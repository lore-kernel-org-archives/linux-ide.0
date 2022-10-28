Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14425FA3740
	for <linux-ide@archiver.kernel.org>; Fri, 28 Oct 2022 21:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJ1VHe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJ1VHS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Oct 2022 17:07:18 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC75248C9E
        for <linux-ide@vger.kernel.org>; Fri, 28 Oct 2022 14:07:15 -0700 (PDT)
Received: from [192.168.1.103] (31.173.84.89) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 29 Oct
 2022 00:07:06 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: pata_legacy: fix pdc20230_set_piomode()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <llvm@lists.linux.dev>
Organization: Open Mobile Platform
Message-ID: <99d91d0e-d3fc-5492-ddca-6da6e65e1e89@omp.ru>
Date:   Sat, 29 Oct 2022 00:07:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.84.89]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/28/2022 20:37:24
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
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.84.89 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;31.173.84.89:7.7.3,7.4.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.84.89
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/28/2022 20:40:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/28/2022 6:31:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Clang gives a warning when compiling pata_legacy.c with 'make W=1' about
the 'rt' local variable in pdc20230_set_piomode() being set but unused.
Quite obviously, there is an outb() call missing to write back the updated
variable. Moreover, checking the docs by Petr Soucek revealed that bitwise
AND should have been done with a negated timing mask and the master/slave
timing masks were swapped while updating...

Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")
Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
 drivers/ata/pata_legacy.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: libata/drivers/ata/pata_legacy.c
===================================================================
--- libata.orig/drivers/ata/pata_legacy.c
+++ libata/drivers/ata/pata_legacy.c
@@ -315,9 +315,10 @@ static void pdc20230_set_piomode(struct
 	outb(inb(0x1F4) & 0x07, 0x1F4);
 
 	rt = inb(0x1F3);
-	rt &= 0x07 << (3 * adev->devno);
+	rt &= ~(0x07 << (3 * !adev->devno));
 	if (pio)
-		rt |= (1 + 3 * pio) << (3 * adev->devno);
+		rt |= (1 + 3 * pio) << (3 * !adev->devno);
+	outb(rt, 0x1F3);
 
 	udelay(100);
 	outb(inb(0x1F2) | 0x01, 0x1F2);
