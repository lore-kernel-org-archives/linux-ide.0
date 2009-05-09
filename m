From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 12/14] ide-atapi: remove pc->buf
Date: Sat,  9 May 2009 09:45:32 +0200
Message-ID: <1241855134-4984-13-git-send-email-petkovbb@gmail.com>
References: <1241855134-4984-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37916 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbZEIHpj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 May 2009 03:45:39 -0400
In-Reply-To: <1241855134-4984-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Now after all users of pc->buf have been converted, remove the 64B buffer
embedded in each packet command.

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c  |    2 --
 drivers/ide/ide-floppy.c |    2 --
 drivers/ide/ide-tape.c   |    4 ----
 include/linux/ide.h      |   11 -----------
 4 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index df3e3bb..96aded6 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -74,8 +74,6 @@ EXPORT_SYMBOL_GPL(ide_check_atapi_device);
 void ide_init_pc(struct ide_atapi_pc *pc)
 {
 	memset(pc, 0, sizeof(*pc));
-	pc->buf = pc->pc_buf;
-	pc->buf_size = IDE_PC_BUFFER_SIZE;
 }
 EXPORT_SYMBOL_GPL(ide_init_pc);
 
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index cb6c6f8..23f40a6 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -387,8 +387,6 @@ static int ide_floppy_get_capacity(ide_drive_t *drive)
 	drive->capacity64 = 0;
 
 	ide_floppy_create_read_capacity_cmd(&pc);
-	pc.buf_size = sizeof(pc_buf);
-
 	if (ide_queue_pc_tail(drive, disk, &pc, pc_buf, pc.req_xfer)) {
 		printk(KERN_ERR PFX "Can't get floppy parameters\n");
 		return 1;
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 7f70926..ea22c0c 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -567,8 +567,6 @@ static void ide_tape_create_rw_cmd(idetape_tape_t *tape,
 	ide_init_pc(pc);
 	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
 	pc->c[1] = 1;
-	pc->buf = NULL;
-	pc->buf_size = blk_rq_bytes(rq);
 	if (pc->req_xfer == tape->buffer_size)
 		pc->flags |= PC_FLAG_DMA_OK;
 
@@ -1607,8 +1605,6 @@ static void idetape_get_inquiry_results(ide_drive_t *drive)
 	char fw_rev[4], vendor_id[8], product_id[16];
 
 	idetape_create_inquiry_cmd(&pc);
-	pc.buf_size = sizeof(pc_buf);
-
 	if (ide_queue_pc_tail(drive, tape->disk, &pc, pc_buf, pc.req_xfer)) {
 		printk(KERN_ERR "ide-tape: %s: can't get INQUIRY results\n",
 				tape->name);
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 4cd7157..59aedcd 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -341,11 +341,6 @@ enum {
 	PC_FLAG_WRITING			= (1 << 6),
 };
 
-/*
- * With each packet command, we allocate a buffer of IDE_PC_BUFFER_SIZE bytes.
- * This is used for several packet commands (not for READ/WRITE commands).
- */
-#define IDE_PC_BUFFER_SIZE	64
 #define ATAPI_WAIT_PC		(60 * HZ)
 
 struct ide_atapi_pc {
@@ -358,10 +353,6 @@ struct ide_atapi_pc {
 	/* bytes to transfer */
 	int req_xfer;
 
-	/* data buffer */
-	u8 *buf;
-	int buf_size;
-
 	/* the corresponding request */
 	struct request *rq;
 
@@ -371,8 +362,6 @@ struct ide_atapi_pc {
 	 * those are more or less driver-specific and some of them are subject
 	 * to change/removal later.
 	 */
-	u8 pc_buf[IDE_PC_BUFFER_SIZE];
-
 	unsigned long timeout;
 };
 
-- 
1.6.2.4

