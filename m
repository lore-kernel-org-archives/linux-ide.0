From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [v1] ahci: imx: setup power saving methods
Date: Sun, 29 Sep 2013 15:33:00 +0800
Message-ID: <20130929073257.GD26156@S2101-09.ap.freescale.net>
References: <1380269265-10821-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:32471
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709Ab3I2Hc0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Sep 2013 03:32:26 -0400
Content-Disposition: inline
In-Reply-To: <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Fri, Sep 27, 2013 at 04:07:45PM +0800, Richard Zhu wrote:
> From: Richard Zhu <r65037@freescale.com>
> 
> In order to save power consumption amap.
> * Disable sata phy internal pll reference clock when
> sysetem enter into suspend mode, enable it after resume.
> * Enter into test power down mode when there is no sata disk
> detected on the port and 'AHCI_IMX_PHY_POWER_DOWN_MODE' is
> enabled.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  drivers/ata/Kconfig    |    8 +++++
>  drivers/ata/ahci_imx.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 4e73772..84b09f0 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -106,6 +106,14 @@ config AHCI_IMX
>  
>  	  If unsure, say N.
>  
> +config AHCI_IMX_PHY_POWER_DOWN_MODE
> +	bool "Power saving mode when there is no SATA DEV detected on the port"
> +	depends on AHCI_IMX
> +	help
> +	  This option enable the power down mode of the imx ahci when there is
> +	  no sata device detected on the port, the sata port wouldn't be
> +	  functional anymore except one system power down, and power up again.
> +
>  config SATA_FSL
>  	tristate "Freescale 3.0Gbps SATA support"
>  	depends on FSL_SOC
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 58debb0..c15dade 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -1,6 +1,6 @@
>  /*
> + * copyright (c) 2013 Freescale Semiconductor, Inc.
>   * Freescale IMX AHCI SATA platform driver
> - * Copyright 2013 Freescale Semiconductor, Inc.
>   *
>   * based on the AHCI SATA platform driver by Jeff Garzik and Anton Vorontsov
>   *
> @@ -28,6 +28,10 @@
>  #include "ahci.h"
>  
>  enum {
> +	/* Port0 PHY Control */
> +	PORT_PHY_CTL = 0x178,
> +	/* PORT_PHY_CTL bits */
> +	PORT_PHY_CTL_PDDQ_LOC = 0x100000,
>  	HOST_TIMER1MS = 0xe0, /* Timer 1-ms */
>  };
>  
> @@ -36,12 +40,13 @@ struct imx_ahci_priv {
>  	struct clk *sata_ref_clk;
>  	struct clk *ahb_clk;
>  	struct regmap *gpr;
> +	bool no_device;
>  };
>  
>  static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
>  {
> -	int ret = 0;
> -	unsigned int reg_val;
> +	int ret = 0, iterations = 200;
> +	u32 reg_val, sstatus;

I think the following is less diff stat and easier to understand.

	int ret = 0;
+	int iterations = 200;
	unsigned int reg_val;
+	u32 sstatus;

>  	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
>  
>  	imxpriv->gpr =
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

dev_info

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

This else block can just be saved, since imxpriv is allocated by
devm_kzalloc() which already clears the structure?

> +
>  	return 0;
>  }
>  
> @@ -117,9 +152,46 @@ static void imx6q_sata_exit(struct device *dev)
>  	clk_disable_unprepare(imxpriv->sata_ref_clk);
>  }
>  
> +static int imx_ahci_suspend(struct device *dev)
> +{
> +	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
> +
> +	if (!(imxpriv->no_device)) {

'if (!imxpriv->no_device)' is good enough.

> +		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +				!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +		clk_disable_unprepare(imxpriv->sata_ref_clk);
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_ahci_resume(struct device *dev)
> +{
> +	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
> +	int ret;
> +
> +	if (!(imxpriv->no_device)) {

Ditto

> +		ret = clk_prepare_enable(imxpriv->sata_ref_clk);
> +		if (ret < 0) {
> +			dev_err(dev, "pre-enable sata_ref clock err:%d\n", ret);

Word 'pre-enable' is confusing, and 'enable' is fine.

Shawn

> +			return ret;
> +		}
> +
> +		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +				IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +		usleep_range(1000, 2000);
> +	}
> +
> +	return 0;
> +}
> +
>  static struct ahci_platform_data imx6q_sata_pdata = {
>  	.init = imx6q_sata_init,
>  	.exit = imx6q_sata_exit,
> +	.suspend = imx_ahci_suspend,
> +	.resume = imx_ahci_resume,
>  };
>  
>  static const struct of_device_id imx_ahci_of_match[] = {
> -- 
> 1.7.5.4
> 

