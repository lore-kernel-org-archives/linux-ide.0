Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0193C43334
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jun 2022 20:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbiFOUEZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 16:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiFOUEY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 16:04:24 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 13:04:20 PDT
Received: from mx01.omp.ru (unknown [95.181.193.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA208340E9
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 13:04:20 -0700 (PDT)
Received: from [192.168.1.103] (31.173.86.16) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 15 Jun
 2022 22:49:08 +0300
Subject: Re: [PATCH v2 0/2] Fix sloppy 'timeout' parameter type in
 libata-core.c
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20220615193821.9235-1-s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <7da76e0a-3805-6e33-def2-3846a2f3c8a8@omp.ru>
Date:   Wed, 15 Jun 2022 22:49:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220615193821.9235-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.86.16]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/15/2022 19:25:54
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 171152 [Jun 15 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 489 489 b67d2e276d358fa514f5991440453e6a402e3a26
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.16 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 31.173.86.16:7.4.1,7.7.2;omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.16
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/15/2022 19:28:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/15/2022 4:39:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/15/22 10:38 PM, Sergey Shtylyov wrote:

> The libata code too often uses the *unsigned long* type for the millisecond
> timeouts, while the kernel functions like msecs_to_jiffies() or msleep() only
> take *unsigned int* parameters for those. Start fixing the timeout types from
> ata_exec_internal[_sg]() that triggered the SVACE static analyzer; there's
> going to be a large continuation series somewhat later...
> 
> Sergey Shtylyov (2):
>   ata: libata-core: make ata_exec_internal_sg() *static*
>   ata: libata-core: fix sloppy parameter type in ata_exec_internal[_sg]()
> 
>  drivers/ata/libata-core.c | 12 ++++++------
>  drivers/ata/libata.h      |  6 +-----
>  2 files changed, 7 insertions(+), 11 deletions(-)

  Forgot to mention the patches are against the 'for-next' branch of Damien's
'libata.git' repo... :-/

MBR, Sergey
