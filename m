From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] libata: convert @post_reset to @flags in ata_dev_read_id()
Date: Fri, 10 Nov 2006 18:08:10 +0900
Message-ID: <11631496902762-git-send-email-htejun@gmail.com>
References: <11631496893280-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:15056 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1946092AbWKJJIR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Nov 2006 04:08:17 -0500
Received: by wx-out-0506.google.com with SMTP id s7so11365wxc
        for <linux-ide@vger.kernel.org>; Fri, 10 Nov 2006 01:08:17 -0800 (PST)
In-Reply-To: <11631496893280-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_dev_read_id() take @flags instead of @post_reset.  Currently
there is only one flag defined - ATA_READID_POSTRESET, which is
equivalent to @post_reset.  This is preparation for polling presence
detection.
---
 drivers/ata/libata-core.c |   17 +++++++++--------
 drivers/ata/libata-eh.c   |   11 +++++++----
 drivers/ata/libata.h      |    9 +++++++--
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9fdb266..486cabf 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1224,7 +1224,7 @@ unsigned int ata_pio_need_iordy(const st
  *	ata_dev_read_id - Read ID data from the specified device
  *	@dev: target device
  *	@p_class: pointer to class of the target device (may be changed)
- *	@post_reset: is this read ID post-reset?
+ *	@flags: ATA_READID_* flags
  *	@id: buffer to read IDENTIFY data into
  *
  *	Read ID data from the specified device.  ATA_CMD_ID_ATA is
@@ -1239,7 +1239,7 @@ unsigned int ata_pio_need_iordy(const st
  *	0 on success, -errno otherwise.
  */
 int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
-		    int post_reset, u16 *id)
+		    unsigned int flags, u16 *id)
 {
 	struct ata_port *ap = dev->ap;
 	unsigned int class = *p_class;
@@ -1294,7 +1294,7 @@ int ata_dev_read_id(struct ata_device *d
 			goto err_out;
 	}
 
-	if (post_reset && class == ATA_DEV_ATA) {
+	if ((flags & ATA_READID_POSTRESET) && class == ATA_DEV_ATA) {
 		/*
 		 * The exact sequence expected by certain pre-ATA4 drives is:
 		 * SRST RESET
@@ -1314,7 +1314,7 @@ int ata_dev_read_id(struct ata_device *d
 			/* current CHS translation info (id[53-58]) might be
 			 * changed. reread the identify device info.
 			 */
-			post_reset = 0;
+			flags &= ~ATA_READID_POSTRESET;
 			goto retry;
 		}
 	}
@@ -1639,7 +1639,8 @@ int ata_bus_probe(struct ata_port *ap)
 		if (!ata_dev_enabled(dev))
 			continue;
 
-		rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
+		rc = ata_dev_read_id(dev, &dev->class, ATA_READID_POSTRESET,
+				     dev->id);
 		if (rc)
 			goto fail;
 
@@ -3019,7 +3020,7 @@ static int ata_dev_same_device(struct at
 /**
  *	ata_dev_revalidate - Revalidate ATA device
  *	@dev: device to revalidate
- *	@post_reset: is this revalidation after reset?
+ *	@readid_flags: read ID flags
  *
  *	Re-read IDENTIFY page and make sure @dev is still attached to
  *	the port.
@@ -3030,7 +3031,7 @@ static int ata_dev_same_device(struct at
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_dev_revalidate(struct ata_device *dev, int post_reset)
+int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags)
 {
 	unsigned int class = dev->class;
 	u16 *id = (void *)dev->ap->sector_buf;
@@ -3042,7 +3043,7 @@ int ata_dev_revalidate(struct ata_device
 	}
 
 	/* read ID data */
-	rc = ata_dev_read_id(dev, &class, post_reset, id);
+	rc = ata_dev_read_id(dev, &class, readid_flags, id);
 	if (rc)
 		goto fail;
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 4776488..755fc68 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
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
 
@@ -1665,7 +1667,8 @@ static int ata_eh_revalidate_and_attach(
 			   ata_class_enabled(ehc->classes[dev->devno])) {
 			dev->class = ehc->classes[dev->devno];
 
-			rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
+			rc = ata_dev_read_id(dev, &dev->class, readid_flags,
+					     dev->id);
 			if (rc == 0) {
 				ehc->i.flags |= ATA_EHI_PRINTINFO;
 				rc = ata_dev_configure(dev);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index e4ffb2e..bb98390 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
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
@@ -52,8 +57,8 @@ extern unsigned ata_exec_internal(struct
 				  int dma_dir, void *buf, unsigned int buflen);
 extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
-			   int post_reset, u16 *id);
-extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
+			   unsigned int flags, u16 *id);
+extern int ata_dev_revalidate(struct ata_device *dev, unsigned int flags);
 extern int ata_dev_configure(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_port *ap);
 extern int sata_set_spd_needed(struct ata_port *ap);
-- 
1.4.3.3


