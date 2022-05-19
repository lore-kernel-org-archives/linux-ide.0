Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD1C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 19 May 2022 20:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbiESU6d (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 May 2022 16:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244996AbiESU6a (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 May 2022 16:58:30 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DF0ED8ED
        for <linux-ide@vger.kernel.org>; Thu, 19 May 2022 13:58:24 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 5E4212323A6D
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 2/3] ata: make ata_device::{pio|mwdma|udma}_mask *unsigned
 int*
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
 <20220508204139.4961-3-s.shtylyov@omp.ru>
 <90824959-6963-0836-3dca-0331e43e161b@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b2cf4a4f-0a7b-7e46-c938-9fa82b09f436@omp.ru>
Date:   Thu, 19 May 2022 23:58:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <90824959-6963-0836-3dca-0331e43e161b@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/16/22 2:19 PM, Damien Le Moal wrote:

>> The {pio|mwdma|udma}_mask fields of the *struct* ata_device are declared
>> as *unsigned long* (which is a 64-bit type on 64-bit architectures) while
>> the actual masks should easily fit into just 8 bits. The alike fields in
>> the *struct* ata_port are already declared as *unsigned int*, so follow
>> the suit, converting ata_[un]pack_xfermask() as necessary...
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
[...]
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 1429b7012ae8..f6fc482d767a 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -677,9 +677,9 @@ struct ata_device {
>>  	unsigned int		cdb_len;
>>  
>>  	/* per-dev xfer mask */
>> -	unsigned long		pio_mask;
>> -	unsigned long		mwdma_mask;
>> -	unsigned long		udma_mask;
>> +	unsigned int		pio_mask;
>> +	unsigned int		mwdma_mask;
>> +	unsigned int		udma_mask;
> 
> Ah. OK. So you did this here...
> Hmmm. I would squash these 3 patches into a single one. Otherwise, we have
> sort-of a mess without all patches applied (making revert a pain if needed).

   Hm... please explain what kind of a mess... BTW do you really expect a revert?

[...]

MBR, Sergey
