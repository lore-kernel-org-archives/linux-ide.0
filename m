From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Not-yet-working inic162x driver
Date: Tue, 07 Feb 2006 01:39:03 -0500
Message-ID: <43E84087.5000907@pobox.com>
References: <20060207052848.GA6178@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:46720 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932300AbWBGGjM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Feb 2006 01:39:12 -0500
In-Reply-To: <20060207052848.GA6178@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, guys.
> +static struct ata_port_info inic_port_info = {
> +	.sht			= &inic_sht,
> +	/* XXX - for the time being, SATA_RESET fails faster... */
> +	.host_flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
> +				  ATA_FLAG_MMIO | ATA_FLAG_SATA_RESET,
> +	.pio_mask		= 0x1f,
> +	.mwdma_mask		= 0x07,
> +	.udma_mask		= 0x7f,
> +	.port_ops		= &inic_ops,
> +};

does pio-only (dma_masks == 0) work?


> +static u32 inic_scr_read(struct ata_port *ap, unsigned sc_reg)
> +{
> +	void __iomem *scr_addr = (void __iomem *)ap->ioaddr.scr_addr;
> +
> +	if (sc_reg <= SCR_ACTIVE)
> +		return readl(scr_addr + sc_reg * 4);
> +	return -1U;

-1U is sorta a contradiction.


> +static void inic_bmdma_setup(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct inic_port_priv *pp = ap->private_data;
> +	void __iomem *base = AP_MMIO(ap);
> +	int rw = qc->tf.flags & ATA_TFLAG_WRITE;
> +	u32 len;
> +
> +	/* make sure device sees PRD table writes */
> +	wmb();
> +
> +	/* load transfer length - is this necessary? */
> +	if (is_atapi_taskfile(&qc->tf))
> +		len = qc->nsect << 9;
> +	else
> +		len = qc->nbytes;

In the about 'if atapi_taskfile() foo else bar', "foo" and "bar" appear 
reversed.


> +static irqreturn_t inic_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
> +{
> +	struct ata_host_set *host_set = dev_instance;
> +	void __iomem *regs_base = host_set->mmio_base;
> +	u16 host_irq_stat;
> +	int i, handled = 0;;
> +
> +	host_irq_stat = readw(regs_base + HOST_IRQ_STAT);
> +
> +	if (unlikely(!(host_irq_stat & HIRQ_GLOBAL)))
> +		goto out;

check for both stat==0 (nothing to do) and stat=ffffffff (hw fault or 
unplug)


> +static int inic_port_start(struct ata_port *ap)
> +{
> +	struct device *dev = ap->host_set->dev;
> +	void __iomem *regs_base = ap->host_set->mmio_base;
> +	void __iomem *base = AP_MMIO(ap);
> +	struct inic_port_priv *pp = NULL;

needless init


> +	struct inic_cmd_block *cb = NULL;
> +	dma_addr_t cb_dma;
> +	int rc;
> +	u32 tmp;
> +
> +	/* Alloc resources */
> +	rc = -ENOMEM;
> +	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
> +	if (!pp)
> +		goto err_out;
> +
> +	cb = dma_alloc_coherent(dev, sizeof(*cb), &cb_dma, GFP_KERNEL);
> +	if (!cb)
> +		goto err_out;
> +	memset(cb, 0, sizeof(*cb));
> +
> +	rc = ata_pad_alloc(ap, dev);
> +	if (rc)
> +		goto err_out;
> +
> +	/* XXX */
> +	printk("XXX POST GLOBAL RESET\n");
> +	dump_tf(ap);
> +	dump_port(ap);
> +	/* XXX */
> +
> +	/* Stop BMDMA and reset IDMA */
> +	tmp = readb(base + PORT_PRD_CTRL);
> +	tmp &= PRD_RSVD;
> +	writeb(tmp, base + PORT_PRD_CTRL);
> +
> +	tmp = readw(base + PORT_IDMA_CTRL);
> +	tmp &= IDMA_CTRL_RSVD;
> +	writew(tmp | IDMA_CTRL_RST_IDMA, base + PORT_IDMA_CTRL);
> +	readw(base + PORT_IDMA_CTRL);	/* flush */
> +	msleep(1);			/* spec says 1us, well... */
> +	writew(tmp, base + PORT_IDMA_CTRL);
> +
> +	/* Setup PRD address */
> +	writel(cb_dma + CB_PRD_OFFSET, base + PORT_PRD_ADDR);
> +
> +	/* Setup IRQ mask and enable IRQ for this port */
> +	writeb(PIRQ_MASK, base + PORT_IRQ_MASK);
> +
> +	tmp = readw(regs_base + HOST_IRQ_MASK);
> +	if (ap->port_no == 0)
> +		tmp &= ~HIRQ_PORT0;
> +	else
> +		tmp &= ~HIRQ_PORT1;
> +	writew(tmp, regs_base + HOST_IRQ_MASK);
> +
> +	/* Initialize data structures */
> +	pp->bmdma_status = 0x20; /* Drive 0 DMA capable */
> +	pp->cmd_block = cb;
> +	pp->cmd_block_dma = cb_dma;
> +	pp->dfl_prdctl = readb(base + PORT_PRD_CTRL);
> +	ap->private_data = pp;
> +
> +	ap->prd = cb->prd;
> +	ap->prd_dma = cb_dma + CB_PRD_OFFSET;
> +
> +	/* XXX */
> +	printk("XXX HERE0\n");
> +	writeb(0xde, base + PORT_TF + ATA_REG_NSECT);
> +	writeb(0xad, base + PORT_TF + ATA_REG_LBAL);
> +	writeb(0xbe, base + PORT_TF + ATA_REG_LBAM);
> +	writeb(0xef, base + PORT_TF + ATA_REG_LBAH);
> +	writeb(0x69, base + PORT_TF + ATA_REG_FEATURE);
> +	dump_tf(ap);
> +	dump_port(ap);
> +
> +	/*
> +	 * XXX - this is where I got stuck.  I couldn't get ATA TF
> +	 * mode working.
> +	 *
> +	 * STANDBYNOW1 actually gets issued and the drive spins down.
> +	 * BUT no interrupt is generated.
> +	 *
> +	 * SRST seems to do something but drive never gets out of BUSY
> +	 * status.
> +	 *
> +	 * SATA RESET also seems to do something but TF registers are
> +	 * not changed after it.  (TF regs doesn't change at all, to
> +	 * verify, load TF regs with arbitrary values.
> +	 *
> +	 * PORT RESET seems to perform reset and it loads part of
> +	 * signature into TF regs.  But error register is 0xff after
> +	 * PORT RESET.
> +	 *
> +	 * PORT_IDMA_STAT's legacy mode bit is off all the time.  I
> +	 * think this is why TF regs are not behaving as expected.  If
> +	 * you find out how to turn on legacy mode, please let me
> +	 * know.
> +	 *
> +	 * Contrary to the document, host reset does seem to reset the
> +	 * PHYs and loads part of classification signature into TF
> +	 * registers (again, error register is off).
> +	 *
> +	 * Lying about error register make libata continue to issue
> +	 * IDENTIFY but it times out.
> +	 */
> +
> +/*	printk("issuing STANDBYNOW1\n");
> +	writeb(ATA_CMD_STANDBYNOW1, base + PORT_TF + ATA_REG_CMD);
> +	printk("sleeping 3secss\n");
> +	msleep(3000);*/
> +/*	printk("SRST...\n");
> +	writeb(ap->ctl | ATA_SRST, base + PORT_ALT_STAT);
> +	msleep(100);
> +	writeb(ap->ctl, base + PORT_ALT_STAT);
> +	msleep(3000);*/
> +/*	printk("SATA RESET\n");
> +	scr_write_flush(ap, SCR_CONTROL, 0x301);
> +	msleep(1);
> +	scr_write_flush(ap, SCR_CONTROL, 0x300);
> +	msleep(3000);*/
> +	printk("PORT RESET\n");
> +	writew(tmp | IDMA_CTRL_RST_ATA, base + PORT_IDMA_CTRL);
> +	msleep(100);
> +	writew(tmp, base + PORT_IDMA_CTRL);
> +	msleep(3000);
> +
> +	dump_tf(ap);
> +	dump_port(ap);
> +	/* XXX */
> +
> +	return 0;
> +
> + err_out:
> +	if (cb)
> +		dma_free_coherent(dev, sizeof(*cb), cb, cb_dma);
> +	if (pp)
> +		kfree(pp);

1) no need to check for NULL before calling kfree()

2) what about undoing ata_pad_alloc() ?


> +static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	static int printed_version = 0;
> +	int mmio_idx, i, rc;
> +	struct ata_probe_ent *probe_ent = NULL;
> +	void __iomem *regs_base = NULL;
> +	struct ata_port_info *pinfo;
> +	struct ata_ioports *port;
> +	u16 ctrl;
> +	u32 tmp;
> +
> +	if (!printed_version++)
> +		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
> +
> +	rc = pci_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_request_regions(pdev, DRV_NAME);
> +	if (rc)
> +		goto out_disable;
> +
> +	/*
> +	 * If the controller is configured for Cardbus mode, BAR[0-1]
> +	 * map to BAR[4-5] of normal PCI mode and the rest are
> +	 * reserved.
> +	 */
> +	mmio_idx = 5;
> +	if (pci_resource_flags(pdev, 1) & IORESOURCE_MEM)
> +		mmio_idx = 1;
> +
> +	if (!(pci_resource_flags(pdev, mmio_idx) & IORESOURCE_MEM)) {
> +		dev_printk(KERN_ERR, &pdev->dev,
> +			   "invalid mmio area, flags %lx size %lu\n",
> +			   pci_resource_flags(pdev, mmio_idx),
> +			   pci_resource_len(pdev, mmio_idx));

you should print out mmio_idx, as well as the PCI resources


> +		rc = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	rc = -ENOMEM;
> +	/* ioremap mmio registers */
> +	regs_base = ioremap(pci_resource_start(pdev, mmio_idx),
> +			    pci_resource_len(pdev, mmio_idx));
> +	if (!regs_base)
> +		goto out_free;
> +
> +	/* allocate & init probe_ent */
> +	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
> +	if (!probe_ent)
> +		goto out_free;
> +
> +	probe_ent->dev = &pdev->dev;
> +	INIT_LIST_HEAD(&probe_ent->node);
> +
> +	pinfo = &inic_port_info;
> +	port = probe_ent->port;
> +
> +	probe_ent->sht		= pinfo->sht;
> +	probe_ent->host_flags	= pinfo->host_flags;
> +	probe_ent->pio_mask	= pinfo->pio_mask;
> +	probe_ent->udma_mask	= pinfo->udma_mask;
> +	probe_ent->port_ops	= pinfo->port_ops;
> +	probe_ent->n_ports	= INIC_NPORTS;
> +
> +	probe_ent->irq = pdev->irq;
> +	probe_ent->irq_flags = SA_SHIRQ;
> +	probe_ent->mmio_base = regs_base;
> +
> +	for (i = 0; i < INIC_NPORTS; i++) {
> +		unsigned long base = (unsigned long)regs_base;
> +
> +		if (i == 0)
> +			base += PORT0_BASE;
> +		else
> +			base += PORT1_BASE;
> +		
> +		port[i].cmd_addr = base + PORT_TF;
> +		ata_std_ports(&port[i]);
> +		port[i].altstatus_addr = base + PORT_ALT_STAT;
> +		port[i].ctl_addr = base + PORT_ALT_STAT;
> +		port[i].scr_addr = base + PORT_SCR_BASE;
> +	}
> +
> +	/* Set dma_mask.  This devices doesn't support 64bit addressing. */
> +	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
> +	if (rc) {
> +		dev_printk(KERN_ERR, &pdev->dev,
> +			   "32-bit DMA enable failed\n");
> +		goto out_free;
> +	}
> +
> +	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
> +	if (rc) {
> +		dev_printk(KERN_ERR, &pdev->dev,
> +			   "32-bit consistent DMA enable failed\n");
> +		goto out_free;
> +	}
> +
> +	/*
> +	 * Configure the controller
> +	 */
> +
> +	/* Set sensible HOST_CTRL and turn global IRQ off */
> +	ctrl = readw(regs_base + HOST_CTRL);
> +	ctrl &= ~(HCTRL_MIREN | HCTRL_PWRDWN | HCTRL_RPGSEL);
> +	ctrl |= HCTRL_GINTDIS;
> +	writew(ctrl, regs_base + HOST_CTRL);
> +
> +	/* Mask irqs */
> +	tmp = readw(regs_base + HOST_IRQ_MASK);
> +	tmp |= HIRQ_PORT0 | HIRQ_PORT1 | HIRQ_SOFT;
> +	writew(tmp, regs_base + HOST_IRQ_MASK);
> +
> +	/* Soft reset the controller */
> +	ctrl |= HCTRL_SOFTRST;
> +	writew(ctrl, regs_base + HOST_CTRL);
> +
> +	/*
> +	 * Spec says reset duration is 3 PCI clocks, be generous and
> +	 * give it 10ms.
> +	 */
> +	for (i = 0; i < 10; i++) {
> +		msleep(1);
> +		ctrl = readw(regs_base + HOST_CTRL);
> +		if (!(ctrl & HCTRL_SOFTRST))
> +			break;
> +	}
> +
> +	if (ctrl & HCTRL_SOFTRST) {
> +		dev_printk(KERN_ERR, &pdev->dev,
> +			   "failed to reset the controller\n");
> +		rc = -EIO;
> +		goto out_free;
> +	}
> +
> +	/* Turn on global IRQ */
> +	ctrl &= ~HCTRL_GINTDIS;
> +	writew(ctrl, regs_base + HOST_CTRL);
> +
> +	pci_set_master(pdev);

Missing a call to pci_intx(), most likely...

