From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v3] libata: pata_samsung_cf: Add Samsung PATA controller
 driver
Date: Thu, 10 Jun 2010 14:43:34 +0400
Message-ID: <4C10C1D6.8080708@ru.mvista.com>
References: <1276156241-28804-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1276156241-28804-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, jgarzik@pobox.com, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

Kukjin Kim wrote:

> From: Abhilash Kesavan <a.kesavan@samsung.com>

> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsystem.

> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

[...]

> diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
> new file mode 100644
> index 0000000..fef5515
> --- /dev/null
> +++ b/drivers/ata/pata_samsung_cf.c
> @@ -0,0 +1,608 @@
> +/* linux/drivers/ata/pata_samsung_cf.c

    File names in the heading comment are discouraged.

[...]

> +static unsigned long
> +pata_s3c_setup_timing(struct s3c_ide_info *info, struct ata_device *adev)
> +{
> +	const struct ata_timing *timing;
> +	int cycle_time;
> +	int t1;
> +	int t2;
> +	int t2i;
> +	ulong piotime;
> +
> +	cycle_time = (int)(1000000000UL / clk_get_rate(info->clk));
> +
> +	timing = ata_timing_find_mode(adev->pio_mode);
> +	t1	= (timing->setup / cycle_time) & 0xf;
> +	t2	= (timing->act8b / cycle_time) & 0xff;
> +	t2i	= (timing->rec8b / cycle_time) & 0xff;

    Why are you still not using ata_timing_compute()?

> +
> +	piotime = (t2i << 12) | (t2 << 4) | t1;
> +
> +	return piotime;
> +}
> +
> +static void pata_s3c_set_piomode(struct ata_port *ap, struct ata_device *adev)
> +{
> +	int mode = adev->pio_mode - XFER_PIO_0;
> +	struct s3c_ide_info *info = ap->host->private_data;
> +	ulong ata_cfg = readl(info->ide_addr + S3C_ATA_CFG);
> +	ulong piotime;
> +
> +	/* Calculates timing parameters for PIO mode */
> +	piotime = pata_s3c_setup_timing(info, adev);

    In fact, for 8-bit (command) timing you should program the slowest mode of 
the two drives. However, with CF, you probably only have only one drive per 
channel...

> +
> +	/* Enables IORDY if mode requires it */
> +	if (ata_pio_need_iordy(adev))
> +		ata_cfg |= S3C_ATA_CFG_IORDYEN;
> +	else
> +		ata_cfg &= ~S3C_ATA_CFG_IORDYEN;
> +
> +	/* Host controller supports upto PIO4 only */
> +	if (mode >= 0 && mode <= 4) {

    No need to check -- you won't be passed a mode not specified by your pio_mask.

> +		writel(ata_cfg, info->ide_addr + S3C_ATA_CFG);
> +		writel(piotime, info->ide_addr + S3C_ATA_PIO_TIME);
> +	}
> +}

[...]

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
> +	u16 *data_ptr = (u16 *)buf;
> +
> +	if (rw == READ)
> +		for (i = 0; i < words; i++, data_ptr++) {
> +			wait_for_host_ready(info);
> +			*data_ptr = readw(data_addr);

    Why not just ignore the result?

> +			wait_for_host_ready(info);
> +			*data_ptr = readw(info->ide_addr
> +					+ S3C_ATA_PIO_RDATA);
> +		}
> +	else
> +		for (i = 0; i < words; i++, data_ptr++) {
> +			wait_for_host_ready(info);
> +			writel(*data_ptr, data_addr);
> +		}
> +
> +	return words << 1;
> +}

[...]

> +static struct ata_port_operations pata_s3c_port_ops = {
> +	.inherits		= &ata_sff_port_ops,
> +	.sff_check_status	= pata_s3c_check_status,
> +	.sff_check_altstatus    = pata_s3c_check_altstatus,
> +	.sff_tf_load		= pata_s3c_tf_load,
> +	.sff_tf_read		= pata_s3c_tf_read,
> +	.sff_data_xfer		= pata_s3c_data_xfer,
> +	.sff_exec_command	= pata_s3c_exec_command,
> +	.sff_dev_select         = pata_s3c_dev_select,
> +	.sff_set_devctl         = pata_s3c_set_devctl,

    I forgot: you also need to override the softreset() method as it accesses 
several taskfile registers and ioread8()/iowrite8() won't suffice -- Jeff was 
too quick to ack the patch. See ata_bus_softreset(), ata_devchk(), and 
ata_sff_wait_after_reset() for the accesses I'm talking about...

[...]

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
> +		ret = -EINVAL;
> +		goto release_device_mem;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res == NULL) {
> +		dev_err(dev, "failed to get mem resource\n");
> +		ret = -EINVAL;
> +		goto release_device_mem;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res), DRV_NAME)) {

    Probably should call devm_request_mem_region() if you're using 
devm_ioremap()...

> +		dev_err(dev, "error requesting register region\n");
> +		return -EBUSY;
> +	}
> +
> +	info->ide_addr = devm_ioremap(dev, res->start, resource_size(res));
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

    No 'goto' here?

[...]

> +stop_clk:
> +	clk_disable(info->clk);

    Where is clk_put() call?

> +release_mem:
> +	release_mem_region(res->start, resource_size(res));
> +release_device_mem:
> +	kfree(info);

    Doesn't using devm_kzalloc() guarantee that the memory will be freed up 
automatically?

> +return ret;

    Wrong indentation.

> +static struct platform_driver pata_s3c_driver = {
> +	.probe		= pata_s3c_probe,
> 
> 

    2 empty lines -- broken patch?

> +	.remove		= __devexit_p(pata_s3c_remove),
> +	.id_table	= pata_s3c_driver_ids,
> +	.driver		= {
> +		.name	= DRV_NAME,
> +		.owner	= THIS_MODULE,
> +#ifdef CONFIG_PM
> +		.pm	= &pata_s3c_pm_ops,
> +#endif
> +	},
> +};

[...]

MBR, Sergei
