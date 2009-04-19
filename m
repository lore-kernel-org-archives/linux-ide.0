From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] mv-ahci: add set-mode, cable id functions
Date: Sun, 19 Apr 2009 09:09:16 -0400
Message-ID: <20090419130916.GA4992@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:44802 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755627AbZDSNJU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Apr 2009 09:09:20 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I just checked this into the 'libahci' branch of libata-dev.git...



diff --git a/drivers/ata/mv-ahci.c b/drivers/ata/mv-ahci.c
index a19b979..02b35c5 100644
--- a/drivers/ata/mv-ahci.c
+++ b/drivers/ata/mv-ahci.c
@@ -55,7 +55,28 @@ enum {
 	board_ahci_mv		= 0,
 };
 
-enum mvp_specific_registers {
+enum mvp_host_registers {
+	MVP_HOST_PATA_MODE0	= 0xA0,		/* DMA/PIO mode, drive 0 */
+	MVP_HOST_PATA_MODE1	= 0xA4,		/* DMA/PIO mode, drive 1 */
+
+	MVP_ENABLE_MDMA		= 0x100,	/* Enable MDMA? */
+
+	MVP_MASK_PIO		= 0x38,		/* PIO mode: bits 5:3 */
+	MVP_SHIFT_PIO		= 3,
+	MVP_MASK_MDMA		= 0xC0,		/* MDMA mode: bits 7:6 */
+	MVP_SHIFT_MDMA		= 6,
+	MVP_MASK_UDMA		= 0x7,		/* UDMA mode: bits 2:0 */
+	MVP_SHIFT_UDMA		= 0,
+
+	MVP_MASK_DMA		= MVP_MASK_MDMA | MVP_MASK_UDMA |
+				  MVP_ENABLE_MDMA,
+
+	MVP_CBLID_BAR		= 4,
+	MVP_CBLID_REG		= 0x01,
+	MVP_CBLID		= (1 << 0),
+};
+
+enum mvp_port_registers {
 	MVP_D0_TF0		= 0x20,		/* dev0 taskfile part 1 */
 	MVP_D0_TF1		= 0x24,		/* dev0 taskfile part 2 */
 	MVP_D0_TF2		= 0x28,		/* dev0 taskfile part 3 */
@@ -117,6 +138,9 @@ static int mvp_hardreset(struct ata_link *link, unsigned int *class,
 static int mvp_softreset(struct ata_link *link, unsigned int *class,
 			 unsigned long deadline);
 static int mvp_port_start(struct ata_port *ap);
+static void mvp_set_piomode(struct ata_port *ap, struct ata_device *adev);
+static void mvp_set_dmamode(struct ata_port *ap, struct ata_device *adev);
+static int mvp_cable_id(struct ata_port *ap);
 
 static struct device_attribute *mv_ahci_shost_attrs[] = {
 	&dev_attr_link_power_management_policy,
@@ -182,6 +206,10 @@ static struct ata_port_operations mv_pata_ops = {
 	.qc_prep		= mvp_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
+	.cable_detect		= mvp_cable_id,
+	.set_piomode		= mvp_set_piomode,
+	.set_dmamode		= mvp_set_dmamode,
+
 	.freeze			= ahci_freeze,
 	.thaw			= ahci_thaw,
 	.hardreset		= mvp_hardreset,
@@ -329,6 +357,77 @@ static void mv_ahci_dump_port(struct ata_port *ap)
 	}
 }
 
+static int mvp_cable_id(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->host->iomap[MVP_CBLID_BAR];
+	u8 tmp;
+
+	tmp = ioread8(mmio + MVP_CBLID_REG);
+	if (tmp & MVP_CBLID) {
+		DPRINTK("detected 40-pin PATA cable\n");
+		return ATA_CBL_PATA40;
+	}
+
+	DPRINTK("detected 80-pin PATA cable\n");
+	return ATA_CBL_PATA80;
+}
+
+static void mvp_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	unsigned int pio = adev->pio_mode - XFER_PIO_0;
+	bool is_slave = (adev->devno != 0);
+	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
+	u32 tmp, new_tmp;
+
+	/* TODO?  early chip revs stored this info in PCI BAR4, not BAR5 */
+
+	if (!is_slave)
+		mmio += MVP_HOST_PATA_MODE0;
+	else
+		mmio += MVP_HOST_PATA_MODE1;
+
+	tmp = readl(mmio);
+	new_tmp = tmp & ~MVP_MASK_PIO;
+	new_tmp |= (pio << MVP_SHIFT_PIO);
+
+	if (new_tmp != tmp) {
+		writel(new_tmp, mmio);
+		readl(mmio);	/* flush */
+	}
+}
+
+static void mvp_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+{
+	bool is_slave = (adev->devno != 0);
+	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
+	u32 tmp, new_tmp;
+
+	/* TODO?  early chip revs stored this info in PCI BAR4, not BAR5 */
+
+	if (!is_slave)
+		mmio += MVP_HOST_PATA_MODE0;
+	else
+		mmio += MVP_HOST_PATA_MODE1;
+
+	tmp = readl(mmio);
+	new_tmp = tmp & ~MVP_MASK_DMA;
+
+	if (adev->dma_mode >= XFER_UDMA_0) {
+		unsigned int udma = adev->dma_mode - XFER_UDMA_0;
+
+		new_tmp |= (udma << MVP_SHIFT_UDMA);
+	} else {
+		unsigned int mwdma = adev->dma_mode - XFER_MW_DMA_0;
+
+		new_tmp |= (mwdma << MVP_SHIFT_MDMA) | MVP_ENABLE_MDMA;
+	}
+
+	if (new_tmp != tmp) {
+		writel(new_tmp, mmio);
+		readl(mmio);	/* flush */
+	}
+}
+
 /* WARNING: the following doesn't clear the interrupt, it's
  * a read-only view of the device's ATA shadow registers
  */
@@ -946,7 +1045,9 @@ static int mv_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *en
 	/* AHCI controllers often implement SFF compatible interface.
 	 * Grab all PCI BARs just in case.
 	 */
-	rc = pcim_iomap_regions_request_all(pdev, 1 << AHCI_PCI_BAR, DRV_NAME);
+	rc = pcim_iomap_regions_request_all(pdev,
+			(1 << AHCI_PCI_BAR) | (1 << MVP_CBLID_BAR),
+			DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
