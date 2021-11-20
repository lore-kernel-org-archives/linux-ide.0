Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D44C4332F
	for <linux-ide@archiver.kernel.org>; Sat, 20 Nov 2021 09:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhKTJyq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 20 Nov 2021 04:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbhKTJyq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 20 Nov 2021 04:54:46 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AADEC061574;
        Sat, 20 Nov 2021 01:51:42 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b1so54781826lfs.13;
        Sat, 20 Nov 2021 01:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=KurvDeK1OCCTbWY8LAh9vhNWC4pm8h+CrIfTiM1/sFQ=;
        b=UlJc3W8bLVIjECrs0I8CRg1Jcr/3OOXlyFaJGE+jBdeQacZ/SSFYvOYQlcdW0xn6a2
         hxRXOfINNjskmWKxAE42dO0uxG9LEuDiTQZm7ZDYNj/FJ+qr0VOUUhfa7x5AICRG9NWH
         zLEPGD/KikArkqBlSv24L3g59WVdkPtz28guLgilN7Ins8pvhhQqnkZtuovPPEvBjNKM
         DybA/UioMNshpxsgyeBaW+2Z+KRJC5QDHBERSGrNqexN02FsLTCZAZK/omlXdhcEU+CI
         RqM6UylXhP4Ms831WeK5dDqsm6bHtCUnY82z3ZMGkVQu8RC/ZS8VWZmnER1la+/OaveW
         THog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=KurvDeK1OCCTbWY8LAh9vhNWC4pm8h+CrIfTiM1/sFQ=;
        b=GZWhBa+eJ4D7943DowMjaIDd4i2XdnxNeA29pGb4G/fvczFJHQki8LGxDNxWAy60ig
         3lUHy9HhGkviu9y1mCqfQjsZ8P2Ne61u0+nr+A/qI4j2HW8c/ieMXTUiPLBqWjSuDnqY
         fB0K2ADKTaNhfgnC4Z9vZzRdrnWetMs5POxVVLIzYSdQT8BavhCeFZFRSPZmLTKp4kio
         P8/ytrrXvTKDLW/raE5RoAG9QBDxJEIFVUpj2sHthK+p3JzTbXAbr7RQU7SCf4S92nmD
         7O4a5o/JzxvmgOOJF5ar6vkMXI+3f30UIoYid7ZnzO/EpTswPOCAycOnDS6aXBO+PA9j
         m2ag==
X-Gm-Message-State: AOAM530Vfyxh8xzlp6M71yJrvwffxQtsM7AWCv0gQNbvxnGkxRdXBHle
        ogD/XJF4e6UGaC7ogK57Axw=
X-Google-Smtp-Source: ABdhPJx/6t6eNVFJY+Z1BLiHLUtI7q+X4uBmxvgGkomS92Z+IWNnzF60Jv5zfJkSuaU5fjmqW7OEkA==
X-Received: by 2002:a05:6512:398b:: with SMTP id j11mr38760989lfu.170.1637401900940;
        Sat, 20 Nov 2021 01:51:40 -0800 (PST)
Received: from [192.168.1.100] ([178.176.76.156])
        by smtp.gmail.com with ESMTPSA id s17sm312122lfe.10.2021.11.20.01.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 01:51:40 -0800 (PST)
Message-ID: <361abc20-e01e-3c3a-3217-2e7ed6cb3f76@gmail.com>
Date:   Sat, 20 Nov 2021 12:51:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH -next 2/2] sata_fsl: fix warning in remove_proc_entry when
 rmmod sata_fsl
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Baokun Li <libaokun1@huawei.com>, axboe@kernel.dk,
        tj@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20211119041128.2436889-1-libaokun1@huawei.com>
 <20211119041128.2436889-3-libaokun1@huawei.com>
 <283712c0-bab7-de13-fc27-6ae2e6f9532f@gmail.com>
 <fcf2d384-ee03-298c-c1ac-5a39c0d85784@opensource.wdc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
In-Reply-To: <fcf2d384-ee03-298c-c1ac-5a39c0d85784@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 20.11.2021 9:08, Damien Le Moal wrote:
> On 11/20/21 00:43, Sergei Shtylyov wrote:
>>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>>> index 30759fd1c3a2..011daac4a14e 100644
>>> --- a/drivers/ata/sata_fsl.c
>>> +++ b/drivers/ata/sata_fsl.c
>>> @@ -1493,7 +1493,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>>>    	host_priv->ssr_base = ssr_base;
>>>    	host_priv->csr_base = csr_base;
>>>    
>>> -	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
>>> +	irq = platform_get_irq(ofdev, 0);
>>>    	if (!irq) {
>>
>> 	if (irq < 0) {
>>
>>      platform_get_irq() returns negative error codes, not 0 on failure.
> 
> Sergei,
> 
> By the way, the kdoc comment for platform_get_irq() says:
> 
> "Return: non-zero IRQ number on success, negative error number on failure."
> 
> But irq	0 is valid, isn't it ? So shouldn't this be changed to something
> like:
> 
> "Return: IRQ number on success, negative error number on failure."

    No, it's not valid (the current code WARN()s about it) and won't be 
returned anymore after my patch [1] gets applied.

[1] https://marc.info/?l=linux-kernel&m=163623041902285

MBR, Sergei
