From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH v2 1/3] PATA host controller driver for ep93xx
Date: Tue, 3 Apr 2012 13:55:17 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020698409E51@AUSP01VMBX24.collaborationhost.net>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0CEF.2040307@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail131.messagelabs.com ([216.82.242.99]:29513 "EHLO
	mail131.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103Ab2DCSz2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Apr 2012 14:55:28 -0400
In-Reply-To: <4F7B0CEF.2040307@metasoft.pl>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>

On Tuesday, April 03, 2012 7:45 AM, Rafal Prylowski wrote:
<snip>

> +static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
> +{
> +	const struct platform_device *pdev = drv_data->pdev;
> +	dma_cap_mask_t mask;
> +	struct dma_slave_config conf;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	/*
> +	 * Request two channels for IDE. Another possibility would be
> +	 * to request only one channel, and reprogram it's direction at
> +	 * start of new transfer.
> +	 */
> +	drv_data->dma_rx_data.port = EP93XX_DMA_IDE;
> +	drv_data->dma_rx_data.direction = DMA_FROM_DEVICE;
> +	drv_data->dma_rx_data.name = "ep93xx-pata-rx";
> +	drv_data->dma_rx_channel = dma_request_channel(mask,
> +		ep93xx_pata_dma_filter, &drv_data->dma_rx_data);
> +	if (!drv_data->dma_rx_channel)
> +		return;
> +
> +	drv_data->dma_tx_data.port = EP93XX_DMA_IDE;
> +	drv_data->dma_tx_data.direction = DMA_TO_DEVICE;
> +	drv_data->dma_tx_data.name = "ep93xx-pata-tx";
> +	drv_data->dma_tx_channel = dma_request_channel(mask,
> +		ep93xx_pata_dma_filter, &drv_data->dma_tx_data);
> +	if (!drv_data->dma_tx_channel) {
> +		dma_release_channel(drv_data->dma_rx_channel);
> +		return;
> +	}
> +
> +	/* Configure receive channel direction and source address */
> +	memset(&conf, 0, sizeof(conf));
> +	conf.direction = DMA_FROM_DEVICE;
> +	conf.src_addr = drv_data->udma_in_phys;
> +	conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	if (dmaengine_slave_config(drv_data->dma_rx_channel, &conf)) {
> +		dev_err(&pdev->dev, "failed to configure rx dma channel\n");
> +		ep93xx_pata_release_dma(drv_data);
> +		return;
> +	}
> +
> +	/* Configure transmit channel direction and destination address */
> +	memset(&conf, 0, sizeof(conf));
> +	conf.direction = DMA_TO_DEVICE;
> +	conf.dst_addr = drv_data->udma_out_phys;
> +	conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	if (dmaengine_slave_config(drv_data->dma_tx_channel, &conf)) {
> +		dev_err(&pdev->dev, "failed to configure tx dma channel\n");
> +		ep93xx_pata_release_dma(drv_data);
> +	}
> +}

If the dma init fails does the driver fall back to pio mode correctly?

<snip>

> +static struct ata_port_operations ep93xx_pata_port_ops = {
> +	.inherits		= &ata_bmdma_port_ops,
> +
> +	.qc_prep		= ata_noop_qc_prep,
> +
> +	.softreset		= ep93xx_pata_softreset,
> +	.hardreset		= ATA_OP_NULL,
> +
> +	.sff_dev_select		= ep93xx_pata_dev_select,
> +	.sff_set_devctl		= ep93xx_pata_set_devctl,
> +	.sff_check_status	= ep93xx_pata_check_status,
> +	.sff_check_altstatus	= ep93xx_pata_check_altstatus,
> +	.sff_tf_load		= ep93xx_pata_tf_load,
> +	.sff_tf_read		= ep93xx_pata_tf_read,
> +	.sff_exec_command	= ep93xx_pata_exec_command,
> +	.sff_data_xfer		= ep93xx_pata_data_xfer,
> +	.sff_drain_fifo		= ep93xx_pata_drain_fifo,
> +	.sff_irq_clear		= ATA_OP_NULL,
> +
> +	.set_piomode		= ep93xx_pata_set_piomode,
> +
> +	.bmdma_setup		= ep93xx_pata_dma_setup,
> +	.bmdma_start		= ep93xx_pata_dma_start,
> +	.bmdma_stop		= ep93xx_pata_dma_stop,
> +	.bmdma_status		= ep93xx_pata_dma_status,

The bmdma ops pointers are still set if the dma init failed. Should they
be set to NULL?

> +
> +	.cable_detect		= ata_cable_unknown,
> +	.port_start		= ep93xx_pata_port_start,
> +};
> +
> +static int __devinit ep93xx_pata_probe(struct platform_device *pdev)
> +{
> +	struct ep93xx_pata_data *drv_data;
> +	struct ata_host *host;
> +	struct ata_port *ap;
> +	unsigned int irq;
> +	struct resource *mem_res;
> +	void __iomem *ide_base;
> +	int err;
> +
> +	err = ep93xx_ide_acquire_gpio(pdev);
> +	if (err)
> +		return err;
> +
> +	/* INT[3] (IRQ_EP93XX_EXT3) line connected as pull down */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		err = -ENXIO;
> +		goto err_rel_gpio;
> +	}
> +
> +	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem_res) {
> +		err = -ENXIO;
> +		goto err_rel_gpio;
> +	}
> +
> +	ide_base = devm_request_and_ioremap(&pdev->dev, mem_res);
> +	if (!ide_base) {
> +		err = -ENXIO;
> +		goto err_rel_gpio;
> +	}
> +
> +	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
> +	if (!drv_data) {
> +		err = -ENXIO;
> +		goto err_rel_gpio;
> +	}
> +
> +	platform_set_drvdata(pdev, drv_data);
> +	drv_data->pdev = pdev;
> +	drv_data->ide_base = ide_base;
> +	drv_data->udma_in_phys = mem_res->start + IDEUDMADATAIN;
> +	drv_data->udma_out_phys = mem_res->start + IDEUDMADATAOUT;
> +	ep93xx_pata_dma_init(drv_data);
> +
> +	/* allocate host */
> +	host = ata_host_alloc(&pdev->dev, 1);
> +	if (!host) {
> +		err = -ENXIO;
> +		goto err_rel_dma;
> +	}
> +
> +	ep93xx_pata_clear_regs(ide_base);
> +
> +	host->n_ports = 1;
> +	host->private_data = drv_data;
> +
> +	ap = host->ports[0];
> +	ap->dev = &pdev->dev;
> +	ap->ops = &ep93xx_pata_port_ops;
> +	ap->flags |= ATA_FLAG_SLAVE_POSS;
> +	ap->pio_mask = ATA_PIO4;
> +
> +	/*
> +	 * Maximum UDMA modes:
> +	 * EP931x rev.E0 - UDMA2
> +	 * EP931x rev.E1 - UDMA3
> +	 * EP931x rev.E2 - UDMA4
> +	 *
> +	 * MWDMA support was removed from EP931x rev.E2,
> +	 * so this driver supports only UDMA modes.
> +	 */
> +	if (drv_data->dma_rx_channel && drv_data->dma_tx_channel) {
> +		int chip_rev = ep93xx_chip_revision();
> +
> +		if (chip_rev == EP93XX_CHIP_REV_E1)
> +			ap->udma_mask = ATA_UDMA3;
> +		else if (chip_rev == EP93XX_CHIP_REV_E2)
> +			ap->udma_mask = ATA_UDMA4;
> +		else
> +			ap->udma_mask = ATA_UDMA2;
> +	}
> +
> +	/* defaults, pio 0 */
> +	ep93xx_pata_enable_pio(ide_base, 0);
> +
> +	dev_info(&pdev->dev, "version " DRV_VERSION "\n");
> +
> +	/* activate host */
> +	err = ata_host_activate(host, irq, ata_bmdma_interrupt, 0,
> +		&ep93xx_pata_sht);
> +	if (err == 0)
> +		return 0;
> +
> +err_rel_dma:
> +	ep93xx_pata_release_dma(drv_data);
> +err_rel_gpio:
> +	ep93xx_ide_release_gpio(pdev);
> +	return err;
> +}

There are only two m2m dma channels on the ep93xx. They could be already in
use by the spi driver. I just want to make sure that the ide driver will fall back to
pio mode if they are not available.

Regards,
Hartley


