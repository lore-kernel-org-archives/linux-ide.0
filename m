From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/14] ide: unify exit paths in task_pio_intr()
Date: Mon, 02 Feb 2009 22:38:21 +0100
Message-ID: <20090202213821.17960.40146.sendpatchset@localhost.localdomain>
References: <20090202213707.17960.61897.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f12.google.com ([209.85.218.12]:47443 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759743AbZBBVlK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Feb 2009 16:41:10 -0500
In-Reply-To: <20090202213707.17960.61897.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: unify exit paths in task_pio_intr()

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
'goto' rules!

 drivers/ide/ide-taskfile.c |   37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -322,35 +322,28 @@ static ide_startstop_t task_pio_intr(ide
 	if (write == 0) {
 		/* Error? */
 		if (stat & ATA_ERR)
-			return task_error(drive, cmd, __func__, stat);
+			goto out_err;
 
 		/* Didn't want any data? Odd. */
 		if ((stat & ATA_DRQ) == 0) {
 			/* Command all done? */
-			if (OK_STAT(stat, ATA_DRDY, ATA_BUSY)) {
-				ide_finish_cmd(drive, cmd, stat);
-				return ide_stopped;
-			}
+			if (OK_STAT(stat, ATA_DRDY, ATA_BUSY))
+				goto out_end;
 
 			/* Assume it was a spurious irq */
-			ide_set_handler(drive, &task_pio_intr, WAIT_WORSTCASE,
-					NULL);
-
-			return ide_started;
+			goto out_wait;
 		}
 	} else {
 		if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
-			return task_error(drive, cmd, __func__, stat);
+			goto out_err;
 
 		/* Deal with unexpected ATA data phase. */
 		if (((stat & ATA_DRQ) == 0) ^ (cmd->nleft == 0))
-			return task_error(drive, cmd, __func__, stat);
+			goto out_err;
 	}
 
-	if (write && cmd->nleft == 0) {
-		ide_finish_cmd(drive, cmd, stat);
-		return ide_stopped;
-	}
+	if (write && cmd->nleft == 0)
+		goto out_end;
 
 	/* Still data left to transfer. */
 	ide_pio_datablock(drive, cmd, write);
@@ -359,15 +352,19 @@ static ide_startstop_t task_pio_intr(ide
 	if (write == 0 && cmd->nleft == 0) {
 		stat = wait_drive_not_busy(drive);
 		if (!OK_STAT(stat, 0, BAD_STAT))
-			return task_error(drive, cmd, __func__, stat);
-		ide_finish_cmd(drive, cmd, stat);
-		return ide_stopped;
-	}
+			goto out_err;
 
+		goto out_end;
+	}
+out_wait:
 	/* Still data left to transfer. */
 	ide_set_handler(drive, &task_pio_intr, WAIT_WORSTCASE, NULL);
-
 	return ide_started;
+out_end:
+	ide_finish_cmd(drive, cmd, stat);
+	return ide_stopped;
+out_err:
+	return task_error(drive, cmd, __func__, stat);
 }
 
 static ide_startstop_t pre_task_out_intr(ide_drive_t *drive,
