From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/5] ARM: dts: imx53: Add AHCI SATA binding
Date: Mon, 18 Nov 2013 10:41:52 +0800
Message-ID: <20131118024150.GQ11014@S2101-09.ap.freescale.net>
References: <1384651251-5548-1-git-send-email-marex@denx.de>
 <1384651251-5548-4-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:49845
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750877Ab3KRCkO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Nov 2013 21:40:14 -0500
Content-Disposition: inline
In-Reply-To: <1384651251-5548-4-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Sun, Nov 17, 2013 at 02:20:50AM +0100, Marek Vasut wrote:
> The AHCI-IMX driver now supports i.MX53 as well. Add DT binding.

I think this patch can be merged independently without the driver
changes in place.  Also, I understand that the term 'binding' is
referred as binding doc, while what you're patching here is device tree
source.

Shawn

> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>
> ---
>  arch/arm/boot/dts/imx53.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index cffdda2..0e92af0 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -85,6 +85,15 @@
>  		interrupt-parent = <&tzic>;
>  		ranges;
>  
> +		sata: sata@10000000 {
> +			compatible = "fsl,imx53-ahci";
> +			reg = <0x10000000 0x1000>;
> +			interrupts = <28>;
> +			clocks =  <&clks 173>, <&clks 188>, <&clks 5>;
> +			clock-names = "sata_gate", "sata_phy", "ahb";
> +			status = "disabled";
> +		};
> +
>  		ipu: ipu@18000000 {
>  			#crtc-cells = <1>;
>  			compatible = "fsl,imx53-ipu";
> -- 
> 1.8.4.2
> 

