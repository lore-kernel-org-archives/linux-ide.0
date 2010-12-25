From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_{hpt37x|hpt3x2n}: SATA mode filtering
Date: Sat, 25 Dec 2010 22:42:41 +0300
Message-ID: <201012252242.41486.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:58988 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751124Ab0LYTn6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Dec 2010 14:43:58 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

The Marvell bridge chips used on HighPoint SATA cards do not seem to support
the UltraDMA modes 1, 2, and 3 as well as any MWDMA modes;  these cards are
based on HPT372/372A/372N/374 chips (judging from the vendor drivers), so
the Linux drivers need to have a mode_filter() method for these chips...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

--
The patch is against the recent Linus' tree.

 drivers/ata/pata_hpt37x.c  |   54 ++++++++++++++++++++++++++++++++-------
 drivers/ata/pata_hpt3x2n.c |   61 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 93 insertions(+), 22 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -8,7 +8,7 @@
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
- * Portions Copyright (C) 2005-2009	MontaVista Software, Inc.
+ * Portions Copyright (C) 2005-2010	MontaVista Software, Inc.
  *
  * TODO
  *	Look into engine reset on timeout errors. Should not be	required.
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.15"
+#define DRV_VERSION	"0.6.16"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -302,6 +302,22 @@ static unsigned long hpt370a_filter(stru
 }
 
 /**
+ *	hpt372_filter	-	mode selection filter
+ *	@adev: ATA device
+ *	@mask: mode mask
+ *
+ *	The Marvell bridge chips used on the HighPoint SATA cards do not seem
+ *	to support the UltraDMA modes 1, 2, and 3 as well as any MWDMA modes...
+ */
+static unsigned long hpt372_filter(struct ata_device *adev, unsigned long mask)
+{
+	if (ata_id_is_sata(adev->id))
+		mask &= ~((0xE << ATA_SHIFT_UDMA) | ATA_MASK_MWDMA);
+
+	return mask;
+}
+
+/**
  *	hpt37x_cable_detect	-	Detect the cable type
  *	@ap: ATA port to detect on
  *
@@ -586,11 +602,11 @@ static struct ata_port_operations hpt370
 };
 
 /*
- *	Configuration for HPT372, HPT371, HPT302. Slightly different PIO
- *	and DMA mode setting functionality.
+ *	Configuration for HPT371 and HPT302. Slightly different PIO and DMA
+ *	mode setting functionality.
  */
 
-static struct ata_port_operations hpt372_port_ops = {
+static struct ata_port_operations hpt302_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 
 	.bmdma_stop	= hpt37x_bmdma_stop,
@@ -602,7 +618,17 @@ static struct ata_port_operations hpt372
 };
 
 /*
- *	Configuration for HPT374. Mode setting works like 372 and friends
+ *	Configuration for HPT372. Mode setting works like 371 and 302
+ *	but we have a mode filter.
+ */
+
+static struct ata_port_operations hpt372_port_ops = {
+	.inherits	= &hpt302_port_ops,
+	.mode_filter	= hpt372_filter,
+};
+
+/*
+ *	Configuration for HPT374. Mode setting and filtering works like 372
  *	but we have a different cable detection procedure for function 1.
  */
 
@@ -753,7 +779,7 @@ static int hpt37x_init_one(struct pci_de
 		.udma_mask = ATA_UDMA5,
 		.port_ops = &hpt370a_port_ops
 	};
-	/* HPT371, 372 and friends - UDMA133 */
+	/* HPT372 - UDMA133 */
 	static const struct ata_port_info info_hpt372 = {
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = ATA_PIO4,
@@ -761,6 +787,14 @@ static int hpt37x_init_one(struct pci_de
 		.udma_mask = ATA_UDMA6,
 		.port_ops = &hpt372_port_ops
 	};
+	/* HPT371, 302 - UDMA133 */
+	static const struct ata_port_info info_hpt302 = {
+		.flags = ATA_FLAG_SLAVE_POSS,
+		.pio_mask = ATA_PIO4,
+		.mwdma_mask = ATA_MWDMA2,
+		.udma_mask = ATA_UDMA6,
+		.port_ops = &hpt302_port_ops
+	};
 	/* HPT374 - UDMA100, function 1 uses different prereset method */
 	static const struct ata_port_info info_hpt374_fn0 = {
 		.flags = ATA_FLAG_SLAVE_POSS,
@@ -828,7 +862,7 @@ static int hpt37x_init_one(struct pci_de
 	} else {
 		switch(dev->device) {
 			case PCI_DEVICE_ID_TTI_HPT372:
-				/* 372N if rev >= 2*/
+				/* 372N if rev >= 2 */
 				if (rev >= 2)
 					return -ENODEV;
 				ppi[0] = &info_hpt372;
@@ -838,14 +872,14 @@ static int hpt37x_init_one(struct pci_de
 				/* 302N if rev > 1 */
 				if (rev > 1)
 					return -ENODEV;
-				ppi[0] = &info_hpt372;
+				ppi[0] = &info_hpt302;
 				/* Check this */
 				chip_table = &hpt302;
 				break;
 			case PCI_DEVICE_ID_TTI_HPT371:
 				if (rev > 1)
 					return -ENODEV;
-				ppi[0] = &info_hpt372;
+				ppi[0] = &info_hpt302;
 				chip_table = &hpt371;
 				/* Single channel device, master is not present
 				   but the BIOS (or us for non x86) must mark it
Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -8,7 +8,7 @@
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
- * Portions Copyright (C) 2005-2009	MontaVista Software, Inc.
+ * Portions Copyright (C) 2005-2010	MontaVista Software, Inc.
  *
  *
  * TODO
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.10"
+#define DRV_VERSION	"0.3.11"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -113,6 +113,22 @@ static u32 hpt3x2n_find_mode(struct ata_
 }
 
 /**
+ *	hpt372n_filter	-	mode selection filter
+ *	@adev: ATA device
+ *	@mask: mode mask
+ *
+ *	The Marvell bridge chips used on the HighPoint SATA cards do not seem
+ *	to support the UltraDMA modes 1, 2, and 3 as well as any MWDMA modes...
+ */
+static unsigned long hpt372n_filter(struct ata_device *adev, unsigned long mask)
+{
+	if (ata_id_is_sata(adev->id))
+		mask &= ~((0xE << ATA_SHIFT_UDMA) | ATA_MASK_MWDMA);
+
+	return mask;
+}
+
+/**
  *	hpt3x2n_cable_detect	-	Detect the cable type
  *	@ap: ATA port to detect on
  *
@@ -328,10 +344,10 @@ static struct scsi_host_template hpt3x2n
 };
 
 /*
- *	Configuration for HPT3x2n.
+ *	Configuration for HPT302N/371N.
  */
 
-static struct ata_port_operations hpt3x2n_port_ops = {
+static struct ata_port_operations hpt3xxn_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 
 	.bmdma_stop	= hpt3x2n_bmdma_stop,
@@ -345,6 +361,15 @@ static struct ata_port_operations hpt3x2
 	.prereset	= hpt3x2n_pre_reset,
 };
 
+/*
+ *	Configuration for HPT372N. Same as 302N/371N but we have a mode filter.
+ */
+
+static struct ata_port_operations hpt372n_port_ops = {
+	.inherits	= &hpt3xxn_port_ops,
+	.mode_filter	= &hpt372n_filter,
+};
+
 /**
  *	hpt3xn_calibrate_dpll		-	Calibrate the DPLL loop
  *	@dev: PCI device
@@ -437,15 +462,23 @@ static int hpt3x2n_pci_clock(struct pci_
 
 static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	/* HPT372N and friends - UDMA133 */
-	static const struct ata_port_info info = {
+	/* HPT372N - UDMA133 */
+	static const struct ata_port_info info_hpt372n = {
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = ATA_PIO4,
 		.mwdma_mask = ATA_MWDMA2,
 		.udma_mask = ATA_UDMA6,
-		.port_ops = &hpt3x2n_port_ops
+		.port_ops = &hpt372n_port_ops
 	};
-	const struct ata_port_info *ppi[] = { &info, NULL };
+	/* HPT302N and HPT371N - UDMA133 */
+	static const struct ata_port_info info_hpt3xxn = {
+		.flags = ATA_FLAG_SLAVE_POSS,
+		.pio_mask = ATA_PIO4,
+		.mwdma_mask = ATA_MWDMA2,
+		.udma_mask = ATA_UDMA6,
+		.port_ops = &hpt3xxn_port_ops
+	};
+	const struct ata_port_info *ppi[] = { &info_hpt3xxn, NULL };
 	u8 rev = dev->revision;
 	u8 irqmask;
 	unsigned int pci_mhz;
@@ -461,24 +494,28 @@ static int hpt3x2n_init_one(struct pci_d
 
 	switch(dev->device) {
 		case PCI_DEVICE_ID_TTI_HPT366:
+			/* 372N if rev >= 6 */
 			if (rev < 6)
 				return -ENODEV;
-			break;
+			goto hpt372n;
 		case PCI_DEVICE_ID_TTI_HPT371:
+			/* 371N if rev >= 2 */
 			if (rev < 2)
 				return -ENODEV;
-			/* 371N if rev > 1 */
 			break;
 		case PCI_DEVICE_ID_TTI_HPT372:
-			/* 372N if rev >= 2*/
+			/* 372N if rev >= 2 */
 			if (rev < 2)
 				return -ENODEV;
-			break;
+			goto hpt372n;
 		case PCI_DEVICE_ID_TTI_HPT302:
+			/* 302N if rev >= 2 */
 			if (rev < 2)
 				return -ENODEV;
 			break;
 		case PCI_DEVICE_ID_TTI_HPT372N:
+hpt372n:
+			ppi[0] = &info_hpt372n;
 			break;
 		default:
 			printk(KERN_ERR "pata_hpt3x2n: PCI table is bogus please report (%d).\n", dev->device);
