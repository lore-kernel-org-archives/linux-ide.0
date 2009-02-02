From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 09/14] ide: inline task_in_unexpected() into task_pio_intr()
Date: Mon, 02 Feb 2009 22:38:14 +0100
Message-ID: <20090202213814.17960.32694.sendpatchset@localhost.localdomain>
References: <20090202213707.17960.61897.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:63868 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758608AbZBBVhS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Feb 2009 16:37:18 -0500
In-Reply-To: <20090202213707.17960.61897.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: inline task_in_unexpected() into task_pio_intr()

task_in_unexpected() is only used by task_pio_intr() so inline it there.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -310,27 +310,6 @@ void ide_finish_cmd(ide_drive_t *drive, st
 }
 
 /*
- * We got an interrupt on a task_in case, but no errors and no DRQ.
- *
- * It might be a spurious irq (shared irq), but it might be a
- * command that had no output.
- */
-static ide_startstop_t task_in_unexpected(ide_drive_t *drive,
-					  struct ide_cmd *cmd, u8 stat)
-{
-	/* Command all done? */
-	if (OK_STAT(stat, ATA_DRDY, ATA_BUSY)) {
-		ide_finish_cmd(drive, cmd, stat);
-		return ide_stopped;
-	}
-
-	/* Assume it was a spurious irq */
-	ide_set_handler(drive, &task_pio_intr, WAIT_WORSTCASE, NULL);
-
-	return ide_started;
-}
-
-/*
  * Handler for command with PIO data phase.
  */
 static ide_startstop_t task_pio_intr(ide_drive_t *drive)
@@ -346,8 +325,19 @@ static ide_startstop_t task_pio_intr(ide
 			return task_error(drive, cmd, __func__, stat);
 
 		/* Didn't want any data? Odd. */
-		if ((stat & ATA_DRQ) == 0)
-			return task_in_unexpected(drive, cmd, stat);
+		if ((stat & ATA_DRQ) == 0) {
+			/* Command all done? */
+			if (OK_STAT(stat, ATA_DRDY, ATA_BUSY)) {
+				ide_finish_cmd(drive, cmd, stat);
+				return ide_stopped;
+			}
+
+			/* Assume it was a spurious irq */
+			ide_set_handler(drive, &task_pio_intr, WAIT_WORSTCASE,
+					NULL);
+
+			return ide_started;
+		}
 	} else {
 		if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
 			return task_error(drive, cmd, __func__, stat);
