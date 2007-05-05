From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6] hpt366: simplify UltraDMA filtering (take 2)
Date: Sun, 6 May 2007 00:24:54 +0400
Message-ID: <200705060024.54748.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:21070 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933334AbXEEUXV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 May 2007 16:23:21 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Simplify UltraDMA mode filtering in the driver:

- make use of the newly introduced 'udma_mask' field of 'ide_pci_device_t' to
  set the correct hwif->ultra_mask, modifying init_setup_hpt366() to select
  the correct mask based on the chip revision;

- replace 'max_mode' field of the 'struct hpt_info' with 'max_ultra' specifying
  the maximum UltraDMA mode allowed;

- rewrite hpt3xx_udma_filter() to differ the filters based on the 'chip_type'
  field, and only use it for HPT366 and HPT370[A] where it's really necessary.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the top of the pata-2.6. I had to change it a bit due to
a fix going in ahead. Tested on HPT370, will try to test on HPT371N later...

 drivers/ide/pci/hpt366.c |  148 +++++++++++++++++++++++++----------------------
 1 files changed, 80 insertions(+), 68 deletions(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.03	May 4, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.10	May 5, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -77,7 +77,7 @@
  *   since they may tamper with its fields
  * - prefix the driver startup messages with the real chip name
  * - claim the extra 240 bytes of I/O space for all chips
- * - optimize the rate masking/filtering and the drive list lookup code
+ * - optimize the UltraDMA filtering and the drive list lookup code
  * - use pci_get_slot() to get to the function 1 of HPT36x/374
  * - cache offset of the channel's misc. control registers (MCRs) being used
  *   throughout the driver
@@ -99,9 +99,9 @@
  *   stop duplicating it for each channel by storing the pointer in the pci_dev
  *   structure: first, at the init_setup stage, point it to a static "template"
  *   with only the chip type and its specific base DPLL frequency, the highest
- *   supported DMA mode, and the chip settings table pointer filled, then, at
- *   the init_chipset stage, allocate per-chip instance  and fill it with the
- *   rest of the necessary information
+ *   UltraDMA mode, and the chip settings table pointer filled,  then, at the
+ *   init_chipset stage, allocate per-chip instance  and fill it with the rest
+ *   of the necessary information
  * - get rid of the constant thresholds in the HPT37x PCI clock detection code,
  *   switch  to calculating  PCI clock frequency based on the chip's base DPLL
  *   frequency
@@ -111,6 +111,7 @@
  *   also fixing the interchanged 25/40 MHz PCI clock cases for HPT36x chips;
  *   unify HPT36x/37x timing setup code and the speedproc handlers by joining
  *   the register setting lists into the table indexed by the clock selected
+ * - set the correct hwif->ultra_mask for each individual chip
  *	Sergei Shtylyov, <sshtylyov@ru.mvista.com> or <source@mvista.com>
  */
 
@@ -390,7 +391,7 @@ enum ata_clock {
 
 struct hpt_info {
 	u8 chip_type;		/* Chip type */
-	u8 max_mode;		/* Speeds allowed */
+	u8 max_ultra;		/* Max. UltraDMA mode allowed */
 	u8 dpll_clk;		/* DPLL clock in MHz */
 	u8 pci_clk;		/* PCI  clock in MHz */
 	u32 **settings; 	/* Chipset settings table */
@@ -429,77 +430,77 @@ static u32 *hpt37x_settings[NUM_ATA_CLOC
 
 static struct hpt_info hpt36x __devinitdata = {
 	.chip_type	= HPT36x,
-	.max_mode	= (HPT366_ALLOW_ATA66_4 || HPT366_ALLOW_ATA66_3) ? 2 : 1,
+	.max_ultra	= HPT366_ALLOW_ATA66_3 ? (HPT366_ALLOW_ATA66_4 ? 4 : 3) : 2,
 	.dpll_clk	= 0,	/* no DPLL */
 	.settings	= hpt36x_settings
 };
 
 static struct hpt_info hpt370 __devinitdata = {
 	.chip_type	= HPT370,
-	.max_mode	= HPT370_ALLOW_ATA100_5 ? 3 : 2,
+	.max_ultra	= HPT370_ALLOW_ATA100_5 ? 5 : 4,
 	.dpll_clk	= 48,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt370a __devinitdata = {
 	.chip_type	= HPT370A,
-	.max_mode	= HPT370_ALLOW_ATA100_5 ? 3 : 2,
+	.max_ultra	= HPT370_ALLOW_ATA100_5 ? 5 : 4,
 	.dpll_clk	= 48,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt374 __devinitdata = {
 	.chip_type	= HPT374,
-	.max_mode	= HPT374_ALLOW_ATA133_6 ? 4 : 3,
+	.max_ultra	= HPT374_ALLOW_ATA133_6 ? 6 : 5,
 	.dpll_clk	= 48,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt372 __devinitdata = {
 	.chip_type	= HPT372,
-	.max_mode	= HPT372_ALLOW_ATA133_6 ? 4 : 3,
+	.max_ultra	= HPT372_ALLOW_ATA133_6 ? 6 : 5,
 	.dpll_clk	= 55,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt372a __devinitdata = {
 	.chip_type	= HPT372A,
-	.max_mode	= HPT372_ALLOW_ATA133_6 ? 4 : 3,
+	.max_ultra	= HPT372_ALLOW_ATA133_6 ? 6 : 5,
 	.dpll_clk	= 66,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt302 __devinitdata = {
 	.chip_type	= HPT302,
-	.max_mode	= HPT302_ALLOW_ATA133_6 ? 4 : 3,
+	.max_ultra	= HPT302_ALLOW_ATA133_6 ? 6 : 5,
 	.dpll_clk	= 66,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt371 __devinitdata = {
 	.chip_type	= HPT371,
-	.max_mode	= HPT371_ALLOW_ATA133_6 ? 4 : 3,
+	.max_ultra	= HPT371_ALLOW_ATA133_6 ? 6 : 5,
 	.dpll_clk	= 66,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt372n __devinitdata = {
 	.chip_type	= HPT372N,
-	.max_mode	= HPT372_ALLOW_ATA133_6 ? 4 : 3,
+	.max_ultra	= HPT372_ALLOW_ATA133_6 ? 6 : 5,
 	.dpll_clk	= 77,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt302n __devinitdata = {
 	.chip_type	= HPT302N,
-	.max_mode	= HPT302_ALLOW_ATA133_6 ? 4 : 3,
+	.max_ultra	= HPT302_ALLOW_ATA133_6 ? 6 : 5,
 	.dpll_clk	= 77,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt371n __devinitdata = {
 	.chip_type	= HPT371N,
-	.max_mode	= HPT371_ALLOW_ATA133_6 ? 4 : 3,
+	.max_ultra	= HPT371_ALLOW_ATA133_6 ? 6 : 5,
 	.dpll_clk	= 77,
 	.settings	= hpt37x_settings
 };
@@ -522,53 +523,38 @@ static int check_in_drive_list(ide_drive
 static u8 hpt3xx_udma_filter(ide_drive_t *drive)
 {
 	struct hpt_info *info	= pci_get_drvdata(HWIF(drive)->pci_dev);
-	u8 chip_type		= info->chip_type;
-	u8 mode			= info->max_mode;
 	u8 mask;
 
-	switch (mode) {
-		case 0x04:
-			mask = 0x7f;
-			break;
-		case 0x03:
+	switch (info->chip_type) {
+	case HPT370A:
+		if (!HPT370_ALLOW_ATA100_5 ||
+		    check_in_drive_list(drive, bad_ata100_5))
+			return 0x1f;
+		else
+			return 0x3f;
+	case HPT370:
+		if (!HPT370_ALLOW_ATA100_5 ||
+		    check_in_drive_list(drive, bad_ata100_5))
+			mask = 0x1f;
+		else
 			mask = 0x3f;
-			if (chip_type >= HPT374)
-				break;
-			if (!check_in_drive_list(drive, bad_ata100_5))
-				goto check_bad_ata33;
-			/* fall thru */
-		case 0x02:
+		break;
+	case HPT36x:
+		if (!HPT366_ALLOW_ATA66_4 ||
+		    check_in_drive_list(drive, bad_ata66_4))
+			mask = 0x0f;
+		else
 			mask = 0x1f;
 
-			/*
-			 * CHECK ME, Does this need to be changed to HPT374 ??
-			 */
-			if (chip_type >= HPT370)
-				goto check_bad_ata33;
-			if (HPT366_ALLOW_ATA66_4 &&
-			    !check_in_drive_list(drive, bad_ata66_4))
-				goto check_bad_ata33;
-
-			mask = 0x0f;
-			if (HPT366_ALLOW_ATA66_3 &&
-			    !check_in_drive_list(drive, bad_ata66_3))
-				goto check_bad_ata33;
-			/* fall thru */
-		case 0x01:
+		if (!HPT366_ALLOW_ATA66_3 ||
+		    check_in_drive_list(drive, bad_ata66_3))
 			mask = 0x07;
-
-		check_bad_ata33:
-			if (chip_type >= HPT370A)
-				break;
-			if (!check_in_drive_list(drive, bad_ata33))
-				break;
-			/* fall thru */
-		case 0x00:
-		default:
-			mask = 0x00;
-			break;
+		break;
+	default:
+		return 0x7f;
 	}
-	return mask;
+
+	return check_in_drive_list(drive, bad_ata33) ? 0x00 : mask;
 }
 
 static u32 get_speed_setting(u8 speed, struct hpt_info *info)
@@ -1149,7 +1135,7 @@ static unsigned int __devinit init_chips
 		  * Select 66 MHz DPLL clock only if UltraATA/133 mode is
 		  * supported/enabled, use 50 MHz DPLL clock otherwise...
 		  */
-		if (info->max_mode == 0x04) {
+		if (info->max_ultra == 6) {
 			dpll_clk = 66;
 			clock = ATA_CLOCK_66MHZ;
 		} else if (dpll_clk) {	/* HPT36x chips don't have DPLL */
@@ -1242,7 +1228,7 @@ static void __devinit init_hwif_hpt366(i
 	struct pci_dev	*dev		= hwif->pci_dev;
 	struct hpt_info *info		= pci_get_drvdata(dev);
 	int serialize			= HPT_SERIALIZE_IO;
-	u8  scr1 = 0, ata66		= (hwif->channel) ? 0x01 : 0x02;
+	u8  scr1 = 0, ata66		= hwif->channel ? 0x01 : 0x02;
 	u8  chip_type			= info->chip_type;
 	u8  new_mcr, old_mcr 		= 0;
 
@@ -1255,7 +1241,9 @@ static void __devinit init_hwif_hpt366(i
 	hwif->intrproc			= &hpt3xx_intrproc;
 	hwif->maskproc			= &hpt3xx_maskproc;
 	hwif->busproc			= &hpt3xx_busproc;
-	hwif->udma_filter		= &hpt3xx_udma_filter;
+
+	if (chip_type <= HPT370A)
+		hwif->udma_filter	= &hpt3xx_udma_filter;
 
 	/*
 	 * HPT3xxN chips have some complications:
@@ -1304,7 +1292,7 @@ static void __devinit init_hwif_hpt366(i
 		return;
 	}
 
-	hwif->ultra_mask = 0x7f;
+	hwif->ultra_mask = hwif->cds->udma_mask;
 	hwif->mwdma_mask = 0x07;
 
 	/*
@@ -1502,9 +1490,33 @@ static int __devinit init_setup_hpt366(s
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
 
-	if (rev > 6)
+	switch (rev) {
+	case 0:
+	case 1:
+	case 2:
+		/*
+		 * HPT36x chips are single channel and
+		 * do not seem to have the channel enable bit...
+		 */
+		d->channels = 1;
+		d->enablebits[0].reg = 0;
+
+		d->udma_mask = HPT366_ALLOW_ATA66_3 ?
+			      (HPT366_ALLOW_ATA66_4 ? 0x1f : 0x0f) : 0x07;
+		break;
+	case 3:
+	case 4:
+		d->udma_mask = HPT370_ALLOW_ATA100_5 ? 0x3f : 0x1f;
+		break;
+	default:
 		rev = 6;
-		
+		/* fall thru */
+	case 5:
+	case 6:
+		d->udma_mask = HPT372_ALLOW_ATA133_6 ? 0x7f : 0x3f;
+		break;
+	}
+
 	d->name = chipset_names[rev];
 
 	pci_set_drvdata(dev, info[rev]);
@@ -1512,12 +1524,7 @@ static int __devinit init_setup_hpt366(s
 	if (rev > 2)
 		goto init_single;
 
-	/*
-	 * HPT36x chips are single channel and
-	 * do not seem to have the channel enable bit...
-	 */
 	d->channels = 1;
-	d->enablebits[0].reg = 0;
 
 	if ((dev2 = pci_get_slot(dev->bus, dev->devfn + 1)) != NULL) {
 	  	u8  pin1 = 0, pin2 = 0;
@@ -1562,6 +1569,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
+		.udma_mask	= HPT372_ALLOW_ATA133_6 ? 0x7f : 0x3f,
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	},{	/* 2 */
@@ -1573,6 +1581,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
+		.udma_mask	= HPT302_ALLOW_ATA133_6 ? 0x7f : 0x3f,
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	},{	/* 3 */
@@ -1584,6 +1593,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
+		.udma_mask	= HPT371_ALLOW_ATA133_6 ? 0x7f : 0x3f,
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	},{	/* 4 */
@@ -1595,6 +1605,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.channels	= 2,	/* 4 */
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
+		.udma_mask	= HPT374_ALLOW_ATA133_6 ? 0x7f : 0x3f,
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	},{	/* 5 */
@@ -1606,6 +1617,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.channels	= 2,	/* 4 */
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
+		.udma_mask	= HPT372_ALLOW_ATA133_6 ? 0x7f : 0x3f,
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	}

