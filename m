Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A345C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 20 Nov 2021 02:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhKTCTe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 21:19:34 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31889 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhKTCTd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2021 21:19:33 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hwxq81kR3zcbMK;
        Sat, 20 Nov 2021 10:11:32 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sat, 20 Nov 2021 10:16:29 +0800
Subject: Re: [PATCH -next 2/2] sata_fsl: fix warning in remove_proc_entry when
 rmmod sata_fsl
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        <damien.lemoal@opensource.wdc.com>, <axboe@kernel.dk>,
        <tj@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yebin10@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
References: <20211119041128.2436889-1-libaokun1@huawei.com>
 <20211119041128.2436889-3-libaokun1@huawei.com>
 <283712c0-bab7-de13-fc27-6ae2e6f9532f@gmail.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <110d4b51-9cc3-22fd-885e-0bbeb1707bda@huawei.com>
Date:   Sat, 20 Nov 2021 10:16:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <283712c0-bab7-de13-fc27-6ae2e6f9532f@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

在 2021/11/19 23:43, Sergei Shtylyov 写道:
> Hello!
>
> On 19.11.2021 7:11, Baokun Li wrote:
>
>> Trying to remove the fsl-sata module in the PPC64 GNU/Linux
>> leads to the following warning:
>>   ------------[ cut here ]------------
>>   remove_proc_entry: removing non-empty directory 'irq/69',
>>     leaking at least 'fsl-sata[ff0221000.sata]'
>>   WARNING: CPU: 3 PID: 1048 at fs/proc/generic.c:722
>>     .remove_proc_entry+0x20c/0x220
>>   IRQMASK: 0
>>   NIP [c00000000033826c] .remove_proc_entry+0x20c/0x220
>>   LR [c000000000338268] .remove_proc_entry+0x208/0x220
>>   Call Trace:
>>    .remove_proc_entry+0x208/0x220 (unreliable)
>>    .unregister_irq_proc+0x104/0x140
>>    .free_desc+0x44/0xb0
>>    .irq_free_descs+0x9c/0xf0
>>    .irq_dispose_mapping+0x64/0xa0
>>    .sata_fsl_remove+0x58/0xa0 [sata_fsl]
>>    .platform_drv_remove+0x40/0x90
>>    .device_release_driver_internal+0x160/0x2c0
>>    .driver_detach+0x64/0xd0
>>    .bus_remove_driver+0x70/0xf0
>>    .driver_unregister+0x38/0x80
>>    .platform_driver_unregister+0x14/0x30
>>    .fsl_sata_driver_exit+0x18/0xa20 [sata_fsl]
>>   ---[ end trace 0ea876d4076908f5 ]---
>>
>> The driver creates the mapping by calling irq_of_parse_and_map(),
>> so it also has to dispose the mapping. But the easy way out is to
>> simply use platform_get_irq() instead of irq_of_parse_map().
>
>   Not that easy. :-)
>
>> In this case the mapping is not managed by the device but by
>> the of core, so the device has not to dispose the mapping.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   drivers/ata/sata_fsl.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>> index 30759fd1c3a2..011daac4a14e 100644
>> --- a/drivers/ata/sata_fsl.c
>> +++ b/drivers/ata/sata_fsl.c
>> @@ -1493,7 +1493,7 @@ static int sata_fsl_probe(struct 
>> platform_device *ofdev)
>>       host_priv->ssr_base = ssr_base;
>>       host_priv->csr_base = csr_base;
>>   -    irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
>> +    irq = platform_get_irq(ofdev, 0);
>>       if (!irq) {
>
>     if (irq < 0) {
>
>   platform_get_irq() returns negative error codes, not 0 on failure.
>
> [...]
>
> MBR, Sergey
> .

I didn't notice the change in this return value, and the test didn't 
cover the error branch.

Thank you very much for your correction.

I'm about to send a patch v2 with the changes suggested by you.

-- 
With Best Regards,
Baokun Li
.

