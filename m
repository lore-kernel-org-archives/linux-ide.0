From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/5] Phy: Add DT nodes on kirkwood and Dove for the SATA
 PHY
Date: Wed, 04 Dec 2013 23:01:20 +0300
Message-ID: <529F8A10.7010500@cogentembedded.com>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch> <1386177364-10164-5-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:58773 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933015Ab3LDTBT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Dec 2013 14:01:19 -0500
Received: by mail-la0-f53.google.com with SMTP id ea20so10088314lab.12
        for <linux-ide@vger.kernel.org>; Wed, 04 Dec 2013 11:01:18 -0800 (PST)
In-Reply-To: <1386177364-10164-5-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, kishon@ti.com
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Hello.

On 12/04/2013 08:16 PM, Andrew Lunn wrote:

> Add nodes for the two SATA PHYs on kirkewood.
> Add node for the one SATA PHY on Dove.
> Add pHandles to the PHYs in the sata nodes.

    I don't think this patch should be pushed thru the libata tree. However, 
you didn't Cc linux-arm-kernel...

> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
[...]

> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 113a8bc7bee7..d56b3c675249 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -490,10 +490,21 @@
[...]
> +			sata_phy0: sata_phy@0 {

    The node should rather be named "sata-phy@0" to be in line with 
"ethernet-phy" found in the ePAPR spec. [1], hyphen is generally preferred to 
underscore in the device trees.

> +				compatible = "marvell,mvebu-sata-phy";
> +				reg = <0xa2000 0x0334>;
> +				clocks = <&gate_clk 3>;
> +				clock-names = "sata";
> +				#phy-cells = <0>;
> +				status = "ok";
> +			};
> +
>   			rtc: real-time-clock@d8500 {
>   				compatible = "marvell,orion-rtc";
>   				reg = <0xd8500 0x20>;
[...]
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 8b73c80f1dad..5558b89d48ce 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -282,5 +282,23 @@
>   				/* set phy-handle property in board file */
>   			};
>   		};
> +
> +		sata_phy0: sata_phy@0 {

    Same comment.

> +			compatible = "marvell,mvebu-sata-phy";
> +			reg = <0x82000 0x0334>;
> +			clocks = <&gate_clk 14>;
> +			clock-names = "sata";
> +			#phy-cells = <0>;
> +			status = "ok";
> +		};
> +
> +		sata_phy1: sata_phy@1 {

    ... and here.

> +			compatible = "marvell,mvebu-sata-phy";
> +			reg = <0x84000 0x0334>;
> +			clocks = <&gate_clk 15>;
> +			clock-names = "sata";
> +			#phy-cells = <0>;
> +			status = "ok";
> +		};
>   	};
>   };

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei


