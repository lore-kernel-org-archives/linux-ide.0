From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 07/13] ide: convert ide_do_drive_cmd path to use blk_execute_rq
Date: Thu,  1 May 2008 21:28:04 +0900
Message-ID: <1209644890-12040-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:42767 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755027AbYEAM36 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:58 -0400
In-Reply-To: <1209644890-12040-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, petkovbb@gmail.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

This converts the ide_do_drive_cmd path using ide_wait to use
blk_execute_rq.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index c758dcb..25e110e 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -498,7 +498,7 @@ out:
 
 int set_pio_mode(ide_drive_t *drive, int arg)
 {
-	struct request rq;
+	struct request *rq;
 	ide_hwif_t *hwif = drive->hwif;
 	const struct ide_port_ops *port_ops = hwif->port_ops;
 
@@ -512,12 +512,15 @@ int set_pio_mode(ide_drive_t *drive, int arg)
 	if (drive->special.b.set_tune)
 		return -EBUSY;
 
-	ide_init_drive_cmd(&rq);
-	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 
 	drive->tune_req = (u8) arg;
 	drive->special.b.set_tune = 1;
-	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
+
+	blk_execute_rq(drive->queue, NULL, rq, 0);
+	blk_put_request(rq);
+
 	return 0;
 }
 
@@ -555,7 +558,7 @@ static int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 {
 	ide_drive_t *drive = dev->driver_data;
 	ide_hwif_t *hwif = HWIF(drive);
-	struct request rq;
+	struct request *rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
 	int ret;
@@ -564,18 +567,19 @@ static int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 	if (!(drive->dn % 2))
 		ide_acpi_get_timing(hwif);
 
-	blk_rq_init(NULL, &rq);
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
+	ret = blk_execute_rq(drive->queue, NULL, rq, 0);
+	blk_put_request(rq);
 	/* only call ACPI _PS3 after both drivers are suspended */
 	if (!ret && (((drive->dn % 2) && hwif->drives[0].present
 		 && hwif->drives[1].present)
@@ -589,7 +593,7 @@ static int generic_ide_resume(struct device *dev)
 {
 	ide_drive_t *drive = dev->driver_data;
 	ide_hwif_t *hwif = HWIF(drive);
-	struct request rq;
+	struct request *rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
 	int err;
@@ -602,16 +606,18 @@ static int generic_ide_resume(struct device *dev)
 
 	ide_acpi_exec_tfs(drive);
 
-	blk_rq_init(NULL, &rq);
 	memset(&rqpm, 0, sizeof(rqpm));
 	memset(&args, 0, sizeof(args));
-	rq.cmd_type = REQ_TYPE_PM_RESUME;
-	rq.special = &args;
-	rq.data = &rqpm;
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_PM_RESUME;
+	rq->special = &args;
+	rq->data = &rqpm;
+	rq->cmd_flags |= REQ_PREEMPT;
 	rqpm.pm_step = ide_pm_state_start_resume;
 	rqpm.pm_state = PM_EVENT_ON;
 
-	err = ide_do_drive_cmd(drive, &rq, ide_head_wait);
+	err = blk_execute_rq(drive->queue, NULL, rq, 1);
+	blk_put_request(rq);
 
 	if (err == 0 && dev->driver) {
 		ide_driver_t *drv = to_ide_driver(dev->driver);
-- 
1.5.4.2

