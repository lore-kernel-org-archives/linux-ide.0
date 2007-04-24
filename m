From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2 pata-2.6] ide: make void and rename ide_dma_timeout() method
Date: Wed, 25 Apr 2007 00:05:16 +0400
Message-ID: <200704250005.16183.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:10013 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423087AbXDXUDj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Apr 2007 16:03:39 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Since ide_dma_timeout() method's result is discarded, make it return 'void'.
While at it, drop 'ide_' from the method's name, drop the '__' prefix from
the default method's name, and do some cleanups in this method driver-wise:

- in ide-dma.c, au1xxx-ide.c, and pdc202xx_old.c, define/use 'hwif' variable;

- in au1xxx-ide.c, get rid of commented out printk();

- in sl82c105.c, get rid of unnecessary variables.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/arm/icside.c       |   11 +++++------
 drivers/ide/ide-dma.c          |   17 ++++++++++-------
 drivers/ide/ide-io.c           |    2 +-
 drivers/ide/ide.c              |    2 +-
 drivers/ide/mips/au1xxx-ide.c  |   12 ++++++------
 drivers/ide/pci/hpt366.c       |    6 +++---
 drivers/ide/pci/pdc202xx_old.c |   13 ++++++++-----
 drivers/ide/pci/sgiioc4.c      |    2 +-
 drivers/ide/pci/sl82c105.c     |   13 +++++--------
 drivers/ide/ppc/pmac.c         |    2 +-
 include/linux/ide.h            |    4 ++--
 11 files changed, 43 insertions(+), 41 deletions(-)

Index: linux-2.6/drivers/ide/arm/icside.c
===================================================================
--- linux-2.6.orig/drivers/ide/arm/icside.c
+++ linux-2.6/drivers/ide/arm/icside.c
@@ -448,17 +448,16 @@ static int icside_dma_test_irq(ide_drive
 			ICS_ARCIN_V6_INTRSTAT_1)) & 1;
 }
 
-static int icside_dma_timeout(ide_drive_t *drive)
+static void icside_dma_timeout(ide_drive_t *drive)
 {
 	printk(KERN_ERR "%s: DMA timeout occurred: ", drive->name);
 
 	if (icside_dma_test_irq(drive))
-		return 0;
+		return;
 
-	ide_dump_status(drive, "DMA timeout",
-		HWIF(drive)->INB(IDE_STATUS_REG));
+	ide_dump_status(drive, "DMA timeout", HWIF(drive)->INB(IDE_STATUS_REG));
 
-	return icside_dma_end(drive);
+	icside_dma_end(drive);
 }
 
 static void icside_dma_lost_irq(ide_drive_t *drive)
@@ -489,7 +488,7 @@ static void icside_dma_init(ide_hwif_t *
 	hwif->dma_start		= icside_dma_start;
 	hwif->ide_dma_end	= icside_dma_end;
 	hwif->ide_dma_test_irq	= icside_dma_test_irq;
-	hwif->ide_dma_timeout	= icside_dma_timeout;
+	hwif->dma_timeout	= icside_dma_timeout;
 	hwif->dma_lost_irq	= icside_dma_lost_irq;
 
 	hwif->drives[0].autodma = hwif->autodma;
Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -855,16 +855,19 @@ void ide_dma_lost_irq (ide_drive_t *driv
 
 EXPORT_SYMBOL(ide_dma_lost_irq);
 
-int __ide_dma_timeout (ide_drive_t *drive)
+void ide_dma_timeout (ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = HWIF(drive);
+
 	printk(KERN_ERR "%s: timeout waiting for DMA\n", drive->name);
-	if (HWIF(drive)->ide_dma_test_irq(drive))
-		return 0;
 
-	return HWIF(drive)->ide_dma_end(drive);
+	if (hwif->ide_dma_test_irq(drive))
+		return;
+
+	hwif->ide_dma_end(drive);
 }
 
-EXPORT_SYMBOL(__ide_dma_timeout);
+EXPORT_SYMBOL(ide_dma_timeout);
 
 /*
  * Needed for allowing full modular support of ide-driver
@@ -1015,8 +1018,8 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		hwif->ide_dma_end = &__ide_dma_end;
 	if (!hwif->ide_dma_test_irq)
 		hwif->ide_dma_test_irq = &__ide_dma_test_irq;
-	if (!hwif->ide_dma_timeout)
-		hwif->ide_dma_timeout = &__ide_dma_timeout;
+	if (!hwif->dma_timeout)
+		hwif->dma_timeout = &ide_dma_timeout;
 	if (!hwif->dma_lost_irq)
 		hwif->dma_lost_irq = &ide_dma_lost_irq;
 
Index: linux-2.6/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io.c
+++ linux-2.6/drivers/ide/ide-io.c
@@ -1350,7 +1350,7 @@ static ide_startstop_t ide_dma_timeout_r
 						hwif->INB(IDE_STATUS_REG));
 	} else {
 		printk(KERN_WARNING "%s: DMA timeout retry\n", drive->name);
-		(void) hwif->ide_dma_timeout(drive);
+		hwif->dma_timeout(drive);
 	}
 
 	/*
Index: linux-2.6/drivers/ide/ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide.c
+++ linux-2.6/drivers/ide/ide.c
@@ -497,7 +497,7 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->dma_host_on		= tmp_hwif->dma_host_on;
 	hwif->dma_host_off		= tmp_hwif->dma_host_off;
 	hwif->dma_lost_irq		= tmp_hwif->dma_lost_irq;
-	hwif->ide_dma_timeout		= tmp_hwif->ide_dma_timeout;
+	hwif->dma_timeout		= tmp_hwif->dma_timeout;
 
 	hwif->OUTB			= tmp_hwif->OUTB;
 	hwif->OUTBSYNC			= tmp_hwif->OUTBSYNC;
Index: linux-2.6/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/mips/au1xxx-ide.c
+++ linux-2.6/drivers/ide/mips/au1xxx-ide.c
@@ -488,16 +488,16 @@ static void auide_init_dbdma_dev(dbdev_t
   
 #if defined(CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA)
 
-static int auide_dma_timeout(ide_drive_t *drive)
+static void auide_dma_timeout(ide_drive_t *drive)
 {
-//      printk("%s\n", __FUNCTION__);
+	ide_hwif_t *hwif = HWIF(drive);
 
 	printk(KERN_ERR "%s: DMA timeout occurred: ", drive->name);
 
-	if (HWIF(drive)->ide_dma_test_irq(drive))
-		return 0;
+	if (hwif->ide_dma_test_irq(drive))
+		return;
 
-	return HWIF(drive)->ide_dma_end(drive);
+	hwif->ide_dma_end(drive);
 }
 					
 
@@ -720,7 +720,7 @@ static int au_ide_probe(struct device *d
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 	hwif->dma_off_quietly		= &auide_dma_off_quietly;
-	hwif->ide_dma_timeout           = &auide_dma_timeout;
+	hwif->dma_timeout		= &auide_dma_timeout;
 
 	hwif->ide_dma_check             = &auide_dma_check;
 	hwif->dma_exec_cmd              = &auide_dma_exec_cmd;
Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -798,10 +798,10 @@ static int hpt370_ide_dma_end(ide_drive_
 	return __ide_dma_end(drive);
 }
 
-static int hpt370_ide_dma_timeout(ide_drive_t *drive)
+static void hpt370_dma_timeout(ide_drive_t *drive)
 {
 	hpt370_irq_timeout(drive);
-	return __ide_dma_timeout(drive);
+	ide_dma_timeout(drive);
 }
 
 /* returns 1 if DMA IRQ issued, 0 otherwise */
@@ -1352,7 +1352,7 @@ static void __devinit init_hwif_hpt366(i
 	} else if (chip_type >= HPT370) {
 		hwif->dma_start 	= &hpt370_ide_dma_start;
 		hwif->ide_dma_end	= &hpt370_ide_dma_end;
-		hwif->ide_dma_timeout	= &hpt370_ide_dma_timeout;
+		hwif->dma_timeout	= &hpt370_dma_timeout;
 	} else
 		hwif->dma_lost_irq	= &hpt366_dma_lost_irq;
 
Index: linux-2.6/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/pdc202xx_old.c
+++ linux-2.6/drivers/ide/pci/pdc202xx_old.c
@@ -277,11 +277,14 @@ static void pdc202xx_dma_lost_irq(ide_dr
 	ide_dma_lost_irq(drive);
 }
 
-static int pdc202xx_ide_dma_timeout(ide_drive_t *drive)
+static void pdc202xx_dma_timeout(ide_drive_t *drive)
 {
-	if (HWIF(drive)->resetproc != NULL)
-		HWIF(drive)->resetproc(drive);
-	return __ide_dma_timeout(drive);
+	ide_hwif_t *hwif = HWIF(drive);
+
+	if (hwif->resetproc != NULL)
+		hwif->resetproc(drive);
+
+	ide_dma_timeout(drive);
 }
 
 static void pdc202xx_reset_host (ide_hwif_t *hwif)
@@ -351,7 +354,7 @@ static void __devinit init_hwif_pdc202xx
 
 	hwif->ide_dma_check = &pdc202xx_config_drive_xfer_rate;
 	hwif->dma_lost_irq = &pdc202xx_dma_lost_irq;
-	hwif->ide_dma_timeout = &pdc202xx_ide_dma_timeout;
+	hwif->dma_timeout = &pdc202xx_dma_timeout;
 
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
 		if (!(hwif->udma_four))
Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
+++ linux-2.6/drivers/ide/pci/sgiioc4.c
@@ -608,7 +608,7 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->dma_host_on = &sgiioc4_dma_host_on;
 	hwif->dma_host_off = &sgiioc4_dma_host_off;
 	hwif->dma_lost_irq = &sgiioc4_dma_lost_irq;
-	hwif->ide_dma_timeout = &__ide_dma_timeout;
+	hwif->dma_timeout = &ide_dma_timeout;
 
 	hwif->INB = &sgiioc4_INB;
 }
Index: linux-2.6/drivers/ide/pci/sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sl82c105.c
+++ linux-2.6/drivers/ide/pci/sl82c105.c
@@ -241,15 +241,12 @@ static void sl82c105_dma_start(ide_drive
 	ide_dma_start(drive);
 }
 
-static int sl82c105_ide_dma_timeout(ide_drive_t *drive)
+static void sl82c105_dma_timeout(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-
-	DBG(("sl82c105_ide_dma_timeout(drive:%s)\n", drive->name));
+	DBG(("sl82c105_dma_timeout(drive:%s)\n", drive->name));
 
-	sl82c105_reset_host(dev);
-	return __ide_dma_timeout(drive);
+	sl82c105_reset_host(HWIF(drive)->pci_dev);
+	ide_dma_timeout(drive);
 }
 
 static int sl82c105_ide_dma_on(ide_drive_t *drive)
@@ -438,7 +435,7 @@ static void __devinit init_hwif_sl82c105
 	hwif->dma_off_quietly		= &sl82c105_dma_off_quietly;
 	hwif->dma_lost_irq		= &sl82c105_dma_lost_irq;
 	hwif->dma_start			= &sl82c105_dma_start;
-	hwif->ide_dma_timeout		= &sl82c105_ide_dma_timeout;
+	hwif->dma_timeout		= &sl82c105_dma_timeout;
 
 	if (!noautodma)
 		hwif->autodma = 1;
Index: linux-2.6/drivers/ide/ppc/pmac.c
===================================================================
--- linux-2.6.orig/drivers/ide/ppc/pmac.c
+++ linux-2.6/drivers/ide/ppc/pmac.c
@@ -2056,7 +2056,7 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;
 	hwif->dma_host_off = &pmac_ide_dma_host_off;
 	hwif->dma_host_on = &pmac_ide_dma_host_on;
-	hwif->ide_dma_timeout = &__ide_dma_timeout;
+	hwif->dma_timeout = &ide_dma_timeout;
 	hwif->dma_lost_irq = &pmac_ide_dma_lost_irq;
 
 	hwif->atapi_dma = 1;
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -736,7 +736,7 @@ typedef struct hwif_s {
 	void (*dma_host_on)(ide_drive_t *drive);
 	void (*dma_host_off)(ide_drive_t *drive);
 	void (*dma_lost_irq)(ide_drive_t *drive);
-	int (*ide_dma_timeout)(ide_drive_t *drive);
+	void (*dma_timeout)(ide_drive_t *drive);
 
 	void (*OUTB)(u8 addr, unsigned long port);
 	void (*OUTBSYNC)(ide_drive_t *drive, u8 addr, unsigned long port);
@@ -1304,7 +1304,7 @@ extern int ide_dma_setup(ide_drive_t *);
 extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
 extern void ide_dma_lost_irq(ide_drive_t *);
-extern int __ide_dma_timeout(ide_drive_t *);
+extern void ide_dma_timeout(ide_drive_t *);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 #else

