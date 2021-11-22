Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDD5C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 22 Nov 2021 02:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhKVCxm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 21 Nov 2021 21:53:42 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27156 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhKVCxm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 21 Nov 2021 21:53:42 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HyBXP41fnz1DJTT;
        Mon, 22 Nov 2021 10:48:05 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 10:50:34 +0800
Subject: Re: [PATCH -next V2 1/2] sata_fsl: fix UAF in sata_fsl_port_stop when
 rmmod sata_fsl
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>, <axboe@kernel.dk>,
        <tj@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yebin10@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
References: <20211120033420.3762681-1-libaokun1@huawei.com>
 <20211120033420.3762681-2-libaokun1@huawei.com>
 <4216b1e4-5649-071a-84fc-2440aba9d5a0@gmail.com>
 <4d2712d3-00a1-6220-0a86-8580b2f89d03@huawei.com>
 <08bd2ce6-cee7-d77b-8594-9ff83a471a9b@opensource.wdc.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <05f514bd-b94e-1b34-c6de-4a1126455063@huawei.com>
Date:   Mon, 22 Nov 2021 10:50:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <08bd2ce6-cee7-d77b-8594-9ff83a471a9b@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

在 2021/11/22 10:33, Damien Le Moal 写道:
> On 2021/11/22 11:03, libaokun (A) wrote:
>> 在 2021/11/20 20:01, Sergei Shtylyov 写道:
>>> Hello!
>>>
>>> On 20.11.2021 6:34, Baokun Li wrote:
>>>
>>>> When the `rmmod sata_fsl.ko` command is executed in the PPC64 GNU/Linux,
>>>> a bug is reported:
>>>>    ==================================================================
>>>>    BUG: Unable to handle kernel data access on read at 0x80000800805b502c
>>>>    Oops: Kernel access of bad area, sig: 11 [#1]
>>>>    NIP [c0000000000388a4] .ioread32+0x4/0x20
>>>>    LR [80000000000c6034] .sata_fsl_port_stop+0x44/0xe0 [sata_fsl]
>>>>    Call Trace:
>>>>     .free_irq+0x1c/0x4e0 (unreliable)
>>>>     .ata_host_stop+0x74/0xd0 [libata]
>>>>     .release_nodes+0x330/0x3f0
>>>>     .device_release_driver_internal+0x178/0x2c0
>>>>     .driver_detach+0x64/0xd0
>>>>     .bus_remove_driver+0x70/0xf0
>>>>     .driver_unregister+0x38/0x80
>>>>     .platform_driver_unregister+0x14/0x30
>>>>     .fsl_sata_driver_exit+0x18/0xa20 [sata_fsl]
>>>>     .__se_sys_delete_module+0x1ec/0x2d0
>>>>     .system_call_exception+0xfc/0x1f0
>>>>     system_call_common+0xf8/0x200
>>>>    ==================================================================
>>>>
>>>> The triggering of the BUG is shown in the following stack:
>>>>
>>>> driver_detach
>>>>     device_release_driver_internal
>>>>       __device_release_driver
>>>>         drv->remove(dev) --> platform_drv_remove/platform_remove
>>>>           drv->remove(dev) --> sata_fsl_remove
>>>>             iounmap(host_priv->hcr_base);            <---- unmap
>>>>             kfree(host_priv);                             <---- free
>>>>         devres_release_all
>>>>           release_nodes
>>>>             dr->node.release(dev, dr->data) --> ata_host_stop
>>>>               ap->ops->port_stop(ap) --> sata_fsl_port_stop
>>>>                   ioread32(hcr_base + HCONTROL)           <---- UAF
>>>>               host->ops->host_stop(host)
>>>>
>>>> The iounmap(host_priv->hcr_base) and kfree(host_priv) commands should
>>>    s/commands/functions/?
>> OK! I'm going to modify this in V3.
>>
>>
>>>> not be executed in drv->remove. These commands should be executed in
>>>> host_stop after port_stop. Therefore, we move these commands to the
>>>> new function sata_fsl_host_stop and bind the new function to host_stop
>>>> by referring to achi.
>>>    You mean AHCI? I don't see where you reference ahci (or achi)...
>> Yes, it's AHCI, I'm sorry for a spelling error here..
>>
>> ahci_platform_ops in drivers/ata/libahci_platform.c
>>
>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>    Doesn't this need to go into the stable trees?
>>
>> I felt it was needed because the bug was triggered in a very simple way,
>>
>> although PPC linux is rare these days.
>>
>> And I will add
>>
>> Fixes: faf0b2e5afe7 ("drivers/ata: add support to Freescale 3.0Gbps SATA Controller").
> Also add:
>
> Cc: stable@vger.kernel.org
>
>
>>>> ---
>>>>    drivers/ata/sata_fsl.c | 17 ++++++++++++++---
>>>>    1 file changed, 14 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>>>> index e5838b23c9e0..30759fd1c3a2 100644
>>>> --- a/drivers/ata/sata_fsl.c
>>>> +++ b/drivers/ata/sata_fsl.c
>>>> @@ -1430,12 +1430,25 @@ static struct ata_port_operations sata_fsl_ops = {
>>>>        .pmp_detach = sata_fsl_pmp_detach,
>>>>    };
>>>>    +static void sata_fsl_host_stop(struct ata_host *host)
>>>> +{
>>>> +    struct sata_fsl_host_priv *host_priv = host->private_data;
>>>> +
>>>> +    iounmap(host_priv->hcr_base);
>>>> +    kfree(host_priv);
>>>> +}
>>>> +
>>>> +static struct ata_port_operations sata_fsl_platform_ops = {
>>>> +    .inherits       = &sata_fsl_ops,
>>>> +    .host_stop      = sata_fsl_host_stop,
>>>    Why not just add it to the initializer for sata_fsl_ops?
>>
>> This is the AHCI of the reference.
>>
>> Most ATA drivers add host_stop to to the  initializer for  xxx_platform_ops,
>>
>> such as ahci_platform_ops, ahci_brcm_platform_ops, and ahci_imx_ops.
>>
>> It feels like this separates the port operation from the host operation,
>>
>> making the hierarchy of the code clearer.
>>
>>
>>> [...]
>>>
>>> MBR, Sergei
>>> .
>>
>> Thank you very much for your advice.
>>
>> If there's nothing else to modify, I'll send a patch V3.
>>
>> -- 
>> With Best Regards,
>> Baokun Li
>> .
>>
>

Thank you very much for your advice.

I'm about to send a patch V3 with the changes suggested by you.

-- 
With Best Regards,
Baokun Li
.

