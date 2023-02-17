Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4174BC05027
	for <linux-ide@archiver.kernel.org>; Fri, 17 Feb 2023 08:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBQIm1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Feb 2023 03:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBQIm0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2023 03:42:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C730C6
        for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2023 00:42:25 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ec30so1768622edb.2
        for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2023 00:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVj7LmZJZPXZ0P94gWzj9CtC5PuU3cB1LoJ/hZVcvvU=;
        b=RXKR91kYoY8t1eAjtzSvgzHe5NTDgc1Bf0Y5VXT1fDBh4Eg5fZblRq65SsI9eg6SaM
         acN5At2lNljA5LdpgcNUYguuwzOjoTUcEunt6LJYTqvrai3cEPDkLY9RBFaUsEkTlxbY
         bNu7neJlEX881UtOYD0ZgcBZ0WqT81HO9Fre9/EQgBBGbpzYhYGF6P8LRof4QGDgwOjk
         F4VysyMZg3kuwPSxuQ/6RV1biR1VOCoNiWLUXRX9hK+2iTMizNLZGOfT3hmtFoibH436
         FkMG9A0w8ZO6Bp0jIJ/pl6E8L0VHN+ERN/q+mZ5iLmjiHSXOn9+JidKjbe97WVF3wcx8
         OLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVj7LmZJZPXZ0P94gWzj9CtC5PuU3cB1LoJ/hZVcvvU=;
        b=rHm47orU6qg/ctO8YQZ8uGmCtomPSo3X6lDpPl8g+yoPLNhMyckPJH0XQh9eZ1S3Jr
         xhCXYNaqo2HD6AGRZeGXB0pG3aaUyCtamG9hmzUfXoOI44loLBFZUiE8q6pe0impwVZC
         083qvvLcsqrZcIW2cn4wkbPml/jD38NmuKo4FNenjCldRPXB7SSsYDBnyQAqpwBE/kVH
         hVtL7tbJ/rCSRGReDiKdrwWrI0VcaA6hUIKasFOzlrX2TO+avpzZR/fvQ4F0hgTewIuX
         duZqzerODych6RwvxVg4wBnV3rnWaOCfscWhf4//01+oYff+HtplIeHhvtXvkcKUMG39
         8fUg==
X-Gm-Message-State: AO0yUKWDzAhSdm78NnkoeroU5kRCY6deAODg6Vv9ATvtqOjbSqxLjjHi
        g7QMhyLIZsPbDugoMSxv2ZL5tA==
X-Google-Smtp-Source: AK7set/YUe4m0PuuVvCfAJfcN7lS6uTcbvXE60HE0ghbiJQmTViJ2LLu87ewTnVqLkvJJqYaUVudsA==
X-Received: by 2002:a17:906:ae50:b0:8b1:20f4:44a3 with SMTP id lf16-20020a170906ae5000b008b120f444a3mr8963111ejb.7.1676623343829;
        Fri, 17 Feb 2023 00:42:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id qq12-20020a17090720cc00b0087f68a2681bsm1860150ejb.96.2023.02.17.00.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:42:23 -0800 (PST)
Message-ID: <2e5a17c2-f0fa-e82e-65ed-fea3637b7e62@linaro.org>
Date:   Fri, 17 Feb 2023 09:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213045432.32614-1-hayashi.kunihiko@socionext.com>
 <2d76ec86-6580-28b0-0f80-a5c497f8cef7@linaro.org>
 <ed864d57-0de3-a169-ebde-628eb84b8a21@socionext.com>
 <0c6dc673-7e11-eec5-ec2d-e00fb2060bf3@linaro.org>
 <c6b86d56-a8a4-825d-ac34-7a9f00e43b42@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c6b86d56-a8a4-825d-ac34-7a9f00e43b42@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 16/02/2023 18:23, Kunihiko Hayashi wrote:
> On 2023/02/14 18:42, Krzysztof Kozlowski wrote:
>> On 14/02/2023 10:33, Kunihiko Hayashi wrote:
>>> Hi Krzysztof,
>>>
>>> On 2023/02/13 18:10, Krzysztof Kozlowski wrote:
>>>> On 13/02/2023 05:54, Kunihiko Hayashi wrote:
>>>>> Add UniPhier SATA controller compatible string to the platform binding.
>>>>> This controller needs maximum three reset controls.
>>>>>
>>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>>> ---
>>>>>    .../devicetree/bindings/ata/ahci-platform.yaml  | 17 +++++++++++++++++
>>>>>    1 file changed, 17 insertions(+)
>>>>>
>>>>> Changes since v1:
>>>>> - Restrict resets property changes with compatible strings
>>>>> - Fix maxItems from two to three
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>>>> b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>>>> index 7dc2a2e8f598..25dd5ffaa517 100644
>>>>> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>>>> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>>>> @@ -45,6 +45,9 @@ properties:
>>>>>                  - marvell,armada-8k-ahci
>>>>>                  - marvell,berlin2-ahci
>>>>>                  - marvell,berlin2q-ahci
>>>>> +              - socionext,uniphier-pro4-ahci
>>>>> +              - socionext,uniphier-pxs2-ahci
>>>>> +              - socionext,uniphier-pxs3-ahci
>>>>>              - const: generic-ahci
>>>>>          - enum:
>>>>
>>>> Top level is saying reset=1, so did you test your bindings?
>>>
>>> Umm, I didn't see any errors on dt_binding_check, anyway I'll add
>>> initial minItems:1 and maxItems:3 on top level first.
>>
>> You need to test also all DTS using these bindings. Yours and others.
>> If you tested the DTS (with proper binding, not one which is basically
>> noop):
>>
>> uniphier-pro4-ace.dtb: sata@65600000: resets: [[27, 12], [27, 28], [37,
>> 3]] is too long
> 
> I've tried updating tools and doing dtbs_check, but I couldn't find this
> error. It seems that this error can't be detected unless there is the
> specified compatible in "select:".
> 
>> BTW, the patch has other errors - just look at the beginning of the
>> file. I cannot see it here in the diff, but when you open the file you
>> should notice it.
> 
> Sorry, but I cannot see anything wrong.
> I'll check the header or something...

If you open the file, you will notice the same compatibles in two
places. In select and in properties. You added your compatibles only to
one place, so not symmetrically.

Best regards,
Krzysztof

