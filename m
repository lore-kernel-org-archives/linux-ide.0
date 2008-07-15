From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 2/2] ide: trivial sparse annotations
Date: Tue, 15 Jul 2008 13:14:05 -0700
Message-ID: <1216152845.6610.20.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.181]:18790 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbYGOUOK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jul 2008 16:14:10 -0400
Received: by el-out-1112.google.com with SMTP id z25so968337ele.1
        for <linux-ide@vger.kernel.org>; Tue, 15 Jul 2008 13:14:08 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ide/ide-dma.c  |    2 +-
 drivers/ide/ide-iops.c |    6 ++----
 drivers/ide/ide-proc.c |    4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index be99d46..71c377a 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -173,7 +173,7 @@ EXPORT_SYMBOL_GPL(ide_build_sglist);
 int ide_build_dmatable (ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	unsigned int *table	= hwif->dmatable_cpu;
+	__le32 *table = (__le32 *)hwif->dmatable_cpu;
 	unsigned int is_trm290	= (hwif->chipset == ide_trm290) ? 1 : 0;
 	unsigned int count = 0;
 	int i;
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index 3ae278d..345cd2c 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -510,10 +510,8 @@ void ide_fixstring (u8 *s, const int bytecount, const int byteswap)
 
 	if (byteswap) {
 		/* convert from big-endian to host byte order */
-		for (p = end ; p != s;) {
-			unsigned short *pp = (unsigned short *) (p -= 2);
-			*pp = ntohs(*pp);
-		}
+		for (p = end ; p != s;)
+			be16_to_cpus((u16 *)(p -= 2));
 	}
 	/* strip leading blanks */
 	while (s != end && *s == ' ')
diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 151c91e..f66c9c3 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -105,7 +105,7 @@ static int proc_ide_read_identify
 	len = sprintf(page, "\n");
 
 	if (drive) {
-		unsigned short *val = (unsigned short *) page;
+		__le16 *val = (__le16 *)page;
 
 		err = taskfile_lib_get_identify(drive, page);
 		if (!err) {
@@ -113,7 +113,7 @@ static int proc_ide_read_identify
 			page = out;
 			do {
 				out += sprintf(out, "%04x%c",
-					le16_to_cpu(*val), (++i & 7) ? ' ' : '\n');
+					le16_to_cpup(val), (++i & 7) ? ' ' : '\n');
 				val += 1;
 			} while (i < (SECTOR_WORDS * 2));
 			len = out - page;
-- 
1.5.6.3.499.geae9

