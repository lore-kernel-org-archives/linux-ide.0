From: Tejun Heo <htejun@gmail.com>
Subject: Re: Not-yet-working inic162x driver
Date: Tue, 07 Feb 2006 15:54:42 +0900
Message-ID: <43E84432.6080504@gmail.com>
References: <20060207052848.GA6178@htj.dyndns.org> <43E84087.5000907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.194]:2998 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964913AbWBGGyt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Feb 2006 01:54:49 -0500
Received: by xproxy.gmail.com with SMTP id i30so901342wxd
        for <linux-ide@vger.kernel.org>; Mon, 06 Feb 2006 22:54:48 -0800 (PST)
In-Reply-To: <43E84087.5000907@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello, Jeff.

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Hello, guys.
>> +static struct ata_port_info inic_port_info = {
>> +    .sht            = &inic_sht,
>> +    /* XXX - for the time being, SATA_RESET fails faster... */
>> +    .host_flags        = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>> +                  ATA_FLAG_MMIO | ATA_FLAG_SATA_RESET,
>> +    .pio_mask        = 0x1f,
>> +    .mwdma_mask        = 0x07,
>> +    .udma_mask        = 0x7f,
>> +    .port_ops        = &inic_ops,
>> +};
> 
> 
> does pio-only (dma_masks == 0) work?
> 

No, IDENTIFY doesn't work.  Even SRST and SATA_RESET don't work.

> 
>> +static u32 inic_scr_read(struct ata_port *ap, unsigned sc_reg)
>> +{
>> +    void __iomem *scr_addr = (void __iomem *)ap->ioaddr.scr_addr;
>> +
>> +    if (sc_reg <= SCR_ACTIVE)
>> +        return readl(scr_addr + sc_reg * 4);
>> +    return -1U;
> 
> 
> -1U is sorta a contradiction.
> 

I kind of prefer unsigned -1 over 0xf*, but no big deal.

> 
>> +static void inic_bmdma_setup(struct ata_queued_cmd *qc)
>> +{
>> +    struct ata_port *ap = qc->ap;
>> +    struct inic_port_priv *pp = ap->private_data;
>> +    void __iomem *base = AP_MMIO(ap);
>> +    int rw = qc->tf.flags & ATA_TFLAG_WRITE;
>> +    u32 len;
>> +
>> +    /* make sure device sees PRD table writes */
>> +    wmb();
>> +
>> +    /* load transfer length - is this necessary? */
>> +    if (is_atapi_taskfile(&qc->tf))
>> +        len = qc->nsect << 9;
>> +    else
>> +        len = qc->nbytes;
> 
> 
> In the about 'if atapi_taskfile() foo else bar', "foo" and "bar" appear 
> reversed.
> 

Yeap, you're right.  The test was 'if (qc->nsect)' initially and I 
forgot to swap the bodies after changing the condition.

> 
>> +static irqreturn_t inic_interrupt(int irq, void *dev_instance, struct 
>> pt_regs *regs)
>> +{
>> +    struct ata_host_set *host_set = dev_instance;
>> +    void __iomem *regs_base = host_set->mmio_base;
>> +    u16 host_irq_stat;
>> +    int i, handled = 0;;
>> +
>> +    host_irq_stat = readw(regs_base + HOST_IRQ_STAT);
>> +
>> +    if (unlikely(!(host_irq_stat & HIRQ_GLOBAL)))
>> +        goto out;
> 
> 
> check for both stat==0 (nothing to do) and stat=ffffffff (hw fault or 
> unplug)
> 

Sure.

> 
>> +static int inic_port_start(struct ata_port *ap)
>> +{
>> +    struct device *dev = ap->host_set->dev;
>> +    void __iomem *regs_base = ap->host_set->mmio_base;
>> +    void __iomem *base = AP_MMIO(ap);
>> +    struct inic_port_priv *pp = NULL;
> 
> 
> needless init
> 

Okay.

> 
>> +    struct inic_cmd_block *cb = NULL;
>> +    dma_addr_t cb_dma;
>> +    int rc;
>> +    u32 tmp;
>> +
>> +    /* Alloc resources */
>> +    rc = -ENOMEM;
>> +    pp = kzalloc(sizeof(*pp), GFP_KERNEL);
>> +    if (!pp)
>> +        goto err_out;
>> +
>> +    cb = dma_alloc_coherent(dev, sizeof(*cb), &cb_dma, GFP_KERNEL);
>> +    if (!cb)
>> +        goto err_out;
>> +    memset(cb, 0, sizeof(*cb));
>> +
>> +    rc = ata_pad_alloc(ap, dev);
>> +    if (rc)
>> +        goto err_out;
[[--snip--]]
>> +
>> + err_out:
>> +    if (cb)
>> +        dma_free_coherent(dev, sizeof(*cb), cb, cb_dma);
>> +    if (pp)
>> +        kfree(pp);
> 
> 
> 1) no need to check for NULL before calling kfree()

Right.

> 2) what about undoing ata_pad_alloc() ?

The last jump to err_out is after failure of ata_pad_alloc().  Also, 
ata_pad_free() doesn't check for ap->pad == NULL condition before 
freeing, so the test should be done explicitly and it seemed a bit out 
of place as pad handling is pretty much hidden from low level driver. 
How about adding ap->pad condition check in ata_pad_free()?

> 
>> +static int inic_init_one(struct pci_dev *pdev, const struct 
>> pci_device_id *ent)
>> +{
>> +    static int printed_version = 0;
>> +    int mmio_idx, i, rc;
>> +    struct ata_probe_ent *probe_ent = NULL;
>> +    void __iomem *regs_base = NULL;
>> +    struct ata_port_info *pinfo;
>> +    struct ata_ioports *port;
>> +    u16 ctrl;
>> +    u32 tmp;
>> +
>> +    if (!printed_version++)
>> +        dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
>> +
>> +    rc = pci_enable_device(pdev);
>> +    if (rc)
>> +        return rc;
>> +
>> +    rc = pci_request_regions(pdev, DRV_NAME);
>> +    if (rc)
>> +        goto out_disable;
>> +
>> +    /*
>> +     * If the controller is configured for Cardbus mode, BAR[0-1]
>> +     * map to BAR[4-5] of normal PCI mode and the rest are
>> +     * reserved.
>> +     */
>> +    mmio_idx = 5;
>> +    if (pci_resource_flags(pdev, 1) & IORESOURCE_MEM)
>> +        mmio_idx = 1;
>> +
>> +    if (!(pci_resource_flags(pdev, mmio_idx) & IORESOURCE_MEM)) {
>> +        dev_printk(KERN_ERR, &pdev->dev,
>> +               "invalid mmio area, flags %lx size %lu\n",
>> +               pci_resource_flags(pdev, mmio_idx),
>> +               pci_resource_len(pdev, mmio_idx));
> 
> 
> you should print out mmio_idx, as well as the PCI resources
> 

Yeap.

[[--snip--]]
>> +
>> +    /* Turn on global IRQ */
>> +    ctrl &= ~HCTRL_GINTDIS;
>> +    writew(ctrl, regs_base + HOST_CTRL);
>> +
>> +    pci_set_master(pdev);
> 
> 
> Missing a call to pci_intx(), most likely...
> 

I'll add it.

Thanks for reviewing it.  :-)

Do you happen to know anyone from Initio?

-- 
tejun
