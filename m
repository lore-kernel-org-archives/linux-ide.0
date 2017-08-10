From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/9] devicetree: bindings: Add sata port phy config
 parameters in ahci-ceva
Date: Thu, 10 Aug 2017 14:07:20 -0500
Message-ID: <20170810190720.yqeu4qzztylu5slb@rob-hp-laptop>
References: <cover.1501852693.git.michal.simek@xilinx.com>
 <b7692739885fe200a4ea5a4e3828349a406e2247.1501852693.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b7692739885fe200a4ea5a4e3828349a406e2247.1501852693.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alexander Graf <agraf@suse.de>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, Tejun Heo <tj@kernel.org>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

On Fri, Aug 04, 2017 at 03:18:10PM +0200, Michal Simek wrote:
> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> 
> This patch adds device tree bindings for sata port phy parameters
> in the ahci-ceva.txt file.
> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  .../devicetree/bindings/ata/ahci-ceva.txt          | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> index 7ca8b976c13a..f97546f61444 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> @@ -5,6 +5,36 @@ Required properties:
>    - compatible: Compatibility string. Must be 'ceva,ahci-1v84'.
>    - clocks: Input clock specifier. Refer to common clock bindings.
>    - interrupts: Interrupt specifier. Refer to interrupt binding.
> +  - ceva,p0-cominit-params: OOB timing value for COMINIT parameter for port 0.
> +  - ceva,p1-cominit-params: OOB timing value for COMINIT parameter for port 1.
> +			The fields for the above parameter must be as shown below:
> +			ceva,phy-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;

phy? Should be pN?

> +			CINMP : COMINIT Negate Minimum Period.
> +			CIBGN : COMINIT Burst Gap Nominal.
> +			CIBGMX: COMINIT Burst Gap Maximum.
> +			CIBGMN: COMINIT Burst Gap Minimum.
> +  - ceva,p0-comwake-params: OOB timing value for COMWAKE parameter for port 0.
> +  - ceva,p1-comwake-params: OOB timing value for COMWAKE parameter for port 1.
> +			The fields for the above parameter must be as shown below:
> +			ceva,phy-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
> +			CWBGMN: COMWAKE Burst Gap Minimum.
> +			CWBGMX: COMWAKE Burst Gap Maximum.
> +			CWBGN: COMWAKE Burst Gap Nominal.
> +			CWNMP: COMWAKE Negate Minimum Period.
> +  - ceva,p0-burst-params: Burst timing value for COM parameter for port 0.
> +  - ceva,p1-burst-params: Burst timing value for COM parameter for port 1.
> +			The fields for the above parameter must be as shown below:
> +			ceva,phy-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
> +			BMX: COM Burst Maximum.
> +			BNM: COM Burst Nominal.
> +			SFD: Signal Failure Detection value.
> +			PTST: Partial to Slumber timer value.
> +  - ceva,p0-retry-params: Retry interval timing value for port 0.
> +  - ceva,p1-retry-params: Retry interval timing value for port 1.
> +			The fields for the above parameter must be as shown below:
> +			ceva,phy-retry-params = /bits/ 16 <RIT RCT>;
> +			RIT:  Retry Interval Timer.
> +			RCT:  Rate Change Timer.
>  
>  Optional properties:
>    - ceva,broken-gen2: limit to gen1 speed instead of gen2.
> @@ -16,5 +46,14 @@ Examples:
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 133 4>;
>  		clocks = <&clkc SATA_CLK_ID>;
> +		ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
> +		ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
> +		ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
> +		ceva,p0-retry-params = /bits/ 16 <0x0216 0x7F06>;
> +
> +		ceva,p1-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
> +		ceva,p1-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
> +		ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
> +		ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
>  		ceva,broken-gen2;
>  	};
> -- 
> 1.9.1
> 
