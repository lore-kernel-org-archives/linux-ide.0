Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9861CC433E6
	for <linux-ide@archiver.kernel.org>; Thu, 14 Jan 2021 08:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C2423447
	for <linux-ide@archiver.kernel.org>; Thu, 14 Jan 2021 08:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbhANIay (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 14 Jan 2021 03:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbhANIay (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2021 03:30:54 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E6CC061575;
        Thu, 14 Jan 2021 00:30:13 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o10so6822668lfl.13;
        Thu, 14 Jan 2021 00:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+hsu23vaNxsHj1VJoWn/rTScTN7qk/saqdbNWiS5lUM=;
        b=ussEO7QlNXLIjpnlSMpEGFwCuwx6l0utPxd/w/8v6Z5nakcfY6jwTFn4fZRaAHfZ6e
         0wf91wHPETJlf5wWplYwJE80RrmURFhIM71ctcZC82ME4wuh6RC6dRAM+iq4vIudyS6F
         1csSm1qYDt2CogO+CkuN/vT5tEiXJ92lQI13Kf37nCq7B1C3zW4TrY1RudRJSQY2SXm8
         aaC6lS0IUA2oUphnd/O7C+VapgwrQEkTsKQkB35vtDuEFcZgrmoutHP8jlp5k32DVhz0
         VQ322vPikF1URIQdqc9id30M6q/SXJTuQQDHpxNUbAjtJ5ni54CyAkg+Hva5t+g6sCCT
         x6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+hsu23vaNxsHj1VJoWn/rTScTN7qk/saqdbNWiS5lUM=;
        b=kFV1fD5YromLDWUIJcK3h+QpwzFTeXa1zB9hDvAqN1w82h3zYsB0ZcEUNufuTJ8iEy
         JYDp80tz2PRSC6fmQ66Vam3wHgg1TmJzBXcbHeImnqvVUDxUmxRzSS/Tt+myKLZZ8RXI
         KrnktCiELjYlu5qvVUhTgeMSd+bqH3v8pVb/dF7w1kwMjh+cwNWWc9ktMWCTba0tP/jT
         ZzWtksm/L2gdl8c+tFEVAyCEICSxWfaPXaQ4PZqwyNbaV1CW+7SioX7dYm73URzDtsFL
         rMLGAyrkYka0a5B2AduEDZU1xS6YpfVinTdTDsGUAG0YqtapH2DRah+HWzjYON7CmVED
         X+iQ==
X-Gm-Message-State: AOAM533noeJ3yLJbxDpS/2uhQlDksG3UAG3Xq+eq5wQPq72Rt9HnU5MH
        Gl0UiwA1m28e4IcPjIeO7hU=
X-Google-Smtp-Source: ABdhPJxo2z8Ed1CusmSw3wXj3ljD4pOkNJNothFdag4/5ulIa2GRCN6PPRcEwKJlHCWL3bKv01bNIg==
X-Received: by 2002:a05:6512:2202:: with SMTP id h2mr2752495lfu.392.1610613012123;
        Thu, 14 Jan 2021 00:30:12 -0800 (PST)
Received: from [192.168.1.100] ([178.176.79.115])
        by smtp.gmail.com with ESMTPSA id n18sm477520lfh.37.2021.01.14.00.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 00:30:11 -0800 (PST)
Subject: Re: [PATCH] ata: remove redundant error print in
 rb532_pata_driver_probe
To:     Menglong Dong <menglong8.dong@gmail.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <dong.menglong@zte.com.cn>
References: <20210112023619.5713-1-dong.menglong@zte.com.cn>
 <33bb1cd2-c202-0fd5-733d-b44e7e8fa92c@gmail.com>
 <CADxym3bzFPeCXzkO1iFy+Sx7GhwRGo=VkOUzrDE4KMCjMx0v-w@mail.gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <2b6dcfbf-d534-4a2a-53e0-c942a9120a0f@gmail.com>
Date:   Thu, 14 Jan 2021 11:29:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CADxym3bzFPeCXzkO1iFy+Sx7GhwRGo=VkOUzrDE4KMCjMx0v-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 13.01.2021 17:04, Menglong Dong wrote:

[...]
>>>        irq = platform_get_irq(pdev, 0);
>>> -     if (irq <= 0) {
>>> -             dev_err(&pdev->dev, "no IRQ resource found\n");
>>> +     if (irq <= 0)
>>>                return -ENOENT;
>>
>>     This still beaks the probe deferral. :-(
>>     But that's another problem...
>>
>> [...]
>>
>> MBR, Sergei
> 
> What does this 'MBR' mean? I am a novice~~~

    Generally speaking, Master Boot Record. But I also use it to send you My 
Best Regards. :-)

> So, is it better to replace 'platform_get_irq' with
> 'platform_get_irq_optional' here?

    No. You should stop overriding the result to -ENOENT and pass the result
up the call chain instead. In order to do it, you should only check for (irq < 0).

> --
>   Best Regards
>   Menglong Dong

MBR, Sergei
