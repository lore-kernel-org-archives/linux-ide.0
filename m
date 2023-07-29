Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AB7C00528
	for <linux-ide@archiver.kernel.org>; Sat, 29 Jul 2023 20:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjG2USP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 29 Jul 2023 16:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2USM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jul 2023 16:18:12 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6E81FC4
        for <linux-ide@vger.kernel.org>; Sat, 29 Jul 2023 13:18:10 -0700 (PDT)
Received: from localhost.localdomain (178.176.75.102) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 29 Jul
 2023 23:18:02 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
Subject: [PATCH v2 3/8] ata: libata-eh: fix reset timeout type
Date:   Sat, 29 Jul 2023 23:17:48 +0300
Message-ID: <20230729201753.37600-4-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20230729201753.37600-1-s.shtylyov@omp.ru>
References: <20230729201753.37600-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [178.176.75.102]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 07/29/2023 19:54:20
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 178952 [Jul 29 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.75.102 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 178.176.75.102:7.1.2;127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.102
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/29/2023 19:59:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/29/2023 4:55:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata_eh_reset_timeouts[] stores 'unsigned long' timeouts in ms, while
ata_eh_reset() passes these values to ata_deadline() that takes just
'unsigned int timeout_msecs' parameter.  Change the reset timeout table
element's type to 'unsigned int' -- all timeouts fit into 'unsigned int'
but we have to change ULONG_MAX to UINT_MAX...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
Changes in version 2:
- refreshed the patch.

 drivers/ata/libata-eh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 35e03679b0bf..0e2acca36c10 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -78,12 +78,12 @@ enum {
  * are mostly for error handling, hotplug and those outlier devices that
  * take an exceptionally long time to recover from reset.
  */
-static const unsigned long ata_eh_reset_timeouts[] = {
+static const unsigned int ata_eh_reset_timeouts[] = {
 	10000,	/* most drives spin up by 10sec */
 	10000,	/* > 99% working drives spin up before 20sec */
 	35000,	/* give > 30 secs of idleness for outlier devices */
 	 5000,	/* and sweet one last chance */
-	ULONG_MAX, /* > 1 min has elapsed, give up */
+	UINT_MAX, /* > 1 min has elapsed, give up */
 };
 
 static const unsigned int ata_eh_identify_timeouts[] = {
@@ -2575,7 +2575,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/*
 	 * Prepare to reset
 	 */
-	while (ata_eh_reset_timeouts[max_tries] != ULONG_MAX)
+	while (ata_eh_reset_timeouts[max_tries] != UINT_MAX)
 		max_tries++;
 	if (link->flags & ATA_LFLAG_RST_ONCE)
 		max_tries = 1;
-- 
2.26.3

