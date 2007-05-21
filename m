From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_sis: Fix and clean up some timing setups
Date: Mon, 21 May 2007 15:00:53 +0100
Message-ID: <20070521150053.3b6f91a2@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42586 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755326AbXEUN4w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 09:56:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

- Rename sis_port_base to sis_old_port_base() so nobody uses it for new
generation controllers in error.
- Use byte size operations where it is cleaner for mode setup
- Fix a couple of masking errors on certai chip revs when setting speeds

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/drivers/ata/pata_sis.c linux-2.6.22-rc1-mm1/drivers/ata/pata_sis.c
--- linux.vanilla-2.6.22-rc1-mm1/drivers/ata/pata_sis.c	2007-05-18 16:21:46.000000000 +0100
+++ linux-2.6.22-rc1-mm1/drivers/ata/pata_sis.c	2007-05-18 16:34:30.000000000 +0100
@@ -73,14 +73,14 @@
 }
 
 /**
- *	sis_port_base		-	return PCI configuration base for dev
+ *	sis_old_port_base		-	return PCI configuration base for dev
  *	@adev: device
  *
  *	Returns the base of the PCI configuration registers for this port
  *	number.
  */
 
-static int sis_port_base(struct ata_device *adev)
+static int sis_old_port_base(struct ata_device *adev)
 {
 	return  0x40 + (4 * adev->ap->port_no) +  (2 * adev->devno);
 }
@@ -211,7 +211,7 @@
 static void sis_old_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
-	int port = sis_port_base(adev);
+	int port = sis_old_port_base(adev);
 	u8 t1, t2;
 	int speed = adev->pio_mode - XFER_PIO_0;
 
@@ -248,7 +248,7 @@
 static void sis_100_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
-	int port = sis_port_base(adev);
+	int port = sis_old_port_base(adev);
 	int speed = adev->pio_mode - XFER_PIO_0;
 
 	const u8 actrec[] = { 0x00, 0x67, 0x44, 0x33, 0x31 };
@@ -328,7 +328,7 @@
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int speed = adev->dma_mode - XFER_MW_DMA_0;
-	int drive_pci = sis_port_base(adev);
+	int drive_pci = sis_old_port_base(adev);
 	u16 timing;
 
 	const u16 mwdma_bits[] = { 0x707, 0x202, 0x202 };
@@ -367,7 +367,7 @@
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int speed = adev->dma_mode - XFER_MW_DMA_0;
-	int drive_pci = sis_port_base(adev);
+	int drive_pci = sis_old_port_base(adev);
 	u16 timing;
 
 	const u16 mwdma_bits[] = { 0x707, 0x202, 0x202 };
@@ -378,12 +378,12 @@
 	if (adev->dma_mode < XFER_UDMA_0) {
 		/* bits 3-0 hold recovery timing bits 8-10 active timing and
 		   the higer bits are dependant on the device, bit 15 udma */
-		timing &= ~ 0x870F;
+		timing &= ~0x870F;
 		timing |= mwdma_bits[speed];
 	} else {
 		/* Bit 15 is UDMA on/off, bit 12-14 are cycle time */
 		speed = adev->dma_mode - XFER_UDMA_0;
-		timing &= ~0x6000;
+		timing &= ~0xF000;
 		timing |= udma_bits[speed];
 	}
 	pci_write_config_word(pdev, drive_pci, timing);
@@ -405,22 +405,22 @@
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int speed = adev->dma_mode - XFER_MW_DMA_0;
-	int drive_pci = sis_port_base(adev);
-	u16 timing;
+	int drive_pci = sis_old_port_base(adev);
+	u8 timing;
 
-	const u16 udma_bits[]  = { 0x8B00, 0x8700, 0x8500, 0x8300, 0x8200, 0x8100};
+	const u8 udma_bits[]  = { 0x8B, 0x87, 0x85, 0x83, 0x82, 0x81};
 
-	pci_read_config_word(pdev, drive_pci, &timing);
+	pci_read_config_byte(pdev, drive_pci + 1, &timing);
 
 	if (adev->dma_mode < XFER_UDMA_0) {
 		/* NOT SUPPORTED YET: NEED DATA SHEET. DITTO IN OLD DRIVER */
 	} else {
-		/* Bit 15 is UDMA on/off, bit 12-14 are cycle time */
+		/* Bit 7 is UDMA on/off, bit 0-3 are cycle time */
 		speed = adev->dma_mode - XFER_UDMA_0;
-		timing &= ~0x0F00;
+		timing &= ~0x8F;
 		timing |= udma_bits[speed];
 	}
-	pci_write_config_word(pdev, drive_pci, timing);
+	pci_write_config_byte(pdev, drive_pci + 1, timing);
 }
 
 /**
@@ -440,22 +440,22 @@
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int speed = adev->dma_mode - XFER_MW_DMA_0;
-	int drive_pci = sis_port_base(adev);
-	u16 timing;
-
-	static const u16 udma_bits[]  = { 0x8F00, 0x8A00, 0x8700, 0x8500, 0x8300, 0x8200, 0x8100};
+	int drive_pci = sis_old_port_base(adev);
+	u8 timing;
+	/* Low 4 bits are timing */
+	static const u8 udma_bits[]  = { 0x8F, 0x8A, 0x87, 0x85, 0x83, 0x82, 0x81};
 
-	pci_read_config_word(pdev, drive_pci, &timing);
+	pci_read_config_byte(pdev, drive_pci + 1, &timing);
 
 	if (adev->dma_mode < XFER_UDMA_0) {
 		/* NOT SUPPORTED YET: NEED DATA SHEET. DITTO IN OLD DRIVER */
 	} else {
-		/* Bit 15 is UDMA on/off, bit 12-14 are cycle time */
+		/* Bit 7 is UDMA on/off, bit 0-3 are cycle time */
 		speed = adev->dma_mode - XFER_UDMA_0;
-		timing &= ~0x0F00;
+		timing &= ~0x8F;
 		timing |= udma_bits[speed];
 	}
-	pci_write_config_word(pdev, drive_pci, timing);
+	pci_write_config_byte(pdev, drive_pci + 1, timing);
 }
 
 /**
