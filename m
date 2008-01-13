From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 6/12] ide-floppy: mv idefloppy_{should_,}report_error
Date: Sun, 13 Jan 2008 21:18:19 +0100
Message-ID: <1200255505-31418-7-git-send-email-bbpetkov@yahoo.de>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-2-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-3-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-4-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-5-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-6-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp114.plus.mail.re1.yahoo.com ([69.147.102.77]:48708 "HELO
	smtp114.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753706AbYAMUWN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 15:22:13 -0500
In-Reply-To: <1200255505-31418-6-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

In addition to shortening the function name, move the printk-call into the
function thereby saving some code lines. Also, make the function out_of_line
since it is not on a performance critical path. Finally, rename the reworked
function to ide_floppy..().

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |   38 ++++++++++++++------------------------
 1 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 5004773..f1ae9af 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -739,18 +739,20 @@ static ide_startstop_t idefloppy_transfer_pc1 (ide_drive_t *drive)
 	return ide_started;
 }
 
-/**
- * idefloppy_should_report_error()
- *
- * Supresses error messages resulting from Medium not present
- */
-static inline int idefloppy_should_report_error(idefloppy_floppy_t *floppy)
+static void ide_floppy_report_error(idefloppy_floppy_t *floppy,
+		idefloppy_pc_t *pc)
 {
+	/* supress error messages resulting from Medium not present */
 	if (floppy->sense_key == 0x02 &&
 	    floppy->asc       == 0x3a &&
 	    floppy->ascq      == 0x00)
-		return 0;
-	return 1;
+		return;
+
+	printk(KERN_ERR "ide-floppy: %s: I/O error, pc = %2x, key = %2x, "
+			"asc = %2x, ascq = %2x\n",
+			floppy->drive->name, pc->c[0], floppy->sense_key,
+			floppy->asc, floppy->ascq);
+
 }
 
 /*
@@ -777,15 +779,8 @@ static ide_startstop_t idefloppy_issue_pc (ide_drive_t *drive, idefloppy_pc_t *p
 		 *	a legitimate error code was received.
 		 */
 		if (!test_bit(PC_ABORT, &pc->flags)) {
-			if (!test_bit(PC_SUPPRESS_ERROR, &pc->flags)) {
-				if (idefloppy_should_report_error(floppy))
-					printk(KERN_ERR "ide-floppy: %s: I/O error, "
-					       "pc = %2x, key = %2x, "
-					       "asc = %2x, ascq = %2x\n",
-					       drive->name, pc->c[0],
-					       floppy->sense_key,
-					       floppy->asc, floppy->ascq);
-			}
+			if (!test_bit(PC_SUPPRESS_ERROR, &pc->flags))
+				ide_floppy_report_error(floppy, pc);
 			/* Giving up */
 			pc->error = IDEFLOPPY_ERROR_GENERAL;
 		}
@@ -995,13 +990,8 @@ static ide_startstop_t idefloppy_do_request (ide_drive_t *drive, struct request
 			rq->nr_sectors, rq->current_nr_sectors);
 
 	if (rq->errors >= ERROR_MAX) {
-		if (floppy->failed_pc != NULL) {
-			if (idefloppy_should_report_error(floppy))
-				printk(KERN_ERR "ide-floppy: %s: I/O error, pc = %2x,"
-				       " key = %2x, asc = %2x, ascq = %2x\n",
-				       drive->name, floppy->failed_pc->c[0],
-				       floppy->sense_key, floppy->asc, floppy->ascq);
-		}
+		if (floppy->failed_pc != NULL)
+			ide_floppy_report_error(floppy, floppy->failed_pc);
 		else
 			printk(KERN_ERR "ide-floppy: %s: I/O error\n",
 				drive->name);
-- 
1.5.3.7

