From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] ARM: dts: r8a7793: Add SATA controller node
Date: Thu, 17 Mar 2016 10:23:53 +0900
Message-ID: <20160317012353.GE17728@verge.net.au>
References: <1458148268-22028-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1458148268-22028-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458148268-22028-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-ide@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 16, 2016 at 06:11:07PM +0100, Ulrich Hecht wrote:
> Adds SATA device node to r8a7793.dtsi.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/r8a7793.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> index 3ebe7d4..abb6851 100644
> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -775,6 +775,22 @@
>  		status = "disabled";
>  	};
>  
> +	sata0: sata@ee300000 {
> +		compatible = "renesas,sata-r8a7793";
> +		reg = <0 0xee300000 0 0x2000>;
> +		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp8_clks R8A7793_CLK_SATA0>;

I think you also need a power domains property:

		power-domains = <&cpg_clocks>;

> +		status = "disabled";
> +	};
> +
> +	sata1: sata@ee500000 {
> +		compatible = "renesas,sata-r8a7793";
> +		reg = <0 0xee500000 0 0x2000>;
> +		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp8_clks R8A7793_CLK_SATA1>;

Here too.

> +		status = "disabled";
> +	};
> +
>  	qspi: spi@e6b10000 {
>  		compatible = "renesas,qspi-r8a7793", "renesas,qspi";
>  		reg = <0 0xe6b10000 0 0x2c>;
> -- 
> 2.6.4
