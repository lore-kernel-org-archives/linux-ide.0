From: tom.ty89@gmail.com
Subject: [PATCH] ata: make lba_{28,48}_ok() use ATA_MAX_SECTORS{,_LBA48}
Date: Fri, 15 Jul 2016 05:09:02 +0800
Message-ID: <e2abe167a66a18daa44e0fb7bf39f5a8da0f5bf0.1468530378.git.tom.ty89@gmail.com>
References: <91a6bb6f4c04eb617a49d9a51f261b661c179de0.1468384890.git.tom.ty89@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33970 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbcGNVJK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jul 2016 17:09:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id g202so5345831pfb.1
        for <linux-ide@vger.kernel.org>; Thu, 14 Jul 2016 14:09:10 -0700 (PDT)
In-Reply-To: <91a6bb6f4c04eb617a49d9a51f261b661c179de0.1468384890.git.tom.ty89@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>

From: Tom Yan <tom.ty89@gmail.com>

Since we set ATA_MAX_SECTORS_LBA48 to 65535 to avoid the corner case
in some drives that commands with "count" set to 0000h (which
reprsents 65536) does not work as expected, lba_48_ok(), which is
used for number-of-blocks checking when libata pack commands, should
use the same limit as well. In fact, there is no reason for the two
functions not to use the macros anyway.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 99346be..f87287a 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -46,7 +46,7 @@ enum {
 	ATA_MAX_SECTORS_128	= 128,
 	ATA_MAX_SECTORS		= 256,
 	ATA_MAX_SECTORS_1024    = 1024,
-	ATA_MAX_SECTORS_LBA48	= 65535,/* TODO: 65536? */
+	ATA_MAX_SECTORS_LBA48	= 65535,/* avoid count to be 0000h */
 	ATA_MAX_SECTORS_TAPE	= 65535,
 
 	ATA_ID_WORDS		= 256,
@@ -1095,13 +1095,13 @@ static inline bool ata_ok(u8 status)
 static inline bool lba_28_ok(u64 block, u32 n_block)
 {
 	/* check the ending block number: must be LESS THAN 0x0fffffff */
-	return ((block + n_block) < ((1 << 28) - 1)) && (n_block <= 256);
+	return ((block + n_block) < ((1 << 28) - 1)) && (n_block <= ATA_MAX_SECTORS);
 }
 
 static inline bool lba_48_ok(u64 block, u32 n_block)
 {
 	/* check the ending block number */
-	return ((block + n_block - 1) < ((u64)1 << 48)) && (n_block <= 65536);
+	return ((block + n_block - 1) < ((u64)1 << 48)) && (n_block <= ATA_MAX_SECTORS_LBA48);
 }
 
 #define sata_pmp_gscr_vendor(gscr)	((gscr)[SATA_PMP_GSCR_PROD_ID] & 0xffff)
-- 
2.9.0

