From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 2/2] ide: remove action argument in ide_do_drive_cmd
Date: Thu, 15 May 2008 09:05:58 +0900
Message-ID: <1210809958-13881-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1210809958-13881-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1210809958-13881-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:55534 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759889AbYEOAGY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 20:06:24 -0400
In-Reply-To: <1210809958-13881-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

ide_do_drive_cmd is called only with ide_preempt action argument. So
we can remove the action argument in ide_do_drive_cmd and ide_action_t
typedef.

This patch also includes two minor cleanups: 1) ide_do_drive_cmd
always succeeds so we don't need the return value; 2) the callers use
blk_rq_init before ide_do_drive_cmd so there is no need to initialize
rq->errors.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c     |    2 +-
 drivers/ide/ide-floppy.c |    2 +-
 drivers/ide/ide-io.c     |   37 +++++++++----------------------------
 drivers/ide/ide-tape.c   |    2 +-
 drivers/scsi/ide-scsi.c  |    3 ++-
 include/linux/ide.h      |   12 +-----------
 6 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 0fbc2d8..043129c 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -213,7 +213,7 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
 	/* NOTE! Save the failed command in "rq->buffer" */
 	rq->buffer = (void *) failed_command;
 
-	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
+	ide_do_drive_cmd(drive, rq);
 }
 
 static void cdrom_end_request(ide_drive_t *drive, int uptodate)
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 1852008..53209a4 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -291,7 +291,7 @@ static void idefloppy_queue_pc_head(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	rq->cmd_flags |= REQ_PREEMPT;
 	rq->rq_disk = floppy->disk;
-	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
+	ide_do_drive_cmd(drive, rq);
 }
 
 static struct ide_atapi_pc *idefloppy_next_pc_storage(ide_drive_t *drive)
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 7627c46..2805774 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1520,46 +1520,27 @@ irqreturn_t ide_intr (int irq, void *dev_id)
  *	ide_do_drive_cmd	-	issue IDE special command
  *	@drive: device to issue command
  *	@rq: request to issue
- *	@action: action for processing
  *
  *	This function issues a special IDE device request
  *	onto the request queue.
  *
- *	If action is ide_wait, then the rq is queued at the end of the
- *	request queue, and the function sleeps until it has been processed.
- *	This is for use when invoked from an ioctl handler.
- *
- *	If action is ide_preempt, then the rq is queued at the head of
- *	the request queue, displacing the currently-being-processed
- *	request and this function returns immediately without waiting
- *	for the new rq to be completed.  This is VERY DANGEROUS, and is
- *	intended for careful use by the ATAPI tape/cdrom driver code.
- *
- *	If action is ide_end, then the rq is queued at the end of the
- *	request queue, and the function returns immediately without waiting
- *	for the new rq to be completed. This is again intended for careful
- *	use by the ATAPI tape/cdrom driver code.
+ *	the rq is queued at the head of the request queue, displacing
+ *	the currently-being-processed request and this function
+ *	returns immediately without waiting for the new rq to be
+ *	completed.  This is VERY DANGEROUS, and is intended for
+ *	careful use by the ATAPI tape/cdrom driver code.
  */
- 
-int ide_do_drive_cmd (ide_drive_t *drive, struct request *rq, ide_action_t action)
+
+void ide_do_drive_cmd(ide_drive_t *drive, struct request *rq)
 {
 	unsigned long flags;
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	int where = ELEVATOR_INSERT_BACK;
-
-	rq->errors = 0;
-
-	if (action == ide_preempt)
-		where = ELEVATOR_INSERT_FRONT;
 
 	spin_lock_irqsave(&ide_lock, flags);
-	if (action == ide_preempt)
-		hwgroup->rq = NULL;
-	__elv_add_request(drive->queue, rq, where, 1);
+	hwgroup->rq = NULL;
+	__elv_add_request(drive->queue, rq, ELEVATOR_INSERT_FRONT, 1);
 	__generic_unplug_device(drive->queue);
 	spin_unlock_irqrestore(&ide_lock, flags);
-
-	return 0;
 }
 
 EXPORT_SYMBOL(ide_do_drive_cmd);
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index cc7991c..a562df8 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -691,7 +691,7 @@ static void idetape_queue_pc_head(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	rq->cmd_flags |= REQ_PREEMPT;
 	rq->buffer = (char *) pc;
 	rq->rq_disk = tape->disk;
-	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
+	ide_do_drive_cmd(drive, rq);
 }
 
 /*
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index 58e30ef..569ffde 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -245,7 +245,8 @@ static int idescsi_check_condition(ide_drive_t *drive,
 		ide_scsi_hex_dump(pc->c, 6);
 	}
 	rq->rq_disk = scsi->disk;
-	return ide_do_drive_cmd(drive, rq, ide_preempt);
+	ide_do_drive_cmd(drive, rq);
+	return 0;
 }
 
 static int idescsi_end_request(ide_drive_t *, int, int);
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 27babdf..5f08902 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -836,17 +836,7 @@ int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned long);
 
 extern ide_startstop_t ide_do_reset (ide_drive_t *);
 
-/*
- * "action" parameter type for ide_do_drive_cmd() below.
- */
-typedef enum {
-	ide_wait,	/* insert rq at end of list, and wait for it */
-	ide_preempt,	/* insert rq in front of current request */
-	ide_head_wait,	/* insert rq in front of current request and wait for it */
-	ide_end		/* insert rq at end of list, but don't wait for it */
-} ide_action_t;
-
-extern int ide_do_drive_cmd(ide_drive_t *, struct request *, ide_action_t);
+extern void ide_do_drive_cmd(ide_drive_t *, struct request *);
 
 extern void ide_end_drive_cmd(ide_drive_t *, u8, u8);
 
-- 
1.5.4.2

