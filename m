Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2974DC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jun 2022 07:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiF2HlL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiF2HlI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jun 2022 03:41:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81E34BBB;
        Wed, 29 Jun 2022 00:41:03 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXtZf3KJ7z67ybq;
        Wed, 29 Jun 2022 15:36:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 09:41:00 +0200
Received: from [10.195.245.77] (10.195.245.77) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 08:41:00 +0100
Message-ID: <7a78b7d0-fe02-4efe-cfbb-5a4a1b5b2f91@huawei.com>
Date:   Wed, 29 Jun 2022 08:41:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] ata: pata_cs5535: Fix W=1 warnings
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
 <16f727b8-c3b0-c828-0c5b-6728a6e7934f@opensource.wdc.com>
 <9044b81f-76db-75de-db74-f45d6e5ea71e@omp.ru>
 <d26b8345-02e9-e461-c506-b429c44f74df@omp.ru>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <d26b8345-02e9-e461-c506-b429c44f74df@omp.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.245.77]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 28/06/2022 19:39, Sergey Shtylyov wrote:
> On 6/28/22 1:05 PM, Sergey Shtylyov wrote:
> [...]
>>>> x86_64 allmodconfig build with W=1 gives these warnings:
>>>>
>>>> drivers/ata/pata_cs5535.c: In function ‘cs5535_set_piomode’:
>>>> drivers/ata/pata_cs5535.c:93:11: error: variable ‘dummy’ set but not used [-Werror=unused-but-set-variable]
>>>>    u32 reg, dummy;
>>>>             ^~~~~
>>>> drivers/ata/pata_cs5535.c: In function ‘cs5535_set_dmamode’:
>>>> drivers/ata/pata_cs5535.c:132:11: error: variable ‘dummy’ set but not used [-Werror=unused-but-set-variable]
>>>>    u32 reg, dummy;
>>>>             ^~~~~
>>>> cc1: all warnings being treated as errors
>>>>
>>>> Mark variables 'dummy' as "maybe unused" to satisfy when rdmsr() is
>>>> stubbed, which is the same as what we already do in pata_cs5536.c .
> 
>     Wait, what do you mean by "stubbed", the version in <asm/paravirt.h>?

Ah, this mentioning of stubbed is wrong on my part. I was distracted by 
the stub in pata_cs5536.c - that's what my text editor showed me for the 
defintion of rdmsr()

Hi Damien,

I see that you applied this patch. If it has not been pushed can we hand 
edit the commit message or I can send a v2? Or maybe we can live with it...

Thanks,
John

> 
>>>>
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...]
> 
> MBR, Sergey
> .

