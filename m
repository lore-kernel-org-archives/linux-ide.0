From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/14] ide: allow any command requesting DMA data phase for HDIO_DRIVE_TASKFILE
Date: Tue, 10 Jun 2008 22:52:30 +0200
Message-ID: <20080610205230.18469.16053.sendpatchset@localhost.localdomain>
References: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:29680 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758052AbYFJUuw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 16:50:52 -0400
Received: by gv-out-0910.google.com with SMTP id e6so669622gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 13:50:52 -0700 (PDT)
In-Reply-To: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Allow any command requesting DMA data phase for HDIO_DRIVE_TASKFILE ioctl
and remove no longer needed task_dma_ok()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -62,25 +62,6 @@ int taskfile_lib_get_identify (ide_drive
 	return ide_raw_taskfile(drive, &args, buf, 1);
 }
 
-static int inline task_dma_ok(ide_task_t *task)
-{
-	if (blk_fs_request(task->rq) || (task->tf_flags & IDE_TFLAG_FLAGGED))
-		return 1;
-
-	switch (task->tf.command) {
-		case WIN_WRITEDMA_ONCE:
-		case WIN_WRITEDMA:
-		case WIN_WRITEDMA_EXT:
-		case WIN_READDMA_ONCE:
-		case WIN_READDMA:
-		case WIN_READDMA_EXT:
-		case WIN_IDENTIFY_DMA:
-			return 1;
-	}
-
-	return 0;
-}
-
 static ide_startstop_t task_no_data_intr(ide_drive_t *);
 static ide_startstop_t set_geometry_intr(ide_drive_t *);
 static ide_startstop_t recal_intr(ide_drive_t *);
@@ -139,8 +120,7 @@ ide_startstop_t do_rw_taskfile (ide_driv
 				    WAIT_WORSTCASE, NULL);
 		return ide_started;
 	default:
-		if (task_dma_ok(task) == 0 || drive->using_dma == 0 ||
-		    dma_ops->dma_setup(drive))
+		if (drive->using_dma == 0 || dma_ops->dma_setup(drive))
 			return ide_stopped;
 		dma_ops->dma_exec_cmd(drive, tf->command);
 		dma_ops->dma_start(drive);
