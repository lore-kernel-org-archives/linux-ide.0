Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B878EEB64DD
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jul 2023 22:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjGYWte (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jul 2023 18:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGYWtS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jul 2023 18:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9579E61AF
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 15:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48DBA61938
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 22:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF08C433C8;
        Tue, 25 Jul 2023 22:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690324136;
        bh=A8x8BEQBsb1ZZdDRofdv2zF62K2tqwNDjqnPzjAnQzg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iU4Lw0WW8aOqYBo4Kk5QYhpy0SKRusfS8mYPrp14JT5igr3v6JcDCJzzWnEpuThPW
         UrUwYqAc+oNUd0BYEf3EHskFHnMzpcWvi71ATEms7/qplCLFgqim2Y1zlXHLEDYrFO
         XY2yKrm3KyrCB8/QuDKuVVB4NeaVmBMm7UsWtRZk+ZaDPQFEbYvIAiql4hwQPFJfwF
         w7ej1ZgqN4BZiviqoXKI27YrGA8kzDDIZFve3izzaHJ3GulFx7mTr3Ym/1u0SwClJa
         OtHE/6XixtI7zsHLJZQY0pH5mnIu0YbBi75+nNDYfRMoeD3i1COT0zYkz/OknKDmko
         iQ49yjbJS4aNQ==
Message-ID: <677bc61d-76c8-1b9a-04fb-b66d84fce9c2@kernel.org>
Date:   Wed, 26 Jul 2023 07:28:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: pata_octeon_cf: fix error return code in
 octeon_cf_probe()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
Cc:     robh@kernel.org
References: <20230725122809.521331-1-yangyingliang@huawei.com>
 <42f9f9dc-b48d-6b84-94e6-691e9500b50e@omp.ru>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <42f9f9dc-b48d-6b84-94e6-691e9500b50e@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/26/23 00:23, Sergey Shtylyov wrote:
> On 7/25/23 3:28 PM, Yang Yingliang wrote:
> 
>> The 'rv' will be set to 0 after calling of_property_read_reg(),
>> return correct error code in the error path.
>>
>> Fixes: d0b2461678b1 ("ata: Use of_property_read_reg() to parse "reg"")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>  drivers/ata/pata_octeon_cf.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
>> index ff538b858928..6b46e20b3830 100644
>> --- a/drivers/ata/pata_octeon_cf.c
>> +++ b/drivers/ata/pata_octeon_cf.c
>> @@ -893,12 +893,12 @@ static int octeon_cf_probe(struct platform_device *pdev)
>>  	cs0 = devm_ioremap(&pdev->dev, res_cs0->start,
>>  				   resource_size(res_cs0));
>>  	if (!cs0)
>> -		return rv;
>> +		return -EINVAL;
> 
>    Hm, missed this one! Should be -ENOMEM as well.

Will fix that when applying.

> 
>>  
>>  	/* allocate host */
>>  	host = ata_host_alloc(&pdev->dev, 1);
>>  	if (!host)
>> -		return rv;
>> +		return -ENOMEM;
> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

