From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/13] siimage: fix wrong ->swdma_mask
Date: Sat, 10 Mar 2007 22:12:49 +0100
Message-ID: <200703102212.49447.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:47335 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbXCJVJX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749164uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:21 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] siimage: fix wrong ->swdma_mask

This driver doesn't support SWDMA so use the correct ->swdma_mask.

While at it:

* no need to call config_chipset_for_pio() in config_chipset_for_dma(),
  if DMA is not available config_chipset_for_pio() will be called
  by siimage_config_drive_for_dma() and if DMA is available
  config_siimage_chipset_for_pio() will be called by siimage_tune_chipset()

* remove needless config_chipset_for_pio() wrapper

* bump driver version

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/pci/siimage.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/siimage.c		Version 1.11	Jan 27, 2007
+ * linux/drivers/ide/pci/siimage.c		Version 1.12	Mar 10 2007
  *
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2003		Red Hat <alan@redhat.com>
@@ -283,11 +283,6 @@ static void config_siimage_chipset_for_p
 		(void) ide_config_drive_speed(drive, speed);
 }
 
-static void config_chipset_for_pio (ide_drive_t *drive, byte set_speed)
-{
-	config_siimage_chipset_for_pio(drive, set_speed);
-}
-
 /**
  *	siimage_tune_chipset	-	set controller timings
  *	@drive: Drive to set up
@@ -392,8 +387,6 @@ static int config_chipset_for_dma (ide_d
 {
 	u8 speed = ide_max_dma_mode(drive);
 
-	config_chipset_for_pio(drive, !speed);
-
 	if (!speed)
 		return 0;
 
@@ -419,7 +412,7 @@ static int siimage_config_drive_for_dma 
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		config_chipset_for_pio(drive, 1);
+		config_siimage_chipset_for_pio(drive, 1);
 
 	return -1;
 }
@@ -1012,7 +1005,6 @@ static void __devinit init_hwif_siimage(
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
 
 	if (!is_sata(hwif))
 		hwif->atapi_dma = 1;
