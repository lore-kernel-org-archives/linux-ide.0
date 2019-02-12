From: Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: Re: [v5 2/2] arm64: dts: lx2160a: add sata node support
Date: Tue, 12 Feb 2019 20:00:59 +0100
Message-ID: <20190212190059.GA9272@suse.de>
References: <20190125081013.21663-1-peng.ma@nxp.com>
 <20190125081013.21663-2-peng.ma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125081013.21663-2-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Ma <peng.ma@nxp.com>
Cc: axboe@kernel.dk, shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.tang@nxp.com
List-Id: linux-ide@vger.kernel.org

On Fri, Jan 25, 2019 at 08:10:13AM +0000, Peng Ma wrote:
> Add SATA device nodes for fsl-lx2160a and enable support
> for QDS and RDB boards.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V5:
> 	- no change
> 
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |   16 +++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   16 +++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   44 +++++++++++++++++++++
>  3 files changed, 76 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index 99a22ab..1a5acf6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -95,6 +95,22 @@
>  	};
>  };
>  
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
> +
>  &uart0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 6481e5f..5b6799e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -102,6 +102,22 @@
>  	};
>  };
>  
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
> +
>  &uart0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index a79f5c1..592034b 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -671,6 +671,50 @@
>  			status = "disabled";
>  		};
>  
> +		sata0: sata@3200000 {
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3200000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +
> +		sata1: sata@3210000 {
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3210000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +
> +		sata2: sata@3220000 {
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3220000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +
> +		sata3: sata@3230000 {
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3230000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
You are using same reg values for sata-ecc in all sata instances. Does this
actually work? No errors when the ahci_qoriq driver do ioremap on it while
probing second instance and onward?

fsl-ls208xa.dtsi is the only other file here with multiple sata instances and
it doesn’t care about sata-ecc.

> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +
>  		smmu: iommu@5000000 {
>  			compatible = "arm,mmu-500";
>  			reg = <0 0x5000000 0 0x800000>;

BR,
Yousaf
