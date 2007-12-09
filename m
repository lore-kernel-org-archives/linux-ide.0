From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/20] ide: task_end_request() fix
Date: Sun, 9 Dec 2007 22:14:33 +0100
Message-ID: <200712092214.33276.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:55432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbXLIVVB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:21:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381308ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:21:00 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


task_end_request() modified to always call ide_end_drive_cmd()
for taskfile requests.  Previously, ide_end_drive_cmd() was
called only when IDE_TFLAG_FLAGGED was set.  Also,
ide_dma_intr() is modified to use task_end_request().

Enables TASKFILE ioctls to get valid register outputs on
successful completion.

Bart:
- ported it over recent IDE changes

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c      |    8 +-------
 drivers/ide/ide-taskfile.c |   11 ++++-------
 include/linux/ide.h        |    2 ++
 3 files changed, 7 insertions(+), 14 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -153,13 +153,7 @@ ide_startstop_t ide_dma_intr (ide_drive_
 		if (!dma_stat) {
 			struct request *rq = HWGROUP(drive)->rq;
 
-			if (rq->rq_disk) {
-				ide_driver_t *drv;
-
-				drv = *(ide_driver_t **)rq->rq_disk->private_data;
-				drv->end_request(drive, 1, rq->nr_sectors);
-			} else
-				ide_end_request(drive, 1, rq->nr_sectors);
+			task_end_request(drive, rq, stat);
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -408,16 +408,13 @@ static ide_startstop_t task_error(ide_dr
 	return ide_error(drive, s, stat);
 }
 
-static void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
+void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
 {
 	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
-		ide_task_t *task = rq->special;
+		u8 err = drive->hwif->INB(IDE_ERROR_REG);
 
-		if (task->tf_flags & IDE_TFLAG_FLAGGED) {
-			u8 err = drive->hwif->INB(IDE_ERROR_REG);
-			ide_end_drive_cmd(drive, stat, err);
-			return;
-		}
+		ide_end_drive_cmd(drive, stat, err);
+		return;
 	}
 
 	if (rq->rq_disk) {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -993,6 +993,8 @@ void ide_pktcmd_tf_load(ide_drive_t *, u
 
 ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
 
+void task_end_request(ide_drive_t *, struct request *, u8);
+
 int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *, u16);
 int ide_no_data_taskfile(ide_drive_t *, ide_task_t *);
 
