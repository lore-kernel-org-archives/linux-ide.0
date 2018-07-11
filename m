From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: add binding for
 Allwinner R40 SATA AHCI controller
Date: Wed, 11 Jul 2018 13:12:52 -0600
Message-ID: <20180711191252.GA2289@rob-hp-laptop>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
 <1531149658-27030-2-git-send-email-clabbe@baylibre.com>
Reply-To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDJIP47K7MERBN5NTHNAKGQEJMSLSLQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1531149658-27030-2-git-send-email-clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-h8G6r0blFSE@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Mon, Jul 09, 2018 at 03:20:55PM +0000, Corentin Labbe wrote:
> From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> 
> The Allwinner R40 SoC contains a SATA AHCI controller like the one in
> A10/A20 SoCs, however a reset control and two power supplies are added
> to it.
> 
> Add a binding document for it.
> 
> As a dedicated binding document is needed now for the A10/A20/R40 AHCI
> controller, drop the A10 compatible line from generic platform AHCI
> controller binding document.
> 
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> Signed-off-by: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |  1 -
>  .../bindings/ata/allwinner,sun4i-a10-ahci.txt      | 40 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index c760ecb81381..1bea4b5ef9fd 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -9,7 +9,6 @@ PHYs.
>  
>  Required properties:
>  - compatible        : compatible string, one of:
> -  - "allwinner,sun4i-a10-ahci"
>    - "brcm,iproc-ahci"
>    - "hisilicon,hisi-ahci"
>    - "cavium,octeon-7130-ahci"
> diff --git a/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt
> new file mode 100644
> index 000000000000..0eea78c14ad3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt
> @@ -0,0 +1,40 @@
> +Allwinner A10/A20/R40 SoC SATA AHCI Controller
> +
> +Required properties:
> +- compatible        : compatible string, one of:
> +  - "allwinner,sun4i-a10-ahci"
> +  - "allwinner,sun8i-r40-ahci"
> +- interrupts        : the SATA IRQ
> +- reg               : the register mapping
> +- clocks            : the clocks needed by SATA controller, usually contains
> +		      an AHB clock and a mod clock

usually?

Need to specify the order. The examples look reversed of what you have 
here.

> +
> +Optional properties:
> +- target-supply     : regulator for SATA target power
> +
> +Required properties for the following compatibles:
> +  - "allwinner,sun8i-r40-ahci"
> +- resets            : the reset control needed by SATA controller
> +- vdd1v2-supply     : regulator for SATA controller's 1.2V VDD
> +- vdd2v5-supply     : regulator for SATA controller's 2.5V VDD
> +
> +
> +Examples for A10:
> +	ahci: sata@1c18000 {
> +		compatible = "allwinner,sun4i-a10-ahci";
> +		reg = <0x01c18000 0x1000>;
> +		interrupts = <56>;
> +		clocks = <&pll6 0>, <&ahb_gates 25>;
> +		target-supply = <&reg_ahci_5v>;
> +	};
> +
> +Examples for R40:
> +	ahci: sata@1c18000 {
> +		compatible = "allwinner,sun8i-r40-ahci";
> +		reg = <0x01c18000 0x1000>;
> +		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&ccu CLK_SATA>, <&ccu CLK_BUS_SATA>;
> +		resets = <&ccu RST_BUS_SATA>;
> +		vdd1v2-supply = <&reg_eldo3>;
> +		vdd2v5-supply = <&reg_dldo4>;
> +	};
> -- 
> 2.16.4
> 
