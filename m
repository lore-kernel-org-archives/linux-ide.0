From: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/8] of: Add NVIDIA Tegra SATA controller binding
Date: Wed, 16 Jul 2014 14:42:50 +0300
Message-ID: <53C6653A.7040107@nvidia.com>
References: <1405500863-19696-1-git-send-email-mperttunen@nvidia.com> <1405500863-19696-2-git-send-email-mperttunen@nvidia.com> <53C64553.9010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53C64553.9010704-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Thanks for you comment. I decided to keep the format as is for now, 
however, to keep a consistent style between all binding files describing 
Tegra hardware.

Mikko

On 16/07/14 12:26, Varka Bhadram wrote:
> On 07/16/2014 02:24 PM, Mikko Perttunen wrote:
>> This patch adds device tree binding documentation for the SATA
>> controller found on NVIDIA Tegra SoCs.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>    .../devicetree/bindings/ata/tegra-sata.txt         | 30 ++++++++++++++++++++++
>>    1 file changed, 30 insertions(+)
>>    create mode 100644 Documentation/devicetree/bindings/ata/tegra-sata.txt
>>
>> diff --git a/Documentation/devicetree/bindings/ata/tegra-sata.txt b/Documentation/devicetree/bindings/ata/tegra-sata.txt
>> new file mode 100644
>> index 0000000..946f207
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ata/tegra-sata.txt
>> @@ -0,0 +1,30 @@
>> +Tegra124 SoC SATA AHCI controller
>> +
>> +Required properties :
>> +- compatible : "nvidia,tegra124-ahci".
>> +- reg : Should contain 2 entries:
>> +  - AHCI register set (SATA BAR5)
>> +  - SATA register set
>> +- interrupts : Defines the interrupt used by SATA
>> +- clocks : Must contain an entry for each entry in clock-names.
>> +  See ../clocks/clock-bindings.txt for details.
>> +- clock-names : Must include the following entries:
>> +  - sata
>> +  - sata-oob
>> +  - cml1
>> +  - pll_e
>
> It would be more readable if it like this...
>
> Required properties :
> - compatible	: "nvidia,tegra124-ahci".
> - reg		: Should contain 2 entries:
> 		  - AHCI register set (SATA BAR5)
> 		  - SATA register set
> - interrupts	: Defines the interrupt used by SATA
> - clocks	: Must contain an entry for each entry in clock-names.
> 		  See ../clocks/clock-bindings.txt for details.
> ....
>
>> +- resets : Must contain an entry for each entry in reset-names.
>> +  See ../reset/reset.txt for details.
>> +- reset-names : Must include the following entries:
>> +  - sata
>> +  - sata-oob
>> +  - sata-cold
>> +- phys : Must contain an entry for each entry in phy-names.
>> +  See ../phy/phy-bindings.txt for details.
>> +- phy-names : Must include the following entries:
>> +  - sata-phy : XUSB PADCTL SATA PHY
>> +- hvdd-supply : Defines the SATA HVDD regulator
>> +- vddio-supply : Defines the SATA VDDIO regulator
>> +- avdd-supply : Defines the SATA AVDD regulator
>> +- target-5v-supply : Defines the SATA 5V power regulator
>> +- target-12v-supply : Defines the SATA 12V power regulator
>
> Same....
>
>
