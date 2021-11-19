Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF9EC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 15:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237876101A
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 15:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhKSPqu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhKSPqq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2021 10:46:46 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068E9C06173E;
        Fri, 19 Nov 2021 07:43:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l22so44966024lfg.7;
        Fri, 19 Nov 2021 07:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Y/H0f2cc4LOS2yW9MTa6k9uR5O+nimtRUUk2Rd26V3Y=;
        b=dfRW94zBYn6rwUAlFZhmjlgq2gEMJ2AiSCZNf5YgpowALi7ZSJSwRWJfO1gCbVJzN1
         VJOJxLCU1dYTEomyCMIQdzkiYCzyoJdyScBywT1rIvkAY/3s3FOS4TPVRggKYLZ1ZYOl
         ybO8iUMdNIhDVGCePYRQymbLwfe7QNrxcB8P6wtii/A1PHBciqRCRhoKTIZxkjFQ07rx
         vgo4XkwApvZ+0d3PIk23pTAsIBighqNKnRzkz7tPc+eoXmG/3t7Ipg3o5N2+BIlc4EAb
         5zOOealMztDdArfidlLh2+pQKQZiu7heO28J10F8l/QEZWypDX3nE7alILLmEQE4nEML
         0lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Y/H0f2cc4LOS2yW9MTa6k9uR5O+nimtRUUk2Rd26V3Y=;
        b=doIVA7sQd5pgBf9aOfOmt+jsqEGBiLkJaXuUI9iV97KbLfDdnmM+xewJe/j9A3vAqT
         pglURZ8HO2i5Ynsthgf8glSqSgwOdT5k1apkB+PX1JO9JFFvd3PYrn9k2uyyURwWeqps
         pdRzizp4fJPd9TpDx10X32GRV8uNpNDWJYUwSOEMsI7kfSz2/jUeMy1rhTzc9E3YPdCn
         +DA0zSJHp74aknxmcNS95BA+bZpLc9KYZASpRN03LzFm3/OF32FvuchoRvnOvL8HH561
         Ff/+SOAc0B1bPwsQ52VAC7NmQ/08UfrQr37tyIi23NUDYY0WRSxUCuPKY9eYD0uJ/xox
         cWNg==
X-Gm-Message-State: AOAM531rkzvEhJgEyt9xvqU83/Ac2+YYym4/WqQfYnMKD61HyjcPvzUL
        1sjUy5o5p2fAAoqGfW2BRgg=
X-Google-Smtp-Source: ABdhPJxOcoIXUkL9/AIjxh3ZbKmuLLdSpLFQmpZ6ShxtFomnl+lsg2YoOKC3iPMXJXVm8xTbpgLwOg==
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr32523499lfr.17.1637336621879;
        Fri, 19 Nov 2021 07:43:41 -0800 (PST)
Received: from [192.168.1.100] ([178.176.79.231])
        by smtp.gmail.com with ESMTPSA id x10sm17686lfg.102.2021.11.19.07.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 07:43:41 -0800 (PST)
Message-ID: <283712c0-bab7-de13-fc27-6ae2e6f9532f@gmail.com>
Date:   Fri, 19 Nov 2021 18:43:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH -next 2/2] sata_fsl: fix warning in remove_proc_entry when
 rmmod sata_fsl
Content-Language: en-US
To:     Baokun Li <libaokun1@huawei.com>, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, tj@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20211119041128.2436889-1-libaokun1@huawei.com>
 <20211119041128.2436889-3-libaokun1@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
In-Reply-To: <20211119041128.2436889-3-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 19.11.2021 7:11, Baokun Li wrote:

> Trying to remove the fsl-sata module in the PPC64 GNU/Linux
> leads to the following warning:
>   ------------[ cut here ]------------
>   remove_proc_entry: removing non-empty directory 'irq/69',
>     leaking at least 'fsl-sata[ff0221000.sata]'
>   WARNING: CPU: 3 PID: 1048 at fs/proc/generic.c:722
>     .remove_proc_entry+0x20c/0x220
>   IRQMASK: 0
>   NIP [c00000000033826c] .remove_proc_entry+0x20c/0x220
>   LR [c000000000338268] .remove_proc_entry+0x208/0x220
>   Call Trace:
>    .remove_proc_entry+0x208/0x220 (unreliable)
>    .unregister_irq_proc+0x104/0x140
>    .free_desc+0x44/0xb0
>    .irq_free_descs+0x9c/0xf0
>    .irq_dispose_mapping+0x64/0xa0
>    .sata_fsl_remove+0x58/0xa0 [sata_fsl]
>    .platform_drv_remove+0x40/0x90
>    .device_release_driver_internal+0x160/0x2c0
>    .driver_detach+0x64/0xd0
>    .bus_remove_driver+0x70/0xf0
>    .driver_unregister+0x38/0x80
>    .platform_driver_unregister+0x14/0x30
>    .fsl_sata_driver_exit+0x18/0xa20 [sata_fsl]
>   ---[ end trace 0ea876d4076908f5 ]---
> 
> The driver creates the mapping by calling irq_of_parse_and_map(),
> so it also has to dispose the mapping. But the easy way out is to
> simply use platform_get_irq() instead of irq_of_parse_map().

    Not that easy. :-)

> In this case the mapping is not managed by the device but by
> the of core, so the device has not to dispose the mapping.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   drivers/ata/sata_fsl.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 30759fd1c3a2..011daac4a14e 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1493,7 +1493,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>   	host_priv->ssr_base = ssr_base;
>   	host_priv->csr_base = csr_base;
>   
> -	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> +	irq = platform_get_irq(ofdev, 0);
>   	if (!irq) {

	if (irq < 0) {

    platform_get_irq() returns negative error codes, not 0 on failure.

[...]

MBR, Sergey
