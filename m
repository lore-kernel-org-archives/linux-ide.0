From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 6/8] SPEAr13xx: Fixup: Move SPEAr1340 SATA platform code to phy driver
Date: Thu, 30 Jan 2014 14:21:00 +0100
Message-ID: <201401301421.00990.arnd@arndb.de>
References: <cover.1391077731.git.mohit.kumar@st.com> <7b9e0a98a6873f66e519791dfba20418e2a68c5a.1391077731.git.mohit.kumar@st.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53176 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbaA3NVJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2014 08:21:09 -0500
In-Reply-To: <7b9e0a98a6873f66e519791dfba20418e2a68c5a.1391077731.git.mohit.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mohit Kumar <mohit.kumar@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>, Viresh Kumar <viresh.linux@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, spear-devel@list.st.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 30 January 2014, Mohit Kumar wrote:
> 
> diff --git a/Documentation/devicetree/bindings/phy/spear13xx-miphy.txt b/Documentation/devicetree/bindings/phy/spear13xx-miphy.txt
> new file mode 100644
> index 0000000..208b37d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/spear13xx-miphy.txt
> @@ -0,0 +1,8 @@
> +Required properties:
> +- compatible : should be "st,spear1340-sata-pcie-phy".

Just for confirmation: This phy is by design only capable of driving
sata or pcie, but nothing else if reused in a different SoC, right?

If the phy is actually more generic than that, I'd suggest changing
the name, otherwise it's ok.

> +- reg : offset and length of the PHY register set.
> +- misc: phandle for the syscon node to access misc registers
> +- #phy-cells : from the generic PHY bindings, must be 2.
> +	- 1st arg: phandle to the phy node.
> +	- 2nd arg: 0 if phy (in 1st arg) is to be used for sata else 1.
> +	- 3rd arg: Instance id of the phy (in 1st arg).

I would count "arg" differently: There are three cells, and the first
cell is the phandle, while the second and third cells contain the first
and second argument.

The third cell seems redundant, more on that below.

> +		ahci0: ahci@b1000000 {
>  			compatible = "snps,spear-ahci";
>  			reg = <0xb1000000 0x10000>;
>  			interrupts = <0 68 0x4>;
> +			phys = <&miphy0 0 0>;
> +			phy-names = "ahci-phy";
>  			status = "disabled";
>  		};
>  
> -		ahci@b1800000 {
> +		ahci1: ahci@b1800000 {
>  			compatible = "snps,spear-ahci";
>  			reg = <0xb1800000 0x10000>;
>  			interrupts = <0 69 0x4>;
> +			phys = <&miphy1 0 1>;
> +			phy-names = "ahci-phy";
>  			status = "disabled";
>  		};
>  
> -		ahci@b4000000 {
> +		ahci2: ahci@b4000000 {
>  			compatible = "snps,spear-ahci";
>  			reg = <0xb4000000 0x10000>;
>  			interrupts = <0 70 0x4>;
> +			phys = <&miphy2 0 2>;
> +			phy-names = "ahci-phy";
>  			status = "disabled";
>  		};

In each case, the number of the phy 'miphyX' is identical to the
third cell, and I suspect this is by design. In the driver, the
'id' field is set in the xlate function, but I could not find any
place where it actually gets used, so unless you know that it's
needed, I'd suggest simply removing it.

Even if you need it, it may be better to have the instance encoded
in the phy node itself, since it's a property of the phy hardware
(e.g. if you have to pass the number into a generic register that
is global to all phys.

Alternatively, you could have a different representation, where you
have a single DT device node representing all three PHYs, with
"reg = <0xeb800000 0xc000>;" In that case, all sata devices would
point to the same phy node and pass the instance id so the phy
driver can operated the correct register set.

> +static int spear1340_sata_miphy_init(struct spear13xx_phy_priv *phypriv)
> +{
> +	regmap_update_bits(phypriv->misc, SPEAR1340_PCIE_SATA_CFG,
> +			SPEAR1340_PCIE_SATA_CFG_MASK, SPEAR1340_SATA_CFG_VAL);
> +	regmap_update_bits(phypriv->misc, SPEAR1340_PCIE_MIPHY_CFG,
> +			SPEAR1340_PCIE_MIPHY_CFG_MASK,
> +			SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK);
> +	/* Switch on sata power domain */
> +	regmap_update_bits(phypriv->misc, SPEAR1340_PCM_CFG,
> +			SPEAR1340_PCM_CFG_SATA_POWER_EN,
> +			SPEAR1340_PCM_CFG_SATA_POWER_EN);
> +	msleep(20);
> +	/* Disable PCIE SATA Controller reset */
> +	regmap_update_bits(phypriv->misc, SPEAR1340_PERIP1_SW_RST,
> +			SPEAR1340_PERIP1_SW_RST_SATA, 0);
> +	msleep(20);
> +
> +	return 0;
> +}

I guess some of the parts above can eventually get moved into other
drivers (reset controller, power domains) that get called directly
by the SATA driver (e.g. though reset_device()). Since that won't
impact the PHY binding, it seems fine to leave it here for now.

	Arnd
