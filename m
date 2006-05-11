From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/14] libata-hp-prep: make some ata_device fields persistent
Date: Fri, 12 May 2006 00:11:59 +0900
Message-ID: <11473603182049-git-send-email-htejun@gmail.com>
References: <1147360318920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:13559 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751853AbWEKPML (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:12:11 -0400
Received: by py-out-1112.google.com with SMTP id f28so279625pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:12:11 -0700 (PDT)
In-Reply-To: <1147360318920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Lifetimes of some fields span over device plugging/unplugging.  This
patch moves such persistent fields to the top of ata_device and
separate them with ATA_DEVICE_CLEAR_OFFSET.  Fields above the offset
are initialized once during host initializatino while all other fields
are cleared before hotplugging.  Currently ->ap, devno and part of
flags are persistent.

Note that flags is partially cleared while holding host_set lock.
This is to synchronize with later warm plug implementation which will
record hotplug request in dev->flags.

---

 drivers/scsi/libata-core.c |   14 ++++++++++++--
 include/linux/libata.h     |    8 ++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

480d38b7f94a98fe9c9b33db932d94652cfed779
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d307164..6accef3 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5119,9 +5119,18 @@ static void ata_host_remove(struct ata_p
 void ata_dev_init(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->ap;
+	unsigned long flags;
+
+	/* High bits of dev->flags are used to record warm plug
+	 * requests which occur asynchronously.  Synchronize using
+	 * host_set lock.
+	 */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	dev->flags &= ~ATA_DFLAG_INIT_MASK;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	memset((void *)dev, 0, sizeof(*dev));
-	dev->devno = dev - ap->device;
+	memset((void *)dev + ATA_DEVICE_CLEAR_OFFSET, 0,
+	       sizeof(*dev) - ATA_DEVICE_CLEAR_OFFSET);
 	dev->pio_mask = UINT_MAX;
 	dev->mwdma_mask = UINT_MAX;
 	dev->udma_mask = UINT_MAX;
@@ -5183,6 +5192,7 @@ static void ata_host_init(struct ata_por
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 		dev->ap = ap;
+		dev->devno = i;
 		ata_dev_init(dev);
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1f6e48e..99a78cf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -129,6 +129,7 @@ enum {
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
+	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 16),
 	ATA_DFLAG_DETACHED	= (1 << 17),
@@ -408,10 +409,11 @@ struct ata_ering {
 
 struct ata_device {
 	struct ata_port		*ap;
-	u64			n_sectors;	/* size of device, if ATA */
+	unsigned int		devno;		/* 0 or 1 */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
+	/* fields above n_sectors are not cleared across device init */
+	u64			n_sectors;	/* size of device, if ATA */
 	unsigned int		class;		/* ATA_DEV_xxx */
-	unsigned int		devno;		/* 0 or 1 */
 	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
 	u8			dma_mode;
@@ -436,6 +438,8 @@ struct ata_device {
 	DEFINE_ATA_ERING	(ering, ATA_DEV_ERING_SIZE);
 };
 
+#define ATA_DEVICE_CLEAR_OFFSET		offsetof(struct ata_device, n_sectors)
+
 struct ata_eh_info {
 	struct ata_device	*dev;		/* offending device */
 	u32			serror;		/* SError from LLDD */
-- 
1.2.4


