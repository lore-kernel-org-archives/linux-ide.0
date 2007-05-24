From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6] aec62xx: kill speedproc() method wrapper (take 2)
Date: Thu, 24 May 2007 20:46:14 +0400
Message-ID: <200705242046.14109.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:1624 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750710AbXEXQom (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 12:44:42 -0400
In-Reply-To: <200702162321.40813.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

There's no reason to have the speedproc() method wrapper for the two quite
different chip families, so just get rid of it.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Tthis version of the patch properly installs the speedproc() method.
Again, the patch has only been compile tested...

 drivers/ide/pci/aec62xx.c |   28 ++++++++--------------------
 1 files changed, 8 insertions(+), 20 deletions(-)

Index: linux-2.6/drivers/ide/pci/aec62xx.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/aec62xx.c
+++ linux-2.6/drivers/ide/pci/aec62xx.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/aec62xx.c		Version 0.23	May 23, 2007
+ * linux/drivers/ide/pci/aec62xx.c		Version 0.24	May 24, 2007
  *
  * Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2007		MontaVista Software, Inc. <source@mvista.com>
@@ -140,25 +140,10 @@ static int aec6260_tune_chipset (ide_dri
 	return(ide_config_drive_speed(drive, speed));
 }
 
-static int aec62xx_tune_chipset (ide_drive_t *drive, u8 speed)
-{
-	switch (HWIF(drive)->pci_dev->device) {
-		case PCI_DEVICE_ID_ARTOP_ATP865:
-		case PCI_DEVICE_ID_ARTOP_ATP865R:
-		case PCI_DEVICE_ID_ARTOP_ATP860:
-		case PCI_DEVICE_ID_ARTOP_ATP860R:
-			return ((int) aec6260_tune_chipset(drive, speed));
-		case PCI_DEVICE_ID_ARTOP_ATP850UF:
-			return ((int) aec6210_tune_chipset(drive, speed));
-		default:
-			return -1;
-	}
-}
-
 static void aec62xx_tune_drive (ide_drive_t *drive, u8 pio)
 {
 	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
-	(void) aec62xx_tune_chipset(drive, pio + XFER_PIO_0);
+	(void) HWIF(drive)->speedproc(drive, pio + XFER_PIO_0);
 }
 
 static int aec62xx_config_drive_xfer_rate (ide_drive_t *drive)
@@ -225,10 +210,13 @@ static void __devinit init_hwif_aec62xx(
 	unsigned long flags;
 
 	hwif->tuneproc = &aec62xx_tune_drive;
-	hwif->speedproc = &aec62xx_tune_chipset;
 
-	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF && hwif->mate)
-		hwif->mate->serialized = hwif->serialized = 1;
+	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
+		if(hwif->mate)
+			hwif->mate->serialized = hwif->serialized = 1;
+		hwif->speedproc = &aec6210_tune_chipset;
+	} else
+		hwif->speedproc = &aec6260_tune_chipset;
 
 	if (!hwif->dma_base) {
 		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;

