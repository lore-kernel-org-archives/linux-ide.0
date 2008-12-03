From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH-mm 2/2] ata: replace byteshifting with unaligned endian
 helpers
Date: Wed, 03 Dec 2008 10:13:40 -0800
Message-ID: <1228328020.5412.24.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:20589 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbYLCSNo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Dec 2008 13:13:44 -0500
Received: by qw-out-2122.google.com with SMTP id 3so854250qwe.37
        for <linux-ide@vger.kernel.org>; Wed, 03 Dec 2008 10:13:42 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
Depends on the unaligned access work in -mm.

 drivers/ata/libata-scsi.c |   50 ++++++--------------------------------------
 1 files changed, 7 insertions(+), 43 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d763b2b..1c16b63 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -46,6 +46,7 @@
 #include <linux/libata.h>
 #include <linux/hdreg.h>
 #include <linux/uaccess.h>
+#include <asm/unaligned.h>
 
 #include "libata.h"
 
@@ -1384,19 +1385,10 @@ static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc)
  */
 static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
-	u64 lba = 0;
-	u32 len;
-
 	VPRINTK("six-byte command\n");
 
-	lba |= ((u64)(cdb[1] & 0x1f)) << 16;
-	lba |= ((u64)cdb[2]) << 8;
-	lba |= ((u64)cdb[3]);
-
-	len = cdb[4];
-
-	*plba = lba;
-	*plen = len;
+	*plba = load_be32_noalign((__be32 *)&cdb[0]) & 0x1fffff;
+	*plen = cdb[4];
 }
 
 /**
@@ -1411,21 +1403,10 @@ static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
  */
 static void scsi_10_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
-	u64 lba = 0;
-	u32 len = 0;
-
 	VPRINTK("ten-byte command\n");
 
-	lba |= ((u64)cdb[2]) << 24;
-	lba |= ((u64)cdb[3]) << 16;
-	lba |= ((u64)cdb[4]) << 8;
-	lba |= ((u64)cdb[5]);
-
-	len |= ((u32)cdb[7]) << 8;
-	len |= ((u32)cdb[8]);
-
-	*plba = lba;
-	*plen = len;
+	*plba = load_be32_noalign((__be32 *)&cdb[2]);
+	*plen = load_be16_noalign((__be16 *)&cdb[7]);
 }
 
 /**
@@ -1440,27 +1421,10 @@ static void scsi_10_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
  */
 static void scsi_16_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
-	u64 lba = 0;
-	u32 len = 0;
-
 	VPRINTK("sixteen-byte command\n");
 
-	lba |= ((u64)cdb[2]) << 56;
-	lba |= ((u64)cdb[3]) << 48;
-	lba |= ((u64)cdb[4]) << 40;
-	lba |= ((u64)cdb[5]) << 32;
-	lba |= ((u64)cdb[6]) << 24;
-	lba |= ((u64)cdb[7]) << 16;
-	lba |= ((u64)cdb[8]) << 8;
-	lba |= ((u64)cdb[9]);
-
-	len |= ((u32)cdb[10]) << 24;
-	len |= ((u32)cdb[11]) << 16;
-	len |= ((u32)cdb[12]) << 8;
-	len |= ((u32)cdb[13]);
-
-	*plba = lba;
-	*plen = len;
+	*plba = load_be64_noalign((__be64 *)&cdb[2]);
+	*plen = load_be32_noalign((__be32 *)&cdb[10]);
 }
 
 /**
-- 
1.6.1.rc1.262.gb6810

