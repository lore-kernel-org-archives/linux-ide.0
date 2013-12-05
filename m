From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 4/5] Phy: Add DT nodes on kirkwood and Dove for the SATA
 PHY
Date: Thu, 5 Dec 2013 11:47:54 +0530
Message-ID: <52A01A92.1000305@ti.com>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch> <1386177364-10164-5-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42945 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313Ab3LEGSE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Dec 2013 01:18:04 -0500
In-Reply-To: <1386177364-10164-5-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Hi,
On Wednesday 04 December 2013 10:46 PM, Andrew Lunn wrote:
> Add nodes for the two SATA PHYs on kirkewood.
> Add node for the one SATA PHY on Dove.
> Add pHandles to the PHYs in the sata nodes.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/dove.dtsi          | 11 +++++++++++
>  arch/arm/boot/dts/kirkwood-6281.dtsi |  2 ++
>  arch/arm/boot/dts/kirkwood-6282.dtsi |  2 ++
>  arch/arm/boot/dts/kirkwood.dtsi      | 18 ++++++++++++++++++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 113a8bc7bee7..d56b3c675249 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -490,10 +490,21 @@
>  				reg = <0xa0000 0x2400>;
>  				interrupts = <62>;
>  				clocks = <&gate_clk 3>;
> +				phys = <&sata_phy0>;
> +				phy-names = "0";

A more descriptive phy-names would be good here and below.
>  				nr-ports = <1>;
>  				status = "disabled";
>  			};
>  
> +			sata_phy0: sata_phy@0 {
> +				compatible = "marvell,mvebu-sata-phy";
> +				reg = <0xa2000 0x0334>;
> +				clocks = <&gate_clk 3>;
> +				clock-names = "sata";
> +				#phy-cells = <0>;

Ah.. only you documentation was having this value as '1'. Only that needs to be
fixed then.

Thanks
Kishon
