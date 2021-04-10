Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B480DC433ED
	for <linux-ide@archiver.kernel.org>; Sat, 10 Apr 2021 08:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFC761005
	for <linux-ide@archiver.kernel.org>; Sat, 10 Apr 2021 08:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhDJIrF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 10 Apr 2021 04:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhDJIrE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 10 Apr 2021 04:47:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D07FC061762;
        Sat, 10 Apr 2021 01:46:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f17so6335063lfu.7;
        Sat, 10 Apr 2021 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=da/l24eP3nYB45qy4cZI7dM0NqKY848ZDOT8xVxHEUI=;
        b=milV8WU6UhYWndfZDIcfYda2ZqUi2CrGGJn6sC5Bx4dMWlCOyvTNg+oFmZ5DZS8Qac
         wnl7U3FdBkK6DmQfs2XEHWRjcg3ZVa4mTXjLYosFgQE+o4Tjt1rTNBR3Kbvo/MUnR3O1
         tGtx8kmmOkDOubQmjYne68uwodzVUr2d6xBH2BNW8YNdJDtiZCOj6lb/Y+HT7vi+7je8
         YRGJgHeUBLI12jh0uRI8MDYMMl+Tpnm+IEk9G+CQtyiMDZ6jj+hSTCiEH7LaRM+JuQ9E
         Fd3UlgKzQjebgsXVF70Sgpa4SmpheKEkCbnXo2UDmTSegYTpwQoHQhBQoYj1TsmCeOKf
         6EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=da/l24eP3nYB45qy4cZI7dM0NqKY848ZDOT8xVxHEUI=;
        b=Llp19nTRo4rloyVJbfe3uIeEEdm7x+Lgr5155f9dfBJxBDh+pEFlyxp9gS8GvX6CIi
         q/5Hx2j03IH6f4HqVP0w08609OVzCCe40wgsTvCrTjFzwiC50g7wn9UZetkiyVMJDb+S
         lPU+/gaEA8ff9vP4GCNEpXMCf+QkASOn0CfncAkXhCpy16NWEXdS0T7ioHEx72v/raIn
         aQKOhZKZlACLAXA4EWFFqP0v6N9Pj0h5GGvKGPBGV7qPZNc04Ma6992iUpAH1suHNGfz
         I8EzfpJ+YVu+AxLrBeE4E6NNtz61v+lbx2nAanzfCS8kMsvkZurl5K5wplUKDKW5NAyS
         vSbA==
X-Gm-Message-State: AOAM5309rRZvRwtgStoLHPTVIpOXLY9iuktq1FTdRol//Fvc1POYNchH
        Ov1mLR+TX8tm8OzDT2TD+tOqDsEhuC4=
X-Google-Smtp-Source: ABdhPJywYkV4jSYCLi6QgZmDa6q1xhpZmLlS4btBaJeRd1JwitT5AAXQIvgr6tE3NnOYdBjxljTymQ==
X-Received: by 2002:a05:6512:3089:: with SMTP id z9mr12805138lfd.496.1618044408927;
        Sat, 10 Apr 2021 01:46:48 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.75.45])
        by smtp.gmail.com with ESMTPSA id o9sm878899lfb.280.2021.04.10.01.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 01:46:48 -0700 (PDT)
Subject: Re: [PATCH] pata_ipx4xx_cf: Fix unsigned comparison with less than
 zero
To:     angkery <angkery@163.com>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Junlin Yang <yangjunlin@yulong.com>
References: <20210409135426.1773-1-angkery@163.com>
 <e74ec570-96b6-23ce-edd5-b5a38628963a@gmail.com>
 <e6bf7f02-f0b8-b0c4-2253-62a55ea98d17@gmail.com>
 <20210410073814.00003b86.angkery@163.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <f9ea1536-6cfe-29fe-1ecd-95d0f68d3a85@gmail.com>
Date:   Sat, 10 Apr 2021 11:46:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210410073814.00003b86.angkery@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10.04.2021 2:38, angkery wrote:
> On Fri, 9 Apr 2021 20:02:56 +0300
> Sergei Shtylyov <sergei.shtylyov@gmail.com> wrote:
> 
>> On 4/9/21 7:49 PM, Sergei Shtylyov wrote:
>>
>>>> From: Junlin Yang <yangjunlin@yulong.com>
>>>>
>>>> The return from the call to platform_get_irq() is int, it can be
>>>> a negative error code, however this is being assigned to an
>>>> unsigned int variable 'irq', so making 'irq' an int, and change
>>>> the position to keep the code format.
>>>>
>>>> ./drivers/ata/pata_ixp4xx_cf.c:168:5-8:
>>>> WARNING: Unsigned expression compared with zero: irq > 0
>>>
>>>     I'd understand < 0... but > 0? What tool warned about this issue?
>>>    
>>>> yes, by coccicheck, i will update commits information.

    Thanks!
    Yet, looking at your subject, the above should read irq < 0, not > 0.

>>>> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>


