Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BF4C433DB
	for <linux-ide@archiver.kernel.org>; Tue, 12 Jan 2021 11:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E3B208B3
	for <linux-ide@archiver.kernel.org>; Tue, 12 Jan 2021 11:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhALLQI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Jan 2021 06:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhALLQI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jan 2021 06:16:08 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E6AC061575;
        Tue, 12 Jan 2021 03:15:28 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x20so2730469lfe.12;
        Tue, 12 Jan 2021 03:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=APm8lNC6tsRthrKHh8x0lk8XwUZfEnqHf3TxruRpXZ4=;
        b=ezcp3LJTzPcczKona/Bt7HXW9eKYs3l+I/MdzAJbhSXJxOt+oNB1IRAkWOPd18T5cq
         URWcfZn/TRvkAEX/29SzrDurPEUMWH+IztWozHqYOJWn6bkzJ7/SnN2HmKsGzJxkW4cq
         8IHUJO5xCNvOA3FNs957idAWK6yTJ+pcwZ+SuTt5jXRbVKctLTnNT567OmK+YF0WFPVm
         bB6zhPmK+DXnCwrssHrTXNJJ5vbE15xcOCbG/2sOAgRI+3oTDjKHMO4Pb1gTsYDgbPW4
         RGKE0lrPFw5fTv8jMg5xCjF0sy1ReLAyOu8gDUw8ZIPEOZee3LXQR16fNbu9crYeSYM9
         Om7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=APm8lNC6tsRthrKHh8x0lk8XwUZfEnqHf3TxruRpXZ4=;
        b=dQKiZxJJD4mAZg6mfkx+ilfEFru9Ndu8S6Na85L8HhYZ28DsCLQBmttKalsunQw+MD
         o0hj9dmlbHQloDlECZMYJ3isSKNLBuE2pvKDxcQfOISPkXZjLpvKQL9QtC8x5BOsk9ps
         CS+mCxARA1/Q9026rcsAnygmYjuMEDhzRN2yjZ0QSKy1Aoz++N2emkE3nATv+4/565Qs
         B8t9IAzlwEl8Y10gpq+1jZf/1jFmGjE4H2eNo4tgX+nquiyYivuOnSGrIQjhhHZE96rs
         MnSwK9Q9Tq0epzKmvbzKXEfsNp+24FCEjSjydudgntz7dQQWihF76zKerJ3gakKIOJPd
         g34Q==
X-Gm-Message-State: AOAM533qmJaRUMCdQgIOpik9/7xp3btRSdFg0e1PZhbCMi8V77kKug7w
        xUQYLTAgNelCIwdpaTZtsOQUWSZ2+Wo8qw==
X-Google-Smtp-Source: ABdhPJw+1qiv86mnDHCwjgdDtfJLcl859KZqznUcLc7rVm1ubTj8ZOyXt8uIT4VM8mKIsUdPX43yaA==
X-Received: by 2002:a19:cc56:: with SMTP id c83mr1950431lfg.341.1610450126569;
        Tue, 12 Jan 2021 03:15:26 -0800 (PST)
Received: from [192.168.1.101] ([178.176.77.112])
        by smtp.gmail.com with ESMTPSA id 10sm352059lfh.208.2021.01.12.03.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 03:15:26 -0800 (PST)
Subject: Re: [PATCH] ata: remove redundant error print in
 rb532_pata_driver_probe
To:     menglong8.dong@gmail.com, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
References: <20210112023619.5713-1-dong.menglong@zte.com.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <33bb1cd2-c202-0fd5-733d-b44e7e8fa92c@gmail.com>
Date:   Tue, 12 Jan 2021 14:15:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112023619.5713-1-dong.menglong@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 1/12/21 5:36 AM, menglong8.dong@gmail.com wrote:

> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> Coccinelle reports a redundant error print in rb532_pata_driver_probe.
> As 'platform_get_irq' already prints the error message, error print
> here is redundant and can be removed.
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---
>  drivers/ata/pata_rb532_cf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index 479c4b29b856..dcde84f571c4 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
> @@ -115,10 +115,8 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(&pdev->dev, "no IRQ resource found\n");
> +	if (irq <= 0)
>  		return -ENOENT;

   This still beaks the probe deferral. :-(
   But that's another problem...

[...]

MBR, Sergei
