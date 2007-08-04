From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/11] hpt34x: fix CONFIG_HPT34X_AUTODMA=n handling
Date: Sat, 4 Aug 2007 22:07:41 +0200
Message-ID: <200708042207.41437.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:51646 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988AbXHDUQH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 16:16:07 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1014338fkz
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 13:16:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Programming DMA mode may destroy current PIO mode setting so if
CONFIG_HPT34X_AUTODMA=n (the default case) make ide_tune_dma() fail
early by disabling all host DMA masks and re-tune PIO mode.

This fix doesn't help with the driver being broken but is needed
for some other changes.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/hpt34x.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -85,11 +85,7 @@ static int hpt34x_config_drive_xfer_rate
 	drive->init_speed = 0;
 
 	if (ide_tune_dma(drive))
-#ifndef CONFIG_HPT34X_AUTODMA
 		return -1;
-#else
-		return 0;
-#endif
 
 	if (ide_use_fast_pio(drive))
 		ide_set_max_pio(drive);
@@ -157,9 +153,11 @@ static void __devinit init_hwif_hpt34x(i
 	if (!hwif->dma_base)
 		return;
 
+#ifdef CONFIG_HPT34X_AUTODMA
 	hwif->ultra_mask = 0x07;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
+#endif
 
 	hwif->ide_dma_check = &hpt34x_config_drive_xfer_rate;
 	if (!noautodma)
