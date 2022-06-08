Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE7EC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Jun 2022 20:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiFHUhT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiFHUhT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 16:37:19 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA26986F9
        for <linux-ide@vger.kernel.org>; Wed,  8 Jun 2022 13:37:17 -0700 (PDT)
Received: from [192.168.1.103] (31.173.87.89) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 8 Jun 2022
 23:37:09 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] MAINTAINERS: add ATA sysfs file documentation to libata entry
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <fb6ea0d3-c962-26d2-16e6-a7782d39a0de@omp.ru>
Date:   Wed, 8 Jun 2022 23:37:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.87.89]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/08/2022 20:19:28
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171014 [Jun 08 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 485 485 30d410687e032eeb95d5c3c4fb66dc8aafb87b20
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.89 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.89 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;31.173.87.89:7.7.3,7.4.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.87.89
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/08/2022 20:24:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/8/2022 5:59:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add the (still missing!) ATA sysfs file documentation to the libata
subsystem entry in the MAINTAINERS file.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'master' branch of Damien's 'libata.git' repo.

 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

Index: libata/MAINTAINERS
===================================================================
--- libata.orig/MAINTAINERS
+++ libata/MAINTAINERS
@@ -11257,6 +11257,7 @@ M:	Damien Le Moal <damien.lemoal@opensou
 L:	linux-ide@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
+F:	Documentation/ABI/testing/sysfs-ata
 F:	Documentation/devicetree/bindings/ata/
 F:	drivers/ata/
 F:	include/linux/ata.h
