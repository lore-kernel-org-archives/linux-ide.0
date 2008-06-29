From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 03/16] ide-tape: use drive->pc_callback instead of pc->callback
Date: Sun, 29 Jun 2008 12:59:06 +0200
Message-ID: <1214737159-1078-4-git-send-email-petkovbb@gmail.com>
References: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:56648 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbYF2K7M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 06:59:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so564620fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 03:59:10 -0700 (PDT)
In-Reply-To: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

The if-else block in the IRQ handler is only temporary so that bisect searches
don't break and it'll be removed after converting the remainder of the drivers.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |    4 ++--
 drivers/ide/ide-tape.c  |    7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 411443e..c3c161a 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -30,7 +30,7 @@ ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	debug_log("Enter %s - interrupt handler\n", __func__);
 
 	if (pc->flags & PC_FLAG_TIMEDOUT) {
-		if (drive->media == ide_floppy)
+		if (drive->media == ide_floppy || drive->media == ide_tape)
 			drive->pc_callback(drive);
 		else
 			pc->callback(drive);
@@ -99,7 +99,7 @@ cmd_finished:
 			return ide_stopped;
 		}
 		/* Command finished - Call the callback function */
-		if (drive->media == ide_floppy)
+		if (drive->media == ide_floppy || drive->media == ide_tape)
 			drive->pc_callback(drive);
 		else
 			pc->callback(drive);
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 6e1233b..b9179ee 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -690,7 +690,6 @@ static void idetape_init_pc(struct ide_atapi_pc *pc)
 	pc->buf_size = IDETAPE_PC_BUFFER_SIZE;
 	pc->bh = NULL;
 	pc->b_data = NULL;
-	pc->callback = ide_tape_callback;
 }
 
 static void idetape_create_request_sense_cmd(struct ide_atapi_pc *pc)
@@ -887,7 +886,7 @@ static ide_startstop_t idetape_issue_pc(ide_drive_t *drive,
 			pc->error = IDETAPE_ERROR_GENERAL;
 		}
 		tape->failed_pc = NULL;
-		pc->callback(drive);
+		drive->pc_callback(drive);
 		return ide_stopped;
 	}
 	debug_log(DBG_SENSE, "Retry #%d, cmd = %02X\n", pc->retries, pc->c[0]);
@@ -948,7 +947,7 @@ static ide_startstop_t idetape_media_access_finished(ide_drive_t *drive)
 		pc->error = IDETAPE_ERROR_GENERAL;
 		tape->failed_pc = NULL;
 	}
-	pc->callback(drive);
+	drive->pc_callback(drive);
 	return ide_stopped;
 }
 
@@ -2459,6 +2458,8 @@ static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
 	u8 gcw[2];
 	u16 *ctl = (u16 *)&tape->caps[12];
 
+	drive->pc_callback = ide_tape_callback;
+
 	spin_lock_init(&tape->lock);
 	drive->dsc_overlap = 1;
 	if (drive->hwif->host_flags & IDE_HFLAG_NO_DSC) {
-- 
1.5.5.4

