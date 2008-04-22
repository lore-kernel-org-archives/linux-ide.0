From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] siimage: coding style cleanup (take 2)
Date: Tue, 22 Apr 2008 20:56:38 +0400
Message-ID: <200804222056.38802.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:21939 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755087AbYDVQ5Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2008 12:57:16 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Fix 18 errors and several warnings given by checkpatch.pl:

- use of C99 // comments;

- trailing whitespace;

- 'switch' and 'case' not at the same indentation level;

- no space before the open parenthesis of the 'if' and 'switch' statements;

- space between function name and open parenthesis (though I have introduced
  such warnins in some places since the code looks prettier with the spaces);

- including <asm/io.h> instead of <linux/io.h>;

- line over 80 characters.

In addition to these changes, also do the following:

- make the arrays in sil_set_pio_mode() 'static', and make the arrays in
  sil_set_dma_mode() 'static const';

- change the string of the 'if' statements into the 'switch' statement in
  sil_pata_udma_filter();

- drop the needless '==' operators from the 'if' statements where a condition
  is a mere bit test;

- remove needless initializer for the 'tmp' variable in init_chipset_siimage();

- beautify groups of the variable initializers and assignment operators;

- add new line after variable definitions;

- remove new line between the comment and the statements it refers to;

- remove needless curly braces and parentheses;

- fix typos, capitalize acronyms, etc. in the comments...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Fixed several mode typos in the comments.
The patch is aginst the top of the pata-2.6 patchset...

 drivers/ide/pci/siimage.c |  232 ++++++++++++++++++++++------------------------
 1 files changed, 113 insertions(+), 119 deletions(-)

Index: linux-2.6/drivers/ide/pci/siimage.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/siimage.c
+++ linux-2.6/drivers/ide/pci/siimage.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2003		Red Hat <alan@redhat.com>
- * Copyright (C) 2007		MontaVista Software, Inc.
+ * Copyright (C) 2007-2008	MontaVista Software, Inc.
  * Copyright (C) 2007-2008	Bartlomiej Zolnierkiewicz
  *
  *  May be copied or modified under the terms of the GNU General Public License
@@ -17,10 +17,10 @@
  *
  *  FAQ Items:
  *	If you are using Marvell SATA-IDE adapters with Maxtor drives
- *	ensure the system is set up for ATA100/UDMA5 not UDMA6.
+ *	ensure the system is set up for ATA100/UDMA5, not UDMA6.
  *
  *	If you are using WD drives with SATA bridges you must set the
- *	drive to "Single". "Master" will hang
+ *	drive to "Single". "Master" will hang.
  *
  *	If you have strange problems with nVidia chipset systems please
  *	see the SI support documentation and update your system BIOS
@@ -42,25 +42,24 @@
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/init.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
 
 /**
  *	pdev_is_sata		-	check if device is SATA
  *	@pdev:	PCI device to check
- *	
+ *
  *	Returns true if this is a SATA controller
  */
- 
+
 static int pdev_is_sata(struct pci_dev *pdev)
 {
 #ifdef CONFIG_BLK_DEV_IDE_SATA
-	switch(pdev->device) {
-		case PCI_DEVICE_ID_SII_3112:
-		case PCI_DEVICE_ID_SII_1210SA:
-			return 1;
-		case PCI_DEVICE_ID_SII_680:
-			return 0;
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_SII_3112:
+	case PCI_DEVICE_ID_SII_1210SA:
+		return 1;
+	case PCI_DEVICE_ID_SII_680:
+		return 0;
 	}
 	BUG();
 #endif
@@ -70,10 +69,10 @@ static int pdev_is_sata(struct pci_dev *
 /**
  *	is_sata			-	check if hwif is SATA
  *	@hwif:	interface to check
- *	
+ *
  *	Returns true if this is a SATA controller
  */
- 
+
 static inline int is_sata(ide_hwif_t *hwif)
 {
 	return pdev_is_sata(to_pci_dev(hwif->dev));
@@ -86,21 +85,22 @@ static inline int is_sata(ide_hwif_t *hw
  *
  *	Turn a config register offset into the right address in either
  *	PCI space or MMIO space to access the control register in question
- *	Thankfully this is a configuration operation so isnt performance
- *	criticial. 
+ *	Thankfully this is a configuration operation, so isn't performance
+ *	critical.
  */
- 
+
 static unsigned long siimage_selreg(ide_hwif_t *hwif, int r)
 {
 	unsigned long base = (unsigned long)hwif->hwif_data;
+
 	base += 0xA0 + r;
-	if(hwif->mmio)
-		base += (hwif->channel << 6);
+	if (hwif->mmio)
+		base += hwif->channel << 6;
 	else
-		base += (hwif->channel << 4);
+		base += hwif->channel << 4;
 	return base;
 }
-	
+
 /**
  *	siimage_seldev		-	return register base
  *	@hwif: interface
@@ -110,16 +110,17 @@ static unsigned long siimage_selreg(ide_
  *	PCI space or MMIO space to access the control register in question
  *	including accounting for the unit shift.
  */
- 
+
 static inline unsigned long siimage_seldev(ide_drive_t *drive, int r)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	unsigned long base = (unsigned long)hwif->hwif_data;
+	unsigned long base	= (unsigned long)hwif->hwif_data;
+
 	base += 0xA0 + r;
-	if(hwif->mmio)
-		base += (hwif->channel << 6);
+	if (hwif->mmio)
+		base += hwif->channel << 6;
 	else
-		base += (hwif->channel << 4);
+		base += hwif->channel << 4;
 	base |= drive->select.b.unit << drive->select.b.unit;
 	return base;
 }
@@ -184,21 +185,26 @@ static void sil_iowrite32(struct pci_dev
 
 static u8 sil_pata_udma_filter(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = drive->hwif;
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	unsigned long base = (unsigned long) hwif->hwif_data;
-	u8 mask = 0, scsc;
+	ide_hwif_t *hwif	= drive->hwif;
+	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	unsigned long base	= (unsigned long)hwif->hwif_data;
+	u8 scsc, mask		= 0;
 
 	scsc = sil_ioread8(dev, base + (hwif->mmio ? 0x4A : 0x8A));
 
-	if ((scsc & 0x30) == 0x10)	/* 133 */
+	switch (scsc & 0x30) {
+	case 0x10:	/* 133 */
 		mask = ATA_UDMA6;
-	else if ((scsc & 0x30) == 0x20)	/* 2xPCI */
+		break;
+	case 0x20:	/* 2xPCI */
 		mask = ATA_UDMA6;
-	else if ((scsc & 0x30) == 0x00)	/* 100 */
+		break;
+	case 0x00:	/* 100 */
 		mask = ATA_UDMA5;
-	else 	/* Disabled ? */
+		break;
+	default: 	/* Disabled ? */
 		BUG();
+	}
 
 	return mask;
 }
@@ -220,8 +226,8 @@ static u8 sil_sata_udma_filter(ide_drive
 
 static void sil_set_pio_mode(ide_drive_t *drive, u8 pio)
 {
-	const u16 tf_speed[]	= { 0x328a, 0x2283, 0x1281, 0x10c3, 0x10c1 };
-	const u16 data_speed[]	= { 0x328a, 0x2283, 0x1104, 0x10c3, 0x10c1 };
+	static const u16 tf_speed[]   = { 0x328a, 0x2283, 0x1281, 0x10c3, 0x10c1 };
+	static const u16 data_speed[] = { 0x328a, 0x2283, 0x1104, 0x10c3, 0x10c1 };
 
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
@@ -229,7 +235,7 @@ static void sil_set_pio_mode(ide_drive_t
 	u32 speedt		= 0;
 	u16 speedp		= 0;
 	unsigned long addr	= siimage_seldev(drive, 0x04);
-	unsigned long tfaddr	= siimage_selreg(hwif, 0x02);
+	unsigned long tfaddr	= siimage_selreg(hwif,	0x02);
 	unsigned long base	= (unsigned long)hwif->hwif_data;
 	u8 tf_pio		= pio;
 	u8 addr_mask		= hwif->channel ? (hwif->mmio ? 0xF4 : 0x84)
@@ -261,7 +267,7 @@ static void sil_set_pio_mode(ide_drive_t
 
 	mode = sil_ioread8(dev, base + addr_mask);
 	mode &= ~(unit ? 0x30 : 0x03);
-	mode |= (unit ? 0x10 : 0x01);
+	mode |= unit ? 0x10 : 0x01;
 	sil_iowrite8(dev, mode, base + addr_mask);
 }
 
@@ -275,44 +281,43 @@ static void sil_set_pio_mode(ide_drive_t
 
 static void sil_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
-	u8 ultra6[]		= { 0x0F, 0x0B, 0x07, 0x05, 0x03, 0x02, 0x01 };
-	u8 ultra5[]		= { 0x0C, 0x07, 0x05, 0x04, 0x02, 0x01 };
-	u16 dma[]		= { 0x2208, 0x10C2, 0x10C1 };
+	static const u8 ultra6[] = { 0x0F, 0x0B, 0x07, 0x05, 0x03, 0x02, 0x01 };
+	static const u8 ultra5[] = { 0x0C, 0x07, 0x05, 0x04, 0x02, 0x01 };
+	static const u16 dma[]	 = { 0x2208, 0x10C2, 0x10C1 };
 
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	u16 ultra = 0, multi	= 0;
 	u8 mode = 0, unit	= drive->select.b.unit;
 	unsigned long base	= (unsigned long)hwif->hwif_data;
-	u8 scsc = 0, addr_mask	= ((hwif->channel) ?
-				    ((hwif->mmio) ? 0xF4 : 0x84) :
-				    ((hwif->mmio) ? 0xB4 : 0x80));
-				    
+	u8 scsc = 0, addr_mask	= hwif->channel ?
+					(hwif->mmio ? 0xF4 : 0x84) :
+					(hwif->mmio ? 0xB4 : 0x80);
 	unsigned long ma	= siimage_seldev(drive, 0x08);
 	unsigned long ua	= siimage_seldev(drive, 0x0C);
 
-	scsc = sil_ioread8(dev, base + (hwif->mmio ? 0x4A : 0x8A));
-	mode = sil_ioread8(dev, base + addr_mask);
+	scsc  = sil_ioread8 (dev, base + (hwif->mmio ? 0x4A : 0x8A));
+	mode  = sil_ioread8 (dev, base + addr_mask);
 	multi = sil_ioread16(dev, ma);
 	ultra = sil_ioread16(dev, ua);
 
-	mode &= ~((unit) ? 0x30 : 0x03);
+	mode  &= ~(unit ? 0x30 : 0x03);
 	ultra &= ~0x3F;
 	scsc = ((scsc & 0x30) == 0x00) ? 0 : 1;
 
 	scsc = is_sata(hwif) ? 1 : scsc;
 
 	if (speed >= XFER_UDMA_0) {
-		multi = dma[2];
-		ultra |= (scsc ? ultra6[speed - XFER_UDMA_0] :
-				 ultra5[speed - XFER_UDMA_0]);
-		mode |= (unit ? 0x30 : 0x03);
+		multi  = dma[2];
+		ultra |= scsc ? ultra6[speed - XFER_UDMA_0] :
+				ultra5[speed - XFER_UDMA_0];
+		mode  |= unit ? 0x30 : 0x03;
 	} else {
 		multi = dma[speed - XFER_MW_DMA_0];
-		mode |= (unit ? 0x20 : 0x02);
+		mode |= unit ? 0x20 : 0x02;
 	}
 
-	sil_iowrite8(dev, mode, base + addr_mask);
+	sil_iowrite8 (dev, mode, base + addr_mask);
 	sil_iowrite16(dev, multi, ma);
 	sil_iowrite16(dev, ultra, ua);
 }
@@ -326,13 +331,14 @@ static int siimage_io_dma_test_irq(ide_d
 	unsigned long addr	= siimage_selreg(hwif, 1);
 
 	/* return 1 if INTR asserted */
-	if ((hwif->INB(hwif->dma_status) & 4) == 4)
+	if (hwif->INB(hwif->dma_status) & 4)
 		return 1;
 
 	/* return 1 if Device INTR asserted */
 	pci_read_config_byte(dev, addr, &dma_altstat);
 	if (dma_altstat & 8)
-		return 0;	//return 1;
+		return 0;	/* return 1; */
+
 	return 0;
 }
 
@@ -352,9 +358,9 @@ static int siimage_mmio_dma_test_irq(ide
 		= (void __iomem *)hwif->sata_scr[SATA_ERROR_OFFSET];
 
 	if (sata_error_addr) {
-		unsigned long base = (unsigned long)hwif->hwif_data;
-		u32 ext_stat = readl((void __iomem *)(base + 0x10));
-		u8 watchdog = 0;
+		unsigned long base	= (unsigned long)hwif->hwif_data;
+		u32 ext_stat		= readl((void __iomem *)(base + 0x10));
+		u8 watchdog		= 0;
 
 		if (ext_stat & ((hwif->channel) ? 0x40 : 0x10)) {
 			u32 sata_error = readl(sata_error_addr);
@@ -363,25 +369,22 @@ static int siimage_mmio_dma_test_irq(ide
 			watchdog = (sata_error & 0x00680000) ? 1 : 0;
 			printk(KERN_WARNING "%s: sata_error = 0x%08x, "
 				"watchdog = %d, %s\n",
-				drive->name, sata_error, watchdog,
-				__func__);
-
-		} else {
+				drive->name, sata_error, watchdog, __func__);
+		} else
 			watchdog = (ext_stat & 0x8000) ? 1 : 0;
-		}
-		ext_stat >>= 16;
 
+		ext_stat >>= 16;
 		if (!(ext_stat & 0x0404) && !watchdog)
 			return 0;
 	}
 
 	/* return 1 if INTR asserted */
-	if ((readb((void __iomem *)hwif->dma_status) & 0x04) == 0x04)
+	if (readb((void __iomem *)hwif->dma_status) & 0x04)
 		return 1;
 
 	/* return 1 if Device INTR asserted */
-	if ((readb((void __iomem *)addr) & 8) == 8)
-		return 0;	//return 1;
+	if (readb((void __iomem *)addr) & 8)
+		return 0;	/* return 1; */
 
 	return 0;
 }
@@ -440,33 +443,32 @@ static void sil_sata_pre_reset(ide_drive
 }
 
 /**
- *	setup_mmio_siimage	-	switch an SI controller into MMIO
+ *	setup_mmio_siimage	-	switch controller into MMIO mode
  *	@dev: PCI device we are configuring
  *	@name: device name
  *
- *	Attempt to put the device into mmio mode. There are some slight
- *	complications here with certain systems where the mmio bar isnt
- *	mapped so we have to be sure we can fall back to I/O.
+ *	Attempt to put the device into MMIO mode. There are some slight
+ *	complications here with certain systems where the MMIO BAR isn't
+ *	mapped, so we have to be sure that we can fall back to I/O.
  */
- 
-static unsigned int setup_mmio_siimage (struct pci_dev *dev, const char *name)
+
+static unsigned int setup_mmio_siimage(struct pci_dev *dev, const char *name)
 {
 	resource_size_t bar5	= pci_resource_start(dev, 5);
 	unsigned long barsize	= pci_resource_len(dev, 5);
 	void __iomem *ioaddr;
 
 	/*
-	 *	Drop back to PIO if we can't map the mmio. Some
-	 *	systems seem to get terminally confused in the PCI
-	 *	spaces.
+	 *	Drop back to PIO if we can't map the MMIO. Some	systems
+	 *	seem to get terminally confused in the PCI spaces.
 	 */
 	if (!request_mem_region(bar5, barsize, name)) {
-		printk(KERN_WARNING "siimage: IDE controller MMIO ports not available.\n");
+		printk(KERN_WARNING "siimage: IDE controller MMIO ports not "
+				    "available.\n");
 		return 0;
 	}
 
 	ioaddr = ioremap(bar5, barsize);
-
 	if (ioaddr == NULL) {
 		release_mem_region(bar5, barsize);
 		return 0;
@@ -484,23 +486,23 @@ static unsigned int setup_mmio_siimage (
  *	@name: device name
  *
  *	Perform the initial PCI set up for this device. Attempt to switch
- *	to 133MHz clocking if the system isn't already set up to do it.
+ *	to 133 MHz clocking if the system isn't already set up to do it.
  */
 
-static unsigned int __devinit init_chipset_siimage(struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_siimage(struct pci_dev *dev,
+						   const char *name)
 {
 	unsigned long base, scsc_addr;
 	void __iomem *ioaddr = NULL;
-	u8 rev = dev->revision, tmp = 0, BA5_EN = 0;
+	u8 rev = dev->revision, tmp, BA5_EN;
 
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, rev ? 1 : 255);
 
 	pci_read_config_byte(dev, 0x8A, &BA5_EN);
 
-	if ((BA5_EN & 0x01) || pci_resource_start(dev, 5)) {
+	if ((BA5_EN & 0x01) || pci_resource_start(dev, 5))
 		if (setup_mmio_siimage(dev, name))
 			ioaddr = pci_get_drvdata(dev);
-	}
 
 	base = (unsigned long)ioaddr;
 
@@ -527,7 +529,7 @@ static unsigned int __devinit init_chips
 
 	switch (tmp & 0x30) {
 	case 0x00:
-		/* On 100MHz clocking, try and switch to 133MHz */
+		/* On 100 MHz clocking, try and switch to 133 MHz */
 		sil_iowrite8(dev, tmp | 0x10, scsc_addr);
 		break;
 	case 0x30:
@@ -543,12 +545,12 @@ static unsigned int __devinit init_chips
 
 	tmp = sil_ioread8(dev, scsc_addr);
 
-	sil_iowrite8(dev,        0x72, base + 0xA1);
+	sil_iowrite8 (dev,       0x72, base + 0xA1);
 	sil_iowrite16(dev,     0x328A, base + 0xA2);
 	sil_iowrite32(dev, 0x62DD62DD, base + 0xA4);
 	sil_iowrite32(dev, 0x43924392, base + 0xA8);
 	sil_iowrite32(dev, 0x40094009, base + 0xAC);
-	sil_iowrite8(dev,        0x72, base ? (base + 0xE1) : 0xB1);
+	sil_iowrite8 (dev,       0x72, base ? (base + 0xE1) : 0xB1);
 	sil_iowrite16(dev,     0x328A, base ? (base + 0xE2) : 0xB2);
 	sil_iowrite32(dev, 0x62DD62DD, base ? (base + 0xE4) : 0xB4);
 	sil_iowrite32(dev, 0x43924392, base ? (base + 0xE8) : 0xB8);
@@ -579,8 +581,7 @@ static unsigned int __devinit init_chips
  *
  *	The basic setup here is fairly simple, we can use standard MMIO
  *	operations. However we do have to set the taskfile register offsets
- *	by hand as there isnt a standard defined layout for them this
- *	time.
+ *	by hand as there isn't a standard defined layout for them this time.
  *
  *	The hardware supports buffered taskfiles and also some rather nice
  *	extended PRD tables. For better SI3112 support use the libata driver
@@ -591,24 +592,20 @@ static void __devinit init_mmio_iops_sii
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	void *addr		= pci_get_drvdata(dev);
 	u8 ch			= hwif->channel;
-	unsigned long		base;
-
 	struct ide_io_ports *io_ports = &hwif->io_ports;
+	unsigned long base;
 
 	/*
-	 *	Fill in the basic HWIF bits
+	 *	Fill in the basic hwif bits
 	 */
-
 	hwif->host_flags |= IDE_HFLAG_MMIO;
 	default_hwif_mmiops(hwif);
-	hwif->hwif_data			= addr;
+	hwif->hwif_data	= addr;
 
 	/*
-	 *	Now set up the hw. We have to do this ourselves as
-	 *	the MMIO layout isnt the same as the standard port
-	 *	based I/O
+	 *	Now set up the hw. We have to do this ourselves as the
+	 *	MMIO layout isn't the same as the standard port based I/O.
 	 */
-
 	memset(io_ports, 0, sizeof(*io_ports));
 
 	base = (unsigned long)addr;
@@ -618,10 +615,9 @@ static void __devinit init_mmio_iops_sii
 		base += 0x80;
 
 	/*
-	 *	The buffered task file doesn't have status/control
-	 *	so we can't currently use it sanely since we want to
-	 *	use LBA48 mode.
-	 */	
+	 *	The buffered task file doesn't have status/control, so we
+	 *	can't currently use it sanely since we want to use LBA48 mode.
+	 */
 	io_ports->data_addr	= base;
 	io_ports->error_addr	= base + 1;
 	io_ports->nsect_addr	= base + 2;
@@ -650,19 +646,17 @@ static void __devinit init_mmio_iops_sii
 
 static int is_dev_seagate_sata(ide_drive_t *drive)
 {
-	const char *s = &drive->id->model[0];
-	unsigned len;
-
-	len = strnlen(s, sizeof(drive->id->model));
+	const char *s	= &drive->id->model[0];
+	unsigned len	= strnlen(s, sizeof(drive->id->model));
 
-	if ((len > 4) && (!memcmp(s, "ST", 2))) {
+	if ((len > 4) && (!memcmp(s, "ST", 2)))
 		if ((!memcmp(s + len - 2, "AS", 2)) ||
 		    (!memcmp(s + len - 3, "ASL", 3))) {
 			printk(KERN_INFO "%s: applying pessimistic Seagate "
 					 "errata fix\n", drive->name);
 			return 1;
 		}
-	}
+
 	return 0;
 }
 
@@ -679,7 +673,7 @@ static void __devinit sil_quirkproc(ide_
 {
 	ide_hwif_t *hwif = drive->hwif;
 
-	/* Try and raise the rqsize */
+	/* Try and rise the rqsize */
 	if (!is_sata(hwif) || !is_dev_seagate_sata(drive))
 		hwif->rqsize = 128;
 }
@@ -713,15 +707,14 @@ static void __devinit init_iops_siimage(
  *	sil_cable_detect	-	cable detection
  *	@hwif: interface to check
  *
- *	Check for the presence of an ATA66 capable cable on the
- *	interface.
+ *	Check for the presence of an ATA66 capable cable on the interface.
  */
 
 static u8 __devinit sil_cable_detect(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	unsigned long addr = siimage_selreg(hwif, 0);
-	u8 ata66 = sil_ioread8(dev, addr);
+	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	unsigned long addr	= siimage_selreg(hwif, 0);
+	u8 ata66		= sil_ioread8(dev, addr);
 
 	return (ata66 & 0x01) ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
 }
@@ -767,15 +760,16 @@ static const struct ide_port_info siimag
 };
 
 /**
- *	siimage_init_one	-	pci layer discovery entry
+ *	siimage_init_one	-	PCI layer discovery entry
  *	@dev: PCI device
  *	@id: ident table entry
  *
- *	Called by the PCI code when it finds an SI680 or SI3112 controller.
+ *	Called by the PCI code when it finds an SiI680 or SiI3112 controller.
  *	We then use the IDE PCI generic helper to do most of the work.
  */
- 
-static int __devinit siimage_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+
+static int __devinit siimage_init_one(struct pci_dev *dev,
+				      const struct pci_device_id *id)
 {
 	struct ide_port_info d;
 	u8 idx = id->driver_data;

