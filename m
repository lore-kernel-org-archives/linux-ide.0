From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V3 1/5] ahci: imx: Pull out the clock enable/disable calls
Date: Tue, 19 Nov 2013 16:26:21 +0800
Message-ID: <20131119082619.GA18481@S2101-09.ap.freescale.net>
References: <1384785043-5027-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:53706
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751592Ab3KSIYf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Nov 2013 03:24:35 -0500
Content-Disposition: inline
In-Reply-To: <1384785043-5027-1-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Mon, Nov 18, 2013 at 03:30:39PM +0100, Marek Vasut wrote:
> The same code for enabling and disabling SATA clock was found in multiple
> places in the driver. Implement functions that enable/disable the SATA clock
> and use them in such places instead of duplicating the code.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>
> ---
>  drivers/ata/ahci_imx.c | 134 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 76 insertions(+), 58 deletions(-)
> 
> V2: Move the OR sign from the begining of the line to the end of the line in
>     the regmap_update_bits() call.
> V3: Move the PHY configuration programming out of the clock_enable function and
>     into the probe() function.
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index ae2d73f..b36f96c 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -47,6 +47,40 @@ static int ahci_imx_hotplug;
>  module_param_named(hotplug, ahci_imx_hotplug, int, 0644);
>  MODULE_PARM_DESC(hotplug, "AHCI IMX hot-plug support (0=Don't support, 1=support)");
>  
> +static int imx_sata_clock_enable(struct device *dev)
> +{
> +	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
> +	int ret;
> +
> +	ret = clk_prepare_enable(imxpriv->sata_ref_clk);
> +	if (ret < 0) {
> +		dev_err(dev, "prepare-enable sata_ref clock err:%d\n", ret);
> +		return ret;
> +	}
> +
> +	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +			   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +			   IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +
> +	ret = clk_prepare_enable(imxpriv->sata_ref_clk);

Why calling it twice?

> +	if (ret < 0) {
> +		dev_err(dev, "prepare-enable sata_ref clock err:%d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void imx_sata_clock_disable(struct device *dev)
> +{
> +	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
> +
> +	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +			   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +			   !IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +	clk_disable_unprepare(imxpriv->sata_ref_clk);
> +}
> +
>  static void ahci_imx_error_handler(struct ata_port *ap)
>  {
>  	u32 reg_val;
> @@ -72,10 +106,7 @@ static void ahci_imx_error_handler(struct ata_port *ap)
>  	 */
>  	reg_val = readl(mmio + PORT_PHY_CTL);
>  	writel(reg_val | PORT_PHY_CTL_PDDQ_LOC, mmio + PORT_PHY_CTL);
> -	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> -			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> -			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> -	clk_disable_unprepare(imxpriv->sata_ref_clk);
> +	imx_sata_clock_disable(ap->dev);
>  	imxpriv->no_device = true;
>  }
>  
> @@ -97,44 +128,10 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
>  	unsigned int reg_val;
>  	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
>  
> -	imxpriv->gpr =
> -		syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> -	if (IS_ERR(imxpriv->gpr)) {
> -		dev_err(dev, "failed to find fsl,imx6q-iomux-gpr regmap\n");
> -		return PTR_ERR(imxpriv->gpr);
> -	}
> -
> -	ret = clk_prepare_enable(imxpriv->sata_ref_clk);
> -	if (ret < 0) {
> -		dev_err(dev, "prepare-enable sata_ref clock err:%d\n", ret);
> +	ret = imx_sata_clock_enable(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
> -	/*
> -	 * set PHY Paremeters, two steps to configure the GPR13,
> -	 * one write for rest of parameters, mask of first write
> -	 * is 0x07fffffd, and the other one write for setting
> -	 * the mpll_clk_en.
> -	 */
> -	regmap_update_bits(imxpriv->gpr, 0x34, IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK
> -			| IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK
> -			| IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK
> -			| IMX6Q_GPR13_SATA_SPD_MODE_MASK
> -			| IMX6Q_GPR13_SATA_MPLL_SS_EN
> -			| IMX6Q_GPR13_SATA_TX_ATTEN_MASK
> -			| IMX6Q_GPR13_SATA_TX_BOOST_MASK
> -			| IMX6Q_GPR13_SATA_TX_LVL_MASK
> -			| IMX6Q_GPR13_SATA_TX_EDGE_RATE
> -			, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB
> -			| IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M
> -			| IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F
> -			| IMX6Q_GPR13_SATA_SPD_MODE_3P0G
> -			| IMX6Q_GPR13_SATA_MPLL_SS_EN
> -			| IMX6Q_GPR13_SATA_TX_ATTEN_9_16
> -			| IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB
> -			| IMX6Q_GPR13_SATA_TX_LVL_1_025_V);
> -	regmap_update_bits(imxpriv->gpr, 0x34, IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> -			IMX6Q_GPR13_SATA_MPLL_CLK_EN);
>  	usleep_range(100, 200);

Again, can this usleep_range() call be moved into imx_sata_clock_enable()
together?

Shawn

>  
>  	/*
> @@ -163,11 +160,7 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
>  
>  static void imx6q_sata_exit(struct device *dev)
>  {
> -	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
> -
> -	regmap_update_bits(imxpriv->gpr, 0x34, IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> -			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> -	clk_disable_unprepare(imxpriv->sata_ref_clk);
> +	imx_sata_clock_disable(dev);
>  }
>  
>  static int imx_ahci_suspend(struct device *dev)
> @@ -178,12 +171,8 @@ static int imx_ahci_suspend(struct device *dev)
>  	 * If no_device is set, The CLKs had been gated off in the
>  	 * initialization so don't do it again here.
>  	 */
> -	if (!imxpriv->no_device) {
> -		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> -				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> -				!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> -		clk_disable_unprepare(imxpriv->sata_ref_clk);
> -	}
> +	if (!imxpriv->no_device)
> +		imx_sata_clock_disable(dev);
>  
>  	return 0;
>  }
> @@ -194,15 +183,10 @@ static int imx_ahci_resume(struct device *dev)
>  	int ret;
>  
>  	if (!imxpriv->no_device) {
> -		ret = clk_prepare_enable(imxpriv->sata_ref_clk);
> -		if (ret < 0) {
> -			dev_err(dev, "pre-enable sata_ref clock err:%d\n", ret);
> +		ret = imx_sata_clock_enable(dev);
> +		if (ret < 0)
>  			return ret;
> -		}
>  
> -		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> -				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> -				IMX6Q_GPR13_SATA_MPLL_CLK_EN);
>  		usleep_range(1000, 2000);
>  	}
>  
> @@ -289,6 +273,40 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  	ahci_dev->dma_mask = &ahci_dev->coherent_dma_mask;
>  	ahci_dev->of_node = dev->of_node;
>  
> +	imxpriv->gpr =
> +		syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +
> +	if (IS_ERR(imxpriv->gpr)) {
> +		dev_err(dev, "failed to find fsl,imx6q-iomux-gpr regmap\n");
> +		ret = PTR_ERR(imxpriv->gpr);
> +		goto err_out;
> +	}
> +
> +	/*
> +	 * Set PHY Paremeters, two steps to configure the GPR13,
> +	 * one write for rest of parameters, mask of first write
> +	 * is 0x07fffffd, and the other one write for setting
> +	 * the mpll_clk_en happens in imx_sata_clock_enable().
> +	 */
> +	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +			   IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK |
> +			   IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK |
> +			   IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK |
> +			   IMX6Q_GPR13_SATA_SPD_MODE_MASK |
> +			   IMX6Q_GPR13_SATA_MPLL_SS_EN |
> +			   IMX6Q_GPR13_SATA_TX_ATTEN_MASK |
> +			   IMX6Q_GPR13_SATA_TX_BOOST_MASK |
> +			   IMX6Q_GPR13_SATA_TX_LVL_MASK |
> +			   IMX6Q_GPR13_SATA_TX_EDGE_RATE,
> +			   IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB |
> +			   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
> +			   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
> +			   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
> +			   IMX6Q_GPR13_SATA_MPLL_SS_EN |
> +			   IMX6Q_GPR13_SATA_TX_ATTEN_9_16 |
> +			   IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB |
> +			   IMX6Q_GPR13_SATA_TX_LVL_1_025_V);
> +
>  	ret = platform_device_add_resources(ahci_pdev, res, 2);
>  	if (ret)
>  		goto err_out;
> -- 
> 1.8.4.2
> 

