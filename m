From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/15] ide-atapi: convert ide-{floppy,tape} to using preallocated sense buffer
Date: Fri, 17 Apr 2009 18:33:20 +0900
Message-ID: <1239960802-31978-14-git-send-email-tj@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39996 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760156AbZDQJds (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:48 -0400
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Borislav Petkov <petkovbb@gmail.com>, Tejun Heo <tj@kernel.org>

From: Borislav Petkov <petkovbb@googlemail.com>

Since we're issuing REQ_TYPE_SENSE now we need to allow those types of
rqs in the ->do_request callbacks. As a future improvement, sense_len
assignment might be unified across all ATAPI devices. Borislav to
check with specs and test.

As a result, get rid of ide_queue_pc_head() and
drive->request_sense_rq.

tj: * Init request sense ide_atapi_pc from sense request.  In the
      longer timer, it would probably better to fold
      ide_create_request_sense_cmd() into its only current user -
      ide_floppy_get_format_progress().

    * ide_retry_pc() no longer takes @disk.

CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-atapi.c  |   48 +++++++++++++--------------------------------
 drivers/ide/ide-floppy.c |    4 ++-
 drivers/ide/ide-tape.c   |    7 ++++-
 include/linux/ide.h      |    3 +-
 4 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index c6e0348..972c522 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -80,34 +80,6 @@ void ide_init_pc(struct ide_atapi_pc *pc)
 EXPORT_SYMBOL_GPL(ide_init_pc);
 
 /*
- * Generate a new packet command request in front of the request queue, before
- * the current request, so that it will be processed immediately, on the next
- * pass through the driver.
- */
-static void ide_queue_pc_head(ide_drive_t *drive, struct gendisk *disk,
-			      struct ide_atapi_pc *pc, struct request *rq)
-{
-	blk_rq_init(NULL, rq);
-	rq->cmd_type = REQ_TYPE_SPECIAL;
-	rq->cmd_flags |= REQ_PREEMPT;
-	rq->special = (char *)pc;
-	rq->rq_disk = disk;
-
-	if (pc->req_xfer) {
-		rq->data = pc->buf;
-		rq->data_len = pc->req_xfer;
-	}
-
-	memcpy(rq->cmd, pc->c, 12);
-	if (drive->media == ide_tape)
-		rq->cmd[13] = REQ_IDETAPE_PC1;
-
-	drive->hwif->rq = NULL;
-
-	elv_add_request(drive->queue, rq, ELEVATOR_INSERT_FRONT, 0);
-}
-
-/*
  * Add a special packet command request to the tail of the request queue,
  * and wait for it to be serviced.
  */
@@ -254,18 +226,26 @@ EXPORT_SYMBOL_GPL(ide_queue_sense_rq);
 
 /*
  * Called when an error was detected during the last packet command.
- * We queue a request sense packet command in the head of the request list.
+ * We queue a request sense packet command at the head of the request
+ * queue.
  */
-void ide_retry_pc(ide_drive_t *drive, struct gendisk *disk)
+void ide_retry_pc(ide_drive_t *drive)
 {
-	struct request *rq = &drive->request_sense_rq;
+	struct request *sense_rq = &drive->sense_rq;
 	struct ide_atapi_pc *pc = &drive->request_sense_pc;
 
 	(void)ide_read_error(drive);
-	ide_create_request_sense_cmd(drive, pc);
+
+	/* init pc from sense_rq */
+	ide_init_pc(pc);
+	memcpy(pc->c, sense_rq->cmd, 12);
+	pc->buf = sense_rq->data;
+	pc->req_xfer = sense_rq->data_len;
+
 	if (drive->media == ide_tape)
 		set_bit(IDE_AFLAG_IGNORE_DSC, &drive->atapi_flags);
-	ide_queue_pc_head(drive, disk, pc, rq);
+
+	ide_queue_sense_rq(drive, pc);
 }
 EXPORT_SYMBOL_GPL(ide_retry_pc);
 
@@ -404,7 +384,7 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 			debug_log("[cmd %x]: check condition\n", rq->cmd[0]);
 
 			/* Retry operation */
-			ide_retry_pc(drive, rq->rq_disk);
+			ide_retry_pc(drive);
 
 			/* queued, but not started */
 			return ide_stopped;
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 9460033..d3302cc 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -263,7 +263,7 @@ static ide_startstop_t ide_floppy_do_request(ide_drive_t *drive,
 		}
 		pc = &floppy->queued_pc;
 		idefloppy_create_rw_cmd(drive, pc, rq, (unsigned long)block);
-	} else if (blk_special_request(rq)) {
+	} else if (blk_special_request(rq) || blk_sense_request(rq)) {
 		pc = (struct ide_atapi_pc *)rq->special;
 	} else if (blk_pc_request(rq)) {
 		pc = &floppy->queued_pc;
@@ -273,6 +273,8 @@ static ide_startstop_t ide_floppy_do_request(ide_drive_t *drive,
 		goto out_end;
 	}
 
+	ide_prep_sense(drive, rq);
+
 	memset(&cmd, 0, sizeof(cmd));
 
 	if (rq_data_dir(rq))
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index aadf53c..8324dfa 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -695,7 +695,7 @@ static ide_startstop_t idetape_media_access_finished(ide_drive_t *drive)
 				printk(KERN_ERR "ide-tape: %s: I/O error, ",
 						tape->name);
 			/* Retry operation */
-			ide_retry_pc(drive, tape->disk);
+			ide_retry_pc(drive);
 			return ide_stopped;
 		}
 		pc->error = 0;
@@ -752,7 +752,7 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 			(unsigned long long)rq->sector, rq->nr_sectors,
 			rq->current_nr_sectors);
 
-	if (!blk_special_request(rq)) {
+	if (!(blk_special_request(rq) || blk_sense_request(rq))) {
 		/* We do not support buffer cache originated requests. */
 		printk(KERN_NOTICE "ide-tape: %s: Unsupported request in "
 			"request queue (%d)\n", drive->name, rq->cmd_type);
@@ -840,6 +840,9 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 	BUG();
 
 out:
+	/* prepare sense request for this command */
+	ide_prep_sense(drive, rq);
+
 	memset(&cmd, 0, sizeof(cmd));
 
 	if (rq_data_dir(rq))
diff --git a/include/linux/ide.h b/include/linux/ide.h
index a69ccac..9e67cca 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -604,7 +604,6 @@ struct ide_drive_s {
 	unsigned long atapi_flags;
 
 	struct ide_atapi_pc request_sense_pc;
-	struct request request_sense_rq;
 
 	/* current sense rq and buffer */
 	bool sense_rq_armed;
@@ -1181,7 +1180,7 @@ int ide_do_test_unit_ready(ide_drive_t *, struct gendisk *);
 int ide_do_start_stop(ide_drive_t *, struct gendisk *, int);
 int ide_set_media_lock(ide_drive_t *, struct gendisk *, int);
 void ide_create_request_sense_cmd(ide_drive_t *, struct ide_atapi_pc *);
-void ide_retry_pc(ide_drive_t *, struct gendisk *);
+void ide_retry_pc(ide_drive_t *drive);
 
 void ide_prep_sense(ide_drive_t *drive, struct request *rq);
 void ide_queue_sense_rq(ide_drive_t *drive, void *special);
-- 
1.6.0.2

