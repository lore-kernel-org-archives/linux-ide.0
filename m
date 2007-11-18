From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/21] ide: drop 'initializing' argument from ide_register_hw()
Date: Sun, 18 Nov 2007 23:31:23 +0100
Message-ID: <200711182331.23988.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:49042 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbXKRWgt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:49 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873055ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:48 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>


* Rename init_hwif_data() to ide_init_port_data() and export it.

* For all users of ide_register_hw() with 'initializing' argument set
  hwif->present and hwif->hold are always zero so convert these host
  drivers to use ide_find_port()+ide_init_port_data()+ide_init_port_hw()
  instead (also no need for init_hwif_default() call since the setup
  done by it gets over-ridden by ide_init_port_data() call).

* Drop 'initializing' argument from ide_register_hw().

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/bast-ide.c     |    2 +-
 drivers/ide/arm/ide_arm.c      |    8 +++++++-
 drivers/ide/cris/ide-cris.c    |    4 +++-
 drivers/ide/h8300/ide-h8300.c  |   11 +++++++----
 drivers/ide/ide-pnp.c          |   11 +++++++----
 drivers/ide/ide.c              |   33 +++++++++++----------------------
 drivers/ide/legacy/buddha.c    |   11 ++++++++---
 drivers/ide/legacy/falconide.c |   14 +++++++++-----
 drivers/ide/legacy/gayle.c     |   10 +++++++---
 drivers/ide/legacy/ide-cs.c    |    2 +-
 drivers/ide/legacy/macide.c    |   29 ++++++++++++++---------------
 drivers/ide/legacy/q40ide.c    |   10 ++++++----
 drivers/ide/pci/delkin_cb.c    |    2 +-
 drivers/macintosh/mediabay.c   |    3 ++-
 include/linux/ide.h            |    3 ++-
 15 files changed, 86 insertions(+), 67 deletions(-)

Index: b/drivers/ide/arm/bast-ide.c
===================================================================
--- a/drivers/ide/arm/bast-ide.c
+++ b/drivers/ide/arm/bast-ide.c
@@ -45,7 +45,7 @@ bastide_register(unsigned int base, unsi
 	hw.io_ports[IDE_CONTROL_OFFSET] = aux + (6 * 0x20);
 	hw.irq = irq;
 
-	ide_register_hw(&hw, NULL, 0, hwif);
+	ide_register_hw(&hw, NULL, hwif);
 
 	return 0;
 }
Index: b/drivers/ide/arm/ide_arm.c
===================================================================
--- a/drivers/ide/arm/ide_arm.c
+++ b/drivers/ide/arm/ide_arm.c
@@ -26,10 +26,16 @@
 
 void __init ide_arm_init(void)
 {
+	ide_hwif_t *hwif;
 	hw_regs_t hw;
 
 	memset(&hw, 0, sizeof(hw));
 	ide_std_init_ports(&hw, IDE_ARM_IO, IDE_ARM_IO + 0x206);
 	hw.irq = IDE_ARM_IRQ;
-	ide_register_hw(&hw, NULL, 1, NULL);
+
+	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif) {
+		ide_init_port_data(hwif, hwif->index);
+		ide_init_port_hw(hwif, &hw);
+	}
 }
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -777,9 +777,11 @@ init_e100_ide (void)
 		                ide_offsets,
 		                0, 0, cris_ide_ack_intr,
 		                ide_default_irq(0));
-		ide_register_hw(&hw, NULL, 1, &hwif);
+		hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
 		if (hwif == NULL)
 			continue;
+		ide_init_port_data(hwif, hwif->index);
+		ide_init_port_hw(hwif, &hw);
 		hwif->mmio = 1;
 		hwif->chipset = ide_etrax100;
 		hwif->set_pio_mode = &cris_set_pio_mode;
Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -88,7 +88,7 @@ void __init h8300_ide_init(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
-	int idx;
+	int index;
 
 	if (!request_region(CONFIG_H8300_IDE_BASE, H8300_IDE_GAP*8, "ide-h8300"))
 		goto out_busy;
@@ -100,14 +100,17 @@ void __init h8300_ide_init(void)
 	hw_setup(&hw);
 
 	/* register if */
-	idx = ide_register_hw(&hw, NULL, 1, &hwif);
-	if (idx == -1) {
+	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif == NULL) {
 		printk(KERN_ERR "ide-h8300: IDE I/F register failed\n");
 		return;
 	}
 
+	index = hwif->index;
+	ide_init_port_data(hwif, index);
+	ide_init_port_hw(hwif, &hw);
 	hwif_setup(hwif);
-	printk(KERN_INFO "ide%d: H8/300 generic IDE interface\n", idx);
+	printk(KERN_INFO "ide%d: H8/300 generic IDE interface\n", index);
 	return;
 
 out_busy:
Index: b/drivers/ide/ide-pnp.c
===================================================================
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -31,7 +31,6 @@ static int idepnp_probe(struct pnp_dev *
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
-	int index;
 
 	if (!(pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) && pnp_irq_valid(dev, 0)))
 		return -1;
@@ -41,10 +40,14 @@ static int idepnp_probe(struct pnp_dev *
 				pnp_port_start(dev, 1));
 	hw.irq = pnp_irq(dev, 0);
 
-	index = ide_register_hw(&hw, NULL, 1, &hwif);
+	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif) {
+		u8 index = hwif->index;
+
+		ide_init_port_data(hwif, index);
+		ide_init_port_hw(hwif, &hw);
 
-	if (index != -1) {
-	    	printk(KERN_INFO "ide%d: generic PnP IDE interface\n", index);
+		printk(KERN_INFO "ide%d: generic PnP IDE interface\n", index);
 		pnp_set_drvdata(dev,hwif);
 		return 0;
 	}
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -116,7 +116,7 @@ EXPORT_SYMBOL(ide_hwifs);
 /*
  * Do not even *think* about calling this!
  */
-static void init_hwif_data(ide_hwif_t *hwif, unsigned int index)
+void ide_init_port_data(ide_hwif_t *hwif, unsigned int index)
 {
 	unsigned int unit;
 
@@ -159,6 +159,7 @@ static void init_hwif_data(ide_hwif_t *h
 		init_completion(&drive->gendev_rel_comp);
 	}
 }
+EXPORT_SYMBOL_GPL(ide_init_port_data);
 
 static void init_hwif_default(ide_hwif_t *hwif, unsigned int index)
 {
@@ -210,7 +211,7 @@ static void __init init_ide_data (void)
 	/* Initialise all interface structures */
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		hwif = &ide_hwifs[index];
-		init_hwif_data(hwif, index);
+		ide_init_port_data(hwif, index);
 		init_hwif_default(hwif, index);
 #if !defined(CONFIG_PPC32) || !defined(CONFIG_PCI)
 		hwif->irq =
@@ -609,7 +610,7 @@ void ide_unregister(unsigned int index)
 	tmp_hwif = *hwif;
 
 	/* restore hwif data to pristine status */
-	init_hwif_data(hwif, index);
+	ide_init_port_data(hwif, index);
 	init_hwif_default(hwif, index);
 
 	ide_hwif_restore(hwif, &tmp_hwif);
@@ -690,29 +691,19 @@ EXPORT_SYMBOL_GPL(ide_init_port_hw);
  *	ide_register_hw		-	register IDE interface
  *	@hw: hardware registers
  *	@quirkproc: quirkproc function
- *	@initializing: set while initializing built-in drivers
  *	@hwifp: pointer to returned hwif
  *
  *	Register an IDE interface, specifying exactly the registers etc.
- *	Set init=1 iff calling before probes have taken place.
  *
  *	Returns -1 on error.
  */
 
 int ide_register_hw(hw_regs_t *hw, void (*quirkproc)(ide_drive_t *),
-		    int initializing, ide_hwif_t **hwifp)
+		    ide_hwif_t **hwifp)
 {
 	int index, retry = 1;
 	ide_hwif_t *hwif;
-
-	if (initializing) {
-		hwif = ide_find_port(hw->io_ports[IDE_DATA_OFFSET]);
-		if (hwif) {
-			index = hwif->index;
-			goto found;
-		}
-		return -1;
-	}
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	do {
 		for (index = 0; index < MAX_HWIFS; ++index) {
@@ -735,7 +726,7 @@ found:
 	if (hwif->present)
 		ide_unregister(index);
 	else if (!hwif->hold) {
-		init_hwif_data(hwif, index);
+		ide_init_port_data(hwif, index);
 		init_hwif_default(hwif, index);
 	}
 	if (hwif->present)
@@ -744,16 +735,14 @@ found:
 	ide_init_port_hw(hwif, hw);
 	hwif->quirkproc = quirkproc;
 
-	if (initializing == 0) {
-		u8 idx[4] = { index, 0xff, 0xff, 0xff };
+	idx[0] = index;
 
-		ide_device_add(idx);
-	}
+	ide_device_add(idx);
 
 	if (hwifp)
 		*hwifp = hwif;
 
-	return (initializing || hwif->present) ? index : -1;
+	return hwif->present ? index : -1;
 }
 
 EXPORT_SYMBOL(ide_register_hw);
@@ -1070,7 +1059,7 @@ int generic_ide_ioctl(ide_drive_t *drive
 			ide_init_hwif_ports(&hw, (unsigned long) args[0],
 					    (unsigned long) args[1], NULL);
 			hw.irq = args[2];
-			if (ide_register_hw(&hw, NULL, 0, NULL) == -1)
+			if (ide_register_hw(&hw, NULL, NULL) == -1)
 				return -EIO;
 			return 0;
 		}
Index: b/drivers/ide/legacy/buddha.c
===================================================================
--- a/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -147,7 +147,7 @@ void __init buddha_init(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
-	int i, index;
+	int i;
 
 	struct zorro_dev *z = NULL;
 	u_long buddha_board = 0;
@@ -213,8 +213,13 @@ fail_base2:
 						IRQ_AMIGA_PORTS);
 			}	
 
-			index = ide_register_hw(&hw, NULL, 1, &hwif);
-			if (index != -1) {
+			hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+			if (hwif) {
+				u8 index = hwif->index;
+
+				ide_init_port_data(hwif, index);
+				ide_init_port_hw(hwif, &hw);
+
 				hwif->mmio = 1;
 				printk("ide%d: ", index);
 				switch(type) {
Index: b/drivers/ide/legacy/falconide.c
===================================================================
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -66,15 +66,19 @@ void __init falconide_init(void)
 {
     if (MACH_IS_ATARI && ATARIHW_PRESENT(IDE)) {
 	hw_regs_t hw;
-	int index;
 
 	ide_setup_ports(&hw, ATA_HD_BASE, falconide_offsets,
 			0, 0, NULL,
 //			falconide_iops,
 			IRQ_MFP_IDE);
-	index = ide_register_hw(&hw, NULL, 1, NULL);
 
-	if (index != -1)
-	    printk("ide%d: Falcon IDE interface\n", index);
-    }
+	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif) {
+		u8 index = hwif->index;
+
+		ide_init_port_data(hwif, index);
+		ide_init_port_hw(hwif, &hw);
+
+		printk("ide%d: Falcon IDE interface\n", index);
+	}
 }
Index: b/drivers/ide/legacy/gayle.c
===================================================================
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -133,7 +133,6 @@ found:
 	ide_ack_intr_t *ack_intr;
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
-	int index;
 	unsigned long phys_base, res_start, res_n;
 
 	if (a4000) {
@@ -165,8 +164,13 @@ found:
 //			&gayle_iops,
 			IRQ_AMIGA_PORTS);
 
-	index = ide_register_hw(&hw, NULL, 1, &hwif);
-	if (index != -1) {
+	hwif = ide_find_port(base);
+	if (hwif) {
+	    u8 index = hwif->index;
+
+	    ide_init_port_data(hwif, index);
+	    ide_init_port_hw(hwif, &hw);
+
 	    hwif->mmio = 1;
 	    switch (i) {
 		case 0:
Index: b/drivers/ide/legacy/ide-cs.c
===================================================================
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -153,7 +153,7 @@ static int idecs_register(unsigned long 
     hw.irq = irq;
     hw.chipset = ide_pci;
     hw.dev = &handle->dev;
-    return ide_register_hw(&hw, &ide_undecoded_slave, 0, NULL);
+    return ide_register_hw(&hw, &ide_undecoded_slave, NULL);
 }
 
 /*======================================================================
Index: b/drivers/ide/legacy/macide.c
===================================================================
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -85,7 +85,6 @@ void macide_init(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
-	int index = -1;
 
 	switch (macintosh_config->ide_type) {
 	case MAC_IDE_QUADRA:
@@ -93,40 +92,40 @@ void macide_init(void)
 				0, 0, macide_ack_intr,
 //				quadra_ide_iops,
 				IRQ_NUBUS_F);
-		index = ide_register_hw(&hw, NULL, 1, &hwif);
 		break;
 	case MAC_IDE_PB:
 		ide_setup_ports(&hw, IDE_BASE, macide_offsets,
 				0, 0, macide_ack_intr,
 //				macide_pb_iops,
 				IRQ_NUBUS_C);
-		index = ide_register_hw(&hw, NULL, 1, &hwif);
 		break;
 	case MAC_IDE_BABOON:
 		ide_setup_ports(&hw, BABOON_BASE, macide_offsets,
 				0, 0, NULL,
 //				macide_baboon_iops,
 				IRQ_BABOON_1);
-		index = ide_register_hw(&hw, NULL, 1, &hwif);
-		if (index == -1) break;
-		if (macintosh_config->ident == MAC_MODEL_PB190) {
+		break;
+	default:
+		return;
+	}
 
+	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif) {
+		u8 index = hwif->index;
+
+		ide_init_port_data(hwif, index);
+		ide_init_port_hw(hwif, &hw);
+
+		if (macintosh_config->ide_type == MAC_IDE_BABOON &&
+		    macintosh_config->ident == MAC_MODEL_PB190) {
 			/* Fix breakage in ide-disk.c: drive capacity	*/
 			/* is not initialized for drives without a 	*/
 			/* hardware ID, and we can't get that without	*/
 			/* probing the drive which freezes a 190.	*/
-
-			ide_drive_t *drive = &ide_hwifs[index].drives[0];
+			ide_drive_t *drive = &hwif->drives[0];
 			drive->capacity64 = drive->cyl*drive->head*drive->sect;
-
 		}
-		break;
-
-	default:
-	    return;
-	}
 
-        if (index != -1) {
 		hwif->mmio = 1;
 		if (macintosh_config->ide_type == MAC_IDE_QUADRA)
 			printk(KERN_INFO "ide%d: Macintosh Quadra IDE interface\n", index);
Index: b/drivers/ide/legacy/q40ide.c
===================================================================
--- a/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -115,7 +115,6 @@ void q40ide_init(void)
 {
     int i;
     ide_hwif_t *hwif;
-    int index;
     const char *name;
 
     if (!MACH_IS_Q40)
@@ -141,10 +140,13 @@ void q40ide_init(void)
 			0, NULL,
 //			m68kide_iops,
 			q40ide_default_irq(pcide_bases[i]));
-	index = ide_register_hw(&hw, NULL, 1, &hwif);
-	// **FIXME**
-	if (index != -1)
+
+	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif) {
+		ide_init_port_data(hwif, hwif->index);
+		ide_init_port_hw(hwif, &hw);
 		hwif->mmio = 1;
+	}
     }
 }
 
Index: b/drivers/ide/pci/delkin_cb.c
===================================================================
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -80,7 +80,7 @@ delkin_cb_probe (struct pci_dev *dev, co
 	hw.irq = dev->irq;
 	hw.chipset = ide_pci;		/* this enables IRQ sharing */
 
-	rc = ide_register_hw(&hw, &ide_undecoded_slave, 0, &hwif);
+	rc = ide_register_hw(&hw, &ide_undecoded_slave, &hwif);
 	if (rc < 0) {
 		printk(KERN_ERR "delkin_cb: ide_register_hw failed (%d)\n", rc);
 		pci_disable_device(dev);
Index: b/drivers/macintosh/mediabay.c
===================================================================
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -563,7 +563,8 @@ static void media_bay_step(int i)
 				ide_init_hwif_ports(&hw, (unsigned long) bay->cd_base, (unsigned long) 0, 
NULL);
 				hw.irq = bay->cd_irq;
 				hw.chipset = ide_pmac;
-				bay->cd_index = ide_register_hw(&hw, NULL, 0, NULL);
+				bay->cd_index =
+					ide_register_hw(&hw, NULL, NULL);
 				pmu_resume();
 			}
 			if (bay->cd_index == -1) {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -198,10 +198,11 @@ typedef struct hw_regs_s {
 } hw_regs_t;
 
 struct hwif_s * ide_find_port(unsigned long);
+void ide_init_port_data(struct hwif_s *, unsigned int);
 void ide_init_port_hw(struct hwif_s *, hw_regs_t *);
 
 struct ide_drive_s;
-int ide_register_hw(hw_regs_t *, void (*)(struct ide_drive_s *), int,
+int ide_register_hw(hw_regs_t *, void (*)(struct ide_drive_s *),
 		    struct hwif_s **);
 
 void ide_setup_ports(	hw_regs_t *hw,
