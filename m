From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 4/4] Phy: Add DT nodes on kirkwood and Dove for the
 SATA PHY
Date: Thu, 5 Dec 2013 13:18:48 -0500
Message-ID: <20131205181848.GS29282@titan.lakedaemon.net>
References: <1386262263-18956-1-git-send-email-andrew@lunn.ch>
 <1386262263-18956-5-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10940 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932422Ab3LESS7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Dec 2013 13:18:59 -0500
Content-Disposition: inline
In-Reply-To: <1386262263-18956-5-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: kishon@ti.com, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 05, 2013 at 05:51:03PM +0100, Andrew Lunn wrote:
> Add nodes for the two SATA PHYs on kirkewood.

s/kirkewood/kirkwood/ but only if you do a respin.  Otherwise, I can
patch it up when I pull it in.

thx,

Jason.

> Add node for the one SATA PHY on Dove.
> Add pHandles to the PHYs in the sata nodes.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v1->v2:
> sata_phy@... ->sata-phy@
> value after '@' matching the first address in the reg.
> ---
>  arch/arm/boot/dts/dove.dtsi          | 11 +++++++++++
>  arch/arm/boot/dts/kirkwood-6281.dtsi |  2 ++
>  arch/arm/boot/dts/kirkwood-6282.dtsi |  2 ++
>  arch/arm/boot/dts/kirkwood.dtsi      | 18 ++++++++++++++++++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 113a8bc7bee7..0d786f868760 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -490,10 +490,21 @@
>  				reg = <0xa0000 0x2400>;
>  				interrupts = <62>;
>  				clocks = <&gate_clk 3>;
> +				phys = <&sata_phy0>;
> +				phy-names = "0";
>  				nr-ports = <1>;
>  				status = "disabled";
>  			};
>  
> +			sata_phy0: sata-phy@a2000 {
> +				compatible = "marvell,mvebu-sata-phy";
> +				reg = <0xa2000 0x0334>;
> +				clocks = <&gate_clk 3>;
> +				clock-names = "sata";
> +				#phy-cells = <0>;
> +				status = "ok";
> +			};
> +
>  			rtc: real-time-clock@d8500 {
>  				compatible = "marvell,orion-rtc";
>  				reg = <0xd8500 0x20>;
> diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
> index 650ef30e1856..92a1c747456a 100644
> --- a/arch/arm/boot/dts/kirkwood-6281.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
> @@ -89,6 +89,8 @@
>  			interrupts = <21>;
>  			clocks = <&gate_clk 14>, <&gate_clk 15>;
>  			clock-names = "0", "1";
> +			phys = <&sata_phy0>, <&sata_phy1>;
> +			phy-names = "0", "1";
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
> index 3933a331ddc2..dfa6b073cf00 100644
> --- a/arch/arm/boot/dts/kirkwood-6282.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
> @@ -117,6 +117,8 @@
>  			interrupts = <21>;
>  			clocks = <&gate_clk 14>, <&gate_clk 15>;
>  			clock-names = "0", "1";
> +			phys = <&sata_phy0>, <&sata_phy1>;
> +			phy-names = "0", "1";
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 8b73c80f1dad..ee06951721c4 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -282,5 +282,23 @@
>  				/* set phy-handle property in board file */
>  			};
>  		};
> +
> +		sata_phy0: sata-phy@82000 {
> +			compatible = "marvell,mvebu-sata-phy";
> +			reg = <0x82000 0x0334>;
> +			clocks = <&gate_clk 14>;
> +			clock-names = "sata";
> +			#phy-cells = <0>;
> +			status = "ok";
> +		};
> +
> +		sata_phy1: sata-phy@84000 {
> +			compatible = "marvell,mvebu-sata-phy";
> +			reg = <0x84000 0x0334>;
> +			clocks = <&gate_clk 15>;
> +			clock-names = "sata";
> +			#phy-cells = <0>;
> +			status = "ok";
> +		};
>  	};
>  };
> -- 
> 1.8.5
> 
