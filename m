From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/5] ARM: dts: brcmstb: add nodes for SATA controller
 and PHY
Date: Thu, 19 Mar 2015 12:10:25 +0100
Message-ID: <550AAEA1.5080301@redhat.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com> <1426728222-8197-5-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426728222-8197-5-git-send-email-computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 19-03-15 02:23, Brian Norris wrote:
> Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Light dependency on:
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331921.html
> for the surrounding text.
>
>   arch/arm/boot/dts/bcm7445.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
> index 9eaeac8dce1b..7a7c4d8c2afe 100644
> --- a/arch/arm/boot/dts/bcm7445.dtsi
> +++ b/arch/arm/boot/dts/bcm7445.dtsi
> @@ -108,6 +108,42 @@
>   			brcm,int-map-mask = <0x25c>, <0x7000000>;
>   			brcm,int-fwd-mask = <0x70000>;
>   		};
> +
> +		sata@f045a000 {
> +			compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
> +			reg-names = "ahci", "top-ctrl";
> +			reg = <0x45a000 0xa9c>, <0x458040 0x24>;

Why not simply drop the second register range here, and the minimal top-ctrl
poking you need in the phy driver's phy_init function ?

This avoids the weird / ugly register overlap with the phy driver, and I think you
can then just use the ahci_platform driver unmodified.

> +			interrupts = <GIC_SPI 30 0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			sata0: sata-port@0 {
> +				reg = <0>;
> +				phys = <&sata_phy 0>;
> +			};
> +
> +			sata1: sata-port@1 {
> +				reg = <1>;
> +				phys = <&sata_phy 1>;
> +			};
> +		};
> +
> +		sata_phy: sata-phy@f0458100 {
> +			compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
> +			reg = <0x458100 0x1e00>, <0x45804c 0x10>;

Why not simply use: reg = <0x458000 0x2000>, to me it seems that what you should
really be using here.

> +			reg-names = "phy", "port-ctrl";
> +			#phy-cells = <1>;
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
> +
> +			sata-phy@0 {
> +				reg = <0>;
> +			};
> +
> +			sata-phy@1 {
> +				reg = <1>;
> +			};
> +		};
>   	};
>
>   	smpboot {
>

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
