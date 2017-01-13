From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: Re: [PATCH 03/10] devicetree: bindings: add bindings for ahci-da850
Date: Fri, 13 Jan 2017 13:25:31 -0600
Message-ID: <35ff358d-9b17-b2be-38d8-6a51cdddc1a1@lechnology.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-4-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484311084-31547-4-git-send-email-bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 01/13/2017 06:37 AM, Bartosz Golaszewski wrote:
> Add DT bindings for the TI DA850 AHCI SATA controller.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/ata/ahci-da850.txt          | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
>
> diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
> new file mode 100644
> index 0000000..d07c241
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
> @@ -0,0 +1,21 @@
> +Device tree binding for the TI DA850 AHCI SATA Controller
> +---------------------------------------------------------
> +
> +Required properties:
> +  - compatible: must be "ti,da850-ahci"
> +  - reg: physical base addresses and sizes of the controller's register areas
> +  - interrupts: interrupt specifier (refer to the interrupt binding)
> +
> +Optional properties:
> +  - clocks: clock specifier (refer to the common clock binding)
> +  - da850,clk_multiplier: the multiplier for the reference clock needed
> +                          for 1.5GHz PLL output

A clock multiplier property seems redundant if you are specifying a 
clock. It should be possible to get the rate from the clock to determine 
which multiplier is needed.

> +
> +Example:
> +
> +	sata: ahci@0x218000 {
> +		compatible = "ti,da850-ahci";
> +		reg = <0x218000 0x2000>, <0x22c018 0x4>;
> +		interrupts = <67>;
> +		da850,clk_multiplier = <7>;
> +	};
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
