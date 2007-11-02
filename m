From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/9] ide: convert do_rw_taskfile() to use ->data_phase
Date: Fri, 2 Nov 2007 23:05:27 +0100
Message-ID: <200711022305.27131.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:61145 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbXKBWIU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:08:20 -0400
Received: by nf-out-0910.google.com with SMTP id g13so940287nfb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:08:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Use task->data_phase in do_rw_taskfile() to decide what to do.

* task->prehandler is only used by TASKFILE[_MULTI]_OUT so just
  use pre_task_out_intr() directly and remove no longer needed
  'prehandler' field from ide_task_t.

* Remove no longer needed ide_pre_handler_t type.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   25 +++++++++++++------------
 include/linux/ide.h        |    2 --
 2 files changed, 13 insertions(+), 14 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -170,23 +170,25 @@ ide_startstop_t do_rw_taskfile (ide_driv
 
 	ide_tf_load(drive, task);
 
-	if (task->handler != NULL) {
-		if (task->prehandler != NULL) {
-			hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
-			ndelay(400);	/* FIXME */
-			return task->prehandler(drive, task->rq);
-		}
+	switch (task->data_phase) {
+	case TASKFILE_MULTI_OUT:
+	case TASKFILE_OUT:
+		hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
+		ndelay(400);	/* FIXME */
+		return pre_task_out_intr(drive, task->rq);
+	case TASKFILE_MULTI_IN:
+	case TASKFILE_IN:
+	case TASKFILE_NO_DATA:
 		ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCASE, NULL);
 		return ide_started;
-	}
-
-	if (task_dma_ok(task) && drive->using_dma && !hwif->dma_setup(drive)) {
+	default:
+		if (task_dma_ok(task) == 0 || drive->using_dma == 0 ||
+		    hwif->dma_setup(drive))
+			return ide_stopped;
 		hwif->dma_exec_cmd(drive, tf->command);
 		hwif->dma_start(drive);
 		return ide_started;
 	}
-
-	return ide_stopped;
 }
 
 /*
@@ -665,7 +667,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 			}
 			/* fall through */
 		case TASKFILE_OUT:
-			args.prehandler = &pre_task_out_intr;
 			args.handler = &task_out_intr;
 			/* fall through */
 		case TASKFILE_OUT_DMAQ:
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -626,7 +626,6 @@ typedef struct hwif_s {
 /*
  *  internal ide interrupt handler type
  */
-typedef ide_startstop_t (ide_pre_handler_t)(ide_drive_t *, struct request *);
 typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
 typedef int (ide_expiry_t)(ide_drive_t *);
 
@@ -957,7 +956,6 @@ typedef struct ide_task_s {
 	};
 	u32			tf_flags;
 	int			data_phase;
-	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
 	struct request		*rq;		/* copy of request */
 	void			*special;	/* valid_t generally */
