From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2 pata-2.6] ide: make void and rename ide_dma_lostirq() method
Date: Wed, 25 Apr 2007 00:04:09 +0400
Message-ID: <200704250004.09951.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:10004 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423086AbXDXUCe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Apr 2007 16:02:34 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Since ide_dma_lostirq() method's result is discarded, make it return 'void'.
While at it, rename the method to dma_lost_irq(), drop the '__' prefix from the
default method's name, and do some cleanups in this method driver-wise:

- in aec62xx.c, rename the method in accordance with other drivers, and get rid
  of unnecessary variables there;

- in pdc202xx_old.c, define/use 'hwif' variable;

- in sgiioc4.c, rearrange the code to call the resetproc() method directly.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/arm/icside.c       |    5 ++---
 drivers/ide/ide-dma.c          |    9 ++++-----
 drivers/ide/ide-io.c           |    2 +-
 drivers/ide/ide.c              |    2 +-
 drivers/ide/mips/au1xxx-ide.c  |    5 ++---
 drivers/ide/pci/aec62xx.c      |   10 +++-------
 drivers/ide/pci/hpt366.c       |    6 +++---
 drivers/ide/pci/pdc202xx_old.c |   13 ++++++++-----
 drivers/ide/pci/sgiioc4.c      |   18 +++++++++---------
 drivers/ide/pci/sl82c105.c     |    7 ++-----
 drivers/ide/ppc/pmac.c         |    9 ++++-----
 include/linux/ide.h            |    4 ++--
 12 files changed, 41 insertions(+), 49 deletions(-)

Index: linux-2.6/drivers/ide/arm/icside.c
===================================================================
--- linux-2.6.orig/drivers/ide/arm/icside.c
+++ linux-2.6/drivers/ide/arm/icside.c
@@ -461,10 +461,9 @@ static int icside_dma_timeout(ide_drive_
 	return icside_dma_end(drive);
 }
 
-static int icside_dma_lostirq(ide_drive_t *drive)
+static void icside_dma_lost_irq(ide_drive_t *drive)
 {
 	printk(KERN_ERR "%s: IRQ lost\n", drive->name);
-	return 1;
 }
 
 static void icside_dma_init(ide_hwif_t *hwif)
@@ -491,7 +490,7 @@ static void icside_dma_init(ide_hwif_t *
 	hwif->ide_dma_end	= icside_dma_end;
 	hwif->ide_dma_test_irq	= icside_dma_test_irq;
 	hwif->ide_dma_timeout	= icside_dma_timeout;
-	hwif->ide_dma_lostirq	= icside_dma_lostirq;
+	hwif->dma_lost_irq	= icside_dma_lost_irq;
 
 	hwif->drives[0].autodma = hwif->autodma;
 	hwif->drives[1].autodma = hwif->autodma;
Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -848,13 +848,12 @@ int ide_set_dma(ide_drive_t *drive)
 EXPORT_SYMBOL_GPL(ide_set_dma);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
-int __ide_dma_lostirq (ide_drive_t *drive)
+void ide_dma_lost_irq (ide_drive_t *drive)
 {
 	printk("%s: DMA interrupt recovery\n", drive->name);
-	return 1;
 }
 
-EXPORT_SYMBOL(__ide_dma_lostirq);
+EXPORT_SYMBOL(ide_dma_lost_irq);
 
 int __ide_dma_timeout (ide_drive_t *drive)
 {
@@ -1018,8 +1017,8 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		hwif->ide_dma_test_irq = &__ide_dma_test_irq;
 	if (!hwif->ide_dma_timeout)
 		hwif->ide_dma_timeout = &__ide_dma_timeout;
-	if (!hwif->ide_dma_lostirq)
-		hwif->ide_dma_lostirq = &__ide_dma_lostirq;
+	if (!hwif->dma_lost_irq)
+		hwif->dma_lost_irq = &ide_dma_lost_irq;
 
 	if (hwif->chipset != ide_trm290) {
 		u8 dma_stat = hwif->INB(hwif->dma_status);
Index: linux-2.6/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io.c
+++ linux-2.6/drivers/ide/ide-io.c
@@ -1466,7 +1466,7 @@ void ide_timer_expiry (unsigned long dat
 				startstop = handler(drive);
 			} else if (drive_is_ready(drive)) {
 				if (drive->waiting_for_dma)
-					(void) hwgroup->hwif->ide_dma_lostirq(drive);
+					hwgroup->hwif->dma_lost_irq(drive);
 				(void)ide_ack_intr(hwif);
 				printk(KERN_WARNING "%s: lost interrupt\n", drive->name);
 				startstop = handler(drive);
Index: linux-2.6/drivers/ide/ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide.c
+++ linux-2.6/drivers/ide/ide.c
@@ -496,7 +496,7 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->ide_dma_clear_irq		= tmp_hwif->ide_dma_clear_irq;
 	hwif->dma_host_on		= tmp_hwif->dma_host_on;
 	hwif->dma_host_off		= tmp_hwif->dma_host_off;
-	hwif->ide_dma_lostirq		= tmp_hwif->ide_dma_lostirq;
+	hwif->dma_lost_irq		= tmp_hwif->dma_lost_irq;
 	hwif->ide_dma_timeout		= tmp_hwif->ide_dma_timeout;
 
 	hwif->OUTB			= tmp_hwif->OUTB;
Index: linux-2.6/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/mips/au1xxx-ide.c
+++ linux-2.6/drivers/ide/mips/au1xxx-ide.c
@@ -456,10 +456,9 @@ static void auide_dma_off_quietly(ide_dr
 	drive->using_dma = 0;
 }
 
-static int auide_dma_lostirq(ide_drive_t *drive)
+static void auide_dma_lost_irq(ide_drive_t *drive)
 {
 	printk(KERN_ERR "%s: IRQ lost\n", drive->name);
-	return 0;
 }
 
 static void auide_ddma_tx_callback(int irq, void *param)
@@ -731,7 +730,7 @@ static int au_ide_probe(struct device *d
 	hwif->ide_dma_test_irq          = &auide_dma_test_irq;
 	hwif->dma_host_off		= &auide_dma_host_off;
 	hwif->dma_host_on		= &auide_dma_host_on;
-	hwif->ide_dma_lostirq           = &auide_dma_lostirq;
+	hwif->dma_lost_irq		= &auide_dma_lost_irq;
 	hwif->ide_dma_on                = &auide_dma_on;
 
 	hwif->autodma                   = 1;
Index: linux-2.6/drivers/ide/pci/aec62xx.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/aec62xx.c
+++ linux-2.6/drivers/ide/pci/aec62xx.c
@@ -172,12 +172,9 @@ static int aec62xx_config_drive_xfer_rat
 	return -1;
 }
 
-static int aec62xx_irq_timeout (ide_drive_t *drive)
+static void aec62xx_dma_lost_irq (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-
-	switch(dev->device) {
+	switch (HWIF(drive)->pci_dev->device) {
 		case PCI_DEVICE_ID_ARTOP_ATP860:
 		case PCI_DEVICE_ID_ARTOP_ATP860R:
 		case PCI_DEVICE_ID_ARTOP_ATP865:
@@ -186,7 +183,6 @@ static int aec62xx_irq_timeout (ide_driv
 		default:
 			break;
 	}
-	return 0;
 }
 
 static unsigned int __devinit init_chipset_aec62xx(struct pci_dev *dev, const char *name)
@@ -254,7 +250,7 @@ static void __devinit init_hwif_aec62xx(
 	hwif->mwdma_mask = 0x07;
 
 	hwif->ide_dma_check	= &aec62xx_config_drive_xfer_rate;
-	hwif->ide_dma_lostirq	= &aec62xx_irq_timeout;
+	hwif->dma_lost_irq	= &aec62xx_dma_lost_irq;
 
 	if (!noautodma)
 		hwif->autodma = 1;
Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -736,7 +736,7 @@ static int hpt366_config_drive_xfer_rate
  * This is specific to the HPT366 UDMA chipset
  * by HighPoint|Triones Technologies, Inc.
  */
-static int hpt366_ide_dma_lostirq(ide_drive_t *drive)
+static void hpt366_dma_lost_irq(ide_drive_t *drive)
 {
 	struct pci_dev *dev = HWIF(drive)->pci_dev;
 	u8 mcr1 = 0, mcr3 = 0, scr1 = 0;
@@ -748,7 +748,7 @@ static int hpt366_ide_dma_lostirq(ide_dr
 		drive->name, __FUNCTION__, mcr1, mcr3, scr1);
 	if (scr1 & 0x10)
 		pci_write_config_byte(dev, 0x5a, scr1 & ~0x10);
-	return __ide_dma_lostirq(drive);
+	ide_dma_lost_irq(drive);
 }
 
 static void hpt370_clear_engine(ide_drive_t *drive)
@@ -1354,7 +1354,7 @@ static void __devinit init_hwif_hpt366(i
 		hwif->ide_dma_end	= &hpt370_ide_dma_end;
 		hwif->ide_dma_timeout	= &hpt370_ide_dma_timeout;
 	} else
-		hwif->ide_dma_lostirq	= &hpt366_ide_dma_lostirq;
+		hwif->dma_lost_irq	= &hpt366_dma_lost_irq;
 
 	if (!noautodma)
 		hwif->autodma = 1;
Index: linux-2.6/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/pdc202xx_old.c
+++ linux-2.6/drivers/ide/pci/pdc202xx_old.c
@@ -267,11 +267,14 @@ somebody_else:
 	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
 }
 
-static int pdc202xx_ide_dma_lostirq(ide_drive_t *drive)
+static void pdc202xx_dma_lost_irq(ide_drive_t *drive)
 {
-	if (HWIF(drive)->resetproc != NULL)
-		HWIF(drive)->resetproc(drive);
-	return __ide_dma_lostirq(drive);
+	ide_hwif_t *hwif = HWIF(drive);
+
+	if (hwif->resetproc != NULL)
+		hwif->resetproc(drive);
+
+	ide_dma_lost_irq(drive);
 }
 
 static int pdc202xx_ide_dma_timeout(ide_drive_t *drive)
@@ -347,7 +350,7 @@ static void __devinit init_hwif_pdc202xx
 	hwif->err_stops_fifo = 1;
 
 	hwif->ide_dma_check = &pdc202xx_config_drive_xfer_rate;
-	hwif->ide_dma_lostirq = &pdc202xx_ide_dma_lostirq;
+	hwif->dma_lost_irq = &pdc202xx_dma_lost_irq;
 	hwif->ide_dma_timeout = &pdc202xx_ide_dma_timeout;
 
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
+++ linux-2.6/drivers/ide/pci/sgiioc4.c
@@ -316,14 +316,6 @@ static void sgiioc4_dma_host_off(ide_dri
 	sgiioc4_clearirq(drive);
 }
 
-static int
-sgiioc4_ide_dma_lostirq(ide_drive_t * drive)
-{
-	HWIF(drive)->resetproc(drive);
-
-	return __ide_dma_lostirq(drive);
-}
-
 static void
 sgiioc4_resetproc(ide_drive_t * drive)
 {
@@ -331,6 +323,14 @@ sgiioc4_resetproc(ide_drive_t * drive)
 	sgiioc4_clearirq(drive);
 }
 
+static void
+sgiioc4_dma_lost_irq(ide_drive_t * drive)
+{
+	sgiioc4_resetproc(drive);
+
+	ide_dma_lost_irq(drive);
+}
+
 static u8
 sgiioc4_INB(unsigned long port)
 {
@@ -607,7 +607,7 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
 	hwif->dma_host_on = &sgiioc4_dma_host_on;
 	hwif->dma_host_off = &sgiioc4_dma_host_off;
-	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
+	hwif->dma_lost_irq = &sgiioc4_dma_lost_irq;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 
 	hwif->INB = &sgiioc4_INB;
Index: linux-2.6/drivers/ide/pci/sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sl82c105.c
+++ linux-2.6/drivers/ide/pci/sl82c105.c
@@ -195,7 +195,7 @@ static inline void sl82c105_reset_host(s
  * This function is called when the IDE timer expires, the drive
  * indicates that it is READY, and we were waiting for DMA to complete.
  */
-static int sl82c105_ide_dma_lostirq(ide_drive_t *drive)
+static void sl82c105_dma_lost_irq(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -222,9 +222,6 @@ static int sl82c105_ide_dma_lostirq(ide_
 	}
 
 	sl82c105_reset_host(dev);
-
-	/* __ide_dma_lostirq would return 1, so we do as well */
-	return 1;
 }
 
 /*
@@ -439,7 +436,7 @@ static void __devinit init_hwif_sl82c105
 	hwif->ide_dma_check		= &sl82c105_ide_dma_check;
 	hwif->ide_dma_on		= &sl82c105_ide_dma_on;
 	hwif->dma_off_quietly		= &sl82c105_dma_off_quietly;
-	hwif->ide_dma_lostirq		= &sl82c105_ide_dma_lostirq;
+	hwif->dma_lost_irq		= &sl82c105_dma_lost_irq;
 	hwif->dma_start			= &sl82c105_dma_start;
 	hwif->ide_dma_timeout		= &sl82c105_ide_dma_timeout;
 
Index: linux-2.6/drivers/ide/ppc/pmac.c
===================================================================
--- linux-2.6.orig/drivers/ide/ppc/pmac.c
+++ linux-2.6/drivers/ide/ppc/pmac.c
@@ -2004,20 +2004,19 @@ static void pmac_ide_dma_host_on(ide_dri
 {
 }
 
-static int
-pmac_ide_dma_lostirq (ide_drive_t *drive)
+static void
+pmac_ide_dma_lost_irq (ide_drive_t *drive)
 {
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
 	volatile struct dbdma_regs __iomem *dma;
 	unsigned long status;
 
 	if (pmif == NULL)
-		return 0;
+		return;
 	dma = pmif->dma_regs;
 
 	status = readl(&dma->status);
 	printk(KERN_ERR "ide-pmac lost interrupt, dma status: %lx\n", status);
-	return 0;
 }
 
 /*
@@ -2058,7 +2057,7 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 	hwif->dma_host_off = &pmac_ide_dma_host_off;
 	hwif->dma_host_on = &pmac_ide_dma_host_on;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
-	hwif->ide_dma_lostirq = &pmac_ide_dma_lostirq;
+	hwif->dma_lost_irq = &pmac_ide_dma_lost_irq;
 
 	hwif->atapi_dma = 1;
 	switch(pmif->kind) {
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -735,7 +735,7 @@ typedef struct hwif_s {
 	void (*ide_dma_clear_irq)(ide_drive_t *drive);
 	void (*dma_host_on)(ide_drive_t *drive);
 	void (*dma_host_off)(ide_drive_t *drive);
-	int (*ide_dma_lostirq)(ide_drive_t *drive);
+	void (*dma_lost_irq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
 
 	void (*OUTB)(u8 addr, unsigned long port);
@@ -1303,7 +1303,7 @@ extern int __ide_dma_check(ide_drive_t *
 extern int ide_dma_setup(ide_drive_t *);
 extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
-extern int __ide_dma_lostirq(ide_drive_t *);
+extern void ide_dma_lost_irq(ide_drive_t *);
 extern int __ide_dma_timeout(ide_drive_t *);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 

