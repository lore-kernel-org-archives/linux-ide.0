From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 14/14] ARM: dts: da850-lcdk: enable the SATA node
Date: Tue, 17 Jan 2017 12:53:16 -0600
Message-ID: <8dae1b25-465e-faf5-b5bb-7b1f534a1bcb@lechnology.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-15-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484655976-25382-15-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 01/17/2017 06:26 AM, Bartosz Golaszewski wrote:
> Enable the SATA node for da850-lcdk. We omit the pinctrl property on
> purpose - the muxed SATA pins are not hooked up to anything
> SATA-related on the lcdk.
>
> The REFCLKN/P rate on the board is 100MHz, so we need a multiplier of
> 15 for 1.5GHz PLL rate.

The multiplier is no longer in device tree, so this comment is not 
necessary.

>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index afcb482..fbeee3c 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -105,6 +105,10 @@
>  	status = "okay";
>  };
>
> +&sata {
> +	status = "okay";
> +};
> +
>  &mdio {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mdio_pins>;
>
