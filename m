From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: ata: add DT bindings for MediaTek
 SATA controller
Date: Thu, 10 Aug 2017 15:51:49 -0500
Message-ID: <20170810205149.lkphpv7krhdaa23y@rob-hp-laptop>
References: <cover.1502098458.git.ryder.lee@mediatek.com>
 <a7ceb4ed8cc3542169ae8d2d995bdd4707f504e1.1502098458.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32769 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752800AbdHJUvw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2017 16:51:52 -0400
Content-Disposition: inline
In-Reply-To: <a7ceb4ed8cc3542169ae8d2d995bdd4707f504e1.1502098458.git.ryder.lee@mediatek.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>

On Mon, Aug 07, 2017 at 05:52:21PM +0800, Ryder Lee wrote:
> Add DT bindings for the onboard SATA controller present on the MediaTek
> SoCs.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-mtk.txt | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-mtk.txt b/Documentation/devicetree/bindings/ata/ahci-mtk.txt
> new file mode 100644
> index 0000000..ed04dfc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-mtk.txt
> @@ -0,0 +1,50 @@
> +MediaTek Seria ATA controller

s/Seria/Serial/

> +
> +Required properties:
> + - compatible	   : Must be "mediatek,ahci".

SoC specific compatible strings please.

> + - reg		   : Physical base addresses and length of register sets.
> + - interrupts	   : Interrupt associated with the SATA device.
> + - interrupt-names : Associated name must be: "hostc".
> + - clocks	   : A list of phandle and clock specifier pairs, one for each
> +		     entry in clock-names.
> + - clock-names	   : Associated names must be: "ahb", "axi", "asic", "rbc", "pm".
> + - phys		   : A phandle and PHY specifier pair for the PHY port.
> + - phy-names	   : Associated name must be: "sata-phy".
> + - ports-implemented : Mask that indicates which ports that the HBA supports
> +		       are available for software to use. Useful if PORTS_IMPL
> +		       is not programmed by the BIOS, which is true with some
> +		       embedded SOC's.

Do you have a variable number of ports and need this in DT? Because it 
looks like you only define having a single phy.

But this is a standard prop, so you can just say "see 
./ahci-platform.txt"

> +
> +Optional properties:
> + - power-domains   : A phandle and power domain specifier pair to the power
> +		     domain which is responsible for collapsing and restoring
> +		     power to the peripheral.
> + - resets	   : Must contain an entry for each entry in reset-names.
> +		     See ../reset/reset.txt for details.
> + - reset-names	   : Associated names must be: "axi", "sw", "reg".
> + - mediatek,phy-mode : A phandle to the system controller, used to enable
> +		       SATA function.
> +
> +Example:
> +
> +	sata: sata@1a200000 {
> +		compatible = "mediatek,ahci";
> +		reg = <0 0x1a200000 0 0x1100>;
> +		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "hostc";
> +		clocks = <&pciesys CLK_SATA_AHB_EN>,
> +			 <&pciesys CLK_SATA_AXI_EN>,
> +			 <&pciesys CLK_SATA_ASIC_EN>,
> +			 <&pciesys CLK_SATA_RBC_EN>,
> +			 <&pciesys CLK_SATA_PM_EN>;
> +		clock-names = "ahb", "axi", "asic", "rbc", "pm";
> +		phys = <&u3port1 PHY_TYPE_SATA>;
> +		phy-names = "sata-phy";
> +		ports-implemented = <0x1>;
> +		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
> +		resets = <&pciesys MT7622_SATA_AXI_BUS_RST>,
> +			 <&pciesys MT7622_SATA_PHY_SW_RST>,
> +			 <&pciesys MT7622_SATA_PHY_REG_RST>;
> +		reset-names = "axi", "sw", "reg";
> +		mediatek,phy-mode = <&pciesys>;
> +	};
> -- 
> 1.9.1
> 
