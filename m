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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C86C433B4
	for <linux-ide@archiver.kernel.org>; Sat, 10 Apr 2021 08:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1600E61026
	for <linux-ide@archiver.kernel.org>; Sat, 10 Apr 2021 08:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhDJIw1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 10 Apr 2021 04:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhDJIw0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 10 Apr 2021 04:52:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60827C061762;
        Sat, 10 Apr 2021 01:52:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b4so13402938lfi.6;
        Sat, 10 Apr 2021 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4svQIHaWyonus6NC9Wt6UCIb/Wkk+iEs+l9TOzqnCus=;
        b=oo8UIIim2xX9Ykzn12egb1Q5OuDF5+RMeJ/pNLTiGQ3lmNhLpVcr4qIDxU2IrRVBzh
         zfwXRKUUhD9PQcZ+rvtkmoKaC+J+pC1SuYWmSlOF2Z7k9kcXlH9uE3Q+Zhk4gCv1++V/
         EzRpb5tLY5tIW91EDLkQXQvkksFGmdsoKSY4UC6bllpuIutvFKDJxRoo0dsd7Lobj3oT
         My6bbwzh0bDXhBE8LF7t8E6FJnokffka3OiL/mZ2pRHY/kbXqP+21xnKtW0li2qli5iJ
         wuSj2FdHnXq0xFh06nLR2JXXFjp+TOqZZBnIchDr8hjrYXFHhGd/Hct3o7N6CV9LTv5V
         xf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4svQIHaWyonus6NC9Wt6UCIb/Wkk+iEs+l9TOzqnCus=;
        b=Ox29weTYOVxOM+wUq0Hl5PmVRu830dB89t07ziqKZ4O9q4gqHCaEVEjgWsLeYhj0nd
         YVlMntfIYXTdbkra+vYs2CbaZyEwVXyVMmkeD3sQdD/mmp+i4pMzLFxnEotV0JY69ldP
         wAovrYf6oj4L4wJHYVyIlBKoBeNa8ss9JZxitI3U8wJYL4fTewvi71srlQz4VPTNmwSi
         9/L2L05Q9uaCQBoy9CKHsmYwNAkJfLXBTAiCQZWwfgzaxqdWyYG31NObWUQv6yADvctB
         Ouqixc97AStovSdbzD8pnTGa87vlp6tLSfbA2Iz+W+NmaHn+tNagLfrKrVvN4tz0WhBR
         i+Zw==
X-Gm-Message-State: AOAM53012JPJNsPhMYBr5ddp7TVvXWT2Pnds1NJsJD3rbGg/27/W1eHY
        4Q2FPUBjo2gIe5ndk0qGk6ah2llJnqY=
X-Google-Smtp-Source: ABdhPJypzKENQeeFQdZM6ErG8H+Ffw1RWKwpyuFBAMvHLN3IebCdmTFdVM3+lJ+5DKbAXPa/Ld6oUw==
X-Received: by 2002:a19:e206:: with SMTP id z6mr1375798lfg.100.1618044730773;
        Sat, 10 Apr 2021 01:52:10 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.75.45])
        by smtp.gmail.com with ESMTPSA id m3sm897123lfo.190.2021.04.10.01.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 01:52:10 -0700 (PDT)
Subject: Re: [PATCH v1] pata_ipx4xx_cf: Fix unsigned comparison with less than
 zero
To:     angkery <angkery@163.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
References: <20210409234242.1979-1-angkery@163.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <a9af3dac-7ce5-71fb-5d89-a9afab4e48d4@gmail.com>
Date:   Sat, 10 Apr 2021 11:52:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210409234242.1979-1-angkery@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10.04.2021 2:42, angkery wrote:

> From: Junlin Yang <yangjunlin@yulong.com>
> 
> The return from the call to platform_get_irq() is int, it can be
> a negative error code, however this is being assigned to an unsigned
> int variable 'irq', so making 'irq' an int, and change the position to
> keep the code format.
> 
> Fixes coccicheck warnings:
> ./drivers/ata/pata_ixp4xx_cf.c:168:5-8:
> WARNING: Unsigned expression compared with zero: irq > 0
> 
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
> ---
> changes in v1:
> update the commit information.

    Not seeing what's updated, and anwyways it should read irq < 0, else it 
doesn't make sense...

[...]

MBR, Sergei
