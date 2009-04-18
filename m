From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/10] ide-tape: use single continuous buffer
Date: Sun, 19 Apr 2009 08:58:35 +0900
Message-ID: <1240099122-18381-4-git-send-email-tj@kernel.org>
References: <1240099122-18381-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57766 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbZDRX6y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Apr 2009 19:58:54 -0400
In-Reply-To: <1240099122-18381-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: simpler buffer allocation and handling, kills OOM, fix DMA transfers

ide-tape has its own multiple buffer mechanism using struct
idetape_bh.  It allocates buffer with decreasing order-of-two
allocations so that it results in minimum number of segments.
However, the implementation is quite complex and works in a way that
no other block or ide driver works necessitating a lot of special case
handling.

The benefit this complex allocation scheme brings is questionable as
PIO or DMA the number of segments (16 maximum) doesn't make any
noticeable difference and it also doesn't negate the need for multiple
order allocation which can fail under memory pressure or high
fragmentation although it does lower the highest order necessary by
one when the buffer size isn't power of two.

As the first step to remove the custom buffer management, this patch
makes ide-tape allocate single continous buffer.  The maximum order is
four.  I doubt the change would cause any trouble but if it ever
matters, it should be converted to regular sg mechanism like everyone
else and even in that case dropping custom buffer handling and moving
to standard mechanism first make sense as an intermediate step.

This patch makes the first bh to contain the whole buffer and drops
multi bh handling code.  Following patches will make further changes.

This patch has the side effect of killing OOM triggered by allocation
path and fixing DMA transfers.  Previously, bug in alloc path
triggered OOM on command issue and commands were passed to DMA engine
without DMA-mapping all the segments.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-tape.c |  258 +++++++++++-------------------------------------
 1 files changed, 59 insertions(+), 199 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 8226d52..b2afbc7 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -134,7 +134,6 @@ enum {
 struct idetape_bh {
 	u32 b_size;
 	atomic_t b_count;
-	struct idetape_bh *b_reqnext;
 	char *b_data;
 };
 
@@ -228,10 +227,6 @@ typedef struct ide_tape_obj {
 	char *b_data;
 	int b_count;
 
-	int pages_per_buffer;
-	/* Wasted space in each stage */
-	int excess_bh_size;
-
 	/* Measures average tape speed */
 	unsigned long avg_time;
 	int avg_size;
@@ -303,9 +298,7 @@ static int idetape_input_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	struct idetape_bh *bh = pc->bh;
 	int count;
 
-	while (bcount) {
-		if (bh == NULL)
-			break;
+	if (bcount && bh) {
 		count = min(
 			(unsigned int)(bh->b_size - atomic_read(&bh->b_count)),
 			bcount);
@@ -313,15 +306,10 @@ static int idetape_input_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
 					atomic_read(&bh->b_count), count);
 		bcount -= count;
 		atomic_add(count, &bh->b_count);
-		if (atomic_read(&bh->b_count) == bh->b_size) {
-			bh = bh->b_reqnext;
-			if (bh)
-				atomic_set(&bh->b_count, 0);
-		}
+		if (atomic_read(&bh->b_count) == bh->b_size)
+			pc->bh = NULL;
 	}
 
-	pc->bh = bh;
-
 	return bcount;
 }
 
@@ -331,22 +319,14 @@ static int idetape_output_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	struct idetape_bh *bh = pc->bh;
 	int count;
 
-	while (bcount) {
-		if (bh == NULL)
-			break;
+	if (bcount && bh) {
 		count = min((unsigned int)pc->b_count, (unsigned int)bcount);
 		drive->hwif->tp_ops->output_data(drive, NULL, pc->b_data, count);
 		bcount -= count;
 		pc->b_data += count;
 		pc->b_count -= count;
-		if (!pc->b_count) {
-			bh = bh->b_reqnext;
-			pc->bh = bh;
-			if (bh) {
-				pc->b_data = bh->b_data;
-				pc->b_count = atomic_read(&bh->b_count);
-			}
-		}
+		if (!pc->b_count)
+			pc->bh = NULL;
 	}
 
 	return bcount;
@@ -355,24 +335,20 @@ static int idetape_output_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
 static void idetape_update_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc)
 {
 	struct idetape_bh *bh = pc->bh;
-	int count;
 	unsigned int bcount = pc->xferred;
 
 	if (pc->flags & PC_FLAG_WRITING)
 		return;
-	while (bcount) {
-		if (bh == NULL) {
+	if (bcount) {
+		if (bh == NULL || bcount > bh->b_size) {
 			printk(KERN_ERR "ide-tape: bh == NULL in %s\n",
 					__func__);
 			return;
 		}
-		count = min((unsigned int)bh->b_size, (unsigned int)bcount);
-		atomic_set(&bh->b_count, count);
+		atomic_set(&bh->b_count, bcount);
 		if (atomic_read(&bh->b_count) == bh->b_size)
-			bh = bh->b_reqnext;
-		bcount -= count;
+			pc->bh = NULL;
 	}
-	pc->bh = bh;
 }
 
 /*
@@ -439,24 +415,10 @@ static void idetape_analyze_error(ide_drive_t *drive, u8 *sense)
 /* Free data buffers completely. */
 static void ide_tape_kfree_buffer(idetape_tape_t *tape)
 {
-	struct idetape_bh *prev_bh, *bh = tape->merge_bh;
-
-	while (bh) {
-		u32 size = bh->b_size;
-
-		while (size) {
-			unsigned int order = fls(size >> PAGE_SHIFT)-1;
-
-			if (bh->b_data)
-				free_pages((unsigned long)bh->b_data, order);
+	struct idetape_bh *bh = tape->merge_bh;
 
-			size &= (order-1);
-			bh->b_data += (1 << order) * PAGE_SIZE;
-		}
-		prev_bh = bh;
-		bh = bh->b_reqnext;
-		kfree(prev_bh);
-	}
+	kfree(bh->b_data);
+	kfree(bh);
 }
 
 static void ide_tape_handle_dsc(ide_drive_t *);
@@ -861,117 +823,50 @@ out:
 }
 
 /*
- * The function below uses __get_free_pages to allocate a data buffer of size
- * tape->buffer_size (or a bit more). We attempt to combine sequential pages as
- * much as possible.
- *
- * It returns a pointer to the newly allocated buffer, or NULL in case of
- * failure.
+ * It returns a pointer to the newly allocated buffer, or NULL in case
+ * of failure.
  */
 static struct idetape_bh *ide_tape_kmalloc_buffer(idetape_tape_t *tape,
-						  int full, int clear)
-{
-	struct idetape_bh *prev_bh, *bh, *merge_bh;
-	int pages = tape->pages_per_buffer;
-	unsigned int order, b_allocd;
-	char *b_data = NULL;
-
-	merge_bh = kmalloc(sizeof(struct idetape_bh), GFP_KERNEL);
-	bh = merge_bh;
-	if (bh == NULL)
-		goto abort;
-
-	order = fls(pages) - 1;
-	bh->b_data = (char *) __get_free_pages(GFP_KERNEL, order);
-	if (!bh->b_data)
-		goto abort;
-	b_allocd = (1 << order) * PAGE_SIZE;
-	pages &= (order-1);
-
-	if (clear)
-		memset(bh->b_data, 0, b_allocd);
-	bh->b_reqnext = NULL;
-	bh->b_size = b_allocd;
-	atomic_set(&bh->b_count, full ? bh->b_size : 0);
+						  int full)
+{
+	struct idetape_bh *bh;
 
-	while (pages) {
-		order = fls(pages) - 1;
-		b_data = (char *) __get_free_pages(GFP_KERNEL, order);
-		if (!b_data)
-			goto abort;
-		b_allocd = (1 << order) * PAGE_SIZE;
-
-		if (clear)
-			memset(b_data, 0, b_allocd);
-
-		/* newly allocated page frames below buffer header or ...*/
-		if (bh->b_data == b_data + b_allocd) {
-			bh->b_size += b_allocd;
-			bh->b_data -= b_allocd;
-			if (full)
-				atomic_add(b_allocd, &bh->b_count);
-			continue;
-		}
-		/* they are above the header */
-		if (b_data == bh->b_data + bh->b_size) {
-			bh->b_size += b_allocd;
-			if (full)
-				atomic_add(b_allocd, &bh->b_count);
-			continue;
-		}
-		prev_bh = bh;
-		bh = kmalloc(sizeof(struct idetape_bh), GFP_KERNEL);
-		if (!bh) {
-			free_pages((unsigned long) b_data, order);
-			goto abort;
-		}
-		bh->b_reqnext = NULL;
-		bh->b_data = b_data;
-		bh->b_size = b_allocd;
-		atomic_set(&bh->b_count, full ? bh->b_size : 0);
-		prev_bh->b_reqnext = bh;
+	bh = kmalloc(sizeof(struct idetape_bh), GFP_KERNEL);
+	if (!bh)
+		return NULL;
 
-		pages &= (order-1);
+	bh->b_data = kmalloc(tape->buffer_size, GFP_KERNEL);
+	if (!bh->b_data) {
+		kfree(bh);
+		return NULL;
 	}
 
-	bh->b_size -= tape->excess_bh_size;
-	if (full)
-		atomic_sub(tape->excess_bh_size, &bh->b_count);
-	return merge_bh;
-abort:
-	ide_tape_kfree_buffer(tape);
-	return NULL;
+	bh->b_size = tape->buffer_size;
+	atomic_set(&bh->b_count, full ? bh->b_size : 0);
+
+	return bh;
 }
 
 static int idetape_copy_stage_from_user(idetape_tape_t *tape,
 					const char __user *buf, int n)
 {
 	struct idetape_bh *bh = tape->bh;
-	int count;
 	int ret = 0;
 
-	while (n) {
-		if (bh == NULL) {
+	if (n) {
+		if (bh == NULL || n > bh->b_size - atomic_read(&bh->b_count)) {
 			printk(KERN_ERR "ide-tape: bh == NULL in %s\n",
 					__func__);
 			return 1;
 		}
-		count = min((unsigned int)
-				(bh->b_size - atomic_read(&bh->b_count)),
-				(unsigned int)n);
 		if (copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf,
-				count))
+				   n))
 			ret = 1;
-		n -= count;
-		atomic_add(count, &bh->b_count);
-		buf += count;
-		if (atomic_read(&bh->b_count) == bh->b_size) {
-			bh = bh->b_reqnext;
-			if (bh)
-				atomic_set(&bh->b_count, 0);
-		}
+		atomic_add(n, &bh->b_count);
+		if (atomic_read(&bh->b_count) == bh->b_size)
+			tape->bh = NULL;
 	}
-	tape->bh = bh;
+
 	return ret;
 }
 
@@ -979,30 +874,20 @@ static int idetape_copy_stage_to_user(idetape_tape_t *tape, char __user *buf,
 				      int n)
 {
 	struct idetape_bh *bh = tape->bh;
-	int count;
 	int ret = 0;
 
-	while (n) {
-		if (bh == NULL) {
+	if (n) {
+		if (bh == NULL || n > tape->b_count) {
 			printk(KERN_ERR "ide-tape: bh == NULL in %s\n",
 					__func__);
 			return 1;
 		}
-		count = min(tape->b_count, n);
-		if  (copy_to_user(buf, tape->b_data, count))
+		if (copy_to_user(buf, tape->b_data, n))
 			ret = 1;
-		n -= count;
-		tape->b_data += count;
-		tape->b_count -= count;
-		buf += count;
-		if (!tape->b_count) {
-			bh = bh->b_reqnext;
-			tape->bh = bh;
-			if (bh) {
-				tape->b_data = bh->b_data;
-				tape->b_count = atomic_read(&bh->b_count);
-			}
-		}
+		tape->b_data += n;
+		tape->b_count -= n;
+		if (!tape->b_count)
+			tape->bh = NULL;
 	}
 	return ret;
 }
@@ -1254,7 +1139,7 @@ static int idetape_add_chrdev_write_request(ide_drive_t *drive, int blocks)
 static void ide_tape_flush_merge_buffer(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	int blocks, min;
+	int blocks;
 	struct idetape_bh *bh;
 
 	if (tape->chrdev_dir != IDETAPE_DIR_WRITE) {
@@ -1269,31 +1154,16 @@ static void ide_tape_flush_merge_buffer(ide_drive_t *drive)
 	if (tape->merge_bh_size) {
 		blocks = tape->merge_bh_size / tape->blk_size;
 		if (tape->merge_bh_size % tape->blk_size) {
-			unsigned int i;
-
+			unsigned int i = tape->blk_size -
+				tape->merge_bh_size % tape->blk_size;
 			blocks++;
-			i = tape->blk_size - tape->merge_bh_size %
-				tape->blk_size;
-			bh = tape->bh->b_reqnext;
-			while (bh) {
-				atomic_set(&bh->b_count, 0);
-				bh = bh->b_reqnext;
-			}
 			bh = tape->bh;
-			while (i) {
-				if (bh == NULL) {
-					printk(KERN_INFO "ide-tape: bug,"
-							 " bh NULL\n");
-					break;
-				}
-				min = min(i, (unsigned int)(bh->b_size -
-						atomic_read(&bh->b_count)));
+			if (bh) {
 				memset(bh->b_data + atomic_read(&bh->b_count),
-						0, min);
-				atomic_add(min, &bh->b_count);
-				i -= min;
-				bh = bh->b_reqnext;
-			}
+				       0, i);
+				atomic_add(i, &bh->b_count);
+			} else
+				printk(KERN_INFO "ide-tape: bug, bh NULL\n");
 		}
 		(void) idetape_add_chrdev_write_request(drive, blocks);
 		tape->merge_bh_size = 0;
@@ -1321,7 +1191,7 @@ static int idetape_init_read(ide_drive_t *drive)
 					 " 0 now\n");
 			tape->merge_bh_size = 0;
 		}
-		tape->merge_bh = ide_tape_kmalloc_buffer(tape, 0, 0);
+		tape->merge_bh = ide_tape_kmalloc_buffer(tape, 0);
 		if (!tape->merge_bh)
 			return -ENOMEM;
 		tape->chrdev_dir = IDETAPE_DIR_READ;
@@ -1368,23 +1238,18 @@ static int idetape_add_chrdev_read_request(ide_drive_t *drive, int blocks)
 static void idetape_pad_zeros(ide_drive_t *drive, int bcount)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	struct idetape_bh *bh;
+	struct idetape_bh *bh = tape->merge_bh;
 	int blocks;
 
 	while (bcount) {
 		unsigned int count;
 
-		bh = tape->merge_bh;
 		count = min(tape->buffer_size, bcount);
 		bcount -= count;
 		blocks = count / tape->blk_size;
-		while (count) {
-			atomic_set(&bh->b_count,
-				   min(count, (unsigned int)bh->b_size));
-			memset(bh->b_data, 0, atomic_read(&bh->b_count));
-			count -= atomic_read(&bh->b_count);
-			bh = bh->b_reqnext;
-		}
+		atomic_set(&bh->b_count, count);
+		memset(bh->b_data, 0, atomic_read(&bh->b_count));
+
 		idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, blocks,
 				      tape->merge_bh);
 	}
@@ -1596,7 +1461,7 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 				"should be 0 now\n");
 			tape->merge_bh_size = 0;
 		}
-		tape->merge_bh = ide_tape_kmalloc_buffer(tape, 0, 0);
+		tape->merge_bh = ide_tape_kmalloc_buffer(tape, 0);
 		if (!tape->merge_bh)
 			return -ENOMEM;
 		tape->chrdev_dir = IDETAPE_DIR_WRITE;
@@ -1970,7 +1835,7 @@ static void idetape_write_release(ide_drive_t *drive, unsigned int minor)
 	idetape_tape_t *tape = drive->driver_data;
 
 	ide_tape_flush_merge_buffer(drive);
-	tape->merge_bh = ide_tape_kmalloc_buffer(tape, 1, 0);
+	tape->merge_bh = ide_tape_kmalloc_buffer(tape, 1);
 	if (tape->merge_bh != NULL) {
 		idetape_pad_zeros(drive, tape->blk_size *
 				(tape->user_bs_factor - 1));
@@ -2201,11 +2066,6 @@ static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
 		tape->buffer_size = *ctl * tape->blk_size;
 	}
 	buffer_size = tape->buffer_size;
-	tape->pages_per_buffer = buffer_size / PAGE_SIZE;
-	if (buffer_size % PAGE_SIZE) {
-		tape->pages_per_buffer++;
-		tape->excess_bh_size = PAGE_SIZE - buffer_size % PAGE_SIZE;
-	}
 
 	/* select the "best" DSC read/write polling freq */
 	speed = max(*(u16 *)&tape->caps[14], *(u16 *)&tape->caps[8]);
-- 
1.6.0.2

