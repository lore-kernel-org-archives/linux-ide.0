Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFA8EB64D8
	for <linux-ide@archiver.kernel.org>; Fri, 16 Jun 2023 19:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344729AbjFPTqb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Jun 2023 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFPTqa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jun 2023 15:46:30 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B1A10D8
        for <linux-ide@vger.kernel.org>; Fri, 16 Jun 2023 12:46:29 -0700 (PDT)
Received: from localhost.localdomain (31.173.81.71) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 16 Jun
 2023 22:46:22 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
Subject: [PATCH 2/8] ata: libata-core: fix parameter types of ata_wait_register()
Date:   Fri, 16 Jun 2023 22:46:01 +0300
Message-ID: <20230616194607.7351-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20230616194607.7351-1-s.shtylyov@omp.ru>
References: <20230616194607.7351-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [31.173.81.71]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 06/16/2023 19:27:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 178086 [Jun 16 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_no_received}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.71 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;31.173.81.71:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.71
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/16/2023 19:33:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/16/2023 4:36:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata_wait_register() passes its 'unsigned long {interval|timeout}' params
verbatim to ata_{msleep|deadline}() that just take 'unsigned int' param
for the time intervals in ms -- eliminate unneeded implicit casts...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/libata-core.c | 2 +-
 include/linux/libata.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8796ef51641c..e40785246634 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6487,7 +6487,7 @@ EXPORT_SYMBOL_GPL(ata_msleep);
  *	The final register value.
  */
 u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask, u32 val,
-		      unsigned long interval, unsigned long timeout)
+		      unsigned int interval, unsigned int timeout)
 {
 	unsigned long deadline;
 	u32 tmp;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1cf727632970..059fe8386118 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1105,7 +1105,7 @@ static inline void ata_sas_port_resume(struct ata_port *ap)
 extern int ata_ratelimit(void);
 extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
 extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
-			u32 val, unsigned long interval, unsigned long timeout);
+			     u32 val, unsigned int interval, unsigned int timeout);
 extern int atapi_cmd_type(u8 opcode);
 extern unsigned int ata_pack_xfermask(unsigned int pio_mask,
 				      unsigned int mwdma_mask,
-- 
2.26.3

