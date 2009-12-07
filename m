From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/5] pata_hpt{37x|3x2n}: unify mode programming
Date: Mon, 7 Dec 2009 23:30:06 +0400
Message-ID: <200912072230.06256.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:39661 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1756164AbZLGT2r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 14:28:47 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk

As these drivers' set_piomode() and set_dmamode() methods are almost identical,
factor out the common hpt{37x|3x2n}_set_mode() function to be called by both of
them, the same as in 'pata_hpt366' driver.

This results in ~5% decrease in the 'pata_hpt37x' driver binary size and in ~4%
decrease in the 'pata_hpt3x2n' driver binary size (as measured on x86-32).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_hpt37x.c  |  137 +++++++++++++++++++--------------------------
 drivers/ata/pata_hpt3x2n.c |   69 ++++++++++------------
 2 files changed, 90 insertions(+), 116 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.14"
+#define DRV_VERSION	"0.6.15"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -377,20 +377,12 @@ static int hpt374_fn1_pre_reset(struct a
 	return ata_sff_prereset(link, deadline);
 }
 
-/**
- *	hpt370_set_piomode		-	PIO setup
- *	@ap: ATA interface
- *	@adev: device on the interface
- *
- *	Perform PIO mode setup.
- */
-
-static void hpt370_set_piomode(struct ata_port *ap, struct ata_device *adev)
+static void hpt370_set_mode(struct ata_port *ap, struct ata_device *adev,
+			    u8 mode)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
-	u32 reg;
-	u32 mode;
+	u32 reg, timing, mask;
 	u8 fast;
 
 	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
@@ -402,11 +394,31 @@ static void hpt370_set_piomode(struct at
 	fast |= 0x01;
 	pci_write_config_byte(pdev, addr2, fast);
 
+	/* Determine timing mask and find matching mode entry */
+	if (mode < XFER_MW_DMA_0)
+		mask = 0xcfc3ffff;
+	else if (mode < XFER_UDMA_0)
+		mask = 0x31c001ff;
+	else
+		mask = 0x303c0000;
+
+	timing = hpt37x_find_mode(ap, mode);
+
 	pci_read_config_dword(pdev, addr1, &reg);
-	mode = hpt37x_find_mode(ap, adev->pio_mode);
-	mode &= 0xCFC3FFFF;	/* Leave DMA bits alone */
-	reg &= ~0xCFC3FFFF;	/* Strip timing bits */
-	pci_write_config_dword(pdev, addr1, reg | mode);
+	reg = (reg & ~mask) | (timing & mask);
+	pci_write_config_dword(pdev, addr1, reg);
+}
+/**
+ *	hpt370_set_piomode		-	PIO setup
+ *	@ap: ATA interface
+ *	@adev: device on the interface
+ *
+ *	Perform PIO mode setup.
+ */
+
+static void hpt370_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	hpt370_set_mode(ap, adev, adev->pio_mode);
 }
 
 /**
@@ -414,33 +426,12 @@ static void hpt370_set_piomode(struct at
  *	@ap: ATA interface
  *	@adev: Device being configured
  *
- *	Set up the channel for MWDMA or UDMA modes. Much the same as with
- *	PIO, load the mode number and then set MWDMA or UDMA flag.
+ *	Set up the channel for MWDMA or UDMA modes.
  */
 
 static void hpt370_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u32 addr1, addr2;
-	u32 reg, mode, mask;
-	u8 fast;
-
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
-	addr2 = 0x51 + 4 * ap->port_no;
-
-	/* Fast interrupt prediction disable, hold off interrupt disable */
-	pci_read_config_byte(pdev, addr2, &fast);
-	fast &= ~0x02;
-	fast |= 0x01;
-	pci_write_config_byte(pdev, addr2, fast);
-
-	mask = adev->dma_mode < XFER_UDMA_0 ? 0x31C001FF : 0x303C0000;
-
-	pci_read_config_dword(pdev, addr1, &reg);
-	mode = hpt37x_find_mode(ap, adev->dma_mode);
-	mode &= mask;
-	reg &= ~mask;
-	pci_write_config_dword(pdev, addr1, reg | mode);
+	hpt370_set_mode(ap, adev, adev->dma_mode);
 }
 
 /**
@@ -480,20 +471,12 @@ static void hpt370_bmdma_stop(struct ata
 	ata_bmdma_stop(qc);
 }
 
-/**
- *	hpt372_set_piomode		-	PIO setup
- *	@ap: ATA interface
- *	@adev: device on the interface
- *
- *	Perform PIO mode setup.
- */
-
-static void hpt372_set_piomode(struct ata_port *ap, struct ata_device *adev)
+static void hpt372_set_mode(struct ata_port *ap, struct ata_device *adev,
+			    u8 mode)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
-	u32 reg;
-	u32 mode;
+	u32 reg, timing, mask;
 	u8 fast;
 
 	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
@@ -504,13 +487,32 @@ static void hpt372_set_piomode(struct at
 	fast &= ~0x07;
 	pci_write_config_byte(pdev, addr2, fast);
 
+	/* Determine timing mask and find matching mode entry */
+	if (mode < XFER_MW_DMA_0)
+		mask = 0xcfc3ffff;
+	else if (mode < XFER_UDMA_0)
+		mask = 0x31c001ff;
+	else
+		mask = 0x303c0000;
+
+	timing = hpt37x_find_mode(ap, mode);
+
 	pci_read_config_dword(pdev, addr1, &reg);
-	mode = hpt37x_find_mode(ap, adev->pio_mode);
+	reg = (reg & ~mask) | (timing & mask);
+	pci_write_config_dword(pdev, addr1, reg);
+}
 
-	printk("Find mode for %d reports %X\n", adev->pio_mode, mode);
-	mode &= 0xCFC3FFFF;	/* Leave DMA bits alone */
-	reg &= ~0xCFC3FFFF;	/* Strip timing bits */
-	pci_write_config_dword(pdev, addr1, reg | mode);
+/**
+ *	hpt372_set_piomode		-	PIO setup
+ *	@ap: ATA interface
+ *	@adev: device on the interface
+ *
+ *	Perform PIO mode setup.
+ */
+
+static void hpt372_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	hpt372_set_mode(ap, adev, adev->pio_mode);
 }
 
 /**
@@ -518,33 +520,12 @@ static void hpt372_set_piomode(struct at
  *	@ap: ATA interface
  *	@adev: Device being configured
  *
- *	Set up the channel for MWDMA or UDMA modes. Much the same as with
- *	PIO, load the mode number and then set MWDMA or UDMA flag.
+ *	Set up the channel for MWDMA or UDMA modes.
  */
 
 static void hpt372_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u32 addr1, addr2;
-	u32 reg, mode, mask;
-	u8 fast;
-
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
-	addr2 = 0x51 + 4 * ap->port_no;
-
-	/* Fast interrupt prediction disable, hold off interrupt disable */
-	pci_read_config_byte(pdev, addr2, &fast);
-	fast &= ~0x07;
-	pci_write_config_byte(pdev, addr2, fast);
-
-	mask = adev->dma_mode < XFER_UDMA_0 ? 0x31C001FF : 0x303C0000;
-
-	pci_read_config_dword(pdev, addr1, &reg);
-	mode = hpt37x_find_mode(ap, adev->dma_mode);
-	printk("Find mode for DMA %d reports %X\n", adev->dma_mode, mode);
-	mode &= mask;
-	reg &= ~mask;
-	pci_write_config_dword(pdev, addr1, reg | mode);
+	hpt372_set_mode(ap, adev, adev->dma_mode);
 }
 
 /**
Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.9"
+#define DRV_VERSION	"0.3.10"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -159,20 +159,12 @@ static int hpt3x2n_pre_reset(struct ata_
 	return ata_sff_prereset(link, deadline);
 }
 
-/**
- *	hpt3x2n_set_piomode		-	PIO setup
- *	@ap: ATA interface
- *	@adev: device on the interface
- *
- *	Perform PIO mode setup.
- */
-
-static void hpt3x2n_set_piomode(struct ata_port *ap, struct ata_device *adev)
+static void hpt3x2n_set_mode(struct ata_port *ap, struct ata_device *adev,
+			     u8 mode)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
-	u32 reg;
-	u32 mode;
+	u32 reg, timing, mask;
 	u8 fast;
 
 	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
@@ -183,11 +175,32 @@ static void hpt3x2n_set_piomode(struct a
 	fast &= ~0x07;
 	pci_write_config_byte(pdev, addr2, fast);
 
+	/* Determine timing mask and find matching mode entry */
+	if (mode < XFER_MW_DMA_0)
+		mask = 0xcfc3ffff;
+	else if (mode < XFER_UDMA_0)
+		mask = 0x31c001ff;
+	else
+		mask = 0x303c0000;
+
+	timing = hpt3x2n_find_mode(ap, mode);
+
 	pci_read_config_dword(pdev, addr1, &reg);
-	mode = hpt3x2n_find_mode(ap, adev->pio_mode);
-	mode &= 0xCFC3FFFF;	/* Leave DMA bits alone */
-	reg &= ~0xCFC3FFFF;	/* Strip timing bits */
-	pci_write_config_dword(pdev, addr1, reg | mode);
+	reg = (reg & ~mask) | (timing & mask);
+	pci_write_config_dword(pdev, addr1, reg);
+}
+
+/**
+ *	hpt3x2n_set_piomode		-	PIO setup
+ *	@ap: ATA interface
+ *	@adev: device on the interface
+ *
+ *	Perform PIO mode setup.
+ */
+
+static void hpt3x2n_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	hpt3x2n_set_mode(ap, adev, adev->pio_mode);
 }
 
 /**
@@ -195,32 +208,12 @@ static void hpt3x2n_set_piomode(struct a
  *	@ap: ATA interface
  *	@adev: Device being configured
  *
- *	Set up the channel for MWDMA or UDMA modes. Much the same as with
- *	PIO, load the mode number and then set MWDMA or UDMA flag.
+ *	Set up the channel for MWDMA or UDMA modes.
  */
 
 static void hpt3x2n_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u32 addr1, addr2;
-	u32 reg, mode, mask;
-	u8 fast;
-
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
-	addr2 = 0x51 + 4 * ap->port_no;
-
-	/* Fast interrupt prediction disable, hold off interrupt disable */
-	pci_read_config_byte(pdev, addr2, &fast);
-	fast &= ~0x07;
-	pci_write_config_byte(pdev, addr2, fast);
-
-	mask = adev->dma_mode < XFER_UDMA_0 ? 0x31C001FF : 0x303C0000;
-
-	pci_read_config_dword(pdev, addr1, &reg);
-	mode = hpt3x2n_find_mode(ap, adev->dma_mode);
-	mode &= mask;
-	reg &= ~mask;
-	pci_write_config_dword(pdev, addr1, reg | mode);
+	hpt3x2n_set_mode(ap, adev, adev->dma_mode);
 }
 
 /**

