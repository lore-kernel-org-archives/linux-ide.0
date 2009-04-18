From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/10] ide-tape: use standard data transfer mechanism
Date: Sun, 19 Apr 2009 08:58:36 +0900
Message-ID: <1240099122-18381-5-git-send-email-tj@kernel.org>
References: <1240099122-18381-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57788 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754555AbZDRX7C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Apr 2009 19:59:02 -0400
In-Reply-To: <1240099122-18381-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <jens.axboe@oracle.com>

Impact: use standard way to transfer data

ide-tape uses rq in an interesting way.  For r/w requests, rq->special
is used to carry a private buffer management structure idetape_bh and
rq->nr_sectors and current_nr_sectors are initialized to the number of
idetape blocks which isn't necessary 512 bytes.  Also,
rq->current_nr_sectors is used to report back the residual count in
units of idetape blocks.

This peculiarity taxes both block layer and ide.  ide-atapi has
different paths and hooks to accomodate it and what a rq means becomes
quite confusing and making changes at the block layer becomes quite
difficult and error-prone.

This patch makes ide-tape use bio instead.  With the previous patch,
ide-tape currently is using single contiguos buffer so replacing it
isn't difficult.  Data buffer is mapped into bio using
blk_rq_map_kern() in idetape_queue_rw_tail().  idetape_io_buffers()
and idetape_update_buffers() are dropped and pc->bh is set to null to
tell ide-atapi to use standard data transfer mechanism and idetape_bh
byte counts are updated by the issuer on completion using the residual
count.

This change also nicely removes the FIXME in ide_pc_intr() where
ide-tape rqs need to be completed using ide_rq_bytes() instead of
blk_rq_bytes() (although this didn't really matter as the request
didn't have bio).

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>
---
 drivers/ide/ide-atapi.c |    6 +--
 drivers/ide/ide-tape.c  |  112 ++++++++++-------------------------------------
 2 files changed, 24 insertions(+), 94 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 3df5442..b9dd450 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -413,11 +413,7 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 		 * ->pc_callback() might change rq->data_len for
 		 * residual count, cache total length.
 		 */
-		if (!blk_special_request(rq) &&
-		    (drive->media == ide_tape && !rq->bio))
-			done = ide_rq_bytes(rq);        /* FIXME */
-		else
-			done = blk_rq_bytes(rq);
+		done = blk_rq_bytes(rq);
 
 		/* Command finished - Call the callback function */
 		uptodate = drive->pc_callback(drive, dsc);
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index b2afbc7..b373ac8 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -292,65 +292,6 @@ static struct ide_tape_obj *ide_tape_chrdev_get(unsigned int i)
 	return tape;
 }
 
-static int idetape_input_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
-				  unsigned int bcount)
-{
-	struct idetape_bh *bh = pc->bh;
-	int count;
-
-	if (bcount && bh) {
-		count = min(
-			(unsigned int)(bh->b_size - atomic_read(&bh->b_count)),
-			bcount);
-		drive->hwif->tp_ops->input_data(drive, NULL, bh->b_data +
-					atomic_read(&bh->b_count), count);
-		bcount -= count;
-		atomic_add(count, &bh->b_count);
-		if (atomic_read(&bh->b_count) == bh->b_size)
-			pc->bh = NULL;
-	}
-
-	return bcount;
-}
-
-static int idetape_output_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
-				   unsigned int bcount)
-{
-	struct idetape_bh *bh = pc->bh;
-	int count;
-
-	if (bcount && bh) {
-		count = min((unsigned int)pc->b_count, (unsigned int)bcount);
-		drive->hwif->tp_ops->output_data(drive, NULL, pc->b_data, count);
-		bcount -= count;
-		pc->b_data += count;
-		pc->b_count -= count;
-		if (!pc->b_count)
-			pc->bh = NULL;
-	}
-
-	return bcount;
-}
-
-static void idetape_update_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc)
-{
-	struct idetape_bh *bh = pc->bh;
-	unsigned int bcount = pc->xferred;
-
-	if (pc->flags & PC_FLAG_WRITING)
-		return;
-	if (bcount) {
-		if (bh == NULL || bcount > bh->b_size) {
-			printk(KERN_ERR "ide-tape: bh == NULL in %s\n",
-					__func__);
-			return;
-		}
-		atomic_set(&bh->b_count, bcount);
-		if (atomic_read(&bh->b_count) == bh->b_size)
-			pc->bh = NULL;
-	}
-}
-
 /*
  * called on each failed packet command retry to analyze the request sense. We
  * currently do not utilize this information.
@@ -368,12 +309,10 @@ static void idetape_analyze_error(ide_drive_t *drive, u8 *sense)
 		 pc->c[0], tape->sense_key, tape->asc, tape->ascq);
 
 	/* Correct pc->xferred by asking the tape.	 */
-	if (pc->flags & PC_FLAG_DMA_ERROR) {
+	if (pc->flags & PC_FLAG_DMA_ERROR)
 		pc->xferred = pc->req_xfer -
 			tape->blk_size *
 			get_unaligned_be32(&sense[3]);
-		idetape_update_buffers(drive, pc);
-	}
 
 	/*
 	 * If error was the result of a zero-length read or write command,
@@ -458,7 +397,7 @@ static int ide_tape_callback(ide_drive_t *drive, int dsc)
 		}
 
 		tape->first_frame += blocks;
-		rq->current_nr_sectors -= blocks;
+		rq->data_len -= blocks * tape->blk_size;
 
 		if (pc->error) {
 			uptodate = 0;
@@ -520,19 +459,6 @@ static void ide_tape_handle_dsc(ide_drive_t *drive)
 	idetape_postpone_request(drive);
 }
 
-static int ide_tape_io_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
-				unsigned int bcount, int write)
-{
-	unsigned int bleft;
-
-	if (write)
-		bleft = idetape_output_buffers(drive, pc, bcount);
-	else
-		bleft = idetape_input_buffers(drive, pc, bcount);
-
-	return bcount - bleft;
-}
-
 /*
  * Packet Command Interface
  *
@@ -683,7 +609,7 @@ static void ide_tape_create_rw_cmd(idetape_tape_t *tape,
 	ide_init_pc(pc);
 	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
 	pc->c[1] = 1;
-	pc->bh = bh;
+	pc->bh = NULL;
 	pc->buf = NULL;
 	pc->buf_size = length * tape->blk_size;
 	pc->req_xfer = pc->buf_size;
@@ -1063,10 +989,12 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks,
 				 struct idetape_bh *bh)
 {
 	idetape_tape_t *tape = drive->driver_data;
+	size_t size = blocks * tape->blk_size;
 	struct request *rq;
-	int ret, errors;
+	int ret;
 
 	debug_log(DBG_SENSE, "%s: cmd=%d\n", __func__, cmd);
+	BUG_ON(cmd != REQ_IDETAPE_READ && cmd != REQ_IDETAPE_WRITE);
 
 	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
 	rq->cmd_type = REQ_TYPE_SPECIAL;
@@ -1074,21 +1002,29 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks,
 	rq->rq_disk = tape->disk;
 	rq->special = (void *)bh;
 	rq->sector = tape->first_frame;
-	rq->nr_sectors = blocks;
-	rq->current_nr_sectors = blocks;
+
+	if (size) {
+		ret = blk_rq_map_kern(drive->queue, rq, bh->b_data, size,
+				      __GFP_WAIT);
+		if (ret)
+			goto out_put;
+	}
+
 	blk_execute_rq(drive->queue, tape->disk, rq, 0);
 
-	errors = rq->errors;
-	ret = tape->blk_size * (blocks - rq->current_nr_sectors);
-	blk_put_request(rq);
+	/* calculate the number of transferred bytes and update bh */
+	size -= rq->data_len;
+	if (cmd == REQ_IDETAPE_READ)
+		atomic_add(size, &bh->b_count);
 
-	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) == 0)
-		return 0;
+	ret = size;
+	if (rq->errors == IDE_DRV_ERROR_GENERAL)
+		ret = -EIO;
 
 	if (tape->merge_bh)
 		idetape_init_merge_buffer(tape);
-	if (errors == IDE_DRV_ERROR_GENERAL)
-		return -EIO;
+out_put:
+	blk_put_request(rq);
 	return ret;
 }
 
@@ -2034,8 +1970,6 @@ static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
 	u16 *ctl = (u16 *)&tape->caps[12];
 
 	drive->pc_callback	 = ide_tape_callback;
-	drive->pc_update_buffers = idetape_update_buffers;
-	drive->pc_io_buffers	 = ide_tape_io_buffers;
 
 	drive->dev_flags |= IDE_DFLAG_DSC_OVERLAP;
 
-- 
1.6.0.2

