Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18251C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jun 2022 17:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiFQR2L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jun 2022 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiFQR2K (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jun 2022 13:28:10 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2A01CFE9
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 10:28:04 -0700 (PDT)
Received: from [192.168.1.103] (178.176.76.79) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 17 Jun
 2022 20:27:56 +0300
Subject: Re: [PATCH v2 2/2] ata: libata-core: fix sloppy parameter type in
 ata_exec_internal[_sg]()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20220615193821.9235-1-s.shtylyov@omp.ru>
 <20220615193821.9235-3-s.shtylyov@omp.ru>
 <849f65c3-007e-8f01-2412-e91b3fd6d254@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <c2aac3d9-d1d9-eb87-2644-462f30902352@omp.ru>
Date:   Fri, 17 Jun 2022 20:27:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <849f65c3-007e-8f01-2412-e91b3fd6d254@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.76.79]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/17/2022 17:07:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171211 [Jun 17 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 490 490 64947c9fe6ec4170c45683de1592f92a9c3bac07
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.76.79 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.76.79
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/17/2022 17:11:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/17/2022 2:19:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 6/17/22 10:44 AM, Damien Le Moal wrote:

>> Make the 'timeout' parameter to ata_exec_internal_sg() *unsigned int* as
>> msecs_to_jiffies() that it calls takes just *unsigned int* for the time in
>> milliseconds. Then follow the suit with ata_exec_internal(), its only
>> caller; also fix up ata_dev_set_feature(), the only ata_exec_internal()'s
>> caller  that explicitly passes *unsigned long* variable for timeout...
> 
> Checking this, struct ata_eh_cmd_timeout_ent uses an unsigned long timeout
> and ata_internal_cmd_timeout() returns an unsigned long which is stored
> into the unsigned int timeout variable.

   I know. All timeouts stored in those tables fit into *unsigned int* (except
the last ones which get truncated from ULONG_MAX to UINT_MAX anyways).
   Note that *unsigned long* has always been silently truncated to *unsigned int*
when calling msecs_to_jiffies() in ata_exec_internal_sg(); nothing changes with
my patch, it just gets truncated a bit earlier...

> So it may be good to add another
> prep patch before this one to cleanup the auto_timeout stuff (struct
> ata_eh_cmd_timeout_ent and ata_internal_cmd_timeout()).

   It shouldn't matter whether we do it before or after this patch, due to
truncation which happens even now (I have such a patch, but no description
yet). I was planning to address that as a part of the large patch series,
most probably next week (and I wrote about that in the cover letter)...

> Hmm ? Thoughts ?

   Was I clear enough? :-)

>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.

   I wanted to fix SVACE's reports 1st, then the rest of the sloppy timeout
typing...

>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
[...]

MBR, Sergey
