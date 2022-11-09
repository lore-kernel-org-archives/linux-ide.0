Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F41C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  9 Nov 2022 21:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiKIVr5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKIVr5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Nov 2022 16:47:57 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBC22FFC2
        for <linux-ide@vger.kernel.org>; Wed,  9 Nov 2022 13:47:54 -0800 (PST)
Received: from [192.168.1.103] (31.173.83.14) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 10 Nov
 2022 00:47:42 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-sff: kill unused ata_sff_busy_sleep()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <aaf9372f-a166-8ad1-53a1-a6d38aed031f@omp.ru>
Date:   Thu, 10 Nov 2022 00:47:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.83.14]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 11/09/2022 21:27:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 173481 [Nov 09 2022]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.83.14 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.83.14
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/09/2022 21:29:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/9/2022 3:13:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Nobody seems to call ata_sff_busy_sleep(), so we can get rid of it...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien's 'libata.git' repo.

 drivers/ata/libata-sff.c |   56 -----------------------------------------------
 include/linux/libata.h   |    2 -
 2 files changed, 58 deletions(-)

Index: libata/drivers/ata/libata-sff.c
===================================================================
--- libata.orig/drivers/ata/libata-sff.c
+++ libata/drivers/ata/libata-sff.c
@@ -184,62 +184,6 @@ void ata_sff_dma_pause(struct ata_port *
 }
 EXPORT_SYMBOL_GPL(ata_sff_dma_pause);
 
-/**
- *	ata_sff_busy_sleep - sleep until BSY clears, or timeout
- *	@ap: port containing status register to be polled
- *	@tmout_pat: impatience timeout in msecs
- *	@tmout: overall timeout in msecs
- *
- *	Sleep until ATA Status register bit BSY clears,
- *	or a timeout occurs.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int ata_sff_busy_sleep(struct ata_port *ap,
-		       unsigned long tmout_pat, unsigned long tmout)
-{
-	unsigned long timer_start, timeout;
-	u8 status;
-
-	status = ata_sff_busy_wait(ap, ATA_BUSY, 300);
-	timer_start = jiffies;
-	timeout = ata_deadline(timer_start, tmout_pat);
-	while (status != 0xff && (status & ATA_BUSY) &&
-	       time_before(jiffies, timeout)) {
-		ata_msleep(ap, 50);
-		status = ata_sff_busy_wait(ap, ATA_BUSY, 3);
-	}
-
-	if (status != 0xff && (status & ATA_BUSY))
-		ata_port_warn(ap,
-			      "port is slow to respond, please be patient (Status 0x%x)\n",
-			      status);
-
-	timeout = ata_deadline(timer_start, tmout);
-	while (status != 0xff && (status & ATA_BUSY) &&
-	       time_before(jiffies, timeout)) {
-		ata_msleep(ap, 50);
-		status = ap->ops->sff_check_status(ap);
-	}
-
-	if (status == 0xff)
-		return -ENODEV;
-
-	if (status & ATA_BUSY) {
-		ata_port_err(ap,
-			     "port failed to respond (%lu secs, Status 0x%x)\n",
-			     DIV_ROUND_UP(tmout, 1000), status);
-		return -EBUSY;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ata_sff_busy_sleep);
-
 static int ata_sff_check_ready(struct ata_link *link)
 {
 	u8 status = link->ap->ops->sff_check_status(link->ap);
Index: libata/include/linux/libata.h
===================================================================
--- libata.orig/include/linux/libata.h
+++ libata/include/linux/libata.h
@@ -1918,8 +1918,6 @@ extern void ata_sff_dev_select(struct at
 extern u8 ata_sff_check_status(struct ata_port *ap);
 extern void ata_sff_pause(struct ata_port *ap);
 extern void ata_sff_dma_pause(struct ata_port *ap);
-extern int ata_sff_busy_sleep(struct ata_port *ap,
-			      unsigned long timeout_pat, unsigned long timeout);
 extern int ata_sff_wait_ready(struct ata_link *link, unsigned long deadline);
 extern void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
 extern void ata_sff_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
