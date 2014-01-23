From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v5 13/14] ARM: sun4i: dts: Add ahci / sata support
Date: Thu, 23 Jan 2014 16:34:54 +0800
Message-ID: <CAGb2v65mYK7Lo_KC+sGvYG7P2kDOy7CZgGane2eY8+-pMvH1mw@mail.gmail.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com> <1390417489-5354-14-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCMILY6JWQBBBRFIQOLQKGQEYSKDSGY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1390417489-5354-14-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi,

On Thu, Jan 23, 2014 at 3:04 AM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
>
> This patch adds sunxi sata support to A10 boards that have such a connector.
> Some boards also feature a regulator via a GPIO and support for this is also
> added.
>
> Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts      |  4 ++++
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  6 +++++
>  arch/arm/boot/dts/sun4i-a10.dtsi           |  8 +++++++
>  arch/arm/boot/dts/sunxi-ahci-reg.dtsi      | 38 ++++++++++++++++++++++++++++++
>  4 files changed, 56 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> index aef8207..3fb7305 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -48,6 +48,10 @@
>                         status = "okay";
>                 };
>
> +               ahci: sata@01c18000 {
> +                       status = "okay";
> +               };
> +
>                 pinctrl@01c20800 {
>                         mmc0_cd_pin_a1000: mmc0_cd_pin@0 {
>                                 allwinner,pins = "PH1";
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> index f50fb2b..6ae1110 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -12,6 +12,7 @@
>
>  /dts-v1/;
>  /include/ "sun4i-a10.dtsi"
> +/include/ "sunxi-ahci-reg.dtsi"
>
>  / {
>         model = "Cubietech Cubieboard";
> @@ -51,6 +52,11 @@
>                         status = "okay";
>                 };
>
> +               ahci: sata@01c18000 {
> +                       target-supply = <&reg_ahci_5v>;
> +                       status = "okay";
> +               };
> +
>                 pinctrl@01c20800 {
>                         mmc0_cd_pin_cubieboard: mmc0_cd_pin@0 {
>                                 allwinner,pins = "PH1";
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 4736dd2..198dcda 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -331,6 +331,14 @@
>                         status = "disabled";
>                 };
>
> +               ahci: sata@01c18000 {
> +                       compatible = "allwinner,sun4i-a10-ahci";
> +                       reg = <0x01c18000 0x1000>;
> +                       interrupts = <56>;
> +                       clocks = <&pll6 0>, <&ahb_gates 25>;
> +                       status = "disabled";
> +               };
> +

Consider adding

    pinctrl-names = "default";

in the ahci node to suppress "default pin state not found" warnings.
Same goes for sun7i-a20.dtsi.

>                 intc: interrupt-controller@01c20400 {
>                         compatible = "allwinner,sun4i-ic";
>                         reg = <0x01c20400 0x400>;
> diff --git a/arch/arm/boot/dts/sunxi-ahci-reg.dtsi b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
> new file mode 100644
> index 0000000..955b197
> --- /dev/null
> +++ b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
> @@ -0,0 +1,38 @@
> +/*
> + * sunxi boards sata target power supply common code
> + *
> + * Copyright 2014 - Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/ {
> +       soc@01c00000 {

This block needs to be under

    pinctrl@01c20800 {

> +               ahci_pwr_pin_a: ahci_pwr_pin@0 {
> +                       allwinner,pins = "PB8";
> +                       allwinner,function = "gpio_out";
> +                       allwinner,drive = <0>;
> +                       allwinner,pull = <0>;
> +               };

    };

> +       };
> +
> +       regulators {
> +               compatible = "simple-bus";
> +               pinctrl-names = "default";
> +
> +               reg_ahci_5v: ahci-5v {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "ahci-5v";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       pinctrl-0 = <&ahci_pwr_pin_a>;
> +                       gpio = <&pio 1 8 0>;
> +                       enable-active-high;
> +               };
> +       };
> +};
> --
> 1.8.5.3
>

Great work! Thanks!

ChenYu
