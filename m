From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/4] Phy: DT binding documentation for Marvell MVEBU SATA
 phy.
Date: Tue, 17 Dec 2013 21:27:16 +0100
Message-ID: <20131217202716.GA2071@lunn.ch>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:34895 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909Ab3LQU1t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Dec 2013 15:27:49 -0500
Content-Disposition: inline
In-Reply-To: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>, kishon@ti.com, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

Hi Folks

Sorry, forgot the --subject. This is version 3 of the patchset.

       Andrew


On Tue, Dec 17, 2013 at 09:21:49PM +0100, Andrew Lunn wrote:
> Describe the binding for the Marvell MVEBU SATA phy. This driver
> can be used at least with Kirkwood, Dove and maybe others.
> Additionally, update the SATA binding with the properties to link
> to the phy nodes.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v1->v2:
> Correct #phy-cells
> Correct number after @ to match first reg address.
> Rename to phy-mvebu.txt
> 
> v2->v3:
> Renamed to mvebu-phy.txt
> Use "port0", "port1" instead of "0", "1"
> ---
>  Documentation/devicetree/bindings/ata/marvell.txt  |  6 ++++++
>  .../devicetree/bindings/phy/mvebu-phy.txt          | 22 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mvebu-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/marvell.txt b/Documentation/devicetree/bindings/ata/marvell.txt
> index b5cdd20cde9c..4c5447f1068d 100644
> --- a/Documentation/devicetree/bindings/ata/marvell.txt
> +++ b/Documentation/devicetree/bindings/ata/marvell.txt
> @@ -6,11 +6,17 @@ Required Properties:
>  - interrupts    : Interrupt controller is using
>  - nr-ports      : Number of SATA ports in use.
>  
> +Optional Properties:
> +- phys		: List of phandles to sata phys
> +- phy-names	: Should be "port0", "port1", etc, one per phandle
> +
>  Example:
>  
>  	sata@80000 {
>  		compatible = "marvell,orion-sata";
>  		reg = <0x80000 0x5000>;
>  		interrupts = <21>;
> +		phys = <&sata_phy0>, <&sata_phy1>;
> +		phy-names = "port0", "port1";
>  		nr-ports = <2>;
>  	}
> diff --git a/Documentation/devicetree/bindings/phy/mvebu-phy.txt b/Documentation/devicetree/bindings/phy/mvebu-phy.txt
> new file mode 100644
> index 000000000000..6cb3364aeafb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mvebu-phy.txt
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
> + - clocks	   : phandle of clock and specifier that supplies the device
> + - clock-names	   : Should be "sata"
> +
> +Example:
> +		sata-phy@84000 {
> +			compatible = "marvell,mvebu-sata-phy";
> +			reg = <0x84000 0x0334>;
> +			clocks = <&gate_clk 15>;
> +			clock-names = "sata";
> +			#phy-cells = <0>;
> +			status = "ok";
> +		};
> -- 
> 1.8.5.1
> 
