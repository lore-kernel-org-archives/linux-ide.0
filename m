From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 1/8] of: Add NVIDIA Tegra SATA controller binding
Date: Wed, 16 Jul 2014 13:49:57 +0200
Message-ID: <53C666E5.6030009@redhat.com>
References: <1405500863-19696-2-git-send-email-mperttunen@nvidia.com> <1405510814-31928-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405510814-31928-1-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 07/16/2014 01:40 PM, Mikko Perttunen wrote:
> This patch adds device tree binding documentation for the SATA
> controller found on NVIDIA Tegra SoCs.
> 
> Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v4: clarify mandatory clock order

Thanks this and the new v4 of "ata: Add support for the Tegra124 SATA controller"
both look good to me. So these 2 + v3 for the rest of the series are:

Acked-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Regards,

Hans



> 
>  .../devicetree/bindings/ata/tegra-sata.txt         | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/tegra-sata.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/tegra-sata.txt b/Documentation/devicetree/bindings/ata/tegra-sata.txt
> new file mode 100644
> index 0000000..de2f775
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/tegra-sata.txt
> @@ -0,0 +1,31 @@
> +Tegra124 SoC SATA AHCI controller
> +
> +Required properties :
> +- compatible : "nvidia,tegra124-ahci".
> +- reg : Should contain 2 entries:
> +  - AHCI register set (SATA BAR5)
> +  - SATA register set
> +- interrupts : Defines the interrupt used by SATA
> +- clocks : Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names : Must include the following entries in the same
> +  order as listed here:
> +  - sata
> +  - sata-oob
> +  - cml1
> +  - pll_e
> +- resets : Must contain an entry for each entry in reset-names.
> +  See ../reset/reset.txt for details.
> +- reset-names : Must include the following entries:
> +  - sata
> +  - sata-oob
> +  - sata-cold
> +- phys : Must contain an entry for each entry in phy-names.
> +  See ../phy/phy-bindings.txt for details.
> +- phy-names : Must include the following entries:
> +  - sata-phy : XUSB PADCTL SATA PHY
> +- hvdd-supply : Defines the SATA HVDD regulator
> +- vddio-supply : Defines the SATA VDDIO regulator
> +- avdd-supply : Defines the SATA AVDD regulator
> +- target-5v-supply : Defines the SATA 5V power regulator
> +- target-12v-supply : Defines the SATA 12V power regulator
> 
