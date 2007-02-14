From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/8] ide: add "initializing" argument to ide_register_hw()
Date: Wed, 14 Feb 2007 02:56:59 +0100
Message-ID: <20070214015659.4619.92143.sendpatchset@localhost.localdomain>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:47958 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbXBNBvT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 20:51:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so28283uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2007 17:51:17 -0800 (PST)
In-Reply-To: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[PATCH] ide: add "initializing" argument to ide_register_hw()

Add "initializing" argument to ide_register_hw() and use it instead of ide.c
wide variable of the same name.  Update all users of ide_register_hw()
accordingly.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/arm/bast-ide.c     |    2 +-
 drivers/ide/arm/ide_arm.c      |    2 +-
 drivers/ide/cris/ide-cris.c    |    2 +-
 drivers/ide/h8300/ide-h8300.c  |    2 +-
 drivers/ide/ide-pnp.c          |    2 +-
 drivers/ide/ide.c              |   16 +++++++---------
 drivers/ide/legacy/buddha.c    |    2 +-
 drivers/ide/legacy/falconide.c |    2 +-
 drivers/ide/legacy/gayle.c     |    2 +-
 drivers/ide/legacy/ide-cs.c    |    2 +-
 drivers/ide/legacy/macide.c    |    6 +++---
 drivers/ide/legacy/q40ide.c    |    2 +-
 drivers/ide/pci/delkin_cb.c    |    2 +-
 drivers/macintosh/mediabay.c   |    2 +-
 include/linux/ide.h            |    5 +++--
 15 files changed, 25 insertions(+), 26 deletions(-)

Index: b/drivers/ide/arm/bast-ide.c
===================================================================
--- a/drivers/ide/arm/bast-ide.c
+++ b/drivers/ide/arm/bast-ide.c
@@ -45,7 +45,7 @@ bastide_register(unsigned int base, unsi
 	hw.io_ports[IDE_CONTROL_OFFSET] = aux + (6 * 0x20);
 	hw.irq = irq;
 
-	ide_register_hw(&hw, hwif);
+	ide_register_hw(&hw, 0, hwif);
 
 	return 0;
 }
Index: b/drivers/ide/arm/ide_arm.c
===================================================================
--- a/drivers/ide/arm/ide_arm.c
+++ b/drivers/ide/arm/ide_arm.c
@@ -38,6 +38,6 @@ void __init ide_arm_init(void)
 		memset(&hw, 0, sizeof(hw));
 		ide_std_init_ports(&hw, IDE_ARM_IO, IDE_ARM_IO + 0x206);
 		hw.irq = IDE_ARM_IRQ;
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw, 1, NULL);
 	}
 }
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -797,7 +797,7 @@ init_e100_ide (void)
 		                ide_offsets,
 		                0, 0, cris_ide_ack_intr,
 		                ide_default_irq(0));
-		ide_register_hw(&hw, &hwif);
+		ide_register_hw(&hw, 1, &hwif);
 		hwif->mmio = 1;
 		hwif->chipset = ide_etrax100;
 		hwif->tuneproc = &tune_cris_ide;
Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -101,7 +101,7 @@ void __init h8300_ide_init(void)
 	hw_setup(&hw);
 
 	/* register if */
-	idx = ide_register_hw(&hw, &hwif);
+	idx = ide_register_hw(&hw, 1, &hwif);
 	if (idx == -1) {
 		printk(KERN_ERR "ide-h8300: IDE I/F register failed\n");
 		return;
Index: b/drivers/ide/ide-pnp.c
===================================================================
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -42,7 +42,7 @@ static int idepnp_probe(struct pnp_dev *
 	hw.irq = pnp_irq(dev, 0);
 	hw.dma = NO_DMA;
 
-	index = ide_register_hw(&hw, &hwif);
+	index = ide_register_hw(&hw, 1, &hwif);
 
 	if (index != -1) {
 	    	printk(KERN_INFO "ide%d: generic PnP IDE interface\n", index);
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -170,7 +170,6 @@ static const u8 ide_hwif_to_major[] = { 
 
 static int idebus_parameter;	/* holds the "idebus=" parameter */
 static int system_bus_speed;	/* holds what we think is VESA/PCI bus speed */
-static int initializing;	/* set while initializing built-in drivers */
 
 DECLARE_MUTEX(ide_cfg_sem);
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(ide_lock);
@@ -308,9 +307,7 @@ static void __init init_ide_data (void)
 #endif
 	}
 #ifdef CONFIG_IDE_ARM
-	initializing = 1;
 	ide_arm_init();
-	initializing = 0;
 #endif
 }
 
@@ -755,6 +752,7 @@ void ide_setup_ports (	hw_regs_t *hw,
 /**
  *	ide_register_hw_with_fixup	-	register IDE interface
  *	@hw: hardware registers
+ *	@initializing: set while initializing built-in drivers
  *	@hwifp: pointer to returned hwif
  *	@fixup: fixup function
  *
@@ -764,7 +762,9 @@ void ide_setup_ports (	hw_regs_t *hw,
  *	Returns -1 on error.
  */
 
-int ide_register_hw_with_fixup(hw_regs_t *hw, ide_hwif_t **hwifp, void(*fixup)(ide_hwif_t *hwif))
+int ide_register_hw_with_fixup(hw_regs_t *hw, int initializing,
+			       ide_hwif_t **hwifp,
+			       void(*fixup)(ide_hwif_t *hwif))
 {
 	int index, retry = 1;
 	ide_hwif_t *hwif;
@@ -816,9 +816,9 @@ found:
 
 EXPORT_SYMBOL(ide_register_hw_with_fixup);
 
-int ide_register_hw(hw_regs_t *hw, ide_hwif_t **hwifp)
+int ide_register_hw(hw_regs_t *hw, int initializing, ide_hwif_t **hwifp)
 {
-	return ide_register_hw_with_fixup(hw, hwifp, NULL);
+	return ide_register_hw_with_fixup(hw, initializing, hwifp, NULL);
 }
 
 EXPORT_SYMBOL(ide_register_hw);
@@ -1086,7 +1086,7 @@ int generic_ide_ioctl(ide_drive_t *drive
 			ide_init_hwif_ports(&hw, (unsigned long) args[0],
 					    (unsigned long) args[1], NULL);
 			hw.irq = args[2];
-			if (ide_register_hw(&hw, NULL) == -1)
+			if (ide_register_hw(&hw, 0, NULL) == -1)
 				return -EIO;
 			return 0;
 		}
@@ -1792,10 +1792,8 @@ static int __init ide_init(void)
 		(void)qd65xx_init();
 #endif
 
-	initializing = 1;
 	/* Probe for special PCI and other "known" interface chipsets. */
 	probe_for_hwifs();
-	initializing = 0;
 
 	proc_ide_create();
 
Index: b/drivers/ide/legacy/buddha.c
===================================================================
--- a/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -213,7 +213,7 @@ fail_base2:
 						IRQ_AMIGA_PORTS);
 			}	
 			
-			index = ide_register_hw(&hw, &hwif);
+			index = ide_register_hw(&hw, 1, &hwif);
 			if (index != -1) {
 				hwif->mmio = 1;
 				printk("ide%d: ", index);
Index: b/drivers/ide/legacy/falconide.c
===================================================================
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -70,7 +70,7 @@ void __init falconide_init(void)
 			0, 0, NULL,
 //			falconide_iops,
 			IRQ_MFP_IDE);
-	index = ide_register_hw(&hw, NULL);
+	index = ide_register_hw(&hw, 1, NULL);
 
 	if (index != -1)
 	    printk("ide%d: Falcon IDE interface\n", index);
Index: b/drivers/ide/legacy/gayle.c
===================================================================
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -165,7 +165,7 @@ found:
 //			&gayle_iops,
 			IRQ_AMIGA_PORTS);
 
-	index = ide_register_hw(&hw, &hwif);
+	index = ide_register_hw(&hw, 1, &hwif);
 	if (index != -1) {
 	    hwif->mmio = 1;
 	    switch (i) {
Index: b/drivers/ide/legacy/ide-cs.c
===================================================================
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -154,7 +154,7 @@ static int idecs_register(unsigned long 
     hw.irq = irq;
     hw.chipset = ide_pci;
     hw.dev = &handle->dev;
-    return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
+    return ide_register_hw_with_fixup(&hw, 0, NULL, ide_undecoded_slave);
 }
 
 /*======================================================================
Index: b/drivers/ide/legacy/macide.c
===================================================================
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -102,21 +102,21 @@ void macide_init(void)
 				0, 0, macide_ack_intr,
 //				quadra_ide_iops,
 				IRQ_NUBUS_F);
-		index = ide_register_hw(&hw, &hwif);
+		index = ide_register_hw(&hw, 1, &hwif);
 		break;
 	case MAC_IDE_PB:
 		ide_setup_ports(&hw, IDE_BASE, macide_offsets,
 				0, 0, macide_ack_intr,
 //				macide_pb_iops,
 				IRQ_NUBUS_C);
-		index = ide_register_hw(&hw, &hwif);
+		index = ide_register_hw(&hw, 1, &hwif);
 		break;
 	case MAC_IDE_BABOON:
 		ide_setup_ports(&hw, BABOON_BASE, macide_offsets,
 				0, 0, NULL,
 //				macide_baboon_iops,
 				IRQ_BABOON_1);
-		index = ide_register_hw(&hw, &hwif);
+		index = ide_register_hw(&hw, 1, &hwif);
 		if (index == -1) break;
 		if (macintosh_config->ident == MAC_MODEL_PB190) {
 
Index: b/drivers/ide/legacy/q40ide.c
===================================================================
--- a/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -142,7 +142,7 @@ void q40ide_init(void)
 			0, NULL,
 //			m68kide_iops,
 			q40ide_default_irq(pcide_bases[i]));
-	index = ide_register_hw(&hw, &hwif);
+	index = ide_register_hw(&hw, 1, &hwif);
 	// **FIXME**
 	if (index != -1)
 		hwif->mmio = 1;
Index: b/drivers/ide/pci/delkin_cb.c
===================================================================
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -80,7 +80,7 @@ delkin_cb_probe (struct pci_dev *dev, co
 	hw.irq = dev->irq;
 	hw.chipset = ide_pci;		/* this enables IRQ sharing */
 
-	rc = ide_register_hw_with_fixup(&hw, &hwif, ide_undecoded_slave);
+	rc = ide_register_hw_with_fixup(&hw, 0, &hwif, ide_undecoded_slave);
 	if (rc < 0) {
 		printk(KERN_ERR "delkin_cb: ide_register_hw failed (%d)\n", rc);
 		pci_disable_device(dev);
Index: b/drivers/macintosh/mediabay.c
===================================================================
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -563,7 +563,7 @@ static void media_bay_step(int i)
 				ide_init_hwif_ports(&hw, (unsigned long) bay->cd_base, (unsigned long) 0, NULL);
 				hw.irq = bay->cd_irq;
 				hw.chipset = ide_pmac;
-				bay->cd_index = ide_register_hw(&hw, NULL);
+				bay->cd_index = ide_register_hw(&hw, 0, NULL);
 				pmu_resume();
 			}
 			if (bay->cd_index == -1) {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -223,8 +223,9 @@ typedef struct hw_regs_s {
 /*
  * Register new hardware with ide
  */
-int ide_register_hw(hw_regs_t *hw, struct hwif_s **hwifp);
-int ide_register_hw_with_fixup(hw_regs_t *, struct hwif_s **, void (*)(struct hwif_s *));
+int ide_register_hw(hw_regs_t *, int, struct hwif_s **);
+int ide_register_hw_with_fixup(hw_regs_t *, int, struct hwif_s **,
+			       void (*)(struct hwif_s *));
 
 /*
  * Set up hw_regs_t structure before calling ide_register_hw (optional)
