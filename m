Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A71C433DB
	for <linux-ide@archiver.kernel.org>; Sat, 13 Mar 2021 12:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A5864E07
	for <linux-ide@archiver.kernel.org>; Sat, 13 Mar 2021 12:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhCMMH7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 13 Mar 2021 07:07:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231392AbhCMMHc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 13 Mar 2021 07:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615637251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8fRlwpZMxCpP6SfCb4KtSjSpn9aOFnkT138tspXGQg=;
        b=Fgq0w50tRKhke98to+iqxVV16CAAfnpndGWbw+bmuhd62825B9vdogoJb3d8efCVLfxjAZ
        gnkJ/haw1hVppOBZqz0rRXeBeD7Zw4c7yrvwmVd/OYOOQcbiqceAY6p4UZ2TE/UvAGDYG/
        UHIOfbYjZrfCXN7gvl8gZEEyh/Ng15s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-aZ0sJTu4P72YAWQ_VZBOVg-1; Sat, 13 Mar 2021 07:07:28 -0500
X-MC-Unique: aZ0sJTu4P72YAWQ_VZBOVg-1
Received: by mail-ej1-f71.google.com with SMTP id h14so10978355ejg.7
        for <linux-ide@vger.kernel.org>; Sat, 13 Mar 2021 04:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J8fRlwpZMxCpP6SfCb4KtSjSpn9aOFnkT138tspXGQg=;
        b=TgmRguLCqqD3eGJlXIXiaVLPW4pr0F4afXpp8BCa7T3ioiMMhvB9TyrqoxkKewdyti
         L8nG6ZuE/XY2j7tyfUWNIAy1syRS6BNZTn0BJQOK5Os5H3BNyczBPL7qKFLyzUM8qq1L
         G7uB9tUEvbLP+uQjfghDRSz4E3sOs4/QrQ/HrFGgKRO9zbi0uUkHsj2PHzWH7TFgK/hH
         ezqaHsRYLaSwZGb6yPMEq52OcaXhSw3DQD6cHSy6SSHu/FQaxiLcXvVn3ucCE3mnhB0M
         +Vwr65f8iDHXHfGBuXMPKa69i/SQCMIGAgjuPE53jZPmuwb7dSpMBxDjfV5+8qnlId42
         IjAw==
X-Gm-Message-State: AOAM533OyI7H+shCwHiOSLMuU3cZvt7lAAzwcR1hxNsxAcdvpoBuc7y4
        pN5LUMOcAAkDjX/jEBAHaoHJpHxfD20RNGEOWt7lFjTkEAENbS/EQEWsFaEaFvuX5GUWY10oXXL
        ct60Oc5vAcWWqqwMxINwW
X-Received: by 2002:a17:906:489:: with SMTP id f9mr13363207eja.428.1615637247329;
        Sat, 13 Mar 2021 04:07:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziitgAP7Sysc+qmE9B/FQJ+p0vDJWp2A2Jxduls9RUQjaNdQjrMJmzFAFaD4Ha92l8u2OUog==
X-Received: by 2002:a17:906:489:: with SMTP id f9mr13363195eja.428.1615637247155;
        Sat, 13 Mar 2021 04:07:27 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u17sm4356196edr.0.2021.03.13.04.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 04:07:26 -0800 (PST)
Subject: Re: [PATCH 1/2] ata: delete redundant printing of return value
To:     Wang Qing <wangqing@vivo.com>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1615621617-1343-1-git-send-email-wangqing@vivo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <90604319-c111-2070-54bc-038e6a487150@redhat.com>
Date:   Sat, 13 Mar 2021 13:07:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1615621617-1343-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 3/13/21 8:46 AM, Wang Qing wrote:
> platform_get_irq() has already checked and printed the return value, 
> the printing here is nothing special, it is not necessary at all.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/ata/libahci_platform.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index de638da..2e7ea75
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -582,11 +582,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>  	int i, irq, n_ports, rc;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		if (irq != -EPROBE_DEFER)
> -			dev_err(dev, "no irq\n");
> +	if (irq <= 0)
>  		return irq;
> -	}
>  
>  	hpriv->irq = irq;
>  
> 

