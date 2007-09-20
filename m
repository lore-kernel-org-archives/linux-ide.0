From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove ->ide_dma_check (take 2)
Date: Fri, 21 Sep 2007 01:18:27 +0200
Message-ID: <200709210118.28047.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:60052 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbXITXR2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 19:17:28 -0400
Received: by nf-out-0910.google.com with SMTP id g13so609643nfb
        for <linux-ide@vger.kernel.org>; Thu, 20 Sep 2007 16:17:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


* Add IDE_HFLAG_TRUST_BIOS_FOR_DMA host flag for host drivers that depend
  on BIOS for programming device/controller for DMA.  Set it in cy82c693,
  generic, ns87415, opti621 and trm290 host drivers.

* Add IDE_HFLAG_VDMA host flag for host drivers using VDMA.  Set it in cs5520
  host driver.

* Teach ide_tune_dma() about IDE_HFLAG_TRUST_BIOS_FOR_DMA flag.

* Add generic ide_dma_check() helper and remove all open coded ->ide_dma_check
  implementations.  Fix all places checking for presence of ->ide_dma_check
  hook to check for ->ide_dma_on instead.

* Remove no longer needed code from config_drive_for_dma().

* Make ide_tune_dma() static.

v2:
* Fix config_drive_for_dma() return values.

* Fix ide-dma.c build for CONFIG_BLK_DEV_IDEDMA_PCI=n by adding
  dummy config_drive_for_dma() inline.

* Fix IDE_HFLAG_TRUST_BIOS_FOR_DMA handling in ide_dma_check().

* Fix init_hwif_it8213() comment.

There should be no functionality changes caused by this patch.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
replacement patch for the one currently in IDE quilt tree

Sergei: re-review is needed

 drivers/ide/arm/icside.c       |    9 -----
 drivers/ide/cris/ide-cris.c    |   12 ------
 drivers/ide/ide-dma.c          |   73 ++++++++++++++++++++++++-----------------
 drivers/ide/ide-io.c           |    4 +-
 drivers/ide/ide-iops.c         |    4 +-
 drivers/ide/ide-probe.c        |    2 -
 drivers/ide/ide.c              |    3 -
 drivers/ide/mips/au1xxx-ide.c  |   11 ------
 drivers/ide/pci/aec62xx.c      |   11 ------
 drivers/ide/pci/alim15x3.c     |   19 ----------
 drivers/ide/pci/amd74xx.c      |   11 ------
 drivers/ide/pci/atiixp.c       |   20 -----------
 drivers/ide/pci/cmd64x.c       |   12 ------
 drivers/ide/pci/cs5520.c       |   13 +------
 drivers/ide/pci/cs5530.c       |   20 -----------
 drivers/ide/pci/cs5535.c       |   12 ------
 drivers/ide/pci/cy82c693.c     |    2 -
 drivers/ide/pci/generic.c      |   15 ++++++++
 drivers/ide/pci/hpt34x.c       |   11 ------
 drivers/ide/pci/hpt366.c       |   12 ------
 drivers/ide/pci/it8213.c       |   26 --------------
 drivers/ide/pci/it821x.c       |   22 ------------
 drivers/ide/pci/jmicron.c      |   20 -----------
 drivers/ide/pci/ns87415.c      |    1 
 drivers/ide/pci/opti621.c      |    2 +
 drivers/ide/pci/pdc202xx_new.c |   12 ------
 drivers/ide/pci/pdc202xx_old.c |   11 ------
 drivers/ide/pci/piix.c         |   19 ----------
 drivers/ide/pci/sc1200.c       |   16 --------
 drivers/ide/pci/scc_pata.c     |   22 ------------
 drivers/ide/pci/serverworks.c  |   11 ------
 drivers/ide/pci/sgiioc4.c      |   15 --------
 drivers/ide/pci/siimage.c      |   22 ------------
 drivers/ide/pci/sis5513.c      |   12 ------
 drivers/ide/pci/sl82c105.c     |   16 --------
 drivers/ide/pci/slc90e66.c     |   12 ------
 drivers/ide/pci/tc86c001.c     |   11 ------
 drivers/ide/pci/triflex.c      |   11 ------
 drivers/ide/pci/trm290.c       |    1 
 drivers/ide/pci/via82cxxx.c    |   19 ----------
 drivers/ide/ppc/pmac.c         |   16 --------
 include/linux/ide.h            |    7 ++-
 42 files changed, 79 insertions(+), 501 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -309,14 +309,6 @@ static int icside_dma_on(ide_drive_t *dr
 	return 0;
 }
 
-static int icside_dma_check(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	return -1;
-}
-
 static int icside_dma_end(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -434,7 +426,6 @@ static void icside_dma_init(ide_hwif_t *
 	hwif->set_dma_mode	= icside_set_dma_mode;
 	hwif->autodma		= 1;
 
-	hwif->ide_dma_check	= icside_dma_check;
 	hwif->dma_host_off	= icside_dma_host_off;
 	hwif->dma_off_quietly	= icside_dma_off_quietly;
 	hwif->dma_host_on	= icside_dma_host_on;
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -664,7 +664,6 @@ cris_ide_inb(unsigned long reg)
 	return (unsigned char)cris_ide_inw(reg);
 }
 
-static int cris_dma_check (ide_drive_t *drive);
 static int cris_dma_end (ide_drive_t *drive);
 static int cris_dma_setup (ide_drive_t *drive);
 static void cris_dma_exec_cmd (ide_drive_t *drive, u8 command);
@@ -792,7 +791,6 @@ init_e100_ide (void)
 		hwif->ata_output_data = &cris_ide_output_data;
 		hwif->atapi_input_bytes = &cris_atapi_input_bytes;
 		hwif->atapi_output_bytes = &cris_atapi_output_bytes;
-		hwif->ide_dma_check = &cris_dma_check;
 		hwif->ide_dma_end = &cris_dma_end;
 		hwif->dma_setup = &cris_dma_setup;
 		hwif->dma_exec_cmd = &cris_dma_exec_cmd;
@@ -1019,16 +1017,6 @@ static ide_startstop_t cris_dma_intr (id
  * the caller should revert to PIO for the current request.
  */
 
-static int cris_dma_check(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static int cris_dma_end(ide_drive_t *drive)
 {
 	drive->waiting_for_dma = 0;
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -338,35 +338,30 @@ static int config_drive_for_dma (ide_dri
 	ide_hwif_t *hwif = drive->hwif;
 	struct hd_driveid *id = drive->id;
 
-	/* consult the list of known "bad" drives */
-	if (__ide_dma_bad_drive(drive))
-		return -1;
-
 	if (drive->media != ide_disk && hwif->atapi_dma == 0)
-		return -1;
+		return 0;
 
-	if ((id->capability & 1) && drive->autodma) {
-		/*
-		 * Enable DMA on any drive that has
-		 * UltraDMA (mode 0/1/2/3/4/5/6) enabled
-		 */
-		if ((id->field_valid & 4) && ((id->dma_ultra >> 8) & 0x7f))
-			return 0;
-		/*
-		 * Enable DMA on any drive that has mode2 DMA
-		 * (multi or single) enabled
-		 */
-		if (id->field_valid & 2)	/* regular DMA */
-			if ((id->dma_mword & 0x404) == 0x404 ||
-			    (id->dma_1word & 0x404) == 0x404)
-				return 0;
+	/*
+	 * Enable DMA on any drive that has
+	 * UltraDMA (mode 0/1/2/3/4/5/6) enabled
+	 */
+	if ((id->field_valid & 4) && ((id->dma_ultra >> 8) & 0x7f))
+		return 1;
 
-		/* Consult the list of known "good" drives */
-		if (ide_dma_good_drive(drive))
-			return 0;
-	}
+	/*
+	 * Enable DMA on any drive that has mode2 DMA
+	 * (multi or single) enabled
+	 */
+	if (id->field_valid & 2)	/* regular DMA */
+		if ((id->dma_mword & 0x404) == 0x404 ||
+		    (id->dma_1word & 0x404) == 0x404)
+			return 1;
 
-	return -1;
+	/* Consult the list of known "good" drives */
+	if (ide_dma_good_drive(drive))
+		return 1;
+
+	return 0;
 }
 
 /**
@@ -627,6 +622,8 @@ static int __ide_dma_test_irq(ide_drive_
 			drive->name, __FUNCTION__);
 	return 0;
 }
+#else
+static inline int config_drive_for_dma(ide_drive_t *drive) { return 0; }
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 int __ide_dma_bad_drive (ide_drive_t *drive)
@@ -756,7 +753,7 @@ u8 ide_find_dma_mode(ide_drive_t *drive,
 
 EXPORT_SYMBOL_GPL(ide_find_dma_mode);
 
-int ide_tune_dma(ide_drive_t *drive)
+static int ide_tune_dma(ide_drive_t *drive)
 {
 	u8 speed;
 
@@ -767,6 +764,9 @@ int ide_tune_dma(ide_drive_t *drive)
 	if (__ide_dma_bad_drive(drive))
 		return 0;
 
+	if (drive->hwif->host_flags & IDE_HFLAG_TRUST_BIOS_FOR_DMA)
+		return config_drive_for_dma(drive);
+
 	speed = ide_max_dma_mode(drive);
 
 	if (!speed)
@@ -783,6 +783,23 @@ int ide_tune_dma(ide_drive_t *drive)
 
 EXPORT_SYMBOL_GPL(ide_tune_dma);
 
+static int ide_dma_check(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	int vdma = (hwif->host_flags & IDE_HFLAG_VDMA)? 1 : 0;
+
+	if (!vdma && ide_tune_dma(drive))
+		return 0;
+
+	/* TODO: always do PIO fallback */
+	if (hwif->host_flags & IDE_HFLAG_TRUST_BIOS_FOR_DMA)
+		return -1;
+
+	ide_set_max_pio(drive);
+
+	return vdma ? 0 : -1;
+}
+
 void ide_dma_verbose(ide_drive_t *drive)
 {
 	struct hd_driveid *id	= drive->id;
@@ -840,7 +857,7 @@ int ide_set_dma(ide_drive_t *drive)
 	ide_hwif_t *hwif = drive->hwif;
 	int rc;
 
-	rc = hwif->ide_dma_check(drive);
+	rc = ide_dma_check(drive);
 
 	switch(rc) {
 	case -1: /* DMA needs to be disabled */
@@ -1017,8 +1034,6 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		hwif->ide_dma_on = &__ide_dma_on;
 	if (!hwif->dma_host_on)
 		hwif->dma_host_on = &ide_dma_host_on;
-	if (!hwif->ide_dma_check)
-		hwif->ide_dma_check = &config_drive_for_dma;
 	if (!hwif->dma_setup)
 		hwif->dma_setup = &ide_dma_setup;
 	if (!hwif->dma_exec_cmd)
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -219,11 +219,11 @@ static ide_startstop_t ide_start_power_s
 
 	case ide_pm_restore_dma:	/* Resume step 3 (restore DMA) */
 		/*
-		 * Right now, all we do is call hwif->ide_dma_check(drive),
+		 * Right now, all we do is call ide_set_dma(drive),
 		 * we could be smarter and check for current xfer_speed
 		 * in struct drive etc...
 		 */
-		if (drive->hwif->ide_dma_check == NULL)
+		if (drive->hwif->ide_dma_on == NULL)
 			break;
 		drive->hwif->dma_off_quietly(drive);
 		/*
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -776,7 +776,7 @@ int ide_config_drive_speed(ide_drive_t *
 //		msleep(50);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (hwif->ide_dma_check)	 /* check if host supports DMA */
+	if (hwif->ide_dma_on)	/* check if host supports DMA */
 		hwif->dma_host_off(drive);
 #endif
 
@@ -830,7 +830,7 @@ int ide_config_drive_speed(ide_drive_t *
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (speed >= XFER_SW_DMA_0)
 		hwif->dma_host_on(drive);
-	else if (hwif->ide_dma_check)	/* check if host supports DMA */
+	else if (hwif->ide_dma_on)	/* check if host supports DMA */
 		hwif->dma_off_quietly(drive);
 #endif
 
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -844,7 +844,7 @@ static void probe_hwif(ide_hwif_t *hwif,
 			 * Move here to prevent module loading clashing.
 			 */
 	//		drive->autodma = hwif->autodma;
-			if (hwif->ide_dma_check) {
+			if (hwif->ide_dma_on) {
 				/*
 				 * Force DMAing for the beginning of the check.
 				 * Some chipsets appear to do interesting
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -418,7 +418,6 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->dma_exec_cmd		= tmp_hwif->dma_exec_cmd;
 	hwif->dma_start			= tmp_hwif->dma_start;
 	hwif->ide_dma_end		= tmp_hwif->ide_dma_end;
-	hwif->ide_dma_check		= tmp_hwif->ide_dma_check;
 	hwif->ide_dma_on		= tmp_hwif->ide_dma_on;
 	hwif->dma_off_quietly		= tmp_hwif->dma_off_quietly;
 	hwif->ide_dma_test_irq		= tmp_hwif->ide_dma_test_irq;
@@ -823,7 +822,7 @@ int set_using_dma(ide_drive_t *drive, in
 	if (!drive->id || !(drive->id->capability & 1))
 		goto out;
 
-	if (hwif->ide_dma_check == NULL)
+	if (hwif->ide_dma_on == NULL)
 		goto out;
 
 	err = -EBUSY;
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -380,16 +380,6 @@ static u8 auide_mdma_filter(ide_drive_t 
 	return drive->hwif->mwdma_mask;
 }
 
-static int auide_dma_check(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static int auide_dma_test_irq(ide_drive_t *drive)
 {	
 	if (drive->waiting_for_dma == 0)
@@ -700,7 +690,6 @@ static int au_ide_probe(struct device *d
 
 	hwif->mdma_filter		= &auide_mdma_filter;
 
-	hwif->ide_dma_check             = &auide_dma_check;
 	hwif->dma_exec_cmd              = &auide_dma_exec_cmd;
 	hwif->dma_start                 = &auide_dma_start;
 	hwif->ide_dma_end               = &auide_dma_end;
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -141,16 +141,6 @@ static void aec_set_pio_mode(ide_drive_t
 	drive->hwif->set_dma_mode(drive, pio + XFER_PIO_0);
 }
 
-static int aec62xx_config_drive_xfer_rate (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static void aec62xx_dma_lost_irq (ide_drive_t *drive)
 {
 	switch (HWIF(drive)->pci_dev->device) {
@@ -214,7 +204,6 @@ static void __devinit init_hwif_aec62xx(
 	hwif->ultra_mask = hwif->cds->udma_mask;
 	hwif->mwdma_mask = 0x07;
 
-	hwif->ide_dma_check	= &aec62xx_config_drive_xfer_rate;
 	hwif->dma_lost_irq	= &aec62xx_dma_lost_irq;
 
 	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -437,24 +437,6 @@ static void ali_set_dma_mode(ide_drive_t
 }
 
 /**
- *	ali15x3_config_drive_for_dma	-	configure for DMA
- *	@drive: drive to configure
- *
- *	Configure a drive for DMA operation. If DMA is not possible we
- *	drop the drive into PIO mode instead.
- */
-
-static int ali15x3_config_drive_for_dma(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
-/**
  *	ali15x3_dma_setup	-	begin a DMA phase
  *	@drive:	target device
  *
@@ -713,7 +695,6 @@ static void __devinit init_hwif_common_a
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
-	hwif->ide_dma_check = &ali15x3_config_drive_for_dma;
 	hwif->dma_setup = &ali15x3_dma_setup;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -264,16 +264,6 @@ static void amd_set_pio_mode(ide_drive_t
 	amd_set_drive(drive, XFER_PIO_0 + pio);
 }
 
-static int amd74xx_ide_dma_check(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 /*
  * The initialization callback. Here we determine the IDE chip type
  * and initialize its drive independent registers.
@@ -415,7 +405,6 @@ static void __devinit init_hwif_amd74xx(
 			hwif->cbl = ATA_CBL_PATA40;
 	}
 
-        hwif->ide_dma_check = &amd74xx_ide_dma_check;
         if (!noautodma)
                 hwif->autodma = 1;
         hwif->drives[0].autodma = hwif->autodma;
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -159,24 +159,6 @@ static void atiixp_set_dma_mode(ide_driv
 }
 
 /**
- *	atiixp_dma_check	-	set up an IDE device
- *	@drive: IDE drive to configure
- *
- *	Set up the ATIIXP interface for the best available speed on this
- *	interface, preferring DMA to PIO.
- */
-
-static int atiixp_dma_check(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
-/**
  *	init_hwif_atiixp		-	fill in the hwif for the ATIIXP
  *	@hwif: IDE interface
  *
@@ -215,7 +197,7 @@ static void __devinit init_hwif_atiixp(i
 
 	hwif->dma_host_on = &atiixp_dma_host_on;
 	hwif->dma_host_off = &atiixp_dma_host_off;
-	hwif->ide_dma_check = &atiixp_dma_check;
+
 	if (!noautodma)
 		hwif->autodma = 1;
 
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -330,16 +330,6 @@ static void cmd64x_set_dma_mode(ide_driv
 		(void) pci_write_config_byte(dev, pciU, regU);
 }
 
-static int cmd64x_config_drive_for_dma (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static int cmd648_ide_dma_end (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -546,8 +536,6 @@ static void __devinit init_hwif_cmd64x(i
 	if (dev->device == PCI_DEVICE_ID_CMD_646 && rev < 5)
 		hwif->ultra_mask = 0x00;
 
-	hwif->ide_dma_check = &cmd64x_config_drive_for_dma;
-
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_cmd64x(hwif);
 
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -105,15 +105,6 @@ static void cs5520_set_dma_mode(ide_driv
 	cs5520_set_pio_mode(drive, 0);
 }
 
-static int cs5520_config_drive_xfer_rate(ide_drive_t *drive)
-{
-	/* Tune the drive for PIO modes up to PIO 4 */	
-	ide_set_max_pio(drive);
-
-	/* Then tell the core to use DMA operations */
-	return 0;
-}
-
 /*
  *	We provide a callback for our nonstandard DMA location
  */
@@ -148,7 +139,6 @@ static void __devinit init_hwif_cs5520(i
 		return;
 	}
 
-	hwif->ide_dma_check = &cs5520_config_drive_xfer_rate;
 	hwif->ide_dma_on = &cs5520_dma_on;
 
 	/* ATAPI is harder so leave it for now */
@@ -171,7 +161,8 @@ static void __devinit init_hwif_cs5520(i
 		.init_hwif	= init_hwif_cs5520,		\
 		.autodma	= AUTODMA,			\
 		.bootable	= ON_BOARD,			\
-		.host_flags	= IDE_HFLAG_ISA_PORTS,		\
+		.host_flags	= IDE_HFLAG_ISA_PORTS |		\
+				  IDE_HFLAG_VDMA,		\
 		.pio_mask	= ATA_PIO4,			\
 	}
 
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -104,24 +104,6 @@ out:
 	return mask;
 }
 
-/**
- *	cs5530_config_dma	-	set DMA/UDMA mode
- *	@drive: drive to tune
- *
- *	cs5530_config_dma() handles setting of DMA/UDMA mode
- *	for both the chipset and drive.
- */
-
-static int cs5530_config_dma(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static void cs5530_set_dma_mode(ide_drive_t *drive, const u8 mode)
 {
 	unsigned long basereg;
@@ -288,7 +270,7 @@ static void __devinit init_hwif_cs5530 (
 	hwif->mwdma_mask = 0x07;
 
 	hwif->udma_filter = cs5530_udma_filter;
-	hwif->ide_dma_check = &cs5530_config_dma;
+
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -157,16 +157,6 @@ static void cs5535_set_pio_mode(ide_driv
 	cs5535_set_speed(drive, XFER_PIO_0 + pio);
 }
 
-static int cs5535_dma_check(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static u8 __devinit cs5535_cable_detect(struct pci_dev *dev)
 {
 	u8 bit;
@@ -197,8 +187,6 @@ static void __devinit init_hwif_cs5535(i
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ide_dma_check = &cs5535_dma_check;
-
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x1F;
 	hwif->mwdma_mask = 0x07;
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -469,7 +469,7 @@ static ide_pci_device_t cy82c693_chipset
 	.init_hwif	= init_hwif_cy82c693,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
-	.host_flags	= IDE_HFLAG_SINGLE,
+	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	.pio_mask	= ATA_PIO4,
 };
 
Index: b/drivers/ide/pci/generic.c
===================================================================
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -97,77 +97,92 @@ static ide_pci_device_t generic_chipsets
 		.init_hwif	= init_hwif_generic,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 1 */
 		.name		= "NS87410",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
         },{	/* 2 */
 		.name		= "SAMURAI",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 3 */
 		.name		= "HT6565",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 4 */
 		.name		= "UM8673F",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 5 */
 		.name		= "UM8886A",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 6 */
 		.name		= "UM8886BF",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 7 */
 		.name		= "HINT_IDE",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 8 */
 		.name		= "VIA_IDE",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 9 */
 		.name		= "OPTI621V",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 10 */
 		.name		= "VIA8237SATA",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 11 */
 		.name 		= "Piccolo0102",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 12 */
 		.name 		= "Piccolo0103",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 13 */
 		.name 		= "Piccolo0105",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 14 */
 		.name		= "Revolution",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	}
 };
 
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -80,16 +80,6 @@ static void hpt34x_set_pio_mode(ide_driv
 	hpt34x_set_mode(drive, XFER_PIO_0 + pio);
 }
 
-static int hpt34x_config_drive_xfer_rate (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return -1;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 /*
  * If the BIOS does not set the IO base addaress to XX00, 343 will fail.
  */
@@ -156,7 +146,6 @@ static void __devinit init_hwif_hpt34x(i
 	hwif->swdma_mask = 0x07;
 #endif
 
-	hwif->ide_dma_check = &hpt34x_config_drive_xfer_rate;
 	if (!noautodma)
 		hwif->autodma = (pcicmd & PCI_COMMAND_MEMORY) ? 1 : 0;
 	hwif->drives[0].autodma = hwif->autodma;
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -695,16 +695,6 @@ static void hpt3xx_maskproc(ide_drive_t 
 			   IDE_CONTROL_REG);
 }
 
-static int hpt366_config_drive_xfer_rate(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 /*
  * This is specific to the HPT366 UDMA chipset
  * by HighPoint|Triones Technologies, Inc.
@@ -1327,8 +1317,6 @@ static void __devinit init_hwif_hpt366(i
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = (scr1 & ata66) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 
-	hwif->ide_dma_check		= &hpt366_config_drive_xfer_rate;
-
 	if (chip_type >= HPT374) {
 		hwif->ide_dma_test_irq	= &hpt374_ide_dma_test_irq;
 		hwif->ide_dma_end	= &hpt374_ide_dma_end;
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -158,32 +158,10 @@ static void it8213_set_dma_mode(ide_driv
 }
 
 /**
- *	it8213_configure_drive_for_dma	-	set up for DMA transfers
- *	@drive: drive we are going to set up
- *
- *	Set up the drive for DMA, tune the controller and drive as
- *	required. If the drive isn't suitable for DMA or we hit
- *	other problems then we will drop down to PIO and set up
- *	PIO appropriately
- */
-
-static int it8213_config_drive_for_dma (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
-/**
  *	init_hwif_it8213	-	set up hwif structs
  *	@hwif: interface to set up
  *
- *	We do the basic set up of the interface structure. The IT8212
- *	requires several custom handlers so we override the default
- *	ide DMA handlers appropriately
+ *	We do the basic set up of the interface structure.
  */
 
 static void __devinit init_hwif_it8213(ide_hwif_t *hwif)
@@ -208,8 +186,6 @@ static void __devinit init_hwif_it8213(i
 
 	pci_read_config_byte(hwif->pci_dev, 0x42, &reg42h);
 
-	hwif->ide_dma_check = &it8213_config_drive_for_dma;
-
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = (reg42h & 0x02) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -416,26 +416,6 @@ static void it821x_set_dma_mode(ide_driv
 }
 
 /**
- *	it821x_configure_drive_for_dma	-	set up for DMA transfers
- *	@drive: drive we are going to set up
- *
- *	Set up the drive for DMA, tune the controller and drive as
- *	required. If the drive isn't suitable for DMA or we hit
- *	other problems then we will drop down to PIO and set up
- *	PIO appropriately
- */
-
-static int it821x_config_drive_for_dma (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
-/**
  *	ata66_it821x	-	check for 80 pin cable
  *	@hwif: interface to check
  *
@@ -615,8 +595,6 @@ static void __devinit init_hwif_it821x(i
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
 
-	hwif->ide_dma_check = &it821x_config_drive_for_dma;
-
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_it821x(hwif);
 
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -100,24 +100,6 @@ static void jmicron_set_dma_mode(ide_dri
 }
 
 /**
- *	jmicron_configure_drive_for_dma	-	set up for DMA transfers
- *	@drive: drive we are going to set up
- *
- *	As the JMicron snoops for timings all we actually need to do is
- *	make sure we don't set an invalid mode.
- */
-
-static int jmicron_config_drive_for_dma (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
-/**
  *	init_hwif_jmicron	-	set up hwif structs
  *	@hwif: interface to set up
  *
@@ -139,8 +121,6 @@ static void __devinit init_hwif_jmicron(
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
 
-	hwif->ide_dma_check = &jmicron_config_drive_for_dma;
-
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_jmicron(hwif);
 
Index: b/drivers/ide/pci/ns87415.c
===================================================================
--- a/drivers/ide/pci/ns87415.c
+++ b/drivers/ide/pci/ns87415.c
@@ -274,6 +274,7 @@ static ide_pci_device_t ns87415_chipset 
 	.init_hwif	= init_hwif_ns87415,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
+	.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 };
 
 static int __devinit ns87415_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -355,6 +355,7 @@ static ide_pci_device_t opti621_chipsets
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
 		.bootable	= ON_BOARD,
 		.pio_mask	= ATA_PIO3,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	},{	/* 1 */
 		.name		= "OPTI621X",
 		.init_hwif	= init_hwif_opti621,
@@ -362,6 +363,7 @@ static ide_pci_device_t opti621_chipsets
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
 		.bootable	= ON_BOARD,
 		.pio_mask	= ATA_PIO3,
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 	}
 };
 
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -223,16 +223,6 @@ static u8 pdcnew_cable_detect(ide_hwif_t
 		return ATA_CBL_PATA80;
 }
 
-static int pdcnew_config_drive_xfer_rate(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static int pdcnew_quirkproc(ide_drive_t *drive)
 {
 	const char **list, *model = drive->id->model;
@@ -499,8 +489,6 @@ static void __devinit init_hwif_pdc202ne
 	hwif->ultra_mask = hwif->cds->udma_mask;
 	hwif->mwdma_mask = 0x07;
 
-	hwif->ide_dma_check = &pdcnew_config_drive_xfer_rate;
-
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = pdcnew_cable_detect(hwif);
 
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -179,16 +179,6 @@ static void pdc_old_disable_66MHz_clock(
 	outb(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
 }
 
-static int pdc202xx_config_drive_xfer_rate (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static int pdc202xx_quirkproc (ide_drive_t *drive)
 {
 	const char **list, *model = drive->id->model;
@@ -344,7 +334,6 @@ static void __devinit init_hwif_pdc202xx
 	hwif->swdma_mask = 0x07;
 	hwif->atapi_dma = 1;
 
-	hwif->ide_dma_check = &pdc202xx_config_drive_xfer_rate;
 	hwif->dma_lost_irq = &pdc202xx_dma_lost_irq;
 	hwif->dma_timeout = &pdc202xx_dma_timeout;
 
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -255,24 +255,6 @@ static void piix_set_dma_mode(ide_drive_
 }
 
 /**
- *	piix_config_drive_xfer_rate	-	set up an IDE device
- *	@drive: IDE drive to configure
- *
- *	Set up the PIIX interface for the best available speed on this
- *	interface, preferring DMA to PIO.
- */
- 
-static int piix_config_drive_xfer_rate (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
-/**
  *	piix_is_ichx	-	check if ICHx
  *	@dev: PCI device to check
  *
@@ -432,7 +414,6 @@ static void __devinit init_hwif_piix(ide
 	if (no_piix_dma)
 		hwif->ultra_mask = hwif->mwdma_mask = hwif->swdma_mask = 0;
 
-	hwif->ide_dma_check = &piix_config_drive_xfer_rate;
 	if (!noautodma)
 		hwif->autodma = 1;
 
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -199,21 +199,6 @@ static void sc1200_set_dma_mode(ide_driv
 	}
 }
 
-/*
- * sc1200_config_dma() handles selection/setting of DMA/UDMA modes
- * for both the chipset and drive.
- */
-static int sc1200_config_dma (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
-
 /*  Replacement for the standard ide_dma_end action in
  *  dma_proc.
  *
@@ -391,7 +376,6 @@ static void __devinit init_hwif_sc1200 (
 		return;
 
 	hwif->udma_filter = sc1200_udma_filter;
-	hwif->ide_dma_check = &sc1200_config_dma;
 	hwif->ide_dma_end   = &sc1200_ide_dma_end;
 
 	if (!noautodma)
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -284,27 +284,6 @@ static void scc_set_dma_mode(ide_drive_t
 }
 
 /**
- *	scc_configure_drive_for_dma	-	set up for DMA transfers
- *	@drive: drive we are going to set up
- *
- *	Set up the drive for DMA, tune the controller and drive as
- *	required.
- *      If the drive isn't suitable for DMA or we hit other problems
- *      then we will drop down to PIO and set up PIO appropriately.
- *      (return -1)
- */
-
-static int scc_config_drive_for_dma(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
-/**
  *	scc_ide_dma_setup	-	begin a DMA phase
  *	@drive: target device
  *
@@ -701,7 +680,6 @@ static void __devinit init_hwif_scc(ide_
 	hwif->ide_dma_end = scc_ide_dma_end;
 	hwif->set_pio_mode = scc_set_pio_mode;
 	hwif->set_dma_mode = scc_set_dma_mode;
-	hwif->ide_dma_check = scc_config_drive_for_dma;
 	hwif->ide_dma_test_irq = scc_dma_test_irq;
 	hwif->udma_filter = scc_udma_filter;
 
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -195,16 +195,6 @@ static void svwks_set_dma_mode(ide_drive
 	pci_write_config_byte(dev, 0x54, ultra_enable);
 }
 
-static int svwks_config_drive_xfer_rate (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static unsigned int __devinit init_chipset_svwks (struct pci_dev *dev, const char *name)
 {
 	unsigned int reg;
@@ -391,7 +381,6 @@ static void __devinit init_hwif_svwks (i
 	if (!hwif->dma_base)
 		return;
 
-	hwif->ide_dma_check = &svwks_config_drive_xfer_rate;
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
 		if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 			hwif->cbl = ata66_svwks(hwif);
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -295,20 +295,6 @@ static void sgiioc4_set_dma_mode(ide_dri
 {
 }
 
-static int sgiioc4_ide_dma_check(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	/*
-	 * ->set_pio_mode is not implemented currently
-	 * so this is just for the completness
-	 */
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 /* returns 1 if dma irq issued, 0 otherwise */
 static int
 sgiioc4_ide_dma_test_irq(ide_drive_t * drive)
@@ -611,7 +597,6 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->dma_setup = &sgiioc4_ide_dma_setup;
 	hwif->dma_start = &sgiioc4_ide_dma_start;
 	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
-	hwif->ide_dma_check = &sgiioc4_ide_dma_check;
 	hwif->ide_dma_on = &sgiioc4_ide_dma_on;
 	hwif->dma_off_quietly = &sgiioc4_dma_off_quietly;
 	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -311,26 +311,6 @@ static void sil_set_dma_mode(ide_drive_t
 	}
 }
 
-/**
- *	siimage_configure_drive_for_dma	-	set up for DMA transfers
- *	@drive: drive we are going to set up
- *
- *	Set up the drive for DMA, tune the controller and drive as 
- *	required. If the drive isn't suitable for DMA or we hit
- *	other problems then we will drop down to PIO and set up
- *	PIO appropriately
- */
- 
-static int siimage_config_drive_for_dma (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 /* returns 1 if dma irq issued, 0 otherwise */
 static int siimage_io_ide_dma_test_irq (ide_drive_t *drive)
 {
@@ -924,8 +904,6 @@ static void __devinit init_hwif_siimage(
 	if (!is_sata(hwif))
 		hwif->atapi_dma = 1;
 
-	hwif->ide_dma_check = &siimage_config_drive_for_dma;
-
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_siimage(hwif);
 
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -601,16 +601,6 @@ static void sis_set_dma_mode(ide_drive_t
 	}
 }
 
-static int sis5513_config_xfer_rate(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static u8 sis5513_ata133_udma_filter(ide_drive_t *drive)
 {
 	struct pci_dev *dev = drive->hwif->pci_dev;
@@ -847,8 +837,6 @@ static void __devinit init_hwif_sis5513 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_sis5513(hwif);
 
-	hwif->ide_dma_check = &sis5513_config_xfer_rate;
-
 	if (!noautodma)
 		hwif->autodma = 1;
 
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -145,21 +145,6 @@ static void sl82c105_set_dma_mode(ide_dr
 }
 
 /*
- * Check to see if the drive and chipset are capable of DMA mode.
- */
-static int sl82c105_ide_dma_check(ide_drive_t *drive)
-{
-	DBG(("sl82c105_ide_dma_check(drive:%s)\n", drive->name));
-
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
-/*
  * The SL82C105 holds off all IDE interrupts while in DMA mode until
  * all DMA activity is completed.  Sometimes this causes problems (eg,
  * when the drive wants to report an error condition).
@@ -406,7 +391,6 @@ static void __devinit init_hwif_sl82c105
 	hwif->atapi_dma  = 1;
 	hwif->mwdma_mask = 0x07;
 
-	hwif->ide_dma_check		= &sl82c105_ide_dma_check;
 	hwif->ide_dma_on		= &sl82c105_ide_dma_on;
 	hwif->dma_off_quietly		= &sl82c105_dma_off_quietly;
 	hwif->dma_lost_irq		= &sl82c105_dma_lost_irq;
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -130,16 +130,6 @@ static void slc90e66_set_dma_mode(ide_dr
 	slc90e66_set_pio_mode(drive, pio);
 }
 
-static int slc90e66_config_drive_xfer_rate (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static void __devinit init_hwif_slc90e66 (ide_hwif_t *hwif)
 {
 	u8 reg47 = 0;
@@ -170,8 +160,6 @@ static void __devinit init_hwif_slc90e66
 		/* bit[0(1)]: 0:80, 1:40 */
 		hwif->cbl = (reg47 & mask) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 
-	hwif->ide_dma_check = &slc90e66_config_drive_xfer_rate;
-
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -162,16 +162,6 @@ static int tc86c001_busproc(ide_drive_t 
 	return 0;
 }
 
-static int tc86c001_config_drive_xfer_rate(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static void __devinit init_hwif_tc86c001(ide_hwif_t *hwif)
 {
 	unsigned long sc_base	= pci_resource_start(hwif->pci_dev, 5);
@@ -212,7 +202,6 @@ static void __devinit init_hwif_tc86c001
 	hwif->ultra_mask = 0x1f;
 	hwif->mwdma_mask = 0x07;
 
-	hwif->ide_dma_check	= &tc86c001_config_drive_xfer_rate;
 	hwif->dma_start 	= &tc86c001_dma_start;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT) {
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -96,16 +96,6 @@ static void triflex_set_pio_mode(ide_dri
 	triflex_set_mode(drive, XFER_PIO_0 + pio);
 }
 
-static int triflex_config_drive_xfer_rate(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static void __devinit init_hwif_triflex(ide_hwif_t *hwif)
 {
 	hwif->set_pio_mode = &triflex_set_pio_mode;
@@ -117,7 +107,6 @@ static void __devinit init_hwif_triflex(
 	hwif->atapi_dma  = 1;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
-	hwif->ide_dma_check = &triflex_config_drive_xfer_rate;
 	
 	if (!noautodma)
 		hwif->autodma = 1;
Index: b/drivers/ide/pci/trm290.c
===================================================================
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -329,6 +329,7 @@ static ide_pci_device_t trm290_chipset _
 	.init_hwif	= init_hwif_trm290,
 	.autodma	= NOAUTODMA,
 	.bootable	= ON_BOARD,
+	.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
 };
 
 static int __devinit trm290_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -197,24 +197,6 @@ static void via_set_pio_mode(ide_drive_t
 	via_set_drive(drive, XFER_PIO_0 + pio);
 }
 
-/**
- *	via82cxxx_ide_dma_check		-	set up for DMA if possible
- *	@drive: IDE drive to set up
- *
- *	Set up the drive for the highest supported speed considering the
- *	driver, controller and cable
- */
- 
-static int via82cxxx_ide_dma_check (ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
 static struct via_isa_bridge *via_config_find(struct pci_dev **isa)
 {
 	struct via_isa_bridge *via_config;
@@ -473,7 +455,6 @@ static void __devinit init_hwif_via82cxx
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = via82cxxx_cable_detect(hwif);
 
-	hwif->ide_dma_check = &via82cxxx_ide_dma_check;
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1578,21 +1578,6 @@ pmac_ide_destroy_dmatable (ide_drive_t *
 }
 
 /*
- * Check what is the best DMA timing setting for the drive and
- * call appropriate functions to apply it.
- */
-static int
-pmac_ide_dma_check(ide_drive_t *drive)
-{
-	if (ide_tune_dma(drive))
-		return 0;
-
-	ide_set_max_pio(drive);
-
-	return -1;
-}
-
-/*
  * Prepare a DMA transfer. We build the DMA table, adjust the timings for
  * a read on KeyLargo ATA/66 and mark us as waiting for DMA completion
  */
@@ -1789,7 +1774,6 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 
 	hwif->dma_off_quietly = &ide_dma_off_quietly;
 	hwif->ide_dma_on = &__ide_dma_on;
-	hwif->ide_dma_check = &pmac_ide_dma_check;
 	hwif->dma_setup = &pmac_ide_dma_setup;
 	hwif->dma_exec_cmd = &pmac_ide_dma_exec_cmd;
 	hwif->dma_start = &pmac_ide_dma_start;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -736,7 +736,6 @@ typedef struct hwif_s {
 	void (*dma_exec_cmd)(ide_drive_t *, u8);
 	void (*dma_start)(ide_drive_t *);
 	int (*ide_dma_end)(ide_drive_t *drive);
-	int (*ide_dma_check)(ide_drive_t *drive);
 	int (*ide_dma_on)(ide_drive_t *drive);
 	void (*dma_off_quietly)(ide_drive_t *drive);
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
@@ -1261,6 +1260,10 @@ enum {
 	IDE_HFLAG_POST_SET_MODE		= (1 << 8),
 	/* don't program host/device for the transfer mode ("smart" hosts) */
 	IDE_HFLAG_NO_SET_MODE		= (1 << 9),
+	/* trust BIOS for programming chipset/device for DMA */
+	IDE_HFLAG_TRUST_BIOS_FOR_DMA	= (1 << 10),
+	/* host uses VDMA */
+	IDE_HFLAG_VDMA			= (1 << 11),
 };
 
 typedef struct ide_pci_device_s {
@@ -1308,7 +1311,6 @@ static inline u8 ide_max_dma_mode(ide_dr
 	return ide_find_dma_mode(drive, XFER_UDMA_6);
 }
 
-int ide_tune_dma(ide_drive_t *);
 void ide_dma_off(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
 int ide_set_dma(ide_drive_t *);
@@ -1335,7 +1337,6 @@ extern void ide_dma_timeout(ide_drive_t 
 #else
 static inline u8 ide_find_dma_mode(ide_drive_t *drive, u8 speed) { return 0; }
 static inline u8 ide_max_dma_mode(ide_drive_t *drive) { return 0; }
-static inline int ide_tune_dma(ide_drive_t *drive) { return 0; }
 static inline void ide_dma_off(ide_drive_t *drive) { ; }
 static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
 static inline int ide_set_dma(ide_drive_t *drive) { return 1; }
