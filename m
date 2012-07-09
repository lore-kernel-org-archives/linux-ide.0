From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ata: pata_imx: Convert to
 clk_prepare_enable/clk_disable_unprepare
Date: Mon, 9 Jul 2012 08:41:36 +0200
Message-ID: <20120709064136.GJ30009@pengutronix.de>
References: <1341700445-11979-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52115 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab2GIGlp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2012 02:41:45 -0400
Content-Disposition: inline
In-Reply-To: <1341700445-11979-1-git-send-email-festevam@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: jgarzik@pobox.com, arnaud.patard@rtp-net.org, kernel@pengutronix.de, linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Sat, Jul 07, 2012 at 07:34:05PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> With the new i.mx clock framework, we need to use clk_prepare_enable/clk_disable_unprepare.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/ata/pata_imx.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
> index c5af97f..87bb05b 100644
> --- a/drivers/ata/pata_imx.c
> +++ b/drivers/ata/pata_imx.c
> @@ -118,7 +118,7 @@ static int __devinit pata_imx_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->clk);
>  	}
>  
> -	clk_enable(priv->clk);
> +	clk_prepare_enable(priv->clk);
>  
>  	host = ata_host_alloc(&pdev->dev, 1);
>  	if (!host)
> @@ -162,7 +162,7 @@ static int __devinit pata_imx_probe(struct platform_device *pdev)
>  				&pata_imx_sht);
>  
>  free_priv:
> -	clk_disable(priv->clk);
> +	clk_disable_unprepare(priv->clk);
>  	clk_put(priv->clk);
>  	return -ENOMEM;
>  }
> @@ -176,7 +176,7 @@ static int __devexit pata_imx_remove(struct platform_device *pdev)
>  
>  	__raw_writel(0, priv->host_regs + PATA_IMX_ATA_INT_EN);
>  
> -	clk_disable(priv->clk);
> +	clk_disable_unprepare(priv->clk);
>  	clk_put(priv->clk);
>  
>  	return 0;
> @@ -194,7 +194,7 @@ static int pata_imx_suspend(struct device *dev)
>  		__raw_writel(0, priv->host_regs + PATA_IMX_ATA_INT_EN);
>  		priv->ata_ctl =
>  			__raw_readl(priv->host_regs + PATA_IMX_ATA_CONTROL);
> -		clk_disable(priv->clk);
> +		clk_disable_unprepare(priv->clk);
>  	}
>  
>  	return ret;
> @@ -205,7 +205,7 @@ static int pata_imx_resume(struct device *dev)
>  	struct ata_host *host = dev_get_drvdata(dev);
>  	struct pata_imx_priv *priv = host->private_data;
>  
> -	clk_enable(priv->clk);
> +	clk_prepare_enable(priv->clk);
>  
>  	__raw_writel(priv->ata_ctl, priv->host_regs + PATA_IMX_ATA_CONTROL);
>  
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
