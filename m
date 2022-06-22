Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67B8CCA479
	for <linux-ide@archiver.kernel.org>; Wed, 22 Jun 2022 20:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbiFVU5e (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Jun 2022 16:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiFVU5c (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jun 2022 16:57:32 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B9E183B3
        for <linux-ide@vger.kernel.org>; Wed, 22 Jun 2022 13:57:30 -0700 (PDT)
Received: from [192.168.1.103] (178.176.76.60) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 22 Jun
 2022 23:57:20 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-scsi: fix result type of ata_ioc32()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <05a7fcf4-3a2b-3012-34c6-ca1f00fa457c@omp.ru>
Date:   Wed, 22 Jun 2022 23:57:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.76.60]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/22/2022 20:12:00
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171302 [Jun 22 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 491 491 a718ef6dc942138335b0bcd7ab07f27b5c06005e
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.76.60 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;178.176.76.60:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.76.60
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/22/2022 20:14:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/22/2022 4:50:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

While ata_ioc32() returns 'int', its result gets assigned to and compared
with the 'unsigned long' variable 'val' in ata_sas_scsi_ioctl(), its only
caller, which implies a problematic implicit cast -- fix that by returning
'bool' instead (actually, the object code doesn't seem to change, probably
because the function is always inlined).

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien's 'libata.git' repo.

Changes in version 2:
- changed the result type of ata_ioc32() to 'bool', updating the 'return'
  statements as well;
- dropped "sloppy" from the patch subject;
- added a note about the object code to the patch description;
- changed * to ' in the patch description.

 drivers/ata/libata-scsi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: libata/drivers/ata/libata-scsi.c
===================================================================
--- libata.orig/drivers/ata/libata-scsi.c
+++ libata/drivers/ata/libata-scsi.c
@@ -539,13 +539,13 @@ int ata_task_ioctl(struct scsi_device *s
 	return rc;
 }
 
-static int ata_ioc32(struct ata_port *ap)
+static bool ata_ioc32(struct ata_port *ap)
 {
 	if (ap->flags & ATA_FLAG_PIO_DMA)
-		return 1;
+		return true;
 	if (ap->pflags & ATA_PFLAG_PIO32)
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 /*
