From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] libata: add per-device max_sectors
Date: Fri, 27 Jan 2006 00:24:03 +0900
Message-ID: <1138289043979-git-send-email-htejun@gmail.com>
References: <11382890422935-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:60563 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932364AbWAZPYL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:24:11 -0500
Received: by zproxy.gmail.com with SMTP id 34so368593nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:24:11 -0800 (PST)
In-Reply-To: <11382890422935-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

If a low level driver wants to control max_sectors, it had to adjust
ap->host->max_sectors and set ATA_DFLAG_LOCK_SECTORS to tell
ata_scsi_slave_config not to override the limit.  This is not only
cumbersome but also incorrect for hosts which support more than one
devices per port.

This patch adds per-device ->max_sectors.  If the field is unset
(zero), libata core layer will adjust ->max_sectors according to
default rules.  If the field is set, libata honors the setting.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    4 +---
 drivers/scsi/libata-scsi.c |   18 +++++++++---------
 drivers/scsi/sata_sil.c    |    4 +---
 include/linux/libata.h     |    4 ++--
 4 files changed, 13 insertions(+), 17 deletions(-)

d1a4f7e13eb3dbc87f2970dc25cf0b6ee267f6ce
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f42c613..b1ec4e5 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1511,9 +1511,7 @@ void ata_dev_config(struct ata_port *ap,
 		printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
 		       ap->id, i);
 		ap->udma_mask &= ATA_UDMA5;
-		ap->host->max_sectors = ATA_MAX_SECTORS;
-		ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
-		ap->device[i].flags |= ATA_DFLAG_LOCK_SECTORS;
+		ap->device[i].max_sectors = ATA_MAX_SECTORS;
 	}
 
 	if (ap->ops->dev_config)
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index c0b34bf..999cfad 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -684,23 +684,23 @@ int ata_scsi_slave_config(struct scsi_de
 	if (sdev->id < ATA_MAX_DEVICES) {
 		struct ata_port *ap;
 		struct ata_device *dev;
+		unsigned int max_sectors;
 
 		ap = (struct ata_port *) &sdev->host->hostdata[0];
 		dev = &ap->device[sdev->id];
 
-		/* TODO: 1024 is an arbitrary number, not the
+		/* TODO: 2048 is an arbitrary number, not the
 		 * hardware maximum.  This should be increased to
 		 * 65534 when Jens Axboe's patch for dynamically
 		 * determining max_sectors is merged.
 		 */
-		if ((dev->flags & ATA_DFLAG_LBA48) &&
-		    ((dev->flags & ATA_DFLAG_LOCK_SECTORS) == 0)) {
-			/*
-			 * do not overwrite sdev->host->max_sectors, since
-			 * other drives on this host may not support LBA48
-			 */
-			blk_queue_max_sectors(sdev->request_queue, 2048);
-		}
+		max_sectors = ATA_MAX_SECTORS;
+		if (dev->flags & ATA_DFLAG_LBA48)
+			max_sectors = 2048;
+		if (dev->max_sectors)
+			max_sectors = dev->max_sectors;
+
+		blk_queue_max_sectors(sdev->request_queue, max_sectors);
 
 		/*
 		 * SATA DMA transfers must be multiples of 4 byte, so
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 6c8becc..4d6d75a 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -356,9 +356,7 @@ static void sil_dev_config(struct ata_po
 	if ((ap->flags & SIL_FLAG_MOD15WRITE) && (quirks & SIL_QUIRK_MOD15WRITE)) {
 		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix\n",
 		       ap->id, dev->devno);
-		ap->host->max_sectors = 15;
-		ap->host->hostt->max_sectors = 15;
-		dev->flags |= ATA_DFLAG_LOCK_SECTORS;
+		dev->max_sectors = 15;
 		return;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e049fc5..a30aba8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -132,8 +132,7 @@ enum {
 	/* struct ata_device stuff */
 	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
 	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
-	ATA_DFLAG_LOCK_SECTORS	= (1 << 2), /* don't adjust max_sectors */
-	ATA_DFLAG_LBA		= (1 << 3), /* device supports LBA */
+	ATA_DFLAG_LBA		= (1 << 2), /* device supports LBA */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -356,6 +355,7 @@ struct ata_device {
 
 	unsigned int		multi_count;	/* sectors count for
 						   READ/WRITE MULTIPLE */
+	unsigned int		max_sectors;	/* per-device max sectors */
 	unsigned int		cdb_len;
 
 	/* for CHS addressing */
-- 
1.1.3


