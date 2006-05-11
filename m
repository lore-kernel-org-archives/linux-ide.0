From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 20/22] libata: use dev->ap
Date: Thu, 11 May 2006 20:59:51 +0900
Message-ID: <11473487912163-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.194]:49320 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751557AbWEKMAJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:09 -0400
Received: by wx-out-0102.google.com with SMTP id t16so118654wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:09 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Use dev->ap where possible and eliminate superflous @ap from functions
and structures.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c        |    2 -
 drivers/scsi/libata-core.c |  160 +++++++++++++++++++++-----------------------
 drivers/scsi/libata-scsi.c |   40 +++++------
 drivers/scsi/libata.h      |   11 +--
 include/linux/libata.h     |   21 ++----
 5 files changed, 106 insertions(+), 128 deletions(-)

350ae14b3a5639351348cb30b2ddd50022d6bdab
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index c2298fb..f6e4c8e 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -597,7 +597,7 @@ static int ahci_softreset(struct ata_por
 	/* restart engine */
 	ahci_start_engine(ap);
 
-	ata_tf_init(ap, &tf, 0);
+	ata_tf_init(ap->device, &tf);
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 38a9833..8eee5af 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -61,13 +61,10 @@
 
 #include "libata.h"
 
-static unsigned int ata_dev_init_params(struct ata_port *ap,
-					struct ata_device *dev,
-					u16 heads,
-					u16 sectors);
-static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
-					 struct ata_device *dev);
-static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev);
+static unsigned int ata_dev_init_params(struct ata_device *dev,
+					u16 heads, u16 sectors);
+static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
+static void ata_dev_xfermask(struct ata_device *dev);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -412,11 +409,11 @@ static const char *sata_spd_string(unsig
 	return spd_str[spd - 1];
 }
 
-void ata_dev_disable(struct ata_port *ap, struct ata_device *dev)
+void ata_dev_disable(struct ata_device *dev)
 {
 	if (ata_dev_enabled(dev)) {
 		printk(KERN_WARNING "ata%u: dev %u disabled\n",
-		       ap->id, dev->devno);
+		       dev->ap->id, dev->devno);
 		dev->class++;
 	}
 }
@@ -960,7 +957,6 @@ void ata_qc_complete_internal(struct ata
 
 /**
  *	ata_exec_internal - execute libata internal command
- *	@ap: Port to which the command is sent
  *	@dev: Device to which the command is sent
  *	@tf: Taskfile registers for the command and the result
  *	@cdb: CDB for packet command
@@ -978,10 +974,11 @@ void ata_qc_complete_internal(struct ata
  *	None.  Should be called with kernel context, might sleep.
  */
 
-unsigned ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
+unsigned ata_exec_internal(struct ata_device *dev,
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen)
 {
+	struct ata_port *ap = dev->ap;
 	u8 command = tf->command;
 	struct ata_queued_cmd *qc;
 	DECLARE_COMPLETION(wait);
@@ -990,7 +987,7 @@ unsigned ata_exec_internal(struct ata_po
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
-	qc = ata_qc_new_init(ap, dev);
+	qc = ata_qc_new_init(dev);
 	BUG_ON(qc == NULL);
 
 	qc->tf = *tf;
@@ -1095,7 +1092,6 @@ unsigned int ata_pio_need_iordy(const st
 
 /**
  *	ata_dev_read_id - Read ID data from the specified device
- *	@ap: port on which target device resides
  *	@dev: target device
  *	@p_class: pointer to class of the target device (may be changed)
  *	@post_reset: is this read ID post-reset?
@@ -1112,9 +1108,10 @@ unsigned int ata_pio_need_iordy(const st
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-static int ata_dev_read_id(struct ata_port *ap, struct ata_device *dev,
-			   unsigned int *p_class, int post_reset, u16 *id)
+static int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
+			   int post_reset, u16 *id)
 {
+	struct ata_port *ap = dev->ap;
 	unsigned int class = *p_class;
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
@@ -1126,7 +1123,7 @@ static int ata_dev_read_id(struct ata_po
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
 
  retry:
-	ata_tf_init(ap, &tf, dev->devno);
+	ata_tf_init(dev, &tf);
 
 	switch (class) {
 	case ATA_DEV_ATA:
@@ -1143,7 +1140,7 @@ static int ata_dev_read_id(struct ata_po
 
 	tf.protocol = ATA_PROT_PIO;
 
-	err_mask = ata_exec_internal(ap, dev, &tf, NULL, DMA_FROM_DEVICE,
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);
 	if (err_mask) {
 		rc = -EIO;
@@ -1170,7 +1167,7 @@ static int ata_dev_read_id(struct ata_po
 		 * Some drives were very specific about that exact sequence.
 		 */
 		if (ata_id_major_version(id) < 4 || !ata_id_has_lba(id)) {
-			err_mask = ata_dev_init_params(ap, dev, id[3], id[6]);
+			err_mask = ata_dev_init_params(dev, id[3], id[6]);
 			if (err_mask) {
 				rc = -EIO;
 				reason = "INIT_DEV_PARAMS failed";
@@ -1195,15 +1192,13 @@ static int ata_dev_read_id(struct ata_po
 	return rc;
 }
 
-static inline u8 ata_dev_knobble(const struct ata_port *ap,
-				 struct ata_device *dev)
+static inline u8 ata_dev_knobble(struct ata_device *dev)
 {
-	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
+	return ((dev->ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
 
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
- *	@ap: Port on which target device resides
  *	@dev: Target device to configure
  *	@print_info: Enable device info printout
  *
@@ -1216,9 +1211,9 @@ static inline u8 ata_dev_knobble(const s
  *	RETURNS:
  *	0 on success, -errno otherwise
  */
-static int ata_dev_configure(struct ata_port *ap, struct ata_device *dev,
-			     int print_info)
+static int ata_dev_configure(struct ata_device *dev, int print_info)
 {
+	struct ata_port *ap = dev->ap;
 	const u16 *id = dev->id;
 	unsigned int xfer_mask;
 	int i, rc;
@@ -1331,7 +1326,7 @@ static int ata_dev_configure(struct ata_
 					      ap->device[i].cdb_len);
 
 	/* limit bridge transfers to udma5, 200 sectors */
-	if (ata_dev_knobble(ap, dev)) {
+	if (ata_dev_knobble(dev)) {
 		if (print_info)
 			printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
 			       ap->id, dev->devno);
@@ -1416,11 +1411,11 @@ static int ata_bus_probe(struct ata_port
 		if (!ata_dev_enabled(dev))
 			continue;
 
-		rc = ata_dev_read_id(ap, dev, &dev->class, 1, dev->id);
+		rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
 		if (rc)
 			goto fail;
 
-		rc = ata_dev_configure(ap, dev, 1);
+		rc = ata_dev_configure(dev, 1);
 		if (rc)
 			goto fail;
 	}
@@ -1453,13 +1448,13 @@ static int ata_bus_probe(struct ata_port
 	default:
 		tries[dev->devno]--;
 		if (down_xfermask &&
-		    ata_down_xfermask_limit(ap, dev, tries[dev->devno] == 1))
+		    ata_down_xfermask_limit(dev, tries[dev->devno] == 1))
 			tries[dev->devno] = 0;
 	}
 
 	if (!tries[dev->devno]) {
-		ata_down_xfermask_limit(ap, dev, 1);
-		ata_dev_disable(ap, dev);
+		ata_down_xfermask_limit(dev, 1);
+		ata_dev_disable(dev);
 	}
 
 	goto retry;
@@ -1586,15 +1581,15 @@ void sata_phy_reset(struct ata_port *ap)
 
 /**
  *	ata_dev_pair		-	return other device on cable
- *	@ap: port
  *	@adev: device
  *
  *	Obtain the other device on the same cable, or if none is
  *	present NULL is returned
  */
 
-struct ata_device *ata_dev_pair(struct ata_port *ap, struct ata_device *adev)
+struct ata_device *ata_dev_pair(struct ata_device *adev)
 {
+	struct ata_port *ap = adev->ap;
 	struct ata_device *pair = &ap->device[1 - adev->devno];
 	if (!ata_dev_enabled(pair))
 		return NULL;
@@ -1885,7 +1880,6 @@ int ata_timing_compute(struct ata_device
 
 /**
  *	ata_down_xfermask_limit - adjust dev xfer masks downward
- *	@ap: Port associated with device @dev
  *	@dev: Device to adjust xfer masks
  *	@force_pio0: Force PIO0
  *
@@ -1899,9 +1893,9 @@ int ata_timing_compute(struct ata_device
  *	RETURNS:
  *	0 on success, negative errno on failure
  */
-int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
-			    int force_pio0)
+int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0)
 {
+	struct ata_port *ap = dev->ap;
 	unsigned long xfer_mask;
 	int highbit;
 
@@ -1933,8 +1927,9 @@ int ata_down_xfermask_limit(struct ata_p
 	return -EINVAL;
 }
 
-static int ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
+static int ata_dev_set_mode(struct ata_device *dev)
 {
+	struct ata_port *ap = dev->ap;
 	unsigned int err_mask;
 	int rc;
 
@@ -1942,7 +1937,7 @@ static int ata_dev_set_mode(struct ata_p
 	if (dev->xfer_shift == ATA_SHIFT_PIO)
 		dev->flags |= ATA_DFLAG_PIO;
 
-	err_mask = ata_dev_set_xfermode(ap, dev);
+	err_mask = ata_dev_set_xfermode(dev);
 	if (err_mask) {
 		printk(KERN_ERR
 		       "ata%u: failed to set xfermode (err_mask=0x%x)\n",
@@ -1950,7 +1945,7 @@ static int ata_dev_set_mode(struct ata_p
 		return -EIO;
 	}
 
-	rc = ata_dev_revalidate(ap, dev, 0);
+	rc = ata_dev_revalidate(dev, 0);
 	if (rc)
 		return rc;
 
@@ -2006,7 +2001,7 @@ int ata_set_mode(struct ata_port *ap, st
 		if (!ata_dev_enabled(dev))
 			continue;
 
-		ata_dev_xfermask(ap, dev);
+		ata_dev_xfermask(dev);
 
 		pio_mask = ata_pack_xfermask(dev->pio_mask, 0, 0);
 		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
@@ -2059,7 +2054,7 @@ int ata_set_mode(struct ata_port *ap, st
 		if (!ata_dev_enabled(dev))
 			continue;
 
-		rc = ata_dev_set_mode(ap, dev);
+		rc = ata_dev_set_mode(dev);
 		if (rc)
 			goto out;
 	}
@@ -2711,7 +2706,6 @@ int ata_drive_probe_reset(struct ata_por
 
 /**
  *	ata_dev_same_device - Determine whether new ID matches configured device
- *	@ap: port on which the device to compare against resides
  *	@dev: device to compare against
  *	@new_class: class of the new device
  *	@new_id: IDENTIFY page of the new device
@@ -2726,9 +2720,10 @@ int ata_drive_probe_reset(struct ata_por
  *	RETURNS:
  *	1 if @dev matches @new_class and @new_id, 0 otherwise.
  */
-static int ata_dev_same_device(struct ata_port *ap, struct ata_device *dev,
-			       unsigned int new_class, const u16 *new_id)
+static int ata_dev_same_device(struct ata_device *dev, unsigned int new_class,
+			       const u16 *new_id)
 {
+	struct ata_port *ap = dev->ap;
 	const u16 *old_id = dev->id;
 	unsigned char model[2][41], serial[2][21];
 	u64 new_n_sectors;
@@ -2773,7 +2768,6 @@ static int ata_dev_same_device(struct at
 
 /**
  *	ata_dev_revalidate - Revalidate ATA device
- *	@ap: port on which the device to revalidate resides
  *	@dev: device to revalidate
  *	@post_reset: is this revalidation after reset?
  *
@@ -2786,9 +2780,9 @@ static int ata_dev_same_device(struct at
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_dev_revalidate(struct ata_port *ap, struct ata_device *dev,
-		       int post_reset)
+int ata_dev_revalidate(struct ata_device *dev, int post_reset)
 {
+	struct ata_port *ap = dev->ap;
 	unsigned int class = dev->class;
 	u16 *id = (void *)ap->sector_buf;
 	int rc;
@@ -2799,12 +2793,12 @@ int ata_dev_revalidate(struct ata_port *
 	}
 
 	/* read ID data */
-	rc = ata_dev_read_id(ap, dev, &class, post_reset, id);
+	rc = ata_dev_read_id(dev, &class, post_reset, id);
 	if (rc)
 		goto fail;
 
 	/* is the device still there? */
-	if (!ata_dev_same_device(ap, dev, class, id)) {
+	if (!ata_dev_same_device(dev, class, id)) {
 		rc = -ENODEV;
 		goto fail;
 	}
@@ -2812,7 +2806,7 @@ int ata_dev_revalidate(struct ata_port *
 	memcpy(dev->id, id, sizeof(id[0]) * ATA_ID_WORDS);
 
 	/* configure device according to the new ID */
-	rc = ata_dev_configure(ap, dev, 0);
+	rc = ata_dev_configure(dev, 0);
 	if (rc == 0)
 		return 0;
 
@@ -2894,7 +2888,6 @@ static int ata_dma_blacklisted(const str
 
 /**
  *	ata_dev_xfermask - Compute supported xfermask of the given device
- *	@ap: Port on which the device to compute xfermask for resides
  *	@dev: Device to compute xfermask for
  *
  *	Compute supported xfermask of @dev and store it in
@@ -2909,8 +2902,9 @@ static int ata_dma_blacklisted(const str
  *	LOCKING:
  *	None.
  */
-static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev)
+static void ata_dev_xfermask(struct ata_device *dev)
 {
+	struct ata_port *ap = dev->ap;
 	struct ata_host_set *hs = ap->host_set;
 	unsigned long xfer_mask;
 	int i;
@@ -2963,7 +2957,6 @@ static void ata_dev_xfermask(struct ata_
 
 /**
  *	ata_dev_set_xfermode - Issue SET FEATURES - XFER MODE command
- *	@ap: Port associated with device @dev
  *	@dev: Device to which command will be sent
  *
  *	Issue SET FEATURES - XFER MODE command to device @dev
@@ -2976,8 +2969,7 @@ static void ata_dev_xfermask(struct ata_
  *	0 on success, AC_ERR_* mask otherwise.
  */
 
-static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
-					 struct ata_device *dev)
+static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
@@ -2985,14 +2977,14 @@ static unsigned int ata_dev_set_xfermode
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
 
-	ata_tf_init(ap, &tf, dev->devno);
+	ata_tf_init(dev, &tf);
 	tf.command = ATA_CMD_SET_FEATURES;
 	tf.feature = SETFEATURES_XFER;
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.protocol = ATA_PROT_NODATA;
 	tf.nsect = dev->xfer_mode;
 
-	err_mask = ata_exec_internal(ap, dev, &tf, NULL, DMA_NONE, NULL, 0);
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
 
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
@@ -3000,8 +2992,9 @@ static unsigned int ata_dev_set_xfermode
 
 /**
  *	ata_dev_init_params - Issue INIT DEV PARAMS command
- *	@ap: Port associated with device @dev
  *	@dev: Device to which command will be sent
+ *	@heads: Number of heads
+ *	@sectors: Number of sectors
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -3009,11 +3002,8 @@ static unsigned int ata_dev_set_xfermode
  *	RETURNS:
  *	0 on success, AC_ERR_* mask otherwise.
  */
-
-static unsigned int ata_dev_init_params(struct ata_port *ap,
-					struct ata_device *dev,
-					u16 heads,
-					u16 sectors)
+static unsigned int ata_dev_init_params(struct ata_device *dev,
+					u16 heads, u16 sectors)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
@@ -3025,14 +3015,14 @@ static unsigned int ata_dev_init_params(
 	/* set up init dev params taskfile */
 	DPRINTK("init dev params \n");
 
-	ata_tf_init(ap, &tf, dev->devno);
+	ata_tf_init(dev, &tf);
 	tf.command = ATA_CMD_INIT_DEV_PARAMS;
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.protocol = ATA_PROT_NODATA;
 	tf.nsect = sectors;
 	tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
 
-	err_mask = ata_exec_internal(ap, dev, &tf, NULL, DMA_NONE, NULL, 0);
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
 
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
@@ -4044,16 +4034,15 @@ static struct ata_queued_cmd *ata_qc_new
 
 /**
  *	ata_qc_new_init - Request an available ATA command, and initialize it
- *	@ap: Port associated with device @dev
  *	@dev: Device from whom we request an available command structure
  *
  *	LOCKING:
  *	None.
  */
 
-struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
-				      struct ata_device *dev)
+struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev)
 {
+	struct ata_port *ap = dev->ap;
 	struct ata_queued_cmd *qc;
 
 	qc = ata_qc_new(ap);
@@ -4519,19 +4508,18 @@ int ata_port_offline(struct ata_port *ap
  * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
  * without filling any other registers
  */
-static int ata_do_simple_cmd(struct ata_port *ap, struct ata_device *dev,
-			     u8 cmd)
+static int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
 {
 	struct ata_taskfile tf;
 	int err;
 
-	ata_tf_init(ap, &tf, dev->devno);
+	ata_tf_init(dev, &tf);
 
 	tf.command = cmd;
 	tf.flags |= ATA_TFLAG_DEVICE;
 	tf.protocol = ATA_PROT_NODATA;
 
-	err = ata_exec_internal(ap, dev, &tf, NULL, DMA_NONE, NULL, 0);
+	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
 	if (err)
 		printk(KERN_ERR "%s: ata command failed: %d\n",
 				__FUNCTION__, err);
@@ -4539,7 +4527,7 @@ static int ata_do_simple_cmd(struct ata_
 	return err;
 }
 
-static int ata_flush_cache(struct ata_port *ap, struct ata_device *dev)
+static int ata_flush_cache(struct ata_device *dev)
 {
 	u8 cmd;
 
@@ -4551,22 +4539,21 @@ static int ata_flush_cache(struct ata_po
 	else
 		cmd = ATA_CMD_FLUSH;
 
-	return ata_do_simple_cmd(ap, dev, cmd);
+	return ata_do_simple_cmd(dev, cmd);
 }
 
-static int ata_standby_drive(struct ata_port *ap, struct ata_device *dev)
+static int ata_standby_drive(struct ata_device *dev)
 {
-	return ata_do_simple_cmd(ap, dev, ATA_CMD_STANDBYNOW1);
+	return ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
 }
 
-static int ata_start_drive(struct ata_port *ap, struct ata_device *dev)
+static int ata_start_drive(struct ata_device *dev)
 {
-	return ata_do_simple_cmd(ap, dev, ATA_CMD_IDLEIMMEDIATE);
+	return ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
 }
 
 /**
  *	ata_device_resume - wakeup a previously suspended devices
- *	@ap: port the device is connected to
  *	@dev: the device to resume
  *
  *	Kick the drive back into action, by sending it an idle immediate
@@ -4574,39 +4561,42 @@ static int ata_start_drive(struct ata_po
  *	and host.
  *
  */
-int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
+int ata_device_resume(struct ata_device *dev)
 {
+	struct ata_port *ap = dev->ap;
+
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
 		struct ata_device *failed_dev;
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		while (ata_set_mode(ap, &failed_dev))
-			ata_dev_disable(ap, failed_dev);
+			ata_dev_disable(failed_dev);
 	}
 	if (!ata_dev_enabled(dev))
 		return 0;
 	if (dev->class == ATA_DEV_ATA)
-		ata_start_drive(ap, dev);
+		ata_start_drive(dev);
 
 	return 0;
 }
 
 /**
  *	ata_device_suspend - prepare a device for suspend
- *	@ap: port the device is connected to
  *	@dev: the device to suspend
  *
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.
  */
-int ata_device_suspend(struct ata_port *ap, struct ata_device *dev, pm_message_t state)
+int ata_device_suspend(struct ata_device *dev, pm_message_t state)
 {
+	struct ata_port *ap = dev->ap;
+
 	if (!ata_dev_enabled(dev))
 		return 0;
 	if (dev->class == ATA_DEV_ATA)
-		ata_flush_cache(ap, dev);
+		ata_flush_cache(dev);
 
 	if (state.event != PM_EVENT_FREEZE)
-		ata_standby_drive(ap, dev);
+		ata_standby_drive(dev);
 	ap->flags |= ATA_FLAG_SUSPENDED;
 	return 0;
 }
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index ce90b63..fcbf64e 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -302,7 +302,6 @@ int ata_scsi_ioctl(struct scsi_device *s
 
 /**
  *	ata_scsi_qc_new - acquire new ata_queued_cmd reference
- *	@ap: ATA port to which the new command is attached
  *	@dev: ATA device to which the new command is attached
  *	@cmd: SCSI command that originated this ATA command
  *	@done: SCSI command completion function
@@ -321,14 +320,13 @@ int ata_scsi_ioctl(struct scsi_device *s
  *	RETURNS:
  *	Command allocated, or %NULL if none available.
  */
-struct ata_queued_cmd *ata_scsi_qc_new(struct ata_port *ap,
-				       struct ata_device *dev,
+struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
 				       struct scsi_cmnd *cmd,
 				       void (*done)(struct scsi_cmnd *))
 {
 	struct ata_queued_cmd *qc;
 
-	qc = ata_qc_new_init(ap, dev);
+	qc = ata_qc_new_init(dev);
 	if (qc) {
 		qc->scsicmd = cmd;
 		qc->scsidone = done;
@@ -398,7 +396,7 @@ int ata_scsi_device_resume(struct scsi_d
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev = &ap->device[sdev->id];
 
-	return ata_device_resume(ap, dev);
+	return ata_device_resume(dev);
 }
 
 int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
@@ -406,7 +404,7 @@ int ata_scsi_device_suspend(struct scsi_
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev = &ap->device[sdev->id];
 
-	return ata_device_suspend(ap, dev, state);
+	return ata_device_suspend(dev, state);
 }
 
 /**
@@ -1224,7 +1222,6 @@ static void ata_scsi_qc_complete(struct 
 
 /**
  *	ata_scsi_translate - Translate then issue SCSI command to ATA device
- *	@ap: ATA port to which the command is addressed
  *	@dev: ATA device to which the command is addressed
  *	@cmd: SCSI command to execute
  *	@done: SCSI command completion function
@@ -1247,17 +1244,16 @@ static void ata_scsi_qc_complete(struct 
  *	spin_lock_irqsave(host_set lock)
  */
 
-static void ata_scsi_translate(struct ata_port *ap, struct ata_device *dev,
-			      struct scsi_cmnd *cmd,
-			      void (*done)(struct scsi_cmnd *),
-			      ata_xlat_func_t xlat_func)
+static void ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
+			       void (*done)(struct scsi_cmnd *),
+			       ata_xlat_func_t xlat_func)
 {
 	struct ata_queued_cmd *qc;
 	u8 *scsicmd = cmd->cmnd;
 
 	VPRINTK("ENTER\n");
 
-	qc = ata_scsi_qc_new(ap, dev, cmd, done);
+	qc = ata_scsi_qc_new(dev, cmd, done);
 	if (!qc)
 		goto err_mem;
 
@@ -1266,7 +1262,7 @@ static void ata_scsi_translate(struct at
 	    cmd->sc_data_direction == DMA_TO_DEVICE) {
 		if (unlikely(cmd->request_bufflen < 1)) {
 			printk(KERN_WARNING "ata%u(%u): WARNING: zero len r/w req\n",
-			       ap->id, dev->devno);
+			       dev->ap->id, dev->devno);
 			goto err_did;
 		}
 
@@ -2433,19 +2429,20 @@ static inline void ata_scsi_dump_cdb(str
 #endif
 }
 
-static inline void __ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
-				       struct ata_port *ap, struct ata_device *dev)
+static inline void __ata_scsi_queuecmd(struct scsi_cmnd *cmd,
+				       void (*done)(struct scsi_cmnd *),
+				       struct ata_device *dev)
 {
 	if (dev->class == ATA_DEV_ATA) {
 		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
 							      cmd->cmnd[0]);
 
 		if (xlat_func)
-			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
+			ata_scsi_translate(dev, cmd, done, xlat_func);
 		else
-			ata_scsi_simulate(ap, dev, cmd, done);
+			ata_scsi_simulate(dev, cmd, done);
 	} else
-		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
+		ata_scsi_translate(dev, cmd, done, atapi_xlat);
 }
 
 /**
@@ -2483,7 +2480,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 
 	dev = ata_scsi_find_dev(ap, scsidev);
 	if (likely(dev))
-		__ata_scsi_queuecmd(cmd, done, ap, dev);
+		__ata_scsi_queuecmd(cmd, done, dev);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
@@ -2496,7 +2493,6 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
- *	@ap: port the device is connected to
  *	@dev: the target device
  *	@cmd: SCSI command being sent to device.
  *	@done: SCSI command completion function.
@@ -2508,14 +2504,12 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
-		      struct scsi_cmnd *cmd,
+void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd,
 		      void (*done)(struct scsi_cmnd *))
 {
 	struct ata_scsi_args args;
 	const u8 *scsicmd = cmd->cmnd;
 
-	args.ap = ap;
 	args.dev = dev;
 	args.id = dev->id;
 	args.cmd = cmd;
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 43a56e5..a810c91 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -32,7 +32,6 @@
 #define DRV_VERSION	"1.30"	/* must be exactly four chars */
 
 struct ata_scsi_args {
-	struct ata_port		*ap;
 	struct ata_device	*dev;
 	u16			*id;
 	struct scsi_cmnd	*cmd;
@@ -43,18 +42,16 @@ struct ata_scsi_args {
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
-extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
-				      struct ata_device *dev);
+extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
-extern void ata_dev_disable(struct ata_port *ap, struct ata_device *dev);
+extern void ata_dev_disable(struct ata_device *dev);
 extern void ata_port_flush_task(struct ata_port *ap);
-extern unsigned ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
+extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen);
 extern int ata_down_sata_spd_limit(struct ata_port *ap);
 extern int ata_set_sata_spd_needed(struct ata_port *ap);
-extern int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
-				   int force_pio0);
+extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
 extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
 extern int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
 			unsigned int *classes);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8d7fbb3..bd8cd3b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -518,8 +518,7 @@ extern void ata_std_probeinit(struct ata
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
-extern int ata_dev_revalidate(struct ata_port *ap, struct ata_device *dev,
-			      int post_reset);
+extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
@@ -545,8 +544,8 @@ extern int ata_port_online(struct ata_po
 extern int ata_port_offline(struct ata_port *ap);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t state);
-extern int ata_device_resume(struct ata_port *, struct ata_device *);
-extern int ata_device_suspend(struct ata_port *, struct ata_device *, pm_message_t state);
+extern int ata_device_resume(struct ata_device *);
+extern int ata_device_suspend(struct ata_device *, pm_message_t state);
 extern int ata_ratelimit(void);
 extern unsigned int ata_busy_sleep(struct ata_port *ap,
 				   unsigned long timeout_pat,
@@ -592,15 +591,13 @@ extern void ata_bmdma_stop(struct ata_qu
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
-extern void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
-			      struct scsi_cmnd *cmd,
+extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
 extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
-extern struct ata_device *ata_dev_pair(struct ata_port *ap, 
-				       struct ata_device *adev);
+extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 
 /*
  * Timing helpers
@@ -812,12 +809,12 @@ static inline struct ata_queued_cmd *ata
 	return NULL;
 }
 
-static inline void ata_tf_init(struct ata_port *ap, struct ata_taskfile *tf, unsigned int device)
+static inline void ata_tf_init(struct ata_device *dev, struct ata_taskfile *tf)
 {
 	memset(tf, 0, sizeof(*tf));
 
-	tf->ctl = ap->ctl;
-	if (device == 0)
+	tf->ctl = dev->ap->ctl;
+	if (dev->devno == 0)
 		tf->device = ATA_DEVICE_OBS;
 	else
 		tf->device = ATA_DEVICE_OBS | ATA_DEV1;
@@ -832,7 +829,7 @@ static inline void ata_qc_reinit(struct 
 	qc->nbytes = qc->curbytes = 0;
 	qc->err_mask = 0;
 
-	ata_tf_init(qc->ap, &qc->tf, qc->dev->devno);
+	ata_tf_init(qc->dev, &qc->tf);
 
 	/* init result_tf such that it indicates normal completion */
 	qc->result_tf.command = ATA_DRDY;
-- 
1.2.4


