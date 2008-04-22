From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 01/11] ide: use blk_get_request in the ide_do_drive_cmd path using ide_wait
Date: Tue, 22 Apr 2008 09:26:32 +0900
Message-ID: <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:49522 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759185AbYDVA17 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:27:59 -0400
In-Reply-To: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This replaces struct request on the stack with blk_get_request in the
ide_do_drive_cmd path using ide_wait.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 917c72d..c5b33f5 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -626,7 +626,8 @@ out:
 
 int set_pio_mode(ide_drive_t *drive, int arg)
 {
-	struct request rq;
+	struct request *rq;
+
 
 	if (arg < 0 || arg > 255)
 		return -EINVAL;
@@ -637,12 +638,12 @@ int set_pio_mode(ide_drive_t *drive, int arg)
 	if (drive->special.b.set_tune)
 		return -EBUSY;
 
-	ide_init_drive_cmd(&rq);
-	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 
 	drive->tune_req = (u8) arg;
 	drive->special.b.set_tune = 1;
-	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
+	ide_do_drive_cmd(drive, rq, ide_wait);
 	return 0;
 }
 
@@ -680,7 +681,7 @@ static int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 {
 	ide_drive_t *drive = dev->driver_data;
 	ide_hwif_t *hwif = HWIF(drive);
-	struct request rq;
+	struct request *rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
 	int ret;
@@ -689,18 +690,18 @@ static int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 	if (!(drive->dn % 2))
 		ide_acpi_get_timing(hwif);
 
-	memset(&rq, 0, sizeof(rq));
 	memset(&rqpm, 0, sizeof(rqpm));
 	memset(&args, 0, sizeof(args));
-	rq.cmd_type = REQ_TYPE_PM_SUSPEND;
-	rq.special = &args;
-	rq.data = &rqpm;
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_PM_SUSPEND;
+	rq->special = &args;
+	rq->data = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
 	if (mesg.event == PM_EVENT_PRETHAW)
 		mesg.event = PM_EVENT_FREEZE;
 	rqpm.pm_state = mesg.event;
 
-	ret = ide_do_drive_cmd(drive, &rq, ide_wait);
+	ret = ide_do_drive_cmd(drive, rq, ide_wait);
 	/* only call ACPI _PS3 after both drivers are suspended */
 	if (!ret && (((drive->dn % 2) && hwif->drives[0].present
 		 && hwif->drives[1].present)
@@ -714,7 +715,7 @@ static int generic_ide_resume(struct device *dev)
 {
 	ide_drive_t *drive = dev->driver_data;
 	ide_hwif_t *hwif = HWIF(drive);
-	struct request rq;
+	struct request *rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
 	int err;
@@ -727,16 +728,16 @@ static int generic_ide_resume(struct device *dev)
 
 	ide_acpi_exec_tfs(drive);
 
-	memset(&rq, 0, sizeof(rq));
 	memset(&rqpm, 0, sizeof(rqpm));
 	memset(&args, 0, sizeof(args));
-	rq.cmd_type = REQ_TYPE_PM_RESUME;
-	rq.special = &args;
-	rq.data = &rqpm;
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_PM_RESUME;
+	rq->special = &args;
+	rq->data = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_resume;
 	rqpm.pm_state = PM_EVENT_ON;
 
-	err = ide_do_drive_cmd(drive, &rq, ide_head_wait);
+	err = ide_do_drive_cmd(drive, rq, ide_head_wait);
 
 	if (err == 0 && dev->driver) {
 		ide_driver_t *drv = to_ide_driver(dev->driver);
-- 
1.5.4.2

