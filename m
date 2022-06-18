Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F225FC43334
	for <linux-ide@archiver.kernel.org>; Sat, 18 Jun 2022 20:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiFRUiV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 18 Jun 2022 16:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFRUiU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 18 Jun 2022 16:38:20 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7441911C02
        for <linux-ide@vger.kernel.org>; Sat, 18 Jun 2022 13:38:18 -0700 (PDT)
Received: from [192.168.1.103] (178.176.74.222) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 18 Jun
 2022 23:38:10 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-eh: fix sloppy result type of
 ata_internal_cmd_timeout()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <8177b862-694b-4efd-d079-ddec57a40e33@omp.ru>
Date:   Sat, 18 Jun 2022 23:38:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.74.222]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/18/2022 20:23:18
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171212 [Jun 18 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 490 490 64947c9fe6ec4170c45683de1592f92a9c3bac07
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.222 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.222 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 178.176.74.222:7.4.1,7.1.2,7.7.3;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.222
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/18/2022 20:25:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/18/2022 5:15:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata_internal_cmd_timeout() returns *unsigned long* timeout in ms, however
ata_exec_internal_sg() passes that timeout to msecs_to_jiffies() that takes
just *unsigned int*.  Change ata_internal_cmd_timeout()'s result type to
*unsigned int* as well, also updating the *struct* ata_eh_cmd_timeout_ent
and the command timeout tables -- all timeouts fit into *unsigned int* but
we have to change ULONG_MAX to UINT_MAX...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien's 'libata.git' repo.

 drivers/ata/libata-eh.c |   22 +++++++++++-----------
 drivers/ata/libata.h    |    2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

Index: libata/drivers/ata/libata-eh.c
===================================================================
--- libata.orig/drivers/ata/libata-eh.c
+++ libata/drivers/ata/libata-eh.c
@@ -86,36 +86,36 @@ static const unsigned long ata_eh_reset_
 	ULONG_MAX, /* > 1 min has elapsed, give up */
 };
 
-static const unsigned long ata_eh_identify_timeouts[] = {
+static const unsigned int ata_eh_identify_timeouts[] = {
 	 5000,	/* covers > 99% of successes and not too boring on failures */
 	10000,  /* combined time till here is enough even for media access */
 	30000,	/* for true idiots */
-	ULONG_MAX,
+	UINT_MAX,
 };
 
-static const unsigned long ata_eh_revalidate_timeouts[] = {
+static const unsigned int ata_eh_revalidate_timeouts[] = {
 	15000,	/* Some drives are slow to read log pages when waking-up */
 	15000,  /* combined time till here is enough even for media access */
-	ULONG_MAX,
+	UINT_MAX,
 };
 
-static const unsigned long ata_eh_flush_timeouts[] = {
+static const unsigned int ata_eh_flush_timeouts[] = {
 	15000,	/* be generous with flush */
 	15000,  /* ditto */
 	30000,	/* and even more generous */
-	ULONG_MAX,
+	UINT_MAX,
 };
 
-static const unsigned long ata_eh_other_timeouts[] = {
+static const unsigned int ata_eh_other_timeouts[] = {
 	 5000,	/* same rationale as identify timeout */
 	10000,	/* ditto */
 	/* but no merciful 30sec for other commands, it just isn't worth it */
-	ULONG_MAX,
+	UINT_MAX,
 };
 
 struct ata_eh_cmd_timeout_ent {
 	const u8		*commands;
-	const unsigned long	*timeouts;
+	const unsigned int	*timeouts;
 };
 
 /* The following table determines timeouts to use for EH internal
@@ -326,7 +326,7 @@ static int ata_lookup_timeout_table(u8 c
  *	RETURNS:
  *	Determined timeout.
  */
-unsigned long ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd)
+unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd)
 {
 	struct ata_eh_context *ehc = &dev->link->eh_context;
 	int ent = ata_lookup_timeout_table(cmd);
@@ -361,7 +361,7 @@ void ata_internal_cmd_timed_out(struct a
 		return;
 
 	idx = ehc->cmd_timeout_idx[dev->devno][ent];
-	if (ata_eh_cmd_timeout_table[ent].timeouts[idx + 1] != ULONG_MAX)
+	if (ata_eh_cmd_timeout_table[ent].timeouts[idx + 1] != UINT_MAX)
 		ehc->cmd_timeout_idx[dev->devno][ent]++;
 }
 
Index: libata/drivers/ata/libata.h
===================================================================
--- libata.orig/drivers/ata/libata.h
+++ libata/drivers/ata/libata.h
@@ -132,7 +132,7 @@ int ata_scsi_dev_config(struct scsi_devi
 int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
 
 /* libata-eh.c */
-extern unsigned long ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
+extern unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
 extern void ata_internal_cmd_timed_out(struct ata_device *dev, u8 cmd);
 extern void ata_eh_acquire(struct ata_port *ap);
 extern void ata_eh_release(struct ata_port *ap);
