From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] arm64: dts: updated sata node on ls1046a dts
Date: Fri, 30 Dec 2016 10:36:07 +0800
Message-ID: <20161230023606.GJ6177@dragon>
References: <1479369560-9188-1-git-send-email-yuantian.tang@nxp.com>
 <1479369560-9188-2-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479369560-9188-2-git-send-email-yuantian.tang-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yuantian.tang-3arQi8VN3Tc@public.gmane.org
Cc: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Thu, Nov 17, 2016 at 03:59:20PM +0800, yuantian.tang-3arQi8VN3Tc@public.gmane.org wrote:
> From: Tang Yuantian <Yuantian.Tang-3arQi8VN3Tc@public.gmane.org>
> 
> On ls1046a soc, sata ecc should be disabled. So added sata ecc

disabled or enabled?

Shawn

> register address so that driver can get this information.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang-3arQi8VN3Tc@public.gmane.org>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 38806ca..88aaaf1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -507,7 +507,9 @@
>  
>  		sata: sata@3200000 {
>  			compatible = "fsl,ls1046a-ahci";
> -			reg = <0x0 0x3200000 0x0 0x10000>;
> +			reg = <0x0 0x3200000 0x0 0x10000>,
> +			    <0x0 0x20140520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
>  			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clockgen 4 1>;
>  		};
> -- 
> 2.1.0.27.g96db324
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
