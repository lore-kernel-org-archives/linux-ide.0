From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/6] libata: convert @post_reset to @flags in ata_dev_read_id()
Date: Sat, 30 Sep 2006 15:46:49 +0900
Message-ID: <115959880960-git-send-email-htejun@gmail.com>
References: <11595988092938-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:62673 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751089AbWI3Gq5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 02:46:57 -0400
Received: by py-out-1112.google.com with SMTP id n25so1581531pyg
        for <linux-ide@vger.kernel.org>; Fri, 29 Sep 2006 23:46:56 -0700 (PDT)
In-Reply-To: <11595988092938-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nabiki@teleline.es, kaos@ocs.com.au, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, jgarzik@pobox.com, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_dev_read_id() take @flags instead of @post_reset.  Currently
there is only one flag defined - ATA_READID_POSTRESET, which is
equivalent to @post_reset.  This is preparation for polling presence
detection.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   17 +++++++++--------
 drivers/ata/libata-eh.c   |   11 +++++++----
 drivers/ata/libata.h      |    9 +++++++--
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6cbb5e7..8e8f359 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1220,7 +1220,7 @@ unsigned int ata_pio_need_iordy(const st
  *	ata_dev_read_id - Read ID data from the specified device
  *	@dev: target device
  *	@p_class: pointer to class of the target device (may be changed)
- *	@post_reset: is this read ID post-reset?
+ *	@flags: ATA_READID_* flags
  *	@id: buffer to read IDENTIFY data into
  *
  *	Read ID data from the specified device.  ATA_CMD_ID_ATA is
@@ -1235,7 +1235,7 @@ unsigned int ata_pio_need_iordy(const st
  *	0 on success, -errno otherwise.
  */
 int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
-		    int post_reset, u16 *id)
+		    unsigned int flags, u16 *id)
 {
 	struct ata_port *ap = dev->ap;
 	unsigned int class = *p_class;
@@ -1290,7 +1290,7 @@ int ata_dev_read_id(struct ata_device *d
 			goto err_out;
 	}
 
-	if (post_reset && class == ATA_DEV_ATA) {
+	if ((flags & ATA_READID_POSTRESET) && class == ATA_DEV_ATA) {
 		/*
 		 * The exact sequence expected by certain pre-ATA4 drives is:
 		 * SRST RESET
@@ -1310,7 +1310,7 @@ int ata_dev_read_id(struct ata_device *d
 			/* current CHS translation info (id[53-58]) might be
 			 * changed. reread the identify device info.
 			 */
-			post_reset = 0;
+			flags &= ~ATA_READID_POSTRESET;
 			goto retry;
 		}
 	}
@@ -1627,7 +1627,8 @@ int ata_bus_probe(struct ata_port *ap)
 		if (!ata_dev_enabled(dev))
 			continue;
 
-		rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
+		rc = ata_dev_read_id(dev, &dev->class, ATA_READID_POSTRESET,
+				     dev->id);
 		if (rc)
 			goto fail;
 
@@ -2965,7 +2966,7 @@ static int ata_dev_same_device(struct at
 /**
  *	ata_dev_revalidate - Revalidate ATA device
  *	@dev: device to revalidate
- *	@post_reset: is this revalidation after reset?
+ *	@readid_flags: read ID flags
  *
  *	Re-read IDENTIFY page and make sure @dev is still attached to
  *	the port.
@@ -2976,7 +2977,7 @@ static int ata_dev_same_device(struct at
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_dev_revalidate(struct ata_device *dev, int post_reset)
+int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags)
 {
 	unsigned int class = dev->class;
 	u16 *id = (void *)dev->ap->sector_buf;
@@ -2988,7 +2989,7 @@ int ata_dev_revalidate(struct ata_device
 	}
 
 	/* read ID data */
-	rc = ata_dev_read_id(dev, &class, post_reset, id);
+	rc = ata_dev_read_id(dev, &class, readid_flags, id);
 	if (rc)
 		goto fail;
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 02b2b27..94faeee 100644
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
 
@@ -1660,7 +1662,8 @@ static int ata_eh_revalidate_and_attach(
 			   ata_class_enabled(ehc->classes[dev->devno])) {
 			dev->class = ehc->classes[dev->devno];
 
-			rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
+			rc = ata_dev_read_id(dev, &dev->class, readid_flags,
+					     dev->id);
 			if (rc == 0)
 				rc = ata_dev_configure(dev, 1);
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0ed263b..34c4054 100644
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
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
 extern int sata_down_spd_limit(struct ata_port *ap);
 extern int sata_set_spd_needed(struct ata_port *ap);
-- 
1.4.2.1


