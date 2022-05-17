Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CFDC433F5
	for <linux-ide@archiver.kernel.org>; Tue, 17 May 2022 19:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbiEQTnI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 May 2022 15:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiEQTnH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 May 2022 15:43:07 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC0427B07
        for <linux-ide@vger.kernel.org>; Tue, 17 May 2022 12:43:04 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru ED4C220D5BCA
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: libata-core: fix sloppy typing in ata_id_n_sectors()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <a15e1894-8be2-70f8-26b4-be62de8055d9@omp.ru>
 <f8e5288f-e0e9-da11-6a82-6bcbe5365eea@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <0fbb1f50-503c-f258-2a34-10cf069a633e@omp.ru>
Date:   Tue, 17 May 2022 22:43:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f8e5288f-e0e9-da11-6a82-6bcbe5365eea@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 5/16/22 2:29 PM, Damien Le Moal wrote:

>> The code multiplying the # of cylinders/heads/sectors in ata_id_n_sectors()
>> to get a disk capacity implicitly uses the *int* type for that calculation
>> and casting the result to 'u64' before returning ensues a sign extension.
>> Explicitly casting the 'u16' typed multipliers to 'u32' results in avoiding
>> a sign extension instruction and so in a more compact code...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> ---
>> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
>>
>>  drivers/ata/libata-core.c |   10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> Index: libata/drivers/ata/libata-core.c
>> ===================================================================
>> --- libata.orig/drivers/ata/libata-core.c
>> +++ libata/drivers/ata/libata-core.c
>> @@ -1107,11 +1107,13 @@ static u64 ata_id_n_sectors(const u16 *i
>>  			return ata_id_u32(id, ATA_ID_LBA_CAPACITY);
>>  	} else {
>>  		if (ata_id_current_chs_valid(id))
>> -			return id[ATA_ID_CUR_CYLS] * id[ATA_ID_CUR_HEADS] *
>> -			       id[ATA_ID_CUR_SECTORS];
>> +			return (u32)id[ATA_ID_CUR_CYLS] *
>> +			       (u32)id[ATA_ID_CUR_HEADS] *
>> +			       (u32)id[ATA_ID_CUR_SECTORS];
>>  		else
> 
> While at it, you can drop this useless "else". The 2 else above this one are
> actually also useless...

   OK. But I think it's all a matter of a separate patch. I don't want to touch
the LBA branches in this same patch...

>> -			return id[ATA_ID_CYLS] * id[ATA_ID_HEADS] *
>> -			       id[ATA_ID_SECTORS];
>> +			return (u32)id[ATA_ID_CYLS] *
>> +			       (u32)id[ATA_ID_HEADS] *
>> +			       (u32)id[ATA_ID_SECTORS];
> 
> Given that the function returns an u64, I would cast everything to u64. That

   I don't think this is a good idea. Looking at the produced x86 32-bit code,
gcc produces an extra (3rd) multiplication instruction for no value.

> will avoid overflows too, which was possible before,

   No, it wasn't possible. Any possible CHS capacity always fits into 32 bits --
max # of sectors per track is 255, max # of heads is only 16.
   What actually seems to make sense is changing the order of multiplications
to first multiply # of sectors by # of heads and than multiply that by # of
cylinders...

> eventhough no problems seem
> to have been reported...

   Because there's not problem. :-)
   The current CHS capacity is stored in the words 57-58 (so 32-bit) and we
could read it from there instead of the multiplications... BUT I do remember
the disks (IIRC Fujitsu... but I'm not sure now -- that was back in 90s!)
that had totally wrong value in these words... so the code we have now is
a good thing! :-)

> Who uses CHS these days :)

   Indeed, the CHS days are long gone... :-)

[...]

MBR, Sergey
