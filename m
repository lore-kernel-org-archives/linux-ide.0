Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9310C77B61
	for <linux-ide@archiver.kernel.org>; Fri, 28 Apr 2023 09:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbjD1JvG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Apr 2023 05:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjD1JvF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Apr 2023 05:51:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CB22701;
        Fri, 28 Apr 2023 02:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C54764227;
        Fri, 28 Apr 2023 09:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1297FC433D2;
        Fri, 28 Apr 2023 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682675463;
        bh=jeZ+tQySh8tl4JSRvwmCGKERqK2e69EIh/sv7jFGWVo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a5JugZLQ5rnCHiSJi305HWNfAvD2qTXHPqctUMUbEgOaz2BH4sKwC5/0WomzEzz4s
         jGO7pd/sYYOM03xNJbqpOl1lyHq+AeylcYmXxMRsF4Rlma0lqL1lC46jhU5v4XnsYt
         2GRzOJmRoyUSQ9DS4bInVVAM7FfaNoOm38EZlDF0UliAH+a/iHGdFxaonXjro9vBjX
         TYEDRzM23wB94877KGvUuQr6KjB0YlemGNfah+pF9VVvjFWgh3AFnnsVAmKGqYHD9+
         Kpu0zL+WCG0CdwcK/kwsPZRpZubER4l1A/oFiTp5FiTp6esV+R9zvjEEaB4ajTKKjU
         W+UrXxefkXv9A==
Message-ID: <e7c552a3-1665-a48c-bad3-aee2f790a0bd@kernel.org>
Date:   Fri, 28 Apr 2023 18:51:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-core: Simplies if condition
To:     Yahu Gao <yahu.gao@outlook.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yahu Gao <gaoyh12@lenovo.com>, Jiwei Sun <sunjw10@lenovo.com>
References: <20230422121415.6276-1-yahu.gao@outlook.com>
 <OS3P286MB0632739A614E451725FF697D9E619@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
 <OS0P286MB06283D2E74F02D7C541E46D79E6B9@OS0P286MB0628.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <OS0P286MB06283D2E74F02D7C541E46D79E6B9@OS0P286MB0628.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/28/23 10:53, Yahu Gao wrote:
> ping ...
> 
> 在 2023/4/22 20:14, Yahu Gao 写道:
>> From: Yahu Gao <gaoyh12@lenovo.com>
>>
>> Replace conditions of avoid issuing [P]IDENTIFY to PMP.
>>
>> Reviewed-by: Jiwei Sun <sunjw10@lenovo.com>
>> Signed-off-by: Yahu Gao <gaoyh12@lenovo.com>
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 14c17c3bda4e..53f65d751189 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -3802,11 +3802,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
>>   		return -ENODEV;
>>   
>>   	/* fail early if !ATA && !ATAPI to avoid issuing [P]IDENTIFY to PMP */
>> -	if (ata_class_enabled(new_class) &&
>> -	    new_class != ATA_DEV_ATA &&
>> -	    new_class != ATA_DEV_ATAPI &&
>> -	    new_class != ATA_DEV_ZAC &&
>> -	    new_class != ATA_DEV_SEMB) {
>> +	if (new_class == ATA_DEV_PMP) {
>>   		ata_dev_info(dev, "class mismatch %u != %u\n",
>>   			     dev->class, new_class);
>>   		rc = -ENODEV;

Merge window is on-going, so I will not queue this right now. Also I need to
check this as you remove the call to ata_class_enabled() and I am not 100%
convinced that it is correct.
