From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: improve failed opcode reporting
Date: Tue, 19 May 2009 23:18:43 +0200
Message-ID: <200905192318.43760.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:65010 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbZESVOm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 17:14:42 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Martin Lottermoser <Martin.Lottermoser@t-online.de>

Nowadays we (almost) always store the currently executing command
in hwif->cmd so we can use it for the failed opcode reporting.

Cc: Martin Lottermoser <Martin.Lottermoser@t-online.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -31,24 +31,6 @@ void ide_toggle_bounce(ide_drive_t *driv
 		blk_queue_bounce_limit(drive->queue, addr);
 }
 
-static void ide_dump_opcode(ide_drive_t *drive)
-{
-	struct request *rq = drive->hwif->rq;
-	struct ide_cmd *cmd = NULL;
-
-	if (!rq)
-		return;
-
-	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE)
-		cmd = rq->special;
-
-	printk(KERN_ERR "ide: failed opcode was: ");
-	if (cmd == NULL)
-		printk(KERN_CONT "unknown\n");
-	else
-		printk(KERN_CONT "0x%02x\n", cmd->tf.command);
-}
-
 u64 ide_get_lba_addr(struct ide_cmd *cmd, int lba48)
 {
 	struct ide_taskfile *tf = &cmd->tf;
@@ -179,7 +161,10 @@ u8 ide_dump_status(ide_drive_t *drive, c
 		else
 			ide_dump_atapi_error(drive, err);
 	}
-	ide_dump_opcode(drive);
+
+	printk(KERN_ERR "%s: possibly failed opcode: 0x%02x\n",
+		drive->name, drive->hwif->cmd.tf.command);
+
 	return err;
 }
 EXPORT_SYMBOL(ide_dump_status);
