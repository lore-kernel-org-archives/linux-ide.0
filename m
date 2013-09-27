From: Tejun Heo <tj@kernel.org>
Subject: Re: [v1] ahci: imx: setup power saving methods
Date: Fri, 27 Sep 2013 09:14:41 -0400
Message-ID: <20130927131441.GA3205@htj.dyndns.org>
References: <1380269265-10821-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:34691 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab3I0NOq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Sep 2013 09:14:46 -0400
Received: by mail-qa0-f41.google.com with SMTP id ii20so449557qab.7
        for <linux-ide@vger.kernel.org>; Fri, 27 Sep 2013 06:14:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

Hello,

On Fri, Sep 27, 2013 at 04:07:45PM +0800, Richard Zhu wrote:
> +config AHCI_IMX_PHY_POWER_DOWN_MODE
> +	bool "Power saving mode when there is no SATA DEV detected on the port"
> +	depends on AHCI_IMX
> +	help
> +	  This option enable the power down mode of the imx ahci when there is
> +	  no sata device detected on the port, the sata port wouldn't be
> +	  functional anymore except one system power down, and power up again.

The last part of the sentence is a bit difficult to understand.  Also,
I'm not sure whether making this a build option is a good idea.
Please read on.

> @@ -105,6 +110,36 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
>  	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
>  	writel(reg_val, mmio + HOST_TIMER1MS);
>  
> +	if (IS_ENABLED(CONFIG_AHCI_IMX_PHY_POWER_DOWN_MODE)) {
> +		/*
> +		 * In order to save power consumption, enter PDDQ mode
> +		 * when there is no device detected on the port
> +		 */
> +		do {
> +			sstatus = readl(mmio + 0x100 + PORT_SCR_STAT);
> +			if ((sstatus & 0xF) == 0)
> +				usleep_range(1000, 2000);
> +			else
> +				break;
> +
> +			if (iterations == 0) {
> +				pr_info("No sata disk.\n");
> +				reg_val = readl(mmio + PORT_PHY_CTL);
> +				writel(reg_val | PORT_PHY_CTL_PDDQ_LOC,
> +						mmio + PORT_PHY_CTL);
> +				regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +						IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +						!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +				clk_disable_unprepare(imxpriv->sata_ref_clk);
> +				imxpriv->no_device = 1;
> +
> +				return 0;
> +			}
> +		} while (iterations-- > 0);
> +	} else {
> +		imxpriv->no_device = 0;
> +	}

This looks like it really should be part of lpm framework.  Allow the
ahci_platform driver to override set_lpm() and turning off PHY if
MIN_POWER && !dev should work, right?

Thanks.

-- 
tejun
