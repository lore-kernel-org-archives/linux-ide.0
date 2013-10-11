From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ata: sata_rcar: Add RCAR Gen2 SATA PHY support
Date: Fri, 11 Oct 2013 10:00:35 +0900
Message-ID: <20131011010032.GA13809@verge.net.au>
References: <1381432083-3684-1-git-send-email-valentine.barshak@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381432083-3684-1-git-send-email-valentine.barshak@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

[ CCed devicetree@vger.kernel.org as this involves DT compatibility strings ]

On Thu, Oct 10, 2013 at 11:08:03PM +0400, Valentine Barshak wrote:
> RCAR Gen2 SoC has a different phy which is not compatible with
> the older H1/M1 versions. This adds OF/platform device table
> and PHY initialization callbacks for H2/M2 (Gen2) SoC.

I think it would aid subsequent reading of this patch
if you included information about which SoC is H1, M1, H2 and M2
in the change log.

For the benefit of others they are as follows:

Gen 1:
	H1: r8a7779 SoC
	M1: r8a7778 SoC

Gen 2:
	H2: r8a7790 SoC
	M2: r8a7791 SoC

> PHY initialization method is chosen based on the device id.
> Default PHY settings are applied for Gen2 SoC, which should
> suit the available Gen2 boards.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  drivers/ata/sata_rcar.c | 108 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index c2d95e9..45af29f 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/ata.h>
>  #include <linux/libata.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> @@ -118,17 +119,42 @@
>  #define SATAPCTLR3_REG			0x5A
>  #define SATAPCTLR4_REG			0x60
>  
> +/* Gen2 Physical Layer Control Registers */
> +#define RCAR_GEN2_PHY_CTL1_REG		0x1704
> +#define RCAR_GEN2_PHY_CTL1		0x34180002
> +#define RCAR_GEN2_PHY_CTL1_SS		0xC180	/* Spread Spectrum */
> +
> +#define RCAR_GEN2_PHY_CTL2_REG		0x170C
> +#define RCAR_GEN2_PHY_CTL2		0x00002303
> +
> +#define RCAR_GEN2_PHY_CTL3_REG		0x171C
> +#define RCAR_GEN2_PHY_CTL3		0x000B0194
> +
> +#define RCAR_GEN2_PHY_CTL4_REG		0x1724
> +#define RCAR_GEN2_PHY_CTL4		0x00030994
> +
> +#define RCAR_GEN2_PHY_CTL5_REG		0x1740
> +#define RCAR_GEN2_PHY_CTL5		0x03004001
> +#define RCAR_GEN2_PHY_CTL5_DC		BIT(1)	/* DC connection */
> +#define RCAR_GEN2_PHY_CTL5_TR		BIT(2)	/* Termination Resistor */
> +
>  /* Descriptor table word 0 bit (when DTA32M = 1) */
>  #define SATA_RCAR_DTEND			BIT(0)
>  
>  #define SATA_RCAR_DMA_BOUNDARY		0x1FFFFFFEUL
>  
> +enum sata_rcar_type {
> +	RCAR_SATA,
> +	RCAR_GEN2_SATA,
> +};
> +
>  struct sata_rcar_priv {
>  	void __iomem *base;
>  	struct clk *clk;
> +	enum sata_rcar_type type;
>  };
>  
> -static void sata_rcar_phy_initialize(struct sata_rcar_priv *priv)
> +static void sata_rcar_phy_preinit(struct sata_rcar_priv *priv)
>  {
>  	void __iomem *base = priv->base;
>  
> @@ -170,6 +196,29 @@ static void sata_rcar_phy_write(struct sata_rcar_priv *priv, u16 reg, u32 val,
>  	iowrite32(0, base + SATAPHYADDR_REG);
>  }
>  
> +static void sata_rcar_phy_init(struct sata_rcar_priv *priv)
> +{
> +	sata_rcar_phy_preinit(priv);
> +	sata_rcar_phy_write(priv, SATAPCTLR1_REG, 0x00200188, 0);
> +	sata_rcar_phy_write(priv, SATAPCTLR1_REG, 0x00200188, 1);
> +	sata_rcar_phy_write(priv, SATAPCTLR3_REG, 0x0000A061, 0);
> +	sata_rcar_phy_write(priv, SATAPCTLR2_REG, 0x20000000, 0);
> +	sata_rcar_phy_write(priv, SATAPCTLR2_REG, 0x20000000, 1);
> +	sata_rcar_phy_write(priv, SATAPCTLR4_REG, 0x28E80000, 0);
> +}
> +
> +static void sata_rcar_gen2_phy_init(struct sata_rcar_priv *priv)
> +{
> +	void __iomem *base = priv->base;
> +
> +	iowrite32(RCAR_GEN2_PHY_CTL1, base + RCAR_GEN2_PHY_CTL1_REG);
> +	iowrite32(RCAR_GEN2_PHY_CTL2, base + RCAR_GEN2_PHY_CTL2_REG);
> +	iowrite32(RCAR_GEN2_PHY_CTL3, base + RCAR_GEN2_PHY_CTL3_REG);
> +	iowrite32(RCAR_GEN2_PHY_CTL4, base + RCAR_GEN2_PHY_CTL4_REG);
> +	iowrite32(RCAR_GEN2_PHY_CTL5 | RCAR_GEN2_PHY_CTL5_DC |
> +		  RCAR_GEN2_PHY_CTL5_TR, base + RCAR_GEN2_PHY_CTL5_REG);
> +}
> +
>  static void sata_rcar_freeze(struct ata_port *ap)
>  {
>  	struct sata_rcar_priv *priv = ap->host->private_data;
> @@ -738,13 +787,17 @@ static void sata_rcar_init_controller(struct ata_host *host)
>  	u32 val;
>  
>  	/* reset and setup phy */
> -	sata_rcar_phy_initialize(priv);
> -	sata_rcar_phy_write(priv, SATAPCTLR1_REG, 0x00200188, 0);
> -	sata_rcar_phy_write(priv, SATAPCTLR1_REG, 0x00200188, 1);
> -	sata_rcar_phy_write(priv, SATAPCTLR3_REG, 0x0000A061, 0);
> -	sata_rcar_phy_write(priv, SATAPCTLR2_REG, 0x20000000, 0);
> -	sata_rcar_phy_write(priv, SATAPCTLR2_REG, 0x20000000, 1);
> -	sata_rcar_phy_write(priv, SATAPCTLR4_REG, 0x28E80000, 0);
> +	switch (priv->type) {
> +	case RCAR_GEN2_SATA:
> +		sata_rcar_gen2_phy_init(priv);
> +		break;
> +	case RCAR_SATA:
> +		sata_rcar_phy_init(priv);
> +		break;
> +	default:
> +		dev_warn(host->dev, "SATA PHY is not initialized\n");
> +		break;
> +	}
>  
>  	/* SATA-IP reset state */
>  	val = ioread32(base + ATAPI_CONTROL1_REG);
> @@ -770,8 +823,34 @@ static void sata_rcar_init_controller(struct ata_host *host)
>  	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
>  }
>  
> +static struct of_device_id sata_rcar_match[] = {
> +	{
> +		.compatible = "renesas,rcar-sata",
> +		.data = (void *)RCAR_SATA
> +	},
> +	{
> +		.compatible = "renesas,sata-r8a7790",
> +		.data = (void *)RCAR_GEN2_SATA
> +	},
> +	{
> +		.compatible = "renesas,sata-r8a7791",
> +		.data = (void *)RCAR_GEN2_SATA
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sata_rcar_match);
> +
> +static const struct platform_device_id sata_rcar_id_table[] = {
> +	{ "sata_rcar",		RCAR_SATA },
> +	{ "sata-r8a7790",	RCAR_GEN2_SATA },
> +	{ "sata-r8a7791",	RCAR_GEN2_SATA },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, sata_rcat_id_table);
> +

I think it would be better to add sata-r8a7779 and
sata-r8a7778 to handle the GEN1 hardware and deprecate rcar-sata.

Less importantly I think it would be better to name RCAR_SATA
as RCAR_GEN1_SATA.

>  static int sata_rcar_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *of_id;
>  	struct ata_host *host;
>  	struct sata_rcar_priv *priv;
>  	struct resource *mem;
> @@ -787,6 +866,12 @@ static int sata_rcar_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	of_id = of_match_device(sata_rcar_match, &pdev->dev);
> +	if (of_id)
> +		priv->type = (enum sata_rcar_type)of_id->data;
> +	else
> +		priv->type = platform_get_device_id(pdev)->driver_data;
> +
>  	priv->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(priv->clk)) {
>  		dev_err(&pdev->dev, "failed to get access to sata clock\n");
> @@ -892,15 +977,10 @@ static const struct dev_pm_ops sata_rcar_pm_ops = {
>  };
>  #endif
>  
> -static struct of_device_id sata_rcar_match[] = {
> -	{ .compatible = "renesas,rcar-sata", },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, sata_rcar_match);
> -
>  static struct platform_driver sata_rcar_driver = {
>  	.probe		= sata_rcar_probe,
>  	.remove		= sata_rcar_remove,
> +	.id_table	= sata_rcar_id_table,
>  	.driver = {
>  		.name		= DRV_NAME,
>  		.owner		= THIS_MODULE,
> -- 
> 1.8.3.1
> 
