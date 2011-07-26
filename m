From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [patch v3 1/1] ata: Add iMX pata support
Date: Tue, 26 Jul 2011 09:39:11 +0200
Message-ID: <20110726073911.GG20587@pengutronix.de>
References: <20110724183805.992906251@rtp-net.org>
 <20110724183823.420642781@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44972 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab1GZHjQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2011 03:39:16 -0400
Content-Disposition: inline
In-Reply-To: <20110724183823.420642781@rtp-net.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hi Arnaud,

On Sun, Jul 24, 2011 at 08:38:07PM +0200, Arnaud Patard wrote:
> Add basic support for pata on iMX. It has been tested only on imx51.
> SDMA support will probably be added later so this version supports only
> PIO.
> 
> v2:
>   - enable only when needed IORDY
>   - use dev_get_drvdata
> v3:
>   - add missing clk_put() calls
>   - use platform_get_irq()
>   - fix resume code to avoid disabling IORDY on resume
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6-submit/drivers/ata/Kconfig
> ===================================================================
> --- linux-2.6-submit.orig/drivers/ata/Kconfig	2011-07-22 23:29:06.000000000 +0200
> +++ linux-2.6-submit/drivers/ata/Kconfig	2011-07-22 23:30:58.000000000 +0200
> @@ -467,6 +467,15 @@ config PATA_ICSIDE
>  	  interface card.  This is not required for ICS partition support.
>  	  If you are unsure, say N to this.
>  
> +config PATA_IMX
> +	tristate "PATA support for Freescale iMX (Experimental)"
> +	depends on ARCH_MX5 && EXPERIMENTAL

Should this really depend on EXPERIMENTAL? This driver looks pretty
straightforward.

Also, please depend on ARCH_MXC instead. This may make this driver
selectable on some i.MX SoCs which do not support it, but we don't
have to add new ARCH_MX* to this list once a new SoC is supported.

(And no, IMX_HAVE_PLATFORM_BLA_BLA is not a good idea either as we are
converting to the device tree and the Kconfig entries will probably go
in the longer run)


> +
> +static int __devinit pata_imx_probe(struct platform_device *pdev)
> +{
> +	struct ata_host *host;
> +	struct ata_port *ap;
> +	struct pata_imx_priv *priv;
> +	int irq = 0;
> +	struct resource *io_res;
> +
> +	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (io_res == NULL)
> +		return -EINVAL;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0)
> +		return -EINVAL;
> +
> +	priv = kzalloc(sizeof(struct pata_imx_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;

Given that you already use devm_ioremap, you can also use devm_kzalloc
here.

> +
> +	priv->clk = clk_get(&pdev->dev, "imx-pata");
> +	if (!priv->clk)

IS_ERR(priv->clk)

(also for the checks below)

Does it really make sense to continue when the clock failed?

> +		dev_warn(&pdev->dev, "Failed to get clock\n");
> +	else
> +		clk_enable(priv->clk);
> +
> +
> +	host = ata_host_alloc(&pdev->dev, 1);
> +	if (!host)
> +		goto free_priv;
> +
> +	host->private_data = priv;
> +	ap = host->ports[0];
> +
> +	ap->ops = &pata_imx_port_ops;
> +	ap->pio_mask = ATA_PIO0;
> +	ap->flags |= ATA_FLAG_SLAVE_POSS;
> +
> +	priv->host_regs = devm_ioremap(&pdev->dev, io_res->start, 0x40);

resource_size() instead of hardcoded 0x40?

> +	ap->ioaddr.cmd_addr = devm_ioremap(&pdev->dev,
> +					io_res->start + PATA_IMX_DRIVE_DATA,
> +					0x20);
> +	ap->ioaddr.ctl_addr = devm_ioremap(&pdev->dev,
> +					io_res->start + PATA_IMX_DRIVE_CONTROL,
> +					0x04);

It looks strange to ioremap the register offsets again. Why not just a

	ap->ioaddr.cmd_addr = priv->host_regs + PATA_IMX_DRIVE_DATA
	ap->ioaddr.ctl_addr = priv->host_regs + PATA_IMX_DRIVE_CONTROL

Hm, probably copied from the pxa driver, but this uses different
resources which makes different ioremaps necessary.

> +	if (!priv->host_regs || !ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr) {
> +		dev_err(&pdev->dev, "failed to map IO/CTL base\n");
> +		goto free_priv;
> +	}
> +
> +	ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
> +
> +
> +	pata_imx_setup_port(&ap->ioaddr);
> +
> +	ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
> +		(unsigned long long)io_res->start + PATA_IMX_DRIVE_DATA,
> +		(unsigned long long)io_res->start + PATA_IMX_DRIVE_CONTROL);
> +
> +	/* deassert resets */
> +	__raw_writel(PATA_IMX_ATA_CTRL_FIFO_RST_B |
> +			PATA_IMX_ATA_CTRL_ATA_RST_B,
> +			priv->host_regs + PATA_IMX_ATA_CONTROL);
> +	/* enable interrupts */
> +	__raw_writel(PATA_IMX_ATA_INTR_ATA_INTRQ2,
> +			priv->host_regs + PATA_IMX_ATA_INT_EN);
> +
> +	/* activate */
> +	return ata_host_activate(host, irq, ata_sff_interrupt, 0,
> +				&pata_imx_sht);
> +
> +free_priv:
> +	if (priv->clk) {
> +		clk_disable(priv->clk);
> +		clk_put(priv->clk);
> +	}
> +	kfree(priv);
> +	return -ENOMEM;
> +}
> +

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
