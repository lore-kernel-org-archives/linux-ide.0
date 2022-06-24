Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF109C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 24 Jun 2022 20:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiFXUE5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 24 Jun 2022 16:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiFXUE4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 24 Jun 2022 16:04:56 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AEF3A19A
        for <linux-ide@vger.kernel.org>; Fri, 24 Jun 2022 13:04:54 -0700 (PDT)
Received: from [192.168.1.103] (31.173.87.92) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 24 Jun
 2022 23:04:50 +0300
Subject: Re: [PATCH] ata: libata-scsi: fix result type of ata_ioc32()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <05a7fcf4-3a2b-3012-34c6-ca1f00fa457c@omp.ru>
 <2e7f96b6-2223-c687-a65b-6b90964bb4e1@opensource.wdc.com>
 <d1363b9b-db0a-a9c9-199f-ab71dbbc55d7@omp.ru>
 <f8ecc381-88bb-0fb7-d23c-3c074e23baca@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <67fb58c7-42e0-a405-458a-a6a46fc5afe0@omp.ru>
Date:   Fri, 24 Jun 2022 23:04:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f8ecc381-88bb-0fb7-d23c-3c074e23baca@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.87.92]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/24/2022 19:47:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 171356 [Jun 24 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 491 491 a718ef6dc942138335b0bcd7ab07f27b5c06005e
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;omp.ru:7.1.1;31.173.87.92:7.7.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.87.92
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/24/2022 19:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/24/2022 6:30:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/24/22 1:52 AM, Damien Le Moal wrote:
[...]
>>>> While ata_ioc32() returns 'int', its result gets assigned to and compared
>>>> with the 'unsigned long' variable 'val' in ata_sas_scsi_ioctl(), its only
>>>> caller, which implies a problematic implicit cast -- fix that by returning
>>>> 'bool' instead (actually, the object code doesn't seem to change, probably
>>>> because the function is always inlined).
>>>
>>> Looks good. I would though prefer to change this commit message to simply
>>> say that ata_ioc32() return value is clearly a bool.
>>
>>    No, just changing *int* to 'bool' wasn't the purpose of this patch --
>> I would not have called it a fix if it was so.
>>
>>> The implicit cast to
>>> unsigned long from int is not really an issue at all (the reverse cast
>>
>>    In general case, it is an issue -- as it involves a sign extension (and
>> thus a needless extra instruction on an x86_64 kernel)! However, with the
>> possible *int* values just being 0 and 1, it's not much of issue indeed
>> (except an extra instruction just being there)...  In reality , that extra
>> instruction is not there, probably due to ata_ioc32() being inlined...

   Yes, inlining is to blame here -- luckily we have 'noinline'! :-)

>>> would be an issue). And keep mentioning that the object code does not change.
>>>
>>> By the way, does your statis analyzer stop complaining after this change ?
>>
>>    I don't really know -- all I have is the online report generated for the
>> whole 5.10 kernel. I still can't re-run SVACE but maybe that will change soon...
>>
>>> Because we still have an implicit cast in the user site.
>>
>>    A cast from 'bool' should be OK... :-)
> 
> Yes, I am aware of that. My point is that the commit message does not say
> WHY it is OK. Need to mention that the cast is between unsigned types so
> is fine, or something like that.

   OK, I'll try to come up with something... didn't quite expect that this
patch would be so tough to get merged... :-)

>>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>>> analysis tool.
>>>>
>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> [...]

MBR, Sergey
