From: akpm@osdl.org
Subject: [patch 04/12] libata: convert @post_reset to @flags in ata_dev_read_id()
Date: Fri, 20 Oct 2006 14:39:37 -0700
Message-ID: <200610202139.k9KLdbRi003571@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:32899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422831AbWJTVkW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Oct 2006 17:40:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, htejun@gmail.com

From: Tejun Heo <htejun@gmail.com>

Make ata_dev_read_id() take @flags instead of @post_reset.  Currently
there is only one flag defined - ATA_READID_POSTRESET, which is
equivalent to @post_reset.  This is preparation for polling presence
detection.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ata/libata-core.c |   17 +++++++++--------
 drivers/ata/libata-eh.c   |   11 +++++++----
 drivers/ata/libata.h      |    9 +++++++--
 3 files changed, 23 insertions(+), 14 deletions(-)

diff -puN drivers/ata/libata-core.c~libata-convert-post_reset-to-flags-in-ata_dev_read_id drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-convert-post_reset-to-flags-in-ata_dev_read_id
+++ a/drivers/ata/libata-core.c
@@ -1228,7 +1228,7 @@ unsigned int ata_pio_need_iordy(const st
  *	ata_dev_read_id - Read ID data from the specified device
  *	@dev: target device
  *	@p_class: pointer to class of the target device (may be changed)
- *	@post_reset: is this read ID post-reset?
+ *	@flags: ATA_READID_* flags
  *	@id: buffer to read IDENTIFY data into
  *
  *	Read ID data from the specified device.  ATA_CMD_ID_ATA is
@@ -1243,7 +1243,7 @@ unsigned int ata_pio_need_iordy(const st
  *	0 on success, -errno otherwise.
  */
 int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
-		    int post_reset, u16 *id)
+		    unsigned int flags, u16 *id)
 {
 	struct ata_port *ap = dev->ap;
 	unsigned int class = *p_class;
@@ -1298,7 +1298,7 @@ int ata_dev_read_id(struct ata_device *d
 			goto err_out;
 	}
 
-	if (post_reset && class == ATA_DEV_ATA) {
+	if ((flags & ATA_READID_POSTRESET) && class == ATA_DEV_ATA) {
 		/*
 		 * The exact sequence expected by certain pre-ATA4 drives is:
 		 * SRST RESET
@@ -1318,7 +1318,7 @@ int ata_dev_read_id(struct ata_device *d
 			/* current CHS translation info (id[53-58]) might be
 			 * changed. reread the identify device info.
 			 */
-			post_reset = 0;
+			flags &= ~ATA_READID_POSTRESET;
 			goto retry;
 		}
 	}
@@ -1646,7 +1646,8 @@ int ata_bus_probe(struct ata_port *ap)
 		if (!ata_dev_enabled(dev))
 			continue;
 
-		rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
+		rc = ata_dev_read_id(dev, &dev->class, ATA_READID_POSTRESET,
+				     dev->id);
 		if (rc)
 			goto fail;
 
@@ -2984,7 +2985,7 @@ static int ata_dev_same_device(struct at
 /**
  *	ata_dev_revalidate - Revalidate ATA device
  *	@dev: device to revalidate
- *	@post_reset: is this revalidation after reset?
+ *	@readid_flags: read ID flags
  *
  *	Re-read IDENTIFY page and make sure @dev is still attached to
  *	the port.
@@ -2995,7 +2996,7 @@ static int ata_dev_same_device(struct at
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_dev_revalidate(struct ata_device *dev, int post_reset)
+int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags)
 {
 	unsigned int class = dev->class;
 	u16 *id = (void *)dev->ap->sector_buf;
@@ -3007,7 +3008,7 @@ int ata_dev_revalidate(struct ata_device
 	}
 
 	/* read ID data */
-	rc = ata_dev_read_id(dev, &class, post_reset, id);
+	rc = ata_dev_read_id(dev, &class, readid_flags, id);
 	if (rc)
 		goto fail;
 
diff -puN drivers/ata/libata-eh.c~libata-convert-post_reset-to-flags-in-ata_dev_read_id drivers/ata/libata-eh.c
--- a/drivers/ata/libata-eh.c~libata-convert-post_reset-to-flags-in-ata_dev_read_id
+++ a/drivers/ata/libata-eh.c
@@ -1634,11 +1634,14 @@ static int ata_eh_revalidate_and_attach(
 	DPRINTK("ENTER\n");
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		unsigned int action;
+		unsigned int action, readid_flags = 0;
 
 		dev = &ap->device[i];
 		action = ata_eh_dev_action(dev);
 
+		if (ehc->i.flags & ATA_EHI_DID_RESET)
+			readid_flags |= ATA_READID_POSTRESET;
+
 		if (action & ATA_EH_REVALIDATE && ata_dev_ready(dev)) {
 			if (ata_port_offline(ap)) {
 				rc = -EIO;
@@ -1646,8 +1649,7 @@ static int ata_eh_revalidate_and_attach(
 			}
 
 			ata_eh_about_to_do(ap, dev, ATA_EH_REVALIDATE);
-			rc = ata_dev_revalidate(dev,
-					ehc->i.flags & ATA_EHI_DID_RESET);
+			rc = ata_dev_revalidate(dev, readid_flags);
 			if (rc)
 				break;
 
@@ -1660,7 +1662,8 @@ static int ata_eh_revalidate_and_attach(
 			   ata_class_enabled(ehc->classes[dev->devno])) {
 			dev->class = ehc->classes[dev->devno];
 
-			rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
+			rc = ata_dev_read_id(dev, &dev->class, readid_flags,
+					     dev->id);
 			if (rc == 0)
 				rc = ata_dev_configure(dev, 1);
 
diff -puN drivers/ata/libata.h~libata-convert-post_reset-to-flags-in-ata_dev_read_id drivers/ata/libata.h
--- a/drivers/ata/libata.h~libata-convert-post_reset-to-flags-in-ata_dev_read_id
+++ a/drivers/ata/libata.h
@@ -39,6 +39,11 @@ struct ata_scsi_args {
 };
 
 /* libata-core.c */
+enum {
+	/* flags for ata_dev_read_id() */
+	ATA_READID_POSTRESET	= (1 << 0), /* reading ID after reset */
+};
+
 extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
@@ -53,8 +58,8 @@ extern unsigned ata_exec_internal(struct
 				  int dma_dir, void *buf, unsigned int buflen);
 extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
-			   int post_reset, u16 *id);
-extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
+			   unsigned int flags, u16 *id);
+extern int ata_dev_revalidate(struct ata_device *dev, unsigned int flags);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
 extern int sata_down_spd_limit(struct ata_port *ap);
 extern int sata_set_spd_needed(struct ata_port *ap);
_
