Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98CDC64ED8
	for <linux-ide@archiver.kernel.org>; Fri, 24 Feb 2023 20:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBXUjX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 24 Feb 2023 15:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBXUjU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2023 15:39:20 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD2410A8D
        for <linux-ide@vger.kernel.org>; Fri, 24 Feb 2023 12:39:19 -0800 (PST)
Received: from localhost.localdomain (178.176.72.18) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 24 Feb
 2023 23:39:14 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 1/2] ata: drop unused ata_id_to_hd_driveid()
Date:   Fri, 24 Feb 2023 23:39:02 +0300
Message-ID: <20230224203903.9860-2-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20230224203903.9860-1-s.shtylyov@omp.ru>
References: <20230224203903.9860-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [178.176.72.18]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 02/24/2023 20:16:41
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
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;178.176.72.18:7.1.2
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.18
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/24/2023 20:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/24/2023 4:21:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This function was renamed from ide_id_to_hd_driveid() and moved from
drivers/ide/ to <linux/ata.h> but it never got used by libata, thus it
became useless after drivers/ide/ removal...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 include/linux/ata.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 0c18499f60b6..3240116647d5 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -16,7 +16,6 @@
 #include <linux/bits.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <asm/byteorder.h>
 
 /* defines only for the constants which don't work well as enums */
 #define ATA_DMA_BOUNDARY	0xffffUL
@@ -1067,26 +1066,6 @@ static inline bool ata_id_is_lba_capacity_ok(u16 *id)
 	return false;	/* LBA capacity value may be bad */
 }
 
-static inline void ata_id_to_hd_driveid(u16 *id)
-{
-#ifdef __BIG_ENDIAN
-	/* accessed in struct hd_driveid as 8-bit values */
-	id[ATA_ID_MAX_MULTSECT]	 = __cpu_to_le16(id[ATA_ID_MAX_MULTSECT]);
-	id[ATA_ID_CAPABILITY]	 = __cpu_to_le16(id[ATA_ID_CAPABILITY]);
-	id[ATA_ID_OLD_PIO_MODES] = __cpu_to_le16(id[ATA_ID_OLD_PIO_MODES]);
-	id[ATA_ID_OLD_DMA_MODES] = __cpu_to_le16(id[ATA_ID_OLD_DMA_MODES]);
-	id[ATA_ID_MULTSECT]	 = __cpu_to_le16(id[ATA_ID_MULTSECT]);
-
-	/* as 32-bit values */
-	*(u32 *)&id[ATA_ID_LBA_CAPACITY] = ata_id_u32(id, ATA_ID_LBA_CAPACITY);
-	*(u32 *)&id[ATA_ID_SPG]		 = ata_id_u32(id, ATA_ID_SPG);
-
-	/* as 64-bit value */
-	*(u64 *)&id[ATA_ID_LBA_CAPACITY_2] =
-		ata_id_u64(id, ATA_ID_LBA_CAPACITY_2);
-#endif
-}
-
 static inline bool ata_ok(u8 status)
 {
 	return ((status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ | ATA_ERR))
-- 
2.26.3

