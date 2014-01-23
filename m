From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 4/8] SPEAr13xx: Fixup: Move SPEAr1340 SATA platform code to system cfg driver
Date: Thu, 23 Jan 2014 13:22:54 +0100
Message-ID: <201401231322.54914.arnd@arndb.de>
References: <cover.1390471111.git.mohit.kumar@st.com> <0c4bf78f2a843625f3175cdf259fad653bd2e86d.1390471111.git.mohit.kumar@st.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:49879 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaAWMXi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jan 2014 07:23:38 -0500
In-Reply-To: <0c4bf78f2a843625f3175cdf259fad653bd2e86d.1390471111.git.mohit.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mohit Kumar <mohit.kumar@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>, Viresh Kumar <viresh.linux@gmail.com>, spear-devel@list.st.com, linux-arm-kernel@lists.infradead.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org

On Thursday 23 January 2014, Mohit Kumar wrote:
> diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
> index 3518803..2b4e58e 100644
> --- a/arch/arm/boot/dts/spear13xx.dtsi
> +++ b/arch/arm/boot/dts/spear13xx.dtsi
> @@ -78,6 +78,10 @@
>  		status = "disabled";
>  	};
>  
> +	cfg {
> +		compatible = "st,spear13xx-cfg";
> +	};
> +
>  	ahb {
>  		#address-cells = <1>;
>  		#size-cells = <1>;

I only saw some of the patches, and did not get a patch with the binding
description for this device. Please forward that patch to me, or add it
to the series if you didn't have one.

I assume you'd want a phandle pointing to the syscon device in here
as well?

Regarding the naming, please do not use 'xx' wildcards in DT compatible
strings. Instead, use the exact model name of the first supported
version of the hardware (e.g. spear1300 or spear600) that remains
compatible. If there are minor variations between the versions,
use a list with the most specific version as well as the older ones
it's compatible with.

> @@ -221,6 +225,11 @@
>  				  0xd8000000 0xd8000000 0x01000000
>  				  0xe0000000 0xe0000000 0x10000000>;
>  
> +			misc: misc@e0700000 {
> +				compatible = "st,spear13xx-misc", "syscon";
> +				reg = <0xe0700000 0x1000>;
> +			};
> +

Same here. Also, I would make this 'misc: syscon@e0700000', since 'misc'
does not seem like an appropriate device name.


> +/* SPEAr1340 Registers */
> +/* Power Management Registers */
> +#define SPEAR1340_PCM_CFG			0x100
> +	#define SPEAR1340_PCM_CFG_SATA_POWER_EN	0x800
> +#define SPEAR1340_PCM_WKUP_CFG			0x104
> +#define SPEAR1340_SWITCH_CTR			0x108
> +
> +#define SPEAR1340_PERIP1_SW_RST			0x318
> +	#define SPEAR1340_PERIP1_SW_RST_SATA	0x1000
> +#define SPEAR1340_PERIP2_SW_RST			0x31C
> +#define SPEAR1340_PERIP3_SW_RST			0x320
> +
> +/* PCIE - SATA configuration registers */
> +#define SPEAR1340_PCIE_SATA_CFG			0x424
> +	/* PCIE CFG MASks */
> +	#define SPEAR1340_PCIE_CFG_DEVICE_PRESENT	(1 << 11)
> +	#define SPEAR1340_PCIE_CFG_POWERUP_RESET	(1 << 10)
> +	#define SPEAR1340_PCIE_CFG_CORE_CLK_EN		(1 << 9)
> +	#define SPEAR1340_PCIE_CFG_AUX_CLK_EN		(1 << 8)
> +	#define SPEAR1340_SATA_CFG_TX_CLK_EN		(1 << 4)
> +	#define SPEAR1340_SATA_CFG_RX_CLK_EN		(1 << 3)
> +	#define SPEAR1340_SATA_CFG_POWERUP_RESET	(1 << 2)
> +	#define SPEAR1340_SATA_CFG_PM_CLK_EN		(1 << 1)
> +	#define SPEAR1340_PCIE_SATA_SEL_PCIE		(0)
> +	#define SPEAR1340_PCIE_SATA_SEL_SATA		(1)
> +	#define SPEAR1340_PCIE_SATA_CFG_MASK		0xF1F
> +	#define SPEAR1340_PCIE_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_PCIE | \
> +			SPEAR1340_PCIE_CFG_AUX_CLK_EN | \
> +			SPEAR1340_PCIE_CFG_CORE_CLK_EN | \
> +			SPEAR1340_PCIE_CFG_POWERUP_RESET | \
> +			SPEAR1340_PCIE_CFG_DEVICE_PRESENT)
> +	#define SPEAR1340_SATA_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_SATA | \
> +			SPEAR1340_SATA_CFG_PM_CLK_EN | \
> +			SPEAR1340_SATA_CFG_POWERUP_RESET | \
> +			SPEAR1340_SATA_CFG_RX_CLK_EN | \
> +			SPEAR1340_SATA_CFG_TX_CLK_EN)
> +
> +#define SPEAR1340_PCIE_MIPHY_CFG		0x428
> +	#define SPEAR1340_MIPHY_OSC_BYPASS_EXT		(1 << 31)
> +	#define SPEAR1340_MIPHY_CLK_REF_DIV2		(1 << 27)
> +	#define SPEAR1340_MIPHY_CLK_REF_DIV4		(2 << 27)
> +	#define SPEAR1340_MIPHY_CLK_REF_DIV8		(3 << 27)
> +	#define SPEAR1340_MIPHY_PLL_RATIO_TOP(x)	(x << 0)
> +	#define SPEAR1340_PCIE_MIPHY_CFG_MASK		0xF80000FF
> +	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA \
> +			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
> +			SPEAR1340_MIPHY_CLK_REF_DIV2 | \
> +			SPEAR1340_MIPHY_PLL_RATIO_TOP(60))
> +	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK \
> +			(SPEAR1340_MIPHY_PLL_RATIO_TOP(120))
> +	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE \
> +			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
> +			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
> +
> +struct spear13xx_cfg_priv {
> +	struct regmap		*misc;
> +};
> +
> +/* SATA device registration */
> +static void spear1340_sata_miphy_init(struct spear13xx_cfg_priv *cfgpriv)
> +{
> +	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_SATA_CFG,
> +			SPEAR1340_PCIE_SATA_CFG_MASK, SPEAR1340_SATA_CFG_VAL);
> +	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_MIPHY_CFG,
> +			SPEAR1340_PCIE_MIPHY_CFG_MASK,
> +			SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK);
> +	/* Switch on sata power domain */
> +	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCM_CFG,
> +			SPEAR1340_PCM_CFG_SATA_POWER_EN,
> +			SPEAR1340_PCM_CFG_SATA_POWER_EN);
> +	msleep(20);
> +	/* Disable PCIE SATA Controller reset */
> +	regmap_update_bits(cfgpriv->misc, SPEAR1340_PERIP1_SW_RST,
> +			SPEAR1340_PERIP1_SW_RST_SATA, 0);
> +	msleep(20);
> +}

Looking at the actual code now, this very much looks like it ought to
be a "phy" driver and get put in drivers/phy/.

Please see the recent mailing list discussions about making the ahci
driver more generic. Once you put this code in a proper phy driver,
you should be able to avoid a lot of your workaround and just use
the regular ahci-platform driver without any hand-crafted platform
data callbacks.

	Arnd
