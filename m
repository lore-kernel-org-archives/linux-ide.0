From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: move dev->max_sectors configuration into ata_dev_configure()
Date: Thu, 19 Oct 2006 14:51:39 +0900
Message-ID: <11612370993739-git-send-email-htejun@gmail.com>
References: <1161237098656-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:60327 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030249AbWJSFvq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Oct 2006 01:51:46 -0400
Received: by ug-out-1314.google.com with SMTP id o38so363226ugd
        for <linux-ide@vger.kernel.org>; Wed, 18 Oct 2006 22:51:45 -0700 (PDT)
In-Reply-To: <1161237098656-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move dev->max_sectors configuration from ata_scsi_dev_config() to
ata_dev_configure().

* more consistent.
* allows LLDs to peek at the default dev->max_sectors value.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    5 +++++
 drivers/ata/libata-scsi.c |   19 +++----------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f5164db..4ef68f3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1530,6 +1530,11 @@ int ata_dev_configure(struct ata_device 
 				       cdb_intr_string);
 	}
 
+	/* determine max_sectors */
+	dev->max_sectors = ATA_MAX_SECTORS;
+	if (dev->flags & ATA_DFLAG_LBA48)
+		dev->max_sectors = ATA_MAX_SECTORS_LBA48;
+
 	if (dev->horkage & ATA_HORKAGE_DIAGNOSTIC) {
 		/* Let the user know. We don't want to disallow opens for
 		   rescue purposes, or in case the vendor is just a blithering
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7af2a4b..d10f249 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -807,23 +807,10 @@ static void ata_scsi_sdev_config(struct 
 static void ata_scsi_dev_config(struct scsi_device *sdev,
 				struct ata_device *dev)
 {
-	unsigned int max_sectors;
+	/* configure max sectors */
+	blk_queue_max_sectors(sdev->request_queue, dev->max_sectors);
 
-	/* TODO: 2048 is an arbitrary number, not the
-	 * hardware maximum.  This should be increased to
-	 * 65534 when Jens Axboe's patch for dynamically
-	 * determining max_sectors is merged.
-	 */
-	max_sectors = ATA_MAX_SECTORS;
-	if (dev->flags & ATA_DFLAG_LBA48)
-		max_sectors = ATA_MAX_SECTORS_LBA48;
-	if (dev->max_sectors)
-		max_sectors = dev->max_sectors;
-
-	blk_queue_max_sectors(sdev->request_queue, max_sectors);
-
-	/*
-	 * SATA DMA transfers must be multiples of 4 byte, so
+	/* SATA DMA transfers must be multiples of 4 byte, so
 	 * we need to pad ATAPI transfers using an extra sg.
 	 * Decrement max hw segments accordingly.
 	 */
-- 
1.4.2.3


