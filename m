From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/5] Phy: DT binding documentation for Marvell MVEBU SATA
 phy.
Date: Thu, 5 Dec 2013 11:33:46 +0530
Message-ID: <52A01742.2080405@ti.com>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch> <1386177364-10164-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32849 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973Ab3LEGD4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Dec 2013 01:03:56 -0500
In-Reply-To: <1386177364-10164-2-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Hi,

On Wednesday 04 December 2013 10:46 PM, Andrew Lunn wrote:
> Describe the binding for the Marvell MVEBU SATA phy. This driver
> can be used at least with Kirkwood, Dove and maybe others.
> Additionally, update the SATA binding with the properties to link
> to the phy nodes.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  Documentation/devicetree/bindings/ata/marvell.txt  |  6 ++++++
>  .../devicetree/bindings/phy/phy-mvebu-sata.txt     | 22 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/marvell.txt b/Documentation/devicetree/bindings/ata/marvell.txt
> index b5cdd20cde9c..e072fa105b49 100644
> --- a/Documentation/devicetree/bindings/ata/marvell.txt
> +++ b/Documentation/devicetree/bindings/ata/marvell.txt
> @@ -6,11 +6,17 @@ Required Properties:
>  - interrupts    : Interrupt controller is using
>  - nr-ports      : Number of SATA ports in use.
>  
> +Optional Properties:
> +- phys		: List of phandles to sata phys
> +- phy-names	: Should be "0", "1", etc, one number per phandle

over aligned..
> +
>  Example:
>  
>  	sata@80000 {
>  		compatible = "marvell,orion-sata";
>  		reg = <0x80000 0x5000>;
>  		interrupts = <21>;
> +		phys = <&sata_phy0>, <&sata_phy1>;
> +		phy-names = "0", "1";

more descriptive phy-names? sata-phy0?
>  		nr-ports = <2>;
>  	}
> diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt
> new file mode 100644
> index 000000000000..1cf9cef50b4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt

Just name this mvebu-phy.txt so that we can add bindings of other mvebu PHYs
here when it's added.
> @@ -0,0 +1,22 @@
> +* Marvell MVEBU SATA PHY
> +
> +Power control for the SATA phy found on Marvell MVEBU SoCs.
> +
> +This document extends the binding described in phy-bindings.txt
> +
> +Required properties :
> +
> + - reg		   : Offset and length of the register set for the SATA device
> + - compatible	   : Should be "marvell,mvebu-sata-phy"
> + - clocks	   : phandle of clock that supplies the SATA device

some alignment mismatch here?
> + - clock-names	   : Should be "sata"
> +
> +Example:
> +		sata-phy@1 {

The value after '@' must match the first address specified in the reg property
of the node according to the ePAPR spec.
> +			compatible = "marvell,mvebu-sata-phy";
> +			reg = <0x84000 0x0334>;
> +			clocks = <&gate_clk 15>;
> +			clock-names = "sata";
> +			#phy-cells = <1>;

Is it on purpose that your are having phy-cells value to 1?

Thanks
Kishon
