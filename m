From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/4] ide: use only ->set_pio_mode method for programming PIO modes
Date: Fri, 20 Jul 2007 12:26:13 +0200
Message-ID: <200707201226.13405.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:57100 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbXGTKJP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 06:09:15 -0400
Received: by ug-out-1314.google.com with SMTP id j3so586011ugf
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 03:09:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Use ->set_pio_mode method to program PIO modes in ide_set_xfer_rate()
(the only place which used ->speedproc to program PIO modes) and remove
handling of PIO modes from all ->speedproc implementations.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cris/ide-cris.c   |    5 -----
 drivers/ide/ide-lib.c         |   12 ++++++++++++
 drivers/ide/mips/au1xxx-ide.c |    5 -----
 drivers/ide/pci/alim15x3.c    |    5 -----
 drivers/ide/pci/atiixp.c      |    5 -----
 drivers/ide/pci/cmd64x.c      |    8 --------
 drivers/ide/pci/cs5520.c      |   36 ++++++++++++++----------------------
 drivers/ide/pci/cs5530.c      |    7 -------
 drivers/ide/pci/it8213.c      |    5 -----
 drivers/ide/pci/it821x.c      |    9 ---------
 drivers/ide/pci/piix.c        |    5 -----
 drivers/ide/pci/sc1200.c      |   10 ----------
 drivers/ide/pci/scc_pata.c    |    7 -------
 drivers/ide/pci/serverworks.c |    5 -----
 drivers/ide/pci/siimage.c     |    7 -------
 drivers/ide/pci/sis5513.c     |   12 ++----------
 drivers/ide/pci/sl82c105.c    |    8 --------
 drivers/ide/pci/slc90e66.c    |    5 -----
 drivers/ide/ppc/pmac.c        |    7 -------
 19 files changed, 28 insertions(+), 135 deletions(-)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -724,11 +724,6 @@ static int speed_cris_ide(ide_drive_t *d
 {
 	int cyc = 0, dvs = 0, strobe = 0, hold = 0;
 
-	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
-		cris_set_pio_mode(drive, speed - XFER_PIO_0);
-		return ide_config_drive_speed(drive, speed);
-	}
-
 	switch(speed)
 	{
 		case XFER_UDMA_0:
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -398,6 +398,18 @@ int ide_set_xfer_rate(ide_drive_t *drive
 
 	rate = ide_rate_filter(drive, rate);
 
+	if (rate >= XFER_PIO_0 && rate <= XFER_PIO_5) {
+		if (hwif->set_pio_mode)
+			hwif->set_pio_mode(drive, rate - XFER_PIO_0);
+
+		/*
+		 * FIXME: this incorrect to return zero here but
+		 * since all users of ide_set_xfer_rate() ignore
+		 * the return value it is not a problem currently
+		 */
+		return 0;
+	}
+
 	return hwif->speedproc(drive, rate);
 }
 
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -177,11 +177,6 @@ static int auide_tune_chipset(ide_drive_
 	mem_sttime = 0;
 	mem_stcfg  = au_readl(MEM_STCFG2);
 
-	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
-		au1xxx_set_pio_mode(drive, speed - XFER_PIO_0);
-		return 0;
-	}
-
 	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 	case XFER_MW_DMA_2:
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -421,11 +421,6 @@ static int ali15x3_tune_chipset(ide_driv
 	if (speed < XFER_PIO_0)
 		return 1;
 
-	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_5) {
-		ali_tune_pio(drive, speed - XFER_PIO_0);
-		return ide_config_drive_speed(drive, speed);
-	}
-
 	if (speed == XFER_UDMA_6)
 		speed1 = 0x47;
 
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -178,11 +178,6 @@ static int atiixp_speedproc(ide_drive_t 
 	u16 tmp16;
 	u8 pio;
 
-	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
-		atiixp_tune_pio(drive, speed - XFER_PIO_0);
-		return ide_config_drive_speed(drive, speed);
-	}
-
 	spin_lock_irqsave(&atiixp_lock, flags);
 
 	save_mdma_mode[drive->dn] = 0;
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -323,14 +323,6 @@ static int cmd64x_tune_chipset(ide_drive
 	case XFER_MW_DMA_0:
 		program_cycle_times(drive, 480, 215);
 		break;
-	case XFER_PIO_5:
-	case XFER_PIO_4:
-	case XFER_PIO_3:
-	case XFER_PIO_2:
-	case XFER_PIO_1:
-	case XFER_PIO_0:
-		cmd64x_tune_pio(drive, speed - XFER_PIO_0);
-		break;
 	default:
 		return 1;
 	}
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -66,30 +66,13 @@ static struct pio_clocks cs5520_pio_cloc
 	{1, 2, 1}
 };
 
-static int cs5520_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void cs5520_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *pdev = hwif->pci_dev;
-	int pio = speed;
-	u8 reg;
 	int controller = drive->dn > 1 ? 1 : 0;
+	u8 reg;
 
-	switch(speed)
-	{
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-			pio -= XFER_PIO_0;
-			break;
-		default:
-			pio = 0;
-			printk(KERN_ERR "cs55x0: bad ide timing.\n");
-	}
-	
-	printk("PIO clocking = %d\n", pio);
-	
 	/* FIXME: if DMA = 1 do we need to set the DMA bit here ? */
 
 	/* 8bit CAT/CRT - 8bit command timing for channel */
@@ -114,12 +97,21 @@ static int cs5520_tune_chipset(ide_drive
 	reg |= 1<<((drive->dn&1)+5);
 	outb(reg, hwif->dma_base + 0x02 + 8*controller);
 
-	return ide_config_drive_speed(drive, speed);
+	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
-static void cs5520_set_pio_mode(ide_drive_t *drive, const u8 pio)
+static int cs5520_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
-	cs5520_tune_chipset(drive, XFER_PIO_0 + pio);
+	printk(KERN_ERR "cs55x0: bad ide timing.\n");
+
+	cs5520_set_pio_mode(drive, 0);
+
+	/*
+	 * FIXME: this incorrect to return zero here but
+	 * since all users of ide_set_xfer_rate() ignore
+	 * the return value it is not a problem currently
+	 */
+	return 0;
 }
 
 static int cs5520_config_drive_xfer_rate(ide_drive_t *drive)
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -162,13 +162,6 @@ static int cs5530_tune_chipset(ide_drive
 		case XFER_MW_DMA_0:	timings = 0x00077771; break;
 		case XFER_MW_DMA_1:	timings = 0x00012121; break;
 		case XFER_MW_DMA_2:	timings = 0x00002020; break;
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-			cs5530_tunepio(drive, mode - XFER_PIO_0);
-			return 0;
 		default:
 			BUG();
 			break;
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -134,11 +134,6 @@ static int it8213_tune_chipset(ide_drive
 	u16			reg4042, reg4a;
 	u8			reg48, reg54, reg55;
 
-	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
-		it8213_tune_pio(drive, speed - XFER_PIO_0);
-		return ide_config_drive_speed(drive, speed);
-	}
-
 	pci_read_config_word(dev, maslave, &reg4042);
 	pci_read_config_byte(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -418,15 +418,6 @@ static int it821x_tune_chipset(ide_drive
 	ide_hwif_t *hwif	= drive->hwif;
 	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
 
-	switch (speed) {
-	case XFER_PIO_4:
-	case XFER_PIO_3:
-	case XFER_PIO_2:
-	case XFER_PIO_1:
-	case XFER_PIO_0:
-		return it821x_tunepio(drive, speed - XFER_PIO_0);
-	}
-
 	if (itdev->smart == 0) {
 		switch (speed) {
 			/* MWDMA tuning is really hard because our MWDMA and PIO
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -243,11 +243,6 @@ static int piix_tune_chipset(ide_drive_t
 	u16			reg4042, reg4a;
 	u8			reg48, reg54, reg55;
 
-	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
-		piix_tune_pio(drive, speed - XFER_PIO_0);
-		return ide_config_drive_speed(drive, speed);
-	}
-
 	pci_read_config_word(dev, maslave, &reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
 	pci_read_config_byte(dev, 0x48, &reg48);
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -152,16 +152,6 @@ static int sc1200_tune_chipset(ide_drive
 	if (sc1200_set_xfer_mode(drive, mode))
 		return 1;	/* failure */
 
-	switch (mode) {
-	case XFER_PIO_4:
-	case XFER_PIO_3:
-	case XFER_PIO_2:
-	case XFER_PIO_1:
-	case XFER_PIO_0:
-		sc1200_tunepio(drive, mode - XFER_PIO_0);
-		return 0;
-	}
-
 	pci_clock = sc1200_get_pci_clock();
 
 	/*
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -270,13 +270,6 @@ static int scc_tune_chipset(ide_drive_t 
 	case XFER_UDMA_0:
 		idx = speed - XFER_UDMA_0;
 		break;
-	case XFER_PIO_4:
-	case XFER_PIO_3:
-	case XFER_PIO_2:
-	case XFER_PIO_1:
-	case XFER_PIO_0:
-		scc_tune_pio(drive, speed - XFER_PIO_0);
-		return ide_config_drive_speed(drive, speed);
 	default:
 		return 1;
 	}
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -157,11 +157,6 @@ static int svwks_tune_chipset(ide_drive_
 
 	u8 ultra_enable	 = 0, ultra_timing = 0, dma_timing = 0;
 
-	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
-		svwks_tune_pio(drive, speed - XFER_PIO_0);
-		return ide_config_drive_speed(drive, speed);
-	}
-
 	/* If we are about to put a disk into UDMA mode we screwed up.
 	   Our code assumes we never _ever_ do this on an OSB4 */
 	   
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -284,13 +284,6 @@ static int siimage_tune_chipset(ide_driv
 	scsc = is_sata(hwif) ? 1 : scsc;
 
 	switch(speed) {
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-			sil_tune_pio(drive, speed - XFER_PIO_0);
-			return ide_config_drive_speed(drive, speed);
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_MW_DMA_0:
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -519,15 +519,10 @@ static void config_art_rwp_pio (ide_driv
 	}
 }
 
-static int sis5513_tune_drive(ide_drive_t *drive, const u8 pio)
-{
-	config_art_rwp_pio(drive, pio);
-	return ide_config_drive_speed(drive, XFER_PIO_0 + pio);
-}
-
 static void sis_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	(void)sis5513_tune_drive(drive, pio);
+	config_art_rwp_pio(drive, pio);
+	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 static int sis5513_tune_chipset(ide_drive_t *drive, const u8 speed)
@@ -537,9 +532,6 @@ static int sis5513_tune_chipset(ide_driv
 	u32 regdw;
 	u8 drive_pci, reg;
 
-	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4)
-		return sis5513_tune_drive(drive, speed - XFER_PIO_0);
-
 	/* See config_art_rwp_pio for drive pci config registers */
 	drive_pci = 0x40;
 	if (chipset_family >= ATA_133) {
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -139,14 +139,6 @@ static int sl82c105_tune_chipset(ide_dri
 			pci_write_config_word(dev, reg, drv_ctrl);
 		}
 		break;
-	case XFER_PIO_5:
-	case XFER_PIO_4:
-	case XFER_PIO_3:
-	case XFER_PIO_2:
-	case XFER_PIO_1:
-	case XFER_PIO_0:
-		sl82c105_tune_pio(drive, speed - XFER_PIO_0);
-		break;
 	default:
 		return -1;
 	}
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -110,11 +110,6 @@ static int slc90e66_tune_chipset(ide_dri
 	int u_speed = 0, u_flag = 1 << drive->dn;
 	u16			reg4042, reg44, reg48, reg4a;
 
-	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
-		slc90e66_tune_pio(drive, speed - XFER_PIO_0);
-		return ide_config_drive_speed(drive, speed);
-	}
-
 	pci_read_config_word(dev, maslave, &reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
 	pci_read_config_word(dev, 0x44, &reg44);
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -957,13 +957,6 @@ static int pmac_ide_tune_chipset(ide_dri
 		case XFER_SW_DMA_0:
 			return 1;
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-			pmac_ide_set_pio_mode(drive, speed & 0x07);
-			return 0;
 		default:
 			ret = 1;
 	}
