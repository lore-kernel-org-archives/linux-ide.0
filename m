Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1E7C0015E
	for <linux-ide@archiver.kernel.org>; Wed, 26 Jul 2023 03:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjGZDdZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jul 2023 23:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjGZDdU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jul 2023 23:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D8726AE
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 20:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55954611B6
        for <linux-ide@vger.kernel.org>; Wed, 26 Jul 2023 03:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B22C433C7;
        Wed, 26 Jul 2023 03:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690342395;
        bh=1BxuLWqRaxYtwxiUCv5y2JTmAM8Be+GxiTQ2vQ6gAFE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uS4k2w7RS1BFHS1kdMOyFiKK7S3zHqqmvUxhQx+NGXWUYusz7N+7yoSegYVawfLpV
         jSmZcYB/wtKlTAjm6u9spaIuuoY7i1ZGhTuIbb2HSPNpAc+/jD9XSwfiaKkRWmSNbP
         4Q0gUCk7YeibNsfX1rrHfp05oGVCdZvAwyR8QfnNTARFmbsVqAMuVEybzI/F04J+uP
         xsjLHohmXx1vbpDJCU3mRv7Tqua+EpYRc5mMe+uzjgFeRzhyVniNk7SxfV9UtSmeNb
         CWYas2UCxAOa7IxFRsPayx9JgwJjE8DREQPbEAWvjI7HKa//ZwvAXpUMw0DYpq5Xxt
         vx9HdEF4Z35/Q==
Message-ID: <4542a5bc-f7a3-f608-5b06-ddee1bba7352@kernel.org>
Date:   Wed, 26 Jul 2023 12:33:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: pata_octeon_cf: fix error return code in
 octeon_cf_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
Cc:     robh@kernel.org
References: <20230725122809.521331-1-yangyingliang@huawei.com>
 <42f9f9dc-b48d-6b84-94e6-691e9500b50e@omp.ru>
 <2817c126-b8b8-bcdd-5920-c06a05631692@huawei.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2817c126-b8b8-bcdd-5920-c06a05631692@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/26/23 11:02, Yang Yingliang wrote:
> 
> On 2023/7/25 23:23, Sergey Shtylyov wrote:
>> On 7/25/23 3:28 PM, Yang Yingliang wrote:
>>
>>> The 'rv' will be set to 0 after calling of_property_read_reg(),
>>> return correct error code in the error path.
>>>
>>> Fixes: d0b2461678b1 ("ata: Use of_property_read_reg() to parse "reg"")
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> ---
>>>   drivers/ata/pata_octeon_cf.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
>>> index ff538b858928..6b46e20b3830 100644
>>> --- a/drivers/ata/pata_octeon_cf.c
>>> +++ b/drivers/ata/pata_octeon_cf.c
>>> @@ -893,12 +893,12 @@ static int octeon_cf_probe(struct platform_device *pdev)
>>>   	cs0 = devm_ioremap(&pdev->dev, res_cs0->start,
>>>   				   resource_size(res_cs0));
>>>   	if (!cs0)
>>> -		return rv;
>>> +		return -EINVAL;
>>     Hm, missed this one! Should be -ENOMEM as well.
> When ioremap cs1 fails, it returns -EINVAL, it needs be changed too. I 
> will send a patch to modify it.

No need. I fixed that when applying the patch.

> 
> Thanks,
> Yang
>>
>>>   
>>>   	/* allocate host */
>>>   	host = ata_host_alloc(&pdev->dev, 1);
>>>   	if (!host)
>>> -		return rv;
>>> +		return -ENOMEM;
>> [...]
>>
>> MBR, Sergey
>>
>> .

-- 
Damien Le Moal
Western Digital Research

