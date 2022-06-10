Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD3CC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jun 2022 21:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344417AbiFJVP6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiFJVP5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2022 17:15:57 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36215CE0C
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2022 14:15:53 -0700 (PDT)
Received: from [192.168.1.103] (31.173.80.9) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 11 Jun
 2022 00:15:44 +0300
Subject: Re: [PATCH 2/3] ata: make ata_device::{pio|mwdma|udma}_mask *unsigned
 int*
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
 <20220508204139.4961-3-s.shtylyov@omp.ru>
 <90824959-6963-0836-3dca-0331e43e161b@opensource.wdc.com>
 <b2cf4a4f-0a7b-7e46-c938-9fa82b09f436@omp.ru>
 <09e49f39-53fd-ae03-da98-921fa159db55@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <6b14a022-83a0-fcc1-1fdb-8cd7c9e441dc@omp.ru>
Date:   Sat, 11 Jun 2022 00:15:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <09e49f39-53fd-ae03-da98-921fa159db55@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.80.9]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/10/2022 21:02:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171067 [Jun 10 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 489 489 b67d2e276d358fa514f5991440453e6a402e3a26
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.9 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.9 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1;31.173.80.9:7.7.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.9
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/10/2022 21:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/10/2022 6:32:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/20/22 6:31 AM, Damien Le Moal wrote:
[...]

>>>> The {pio|mwdma|udma}_mask fields of the *struct* ata_device are declared
>>>> as *unsigned long* (which is a 64-bit type on 64-bit architectures) while
>>>> the actual masks should easily fit into just 8 bits. The alike fields in
>>>> the *struct* ata_port are already declared as *unsigned int*, so follow
>>>> the suit, converting ata_[un]pack_xfermask() as necessary...
>>>>
>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> [...]
>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>> index 1429b7012ae8..f6fc482d767a 100644
>>>> --- a/include/linux/libata.h
>>>> +++ b/include/linux/libata.h
>>>> @@ -677,9 +677,9 @@ struct ata_device {
>>>>  	unsigned int		cdb_len;
>>>>  
>>>>  	/* per-dev xfer mask */
>>>> -	unsigned long		pio_mask;
>>>> -	unsigned long		mwdma_mask;
>>>> -	unsigned long		udma_mask;
>>>> +	unsigned int		pio_mask;
>>>> +	unsigned int		mwdma_mask;
>>>> +	unsigned int		udma_mask;
>>>
>>> Ah. OK. So you did this here...
>>> Hmmm. I would squash these 3 patches into a single one. Otherwise, we have
>>> sort-of a mess without all patches applied (making revert a pain if needed).
>>
>>    Hm... please explain what kind of a mess... BTW do you really expect a revert?
> 
> The mess would be a partial conversion of the type in case of a revert
> being needed. And no, I do not expect a revert would be ever needed, but
> hey, never know :)

   There shouldn't be a "partial conversion" -- all the patches are actually
independent from each other (except for the context)...

MBR, Sergey
