Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C18FC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Jun 2022 20:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244052AbiFIUPU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Jun 2022 16:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244861AbiFIUPT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jun 2022 16:15:19 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1446FF45D7
        for <linux-ide@vger.kernel.org>; Thu,  9 Jun 2022 13:15:14 -0700 (PDT)
Received: from [192.168.1.103] (31.173.84.193) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 9 Jun 2022
 23:15:05 +0300
Subject: Re: [PATCH] ata: libata-core: fix sloppy typing in ata_id_n_sectors()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <a15e1894-8be2-70f8-26b4-be62de8055d9@omp.ru>
 <2a523107-9838-0940-1402-3b6bdad7e1e1@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <1651775c-cb00-0bdc-e27f-700d0580ec88@omp.ru>
Date:   Thu, 9 Jun 2022 23:15:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2a523107-9838-0940-1402-3b6bdad7e1e1@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.84.193]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/09/2022 19:56:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171038 [Jun 09 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 489 489 b67d2e276d358fa514f5991440453e6a402e3a26
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.84.193 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.84.193
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/09/2022 20:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/9/2022 4:23:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/8/22 9:47 AM, Damien Le Moal wrote:

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
>> -			return id[ATA_ID_CYLS] * id[ATA_ID_HEADS] *
>> -			       id[ATA_ID_SECTORS];
>> +			return (u32)id[ATA_ID_CYLS] *
>> +			       (u32)id[ATA_ID_HEADS] *
>> +			       (u32)id[ATA_ID_SECTORS];
>>  	}
>>  }
>>  
> 
> Applied to for-5.20. Thanks !

   Actually I was going to redo it (changing the order of multiplications), but well,
it's OK as is...

MBR, Sergey
