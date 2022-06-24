Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43E2C43334
	for <linux-ide@archiver.kernel.org>; Fri, 24 Jun 2022 20:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiFXUj5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 24 Jun 2022 16:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXUj4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 24 Jun 2022 16:39:56 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653C363630
        for <linux-ide@vger.kernel.org>; Fri, 24 Jun 2022 13:39:52 -0700 (PDT)
Received: from [192.168.1.103] (31.173.87.92) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 24 Jun
 2022 23:39:44 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3] ata: libata-scsi: fix result type of ata_ioc32()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <1e088333-7c7e-8e7b-7b85-12edd4355b92@omp.ru>
Date:   Fri, 24 Jun 2022 23:39:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.87.92]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/24/2022 20:16:00
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171356 [Jun 24 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 491 491 a718ef6dc942138335b0bcd7ab07f27b5c06005e
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.92 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 31.173.87.92:7.7.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.87.92
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/24/2022 20:19:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/24/2022 6:30:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

While ata_ioc32() returns 'int', its result gets assigned to and compared
with the 'unsigned long' variable 'val' in ata_sas_scsi_ioctl(), its only
caller, which implies a problematic implicit cast (with sign extension).
Fix this by returning 'bool' instead -- the implicit cast then implies
zero extension which is OK.  Note that actually the object code doesn't
change because ata_ioc32() is always inlined -- I can see the expected
code changes with 'noinline')...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien's 'libata.git' repo.

Changes in version 3:
- refined the patch description.

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
