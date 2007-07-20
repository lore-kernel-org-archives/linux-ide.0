From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] it8213/piix/slc90e66: don't change DMA settings when programming PIO
Date: Fri, 20 Jul 2007 12:25:02 +0200
Message-ID: <200707201225.02931.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:56678 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbXGTKJE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 06:09:04 -0400
Received: by ug-out-1314.google.com with SMTP id j3so586012ugf
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 03:09:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it8213.c   |   16 ++++++----------
 drivers/ide/pci/piix.c     |   17 +++++++----------
 drivers/ide/pci/slc90e66.c |   17 +++++++----------
 3 files changed, 20 insertions(+), 30 deletions(-)

Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -134,6 +134,11 @@ static int it8213_tune_chipset(ide_drive
 	u16			reg4042, reg4a;
 	u8			reg48, reg54, reg55;
 
+	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
+		it8213_tune_pio(drive, speed - XFER_PIO_0);
+		return ide_config_drive_speed(drive, speed);
+	}
+
 	pci_read_config_word(dev, maslave, &reg4042);
 	pci_read_config_byte(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
@@ -153,12 +158,6 @@ static int it8213_tune_chipset(ide_drive
 		case XFER_MW_DMA_1:
 		case XFER_SW_DMA_2:
 			break;
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-			break;
 		default:
 			return -1;
 	}
@@ -190,10 +189,7 @@ static int it8213_tune_chipset(ide_drive
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
 
-	if (speed > XFER_PIO_4)
-		it8213_tune_pio(drive, it8213_dma_2_pio(speed));
-	else
-		it8213_tune_pio(drive, speed - XFER_PIO_0);
+	it8213_tune_pio(drive, it8213_dma_2_pio(speed));
 
 	return ide_config_drive_speed(drive, speed);
 }
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/piix.c	Version 0.51	Jul 6, 2007
+ *  linux/drivers/ide/pci/piix.c	Version 0.52	Jul 14, 2007
  *
  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
@@ -243,6 +243,11 @@ static int piix_tune_chipset(ide_drive_t
 	u16			reg4042, reg4a;
 	u8			reg48, reg54, reg55;
 
+	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
+		piix_tune_pio(drive, speed - XFER_PIO_0);
+		return ide_config_drive_speed(drive, speed);
+	}
+
 	pci_read_config_word(dev, maslave, &reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
 	pci_read_config_byte(dev, 0x48, &reg48);
@@ -260,11 +265,6 @@ static int piix_tune_chipset(ide_drive_t
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_SW_DMA_2:	break;
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:	break;
 		default:		return -1;
 	}
 
@@ -294,10 +294,7 @@ static int piix_tune_chipset(ide_drive_t
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
 
-	if (speed > XFER_PIO_4)
-		piix_tune_pio(drive, piix_dma_2_pio(speed));
-	else
-		piix_tune_pio(drive, speed - XFER_PIO_0);
+	piix_tune_pio(drive, piix_dma_2_pio(speed));
 
 	return ide_config_drive_speed(drive, speed);
 }
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/slc90e66.c	Version 0.15	Jul 6, 2007
+ *  linux/drivers/ide/pci/slc90e66.c	Version 0.16	Jul 14, 2007
  *
  *  Copyright (C) 2000-2002 Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
@@ -110,6 +110,11 @@ static int slc90e66_tune_chipset(ide_dri
 	int u_speed = 0, u_flag = 1 << drive->dn;
 	u16			reg4042, reg44, reg48, reg4a;
 
+	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
+		slc90e66_tune_pio(drive, speed - XFER_PIO_0);
+		return ide_config_drive_speed(drive, speed);
+	}
+
 	pci_read_config_word(dev, maslave, &reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
 	pci_read_config_word(dev, 0x44, &reg44);
@@ -125,11 +130,6 @@ static int slc90e66_tune_chipset(ide_dri
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_SW_DMA_2:	break;
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:        break;
 		default:		return -1;
 	}
 
@@ -149,10 +149,7 @@ static int slc90e66_tune_chipset(ide_dri
 			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
 	}
 
-	if (speed > XFER_PIO_4)
-		slc90e66_tune_pio(drive, slc90e66_dma_2_pio(speed));
-	else
-		slc90e66_tune_pio(drive, speed - XFER_PIO_0);
+	slc90e66_tune_pio(drive, slc90e66_dma_2_pio(speed));
 
 	return ide_config_drive_speed(drive, speed);
 }
