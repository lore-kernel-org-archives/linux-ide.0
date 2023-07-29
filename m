Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACDDC0015E
	for <linux-ide@archiver.kernel.org>; Sat, 29 Jul 2023 20:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjG2USS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 29 Jul 2023 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjG2USQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jul 2023 16:18:16 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC611C
        for <linux-ide@vger.kernel.org>; Sat, 29 Jul 2023 13:18:15 -0700 (PDT)
Received: from localhost.localdomain (178.176.75.102) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 29 Jul
 2023 23:18:03 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
Subject: [PATCH v2 6/8] ata: libahci: fix parameter type of ahci_exec_polled_cmd()
Date:   Sat, 29 Jul 2023 23:17:51 +0300
Message-ID: <20230729201753.37600-7-s.shtylyov@omp.ru>
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
X-KSE-AntiSpam-Info: omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;178.176.75.102:7.1.2
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

ahci_exec_polled_cmd() passes its 'unsigned long timeout_msec' parameter
to ata_wait_register() that now takes 'unsigned int' -- eliminate unneeded
implicit casts, not forgetting about ahci_do_softreset()...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/libahci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ad2bfcbff3bc..e2bacedf28ef 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1403,7 +1403,7 @@ EXPORT_SYMBOL_GPL(ahci_kick_engine);
 
 static int ahci_exec_polled_cmd(struct ata_port *ap, int pmp,
 				struct ata_taskfile *tf, int is_cmd, u16 flags,
-				unsigned long timeout_msec)
+				unsigned int timeout_msec)
 {
 	const u32 cmd_fis_len = 5; /* five dwords */
 	struct ahci_port_priv *pp = ap->private_data;
@@ -1448,7 +1448,8 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	struct ahci_port_priv *pp = ap->private_data;
 	const char *reason = NULL;
-	unsigned long now, msecs;
+	unsigned long now;
+	unsigned int msecs;
 	struct ata_taskfile tf;
 	bool fbs_disabled = false;
 	int rc;
-- 
2.26.3

