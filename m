From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V3 2/5] ahci: imx: Add i.MX53 support
Date: Tue, 19 Nov 2013 16:48:16 +0800
Message-ID: <20131119084814.GB18481@S2101-09.ap.freescale.net>
References: <1384785043-5027-1-git-send-email-marex@denx.de>
 <1384785043-5027-2-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:2507
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751358Ab3KSIqZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Nov 2013 03:46:25 -0500
Content-Disposition: inline
In-Reply-To: <1384785043-5027-2-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Mon, Nov 18, 2013 at 03:30:40PM +0100, Marek Vasut wrote:
> Add minor adjustments to support i.MX53 SATA port as well as i.MX6Q one.
> The difference here is mostly the clock which need to be enabled and also
> the lack of need of programming IOMUXC registers on i.MX53. All of which
> is well handles in the clock enable/disable functions. Note that this patch
> also cleans up the names of the common functions, so they don't read imx6q_*
> but imx_* instead.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>
> ---
>  drivers/ata/ahci_imx.c | 191 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 121 insertions(+), 70 deletions(-)
> 
> V2: Rebase this patch to be coherent with formating change in 1/5 .
> V3: Rebase this patch to be coherent with change in 1/5 .
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index b36f96c..8e4b4a9 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -34,10 +34,23 @@ enum {
>  	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
>  };
>  
> +enum ahci_imx_type {
> +	AHCI_IMX53,
> +	AHCI_IMX6Q,
> +};
> +
>  struct imx_ahci_priv {
>  	struct platform_device *ahci_pdev;
> +	enum ahci_imx_type type;
> +
> +	/* i.MX53 clock */
> +	struct clk *sata_gate_clk;
> +	struct clk *sata_phy_clk;
> +	/* i.MX6Q clock */
>  	struct clk *sata_ref_clk;

I think sata_ref_clk on imx6q and sata_phy_clk on imx53 are both the
clock for SATA PHY, so they are the same clock?

Shawn

> +	/* Common clock */
>  	struct clk *ahb_clk;
> +
>  	struct regmap *gpr;
>  	bool no_device;
>  	bool first_time;
> @@ -52,20 +65,32 @@ static int imx_sata_clock_enable(struct device *dev)
>  	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
>  	int ret;
>  
> -	ret = clk_prepare_enable(imxpriv->sata_ref_clk);
> -	if (ret < 0) {
> -		dev_err(dev, "prepare-enable sata_ref clock err:%d\n", ret);
> -		return ret;
> -	}
> +	if (imxpriv->type == AHCI_IMX53) {
> +		ret = clk_prepare_enable(imxpriv->sata_gate_clk);
> +		if (ret < 0) {
> +			dev_err(dev, "prepare-enable sata_gate clock err:%d\n",
> +				ret);
> +			return ret;
> +		}
>  
> -	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> -			   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> -			   IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +		ret = clk_prepare_enable(imxpriv->sata_phy_clk);
> +		if (ret < 0) {
> +			clk_disable_unprepare(imxpriv->sata_gate_clk);
> +			dev_err(dev, "prepare-enable sata_phy clock err:%d\n",
> +				ret);
> +			return ret;
> +		}
> +	} else if (imxpriv->type == AHCI_IMX6Q) {
> +		ret = clk_prepare_enable(imxpriv->sata_ref_clk);
> +		if (ret < 0) {
> +			dev_err(dev, "prepare-enable sata_ref clock err:%d\n",
> +				ret);
> +			return ret;
> +		}
>  
> -	ret = clk_prepare_enable(imxpriv->sata_ref_clk);
> -	if (ret < 0) {
> -		dev_err(dev, "prepare-enable sata_ref clock err:%d\n", ret);
> -		return ret;
> +		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +				   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +				   IMX6Q_GPR13_SATA_MPLL_CLK_EN);
>  	}
>  
>  	return 0;
> @@ -75,10 +100,15 @@ static void imx_sata_clock_disable(struct device *dev)
>  {
>  	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
>  
> -	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> -			   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> -			   !IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> -	clk_disable_unprepare(imxpriv->sata_ref_clk);
> +	if (imxpriv->type == AHCI_IMX53) {
> +		clk_disable_unprepare(imxpriv->sata_phy_clk);
> +		clk_disable_unprepare(imxpriv->sata_gate_clk);
> +	} else if (imxpriv->type == AHCI_IMX6Q) {
> +		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +				   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +				   !IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +		clk_disable_unprepare(imxpriv->sata_ref_clk);
> +	}
>  }
>  
>  static void ahci_imx_error_handler(struct ata_port *ap)
> @@ -122,7 +152,7 @@ static const struct ata_port_info ahci_imx_port_info = {
>  	.port_ops	= &ahci_imx_ops,
>  };
>  
> -static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
> +static int imx_sata_init(struct device *dev, void __iomem *mmio)
>  {
>  	int ret = 0;
>  	unsigned int reg_val;
> @@ -158,7 +188,7 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
>  	return 0;
>  }
>  
> -static void imx6q_sata_exit(struct device *dev)
> +static void imx_sata_exit(struct device *dev)
>  {
>  	imx_sata_clock_disable(dev);
>  }
> @@ -193,16 +223,18 @@ static int imx_ahci_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static struct ahci_platform_data imx6q_sata_pdata = {
> -	.init = imx6q_sata_init,
> -	.exit = imx6q_sata_exit,
> -	.ata_port_info = &ahci_imx_port_info,
> -	.suspend = imx_ahci_suspend,
> -	.resume = imx_ahci_resume,
> +static struct ahci_platform_data imx_sata_pdata = {
> +	.init		= imx_sata_init,
> +	.exit		= imx_sata_exit,
> +	.ata_port_info	= &ahci_imx_port_info,
> +	.suspend	= imx_ahci_suspend,
> +	.resume		= imx_ahci_resume,
> +
>  };
>  
>  static const struct of_device_id imx_ahci_of_match[] = {
> -	{ .compatible = "fsl,imx6q-ahci", .data = &imx6q_sata_pdata},
> +	{ .compatible = "fsl,imx53-ahci", .data = (void *)AHCI_IMX53 },
> +	{ .compatible = "fsl,imx6q-ahci", .data = (void *)AHCI_IMX6Q },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, imx_ahci_of_match);
> @@ -212,12 +244,20 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct resource *mem, *irq, res[2];
>  	const struct of_device_id *of_id;
> +	enum ahci_imx_type type;
>  	const struct ahci_platform_data *pdata = NULL;
>  	struct imx_ahci_priv *imxpriv;
>  	struct device *ahci_dev;
>  	struct platform_device *ahci_pdev;
>  	int ret;
>  
> +	of_id = of_match_device(imx_ahci_of_match, dev);
> +	if (!of_id)
> +		return -EINVAL;
> +
> +	type = (enum ahci_imx_type)of_id->data;
> +	pdata = &imx_sata_pdata;
> +
>  	imxpriv = devm_kzalloc(dev, sizeof(*imxpriv), GFP_KERNEL);
>  	if (!imxpriv) {
>  		dev_err(dev, "can't alloc ahci_host_priv\n");
> @@ -233,6 +273,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  
>  	imxpriv->no_device = false;
>  	imxpriv->first_time = true;
> +	imxpriv->type = type;
> +
>  	imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
>  	if (IS_ERR(imxpriv->ahb_clk)) {
>  		dev_err(dev, "can't get ahb clock.\n");
> @@ -240,24 +282,32 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  		goto err_out;
>  	}
>  
> -	imxpriv->sata_ref_clk = devm_clk_get(dev, "sata_ref");
> -	if (IS_ERR(imxpriv->sata_ref_clk)) {
> -		dev_err(dev, "can't get sata_ref clock.\n");
> -		ret = PTR_ERR(imxpriv->sata_ref_clk);
> -		goto err_out;
> +	if (type == AHCI_IMX53) {
> +		imxpriv->sata_gate_clk = devm_clk_get(dev, "sata_gate");
> +		if (IS_ERR(imxpriv->sata_gate_clk)) {
> +			dev_err(dev, "can't get sata_gate clock.\n");
> +			ret = PTR_ERR(imxpriv->sata_gate_clk);
> +			goto err_out;
> +		}
> +
> +		imxpriv->sata_phy_clk = devm_clk_get(dev, "sata_phy");
> +		if (IS_ERR(imxpriv->sata_phy_clk)) {
> +			dev_err(dev, "can't get sata_phy clock.\n");
> +			ret = PTR_ERR(imxpriv->sata_phy_clk);
> +			goto err_out;
> +		}
> +	} else if (type == AHCI_IMX6Q) {
> +		imxpriv->sata_ref_clk = devm_clk_get(dev, "sata_ref");
> +		if (IS_ERR(imxpriv->sata_ref_clk)) {
> +			dev_err(dev, "can't get sata_ref clock.\n");
> +			ret = PTR_ERR(imxpriv->sata_ref_clk);
> +			goto err_out;
> +		}
>  	}
>  
>  	imxpriv->ahci_pdev = ahci_pdev;
>  	platform_set_drvdata(pdev, imxpriv);
>  
> -	of_id = of_match_device(imx_ahci_of_match, dev);
> -	if (of_id) {
> -		pdata = of_id->data;
> -	} else {
> -		ret = -EINVAL;
> -		goto err_out;
> -	}
> -
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (!mem || !irq) {
> @@ -273,40 +323,41 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  	ahci_dev->dma_mask = &ahci_dev->coherent_dma_mask;
>  	ahci_dev->of_node = dev->of_node;
>  
> -	imxpriv->gpr =
> -		syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> -
> -	if (IS_ERR(imxpriv->gpr)) {
> -		dev_err(dev, "failed to find fsl,imx6q-iomux-gpr regmap\n");
> -		ret = PTR_ERR(imxpriv->gpr);
> -		goto err_out;
> +	if (type == AHCI_IMX6Q) {
> +		imxpriv->gpr = syscon_regmap_lookup_by_compatible(
> +							"fsl,imx6q-iomuxc-gpr");
> +		if (IS_ERR(imxpriv->gpr)) {
> +			dev_err(dev,
> +				"failed to find fsl,imx6q-iomux-gpr regmap\n");
> +			return PTR_ERR(imxpriv->gpr);
> +		}
> +
> +		/*
> +		 * Set PHY Paremeters, two steps to configure the GPR13,
> +		 * one write for rest of parameters, mask of first write
> +		 * is 0x07fffffd, and the other one write for setting
> +		 * the mpll_clk_en happens in imx_sata_clock_enable().
> +		 */
> +		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +				   IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK |
> +				   IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK |
> +				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK |
> +				   IMX6Q_GPR13_SATA_SPD_MODE_MASK |
> +				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
> +				   IMX6Q_GPR13_SATA_TX_ATTEN_MASK |
> +				   IMX6Q_GPR13_SATA_TX_BOOST_MASK |
> +				   IMX6Q_GPR13_SATA_TX_LVL_MASK |
> +				   IMX6Q_GPR13_SATA_TX_EDGE_RATE,
> +				   IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB |
> +				   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
> +				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
> +				   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
> +				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
> +				   IMX6Q_GPR13_SATA_TX_ATTEN_9_16 |
> +				   IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB |
> +				   IMX6Q_GPR13_SATA_TX_LVL_1_025_V);
>  	}
>  
> -	/*
> -	 * Set PHY Paremeters, two steps to configure the GPR13,
> -	 * one write for rest of parameters, mask of first write
> -	 * is 0x07fffffd, and the other one write for setting
> -	 * the mpll_clk_en happens in imx_sata_clock_enable().
> -	 */
> -	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> -			   IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK |
> -			   IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK |
> -			   IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK |
> -			   IMX6Q_GPR13_SATA_SPD_MODE_MASK |
> -			   IMX6Q_GPR13_SATA_MPLL_SS_EN |
> -			   IMX6Q_GPR13_SATA_TX_ATTEN_MASK |
> -			   IMX6Q_GPR13_SATA_TX_BOOST_MASK |
> -			   IMX6Q_GPR13_SATA_TX_LVL_MASK |
> -			   IMX6Q_GPR13_SATA_TX_EDGE_RATE,
> -			   IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB |
> -			   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
> -			   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
> -			   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
> -			   IMX6Q_GPR13_SATA_MPLL_SS_EN |
> -			   IMX6Q_GPR13_SATA_TX_ATTEN_9_16 |
> -			   IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB |
> -			   IMX6Q_GPR13_SATA_TX_LVL_1_025_V);
> -
>  	ret = platform_device_add_resources(ahci_pdev, res, 2);
>  	if (ret)
>  		goto err_out;
> -- 
> 1.8.4.2
> 

