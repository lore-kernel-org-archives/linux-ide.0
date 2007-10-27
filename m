From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/15] ide: remove REQ_TYPE_ATA_TASK
Date: Sat, 27 Oct 2007 19:49:12 +0200
Message-ID: <200710271949.12689.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:47314 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784AbXJ0Rq5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:57 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1026741nfb
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Based on the earlier work by Tejun Heo.

All users are gone so we can finally remove it.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c   |   25 +------------------------
 drivers/ide/ide-lib.c  |    3 +--
 include/linux/blkdev.h |    1 -
 3 files changed, 2 insertions(+), 27 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -332,22 +332,6 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			args[1] = err;
 			args[2] = hwif->INB(IDE_NSECTOR_REG);
 		}
-	} else if (rq->cmd_type == REQ_TYPE_ATA_TASK) {
-		u8 *args = (u8 *) rq->buffer;
-		if (rq->errors == 0)
-			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
-
-		if (args) {
-			args[0] = stat;
-			args[1] = err;
-			/* be sure we're looking at the low order bits */
-			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
-			args[2] = hwif->INB(IDE_NSECTOR_REG);
-			args[3] = hwif->INB(IDE_SECTOR_REG);
-			args[4] = hwif->INB(IDE_LCYL_REG);
-			args[5] = hwif->INB(IDE_HCYL_REG);
-			args[6] = hwif->INB(IDE_SELECT_REG);
-		}
 	} else if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *args = (ide_task_t *) rq->special;
 		if (rq->errors == 0)
@@ -877,13 +861,7 @@ static ide_startstop_t execute_drive_cmd
 		goto done;
 
 	memset(&ltask, 0, sizeof(ltask));
-	if (rq->cmd_type == REQ_TYPE_ATA_TASK) {
-#ifdef DEBUG
-		printk("%s: DRIVE_TASK_CMD\n", drive->name);
-#endif
-		memcpy(&ltask.tf_array[7], &args[1], 6);
-		ltask.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
-	} else { /* rq->cmd_type == REQ_TYPE_ATA_CMD */
+	if (rq->cmd_type == REQ_TYPE_ATA_CMD) {
 #ifdef DEBUG
 		printk("%s: DRIVE_CMD\n", drive->name);
 #endif
@@ -1009,7 +987,6 @@ static ide_startstop_t start_request (id
 			ide_config_drive_speed(drive, drive->desired_speed);
 
 		if (rq->cmd_type == REQ_TYPE_ATA_CMD ||
-		    rq->cmd_type == REQ_TYPE_ATA_TASK ||
 		    rq->cmd_type == REQ_TYPE_ATA_TASKFILE)
 			return execute_drive_cmd(drive, rq);
 		else if (blk_pm_request(rq)) {
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -455,8 +455,7 @@ static void ide_dump_opcode(ide_drive_t 
 	spin_unlock(&ide_lock);
 	if (!rq)
 		return;
-	if (rq->cmd_type == REQ_TYPE_ATA_CMD ||
-	    rq->cmd_type == REQ_TYPE_ATA_TASK) {
+	if (rq->cmd_type == REQ_TYPE_ATA_CMD) {
 		char *args = rq->buffer;
 		if (args) {
 			opcode = args[0];
Index: b/include/linux/blkdev.h
===================================================================
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -144,7 +144,6 @@ enum rq_cmd_type_bits {
 	 * private REQ_LB opcodes to differentiate what type of request this is
 	 */
 	REQ_TYPE_ATA_CMD,
-	REQ_TYPE_ATA_TASK,
 	REQ_TYPE_ATA_TASKFILE,
 	REQ_TYPE_ATA_PC,
 };
