From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] fix wrong __init usage in IDE PCI drivers
Date: Sun, 9 Jan 2005 14:19:59 +0100
Message-ID: <20050109131959.GA20622@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:53973 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261379AbVAINUD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Jan 2005 08:20:03 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

PCI probe routines (and funcions called by them) must use __devinit
as they can be called from PCI hotplug operations.

While most of the drivers touched in the patch are for hardware that's
soldered on mainboards we now have a fake PCI HP driver that allows
hot remove / replug for them which they need to handle.


--- 1.4/drivers/ide/pci/adma100.c	2003-02-18 19:06:19 +01:00
+++ edited/drivers/ide/pci/adma100.c	2005-01-09 12:55:45 +01:00
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <asm/io.h>
 
-void __init ide_init_adma100 (ide_hwif_t *hwif)
+void __devinit ide_init_adma100 (ide_hwif_t *hwif)
 {
 	unsigned long  phy_admctl = pci_resource_start(hwif->pci_dev, 4) + 0x80 + (hwif->channel * 0x20);
 	void *v_admctl;
===== drivers/ide/pci/alim15x3.c 1.30 vs edited =====
--- 1.30/drivers/ide/pci/alim15x3.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/alim15x3.c	2005-01-09 12:55:45 +01:00
@@ -583,7 +583,7 @@
  *	appropriate also sets up the 1533 southbridge.
  */
   
-static unsigned int __init init_chipset_ali15x3 (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_ali15x3 (struct pci_dev *dev, const char *name)
 {
 	unsigned long flags;
 	u8 tmpbyte;
@@ -677,7 +677,7 @@
  *	FIXME: frobs bits that are not defined on newer ALi devicea
  */
 
-static unsigned int __init ata66_ali15x3 (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_ali15x3 (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
 	unsigned int ata66	= 0;
@@ -748,7 +748,7 @@
  *	Initialize the IDE structure side of the ALi 15x3 driver.
  */
  
-static void __init init_hwif_common_ali15x3 (ide_hwif_t *hwif)
+static void __devinit init_hwif_common_ali15x3 (ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 	hwif->tuneproc = &ali15x3_tune_drive;
@@ -794,7 +794,7 @@
  *	Sparc systems
  */
 
-static void __init init_hwif_ali15x3 (ide_hwif_t *hwif)
+static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
 {
 	u8 ideic, inmir;
 	s8 irq_routing_table[] = { -1,  9, 3, 10, 4,  5, 7,  6,
@@ -847,7 +847,7 @@
  *	the actual work.
  */
 
-static void __init init_dma_ali15x3 (ide_hwif_t *hwif, unsigned long dmabase)
+static void __devinit init_dma_ali15x3 (ide_hwif_t *hwif, unsigned long dmabase)
 {
 	if (m5229_revision < 0x20)
 		return;
===== drivers/ide/pci/amd74xx.c 1.36 vs edited =====
--- 1.36/drivers/ide/pci/amd74xx.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/amd74xx.c	2005-01-09 12:55:45 +01:00
@@ -308,7 +308,7 @@
  * and initialize its drive independent registers.
  */
 
-static unsigned int __init init_chipset_amd74xx(struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_amd74xx(struct pci_dev *dev, const char *name)
 {
 	unsigned char t;
 	unsigned int u;
@@ -412,7 +412,7 @@
 	return dev->irq;
 }
 
-static void __init init_hwif_amd74xx(ide_hwif_t *hwif)
+static void __devinit init_hwif_amd74xx(ide_hwif_t *hwif)
 {
 	int i;
 
===== drivers/ide/pci/cmd640.c 1.10 vs edited =====
--- 1.10/drivers/ide/pci/cmd640.c	2004-10-01 19:55:47 +02:00
+++ edited/drivers/ide/pci/cmd640.c	2005-01-09 12:55:45 +01:00
@@ -278,7 +278,7 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
-static int __init match_pci_cmd640_device (void)
+static int __devinit match_pci_cmd640_device (void)
 {
 	const u8 ven_dev[4] = {0x95, 0x10, 0x40, 0x06};
 	unsigned int i;
@@ -298,7 +298,7 @@
 /*
  * Probe for CMD640x -- pci method 1
  */
-static int __init probe_for_cmd640_pci1 (void)
+static int __devinit probe_for_cmd640_pci1 (void)
 {
 	__get_cmd640_reg = get_cmd640_reg_pci1;
 	__put_cmd640_reg = put_cmd640_reg_pci1;
@@ -314,7 +314,7 @@
 /*
  * Probe for CMD640x -- pci method 2
  */
-static int __init probe_for_cmd640_pci2 (void)
+static int __devinit probe_for_cmd640_pci2 (void)
 {
 	__get_cmd640_reg = get_cmd640_reg_pci2;
 	__put_cmd640_reg = put_cmd640_reg_pci2;
@@ -328,7 +328,7 @@
 /*
  * Probe for CMD640x -- vlb
  */
-static int __init probe_for_cmd640_vlb (void)
+static int __devinit probe_for_cmd640_vlb (void)
 {
 	u8 b;
 
@@ -349,7 +349,7 @@
  *  Returns 1 if an IDE interface/drive exists at 0x170,
  *  Returns 0 otherwise.
  */
-static int __init secondary_port_responding (void)
+static int __devinit secondary_port_responding (void)
 {
 	unsigned long flags;
 
@@ -392,7 +392,7 @@
  * Check whether prefetch is on for a drive,
  * and initialize the unmask flags for safe operation.
  */
-static void __init check_prefetch (unsigned int index)
+static void __devinit check_prefetch (unsigned int index)
 {
 	ide_drive_t *drive = cmd_drives[index];
 	u8 b = get_cmd640_reg(prefetch_regs[index]);
@@ -413,7 +413,7 @@
 /*
  * Figure out which devices we control
  */
-static void __init setup_device_ptrs (void)
+static void __devinit setup_device_ptrs (void)
 {
 	unsigned int i;
 
@@ -495,7 +495,7 @@
 /*
  * This routine retrieves the initial drive timings from the chipset.
  */
-static void __init retrieve_drive_counts (unsigned int index)
+static void __devinit retrieve_drive_counts (unsigned int index)
 {
 	u8 b;
 
@@ -716,7 +716,7 @@
 /*
  * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
  */
-int __init ide_probe_for_cmd640x (void)
+int __devinit ide_probe_for_cmd640x (void)
 {
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	int second_port_toggled = 0;
===== drivers/ide/pci/cs5530.c 1.25 vs edited =====
--- 1.25/drivers/ide/pci/cs5530.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/cs5530.c	2005-01-09 12:55:45 +01:00
@@ -217,7 +217,7 @@
  *	Initialize the cs5530 bridge for reliable IDE DMA operation.
  */
 
-static unsigned int __init init_chipset_cs5530 (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_cs5530 (struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL;
 	unsigned long flags;
@@ -308,7 +308,7 @@
  *	performs channel-specific pre-initialization before drive probing.
  */
 
-static void __init init_hwif_cs5530 (ide_hwif_t *hwif)
+static void __devinit init_hwif_cs5530 (ide_hwif_t *hwif)
 {
 	unsigned long basereg;
 	u32 d0_timings;
===== drivers/ide/pci/cy82c693.c 1.20 vs edited =====
--- 1.20/drivers/ide/pci/cy82c693.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/cy82c693.c	2005-01-09 12:55:45 +01:00
@@ -334,7 +334,7 @@
 /*
  * this function is called during init and is used to setup the cy82c693 chip
  */
-static unsigned int __init init_chipset_cy82c693(struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_cy82c693(struct pci_dev *dev, const char *name)
 {
 	if (PCI_FUNC(dev->devfn) != 1)
 		return 0;
@@ -386,7 +386,7 @@
 /*
  * the init function - called for each ide channel once
  */
-static void __init init_hwif_cy82c693(ide_hwif_t *hwif)
+static void __devinit init_hwif_cy82c693(ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 
@@ -410,9 +410,9 @@
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static __initdata ide_hwif_t *primary;
+static __devinitdata ide_hwif_t *primary;
 
-void __init init_iops_cy82c693(ide_hwif_t *hwif)
+void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
 {
 	if (PCI_FUNC(hwif->pci_dev->devfn) == 1)
 		primary = hwif;
===== drivers/ide/pci/it8172.c 1.22 vs edited =====
--- 1.22/drivers/ide/pci/it8172.c	2004-12-30 20:27:27 +01:00
+++ edited/drivers/ide/pci/it8172.c	2005-01-09 12:55:46 +01:00
@@ -218,7 +218,7 @@
 	return 0;
 }
 
-static unsigned int __init init_chipset_it8172 (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_it8172 (struct pci_dev *dev, const char *name)
 {
 	unsigned char progif;
     
@@ -232,7 +232,7 @@
 }
 
 
-static void __init init_hwif_it8172 (ide_hwif_t *hwif)
+static void __devinit init_hwif_it8172 (ide_hwif_t *hwif)
 {
 	struct pci_dev* dev = hwif->pci_dev;
 	unsigned long cmdBase, ctrlBase;
===== drivers/ide/pci/ns87415.c 1.24 vs edited =====
--- 1.24/drivers/ide/pci/ns87415.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/ns87415.c	2005-01-09 12:55:46 +01:00
@@ -195,7 +195,7 @@
 	return __ide_dma_check(drive);
 }
 
-static void __init init_hwif_ns87415 (ide_hwif_t *hwif)
+static void __devinit init_hwif_ns87415 (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 	unsigned int ctrl, using_inta;
===== drivers/ide/pci/opti621.c 1.20 vs edited =====
--- 1.20/drivers/ide/pci/opti621.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/opti621.c	2005-01-09 12:56:08 +01:00
@@ -328,7 +328,7 @@
 /*
  * init_hwif_opti621() is called once for each hwif found at boot.
  */
-static void __init init_hwif_opti621 (ide_hwif_t *hwif)
+static void __devinit init_hwif_opti621 (ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 	hwif->drives[0].drive_data = PIO_DONT_KNOW;
@@ -348,7 +348,7 @@
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static int __init init_setup_opti621 (struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_opti621 (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	return ide_setup_pci_device(dev, d);
 }
===== drivers/ide/pci/sc1200.c 1.23 vs edited =====
--- 1.23/drivers/ide/pci/sc1200.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/sc1200.c	2005-01-09 12:55:46 +01:00
@@ -459,7 +459,7 @@
  * This gets invoked by the IDE driver once for each channel,
  * and performs channel-specific pre-initialization before drive probing.
  */
-static void __init init_hwif_sc1200 (ide_hwif_t *hwif)
+static void __devinit init_hwif_sc1200 (ide_hwif_t *hwif)
 {
 	if (hwif->mate)
 		hwif->serialized = hwif->mate->serialized = 1;
===== drivers/ide/pci/serverworks.c 1.34 vs edited =====
--- 1.34/drivers/ide/pci/serverworks.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/serverworks.c	2005-01-09 12:57:01 +01:00
@@ -330,7 +330,7 @@
 	return __ide_dma_end(drive);
 }
 
-static unsigned int __init init_chipset_svwks (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_svwks (struct pci_dev *dev, const char *name)
 {
 	unsigned int reg;
 	u8 btr;
@@ -431,7 +431,7 @@
 	return (dev->irq) ? dev->irq : 0;
 }
 
-static unsigned int __init ata66_svwks_svwks (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks_svwks (ide_hwif_t *hwif)
 {
 	return 1;
 }
@@ -443,7 +443,7 @@
  * Bit 14 clear = primary IDE channel does not have 80-pin cable.
  * Bit 14 set   = primary IDE channel has 80-pin cable.
  */
-static unsigned int __init ata66_svwks_dell (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks_dell (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_DELL &&
@@ -461,7 +461,7 @@
  *
  * WARNING: this only works on Alpine hardware!
  */
-static unsigned int __init ata66_svwks_cobalt (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks_cobalt (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_SUN &&
@@ -472,7 +472,7 @@
 	return 0;
 }
 
-static unsigned int __init ata66_svwks (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 
@@ -497,7 +497,7 @@
 }
 
 #undef CAN_SW_DMA
-static void __init init_hwif_svwks (ide_hwif_t *hwif)
+static void __devinit init_hwif_svwks (ide_hwif_t *hwif)
 {
 	u8 dma_stat = 0;
 
@@ -545,7 +545,7 @@
 /*
  * We allow the BM-DMA driver to only work on enabled interfaces.
  */
-static void __init init_dma_svwks (ide_hwif_t *hwif, unsigned long dmabase)
+static void __devinit init_dma_svwks (ide_hwif_t *hwif, unsigned long dmabase)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 
@@ -557,12 +557,12 @@
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static int __init init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	return ide_setup_pci_device(dev, d);
 }
 
-static int __init init_setup_csb6 (struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_csb6 (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	if (!(PCI_FUNC(dev->devfn) & 1)) {
 		d->bootable = NEVER_BOARD;
===== drivers/ide/pci/sis5513.c 1.32 vs edited =====
--- 1.32/drivers/ide/pci/sis5513.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/sis5513.c	2005-01-09 12:55:46 +01:00
@@ -726,7 +726,7 @@
 */
 
 /* Chip detection and general config */
-static unsigned int __init init_chipset_sis5513 (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_sis5513 (struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *host;
 	int i = 0;
@@ -879,7 +879,7 @@
 	return 0;
 }
 
-static unsigned int __init ata66_sis5513 (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_sis5513 (ide_hwif_t *hwif)
 {
 	u8 ata66 = 0;
 
@@ -897,7 +897,7 @@
         return ata66;
 }
 
-static void __init init_hwif_sis5513 (ide_hwif_t *hwif)
+static void __devinit init_hwif_sis5513 (ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 
===== drivers/ide/pci/sl82c105.c 1.23 vs edited =====
--- 1.23/drivers/ide/pci/sl82c105.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/sl82c105.c	2005-01-09 12:55:47 +01:00
@@ -386,7 +386,7 @@
  * channel 0 here at least, but channel 1 has to be enabled by
  * firmware or arch code. We still set both to 16 bits mode.
  */
-static unsigned int __init init_chipset_sl82c105(struct pci_dev *dev, const char *msg)
+static unsigned int __devinit init_chipset_sl82c105(struct pci_dev *dev, const char *msg)
 {
 	u32 val;
 
@@ -399,7 +399,7 @@
 	return dev->irq;
 }
 
-static void __init init_dma_sl82c105(ide_hwif_t *hwif, unsigned long dma_base)
+static void __devinit init_dma_sl82c105(ide_hwif_t *hwif, unsigned long dma_base)
 {
 	unsigned int rev;
 	u8 dma_state;
@@ -431,7 +431,7 @@
  * Initialise the chip
  */
 
-static void __init init_hwif_sl82c105(ide_hwif_t *hwif)
+static void __devinit init_hwif_sl82c105(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 	u32 val;
===== drivers/ide/pci/slc90e66.c 1.26 vs edited =====
--- 1.26/drivers/ide/pci/slc90e66.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/slc90e66.c	2005-01-09 12:55:47 +01:00
@@ -196,7 +196,7 @@
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
-static void __init init_hwif_slc90e66 (ide_hwif_t *hwif)
+static void __devinit init_hwif_slc90e66 (ide_hwif_t *hwif)
 {
 	u8 reg47 = 0;
 	u8 mask = hwif->channel ? 0x01 : 0x02;  /* bit0:Primary */
===== drivers/ide/pci/triflex.c 1.13 vs edited =====
--- 1.13/drivers/ide/pci/triflex.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/triflex.c	2005-01-09 12:55:47 +01:00
@@ -130,7 +130,7 @@
 	return hwif->ide_dma_off_quietly(drive);
 }
 
-static void __init init_hwif_triflex(ide_hwif_t *hwif)
+static void __devinit init_hwif_triflex(ide_hwif_t *hwif)
 {
 	hwif->tuneproc = &triflex_tune_drive;
 	hwif->speedproc = &triflex_tune_chipset;
===== drivers/ide/pci/via82cxxx.c 1.25 vs edited =====
--- 1.25/drivers/ide/pci/via82cxxx.c	2004-12-29 23:58:32 +01:00
+++ edited/drivers/ide/pci/via82cxxx.c	2005-01-09 12:55:47 +01:00
@@ -414,7 +414,7 @@
  *	and initialize its drive independent registers.
  */
 
-static unsigned int __init init_chipset_via82cxxx(struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_via82cxxx(struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *isa = NULL;
 	u8 t, v;
@@ -575,7 +575,7 @@
 	return 0;
 }
 
-static void __init init_hwif_via82cxxx(ide_hwif_t *hwif)
+static void __devinit init_hwif_via82cxxx(ide_hwif_t *hwif)
 {
 	int i;
 
===== drivers/net/8139too.c 1.101 vs edited =====
