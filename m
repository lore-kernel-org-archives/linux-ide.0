From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/15] ide-cd: convert to using generic sense request
Date: Fri, 17 Apr 2009 18:33:19 +0900
Message-ID: <1239960802-31978-13-git-send-email-tj@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39995 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759984AbZDQJds (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:48 -0400
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Borislav Petkov <petkovbb@gmail.com>, Tejun Heo <tj@kernel.org>

From: Borislav Petkov <petkovbb@googlemail.com>

Preallocate a sense request in the ->do_request method and reinitialize
it only on demand, in case it's been consumed in the IRQ handler path.
The reason for this is that we don't want to be mapping rq to bio in
the IRQ path and introduce all kinds of unnecessary hacks to the block
layer.

tj: * Both user and kernel PC requests expect sense data to be stored
      in separate storage other than drive->sense_data.  Copy sense
      data to rq->sense on completion if rq->sense is not NULL.  This
      fixes bogus sense data on PC requests.

As a result, remove cdrom_queue_request_sense.

CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-cd.c |   54 +++++++++++--------------------------------------
 drivers/ide/ide-cd.h |    4 ---
 2 files changed, 12 insertions(+), 46 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index eb3c299..7b21c7e 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -206,44 +206,6 @@ static void cdrom_analyze_sense_data(ide_drive_t *drive,
 	ide_cd_log_error(drive->name, failed_command, sense);
 }
 
-static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
-				      struct request *failed_command)
-{
-	struct cdrom_info *info		= drive->driver_data;
-	struct request *rq		= &drive->request_sense_rq;
-
-	ide_debug_log(IDE_DBG_SENSE, "enter");
-
-	if (sense == NULL)
-		sense = &info->sense_data;
-
-	memset(sense, 0, 18);
-
-	/* stuff the sense request in front of our current request */
-	blk_rq_init(NULL, rq);
-	rq->cmd_type = REQ_TYPE_ATA_PC;
-	rq->rq_disk = info->disk;
-
-	rq->data = sense;
-	rq->cmd[0] = GPCMD_REQUEST_SENSE;
-	rq->cmd[4] = 18;
-	rq->data_len = 18;
-
-	rq->cmd_type = REQ_TYPE_SENSE;
-	rq->cmd_flags |= REQ_PREEMPT;
-
-	/* NOTE! Save the failed command in "rq->special" */
-	rq->special = (void *)failed_command;
-
-	if (failed_command)
-		ide_debug_log(IDE_DBG_SENSE, "failed_cmd: 0x%x",
-					     failed_command->cmd[0]);
-
-	drive->hwif->rq = NULL;
-
-	elv_add_request(drive->queue, rq, ELEVATOR_INSERT_FRONT, 0);
-}
-
 static void ide_cd_complete_failed_rq(ide_drive_t *drive, struct request *rq)
 {
 	/*
@@ -251,11 +213,16 @@ static void ide_cd_complete_failed_rq(ide_drive_t *drive, struct request *rq)
 	 * failed request
 	 */
 	struct request *failed = (struct request *)rq->special;
-	struct cdrom_info *info = drive->driver_data;
-	void *sense = &info->sense_data;
+	struct request_sense *sense = &drive->sense_data;
 
 	if (failed) {
 		if (failed->sense) {
+			/*
+			 * Sense is always read into drive->sense_data.
+			 * Copy back if the failed request has its
+			 * sense pointer set.
+			 */
+			memcpy(failed->sense, sense, 18);
 			sense = failed->sense;
 			failed->sense_len = rq->sense_len;
 		}
@@ -431,7 +398,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 
 	/* if we got a CHECK_CONDITION status, queue a request sense command */
 	if (stat & ATA_ERR)
-		cdrom_queue_request_sense(drive, NULL, NULL);
+		ide_queue_sense_rq(drive, NULL);
 	return 1;
 
 end_request:
@@ -445,7 +412,7 @@ end_request:
 
 		hwif->rq = NULL;
 
-		cdrom_queue_request_sense(drive, rq->sense, rq);
+		ide_queue_sense_rq(drive, rq);
 		return 1;
 	} else
 		return 2;
@@ -893,6 +860,9 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 		goto out_end;
 	}
 
+	/* prepare sense request for this command */
+	ide_prep_sense(drive, rq);
+
 	memset(&cmd, 0, sizeof(cmd));
 
 	if (rq_data_dir(rq))
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index 1d97101..93a3cf1 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -87,10 +87,6 @@ struct cdrom_info {
 
 	struct atapi_toc *toc;
 
-	/* The result of the last successful request sense command
-	   on this device. */
-	struct request_sense sense_data;
-
 	u8 max_speed;		/* Max speed of the drive. */
 	u8 current_speed;	/* Current speed of the drive. */
 
-- 
1.6.0.2

