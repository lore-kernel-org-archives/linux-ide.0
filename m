From: Tejun Heo <tj@kernel.org>
Subject: Re: [v3] ahci: imx: setup power saving methods
Date: Sun, 13 Oct 2013 16:16:34 -0400
Message-ID: <20131013201634.GF18075@htj.dyndns.org>
References: <1381487831-30090-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1381487831-30090-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:46315 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab3JMUQh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Oct 2013 16:16:37 -0400
Received: by mail-qa0-f49.google.com with SMTP id i13so1969076qae.1
        for <linux-ide@vger.kernel.org>; Sun, 13 Oct 2013 13:16:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381487831-30090-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

Hello,

On Fri, Oct 11, 2013 at 06:37:11PM +0800, Richard Zhu wrote:
> @@ -1,6 +1,6 @@
>  /*
> + * copyright (c) 2013 Freescale Semiconductor, Inc.
>   * Freescale IMX AHCI SATA platform driver
> - * Copyright 2013 Freescale Semiconductor, Inc.

Forgot to mention the above in the commit message?

> +static void ahci_imx_error_handler(struct ata_port *ap);
> +static void ahci_host_stop(struct ata_host *host);

Please put the ops definition below the function defs so that the
above aren't necessary.

> +static void ahci_imx_error_handler(struct ata_port *ap)
> +{
> +	u32 reg_val;
> +	struct ata_device *dev;
> +	struct ata_host *host = dev_get_drvdata(ap->dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	void __iomem *mmio = hpriv->mmio;
> +	struct imx_ahci_priv *imxpriv = dev_get_drvdata(ap->dev->parent);
> +
> +	/* wrapper of the ahci_error_handler */
> +	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
> +		/* restart engine */
> +		ahci_stop_engine(ap);
> +		ahci_start_engine(ap);
> +	}

Please export ahci_error_handler() and use that instead of duplicating
this part.

> +
> +	sata_pmp_error_handler(ap);
> +
> +	if (!ata_dev_enabled(ap->link.device))
> +		ahci_stop_engine(ap);
> +	/* end of wrapper */
> +
> +	if (!(imxpriv->first_time) || ahci_imx_hotplug)
> +		return;
> +
> +	imxpriv->first_time = false;
> +
> +	ata_for_each_dev(dev, &ap->link, ENABLED)
> +		return;
> +	/* DISABLE LINK to save power consumption */

A bit more explanation would be nice.  ie. briefly explain why it
can't be part of usual LPM.

> +	reg_val = readl(mmio + PORT_PHY_CTL);
> +	writel(reg_val | PORT_PHY_CTL_PDDQ_LOC, mmio + PORT_PHY_CTL);
> +	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +	clk_disable_unprepare(imxpriv->sata_ref_clk);
> +	imxpriv->no_device = true;
> +}
> +
> +static void ahci_host_stop(struct ata_host *host)
> +{
> +	struct device *dev = host->dev;
> +	struct ahci_platform_data *pdata = dev_get_platdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +
> +	if (pdata && pdata->exit)
> +		pdata->exit(dev);
> +
> +	if (!IS_ERR(hpriv->clk)) {
> +		clk_disable_unprepare(hpriv->clk);
> +		clk_put(hpriv->clk);
> +	}
> +}

Please do not duplicate functions like this.  Why not export and
inherit from ahci_platform_ops?

>  static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
>  {
>  	int ret = 0;
> -	unsigned int reg_val;
> +	u32 reg_val;

Hah?  Why is this chunk in this patch?

> +static int imx_ahci_suspend(struct device *dev)
> +{
> +	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
> +
> +	if (!(imxpriv->no_device)) {

Please lose the unnecessary parantheses.

> +		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +				!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +		clk_disable_unprepare(imxpriv->sata_ref_clk);
> +	}

Some comment of what's going on would be nice.

Other than the above, looks good to me.

Thanks.

-- 
tejun
