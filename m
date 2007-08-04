From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-pmac: use ide_tune_dma() (take 2)
Date: Sat, 4 Aug 2007 22:04:01 +0200
Message-ID: <200708042204.01165.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:51646 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759225AbXHDUQD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 16:16:03 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1014338fkz
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 13:16:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


* Add missing initialization of hwif->autodma and drive->autodma to
  pmac_ide_setup_dma().

* Use ide_tune_dma() in pmac_ide_dma_check().

While at it:

* Fix pmac_ide_dma_check() return value if DMA mode is not programmed
  (should be "-1" otherwise ide_set_dma() will try to enable DMA).

* Remove unnecessary drive->using_dma fiddling (->dma_off_quietly is always
  called before ide_set_dma() call and ide_set_dma() calls ->ide_dma_on if
  ->ide_dma_check returns "0").

v2:
* No reason to blacklist all ide_floppy devices and the old code was always
  enabling DMA anyway (without even programming controller/device if the
  device was ide_floppy).

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Ben, any update on the testing status of ide-pmac series?

I also merged your patch to my tree but it is lacking description:
http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/ide-pmac-fix-pio-setup-and-enable-autotune.patch

Thanks, Bart.

 drivers/ide/ppc/pmac.c |   24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1592,23 +1592,10 @@ pmac_ide_destroy_dmatable (ide_drive_t *
 static int
 pmac_ide_dma_check(ide_drive_t *drive)
 {
-	int enable = 1;
-	drive->using_dma = 0;
-	
-	if (drive->media == ide_floppy)
-		enable = 0;
-	if ((drive->id->capability & 1) == 0 && !__ide_dma_good_drive(drive))
-		enable = 0;
-	if (__ide_dma_bad_drive(drive))
-		enable = 0;
-
-	if (enable) {
-		u8 mode = ide_max_dma_mode(drive);
+	if (ide_tune_dma(drive))
+		return 0;
 
-		if (mode && pmac_ide_tune_chipset(drive, mode) == 0)
-			drive->using_dma = 1;
-	}
-	return 0;
+	return -1;
 }
 
 /*
@@ -1842,7 +1829,10 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 			hwif->mwdma_mask = 0x07;
 			hwif->swdma_mask = 0x00;
 			break;
-	}	
+	}
+
+	hwif->autodma = 1;
+	hwif->drives[1].autodma = hwif->drives[0].autodma = hwif->autodma;
 }
 
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
