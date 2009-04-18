From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/10] ide-tape: use byte size instead of sectors on rw issue functions
Date: Sun, 19 Apr 2009 08:58:39 +0900
Message-ID: <1240099122-18381-8-git-send-email-tj@kernel.org>
References: <1240099122-18381-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57779 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667AbZDRX66 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Apr 2009 19:58:58 -0400
In-Reply-To: <1240099122-18381-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: cleanup

Byte size is what most issue functions deal with, make
idetape_queue_rw_tail() and its wrappers take byte size instead of
sector counts.  idetape_chrdev_read() and write() functions are
converted to use tape->buffer_size instead of ctl from tape->cap.

This cleans up code a little bit and will ease the next r/w
reimplementation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-tape.c |   45 ++++++++++++++++++++-------------------------
 1 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 4da7fa9..d5e9bb2 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -879,15 +879,15 @@ static void ide_tape_discard_merge_buffer(ide_drive_t *drive,
  * Generate a read/write request for the block device interface and wait for it
  * to be serviced.
  */
-static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks)
+static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int size)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	size_t size = blocks * tape->blk_size;
 	struct request *rq;
 	int ret;
 
 	debug_log(DBG_SENSE, "%s: cmd=%d\n", __func__, cmd);
 	BUG_ON(cmd != REQ_IDETAPE_READ && cmd != REQ_IDETAPE_WRITE);
+	BUG_ON(size < 0 || size % tape->blk_size);
 
 	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
 	rq->cmd_type = REQ_TYPE_SPECIAL;
@@ -954,17 +954,16 @@ static void idetape_create_space_cmd(struct ide_atapi_pc *pc, int count, u8 cmd)
 }
 
 /* Queue up a character device originated write request. */
-static int idetape_add_chrdev_write_request(ide_drive_t *drive, int blocks)
+static int idetape_add_chrdev_write_request(ide_drive_t *drive, int size)
 {
 	debug_log(DBG_CHRDEV, "Enter %s\n", __func__);
 
-	return idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, blocks);
+	return idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, size);
 }
 
 static void ide_tape_flush_merge_buffer(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	int blocks;
 
 	if (tape->chrdev_dir != IDETAPE_DIR_WRITE) {
 		printk(KERN_ERR "ide-tape: bug: Trying to empty merge buffer"
@@ -972,15 +971,10 @@ static void ide_tape_flush_merge_buffer(ide_drive_t *drive)
 		return;
 	}
 	if (tape->buf) {
-		blocks = tape->valid / tape->blk_size;
-		if (tape->valid % tape->blk_size) {
-			blocks++;
-			memset(tape->buf + tape->valid, 0,
-			       tape->blk_size - tape->valid % tape->blk_size);
-		}
-		(void) idetape_add_chrdev_write_request(drive, blocks);
-	}
-	if (tape->buf != NULL) {
+		size_t aligned = roundup(tape->valid, tape->blk_size);
+
+		memset(tape->cur, 0, aligned - tape->valid);
+		idetape_add_chrdev_write_request(drive, aligned);
 		kfree(tape->buf);
 		tape->buf = NULL;
 	}
@@ -1038,9 +1032,9 @@ static int idetape_init_rw(ide_drive_t *drive, int dir)
 }
 
 /* called from idetape_chrdev_read() to service a chrdev read request. */
-static int idetape_add_chrdev_read_request(ide_drive_t *drive, int blocks)
+static int idetape_add_chrdev_read_request(ide_drive_t *drive, int size)
 {
-	debug_log(DBG_PROCS, "Enter %s, %d blocks\n", __func__, blocks);
+	debug_log(DBG_PROCS, "Enter %s, %d bytes\n", __func__, size);
 
 	/* If we are at a filemark, return a read length of 0 */
 	if (test_bit(IDE_AFLAG_FILEMARK, &drive->atapi_flags))
@@ -1048,7 +1042,7 @@ static int idetape_add_chrdev_read_request(ide_drive_t *drive, int blocks)
 
 	idetape_init_rw(drive, IDETAPE_DIR_READ);
 
-	return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks);
+	return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, size);
 }
 
 static void idetape_pad_zeros(ide_drive_t *drive, int bcount)
@@ -1060,8 +1054,7 @@ static void idetape_pad_zeros(ide_drive_t *drive, int bcount)
 	while (bcount) {
 		unsigned int count = min(tape->buffer_size, bcount);
 
-		idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE,
-				      count / tape->blk_size);
+		idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, count);
 		bcount -= count;
 	}
 }
@@ -1193,7 +1186,6 @@ static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
 	ide_drive_t *drive = tape->drive;
 	ssize_t bytes_read, temp, actually_read = 0, rc;
 	ssize_t ret = 0;
-	u16 ctl = *(u16 *)&tape->caps[12];
 
 	debug_log(DBG_CHRDEV, "Enter %s, count %Zd\n", __func__, count);
 
@@ -1218,7 +1210,8 @@ static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
 		tape->valid -= actually_read;
 	}
 	while (count >= tape->buffer_size) {
-		bytes_read = idetape_add_chrdev_read_request(drive, ctl);
+		bytes_read = idetape_add_chrdev_read_request(drive,
+							     tape->buffer_size);
 		if (bytes_read <= 0)
 			goto finish;
 		if (copy_to_user(buf, tape->cur, bytes_read))
@@ -1228,7 +1221,8 @@ static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
 		actually_read += bytes_read;
 	}
 	if (count) {
-		bytes_read = idetape_add_chrdev_read_request(drive, ctl);
+		bytes_read = idetape_add_chrdev_read_request(drive,
+							     tape->buffer_size);
 		if (bytes_read <= 0)
 			goto finish;
 		temp = min((unsigned long)count, (unsigned long)bytes_read);
@@ -1256,7 +1250,6 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 	ide_drive_t *drive = tape->drive;
 	ssize_t actually_written = 0;
 	ssize_t ret = 0;
-	u16 ctl = *(u16 *)&tape->caps[12];
 	int rc;
 
 	/* The drive is write protected. */
@@ -1284,7 +1277,8 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 
 		if (tape->valid == tape->buffer_size) {
 			ssize_t retval;
-			retval = idetape_add_chrdev_write_request(drive, ctl);
+			retval = idetape_add_chrdev_write_request(drive,
+							tape->buffer_size);
 			if (retval <= 0)
 				return (retval);
 		}
@@ -1295,7 +1289,8 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 			ret = -EFAULT;
 		buf += tape->buffer_size;
 		count -= tape->buffer_size;
-		retval = idetape_add_chrdev_write_request(drive, ctl);
+		retval = idetape_add_chrdev_write_request(drive,
+							  tape->buffer_size);
 		actually_written += tape->buffer_size;
 		if (retval <= 0)
 			return (retval);
-- 
1.6.0.2

