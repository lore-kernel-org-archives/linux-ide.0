Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC887C43334
	for <linux-ide@archiver.kernel.org>; Thu, 23 Jun 2022 19:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiFWTYq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiFWTY0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jun 2022 15:24:26 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A0B792A1
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2022 11:34:02 -0700 (PDT)
Received: from [192.168.1.103] (31.173.85.234) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 23 Jun
 2022 21:33:40 +0300
Subject: Re: [PATCH] ata: libata-scsi: fix result type of ata_ioc32()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <05a7fcf4-3a2b-3012-34c6-ca1f00fa457c@omp.ru>
 <2e7f96b6-2223-c687-a65b-6b90964bb4e1@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d1363b9b-db0a-a9c9-199f-ab71dbbc55d7@omp.ru>
Date:   Thu, 23 Jun 2022 21:33:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2e7f96b6-2223-c687-a65b-6b90964bb4e1@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.85.234]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/23/2022 18:09:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171342 [Jun 23 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 491 491 a718ef6dc942138335b0bcd7ab07f27b5c06005e
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.85.234 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.85.234 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.85.234
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/23/2022 18:13:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/23/2022 4:30:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 6/23/22 2:45 AM, Damien Le Moal wrote:
[...]
>> While ata_ioc32() returns 'int', its result gets assigned to and compared
>> with the 'unsigned long' variable 'val' in ata_sas_scsi_ioctl(), its only
>> caller, which implies a problematic implicit cast -- fix that by returning
>> 'bool' instead (actually, the object code doesn't seem to change, probably
>> because the function is always inlined).
> 
> Looks good. I would though prefer to change this commit message to simply
> say that ata_ioc32() return value is clearly a bool.

   No, just changing *int* to 'bool' wasn't the purpose of this patch --
I would not have called it a fix if it was so.

> The implicit cast to
> unsigned long from int is not really an issue at all (the reverse cast

   In general case, it is an issue -- as it involves a sign extension (and
thus a needless extra instruction on an x86_64 kernel)! However, with the
possible *int* values just being 0 and 1, it's not much of issue indeed
(except an extra instruction just being there)...  In reality , that extra
instruction is not there, probably due to ata_ioc32() being inlined...

> would be an issue). And keep mentioning that the object code does not change.
> 
> By the way, does your statis analyzer stop complaining after this change ?

   I don't really know -- all I have is the online report generated for the
whole 5.10 kernel. I still can't re-run SVACE but maybe that will change soon...

> Because we still have an implicit cast in the user site.

   A cast from 'bool' should be OK... :-)

>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
[...]

MBR, Sergey
