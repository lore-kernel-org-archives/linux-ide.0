From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_amd: remove all the crud and restore the cable detect
 method again
Date: Thu, 8 Mar 2007 19:25:13 +0000
Message-ID: <20070308192513.29b4603e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55634 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932370AbXCHSUz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:20:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_amd.c linux-2.6.21-rc3-mm2/drivers/ata/pata_amd.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_amd.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_amd.c	2007-03-08 17:03:58.000000000 +0000
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_amd"
-#define DRV_VERSION "0.2.8"
+#define DRV_VERSION "0.3.8"
 
 /**
  *	timing_setup		-	shared timing computation and load
@@ -119,33 +119,25 @@
 }
 
 /**
- *	amd_probe_init		-	cable detection
+ *	amd_probe_init		-	perform reset handling
  *	@ap: ATA port
  *	@deadline: deadline jiffies for the operation
  *
- *	Perform cable detection. The BIOS stores this in PCI config
- *	space for us.
+ *	Reset sequence checking enable bits to see which ports are
+ *	active.
  */
 
 static int amd_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
-	static const u32 bitmask[2] = {0x03, 0x0C};
 	static const struct pci_bits amd_enable_bits[] = {
 		{ 0x40, 1, 0x02, 0x02 },
 		{ 0x40, 1, 0x01, 0x01 }
 	};
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 ata66;
 
 	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no]))
 		return -ENOENT;
-
-	pci_read_config_byte(pdev, 0x42, &ata66);
-	if (ata66 & bitmask[ap->port_no])
-		ap->cbl = ATA_CBL_PATA80;
-	else
-		ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap, deadline);
 
 }
@@ -157,27 +149,15 @@
 				      ata_std_postreset);
 }
 
-static int amd_early_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int amd_cable_detect(struct ata_port *ap)
 {
+	static const u32 bitmask[2] = {0x03, 0x0C};
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	static struct pci_bits amd_enable_bits[] = {
-		{ 0x40, 1, 0x02, 0x02 },
-		{ 0x40, 1, 0x01, 0x01 }
-	};
-
-	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no]))
-		return -ENOENT;
-
-	/* No host side cable detection */
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap, deadline);
-}
-
-static void amd_early_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, amd_early_pre_reset,
-			       ata_std_softreset, NULL,
-			       ata_std_postreset);
+	u8 ata66;
+	pci_read_config_byte(pdev, 0x42, &ata66);
+	if (ata66 & bitmask[ap->port_no])
+		return ATA_CBL_PATA80;
+	return ATA_CBL_PATA40;
 }
 
 /**
@@ -241,6 +221,7 @@
 /**
  *	nv_probe_init	-	cable detection
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection. The BIOS stores this in PCI config
  *	space for us.
@@ -248,31 +229,14 @@
 
 static int nv_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
-	static const u8 bitmask[2] = {0x03, 0x0C};
 	static const struct pci_bits nv_enable_bits[] = {
 		{ 0x50, 1, 0x02, 0x02 },
 		{ 0x50, 1, 0x01, 0x01 }
 	};
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 ata66;
-	u16 udma;
-
 	if (!pci_test_config_bits(pdev, &nv_enable_bits[ap->port_no]))
 		return -ENOENT;
-
-	pci_read_config_byte(pdev, 0x52, &ata66);
-	if (ata66 & bitmask[ap->port_no])
-		ap->cbl = ATA_CBL_PATA80;
-	else
-		ap->cbl = ATA_CBL_PATA40;
-
-	/* We now have to double check because the Nvidia boxes BIOS
-	   doesn't always set the cable bits but does set mode bits */
-
-	pci_read_config_word(pdev, 0x62 - 2 * ap->port_no, &udma);
-	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
-		ap->cbl = ATA_CBL_PATA80;
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -282,6 +246,29 @@
 			       ata_std_softreset, NULL,
 			       ata_std_postreset);
 }
+
+static int nv_cable_detect(struct ata_port *ap)
+{
+	static const u8 bitmask[2] = {0x03, 0x0C};
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u8 ata66;
+	u16 udma;
+	int cbl;
+
+	pci_read_config_byte(pdev, 0x52, &ata66);
+	if (ata66 & bitmask[ap->port_no])
+		cbl = ATA_CBL_PATA80;
+	else
+		cbl = ATA_CBL_PATA40;
+
+ 	/* We now have to double check because the Nvidia boxes BIOS
+ 	   doesn't always set the cable bits but does set mode bits */
+ 	pci_read_config_word(pdev, 0x62 - 2 * ap->port_no, &udma);
+ 	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
+		cbl = ATA_CBL_PATA80;
+	return cbl;
+}
+
 /**
  *	nv100_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
@@ -354,8 +341,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= amd_early_error_handler,
+	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -388,8 +376,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= amd_early_error_handler,
+	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_unknown,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -424,6 +413,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_unknown,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -458,6 +448,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= amd_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -492,6 +483,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= nv_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -526,6 +518,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= nv_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -645,6 +638,11 @@
 	if (type == 1 && rev > 0x7)
 		type = 2;
 
+#if defined(CONFIG_ATA_ACPI)
+	/* Prefer the ACPI driver for Nvidia hardware */
+	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA && ata_pata_acpi_present(pdev))
+		return -ENODEV;
+#endif
 	/* Check for AMD7411 */
 	if (type == 3)
 		/* FIFO is broken */
