From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH V3 3/3] arm64: tegra: Enable SATA on Tegra210
Date: Sun, 14 May 2017 14:29:12 +0300
Message-ID: <3279be02-37b3-7869-4fe6-5bd20f107f38@kapsi.fi>
References: <1494581650-11115-1-git-send-email-pchandru@nvidia.com>
 <1494581650-11115-4-git-send-email-pchandru@nvidia.com>
 <1f54292e718c4bb5a02d547d041804b0@bgmail103.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1f54292e718c4bb5a02d547d041804b0-7W72rfoJkVnYuxH7O460wFaTQe2KTcn/@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Preetham Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On 05/12/2017 12:56 PM, Preetham Chandru wrote:
> +CC linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>
>> -----Original Message-----
>> From: Preetham Chandru
>> Sent: Friday, May 12, 2017 3:04 PM
>> To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
>> Cc: tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Laxman Dewangan
>> <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Venu Byravarasu
>> <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Preetham
>> Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> Subject: [PATCH V3 3/3] arm64: tegra: Enable SATA on Tegra210
>>
>> From: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> Enable the SATA unit on Tegra210 systems.
>>
>> Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>> arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi |  6 ++++++
>> arch/arm64/boot/dts/nvidia/tegra210.dtsi       | 16 ++++++++++++++++
>> 2 files changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>> b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>> index e5fc67b..58c28b9 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>> @@ -1324,6 +1324,12 @@
>> 		status = "okay";
>> 	};
>>
>> +	sata@70020000 {
>> +		status = "okay";
>> +		phys = <&{/padctl@7009f000/pads/sata/lanes/sata-0}>;
>> +		phy-names = "sata-0";
>> +	};
>> +
>> 	padctl@7009f000 {
>> 		status = "okay";
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> index 8f26c4d..20c9160 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> @@ -795,6 +795,22 @@
>> 		#iommu-cells = <1>;
>> 	};
>>
>> +	sata@70020000 {
>> +		compatible = "nvidia,tegra210-ahci";
>> +		reg = <0x0 0x70027000 0x0 0x2000>, /* AHCI */
>> +		      <0x0 0x70020000 0x0 0x7000>, /* SATA */
>> +		      <0x0 0x70001100 0x0 0x1000>; /* SATA AUX*/

Missing space after 'AUX'

>> +		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&tegra_car TEGRA210_CLK_SATA>,
>> +			<&tegra_car TEGRA210_CLK_SATA_OOB>;
>> +		clock-names = "sata", "sata-oob";
>> +		resets = <&tegra_car 124>,
>> +			 <&tegra_car 123>,
>> +			 <&tegra_car 129>;
>> +		reset-names = "sata", "sata-oob", "sata-cold";

The binding documentation says that sata-cold is not required for tegra210?

>> +		status = "disabled";
>> +	};
>> +
>> 	hda@70030000 {
>> 		compatible = "nvidia,tegra210-hda", "nvidia,tegra30-hda";
>> 		reg = <0x0 0x70030000 0x0 0x10000>;
>> --
>> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
