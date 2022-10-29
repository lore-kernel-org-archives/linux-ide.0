Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE69C433FE
	for <linux-ide@archiver.kernel.org>; Sat, 29 Oct 2022 10:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJ2K0M (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 29 Oct 2022 06:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ2K0K (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 29 Oct 2022 06:26:10 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAF6664C7
        for <linux-ide@vger.kernel.org>; Sat, 29 Oct 2022 03:26:01 -0700 (PDT)
Received: from [192.168.1.103] (31.173.80.252) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 29 Oct
 2022 13:25:51 +0300
Subject: Re: [PATCH] ata: pata_legacy: fix pdc20230_set_piomode()
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <llvm@lists.linux.dev>
References: <99d91d0e-d3fc-5492-ddca-6da6e65e1e89@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a0e81265-2704-90ac-1282-c6c1977237b9@omp.ru>
Date:   Sat, 29 Oct 2022 13:25:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <99d91d0e-d3fc-5492-ddca-6da6e65e1e89@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.80.252]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/29/2022 09:47:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 173322 [Oct 28 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: 31.173.80.252:7.7.3,7.4.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.252
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/29/2022 09:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/29/2022 6:42:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 10/29/22 12:07 AM, Sergey Shtylyov wrote:

> Clang gives a warning when compiling pata_legacy.c with 'make W=1' about
> the 'rt' local variable in pdc20230_set_piomode() being set but unused.
> Quite obviously, there is an outb() call missing to write back the updated
> variable. Moreover, checking the docs by Petr Soucek revealed that bitwise
> AND should have been done with a negated timing mask and the master/slave
> timing masks were swapped while updating...
> 
> Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---

   Forgot to mention that the patch was done against the 'master' branch
of libata.git...

[...]

MBR, Sergey
