Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A48CC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 20 Oct 2021 03:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029A6604AC
	for <linux-ide@archiver.kernel.org>; Wed, 20 Oct 2021 03:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhJTD30 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 19 Oct 2021 23:29:26 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:44609 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTD30 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 19 Oct 2021 23:29:26 -0400
Received: by mail-pj1-f44.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so1434905pjb.3
        for <linux-ide@vger.kernel.org>; Tue, 19 Oct 2021 20:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QZwoZyaOjNTYz89gCDVStqJm3zYRIaX8is14HxaK4cU=;
        b=L5nOF/i5/an8GbpIj8SvEHugOt3iZwa2gG7GHRmjf5WVZ54OUoHzt6YibIX4tg+m0a
         GelSSERYcFXuRIuv528tP4yOS/RDjsHV2VY66bAU6Sq46CbQoe9Vot2I09i/Qih+kc2m
         B3qEFPMqVmkZKjcGxv7cUEu09xOfuieKXQG9jwbP5bvhRNNL6Yrre1tIX0QREBp21T8J
         dp9EZPFBZ0ZzHh6MbE4vfFpac8+FMc0BFfjEArj4kEWVDvjK1D5fNZr43g0hpBczJPig
         1FTkbKZptwmyVoEyGAhOd6fCoblmW8aEiYqVz052XRfVq084BEV9CY9qqKrvc04/TPoh
         D2sQ==
X-Gm-Message-State: AOAM530yITflrM7ZXBJmTmkhMGsUZx40hn2wKcQKnmkD3WyhSFmXTu6Y
        dHhfQbEqVRQUKYEDgsKRmzl9hL0FneY=
X-Google-Smtp-Source: ABdhPJweiFDRIEDjpuTKZcAHicl5h+H35d2fVSH2uQd0mkGEDg/5NfzvJsfH3rK6OvBwCxHGVaKKOQ==
X-Received: by 2002:a17:903:41c2:b0:13f:f26:d6b9 with SMTP id u2-20020a17090341c200b0013f0f26d6b9mr36589405ple.14.1634700432216;
        Tue, 19 Oct 2021 20:27:12 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:3394:3c51:c06a:8f0b? ([2601:647:4000:d7:3394:3c51:c06a:8f0b])
        by smtp.gmail.com with ESMTPSA id t6sm643294pfh.63.2021.10.19.20.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 20:27:11 -0700 (PDT)
Message-ID: <59795405-fe7c-2181-b1a0-6beda1963911@acm.org>
Date:   Tue, 19 Oct 2021 20:27:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] scsi: ata: make ahci_sdev_attrs static
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-ide@vger.kernel.org
References: <1634639082-1007-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <af043ccc-6287-47d4-d5b5-7bbef4e3380e@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <af043ccc-6287-47d4-d5b5-7bbef4e3380e@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/19/21 15:44, Damien Le Moal wrote:
> +Bart
> 
> On 2021/10/19 19:24, Jiapeng Chong wrote:
>> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> 
> The patch title should be:
> 
> ata: libahci: make ahci_sdev_attrs static
> 
>>
>> This symbol is not used outside of libahci.c, so marks it static.
>>
>> Fix the following sparse warning:
>>
>> drivers/ata/libahci.c:134:18: warning: symbol 'ahci_sdev_attrs' was not
>> declared. Should it be static?
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Fixes: c3f69c7f629f ("scsi: ata: Switch to attribute groups")
>> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
>> ---
>>   drivers/ata/libahci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> index 28430c093a7f..8a6835bfd18a 100644
>> --- a/drivers/ata/libahci.c
>> +++ b/drivers/ata/libahci.c
>> @@ -131,7 +131,7 @@ const struct attribute_group *ahci_shost_groups[] = {
>>   };
>>   EXPORT_SYMBOL_GPL(ahci_shost_groups);
>>   
>> -struct attribute *ahci_sdev_attrs[] = {
>> +static struct attribute *ahci_sdev_attrs[] = {
>>   	&dev_attr_sw_activity.attr,
>>   	&dev_attr_unload_heads.attr,
>>   	&dev_attr_ncq_prio_supported.attr,
>>
> 
> Looks OK to me.

The above patch looks fine to me too.

Thanks,

Bart.
