Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71853C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 06:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbiDYGEZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Apr 2022 02:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbiDYGDR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Apr 2022 02:03:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B6F39167;
        Sun, 24 Apr 2022 23:00:08 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KmvTt4W7hzfb5H;
        Mon, 25 Apr 2022 13:59:14 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 14:00:06 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 14:00:05 +0800
Subject: Re: [PATCH -next] ata: palmld: fix return value check in
 palmld_pata_probe()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
CC:     <damien.lemoal@opensource.wdc.com>, <arnd@arndb.de>,
        <b.zolnierkie@samsung.com>, <robert.jarzmik@free.fr>
References: <20220424093420.2129779-1-yangyingliang@huawei.com>
 <24916b73-15dc-1ab7-7d5d-532d177fecec@omp.ru>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <15e09c18-792b-931c-11c7-5ef284490eba@huawei.com>
Date:   Mon, 25 Apr 2022 14:00:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <24916b73-15dc-1ab7-7d5d-532d177fecec@omp.ru>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2022/4/25 0:55, Sergey Shtylyov wrote:
> Hello!
>
>     You should CC: me on the PATA driver patches, not Bart -- he no longer maintains
> the PATA drivers.
OK.

Thanks,
Yang
>
> On 4/24/22 12:34 PM, Yang Yingliang wrote:
>
>> If devm_platform_ioremap_resource() fails, it never return
>> NULL pointer, replace the check with IS_ERR().
>>
>> Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> [...]
>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>
> MBR, Sergey
> .
