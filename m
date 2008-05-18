From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 32/40] ide-{floppy,tape}: move checking of ->failed_pc to ->callback
Date: Sun, 18 May 2008 20:59:15 +0200
Message-ID: <20080518185915.5636.13511.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:52155 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757916AbYERSlu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:41:50 -0400
Received: by ug-out-1314.google.com with SMTP id h2so323068ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:41:50 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Move checking/resetting of ->failed_pc from ide*_pc_intr() to ->callback
as a preparation for adding generic ide_pc_intr() helper.

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>---
---
 drivers/ide/ide-floppy.c |    5 +++--
 drivers/ide/ide-tape.c   |    7 +++----
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -320,6 +320,9 @@ static void ide_floppy_callback(ide_driv
 
 	debug_log("Reached %s\n", __func__);
 
+	if (floppy->failed_pc == pc)
+		floppy->failed_pc = NULL;
+
 	if (pc->c[0] == GPCMD_READ_10 || pc->c[0] == GPCMD_WRITE_10 ||
 	    (pc->rq && blk_pc_request(pc->rq)))
 		uptodate = 1; /* FIXME */
@@ -435,8 +438,6 @@ static ide_startstop_t idefloppy_pc_intr
 			return ide_stopped;
 		}
 		pc->error = 0;
-		if (floppy->failed_pc == pc)
-			floppy->failed_pc = NULL;
 		/* Command finished - Call the callback function */
 		pc->callback(drive);
 		return ide_stopped;
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -627,6 +627,9 @@ static void ide_tape_callback(ide_drive_
 
 	debug_log(DBG_PROCS, "Enter %s\n", __func__);
 
+	if (tape->failed_pc == pc)
+		tape->failed_pc = NULL;
+
 	if (pc->c[0] == REQUEST_SENSE) {
 		if (uptodate)
 			idetape_analyze_error(drive, pc->buf);
@@ -838,8 +841,6 @@ static ide_startstop_t idetape_pc_intr(i
 			idetape_postpone_request(drive);
 			return ide_stopped;
 		}
-		if (tape->failed_pc == pc)
-			tape->failed_pc = NULL;
 		/* Command finished - Call the callback function */
 		pc->callback(drive);
 		return ide_stopped;
@@ -1050,8 +1051,6 @@ static ide_startstop_t idetape_media_acc
 			return ide_stopped;
 		}
 		pc->error = 0;
-		if (tape->failed_pc == pc)
-			tape->failed_pc = NULL;
 	} else {
 		pc->error = IDETAPE_ERROR_GENERAL;
 		tape->failed_pc = NULL;
