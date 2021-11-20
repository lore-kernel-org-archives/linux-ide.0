Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B2EC433F5
	for <linux-ide@archiver.kernel.org>; Sat, 20 Nov 2021 12:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhKTMEu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 20 Nov 2021 07:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhKTMEu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 20 Nov 2021 07:04:50 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14E0C061574;
        Sat, 20 Nov 2021 04:01:46 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y26so56109897lfa.11;
        Sat, 20 Nov 2021 04:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=wbJD9nZe6qNHGvBaJI58XqT00jTe1paMdYt56fGsTdQ=;
        b=Opf18F8tY87CNqNWoL54Enz4yj9+AiUaIspVfDSRk1iqdnse6PminboQ5g9ztcyMyx
         501X0MM6QToIONl4dh+ndDYnwa34KVAgpc4fCjTymn2r6sF4HH0T7wKSdd/7/8OaM/Rf
         N7mYYSB+Zj5/5tcfsLyMdT8JgWzlIk/kJtW3V24RjOEZheI0B5XJiUwBCfrfaaNCwmEZ
         R99dcc9aVst980QALtj9Wm+aAYAeZXB6fCh4vZwn4QyIbBiTUjzcOaFKK1Jby3B+h4ws
         z9syhr3kRreF5y01aRK7cUiNaL9EfrDbcvD87Paps2PYAnKNYUnX7R1KmRWjtoaOdka1
         tVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=wbJD9nZe6qNHGvBaJI58XqT00jTe1paMdYt56fGsTdQ=;
        b=Zh+is57B52d9VeLFQEIMx5w2Am5erL48tIk3KFGsMfv3l6Sy9hlkeiPJ5RWQGFwYMG
         PktRp+iWfsn57prD2/AvqbqmoVr7ctmB++eJmw7HN05FDeL55zRyXhh7wwAUK8WBDTou
         6tM0GoVQFWnv+o6XTPYWdnya+IKH0L3ObUhuoLkukdpEQV7J2oXBqWDuQubdFVtC96XF
         TBtG1nM+jdXXqP0M+yUAueeZn1TOb0nUtS4lIf/PzrMKeEqYXHNm1cMSMkB83NU+7map
         jdwGzgMRADHOyvjJmMG9ZwtQSyAia8OmY3JuyAp5rZOB6O0oCtfgQtAuZPBhv8Ctu0sF
         3Ssw==
X-Gm-Message-State: AOAM533KHDCI3aBuZE8VxzqUCX8eyv4nKD8oTzdpxnc474+D2lFkS0oT
        9U8uXM1qrb2Uk7vx0rb7S/0=
X-Google-Smtp-Source: ABdhPJxlJw2/XZ1Wo2YKnWyVGQl0ojyTplQRPVAsQkD+7meVgixOF6S6wy+BMivE9YlEReWILulwsw==
X-Received: by 2002:a2e:bc21:: with SMTP id b33mr35734548ljf.497.1637409704996;
        Sat, 20 Nov 2021 04:01:44 -0800 (PST)
Received: from [192.168.1.100] ([178.176.76.156])
        by smtp.gmail.com with ESMTPSA id f9sm310089lfv.44.2021.11.20.04.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 04:01:44 -0800 (PST)
Message-ID: <4216b1e4-5649-071a-84fc-2440aba9d5a0@gmail.com>
Date:   Sat, 20 Nov 2021 15:01:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH -next V2 1/2] sata_fsl: fix UAF in sata_fsl_port_stop when
 rmmod sata_fsl
Content-Language: en-US
To:     Baokun Li <libaokun1@huawei.com>, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, tj@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20211120033420.3762681-1-libaokun1@huawei.com>
 <20211120033420.3762681-2-libaokun1@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
In-Reply-To: <20211120033420.3762681-2-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 20.11.2021 6:34, Baokun Li wrote:

> When the `rmmod sata_fsl.ko` command is executed in the PPC64 GNU/Linux,
> a bug is reported:
>   ==================================================================
>   BUG: Unable to handle kernel data access on read at 0x80000800805b502c
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   NIP [c0000000000388a4] .ioread32+0x4/0x20
>   LR [80000000000c6034] .sata_fsl_port_stop+0x44/0xe0 [sata_fsl]
>   Call Trace:
>    .free_irq+0x1c/0x4e0 (unreliable)
>    .ata_host_stop+0x74/0xd0 [libata]
>    .release_nodes+0x330/0x3f0
>    .device_release_driver_internal+0x178/0x2c0
>    .driver_detach+0x64/0xd0
>    .bus_remove_driver+0x70/0xf0
>    .driver_unregister+0x38/0x80
>    .platform_driver_unregister+0x14/0x30
>    .fsl_sata_driver_exit+0x18/0xa20 [sata_fsl]
>    .__se_sys_delete_module+0x1ec/0x2d0
>    .system_call_exception+0xfc/0x1f0
>    system_call_common+0xf8/0x200
>   ==================================================================
> 
> The triggering of the BUG is shown in the following stack:
> 
> driver_detach
>    device_release_driver_internal
>      __device_release_driver
>        drv->remove(dev) --> platform_drv_remove/platform_remove
>          drv->remove(dev) --> sata_fsl_remove
>            iounmap(host_priv->hcr_base);			<---- unmap
>            kfree(host_priv);                             <---- free
>        devres_release_all
>          release_nodes
>            dr->node.release(dev, dr->data) --> ata_host_stop
>              ap->ops->port_stop(ap) --> sata_fsl_port_stop
>                  ioread32(hcr_base + HCONTROL)           <---- UAF
>              host->ops->host_stop(host)
> 
> The iounmap(host_priv->hcr_base) and kfree(host_priv) commands should

    s/commands/functions/?

> not be executed in drv->remove. These commands should be executed in
> host_stop after port_stop. Therefore, we move these commands to the
> new function sata_fsl_host_stop and bind the new function to host_stop
> by referring to achi.

    You mean AHCI? I don't see where you reference ahci (or achi)...

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

    Doesn't this need to go into the stable trees?

> ---
>   drivers/ata/sata_fsl.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index e5838b23c9e0..30759fd1c3a2 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1430,12 +1430,25 @@ static struct ata_port_operations sata_fsl_ops = {
>   	.pmp_detach = sata_fsl_pmp_detach,
>   };
>   
> +static void sata_fsl_host_stop(struct ata_host *host)
> +{
> +	struct sata_fsl_host_priv *host_priv = host->private_data;
> +
> +	iounmap(host_priv->hcr_base);
> +	kfree(host_priv);
> +}
> +
> +static struct ata_port_operations sata_fsl_platform_ops = {
> +	.inherits       = &sata_fsl_ops,
> +	.host_stop      = sata_fsl_host_stop,

    Why not just add it to the initializer for sata_fsl_ops?

[...]

MBR, Sergei
