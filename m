From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH V6 2/7] arm64: tegra: Enable AHCI on Jetson TX1
Date: Tue, 23 Jan 2018 17:34:29 +0200
Message-ID: <ea0d92f7-8267-722f-fbf5-607c5d896fa8@kapsi.fi>
References: <1515482234-24716-1-git-send-email-pchandru@nvidia.com>
 <1515482234-24716-3-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515482234-24716-3-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

I have usually split the change in chip .dtsi and board .dtsi/.dts in 
separate commits. I don't know if that's necessary though.

This does however require a commit message, like

   Add sata node to the Tegra210 device tree, and enable the device and
   assign board-specific properties on Jetson TX1.

Mikko

On 01/09/2018 09:17 AM, Preetham Chandru Ramchandra wrote:
> From: Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v4:
> * Fixed missing space after 'AUX'
> ---
>   arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi |  6 ++++++
>   arch/arm64/boot/dts/nvidia/tegra210.dtsi       | 16 ++++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> index d67ef4319f3b..2aa2979cd6b5 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> @@ -1325,6 +1325,12 @@
>   		status = "okay";
>   	};
>   
> +	sata@70020000 {
> +		status = "okay";
> +		phys = <&{/padctl@7009f000/pads/sata/lanes/sata-0}>;
> +		phy-names = "sata-0";
> +	};
> +
>   	padctl@7009f000 {
>   		status = "okay";
>   
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> index 9c2402108772..bf72db5386a5 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -798,6 +798,22 @@
>   		#iommu-cells = <1>;
>   	};
>   
> +	sata@70020000 {
> +		compatible = "nvidia,tegra210-ahci";
> +		reg = <0x0 0x70027000 0x0 0x2000>, /* AHCI */
> +		      <0x0 0x70020000 0x0 0x7000>, /* SATA */
> +		      <0x0 0x70001100 0x0 0x1000>; /* SATA AUX */
> +		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&tegra_car TEGRA210_CLK_SATA>,
> +			<&tegra_car TEGRA210_CLK_SATA_OOB>;
> +		clock-names = "sata", "sata-oob";
> +		resets = <&tegra_car 124>,
> +			 <&tegra_car 123>,
> +			 <&tegra_car 129>;
> +		reset-names = "sata", "sata-oob", "sata-cold";
> +		status = "disabled";
> +	};
> +
>   	hda@70030000 {
>   		compatible = "nvidia,tegra210-hda", "nvidia,tegra30-hda";
>   		reg = <0x0 0x70030000 0x0 0x10000>;
> 
