From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 04/16] ide-scsi: use drive->pc_callback instead of pc->callback
Date: Sun, 29 Jun 2008 12:59:07 +0200
Message-ID: <1214737159-1078-5-git-send-email-petkovbb@gmail.com>
References: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:56597 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbYF2K7M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 06:59:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so564627fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 03:59:10 -0700 (PDT)
In-Reply-To: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   10 ++--------
 drivers/scsi/ide-scsi.c |    5 +++--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index c3c161a..0e8b6f5 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -30,10 +30,7 @@ ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	debug_log("Enter %s - interrupt handler\n", __func__);
 
 	if (pc->flags & PC_FLAG_TIMEDOUT) {
-		if (drive->media == ide_floppy || drive->media == ide_tape)
-			drive->pc_callback(drive);
-		else
-			pc->callback(drive);
+		drive->pc_callback(drive);
 		return ide_stopped;
 	}
 
@@ -99,10 +96,7 @@ cmd_finished:
 			return ide_stopped;
 		}
 		/* Command finished - Call the callback function */
-		if (drive->media == ide_floppy || drive->media == ide_tape)
-			drive->pc_callback(drive);
-		else
-			pc->callback(drive);
+		drive->pc_callback(drive);
 		return ide_stopped;
 	}
 
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index 683bce3..a6c2c5f 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -228,7 +228,6 @@ static int idescsi_check_condition(ide_drive_t *drive,
 	rq->cmd_type = REQ_TYPE_SENSE;
 	rq->cmd_flags |= REQ_PREEMPT;
 	pc->timeout = jiffies + WAIT_READY;
-	pc->callback = ide_scsi_callback;
 	/* NOTE! Save the failed packet command in "rq->buffer" */
 	rq->buffer = (void *) failed_cmd->special;
 	pc->scsi_cmd = ((struct ide_atapi_pc *) failed_cmd->special)->scsi_cmd;
@@ -478,6 +477,9 @@ static void idescsi_setup (ide_drive_t *drive, idescsi_scsi_t *scsi)
 #if IDESCSI_DEBUG_LOG
 	set_bit(IDESCSI_LOG_CMD, &scsi->log);
 #endif /* IDESCSI_DEBUG_LOG */
+
+	drive->pc_callback = ide_scsi_callback;
+
 	idescsi_add_settings(drive);
 }
 
@@ -630,7 +632,6 @@ static int idescsi_queue (struct scsi_cmnd *cmd,
 	pc->scsi_cmd = cmd;
 	pc->done = done;
 	pc->timeout = jiffies + cmd->timeout_per_command;
-	pc->callback = ide_scsi_callback;
 
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log)) {
 		printk ("ide-scsi: %s: que %lu, cmd = ", drive->name, cmd->serial_number);
-- 
1.5.5.4

