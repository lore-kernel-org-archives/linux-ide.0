From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/13] sl82c105: add ->speedproc support
Date: Sat, 10 Mar 2007 22:09:59 +0100
Message-ID: <200703102209.59918.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:46174 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314AbXCJVJP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749114uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:14 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] sl82c105: add ->speedproc support

* add sl82c105_tunepio() wrapper for sl82c105_tune_drive()
  (just to get the error value)

* add sl82c105_tune_chipset() (->speedproc method) for setting
  transfer mode

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/pci/sl82c105.c |   44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -77,7 +77,7 @@ static unsigned int get_timing_sl82c105(
 /*
  * Configure the drive and chipset for PIO
  */
-static void sl82c105_tune_drive(ide_drive_t *drive, u8 pio)
+static int sl82c105_tunepio(ide_drive_t *drive, u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -91,7 +91,7 @@ static void sl82c105_tune_drive(ide_driv
 	xfer_mode = ide_get_best_pio_mode(drive, pio, 5, &p) + XFER_PIO_0;
 
 	if (ide_config_drive_speed(drive, xfer_mode))
-		return;
+		return 1;
 
 	drive->drive_data = drv_ctrl = get_timing_sl82c105(&p);
 
@@ -114,17 +114,45 @@ static void sl82c105_tune_drive(ide_driv
 	 */
 	drive->io_32bit = 1;
 	drive->unmask	= 1;
+
+	return 0;
+}
+
+static void sl82c105_tune_drive(ide_drive_t *drive, u8 pio)
+{
+	/*
+	 * TODO: find best PIO mode and set device speed here
+	 *       (requires adding helper function for getting PIO cycle time)
+	 */
+	(void)sl82c105_tunepio(drive, pio);
+}
+
+static int sl82c105_tune_chipset(ide_drive_t *drive, u8 mode)
+{
+	mode = ide_rate_filter(drive, mode);
+
+	if (mode >= XFER_PIO_0 && mode <= XFER_PIO_5)
+		return sl82c105_tunepio(drive, mode - XFER_PIO_0);
+
+	/*
+	 * TODO: add MWDMA0/1 support
+	 */
+	BUG_ON(mode != XFER_MW_DMA_2);
+
+	/*
+	 * Configure the drive for DMA.
+	 * We'll program the chipset only when DMA is actually turned on.
+	 */
+	return ide_config_drive_speed(drive, mode);
 }
 
-/*
- * Configure the drive for DMA.
- * We'll program the chipset only when DMA is actually turned on.
- */
 static int config_for_dma (ide_drive_t *drive)
 {
+	u8 mode = ide_max_dma_mode(drive);
+
 	DBG(("config_for_dma(drive:%s)\n", drive->name));
 
-	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) != 0)
+	if (mode == 0 || sl82c105_tune_chipset(drive, mode))
 		return 0;
 
 	return ide_dma_enable(drive);
@@ -387,6 +415,8 @@ static void __devinit init_hwif_sl82c105
 		return;
 	}
 
+	hwif->speedproc			= &sl82c105_tune_chipset;
+
 	hwif->atapi_dma  = 1;
 	hwif->mwdma_mask = 0x04;
 
