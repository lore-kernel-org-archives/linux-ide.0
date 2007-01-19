From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (2.6.20-rc4-mm1) pdc202xx_old: fix PIO mode setup
Date: Fri, 19 Jan 2007 23:37:52 +0300
Message-ID: <200701192337.52502.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:19007 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S964852AbXASUhx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 15:37:53 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Fix the driver's tuneproc() method to always set the PIO mode requested and not
pick the best possible one, rename it to pdc202xx_tune_drive(), and change the
calls to it accordingly; remove the preceding comment which has nothing to do
with the code.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/pdc202xx_old.c |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/pdc202xx_old.c
+++ linux-2.6/drivers/ide/pci/pdc202xx_old.c
@@ -2,6 +2,7 @@
  *  linux/drivers/ide/pci/pdc202xx_old.c	Version 0.36	Sept 11, 2002
  *
  *  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (C) 2006-2007		MontaVista Software, Inc.
  *
  *  Promise Ultra33 cards with BIOS v1.20 through 1.28 will need this
  *  compiled into the kernel if you have more than one card installed.
@@ -216,21 +217,10 @@ static int pdc202xx_tune_chipset (ide_dr
 }
 
 
-/*   0    1    2    3    4    5    6   7   8
- * 960, 480, 390, 300, 240, 180, 120, 90, 60
- *           180, 150, 120,  90,  60
- * DMA_Speed
- * 180, 120,  90,  90,  90,  60,  30
- *  11,   5,   4,   3,   2,   1,   0
- */
-static void config_chipset_for_pio (ide_drive_t *drive, u8 pio)
+static void pdc202xx_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	u8 speed = 0;
-
-	if (pio == 5) pio = 4;
-	speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, pio, NULL);
-        
-	pdc202xx_tune_chipset(drive, speed);
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pdc202xx_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
 static u8 pdc202xx_old_cable_detect (ide_hwif_t *hwif)
@@ -348,7 +338,7 @@ static int pdc202xx_config_drive_xfer_ra
 
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		hwif->tuneproc(drive, 5);
+		pdc202xx_tune_drive(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
@@ -463,7 +453,7 @@ static void pdc202xx_reset (ide_drive_t 
 	
 	pdc202xx_reset_host(hwif);
 	pdc202xx_reset_host(mate);
-	hwif->tuneproc(drive, 5);
+	pdc202xx_tune_drive(drive, 255);
 }
 
 static unsigned int __devinit init_chipset_pdc202xx(struct pci_dev *dev,
@@ -490,7 +480,7 @@ static void __devinit init_hwif_pdc202xx
 		hwif->rqsize = 256;
 
 	hwif->autodma = 0;
-	hwif->tuneproc  = &config_chipset_for_pio;
+	hwif->tuneproc  = &pdc202xx_tune_drive;
 	hwif->quirkproc = &pdc202xx_quirkproc;
 
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246)

