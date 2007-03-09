From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/12] libata: convert ata_pci_init_native_mode() users to new init model
Date: Fri, 9 Mar 2007 20:15:36 +0900
Message-ID: <11734389362374-git-send-email-htejun@gmail.com>
References: <1173438935540-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:5345 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767185AbXCILPs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:15:48 -0500
Received: by wr-out-0506.google.com with SMTP id 71so1261523wri
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 03:15:47 -0800 (PST)
In-Reply-To: <1173438935540-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert drivers which use ata_pci_init_native_mode() to new init
model.  ata_pci_init_native_host() is used instead.  sata_nv, sata_uli
and sata_sis are in this category.

Tested on nVidia Corporation CK804 Serial ATA Controller [10de:0054]
in both BMDMA and ADMA mode.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_nv.c  |   86 +++++++++++++++++++++--------------------------
 drivers/ata/sata_sis.c |   49 +++++++++------------------
 drivers/ata/sata_uli.c |   62 +++++++++++++---------------------
 3 files changed, 79 insertions(+), 118 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index eb0f877..37cbea5 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -368,7 +368,6 @@ static const struct ata_port_operations nv_generic_ops = {
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
-	.irq_handler		= nv_generic_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -395,7 +394,6 @@ static const struct ata_port_operations nv_nf2_ops = {
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
-	.irq_handler		= nv_nf2_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -422,7 +420,6 @@ static const struct ata_port_operations nv_ck804_ops = {
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
-	.irq_handler		= nv_ck804_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -451,7 +448,6 @@ static const struct ata_port_operations nv_adma_ops = {
 	.error_handler		= nv_adma_error_handler,
 	.post_internal_cmd	= nv_adma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
-	.irq_handler		= nv_adma_interrupt,
 	.irq_clear		= nv_adma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -476,6 +472,7 @@ static struct ata_port_info nv_port_info[] = {
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
 		.port_ops	= &nv_generic_ops,
+		.irq_handler	= nv_generic_interrupt,
 	},
 	/* nforce2/3 */
 	{
@@ -486,6 +483,7 @@ static struct ata_port_info nv_port_info[] = {
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
 		.port_ops	= &nv_nf2_ops,
+		.irq_handler	= nv_nf2_interrupt,
 	},
 	/* ck804 */
 	{
@@ -496,6 +494,7 @@ static struct ata_port_info nv_port_info[] = {
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
 		.port_ops	= &nv_ck804_ops,
+		.irq_handler	= nv_ck804_interrupt,
 	},
 	/* ADMA */
 	{
@@ -507,6 +506,7 @@ static struct ata_port_info nv_port_info[] = {
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
 		.port_ops	= &nv_adma_ops,
+		.irq_handler	= nv_adma_interrupt,
 	},
 };
 
@@ -1068,14 +1068,14 @@ static int nv_adma_port_resume(struct ata_port *ap)
 }
 #endif
 
-static void nv_adma_setup_port(struct ata_probe_ent *probe_ent, unsigned int port)
+static void nv_adma_setup_port(struct ata_port *ap)
 {
-	void __iomem *mmio = probe_ent->iomap[NV_MMIO_BAR];
-	struct ata_ioports *ioport = &probe_ent->port[port];
+	void __iomem *mmio = ap->host->iomap[NV_MMIO_BAR];
+	struct ata_ioports *ioport = &ap->ioaddr;
 
 	VPRINTK("ENTER\n");
 
-	mmio += NV_ADMA_PORT + port * NV_ADMA_PORT_SIZE;
+	mmio += NV_ADMA_PORT + ap->port_no * NV_ADMA_PORT_SIZE;
 
 	ioport->cmd_addr	= mmio;
 	ioport->data_addr	= mmio + (ATA_REG_DATA * 4);
@@ -1092,9 +1092,9 @@ static void nv_adma_setup_port(struct ata_probe_ent *probe_ent, unsigned int por
 	ioport->ctl_addr	= mmio + 0x20;
 }
 
-static int nv_adma_host_init(struct ata_probe_ent *probe_ent)
+static int nv_adma_host_init(struct ata_host *host)
 {
-	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
+	struct pci_dev *pdev = to_pci_dev(host->dev);
 	unsigned int i;
 	u32 tmp32;
 
@@ -1109,8 +1109,8 @@ static int nv_adma_host_init(struct ata_probe_ent *probe_ent)
 
 	pci_write_config_dword(pdev, NV_MCP_SATA_CFG_20, tmp32);
 
-	for (i = 0; i < probe_ent->n_ports; i++)
-		nv_adma_setup_port(probe_ent, i);
+	for (i = 0; i < host->n_ports; i++)
+		nv_adma_setup_port(host->ports[i]);
 
 	return 0;
 }
@@ -1467,14 +1467,13 @@ static void nv_adma_error_handler(struct ata_port *ap)
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
-	struct ata_port_info *ppi[2];
-	struct ata_probe_ent *probe_ent;
+	const struct ata_port_info *ppi[2];
+	struct ata_host *host;
 	struct nv_host_priv *hpriv;
 	int rc;
 	u32 bar;
 	void __iomem *base;
 	unsigned long type = ent->driver_data;
-	u64 dma_mask = ATA_DMA_MASK;
 
         // Make sure this is a SATA controller by counting the number of bars
         // (NVIDIA SATA controllers will always have six bars).  Otherwise,
@@ -1490,43 +1489,38 @@ static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc) {
-		pcim_pin_device(pdev);
-		return rc;
-	}
-
-	if(type >= CK804 && adma_enabled) {
+	/* determine type and allocate host */
+	if (type >= CK804 && adma_enabled) {
 		dev_printk(KERN_NOTICE, &pdev->dev, "Using ADMA mode\n");
 		type = ADMA;
-		dma_mask = DMA_64BIT_MASK;
 	}
 
-	rc = pci_configure_dma_masks(pdev, dma_mask, NULL);
+	ppi[0] = ppi[1] = &nv_port_info[type];
+	rc = ata_pci_prepare_native_host(pdev, ppi, 2, &host);
 	if (rc)
 		return rc;
 
-	rc = -ENOMEM;
-
 	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
+	hpriv->type = type;
+	host->private_data = hpriv;
 
-	ppi[0] = ppi[1] = &nv_port_info[type];
-	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-	if (!probe_ent)
-		return -ENOMEM;
-
-	if (!pcim_iomap(pdev, NV_MMIO_BAR, 0))
-		return -EIO;
-	probe_ent->iomap = pcim_iomap_table(pdev);
+	if (type == ADMA) {
+		rc = pci_configure_dma_masks(pdev, DMA_64BIT_MASK, NULL);
+		if (rc)
+			return rc;
+	}
 
-	probe_ent->private_data = hpriv;
-	hpriv->type = type;
+	/* request and iomap NV_MMIO_BAR */
+	rc = pcim_iomap_regions(pdev, 1 << NV_MMIO_BAR, DRV_NAME);
+	if (rc)
+		return rc;
 
-	base = probe_ent->iomap[NV_MMIO_BAR];
-	probe_ent->port[0].scr_addr = base + NV_PORT0_SCR_REG_OFFSET;
-	probe_ent->port[1].scr_addr = base + NV_PORT1_SCR_REG_OFFSET;
+	/* configure SCR access */
+	base = host->iomap[NV_MMIO_BAR];
+	host->ports[0]->ioaddr.scr_addr = base + NV_PORT0_SCR_REG_OFFSET;
+	host->ports[1]->ioaddr.scr_addr = base + NV_PORT1_SCR_REG_OFFSET;
 
 	/* enable SATA space for CK804 */
 	if (type >= CK804) {
@@ -1537,20 +1531,16 @@ static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
 	}
 
-	pci_set_master(pdev);
-
+	/* init ADMA */
 	if (type == ADMA) {
-		rc = nv_adma_host_init(probe_ent);
+		rc = nv_adma_host_init(host);
 		if (rc)
 			return rc;
 	}
 
-	rc = ata_device_add(probe_ent);
-	if (rc != NV_PORTS)
-		return -ENODEV;
-
-	devm_kfree(&pdev->dev, probe_ent);
-	return 0;
+	pci_set_master(pdev);
+	return ata_host_activate(host, pdev->irq, ppi[0]->irq_handler,
+				 IRQF_SHARED, ppi[0]->sht);
 }
 
 static void nv_remove_one (struct pci_dev *pdev)
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 75c5683..d8ee062 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -121,7 +121,6 @@ static const struct ata_port_operations sis_ops = {
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -131,7 +130,6 @@ static const struct ata_port_operations sis_ops = {
 };
 
 static struct ata_port_info sis_port_info = {
-	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x7,
@@ -256,12 +254,13 @@ static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent = NULL;
-	int rc;
+	struct ata_port_info pi = sis_port_info;
+	const struct ata_port_info *ppi[2] = { &pi, &pi };
+	struct ata_host *host;
 	u32 genctl, val;
-	struct ata_port_info pi = sis_port_info, *ppi[2] = { &pi, &pi };
 	u8 pmr;
 	u8 port2_start = 0x20;
+	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
@@ -270,16 +269,6 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc) {
-		pcim_pin_device(pdev);
-		return rc;
-	}
-
-	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
-	if (rc)
-		return rc;
-
 	/* check and see if the SCRs are in IO space or PCI cfg space */
 	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
 	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
@@ -346,30 +335,26 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		break;
 	}
 
-	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-	if (!probe_ent)
-		return -ENOMEM;
+	rc = ata_pci_prepare_native_host(pdev, ppi, 2, &host);
+	if (rc)
+		return rc;
 
-	if (!(probe_ent->port_flags & SIS_FLAG_CFGSCR)) {
-		void *mmio;
+	if (!(pi.flags & SIS_FLAG_CFGSCR)) {
+		void __iomem *mmio;
 
-		mmio = pcim_iomap(pdev, SIS_SCR_PCI_BAR, 0);
-		if (!mmio)
-			return -ENOMEM;
+		rc = pcim_iomap_regions(pdev, 1 << SIS_SCR_PCI_BAR, DRV_NAME);
+		if (rc)
+			return rc;
+		mmio = host->iomap[SIS_SCR_PCI_BAR];
 
-		probe_ent->port[0].scr_addr = mmio;
-		probe_ent->port[1].scr_addr = mmio + port2_start;
+		host->ports[0]->ioaddr.scr_addr = mmio;
+		host->ports[1]->ioaddr.scr_addr = mmio + port2_start;
 	}
 
 	pci_set_master(pdev);
 	pci_intx(pdev, 1);
-
-	if (!ata_device_add(probe_ent))
-		return -EIO;
-
-	devm_kfree(&pdev->dev, probe_ent);
-	return 0;
-
+	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
+				 &sis_sht);
 }
 
 static int __init sis_init(void)
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index bfdb73e..f74e383 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -115,7 +115,6 @@ static const struct ata_port_operations uli_ops = {
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -127,7 +126,6 @@ static const struct ata_port_operations uli_ops = {
 };
 
 static struct ata_port_info uli_port_info = {
-	.sht            = &uli_sht,
 	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 			  ATA_FLAG_IGN_SIMPLEX,
 	.pio_mask       = 0x1f,		/* pio0-4 */
@@ -185,12 +183,13 @@ static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent;
-	struct ata_port_info *ppi[2];
-	int rc;
+	const struct ata_port_info *ppi[] = { &uli_port_info, NULL };
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	struct ata_host *host;
 	struct uli_priv *hpriv;
 	void __iomem * const *iomap;
+	struct ata_ioports *ioaddr;
+	int n_ports, rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
@@ -199,51 +198,42 @@ static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc) {
-		pcim_pin_device(pdev);
-		return rc;
-	}
-
-	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
+	n_ports = 2;
+	if (board_idx == uli_5287)
+		n_ports = 4;
+	rc = ata_pci_prepare_native_host(pdev, ppi, n_ports, &host);
 	if (rc)
 		return rc;
 
-	ppi[0] = ppi[1] = &uli_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-	if (!probe_ent)
-		return -ENOMEM;
-
 	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
+	host->private_data = hpriv;
 
-	probe_ent->private_data = hpriv;
-
-	iomap = pcim_iomap_table(pdev);
+	iomap = host->iomap;
 
 	switch (board_idx) {
 	case uli_5287:
 		hpriv->scr_cfg_addr[0] = ULI5287_BASE;
 		hpriv->scr_cfg_addr[1] = ULI5287_BASE + ULI5287_OFFS;
-       		probe_ent->n_ports = 4;
 
-		probe_ent->port[2].cmd_addr = iomap[0] + 8;
-		probe_ent->port[2].altstatus_addr =
-		probe_ent->port[2].ctl_addr = (void __iomem *)
+		ioaddr = &host->ports[2]->ioaddr;
+		ioaddr->cmd_addr = iomap[0] + 8;
+		ioaddr->altstatus_addr =
+		ioaddr->ctl_addr = (void __iomem *)
 			((unsigned long)iomap[1] | ATA_PCI_CTL_OFS) + 4;
-		probe_ent->port[2].bmdma_addr = iomap[4] + 16;
+		ioaddr->bmdma_addr = iomap[4] + 16;
 		hpriv->scr_cfg_addr[2] = ULI5287_BASE + ULI5287_OFFS*4;
+		ata_std_ports(ioaddr);
 
-		probe_ent->port[3].cmd_addr = iomap[2] + 8;
-		probe_ent->port[3].altstatus_addr =
-		probe_ent->port[3].ctl_addr = (void __iomem *)
+		ioaddr = &host->ports[3]->ioaddr;
+		ioaddr->cmd_addr = iomap[2] + 8;
+		ioaddr->altstatus_addr =
+		ioaddr->ctl_addr = (void __iomem *)
 			((unsigned long)iomap[3] | ATA_PCI_CTL_OFS) + 4;
-		probe_ent->port[3].bmdma_addr = iomap[4] + 24;
+		ioaddr->bmdma_addr = iomap[4] + 24;
 		hpriv->scr_cfg_addr[3] = ULI5287_BASE + ULI5287_OFFS*5;
-
-		ata_std_ports(&probe_ent->port[2]);
-		ata_std_ports(&probe_ent->port[3]);
+		ata_std_ports(ioaddr);
 		break;
 
 	case uli_5289:
@@ -263,12 +253,8 @@ static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 	pci_intx(pdev, 1);
-
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
-
-	devm_kfree(&pdev->dev, probe_ent);
-	return 0;
+	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
+				 &uli_sht);
 }
 
 static int __init uli_init(void)
-- 
1.5.0.1


