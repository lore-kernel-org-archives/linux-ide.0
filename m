From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/12 UPDATED] libata: convert drivers with combined SATA/PATA ports to new init model
Date: Wed, 11 Apr 2007 18:06:52 +0900
Message-ID: <20070411090652.GE10619@htj.dyndns.org>
References: <200704110858.l3B8w5As003102@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:24869 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbXDKJHA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 05:07:00 -0400
Received: by nz-out-0506.google.com with SMTP id s1so77468nze
        for <linux-ide@vger.kernel.org>; Wed, 11 Apr 2007 02:06:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200704110858.l3B8w5As003102@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, brking@linux.vnet.ibm.com, jeff@garzik.org, linux-ide@vger.kernel.org

Convert sata_via and sata_promise to new init model.  Both controllers
can have combined configuration (SATA + PATA) and used twisted
initialization method (modifying port in ->port_start) to overcome
probe_ent limitations.

This patch converts both drivers to new init model in which such
configuration is natively supported.

* promise: Combined pata port now uses separate port_info entry right
  after the sata counterpart entry.

* promise: Controller configuration is discerned using ap->flags.
  This simplifies init path and makes it look more like other LLDs.

* via: Both SATA and PATA ports in vt6421 are represented in their
  own port_info structure.

Tested on PDC20375 (SATA150 TX2plus) [105a:3375] and PDC40775 (SATA
300 TX2plus) [105a:3d73].  Couldn't test via cuz my c3 won't boot the
current kernel.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Okay, common -> pata rename dropped.

 drivers/ata/sata_promise.c |  255 ++++++++++++++++++---------------------------
 drivers/ata/sata_via.c     |  180 +++++++++++++------------------
 2 files changed, 186 insertions(+), 249 deletions(-)

Index: work/drivers/ata/sata_via.c
===================================================================
--- work.orig/drivers/ata/sata_via.c
+++ work/drivers/ata/sata_via.c
@@ -64,8 +64,6 @@ enum {
 	PORT0			= (1 << 1),
 	PORT1			= (1 << 0),
 	ALL_PORTS		= PORT0 | PORT1,
-	PATA_PORT		= 2,	/* PATA is port 2 */
-	N_PORTS			= 3,
 
 	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
 
@@ -81,7 +79,6 @@ static void vt6420_error_handler(struct 
 static int vt6421_pata_cable_detect(struct ata_port *ap);
 static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev);
 static void vt6421_set_dma_mode(struct ata_port *ap, struct ata_device *adev);
-static int vt6421_port_start(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
 	{ PCI_VDEVICE(VIA, 0x5337), vt6420 },
@@ -140,7 +137,6 @@ static const struct ata_port_operations 
 	.error_handler		= vt6420_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -175,12 +171,11 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= vt6421_pata_cable_detect,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
 
-	.port_start		= vt6421_port_start,
+	.port_start		= ata_port_start,
 };
 
 static const struct ata_port_operations vt6421_sata_ops = {
@@ -207,7 +202,6 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_sata,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -215,11 +209,10 @@ static const struct ata_port_operations 
 	.scr_read		= svia_scr_read,
 	.scr_write		= svia_scr_write,
 
-	.port_start		= vt6421_port_start,
+	.port_start		= ata_port_start,
 };
 
-static struct ata_port_info vt6420_port_info = {
-	.sht		= &svia_sht,
+static const struct ata_port_info vt6420_port_info = {
 	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x07,
@@ -227,6 +220,22 @@ static struct ata_port_info vt6420_port_
 	.port_ops	= &vt6420_sata_ops,
 };
 
+static struct ata_port_info vt6421_sport_info = {
+	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+	.pio_mask	= 0x1f,
+	.mwdma_mask	= 0x07,
+	.udma_mask	= 0x7f,
+	.port_ops	= &vt6421_sata_ops,
+};
+
+static struct ata_port_info vt6421_pport_info = {
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_LEGACY,
+	.pio_mask	= 0x1f,
+	.mwdma_mask	= 0,
+	.udma_mask	= 0x7f,
+	.port_ops	= &vt6421_pata_ops,
+};
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("SCSI low-level driver for VIA SATA controllers");
 MODULE_LICENSE("GPL");
@@ -356,16 +365,6 @@ static void vt6421_set_dma_mode(struct a
 	pci_write_config_byte(pdev, PATA_UDMA_TIMING, udma_bits[adev->pio_mode - XFER_UDMA_0]);
 }
 
-static int vt6421_port_start(struct ata_port *ap)
-{
-	if (ap->port_no == PATA_PORT) {
-		ap->ops = &vt6421_pata_ops;
-		ap->mwdma_mask = 0;
-		ap->flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST;
-	}
-	return ata_port_start(ap);
-}
-
 static const unsigned int svia_bar_sizes[] = {
 	8, 4, 8, 4, 16, 256
 };
@@ -384,79 +383,78 @@ static void __iomem * vt6421_scr_addr(vo
 	return addr + (port * 64);
 }
 
-static void vt6421_init_addrs(struct ata_probe_ent *probe_ent,
-			      void __iomem * const *iomap, unsigned int port)
+static void vt6421_init_addrs(struct ata_port *ap)
 {
-	void __iomem *reg_addr = iomap[port];
-	void __iomem *bmdma_addr = iomap[4] + (port * 8);
-
-	probe_ent->port[port].cmd_addr = reg_addr;
-	probe_ent->port[port].altstatus_addr =
-	probe_ent->port[port].ctl_addr = (void __iomem *)
+	void __iomem * const * iomap = ap->host->iomap;
+	void __iomem *reg_addr = iomap[ap->port_no];
+	void __iomem *bmdma_addr = iomap[4] + (ap->port_no * 8);
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	ioaddr->cmd_addr = reg_addr;
+	ioaddr->altstatus_addr =
+	ioaddr->ctl_addr = (void __iomem *)
 		((unsigned long)(reg_addr + 8) | ATA_PCI_CTL_OFS);
-	probe_ent->port[port].bmdma_addr = bmdma_addr;
-	probe_ent->port[port].scr_addr = vt6421_scr_addr(iomap[5], port);
+	ioaddr->bmdma_addr = bmdma_addr;
+	ioaddr->scr_addr = vt6421_scr_addr(iomap[5], ap->port_no);
 
-	ata_std_ports(&probe_ent->port[port]);
+	ata_std_ports(ioaddr);
 }
 
-static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
+static int vt6420_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 {
-	struct ata_probe_ent *probe_ent;
-	struct ata_port_info *ppi[2];
-	void __iomem *bar5;
+	const struct ata_port_info *ppi[] = { &vt6420_port_info, NULL };
+	struct ata_host *host;
+	int rc;
 
-	ppi[0] = ppi[1] = &vt6420_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-	if (!probe_ent)
-		return NULL;
+	rc = ata_pci_prepare_native_host(pdev, ppi, 2, &host);
+	if (rc)
+		return rc;
+	*r_host = host;
 
-	bar5 = pcim_iomap(pdev, 5, 0);
-	if (!bar5) {
+	rc = pcim_iomap_regions(pdev, 1 << 5, DRV_NAME);
+	if (rc) {
 		dev_printk(KERN_ERR, &pdev->dev, "failed to iomap PCI BAR 5\n");
-		return NULL;
+		return rc;
 	}
 
-	probe_ent->port[0].scr_addr = svia_scr_addr(bar5, 0);
-	probe_ent->port[1].scr_addr = svia_scr_addr(bar5, 1);
+	host->ports[0]->ioaddr.scr_addr = svia_scr_addr(host->iomap[5], 0);
+	host->ports[1]->ioaddr.scr_addr = svia_scr_addr(host->iomap[5], 1);
 
-	return probe_ent;
+	return 0;
 }
 
-static struct ata_probe_ent *vt6421_init_probe_ent(struct pci_dev *pdev)
+static int vt6421_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 {
-	struct ata_probe_ent *probe_ent;
-	unsigned int i;
+	const struct ata_port_info *ppi[] =
+		{ &vt6421_sport_info, &vt6421_sport_info, &vt6421_pport_info };
+	struct ata_host *host;
+	int i, rc;
+
+	*r_host = host = ata_host_alloc_pinfo(&pdev->dev, ppi, ARRAY_SIZE(ppi));
+	if (!host) {
+		dev_printk(KERN_ERR, &pdev->dev, "failed to allocate host\n");
+		return -ENOMEM;
+	}
 
-	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (!probe_ent)
-		return NULL;
-
-	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	probe_ent->sht		= &svia_sht;
-	probe_ent->port_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY;
-	probe_ent->port_ops	= &vt6421_sata_ops;
-	probe_ent->n_ports	= N_PORTS;
-	probe_ent->irq		= pdev->irq;
-	probe_ent->irq_flags	= IRQF_SHARED;
-	probe_ent->pio_mask	= 0x1f;
-	probe_ent->mwdma_mask	= 0x07;
-	probe_ent->udma_mask	= 0x7f;
+	rc = pcim_iomap_regions(pdev, 0x1f, DRV_NAME);
+	if (rc) {
+		dev_printk(KERN_ERR, &pdev->dev, "failed to request/iomap "
+			   "PCI BARs (errno=%d)\n", rc);
+		return rc;
+	}
+	host->iomap = pcim_iomap_table(pdev);
 
-	for (i = 0; i < 6; i++)
-		if (!pcim_iomap(pdev, i, 0)) {
-			dev_printk(KERN_ERR, &pdev->dev,
-				   "failed to iomap PCI BAR %d\n", i);
-			return NULL;
-		}
+	for (i = 0; i < host->n_ports; i++)
+		vt6421_init_addrs(host->ports[i]);
 
-	for (i = 0; i < N_PORTS; i++)
-		vt6421_init_addrs(probe_ent, pcim_iomap_table(pdev), i);
+	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		return rc;
+	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		return rc;
 
-	return probe_ent;
+	return 0;
 }
 
 static void svia_configure(struct pci_dev *pdev)
@@ -503,7 +501,7 @@ static int svia_init_one (struct pci_dev
 	static int printed_version;
 	unsigned int i;
 	int rc;
-	struct ata_probe_ent *probe_ent;
+	struct ata_host *host;
 	int board_id = (int) ent->driver_data;
 	const int *bar_sizes;
 	u8 tmp8;
@@ -515,12 +513,6 @@ static int svia_init_one (struct pci_dev
 	if (rc)
 		return rc;
 
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc) {
-		pcim_pin_device(pdev);
-		return rc;
-	}
-
 	if (board_id == vt6420) {
 		pci_read_config_byte(pdev, SATA_PATA_SHARING, &tmp8);
 		if (tmp8 & SATA_2DEV) {
@@ -546,32 +538,18 @@ static int svia_init_one (struct pci_dev
 			return -ENODEV;
 		}
 
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-
 	if (board_id == vt6420)
-		probe_ent = vt6420_init_probe_ent(pdev);
+		rc = vt6420_prepare_host(pdev, &host);
 	else
-		probe_ent = vt6421_init_probe_ent(pdev);
-
-	if (!probe_ent) {
-		dev_printk(KERN_ERR, &pdev->dev, "out of memory\n");
-		return -ENOMEM;
-	}
+		rc = vt6421_prepare_host(pdev, &host);
+	if (rc)
+		return rc;
 
 	svia_configure(pdev);
 
 	pci_set_master(pdev);
-
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
-
-	devm_kfree(&pdev->dev, probe_ent);
-	return 0;
+	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
+				 &svia_sht);
 }
 
 static int __init svia_init(void)
Index: work/drivers/ata/sata_promise.c
===================================================================
--- work.orig/drivers/ata/sata_promise.c
+++ work/drivers/ata/sata_promise.c
@@ -49,6 +49,7 @@
 
 
 enum {
+	PDC_MAX_PORTS		= 4,
 	PDC_MMIO_BAR		= 3,
 
 	/* register offsets */
@@ -89,10 +90,12 @@ enum {
 				   | PDC1_ERR_MASK | PDC2_ERR_MASK),
 
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
-	board_20319		= 1,	/* FastTrak S150 TX4 */
-	board_20619		= 2,	/* FastTrak TX4000 */
-	board_2057x		= 3,	/* SATAII150 Tx2plus */
-	board_40518		= 4,	/* SATAII150 Tx4 */
+	board_2037x_pata	= 1,	/* FastTrak S150 TX2plus PATA port */
+	board_20319		= 2,	/* FastTrak S150 TX4 */
+	board_20619		= 3,	/* FastTrak TX4000 */
+	board_2057x		= 4,	/* SATAII150 Tx2plus */
+	board_2057x_pata	= 5,	/* SATAII150 Tx2plus */
+	board_40518		= 6,	/* SATAII150 Tx4 */
 
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375/20575 has PATA */
 
@@ -115,8 +118,10 @@ enum {
 				  ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_POLLING,
 
-	/* hp->flags bits */
-	PDC_FLAG_GEN_II		= (1 << 0),
+	/* ap->flags bits */
+	PDC_FLAG_GEN_II		= (1 << 24),
+	PDC_FLAG_SATA_PATA	= (1 << 25), /* supports SATA + PATA */
+	PDC_FLAG_4_PORTS	= (1 << 26), /* 4 ports */
 };
 
 
@@ -125,16 +130,11 @@ struct pdc_port_priv {
 	dma_addr_t		pkt_dma;
 };
 
-struct pdc_host_priv {
-	unsigned long		flags;
-	unsigned long		port_flags[ATA_MAX_PORTS];
-};
-
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static irqreturn_t pdc_interrupt (int irq, void *dev_instance);
-static int pdc_port_start(struct ata_port *ap);
+static int pdc_common_port_start(struct ata_port *ap);
+static int pdc_sata_port_start(struct ata_port *ap);
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
@@ -185,14 +185,13 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.cable_detect		= pdc_sata_cable_detect,
 	.data_xfer		= ata_data_xfer,
-	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
-	.port_start		= pdc_port_start,
+	.port_start		= pdc_sata_port_start,
 };
 
 /* First-generation chips need a more restrictive ->check_atapi_dma op */
@@ -213,14 +212,13 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.cable_detect		= pdc_sata_cable_detect,
 	.data_xfer		= ata_data_xfer,
-	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
-	.port_start		= pdc_port_start,
+	.port_start		= pdc_sata_port_start,
 };
 
 static const struct ata_port_operations pdc_pata_ops = {
@@ -240,29 +238,37 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.cable_detect		= pdc_pata_cable_detect,
 	.data_xfer		= ata_data_xfer,
-	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
 
-	.port_start		= pdc_port_start,
+	.port_start		= pdc_common_port_start,
 };
 
 static const struct ata_port_info pdc_port_info[] = {
 	/* board_2037x */
 	{
-		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS,
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA |
+				  PDC_FLAG_SATA_PATA,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_old_sata_ops,
 	},
 
+	/* board_2037x_pata */
+	{
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &pdc_pata_ops,
+	},
+
 	/* board_20319 */
 	{
-		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA |
+				  PDC_FLAG_4_PORTS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -271,8 +277,8 @@ static const struct ata_port_info pdc_po
 
 	/* board_20619 */
 	{
-		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS |
+				  PDC_FLAG_4_PORTS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -281,18 +287,28 @@ static const struct ata_port_info pdc_po
 
 	/* board_2057x */
 	{
-		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS,
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA |
+				  PDC_FLAG_GEN_II | PDC_FLAG_SATA_PATA,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_sata_ops,
 	},
 
+	/* board_2057x_pata */
+	{
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
+				  PDC_FLAG_GEN_II,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &pdc_pata_ops,
+	},
+
 	/* board_40518 */
 	{
-		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA |
+				  PDC_FLAG_GEN_II | PDC_FLAG_4_PORTS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -358,7 +374,6 @@ static int pdc_common_port_start(struct 
 
 static int pdc_sata_port_start(struct ata_port *ap)
 {
-	struct pdc_host_priv *hp = ap->host->private_data;
 	int rc;
 
 	rc = pdc_common_port_start(ap);
@@ -366,7 +381,7 @@ static int pdc_sata_port_start(struct at
 		return rc;
 
 	/* fix up PHYMODE4 align timing */
-	if (hp->flags & PDC_FLAG_GEN_II) {
+	if (ap->flags & PDC_FLAG_GEN_II) {
 		void __iomem *mmio = (void __iomem *) ap->ioaddr.scr_addr;
 		unsigned int tmp;
 
@@ -378,21 +393,6 @@ static int pdc_sata_port_start(struct at
 	return 0;
 }
 
-static int pdc_port_start(struct ata_port *ap)
-{
-	struct pdc_host_priv *hp = ap->host->private_data;
-
-	/* fix up port flags and cable type for SATA+PATA chips */
-	ap->flags |= hp->port_flags[ap->port_no];
-	if (ap->flags & ATA_FLAG_SATA) {
-		ap->cbl = ATA_CBL_SATA;
-		return pdc_sata_port_start(ap);
-	} else {
-		ap->ops = &pdc_pata_ops;
-		return pdc_common_port_start(ap);
-	}
-}
-
 static void pdc_reset_port(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->ioaddr.cmd_addr + PDC_CTLSTAT;
@@ -660,11 +660,10 @@ static inline unsigned int pdc_host_intr
 {
 	unsigned int handled = 0;
 	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
-	struct pdc_host_priv *hp = ap->host->private_data;
 	u32 port_status, err_mask;
 
 	err_mask = PDC_ERR_MASK;
-	if (hp->flags & PDC_FLAG_GEN_II)
+	if (ap->flags & PDC_FLAG_GEN_II)
 		err_mask &= ~PDC1_ERR_MASK;
 	else
 		err_mask &= ~PDC2_ERR_MASK;
@@ -844,34 +843,34 @@ static int pdc_old_sata_check_atapi_dma(
 	return 1;
 }
 
-static void pdc_ata_setup_port(struct ata_ioports *port, void __iomem *base,
-			       void __iomem *scr_addr)
+static void pdc_ata_setup_port(struct ata_port *ap,
+			       void __iomem *base, void __iomem *scr_addr)
 {
-	port->cmd_addr		= base;
-	port->data_addr		= base;
-	port->feature_addr	=
-	port->error_addr	= base + 0x4;
-	port->nsect_addr	= base + 0x8;
-	port->lbal_addr		= base + 0xc;
-	port->lbam_addr		= base + 0x10;
-	port->lbah_addr		= base + 0x14;
-	port->device_addr	= base + 0x18;
-	port->command_addr	=
-	port->status_addr	= base + 0x1c;
-	port->altstatus_addr	=
-	port->ctl_addr		= base + 0x38;
-	port->scr_addr		= scr_addr;
+	ap->ioaddr.cmd_addr		= base;
+	ap->ioaddr.data_addr		= base;
+	ap->ioaddr.feature_addr		=
+	ap->ioaddr.error_addr		= base + 0x4;
+	ap->ioaddr.nsect_addr		= base + 0x8;
+	ap->ioaddr.lbal_addr		= base + 0xc;
+	ap->ioaddr.lbam_addr		= base + 0x10;
+	ap->ioaddr.lbah_addr		= base + 0x14;
+	ap->ioaddr.device_addr		= base + 0x18;
+	ap->ioaddr.command_addr		=
+	ap->ioaddr.status_addr		= base + 0x1c;
+	ap->ioaddr.altstatus_addr	=
+	ap->ioaddr.ctl_addr		= base + 0x38;
+	ap->ioaddr.scr_addr		= scr_addr;
 }
 
 
-static void pdc_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
+static void pdc_host_init(struct ata_host *host)
 {
-	void __iomem *mmio = pe->iomap[PDC_MMIO_BAR];
-	struct pdc_host_priv *hp = pe->private_data;
+	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
+	int is_gen2 = host->ports[0]->flags & PDC_FLAG_GEN_II;
 	int hotplug_offset;
 	u32 tmp;
 
-	if (hp->flags & PDC_FLAG_GEN_II)
+	if (is_gen2)
 		hotplug_offset = PDC2_SATA_PLUG_CSR;
 	else
 		hotplug_offset = PDC_SATA_PLUG_CSR;
@@ -885,7 +884,7 @@ static void pdc_host_init(unsigned int c
 	/* enable BMR_BURST, maybe change FIFO_SHD to 8 dwords */
 	tmp = readl(mmio + PDC_FLASH_CTL);
 	tmp |= 0x02000;	/* bit 13 (enable bmr burst) */
-	if (!(hp->flags & PDC_FLAG_GEN_II))
+	if (!is_gen2)
 		tmp |= 0x10000;	/* bit 16 (fifo threshold at 8 dw) */
 	writel(tmp, mmio + PDC_FLASH_CTL);
 
@@ -898,7 +897,7 @@ static void pdc_host_init(unsigned int c
 	writel(tmp | 0xff0000, mmio + hotplug_offset);
 
 	/* don't initialise TBG or SLEW on 2nd generation chips */
-	if (hp->flags & PDC_FLAG_GEN_II)
+	if (is_gen2)
 		return;
 
 	/* reduce TBG clock to 133 Mhz. */
@@ -920,16 +919,16 @@ static void pdc_host_init(unsigned int c
 static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent;
-	struct pdc_host_priv *hp;
+	const struct ata_port_info *pi = &pdc_port_info[ent->driver_data];
+	const struct ata_port_info *ppi[PDC_MAX_PORTS];
+	struct ata_host *host;
 	void __iomem *base;
-	unsigned int board_idx = (unsigned int) ent->driver_data;
-	int rc;
-	u8 tmp;
+	int n_ports, i, rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* enable and acquire resources */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -939,89 +938,49 @@ static int pdc_ata_init_one (struct pci_
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
+	base = pcim_iomap_table(pdev)[PDC_MMIO_BAR];
 
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-
-	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL)
-		return -ENOMEM;
+	/* determine port configuration and setup host */
+	n_ports = 2;
+	if (pi->flags & PDC_FLAG_4_PORTS)
+		n_ports = 4;
+	for (i = 0; i < n_ports; i++)
+		ppi[i] = pi;
 
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	INIT_LIST_HEAD(&probe_ent->node);
+	if (pi->flags & PDC_FLAG_SATA_PATA) {
+		u8 tmp = readb(base + PDC_FLASH_CTL+1);
+		if (!(tmp & 0x80)) {
+			ppi[n_ports++] = pi + 1;
+			dev_printk(KERN_INFO, &pdev->dev, "PATA port found\n");
+		}
+	}
 
-	hp = devm_kzalloc(&pdev->dev, sizeof(*hp), GFP_KERNEL);
-	if (hp == NULL)
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
+	if (!host) {
+		dev_printk(KERN_ERR, &pdev->dev, "failed to allocate host\n");
 		return -ENOMEM;
-
-	probe_ent->private_data = hp;
-
-	probe_ent->sht		= pdc_port_info[board_idx].sht;
-	probe_ent->port_flags	= pdc_port_info[board_idx].flags;
-	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
-	probe_ent->mwdma_mask	= pdc_port_info[board_idx].mwdma_mask;
-	probe_ent->udma_mask	= pdc_port_info[board_idx].udma_mask;
-	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
-
-       	probe_ent->irq = pdev->irq;
-       	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->iomap = pcim_iomap_table(pdev);
-
-	base = probe_ent->iomap[PDC_MMIO_BAR];
-
-	pdc_ata_setup_port(&probe_ent->port[0], base + 0x200, base + 0x400);
-	pdc_ata_setup_port(&probe_ent->port[1], base + 0x280, base + 0x500);
-
-	/* notice 4-port boards */
-	switch (board_idx) {
-	case board_40518:
-		hp->flags |= PDC_FLAG_GEN_II;
-		/* Fall through */
-	case board_20319:
-       		probe_ent->n_ports = 4;
-		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300, base + 0x600);
-		pdc_ata_setup_port(&probe_ent->port[3], base + 0x380, base + 0x700);
-		break;
-	case board_2057x:
-		hp->flags |= PDC_FLAG_GEN_II;
-		/* Fall through */
-	case board_2037x:
-		/* TX2plus boards also have a PATA port */
-		tmp = readb(base + PDC_FLASH_CTL+1);
-		if (!(tmp & 0x80)) {
-			probe_ent->n_ports = 3;
-			pdc_ata_setup_port(&probe_ent->port[2], base + 0x300, NULL);
-			hp->port_flags[2] = ATA_FLAG_SLAVE_POSS;
-			printk(KERN_INFO DRV_NAME " PATA port found\n");
-		} else
-			probe_ent->n_ports = 2;
-		hp->port_flags[0] = ATA_FLAG_SATA;
-		hp->port_flags[1] = ATA_FLAG_SATA;
-		break;
-	case board_20619:
-		probe_ent->n_ports = 4;
-		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300, NULL);
-		pdc_ata_setup_port(&probe_ent->port[3], base + 0x380, NULL);
-		break;
-	default:
-		BUG();
-		break;
 	}
+	host->iomap = pcim_iomap_table(pdev);
 
-	pci_set_master(pdev);
+	for (i = 0; i < host->n_ports; i++)
+		pdc_ata_setup_port(host->ports[i],
+				   base + 0x200 + i * 0x80,
+				   base + 0x400 + i * 0x100);
 
 	/* initialize adapter */
-	pdc_host_init(board_idx, probe_ent);
+	pdc_host_init(host);
 
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
+	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		return rc;
+	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		return rc;
 
-	devm_kfree(&pdev->dev, probe_ent);
-	return 0;
+	/* start host, request IRQ and attach */
+	pci_set_master(pdev);
+	return ata_host_activate(host, pdev->irq, pdc_interrupt, IRQF_SHARED,
+				 &pdc_ata_sht);
 }
 
 
