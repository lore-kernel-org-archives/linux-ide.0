From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/9] libata-acpi: clean up ata_acpi_exec_tfs()
Date: Tue, 15 May 2007 03:28:16 +0900
Message-ID: <11791672962997-git-send-email-htejun@gmail.com>
References: <11791672953697-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:42865 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757312AbXENS2e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 14:28:34 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1846510wra
        for <linux-ide@vger.kernel.org>; Mon, 14 May 2007 11:28:34 -0700 (PDT)
In-Reply-To: <11791672953697-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch cleans up ata_acpi_exec_tfs() and its friends.

* Rename taskfile_array to ata_acpi_gtf and make it __packed as it's
  used as argument to ACPI method, and use pointer to ata_acpi_gtf and
  number of taskfiles to represent _GTF taskfiles instead of a pointer
  casted into unsigned long and byte count.  This makes argument
  re-checking in do_drive_set_taskfiles() unnecessary.

* Pointer in void * not in unsigned long.

* Clean up do_drive_get_GTF() error handling and make
  do_drive_get_GTF() return number of taskfiles on success, 0 if _GTF
  doesn't exist or doesn't contain valid ata.  -errno on other errors.

* Remove superflous check for acpi->buffer.pointer.

* Update taskfile_load_raw() such that printed messages look similar
  to the messages printed by ata_eh_report().

* s/do_drive_get_GTF/ata_dev_get_GTF/
  s/do_drive_set_taskfiles/ata_dev_set_taskfiles/

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |  226 ++++++++++++++++++++++-----------------------
 1 files changed, 111 insertions(+), 115 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index eda4263..4d36d25 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -28,9 +28,9 @@
 #define SATA_ADR(root,pmp)	(((root) << 16) | (pmp))
 
 #define REGS_PER_GTF		7
-struct taskfile_array {
-	u8	tfa[REGS_PER_GTF];	/* regs. 0x1f1 - 0x1f7 */
-};
+struct ata_acpi_gtf {
+	u8	tf[REGS_PER_GTF];	/* regs. 0x1f1 - 0x1f7 */
+} __packed;
 
 /*
  *	Helper - belongs in the PCI layer somewhere eventually
@@ -101,10 +101,10 @@ void ata_acpi_associate(struct ata_host *host)
 }
 
 /**
- * do_drive_get_GTF - get the drive bootup default taskfile settings
+ * ata_dev_get_GTF - get the drive bootup default taskfile settings
  * @dev: target ATA device
- * @gtf_length: number of bytes of _GTF data returned at @gtf_address
- * @gtf_address: buffer containing _GTF taskfile arrays
+ * @gtf: output parameter for buffer containing _GTF taskfile arrays
+ * @ptr_to_free: pointer which should be freed
  *
  * This applies to both PATA and SATA drives.
  *
@@ -114,24 +114,28 @@ void ata_acpi_associate(struct ata_host *host)
  * The <variable number> is not known in advance, so have ACPI-CA
  * allocate the buffer as needed and return it, then free it later.
  *
- * The returned @gtf_length and @gtf_address are only valid if the
- * function return value is 0.
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * Number of taskfiles on success, 0 if _GTF doesn't exist or doesn't
+ * contain valid data.  -errno on other errors.
  */
-static int do_drive_get_GTF(struct ata_device *dev, unsigned int *gtf_length,
-			    unsigned long *gtf_address, unsigned long *obj_loc)
+static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
+			   void **ptr_to_free)
 {
 	struct ata_port *ap = dev->ap;
 	acpi_status status;
 	struct acpi_buffer output;
 	union acpi_object *out_obj;
-	int err = -ENODEV;
+	int rc = 0;
 
-	*gtf_length = 0;
-	*gtf_address = 0UL;
-	*obj_loc = 0UL;
+	/* set up output buffer */
+	output.length = ACPI_ALLOCATE_BUFFER;
+	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
 
 	if (!dev->acpi_handle)
-		return 0;
+		goto out_free;
 
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
@@ -143,23 +147,20 @@ static int do_drive_get_GTF(struct ata_device *dev, unsigned int *gtf_length,
 				"ata_dev_present: %d, PORT_DISABLED: %lu\n",
 				__FUNCTION__, ata_dev_enabled(dev),
 				ap->flags & ATA_FLAG_DISABLED);
-		goto out;
+		goto out_free;
 	}
 
-	/* Setting up output buffer */
-	output.length = ACPI_ALLOCATE_BUFFER;
-	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
-
 	/* _GTF has no input parameters */
-	err = -EIO;
-	status = acpi_evaluate_object(dev->acpi_handle, "_GTF",
-				      NULL, &output);
+	status = acpi_evaluate_object(dev->acpi_handle, "_GTF", NULL, &output);
+
 	if (ACPI_FAILURE(status)) {
-		if (ata_msg_probe(ap))
-			ata_dev_printk(dev, KERN_DEBUG,
-				"%s: Run _GTF error: status = 0x%x\n",
-				__FUNCTION__, status);
-		goto out;
+		if (status != AE_NOT_FOUND) {
+			ata_dev_printk(dev, KERN_WARNING,
+				       "_GTF evaluation failed (AE 0x%x)\n",
+				       status);
+			rc = -EIO;
+		}
+		goto out_free;
 	}
 
 	if (!output.length || !output.pointer) {
@@ -169,43 +170,43 @@ static int do_drive_get_GTF(struct ata_device *dev, unsigned int *gtf_length,
 				__FUNCTION__,
 				(unsigned long long)output.length,
 				output.pointer);
-		kfree(output.pointer);
-		goto out;
+		goto out_free;
 	}
 
 	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
-		kfree(output.pointer);
 		if (ata_msg_probe(ap))
 			ata_dev_printk(dev, KERN_DEBUG, "%s: Run _GTF: "
 				"error: expected object type of "
 				" ACPI_TYPE_BUFFER, got 0x%x\n",
 				__FUNCTION__, out_obj->type);
-		err = -ENOENT;
-		goto out;
+		rc = -EINVAL;
+		goto out_free;
 	}
 
-	if (!out_obj->buffer.length || !out_obj->buffer.pointer ||
-	    out_obj->buffer.length % REGS_PER_GTF) {
+	if (out_obj->buffer.length % REGS_PER_GTF) {
 		if (ata_msg_drv(ap))
 			ata_dev_printk(dev, KERN_ERR,
 				"%s: unexpected GTF length (%d) or addr (0x%p)\n",
 				__FUNCTION__, out_obj->buffer.length,
 				out_obj->buffer.pointer);
-		err = -ENOENT;
-		goto out;
+		rc = -EINVAL;
+		goto out_free;
 	}
 
-	*gtf_length = out_obj->buffer.length;
-	*gtf_address = (unsigned long)out_obj->buffer.pointer;
-	*obj_loc = (unsigned long)out_obj;
+	*ptr_to_free = out_obj;
+	*gtf = (void *)out_obj->buffer.pointer;
+	rc = out_obj->buffer.length / REGS_PER_GTF;
+
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: returning "
-			"gtf_length=%d, gtf_address=0x%lx, obj_loc=0x%lx\n",
-			__FUNCTION__, *gtf_length, *gtf_address, *obj_loc);
-	err = 0;
-out:
-	return err;
+			"gtf=%p, gtf_count=%d, ptr_to_free=%p\n",
+			__FUNCTION__, *gtf, rc, *ptr_to_free);
+	return rc;
+
+ out_free:
+	kfree(output.pointer);
+	return rc;
 }
 
 /**
@@ -224,68 +225,78 @@ out:
  * function also waits for idle after writing control and before
  * writing the remaining registers.
  *
- * LOCKING: TBD:
- * Inherited from caller.
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
  */
-static void taskfile_load_raw(struct ata_device *dev,
-			      const struct taskfile_array *gtf)
+static int taskfile_load_raw(struct ata_device *dev,
+			      const struct ata_acpi_gtf *gtf)
 {
 	struct ata_port *ap = dev->ap;
-	struct ata_taskfile tf;
-	unsigned int err;
+	struct ata_taskfile tf, rtf;
+	unsigned int err_mask;
 
-	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: (0x1f1-1f7): hex: "
-			"%02x %02x %02x %02x %02x %02x %02x\n",
-			__FUNCTION__,
-			gtf->tfa[0], gtf->tfa[1], gtf->tfa[2],
-			gtf->tfa[3], gtf->tfa[4], gtf->tfa[5], gtf->tfa[6]);
-
-	if ((gtf->tfa[0] == 0) && (gtf->tfa[1] == 0) && (gtf->tfa[2] == 0)
-	    && (gtf->tfa[3] == 0) && (gtf->tfa[4] == 0) && (gtf->tfa[5] == 0)
-	    && (gtf->tfa[6] == 0))
-		return;
+	if ((gtf->tf[0] == 0) && (gtf->tf[1] == 0) && (gtf->tf[2] == 0)
+	    && (gtf->tf[3] == 0) && (gtf->tf[4] == 0) && (gtf->tf[5] == 0)
+	    && (gtf->tf[6] == 0))
+		return 0;
 
 	ata_tf_init(dev, &tf);
 
 	/* convert gtf to tf */
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE; /* TBD */
 	tf.protocol = ATA_PROT_NODATA;
-	tf.feature = gtf->tfa[0];	/* 0x1f1 */
-	tf.nsect   = gtf->tfa[1];	/* 0x1f2 */
-	tf.lbal    = gtf->tfa[2];	/* 0x1f3 */
-	tf.lbam    = gtf->tfa[3];	/* 0x1f4 */
-	tf.lbah    = gtf->tfa[4];	/* 0x1f5 */
-	tf.device  = gtf->tfa[5];	/* 0x1f6 */
-	tf.command = gtf->tfa[6];	/* 0x1f7 */
-
-	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
-	if (err && ata_msg_probe(ap))
+	tf.feature = gtf->tf[0];	/* 0x1f1 */
+	tf.nsect   = gtf->tf[1];	/* 0x1f2 */
+	tf.lbal    = gtf->tf[2];	/* 0x1f3 */
+	tf.lbam    = gtf->tf[3];	/* 0x1f4 */
+	tf.lbah    = gtf->tf[4];	/* 0x1f5 */
+	tf.device  = gtf->tf[5];	/* 0x1f6 */
+	tf.command = gtf->tf[6];	/* 0x1f7 */
+
+	if (ata_msg_probe(ap))
+		ata_dev_printk(dev, KERN_DEBUG, "executing ACPI cmd "
+			       "%02x/%02x:%02x:%02x:%02x:%02x:%02x\n",
+			       tf.command, tf.feature, tf.nsect,
+			       tf.lbal, tf.lbam, tf.lbah, tf.device);
+
+	rtf = tf;
+	err_mask = ata_exec_internal(dev, &rtf, NULL, DMA_NONE, NULL, 0);
+	if (err_mask) {
 		ata_dev_printk(dev, KERN_ERR,
-			"%s: ata_exec_internal failed: %u\n",
-			__FUNCTION__, err);
+			"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x failed "
+			"(Emask=0x%x Stat=0x%02x Err=0x%02x)\n",
+			tf.command, tf.feature, tf.nsect, tf.lbal, tf.lbam,
+			tf.lbah, tf.device, err_mask, rtf.command, rtf.feature);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 /**
- * do_drive_set_taskfiles - write the drive taskfile settings from _GTF
+ * ata_dev_set_taskfiles - write the drive taskfile settings from _GTF
  * @dev: target ATA device
- * @gtf_length: total number of bytes of _GTF taskfiles
- * @gtf_address: location of _GTF taskfile arrays
+ * @gtf: pointer to array of _GTF taskfiles to execute
+ * @gtf_count: number of taskfiles
  *
  * This applies to both PATA and SATA drives.
  *
- * Write {gtf_address, length gtf_length} in groups of
- * REGS_PER_GTF bytes.
+ * Execute taskfiles in @gtf.
+ *
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
  */
-static int do_drive_set_taskfiles(struct ata_device *dev,
-				  unsigned int gtf_length,
-				  unsigned long gtf_address)
+static int ata_dev_set_taskfiles(struct ata_device *dev,
+				 struct ata_acpi_gtf *gtf, int gtf_count)
 {
 	struct ata_port *ap = dev->ap;
-	int err = -ENODEV;
-	int gtf_count = gtf_length / REGS_PER_GTF;
 	int ix;
-	struct taskfile_array	*gtf;
 
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
@@ -295,29 +306,13 @@ static int do_drive_set_taskfiles(struct ata_device *dev,
 		return 0;
 
 	if (!ata_dev_enabled(dev) || (ap->flags & ATA_FLAG_DISABLED))
-		goto out;
-	if (!gtf_count)		/* shouldn't be here */
-		goto out;
-
-	if (gtf_length % REGS_PER_GTF) {
-		if (ata_msg_drv(ap))
-			ata_dev_printk(dev, KERN_ERR,
-				"%s: unexpected GTF length (%d)\n",
-				__FUNCTION__, gtf_length);
-		goto out;
-	}
+		return -ENODEV;
 
-	for (ix = 0; ix < gtf_count; ix++) {
-		gtf = (struct taskfile_array *)
-			(gtf_address + ix * REGS_PER_GTF);
+	/* send all TaskFile registers (0x1f1-0x1f7) *in*that*order* */
+	for (ix = 0; ix < gtf_count; ix++)
+		 taskfile_load_raw(dev, gtf++);
 
-		/* send all TaskFile registers (0x1f1-0x1f7) *in*that*order* */
-		taskfile_load_raw(dev, gtf);
-	}
-
-	err = 0;
-out:
-	return err;
+	return 0;
 }
 
 /**
@@ -328,11 +323,7 @@ out:
  */
 int ata_acpi_exec_tfs(struct ata_port *ap)
 {
-	int ix;
-	int ret = 0;
-	unsigned int gtf_length;
-	unsigned long gtf_address;
-	unsigned long obj_loc;
+	int ix, ret = 0;
 
 	/*
 	 * TBD - implement PATA support.  For now,
@@ -344,12 +335,16 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
 
 	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
 		struct ata_device *dev = &ap->device[ix];
+		struct ata_acpi_gtf *gtf = NULL;
+		int gtf_count;
+		void *ptr_to_free = NULL;
 
 		if (!ata_dev_enabled(dev))
 			continue;
 
-		ret = do_drive_get_GTF(dev, &gtf_length, &gtf_address,
-				       &obj_loc);
+		ret = ata_dev_get_GTF(dev, &gtf, &ptr_to_free);
+		if (ret == 0)
+			continue;
 		if (ret < 0) {
 			if (ata_msg_probe(ap))
 				ata_port_printk(ap, KERN_DEBUG,
@@ -357,9 +352,10 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
 					__FUNCTION__, ret);
 			break;
 		}
+		gtf_count = ret;
 
-		ret = do_drive_set_taskfiles(dev, gtf_length, gtf_address);
-		kfree((void *)obj_loc);
+		ret = ata_dev_set_taskfiles(dev, gtf, gtf_count);
+		kfree(ptr_to_free);
 		if (ret < 0) {
 			if (ata_msg_probe(ap))
 				ata_port_printk(ap, KERN_DEBUG,
-- 
1.5.0.3


