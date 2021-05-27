Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37556C4708B
	for <linux-ide@archiver.kernel.org>; Thu, 27 May 2021 19:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE11613DC
	for <linux-ide@archiver.kernel.org>; Thu, 27 May 2021 19:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhE0TFH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 May 2021 15:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhE0TFH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 May 2021 15:05:07 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F45C061574
        for <linux-ide@vger.kernel.org>; Thu, 27 May 2021 12:03:27 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so1218460otp.4
        for <linux-ide@vger.kernel.org>; Thu, 27 May 2021 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=E7HMoNLxvIBVMviLV8YQVGyMH9ji6kJErU/TIfcY9QI=;
        b=AN5yPs5l1c7yvlYBgaKEAN1P+EN9IqR/uKHWeRTJJrW4dFmMM2eYL0Ej2neuctH6kz
         d17qHKCqF5STeO8z5S77uytcf/R7Ss62ilKw8z32cBS6BX8lU4jpAgKOhda52Bbrd1A2
         aT5eMzNAzmTRDEPOpKCmtHwEjd2J7wOCP1bwH7OTmVrOp2LraRz3sH1Zd9sujV1RMfgX
         OILkpM9h13q4N+FwF/Aj9jDmFebeqEPWTK56RYbTf/ZZp4kCNwmzBEeDmya9phGTVwpx
         AKnczPLd9/3nnONpjHVTClQRgzj6quaGrILAQ0w09k2opSoGY4GNE7UCU/MBa3zyaY0N
         KEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E7HMoNLxvIBVMviLV8YQVGyMH9ji6kJErU/TIfcY9QI=;
        b=QtgeFPTqLiB1AaAqwTgV0xwN4U6pVbvE7Pr/Z884rOb16OdKtG/akozBaQznuapKta
         bZFdlnPYVt3mo+OHDWMf4nR9lz0B9ptn7XYPutReGpGowJWFlq0G5BT4cszU1OlXocHe
         VIZL2po0ivjBZgPqc8QUNyISGKR2MnzhA61CxDgYz9qGCAF2xOy+khCc7mAyba7OU4Hq
         KYfgJt2w9KvIqglqixNNpugAS7slN54cx3qYohbyoKrA2aL8oOWGrFrPpCERr10aSZKf
         T7a90pzcASYSTANvf8KYeiwP0dVsVmkdudhLt03vfjZ+Av6uLHAxlG3upTt20VYQj/Fn
         xPrA==
X-Gm-Message-State: AOAM532Mcp2ErIsSu6Ugoomzh2uh4hYZBuJ+x8oXPOxCVxVKYjgnHW9/
        B+ZrHQaeKDJ5n22fpoVs+voQ4R5sbqPScQ==
X-Google-Smtp-Source: ABdhPJzjP8T3443SRYO16gXcfMDQJ8Q45RPfdys/2dh4dA13Tn4HRes5ZKB4gwgZg3MOM4e+j/g56Q==
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr3934670otl.18.1622142206258;
        Thu, 27 May 2021 12:03:26 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id k18sm707662otj.42.2021.05.27.12.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 12:03:25 -0700 (PDT)
Subject: Re: [PATCH v2] pata_ep93xx: fix deferred probing
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        linux-ide@vger.kernel.org
References: <509fda88-2e0d-2cc7-f411-695d7e94b136@omprussia.ru>
 <946c838b-0a9f-dfd0-70ac-a0c67c57deea@omp.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <934957f3-ff80-ae1d-8839-d5ffe2a952d1@kernel.dk>
Date:   Thu, 27 May 2021 13:03:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <946c838b-0a9f-dfd0-70ac-a0c67c57deea@omp.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/27/21 12:39 PM, Sergey Shtylyov wrote:
> Hello!
> 
> On 3/20/21 11:32 PM, Sergey Shtylyov wrote:
> 
>> The driver overrides the error codes returned by platform_get_irq() to
>> -ENXIO, so if it returns -EPROBE_DEFER, the driver would fail the probe
>> permanently instead of the deferred probing.  Propagate the error code
>> upstream, as it should have been done from the start...
>>
>> Fixes: 2fff27512600 ("PATA host controller driver for ep93xx")
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
> 
>    Again, 2 months has passed and no feedback whatsoever... the patch has fell
> thru the cracks?

It'd help if you sent out patches like this in a series, instead of
individual ones, when they are addressing the same issue across
multiple drivers. Makes the risk of them getting lost much smaller.

That said, I'll apply this one, thanks.

-- 
Jens Axboe

