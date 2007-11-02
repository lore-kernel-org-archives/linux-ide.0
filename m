From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/9] ide: merge flagged_taskfile() into do_rw_taskfile()
Date: Fri, 2 Nov 2007 23:05:19 +0100
Message-ID: <200711022305.19308.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:59724 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969AbXKBWIT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:08:19 -0400
Received: by nf-out-0910.google.com with SMTP id g13so940294nfb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:08:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Based on the earlier work by Tejun Heo.

task->data_phase == TASKFILE_MULTI_{IN,OUT} vs drive->mult_count == 0
check is needed also for ide_taskfile_ioctl() requests that don't have
IDE_TFLAG_FLAGGED taskfile flag set.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c       |    3 ---
 drivers/ide/ide-taskfile.c |   32 ++++++++++++--------------------
 include/linux/ide.h        |    5 -----
 3 files changed, 12 insertions(+), 28 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -851,9 +851,6 @@ static ide_startstop_t execute_drive_cmd
 			break;
 		}
 
-		if (task->tf_flags & IDE_TFLAG_FLAGGED)
-			return flagged_taskfile(drive, task);
-
 		return do_rw_taskfile(drive, task);
 	}
 
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -156,6 +156,18 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct ide_taskfile *tf = &task->tf;
 
+	if (task->data_phase == TASKFILE_MULTI_IN ||
+	    task->data_phase == TASKFILE_MULTI_OUT) {
+		if (!drive->mult_count) {
+			printk(KERN_ERR "%s: multimode not set!\n",
+					drive->name);
+			return ide_stopped;
+		}
+	}
+
+	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+		task->tf_flags |= IDE_TFLAG_FLAGGED_SET_IN_FLAGS;
+
 	ide_tf_load(drive, task);
 
 	if (task->handler != NULL) {
@@ -838,23 +850,3 @@ int ide_task_ioctl (ide_drive_t *drive, 
 
 	return err;
 }
-
-/*
- * NOTICE: This is additions from IBM to provide a discrete interface,
- * for selective taskregister access operations.  Nice JOB Klaus!!!
- * Glad to be able to work and co-develop this with you and IBM.
- */
-ide_startstop_t flagged_taskfile (ide_drive_t *drive, ide_task_t *task)
-{
-	if (task->data_phase == TASKFILE_MULTI_IN ||
-	    task->data_phase == TASKFILE_MULTI_OUT) {
-		if (!drive->mult_count) {
-			printk(KERN_ERR "%s: multimode not set!\n", drive->name);
-			return ide_stopped;
-		}
-	}
-
-	task->tf_flags |= IDE_TFLAG_FLAGGED_SET_IN_FLAGS;
-
-	return do_rw_taskfile(drive, task);
-}
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -979,11 +979,6 @@ void ide_pktcmd_tf_load(ide_drive_t *, u
  */
 extern ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
 
-/*
- * Special Flagged Register Validation Caller
- */
-extern ide_startstop_t flagged_taskfile(ide_drive_t *, ide_task_t *);
-
 extern ide_startstop_t set_multmode_intr(ide_drive_t *);
 extern ide_startstop_t set_geometry_intr(ide_drive_t *);
 extern ide_startstop_t recal_intr(ide_drive_t *);
