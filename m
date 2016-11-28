From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [v2,3/3] dt-bindings: ata: ahci_tegra: Add tegra210 AHCI
Date: Mon, 28 Nov 2016 13:52:06 +0000
Message-ID: <bc12a764-ddc3-84cf-aa43-3900d1e78021@nvidia.com>
References: <1479973418-21351-4-git-send-email-pchandru@nvidia.com>
 <bdc5d888-0d9f-fed2-8a74-c42ae7e6b810@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bdc5d888-0d9f-fed2-8a74-c42ae7e6b810-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, PREETHAM RAMACHANDRA <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org


On 28/11/16 13:05, Mikko Perttunen wrote:
> On 24.11.2016 09:43, PREETHAM RAMACHANDRA wrote:
>> From: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

I did not receive the original (please CC linux-tegra as well if you did
not originally), but there should be some description here.

>> Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  .../bindings/ata/nvidia,tegra124-ahci.txt          | 48
>> ++++++++++++++++------
>>  1 file changed, 36 insertions(+), 12 deletions(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>> b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>> index 66c83c3..446214f 100644
>> --- a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>> +++ b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>> @@ -1,9 +1,9 @@
>> -Tegra124 SoC SATA AHCI controller
>> +Tegra SoC SATA AHCI controller
>>
>>  Required properties :
>> -- compatible : For Tegra124, must contain "nvidia,tegra124-ahci". 
>> Otherwise,
>> -  must contain '"nvidia,<chip>-ahci", "nvidia,tegra124-ahci"', where
>> <chip>
>> -  is tegra132.
>> +- compatible : Must be one of:
>> +  - Tegra124 : "nvidia,tegra124-ahci"
>> +  - Tegra210 : "nvidia,tegra210-ahci"
>>  - reg : Should contain 2 entries:
>>    - AHCI register set (SATA BAR5)
>>    - SATA register set
> 
> I think you added a new set in the first patch, AUX; you should add it
> here as well.
> 
>> @@ -13,8 +13,6 @@ Required properties :
>>  - clock-names : Must include the following entries:
>>    - sata
>>    - sata-oob
>> -  - cml1
>> -  - pll_e
>>  - resets : Must contain an entry for each entry in reset-names.
>>    See ../reset/reset.txt for details.
>>  - reset-names : Must include the following entries:
>> @@ -24,9 +22,35 @@ Required properties :
>>  - phys : Must contain an entry for each entry in phy-names.
>>    See ../phy/phy-bindings.txt for details.
>>  - phy-names : Must include the following entries:
>> -  - sata-phy : XUSB PADCTL SATA PHY
>> -- hvdd-supply : Defines the SATA HVDD regulator
>> -- vddio-supply : Defines the SATA VDDIO regulator
>> -- avdd-supply : Defines the SATA AVDD regulator
>> -- target-5v-supply : Defines the SATA 5V power regulator
>> -- target-12v-supply : Defines the SATA 12V power regulator
>> +  - For T124:
>> +    - sata-phy : XUSB PADCTL SATA PHY
>> +  - For T210:
>> +    - sata-0
>> +- For T124:
>> +  - hvdd-supply : Defines the SATA HVDD regulator
>> +  - vddio-supply : Defines the SATA VDDIO regulator
>> +  - avdd-supply : Defines the SATA AVDD regulator
>> +  - target-5v-supply : Defines the SATA 5V power regulator
>> +- For T210:
>> +  - l0-hvddio-sata-supply : Defines the SATA HVDDIO regulator
>> +  - l0-dvddio-sata-supply : Defines the SATA DVDDIO regulator
>> +  - hvdd-pex-pll-e-supply : Defines the PEX PLL_E regulator
>> +  - dvdd-sata-pll-supply  : Defines the SATA PLL regulator
>> +  - hvdd-sata-supply      : Defines the SATA HVDD regulator
>> +- nvidia,disable-features : Must include the following entries:
>> +  - devslp
>> +  - dipm

My understanding is that the AHCI controller requires the SATA powergate
to be enabled. Now we have support for powergates via the genpd
framework we should add the 'power-domains' property for this device.

Do you know if there is any sequencing requirement with regard to
powering on the above rails and the powergate? If not we should check as
we should ensure that we have the proper sequencing.

Cheers
Jon

-- 
nvpublic
