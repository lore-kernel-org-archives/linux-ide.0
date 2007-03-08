From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_optidma: Rework for cable detect and to remove
 post_set_mode()
Date: Thu, 8 Mar 2007 23:33:06 +0000
Message-ID: <20070308233306.588c23c0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46790 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030808AbXCHW2x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:28:53 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

A lot of noise because I had to rename the optidma_set_mode() method to
avoid confusion with the new ->set_mode() method that was added. Cable
detect side is pretty trivial.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_optidma.c linux-2.6.21-rc3-mm2/drivers/ata/pata_optidma.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_optidma.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_optidma.c	2007-03-08 16:34:00.000000000 +0000
@@ -33,7 +33,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_optidma"
-#define DRV_VERSION "0.2.4"
+#define DRV_VERSION "0.3.2"
 
 enum {
 	READ_REG	= 0,	/* index of Read cycle timing register */
@@ -62,8 +62,6 @@
 
 	if (ap->port_no && !pci_test_config_bits(pdev, &optidma_enable_bits))
 		return -ENOENT;
-
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -116,7 +114,7 @@
 }
 
 /**
- *	optidma_set_mode	-	set mode data
+ *	optidma_mode_setup	-	set mode data
  *	@ap: ATA interface
  *	@adev: ATA device
  *	@mode: Mode to set
@@ -129,7 +127,7 @@
  *	IRQ here we depend on the host set locking to avoid catastrophe.
  */
 
-static void optidma_set_mode(struct ata_port *ap, struct ata_device *adev, u8 mode)
+static void optidma_mode_setup(struct ata_port *ap, struct ata_device *adev, u8 mode)
 {
 	struct ata_device *pair = ata_dev_pair(adev);
 	int pio = adev->pio_mode - XFER_PIO_0;
@@ -203,7 +201,7 @@
 }
 
 /**
- *	optiplus_set_mode	-	DMA setup for Firestar Plus
+ *	optiplus_mode_setup	-	DMA setup for Firestar Plus
  *	@ap: ATA port
  *	@adev: device
  *	@mode: desired mode
@@ -214,7 +212,7 @@
  *	one
  */
 
-static void optiplus_set_mode(struct ata_port *ap, struct ata_device *adev, u8 mode)
+static void optiplus_mode_setup(struct ata_port *ap, struct ata_device *adev, u8 mode)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 udcfg;
@@ -226,7 +224,7 @@
 	pci_read_config_byte(pdev, 0x44, &udcfg);
 	if (mode <= XFER_UDMA_0) {
 		udcfg &= ~(1 << unit);
-		optidma_set_mode(ap, adev, adev->dma_mode);
+		optidma_mode_setup(ap, adev, adev->dma_mode);
 	} else {
 		udcfg |=  (1 << unit);
 		if (ap->port_no) {
@@ -254,7 +252,7 @@
 
 static void optidma_set_pio_mode(struct ata_port *ap, struct ata_device *adev)
 {
-	optidma_set_mode(ap, adev, adev->pio_mode);
+	optidma_mode_setup(ap, adev, adev->pio_mode);
 }
 
 /**
@@ -269,7 +267,7 @@
 
 static void optidma_set_dma_mode(struct ata_port *ap, struct ata_device *adev)
 {
-	optidma_set_mode(ap, adev, adev->dma_mode);
+	optidma_mode_setup(ap, adev, adev->dma_mode);
 }
 
 /**
@@ -284,7 +282,7 @@
 
 static void optiplus_set_pio_mode(struct ata_port *ap, struct ata_device *adev)
 {
-	optiplus_set_mode(ap, adev, adev->pio_mode);
+	optiplus_mode_setup(ap, adev, adev->pio_mode);
 }
 
 /**
@@ -299,7 +297,7 @@
 
 static void optiplus_set_dma_mode(struct ata_port *ap, struct ata_device *adev)
 {
-	optiplus_set_mode(ap, adev, adev->dma_mode);
+	optiplus_mode_setup(ap, adev, adev->dma_mode);
 }
 
 /**
@@ -323,26 +321,29 @@
 }
 
 /**
- *	optidma_post_set_mode	-	finalize PCI setup
+ *	optidma_set_mode	-	mode setup
  *	@ap: port to set up
  *
- *	Finalise the configuration by writing the nibble of extra bits
- *	of data into the chip.
+ *	Use the standard setup to tune the chipset and then finalise the
+ *	configuration by writing the nibble of extra bits of data into 
+ *	the chip.
  */
 
-static void optidma_post_set_mode(struct ata_port *ap)
+static int optidma_set_mode(struct ata_port *ap, struct ata_device **r_failed)
 {
 	u8 r;
 	int nybble = 4 * ap->port_no;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-
-	pci_read_config_byte(pdev, 0x43, &r);
-
-	r &= (0x0F << nybble);
-	r |= (optidma_make_bits43(&ap->device[0]) +
-	     (optidma_make_bits43(&ap->device[0]) << 2)) << nybble;
-
-	pci_write_config_byte(pdev, 0x43, r);
+	int rc  = ata_do_set_mode(ap, r_failed);
+	if (rc == 0) {
+		pci_read_config_byte(pdev, 0x43, &r);
+
+		r &= (0x0F << nybble);
+		r |= (optidma_make_bits43(&ap->device[0]) +
+		     (optidma_make_bits43(&ap->device[0]) << 2)) << nybble;
+		pci_write_config_byte(pdev, 0x43, r);
+	}
+	return rc;
 }
 
 static struct scsi_host_template optidma_sht = {
@@ -382,7 +383,8 @@
 	.thaw		= ata_bmdma_thaw,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.error_handler	= optidma_error_handler,
-	.post_set_mode	= optidma_post_set_mode,
+	.set_mode	= optidma_set_mode,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -417,7 +419,8 @@
 	.thaw		= ata_bmdma_thaw,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.error_handler	= optidma_error_handler,
-	.post_set_mode	= optidma_post_set_mode,
+	.set_mode	= optidma_set_mode,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
