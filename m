From: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V4 2/2] ARM: dts: Enable ahci sata and sata phy
Date: Tue, 31 Dec 2013 16:44:08 +0100
Message-ID: <40868257.6Tm1252hrx@amdc1032>
References: <1388408823-4963-1-git-send-email-yuvaraj.cd@samsung.com>
 <1388408823-4963-3-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1388408823-4963-3-git-send-email-yuvaraj.cd-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yuvaraj Kumar C D <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kishon-l0cyMroinI0@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Yuvaraj Kumar C D <yuvaraj.cd-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org


[ added linux-ide ML to Cc: ]

On Monday, December 30, 2013 06:37:03 PM Yuvaraj Kumar C D wrote:
> This patch adds dt entry for ahci sata controller and its
> corresponding phy controller.phy node has been added w.r.t
> new generic phy framework.
> 
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> 
> Changes since V3:
> 	1.Moved the binding info to the /bindings/phy/
> 
> Changes since V2:
> 	1.Used syscon interface to PMU handling.
> 	2.Changed "sata-phy-i2c" to "exynos-sataphy-i2c".
> 
> Changes since V1:
> 	1.Minor changes to node name convention.
> 	2.Updated binding document.
> 
>  .../devicetree/bindings/ata/exynos-sata-phy.txt    |   14 -------
>  .../devicetree/bindings/ata/exynos-sata.txt        |   25 +++++++-----
>  .../devicetree/bindings/phy/samsung-phy.txt        |   40 ++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250-arndale.dts           |   11 ++++++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |    8 +---
>  arch/arm/boot/dts/exynos5250.dtsi                  |   16 ++++++--
>  6 files changed, 81 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/exynos-sata-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/exynos-sata-phy.txt b/Documentation/devicetree/bindings/ata/exynos-sata-phy.txt
> deleted file mode 100644
> index 37824fa..0000000
> --- a/Documentation/devicetree/bindings/ata/exynos-sata-phy.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -* Samsung SATA PHY Controller
> -
> -SATA PHY nodes are defined to describe on-chip SATA Physical layer controllers.
> -Each SATA PHY controller should have its own node.
> -
> -Required properties:
> -- compatible        : compatible list, contains "samsung,exynos5-sata-phy"
> -- reg               : <registers mapping>
> -
> -Example:
> -        sata@ffe07000 {
> -                compatible = "samsung,exynos5-sata-phy";
> -                reg = <0xffe07000 0x1000>;
> -        };
> diff --git a/Documentation/devicetree/bindings/ata/exynos-sata.txt b/Documentation/devicetree/bindings/ata/exynos-sata.txt
> index 0849f10..b2adb1f 100644
> --- a/Documentation/devicetree/bindings/ata/exynos-sata.txt
> +++ b/Documentation/devicetree/bindings/ata/exynos-sata.txt
> @@ -4,14 +4,21 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
>  Each SATA controller should have its own node.
>  
>  Required properties:
> -- compatible        : compatible list, contains "samsung,exynos5-sata"
> -- interrupts        : <interrupt mapping for SATA IRQ>
> -- reg               : <registers mapping>
> -- samsung,sata-freq : <frequency in MHz>
> +- compatible		: compatible list, contains "samsung,exynos5-sata"
> +- interrupts		: <interrupt mapping for SATA IRQ>
> +- reg			: <registers mapping>
> +- samsung,sata-freq	: <frequency in MHz>
> +- phys			: as mentioned in phy-bindings.txt
> +- phy-names		: as mentioned in phy-bindings.txt
>  
>  Example:
> -        sata@ffe08000 {
> -                compatible = "samsung,exynos5-sata";
> -                reg = <0xffe08000 0x1000>;
> -                interrupts = <115>;
> -        };
> +	sata@122f0000 {
> +		compatible = "snps,dwc-ahci";
> +		samsung,sata-freq = <66>;
> +		reg = <0x122f0000 0x1ff>;
> +		interrupts = <0 115 0>;
> +		clocks = <&clock 277>, <&clock 143>;
> +		clock-names = "sata", "sclk_sata";
> +		phys = <&sata_phy>;
> +		phy-names = "sata-phy";
> +	};
> diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
> index c0fccaa..876fe9b 100644
> --- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
> @@ -20,3 +20,43 @@ Required properties:
>  - compatible : should be "samsung,exynos5250-dp-video-phy";
>  - reg : offset and length of the Display Port PHY register set;
>  - #phy-cells : from the generic PHY bindings, must be 0;
> +
> +Samsung SATA PHY Controller
> +---------------------------
> +
> +SATA PHY nodes are defined to describe on-chip SATA Physical layer controllers.
> +Each SATA PHY controller should have its own node.
> +
> +Required properties:
> +- compatible        : compatible list, contains "samsung,exynos5250-sata-phy"
> +- reg : offset and length of the SATA PHY register set;
> +- #phy-cells : from the generic phy bindings;
> +
> +Example:
> +	sata_phy: sata-phy@12170000 {
> +		compatible = "samsung,exynos5250-sata-phy";
> +		reg = <0x12170000 0x1ff>;
> +		clocks = <&clock 287>;
> +		clock-names = "sata_phyctrl";
> +		#phy-cells = <0>;

This example needs to be updated as the code below evolved to be just:

samsung,syscon-phandle = <&pmu_syscon>;

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		sataphy-pmu {
> +			reg = <0x10040724 0x4>;
> +		};

Otherwise the patch looks good.

> +	};
> +
> +Device-Tree bindings for sataphy i2c client driver
> +--------------------------------------------------
> +
> +Required properties:
> +compatible: Should be "samsung,exynos-sataphy-i2c"
> +- reg: I2C address of the sataphy i2c device.
> +
> +Example:
> +
> +	sata-phy@38 {
> +		compatible = "samsung,exynos-sataphy-i2c";
> +		reg = <0x38>;
> +	};
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index b42e658..25fe5a3 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -370,6 +370,17 @@
>  		};
>  	};
>  
> +	i2c@121D0000 {
> +		samsung,i2c-sda-delay = <100>;
> +		samsung,i2c-max-bus-freq = <40000>;
> +		samsung,i2c-slave-addr = <0x38>;
> +
> +		sata-phy@38 {
> +			compatible = "samsung,exynos-sataphy-i2c";
> +			reg = <0x38>;
> +		};
> +	};
> +
>  	mmc_0: mmc@12200000 {
>  		status = "okay";
>  		num-slots = <1>;
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 3e69837..9e449e6 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -96,16 +96,12 @@
>  		samsung,i2c-slave-addr = <0x38>;
>  		status = "okay";
>  
> -		sata-phy {
> -			compatible = "samsung,sata-phy";
> +		sata-phy@38 {
> +			compatible = "samsung,exynos-sataphy-i2c";
>  			reg = <0x38>;
>  		};
>  	};
>  
> -	sata@122F0000 {
> -		samsung,sata-freq = <66>;
> -	};
> -
>  	i2c@12C80000 {
>  		samsung,i2c-sda-delay = <100>;
>  		samsung,i2c-max-bus-freq = <66000>;
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index dbb4a47..626a7d1 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -46,6 +46,7 @@
>  		i2c6 = &i2c_6;
>  		i2c7 = &i2c_7;
>  		i2c8 = &i2c_8;
> +		i2c9 = &i2c_9;
>  		pinctrl0 = &pinctrl_0;
>  		pinctrl1 = &pinctrl_1;
>  		pinctrl2 = &pinctrl_2;
> @@ -231,16 +232,23 @@
>  	};
>  
>  	sata@122F0000 {
> -		compatible = "samsung,exynos5-sata-ahci";
> +		compatible = "snps,dwc-ahci";
> +		samsung,sata-freq = <66>;
>  		reg = <0x122F0000 0x1ff>;
>  		interrupts = <0 115 0>;
>  		clocks = <&clock 277>, <&clock 143>;
>  		clock-names = "sata", "sclk_sata";
> +		phys = <&sata_phy>;
> +		phy-names = "sata-phy";
>  	};
>  
> -	sata-phy@12170000 {
> -		compatible = "samsung,exynos5-sata-phy";
> +	sata_phy: sata-phy@12170000 {
> +		compatible = "samsung,exynos5250-sata-phy";
>  		reg = <0x12170000 0x1ff>;
> +		clocks = <&clock 287>;
> +		clock-names = "sata_phyctrl";
> +		#phy-cells = <0>;
> +		samsung,syscon-phandle = <&pmu_syscon>;
>  	};
>  
>  	i2c_0: i2c@12C60000 {
> @@ -358,7 +366,7 @@
>  		status = "disabled";
>  	};
>  
> -	i2c@121D0000 {
> +	i2c_9: i2c@121D0000 {
>                  compatible = "samsung,exynos5-sata-phy-i2c";
>                  reg = <0x121D0000 0x100>;
>                  #address-cells = <1>;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
