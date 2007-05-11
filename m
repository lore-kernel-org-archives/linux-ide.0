From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6 fix queue] aec62xx: kill speedproc() method wrapper
Date: Sat, 12 May 2007 01:22:34 +0400
Message-ID: <200705120122.34384.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:56643 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761316AbXEKVVA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 17:21:00 -0400
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
The patch should apply somewhere near the start of pata-2.6 patchset.
Warning: the patch has only been compile tested.

 drivers/ide/pci/aec62xx.c |   24 ++++++------------------
 1 files changed, 6 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/ide/pci/aec62xx.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/aec62xx.c
+++ linux-2.6/drivers/ide/pci/aec62xx.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/aec62xx.c		Version 0.23	Apr 27, 2007
+ * linux/drivers/ide/pci/aec62xx.c		Version 0.24	Apr 28, 2007
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
@@ -229,7 +214,6 @@ static void __devinit init_hwif_aec62xx(
 	unsigned long flags;
 
 	hwif->tuneproc = &aec62xx_tune_drive;
-	hwif->speedproc = &aec62xx_tune_chipset;
 
 	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF && hwif->mate)
 		hwif->mate->serialized = hwif->serialized = 1;
@@ -251,6 +235,8 @@ static void __devinit init_hwif_aec62xx(
 		pci_read_config_byte (dev, 0x54, &reg54);
 		pci_write_config_byte(dev, 0x54, (reg54 & ~mask));
 		spin_unlock_irqrestore(&ide_lock, flags);
+
+		hwif->speedproc = &aec6210_tune_chipset;
 		break;
 	case PCI_DEVICE_ID_ARTOP_ATP865:
 	case PCI_DEVICE_ID_ARTOP_ATP865R:
@@ -262,6 +248,8 @@ static void __devinit init_hwif_aec62xx(
 			pci_read_config_byte(hwif->pci_dev, 0x49, &ata66);
 			hwif->udma_four = (ata66 & mask) ? 0 : 1;
 		}
+
+		hwif->speedproc = &aec6260_tune_chipset;
 		break;
 	}
 

