From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v7 02/15] ahci-platform: Add support for devices with more
 then 1 clock
Date: Mon, 03 Mar 2014 18:40:04 +0100
Message-ID: <1913842.kQBYcblUGT@amdc1032>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
 <1393084424-31099-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48789 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925AbaCCRkV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2014 12:40:21 -0500
In-reply-to: <1393084424-31099-3-git-send-email-hdegoede@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Oliver Schinagl <oliver@schinagl.nl>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com


Hi,

On Saturday, February 22, 2014 04:53:31 PM Hans de Goede wrote:
> The allwinner-sun4i AHCI controller needs 2 clocks to be enabled and the
> imx AHCI controller needs 3 clocks to be enabled.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
>  drivers/ata/ahci.h                                 |   3 +-
>  drivers/ata/ahci_platform.c                        | 119 ++++++++++++++++-----
>  include/linux/ahci_platform.h                      |   4 +
>  4 files changed, 99 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index 89de156..3ced07d 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -10,6 +10,7 @@ Required properties:
>  
>  Optional properties:
>  - dma-coherent      : Present if dma operations are coherent
> +- clocks            : a list of phandle + clock specifier pairs
>  
>  Example:
>          sata@ffe08000 {
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 64d1a99..c12862b 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -51,6 +51,7 @@
>  
>  enum {
>  	AHCI_MAX_PORTS		= 32,
> +	AHCI_MAX_CLKS		= 3,
>  	AHCI_MAX_SG		= 168, /* hardware max is 64K */
>  	AHCI_DMA_BOUNDARY	= 0xffffffff,
>  	AHCI_MAX_CMDS		= 32,
> @@ -321,7 +322,7 @@ struct ahci_host_priv {
>  	u32 			em_loc; /* enclosure management location */
>  	u32			em_buf_sz;	/* EM buffer size in byte */
>  	u32			em_msg_type;	/* EM message type */
> -	struct clk		*clk;		/* Only for platforms supporting clk */
> +	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
>  	void			*plat_data;	/* Other platform data */
>  	/*
>  	 * Optional ahci_start_engine override, if not set this gets set to the
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 4b231ba..609975d 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -87,6 +87,66 @@ static struct scsi_host_template ahci_platform_sht = {
>  	AHCI_SHT("ahci_platform"),
>  };
>  
> +/**
> + *	ahci_platform_enable_clks - Enable platform clocks
> + *	@hpriv: host private area to store config values
> + *
> + *	This function enables all the clks found in hpriv->clks, starting
> + *	at index 0. If any clk fails to enable it disables all the clks
> + *	already enabled in reverse order, and then returns an error.
> + *
> + *	LOCKING:
> + *	None.
> + *
> + *	RETURNS:
> + *	0 on success otherwise a negative error code
> + */
> +int ahci_platform_enable_clks(struct ahci_host_priv *hpriv)
> +{
> +	int c, rc;
> +
> +	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++) {
> +		rc = clk_prepare_enable(hpriv->clks[c]);
> +		if (rc)
> +			goto disable_unprepare_clk;
> +	}
> +	return 0;
> +
> +disable_unprepare_clk:
> +	while (--c >= 0)
> +		clk_disable_unprepare(hpriv->clks[c]);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
> +
> +/**
> + *	ahci_platform_disable_clks - Disable platform clocks
> + *	@hpriv: host private area to store config values
> + *
> + *	This function disables all the clks found in hpriv->clks, in reverse
> + *	order of ahci_platform_enable_clks (starting at the end of the array).
> + *
> + *	LOCKING:
> + *	None.
> + */
> +void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
> +{
> +	int c;
> +
> +	for (c = AHCI_MAX_CLKS - 1; c >= 0; c--)
> +		if (hpriv->clks[c])
> +			clk_disable_unprepare(hpriv->clks[c]);
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
> +
> +static void ahci_put_clks(struct ahci_host_priv *hpriv)
> +{
> +	int c;
> +
> +	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
> +		clk_put(hpriv->clks[c]);
> +}
> +
>  static int ahci_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -97,6 +157,7 @@ static int ahci_probe(struct platform_device *pdev)
>  	struct ahci_host_priv *hpriv;
>  	struct ata_host *host;
>  	struct resource *mem;
> +	struct clk *clk;
>  	int irq;
>  	int n_ports;
>  	int i;
> @@ -131,17 +192,31 @@ static int ahci_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	hpriv->clk = clk_get(dev, NULL);
> -	if (IS_ERR(hpriv->clk)) {
> -		dev_err(dev, "can't get clock\n");
> -	} else {
> -		rc = clk_prepare_enable(hpriv->clk);
> -		if (rc) {
> -			dev_err(dev, "clock prepare enable failed");
> -			goto free_clk;
> +	for (i = 0; i < AHCI_MAX_CLKS; i++) {
> +		/*
> +		 * For now we must use clk_get(dev, NULL) for the first clock,
> +		 * because some platforms (da850, spear13xx) are not yet
> +		 * converted to use devicetree for clocks.  For new platforms
> +		 * this is equivalent to of_clk_get(dev->of_node, 0).
> +		 */
> +		if (i == 0)
> +			clk = clk_get(dev, NULL);
> +		else
> +			clk = of_clk_get(dev->of_node, i);
> +
> +		if (IS_ERR(clk)) {
> +			rc = PTR_ERR(clk);
> +			if (rc == -EPROBE_DEFER)
> +				goto free_clk;
> +			break;
>  		}
> +		hpriv->clks[i] = clk;
>  	}
>  
> +	rc = ahci_enable_clks(dev, hpriv);

This should be ahci_platform_enable_clks().

> +	if (rc)
> +		goto free_clk;
> +
>  	/*
>  	 * Some platforms might need to prepare for mmio region access,
>  	 * which could be done in the following init call. So, the mmio
> @@ -222,11 +297,9 @@ pdata_exit:
>  	if (pdata && pdata->exit)
>  		pdata->exit(dev);
>  disable_unprepare_clk:
> -	if (!IS_ERR(hpriv->clk))
> -		clk_disable_unprepare(hpriv->clk);
> +	ahci_disable_clks(hpriv);

ahci_platform_disable_clks()

>  free_clk:
> -	if (!IS_ERR(hpriv->clk))
> -		clk_put(hpriv->clk);
> +	ahci_put_clks(hpriv);
>  	return rc;
>  }
>  
> @@ -239,10 +312,8 @@ static void ahci_host_stop(struct ata_host *host)
>  	if (pdata && pdata->exit)
>  		pdata->exit(dev);
>  
> -	if (!IS_ERR(hpriv->clk)) {
> -		clk_disable_unprepare(hpriv->clk);
> -		clk_put(hpriv->clk);
> -	}
> +	ahci_disable_clks(hpriv);

ahci_platform_disable_clks()

> +	ahci_put_clks(hpriv);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -277,8 +348,7 @@ static int ahci_suspend(struct device *dev)
>  	if (pdata && pdata->suspend)
>  		return pdata->suspend(dev);
>  
> -	if (!IS_ERR(hpriv->clk))
> -		clk_disable_unprepare(hpriv->clk);
> +	ahci_disable_clks(hpriv);

ahci_platform_disable_clks()

>  	return 0;
>  }
> @@ -290,13 +360,9 @@ static int ahci_resume(struct device *dev)
>  	struct ahci_host_priv *hpriv = host->private_data;
>  	int rc;
>  
> -	if (!IS_ERR(hpriv->clk)) {
> -		rc = clk_prepare_enable(hpriv->clk);
> -		if (rc) {
> -			dev_err(dev, "clock prepare enable failed");
> -			return rc;
> -		}
> -	}
> +	rc = ahci_enable_clks(dev, hpriv);

ahci_platform_enable_clks()

> +	if (rc)
> +		return rc;
>  
>  	if (pdata && pdata->resume) {
>  		rc = pdata->resume(dev);
> @@ -317,8 +383,7 @@ static int ahci_resume(struct device *dev)
>  	return 0;
>  
>  disable_unprepare_clk:
> -	if (!IS_ERR(hpriv->clk))
> -		clk_disable_unprepare(hpriv->clk);
> +	ahci_disable_clks(hpriv);

ahci_platform_disable_clks()

[...]

All code in question gets rewritten in patch #4/15 so the actual
problem is the broken bisectability between patch #2 and #4.

It seems too late to fix it now but in the future please remember
to build-test each patch separately (in addition to testing the whole
patchset).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

