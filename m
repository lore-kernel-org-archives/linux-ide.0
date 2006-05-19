From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/14] libata-hp-prep: make some ata_device fields persistent
Date: Fri, 19 May 2006 06:06:35 -0700 (PDT)
Message-ID: <11480439881851-git-send-email-htejun@gmail.com>
References: <11480439883935-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:18121 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751226AbWESNGh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:06:37 -0400
Received: by py-out-1112.google.com with SMTP id z59so917368pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:06:36 -0700 (PDT)
In-Reply-To: <11480439883935-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
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

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   14 ++++++++++++--
 include/linux/libata.h     |    8 ++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

2a6927015b1d7a4c1de409c527331ebf9755d613
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f239324..ccdb867 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5120,9 +5120,18 @@ static void ata_host_remove(struct ata_p
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
index 3fb6dc3..99808c5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -130,6 +130,7 @@ enum {
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
+	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 16),
 	ATA_DFLAG_DETACHED	= (1 << 17),
@@ -410,10 +411,11 @@ struct ata_ering {
 
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
@@ -439,6 +441,8 @@ struct ata_device {
 	struct ata_ering	ering;
 };
 
+#define ATA_DEVICE_CLEAR_OFFSET		offsetof(struct ata_device, n_sectors)
+
 struct ata_eh_info {
 	struct ata_device	*dev;		/* offending device */
 	u32			serror;		/* SError from LLDD */
-- 
1.3.2

