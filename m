From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_hpt3xx: Updates to match work done by Sergei to old
 IDE
Date: Wed, 11 Apr 2007 00:16:49 +0100
Message-ID: <20070411001649.1abecf4b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:49236 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161053AbXDJXNn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Apr 2007 19:13:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Signed-off-by: Alan Cox <alan@redhat.com>

Correct timing lists
Use DPLL when appropriate
Fix HPT372 UDMA 100 limit
Add HPT371N support
Reset the correct channel only not both when doing the pre_reset
processing
Pull DPLL clock from I/O not PCI space
Correct DPLL failure error handling

diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index fe1b482..6bde2e9 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -26,7 +26,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.4"
+#define DRV_VERSION	"0.6.5"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -130,7 +130,7 @@ static const struct hpt_chip hpt370 = {
 		hpt37x_timings_33,
 		NULL,
 		NULL,
-		hpt37x_timings_66
+		NULL
 	}
 };
 
@@ -141,7 +141,7 @@ static const struct hpt_chip hpt370a = {
 		hpt37x_timings_33,
 		NULL,
 		hpt37x_timings_50,
-		hpt37x_timings_66
+		NULL
 	}
 };
 
@@ -930,15 +930,6 @@ static int hpt37x_init_one(struct pci_de
 		.udma_mask = 0x7f,
 		.port_ops = &hpt372_port_ops
 	};
-	/* HPT371, 372 and friends - UDMA100 at 50MHz clock */
-	static struct ata_port_info info_hpt372_50 = {
-		.sht = &hpt37x_sht,
-		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
-		.pio_mask = 0x1f,
-		.mwdma_mask = 0x07,
-		.udma_mask = 0x3f,
-		.port_ops = &hpt372_port_ops
-	};
 	/* HPT374 - UDMA133 */
 	static struct ata_port_info info_hpt374 = {
 		.sht = &hpt37x_sht,
@@ -1018,8 +1009,8 @@ static int hpt37x_init_one(struct pci_de
 					return -ENODEV;
 				port = &info_hpt372;
 				chip_table = &hpt371;
-				/* Single channel device, paster is not present
-				   but the NIOS (or us for non x86) must mark it
+				/* Single channel device, master is not present
+				   but the BIOS (or us for non x86) must mark it
 				   absent */
 				pci_read_config_byte(dev, 0x50, &mcr1);
 				mcr1 &= ~0x04;
@@ -1131,16 +1122,11 @@ static int hpt37x_init_one(struct pci_de
 	} else {
 		port->private_data = (void *)chip_table->clocks[clock_slot];
 		/*
-		 *	Perform a final fixup. The 371 and 372 clock determines
-		 *	if UDMA133 is available. (FIXME: should we use DPLL then ?)
-		 */
+		 *	Perform a final fixup. Note that we will have used the
+		 *	DPLL on the HPT372 which means we don't have to worry
+		 *	about lack of UDMA133 support on lower clocks
+ 		 */
 
-		if (clock_slot == 2 && chip_table == &hpt372) {	/* 50Mhz */
-			printk(KERN_WARNING "pata_hpt37x: No UDMA133 support available with 50MHz bus clock.\n");
-			if (port == &info_hpt372)
-				port = &info_hpt372_50;
-			else BUG();
-		}
 		if (clock_slot < 2 && port == &info_hpt370)
 			port = &info_hpt370_33;
 		if (clock_slot < 2 && port == &info_hpt370a)
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 7832392..7684609 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -8,10 +8,10 @@
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
+ * Portions Copyright (C) 2005-2006	MontaVista Software, Inc.
  *
  *
  * TODO
- *	371N
  *	Work out best PLL policy
  */
 
@@ -151,8 +151,7 @@ static int hpt3xn_pre_reset(struct ata_p
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	/* Reset the state machine */
-	pci_write_config_byte(pdev, 0x50, 0x37);
-	pci_write_config_byte(pdev, 0x54, 0x37);
+	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
 	return ata_std_prereset(ap);
 }
@@ -433,8 +432,9 @@ static int hpt3x2n_pci_clock(struct pci_
 {
 	unsigned long freq;
 	u32 fcnt;
+	unsigned long iobase = pci_resource_start(pdev, 4);
 
-	pci_read_config_dword(pdev, 0x70/*CHECKME*/, &fcnt);
+	fcnt = inl(iobase + 0x90);	/* Not PCI readable for some chips */
 	if ((fcnt >> 12) != 0xABCDE) {
 		printk(KERN_WARNING "hpt3xn: BIOS clock data not set.\n");
 		return 33;	/* Not BIOS set */
@@ -503,6 +503,7 @@ static int hpt3x2n_init_one(struct pci_d
 	unsigned int pci_mhz;
 	unsigned int f_low, f_high;
 	int adjust;
+	unsigned long iobase = pci_resource_start(dev, 4);
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xFF;
@@ -512,6 +513,11 @@ static int hpt3x2n_init_one(struct pci_d
 			if (class_rev < 6)
 				return -ENODEV;
 			break;
+		case PCI_DEVICE_ID_TTI_HPT371:
+			if (class_rev < 2)
+				return -ENODEV;
+			/* 371N if rev > 1 */
+			break;
 		case PCI_DEVICE_ID_TTI_HPT372:
 			/* 372N if rev >= 1*/
 			if (class_rev == 0)
@@ -539,6 +545,19 @@ static int hpt3x2n_init_one(struct pci_d
 	irqmask &= ~0x10;
 	pci_write_config_byte(dev, 0x5a, irqmask);
 
+	/*
+	 * HPT371 chips physically have only one channel, the secondary one,
+	 * but the primary channel registers do exist!  Go figure...
+	 * So,  we manually disable the non-existing channel here
+	 * (if the BIOS hasn't done this already).
+	 */
+	if (dev->device == PCI_DEVICE_ID_TTI_HPT371) {
+		u8 mcr1;
+		pci_read_config_byte(dev, 0x50, &mcr1);
+		mcr1 &= ~0x04;
+		pci_write_config_byte(dev, 0x50, mcr1);
+	}
+
 	/* Tune the PLL. HPT recommend using 75 for SATA, 66 for UDMA133 or
 	   50 for UDMA100. Right now we always use 66 */
 
@@ -557,14 +576,24 @@ static int hpt3x2n_init_one(struct pci_d
 			break;
 		pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low);
 	}
-	if (adjust == 8)
-		printk(KERN_WARNING "hpt3xn: DPLL did not stabilize.\n");
+	if (adjust == 8) {
+		printk(KERN_WARNING "hpt3x2n: DPLL did not stabilize.\n");
+		return -ENODEV;
+	}
 
 	/* Set our private data up. We only need a few flags so we use
 	   it directly */
 	port->private_data = NULL;
-	if (pci_mhz > 60)
+	if (pci_mhz > 60) {
 		port->private_data = (void *)PCI66;
+		/*
+		 * On  HPT371N, if ATA clock is 66 MHz we must set bit 2 in
+		 * the MISC. register to stretch the UltraDMA Tss timing.
+		 * NOTE: This register is only writeable via I/O space.
+		 */
+		if (dev->device == PCI_DEVICE_ID_TTI_HPT371)
+			outb(inb(iobase + 0x9c) | 0x04, iobase + 0x9c);
+	}
 
 	/* Now kick off ATA set up */
 	port_info[0] = port_info[1] = port;
@@ -573,6 +602,7 @@ static int hpt3x2n_init_one(struct pci_d
 
 static const struct pci_device_id hpt3x2n[] = {
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT366), },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT371), },
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT372), },
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT302), },
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT372N), },
