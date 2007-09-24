From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/9] ide_platform: set hwif->chipset
Date: Mon, 24 Sep 2007 22:34:27 +0200
Message-ID: <200709242234.27142.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29636 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbXIXUqE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 16:46:04 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1485942nfb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 13:46:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


We need to set hwif->chipset or IDE PCI host drivers may try to claim
our ide_hwifs[] slot.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ide_platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/legacy/ide_platform.c
===================================================================
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -52,7 +52,7 @@ static ide_hwif_t *__devinit plat_ide_lo
 	hwif->hw.irq = hwif->irq = irq;
 
 	hwif->hw.dma = NO_DMA;
-	hwif->hw.chipset = ide_generic;
+	hwif->chipset = hwif->hw.chipset = ide_generic;
 
 	if (mmio) {
 		hwif->mmio = 1;
