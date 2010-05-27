From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/4] pata_samsung: Add Samsung PATA controller driver
Date: Thu, 27 May 2010 14:17:40 +0400
Message-ID: <4BFE46C4.5030007@mvista.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com> <1274948524-2970-5-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1274948524-2970-5-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

Hello.

Kukjin Kim wrote:

> From: Abhilash Kesavan <a.kesavan@samsung.com>

> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsystem.

> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

> diff --git a/drivers/ata/pata_samsung.c b/drivers/ata/pata_samsung.c
> new file mode 100644
> index 0000000..14381e4
> --- /dev/null
> +++ b/drivers/ata/pata_samsung.c
> @@ -0,0 +1,591 @@
[...]
> +static void pata_s3c_tune_chipset(struct s3c_ide_info *info, u8 ide_mode)
> +{
> +	ulong ata_cfg = readl(info->ide_addr + S3C_ATA_CFG);
> +
> +	/* IORDY is enabled for modes > PIO2 */
> +	if (XFER_PIO_0 <= ide_mode && ide_mode <= XFER_PIO_4) {
> +
> +		switch (ide_mode) {
> +		case XFER_PIO_0:
> +		case XFER_PIO_1:
> +		case XFER_PIO_2:
> +			ata_cfg &= (~S3C_ATA_CFG_IORDYEN);

    Useless parens.

> +			break;
> +		case XFER_PIO_3:
> +		case XFER_PIO_4:
> +			ata_cfg |= S3C_ATA_CFG_IORDYEN;

    IORDY should be controlled by ata_id_pio_need_iordy(),  not by mode 
number. PIO2 also can have IODRY enabled.

> +			break;
> +		}
> +
> +		writel(ata_cfg, info->ide_addr + S3C_ATA_CFG);
> +		writel(piotime[ide_mode - XFER_PIO_0],
> +			info->ide_addr + S3C_ATA_PIO_TIME);
> +	} else {
> +		/* Default to PIO0 */
> +		ata_cfg &= (~S3C_ATA_CFG_IORDYEN);
> +		writel(ata_cfg, info->ide_addr + S3C_ATA_CFG);
> +		writel(piotime[0], info->ide_addr + S3C_ATA_PIO_TIME);

    If you don't support DMA modes or modes higher than PIO4 (PIO5 and 
PIO6 would have been good for CF though), just do nothing.

> +	}
> +}
> +
> +static void
> +pata_s3c_set_piomode(struct ata_port *ap, struct ata_device *adev)
> +{
> +	struct s3c_ide_info *info = ap->host->private_data;
> +
> +	/* Configure IORDY based on PIO mode and also set the timing value */
> +	pata_s3c_tune_chipset(info, adev->pio_mode);

    Don't see why you need a separate function for that. Maybe in 
preparation to UDMA support?

> +/*
> + * Writes to one of the task file registers.
> + */
> +static void ata_outb(struct ata_host *host, u8 addr, void __iomem *reg)
> +{
> +	struct s3c_ide_info *info = host->private_data;
> +
> +	wait_for_host_ready(info);
> +	__raw_writeb(addr, reg);

    You should use write?() or __raw_write?() consistently...

> +/*
> + * pata_s3c_tf_load - send taskfile registers to host controller
> + */
> +static void pata_s3c_tf_load(struct ata_port *ap,
> +				const struct ata_taskfile *tf)
> +{
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
> +
> +	if (tf->ctl != ap->last_ctl) {
> +		if (ioaddr->ctl_addr)

    This register does exist and you assign ioaddr->ctl_addr in 
pata_s3c_probe(), hence the check is pointless.

> +			ata_outb(ap->host, tf->ctl, ioaddr->ctl_addr);
> +		ap->last_ctl = tf->ctl;
> +		ata_wait_idle(ap);
> +	}
> +
> +	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> +		WARN_ON_ONCE(!ioaddr->ctl_addr);

    You don't need this either.

> +/*
> + * pata_s3c_tf_read - input device's ATA taskfile shadow registers
> + */
> +static void pata_s3c_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> +{
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +
> +	tf->command = ata_sff_check_status(ap);

    But you have overriden this method, so ata_sff_check_status() 
shouldn't work!

> +	tf->feature = ata_inb(ap->host, ioaddr->error_addr);
> +	tf->nsect = ata_inb(ap->host, ioaddr->nsect_addr);
> +	tf->lbal = ata_inb(ap->host, ioaddr->lbal_addr);
> +	tf->lbam = ata_inb(ap->host, ioaddr->lbam_addr);
> +	tf->lbah = ata_inb(ap->host, ioaddr->lbah_addr);
> +	tf->device = ata_inb(ap->host, ioaddr->device_addr);
> +
> +	if (tf->flags & ATA_TFLAG_LBA48) {
> +		if (likely(ioaddr->ctl_addr)) {

    Not just likely, it's always true. Emilinate the check please.

> +			iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
> +			tf->hob_feature = ata_inb(ap->host, ioaddr->error_addr);
> +			tf->hob_nsect = ata_inb(ap->host, ioaddr->nsect_addr);
> +			tf->hob_lbal = ata_inb(ap->host, ioaddr->lbal_addr);
> +			tf->hob_lbam = ata_inb(ap->host, ioaddr->lbam_addr);
> +			tf->hob_lbah = ata_inb(ap->host, ioaddr->lbah_addr);
> +			iowrite8(tf->ctl, ioaddr->ctl_addr);
> +			ap->last_ctl = tf->ctl;
> +		} else
> +			WARN_ON_ONCE(1);

    Not needed.

> +/*
> + * pata_s3c_data_xfer - Transfer data by PIO
> + */
> +unsigned int pata_s3c_data_xfer(struct ata_device *dev, unsigned char *buf,
> +				unsigned int buflen, int rw)
> +{
> +	struct ata_port *ap = dev->link->ap;
> +	struct s3c_ide_info *info = ap->host->private_data;
> +	void __iomem *data_addr = ap->ioaddr.data_addr;
> +	unsigned int words = buflen >> 1, i;
> +	u16 *temp_addr = (u16 *)buf;
> +
> +	if (rw == READ) {

    {} not needed.

> +		for (i = 0; i < words; i++, temp_addr++) {
> +			wait_for_host_ready(info);
> +			*temp_addr = __raw_readw(data_addr);
> +			wait_for_host_ready(info);
> +			*temp_addr = __raw_readw(info->ide_addr
> +					+ S3C_ATA_PIO_RDATA);
> +		}
> +	} else {

    {} not needed.

> +		for (i = 0; i < words; i++, temp_addr++) {
> +			wait_for_host_ready(info);
> +			writel(*temp_addr, data_addr);
> +		}
> +	}

    Well, if this is pere CF case, 'buflen' can't be odd, but otherwise 
you should handle that case...

> +
> +	return words << 1;
> +}
> +
> +static struct scsi_host_template pata_s3c_sht = {
> +	ATA_PIO_SHT(DRV_NAME),
> +};
> +
> +static struct ata_port_operations pata_s3c_port_ops = {
> +	.inherits		= &ata_sff_port_ops,
> +	.sff_check_status	= pata_s3c_check_status,

    Since simple iowrite8() isn't enough in your case, you also need to 
override sff_dev_select(), sff_check_altstatus(), and sff_set_devctl() 
methods...

> +	.sff_tf_load		= pata_s3c_tf_load,
> +	.sff_tf_read		= pata_s3c_tf_read,
> +	.sff_data_xfer		= pata_s3c_data_xfer,
> +	.sff_exec_command	= pata_s3c_exec_command,
> +	.qc_prep		= ata_noop_qc_prep,
> +	.set_piomode		= pata_s3c_set_piomode,
> +};
> +
> +static struct ata_port_operations pata_s5p_port_ops = {
> +	.inherits		= &ata_sff_port_ops,
> +	.qc_prep		= ata_noop_qc_prep,
> +	.set_piomode		= pata_s3c_set_piomode,
> +};

[...]

> +static void pata_s3c_setup_timing(struct s3c_ide_info *info)
> +{
> +	uint t1, t2, teoc, i;
> +
> +	uint pio_t1[5] = { 70, 50, 30, 30, 25 };

    Could use ata_timing_find_mode() here to get the mode timings, 
intead of duplicating them from libata-ocre.c...

> +	uint pio_t2[5] = { 290, 290, 290, 80, 70 };

    Note that those active times are for command cycles, not for data ones.

> +	uint pio_teoc[5] = { 240, 43, 10, 70, 25 };

    What timing is this? :-O

> +
> +	ulong cycle_time = (uint) (1000000000 / clk_get_rate(info->clk));
> +
> +	for (i = 0; i < 5; i++) {
> +		t1 = (pio_t1[i] / cycle_time) & 0x0f;
> +		t2 = (pio_t2[i] / cycle_time) & 0xff;

    Could use ata_timing_compute() here.

> +		teoc = (pio_teoc[i] / cycle_time) & 0xff;
> +		piotime[i] = (teoc << 12) | (t2 << 4) | t1;
> +	}
> +}
> +
> +static void pata_s3c_hwinit(struct s3c_ide_info *info,
> +				struct s3c_ide_platdata *pdata)
> +{
> +	/* Select true-ide as the internal operating mode*/
> +	if (pdata && (pdata->cfg_mode))
> +		pdata->cfg_mode(info->sfr_addr);
> +
> +	switch (info->cpu_type) {
> +	case TYPE_S3C6400:
> +		/* Configure as big endian and enable the i/f*/

    Put space before */, please.

> +static int __devinit pata_s3c_probe(struct platform_device *pdev)
> +{
> +	struct s3c_ide_platdata *pdata = pdev->dev.platform_data;
> +	struct device *dev = &pdev->dev;
> +	struct s3c_ide_info *info;
> +	struct resource *res;
> +	struct ata_port *ap;
> +	struct ata_host *host;
> +	enum s3c_cpu_type cpu_type;
> +	int ret;
> +
> +	cpu_type = platform_get_device_id(pdev)->driver_data;
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		dev_err(dev, "failed to allocate memory for device data\n");
> +		return -ENOMEM;
> +	}
> +
> +	info->irq = platform_get_irq(pdev, 0);
> +	if (info->irq < 0) {
> +		dev_err(dev, "could not obtain irq number\n");
> +		ret = -ENODEV;
> +		goto release_device_mem;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res == NULL) {
> +		dev_err(dev, "failed to get mem resource\n");
> +		ret = -ENODEV;
> +		goto release_device_mem;
> +	}
> +
> +	info->ide_addr = devm_ioremap(dev,
> +				res->start, res->end - res->start + 1);
> +	if (!info->ide_addr) {
> +		dev_err(dev, "failed to map IO base address\n");
> +		ret = -ENOMEM;
> +		goto release_mem;
> +	}
> +
> +	info->clk = clk_get(&pdev->dev, "cfcon");
> +	if (IS_ERR(info->clk)) {
> +		dev_err(dev, "failed to get access to cf controller clock\n");
> +		ret = PTR_ERR(info->clk);
> +		info->clk = NULL;
> +		goto unmap;
> +	}
> +
> +	if (clk_enable(info->clk)) {

    Can it really fail?

> +		dev_err(dev, "failed to enable clock source.\n");
> +		goto clkerr;
> +	}
> +
> +	/* init ata host */
> +	host = ata_host_alloc(dev, 1);
> +	if (!host) {
> +		dev_err(dev, "failed to allocate ide host\n");
> +		ret = -ENOMEM;
> +		goto stop_clk;
> +	}
> +
> +	ap = host->ports[0];
> +	ap->flags |= ATA_FLAG_MMIO;
> +	ap->pio_mask = ATA_PIO4;
> +
> +	if (cpu_type == TYPE_S3C6400) {
> +		ap->ops = &pata_s3c_port_ops;
> +		info->sfr_addr = info->ide_addr + 0x1800;
> +		info->ide_addr = info->ide_addr + 0x1900;
> +		info->fifo_status_reg = 0x94;
> +	} else if (cpu_type == TYPE_S5PC100) {
> +		ap->ops = &pata_s5p_port_ops;
> +		info->sfr_addr = info->ide_addr + 0x1800;
> +		info->ide_addr = info->ide_addr + 0x1900;

    Does make sense to assign those before *if*.

> +		info->fifo_status_reg = 0x84;
> +	} else {
> +		ap->ops = &pata_s5p_port_ops;

    You don't assign 'info->ide_addr' here but you'll need it in 
pata_s3c_tune_chipset() which will be called thru pata_s5p_port_ops!

> +		info->fifo_status_reg = 0x84;
> +	}
> +
> +	info->cpu_type = cpu_type;
> +
> +	if (!(info->irq)) {

    Parens not needed around 'info->irq'.

> +		ap->flags |= ATA_FLAG_PIO_POLLING;
> +		ata_port_desc(ap, "no IRQ, using PIO polling\n");
> +	}
> +
> +	ap->ioaddr.cmd_addr =  info->ide_addr + S3C_ATA_CMD;
> +	ap->ioaddr.data_addr = info->ide_addr + S3C_ATA_PIO_DTR;
> +	ap->ioaddr.error_addr = info->ide_addr + S3C_ATA_PIO_FED;
> +	ap->ioaddr.feature_addr = info->ide_addr + S3C_ATA_PIO_FED;
> +	ap->ioaddr.nsect_addr = info->ide_addr + S3C_ATA_PIO_SCR;
> +	ap->ioaddr.lbal_addr = info->ide_addr + S3C_ATA_PIO_LLR;
> +	ap->ioaddr.lbam_addr = info->ide_addr + S3C_ATA_PIO_LMR;
> +	ap->ioaddr.lbah_addr = info->ide_addr + S3C_ATA_PIO_LHR;
> +	ap->ioaddr.device_addr = info->ide_addr + S3C_ATA_PIO_DVR;
> +	ap->ioaddr.status_addr = info->ide_addr + S3C_ATA_PIO_CSD;
> +	ap->ioaddr.command_addr = info->ide_addr + S3C_ATA_PIO_CSD;
> +	ap->ioaddr.altstatus_addr = info->ide_addr + S3C_ATA_PIO_DAD;
> +	ap->ioaddr.ctl_addr = info->ide_addr + S3C_ATA_PIO_DAD;
> +
> +

     Extra newline?

> +	ata_port_desc(ap, "mmio cmd 0x%llx ",
> +			(unsigned long long)res->start);
> +
> +	host->private_data = info;
> +
> +	/* Calculates timing parameters for PIO mode */
> +	pata_s3c_setup_timing(info);

    You could do it right in pata_s3c_tune_chipset() -- no need to 
precalculate the timings.

> +	if (pdata && (pdata->setup_gpio))

    Prens not needed around 'pdata->setup_gpio'.

> +		pdata->setup_gpio();
> +
> +	/* Set endianness and enable the interface */
> +	pata_s3c_hwinit(info, pdata);
> +
> +	return ata_host_activate(host, info->irq ? info->irq : 0,

    This ?: doesn't make sense, just pass 'info->irq'.

> +			info->irq ? pata_s3c_irq : NULL,
> +			IRQF_DISABLED, &pata_s3c_sht);
> +
> +	dev_set_drvdata(&pdev->dev, host);

    Could use platform_set_drvdata(pdev, host)...

> +
> +stop_clk:
> +	clk_disable(info->clk);
> +clkerr:
> +	clk_put(info->clk);
> +unmap:
> +	devm_iounmap(dev, info->ide_addr);

    devm_ioremap() should "look after itself", so no explicait call 
should be needed, if I don't mistake...

> +release_mem:
> +	release_mem_region(res->start, res->end - res->start + 1);

    But you didn't call request_mem_region()!

> +release_device_mem:
> +	kfree(info);
> +return ret;
> +}
> +
> +static int __devexit pata_s3c_remove(struct platform_device *pdev)
> +{
> +	struct ata_host *host = dev_get_drvdata(&pdev->dev);

    Could use platform_get_drvdata(pdev)...

> +	struct s3c_ide_info *info;
> +	struct resource *res;
> +
> +	if (!host)
> +		return 0;
> +	info = host->private_data;
> +
> +	ata_host_detach(host);
> +
> +	devm_iounmap(&pdev->dev, info->ide_addr);
> +	clk_disable(info->clk);
> +	clk_put(info->clk);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(res->start, res->end - res->start + 1);

    Use resource_size(). Also, you don't call request_mem_region().

> +	kfree(info);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int pata_s3c_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct ata_host *host = dev_get_drvdata(&pdev->dev);

    Could use platform_get_drvdata(pdev)...

> +	if (host)
> +		return ata_host_suspend(host, state);
> +	else
> +		return 0;
> +}
> +
> +static int pata_s3c_resume(struct platform_device *pdev)
> +{
> +	struct ata_host *host = dev_get_drvdata(&pdev->dev);

    Could use platform_get_drvdata(pdev)...

MBR, Sergei
