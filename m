From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/10] ide-tape: unify r/w init paths
Date: Sun, 19 Apr 2009 08:58:38 +0900
Message-ID: <1240099122-18381-7-git-send-email-tj@kernel.org>
References: <1240099122-18381-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57772 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbZDRX65 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Apr 2009 19:58:57 -0400
In-Reply-To: <1240099122-18381-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: cleanup

Read and write init paths are almost identical.  Unify them into
idetape_init_rw().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-tape.c |  110 ++++++++++++++++++++----------------------------
 1 files changed, 46 insertions(+), 64 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index d2e9c09..4da7fa9 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -987,42 +987,50 @@ static void ide_tape_flush_merge_buffer(ide_drive_t *drive)
 	tape->chrdev_dir = IDETAPE_DIR_NONE;
 }
 
-static int idetape_init_read(ide_drive_t *drive)
+static int idetape_init_rw(ide_drive_t *drive, int dir)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	int bytes_read;
+	int rc;
 
-	/* Initialize read operation */
-	if (tape->chrdev_dir != IDETAPE_DIR_READ) {
-		if (tape->chrdev_dir == IDETAPE_DIR_WRITE) {
-			ide_tape_flush_merge_buffer(drive);
-			idetape_flush_tape_buffers(drive);
-		}
-		if (tape->buf || tape->valid) {
-			printk(KERN_ERR "ide-tape: valid should be 0 now\n");
-			tape->valid = 0;
-		}
-		tape->buf = kmalloc(tape->buffer_size, GFP_KERNEL);
-		if (!tape->buf)
-			return -ENOMEM;
-		tape->chrdev_dir = IDETAPE_DIR_READ;
-		tape->cur = tape->buf;
+	BUG_ON(dir != IDETAPE_DIR_READ && dir != IDETAPE_DIR_WRITE);
 
-		/*
-		 * Issue a read 0 command to ensure that DSC handshake is
-		 * switched from completion mode to buffer available mode.
-		 * No point in issuing this if DSC overlap isn't supported, some
-		 * drives (Seagate STT3401A) will return an error.
-		 */
-		if (drive->dev_flags & IDE_DFLAG_DSC_OVERLAP) {
-			bytes_read = idetape_queue_rw_tail(drive,
-							REQ_IDETAPE_READ, 0);
-			if (bytes_read < 0) {
-				kfree(tape->buf);
-				tape->buf = NULL;
-				tape->chrdev_dir = IDETAPE_DIR_NONE;
-				return bytes_read;
-			}
+	if (tape->chrdev_dir == dir)
+		return 0;
+
+	if (tape->chrdev_dir == IDETAPE_DIR_READ)
+		ide_tape_discard_merge_buffer(drive, 1);
+	else if (tape->chrdev_dir == IDETAPE_DIR_WRITE) {
+		ide_tape_flush_merge_buffer(drive);
+		idetape_flush_tape_buffers(drive);
+	}
+
+	if (tape->buf || tape->valid) {
+		printk(KERN_ERR "ide-tape: valid should be 0 now\n");
+		tape->valid = 0;
+	}
+
+	tape->buf = kmalloc(tape->buffer_size, GFP_KERNEL);
+	if (!tape->buf)
+		return -ENOMEM;
+	tape->chrdev_dir = dir;
+	tape->cur = tape->buf;
+
+	/*
+	 * Issue a 0 rw command to ensure that DSC handshake is
+	 * switched from completion mode to buffer available mode.  No
+	 * point in issuing this if DSC overlap isn't supported, some
+	 * drives (Seagate STT3401A) will return an error.
+	 */
+	if (drive->dev_flags & IDE_DFLAG_DSC_OVERLAP) {
+		int cmd = dir == IDETAPE_DIR_READ ? REQ_IDETAPE_READ
+						  : REQ_IDETAPE_WRITE;
+
+		rc = idetape_queue_rw_tail(drive, cmd, 0);
+		if (rc < 0) {
+			kfree(tape->buf);
+			tape->buf = NULL;
+			tape->chrdev_dir = IDETAPE_DIR_NONE;
+			return rc;
 		}
 	}
 
@@ -1038,7 +1046,7 @@ static int idetape_add_chrdev_read_request(ide_drive_t *drive, int blocks)
 	if (test_bit(IDE_AFLAG_FILEMARK, &drive->atapi_flags))
 		return 0;
 
-	idetape_init_read(drive);
+	idetape_init_rw(drive, IDETAPE_DIR_READ);
 
 	return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks);
 }
@@ -1195,7 +1203,7 @@ static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
 			    (count % tape->blk_size) == 0)
 				tape->user_bs_factor = count / tape->blk_size;
 	}
-	rc = idetape_init_read(drive);
+	rc = idetape_init_rw(drive, IDETAPE_DIR_READ);
 	if (rc < 0)
 		return rc;
 	if (count == 0)
@@ -1249,6 +1257,7 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 	ssize_t actually_written = 0;
 	ssize_t ret = 0;
 	u16 ctl = *(u16 *)&tape->caps[12];
+	int rc;
 
 	/* The drive is write protected. */
 	if (tape->write_prot)
@@ -1257,36 +1266,9 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 	debug_log(DBG_CHRDEV, "Enter %s, count %Zd\n", __func__, count);
 
 	/* Initialize write operation */
-	if (tape->chrdev_dir != IDETAPE_DIR_WRITE) {
-		if (tape->chrdev_dir == IDETAPE_DIR_READ)
-			ide_tape_discard_merge_buffer(drive, 1);
-		if (tape->buf || tape->valid) {
-			printk(KERN_ERR "ide-tape: valid should be 0 now\n");
-			tape->valid = 0;
-		}
-		tape->buf = kmalloc(tape->buffer_size, GFP_KERNEL);
-		if (!tape->buf)
-			return -ENOMEM;
-		tape->chrdev_dir = IDETAPE_DIR_WRITE;
-		tape->cur = tape->buf;
-
-		/*
-		 * Issue a write 0 command to ensure that DSC handshake is
-		 * switched from completion mode to buffer available mode. No
-		 * point in issuing this if DSC overlap isn't supported, some
-		 * drives (Seagate STT3401A) will return an error.
-		 */
-		if (drive->dev_flags & IDE_DFLAG_DSC_OVERLAP) {
-			ssize_t retval = idetape_queue_rw_tail(drive,
-							REQ_IDETAPE_WRITE, 0);
-			if (retval < 0) {
-				kfree(tape->buf);
-				tape->buf = NULL;
-				tape->chrdev_dir = IDETAPE_DIR_NONE;
-				return retval;
-			}
-		}
-	}
+	rc = idetape_init_rw(drive, IDETAPE_DIR_WRITE);
+	if (rc < 0)
+		return rc;
 	if (count == 0)
 		return (0);
 	if (tape->valid < tape->buffer_size) {
-- 
1.6.0.2

