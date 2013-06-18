From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [v1 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
Date: Tue, 18 Jun 2013 10:06:55 +0800
Message-ID: <20130618020653.GC28381@S2101-09.ap.freescale.net>
References: <1371462767-16630-1-git-send-email-r65037@freescale.com>
 <1371462767-16630-2-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:29944
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753767Ab3FRCFz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jun 2013 22:05:55 -0400
Content-Disposition: inline
In-Reply-To: <1371462767-16630-2-git-send-email-r65037@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Mon, Jun 17, 2013 at 05:52:45PM +0800, Richard Zhu wrote:
> Only imx6q has the ahci sata controller, enable
> it on imx6q platforms.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabreauto.dts |    6 ++++++
>  arch/arm/boot/dts/imx6q-sabrelite.dts |    6 ++++++
>  arch/arm/boot/dts/imx6q-sabresd.dts   |    6 ++++++
>  arch/arm/boot/dts/imx6q.dtsi          |    9 +++++++++
>  4 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
> index 09a7580..79643cc 100644
> --- a/arch/arm/boot/dts/imx6q-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
> @@ -18,6 +18,12 @@
>  / {
>  	model = "Freescale i.MX6 Quad SABRE Automotive Board";
>  	compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
> +
> +	soc {
> +		ahci@02200000 { /* AHCI SATA */
> +			status = "okay";
> +		};
> +	}
>  };
>  
>  &iomuxc {
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 6a00066..dac40af 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -21,6 +21,12 @@
>  		reg = <0x10000000 0x40000000>;
>  	};
>  
> +	soc {
> +		ahci@02200000 { /* AHCI SATA */
> +			status = "okay";
> +		};
> +	}
> +
>  	regulators {
>  		compatible = "simple-bus";
>  
> diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
> index 0038228..ecae151 100644
> --- a/arch/arm/boot/dts/imx6q-sabresd.dts
> +++ b/arch/arm/boot/dts/imx6q-sabresd.dts
> @@ -18,6 +18,12 @@
>  / {
>  	model = "Freescale i.MX6 Quad SABRE Smart Device Board";
>  	compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
> +
> +	soc {
> +		ahci@02200000 { /* AHCI SATA */
> +			status = "okay";
> +		};
> +	};
>  };
>  
>  &iomuxc {
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index e7dd2c4..e13ff30 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -424,6 +424,15 @@
>  			};
>  		};
>  
> +		ahci@02200000 { /* AHCI SATA */

Add a label for the node like "ahci: ahci@02200000", you can refer to
the node simply using the label in board dts, just like every one else
is doing.

&ahci {
	status = "okay";
};

Shawn

> +			compatible = "snps,imx-ahci";
> +			reg = <0x02200000 0x4000>;
> +			interrupts = <0 39 0x04>;
> +			clocks = <&clks 154>, <&clks 187>;
> +			clock-names = "sata", "sata_ref_100m";
> +			status = "disabled";
> +		};
> +
>  		ipu2: ipu@02800000 {
>  			#crtc-cells = <1>;
>  			compatible = "fsl,imx6q-ipu";
> -- 
> 1.7.5.4
> 

