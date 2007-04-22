From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/13] libata-acpi: clean up parameters and misc stuff
Date: Mon, 23 Apr 2007 02:41:06 +0900
Message-ID: <11772636663949-git-send-email-htejun@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:49324 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbXDVRlU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:41:20 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1532725wxd
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 10:41:20 -0700 (PDT)
In-Reply-To: <11772636651400-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch cleans up libata-acpi such that it looks similar to other
libata files.  This patch doesn't introuce any behavior changes.

* make libata-acpi functions take ata_device instead of ata_port +
  device index
* s/atadev/adev/
* de-indent local variable declarations

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |  184 ++++++++++++++++++++++-----------------------
 drivers/ata/libata-core.c |    2 +-
 drivers/ata/libata.h      |    4 +-
 3 files changed, 94 insertions(+), 96 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index cb3eab6..f005730 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -270,8 +270,7 @@ out:
 
 /**
  * do_drive_get_GTF - get the drive bootup default taskfile settings
- * @ap: the ata_port for the drive
- * @ix: target ata_device (drive) index
+ * @adev: target ATA device
  * @gtf_length: number of bytes of _GTF data returned at @gtf_address
  * @gtf_address: buffer containing _GTF taskfile arrays
  *
@@ -286,20 +285,19 @@ out:
  * The returned @gtf_length and @gtf_address are only valid if the
  * function return value is 0.
  */
-static int do_drive_get_GTF(struct ata_port *ap, int ix,
-			unsigned int *gtf_length, unsigned long *gtf_address,
-			unsigned long *obj_loc)
+static int do_drive_get_GTF(struct ata_device *adev, unsigned int *gtf_length,
+			    unsigned long *gtf_address, unsigned long *obj_loc)
 {
-	acpi_status			status;
-	acpi_handle			dev_handle = NULL;
-	acpi_handle			chan_handle, drive_handle;
-	acpi_integer			pcidevfn = 0;
-	u32				dev_adr;
-	struct acpi_buffer		output;
-	union acpi_object 		*out_obj;
-	struct device			*dev = ap->host->dev;
-	struct ata_device		*atadev = &ap->device[ix];
-	int				err = -ENODEV;
+	struct ata_port *ap = adev->ap;
+	acpi_status status;
+	acpi_handle dev_handle = NULL;
+	acpi_handle chan_handle, drive_handle;
+	acpi_integer pcidevfn = 0;
+	u32 dev_adr;
+	struct acpi_buffer output;
+	union acpi_object *out_obj;
+	struct device *dev = ap->host->dev;
+	int err = -ENODEV;
 
 	*gtf_length = 0;
 	*gtf_address = 0UL;
@@ -309,14 +307,14 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 		return 0;
 
 	if (ata_msg_probe(ap))
-		ata_dev_printk(atadev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
+		ata_dev_printk(adev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
 			       __FUNCTION__, ap->port_no);
 
-	if (!ata_dev_enabled(atadev) || (ap->flags & ATA_FLAG_DISABLED)) {
+	if (!ata_dev_enabled(adev) || (ap->flags & ATA_FLAG_DISABLED)) {
 		if (ata_msg_probe(ap))
-			ata_dev_printk(atadev, KERN_DEBUG, "%s: ERR: "
+			ata_dev_printk(adev, KERN_DEBUG, "%s: ERR: "
 				"ata_dev_present: %d, PORT_DISABLED: %lu\n",
-				__FUNCTION__, ata_dev_enabled(atadev),
+				__FUNCTION__, ata_dev_enabled(adev),
 				ap->flags & ATA_FLAG_DISABLED);
 		goto out;
 	}
@@ -327,7 +325,7 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 		err = pata_get_dev_handle(dev, &dev_handle, &pcidevfn);
 		if (err < 0) {
 			if (ata_msg_probe(ap))
-				ata_dev_printk(atadev, KERN_DEBUG,
+				ata_dev_printk(adev, KERN_DEBUG,
 					"%s: pata_get_dev_handle failed (%d)\n",
 					__FUNCTION__, err);
 			goto out;
@@ -336,7 +334,7 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 		err = sata_get_dev_handle(dev, &dev_handle, &pcidevfn);
 		if (err < 0) {
 			if (ata_msg_probe(ap))
-				ata_dev_printk(atadev, KERN_DEBUG,
+				ata_dev_printk(adev, KERN_DEBUG,
 					"%s: sata_get_dev_handle failed (%d\n",
 					__FUNCTION__, err);
 			goto out;
@@ -344,7 +342,7 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 	}
 
 	/* Get this drive's _ADR info. if not already known. */
-	if (!atadev->obj_handle) {
+	if (!adev->obj_handle) {
 		if (!(ap->cbl == ATA_CBL_SATA)) {
 			/* get child objects of dev_handle == channel objects,
 	 		 * + _their_ children == drive objects */
@@ -352,7 +350,7 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 			chan_handle = acpi_get_child(dev_handle,
 						ap->port_no);
 			if (ata_msg_probe(ap))
-				ata_dev_printk(atadev, KERN_DEBUG,
+				ata_dev_printk(adev, KERN_DEBUG,
 					"%s: chan adr=%d: chan_handle=0x%p\n",
 					__FUNCTION__, ap->port_no,
 					chan_handle);
@@ -361,26 +359,26 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 				goto out;
 			}
 			/* TBD: could also check ACPI object VALID bits */
-			drive_handle = acpi_get_child(chan_handle, ix);
+			drive_handle = acpi_get_child(chan_handle, adev->devno);
 			if (!drive_handle) {
 				err = -ENODEV;
 				goto out;
 			}
-			dev_adr = ix;
-			atadev->obj_handle = drive_handle;
+			dev_adr = adev->devno;
+			adev->obj_handle = drive_handle;
 		} else {	/* for SATA mode */
 			dev_adr = SATA_ADR_RSVD;
 			err = get_sata_adr(dev, dev_handle, pcidevfn, 0,
-					ap, atadev, &dev_adr);
+					ap, adev, &dev_adr);
 		}
 		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
-		    !atadev->obj_handle) {
+		    !adev->obj_handle) {
 			if (ata_msg_probe(ap))
-				ata_dev_printk(atadev, KERN_DEBUG,
+				ata_dev_printk(adev, KERN_DEBUG,
 					"%s: get_sata/pata_adr failed: "
 					"err=%d, dev_adr=%u, obj_handle=0x%p\n",
 					__FUNCTION__, err, dev_adr,
-					atadev->obj_handle);
+					adev->obj_handle);
 			goto out;
 		}
 	}
@@ -391,11 +389,11 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 
 	/* _GTF has no input parameters */
 	err = -EIO;
-	status = acpi_evaluate_object(atadev->obj_handle, "_GTF",
+	status = acpi_evaluate_object(adev->obj_handle, "_GTF",
 					NULL, &output);
 	if (ACPI_FAILURE(status)) {
 		if (ata_msg_probe(ap))
-			ata_dev_printk(atadev, KERN_DEBUG,
+			ata_dev_printk(adev, KERN_DEBUG,
 				"%s: Run _GTF error: status = 0x%x\n",
 				__FUNCTION__, status);
 		goto out;
@@ -403,7 +401,7 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 
 	if (!output.length || !output.pointer) {
 		if (ata_msg_probe(ap))
-			ata_dev_printk(atadev, KERN_DEBUG, "%s: Run _GTF: "
+			ata_dev_printk(adev, KERN_DEBUG, "%s: Run _GTF: "
 				"length or ptr is NULL (0x%llx, 0x%p)\n",
 				__FUNCTION__,
 				(unsigned long long)output.length,
@@ -416,7 +414,7 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
 		kfree(output.pointer);
 		if (ata_msg_probe(ap))
-			ata_dev_printk(atadev, KERN_DEBUG, "%s: Run _GTF: "
+			ata_dev_printk(adev, KERN_DEBUG, "%s: Run _GTF: "
 				"error: expected object type of "
 				" ACPI_TYPE_BUFFER, got 0x%x\n",
 				__FUNCTION__, out_obj->type);
@@ -427,7 +425,7 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 	if (!out_obj->buffer.length || !out_obj->buffer.pointer ||
 	    out_obj->buffer.length % REGS_PER_GTF) {
 		if (ata_msg_drv(ap))
-			ata_dev_printk(atadev, KERN_ERR,
+			ata_dev_printk(adev, KERN_ERR,
 				"%s: unexpected GTF length (%d) or addr (0x%p)\n",
 				__FUNCTION__, out_obj->buffer.length,
 				out_obj->buffer.pointer);
@@ -439,7 +437,7 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 	*gtf_address = (unsigned long)out_obj->buffer.pointer;
 	*obj_loc = (unsigned long)out_obj;
 	if (ata_msg_probe(ap))
-		ata_dev_printk(atadev, KERN_DEBUG, "%s: returning "
+		ata_dev_printk(adev, KERN_DEBUG, "%s: returning "
 			"gtf_length=%d, gtf_address=0x%lx, obj_loc=0x%lx\n",
 			__FUNCTION__, *gtf_length, *gtf_address, *obj_loc);
 	err = 0;
@@ -449,7 +447,7 @@ out:
 
 /**
  * taskfile_load_raw - send taskfile registers to host controller
- * @ap: Port to which output is sent
+ * @adev: target ATA device
  * @gtf: raw ATA taskfile register set (0x1f1 - 0x1f7)
  *
  * Outputs ATA taskfile to standard ATA host controller using MMIO
@@ -466,15 +464,15 @@ out:
  * LOCKING: TBD:
  * Inherited from caller.
  */
-static void taskfile_load_raw(struct ata_port *ap,
-				struct ata_device *atadev,
-				const struct taskfile_array *gtf)
+static void taskfile_load_raw(struct ata_device *adev,
+			      const struct taskfile_array *gtf)
 {
+	struct ata_port *ap = adev->ap;
 	struct ata_taskfile tf;
 	unsigned int err;
 
 	if (ata_msg_probe(ap))
-		ata_dev_printk(atadev, KERN_DEBUG, "%s: (0x1f1-1f7): hex: "
+		ata_dev_printk(adev, KERN_DEBUG, "%s: (0x1f1-1f7): hex: "
 			"%02x %02x %02x %02x %02x %02x %02x\n",
 			__FUNCTION__,
 			gtf->tfa[0], gtf->tfa[1], gtf->tfa[2],
@@ -485,7 +483,7 @@ static void taskfile_load_raw(struct ata_port *ap,
 	    && (gtf->tfa[6] == 0))
 		return;
 
-	ata_tf_init(atadev, &tf);
+	ata_tf_init(adev, &tf);
 
 	/* convert gtf to tf */
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE; /* TBD */
@@ -498,17 +496,16 @@ static void taskfile_load_raw(struct ata_port *ap,
 	tf.device  = gtf->tfa[5];	/* 0x1f6 */
 	tf.command = gtf->tfa[6];	/* 0x1f7 */
 
-	err = ata_exec_internal(atadev, &tf, NULL, DMA_NONE, NULL, 0);
+	err = ata_exec_internal(adev, &tf, NULL, DMA_NONE, NULL, 0);
 	if (err && ata_msg_probe(ap))
-		ata_dev_printk(atadev, KERN_ERR,
+		ata_dev_printk(adev, KERN_ERR,
 			"%s: ata_exec_internal failed: %u\n",
 			__FUNCTION__, err);
 }
 
 /**
  * do_drive_set_taskfiles - write the drive taskfile settings from _GTF
- * @ap: the ata_port for the drive
- * @atadev: target ata_device
+ * @adev: target ATA device
  * @gtf_length: total number of bytes of _GTF taskfiles
  * @gtf_address: location of _GTF taskfile arrays
  *
@@ -517,30 +514,31 @@ static void taskfile_load_raw(struct ata_port *ap,
  * Write {gtf_address, length gtf_length} in groups of
  * REGS_PER_GTF bytes.
  */
-static int do_drive_set_taskfiles(struct ata_port *ap,
-		struct ata_device *atadev, unsigned int gtf_length,
-		unsigned long gtf_address)
+static int do_drive_set_taskfiles(struct ata_device *adev,
+				  unsigned int gtf_length,
+				  unsigned long gtf_address)
 {
-	int			err = -ENODEV;
-	int			gtf_count = gtf_length / REGS_PER_GTF;
-	int			ix;
+	struct ata_port *ap = adev->ap;
+	int err = -ENODEV;
+	int gtf_count = gtf_length / REGS_PER_GTF;
+	int ix;
 	struct taskfile_array	*gtf;
 
 	if (ata_msg_probe(ap))
-		ata_dev_printk(atadev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
+		ata_dev_printk(adev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
 			       __FUNCTION__, ap->port_no);
 
 	if (libata_noacpi || !(ap->cbl == ATA_CBL_SATA))
 		return 0;
 
-	if (!ata_dev_enabled(atadev) || (ap->flags & ATA_FLAG_DISABLED))
+	if (!ata_dev_enabled(adev) || (ap->flags & ATA_FLAG_DISABLED))
 		goto out;
 	if (!gtf_count)		/* shouldn't be here */
 		goto out;
 
 	if (gtf_length % REGS_PER_GTF) {
 		if (ata_msg_drv(ap))
-			ata_dev_printk(atadev, KERN_ERR,
+			ata_dev_printk(adev, KERN_ERR,
 				"%s: unexpected GTF length (%d)\n",
 				__FUNCTION__, gtf_length);
 		goto out;
@@ -551,7 +549,7 @@ static int do_drive_set_taskfiles(struct ata_port *ap,
 			(gtf_address + ix * REGS_PER_GTF);
 
 		/* send all TaskFile registers (0x1f1-0x1f7) *in*that*order* */
-		taskfile_load_raw(ap, atadev, gtf);
+		taskfile_load_raw(adev, gtf);
 	}
 
 	err = 0;
@@ -567,11 +565,11 @@ out:
  */
 int ata_acpi_exec_tfs(struct ata_port *ap)
 {
-	int		ix;
-	int		ret =0;
-	unsigned int	gtf_length;
-	unsigned long	gtf_address;
-	unsigned long	obj_loc;
+	int ix;
+	int ret = 0;
+	unsigned int gtf_length;
+	unsigned long gtf_address;
+	unsigned long obj_loc;
 
 	if (libata_noacpi)
 		return 0;
@@ -584,11 +582,13 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
 		return 0;
 
 	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
-		if (!ata_dev_enabled(&ap->device[ix]))
+		struct ata_device *adev = &ap->device[ix];
+
+		if (!ata_dev_enabled(adev))
 			continue;
 
-		ret = do_drive_get_GTF(ap, ix,
-				&gtf_length, &gtf_address, &obj_loc);
+		ret = do_drive_get_GTF(adev, &gtf_length, &gtf_address,
+				       &obj_loc);
 		if (ret < 0) {
 			if (ata_msg_probe(ap))
 				ata_port_printk(ap, KERN_DEBUG,
@@ -597,8 +597,7 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
 			break;
 		}
 
-		ret = do_drive_set_taskfiles(ap, &ap->device[ix],
-				gtf_length, gtf_address);
+		ret = do_drive_set_taskfiles(adev, gtf_length, gtf_address);
 		kfree((void *)obj_loc);
 		if (ret < 0) {
 			if (ata_msg_probe(ap))
@@ -614,8 +613,7 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
 
 /**
  * ata_acpi_push_id - send Identify data to drive
- * @ap: the ata_port for the drive
- * @ix: drive index
+ * @adev: target ATA device
  *
  * _SDD ACPI object: for SATA mode only
  * Must be after Identify (Packet) Device -- uses its data
@@ -623,29 +621,29 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
  * method and if it fails for whatever reason, we should still
  * just keep going.
  */
-int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
+int ata_acpi_push_id(struct ata_device *adev)
 {
-	acpi_handle                     handle;
-	acpi_integer                    pcidevfn;
-	int                             err;
-	struct device                   *dev = ap->host->dev;
-	struct ata_device               *atadev = &ap->device[ix];
-	u32                             dev_adr;
-	acpi_status                     status;
-	struct acpi_object_list         input;
-	union acpi_object               in_params[1];
+	struct ata_port *ap = adev->ap;
+	acpi_handle handle;
+	acpi_integer pcidevfn;
+	int err;
+	struct device *dev = ap->host->dev;
+	u32 dev_adr;
+	acpi_status status;
+	struct acpi_object_list input;
+	union acpi_object in_params[1];
 
 	if (libata_noacpi)
 		return 0;
 
 	if (ata_msg_probe(ap))
-		ata_dev_printk(atadev, KERN_DEBUG, "%s: ix = %d, port#: %d\n",
-			       __FUNCTION__, ix, ap->port_no);
+		ata_dev_printk(adev, KERN_DEBUG, "%s: ix = %d, port#: %d\n",
+			       __FUNCTION__, adev->devno, ap->port_no);
 
 	/* Don't continue if not a SATA device. */
 	if (!(ap->cbl == ATA_CBL_SATA)) {
 		if (ata_msg_probe(ap))
-			ata_dev_printk(atadev, KERN_DEBUG,
+			ata_dev_printk(adev, KERN_DEBUG,
 				"%s: Not a SATA device\n", __FUNCTION__);
 		goto out;
 	}
@@ -655,25 +653,25 @@ int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
 	err = sata_get_dev_handle(dev, &handle, &pcidevfn);
 	if (err < 0) {
 		if (ata_msg_probe(ap))
-			ata_dev_printk(atadev, KERN_DEBUG,
+			ata_dev_printk(adev, KERN_DEBUG,
 				"%s: sata_get_dev_handle failed (%d\n",
 				__FUNCTION__, err);
 		goto out;
 	}
 
 	/* Get this drive's _ADR info, if not already known */
-	if (!atadev->obj_handle) {
+	if (!adev->obj_handle) {
 		dev_adr = SATA_ADR_RSVD;
-		err = get_sata_adr(dev, handle, pcidevfn, ix, ap, atadev,
+		err = get_sata_adr(dev, handle, pcidevfn, adev->devno, ap, adev,
 					&dev_adr);
 		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
-			!atadev->obj_handle) {
+			!adev->obj_handle) {
 			if (ata_msg_probe(ap))
-				ata_dev_printk(atadev, KERN_DEBUG,
+				ata_dev_printk(adev, KERN_DEBUG,
 					"%s: get_sata_adr failed: "
 					"err=%d, dev_adr=%u, obj_handle=0x%p\n",
 					__FUNCTION__, err, dev_adr,
-					atadev->obj_handle);
+					adev->obj_handle);
 			goto out;
 		}
 	}
@@ -683,19 +681,19 @@ int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
 	input.count = 1;
 	input.pointer = in_params;
 	in_params[0].type = ACPI_TYPE_BUFFER;
-	in_params[0].buffer.length = sizeof(atadev->id[0]) * ATA_ID_WORDS;
-	in_params[0].buffer.pointer = (u8 *)atadev->id;
+	in_params[0].buffer.length = sizeof(adev->id[0]) * ATA_ID_WORDS;
+	in_params[0].buffer.pointer = (u8 *)adev->id;
 	/* Output buffer: _SDD has no output */
 
 	/* It's OK for _SDD to be missing too. */
-	swap_buf_le16(atadev->id, ATA_ID_WORDS);
-	status = acpi_evaluate_object(atadev->obj_handle, "_SDD", &input, NULL);
-	swap_buf_le16(atadev->id, ATA_ID_WORDS);
+	swap_buf_le16(adev->id, ATA_ID_WORDS);
+	status = acpi_evaluate_object(adev->obj_handle, "_SDD", &input, NULL);
+	swap_buf_le16(adev->id, ATA_ID_WORDS);
 
 	err = ACPI_FAILURE(status) ? -EIO : 0;
 	if (err < 0) {
 		if (ata_msg_probe(ap))
-			ata_dev_printk(atadev, KERN_DEBUG,
+			ata_dev_printk(adev, KERN_DEBUG,
 				       "%s _SDD error: status = 0x%x\n",
 				       __FUNCTION__, status);
 	}
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2171af6..d3d0f01 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1812,7 +1812,7 @@ int ata_dev_configure(struct ata_device *dev)
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
 
 	/* set _SDD */
-	rc = ata_acpi_push_id(ap, dev->devno);
+	rc = ata_acpi_push_id(dev);
 	if (rc) {
 		ata_dev_printk(dev, KERN_WARNING, "failed to set _SDD(%d)\n",
 			rc);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 122bc16..6041b91 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -99,13 +99,13 @@ extern struct ata_port *ata_port_alloc(struct ata_host *host);
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern int ata_acpi_exec_tfs(struct ata_port *ap);
-extern int ata_acpi_push_id(struct ata_port *ap, unsigned int ix);
+extern int ata_acpi_push_id(struct ata_device *adev);
 #else
 static inline int ata_acpi_exec_tfs(struct ata_port *ap)
 {
 	return 0;
 }
-static inline int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
+static inline int ata_acpi_push_id(struct ata_device *adev)
 {
 	return 0;
 }
-- 
1.5.0.3


