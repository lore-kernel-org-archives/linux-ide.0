From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [patch 1/1] ata: Add iMX pata support
Date: Sun, 17 Jul 2011 17:32:14 +0400
Message-ID: <4E22E45E.40807@ru.mvista.com>
References: <20110716210420.234549871@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:55860 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755753Ab1GQNdb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Jul 2011 09:33:31 -0400
Received: by wwg11 with SMTP id 11so2384780wwg.1
        for <linux-ide@vger.kernel.org>; Sun, 17 Jul 2011 06:33:30 -0700 (PDT)
In-Reply-To: <20110716210420.234549871@rtp-net.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
Cc: linux-ide@vger.kernel.org, s.hauer@pengutronix.de, jgarzik@pobox.com

Hello.

On 17-07-2011 1:04, Arnaud Patard (Rtp) wrote:

> Add basic support for pata on iMX. It has been tested only on imx51.
> SDMA support will probably be added later so this version supports only
> PIO.

> Signed-off-by: Arnaud Patard<arnaud.patard@rtp-net.org>
[...]
> Index: linux-2.6-submit/drivers/ata/pata_imx.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6-submit/drivers/ata/pata_imx.c	2011-07-16 22:35:41.000000000 +0200
> @@ -0,0 +1,254 @@
[...]
> + * TODO:
> + * - dmaengine support
> + * - check if timing stuff needed

    Sure, it's needed, especially if you want to support DMA.

> +#define PATA_IMX_ATA_CONTROL		0x24
> +#define PATA_IMX_ATA_CTRL_FIFO_RST_B	(1<<7)
> +#define PATA_IMX_ATA_CTRL_ATA_RST_B	(1<<6)
> +#define PATA_IMX_ATA_CTRL_IORDY_EN	(1<<0)

    So, it seems to support advanced PIO modes...

> +static int __devinit pata_imx_probe(struct platform_device *pdev)
> +{
> +	struct ata_host *host;
> +	struct ata_port *ap;
> +	struct pata_imx_priv *priv;
> +	int irq = 0;
> +	struct resource *io_res;
> +	struct resource *irq_res;
> +
> +	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (io_res == NULL)
> +		return -EINVAL;
> +
> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);

    Why not use platform_get_irq()?

> +	if (irq_res == NULL)
> +		return -EINVAL;
> +	irq = irq_res->start;
> +
> +	priv = kzalloc(sizeof(struct pata_imx_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk = clk_get(&pdev->dev, "imx-pata");

    Does iMX support clkdev?

[...]
> +	ap->ops = &pata_imx_port_ops;
> +	/* pio 0-4 */
> +	ap->pio_mask = ATA_PIO4;

    But you don't support PIO1-4!

> +	ap->flags |= ATA_FLAG_SLAVE_POSS;
> +
> +	priv->host_regs = devm_ioremap(&pdev->dev, io_res->start, 0x40);
> +	ap->ioaddr.cmd_addr = devm_ioremap(&pdev->dev,
> +					io_res->start + PATA_IMX_DRIVE_DATA,
> +					0x20);
> +	ap->ioaddr.ctl_addr = devm_ioremap(&pdev->dev,
> +					io_res->start + PATA_IMX_DRIVE_CONTROL,
> +					0x04);

    Why not ioremap all registers as one block?

> +	ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
> +		(unsigned long long)io_res->start + PATA_IMX_DRIVE_DATA,
> +		(unsigned long long)io_res->start + PATA_IMX_DRIVE_CONTROL);
> +
> +	/* deassert resets */
> +	__raw_writel(PATA_IMX_ATA_CTRL_FIFO_RST_B |
> +			PATA_IMX_ATA_CTRL_ATA_RST_B |
> +			PATA_IMX_ATA_CTRL_IORDY_EN,

    You can't enable IORDY by default, only when the drive supports it!

[...]
> +#ifdef CONFIG_PM
> +static int pata_imx_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ata_host *host = platform_get_drvdata(pdev);

    You can just use dev_get_drvdata(), without calling to_platfrom_device().

> +	struct pata_imx_priv *priv = host->private_data;
> +	int ret;
> +
> +	ret = ata_host_suspend(host, PMSG_SUSPEND);
> +

    Empty line not needed here...

> +	if (!ret)
> +		__raw_writel(0, priv->host_regs + PATA_IMX_ATA_INT_EN);
[...]
> +static int pata_imx_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ata_host *host = platform_get_drvdata(pdev);

    Just use dev_get_drvdata().

> +	struct pata_imx_priv *priv = host->private_data;
[...]

WBR, Sergei
