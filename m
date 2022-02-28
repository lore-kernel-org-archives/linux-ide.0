Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487A7C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 28 Feb 2022 14:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiB1Ofu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Feb 2022 09:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiB1Ofu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2022 09:35:50 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08045286DC
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 06:35:10 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6630F3F4B4
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 14:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646058909;
        bh=cY+2Lb+cjTat47mxYF3hRVRAsG+Ud2T/F9b9vhwTP8I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iil41hGdghowujboZBO/eRe7a2roqtnvcCwQu4hnD58jF3iDCJoVH8wePiSnW+V/g
         EBme/C5uoo+lcDEtK2rXe/tDWpSqy+S+GpTXF7hxVO4c7Fg9z0ZBh2Ogpl9h71jXuz
         KyNQpGOnWWq7BJQ86DArdiNFbP4HxkrmOb8+bvMkoZ/o+uM+s9Z5s1/dtrw6Q/hi0h
         nuLNJUAjVTvSNItn8tL+evZ7dnxPn40gnNUU5sGZxJIu+caApRZH8ImQGTS2e8PrrH
         RHguGckW2kExy7p2zhTRgLtH4ZQuiF7RMMd81ky2nGWQmHArqIbrezHUmcu/XvGC32
         QpRvrrbpwuuFg==
Received: by mail-ed1-f69.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so5924438edh.9
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 06:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cY+2Lb+cjTat47mxYF3hRVRAsG+Ud2T/F9b9vhwTP8I=;
        b=o1uv3PWzgFHMDwuFbgyh2H3hCiXowkcMopGvbWvR5E9F100jnc6SgSegqkTsT3BJ/s
         XNBYZ9LkvsZXFOlbitQ4yivQWcnCyWj3S0hLBXAzjbLtq2FaGK1DrRZjSjdb1gs9JQF/
         UDKdMN4dlIrsHEogXBrjYz7c6A3pDbV8S7uoT3uRsJn9QelbOSfg5tbuZ8zm9833cref
         0hC2vtWUHh62AD9HsEYJIX9UESISY+RQYi7y8Hoo4xxuVFEAwckTwPdsKUfs8JlsMV5+
         YQAFfy83n8aEdS0ZhVLHJ7h5U49Jmx+wIhQ+XNxQbTIX2XUnDV1FRMac+s3mwIiWv+5w
         9lHg==
X-Gm-Message-State: AOAM530yEE5O0xKlZaa9tWkM0Hi2cjsEI53QN+DFkCfnYNAPdoPYPsTV
        XSGqXkBKuQqQNEOXoxikPsJVObI1MpDywxaIB3Bt8jYsFbalt+UqKzIekYn++JuHuk5GkiUaDR9
        7gCDrZbDPAQKeXuO0FYQ1TiRlBwpA4dwdH+3fcg==
X-Received: by 2002:a05:6402:50d4:b0:413:2a27:6b56 with SMTP id h20-20020a05640250d400b004132a276b56mr20130671edb.228.1646058907565;
        Mon, 28 Feb 2022 06:35:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDY8R2MrubTXi50w56pdwC6DtPAk6AD2Vm2bz+yDKpsTw4K5OhCQsji/CEA8QLue8RhCTBgw==
X-Received: by 2002:a05:6402:50d4:b0:413:2a27:6b56 with SMTP id h20-20020a05640250d400b004132a276b56mr20130333edb.228.1646058903378;
        Mon, 28 Feb 2022 06:35:03 -0800 (PST)
Received: from [192.168.0.135] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm4416053ejk.119.2022.02.28.06.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:35:02 -0800 (PST)
Message-ID: <ddd09f4f-782f-67e9-ec2f-dd5818ae26c5@canonical.com>
Date:   Mon, 28 Feb 2022 15:35:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Aw: Re: Re: [PATCH v3 1/3] dt-bindings: Convert ahci-platform DT
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
 <8fbbce9e-4fd9-d420-43ef-953e846d29f1@canonical.com>
 <trinity-f1b6ce3a-6f22-4cf8-bf51-a5e7f007dda7-1646057347735@3c-app-gmx-bs53>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <trinity-f1b6ce3a-6f22-4cf8-bf51-a5e7f007dda7-1646057347735@3c-app-gmx-bs53>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 28/02/2022 15:09, Frank Wunderlich wrote:
> Hi,
> 
> looks like i'm not the right person to convert the binding. I have not enough knowledge about yaml, bindings, drivers, ...
> 
> i will try you suggestions for me as a lerning-by-doing approach, but will drop it from the series, same for part2 as it depends on first.
> 
> 
> 
>> Gesendet: Montag, 28. Februar 2022 um 13:38 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
> 
>> On 28/02/2022 13:19, Frank Wunderlich wrote:
> 
>>>> You converted the TXT bindings explicitly, but you missed the comment
>>>> just below the 'reg' about generic-ahci. The generic-ahci never comes alone.
>>>
>>> How should this comment be added? description above/below the compatible-property?
>>> Sorry for dumb questions...this is my first yaml ;)
>>
>> No, this has to be oneOf. See for example
>> Documentation/devicetree/bindings/gpio/gpio-vf610.yaml or many other files.
> 
> Afaik the generic-ahci should be defined optional with one of the others needed, but afaik this will duplicate the list i had.
> 
> so i end up in a struct like this
> 
> compatible:
>   oneOf:
>     - enum:
>       - brcm,iproc-ahci
>       - cavium,octeon-7130-ahci
>       - hisilicon,hisi-ahci
>       - ibm,476gtr-ahci
>       - marvell,armada-3700-ahci
>       - marvell,armada-380-ahci
>       - snps,dwc-ahci
>       - snps,spear-ahci
>     - items:
>       - const: generic-ahci
>       - enum:
>         - brcm,iproc-ahci
>         - cavium,octeon-7130-ahci
>         - hisilicon,hisi-ahci
>         - ibm,476gtr-ahci
>         - marvell,armada-3700-ahci
>         - marvell,armada-380-ahci
>         - snps,dwc-ahci
>         - snps,spear-ahci

That could be one way, but instead I propose to have only second part
(so enum + generic-ahci) for all compatibles mentioned in
ahci_platform.c, which do not customize the driver behavior for these
compatibles..


> 
> 
>>>>> + interrupts:
>>>>> + minItems: 1
>>>>
>>>> You mean maxItems?
>>>
>>> no, minItems, as interrupts suggests 1+ (same for phys)
>>
>> You cannot have infinite number of interrupts... What suggests "1+"?
>> What does it mean "as interrupts suggests"? Do these hardware blocks
>> really have many interrupt lines?
>>
>> The same for phys.
> 
> interrupts/phys is plural of interrupt/phy, so it suggests it can be more than 1.

There is no property named "interrupt" or "phy". There is only
"interrupts", "phys", "gpios", "clocks" etc. regardless whether there is
one or multiple items. This is not specific to bindings, but all DTS
have this.

> 
> as i said i do not know every driver with all possibilities, so i started with the min-items as we need at least 1 interrupt/phy, but yes if there are any limits then they should be added, but this needs extensive knowledge about the drivers/hardware, i don't have.

But the sources of the driver and DTS are available, why not using them?

> 
>>>>> + ports-implemented:
>>>>> + description:
>>>>> + Mask that indicates which ports that the HBA supports
>>>>> + are available for software to use. Useful if PORTS_IMPL
>>>>> + is not programmed by the BIOS, which is true with
>>>>> + some embedded SoCs.
>>>>> + minItems: 1
>>>>
>>>> You need a type and maxItems.
>>>
>>> what will be the type of a mask?
>>
>> `git grep ports-implemented` gives pretty straightfoward answer. All DTS
>> have u32 and driver also uses u32.
> 
> so type should be
> 
> $ref: '/schemas/types.yaml#/definitions/uint32'

Yes. See example schema.

> 
> ?
> 
> it's the only one i've found with u32 looking like a type
> 
> found in Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml

This part I do not understand.

> 
>>>
>>>>> +
>>>>> + resets:
>>>>> + minItems: 1
>>>>
>>>> maxItems?
>>>
>>> if there is a known maximum....
>>
>> Must be. You cannot have infinite number of reset lines... Please check
>> all DTS and drivers. If there is public documentation, it also might be
>> useful.
> 
> "Please check all DTS and drivers." this is impossible for me as doing this as hobby with still limited time ;(

I believe that information - how many resets - is in general findable
via driver sources. In all bindings conversions, if we do not have such
information, we need to try to look it up.

>>>
>>>>> +
>>>>> + target-supply:
>>>>> + description:
>>>>> + regulator for SATA target power
>>>>> +
>>>>> +required:
>>>>> + - compatible
>>>>> + - reg
>>>>> + - interrupts
>>>>> +
>>>>> +patternProperties:
>>>>> + "^sata-port@[0-9]+$":
>>>>
>>>> You limit number of ports to 10. On purpose? What about 0xa? 0xb?
>>>
>>> oh, right, there can be hexadecimal...
>>> thought this is only true for the main-node (address) and have only seen @0, @1 and @2
>>>
>>>>> + type: object
>>>>> + description:
>>>>> + Subnode with configuration of the Ports.
>>>>> +
>>>>> + properties:
>>>>> + reg:
>>>>> + maxItems: 1
>>>>> +
>>>>> + phys:
>>>>> + minItems: 1
>>>>
>>>> maxItems? Why do you put everywhere minItems? Are several phys really
>>>> expected?
>>>
>>> name suggests that it can be more than 1.
>>
>> What do you mean "name suggests"? Name of property? No, it does not
>> suggest that. Name is standard. Please check example schema and other
>> existing schema bindings to see how it is done. For example earlier
>> gpio-vf610.yaml is not bad.
> 
>>> i know from usb subsystem (dwc3 usb3) that a device can have more than one phy, and because in the txt there are no ranges i set everywhere MinItems to 1 with open end as i do not know all possibilities. Anything else will be trial and error...for all properties
>>
>> The bindings need to be specific, so only properties which really,
>> really can have many unknown elements we could keep here some high
>> maxItems limit. In 99% of cases maxItems are clearly defined.
> 
> so i need to do try-and-error, setting maxItems to 1, make checks, if failing look in driver, increase, ...

Why try-and-error? "git grep" works here...

> 
> but this is maybe not the right way to do as dts can contain errors which should not modify the binding.

True, but having stricter limit, even if not fully correct, is better
than having too loose limit. Stricter can be always loosened. Loose
requirement cannot be made stricter.

> 
>>> these are the commands i used:
>>>
>>> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>
>> Install dependencies (libyaml-dev) and you will see first error:
>> Documentation/devicetree/bindings/ata/ahci-platform.yaml:110:1:
>> [warning] wrong indentation: expected 2 but found 0 (indentation)
>>
>> But the one I am thinking is indeed not visible by default. You would
>> need to run it like Rob's boot is running, so add DT_CHECKER_FLAGS=-m.
>> Then you see:
>>
>> Documentation/devicetree/bindings/ata/ahci-platform.example.dt.yaml:0:0:
>> /example-1/sata@f7e90000: failed to match any schema with compatible:
>> ['marvell,berlin2q-achi', 'generic-ahci']
> 
> i try this, but imho it's better to drop the Patch as i'm no expert in this, don't know the HW/drivers enough and this will delay the dts patch too much.
> I thought i can help getting this (simple looking) txt converted to yaml.
> Seems the binding needs to be done by someone who knows the drivers more than me.
> 
> regards Frank


Best regards,
Krzysztof
