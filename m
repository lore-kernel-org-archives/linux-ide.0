From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/15] ide: remove ide_cmd() helper
Date: Sat, 27 Oct 2007 19:46:25 +0200
Message-ID: <200710271946.25234.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:9321 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106AbXJ0Rqr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:47 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1942000mue
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Remove ide_cmd() helper.

* Clear nIEN and call SELECT_MASK() before writing taskfile registers.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -621,25 +621,6 @@ ide_startstop_t ide_abort(ide_drive_t *d
 }
 
 /**
- *	ide_cmd		-	issue a simple drive command
- *	@drive: drive the command is for
- *	@cmd: command byte
- *	@handler: handler for the command completion
- *
- *	Issue a simple drive command with interrupts.
- *	The drive must be selected beforehand.
- */
-
-static void ide_cmd(ide_drive_t *drive, u8 cmd, ide_handler_t *handler)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);	/* clear nIEN */
-	SELECT_MASK(drive,0);
-	ide_execute_command(drive, cmd, handler, WAIT_CMD, NULL);
-}
-
-/**
  *	drive_cmd_intr		- 	drive command completion interrupt
  *	@drive: drive the completion interrupt occurred on
  *
@@ -901,6 +882,11 @@ static ide_startstop_t execute_drive_cmd
 	if (args == NULL)
 		goto done;
 
+	if (IDE_CONTROL_REG)
+		hwif->OUTB(drive->ctl, IDE_CONTROL_REG); /* clear nIEN */
+
+	SELECT_MASK(drive, 0);
+
 	if (rq->cmd_type == REQ_TYPE_ATA_TASK) {
 #ifdef DEBUG
  		printk("%s: DRIVE_TASK_CMD ", drive->name);
@@ -936,7 +922,7 @@ static ide_startstop_t execute_drive_cmd
 			hwif->OUTB(args[1], IDE_NSECTOR_REG);
  	}
 
-	ide_cmd(drive, args[0], &drive_cmd_intr);
+	ide_execute_command(drive, args[0], &drive_cmd_intr, WAIT_CMD, NULL);
 	return ide_started;
 
 done:
