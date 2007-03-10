From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/13] ide-cris: fix ->speedproc and wrong ->swdma_mask
Date: Sat, 10 Mar 2007 22:12:58 +0100
Message-ID: <200703102212.58415.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:46382 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374AbXCJVJX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749167uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:22 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] ide-cris: fix ->speedproc and wrong ->swdma_mask

* fix ->speedproc to set the drive speed

* this driver doesn't support SWDMA so use the correct ->swdma_mask

* BUG() if an unsupported mode is passed to ->speedproc

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/cris/ide-cris.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -730,7 +730,7 @@ static int speed_cris_ide(ide_drive_t *d
 
 	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
 		tune_cris_ide(drive, speed - XFER_PIO_0);
-		return 0;
+		return ide_config_drive_speed(drive, speed);
 	}
 
 	switch(speed)
@@ -760,7 +760,8 @@ static int speed_cris_ide(ide_drive_t *d
 			hold = ATA_DMA2_HOLD;
 			break;
 		default:
-			return 0;
+			BUG();
+			break;
 	}
 
 	if (speed >= XFER_UDMA_0)
@@ -768,7 +769,7 @@ static int speed_cris_ide(ide_drive_t *d
 	else
 		cris_ide_set_speed(TYPE_DMA, 0, strobe, hold);
 
-	return 0;
+	return ide_config_drive_speed(drive, speed);
 }
 
 void __init
@@ -821,7 +822,6 @@ init_e100_ide (void)
 		hwif->udma_four = 0;
 		hwif->ultra_mask = cris_ultra_mask;
 		hwif->mwdma_mask = 0x07; /* Multiword DMA 0-2 */
-		hwif->swdma_mask = 0x07; /* Singleword DMA 0-2 */
 		hwif->autodma = 1;
 		hwif->drives[0].autodma = 1;
 		hwif->drives[1].autodma = 1;
@@ -1010,7 +1010,6 @@ static int cris_config_drive_for_dma (id
 		return 0;
 
 	speed_cris_ide(drive, speed);
-	ide_config_drive_speed(drive, speed);
 
 	return ide_dma_enable(drive);
 }
