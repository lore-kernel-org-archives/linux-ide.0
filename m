From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/11] it8213/piix/slc90e66: remove {it8213,piix,slc90e66}_dma_2_pio()
Date: Sat, 4 Aug 2007 22:06:22 +0200
Message-ID: <200708042206.22546.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:12604 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759060AbXHDUQG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 16:16:06 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1508326mue
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 13:16:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it8213.c   |   44 +++++++++++---------------------------------
 drivers/ide/pci/piix.c     |   44 +++++++++++---------------------------------
 drivers/ide/pci/slc90e66.c |   33 +++++++++++----------------------
 3 files changed, 33 insertions(+), 88 deletions(-)

Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -18,37 +18,6 @@
 #include <asm/io.h>
 
 /**
- *	it8213_dma_2_pio		-	return the PIO mode matching DMA
- *	@xfer_rate: transfer speed
- *
- *	Returns the nearest equivalent PIO timing for the DMA
- *	mode requested by the controller.
- */
-
-static u8 it8213_dma_2_pio (u8 xfer_rate) {
-	switch(xfer_rate) {
-		case XFER_UDMA_6:
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-		case XFER_MW_DMA_2:
-			return 4;
-		case XFER_MW_DMA_1:
-			return 3;
-		case XFER_SW_DMA_2:
-			return 2;
-		case XFER_MW_DMA_0:
-		case XFER_SW_DMA_1:
-		case XFER_SW_DMA_0:
-		default:
-			return 0;
-	}
-}
-
-/**
  *	it8213_set_pio_mode	-	set host controller for PIO mode
  *	@drive: drive
  *	@pio: PIO mode number
@@ -124,7 +93,7 @@ static void it8213_set_dma_mode(ide_driv
 	int w_flag		= 0x10 << drive->dn;
 	int u_speed		= 0;
 	u16			reg4042, reg4a;
-	u8			reg48, reg54, reg55;
+	u8			reg48, reg54, reg55, pio;
 
 	pci_read_config_word(dev, maslave, &reg4042);
 	pci_read_config_byte(dev, 0x48, &reg48);
@@ -165,7 +134,11 @@ static void it8213_set_dma_mode(ide_driv
 				pci_write_config_byte(dev, 0x54, reg54 | v_flag);
 		} else
 			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
+
+		pio = 4;
 	} else {
+		const u8 mwdma_to_pio[] = { 0, 3, 4 };
+
 		if (reg48 & u_flag)
 			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
 		if (reg4a & a_speed)
@@ -174,9 +147,14 @@ static void it8213_set_dma_mode(ide_driv
 			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 		if (reg55 & w_flag)
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
+
+		if (speed >= XFER_MW_DMA_0)
+			pio = mwdma_to_pio[speed - XFER_MW_DMA_0];
+		else
+			pio = 2; /* only SWDMA2 is allowed */
 	}
 
-	it8213_set_pio_mode(drive, it8213_dma_2_pio(speed));
+	it8213_set_pio_mode(drive, pio);
 }
 
 /**
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -106,37 +106,6 @@
 static int no_piix_dma;
 
 /**
- *	piix_dma_2_pio		-	return the PIO mode matching DMA
- *	@xfer_rate: transfer speed
- *
- *	Returns the nearest equivalent PIO timing for the DMA
- *	mode requested by the controller.
- */
- 
-static u8 piix_dma_2_pio (u8 xfer_rate) {
-	switch(xfer_rate) {
-		case XFER_UDMA_6:
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-		case XFER_MW_DMA_2:
-			return 4;
-		case XFER_MW_DMA_1:
-			return 3;
-		case XFER_SW_DMA_2:
-			return 2;
-		case XFER_MW_DMA_0:
-		case XFER_SW_DMA_1:
-		case XFER_SW_DMA_0:
-		default:
-			return 0;
-	}
-}
-
-/**
  *	piix_set_pio_mode	-	set host controller for PIO mode
  *	@drive: drive
  *	@pio: PIO mode number
@@ -225,7 +194,7 @@ static void piix_set_dma_mode(ide_drive_
 	int u_speed		= 0;
 	int			sitre;
 	u16			reg4042, reg4a;
-	u8			reg48, reg54, reg55;
+	u8			reg48, reg54, reg55, pio;
 
 	pci_read_config_word(dev, maslave, &reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
@@ -262,7 +231,11 @@ static void piix_set_dma_mode(ide_drive_
 				pci_write_config_byte(dev, 0x54, reg54 | v_flag);
 		} else
 			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
+
+		pio = 4;
 	} else {
+		const u8 mwdma_to_pio[] = { 0, 3, 4 };
+
 		if (reg48 & u_flag)
 			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
 		if (reg4a & a_speed)
@@ -271,9 +244,14 @@ static void piix_set_dma_mode(ide_drive_
 			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 		if (reg55 & w_flag)
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
+
+		if (speed >= XFER_MW_DMA_0)
+			pio = mwdma_to_pio[speed - XFER_MW_DMA_0];
+		else
+			pio = 2; /* only SWDMA2 is allowed */
 	}
 
-	piix_set_pio_mode(drive, piix_dma_2_pio(speed));
+	piix_set_pio_mode(drive, pio);
 }
 
 /**
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -21,27 +21,6 @@
 
 #include <asm/io.h>
 
-static u8 slc90e66_dma_2_pio (u8 xfer_rate) {
-	switch(xfer_rate) {
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-		case XFER_MW_DMA_2:
-			return 4;
-		case XFER_MW_DMA_1:
-			return 3;
-		case XFER_SW_DMA_2:
-			return 2;
-		case XFER_MW_DMA_0:
-		case XFER_SW_DMA_1:
-		case XFER_SW_DMA_0:
-		default:
-			return 0;
-	}
-}
-
 static void slc90e66_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -103,6 +82,7 @@ static void slc90e66_set_dma_mode(ide_dr
 	int sitre = 0, a_speed	= 7 << (drive->dn * 4);
 	int u_speed = 0, u_flag = 1 << drive->dn;
 	u16			reg4042, reg44, reg48, reg4a;
+	u8			pio;
 
 	pci_read_config_word(dev, maslave, &reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
@@ -131,14 +111,23 @@ static void slc90e66_set_dma_mode(ide_dr
 			pci_read_config_word(dev, 0x4a, &reg4a);
 			pci_write_config_word(dev, 0x4a, reg4a|u_speed);
 		}
+
+		pio = 4;
 	} else {
+		const u8 mwdma_to_pio[] = { 0, 3, 4 };
+
 		if (reg48 & u_flag)
 			pci_write_config_word(dev, 0x48, reg48 & ~u_flag);
 		if (reg4a & a_speed)
 			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
+
+		if (speed >= XFER_MW_DMA_0)
+			pio = mwdma_to_pio[speed - XFER_MW_DMA_0];
+		else
+			pio = 2; /* only SWDMA2 is allowed */
 	}
 
-	slc90e66_set_pio_mode(drive, slc90e66_dma_2_pio(speed));
+	slc90e66_set_pio_mode(drive, pio);
 }
 
 static int slc90e66_config_drive_xfer_rate (ide_drive_t *drive)
