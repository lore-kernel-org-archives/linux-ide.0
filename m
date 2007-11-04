From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/18] ide-disk: use ide_get_lba_addr()
Date: Mon, 5 Nov 2007 00:22:57 +0100
Message-ID: <200711050022.57478.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:52113 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbXKDX3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:40 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219894nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


* Export ide_get_lba_addr().

* Convert idedisk_{read_native,set}_max_address() to use ide_get_lba_addr().

* Remove incorrect comment from idedisk_read_native_max_address()
  (noticed by Sergei).

There should be no functionality changes caused by this patch.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   26 ++++----------------------
 drivers/ide/ide-lib.c  |    3 ++-
 include/linux/ide.h    |    1 +
 3 files changed, 7 insertions(+), 23 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -352,18 +352,9 @@ static u64 idedisk_read_native_max_addre
 	ide_no_data_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
-	if ((tf->status & 0x01) == 0) {
-		u32 high, low;
+	if ((tf->status & 0x01) == 0)
+		addr = ide_get_lba_addr(tf, lba48) + 1;
 
-		if (lba48)
-			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
-				tf->hob_lbal;
-		else
-			high = tf->device & 0xf;
-		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
-		addr = ((__u64)high << 24) | low;
-		addr++;	/* since the return value is (maxlba - 1), we add 1 */
-	}
 	return addr;
 }
 
@@ -399,18 +390,9 @@ static u64 idedisk_set_max_address(ide_d
 	/* submit command request */
 	ide_no_data_taskfile(drive, &args);
 	/* if OK, compute maximum address value */
-	if ((tf->status & 0x01) == 0) {
-		u32 high, low;
+	if ((tf->status & 0x01) == 0)
+		addr_set = ide_get_lba_addr(tf, lba48) + 1;
 
-		if (lba48)
-			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
-				tf->hob_lbal;
-		else
-			high = tf->device & 0xf;
-		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
-		addr_set = ((__u64)high << 24) | low;
-		addr_set++;
-	}
 	return addr_set;
 }
 
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -476,7 +476,7 @@ static void ide_dump_opcode(ide_drive_t 
 		printk("0x%02x\n", opcode);
 }
 
-static u64 ide_get_lba_addr(struct ide_taskfile *tf, int lba48)
+u64 ide_get_lba_addr(struct ide_taskfile *tf, int lba48)
 {
 	u32 high, low;
 
@@ -489,6 +489,7 @@ static u64 ide_get_lba_addr(struct ide_t
 
 	return ((u64)high << 24) | low;
 }
+EXPORT_SYMBOL_GPL(ide_get_lba_addr);
 
 static void ide_dump_sector(ide_drive_t *drive)
 {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1238,6 +1238,7 @@ static inline int ide_dev_is_sata(struct
 	return 0;
 }
 
+u64 ide_get_lba_addr(struct ide_taskfile *, int);
 u8 ide_dump_status(ide_drive_t *, const char *, u8);
 
 typedef struct ide_pio_timings_s {
