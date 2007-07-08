From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/12] scc_pata: PIO fixes
Date: Sun, 8 Jul 2007 15:37:45 +0200
Message-ID: <200707081537.45090.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:5711 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756823AbXGHOAe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 10:00:34 -0400
Received: by mu-out-0910.google.com with SMTP id i10so570183mue
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 07:00:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Use pio == 255 == "auto-tune" in scc_config_drive_for_dma() instead of
  forcing PIO4 on PIO fallback.  Fix comment while at it.

* Rename scc_tuneproc() to scc_tune_pio() and add scc_tuneproc() wrapper.
  Move finding of the best PIO mode and setting of transfer mode on the device
  to the new wrapper.

* Fix scc_tune_chipset() to tune PIO modes.  Do a small cleanup while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/scc_pata.c |   61 ++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -190,7 +190,7 @@ scc_ide_outsl(unsigned long port, void *
 }
 
 /**
- *	scc_tuneproc	-	tune a drive PIO mode
+ *	scc_tune_pio	-	tune a drive PIO mode
  *	@drive: drive to tune
  *	@mode_wanted: the target operating mode
  *
@@ -198,7 +198,7 @@ scc_ide_outsl(unsigned long port, void *
  *	controller.
  */
 
-static void scc_tuneproc(ide_drive_t *drive, byte mode_wanted)
+static void scc_tune_pio(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct scc_ports *ports = ide_get_hwifdata(hwif);
@@ -207,41 +207,25 @@ static void scc_tuneproc(ide_drive_t *dr
 	unsigned long piosht_port = ctl_base + 0x000;
 	unsigned long pioct_port = ctl_base + 0x004;
 	unsigned long reg;
-	unsigned char speed = XFER_PIO_0;
 	int offset;
 
-	mode_wanted = ide_get_best_pio_mode(drive, mode_wanted, 4);
-	switch (mode_wanted) {
-	case 4:
-		speed = XFER_PIO_4;
-		break;
-	case 3:
-		speed = XFER_PIO_3;
-		break;
-	case 2:
-		speed = XFER_PIO_2;
-		break;
-	case 1:
-		speed = XFER_PIO_1;
-		break;
-	case 0:
-	default:
-		speed = XFER_PIO_0;
-		break;
-	}
-
 	reg = in_be32((void __iomem *)cckctrl_port);
 	if (reg & CCKCTRL_ATACLKOEN) {
 		offset = 1; /* 133MHz */
 	} else {
 		offset = 0; /* 100MHz */
 	}
-	reg = JCHSTtbl[offset][mode_wanted] << 16 | JCHHTtbl[offset][mode_wanted];
+	reg = JCHSTtbl[offset][pio] << 16 | JCHHTtbl[offset][pio];
 	out_be32((void __iomem *)piosht_port, reg);
-	reg = JCHCTtbl[offset][mode_wanted];
+	reg = JCHCTtbl[offset][pio];
 	out_be32((void __iomem *)pioct_port, reg);
+}
 
-	ide_config_drive_speed(drive, speed);
+static void scc_tuneproc(ide_drive_t *drive, u8 pio)
+{
+	pio = ide_get_best_pio_mode(drive, pio, 4);
+	scc_tune_pio(drive, pio);
+	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 /**
@@ -280,26 +264,21 @@ static int scc_tune_chipset(ide_drive_t 
 
 	switch (speed) {
 	case XFER_UDMA_6:
-		idx = 6;
-		break;
 	case XFER_UDMA_5:
-		idx = 5;
-		break;
 	case XFER_UDMA_4:
-		idx = 4;
-		break;
 	case XFER_UDMA_3:
-		idx = 3;
-		break;
 	case XFER_UDMA_2:
-		idx = 2;
-		break;
 	case XFER_UDMA_1:
-		idx = 1;
-		break;
 	case XFER_UDMA_0:
-		idx = 0;
+		idx = speed - XFER_UDMA_0;
 		break;
+	case XFER_PIO_4:
+	case XFER_PIO_3:
+	case XFER_PIO_2:
+	case XFER_PIO_1:
+	case XFER_PIO_0:
+		scc_tune_pio(drive, speed - XFER_PIO_0);
+		return ide_config_drive_speed(drive, speed);
 	default:
 		return 1;
 	}
@@ -329,7 +308,7 @@ static int scc_tune_chipset(ide_drive_t 
  *	required.
  *      If the drive isn't suitable for DMA or we hit other problems
  *      then we will drop down to PIO and set up PIO appropriately.
- *      (return 1)
+ *      (return -1)
  */
 
 static int scc_config_drive_for_dma(ide_drive_t *drive)
@@ -338,7 +317,7 @@ static int scc_config_drive_for_dma(ide_
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		scc_tuneproc(drive, 4);
+		scc_tuneproc(drive, 255);
 
 	return -1;
 }
