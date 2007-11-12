From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/13] ide: merge ->dma_host_{on,off} methods into ->dma_host_set method
Date: Tue, 13 Nov 2007 00:02:25 +0100
Message-ID: <200711130002.25301.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:11054 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758206AbXKLW6f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:35 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1634397fkz
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Merge ->dma_host_{on,off} methods into ->dma_host_set method
which takes 'int on' argument.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c      |    9 +------
 drivers/ide/cris/ide-cris.c   |    9 +------
 drivers/ide/ide-dma.c         |   50 ++++++++++++------------------------------
 drivers/ide/ide-io.c          |    2 -
 drivers/ide/ide-iops.c        |    8 +++---
 drivers/ide/ide-probe.c       |    2 -
 drivers/ide/ide.c             |    5 +---
 drivers/ide/mips/au1xxx-ide.c |    9 +------
 drivers/ide/pci/cs5520.c      |   17 +++-----------
 drivers/ide/pci/sc1200.c      |    2 -
 drivers/ide/pci/sgiioc4.c     |   12 +++-------
 drivers/ide/ppc/pmac.c        |    9 +------
 include/linux/ide.h           |    6 +----
 13 files changed, 42 insertions(+), 98 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -287,11 +287,7 @@ static void icside_set_dma_mode(ide_driv
 		ide_xfer_verbose(xfer_mode), 2000 / drive->drive_data);
 }
 
-static void icside_dma_host_off(ide_drive_t *drive)
-{
-}
-
-static void icside_dma_host_on(ide_drive_t *drive)
+static void icside_dma_host_set(ide_drive_t *drive, int on)
 {
 }
 
@@ -410,8 +406,7 @@ static void icside_dma_init(ide_hwif_t *
 	hwif->dmatable_dma	= 0;
 	hwif->set_dma_mode	= icside_set_dma_mode;
 
-	hwif->dma_host_off	= icside_dma_host_off;
-	hwif->dma_host_on	= icside_dma_host_on;
+	hwif->dma_host_set	= icside_dma_host_set;
 	hwif->dma_setup		= icside_dma_setup;
 	hwif->dma_exec_cmd	= icside_dma_exec_cmd;
 	hwif->dma_start		= icside_dma_start;
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -674,11 +674,7 @@ static void cris_ide_output_data (ide_dr
 static void cris_atapi_input_bytes(ide_drive_t *drive, void *, unsigned int);
 static void cris_atapi_output_bytes(ide_drive_t *drive, void *, unsigned int);
 
-static void cris_dma_host_off(ide_drive_t *drive)
-{
-}
-
-static void cris_dma_host_on(ide_drive_t *drive)
+static void cris_dma_host_set(ide_drive_t *drive, int on)
 {
 }
 
@@ -791,6 +787,7 @@ init_e100_ide (void)
 		hwif->ata_output_data = &cris_ide_output_data;
 		hwif->atapi_input_bytes = &cris_atapi_input_bytes;
 		hwif->atapi_output_bytes = &cris_atapi_output_bytes;
+		hwif->dma_host_set = &cris_dma_host_set;
 		hwif->ide_dma_end = &cris_dma_end;
 		hwif->dma_setup = &cris_dma_setup;
 		hwif->dma_exec_cmd = &cris_dma_exec_cmd;
@@ -801,8 +798,6 @@ init_e100_ide (void)
 		hwif->OUTBSYNC = &cris_ide_outbsync;
 		hwif->INB = &cris_ide_inb;
 		hwif->INW = &cris_ide_inw;
-		hwif->dma_host_off = &cris_dma_host_off;
-		hwif->dma_host_on = &cris_dma_host_on;
 		hwif->cbl = ATA_CBL_PATA40;
 		hwif->host_flags |= IDE_HFLAG_NO_ATAPI_DMA;
 		hwif->pio_mask = ATA_PIO4,
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -407,23 +407,28 @@ static int dma_timer_expiry (ide_drive_t
 }
 
 /**
- *	ide_dma_host_off	-	Generic DMA kill
+ *	ide_dma_host_set	-	Enable/disable DMA on a host
  *	@drive: drive to control
  *
- *	Perform the generic IDE controller DMA off operation. This
- *	works for most IDE bus mastering controllers
+ *	Enable/disable DMA on an IDE controller following generic
+ *	bus-mastering IDE controller behaviour.
  */
 
-void ide_dma_host_off(ide_drive_t *drive)
+void ide_dma_host_set(ide_drive_t *drive, int on)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 unit			= (drive->select.b.unit & 0x01);
 	u8 dma_stat		= hwif->INB(hwif->dma_status);
 
-	hwif->OUTB((dma_stat & ~(1<<(5+unit))), hwif->dma_status);
+	if (on)
+		dma_stat |= (1 << (5 + unit));
+	else
+		dma_stat &= ~(1 << (5 + unit));
+
+	hwif->OUTB(dma_stat, hwif->dma_status);
 }
 
-EXPORT_SYMBOL(ide_dma_host_off);
+EXPORT_SYMBOL_GPL(ide_dma_host_set);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 /**
@@ -438,7 +443,7 @@ void ide_dma_off_quietly(ide_drive_t *dr
 	drive->using_dma = 0;
 	ide_toggle_bounce(drive, 0);
 
-	drive->hwif->dma_host_off(drive);
+	drive->hwif->dma_host_set(drive, 0);
 }
 
 EXPORT_SYMBOL(ide_dma_off_quietly);
@@ -459,29 +464,6 @@ void ide_dma_off(ide_drive_t *drive)
 
 EXPORT_SYMBOL(ide_dma_off);
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
-/**
- *	ide_dma_host_on	-	Enable DMA on a host
- *	@drive: drive to enable for DMA
- *
- *	Enable DMA on an IDE controller following generic bus mastering
- *	IDE controller behaviour
- */
-
-void ide_dma_host_on(ide_drive_t *drive)
-{
-	if (1) {
-		ide_hwif_t *hwif	= HWIF(drive);
-		u8 unit			= (drive->select.b.unit & 0x01);
-		u8 dma_stat		= hwif->INB(hwif->dma_status);
-
-		hwif->OUTB((dma_stat|(1<<(5+unit))), hwif->dma_status);
-	}
-}
-
-EXPORT_SYMBOL(ide_dma_host_on);
-#endif
-
 /**
  *	ide_dma_on		-	Enable DMA on a device
  *	@drive: drive to enable DMA on
@@ -494,7 +476,7 @@ void ide_dma_on(ide_drive_t *drive)
 	drive->using_dma = 1;
 	ide_toggle_bounce(drive, 1);
 
-	drive->hwif->dma_host_on(drive);
+	drive->hwif->dma_host_set(drive, 1);
 }
 
 EXPORT_SYMBOL(ide_dma_on);
@@ -1014,10 +996,8 @@ void ide_setup_dma(ide_hwif_t *hwif, uns
 	if (!(hwif->dma_prdtable))
 		hwif->dma_prdtable	= (hwif->dma_base + 4);
 
-	if (!hwif->dma_host_off)
-		hwif->dma_host_off = &ide_dma_host_off;
-	if (!hwif->dma_host_on)
-		hwif->dma_host_on = &ide_dma_host_on;
+	if (!hwif->dma_host_set)
+		hwif->dma_host_set = &ide_dma_host_set;
 	if (!hwif->dma_setup)
 		hwif->dma_setup = &ide_dma_setup;
 	if (!hwif->dma_exec_cmd)
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -219,7 +219,7 @@ static ide_startstop_t ide_start_power_s
 		 * we could be smarter and check for current xfer_speed
 		 * in struct drive etc...
 		 */
-		if (drive->hwif->dma_host_on == NULL)
+		if (drive->hwif->dma_host_set == NULL)
 			break;
 		/*
 		 * TODO: respect ->using_dma setting
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -739,8 +739,8 @@ int ide_config_drive_speed(ide_drive_t *
 //		msleep(50);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (hwif->dma_host_on)	/* check if host supports DMA */
-		hwif->dma_host_off(drive);
+	if (hwif->dma_host_set)	/* check if host supports DMA */
+		hwif->dma_host_set(drive, 0);
 #endif
 
 	/*
@@ -793,8 +793,8 @@ int ide_config_drive_speed(ide_drive_t *
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if ((speed >= XFER_SW_DMA_0 || (hwif->host_flags & IDE_HFLAG_VDMA)) &&
 	    drive->using_dma)
-		hwif->dma_host_on(drive);
-	else if (hwif->dma_host_on)	/* check if host supports DMA */
+		hwif->dma_host_set(drive, 1);
+	else if (hwif->dma_host_set)	/* check if host supports DMA */
 		ide_dma_off_quietly(drive);
 #endif
 
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -840,7 +840,7 @@ static void probe_hwif(ide_hwif_t *hwif)
 
 			drive->nice1 = 1;
 
-			if (hwif->dma_host_on)
+			if (hwif->dma_host_set)
 				ide_set_dma(drive);
 		}
 	}
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -433,14 +433,13 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->atapi_input_bytes		= tmp_hwif->atapi_input_bytes;
 	hwif->atapi_output_bytes	= tmp_hwif->atapi_output_bytes;
 
+	hwif->dma_host_set		= tmp_hwif->dma_host_set;
 	hwif->dma_setup			= tmp_hwif->dma_setup;
 	hwif->dma_exec_cmd		= tmp_hwif->dma_exec_cmd;
 	hwif->dma_start			= tmp_hwif->dma_start;
 	hwif->ide_dma_end		= tmp_hwif->ide_dma_end;
 	hwif->ide_dma_test_irq		= tmp_hwif->ide_dma_test_irq;
 	hwif->ide_dma_clear_irq		= tmp_hwif->ide_dma_clear_irq;
-	hwif->dma_host_on		= tmp_hwif->dma_host_on;
-	hwif->dma_host_off		= tmp_hwif->dma_host_off;
 	hwif->dma_lost_irq		= tmp_hwif->dma_lost_irq;
 	hwif->dma_timeout		= tmp_hwif->dma_timeout;
 
@@ -828,7 +827,7 @@ int set_using_dma(ide_drive_t *drive, in
 	if (!drive->id || !(drive->id->capability & 1))
 		goto out;
 
-	if (hwif->dma_host_on == NULL)
+	if (hwif->dma_host_set == NULL)
 		goto out;
 
 	err = -EBUSY;
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -395,11 +395,7 @@ static int auide_dma_test_irq(ide_drive_
 	return 0;
 }
 
-static void auide_dma_host_on(ide_drive_t *drive)
-{
-}
-
-static void auide_dma_host_off(ide_drive_t *drive)
+static void auide_dma_host_set(ide_drive_t *drive, int on)
 {
 }
 
@@ -674,13 +670,12 @@ static int au_ide_probe(struct device *d
 
 	hwif->mdma_filter		= &auide_mdma_filter;
 
+	hwif->dma_host_set		= &auide_dma_host_set;
 	hwif->dma_exec_cmd              = &auide_dma_exec_cmd;
 	hwif->dma_start                 = &auide_dma_start;
 	hwif->ide_dma_end               = &auide_dma_end;
 	hwif->dma_setup                 = &auide_dma_setup;
 	hwif->ide_dma_test_irq          = &auide_dma_test_irq;
-	hwif->dma_host_off		= &auide_dma_host_off;
-	hwif->dma_host_on		= &auide_dma_host_on;
 	hwif->dma_lost_irq		= &auide_dma_lost_irq;
 #else /* !CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
 	hwif->channel                   = 0;
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -107,18 +107,10 @@ static void cs5520_set_dma_mode(ide_driv
  *	ATAPI is harder so disable it for now using IDE_HFLAG_NO_ATAPI_DMA
  */
 
-static void cs5520_dma_host_on(ide_drive_t *drive)
+static void cs5520_dma_host_set(ide_drive_t *drive, int on)
 {
-	drive->vdma = 1;
-
-	ide_dma_host_on(drive);
-}
-
-static void cs5520_dma_host_off(ide_drive_t *drive)
-{
-	drive->vdma = 0;
-
-	ide_dma_host_off(drive);
+	drive->vdma = on;
+	ide_dma_host_set(drive, on);
 }
 
 static void __devinit init_hwif_cs5520(ide_hwif_t *hwif)
@@ -129,8 +121,7 @@ static void __devinit init_hwif_cs5520(i
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->dma_host_on  = &cs5520_dma_host_on;
-	hwif->dma_host_off = &cs5520_dma_host_off;
+	hwif->dma_host_set = &cs5520_dma_host_set;
 }
 
 #define DECLARE_CS_DEV(name_str)				\
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -222,7 +222,7 @@ static void sc1200_set_pio_mode(ide_driv
 		printk("SC1200: %s: changing (U)DMA mode\n", drive->name);
 		ide_dma_off_quietly(drive);
 		if (ide_set_dma_mode(drive, mode) == 0 && drive->using_dma)
-			hwif->dma_host_on(drive);
+			hwif->dma_host_set(drive, 1);
 		return;
 	}
 
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -288,13 +288,10 @@ sgiioc4_ide_dma_test_irq(ide_drive_t * d
 	return sgiioc4_checkirq(HWIF(drive));
 }
 
-static void sgiioc4_dma_host_on(ide_drive_t * drive)
+static void sgiioc4_dma_host_set(ide_drive_t *drive, int on)
 {
-}
-
-static void sgiioc4_dma_host_off(ide_drive_t * drive)
-{
-	sgiioc4_clearirq(drive);
+	if (!on)
+		sgiioc4_clearirq(drive);
 }
 
 static void
@@ -578,12 +575,11 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 
 	hwif->mwdma_mask = ATA_MWDMA2_ONLY;
 
+	hwif->dma_host_set = &sgiioc4_dma_host_set;
 	hwif->dma_setup = &sgiioc4_ide_dma_setup;
 	hwif->dma_start = &sgiioc4_ide_dma_start;
 	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
 	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
-	hwif->dma_host_on = &sgiioc4_dma_host_on;
-	hwif->dma_host_off = &sgiioc4_dma_host_off;
 	hwif->dma_lost_irq = &sgiioc4_dma_lost_irq;
 	hwif->dma_timeout = &ide_dma_timeout;
 }
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1698,11 +1698,7 @@ pmac_ide_dma_test_irq (ide_drive_t *driv
 	return 1;
 }
 
-static void pmac_ide_dma_host_off(ide_drive_t *drive)
-{
-}
-
-static void pmac_ide_dma_host_on(ide_drive_t *drive)
+static void pmac_ide_dma_host_set(ide_drive_t *drive, int on)
 {
 }
 
@@ -1748,13 +1744,12 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 		return;
 	}
 
+	hwif->dma_host_set = &pmac_ide_dma_host_set;
 	hwif->dma_setup = &pmac_ide_dma_setup;
 	hwif->dma_exec_cmd = &pmac_ide_dma_exec_cmd;
 	hwif->dma_start = &pmac_ide_dma_start;
 	hwif->ide_dma_end = &pmac_ide_dma_end;
 	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;
-	hwif->dma_host_off = &pmac_ide_dma_host_off;
-	hwif->dma_host_on = &pmac_ide_dma_host_on;
 	hwif->dma_timeout = &ide_dma_timeout;
 	hwif->dma_lost_irq = &pmac_ide_dma_lost_irq;
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -542,14 +542,13 @@ typedef struct hwif_s {
 	void (*atapi_input_bytes)(ide_drive_t *, void *, u32);
 	void (*atapi_output_bytes)(ide_drive_t *, void *, u32);
 
+	void (*dma_host_set)(ide_drive_t *, int);
 	int (*dma_setup)(ide_drive_t *);
 	void (*dma_exec_cmd)(ide_drive_t *, u8);
 	void (*dma_start)(ide_drive_t *);
 	int (*ide_dma_end)(ide_drive_t *drive);
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
 	void (*ide_dma_clear_irq)(ide_drive_t *drive);
-	void (*dma_host_on)(ide_drive_t *drive);
-	void (*dma_host_off)(ide_drive_t *drive);
 	void (*dma_lost_irq)(ide_drive_t *drive);
 	void (*dma_timeout)(ide_drive_t *drive);
 
@@ -1160,8 +1159,7 @@ extern void ide_destroy_dmatable(ide_dri
 extern int ide_release_dma(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
 
-void ide_dma_host_off(ide_drive_t *);
-void ide_dma_host_on(ide_drive_t *);
+void ide_dma_host_set(ide_drive_t *, int);
 extern int ide_dma_setup(ide_drive_t *);
 extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
