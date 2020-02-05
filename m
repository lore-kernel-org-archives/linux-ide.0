Return-Path: <SRS0=KtmC=3Z=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C030CC3524F
	for <linux-ide@archiver.kernel.org>; Wed,  5 Feb 2020 08:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC952082E
	for <linux-ide@archiver.kernel.org>; Wed,  5 Feb 2020 08:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="bsxD+Byx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgBEIIT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Feb 2020 03:08:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43814 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEIIT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Feb 2020 03:08:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so1307599ljm.10
        for <linux-ide@vger.kernel.org>; Wed, 05 Feb 2020 00:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CyzcclHK+Tfwo+iVG3qc+4Lr5usg95bhnco1uoG1C1A=;
        b=bsxD+Byx9/ha2flINByJn1Ljz1J5A/Kooyw5c05RTBFftoe77SWWUJUMe9+pg4hLcN
         3wdU0lScc7LKooXU7WCPUukwv3sZdMmMp0mYqTQjuUEsxTBsynZgsVhcHUQBp4D8LOIk
         Na0oe/15ywOt4nYI2hslTtSw+g723o8uc7cWmCXLES+MVBCO13QW4RPEaHh0nUySlqP9
         /bCLmJFW4Dc+ldujtC4zPolSiUYMqCs5Nl7Xmty8uqI8a7gN5ypmYNepYN1s+cYr2H61
         WJqnwDHnZMx0EE7sAYM/j8ON1MqcZcmo+gcesba/JjIf1CzdbyyiqPwQDimhu03U9rHT
         9rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CyzcclHK+Tfwo+iVG3qc+4Lr5usg95bhnco1uoG1C1A=;
        b=ReoYmfZckGaR1C5UQDepE5bfPYjz8ix2IwTKAb+D8KAC0z07oC0vvMPjL5Xi2SBXCS
         3dnTORAMzT+OsqP18xx4xyP/50gIsIFSTAduuXpxlkxJJBN49+IL3CnUqyuYPalyjJ+B
         O4AfqNS6lkeS+CQp6e3qHAYvV5ZjryaZBg/UxlED1XFrscFBmRpR2/u6DbgKHtebNPw/
         NqJlTiWahTU/yHLrdFUWuDbS6TSsHFQSbMjVd0ZcgkNZZui09uXZY6uIBqlqyO2ExAvu
         E3vAWsymKj63UeCQrfrP2FiO8va6i23M3Px31n5qqP8/MQo72KVu18Zl2sS9QsRBcUro
         Lbsw==
X-Gm-Message-State: APjAAAWfO1jEINO4WXj6K/P1hwjSqSVrw8ki6XSkvrcwSKF0tHICeZXj
        ufTxHDz3d7bxP/sYP8f3s6BAin/wLiAWpg==
X-Google-Smtp-Source: APXvYqyTQyIBCXrwCzWPDbL6sLLbxI/svrI5YoBK0A142bJ2pxN/EP1kYluKy9Vh5rpSln7nlMK44Q==
X-Received: by 2002:a2e:9013:: with SMTP id h19mr20019467ljg.223.1580890095641;
        Wed, 05 Feb 2020 00:08:15 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:4833:d6db:6540:664e:fe2b:b66c? ([2a00:1fa0:4833:d6db:6540:664e:fe2b:b66c])
        by smtp.gmail.com with ESMTPSA id t27sm12657151ljd.26.2020.02.05.00.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 00:08:14 -0800 (PST)
Subject: Re: [PATCH 07/46] libata-core: remove pointless debugging messages
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org
References: <20200204165547.115220-1-hare@suse.de>
 <20200204165547.115220-8-hare@suse.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5f534c1d-4c86-4c44-f0b3-0cce6a2868b3@cogentembedded.com>
Date:   Wed, 5 Feb 2020 11:08:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-8-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 04.02.2020 19:55, Hannes Reinecke wrote:

> The bus probe is better tracked with the actual calls, and the
> resulting taskfile will be printed with tracepoints anyway.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/ata/libata-core.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index cea065fb6282..0f5715cfa1c4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
[...]
> @@ -6475,11 +6472,8 @@ int ata_port_probe(struct ata_port *ap)
>   	if (ap->ops->error_handler) {
>   		__ata_port_probe(ap);
>   		ata_port_wait_eh(ap);
> -	} else {
> -		DPRINTK("ata%u: bus probe begin\n", ap->print_id);
> +	} else

    You shousd keep {} here, according to the CodingStyle. {} should be
used in all branches if used in any.

>   		rc = ata_bus_probe(ap);
> -		DPRINTK("ata%u: bus probe end\n", ap->print_id);
> -	}
>   	return rc;
>   }
>   

MBR, Sergei
