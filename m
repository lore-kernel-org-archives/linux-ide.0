From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: lx2160a: add sata node support
Date: Sun, 13 Jan 2019 12:05:48 +0800
Message-ID: <20190113040546.GL11426@dragon>
References: <20190110100533.33333-1-peng.ma@nxp.com>
 <20190110100533.33333-2-peng.ma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110100533.33333-2-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Ma <peng.ma@nxp.com>
Cc: axboe@kernel.dk, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jan 10, 2019 at 06:05:33PM +0800, Peng Ma wrote:
> Add sata node support and Enable sata support
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   16 +++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   44 +++++++++++++++++++++
>  2 files changed, 60 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 6481e5f..aacca27 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -117,3 +117,19 @@
>  &usb1 {
>  	status = "okay";
>  };
> +
> +&sata0 {
> +	status = "okay";
> +};
> +
> +&sata1 {
> +	status = "okay";
> +};
> +
> +&sata2 {
> +	status = "okay";
> +};
> +
> +&sata3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index a79f5c1..e857a14 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -762,5 +762,49 @@
>  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>  			dma-coherent;
>  		};
> +
> +		sata0: sata@3200000 {
> +			status = "disabled";

We usually have 'status' at the end of property list.

Shawn

> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3200000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +		};
> +
> +		sata1: sata@3210000 {
> +			status = "disabled";
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3210000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +		};
> +
> +		sata2: sata@3220000 {
> +			status = "disabled";
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3220000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +		};
> +
> +		sata3: sata@3230000 {
> +			status = "disabled";
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3230000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +		};
>  	};
>  };
> -- 
> 1.7.1
> 
