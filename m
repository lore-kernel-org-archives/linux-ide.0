From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: move dev->max_sectors configuration into ata_dev_configure()
Date: Wed, 1 Nov 2006 18:39:55 +0900
Message-ID: <20061101093955.GU13677@htj.dyndns.org>
References: <20061101093852.GS13677@htj.dyndns.org> <20061101093927.GT13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:58995 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946737AbWKAJkD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 04:40:03 -0500
Received: by nf-out-0910.google.com with SMTP id c2so744373nfe
        for <linux-ide@vger.kernel.org>; Wed, 01 Nov 2006 01:40:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061101093927.GT13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Move dev->max_sectors configuration from ata_scsi_dev_config() to
ata_dev_configure().

* more consistent.
* allows LLDs to peek at the default dev->max_sectors value.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    5 +++++
 drivers/ata/libata-scsi.c |   19 +++----------------
 2 files changed, 8 insertions(+), 16 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -1533,6 +1533,11 @@ int ata_dev_configure(struct ata_device 
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
Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
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
