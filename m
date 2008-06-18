From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH] ide: endian annotations in ide-floppy.c
Date: Wed, 18 Jun 2008 15:57:35 -0700
Message-ID: <1213829856.2125.26.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:11758 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbYFRW5h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2008 18:57:37 -0400
Received: by wa-out-1112.google.com with SMTP id j37so348713waf.23
        for <linux-ide@vger.kernel.org>; Wed, 18 Jun 2008 15:57:35 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-ide <linux-ide@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ide/ide-floppy.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index f05fbc2..cba39fa 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -921,10 +921,10 @@ static int ide_floppy_get_flexible_disk_page(ide_drive_t *drive)
 	set_disk_ro(floppy->disk, floppy->wp);
 	page = &pc.buf[8];
 
-	transfer_rate = be16_to_cpu(*(u16 *)&pc.buf[8 + 2]);
-	sector_size   = be16_to_cpu(*(u16 *)&pc.buf[8 + 6]);
-	cyls          = be16_to_cpu(*(u16 *)&pc.buf[8 + 8]);
-	rpm           = be16_to_cpu(*(u16 *)&pc.buf[8 + 28]);
+	transfer_rate = be16_to_cpup((__be16 *)&pc.buf[8 + 2]);
+	sector_size   = be16_to_cpup((__be16 *)&pc.buf[8 + 6]);
+	cyls          = be16_to_cpup((__be16 *)&pc.buf[8 + 8]);
+	rpm           = be16_to_cpup((__be16 *)&pc.buf[8 + 28]);
 	heads         = pc.buf[8 + 4];
 	sectors       = pc.buf[8 + 5];
 
@@ -999,8 +999,8 @@ static int ide_floppy_get_capacity(ide_drive_t *drive)
 	for (i = 0; i < desc_cnt; i++) {
 		unsigned int desc_start = 4 + i*8;
 
-		blocks = be32_to_cpu(*(u32 *)&pc.buf[desc_start]);
-		length = be16_to_cpu(*(u16 *)&pc.buf[desc_start + 6]);
+		blocks = be32_to_cpup((__be32 *)&pc.buf[desc_start]);
+		length = be16_to_cpup((__be16 *)&pc.buf[desc_start + 6]);
 
 		debug_log("Descriptor %d: %dkB, %d blocks, %d sector size\n",
 				i, blocks * length / 1024, blocks, length);
@@ -1121,8 +1121,8 @@ static int ide_floppy_get_format_capacities(ide_drive_t *drive, int __user *arg)
 		if (u_index >= u_array_size)
 			break;	/* User-supplied buffer too small */
 
-		blocks = be32_to_cpu(*(u32 *)&pc.buf[desc_start]);
-		length = be16_to_cpu(*(u16 *)&pc.buf[desc_start + 6]);
+		blocks = be32_to_cpup((__be32 *)&pc.buf[desc_start]);
+		length = be16_to_cpup((__be16 *)&pc.buf[desc_start + 6]);
 
 		if (put_user(blocks, argp))
 			return(-EFAULT);
-- 
1.5.6.rc3.295.gdca2e



