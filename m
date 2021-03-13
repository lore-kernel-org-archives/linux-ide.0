Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF12C433DB
	for <linux-ide@archiver.kernel.org>; Sat, 13 Mar 2021 10:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F316A64F18
	for <linux-ide@archiver.kernel.org>; Sat, 13 Mar 2021 10:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhCMKQ0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 13 Mar 2021 05:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhCMKQH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 13 Mar 2021 05:16:07 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B23C061574;
        Sat, 13 Mar 2021 02:16:06 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u4so49382544lfs.0;
        Sat, 13 Mar 2021 02:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t9kPPPK9c3pzqxRw4AWNgNZvrvM1Z4sRXVFaTHOAKVc=;
        b=lBzZ/VOBmYuejEFwG4Rr/U0cZT447rRkpkC/mgGH3Sf5WI6HGOIaEMGy8tDOP2Ygcj
         30KOhtoB+T/cQaZ/1Zjl+67D+UHm/z8K4mFSUXgWLw2tIyZv+EHN3wg+7LcNU7IgH52c
         JsnhE3Ffvj60xSnjp5wrKJ4j79Utq7f9dKWBghqapdgK3fw0r3nFN0u5nJkvbJqRmCSS
         7Qo9m98q9DGfhOCyBKiZsEeqR6AHnrJuEI4V/sQLblQHzjCxaQ+QtasZMUaEThVWeakO
         SIOQD+3SozGSDcjgi/7C88XO99+CM975S6lER6WKVsKXSbMeYxNcJvS+BYJ9geVxZJkX
         qQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t9kPPPK9c3pzqxRw4AWNgNZvrvM1Z4sRXVFaTHOAKVc=;
        b=nZO6TUp0XWNSNoHyEiwEJWVLGAk64HbqGFE5DGardTDuF4VdjhXVpa+PbD/bIX94tc
         ubp63/AwQRQcTnNVmASF+TMCnuoOAEU1O7nQkB3zC+j8ERiJBj5nSi7RUNARbVGCrKlZ
         9QN6t5FbyK38dXuu2MiP0t8Ry3VIlsLTmn3erUF4mXm/vhcEF5IQmQKKToucH5fnft+5
         RvM32NH83RLeDOaMAeh4q8U7V1GPpXeVpQgtvcOvIhrYvyUDiIzEaPWHkGxa2qyu6qqh
         +PcmjwXrXNr+tWAmmwLYh0ggyr9ULc2LcQfqbwXHEemwig86LdPnayAY8YjqVJ6h2gHk
         Spow==
X-Gm-Message-State: AOAM5306VeOpYBe82QFUuN/858xGDqSvuP+4H8ZLTw6EpyiRWo70o7kR
        wyvE6FIkPQIAaCmw0WHTuT791Q8siH8gjA==
X-Google-Smtp-Source: ABdhPJzbarSr9Mrazu1IErP9dqEUHHeIepQ9jwt7+O9q6zTuS+/0tkkC8BvU8cw5juakdIllCekOSA==
X-Received: by 2002:a05:6512:442:: with SMTP id y2mr2195195lfk.159.1615630563419;
        Sat, 13 Mar 2021 02:16:03 -0800 (PST)
Received: from [192.168.1.101] ([31.173.82.251])
        by smtp.gmail.com with ESMTPSA id k1sm1979488lfg.3.2021.03.13.02.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 02:16:03 -0800 (PST)
Subject: Re: [PATCH 1/2] ata: delete redundant printing of return value
To:     Wang Qing <wangqing@vivo.com>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1615621644-1657-1-git-send-email-wangqing@vivo.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <20e81aa3-96f9-4f36-e796-1a6f7364afb3@gmail.com>
Date:   Sat, 13 Mar 2021 13:16:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615621644-1657-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello again. :-)

   Now, 2 patches to the different files shouldn't have and identical subject! And the patch
subject should reflect the exact patch locus, e.g. "sata_highbank: delete redundant printing
of return value".

On 3/13/21 10:47 AM, Wang Qing wrote:

> platform_get_irq() has already checked and printed the return value, 
> the printing here is nothing special, it is not necessary at all.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/ata/sata_highbank.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
> index 64b2ef1..a43d42a
> --- a/drivers/ata/sata_highbank.c
> +++ b/drivers/ata/sata_highbank.c
> @@ -469,10 +469,8 @@ static int ahci_highbank_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(dev, "no irq\n");
> +	if (irq <= 0)
>  		return -EINVAL;
> -	}

   Again, this code has more serious issue: it breaks deferred probing by 
overriding the result to -EINVAL...

MBR, Sergei
