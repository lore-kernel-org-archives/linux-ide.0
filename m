From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH V5 3/3] dt-bindings: tegra: add binding documentation
Date: Mon, 17 Jul 2017 18:08:18 +0300
Message-ID: <3a334423-9a47-595c-3782-d474d6a960ab@kapsi.fi>
References: <1498830993-24666-1-git-send-email-pchandru@nvidia.com>
 <1498830993-24666-4-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498830993-24666-4-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 30.06.2017 16:56, Preetham Chandru Ramchandra wrote:
> From: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> This adds bindings documentation for the
> AHCI controller on Tegra210
>
> Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v4:
> * changed the commit message
> * changed 'sata-cold' reset to mandatory for t210 and t124
> * Removed the regulators for T210 since these regulators
>   will be enabled in phy driver.
> v3:
> * Add AUX register.
> v2:
> * change cml1, pll_e and phy regulators as optional
>   for T210.
> ---
>  .../bindings/ata/nvidia,tegra124-ahci.txt          | 38 ++++++++++++++--------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
> index 66c83c3..df4dc2c 100644
> --- a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
> +++ b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
> @@ -1,20 +1,19 @@
> -Tegra124 SoC SATA AHCI controller
> +Tegra SoC SATA AHCI controller
>
>  Required properties :
> -- compatible : For Tegra124, must contain "nvidia,tegra124-ahci".  Otherwise,
> -  must contain '"nvidia,<chip>-ahci", "nvidia,tegra124-ahci"', where <chip>
> -  is tegra132.
> -- reg : Should contain 2 entries:
> +- compatible : Must be one of:
> +  - Tegra124 : "nvidia,tegra124-ahci"
> +  - Tegra210 : "nvidia,tegra210-ahci"
> +- reg : Should contain 3 entries:
>    - AHCI register set (SATA BAR5)
>    - SATA register set
> +  - Tegra210 : AUX register set

Perhaps just drop the Tegra210 since this register set also works on 
Tegra124, even if it is optional.

>  - interrupts : Defines the interrupt used by SATA
>  - clocks : Must contain an entry for each entry in clock-names.
>    See ../clocks/clock-bindings.txt for details.
>  - clock-names : Must include the following entries:
>    - sata
>    - sata-oob
> -  - cml1
> -  - pll_e
>  - resets : Must contain an entry for each entry in reset-names.
>    See ../reset/reset.txt for details.
>  - reset-names : Must include the following entries:
> @@ -24,9 +23,22 @@ Required properties :
>  - phys : Must contain an entry for each entry in phy-names.
>    See ../phy/phy-bindings.txt for details.
>  - phy-names : Must include the following entries:
> -  - sata-phy : XUSB PADCTL SATA PHY
> -- hvdd-supply : Defines the SATA HVDD regulator
> -- vddio-supply : Defines the SATA VDDIO regulator
> -- avdd-supply : Defines the SATA AVDD regulator
> -- target-5v-supply : Defines the SATA 5V power regulator
> -- target-12v-supply : Defines the SATA 12V power regulator
> +  - For T124:
> +    - sata-phy : XUSB PADCTL SATA PHY
> +  - For T210:
> +    - sata-0
> +- For T124:
> +  - hvdd-supply : Defines the SATA HVDD regulator
> +  - vddio-supply : Defines the SATA VDDIO regulator
> +  - avdd-supply : Defines the SATA AVDD regulator
> +  - target-5v-supply : Defines the SATA 5V power regulator
> +  - target-12v-supply : Defines the SATA 12V power regulator
> +
> +Optional properties:
> +- clock-names :
> +  - cml1 :
> +    cml1 clock is required by phy so it is optional to define
> +    here as phy driver will be enabling this clock.
> +  - pll_e :
> +    pll_e is the parent of cml1 clock so it is optional to define
> +    here as phy driver will be enabling this clock.

Perhaps something like "These clocks should be defined here if the PHY 
driver doesn't manage them. If it does, they should not be."

Also for next round, please also add robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org and 
mark.rutland-5wv7dgnIgG8@public.gmane.org to To field and devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org to Cc 
field. They should review the binding documentation. (Sorry for not 
mentioning this earlier but I have been a bit fuzzy on the proper 
procedure myself.)

Cheers,
Mikko
