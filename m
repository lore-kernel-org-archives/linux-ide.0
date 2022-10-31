Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7505DC38A02
	for <linux-ide@archiver.kernel.org>; Mon, 31 Oct 2022 08:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJaINo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Oct 2022 04:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJaINo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2022 04:13:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAE1958B
        for <linux-ide@vger.kernel.org>; Mon, 31 Oct 2022 01:13:43 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N15Q235zrzmVb1;
        Mon, 31 Oct 2022 16:08:42 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 16:13:28 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 16:13:28 +0800
Subject: Re: [PATCH RESEND] ata: palmld: fix return value check in
 palmld_pata_probe()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <arnd@arndb.de>
CC:     <s.shtylyov@omp.ru>
References: <20221029074931.3189275-1-yangyingliang@huawei.com>
 <491dfec9-b6c5-5f20-a3f0-2a339e2d528c@opensource.wdc.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <e76bdc54-f078-b8db-6258-3bfe4ac59329@huawei.com>
Date:   Mon, 31 Oct 2022 16:13:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <491dfec9-b6c5-5f20-a3f0-2a339e2d528c@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 2022/10/31 13:46, Damien Le Moal wrote:
> On 10/29/22 16:49, Yang Yingliang wrote:
>> If devm_platform_ioremap_resource() fails, it never return
>> NULL pointer, replace the check with IS_ERR().
>>
>> Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>> The previous patch link:
>> https://lore.kernel.org/lkml/15e09c18-792b-931c-11c7-5ef284490eba@huawei.com/T/#t
>> ---
>>   drivers/ata/pata_palmld.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
>> index 400e65190904..51caa2a427dd 100644
>> --- a/drivers/ata/pata_palmld.c
>> +++ b/drivers/ata/pata_palmld.c
>> @@ -63,8 +63,8 @@ static int palmld_pata_probe(struct platform_device *pdev)
>>   
>>   	/* remap drive's physical memory address */
>>   	mem = devm_platform_ioremap_resource(pdev, 0);
>> -	if (!mem)
>> -		return -ENOMEM;
>> +	if (IS_ERR(mem))
>> +		return PTR_ERR(mem);
>>   
>>   	/* request and activate power and reset GPIOs */
>>   	lda->power = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);
> Arnd has a series of patches that removes this driver from the kernel in
> 6.2. Do you need this fix for a stable release ?
It's nice that you can merge this patch. If you don't take this, it's 
not a big problem.

Thanks,
Yang
>
