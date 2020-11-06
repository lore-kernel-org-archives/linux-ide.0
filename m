Return-Path: <SRS0=A6T3=EM=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42CCC388F2
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 16:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E6922202
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 16:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ml3t7Jat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgKFQrS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 6 Nov 2020 11:47:18 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17668 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQrS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 6 Nov 2020 11:47:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa57e180000>; Fri, 06 Nov 2020 08:47:20 -0800
Received: from [10.2.59.206] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 16:47:17 +0000
Subject: Re: [PATCH v1 1/4] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1604628968-1501-1-git-send-email-skomatineni@nvidia.com>
 <1604628968-1501-2-git-send-email-skomatineni@nvidia.com>
 <20201106161517.GA3290506@bogus>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <1b664477-c49b-2e45-11f7-924d41782de5@nvidia.com>
Date:   Fri, 6 Nov 2020 08:47:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106161517.GA3290506@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604681240; bh=Wi3FOqlGOutZLqAlmzfVvCaaPrLMjU7AUNAseqYeTfE=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=ml3t7Jat0LElQXsLyUv83Ef1oFQvL+GkhhpnT3WYJ7wlWydkJI4Ivh5TKN2Mlur8s
         wtkaURkYdPYfiPF1JPDWFbi+LzZKhiE0fImm5xCRQxxePywIlpnDb5d5a5L31tB1dx
         QuiqcGkTRWtCVIPeL5ISpq1VlkLvu3cAljmGyq/H7PhDtvAfa3QehZut/rWbNlqoCk
         C/WlIK+d2VT4wJNvVH5vdw1WH5pdA9CUgnZCVq7id6vJiH/s945m59zbRkmvdoU7+c
         Wh67vdfuJghM+OM36QkxrrjR+5KokLjZcq5M62KFFZM66YK/sfTv8DSLdpzk+irdTd
         icTNoSRHY080A==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 11/6/20 8:15 AM, Rob Herring wrote:
> On Thu, Nov 05, 2020 at 06:16:05PM -0800, Sowjanya Komatineni wrote:
>> This patch converts text based dt-binding document to YAML based
>> dt-binding document.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 152 +++++++++++++++++++++
>>   .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 ------
>>   2 files changed, 152 insertions(+), 44 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>> new file mode 100644
>> index 0000000..ac20f6e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>> @@ -0,0 +1,152 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/ata/nvidia,tegra-ahci.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Tegra AHCI SATA Controller
>> +
>> +maintainers:
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +  - Jonathan Hunter <jonathanh@nvidia.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra124-ahci
>> +      - nvidia,tegra132-ahci
>> +      - nvidia,tegra210-ahci
>> +
>> +  reg:
>> +    minItems: 2
>> +    maxItems: 3
>> +    items:
>> +      - description: AHCI registers
>> +      - description: SATA configuration and IPFS registers
>> +      - description: SATA AUX registers
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    maxItems: 2
> Don't need maxItems, implied by the size of 'items'.
>
>> +    items:
>> +      - const: sata
>> +      - const: sata-oob
>> +
>> +  clocks:
>> +    maxItems: 2
>> +    description:
>> +      Must contain an entry for each entry in clock-names.
>> +      See ../clocks/clock-bindings.txt for details.
> Drop 'description'. Says nothing specific to this binding.
>
>> +
>> +  reset-names:
>> +    maxItems: 3
> Need to define what each reset is.
reset-names are specified as conditional below.
>
>> +
>> +  resets:
>> +    maxItems: 3
>> +    description:
>> +      Must contain an entry for each entry in reset-names.
>> +      See ../reset/reset.txt for details.
> Drop 'description'. Says nothing specific to this binding.
>
>> +
>> +  phy-names:
>> +    items:
>> +      - const: sata-0
>> +
>> +  phys:
>> +    maxItems: 1
>> +    description:
>> +      Must contain an entry for each entry in phy-names.
>> +      See ../phy/phy-bindings.txt for details.
> Drop 'description'. Says nothing specific to this binding.
>
>> +
>> +  hvdd-supply:
>> +    description: SATA HVDD regulator supply.
>> +
>> +  vddio-supply:
>> +    description: SATA VDDIO regulator supply.
>> +
>> +  avdd-supply:
>> +    description: SATA AVDD regulator supply.
>> +
>> +  target-5v-supply:
>> +    description: SATA 5V power regulator supply.
>> +
>> +  target-12v-supply:
>> +    description: SATA 12V power regulator supply.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clock-names
>> +  - clocks
>> +  - reset-names
>> +  - resets
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nvidia,tegra124-ahci
>> +              - nvidia,tegra132-ahci
>> +    then:
>> +      properties:
>> +        reg:
>> +          maxItems: 2
>> +        reset-names:
>> +          minItems: 3
>> +          items:
>> +            - const: sata
>> +            - const: sata-oob
>> +            - const: sata-cold
>> +        resets:
>> +          minItems: 3
> This doesn't need to be conditional.

Reason for specifying reset-names as conditional is as items are ordered 
list, index: 0 - sata, 1 - sata-oob, and 2 - sata-cold

Tegra124 thru Tegra210 has all 3 resets but Tegra186 don't have sata-oob 
and using reset-names as sata, sata-cold will change index of sata-cold 
and I see dtbs_check shows error for sata-cold as index being wrong.

So added conditional reset-names to specify different order of these 
names for Tegra186 and prior.

Please suggest any other way of forcing order of these names separately.

Otherwise, removing conditional reset-names and specifying in main 
section also need to update all old dtbs to change order of the 
reset-names in device tree to be sata, sata-cold and sata-oob so same 
order will work for all SoC's.

>> +      required:
>> +        - phys
>> +        - phy-names
>> +        - hvdd-supply
>> +        - vddio-supply
>> +        - avdd-supply
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nvidia,tegra210-ahci
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 3
>> +        reset-names:
>> +          minItems: 3
>> +          items:
>> +            - const: sata
>> +            - const: sata-oob
>> +            - const: sata-cold
>> +        resets:
>> +          minItems: 3
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/tegra210-car.h>
>> +    #include <dt-bindings/reset/tegra210-car.h>
>> +
>> +    sata@70020000 {
>> +            compatible = "nvidia,tegra210-ahci";
>> +            reg = <0x0 0x70027000 0x0 0x00002000>, /* AHCI */
>> +                  <0x0 0x70020000 0x0 0x00007000>, /* SATA */
>> +                  <0x0 0x70001100 0x0 0x00010000>; /* SATA AUX */
>> +            interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&tegra_car TEGRA210_CLK_SATA>,
>> +                     <&tegra_car TEGRA210_CLK_SATA_OOB>;
>> +            clock-names = "sata", "sata-oob";
>> +            resets = <&tegra_car 124>,
>> +                     <&tegra_car 123>,
>> +                     <&tegra_car 129>;
>> +            reset-names = "sata", "sata-oob", "sata-cold";
>> +    };
>> diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>> deleted file mode 100644
>> index 12ab2f7..0000000
>> --- a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>> +++ /dev/null
>> @@ -1,44 +0,0 @@
>> -Tegra SoC SATA AHCI controller
>> -
>> -Required properties :
>> -- compatible : Must be one of:
>> -  - Tegra124 : "nvidia,tegra124-ahci"
>> -  - Tegra132 : "nvidia,tegra132-ahci", "nvidia,tegra124-ahci"
>> -  - Tegra210 : "nvidia,tegra210-ahci"
>> -- reg : Should contain 2 entries:
>> -  - AHCI register set (SATA BAR5)
>> -  - SATA register set
>> -- interrupts : Defines the interrupt used by SATA
>> -- clocks : Must contain an entry for each entry in clock-names.
>> -  See ../clocks/clock-bindings.txt for details.
>> -- clock-names : Must include the following entries:
>> -  - sata
>> -  - sata-oob
>> -- resets : Must contain an entry for each entry in reset-names.
>> -  See ../reset/reset.txt for details.
>> -- reset-names : Must include the following entries:
>> -  - sata
>> -  - sata-oob
>> -  - sata-cold
>> -- phys : Must contain an entry for each entry in phy-names.
>> -  See ../phy/phy-bindings.txt for details.
>> -- phy-names : Must include the following entries:
>> -  - For Tegra124 and Tegra132:
>> -    - sata-phy : XUSB PADCTL SATA PHY
>> -- For Tegra124 and Tegra132:
>> -  - hvdd-supply : Defines the SATA HVDD regulator
>> -  - vddio-supply : Defines the SATA VDDIO regulator
>> -  - avdd-supply : Defines the SATA AVDD regulator
>> -  - target-5v-supply : Defines the SATA 5V power regulator
>> -  - target-12v-supply : Defines the SATA 12V power regulator
>> -
>> -Optional properties:
>> -- reg :
>> -  - AUX register set
>> -- clock-names :
>> -  - cml1 :
>> -    cml1 clock should be defined here if the PHY driver
>> -    doesn't manage them. If it does, they should not be.
>> -- phy-names :
>> -  - For T210:
>> -    - sata-phy
>> -- 
>> 2.7.4
>>
