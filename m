From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/10] ide-atapi,tape,floppy: allow ->pc_callback() to change rq->data_len
Date: Sun, 19 Apr 2009 08:58:34 +0900
Message-ID: <1240099122-18381-3-git-send-email-tj@kernel.org>
References: <1240099122-18381-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57789 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330AbZDRX7C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Apr 2009 19:59:02 -0400
In-Reply-To: <1240099122-18381-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <jens.axboe@oracle.com>

Impact: allow residual count implementation in ->pc_callback()

rq->data_len has two duties - carrying the number of input bytes on
issue and carrying residual count back to the issuer on completion.
ide-atapi completion callback ->pc_callback() is the right place to do
this but currently ide-atapi depends on rq->data_len carrying the
original request size after calling ->pc_callback() to complete the pc
request.

This patch makes ide_pc_intr(), ide_tape_issue_pc() and
ide_floppy_issue_pc() cache length to complete before calling
->pc_callback() so that it can modify rq->data_len as necessary.

Note: As using rq->data_len for two purposes can make cases like this
      incorrect in subtle ways, future changes will introduce separate
      field for residual count.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>
---
 drivers/ide/ide-atapi.c  |   16 ++++++++++------
 drivers/ide/ide-floppy.c |    5 ++++-
 drivers/ide/ide-tape.c   |    5 ++++-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 5cefe12..3df5442 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -409,6 +409,16 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 		if ((pc->flags & PC_FLAG_WAIT_FOR_DSC) && (stat & ATA_DSC) == 0)
 			dsc = 1;
 
+		/*
+		 * ->pc_callback() might change rq->data_len for
+		 * residual count, cache total length.
+		 */
+		if (!blk_special_request(rq) &&
+		    (drive->media == ide_tape && !rq->bio))
+			done = ide_rq_bytes(rq);        /* FIXME */
+		else
+			done = blk_rq_bytes(rq);
+
 		/* Command finished - Call the callback function */
 		uptodate = drive->pc_callback(drive, dsc);
 
@@ -417,7 +427,6 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 
 		if (blk_special_request(rq)) {
 			rq->errors = 0;
-			done = blk_rq_bytes(rq);
 			error = 0;
 		} else {
 
@@ -426,11 +435,6 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 					rq->errors = -EIO;
 			}
 
-			if (drive->media == ide_tape && !rq->bio)
-				done = ide_rq_bytes(rq); /* FIXME */
-			else
-				done = blk_rq_bytes(rq);
-
 			error = uptodate ? 0 : -EIO;
 		}
 
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index d20704a..537b7c5 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -134,14 +134,17 @@ static ide_startstop_t ide_floppy_issue_pc(ide_drive_t *drive,
 	drive->pc = pc;
 
 	if (pc->retries > IDEFLOPPY_MAX_PC_RETRIES) {
+		unsigned int done = blk_rq_bytes(drive->hwif->rq);
+
 		if (!(pc->flags & PC_FLAG_SUPPRESS_ERROR))
 			ide_floppy_report_error(floppy, pc);
+
 		/* Giving up */
 		pc->error = IDE_DRV_ERROR_GENERAL;
 
 		drive->failed_pc = NULL;
 		drive->pc_callback(drive, 0);
-		ide_complete_rq(drive, -EIO, blk_rq_bytes(drive->hwif->rq));
+		ide_complete_rq(drive, -EIO, done);
 		return ide_stopped;
 	}
 
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 2b9a136..8226d52 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -622,6 +622,8 @@ static ide_startstop_t ide_tape_issue_pc(ide_drive_t *drive,
 
 	if (pc->retries > IDETAPE_MAX_PC_RETRIES ||
 		(pc->flags & PC_FLAG_ABORT)) {
+		unsigned int done = blk_rq_bytes(drive->hwif->rq);
+
 		/*
 		 * We will "abort" retrying a packet command in case legitimate
 		 * error code was received (crossing a filemark, or end of the
@@ -641,9 +643,10 @@ static ide_startstop_t ide_tape_issue_pc(ide_drive_t *drive,
 			/* Giving up */
 			pc->error = IDE_DRV_ERROR_GENERAL;
 		}
+
 		drive->failed_pc = NULL;
 		drive->pc_callback(drive, 0);
-		ide_complete_rq(drive, -EIO, blk_rq_bytes(drive->hwif->rq));
+		ide_complete_rq(drive, -EIO, done);
 		return ide_stopped;
 	}
 	debug_log(DBG_SENSE, "Retry #%d, cmd = %02X\n", pc->retries, pc->c[0]);
-- 
1.6.0.2

