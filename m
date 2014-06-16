From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/9] ARM: tegra: Add SATA and SATA power to Jetson TK1
 device tree
Date: Mon, 16 Jun 2014 15:58:47 -0600
Message-ID: <539F6897.7080306@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com> <1401881559-18469-4-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401881559-18469-4-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> This enables the integrated SATA controller on the Tegra124 system-on-chip
> on the Jetson TK1 board and adds regulators for the onboard Molex connector
> commonly used to power SATA devices. The regulators are marked always-on
> since they can be used for other purposes than powering SATA devices.

> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts

> +	sata@0,70020000 {

> +		target-supply = <&vdd_5v0_sata>;

   	regulators {

> +		/* Molex power connector */
> +		vdd_5v0_sata: regulator@13 {
> +			compatible = "regulator-fixed";
> +			reg = <13>;
> +			regulator-name = "+5V_SATA";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio TEGRA_GPIO(EE, 2) GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +			vin-supply = <&vdd_5v0_sys>;
> +			regulator-always-on;
> +		};

Why is this always-on, considering that the SATA node references this,
and presumably the driver explicitly enables this regulator?

> +
> +		vdd_12v0_sata: regulator@14 {
> +			compatible = "regulator-fixed";
> +			reg = <14>;
> +			regulator-name = "+12V_SATA";
> +			regulator-min-microvolt = <12000000>;
> +			regulator-max-microvolt = <12000000>;
> +			gpio = <&gpio TEGRA_GPIO(EE, 2) GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +			vin-supply = <&vdd_mux>;
> +			regulator-always-on;
> +		};
>  	};

If there are two regulators required for the SATA devices, shouldn't the
SATA node's target-supply property reference them both? Well, I suppose
there'd need to be target-5v-supply and target-12v-supply properties,
since each regulator property can only reference a single supply, IIRC.
I think the DT binding needs to be updated for this.
