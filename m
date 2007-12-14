From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6] hpt366: merge set_dma_mode() methods
Date: Fri, 14 Dec 2007 21:46:31 +0300
Message-ID: <200712142146.31984.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:9036 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752811AbXLNSqO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 13:46:14 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Group the array of pointers to the timing tables with the timing register masks
which allows us to merge HPT36x/HPT37x set_dma_mode() methods into one.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the pata-2.6 patchset...

 drivers/ide/pci/hpt366.c |  129 +++++++++++++++++++++--------------------------
 1 files changed, 58 insertions(+), 71 deletions(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.24	Dec 8, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.30	Dec 12, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -88,7 +88,7 @@
  * - rename all the register related variables consistently
  * - move all the interrupt twiddling code from the speedproc handlers into
  *   init_hwif_hpt366(), also grouping all the DMA related code together there
- * - merge two HPT37x speedproc handlers, fix the PIO timing register mask and
+ * - merge HPT36x/HPT37x speedproc handlers, fix PIO timing register mask and
  *   separate the UltraDMA and MWDMA masks there to avoid changing PIO timings
  *   when setting an UltraDMA mode
  * - fix hpt3xx_tune_drive() to set the PIO mode requested, not always select
@@ -458,6 +458,13 @@ enum ata_clock {
 	NUM_ATA_CLOCKS
 };
 
+struct hpt_timings {
+	u32 pio_mask;
+	u32 dma_mask;
+	u32 ultra_mask;
+	u32 *clock_table[NUM_ATA_CLOCKS];
+};
+
 /*
  *	Hold all the HighPoint chip information in one place.
  */
@@ -468,7 +475,8 @@ struct hpt_info {
 	u8 udma_mask;		/* Allowed UltraDMA modes mask. */
 	u8 dpll_clk;		/* DPLL clock in MHz */
 	u8 pci_clk;		/* PCI  clock in MHz */
-	u32 **settings; 	/* Chipset settings table */
+	struct hpt_timings *timings; /* Chipset timing data */
+	u8 clock;		/* ATA clock selected */
 };
 
 /* Supported HighPoint chips */
@@ -486,20 +494,30 @@ enum {
 	HPT371N
 };
 
-static u32 *hpt36x_settings[NUM_ATA_CLOCKS] = {
-	twenty_five_base_hpt36x,
-	thirty_three_base_hpt36x,
-	forty_base_hpt36x,
-	NULL,
-	NULL
+static struct hpt_timings hpt36x_timings = {
+	.pio_mask	= 0xc1f8ffff,
+	.dma_mask	= 0x303800ff,
+	.ultra_mask	= 0x30070000,
+	.clock_table	= {
+		[ATA_CLOCK_25MHZ] = twenty_five_base_hpt36x,
+		[ATA_CLOCK_33MHZ] = thirty_three_base_hpt36x,
+		[ATA_CLOCK_40MHZ] = forty_base_hpt36x,
+		[ATA_CLOCK_50MHZ] = NULL,
+		[ATA_CLOCK_66MHZ] = NULL
+	}
 };
 
-static u32 *hpt37x_settings[NUM_ATA_CLOCKS] = {
-	NULL,
-	thirty_three_base_hpt37x,
-	NULL,
-	fifty_base_hpt37x,
-	sixty_six_base_hpt37x
+static struct hpt_timings hpt37x_timings = {
+	.pio_mask	= 0xcfc3ffff,
+	.dma_mask	= 0x31c001ff,
+	.ultra_mask	= 0x303c0000,
+	.clock_table	= {
+		[ATA_CLOCK_25MHZ] = NULL,
+		[ATA_CLOCK_33MHZ] = thirty_three_base_hpt37x,
+		[ATA_CLOCK_40MHZ] = NULL,
+		[ATA_CLOCK_50MHZ] = fifty_base_hpt37x,
+		[ATA_CLOCK_66MHZ] = sixty_six_base_hpt37x
+	}
 };
 
 static const struct hpt_info hpt36x __devinitdata = {
@@ -507,7 +525,7 @@ static const struct hpt_info hpt36x __de
 	.chip_type	= HPT36x,
 	.udma_mask	= HPT366_ALLOW_ATA66_3 ? (HPT366_ALLOW_ATA66_4 ? ATA_UDMA4 : ATA_UDMA3) : ATA_UDMA2,
 	.dpll_clk	= 0,	/* no DPLL */
-	.settings	= hpt36x_settings
+	.timings	= &hpt36x_timings
 };
 
 static const struct hpt_info hpt370 __devinitdata = {
@@ -515,7 +533,7 @@ static const struct hpt_info hpt370 __de
 	.chip_type	= HPT370,
 	.udma_mask	= HPT370_ALLOW_ATA100_5 ? ATA_UDMA5 : ATA_UDMA4,
 	.dpll_clk	= 48,
-	.settings	= hpt37x_settings
+	.timings	= &hpt37x_timings
 };
 
 static const struct hpt_info hpt370a __devinitdata = {
@@ -523,7 +541,7 @@ static const struct hpt_info hpt370a __d
 	.chip_type	= HPT370A,
 	.udma_mask	= HPT370_ALLOW_ATA100_5 ? ATA_UDMA5 : ATA_UDMA4,
 	.dpll_clk	= 48,
-	.settings	= hpt37x_settings
+	.timings	= &hpt37x_timings
 };
 
 static const struct hpt_info hpt374 __devinitdata = {
@@ -531,7 +549,7 @@ static const struct hpt_info hpt374 __de
 	.chip_type	= HPT374,
 	.udma_mask	= ATA_UDMA5,
 	.dpll_clk	= 48,
-	.settings	= hpt37x_settings
+	.timings	= &hpt37x_timings
 };
 
 static const struct hpt_info hpt372 __devinitdata = {
@@ -539,7 +557,7 @@ static const struct hpt_info hpt372 __de
 	.chip_type	= HPT372,
 	.udma_mask	= HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 55,
-	.settings	= hpt37x_settings
+	.timings	= &hpt37x_timings
 };
 
 static const struct hpt_info hpt372a __devinitdata = {
@@ -547,7 +565,7 @@ static const struct hpt_info hpt372a __d
 	.chip_type	= HPT372A,
 	.udma_mask	= HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 66,
-	.settings	= hpt37x_settings
+	.timings	= &hpt37x_timings
 };
 
 static const struct hpt_info hpt302 __devinitdata = {
@@ -555,7 +573,7 @@ static const struct hpt_info hpt302 __de
 	.chip_type	= HPT302,
 	.udma_mask	= HPT302_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 66,
-	.settings	= hpt37x_settings
+	.timings	= &hpt37x_timings
 };
 
 static const struct hpt_info hpt371 __devinitdata = {
@@ -563,7 +581,7 @@ static const struct hpt_info hpt371 __de
 	.chip_type	= HPT371,
 	.udma_mask	= HPT371_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 66,
-	.settings	= hpt37x_settings
+	.timings	= &hpt37x_timings
 };
 
 static const struct hpt_info hpt372n __devinitdata = {
@@ -571,7 +589,7 @@ static const struct hpt_info hpt372n __d
 	.chip_type	= HPT372N,
 	.udma_mask	= HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 77,
-	.settings	= hpt37x_settings
+	.timings	= &hpt37x_timings
 };
 
 static const struct hpt_info hpt302n __devinitdata = {
@@ -579,7 +597,7 @@ static const struct hpt_info hpt302n __d
 	.chip_type	= HPT302N,
 	.udma_mask	= HPT302_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 77,
-	.settings	= hpt37x_settings
+	.timings	= &hpt37x_timings
 };
 
 static const struct hpt_info hpt371n __devinitdata = {
@@ -587,7 +605,7 @@ static const struct hpt_info hpt371n __d
 	.chip_type	= HPT371N,
 	.udma_mask	= HPT371_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 77,
-	.settings	= hpt37x_settings
+	.timings	= &hpt37x_timings
 };
 
 static int check_in_drive_list(ide_drive_t *drive, const char **list)
@@ -675,24 +693,21 @@ static u32 get_speed_setting(u8 speed, s
 	for (i = 0; i < ARRAY_SIZE(xfer_speeds) - 1; i++)
 		if (xfer_speeds[i] == speed)
 			break;
-	/*
-	 * NOTE: info->settings only points to the pointer
-	 * to the list of the actual register values
-	 */
-	return (*info->settings)[i];
+
+	return info->timings->clock_table[info->clock][i];
 }
 
-static void hpt36x_set_mode(ide_drive_t *drive, const u8 speed)
+static void hpt3xx_set_mode(ide_drive_t *drive, const u8 speed)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev  *dev	= hwif->pci_dev;
+	struct pci_dev  *dev	= HWIF(drive)->pci_dev;
 	struct hpt_info	*info	= pci_get_drvdata(dev);
-	u8  itr_addr		= drive->dn ? 0x44 : 0x40;
+	struct hpt_timings *t	= info->timings;
+	u8  itr_addr		= 0x40 + (drive->dn * 4);
 	u32 old_itr		= 0;
 	u32 new_itr		= get_speed_setting(speed, info);
-	u32 itr_mask		= speed < XFER_MW_DMA_0 ? 0xc1f8ffff :
-				 (speed < XFER_UDMA_0   ? 0x303800ff :
-							  0x30070000);
+	u32 itr_mask		= speed < XFER_MW_DMA_0 ? t->pio_mask :
+				 (speed < XFER_UDMA_0   ? t->dma_mask :
+							  t->ultra_mask);
 
 	pci_read_config_dword(dev, itr_addr, &old_itr);
 	new_itr = (old_itr & ~itr_mask) | (new_itr & itr_mask);
@@ -705,29 +720,9 @@ static void hpt36x_set_mode(ide_drive_t 
 	pci_write_config_dword(dev, itr_addr, new_itr);
 }
 
-static void hpt37x_set_mode(ide_drive_t *drive, const u8 speed)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev  *dev	= hwif->pci_dev;
-	struct hpt_info	*info	= pci_get_drvdata(dev);
-	u8  itr_addr		= 0x40 + (drive->dn * 4);
-	u32 old_itr		= 0;
-	u32 new_itr		= get_speed_setting(speed, info);
-	u32 itr_mask		= speed < XFER_MW_DMA_0 ? 0xcfc3ffff :
-				 (speed < XFER_UDMA_0   ? 0x31c001ff :
-				 			  0x303c0000);
-
-	pci_read_config_dword(dev, itr_addr, &old_itr);
-	new_itr = (old_itr & ~itr_mask) | (new_itr & itr_mask);
-
-	if (speed < XFER_MW_DMA_0)
-		new_itr &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
-	pci_write_config_dword(dev, itr_addr, new_itr);
-}
-
 static void hpt3xx_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	HWIF(drive)->set_dma_mode(drive, XFER_PIO_0 + pio);
+	hpt3xx_set_mode(drive, XFER_PIO_0 + pio);
 }
 
 static void hpt3xx_quirkproc(ide_drive_t *drive)
@@ -1190,7 +1185,7 @@ static unsigned int __devinit init_chips
 	 * We also  don't like using  the DPLL because this causes glitches
 	 * on PRST-/SRST- when the state engine gets reset...
 	 */
-	if (chip_type >= HPT374 || info->settings[clock] == NULL) {
+	if (chip_type >= HPT374 || info->timings->clock_table[clock] == NULL) {
 		u16 f_low, delta = pci_clk < 50 ? 2 : 4;
 		int adjust;
 
@@ -1206,7 +1201,7 @@ static unsigned int __devinit init_chips
 			clock = ATA_CLOCK_50MHZ;
 		}
 
-		if (info->settings[clock] == NULL) {
+		if (info->timings->clock_table[clock] == NULL) {
 			printk(KERN_ERR "%s: unknown bus timing!\n", name);
 			kfree(info);
 			return -EIO;
@@ -1247,15 +1242,10 @@ static unsigned int __devinit init_chips
 		printk("%s: using %d MHz PCI clock\n", name, pci_clk);
 	}
 
-	/*
-	 * Advance the table pointer to a slot which points to the list
-	 * of the register values settings matching the clock being used.
-	 */
-	info->settings += clock;
-
 	/* Store the clock frequencies. */
 	info->dpll_clk	= dpll_clk;
 	info->pci_clk	= pci_clk;
+	info->clock	= clock;
 
 	/* Point to this chip's own instance of the hpt_info structure. */
 	pci_set_drvdata(dev, info);
@@ -1299,10 +1289,7 @@ static void __devinit init_hwif_hpt366(i
 	hwif->select_data	= hwif->channel ? 0x54 : 0x50;
 
 	hwif->set_pio_mode	= &hpt3xx_set_pio_mode;
-	if (chip_type >= HPT370)
-		hwif->set_dma_mode = &hpt37x_set_mode;
-	else
-		hwif->set_dma_mode = &hpt36x_set_mode;
+	hwif->set_dma_mode	= &hpt3xx_set_mode;
 
 	hwif->quirkproc		= &hpt3xx_quirkproc;
 	hwif->maskproc		= &hpt3xx_maskproc;

