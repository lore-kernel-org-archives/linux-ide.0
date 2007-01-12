From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/19] sis5513: sis5513_config_xfer_rate() cleanup
Date: Fri, 12 Jan 2007 05:27:47 +0100
Message-ID: <20070112042747.28794.38484.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:34837 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030488AbXALEYL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 23:24:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so689928uga
        for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 20:24:10 -0800 (PST)
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

[PATCH] sis5513: sis5513_config_xfer_rate() cleanup

* remove bogus comment for sis5513_config_xfer_rate()
* there is no need to call config_drive_art_rwp() because
  it is called by config_art_rwp_pio()
* remove needless wrapper
* remove stale "TODO" comment
  (IDE core should provide generic tuning code)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/sis5513.c |   41 +++--------------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

Index: a/drivers/ide/pci/sis5513.c
===================================================================
--- a.orig/drivers/ide/pci/sis5513.c
+++ a/drivers/ide/pci/sis5513.c
@@ -667,11 +667,13 @@ static int config_chipset_for_dma (ide_d
 	return ide_dma_enable(drive);
 }
 
-static int sis5513_config_drive_xfer_rate (ide_drive_t *drive)
+static int sis5513_config_xfer_rate(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
+	config_art_rwp_pio(drive, 5);
+
 	drive->init_speed = 0;
 
 	if (id && (id->capability & 1) && drive->autodma) {
@@ -692,43 +694,6 @@ fast_ata_pio:
 	return 0;
 }
 
-/* initiates/aborts (U)DMA read/write operations on a drive. */
-static int sis5513_config_xfer_rate (ide_drive_t *drive)
-{
-	config_drive_art_rwp(drive);
-	config_art_rwp_pio(drive, 5);
-	return sis5513_config_drive_xfer_rate(drive);
-}
-
-/*
-  Future simpler config_xfer_rate :
-   When ide_find_best_mode is made bad-drive aware
-   - remove config_drive_xfer_rate and config_chipset_for_dma,
-   - replace config_xfer_rate with the following
-
-static int sis5513_config_xfer_rate (ide_drive_t *drive)
-{
-	u16 w80 = HWIF(drive)->udma_four;
-	u16 speed;
-
-	config_drive_art_rwp(drive);
-	config_art_rwp_pio(drive, 5);
-
-	speed = ide_find_best_mode(drive,
-		XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
-		(chipset_family >= ATA_33 ? XFER_UDMA : 0) |
-		(w80 && chipset_family >= ATA_66 ? XFER_UDMA_66 : 0) |
-		(w80 && chipset_family >= ATA_100a ? XFER_UDMA_100 : 0) |
-		(w80 && chipset_family >= ATA_133a ? XFER_UDMA_133 : 0));
-
-	sis5513_tune_chipset(drive, speed);
-
-	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
-		return HWIF(drive)->ide_dma_on(drive);
-	return HWIF(drive)->ide_dma_off_quietly(drive);
-}
-*/
-
 /* Chip detection and general config */
 static unsigned int __devinit init_chipset_sis5513 (struct pci_dev *dev, const char *name)
 {
