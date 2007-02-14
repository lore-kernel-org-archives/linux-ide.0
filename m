From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/8] alim15x3: PIO fallback fix
Date: Wed, 14 Feb 2007 02:56:03 +0100
Message-ID: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:46567 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbXBNBu0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 20:50:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so28107uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2007 17:50:22 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[PATCH] alim15x3: PIO fallback fix

If DMA tuning fails always set the best PIO mode.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/alim15x3.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -491,7 +491,7 @@ static int ali15x3_config_drive_for_dma(
 	struct hd_driveid *id	= drive->id;
 
 	if ((m5229_revision<=0x20) && (drive->media!=ide_disk))
-		goto no_dma_set;
+		goto ata_pio;
 
 	drive->init_speed = 0;
 
@@ -512,20 +512,19 @@ try_dma_modes:
 			    (id->dma_1word & hwif->swdma_mask)) {
 				/* Force if Capable regular DMA modes */
 				if (!config_chipset_for_dma(drive))
-					goto no_dma_set;
+					goto ata_pio;
 			}
 		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!config_chipset_for_dma(drive))
-				goto no_dma_set;
+				goto ata_pio;
 		} else {
 			goto ata_pio;
 		}
 	} else {
 ata_pio:
 		hwif->tuneproc(drive, 255);
-no_dma_set:
 		return -1;
 	}
 
