Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E251AC63697
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CD8206D9
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 19:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TKk4/A8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390047AbgKWTBh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:01:37 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4091 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbgKWTBe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2020 14:01:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc07110000>; Mon, 23 Nov 2020 11:01:37 -0800
Received: from [10.2.49.186] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 19:01:32 +0000
Subject: Re: [PATCH v2 3/6] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
To:     Rob Herring <robh+dt@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
 <1605296218-2510-4-git-send-email-skomatineni@nvidia.com>
 <CAL_JsqKkGmRwsv48xdX7xMSEaTSqdEnWuy0E19eohBxJKMywJg@mail.gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <0a6e99c8-9149-8756-3511-d4cb1814d3c6@nvidia.com>
Date:   Mon, 23 Nov 2020 11:01:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKkGmRwsv48xdX7xMSEaTSqdEnWuy0E19eohBxJKMywJg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606158097; bh=cQOOEZHk9E7IMSrqdkSjQAynq19K5cTIYzc1PC5TT/4=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=TKk4/A8pGOgG08SCtA6LrP5Mt8p0MR+F6vDXfAuCDGOsdINHQQ4kkyDKoehi2cybL
         Amccb+8ZWdjsKIKS5ciDyerdCOaZ0Ss/C9r0MUtiIChI4x+NdzgPibAodfBqdlBbDv
         M6l6S1zXToRJOIIe9A+ivRnrUxtJEb5A9tZnE2PNv6kPxt3gvPpWbQCd11hRzHxeSZ
         Djc6ICGbRwX7oy+v4Lbaxatyae4JaYLhu3bpvEzOCuQgR6kJ0pPoczoqlII2p9s7WN
         fWfHvENmhK5lCnqoTFzwXS4byuIn8PDbTQdBQWVx39KIRtJs6L7zi9qLa1LoHIn0G2
         zRP812XO6DkpA==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 11/20/20 12:17 PM, Rob Herring wrote:
> On Fri, Nov 13, 2020 at 1:36 PM Sowjanya Komatineni
> <skomatineni@nvidia.com> wrote:
>> This patch converts text based dt-binding document to YAML based
>> dt-binding document.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 137 +++++++++++++++++++++
>>   .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 -------
>>   2 files changed, 137 insertions(+), 44 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>> new file mode 100644
>> index 0000000..dbbe460
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>> @@ -0,0 +1,137 @@
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
>> +    items:
>> +      - const: sata
>> +      - const: sata-oob
>> +
>> +  clocks:
>> +    maxItems: 2
>> +
>> +  reset-names:
>> +    items:
>> +      - const: sata
>> +      - const: sata-cold
>> +      - const: sata-oob
>> +
>> +  resets:
>> +    maxItems: 3
>> +
>> +  phy-names:
>> +    items:
>> +      - const: sata-0
>> +
>> +  phys:
>> +    maxItems: 1
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
>> +        resets:
>> +          minItems: 3
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
> The default sizes are 1 cell for address and size, so this will give
> you warnings. You either need to adjust the entries here or add a
> parent node setting the sizes to 2 cells.

Thanks Rob.

tegra210.dtsi already has address and size set to 2 cells in parent node 
of sata.

Do you mean to add parent node and address and size cells set to 2 in 
this yaml example as well?

>
>> +            interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> The error is because you need the include files for these defines.
Will add header file for interrupts in yaml example.
>
>> +            clocks = <&tegra_car TEGRA210_CLK_SATA>,
>> +                     <&tegra_car TEGRA210_CLK_SATA_OOB>;
>> +            clock-names = "sata", "sata-oob";
>> +            resets = <&tegra_car 124>,
>> +                     <&tegra_car 129>,
>> +                     <&tegra_car 123>;
>> +            reset-names = "sata", "sata-cold", "sata-oob";
>> +    };
