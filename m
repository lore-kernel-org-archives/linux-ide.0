From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] palm_bk3710: factor out cable detection
Date: Thu, 7 Feb 2008 15:42:29 +0100
Message-ID: <200802071542.29628.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:15272 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125AbYBGO3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 09:29:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1129168wah.23
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 06:29:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Anton Salnikov <asalnikov@ru.mvista.com>


Factor out cable detection to palm_bk3710_cable_detect().

Cc: Anton Salnikov <asalnikov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/palm_bk3710.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: b/drivers/ide/arm/palm_bk3710.c
===================================================================
--- a/drivers/ide/arm/palm_bk3710.c
+++ b/drivers/ide/arm/palm_bk3710.c
@@ -311,6 +311,12 @@ static void __devinit palm_bk3710_chipin
 	palm_bk3710_setpiomode(base, NULL, 0, 600, 0);
 	palm_bk3710_setpiomode(base, NULL, 1, 600, 0);
 }
+
+static u8 __devinit palm_bk3710_cable_detect(ide_hwif_t *hwif)
+{
+	return ATA_CBL_PATA80;
+}
+
 static int __devinit palm_bk3710_probe(struct platform_device *pdev)
 {
 	struct clk *clkp;
@@ -381,7 +387,7 @@ static int __devinit palm_bk3710_probe(s
 	hwif->set_dma_mode = &palm_bk3710_set_dma_mode;
 	hwif->mmio = 1;
 	default_hwif_mmiops(hwif);
-	hwif->cbl = ATA_CBL_PATA80;
+	hwif->cbl = palm_bk3710_cable_detect(hwif);
 	hwif->ultra_mask = 0x1f;	/* Ultra DMA Mode 4 Max
 						(input clk 99MHz) */
 	hwif->mwdma_mask = 0x7;
