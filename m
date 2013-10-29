From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] sata_rcar: Add R-Car Gen2 SATA PHY support
Date: Tue, 29 Oct 2013 13:59:43 +0900
Message-ID: <20131029045943.GE20432@verge.net.au>
References: <1381925161-16729-1-git-send-email-valentine.barshak@cogentembedded.com>
 <1381925161-16729-3-git-send-email-valentine.barshak@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381925161-16729-3-git-send-email-valentine.barshak@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

On Wed, Oct 16, 2013 at 04:06:01PM +0400, Valentine Barshak wrote:
> R-Car Gen2 SoCs have a different PHY which is not compatible
> with the older R-Car H1 (R8A7779) version.
> This adds OF/platform device id tables and PHY initialization
> callbacks for the following Gen2 SoCs:
>   * R-Car H2: R8A7790;
>   * R-Car M2: R8A7791.
> 
> PHY initialization method is chosen based on the device id.
> Default PHY settings are applied for Gen2 SoCs, which should
> suit the Gen2 boards available.
> 
> The R8A7779 platform code is modified to use "sata-r8a7779"
> device name.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  .../devicetree/bindings/ata/sata_rcar.txt          |   5 +-
>  arch/arm/mach-shmobile/clock-r8a7779.c             |   2 +-
>  arch/arm/mach-shmobile/setup-r8a7779.c             |   2 +-
>  drivers/ata/sata_rcar.c                            | 118 ++++++++++++++++++---

Hi Mark, Hi Device-Tree Folks,

I'm wondering if you have had a chance to look over the bindings
aspect of this and the other patch in the series. I believe that
this series addresses all previous review in that regards.

Hi Valentine,

I would like to request that the arch/arm/mach-shmobile/ portion
of this patch be split out into a separate patch. The reason is
that in general it is nicer to apply driver changes separately
to platform changes: for starters they have different maintainers.
And in this case there seems to be no reason not to split the change.

Also, I would like to this chance to pass on part of a discussion
at the ARM Linux Kernel summit which is that when posting a series of
patches please only CC devicetree@vger.kernel.org on the patches in
the series that relate to device tree. This would not include
to the new patch with only the arch/arm/mach-shmobile/ portions
of this patch. Feel free to post that patch as a separate series
noting its dependencies below '---' accordingly.

>  4 files changed, 107 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> index 0719115..d6b20a6 100644
> --- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> @@ -1,7 +1,10 @@
>  * Renesas R-Car SATA
>  
>  Required properties:
> -- compatible		: should contain "renesas,sata-r8a7779";
> +- compatible		: should contain one of the following:
> +			  - "renesas,sata-r8a7779" for R-Car H1
> +			  - "renesas,sata-r8a7790" for R-Car H2
> +			  - "renesas,sata-r8a7791" for R-Car M2
>  - reg			: offset and length of the SATA registers;
>  - interrupts		: must consist of one interrupt specifier.
>  
> diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
> index 5c83259..b2f8417 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> @@ -170,7 +170,7 @@ static struct clk_lookup lookups[] = {
>  	/* MSTP32 clocks */
>  	CLKDEV_DEV_ID("r8a7779-vin.3", &mstp_clks[MSTP120]), /* VIN3 */
>  	CLKDEV_DEV_ID("rcar-pcie", &mstp_clks[MSTP116]), /* PCIe */
> -	CLKDEV_DEV_ID("sata_rcar", &mstp_clks[MSTP115]), /* SATA */
> +	CLKDEV_DEV_ID("sata-r8a7779", &mstp_clks[MSTP115]), /* SATA */
>  	CLKDEV_DEV_ID("fc600000.sata", &mstp_clks[MSTP115]), /* SATA w/DT */
>  	CLKDEV_DEV_ID("r8a777x-ether", &mstp_clks[MSTP114]), /* Ether */
>  	CLKDEV_DEV_ID("r8a7779-vin.0", &mstp_clks[MSTP110]), /* VIN0 */
> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> index 51a43c5..9d49090 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -438,7 +438,7 @@ static struct resource sata_resources[] = {
>  };
>  
>  static struct platform_device sata_device = {
> -	.name		= "sata_rcar",
> +	.name		= "sata-r8a7779",
>  	.id		= -1,
>  	.resource	= sata_resources,
>  	.num_resources	= ARRAY_SIZE(sata_resources),
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index a625cc5..068d5b4 100644
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
> @@ -123,12 +124,37 @@
>  
>  #define SATA_RCAR_DMA_BOUNDARY		0x1FFFFFFEUL
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
> +enum sata_rcar_type {
> +	RCAR_GEN1_SATA,
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
> +static void sata_rcar_gen1_phy_preinit(struct sata_rcar_priv *priv)
>  {
>  	void __iomem *base = priv->base;
>  
> @@ -141,8 +167,8 @@ static void sata_rcar_phy_initialize(struct sata_rcar_priv *priv)
>  	iowrite32(0, base + SATAPHYRESET_REG);
>  }
>  
> -static void sata_rcar_phy_write(struct sata_rcar_priv *priv, u16 reg, u32 val,
> -				int group)
> +static void sata_rcar_gen1_phy_write(struct sata_rcar_priv *priv, u16 reg,
> +				     u32 val, int group)
>  {
>  	void __iomem *base = priv->base;
>  	int timeout;
> @@ -170,6 +196,29 @@ static void sata_rcar_phy_write(struct sata_rcar_priv *priv, u16 reg, u32 val,
>  	iowrite32(0, base + SATAPHYADDR_REG);
>  }
>  
> +static void sata_rcar_gen1_phy_init(struct sata_rcar_priv *priv)
> +{
> +	sata_rcar_gen1_phy_preinit(priv);
> +	sata_rcar_gen1_phy_write(priv, SATAPCTLR1_REG, 0x00200188, 0);
> +	sata_rcar_gen1_phy_write(priv, SATAPCTLR1_REG, 0x00200188, 1);
> +	sata_rcar_gen1_phy_write(priv, SATAPCTLR3_REG, 0x0000A061, 0);
> +	sata_rcar_gen1_phy_write(priv, SATAPCTLR2_REG, 0x20000000, 0);
> +	sata_rcar_gen1_phy_write(priv, SATAPCTLR2_REG, 0x20000000, 1);
> +	sata_rcar_gen1_phy_write(priv, SATAPCTLR4_REG, 0x28E80000, 0);
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
> +	case RCAR_GEN1_SATA:
> +		sata_rcar_gen1_phy_init(priv);
> +		break;
> +	case RCAR_GEN2_SATA:
> +		sata_rcar_gen2_phy_init(priv);
> +		break;
> +	default:
> +		dev_warn(host->dev, "SATA phy is not initialized\n");
> +		break;
> +	}
>  
>  	/* SATA-IP reset state */
>  	val = ioread32(base + ATAPI_CONTROL1_REG);
> @@ -770,8 +823,39 @@ static void sata_rcar_init_controller(struct ata_host *host)
>  	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
>  }
>  
> +static struct of_device_id sata_rcar_match[] = {
> +	/* Deprecated, "renesas,sata-r8a7779" should be used instead. */
> +	{
> +		.compatible = "renesas,rcar-sata",
> +		.data = (void *)RCAR_GEN1_SATA,
> +	},
> +	{
> +		.compatible = "renesas,sata-r8a7779",
> +		.data = (void *)RCAR_GEN1_SATA,
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
> +	{ "sata-r8a7779", RCAR_GEN1_SATA },
> +	{ "sata-r8a7790", RCAR_GEN2_SATA },
> +	{ "sata-r8a7791", RCAR_GEN2_SATA },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, sata_rcar_id_table);
> +
>  static int sata_rcar_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *of_id;
>  	struct ata_host *host;
>  	struct sata_rcar_priv *priv;
>  	struct resource *mem;
> @@ -787,6 +871,12 @@ static int sata_rcar_probe(struct platform_device *pdev)
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
> @@ -892,16 +982,10 @@ static const struct dev_pm_ops sata_rcar_pm_ops = {
>  };
>  #endif
>  
> -static struct of_device_id sata_rcar_match[] = {
> -	{ .compatible = "renesas,rcar-sata", },	/* Deprecated */
> -	{ .compatible = "renesas,sata-r8a7779", },
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
