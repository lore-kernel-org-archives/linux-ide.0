From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: add per-device max_sectors
Date: Sun, 12 Feb 2006 23:32:59 +0900
Message-ID: <1139754779159-git-send-email-htejun@gmail.com>
References: <11397547782407-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:27538 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751055AbWBLOdC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 09:33:02 -0500
Received: by pproxy.gmail.com with SMTP id n25so897215pyg
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 06:33:01 -0800 (PST)
In-Reply-To: <11397547782407-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
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

43ec393ac52f72d2a45f93ee2abf5255bed1d8db
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index c62798c..4db3db0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1147,9 +1147,7 @@ void ata_dev_config(struct ata_port *ap,
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
index 3628fed..86da465 100644
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
index 61c4ac7..6c482c8 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -354,9 +354,7 @@ static void sil_dev_config(struct ata_po
 	     (quirks & SIL_QUIRK_MOD15WRITE))) {
 		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix (mod15write workaround)\n",
 		       ap->id, dev->devno);
-		ap->host->max_sectors = 15;
-		ap->host->hostt->max_sectors = 15;
-		dev->flags |= ATA_DFLAG_LOCK_SECTORS;
+		dev->max_sectors = 15;
 		return;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 853c988..afe4645 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -122,8 +122,7 @@ enum {
 	/* struct ata_device stuff */
 	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
 	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
-	ATA_DFLAG_LOCK_SECTORS	= (1 << 2), /* don't adjust max_sectors */
-	ATA_DFLAG_LBA		= (1 << 3), /* device supports LBA */
+	ATA_DFLAG_LBA		= (1 << 2), /* device supports LBA */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -348,6 +347,7 @@ struct ata_device {
 
 	unsigned int		multi_count;	/* sectors count for
 						   READ/WRITE MULTIPLE */
+	unsigned int		max_sectors;	/* per-device max sectors */
 	unsigned int		cdb_len;
 
 	/* for CHS addressing */
-- 
1.1.5


