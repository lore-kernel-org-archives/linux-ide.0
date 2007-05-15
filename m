From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] libata: Add MMIO support to pata_sil680
Date: Tue, 15 May 2007 16:12:08 +1000
Message-ID: <20070515061239.611A2DDEE9@ozlabs.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:45467 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758989AbXEOGMk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 May 2007 02:12:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

This patch adds MMIO support to the pata_sil680 for taskfile IOs,
based on what the old siimage does.

I haven't bothered changing the chip setup stuff from PCI config
cycles to MMIO though (siimage does it), I don't think it matters,
I've only adapted it to use MMIO for taskfile accesses.

I've tested it on a Cell blade and it seems to work fine.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 drivers/ata/pata_sil680.c |   70 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 8 deletions(-)

Index: linux-cell/drivers/ata/pata_sil680.c
===================================================================
--- linux-cell.orig/drivers/ata/pata_sil680.c	2007-05-15 15:19:08.000000000 +1000
+++ linux-cell/drivers/ata/pata_sil680.c	2007-05-15 16:06:56.000000000 +1000
@@ -35,6 +35,8 @@
 #define DRV_NAME "pata_sil680"
 #define DRV_VERSION "0.4.6"
 
+#define SIL680_MMIO_BAR		5
+
 /**
  *	sil680_selreg		-	return register base
  *	@hwif: interface
@@ -278,7 +280,7 @@ static struct ata_port_operations sil680
  *	Returns the final clock settings.
  */
 
-static u8 sil680_init_chip(struct pci_dev *pdev)
+static u8 sil680_init_chip(struct pci_dev *pdev, int *try_mmio)
 {
 	u32 class_rev	= 0;
 	u8 tmpbyte	= 0;
@@ -293,8 +295,10 @@ static u8 sil680_init_chip(struct pci_de
 
 	pci_read_config_byte(pdev, 0x8A, &tmpbyte);
 
-	printk(KERN_INFO "sil680: BA5_EN = %d clock = %02X\n",
-			tmpbyte & 1, tmpbyte & 0x30);
+	dev_dbg(&pdev->dev, "sil680: BA5_EN = %d clock = %02X\n",
+		tmpbyte & 1, tmpbyte & 0x30);
+
+	*try_mmio = (tmpbyte & 1) || pci_resource_start(pdev, 5);
 
 	switch(tmpbyte & 0x30) {
 		case 0x00:
@@ -315,8 +319,8 @@ static u8 sil680_init_chip(struct pci_de
 	}
 
 	pci_read_config_byte(pdev,   0x8A, &tmpbyte);
-	printk(KERN_INFO "sil680: BA5_EN = %d clock = %02X\n",
-			tmpbyte & 1, tmpbyte & 0x30);
+	dev_dbg(&pdev->dev, "sil680: BA5_EN = %d clock = %02X\n",
+		tmpbyte & 1, tmpbyte & 0x30);
 
 	pci_write_config_byte(pdev,  0xA1, 0x72);
 	pci_write_config_word(pdev,  0xA2, 0x328A);
@@ -339,7 +343,8 @@ static u8 sil680_init_chip(struct pci_de
 	return tmpbyte & 0x30;
 }
 
-static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
+static int __devinit sil680_init_one(struct pci_dev *pdev,
+				     const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
 		.sht = &sil680_sht,
@@ -359,18 +364,67 @@ static int sil680_init_one(struct pci_de
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
 	static int printed_version;
+	struct ata_host *host;
+	void __iomem *mmio_base;
+	int rc, try_mmio;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	switch(sil680_init_chip(pdev))
-	{
+	switch(sil680_init_chip(pdev, &try_mmio)) {
 		case 0:
 			ppi[0] = &info_slow;
 			break;
 		case 0x30:
 			return -ENODEV;
 	}
+
+	if (!try_mmio)
+		goto use_pio;
+
+	/* Try to acquire MMIO resources and fallback to PIO if
+	 * that fails
+	 */
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+	rc = pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR, DRV_NAME);
+	if (rc)
+		goto use_pio;
+
+	/* Allocate host and set it up */
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 2);
+	if (!host)
+		return -ENOMEM;
+	host->iomap = pcim_iomap_table(pdev);
+
+	/* Setup DMA masks */
+	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		return rc;
+	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		return rc;
+	pci_set_master(pdev);
+
+	/* Get MMIO base and initialize port addresses */
+	mmio_base = host->iomap[SIL680_MMIO_BAR];
+	host->ports[0]->ioaddr.bmdma_addr = mmio_base + 0x00;
+	host->ports[0]->ioaddr.cmd_addr = mmio_base + 0x80;
+	host->ports[0]->ioaddr.ctl_addr = mmio_base + 0x8a;
+	host->ports[0]->ioaddr.altstatus_addr = mmio_base + 0x8a;
+	ata_std_ports(&host->ports[0]->ioaddr);
+	host->ports[1]->ioaddr.bmdma_addr = mmio_base + 0x08;
+	host->ports[1]->ioaddr.cmd_addr = mmio_base + 0xc0;
+	host->ports[1]->ioaddr.ctl_addr = mmio_base + 0xca;
+	host->ports[1]->ioaddr.altstatus_addr = mmio_base + 0xca;
+	ata_std_ports(&host->ports[1]->ioaddr);
+
+	/* Register & activate */
+	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
+				 &sil680_sht);
+
+use_pio:
 	return ata_pci_init_one(pdev, ppi);
 }
 
