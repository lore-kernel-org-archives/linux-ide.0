Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E70EC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 28 Feb 2022 12:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiB1Mit (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Feb 2022 07:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiB1Mis (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2022 07:38:48 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BED192B1
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 04:38:09 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8E1993FCA8
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646051885;
        bh=yBCEUorlg+xBlOPMuzfS7FMt5ush9iHU9TRaKC9MT3M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=DQpjbOys0yb+tqHibyxbOQ+p3ChSG9QTceqi8n5kOpLLU85pNkcg+X44JZp34HEso
         c8bix4vdFFNnPZ7hYoFF7FF2o7VsFvDRXwqs9sfXHZnaDmjb7/bp38k/2Wam0FHBQa
         EGfv5PzEXmRb2sKDs2p40eRsRo4S5dPJnpCHcQBBYoo/81Cwd+guY7Kd2xBVgLii5O
         TzpoNRlFZFBrg7lGL7pBn1HlDk8u7XYl+A66Szm5DoEJDXShJr610P5rEmgwNr1DTn
         eZbPS5xyavLb8Cp71jQO3TdkPDAHISQ/YWQphTCKSNl7pSUSZzkC01IYvZREsLSQjy
         QMYNn+NbLr3yA==
Received: by mail-ed1-f69.google.com with SMTP id dy17-20020a05640231f100b00412897682b4so5793386edb.18
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 04:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yBCEUorlg+xBlOPMuzfS7FMt5ush9iHU9TRaKC9MT3M=;
        b=3NDcvahAZ675Z4eIIF9cDMe3dXuV4KFcvxQumxLVso66uXc4ymNTVJmX4zZxAE1QRP
         U/I1z1ZzHwe66VC2XSTLwk7Rk95GgQZoHiimYbR/XeEYtzLmxfxZWLH0Fs8hQazDlNoC
         BU1fcoDrmhymiz/RNo48DAiEl/MBPgH4QYQpM6RGzCbsHf053/Vnpkz5SuPKGLTwx+Te
         ZirlDFaoY/8xF0zKiYpHYwdZuDAIoI/vuPwAPHJV2Zeivo1CCvSzgdKOzmS+5UB/vBZF
         Z64vask00u4I0Bu4VGN4LH1AKa/HCtkY7+Znbmub2GDDYDI9LUhTiWUDod5aUx14VIzc
         WWqg==
X-Gm-Message-State: AOAM531BUmxr/ikTj/CVCdXklChOtm+APGbYxcALZruOcvPK0jRz9DoR
        vVwkrXD0MPUjRdRw2yOFVm08NNEayYMOD2UE/T+m+MwYFTCU9E9U9JYLHrsG/Tfr3M1Z6JSq7L0
        AFoGVVUWlrfaIW1b0D0Z5rj7c8u/ZbbxjcD5b4Q==
X-Received: by 2002:a17:906:30d1:b0:6cf:c116:c9d3 with SMTP id b17-20020a17090630d100b006cfc116c9d3mr14139278ejb.245.1646051885100;
        Mon, 28 Feb 2022 04:38:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcabmO//fO9WrOuT+Tx7mXA7Z9TCYDStZV57LXD69zGXPBLH9Zc2063RzietPBwBz5cKiOxg==
X-Received: by 2002:a17:906:30d1:b0:6cf:c116:c9d3 with SMTP id b17-20020a17090630d100b006cfc116c9d3mr14139255ejb.245.1646051884758;
        Mon, 28 Feb 2022 04:38:04 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id x12-20020a50d9cc000000b0040f70fe78f3sm6005540edj.36.2022.02.28.04.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 04:38:03 -0800 (PST)
Message-ID: <8fbbce9e-4fd9-d420-43ef-953e846d29f1@canonical.com>
Date:   Mon, 28 Feb 2022 13:38:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Aw: Re: [PATCH v3 1/3] dt-bindings: Convert ahci-platform DT
 bindings to yaml
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220227182800.275572-1-linux@fw-web.de>
 <20220227182800.275572-2-linux@fw-web.de>
 <4c3303f5-7af5-9974-7bea-b7f0d6c7ef53@canonical.com>
 <trinity-ac45bde6-392d-4810-8aad-9a06d2bcd85a-1646050780475@3c-app-gmx-bs53>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <trinity-ac45bde6-392d-4810-8aad-9a06d2bcd85a-1646050780475@3c-app-gmx-bs53>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 28/02/2022 13:19, Frank Wunderlich wrote:
> Hi Krzysztof,
> 
> thanks for first review.
> 
>> Gesendet: Montag, 28. Februar 2022 um 11:08 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
> 
>> On 27/02/2022 19:27, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
> 
>> You missed devicetree mailing list (corrupted address).
> 
> sorry, devicetree ML was To, but forget the Cc-Header (prepared addresses in coverletter)
> 
>>> imho all errors should be fixed in the dts not in the yaml...
> 
>>> -- reg               : <registers mapping>
>>> -
>>> -Please note that when using "generic-ahci" you must also specify a SoC specific
>>> -compatible:
>>> -	compatible = "manufacturer,soc-model-ahci", "generic-ahci";
> ...
>>> +properties:
>>> +  compatible:
>>> +    contains:
>>> +      enum:
>>> +        - brcm,iproc-ahci
>>> +        - cavium,octeon-7130-ahci
>>> +        - generic-ahci
>>> +        - hisilicon,hisi-ahci
>>> +        - ibm,476gtr-ahci
>>> +        - marvell,armada-380-ahci
>>> +        - marvell,armada-3700-ahci
>>
>> Order entries alphabetically.
> 
> ok
> 
>>> +        - snps,dwc-ahci
>>> +        - snps,spear-ahci
>>
>> You converted the TXT bindings explicitly, but you missed the comment
>> just below the 'reg' about generic-ahci. The generic-ahci never comes alone.
> 
> How should this comment be added? description above/below the compatible-property?
> Sorry for dumb questions...this is my first yaml ;)

No, this has to be oneOf. See for example
Documentation/devicetree/bindings/gpio/gpio-vf610.yaml or many other files.

> 
> e.g.
> 
> properties:
>   compatible:
>     description:
>       Please note that when using "generic-ahci" you must also specify a SoC specific
>       compatible:
>          compatible = "manufacturer,soc-model-ahci", "generic-ahci";
>     contains:
>       enum:
> 
>> The snps,dwc-ahci could come, although history shows that Synapsys
>> blocks are commonly re-used and they should have specific compatible.
>> Current users still have single snps,dwc-ahci, so it could be fixed a
>> bit later.
>>
>> On the other hand, I expect to fix all the DTS in the same series where
>> the bindings are corrected.
> 
> i don't know the marvell/broadcom-hw so i cannot fix them.
> Just converted the txt to check my rockchip sata nodes and to be more
> future-proof (no more exceptions like the marvell/broadcom)
> 
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>> +    maxItems: 3
>>
>> Items should be described. Next or this patch could add also clock-names.
> 
> i was told to drop clock-names (same for interrupt-names and reset-names) from dts
> and in txt it was not there so have not added it
> 
> https://patchwork.kernel.org/comment/24755956/

OK, then let's skip them now. The clock items should be described if it
is possible.

> 
>>> +
>>> +  interrupts:
>>> +    minItems: 1
>>
>> You mean maxItems?
> 
> no, minItems, as interrupts suggests 1+ (same for phys)

You cannot have infinite number of interrupts... What suggests "1+"?
What does it mean "as interrupts suggests"? Do these hardware blocks
really have many interrupt lines?

The same for phys.

> 
>>> +
>>> +  ahci-supply:
>>> +    description:
>>> +      regulator for AHCI controller
>>> +
>>> +  dma-coherent:
>>> +    description:
>>> +      Present if dma operations are coherent
>>
>> Skip description, it's obvious. Just 'true'.
> 
> ok, took this from the txt
> 
>>> +
>>> +  phy-supply:
>>> +    description:
>>> +      regulator for PHY power
>>> +
>>> +  phys:
>>> +    minItems: 1
>>
>> maxItems?
>>> +
>>> +  phy-names:
>>> +    minItems: 1
>>
>> Describe the items.
>>
>>> +
>>> +  ports-implemented:
>>> +    description:
>>> +      Mask that indicates which ports that the HBA supports
>>> +      are available for software to use. Useful if PORTS_IMPL
>>> +      is not programmed by the BIOS, which is true with
>>> +      some embedded SoCs.
>>> +    minItems: 1
>>
>> You need a type and maxItems.
> 
> what will be the type of a mask?

`git grep ports-implemented` gives pretty straightfoward answer. All DTS
have u32 and driver also uses u32.

> 
>>> +
>>> +  resets:
>>> +    minItems: 1
>>
>> maxItems?
> 
> if there is a known maximum....

Must be. You cannot have infinite number of reset lines... Please check
all DTS and drivers. If there is public documentation, it also might be
useful.

> 
>>> +
>>> +  target-supply:
>>> +    description:
>>> +      regulator for SATA target power
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +
>>> +patternProperties:
>>> +  "^sata-port@[0-9]+$":
>>
>> You limit number of ports to 10. On purpose? What about 0xa? 0xb?
> 
> oh, right, there can be hexadecimal...
> thought this is only true for the main-node (address) and have only seen @0, @1 and @2
> 
>>> +    type: object
>>> +    description:
>>> +      Subnode with configuration of the Ports.
>>> +
>>> +    properties:
>>> +      reg:
>>> +        maxItems: 1
>>> +
>>> +      phys:
>>> +        minItems: 1
>>
>> maxItems? Why do you put everywhere minItems? Are several phys really
>> expected?
> 
> name suggests that it can be more than 1.

What do you mean "name suggests"? Name of property? No, it does not
suggest that. Name is standard. Please check example schema and other
existing schema bindings to see how it is done. For example earlier
gpio-vf610.yaml is not bad.

> i know from usb subsystem (dwc3 usb3) that a device can have more than one phy, and because in the txt there are no ranges i set everywhere MinItems to 1 with open end as i do not know all possibilities. Anything else will be trial and error...for all properties

The bindings need to be specific, so only properties which really,
really can have many unknown elements we could keep here some high
maxItems limit. In 99% of cases maxItems are clearly defined.

> 
>>> +
>>> +      target-supply:
>>> +        description:
>>> +          regulator for SATA target power
>>> +
>>> +    required:
>>> +      - reg
>>> +
>>> +    anyOf:
>>> +      - required: [ phys ]
>>> +      - required: [ target-supply ]
>>> +
>>> +allOf:
>>> +- $ref: "sata-common.yaml#"
>>
>> This goes before properties.
>>
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +        sata@ffe08000 {
>>
>> Wrong indentation. It starts just below |
> 
> will fix it
> 
>>> +               compatible = "snps,spear-ahci";
>>> +               reg = <0xffe08000 0x1000>;
>>> +               interrupts = <115>;
>>> +        };
>>> +  - |
>>> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +        #include <dt-bindings/clock/berlin2q.h>
>>> +        sata@f7e90000 {
>>> +                compatible = "marvell,berlin2q-achi", "generic-ahci";
>>
>> This clearly won't pass your checks. I don't think you run
>> dt_binding_check. You must test your bindings first.
> 
> i had them tested ...needed to add the includes...after that the dt_bindings_check was without errors/warnings
> 
> these are the commands i used:
> 
> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml
> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml

Install dependencies (libyaml-dev) and you will see first error:
Documentation/devicetree/bindings/ata/ahci-platform.yaml:110:1:
[warning] wrong indentation: expected 2 but found 0 (indentation)

But the one I am thinking is indeed not visible by default. You would
need to run it like Rob's boot is running, so add DT_CHECKER_FLAGS=-m.
Then you see:

Documentation/devicetree/bindings/ata/ahci-platform.example.dt.yaml:0:0:
/example-1/sata@f7e90000: failed to match any schema with compatible:
['marvell,berlin2q-achi', 'generic-ahci']




Best regards,
Krzysztof
