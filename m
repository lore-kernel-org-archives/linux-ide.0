From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 1/4] Phy: DT binding documentation for Marvell MVEBU
 SATA phy.
Date: Thu, 5 Dec 2013 13:16:51 -0500
Message-ID: <20131205181651.GR29282@titan.lakedaemon.net>
References: <1386262263-18956-1-git-send-email-andrew@lunn.ch>
 <1386262263-18956-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60755 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757277Ab3LESRB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Dec 2013 13:17:01 -0500
Content-Disposition: inline
In-Reply-To: <1386262263-18956-2-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: kishon@ti.com, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 05, 2013 at 05:51:00PM +0100, Andrew Lunn wrote:
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



> Rename to mvebu-phy.txt

Ok, this follows samsung-phy.txt.

> ---
>  Documentation/devicetree/bindings/ata/marvell.txt  |  6 ++++++
>  .../devicetree/bindings/phy/phy-mvebu.txt          | 22 ++++++++++++++++++++++

but this does not... ?

thx,

Jason.

>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu.txt
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
> +
>  Example:
>  
>  	sata@80000 {
>  		compatible = "marvell,orion-sata";
>  		reg = <0x80000 0x5000>;
>  		interrupts = <21>;
> +		phys = <&sata_phy0>, <&sata_phy1>;
> +		phy-names = "0", "1";
>  		nr-ports = <2>;
>  	}
> diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu.txt b/Documentation/devicetree/bindings/phy/phy-mvebu.txt
> new file mode 100644
> index 000000000000..6cb3364aeafb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-mvebu.txt
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
> 1.8.5
> 
