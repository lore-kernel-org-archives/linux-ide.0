Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A8CC6379F
	for <linux-ide@archiver.kernel.org>; Wed,  1 Feb 2023 17:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjBARSt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Feb 2023 12:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjBARSp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2023 12:18:45 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A124616F;
        Wed,  1 Feb 2023 09:18:42 -0800 (PST)
Received: from [192.168.1.103] (178.176.77.227) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 1 Feb 2023
 20:18:34 +0300
Subject: Re: [PATCH] ata: pata_hpt37x: fix potential forever loop
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Dan Carpenter <error27@gmail.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <Y9py1vjPW5HgRwOR@kili>
 <98e8e8cb-53a3-c247-078e-85724079ecad@omp.ru>
Organization: Open Mobile Platform
Message-ID: <eb44fe29-47bb-315e-c340-10918a6250f6@omp.ru>
Date:   Wed, 1 Feb 2023 20:18:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <98e8e8cb-53a3-c247-078e-85724079ecad@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.77.227]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 02/01/2023 17:00:31
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 175185 [Feb 01 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.77.227 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.77.227 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.77.227
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/01/2023 17:03:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/1/2023 3:09:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/1/23 5:59 PM, Sergey Shtylyov wrote:
[...]
>> This code accidentally reuses the "tries" iterator for both the inside
>> and outside loops.  It could result in a forever loop if the "tries"
>> variable gets reset to 0x1000 and never reaches 0x5000.

   Have you actually seen this happening?

>>
>> Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")
>> Signed-off-by: Dan Carpenter <error27@gmail.com>
>> ---
>>  drivers/ata/pata_hpt37x.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
>> index ce3c5eaa7e76..35be9a095b18 100644
>> --- a/drivers/ata/pata_hpt37x.c
>> +++ b/drivers/ata/pata_hpt37x.c
>> @@ -621,14 +621,14 @@ static int hpt37x_calibrate_dpll(struct pci_dev *dev)
>>  {
>>  	u8 reg5b;
>>  	u32 reg5c;
>> -	int tries;
>> +	int tries, tries2;
>>  
>>  	for (tries = 0; tries < 0x5000; tries++) {
>>  		udelay(50);
>>  		pci_read_config_byte(dev, 0x5b, &reg5b);
>>  		if (reg5b & 0x80) {
>>  			/* See if it stays set */
>> -			for (tries = 0; tries < 0x1000; tries++) {
>> +			for (tries2 = 0; tries2 < 0x1000; tries2++) {
>>  				pci_read_config_byte(dev, 0x5b, &reg5b);
>>  				/* Failed ? */
>>  				if ((reg5b & 0x80) == 0)
> 
>    Looks like Alan tried to "fix" the DPLL calibration code imported from drivers/ide/hpt366.c
> and failed at that... :-) The iriginal code has 2 sequential loops (thus 'tries' could be used
> for both). In principle, I agree with a simplistic patch:

   Err, wait! Once we have bit 7 of the PCI register at 0x5b set, we'll never
return to the outer loop... So, I'm ot seeing the bug here...

> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

   So I have to take this back...

MBR, Sergey
