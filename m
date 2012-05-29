From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 02/15] ata: Use clk_prepare_enable/clk_disable_unprepare
Date: Tue, 29 May 2012 11:17:21 +0200
Message-ID: <20120529091721.GF30400@pengutronix.de>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
 <1337987696-31728-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42313 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab2E2JR3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 May 2012 05:17:29 -0400
Content-Disposition: inline
In-Reply-To: <1337987696-31728-2-git-send-email-festevam@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de, shawn.guo@freescale.com, Fabio Estevam <fabio.estevam@freescale.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Fri, May 25, 2012 at 08:14:43PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Prepare the clock before enabling it.
> 
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: <linux-ide@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


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
