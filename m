From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 3/6] ide-tape: mv idetape_empty_write_pipeline ide_tape_flush_merge_buffer
Date: Mon,  7 Apr 2008 06:45:01 +0200
Message-ID: <1207543504-27888-4-git-send-email-petkovbb@gmail.com>
References: <1207543504-27888-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:37338 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbYDGEot (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 00:44:49 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1273833fgb.17
        for <linux-ide@vger.kernel.org>; Sun, 06 Apr 2008 21:44:46 -0700 (PDT)
In-Reply-To: <1207543504-27888-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index ecc11c1..d5ca673 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1779,7 +1779,7 @@ static int idetape_add_chrdev_write_request(ide_drive_t *drive, int blocks)
 				     blocks, tape->merge_stage->bh);
 }
 
-static void idetape_empty_write_pipeline(ide_drive_t *drive)
+static void ide_tape_flush_merge_buffer(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	int blocks, min;
@@ -1841,7 +1841,7 @@ static int idetape_init_read(ide_drive_t *drive)
 	/* Initialize read operation */
 	if (tape->chrdev_dir != IDETAPE_DIR_READ) {
 		if (tape->chrdev_dir == IDETAPE_DIR_WRITE) {
-			idetape_empty_write_pipeline(drive);
+			ide_tape_flush_merge_buffer(drive);
 			idetape_flush_tape_buffers(drive);
 		}
 		if (tape->merge_stage || tape->merge_stage_size) {
@@ -2357,7 +2357,7 @@ static int idetape_chrdev_ioctl(struct inode *inode, struct file *file,
 	debug_log(DBG_CHRDEV, "Enter %s, cmd=%u\n", __func__, cmd);
 
 	if (tape->chrdev_dir == IDETAPE_DIR_WRITE) {
-		idetape_empty_write_pipeline(drive);
+		ide_tape_flush_merge_buffer(drive);
 		idetape_flush_tape_buffers(drive);
 	}
 	if (cmd == MTIOCGET || cmd == MTIOCPOS) {
@@ -2506,7 +2506,7 @@ static void idetape_write_release(ide_drive_t *drive, unsigned int minor)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
-	idetape_empty_write_pipeline(drive);
+	ide_tape_flush_merge_buffer(drive);
 	tape->merge_stage = ide_tape_kmalloc_buffer(tape, 1, 0);
 	if (tape->merge_stage != NULL) {
 		idetape_pad_zeros(drive, tape->blk_size *
-- 
1.5.4.1

