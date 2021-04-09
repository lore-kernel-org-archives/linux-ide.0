Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F2C433B4
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 17:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE33610E5
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 17:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhDIRDN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Apr 2021 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhDIRDN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2021 13:03:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51FEC061760;
        Fri,  9 Apr 2021 10:02:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n8so10837092lfh.1;
        Fri, 09 Apr 2021 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2bvODQuDa1cDn0qYG9mTzkQm4Buu1xo+v0u1y8wm87g=;
        b=tbIemSFN6qv2so0TFjO3qi70RV3u8ZE1lqPPozG7sIia4e7uPyUnoZ7bO660sipymU
         UWdO02Ez158K35LvQA0rpGFSp02Dz3odCcIN/JhOUJoQJyhmyrFjLnQLhN+hOXqvjjUh
         KRNFbJXTuAJWGR/uQ5963jJg0f/80ZqW/V6PgbohfdLOQjRmWQyh6Z6Y9BPFl6GgE2pu
         6Hm6K3J2GaJuohrrcRuQRax7HGBM5roieORzLQRhBczrpt0jowT8RHXC35SFJKqcI/xi
         L0sKeF33OK6Zp9v78vIC7lMwgxWUW/gPz9218TG13d/+yWoT+YvE+0LA18Vhnop+siXn
         TWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2bvODQuDa1cDn0qYG9mTzkQm4Buu1xo+v0u1y8wm87g=;
        b=hh74dv4CffJ4XV5HQm7UsFW+Hd0t/0DRV4DVZEcNW3n8FjeuuCGv00G6xd7T9X6t9w
         XUcBzRz4HNsja29yH00YuZgd3YkH2/ivXLKdFO1EtnbzrrtmKsKK+9+A9GSj6Akac2K/
         bV684MXq18ynKj7U2YfNt/KTJqgzijuJLwiAHPgmTrChUt19frnHQ2xcpC+hTtlSrmcK
         vki12/qpQB9CeYNdqMTYttiphzXMsx2/5Rqaj4XTovUs9+OxVnf07GCkmzCj7uTs0OSH
         TaR3jRC1lanw9fzoQmsPI+PAbZz+wj0l52t0teO5IpLqvzSr6aetBJR3MQ/t1LNY7f7U
         zktg==
X-Gm-Message-State: AOAM532EJwaklYGB7j3aMJ+/hfFD8qnzo6oE6lbYeeJZD0uj8sF5DOuA
        xNPNKZPhPfc55pKxVRiMOE9M1jDEupw=
X-Google-Smtp-Source: ABdhPJxXZH89u5ZAp+pXUuQSFdwL+NWTQdoinIJ1bKwgT3X89yTEDny82Q+u1KkVrHYogQdpN6IyEA==
X-Received: by 2002:a05:6512:70c:: with SMTP id b12mr10691463lfs.621.1617987778194;
        Fri, 09 Apr 2021 10:02:58 -0700 (PDT)
Received: from [192.168.1.102] ([178.176.73.141])
        by smtp.gmail.com with ESMTPSA id c2sm329561lfc.221.2021.04.09.10.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 10:02:57 -0700 (PDT)
Subject: Re: [PATCH] pata_ipx4xx_cf: Fix unsigned comparison with less than
 zero
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
To:     angkery <angkery@163.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
References: <20210409135426.1773-1-angkery@163.com>
 <e74ec570-96b6-23ce-edd5-b5a38628963a@gmail.com>
Message-ID: <e6bf7f02-f0b8-b0c4-2253-62a55ea98d17@gmail.com>
Date:   Fri, 9 Apr 2021 20:02:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e74ec570-96b6-23ce-edd5-b5a38628963a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/9/21 7:49 PM, Sergei Shtylyov wrote:

>> From: Junlin Yang <yangjunlin@yulong.com>
>>
>> The return from the call to platform_get_irq() is int, it can be
>> a negative error code, however this is being assigned to an unsigned
>> int variable 'irq', so making 'irq' an int, and change the position to
>> keep the code format.
>>
>> ./drivers/ata/pata_ixp4xx_cf.c:168:5-8:
>> WARNING: Unsigned expression compared with zero: irq > 0
> 
>    I'd understand < 0... but > 0? What tool warned about this issue?
> 
>> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
>> ---
>>  drivers/ata/pata_ixp4xx_cf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
>> index abc0e87..43215a4 100644
>> --- a/drivers/ata/pata_ixp4xx_cf.c
>> +++ b/drivers/ata/pata_ixp4xx_cf.c
>> @@ -135,12 +135,12 @@ static void ixp4xx_setup_port(struct ata_port *ap,
>>  
>>  static int ixp4xx_pata_probe(struct platform_device *pdev)
>>  {
>> -	unsigned int irq;
> 
>    Oops, not sure how I missed that. :-/
>    Thanks for fixing my overlook. :-)

   Forgot to add my

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>

> [...]

MBR, Sergei

