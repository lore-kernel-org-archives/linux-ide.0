Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0FFC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 28 Feb 2022 17:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiB1RGy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiB1RGy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2022 12:06:54 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C682D17
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 09:06:15 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E83233FCA2
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 17:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646067973;
        bh=h4FOiTIqGWppiNVb4WN93SVinniWb4652lod3S4x79M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FbS8ZhkRNbarCOEzZsHhQZHfgf6c6wYkkhvDT37YuKYddk8y3ReiHGDgCrumU7+XI
         xtEmFKS/QaU7bfPxNahG+IW4IZGmQUa/4R00kcn1TTK/a4YRZ0v5g9uYVA1pX79v5V
         EkQ4zRhkPs6lAJvf1P41qaKWDaah1SoHJW9DwcxG45SHYmtZrpXqBsgF+f2g2GnUgL
         cIINKY2aBK1v/fSqRfX7hPc8cPDd5Ui9hV2VbPBSw5P6uEGk9mzD5xPQsxNuG027gP
         zjg0bVZdopdf5WAxJMUYhCOtYx4R1wFaD+jz1/+rlrPcuK2EzFGD89nT/5hIiTeoZh
         dXNzKz8f9TIZg==
Received: by mail-ej1-f69.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso5476993eje.20
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 09:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h4FOiTIqGWppiNVb4WN93SVinniWb4652lod3S4x79M=;
        b=F646xGKqsT18nlKHCJojuj2xOSJxQGa/VA3XU/4Ty7rIQzu6olIKnwz1lXlIsj0GzJ
         /VX05byPXV+Y8fXHh3W7S8FDTw2WewC2dOoKCRAasq27X+aguAMXB8KMbwVQzJ51rV7g
         +ohNW1CgllafRX6m8PYhAHEZ5S3DbOTIEM/KEUV5rynScwtbABNuyxjOixCwo+pqpCp9
         4F6apgcJ3cx93b7Xqjbnabtk+8MvPvdVG+pBKj9igeQHVMcj3bE4wn9ELJkIrk/gnKCA
         kiLRSnwJjTbB+WrUtmTvHahFPlK7IshKofZIqYFKLvbuyWarIYvTpTO/tA9BDNQGgNUp
         tTSQ==
X-Gm-Message-State: AOAM530D7z5SXgY55L3SkfMaSc1UeysPCz0K6geT6Q70wUUa6iX8uT/t
        8b409icJN9Ms6jnqGJxyy1u9vXAAwu7SpxsFb9BDemqRc/jmrl5SizjYxYxsPZ9fl22kxl3nqY4
        NLhQOXlUKK36GgTlE6I141XNREoeQsIEgfeM3lA==
X-Received: by 2002:a17:906:199a:b0:6d1:aa59:2927 with SMTP id g26-20020a170906199a00b006d1aa592927mr15322012ejd.215.1646067973495;
        Mon, 28 Feb 2022 09:06:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnrW6Z2hgpLyaCXJWZUUQ0z1Tt4gdOb4FulD2fvmZoIPy6sejI1yUTOFOiqsKx5QAi7Ae9Lw==
X-Received: by 2002:a17:906:199a:b0:6d1:aa59:2927 with SMTP id g26-20020a170906199a00b006d1aa592927mr15321996ejd.215.1646067973232;
        Mon, 28 Feb 2022 09:06:13 -0800 (PST)
Received: from [192.168.0.135] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id pj4-20020a170906d78400b006ce88d5ce8dsm4521931ejb.108.2022.02.28.09.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 09:06:12 -0800 (PST)
Message-ID: <22b1de71-a72a-ecb8-44a2-cf055d2a4fc5@canonical.com>
Date:   Mon, 28 Feb 2022 18:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Aw: Re: Re: Re: [PATCH v3 1/3] dt-bindings: Convert ahci-platform
 DT bindings to yaml
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
 <ddd09f4f-782f-67e9-ec2f-dd5818ae26c5@canonical.com>
 <trinity-bfe6b2d5-52cd-458d-92b2-66216620a4b3-1646067718759@3c-app-gmx-bs53>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <trinity-bfe6b2d5-52cd-458d-92b2-66216620a4b3-1646067718759@3c-app-gmx-bs53>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 28/02/2022 18:01, Frank Wunderlich wrote:
> Hi
> 
>> Gesendet: Montag, 28. Februar 2022 um 15:35 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
>>>> Gesendet: Montag, 28. Februar 2022 um 13:38 Uhr
>>>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
> 
>>>> No, this has to be oneOf. See for example
>>>> Documentation/devicetree/bindings/gpio/gpio-vf610.yaml or many other files.
> 
>>> compatible:
>>>   oneOf:
>>>     - enum:
>>>       - brcm,iproc-ahci
>>>       - cavium,octeon-7130-ahci
>>>       - hisilicon,hisi-ahci
>>>       - ibm,476gtr-ahci
>>>       - marvell,armada-3700-ahci
>>>       - marvell,armada-380-ahci
>>>       - snps,dwc-ahci
>>>       - snps,spear-ahci
>>>     - items:
>>>       - const: generic-ahci
>>>       - enum:
>>>         - brcm,iproc-ahci
>>>         - cavium,octeon-7130-ahci
>>>         - hisilicon,hisi-ahci
>>>         - ibm,476gtr-ahci
>>>         - marvell,armada-3700-ahci
>>>         - marvell,armada-380-ahci
>>>         - snps,dwc-ahci
>>>         - snps,spear-ahci
>>
>> That could be one way, but instead I propose to have only second part
>> (so enum + generic-ahci) for all compatibles mentioned in
>> ahci_platform.c, which do not customize the driver behavior for these
>> compatibles..
> 
> tried many ways of defining it, but none passes with the examples. either to short (first example) or too long (second)
> 
> as far as i understand the logic it should be similar to this:
> 
> properties:
>   compatible:
>     oneOf:
>       - items:
>         - enum:
>           - marvell,berlin2q-achi

You need to extend this enum with all the entries I mentioned before.

>         - const: generic-ahci
>       - items:

No items here, directly enum.

>         - enum:
>           - brcm,iproc-ahci
>           - cavium,octeon-7130-ahci
>           - hisilicon,hisi-ahci
>           - ibm,476gtr-ahci
>           - marvell,armada-3700-ahci
>           - marvell,armada-380-ahci
>           - snps,dwc-ahci
>           - snps,spear-ahci
> 
> this passes the dt-binding_check (examples) for me, but i guess there are many more compatibles defined with the generic.
> 
> dtbs_check found some more like
> 
> 'brcm,iproc-ahci'
> 'marvell,armada-8k-ahci'
> and many more
> 
> it looks like these are also checked in the enum, so the yaml itself look correct, but needs some kind of wildcard instead of the "marvell,berlin2q-achi" as second for the generic-ahci compatible
> 
> regards Frank


Best regards,
Krzysztof
