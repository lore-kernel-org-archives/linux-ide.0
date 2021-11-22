Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA0BC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 22 Nov 2021 18:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhKVTBX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 Nov 2021 14:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbhKVTBU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Nov 2021 14:01:20 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B45C061574;
        Mon, 22 Nov 2021 10:58:13 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id b16so757683ljf.12;
        Mon, 22 Nov 2021 10:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZmFlPfAlVUL5AM59C3+v18Onh7pNcAeuHxBgvnplYJM=;
        b=AJZzODeeHpZBqWdtwrER3B+R1IpHQkIkFNyDS4u/PfsjKf14C/PNLnu+DhrCYi9GQr
         EvUsViHzVCUroGI9RBlBH6V1DKmhYEBns30QpXjCFXn4yQrwniQPUSbj62oPcrrzgaCO
         w/nOVpw8xEWyEVJEe1E8rMiKmUjqksU9sx4tEJWsQCXi3B+GOXUSfGatRiHy9XUdJfW6
         xiu5PdxNuFhD0OQ58Giv/9YXyp1Ucs+eccHLrssIEap7tQhI23Aesk/HdKLVWxnPxoGV
         XM/C3aospJghfps04UZWqEcFUTBnYzp/bDggzpa1Nmw5V3LOaEIhctRmvRYIePCsAhVX
         1C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZmFlPfAlVUL5AM59C3+v18Onh7pNcAeuHxBgvnplYJM=;
        b=zvPrRiqYCRk+Q89me5j4pxtf5cMyDtiDBpxdbNJ7qO5DIr3+0Q7XPbv7Uwecz68Csi
         k47OradZcpZfGsH9mfNcfbPpFZSEsNqaj/5bhZxs+a58J49+X17j2qBLeRO6/Tf6BoEg
         SEB7kzYlfaHODbnyKfJj6qsF9oNXItimM06GPk++0C2Oi1JKcXXPrOg3Zr0bjHACV+l5
         wo1i1s81DCucpc1ycYeAvTC73ZSIJfTdtmeZX2ObFtbGFv5f5TFqLtR4g+XU0EmwpQfO
         VA9460LHjlz+uswm4PMGjKiMGJLDGUOIN1Iy+56fjD6Fq6/MEUgzL4nCNZIDrWtEg4Ts
         81dQ==
X-Gm-Message-State: AOAM530gI0cdSoAcB8fxUrc3K2ml4e1XCUOyjMa603F183fbk4eT+bJu
        /sxDYo2wh4P+1hfNs4guX8/w/Cm7Mtc=
X-Google-Smtp-Source: ABdhPJzn7uhE3bpLc0RVrL9UAt90kI8f4OTVLQplB01nptpyTNRIHegCq0e5pAiZLal/todmdksr2g==
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr54315188ljj.506.1637607491843;
        Mon, 22 Nov 2021 10:58:11 -0800 (PST)
Received: from [192.168.1.100] ([31.173.86.201])
        by smtp.gmail.com with ESMTPSA id x18sm1018067ljd.110.2021.11.22.10.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 10:58:11 -0800 (PST)
Message-ID: <e9d66318-3b5d-f737-ec7a-d819c4aa5b6b@gmail.com>
Date:   Mon, 22 Nov 2021 21:58:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH -next V2 1/2] sata_fsl: fix UAF in sata_fsl_port_stop when
 rmmod sata_fsl
Content-Language: en-US
To:     "libaokun (A)" <libaokun1@huawei.com>,
        damien.lemoal@opensource.wdc.com, axboe@kernel.dk, tj@kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20211120033420.3762681-1-libaokun1@huawei.com>
 <20211120033420.3762681-2-libaokun1@huawei.com>
 <4216b1e4-5649-071a-84fc-2440aba9d5a0@gmail.com>
 <4d2712d3-00a1-6220-0a86-8580b2f89d03@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
In-Reply-To: <4d2712d3-00a1-6220-0a86-8580b2f89d03@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 22.11.2021 5:03, libaokun (A) wrote:

>>> When the `rmmod sata_fsl.ko` command is executed in the PPC64 GNU/Linux,
>>> a bug is reported:
>>> ==================================================================
>>>   BUG: Unable to handle kernel data access on read at 0x80000800805b502c
>>>   Oops: Kernel access of bad area, sig: 11 [#1]
>>>   NIP [c0000000000388a4] .ioread32+0x4/0x20
>>>   LR [80000000000c6034] .sata_fsl_port_stop+0x44/0xe0 [sata_fsl]
>>>   Call Trace:
>>>    .free_irq+0x1c/0x4e0 (unreliable)
>>>    .ata_host_stop+0x74/0xd0 [libata]
>>>    .release_nodes+0x330/0x3f0
>>>    .device_release_driver_internal+0x178/0x2c0
>>>    .driver_detach+0x64/0xd0
>>>    .bus_remove_driver+0x70/0xf0
>>>    .driver_unregister+0x38/0x80
>>>    .platform_driver_unregister+0x14/0x30
>>>    .fsl_sata_driver_exit+0x18/0xa20 [sata_fsl]
>>>    .__se_sys_delete_module+0x1ec/0x2d0
>>>    .system_call_exception+0xfc/0x1f0
>>>    system_call_common+0xf8/0x200
>>> ==================================================================
>>>
>>> The triggering of the BUG is shown in the following stack:
>>>
>>> driver_detach
>>>    device_release_driver_internal
>>>      __device_release_driver
>>>        drv->remove(dev) --> platform_drv_remove/platform_remove
>>>          drv->remove(dev) --> sata_fsl_remove
>>>            iounmap(host_priv->hcr_base);            <---- unmap
>>>            kfree(host_priv); <---- free
>>>        devres_release_all
>>>          release_nodes
>>>            dr->node.release(dev, dr->data) --> ata_host_stop
>>>              ap->ops->port_stop(ap) --> sata_fsl_port_stop
>>>                  ioread32(hcr_base + HCONTROL) <---- UAF
>>>              host->ops->host_stop(host)
>>>
>>> The iounmap(host_priv->hcr_base) and kfree(host_priv) commands should
>>
>>   s/commands/functions/?
> 
> OK! I'm going to modify this in V3.
> 
>>
>>> not be executed in drv->remove. These commands should be executed in
>>> host_stop after port_stop. Therefore, we move these commands to the
>>> new function sata_fsl_host_stop and bind the new function to host_stop
>>> by referring to achi.
>>
>>   You mean AHCI? I don't see where you reference ahci (or achi)...
> 
> Yes, it's AHCI, I'm sorry for a spelling error here..
> 
> ahci_platform_ops in drivers/ata/libahci_platform.c

   You should have (at least) written "the AHCI platform driver"...

[...]
>>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>>> index e5838b23c9e0..30759fd1c3a2 100644
>>> --- a/drivers/ata/sata_fsl.c
>>> +++ b/drivers/ata/sata_fsl.c
>>> @@ -1430,12 +1430,25 @@ static struct ata_port_operations sata_fsl_ops = {
>>>       .pmp_detach = sata_fsl_pmp_detach,
>>>   };
>>>   +static void sata_fsl_host_stop(struct ata_host *host)
>>> +{
>>> +    struct sata_fsl_host_priv *host_priv = host->private_data;
>>> +
>>> +    iounmap(host_priv->hcr_base);
>>> +    kfree(host_priv);
>>> +}
>>> +
>>> +static struct ata_port_operations sata_fsl_platform_ops = {
>>> +    .inherits       = &sata_fsl_ops,
>>> +    .host_stop      = sata_fsl_host_stop,
>>
>>   Why not just add it to the initializer for sata_fsl_ops?
> 
> This is the AHCI of the reference.
> 
> Most ATA drivers add host_stop to to the  initializer for xxx_platform_ops,

    Most? Even if so, I guess they add it this way because they're in the 
separate modules with the ops they inherit -- in this case it's not so.

> such as ahci_platform_ops, ahci_brcm_platform_ops, and ahci_imx_ops.

    Note that these are all AHCI drivers, not just (more general) ATA.

> It feels like this separates the port operation from the host operation,

    Why separate them? The 'struct ata_port_operations' embraces many 
different aspects of ATA, the arguments do not always include a 'struct 
*ata_port' (I don't quite like that part in libata).

> making the hierarchy of the code clearer.

    Clear as mud. In your case, there's no separate modules in play, so 
blindly parroting what the AHCI platform drivers do gives you nothing but 
memory waste... :-(

>> [...]
>>
>> MBR, Sergei
>> .
> 
> 
> Thank you very much for your advice.

    You're welcome. :-)

> If there's nothing else to modify, I'll send a patch V3.

    Please use a single structure, it's already large enough to have 2 of them 
in the same module for no good reason.

> -- 
> With Best Regards,
> Baokun Li

MBR, Sergei
