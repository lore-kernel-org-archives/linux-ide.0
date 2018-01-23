From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH V6 1/7] dt-bindings: tegra: add binding documentation
Date: Tue, 23 Jan 2018 17:31:38 +0200
Message-ID: <2c02c25d-e80b-5a4f-b024-602bac94db13@kapsi.fi>
References: <1515482234-24716-1-git-send-email-pchandru@nvidia.com>
 <1515482234-24716-2-git-send-email-pchandru@nvidia.com>
 <f8ce6c14-bbff-2eb1-63ad-951723aa47e7@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([91.232.154.25]:34446 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751206AbeAWPbk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 23 Jan 2018 10:31:40 -0500
In-Reply-To: <f8ce6c14-bbff-2eb1-63ad-951723aa47e7@kapsi.fi>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Preetham Chandru Ramchandra <pchandru@nvidia.com>, thierry.reding@gmail.com, tj@kernel.org
Cc: preetham260@gmail.com, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com

Also the commit subject needs to specify it's about ahci-tegra.

On 01/23/2018 05:30 PM, Mikko Perttunen wrote:
> On 01/09/2018 09:17 AM, Preetham Chandru Ramchandra wrote:
>> From: Preetham Ramchandra <pchandru@nvidia.com>
>>
>> This adds bindings documentation for the
>> AHCI controller on Tegra210
>>
>> Signed-off-by: Preetham Chandru R <pchandru@nvidia.com>
>> ---
>> v4:
>> * changed the commit message
>> * changed 'sata-cold' reset to mandatory for t210 and t124
>> * Removed the regulators for T210 since these regulators
>>    will be enabled in phy driver.
>> v3:
>> * Add AUX register.
>> v2:
>> * change cml1, pll_e and phy regulators as optional
>>    for T210.
>> ---
>>   .../bindings/ata/nvidia,tegra124-ahci.txt          | 38 
>> ++++++++++++++--------
>>   1 file changed, 25 insertions(+), 13 deletions(-)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt 
>> b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>> index 66c83c3e8915..df4dc2c78ee8 100644
>> --- a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>> +++ b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>> @@ -1,20 +1,19 @@
>> -Tegra124 SoC SATA AHCI controller
>> +Tegra SoC SATA AHCI controller
>>   Required properties :
>> -- compatible : For Tegra124, must contain "nvidia,tegra124-ahci".  
>> Otherwise,
>> -  must contain '"nvidia,<chip>-ahci", "nvidia,tegra124-ahci"', where 
>> <chip>
>> -  is tegra132.
>> -- reg : Should contain 2 entries:
>> +- compatible : Must be one of:
>> +  - Tegra124 : "nvidia,tegra124-ahci"
>> +  - Tegra210 : "nvidia,tegra210-ahci"
>> +- reg : Should contain 3 entries:
>>     - AHCI register set (SATA BAR5)
>>     - SATA register set
>> +  - Tegra210 : AUX register set
>>   - interrupts : Defines the interrupt used by SATA
>>   - clocks : Must contain an entry for each entry in clock-names.
>>     See ../clocks/clock-bindings.txt for details.
>>   - clock-names : Must include the following entries:
>>     - sata
>>     - sata-oob
>> -  - cml1
>> -  - pll_e
>>   - resets : Must contain an entry for each entry in reset-names.
>>     See ../reset/reset.txt for details.
>>   - reset-names : Must include the following entries:
>> @@ -24,9 +23,22 @@ Required properties :
>>   - phys : Must contain an entry for each entry in phy-names.
>>     See ../phy/phy-bindings.txt for details.
>>   - phy-names : Must include the following entries:
>> -  - sata-phy : XUSB PADCTL SATA PHY
>> -- hvdd-supply : Defines the SATA HVDD regulator
>> -- vddio-supply : Defines the SATA VDDIO regulator
>> -- avdd-supply : Defines the SATA AVDD regulator
>> -- target-5v-supply : Defines the SATA 5V power regulator
>> -- target-12v-supply : Defines the SATA 12V power regulator
>> +  - For T124:
>> +    - sata-phy : XUSB PADCTL SATA PHY
>> +  - For T210:
>> +    - sata-0
>> +- For T124:
>> +  - hvdd-supply : Defines the SATA HVDD regulator
>> +  - vddio-supply : Defines the SATA VDDIO regulator
>> +  - avdd-supply : Defines the SATA AVDD regulator
>> +  - target-5v-supply : Defines the SATA 5V power regulator
>> +  - target-12v-supply : Defines the SATA 12V power regulator
>> +
>> +Optional properties:
>> +- clock-names :
>> +  - cml1 :
>> +    cml1 clock is required by phy so it is optional to define
>> +    here as phy driver will be enabling this clock.
>> +  - pll_e :
>> +    pll_e is the parent of cml1 clock so it is optional to define
>> +    here as phy driver will be enabling this clock.
>>
> 
> We should drop the pll_e here since CCF should handle that automatically 
> as CML1 is a child clock of it. I also had some primarily cosmetic 
> change suggestions to this in v5. I'd still like to see those go in - 
> it's of course possible to also apply these changes while applying the 
> patch.
> 
> Mikko
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
