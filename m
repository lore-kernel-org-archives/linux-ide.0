From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/15] serverworks: fix DMA
Date: Sat, 30 Jun 2007 21:01:33 +0200
Message-ID: <200706302101.33525.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:51203 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466AbXF3TAH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:07 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1759210mue
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


The driver used to depend on BIOS settings for deciding whether it is OK
to use DMA.  However it seems that BIOS doesn't always handle all cases
correctly so just let IDE core to decide about this.  It should be a safe
thing to do now, after the driver went through heavy bugfixing.

Thanks for bugreport and testing the patch goes out to Sven Niedner.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/serverworks.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/serverworks.c		Version 0.21	Jun 16 2007
+ * linux/drivers/ide/pci/serverworks.c		Version 0.22	Jun 27 2007
  *
  * Copyright (C) 1998-2000 Michel Aubry
  * Copyright (C) 1998-2000 Andrzej Krzysztofowicz
@@ -394,8 +394,6 @@ static u8 __devinit ata66_svwks(ide_hwif
 
 static void __devinit init_hwif_svwks (ide_hwif_t *hwif)
 {
-	u8 dma_stat = 0;
-
 	if (!hwif->irq)
 		hwif->irq = hwif->channel ? 15 : 14;
 
@@ -426,9 +424,7 @@ static void __devinit init_hwif_svwks (i
 	if (!noautodma)
 		hwif->autodma = 1;
 
-	dma_stat = inb(hwif->dma_status);
-	hwif->drives[0].autodma = (dma_stat & 0x20);
-	hwif->drives[1].autodma = (dma_stat & 0x40);
+	hwif->drives[0].autodma = hwif->drives[1].autodma = 1;
 }
 
 static int __devinit init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
