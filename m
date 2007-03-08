From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_hpt3x2n: Further updating based upon old IDE work
Date: Thu, 8 Mar 2007 23:30:58 +0000
Message-ID: <20070308233058.23b5c29d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49244 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030764AbXCHW0p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:26:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

And it now supports the hpt371n so at some point needs a rename. Sigh

This imports the basic fixups from the work Sergey has been doing into
the HPT3x2N driver. In particular it adds support for the 371N. Plenty
more work left on both this and HPT37x

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_hpt3x2n.c linux-2.6.21-rc3-mm2/drivers/ata/pata_hpt3x2n.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_hpt3x2n.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_hpt3x2n.c	2007-03-08 17:10:32.000000000 +0000
@@ -8,10 +8,11 @@
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
+ * Portions Copyright (C) 2005-2006	MontaVista Software, Inc.
  *
+ * 
  *
  * TODO
- *	371N
  *	Work out best PLL policy
  */
 
@@ -25,7 +26,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.2"
+#define DRV_VERSION	"0.3.3"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -115,15 +116,13 @@
 }
 
 /**
- *	hpt3x2n_pre_reset	-	reset the hpt3x2n bus
- *	@ap: ATA port to reset
- *	@deadline: deadline jiffies for the operation
+ *	hpt3x2n_cable_detect	-	Detect the cable type
+ *	@ap: ATA port to detect on
  *
- *	Perform the initial reset handling for the 3x2n series controllers.
- *	Reset the hardware and state machine, obtain the cable type.
+ *	Return the cable type attached to this port
  */
 
-static int hpt3xn_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int hpt3x2n_cable_detect(struct ata_port *ap)
 {
 	u8 scr2, ata66;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
@@ -136,15 +135,26 @@
 	pci_write_config_byte(pdev, 0x5B, scr2);
 
 	if (ata66 & (1 << ap->port_no))
-		ap->cbl = ATA_CBL_PATA40;
+		return ATA_CBL_PATA40;
 	else
-		ap->cbl = ATA_CBL_PATA80;
+		return ATA_CBL_PATA80;
+}
+
+/**
+ *	hpt3x2n_pre_reset	-	reset the hpt3x2n bus
+ *	@ap: ATA port to reset
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Perform the initial reset handling for the 3x2n series controllers.
+ *	Reset the hardware and state machine,
+ */
 
+static int hpt3xn_pre_reset(struct ata_port *ap, unsigned long deadline)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	/* Reset the state machine */
-	pci_write_config_byte(pdev, 0x50, 0x37);
-	pci_write_config_byte(pdev, 0x54, 0x37);
+	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
-
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -365,6 +375,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt3x2n_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= hpt3x2n_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -423,8 +434,9 @@
 {
 	unsigned long freq;
 	u32 fcnt;
+	unsigned long iobase = pci_resource_start(pdev, 4);
 
-	pci_read_config_dword(pdev, 0x70/*CHECKME*/, &fcnt);
+	fcnt = inl(iobase + 0x90);	/* Not PCI readable for some chips */
 	if ((fcnt >> 12) != 0xABCDE) {
 		printk(KERN_WARNING "hpt3xn: BIOS clock data not set.\n");
 		return 33;	/* Not BIOS set */
@@ -493,6 +505,7 @@
 	unsigned int pci_mhz;
 	unsigned int f_low, f_high;
 	int adjust;
+	unsigned long iobase = pci_resource_start(dev, 4);
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xFF;
@@ -502,6 +515,11 @@
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
@@ -528,6 +546,19 @@
 	pci_read_config_byte(dev, 0x5A, &irqmask);
 	irqmask &= ~0x10;
 	pci_write_config_byte(dev, 0x5a, irqmask);
+	
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
 
 	/* Tune the PLL. HPT recommend using 75 for SATA, 66 for UDMA133 or
 	   50 for UDMA100. Right now we always use 66 */
@@ -547,14 +578,24 @@
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
@@ -563,6 +604,7 @@
 
 static const struct pci_device_id hpt3x2n[] = {
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT366), },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT371), },
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT372), },
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT302), },
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT372N), },
