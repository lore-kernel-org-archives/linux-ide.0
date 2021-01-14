Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A21C433DB
	for <linux-ide@archiver.kernel.org>; Thu, 14 Jan 2021 15:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C86623A50
	for <linux-ide@archiver.kernel.org>; Thu, 14 Jan 2021 15:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbhANPud (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbhANPuc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2021 10:50:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE1CC061574;
        Thu, 14 Jan 2021 07:49:52 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v67so8704200lfa.0;
        Thu, 14 Jan 2021 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HsYb3ISmwqcZYohpIUCu38MljjWZZ4dkXVTquIJzHZM=;
        b=NIwYlP6CuqvXWqR/JtiP24TUaUTdSrV7XbEJH70mRLVASYG7oo+K3aJLKzV29jd6L2
         Ctn7RmRPom4fJNFQ0IfqSJ3GBOU1FIyA6RC+qDr+DZF75h9L07FUeiphLPn5FCQc7N++
         TFxdmC+d1wJxkFOeJhHGqNc8n7QN1EUlSptf8IyDCOyusf12IIPY3AtZkONN3AjemEpD
         9bylPWnmrrwC5jt779ufPtk3h4169aqlIv41nHRGWWaKdDRWIVHYXCRFs/mmCKf65MdV
         +PrEvItdPSfrDfSIDhQVLj0uya/3kqMPeHvStC94EQHTShsAHFozJKpaSUDhzKcoYgnz
         7o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HsYb3ISmwqcZYohpIUCu38MljjWZZ4dkXVTquIJzHZM=;
        b=ICPrG68Jtw5ALOBVI3K/zNeLTVHO/GVARcTCbeAiS2cvYW1W8kIn31HLMTgKFeJiSe
         IeJ8KcCr1KIfuHRF/1pIEYFHb1M1jnBfxHv6XK/Q9qJ+mlJ3QKPAFBiKpQBjC0j+DQT9
         DU/eQdnH/fWa7AoLHD2nSujTVUjPZa7/sFDEHCiDkR4ukjvD8I3yvBLLnzFpHKZnPe7V
         gHjljOmF3FBNGXT3d8gl+/3ivg1SFU6EPzDAnd81dc4qwtsdnCJbJhA/elHEFuzLUz3q
         bo1+o3L5aZUOdTSInjcyf143XnZxXx0BBXn7uEC1rNKS5odIheDVUpKANXwnqCbbB714
         9qWw==
X-Gm-Message-State: AOAM531+mhk0LnHERGSKTu1e+Hl4/JjVFwecSbdknE+h/NBpghINcCkM
        y8tIUYYPu1wVqQUWj3LYJ50=
X-Google-Smtp-Source: ABdhPJwo9oVXjah7NnQ1zOABnQ0HZUZbeISWJjKo5Pe+t4Kk82UHcevH1dt0nRpp2K8MjW2ug8BWWw==
X-Received: by 2002:a19:c3cb:: with SMTP id t194mr3348315lff.599.1610639390391;
        Thu, 14 Jan 2021 07:49:50 -0800 (PST)
Received: from [192.168.1.101] ([178.176.75.106])
        by smtp.gmail.com with ESMTPSA id n20sm584377lfh.133.2021.01.14.07.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 07:49:49 -0800 (PST)
Subject: Re: [PATCH] ata: remove redundant error print in
 rb532_pata_driver_probe
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
To:     menglong8.dong@gmail.com, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
References: <20210112023619.5713-1-dong.menglong@zte.com.cn>
 <33bb1cd2-c202-0fd5-733d-b44e7e8fa92c@gmail.com>
Message-ID: <d9ce7fd8-00fc-c42d-5086-20aa0592213e@gmail.com>
Date:   Thu, 14 Jan 2021 18:49:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <33bb1cd2-c202-0fd5-733d-b44e7e8fa92c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/12/21 2:15 PM, Sergei Shtylyov wrote:

[...]
>> From: Menglong Dong <dong.menglong@zte.com.cn>
>>
>> Coccinelle reports a redundant error print in rb532_pata_driver_probe.
>> As 'platform_get_irq' already prints the error message, error print
>> here is redundant and can be removed.
>>
>> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
>> ---
>>  drivers/ata/pata_rb532_cf.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
>> index 479c4b29b856..dcde84f571c4 100644
>> --- a/drivers/ata/pata_rb532_cf.c
>> +++ b/drivers/ata/pata_rb532_cf.c
>> @@ -115,10 +115,8 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	irq = platform_get_irq(pdev, 0);
>> -	if (irq <= 0) {
>> -		dev_err(&pdev->dev, "no IRQ resource found\n");
>> +	if (irq <= 0)
>>  		return -ENOENT;
> 
>    This still beaks the probe deferral. :-(
>    But that's another problem...

   BTW, your patch summary looks quite wrong -- we need the prefix to specify the patch locus,
like this:

pata_rb532_cf: remove redundant error printing in the probe() method

   I.e. "ata: " may even be omitted (your choise though).

> [...]

MBR, Sergei
