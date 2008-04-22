From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 06/11] ide: make ide_do_drive_cmd return rq->errors
Date: Tue, 22 Apr 2008 09:26:37 +0900
Message-ID: <1208824002-3596-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:49527 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759241AbYDVA2B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:28:01 -0400
In-Reply-To: <1208824002-3596-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

ide_do_drive_cmd forges an error value (-EIO) instead of
rq->errors. idetape_queue_rw_tail wants rq->errors so this patch makes
ide_do_drive_cmd return rq->errors.

For compatibility, this patch makes the users of ide_do_drive_cmd
return -EIO instead of a return value of ide_do_drive_cmd
(rq->errors).

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd_ioctl.c |    3 ++-
 drivers/ide/ide-floppy.c   |    4 +++-
 drivers/ide/ide-io.c       |    2 +-
 drivers/ide/ide-tape.c     |    5 ++++-
 drivers/ide/ide-taskfile.c |    7 +++++--
 drivers/ide/ide.c          |    2 ++
 6 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 9c044da..57dda1f 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -302,7 +302,8 @@ int ide_cdrom_reset(struct cdrom_device_info *cdi)
 	req.cmd_type = REQ_TYPE_SPECIAL;
 	req.cmd_flags = REQ_QUIET;
 	ret = ide_do_drive_cmd(drive, &req, ide_wait);
-
+	if (ret)
+		ret = -EIO;
 	/*
 	 * A reset will unlock the door. If it was previously locked,
 	 * lock it again.
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index d75b2aa..af6625a 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -886,13 +886,15 @@ static int idefloppy_queue_pc_tail(ide_drive_t *drive, struct ide_atapi_pc *pc)
 {
 	struct ide_floppy_obj *floppy = drive->driver_data;
 	struct request *rq;
+	int ret;
 
 	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
 	rq->buffer = (char *) pc;
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	rq->rq_disk = floppy->disk;
 
-	return ide_do_drive_cmd(drive, rq, ide_wait);
+	ret = ide_do_drive_cmd(drive, rq, ide_wait);
+	return ret ? -EIO : 0;
 }
 
 /*
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 31e5afa..ce09f70 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1667,7 +1667,7 @@ int ide_do_drive_cmd (ide_drive_t *drive, struct request *rq, ide_action_t actio
 	if (must_wait) {
 		wait_for_completion(&wait);
 		if (rq->errors)
-			err = -EIO;
+			err = rq->errors;
 
 		blk_put_request(rq);
 	}
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index f43fd07..02851b3 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1911,11 +1911,14 @@ static int __idetape_queue_pc_tail(ide_drive_t *drive, struct ide_atapi_pc *pc)
 {
 	struct ide_tape_obj *tape = drive->driver_data;
 	struct request rq;
+	int ret;
 
 	idetape_init_rq(&rq, REQ_IDETAPE_PC1);
 	rq.buffer = (char *) pc;
 	rq.rq_disk = tape->disk;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	ret = ide_do_drive_cmd(drive, &rq, ide_wait);
+	return ret ? -EIO : 0;
+
 }
 
 static void idetape_create_load_unload_cmd(ide_drive_t *drive,
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index fac7fad..6d433c4 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -531,6 +531,7 @@ static ide_startstop_t pre_task_out_intr(ide_drive_t *drive, struct request *rq)
 int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *task, u8 *buf, u16 nsect)
 {
 	struct request *rq;
+	int ret;
 
 	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
 	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
@@ -551,7 +552,8 @@ int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *task, u8 *buf, u16 nsect)
 	rq->special = task;
 	task->rq = rq;
 
-	return ide_do_drive_cmd(drive, rq, ide_wait);
+	ret = ide_do_drive_cmd(drive, rq, ide_wait);
+	return ret ? -EIO : 0;
 }
 
 EXPORT_SYMBOL(ide_raw_taskfile);
@@ -782,7 +784,8 @@ int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 		rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
 		rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 
-		return ide_do_drive_cmd(drive, rq, ide_wait);
+		err = ide_do_drive_cmd(drive, rq, ide_wait);
+		return err ? -EIO : 0;
 	}
 
 	if (copy_from_user(args, (void __user *)arg, 4))
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index c5b33f5..8970054 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -738,6 +738,8 @@ static int generic_ide_resume(struct device *dev)
 	rqpm.pm_state = PM_EVENT_ON;
 
 	err = ide_do_drive_cmd(drive, rq, ide_head_wait);
+	if (err)
+		err = -EIO;
 
 	if (err == 0 && dev->driver) {
 		ide_driver_t *drv = to_ide_driver(dev->driver);
-- 
1.5.4.2

