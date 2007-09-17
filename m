From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/6] ide: add ->fixup method to ide_hwif_t
Date: Mon, 17 Sep 2007 22:09:31 +0200
Message-ID: <200709172209.31548.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:10981 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756278AbXIQUIZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 16:08:25 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1419915wxd
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 13:08:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add ->fixup method to ide_hwif_t.

* Set hwif->fixup in ide_pci_setup_ports() to d->fixup.

* Use hwif->fixup in probe_hwif().

* Use probe_hwif_init() instead of probe_hwif_init_with_fixup() in
  ide_setup_pci_device().

* Add 'fixup' argument to ide_register_hw() and use it to set hwif->fixup,
  update all ide_register_hw() users accordingly.

* Convert ide-cs/delkin_cb host drivers to use ide_register_hw().

* Restore hwif->fixup in ide_hwif_restore().

* Remove ide_register_hw_with_fixup(), probe_hwif_init_with_fixup()
  and 'fixup' argument from probe_hwif().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/bast-ide.c     |    2 +-
 drivers/ide/arm/ide_arm.c      |    2 +-
 drivers/ide/cris/ide-cris.c    |    2 +-
 drivers/ide/h8300/ide-h8300.c  |    2 +-
 drivers/ide/ide-pnp.c          |    2 +-
 drivers/ide/ide-probe.c        |   17 ++++++-----------
 drivers/ide/ide.c              |   23 +++++++++--------------
 drivers/ide/legacy/buddha.c    |    4 ++--
 drivers/ide/legacy/falconide.c |    2 +-
 drivers/ide/legacy/gayle.c     |    2 +-
 drivers/ide/legacy/ide-cs.c    |    2 +-
 drivers/ide/legacy/macide.c    |    6 +++---
 drivers/ide/legacy/q40ide.c    |    2 +-
 drivers/ide/pci/delkin_cb.c    |    2 +-
 drivers/ide/setup-pci.c        |    6 ++++--
 drivers/macintosh/mediabay.c   |    2 +-
 include/linux/ide.h            |   11 ++++-------
 17 files changed, 39 insertions(+), 50 deletions(-)

Index: b/drivers/ide/arm/bast-ide.c
===================================================================
--- a/drivers/ide/arm/bast-ide.c
+++ b/drivers/ide/arm/bast-ide.c
@@ -45,7 +45,7 @@ bastide_register(unsigned int base, unsi
 	hw.io_ports[IDE_CONTROL_OFFSET] = aux + (6 * 0x20);
 	hw.irq = irq;
 
-	ide_register_hw(&hw, 0, hwif);
+	ide_register_hw(&hw, NULL, 0, hwif);
 
 	return 0;
 }
Index: b/drivers/ide/arm/ide_arm.c
===================================================================
--- a/drivers/ide/arm/ide_arm.c
+++ b/drivers/ide/arm/ide_arm.c
@@ -31,5 +31,5 @@ void __init ide_arm_init(void)
 	memset(&hw, 0, sizeof(hw));
 	ide_std_init_ports(&hw, IDE_ARM_IO, IDE_ARM_IO + 0x206);
 	hw.irq = IDE_ARM_IRQ;
-	ide_register_hw(&hw, 1, NULL);
+	ide_register_hw(&hw, NULL, 1, NULL);
 }
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -782,7 +782,7 @@ init_e100_ide (void)
 		                ide_offsets,
 		                0, 0, cris_ide_ack_intr,
 		                ide_default_irq(0));
-		ide_register_hw(&hw, 1, &hwif);
+		ide_register_hw(&hw, NULL, 1, &hwif);
 		hwif->mmio = 1;
 		hwif->chipset = ide_etrax100;
 		hwif->set_pio_mode = &cris_set_pio_mode;
Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -101,7 +101,7 @@ void __init h8300_ide_init(void)
 	hw_setup(&hw);
 
 	/* register if */
-	idx = ide_register_hw(&hw, 1, &hwif);
+	idx = ide_register_hw(&hw, NULL, 1, &hwif);
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
 
-	index = ide_register_hw(&hw, 1, &hwif);
+	index = ide_register_hw(&hw, NULL, 1, &hwif);
 
 	if (index != -1) {
 	    	printk(KERN_INFO "ide%d: generic PnP IDE interface\n", index);
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -717,7 +717,7 @@ EXPORT_SYMBOL_GPL(ide_undecoded_slave);
  * This routine only knows how to look for drive units 0 and 1
  * on an interface, so any setting of MAX_DRIVES > 2 won't work here.
  */
-static void probe_hwif(ide_hwif_t *hwif, void (*fixup)(ide_hwif_t *hwif))
+static void probe_hwif(ide_hwif_t *hwif)
 {
 	unsigned long flags;
 	unsigned int irqd;
@@ -819,8 +819,8 @@ static void probe_hwif(ide_hwif_t *hwif,
 		return;
 	}
 
-	if (fixup)
-		fixup(hwif);
+	if (hwif->fixup)
+		hwif->fixup(hwif);
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
@@ -861,9 +861,9 @@ static void probe_hwif(ide_hwif_t *hwif,
 static int hwif_init(ide_hwif_t *hwif);
 static void hwif_register_devices(ide_hwif_t *hwif);
 
-int probe_hwif_init_with_fixup(ide_hwif_t *hwif, void (*fixup)(ide_hwif_t *hwif))
+int probe_hwif_init(ide_hwif_t *hwif)
 {
-	probe_hwif(hwif, fixup);
+	probe_hwif(hwif);
 
 	if (!hwif_init(hwif)) {
 		printk(KERN_INFO "%s: failed to initialize IDE interface\n",
@@ -877,11 +877,6 @@ int probe_hwif_init_with_fixup(ide_hwif_
 	return 0;
 }
 
-int probe_hwif_init(ide_hwif_t *hwif)
-{
-	return probe_hwif_init_with_fixup(hwif, NULL);
-}
-
 EXPORT_SYMBOL(probe_hwif_init);
 
 #if MAX_HWIFS > 1
@@ -1394,7 +1389,7 @@ int ideprobe_init (void)
 
 	for (index = 0; index < MAX_HWIFS; ++index)
 		if (probe[index])
-			probe_hwif(&ide_hwifs[index], NULL);
+			probe_hwif(&ide_hwifs[index]);
 	for (index = 0; index < MAX_HWIFS; ++index)
 		if (probe[index])
 			hwif_init(&ide_hwifs[index]);
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -393,6 +393,8 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->cds			= tmp_hwif->cds;
 #endif
 
+	hwif->fixup			= tmp_hwif->fixup;
+
 	hwif->set_pio_mode		= tmp_hwif->set_pio_mode;
 	hwif->set_dma_mode		= tmp_hwif->set_dma_mode;
 	hwif->mdma_filter		= tmp_hwif->mdma_filter;
@@ -662,11 +664,11 @@ void ide_setup_ports (	hw_regs_t *hw,
 }
 
 /**
- *	ide_register_hw_with_fixup	-	register IDE interface
+ *	ide_register_hw		-	register IDE interface
  *	@hw: hardware registers
+ *	@fixup: fixup function
  *	@initializing: set while initializing built-in drivers
  *	@hwifp: pointer to returned hwif
- *	@fixup: fixup function
  *
  *	Register an IDE interface, specifying exactly the registers etc.
  *	Set init=1 iff calling before probes have taken place.
@@ -674,9 +676,8 @@ void ide_setup_ports (	hw_regs_t *hw,
  *	Returns -1 on error.
  */
 
-int ide_register_hw_with_fixup(hw_regs_t *hw, int initializing,
-			       ide_hwif_t **hwifp,
-			       void(*fixup)(ide_hwif_t *hwif))
+int ide_register_hw(hw_regs_t *hw, void (*fixup)(ide_hwif_t *),
+		    int initializing, ide_hwif_t **hwifp)
 {
 	int index, retry = 1;
 	ide_hwif_t *hwif;
@@ -712,11 +713,12 @@ found:
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
 	hwif->irq = hw->irq;
 	hwif->noprobe = 0;
+	hwif->fixup = fixup;
 	hwif->chipset = hw->chipset;
 	hwif->gendev.parent = hw->dev;
 
 	if (!initializing) {
-		probe_hwif_init_with_fixup(hwif, fixup);
+		probe_hwif_init(hwif);
 		ide_proc_register_port(hwif);
 	}
 
@@ -726,13 +728,6 @@ found:
 	return (initializing || hwif->present) ? index : -1;
 }
 
-EXPORT_SYMBOL(ide_register_hw_with_fixup);
-
-int ide_register_hw(hw_regs_t *hw, int initializing, ide_hwif_t **hwifp)
-{
-	return ide_register_hw_with_fixup(hw, initializing, hwifp, NULL);
-}
-
 EXPORT_SYMBOL(ide_register_hw);
 
 /*
@@ -1048,7 +1043,7 @@ int generic_ide_ioctl(ide_drive_t *drive
 			ide_init_hwif_ports(&hw, (unsigned long) args[0],
 					    (unsigned long) args[1], NULL);
 			hw.irq = args[2];
-			if (ide_register_hw(&hw, 0, NULL) == -1)
+			if (ide_register_hw(&hw, NULL, 0, NULL) == -1)
 				return -EIO;
 			return 0;
 		}
Index: b/drivers/ide/legacy/buddha.c
===================================================================
--- a/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -212,8 +212,8 @@ fail_base2:
 //						xsurf_iops,
 						IRQ_AMIGA_PORTS);
 			}	
-			
-			index = ide_register_hw(&hw, 1, &hwif);
+
+			index = ide_register_hw(&hw, NULL, 1, &hwif);
 			if (index != -1) {
 				hwif->mmio = 1;
 				printk("ide%d: ", index);
Index: b/drivers/ide/legacy/falconide.c
===================================================================
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -72,7 +72,7 @@ void __init falconide_init(void)
 			0, 0, NULL,
 //			falconide_iops,
 			IRQ_MFP_IDE);
-	index = ide_register_hw(&hw, 1, NULL);
+	index = ide_register_hw(&hw, NULL, 1, NULL);
 
 	if (index != -1)
 	    printk("ide%d: Falcon IDE interface\n", index);
Index: b/drivers/ide/legacy/gayle.c
===================================================================
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -165,7 +165,7 @@ found:
 //			&gayle_iops,
 			IRQ_AMIGA_PORTS);
 
-	index = ide_register_hw(&hw, 1, &hwif);
+	index = ide_register_hw(&hw, NULL, 1, &hwif);
 	if (index != -1) {
 	    hwif->mmio = 1;
 	    switch (i) {
Index: b/drivers/ide/legacy/ide-cs.c
===================================================================
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -153,7 +153,7 @@ static int idecs_register(unsigned long 
     hw.irq = irq;
     hw.chipset = ide_pci;
     hw.dev = &handle->dev;
-    return ide_register_hw_with_fixup(&hw, 0, NULL, ide_undecoded_slave);
+    return ide_register_hw(&hw, &ide_undecoded_slave, 0, NULL);
 }
 
 /*======================================================================
Index: b/drivers/ide/legacy/macide.c
===================================================================
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -93,21 +93,21 @@ void macide_init(void)
 				0, 0, macide_ack_intr,
 //				quadra_ide_iops,
 				IRQ_NUBUS_F);
-		index = ide_register_hw(&hw, 1, &hwif);
+		index = ide_register_hw(&hw, NULL, 1, &hwif);
 		break;
 	case MAC_IDE_PB:
 		ide_setup_ports(&hw, IDE_BASE, macide_offsets,
 				0, 0, macide_ack_intr,
 //				macide_pb_iops,
 				IRQ_NUBUS_C);
-		index = ide_register_hw(&hw, 1, &hwif);
+		index = ide_register_hw(&hw, NULL, 1, &hwif);
 		break;
 	case MAC_IDE_BABOON:
 		ide_setup_ports(&hw, BABOON_BASE, macide_offsets,
 				0, 0, NULL,
 //				macide_baboon_iops,
 				IRQ_BABOON_1);
-		index = ide_register_hw(&hw, 1, &hwif);
+		index = ide_register_hw(&hw, NULL, 1, &hwif);
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
-	index = ide_register_hw(&hw, 1, &hwif);
+	index = ide_register_hw(&hw, NULL, 1, &hwif);
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
 
-	rc = ide_register_hw_with_fixup(&hw, 0, &hwif, ide_undecoded_slave);
+	rc = ide_register_hw(&hw, &ide_undecoded_slave, 0, &hwif);
 	if (rc < 0) {
 		printk(KERN_ERR "delkin_cb: ide_register_hw failed (%d)\n", rc);
 		pci_disable_device(dev);
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -567,6 +567,8 @@ void ide_pci_setup_ports(struct pci_dev 
 		    (d->host_flags & IDE_HFLAG_FORCE_LEGACY_IRQS))
 			hwif->irq = port ? 15 : 14;
 
+		hwif->fixup = d->fixup;
+
 		hwif->host_flags = d->host_flags;
 		hwif->pio_mask = d->pio_mask;
 
@@ -692,9 +694,9 @@ int ide_setup_pci_device(struct pci_dev 
 		mate = &ide_hwifs[index_list.b.high];
 
 	if (hwif)
-		probe_hwif_init_with_fixup(hwif, d->fixup);
+		probe_hwif_init(hwif);
 	if (mate)
-		probe_hwif_init_with_fixup(mate, d->fixup);
+		probe_hwif_init(mate);
 
 	if (hwif)
 		ide_proc_register_port(hwif);
Index: b/drivers/macintosh/mediabay.c
===================================================================
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -563,7 +563,7 @@ static void media_bay_step(int i)
 				ide_init_hwif_ports(&hw, (unsigned long) bay->cd_base, (unsigned long) 0, NULL);
 				hw.irq = bay->cd_irq;
 				hw.chipset = ide_pmac;
-				bay->cd_index = ide_register_hw(&hw, 0, NULL);
+				bay->cd_index = ide_register_hw(&hw, NULL, 0, NULL);
 				pmu_resume();
 			}
 			if (bay->cd_index == -1) {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -223,12 +223,8 @@ typedef struct hw_regs_s {
 	struct device	*dev;
 } hw_regs_t;
 
-/*
- * Register new hardware with ide
- */
-int ide_register_hw(hw_regs_t *, int, struct hwif_s **);
-int ide_register_hw_with_fixup(hw_regs_t *, int, struct hwif_s **,
-			       void (*)(struct hwif_s *));
+int ide_register_hw(hw_regs_t *, void (*)(struct hwif_s *), int,
+		    struct hwif_s **);
 
 /*
  * Set up hw_regs_t structure before calling ide_register_hw (optional)
@@ -727,6 +723,8 @@ typedef struct hwif_s {
 	u8 (*mdma_filter)(ide_drive_t *);
 	u8 (*udma_filter)(ide_drive_t *);
 
+	void (*fixup)(struct hwif_s *);
+
 	void (*ata_input_data)(ide_drive_t *, void *, u32);
 	void (*ata_output_data)(ide_drive_t *, void *, u32);
 
@@ -1385,7 +1383,6 @@ void ide_unregister_region(struct gendis
 
 void ide_undecoded_slave(ide_hwif_t *);
 
-int probe_hwif_init_with_fixup(ide_hwif_t *, void (*)(ide_hwif_t *));
 extern int probe_hwif_init(ide_hwif_t *);
 
 static inline void *ide_get_hwifdata (ide_hwif_t * hwif)
