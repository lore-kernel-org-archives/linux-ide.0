From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/2] dt-bindings: ata: add DT bindings for MediaTek SATA
 controller
Date: Fri, 28 Jul 2017 12:20:04 +0300
Message-ID: <7adf5e2c-4678-3e91-1036-f5e82d23329f@cogentembedded.com>
References: <cover.1501134896.git.ryder.lee@mediatek.com>
 <45c7b2abc65b0d7b5b945763837811296e56835f.1501134896.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:37694 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdG1JUP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jul 2017 05:20:15 -0400
Received: by mail-lf0-f44.google.com with SMTP id m86so82277679lfi.4
        for <linux-ide@vger.kernel.org>; Fri, 28 Jul 2017 02:20:14 -0700 (PDT)
In-Reply-To: <45c7b2abc65b0d7b5b945763837811296e56835f.1501134896.git.ryder.lee@mediatek.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>

Hello!

On 7/27/2017 9:38 AM, Ryder Lee wrote:

> Add DT bindings for the onboard SATA controller present on the MediaTek
> SoCs.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>   Documentation/devicetree/bindings/ata/ahci-mtk.txt | 48 ++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-mtk.txt b/Documentation/devicetree/bindings/ata/ahci-mtk.txt
> new file mode 100644
> index 0000000..a8d11db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-mtk.txt
> @@ -0,0 +1,48 @@
> +MediaTek Seria ATA controller
> +
> +Required properties:
> + - compatible	   : Must be "mediatek,ahci".
> + - reg		   : Physical base addresses and length of register sets.
> + - interrupts	   : Interrupt associated with the SATA device.
> + - interrupt-names : Associated name must be: "hostc".
> + - clocks	   : The phandle for the clock.

    Your example shows that you need both phandle and specifier (afetr phandle).

> + - clock-names	   : Associated name must be: "ahb", "axi", "asic", "rbc", "pm"
> + - phys		   : The phandle for the PHY port.

     Likewise.

> + - phy-names	   : Associated name must be: "sata-phy".
> + - ports-implemented : Mask that indicates which ports that the HBA supports
> +		       are available for software to use. Useful if PORTS_IMPL
> +		       is not programmed by the BIOS, which is true with some
> +		       embedded SOC's.

    An empty line wouldn't hurt here...

> +Optional properties:
> + - power-domains   : A phandle and power domain specifier pair to the power
> +		     domain which is responsible for collapsing and restoring
> +		     power to the peripheral.
> + - resets	   : Must contain an entry for each entry in reset-names.
> +		     See ../reset/reset.txt for details.
> + - reset-names	   : Associated names must be: "axi-rst", "sw-rst", "reg-rst".
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
> +		reset-names = "axi-rst", "sw-rst", "reg-rst";
> +		mediatek,phy-mode = <&pciesys>;
> +	};

MBR, Sergei
