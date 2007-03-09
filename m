From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/12] libata: convert the remaining PATA drivers to new init model
Date: Fri, 9 Mar 2007 20:15:36 +0900
Message-ID: <11734389363614-git-send-email-htejun@gmail.com>
References: <1173438935540-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:50828 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767193AbXCILPt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:15:49 -0500
Received: by nz-out-0506.google.com with SMTP id s1so740662nze
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 03:15:48 -0800 (PST)
In-Reply-To: <1173438935540-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert pdc_adma, pata_cs5520, pata_isapnp, pata_ixp4xx_cf,
pata_legacy, pata_mpc52xx, pata_mpiix, pata_pcmcia, pata_pdc2027x,
pata_platform, pata_qdi, pata_scc and pata_winbond to new init model.

* init_one()'s now follow more consistent init order

* cs5520 now registers one host with two ports, not two hosts.  If any
  of the two ports are disabled, it's made dummy as other drivers do.

Tested pdc_adma and pata_legacy.  Both are as broken as before.  The
rest are compile tested only.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/pata_cs5520.c    |  127 +++++++++++++++++++++++-------------------
 drivers/ata/pata_isapnp.c    |   43 ++++++++-------
 drivers/ata/pata_ixp4xx_cf.c |   39 ++++++-------
 drivers/ata/pata_legacy.c    |   38 ++++++------
 drivers/ata/pata_mpc52xx.c   |   46 +++++++--------
 drivers/ata/pata_mpiix.c     |   36 ++++++------
 drivers/ata/pata_pcmcia.c    |   40 +++++++-------
 drivers/ata/pata_pdc2027x.c  |   98 +++++++++++++--------------------
 drivers/ata/pata_platform.c  |   43 +++++++--------
 drivers/ata/pata_qdi.c       |   45 +++++++--------
 drivers/ata/pata_scc.c       |   51 +++++------------
 drivers/ata/pata_winbond.c   |   97 +++++++++++++++-----------------
 drivers/ata/pdc_adma.c       |   85 +++++++++++-----------------
 13 files changed, 360 insertions(+), 428 deletions(-)

diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 6bddae5..0546748 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -197,7 +197,6 @@ static struct ata_port_operations cs5520_port_ops = {
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -205,87 +204,99 @@ static struct ata_port_operations cs5520_port_ops = {
 	.port_start		= ata_port_start,
 };
 
-static int __devinit cs5520_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct ata_port_info pi = {
+		.flags		= ATA_FLAG_SLAVE_POSS,
+		.pio_mask	= 0x1f,
+		.port_ops	= &cs5520_port_ops,
+	};
+	const struct ata_port_info *ppi[2];
 	u8 pcicfg;
 	void *iomap[5];
-	static struct ata_probe_ent probe[2];
-	int ports = 0, rc;
+	struct ata_host *host;
+	struct ata_ioports *ioaddr;
+	int i, rc;
 
 	/* IDE port enable bits */
-	pci_read_config_byte(dev, 0x60, &pcicfg);
+	pci_read_config_byte(pdev, 0x60, &pcicfg);
 
 	/* Check if the ATA ports are enabled */
-	if ((pcicfg & 3) == 0)
+	if (!(pcicfg & 3))
 		return -ENODEV;
 
+	ppi[0] = ppi[1] = &ata_dummy_port_info;
+	if (pcicfg & 1)
+		ppi[0] = &pi;
+	if (pcicfg & 2)
+		ppi[1] = &pi;
+
 	if ((pcicfg & 0x40) == 0) {
-		printk(KERN_WARNING DRV_NAME ": DMA mode disabled. Enabling.\n");
-		pci_write_config_byte(dev, 0x60, pcicfg | 0x40);
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "DMA mode disabled. Enabling.\n");
+		pci_write_config_byte(pdev, 0x60, pcicfg | 0x40);
 	}
 
+	pi.mwdma_mask = id->driver_data;
+
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 2);
+	if (!host)
+		return -ENOMEM;
+
 	/* Perform set up for DMA */
-	if (pci_enable_device_bars(dev, 1<<2)) {
+	if (pci_enable_device_bars(pdev, 1<<2)) {
 		printk(KERN_ERR DRV_NAME ": unable to configure BAR2.\n");
 		return -ENODEV;
 	}
-	pci_set_master(dev);
 
-	rc = pci_configure_dma_masks(dev, DMA_32BIT_MASK, NULL);
+	rc = pci_configure_dma_masks(pdev, DMA_32BIT_MASK, NULL);
 	if (rc)
 		return rc;
 
-	/* Map IO ports */
-	iomap[0] = devm_ioport_map(&dev->dev, 0x1F0, 8);
-	iomap[1] = devm_ioport_map(&dev->dev, 0x3F6, 1);
-	iomap[2] = devm_ioport_map(&dev->dev, 0x170, 8);
-	iomap[3] = devm_ioport_map(&dev->dev, 0x376, 1);
-	iomap[4] = pcim_iomap(dev, 2, 0);
+	/* Map IO ports and initialize host accordingly */
+	iomap[0] = devm_ioport_map(&pdev->dev, 0x1F0, 8);
+	iomap[1] = devm_ioport_map(&pdev->dev, 0x3F6, 1);
+	iomap[2] = devm_ioport_map(&pdev->dev, 0x170, 8);
+	iomap[3] = devm_ioport_map(&pdev->dev, 0x376, 1);
+	iomap[4] = pcim_iomap(pdev, 2, 0);
 
 	if (!iomap[0] || !iomap[1] || !iomap[2] || !iomap[3] || !iomap[4])
 		return -ENOMEM;
 
-	/* We have to do our own plumbing as the PCI setup for this
-	   chipset is non-standard so we can't punt to the libata code */
-
-	INIT_LIST_HEAD(&probe[0].node);
-	probe[0].dev = pci_dev_to_dev(dev);
-	probe[0].port_ops = &cs5520_port_ops;
-	probe[0].sht = &cs5520_sht;
-	probe[0].pio_mask = 0x1F;
-	probe[0].mwdma_mask = id->driver_data;
-	probe[0].irq = 14;
-	probe[0].irq_flags = 0;
-	probe[0].port_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST;
-	probe[0].n_ports = 1;
-	probe[0].port[0].cmd_addr = iomap[0];
-	probe[0].port[0].ctl_addr = iomap[1];
-	probe[0].port[0].altstatus_addr = iomap[1];
-	probe[0].port[0].bmdma_addr = iomap[4];
-
-	/* The secondary lurks at different addresses but is otherwise
-	   the same beastie */
-
-	probe[1] = probe[0];
-	INIT_LIST_HEAD(&probe[1].node);
-	probe[1].irq = 15;
-	probe[1].port[0].cmd_addr = iomap[2];
-	probe[1].port[0].ctl_addr = iomap[3];
-	probe[1].port[0].altstatus_addr = iomap[3];
-	probe[1].port[0].bmdma_addr = iomap[4] + 8;
-
-	/* Let libata fill in the port details */
-	ata_std_ports(&probe[0].port[0]);
-	ata_std_ports(&probe[1].port[0]);
-
-	/* Now add the ports that are active */
-	if (pcicfg & 1)
-		ports += ata_device_add(&probe[0]);
-	if (pcicfg & 2)
-		ports += ata_device_add(&probe[1]);
-	if (ports)
-		return 0;
-	return -ENODEV;
+	ioaddr = &host->ports[0]->ioaddr;
+	ioaddr->cmd_addr = iomap[0];
+	ioaddr->ctl_addr = iomap[1];
+	ioaddr->altstatus_addr = iomap[1];
+	ioaddr->bmdma_addr = iomap[4];
+	ata_std_ports(ioaddr);
+
+	ioaddr = &host->ports[1]->ioaddr;
+	ioaddr->cmd_addr = iomap[2];
+	ioaddr->ctl_addr = iomap[3];
+	ioaddr->altstatus_addr = iomap[3];
+	ioaddr->bmdma_addr = iomap[4] + 8;
+	ata_std_ports(ioaddr);
+
+	/* activate the host */
+	pci_set_master(pdev);
+	rc = ata_host_start(host);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < 2; i++) {
+		static const int irq[] = { 14, 15 };
+		struct ata_port *ap = host->ports[0];
+
+		if (ata_port_is_dummy(ap))
+			continue;
+
+		rc = devm_request_irq(&pdev->dev, irq[ap->port_no],
+				      ata_interrupt, 0, DRV_NAME, host);
+		if (rc)
+			return rc;
+	}
+
+	return ata_host_attach(host, &cs5520_sht);
 }
 
 /**
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 1a61cc8..46e0d70 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -55,7 +55,6 @@ static struct ata_port_operations isapnp_port_ops = {
 
 	.data_xfer	= ata_data_xfer,
 
-	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 	.irq_ack	= ata_irq_ack,
@@ -74,8 +73,10 @@ static struct ata_port_operations isapnp_port_ops = {
 
 static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev_id)
 {
-	struct ata_probe_ent ae;
+	struct ata_host *host;
+	struct ata_port *ap;
 	void __iomem *cmd_addr, *ctl_addr;
+	int rc;
 
 	if (pnp_port_valid(idev, 0) == 0)
 		return -ENODEV;
@@ -84,34 +85,36 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 	if (pnp_irq_valid(idev, 0) == 0)
 		return -ENODEV;
 
+	/* allocate host */
+	host = ata_host_alloc(&idev->dev, 1);
+	if (!host)
+		return -ENOMEM;
+
+	/* acquire resources and fill host */
 	cmd_addr = devm_ioport_map(&idev->dev, pnp_port_start(idev, 0), 8);
 	if (!cmd_addr)
 		return -ENOMEM;
 
-	memset(&ae, 0, sizeof(struct ata_probe_ent));
-	INIT_LIST_HEAD(&ae.node);
-	ae.dev = &idev->dev;
-	ae.port_ops = &isapnp_port_ops;
-	ae.sht = &isapnp_sht;
-	ae.n_ports = 1;
-	ae.pio_mask = 1;		/* ISA so PIO 0 cycles */
-	ae.irq = pnp_irq(idev, 0);
-	ae.irq_flags = 0;
-	ae.port_flags = ATA_FLAG_SLAVE_POSS;
-	ae.port[0].cmd_addr = cmd_addr;
+	ap = host->ports[0];
+
+	ap->ops = &isapnp_port_ops;
+	ap->pio_mask = 1;
+	ap->flags |= ATA_FLAG_SLAVE_POSS;
+
+	ap->ioaddr.cmd_addr = cmd_addr;
 
 	if (pnp_port_valid(idev, 1) == 0) {
 		ctl_addr = devm_ioport_map(&idev->dev,
 					   pnp_port_start(idev, 1), 1);
-		ae.port[0].altstatus_addr = ctl_addr;
-		ae.port[0].ctl_addr = ctl_addr;
-		ae.port_flags |= ATA_FLAG_SRST;
+		ap->ioaddr.altstatus_addr = ctl_addr;
+		ap->ioaddr.ctl_addr = ctl_addr;
 	}
-	ata_std_ports(&ae.port[0]);
 
-	if (ata_device_add(&ae) == 0)
-		return -ENODEV;
-	return 0;
+	ata_std_ports(&ap->ioaddr);
+
+	/* activate */
+	return ata_host_activate(host, pnp_irq(idev, 0), ata_interrupt, 0,
+				 &isapnp_sht);
 }
 
 /**
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 9a0523b..1afcdf4 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -130,7 +130,6 @@ static struct ata_port_operations ixp4xx_port_ops = {
 	.eng_timeout	= ata_eng_timeout,
 	.data_xfer	= ixp4xx_mmio_data_xfer,
 
-	.irq_handler	= ata_interrupt,
 	.irq_clear	= ixp4xx_irq_clear,
 	.irq_on		= ata_irq_on,
 	.irq_ack	= ata_irq_ack,
@@ -173,12 +172,12 @@ static void ixp4xx_setup_port(struct ata_ioports *ioaddr,
 
 static __devinit int ixp4xx_pata_probe(struct platform_device *pdev)
 {
-	int ret;
 	unsigned int irq;
 	struct resource *cs0, *cs1;
-	struct ata_probe_ent ae;
-
+	struct ata_host *host;
+	struct ata_port *ap;
 	struct ixp4xx_pata_data *data = pdev->dev.platform_data;
+	int rc;
 
 	cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
@@ -186,6 +185,12 @@ static __devinit int ixp4xx_pata_probe(struct platform_device *pdev)
 	if (!cs0 || !cs1)
 		return -EINVAL;
 
+	/* allocate host */
+	host = ata_host_alloc(&pdev->dev, 1);
+	if (!host)
+		return -ENOMEM;
+
+	/* acquire resources and fill host */
 	pdev->dev.coherent_dma_mask = DMA_32BIT_MASK;
 
 	data->cs0 = devm_ioremap(&pdev->dev, cs0->start, 0x1000);
@@ -199,32 +204,22 @@ static __devinit int ixp4xx_pata_probe(struct platform_device *pdev)
 	*data->cs0_cfg = data->cs0_bits;
 	*data->cs1_cfg = data->cs1_bits;
 
-	memset(&ae, 0, sizeof(struct ata_probe_ent));
-	INIT_LIST_HEAD(&ae.node);
+	ap = host->ports[0];
 
-	ae.dev		= &pdev->dev;
-	ae.port_ops	= &ixp4xx_port_ops;
-	ae.sht		= &ixp4xx_sht;
-	ae.n_ports	= 1;
-	ae.pio_mask	= 0x1f; /* PIO4 */
-	ae.irq		= irq;
-	ae.irq_flags	= 0;
-	ae.port_flags	= ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY
-			| ATA_FLAG_NO_ATAPI | ATA_FLAG_SRST;
+	ap->ops	= &ixp4xx_port_ops;
+	ap->pio_mask = 0x1f; /* PIO4 */
+	ap->flags |= ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY | ATA_FLAG_NO_ATAPI;
 
 	/* run in polling mode if no irq has been assigned */
 	if (!irq)
-		ae.port_flags |= ATA_FLAG_PIO_POLLING;
+		ap->flags |= ATA_FLAG_PIO_POLLING;
 
-	ixp4xx_setup_port(&ae.port[0], data);
+	ixp4xx_setup_port(&ap->ioaddr, data);
 
 	dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
-	ret = ata_device_add(&ae);
-	if (ret == 0)
-		return -ENODEV;
-
-	return 0;
+	/* activate host */
+	return ata_host_activate(host, irq, ata_interrupt, 0, &ixp4xx_sht);
 }
 
 static __devexit int ixp4xx_pata_remove(struct platform_device *dev)
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index fc5b73d..1fef86a 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -709,7 +709,8 @@ static struct ata_port_operations opti82c46x_port_ops = {
 static __init int legacy_init_one(int port, unsigned long io, unsigned long ctrl, int irq)
 {
 	struct legacy_data *ld = &legacy_data[nr_legacy_host];
-	struct ata_probe_ent ae;
+	struct ata_host *host;
+	struct ata_port *ap;
 	struct platform_device *pdev;
 	struct ata_port_operations *ops = &legacy_port_ops;
 	void __iomem *io_addr, *ctrl_addr;
@@ -791,24 +792,23 @@ static __init int legacy_init_one(int port, unsigned long io, unsigned long ctrl
 	if (ops == &legacy_port_ops && (autospeed & mask))
 		ops = &simple_port_ops;
 
-	memset(&ae, 0, sizeof(struct ata_probe_ent));
-	INIT_LIST_HEAD(&ae.node);
-	ae.dev = &pdev->dev;
-	ae.port_ops = ops;
-	ae.sht = &legacy_sht;
-	ae.n_ports = 1;
-	ae.pio_mask = pio_modes;
-	ae.irq = irq;
-	ae.irq_flags = 0;
-	ae.port_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST|iordy;
-	ae.port[0].cmd_addr = io_addr;
-	ae.port[0].altstatus_addr = ctrl_addr;
-	ae.port[0].ctl_addr = ctrl_addr;
-	ata_std_ports(&ae.port[0]);
-	ae.private_data = ld;
-
-	ret = -ENODEV;
-	if (!ata_device_add(&ae))
+	ret = -ENOMEM;
+	host = ata_host_alloc(&pdev->dev, 1);
+	if (!host)
+		goto fail;
+	ap = host->ports[0];
+
+	ap->ops = ops;
+	ap->pio_mask = pio_modes;
+	ap->flags |= ATA_FLAG_SLAVE_POSS | iordy;
+	ap->ioaddr.cmd_addr = io_addr;
+	ap->ioaddr.altstatus_addr = ctrl_addr;
+	ap->ioaddr.ctl_addr = ctrl_addr;
+	ata_std_ports(&ap->ioaddr);
+	ap->private_data = ld;
+
+	ret = ata_host_activate(host, irq, ata_interrupt, 0, &legacy_sht);
+	if (ret)
 		goto fail;
 
 	legacy_host[nr_legacy_host++] = dev_get_drvdata(&pdev->dev);
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index f5d8872..9733e48 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -300,35 +300,33 @@ static struct ata_port_operations mpc52xx_ata_port_ops = {
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
 	.port_start		= ata_port_start,
 };
 
-static struct ata_probe_ent mpc52xx_ata_probe_ent = {
-	.port_ops	= &mpc52xx_ata_port_ops,
-	.sht		= &mpc52xx_ata_sht,
-	.n_ports	= 1,
-	.pio_mask	= 0x1f,		/* Up to PIO4 */
-	.mwdma_mask	= 0x00,		/* No MWDMA   */
-	.udma_mask	= 0x00,		/* No UDMA    */
-	.port_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
-	.irq_flags	= 0,
-};
-
 static int __devinit
 mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv)
 {
-	struct ata_probe_ent *ae = &mpc52xx_ata_probe_ent;
-	struct ata_ioports *aio = &ae->port[0];
-	int rv;
-
-	INIT_LIST_HEAD(&ae->node);
-	ae->dev = dev;
-	ae->irq = priv->ata_irq;
-
+	struct ata_host *host;
+	struct ata_port *ap;
+	struct ata_ioports *aio;
+	int rc;
+
+	host = ata_host_alloc(dev, 1);
+	if (!host)
+		return -ENOMEM;
+
+	ap = host->ports[0];
+	ap->flags		|= ATA_FLAG_SLAVE_POSS;
+	ap->pio_mask		= 0x1f;	/* Up to PIO4 */
+	ap->mwdma_mask		= 0x00;	/* No MWDMA   */
+	ap->udma_mask		= 0x00;	/* No UDMA    */
+	ap->ops			= &mpc52xx_ata_port_ops;
+	host->private_data	= priv;
+
+	aio = &ap->ioaddr;
 	aio->cmd_addr		= 0;	/* Don't have a classic reg block */
 	aio->altstatus_addr	= &priv->ata_regs->tf_control;
 	aio->ctl_addr		= &priv->ata_regs->tf_control;
@@ -343,11 +341,9 @@ mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv)
 	aio->status_addr	= &priv->ata_regs->tf_command;
 	aio->command_addr	= &priv->ata_regs->tf_command;
 
-	ae->private_data = priv;
-
-	rv = ata_device_add(ae);
-
-	return rv ? 0 : -EINVAL;
+	/* activate host */
+	return ata_host_activate(host, priv->ata_irq, ata_interrupt, 0,
+				 &mpc52xx_ata_sht);
 }
 
 static struct mpc52xx_ata_priv *
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 4abe45a..ba4db4c 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -190,7 +190,6 @@ static struct ata_port_operations mpiix_port_ops = {
 	.qc_issue	= mpiix_qc_issue_prot,
 	.data_xfer	= ata_data_xfer,
 
-	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 	.irq_ack	= ata_irq_ack,
@@ -201,8 +200,9 @@ static struct ata_port_operations mpiix_port_ops = {
 static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	/* Single threaded by the PCI probe logic */
-	static struct ata_probe_ent probe;
 	static int printed_version;
+	struct ata_host *host;
+	struct ata_port *ap;
 	void __iomem *cmd_addr, *ctl_addr;
 	u16 idetim;
 	int irq;
@@ -210,6 +210,10 @@ static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &dev->dev, "version " DRV_VERSION "\n");
 
+	host = ata_host_alloc(&dev->dev, 1);
+	if (!host)
+		return -ENOMEM;
+
 	/* MPIIX has many functions which can be turned on or off according
 	   to other devices present. Make sure IDE is enabled before we try
 	   and use it */
@@ -238,27 +242,21 @@ static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	   without BARs set fools the setup.  #2 If you pci_disable_device
 	   the MPIIX your box goes castors up */
 
-	INIT_LIST_HEAD(&probe.node);
-	probe.dev = pci_dev_to_dev(dev);
-	probe.port_ops = &mpiix_port_ops;
-	probe.sht = &mpiix_sht;
-	probe.pio_mask = 0x1F;
-	probe.irq_flags = IRQF_SHARED;
-	probe.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
-	probe.n_ports = 1;
+	ap = host->ports[0];
+	ap->ops = &mpiix_port_ops;
+	ap->pio_mask = 0x1F;
+	ap->flags |= ATA_FLAG_SLAVE_POSS;
 
-	probe.irq = irq;
-	probe.port[0].cmd_addr = cmd_addr;
-	probe.port[0].ctl_addr = ctl_addr;
-	probe.port[0].altstatus_addr = ctl_addr;
+	ap->ioaddr.cmd_addr = cmd_addr;
+	ap->ioaddr.ctl_addr = ctl_addr;
+	ap->ioaddr.altstatus_addr = ctl_addr;
 
 	/* Let libata fill in the port details */
-	ata_std_ports(&probe.port[0]);
+	ata_std_ports(&ap->ioaddr);
 
-	/* Now add the port that is active */
-	if (ata_device_add(&probe))
-		return 0;
-	return -ENODEV;
+	/* activate host */
+	return ata_host_activate(host, irq, ata_interrupt, IRQF_SHARED,
+				 &mpiix_sht);
 }
 
 static const struct pci_device_id mpiix[] = {
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 103720f..85719a2 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -90,7 +90,6 @@ static struct ata_port_operations pcmcia_port_ops = {
 
 	.data_xfer	= ata_data_xfer_noirq,
 
-	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 	.irq_ack	= ata_irq_ack,
@@ -111,7 +110,8 @@ do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
 static int pcmcia_init_one(struct pcmcia_device *pdev)
 {
-	struct ata_probe_ent ae;
+	struct ata_host *host;
+	struct ata_port *ap;
 	struct ata_pcmcia_info *info;
 	tuple_t tuple;
 	struct {
@@ -255,24 +255,24 @@ next_entry:
  	 *	Having done the PCMCIA plumbing the ATA side is relatively
  	 *	sane.
 	 */
-
-	memset(&ae, 0, sizeof(struct ata_probe_ent));
-	INIT_LIST_HEAD(&ae.node);
-	ae.dev = &pdev->dev;
-	ae.port_ops = &pcmcia_port_ops;
-	ae.sht = &pcmcia_sht;
-	ae.n_ports = 1;
-	ae.pio_mask = 1;		/* ISA so PIO 0 cycles */
-	ae.irq = pdev->irq.AssignedIRQ;
-	ae.irq_flags = IRQF_SHARED;
-	ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
-	ae.port[0].cmd_addr = io_addr;
-	ae.port[0].altstatus_addr = ctl_addr;
-	ae.port[0].ctl_addr = ctl_addr;
-	ata_std_ports(&ae.port[0]);
-
-	ret = -ENODEV;
-	if (ata_device_add(&ae) == 0)
+	ret = -ENOMEM;
+	host = ata_host_alloc(&pdev->dev, 1);
+	if (!host)
+		goto failed;
+	ap = host->ports[0];
+
+	ap->ops = &pcmcia_port_ops;
+	ap->pio_mask = 1;		/* ISA so PIO 0 cycles */
+	ap->flags |= ATA_FLAG_SLAVE_POSS;
+	ap->ioaddr.cmd_addr = io_addr;
+	ap->ioaddr.altstatus_addr = ctl_addr;
+	ap->ioaddr.ctl_addr = ctl_addr;
+	ata_std_ports(&ap->ioaddr);
+
+	/* activate */
+	ret = ata_host_activate(host, pdev->irq.AssignedIRQ, ata_interrupt,
+				IRQF_SHARED, &pcmcia_sht);
+	if (ret)
 		goto failed;
 
 	info->ndev = 1;
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 3ab66fd..69fec16 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -167,7 +167,6 @@ static struct ata_port_operations pdc2027x_pata100_ops = {
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -201,7 +200,6 @@ static struct ata_port_operations pdc2027x_pata133_ops = {
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -212,7 +210,6 @@ static struct ata_port_operations pdc2027x_pata133_ops = {
 static struct ata_port_info pdc2027x_port_info[] = {
 	/* PDC_UDMA_100 */
 	{
-		.sht		= &pdc2027x_sht,
 		.flags		= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
 		                  ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
@@ -222,7 +219,6 @@ static struct ata_port_info pdc2027x_port_info[] = {
 	},
 	/* PDC_UDMA_133 */
 	{
-		.sht		= &pdc2027x_sht,
 		.flags		= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
                         	  ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
@@ -521,12 +517,12 @@ static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc)
 
 /**
  * pdc_read_counter - Read the ctr counter
- * @probe_ent: for the port address
+ * @host: target ATA host
  */
 
-static long pdc_read_counter(struct ata_probe_ent *probe_ent)
+static long pdc_read_counter(struct ata_host *host)
 {
-	void __iomem *mmio_base = probe_ent->iomap[PDC_MMIO_BAR];
+	void __iomem *mmio_base = host->iomap[PDC_MMIO_BAR];
 	long counter;
 	int retry = 1;
 	u32 bccrl, bccrh, bccrlv, bccrhv;
@@ -564,12 +560,12 @@ retry:
  * adjust_pll - Adjust the PLL input clock in Hz.
  *
  * @pdc_controller: controller specific information
- * @probe_ent: For the port address
+ * @host: target ATA host
  * @pll_clock: The input of PLL in HZ
  */
-static void pdc_adjust_pll(struct ata_probe_ent *probe_ent, long pll_clock, unsigned int board_idx)
+static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int board_idx)
 {
-	void __iomem *mmio_base = probe_ent->iomap[PDC_MMIO_BAR];
+	void __iomem *mmio_base = host->iomap[PDC_MMIO_BAR];
 	u16 pll_ctl;
 	long pll_clock_khz = pll_clock / 1000;
 	long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;
@@ -649,19 +645,19 @@ static void pdc_adjust_pll(struct ata_probe_ent *probe_ent, long pll_clock, unsi
 
 /**
  * detect_pll_input_clock - Detect the PLL input clock in Hz.
- * @probe_ent: for the port address
+ * @host: target ATA host
  * Ex. 16949000 on 33MHz PCI bus for pdc20275.
  *     Half of the PCI clock.
  */
-static long pdc_detect_pll_input_clock(struct ata_probe_ent *probe_ent)
+static long pdc_detect_pll_input_clock(struct ata_host *host)
 {
-	void __iomem *mmio_base = probe_ent->iomap[PDC_MMIO_BAR];
+	void __iomem *mmio_base = host->iomap[PDC_MMIO_BAR];
 	u32 scr;
 	long start_count, end_count;
 	long pll_clock;
 
 	/* Read current counter value */
-	start_count = pdc_read_counter(probe_ent);
+	start_count = pdc_read_counter(host);
 
 	/* Start the test mode */
 	scr = readl(mmio_base + PDC_SYS_CTL);
@@ -673,7 +669,7 @@ static long pdc_detect_pll_input_clock(struct ata_probe_ent *probe_ent)
 	mdelay(100);
 
 	/* Read the counter values again */
-	end_count = pdc_read_counter(probe_ent);
+	end_count = pdc_read_counter(host);
 
 	/* Stop the test mode */
 	scr = readl(mmio_base + PDC_SYS_CTL);
@@ -692,11 +688,10 @@ static long pdc_detect_pll_input_clock(struct ata_probe_ent *probe_ent)
 
 /**
  * pdc_hardware_init - Initialize the hardware.
- * @pdev: instance of pci_dev found
- * @pdc_controller: controller specific information
- * @pe:  for the port address
+ * @host: target ATA host
+ * @board_idx: board identifier
  */
-static int pdc_hardware_init(struct pci_dev *pdev, struct ata_probe_ent *pe, unsigned int board_idx)
+static int pdc_hardware_init(struct ata_host *host, unsigned int board_idx)
 {
 	long pll_clock;
 
@@ -706,15 +701,15 @@ static int pdc_hardware_init(struct pci_dev *pdev, struct ata_probe_ent *pe, uns
 	 * Ex. 25MHz or 40MHz, we have to adjust the cycle_time.
 	 * The pdc20275 controller employs PLL circuit to help correct timing registers setting.
 	 */
-	pll_clock = pdc_detect_pll_input_clock(pe);
+	pll_clock = pdc_detect_pll_input_clock(host);
 
 	if (pll_clock < 0) /* counter overflow? Try again. */
-		pll_clock = pdc_detect_pll_input_clock(pe);
+		pll_clock = pdc_detect_pll_input_clock(host);
 
-	dev_printk(KERN_INFO, &pdev->dev, "PLL input clock %ld kHz\n", pll_clock/1000);
+	dev_printk(KERN_INFO, host->dev, "PLL input clock %ld kHz\n", pll_clock/1000);
 
 	/* Adjust PLL control register */
-	pdc_adjust_pll(pe, pll_clock, board_idx);
+	pdc_adjust_pll(host, pll_clock, board_idx);
 
 	return 0;
 }
@@ -746,8 +741,7 @@ static void pdc_ata_setup_port(struct ata_ioports *port, void __iomem *base)
  * Called when an instance of PCI adapter is inserted.
  * This function checks whether the hardware is supported,
  * initialize hardware and register an instance of ata_host to
- * libata by providing struct ata_probe_ent and ata_device_add().
- * (implements struct pci_driver.probe() )
+ * libata.  (implements struct pci_driver.probe() )
  *
  * @pdev: instance of pci_dev found
  * @ent:  matching entry in the id_tbl[]
@@ -756,14 +750,21 @@ static int __devinit pdc2027x_init_one(struct pci_dev *pdev, const struct pci_de
 {
 	static int printed_version;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-
-	struct ata_probe_ent *probe_ent;
+	const struct ata_port_info *ppi[] =
+		{ &pdc2027x_port_info[board_idx], NULL };
+	struct ata_host *host;
 	void __iomem *mmio_base;
 	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* alloc host */
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 2);
+	if (!host)
+		return -ENOMEM;
+
+	/* acquire resources and fill host */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -771,51 +772,28 @@ static int __devinit pdc2027x_init_one(struct pci_dev *pdev, const struct pci_de
 	rc = pcim_iomap_regions(pdev, 1 << PDC_MMIO_BAR, DRV_NAME);
 	if (rc)
 		return rc;
+	host->iomap = pcim_iomap_table(pdev);
 
 	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		return rc;
 
-	/* Prepare the probe entry */
-	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL)
-		return -ENOMEM;
-
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	probe_ent->sht		= pdc2027x_port_info[board_idx].sht;
-	probe_ent->port_flags	= pdc2027x_port_info[board_idx].flags;
-	probe_ent->pio_mask	= pdc2027x_port_info[board_idx].pio_mask;
-	probe_ent->mwdma_mask	= pdc2027x_port_info[board_idx].mwdma_mask;
-	probe_ent->udma_mask	= pdc2027x_port_info[board_idx].udma_mask;
-	probe_ent->port_ops	= pdc2027x_port_info[board_idx].port_ops;
+	mmio_base = host->iomap[PDC_MMIO_BAR];
 
-       	probe_ent->irq = pdev->irq;
-       	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->iomap = pcim_iomap_table(pdev);
+	pdc_ata_setup_port(&host->ports[0]->ioaddr, mmio_base + 0x17c0);
+	host->ports[0]->ioaddr.bmdma_addr = mmio_base + 0x1000;
+	pdc_ata_setup_port(&host->ports[1]->ioaddr, mmio_base + 0x15c0);
+	host->ports[1]->ioaddr.bmdma_addr = mmio_base + 0x1008;
 
-	mmio_base = probe_ent->iomap[PDC_MMIO_BAR];
-
-	pdc_ata_setup_port(&probe_ent->port[0], mmio_base + 0x17c0);
-	probe_ent->port[0].bmdma_addr = mmio_base + 0x1000;
-	pdc_ata_setup_port(&probe_ent->port[1], mmio_base + 0x15c0);
-	probe_ent->port[1].bmdma_addr = mmio_base + 0x1008;
-
-	probe_ent->n_ports = 2;
-
-	pci_set_master(pdev);
 	//pci_enable_intx(pdev);
 
 	/* initialize adapter */
-	if (pdc_hardware_init(pdev, probe_ent, board_idx) != 0)
+	if (pdc_hardware_init(host, board_idx) != 0)
 		return -EIO;
 
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
-
-	devm_kfree(&pdev->dev, probe_ent);
-	return 0;
+	pci_set_master(pdev);
+	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
+				 &pdc2027x_sht);
 }
 
 /**
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 4b82a54..d8c242b 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -86,7 +86,6 @@ static struct ata_port_operations pata_platform_port_ops = {
 
 	.data_xfer		= ata_data_xfer_noirq,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -135,7 +134,8 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
 static int __devinit pata_platform_probe(struct platform_device *pdev)
 {
 	struct resource *io_res, *ctl_res;
-	struct ata_probe_ent ae;
+	struct ata_host *host;
+	struct ata_port *ap;
 	unsigned int mmio;
 
 	/*
@@ -175,44 +175,41 @@ static int __devinit pata_platform_probe(struct platform_device *pdev)
 	/*
 	 * Now that that's out of the way, wire up the port..
 	 */
-	memset(&ae, 0, sizeof(struct ata_probe_ent));
-	INIT_LIST_HEAD(&ae.node);
-	ae.dev = &pdev->dev;
-	ae.port_ops = &pata_platform_port_ops;
-	ae.sht = &pata_platform_sht;
-	ae.n_ports = 1;
-	ae.pio_mask = pio_mask;
-	ae.irq = platform_get_irq(pdev, 0);
-	ae.irq_flags = 0;
-	ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
+	host = ata_host_alloc(&pdev->dev, 1);
+	if (!host)
+		return -ENOMEM;
+	ap = host->ports[0];
+
+	ap->ops = &pata_platform_port_ops;
+	ap->pio_mask = pio_mask;
+	ap->flags |= ATA_FLAG_SLAVE_POSS;
 
 	/*
 	 * Handle the MMIO case
 	 */
 	if (mmio) {
-		ae.port[0].cmd_addr = devm_ioremap(&pdev->dev, io_res->start,
+		ap->ioaddr.cmd_addr = devm_ioremap(&pdev->dev, io_res->start,
 				io_res->end - io_res->start + 1);
-		ae.port[0].ctl_addr = devm_ioremap(&pdev->dev, ctl_res->start,
+		ap->ioaddr.ctl_addr = devm_ioremap(&pdev->dev, ctl_res->start,
 				ctl_res->end - ctl_res->start + 1);
 	} else {
-		ae.port[0].cmd_addr = devm_ioport_map(&pdev->dev, io_res->start,
+		ap->ioaddr.cmd_addr = devm_ioport_map(&pdev->dev, io_res->start,
 				io_res->end - io_res->start + 1);
-		ae.port[0].ctl_addr = devm_ioport_map(&pdev->dev, ctl_res->start,
+		ap->ioaddr.ctl_addr = devm_ioport_map(&pdev->dev, ctl_res->start,
 				ctl_res->end - ctl_res->start + 1);
 	}
-	if (!ae.port[0].cmd_addr || !ae.port[0].ctl_addr) {
+	if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr) {
 		dev_err(&pdev->dev, "failed to map IO/CTL base\n");
 		return -ENOMEM;
 	}
 
-	ae.port[0].altstatus_addr = ae.port[0].ctl_addr;
+	ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
 
-	pata_platform_setup_port(&ae.port[0], pdev->dev.platform_data);
+	pata_platform_setup_port(&ap->ioaddr, pdev->dev.platform_data);
 
-	if (unlikely(ata_device_add(&ae) == 0))
-		return -ENODEV;
-
-	return 0;
+	/* activate */
+	return ata_host_activate(host, platform_get_irq(pdev, 0), ata_interrupt,
+				 0, &pata_platform_sht);
 }
 
 /**
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index c381001..103f444 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -189,7 +189,6 @@ static struct ata_port_operations qdi6500_port_ops = {
 
 	.data_xfer	= qdi_data_xfer,
 
-	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 	.irq_ack	= ata_irq_ack,
@@ -217,7 +216,6 @@ static struct ata_port_operations qdi6580_port_ops = {
 
 	.data_xfer	= qdi_data_xfer,
 
-	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 	.irq_ack	= ata_irq_ack,
@@ -238,8 +236,9 @@ static struct ata_port_operations qdi6580_port_ops = {
 
 static __init int qdi_init_one(unsigned long port, int type, unsigned long io, int irq, int fast)
 {
-	struct ata_probe_ent ae;
 	struct platform_device *pdev;
+	struct ata_host *host;
+	struct ata_port *ap;
 	void __iomem *io_addr, *ctl_addr;
 	int ret;
 
@@ -257,34 +256,31 @@ static __init int qdi_init_one(unsigned long port, int type, unsigned long io, i
 	if (!io_addr || !ctl_addr)
 		goto fail;
 
-	memset(&ae, 0, sizeof(struct ata_probe_ent));
-	INIT_LIST_HEAD(&ae.node);
-	ae.dev = &pdev->dev;
+	ret = -ENOMEM;
+	host = ata_host_alloc(&pdev->dev, 1);
+	if (!host)
+		goto fail;
+	ap = host->ports[0];
 
 	if (type == 6580) {
-		ae.port_ops = &qdi6580_port_ops;
-		ae.pio_mask = 0x1F;
-		ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
+		ap->ops = &qdi6580_port_ops;
+		ap->pio_mask = 0x1F;
+		ap->flags |= ATA_FLAG_SLAVE_POSS;
 	} else {
-		ae.port_ops = &qdi6500_port_ops;
-		ae.pio_mask = 0x07;	/* Actually PIO3 !IORDY is possible */
-		ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
-				ATA_FLAG_NO_IORDY;
+		ap->ops = &qdi6500_port_ops;
+		ap->pio_mask = 0x07;	/* Actually PIO3 !IORDY is possible */
+		ap->flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
 	}
 
-	ae.sht = &qdi_sht;
-	ae.n_ports = 1;
-	ae.irq = irq;
-	ae.irq_flags = 0;
-	ae.port[0].cmd_addr = io_addr;
-	ae.port[0].altstatus_addr = ctl_addr;
-	ae.port[0].ctl_addr = ctl_addr;
-	ata_std_ports(&ae.port[0]);
+	ap->ioaddr.cmd_addr = io_addr;
+	ap->ioaddr.altstatus_addr = ctl_addr;
+	ap->ioaddr.ctl_addr = ctl_addr;
+	ata_std_ports(&ap->ioaddr);
 
 	/*
 	 *	Hook in a private data structure per channel
 	 */
-	ae.private_data = &qdi_data[nr_qdi_host];
+	ap->private_data = &qdi_data[nr_qdi_host];
 
 	qdi_data[nr_qdi_host].timing = port;
 	qdi_data[nr_qdi_host].fast = fast;
@@ -292,8 +288,9 @@ static __init int qdi_init_one(unsigned long port, int type, unsigned long io, i
 
 	printk(KERN_INFO DRV_NAME": qd%d at 0x%lx.\n", type, io);
 
-	ret = -ENODEV;
-	if (!ata_device_add(&ae))
+	/* activate */
+	ret = ata_host_activate(host, irq, ata_interrupt, 0, &qdi_sht);
+	if (ret)
 		goto fail;
 
 	qdi_host[nr_qdi_host++] = dev_get_drvdata(&pdev->dev);
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index ee0c533..de90d36 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -1016,7 +1016,6 @@ static const struct ata_port_operations scc_pata_ops = {
 	.error_handler		= scc_error_handler,
 	.post_internal_cmd	= scc_bmdma_stop,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= scc_bmdma_irq_clear,
 	.irq_on			= scc_irq_on,
 	.irq_ack		= scc_irq_ack,
@@ -1027,7 +1026,6 @@ static const struct ata_port_operations scc_pata_ops = {
 
 static struct ata_port_info scc_port_info[] = {
 	{
-		.sht		= &scc_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x00,
@@ -1040,10 +1038,10 @@ static struct ata_port_info scc_port_info[] = {
  *	scc_reset_controller - initialize SCC PATA controller.
  */
 
-static int scc_reset_controller(struct ata_probe_ent *probe_ent)
+static int scc_reset_controller(struct ata_host *host)
 {
-	void __iomem *ctrl_base = probe_ent->iomap[SCC_CTRL_BAR];
-	void __iomem *bmid_base = probe_ent->iomap[SCC_BMID_BAR];
+	void __iomem *ctrl_base = host->iomap[SCC_CTRL_BAR];
+	void __iomem *bmid_base = host->iomap[SCC_BMID_BAR];
 	void __iomem *cckctrl_port = ctrl_base + SCC_CTL_CCKCTRL;
 	void __iomem *mode_port = ctrl_base + SCC_CTL_MODEREG;
 	void __iomem *ecmode_port = ctrl_base + SCC_CTL_ECMODE;
@@ -1104,22 +1102,20 @@ static void scc_setup_ports (struct ata_ioports *ioaddr, void __iomem *base)
 	ioaddr->command_addr = ioaddr->cmd_addr + SCC_REG_CMD;
 }
 
-static int scc_host_init(struct ata_probe_ent *probe_ent)
+static int scc_host_init(struct ata_host *host)
 {
-	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
+	struct pci_dev *pdev = to_pci_dev(host->dev);
 	int rc;
 
-	rc = scc_reset_controller(probe_ent);
+	rc = scc_reset_controller(host);
 	if (rc)
 		return rc;
 
-	probe_ent->n_ports = 1;
-
 	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		return rc;
 
-	scc_setup_ports(&probe_ent->port[0], probe_ent->iomap[SCC_BMID_BAR]);
+	scc_setup_ports(&host->ports[0]->ioaddr, host->iomap[SCC_BMID_BAR]);
 
 	pci_set_master(pdev);
 
@@ -1142,14 +1138,18 @@ static int scc_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	const struct ata_port_info *ppi[] = { &scc_port_info[board_idx], NULL };
 	struct device *dev = &pdev->dev;
-	struct ata_probe_ent *probe_ent;
 	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
+	host = ata_port_alloc_pinfo(&pdev->dev, ppi, 1);
+	if (!host)
+		return -ENOMEM;
+
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -1159,33 +1159,14 @@ static int scc_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
+	host->iomap = pcim_iomap_table(pdev);
 
-	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (!probe_ent)
-		return -ENOMEM;
-
-	probe_ent->dev = dev;
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	probe_ent->sht 		= scc_port_info[board_idx].sht;
-	probe_ent->port_flags 	= scc_port_info[board_idx].flags;
-	probe_ent->pio_mask 	= scc_port_info[board_idx].pio_mask;
-	probe_ent->udma_mask 	= scc_port_info[board_idx].udma_mask;
-	probe_ent->port_ops 	= scc_port_info[board_idx].port_ops;
-
-	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->iomap = pcim_iomap_table(pdev);
-
-	rc = scc_host_init(probe_ent);
+	rc = scc_host_init(host);
 	if (rc)
 		return rc;
 
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
-
-	devm_kfree(dev, probe_ent);
-	return 0;
+	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
+				 &scc_sht);
 }
 
 static struct pci_driver scc_pci_driver = {
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 6c11103..5422120 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -158,7 +158,6 @@ static struct ata_port_operations winbond_port_ops = {
 
 	.data_xfer	= winbond_data_xfer,
 
-	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 	.irq_ack	= ata_irq_ack,
@@ -179,11 +178,9 @@ static struct ata_port_operations winbond_port_ops = {
 
 static __init int winbond_init_one(unsigned long port)
 {
-	struct ata_probe_ent ae;
 	struct platform_device *pdev;
-	int ret;
 	u8 reg;
-	int i;
+	int i, rc;
 
 	reg = winbond_readcfg(port, 0x81);
 	reg |= 0x80;	/* jumpered mode off */
@@ -202,58 +199,56 @@ static __init int winbond_init_one(unsigned long port)
 
 	for (i = 0; i < 2 ; i ++) {
 		unsigned long cmd_port = 0x1F0 - (0x80 * i);
+		struct ata_host *host;
+		struct ata_port *ap;
 		void __iomem *cmd_addr, *ctl_addr;
 
-		if (reg & (1 << i)) {
-			/*
-			 *	Fill in a probe structure first of all
-			 */
-
-			pdev = platform_device_register_simple(DRV_NAME, nr_winbond_host, NULL, 0);
-			if (IS_ERR(pdev))
-				return PTR_ERR(pdev);
-
-			cmd_addr = devm_ioport_map(&pdev->dev, cmd_port, 8);
-			ctl_addr = devm_ioport_map(&pdev->dev, cmd_port + 0x0206, 1);
-			if (!cmd_addr || !ctl_addr) {
-				platform_device_unregister(pdev);
-				return -ENOMEM;
-			}
-
-			memset(&ae, 0, sizeof(struct ata_probe_ent));
-			INIT_LIST_HEAD(&ae.node);
-			ae.dev = &pdev->dev;
-
-			ae.port_ops = &winbond_port_ops;
-			ae.pio_mask = 0x1F;
-
-			ae.sht = &winbond_sht;
-
-			ae.n_ports = 1;
-			ae.irq = 14 + i;
-			ae.irq_flags = 0;
-			ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
-			ae.port[0].cmd_addr = cmd_addr;
-			ae.port[0].altstatus_addr = ctl_addr;
-			ae.port[0].ctl_addr = ctl_addr;
-			ata_std_ports(&ae.port[0]);
-			/*
-			 *	Hook in a private data structure per channel
-			 */
-			ae.private_data = &winbond_data[nr_winbond_host];
-			winbond_data[nr_winbond_host].config = port;
-			winbond_data[nr_winbond_host].platform_dev = pdev;
-
-			ret = ata_device_add(&ae);
-			if (ret == 0) {
-				platform_device_unregister(pdev);
-				return -ENODEV;
-			}
-			winbond_host[nr_winbond_host++] = dev_get_drvdata(&pdev->dev);
-		}
+		if (!(reg & (1 << i)))
+			continue;
+
+		pdev = platform_device_register_simple(DRV_NAME, nr_winbond_host, NULL, 0);
+		if (IS_ERR(pdev))
+			return PTR_ERR(pdev);
+
+		rc = -ENOMEM;
+		host = ata_host_alloc(&pdev->dev, 1);
+		if (!host)
+			goto err_unregister;
+
+		rc = -ENOMEM;
+		cmd_addr = devm_ioport_map(&pdev->dev, cmd_port, 8);
+		ctl_addr = devm_ioport_map(&pdev->dev, cmd_port + 0x0206, 1);
+		if (!cmd_addr || !ctl_addr)
+			goto err_unregister;
+
+		ap = host->ports[0];
+		ap->ops = &winbond_port_ops;
+		ap->pio_mask = 0x1F;
+		ap->flags |= ATA_FLAG_SLAVE_POSS;
+		ap->ioaddr.cmd_addr = cmd_addr;
+		ap->ioaddr.altstatus_addr = ctl_addr;
+		ap->ioaddr.ctl_addr = ctl_addr;
+		ata_std_ports(&ap->ioaddr);
+
+		/* hook in a private data structure per channel */
+		host->private_data = &winbond_data[nr_winbond_host];
+		winbond_data[nr_winbond_host].config = port;
+		winbond_data[nr_winbond_host].platform_dev = pdev;
+
+		/* activate */
+		rc = ata_host_activate(host, 14 + i, ata_interrupt, 0,
+				       &winbond_sht);
+		if (rc)
+			goto err_unregister;
+
+		winbond_host[nr_winbond_host++] = dev_get_drvdata(&pdev->dev);
 	}
 
 	return 0;
+
+ err_unregister:
+	platform_device_unregister(pdev);
+	return rc;
 }
 
 /**
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 9448aab..4df1e17 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -52,9 +52,9 @@
 /* macro to calculate base address for ADMA regs */
 #define ADMA_REGS(base,port_no)		((base) + 0x80 + ((port_no) * 0x20))
 
-/* macro to obtain addresses from ata_host */
-#define ADMA_HOST_REGS(host,port_no) \
-	ADMA_REGS((host)->iomap[ADMA_MMIO_BAR], port_no)
+/* macro to obtain addresses from ata_port */
+#define ADMA_PORT_REGS(ap) \
+	ADMA_REGS((ap)->host->iomap[ADMA_MMIO_BAR], ap->port_no)
 
 enum {
 	ADMA_MMIO_BAR		= 4,
@@ -128,7 +128,6 @@ struct adma_port_priv {
 
 static int adma_ata_init_one (struct pci_dev *pdev,
 				const struct pci_device_id *ent);
-static irqreturn_t adma_intr (int irq, void *dev_instance);
 static int adma_port_start(struct ata_port *ap);
 static void adma_host_stop(struct ata_host *host);
 static void adma_port_stop(struct ata_port *ap);
@@ -172,7 +171,6 @@ static const struct ata_port_operations adma_ata_ops = {
 	.qc_issue		= adma_qc_issue,
 	.eng_timeout		= adma_eng_timeout,
 	.data_xfer		= ata_data_xfer,
-	.irq_handler		= adma_intr,
 	.irq_clear		= adma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -186,7 +184,6 @@ static const struct ata_port_operations adma_ata_ops = {
 static struct ata_port_info adma_port_info[] = {
 	/* board_1841_idx */
 	{
-		.sht		= &adma_ata_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
 				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_POLLING,
@@ -229,8 +226,10 @@ static void adma_irq_clear(struct ata_port *ap)
 	/* nothing */
 }
 
-static void adma_reset_engine(void __iomem *chan)
+static void adma_reset_engine(struct ata_port *ap)
 {
+	void __iomem *chan = ADMA_PORT_REGS(ap);
+
 	/* reset ADMA to idle state */
 	writew(aPIOMD4 | aNIEN | aRSTADM, chan + ADMA_CONTROL);
 	udelay(2);
@@ -241,14 +240,14 @@ static void adma_reset_engine(void __iomem *chan)
 static void adma_reinit_engine(struct ata_port *ap)
 {
 	struct adma_port_priv *pp = ap->private_data;
-	void __iomem *chan = ADMA_HOST_REGS(ap->host, ap->port_no);
+	void __iomem *chan = ADMA_PORT_REGS(ap);
 
 	/* mask/clear ATA interrupts */
 	writeb(ATA_NIEN, ap->ioaddr.ctl_addr);
 	ata_check_status(ap);
 
 	/* reset the ADMA engine */
-	adma_reset_engine(chan);
+	adma_reset_engine(ap);
 
 	/* set in-FIFO threshold to 0x100 */
 	writew(0x100, chan + ADMA_FIFO_IN);
@@ -268,7 +267,7 @@ static void adma_reinit_engine(struct ata_port *ap)
 
 static inline void adma_enter_reg_mode(struct ata_port *ap)
 {
-	void __iomem *chan = ADMA_HOST_REGS(ap->host, ap->port_no);
+	void __iomem *chan = ADMA_PORT_REGS(ap);
 
 	writew(aPIOMD4, chan + ADMA_CONTROL);
 	readb(chan + ADMA_STATUS);	/* flush */
@@ -415,7 +414,7 @@ static void adma_qc_prep(struct ata_queued_cmd *qc)
 static inline void adma_packet_start(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void __iomem *chan = ADMA_HOST_REGS(ap->host, ap->port_no);
+	void __iomem *chan = ADMA_PORT_REGS(ap);
 
 	VPRINTK("ENTER, ap %p\n", ap);
 
@@ -453,7 +452,7 @@ static inline unsigned int adma_intr_pkt(struct ata_host *host)
 		struct ata_port *ap = host->ports[port_no];
 		struct adma_port_priv *pp;
 		struct ata_queued_cmd *qc;
-		void __iomem *chan = ADMA_HOST_REGS(host, port_no);
+		void __iomem *chan = ADMA_PORT_REGS(ap);
 		u8 status = readb(chan + ADMA_STATUS);
 
 		if (status == 0)
@@ -575,7 +574,7 @@ static int adma_port_start(struct ata_port *ap)
 
 static void adma_port_stop(struct ata_port *ap)
 {
-	adma_reset_engine(ADMA_HOST_REGS(ap->host, ap->port_no));
+	adma_reset_engine(ap);
 }
 
 static void adma_host_stop(struct ata_host *host)
@@ -583,35 +582,40 @@ static void adma_host_stop(struct ata_host *host)
 	unsigned int port_no;
 
 	for (port_no = 0; port_no < ADMA_PORTS; ++port_no)
-		adma_reset_engine(ADMA_HOST_REGS(host, port_no));
+		adma_reset_engine(host->ports[port_no]);
 }
 
-static void adma_host_init(unsigned int chip_id,
-				struct ata_probe_ent *probe_ent)
+static void adma_host_init(struct ata_host *host, unsigned int chip_id)
 {
 	unsigned int port_no;
-	void __iomem *mmio_base = probe_ent->iomap[ADMA_MMIO_BAR];
 
 	/* enable/lock aGO operation */
-	writeb(7, mmio_base + ADMA_MODE_LOCK);
+	writeb(7, host->iomap[ADMA_MMIO_BAR] + ADMA_MODE_LOCK);
 
 	/* reset the ADMA logic */
 	for (port_no = 0; port_no < ADMA_PORTS; ++port_no)
-		adma_reset_engine(ADMA_REGS(mmio_base, port_no));
+		adma_reset_engine(host->ports[port_no]);
 }
 
 static int adma_ata_init_one(struct pci_dev *pdev,
 			     const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent = NULL;
-	void __iomem *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	const struct ata_port_info *ppi[] = { &adma_port_info[board_idx], NULL };
+	struct ata_host *host;
+	void __iomem *mmio_base;
 	int rc, port_no;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* alloc host */
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, ADMA_PORTS);
+	if (!host)
+		return -ENOMEM;
+
+	/* acquire resources and fill host */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -622,46 +626,23 @@ static int adma_ata_init_one(struct pci_dev *pdev,
 	rc = pcim_iomap_regions(pdev, 1 << ADMA_MMIO_BAR, DRV_NAME);
 	if (rc)
 		return rc;
-	mmio_base = pcim_iomap_table(pdev)[ADMA_MMIO_BAR];
+	host->iomap = pcim_iomap_table(pdev);
+	mmio_base = host->iomap[ADMA_MMIO_BAR];
 
 	rc = pci_configure_dma_masks(pdev, DMA_32BIT_MASK, NULL);
 	if (rc)
 		return rc;
 
-	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL)
-		return -ENOMEM;
-
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	probe_ent->sht		= adma_port_info[board_idx].sht;
-	probe_ent->port_flags	= adma_port_info[board_idx].flags;
-	probe_ent->pio_mask	= adma_port_info[board_idx].pio_mask;
-	probe_ent->mwdma_mask	= adma_port_info[board_idx].mwdma_mask;
-	probe_ent->udma_mask	= adma_port_info[board_idx].udma_mask;
-	probe_ent->port_ops	= adma_port_info[board_idx].port_ops;
-
-	probe_ent->irq		= pdev->irq;
-	probe_ent->irq_flags	= IRQF_SHARED;
-	probe_ent->n_ports	= ADMA_PORTS;
-	probe_ent->iomap	= pcim_iomap_table(pdev);
-
-	for (port_no = 0; port_no < probe_ent->n_ports; ++port_no) {
-		adma_ata_setup_port(&probe_ent->port[port_no],
+	for (port_no = 0; port_no < ADMA_PORTS; ++port_no)
+		adma_ata_setup_port(&host->ports[port_no]->ioaddr,
 				    ADMA_ATA_REGS(mmio_base, port_no));
-	}
-
-	pci_set_master(pdev);
 
 	/* initialize adapter */
-	adma_host_init(board_idx, probe_ent);
+	adma_host_init(host, board_idx);
 
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
-
-	devm_kfree(&pdev->dev, probe_ent);
-	return 0;
+	pci_set_master(pdev);
+	return ata_host_activate(host, pdev->irq, adma_intr, IRQF_SHARED,
+				 &adma_ata_sht);
 }
 
 static int __init adma_ata_init(void)
-- 
1.5.0.1


