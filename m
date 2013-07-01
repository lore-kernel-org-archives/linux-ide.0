From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [v2 1/4] ARM: dtsi: enable ahci sata on imx6q platforms
Date: Mon, 1 Jul 2013 22:37:09 +0800
Message-ID: <20130701143708.GS13206@S2101-09.ap.freescale.net>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
 <1372672975-2997-2-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:1356 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754433Ab3GAOg7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2013 10:36:59 -0400
Content-Disposition: inline
In-Reply-To: <1372672975-2997-2-git-send-email-r65037@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, avorontsov@ru.mvista.com, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Mon, Jul 01, 2013 at 06:02:52PM +0800, Richard Zhu wrote:
> Only imx6q has the ahci sata controller, enable
> it on imx6q platforms.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabreauto.dts |    4 ++++
>  arch/arm/boot/dts/imx6q-sabrelite.dts |    4 ++++
>  arch/arm/boot/dts/imx6q-sabresd.dts   |    4 ++++
>  arch/arm/boot/dts/imx6q.dtsi          |    9 +++++++++
>  4 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
> index 09a7580..dd40f00 100644
> --- a/arch/arm/boot/dts/imx6q-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
> @@ -20,6 +20,10 @@
>  	compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
>  };
>  
> +&ahci { /* AHCI SATA */

All these "AHCI SATA" comments are not so useful.  Please just drop
them.

Shawn

> +	status = "okay";
> +};
> +
>  &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 6a00066..fde2afd 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -65,6 +65,10 @@
>  	};
>  };
>  
> +&ahci { /* AHCI SATA */
> +	status = "okay";
> +};
> +
>  &ecspi1 {
>  	fsl,spi-num-chipselects = <1>;
>  	cs-gpios = <&gpio3 19 0>;
> diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
> index 0038228..e9b6825 100644
> --- a/arch/arm/boot/dts/imx6q-sabresd.dts
> +++ b/arch/arm/boot/dts/imx6q-sabresd.dts
> @@ -20,6 +20,10 @@
>  	compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
>  };
>  
> +&ahci { /* AHCI SATA */
> +	status = "okay";
> +};
> +
>  &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index e7dd2c4..7c1af2b 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -424,6 +424,15 @@
>  			};
>  		};
>  
> +		ahci: ahci@02200000 { /* AHCI SATA */
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

