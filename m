From: akpm@linux-foundation.org
Subject: [patch 09/11] pata_hpt3x3: major reworking and testing
Date: Mon, 09 Jul 2007 11:46:22 -0700
Message-ID: <200707091846.l69IkMTQ001390@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60159 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756501AbXGISzE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 14:55:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, bzolnier@gmail.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

The HPT343/345 (aka 363) is a bit of a warped device.  For many setups you
need to access the other registers via BAR4 offsets.  PIO is now rock
solid, DMA isn't.  Unfortunately the drivers/ide hpt34x driver is
completely broken so doesn't help further debug.

Signed-off-by: Alan Cox <alan@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/Kconfig       |   10 +++-
 drivers/ata/pata_hpt3x3.c |   90 ++++++++++++++++++++++++++++++------
 2 files changed, 85 insertions(+), 15 deletions(-)

diff -puN drivers/ata/Kconfig~pata_hpt3x3-major-reworking-and-testing drivers/ata/Kconfig
--- a/drivers/ata/Kconfig~pata_hpt3x3-major-reworking-and-testing
+++ a/drivers/ata/Kconfig
@@ -318,7 +318,7 @@ config PATA_HPT3X2N
 	  If unsure, say N.
 
 config PATA_HPT3X3
-	tristate "HPT 343/363 PATA support (Experimental)"
+	tristate "HPT 343/363 PATA support"
 	depends on PCI
 	help
 	  This option enables support for the HPT 343/363
@@ -326,6 +326,14 @@ config PATA_HPT3X3
 
 	  If unsure, say N.
 
+config PATA_HPT3X3_DMA
+	bool "HPT 343/363 DMA support (Experimental)"
+	depends on PATA_HPT3X3
+	help
+	  This option enables DMA support for the HPT343/363
+	  controllers. Enable with care as there are still some
+	  problems with DMA on this chipset.
+
 config PATA_ISAPNP
 	tristate "ISA Plug and Play PATA support (Experimental)"
 	depends on EXPERIMENTAL && ISAPNP
diff -puN drivers/ata/pata_hpt3x3.c~pata_hpt3x3-major-reworking-and-testing drivers/ata/pata_hpt3x3.c
--- a/drivers/ata/pata_hpt3x3.c~pata_hpt3x3-major-reworking-and-testing
+++ a/drivers/ata/pata_hpt3x3.c
@@ -23,7 +23,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x3"
-#define DRV_VERSION	"0.4.3"
+#define DRV_VERSION	"0.5.3"
 
 /**
  *	hpt3x3_set_piomode		-	PIO setup
@@ -59,6 +59,9 @@ static void hpt3x3_set_piomode(struct at
  *
  *	Set up the channel for MWDMA or UDMA modes. Much the same as with
  *	PIO, load the mode number and then set MWDMA or UDMA flag.
+ *
+ *	0x44 : bit 0-2 master mode, 3-5 slave mode, etc
+ *	0x48 : bit 4/0 DMA/UDMA bit 5/1 for slave etc
  */
 
 static void hpt3x3_set_dmamode(struct ata_port *ap, struct ata_device *adev)
@@ -76,14 +79,26 @@ static void hpt3x3_set_dmamode(struct at
 	r2 &= ~(0x11 << dn);	/* Clear MWDMA and UDMA bits */
 
 	if (adev->dma_mode >= XFER_UDMA_0)
-		r2 |= 0x01 << dn;	/* Ultra mode */
+		r2 |= (0x10 << dn);	/* Ultra mode */
 	else
-		r2 |= 0x10 << dn;	/* MWDMA */
+		r2 |= (0x01 << dn);	/* MWDMA */
 
 	pci_write_config_dword(pdev, 0x44, r1);
 	pci_write_config_dword(pdev, 0x48, r2);
 }
 
+/**
+ *	hpt3x3_atapi_dma	-	ATAPI DMA check
+ *	@qc: Queued command
+ *
+ *	Just say no - we don't do ATAPI DMA
+ */
+
+static int hpt3x3_atapi_dma(struct ata_queued_cmd *qc)
+{
+	return 1;
+}
+
 static struct scsi_host_template hpt3x3_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -105,7 +120,6 @@ static struct scsi_host_template hpt3x3_
 static struct ata_port_operations hpt3x3_port_ops = {
 	.port_disable	= ata_port_disable,
 	.set_piomode	= hpt3x3_set_piomode,
-	.set_dmamode	= hpt3x3_set_dmamode,
 	.mode_filter	= ata_pci_default_filter,
 
 	.tf_load	= ata_tf_load,
@@ -124,6 +138,7 @@ static struct ata_port_operations hpt3x3
 	.bmdma_start 	= ata_bmdma_start,
 	.bmdma_stop	= ata_bmdma_stop,
 	.bmdma_status 	= ata_bmdma_status,
+	.check_atapi_dma= hpt3x3_atapi_dma,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
@@ -158,32 +173,79 @@ static void hpt3x3_init_chipset(struct p
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x20);
 }
 
-
 /**
  *	hpt3x3_init_one		-	Initialise an HPT343/363
- *	@dev: PCI device
+ *	@pdev: PCI device
  *	@id: Entry in match table
  *
- *	Perform basic initialisation. The chip has a quirk that it won't
- *	function unless it is at XX00. The old ATA driver touched this up
- *	but we leave it for pci quirks to do properly.
+ *	Perform basic initialisation. We set the device up so we access all
+ *	ports via BAR4. This is neccessary to work around errata.
  */
 
-static int hpt3x3_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	static int printed_version;
 	static const struct ata_port_info info = {
 		.sht = &hpt3x3_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
+#if defined(CONFIG_PATA_HPT3X3_DMA)
+		/* Further debug needed */
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x07,
+#endif
 		.port_ops = &hpt3x3_port_ops
 	};
+	/* Register offsets of taskfiles in BAR4 area */
+	static const u8 offset_cmd[2] = { 0x20, 0x28 };
+	static const u8 offset_ctl[2] = { 0x36, 0x3E };
 	const struct ata_port_info *ppi[] = { &info, NULL };
-
-	hpt3x3_init_chipset(dev);
-	/* Now kick off ATA set up */
-	return ata_pci_init_one(dev, ppi);
+	struct ata_host *host;
+	int i, rc;
+	void __iomem *base;
+
+	hpt3x3_init_chipset(pdev);
+
+	if (!printed_version++)
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
+
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 2);
+	if (!host)
+		return -ENOMEM;
+	/* acquire resources and fill host */
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	/* Everything is relative to BAR4 if we set up this way */
+	rc = pcim_iomap_regions(pdev, 1 << 4, DRV_NAME);
+	if (rc == -EBUSY)
+		pcim_pin_device(pdev);
+	if (rc)
+		return rc;
+	host->iomap = pcim_iomap_table(pdev);
+	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		return rc;
+	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		return rc;
+
+	base = host->iomap[4];	/* Bus mastering base */
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_ioports *ioaddr = &host->ports[i]->ioaddr;
+
+		ioaddr->cmd_addr = base + offset_cmd[i];
+		ioaddr->altstatus_addr =
+		ioaddr->ctl_addr = base + offset_ctl[i];
+		ioaddr->scr_addr = NULL;
+		ata_std_ports(ioaddr);
+		ioaddr->bmdma_addr = base + 8 * i;
+	}
+	pci_set_master(pdev);
+	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
+				 &hpt3x3_sht);
 }
 
 #ifdef CONFIG_PM
_
