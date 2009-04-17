From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/15] ide-cd,atapi: use bio for internal commands
Date: Fri, 17 Apr 2009 18:33:21 +0900
Message-ID: <1239960802-31978-15-git-send-email-tj@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39993 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757962AbZDQJds (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:48 -0400
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: unify request data buffer handling

rq->data is used mostly to pass kernel buffer through request queue
without using bio.  There are only a couple of places which still do
this in kernel and converting to bio isn't difficult.

This patch converts ide-cd and atapi to use bio instead of rq->data
for request sense and internal pc commands.  With previous change to
unify sense request handling, this is relatively easily achieved by
adding blk_rq_map_kern() during sense_rq prep and PC issue.

If blk_rq_map_kern() fails for sense, the error is deferred till sense
issue and aborts the failed command which triggered the sense.  Note
that this is a slim possibility as sense prep is done on each command
issue, so for the above condition to actually trigger, all preps since
the last sense issue till the issue of the request which would require
a sense should fail.

* do_request functions might sleep now.  This should be okay as ide
  request_fn - do_ide_request() - is invoked only from make_request
  and plug work.  Make sure this is the case by adding might_sleep()
  to do_ide_request().

* Functions which access the read sense data before the sense request
  is complete now should access bio_data(sense_rq->bio) as the sense
  buffer might have been copied during blk_rq_map_kern().

* ide-tape updated to map sg.

* cdrom_do_block_pc() now doesn't have to deal with REQ_TYPE_ATA_PC
  special case.  Simplified.

* tp_ops->output/input_data path dropped from ide_pc_intr().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-atapi.c |   52 ++++++++++++++++++++++++++++-------------------
 drivers/ide/ide-cd.c    |   28 ++++++++++++------------
 drivers/ide/ide-io.c    |    3 ++
 drivers/ide/ide-tape.c  |    3 ++
 include/linux/ide.h     |    2 +-
 5 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 972c522..5cefe12 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -94,16 +94,18 @@ int ide_queue_pc_tail(ide_drive_t *drive, struct gendisk *disk,
 	rq->special = (char *)pc;
 
 	if (pc->req_xfer) {
-		rq->data = pc->buf;
-		rq->data_len = pc->req_xfer;
+		error = blk_rq_map_kern(drive->queue, rq, pc->buf, pc->req_xfer,
+					GFP_NOIO);
+		if (error)
+			goto put_req;
 	}
 
 	memcpy(rq->cmd, pc->c, 12);
 	if (drive->media == ide_tape)
 		rq->cmd[13] = REQ_IDETAPE_PC1;
 	error = blk_execute_rq(drive->queue, disk, rq, 0);
+put_req:
 	blk_put_request(rq);
-
 	return error;
 }
 EXPORT_SYMBOL_GPL(ide_queue_pc_tail);
@@ -168,6 +170,7 @@ void ide_prep_sense(ide_drive_t *drive, struct request *rq)
 	struct request_sense *sense = &drive->sense_data;
 	struct request *sense_rq = &drive->sense_rq;
 	unsigned int cmd_len, sense_len;
+	int err;
 
 	debug_log("%s: enter\n", __func__);
 
@@ -193,13 +196,19 @@ void ide_prep_sense(ide_drive_t *drive, struct request *rq)
 	memset(sense, 0, sizeof(*sense));
 
 	blk_rq_init(rq->q, sense_rq);
-	sense_rq->rq_disk = rq->rq_disk;
 
-	sense_rq->data = sense;
+	err = blk_rq_map_kern(drive->queue, sense_rq, sense, sense_len,
+			      GFP_NOIO);
+	if (unlikely(err)) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "%s: failed to map sense buffer\n",
+			       drive->name);
+		return;
+	}
+
+	sense_rq->rq_disk = rq->rq_disk;
 	sense_rq->cmd[0] = GPCMD_REQUEST_SENSE;
 	sense_rq->cmd[4] = cmd_len;
-	sense_rq->data_len = sense_len;
-
 	sense_rq->cmd_type = REQ_TYPE_SENSE;
 	sense_rq->cmd_flags |= REQ_PREEMPT;
 
@@ -210,9 +219,14 @@ void ide_prep_sense(ide_drive_t *drive, struct request *rq)
 }
 EXPORT_SYMBOL_GPL(ide_prep_sense);
 
-void ide_queue_sense_rq(ide_drive_t *drive, void *special)
+int ide_queue_sense_rq(ide_drive_t *drive, void *special)
 {
-	BUG_ON(!drive->sense_rq_armed);
+	/* deferred failure from ide_prep_sense() */
+	if (!drive->sense_rq_armed) {
+		printk(KERN_WARNING "%s: failed queue sense request\n",
+		       drive->name);
+		return -ENOMEM;
+	}
 
 	drive->sense_rq.special = special;
 	drive->sense_rq_armed = false;
@@ -221,6 +235,7 @@ void ide_queue_sense_rq(ide_drive_t *drive, void *special)
 
 	elv_add_request(drive->queue, &drive->sense_rq,
 			ELEVATOR_INSERT_FRONT, 0);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ide_queue_sense_rq);
 
@@ -239,13 +254,14 @@ void ide_retry_pc(ide_drive_t *drive)
 	/* init pc from sense_rq */
 	ide_init_pc(pc);
 	memcpy(pc->c, sense_rq->cmd, 12);
-	pc->buf = sense_rq->data;
+	pc->buf = bio_data(sense_rq->bio);	/* pointer to mapped address */
 	pc->req_xfer = sense_rq->data_len;
 
 	if (drive->media == ide_tape)
 		set_bit(IDE_AFLAG_IGNORE_DSC, &drive->atapi_flags);
 
-	ide_queue_sense_rq(drive, pc);
+	if (ide_queue_sense_rq(drive, pc))
+		ide_complete_rq(drive, -EIO, blk_rq_bytes(drive->hwif->rq));
 }
 EXPORT_SYMBOL_GPL(ide_retry_pc);
 
@@ -317,7 +333,6 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 	struct ide_cmd *cmd = &hwif->cmd;
 	struct request *rq = hwif->rq;
 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
-	xfer_func_t *xferfunc;
 	unsigned int timeout, done;
 	u16 bcount;
 	u8 stat, ireason, dsc = 0;
@@ -411,7 +426,7 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 					rq->errors = -EIO;
 			}
 
-			if (drive->media == ide_tape)
+			if (drive->media == ide_tape && !rq->bio)
 				done = ide_rq_bytes(rq); /* FIXME */
 			else
 				done = blk_rq_bytes(rq);
@@ -448,16 +463,11 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 		return ide_do_reset(drive);
 	}
 
-	xferfunc = write ? tp_ops->output_data : tp_ops->input_data;
-
-	if (drive->media == ide_floppy && pc->buf == NULL) {
+	if (drive->media == ide_tape && pc->bh)
+		done = drive->pc_io_buffers(drive, pc, bcount, write);
+	else {
 		done = min_t(unsigned int, bcount, cmd->nleft);
 		ide_pio_bytes(drive, cmd, write, done);
-	} else if (drive->media == ide_tape && pc->bh) {
-		done = drive->pc_io_buffers(drive, pc, bcount, write);
-	} else {
-		done = min_t(unsigned int, bcount, pc->req_xfer - pc->xferred);
-		xferfunc(drive, NULL, pc->cur_pos, done);
 	}
 
 	/* Update the current position */
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 7b21c7e..392a5bd 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -210,10 +210,12 @@ static void ide_cd_complete_failed_rq(ide_drive_t *drive, struct request *rq)
 {
 	/*
 	 * For REQ_TYPE_SENSE, "rq->special" points to the original
-	 * failed request
+	 * failed request.  Also, the sense data should be read
+	 * directly from rq which might be different from the original
+	 * sense buffer if it got copied during mapping.
 	 */
 	struct request *failed = (struct request *)rq->special;
-	struct request_sense *sense = &drive->sense_data;
+	void *sense = bio_data(rq->bio);
 
 	if (failed) {
 		if (failed->sense) {
@@ -398,7 +400,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 
 	/* if we got a CHECK_CONDITION status, queue a request sense command */
 	if (stat & ATA_ERR)
-		ide_queue_sense_rq(drive, NULL);
+		return ide_queue_sense_rq(drive, NULL) ? 2 : 1;
 	return 1;
 
 end_request:
@@ -412,8 +414,7 @@ end_request:
 
 		hwif->rq = NULL;
 
-		ide_queue_sense_rq(drive, rq);
-		return 1;
+		return ide_queue_sense_rq(drive, rq) ? 2 : 1;
 	} else
 		return 2;
 }
@@ -507,8 +508,12 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 		rq->cmd_flags |= cmd_flags;
 		rq->timeout = timeout;
 		if (buffer) {
-			rq->data = buffer;
-			rq->data_len = *bufflen;
+			error = blk_rq_map_kern(drive->queue, rq, buffer,
+						*bufflen, GFP_NOIO);
+			if (error) {
+				blk_put_request(rq);
+				return error;
+			}
 		}
 
 		error = blk_execute_rq(drive->queue, info->disk, rq, 0);
@@ -802,15 +807,10 @@ static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 	drive->dma = 0;
 
 	/* sg request */
-	if (rq->bio || ((rq->cmd_type == REQ_TYPE_ATA_PC) && rq->data_len)) {
+	if (rq->bio) {
 		struct request_queue *q = drive->queue;
+		char *buf = bio_data(rq->bio);
 		unsigned int alignment;
-		char *buf;
-
-		if (rq->bio)
-			buf = bio_data(rq->bio);
-		else
-			buf = rq->data;
 
 		drive->dma = !!(drive->dev_flags & IDE_DFLAG_USING_DMA);
 
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 9b9e8b1..3245c2d 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -481,6 +481,9 @@ void do_ide_request(struct request_queue *q)
 
 	spin_unlock_irq(q->queue_lock);
 
+	/* HLD do_request() callback might sleep, make sure it's okay */
+	might_sleep();
+
 	if (ide_lock_host(host, hwif))
 		goto plug_device_2;
 
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 8324dfa..9b762a2 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -850,6 +850,9 @@ out:
 
 	cmd.rq = rq;
 
+	ide_init_sg_cmd(&cmd, pc->req_xfer);
+	ide_map_sg(drive, &cmd);
+
 	return ide_tape_issue_pc(drive, &cmd, pc);
 }
 
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 9e67cca..1957461 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1183,7 +1183,7 @@ void ide_create_request_sense_cmd(ide_drive_t *, struct ide_atapi_pc *);
 void ide_retry_pc(ide_drive_t *drive);
 
 void ide_prep_sense(ide_drive_t *drive, struct request *rq);
-void ide_queue_sense_rq(ide_drive_t *drive, void *special);
+int ide_queue_sense_rq(ide_drive_t *drive, void *special);
 
 int ide_cd_expiry(ide_drive_t *);
 
-- 
1.6.0.2

