From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 03/18] ide-cd: cdrom_decode_status: factor out block pc
	error handling code
Date: Fri, 15 Aug 2008 09:34:57 +0200
Message-ID: <20080815073457.GB9906@gollum.tnic>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com> <1213252870-20474-4-git-send-email-petkovbb@gmail.com> <200806141929.21329.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:45809 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbYHOHey (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Aug 2008 03:34:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so700429fgg.17
        for <linux-ide@vger.kernel.org>; Fri, 15 Aug 2008 00:34:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200806141929.21329.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: Borislav Petkov <petkovbb@gmail.com>
Date: Mon, 11 Aug 2008 07:55:27 +0200
Subject: [PATCH 2/2] ide-cd: unify error handling in cdrom_decode_status()

There should be no difference in handling rw commands
based on the type of the request (pc|rq) they came on. As
a nice side effect, this makes the code more readable.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |  123 +++++++++++++++++++++++++++-----------------------
 1 files changed, 66 insertions(+), 57 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index f2c12be..ae53a74 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -311,8 +311,13 @@ static int cdrom_decode_status(ide_drive_t *drive, int stat)
 		ide_error(drive, "request sense failure", stat);
 		return 1;
 
-	} else if (blk_pc_request(rq) || rq->cmd_type == REQ_TYPE_ATA_PC) {
-		/* All other functions, except for READ. */
+	} else if (blk_pc_request(rq) || blk_fs_request(rq) ||
+		   rq->cmd_type == REQ_TYPE_ATA_PC) {
+
+		int do_end_request = 0;
+
+		if (blk_noretry_request(rq))
+			do_end_request = 1;
 
 		/*
 		 * if we have an error, pass back CHECK_CONDITION as the
@@ -321,45 +326,8 @@ static int cdrom_decode_status(ide_drive_t *drive, int stat)
 		if (blk_pc_request(rq) && !rq->errors)
 			rq->errors = SAM_STAT_CHECK_CONDITION;
 
-		/* check for tray open */
-		if (sense_key == NOT_READY) {
-			cdrom_saw_media_change(drive);
-		} else if (sense_key == UNIT_ATTENTION) {
-			/* check for media change */
-			cdrom_saw_media_change(drive);
-			return 0;
-		} else if (sense_key == ILLEGAL_REQUEST &&
-			   rq->cmd[0] == GPCMD_START_STOP_UNIT) {
-			/*
-			 * Don't print error message for this condition--
-			 * SFF8090i indicates that 5/24/00 is the correct
-			 * response to a request to close the tray if the
-			 * drive doesn't have that capability.
-			 * cdrom_log_sense() knows this!
-			 */
-		} else if (!(rq->cmd_flags & REQ_QUIET)) {
-			/* otherwise, print an error */
-			ide_dump_status(drive, "packet command error", stat);
-		}
-
-		rq->cmd_flags |= REQ_FAILED;
-
-		/*
-		 * instead of playing games with moving completions around,
-		 * remove failed request completely and end it when the
-		 * request sense has completed
-		 */
-		goto end_request;
-
-	} else if (blk_fs_request(rq)) {
-		int do_end_request = 0;
-
-		/* handle errors from READ and WRITE requests */
-
-		if (blk_noretry_request(rq))
-			do_end_request = 1;
-
-		if (sense_key == NOT_READY) {
+		switch (sense_key) {
+		case NOT_READY:
 			/* tray open */
 			if (rq_data_dir(rq) == READ) {
 				cdrom_saw_media_change(drive);
@@ -395,8 +363,9 @@ static int cdrom_decode_status(ide_drive_t *drive, int stat)
 					return 1;
 				}
 			}
-		} else if (sense_key == UNIT_ATTENTION) {
-			/* media change */
+			break;
+
+		case UNIT_ATTENTION:
 			cdrom_saw_media_change(drive);
 
 			/*
@@ -405,15 +374,33 @@ static int cdrom_decode_status(ide_drive_t *drive, int stat)
 			 */
 			if (++rq->errors > ERROR_MAX)
 				do_end_request = 1;
-		} else if (sense_key == ILLEGAL_REQUEST ||
-			   sense_key == DATA_PROTECT) {
-			/*
-			 * No point in retrying after an illegal request or data
-			 * protect error.
-			 */
-			ide_dump_status_no_sense(drive, "command error", stat);
-			do_end_request = 1;
-		} else if (sense_key == MEDIUM_ERROR) {
+			else
+				return 0;
+			break;
+
+		case ILLEGAL_REQUEST:
+		case DATA_PROTECT:
+
+			if (rq->cmd[0] == GPCMD_START_STOP_UNIT) {
+				/*
+				 * Don't print error message for this condition-
+				 * SFF8090i indicates that 5/24/00 is the
+				 * correct response to a request to close the
+				 * tray if the drive doesn't have that
+				 * capability. cdrom_log_sense() knows this!
+				 */
+			} else {
+				/*
+				 * No point in retrying after an illegal req.
+				 * or data protect error.
+				 */
+				ide_dump_status_no_sense(drive, "command error",
+							 stat);
+				do_end_request = 1;
+			}
+			break;
+
+		case MEDIUM_ERROR:
 			/*
 			 * No point in re-trying a zillion times on a bad
 			 * sector. If we got here the error is not correctable.
@@ -422,20 +409,41 @@ static int cdrom_decode_status(ide_drive_t *drive, int stat)
 						 "media error (bad sector)",
 						 stat);
 			do_end_request = 1;
-		} else if (sense_key == BLANK_CHECK) {
+			break;
+
+		case BLANK_CHECK:
 			/* disk appears blank ?? */
 			ide_dump_status_no_sense(drive, "media error (blank)",
 						 stat);
 			do_end_request = 1;
-		} else if ((err & ~ATA_ABORTED) != 0) {
+			break;
+
+		default:
+			ide_error(drive, "bad sense", stat);
+			break;
+		}
+
+		if (!(rq->cmd_flags & REQ_QUIET)) {
+			/* print an error */
+			ide_dump_status(drive, (blk_fs_request(rq)) ?
+						"fs request error" :
+						"packet command error", stat);
+		}
+
+		if ((err & ~ATA_ABORTED) != 0) {
 			/* go to the default handler for other errors */
 			ide_error(drive, "cdrom_decode_status", stat);
 			return 1;
-		} else if ((++rq->errors > ERROR_MAX)) {
+
+		}
+
+		if ((++rq->errors > ERROR_MAX)) {
 			/* we've racked up too many retries, abort */
 			do_end_request = 1;
 		}
 
+		rq->cmd_flags |= REQ_FAILED;
+
 		/*
 		 * End a request through request sense analysis when we have
 		 * sense data. We need this in order to perform end of media
@@ -445,11 +453,12 @@ static int cdrom_decode_status(ide_drive_t *drive, int stat)
 			goto end_request;
 
 		/*
-		 * If we got a CHECK_CONDITION status, queue
-		 * a request sense command.
+		 * If we got a CHECK_CONDITION status, queue a request sense
+		 * command.
 		 */
 		if (stat & ATA_ERR)
 			cdrom_queue_request_sense(drive, NULL, NULL);
+
 	} else {
 		blk_dump_rq_flags(rq, "ide-cd: bad rq");
 		cdrom_end_request(drive, 0);
-- 
1.5.5.4

-- 
Regards/Gruss,
    Boris.
