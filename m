From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/6] ARM: EXYNOS5: DT Support for SATA and SATA PHY
Date: Tue, 9 Oct 2012 11:28:28 -0700
Message-ID: <20121009182828.GA20879@quad.lixom.net>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
 <1349783332-18467-3-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1349783332-18467-3-git-send-email-vasanthananthan@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vasanth Ananthan <vasanthananthan@gmail.com>
Cc: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

Hi,


On Tue, Oct 09, 2012 at 05:18:48PM +0530, Vasanth Ananthan wrote:
> This patch adds Device Nodes for SATA and SATA PHY device.
> 
> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250-smdk5250.dts |   11 +++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi         |   20 ++++++++++++++++++++
>  arch/arm/mach-exynos/include/mach/map.h   |    7 +++++++
>  arch/arm/mach-exynos/mach-exynos5-dt.c    |    6 ++++++
>  4 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 8a5e348..bb262ce 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -48,6 +48,17 @@
>  		};
>  	};
>  
> +	i2c@121D0000 {
> +		samsung,i2c-sda-delay = <100>;
> +                samsung,i2c-max-bus-freq = <40000>;
> +		samsung,i2c-slave-addr = <0x38>;

Whitespace is off above.

> +
> +		sataphy@70 {

sata-phy would be a more conventional name.

> +			compatible = "samsung,i2c-phy";

i2c-phy? Seems like an odd choice of name. What is this device?

> +			reg = <0x38>;

70 is unit address but here it's 0x38? One of them is wrong. No need for a unit
address if it's a unique name, by the way.


> +		};
> +	};
> +
>  	i2c@12C80000 {
>  		status = "disabled";
>  	};
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 004aaa8..5a47a8f 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -88,6 +88,18 @@
>  		interrupts = <0 54 0>;
>  	};
>  
> +	sata@122F0000 {
> +                compatible = "samsung,exynos-sata-ahci";
> +                reg = <0x122F0000 0x1ff>;
> +		interrupts = <0 115 0>;

More whitespace damage. And need binding.

> +        };
> +
> +        sata-phy@12170000 {
> +                compatible = "samsung,exynos-sata-phy";
> +                reg = <0x12170000 0x1ff>;
> +        };

Should have binding too. How does this relate to the i2c device above.

> +
>  	i2c@12C60000 {
>  		compatible = "samsung,s3c2440-i2c";
>  		reg = <0x12C60000 0x100>;
> @@ -152,6 +164,13 @@
>  		#size-cells = <0>;
>  	};
>  
> +	i2c@121D0000 {
> +                compatible = "samsung,s3c2440-sataphy-i2c";

Is this a unique i2c controller, or is it just another one like the others on
the chip? If it's the latter, it should use the regular compatible string.

> +                reg = <0x121D0000 0x100>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +        };
> +
>  	spi_0: spi@12d20000 {
>  		compatible = "samsung,exynos4210-spi";
>  		reg = <0x12d20000 0x100>;
> @@ -460,4 +479,5 @@
>  			#gpio-cells = <4>;
>  		};
>  	};
> +

Stray whitespace change.

>  };
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index c72b675..6827190 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -177,9 +177,16 @@
>  #define EXYNOS4_PA_HSOTG		0x12480000
>  #define EXYNOS4_PA_USB_HSPHY		0x125B0000
>  
> +#ifdef CONFIG_ARCH_EXYNOS4

No need to ifdef since namespace isn't overlapped.

>  #define EXYNOS4_PA_SATA			0x12560000
>  #define EXYNOS4_PA_SATAPHY		0x125D0000
>  #define EXYNOS4_PA_SATAPHY_CTRL		0x126B0000
> +#endif
> +#ifdef CONFIG_ARCH_EXYNOS5

Same here.

> +#define EXYNOS5_PA_SATA_PHY_CTRL	0x12170000
> +#define EXYNOS5_PA_SATA_PHY_I2C		0x121D0000
> +#define EXYNOS5_PA_SATA_BASE		0x122F0000
> +#endif


-Olof
