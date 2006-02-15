From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/7] libata: convert dev->id to pointer
Date: Wed, 15 Feb 2006 18:24:09 +0900
Message-ID: <11399954493649-git-send-email-htejun@gmail.com>
References: <11399954493467-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:34486 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945907AbWBOJYN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 04:24:13 -0500
Received: by pproxy.gmail.com with SMTP id t32so1467044pyc
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 01:24:12 -0800 (PST)
In-Reply-To: <11399954493467-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert dev->id from array to pointer.  This is to accomodate
revalidation.  During revalidation, both old and new IDENTIFY pages
should be accessible and single ->id array doesn't cut it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   11 +++++++++--
 include/linux/libata.h     |    2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

437d923fd2bb8020b4a5cdaa8080bcf9f20698cd
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f97ead8..a435454 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -953,6 +953,10 @@ static void ata_dev_identify(struct ata_
 
 	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
 
+	dev->id = kmalloc(sizeof(dev->id[0]) * ATA_ID_WORDS, GFP_KERNEL);
+	if (dev->id == NULL)
+		goto err_out;
+
 retry:
 	ata_tf_init(ap, &tf, device);
 
@@ -967,7 +971,7 @@ retry:
 	tf.protocol = ATA_PROT_PIO;
 
 	err_mask = ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
-				     dev->id, sizeof(dev->id));
+				     dev->id, sizeof(dev->id[0]) * ATA_ID_WORDS);
 
 	if (err_mask) {
 		if (err_mask & ~AC_ERR_DEV)
@@ -2515,7 +2519,7 @@ static void ata_dev_reread_id(struct ata
 	tf.protocol = ATA_PROT_PIO;
 
 	if (ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
-			      dev->id, sizeof(dev->id)))
+			      dev->id, sizeof(dev->id[0]) * ATA_ID_WORDS))
 		goto err_out;
 
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
@@ -4722,11 +4726,14 @@ void ata_host_set_remove(struct ata_host
 int ata_scsi_release(struct Scsi_Host *host)
 {
 	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
+	int i;
 
 	DPRINTK("ENTER\n");
 
 	ap->ops->port_disable(ap);
 	ata_host_remove(ap, 0);
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		kfree(ap->device[i].id);
 
 	DPRINTK("EXIT\n");
 	return 1;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0d6bf50..1f15666 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -339,7 +339,7 @@ struct ata_device {
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned int		devno;		/* 0 or 1 */
-	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
+	u16			*id;		/* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
 	u8			dma_mode;
 	u8			xfer_mode;
-- 
1.1.5


