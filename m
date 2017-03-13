From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: ata: add DT bindings for ahci-dm816 SATA
 controller
Date: Mon, 13 Mar 2017 19:53:00 +0300
Message-ID: <2d0ede95-86d6-4d52-6cf5-91de35a29145@cogentembedded.com>
References: <1489422982-3461-1-git-send-email-bgolaszewski@baylibre.com>
 <1489422982-3461-2-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489422982-3461-2-git-send-email-bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hello!

On 03/13/2017 07:36 PM, Bartosz Golaszewski wrote:

> Add DT bindings for the onboard SATA controller present on the DM816x
> SoCs.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/ata/ahci-dm816.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-dm816.txt
>
> diff --git a/Documentation/devicetree/bindings/ata/ahci-dm816.txt b/Documentation/devicetree/bindings/ata/ahci-dm816.txt
> new file mode 100644
> index 0000000..b87ed5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-dm816.txt
> @@ -0,0 +1,20 @@
> +Device tree binding for the TI DM816 AHCI SATA Controller
> +---------------------------------------------------------
> +
> +Required properties:
> +  - compatible: must be "ti,dm816-ahci"
> +  - reg: physical base address and size of the register region used by
> +         the controller (as defined by the AHCI 1.1 standard)
> +  - interrupts: interrupt specifier (refer to the interrupt binding)
> +  - clocks: clock specifiers (refer to the clock binding); two clocks

    There should be a phandle preceding the clock specifier, all new such 
props are different to the old "interrupts" (which had phandle in a separate 
"interrupt-parent" prop).

> +            must be specified: the functional clock and an external
> +            reference clock
> +
> +Example:
> +
> +	sata: sata@4a140000 {
> +		compatible = "ti,dm816-ahci";
> +		reg = <0x4a140000 0xffff>;

   I think you meant 0x10000 ISO 0xffff -- this is a size, not limit.

> +		interrupts = <16>;
> +		clocks = <&sysclk5_ck>, <&sata_refclk>;
> +	};
>

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
