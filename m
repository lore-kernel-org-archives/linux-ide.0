Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38580C64ED8
	for <linux-ide@archiver.kernel.org>; Fri, 24 Feb 2023 20:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjBXUkt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 24 Feb 2023 15:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBXUks (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2023 15:40:48 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393484D634
        for <linux-ide@vger.kernel.org>; Fri, 24 Feb 2023 12:40:47 -0800 (PST)
Received: from localhost.localdomain (178.176.72.18) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 24 Feb
 2023 23:40:39 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 2/2] ata: drop unused ata_id_is_lba_capacity_ok()
Date:   Fri, 24 Feb 2023 23:40:24 +0300
Message-ID: <20230224204024.9982-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20230224204024.9982-1-s.shtylyov@omp.ru>
References: <20230224204024.9982-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [178.176.72.18]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 02/24/2023 20:22:43
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 175702 [Feb 23 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 504 504 dc137e1f9c062eb6c0671e7d509ab442ae395562
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.72.18 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.72.18 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;178.176.72.18:7.4.1,7.1.2,7.7.3;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.18
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/24/2023 20:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/24/2023 4:21:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This function was renamed from lba_capacity_is_ok()() and moved from
drivers/ide/ to <linux/ata.h> but it never got used by libata, thus it
became useless after drivers/ide/ removal...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 include/linux/ata.h | 50 ---------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 3240116647d5..c224dbddb9b2 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -1016,56 +1016,6 @@ static inline bool atapi_id_dmadir(const u16 *dev_id)
 	return ata_id_major_version(dev_id) >= 7 && (dev_id[62] & 0x8000);
 }
 
-/*
- * ata_id_is_lba_capacity_ok() performs a sanity check on
- * the claimed LBA capacity value for the device.
- *
- * Returns 1 if LBA capacity looks sensible, 0 otherwise.
- *
- * It is called only once for each device.
- */
-static inline bool ata_id_is_lba_capacity_ok(u16 *id)
-{
-	unsigned long lba_sects, chs_sects, head, tail;
-
-	/* No non-LBA info .. so valid! */
-	if (id[ATA_ID_CYLS] == 0)
-		return true;
-
-	lba_sects = ata_id_u32(id, ATA_ID_LBA_CAPACITY);
-
-	/*
-	 * The ATA spec tells large drives to return
-	 * C/H/S = 16383/16/63 independent of their size.
-	 * Some drives can be jumpered to use 15 heads instead of 16.
-	 * Some drives can be jumpered to use 4092 cyls instead of 16383.
-	 */
-	if ((id[ATA_ID_CYLS] == 16383 ||
-	     (id[ATA_ID_CYLS] == 4092 && id[ATA_ID_CUR_CYLS] == 16383)) &&
-	    id[ATA_ID_SECTORS] == 63 &&
-	    (id[ATA_ID_HEADS] == 15 || id[ATA_ID_HEADS] == 16) &&
-	    (lba_sects >= 16383 * 63 * id[ATA_ID_HEADS]))
-		return true;
-
-	chs_sects = id[ATA_ID_CYLS] * id[ATA_ID_HEADS] * id[ATA_ID_SECTORS];
-
-	/* perform a rough sanity check on lba_sects: within 10% is OK */
-	if (lba_sects - chs_sects < chs_sects/10)
-		return true;
-
-	/* some drives have the word order reversed */
-	head = (lba_sects >> 16) & 0xffff;
-	tail = lba_sects & 0xffff;
-	lba_sects = head | (tail << 16);
-
-	if (lba_sects - chs_sects < chs_sects/10) {
-		*(__le32 *)&id[ATA_ID_LBA_CAPACITY] = __cpu_to_le32(lba_sects);
-		return true;	/* LBA capacity is (now) good */
-	}
-
-	return false;	/* LBA capacity value may be bad */
-}
-
 static inline bool ata_ok(u8 status)
 {
 	return ((status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ | ATA_ERR))
-- 
2.26.3

