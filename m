Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78307EB64DD
	for <linux-ide@archiver.kernel.org>; Wed, 26 Jul 2023 02:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjGZCCo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jul 2023 22:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGZCCn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jul 2023 22:02:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF94121
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 19:02:41 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9cX31nNPzCrMl;
        Wed, 26 Jul 2023 09:59:15 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 10:02:37 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 10:02:37 +0800
Subject: Re: [PATCH] ata: pata_octeon_cf: fix error return code in
 octeon_cf_probe()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, <linux-ide@vger.kernel.org>
CC:     <dlemoal@kernel.org>, <robh@kernel.org>, <yangyingliang@huawei.com>
References: <20230725122809.521331-1-yangyingliang@huawei.com>
 <42f9f9dc-b48d-6b84-94e6-691e9500b50e@omp.ru>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <2817c126-b8b8-bcdd-5920-c06a05631692@huawei.com>
Date:   Wed, 26 Jul 2023 10:02:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <42f9f9dc-b48d-6b84-94e6-691e9500b50e@omp.ru>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2023/7/25 23:23, Sergey Shtylyov wrote:
> On 7/25/23 3:28 PM, Yang Yingliang wrote:
>
>> The 'rv' will be set to 0 after calling of_property_read_reg(),
>> return correct error code in the error path.
>>
>> Fixes: d0b2461678b1 ("ata: Use of_property_read_reg() to parse "reg"")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/ata/pata_octeon_cf.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
>> index ff538b858928..6b46e20b3830 100644
>> --- a/drivers/ata/pata_octeon_cf.c
>> +++ b/drivers/ata/pata_octeon_cf.c
>> @@ -893,12 +893,12 @@ static int octeon_cf_probe(struct platform_device *pdev)
>>   	cs0 = devm_ioremap(&pdev->dev, res_cs0->start,
>>   				   resource_size(res_cs0));
>>   	if (!cs0)
>> -		return rv;
>> +		return -EINVAL;
>     Hm, missed this one! Should be -ENOMEM as well.
When ioremap cs1 fails, it returns -EINVAL, it needs be changed too. I 
will send a patch to modify it.

Thanks,
Yang
>
>>   
>>   	/* allocate host */
>>   	host = ata_host_alloc(&pdev->dev, 1);
>>   	if (!host)
>> -		return rv;
>> +		return -ENOMEM;
> [...]
>
> MBR, Sergey
>
> .
