From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/15] ide: fix registers loading order for IDE_NSECTOR_REG in execute_drive_cmd()
Date: Sat, 27 Oct 2007 19:46:12 +0200
Message-ID: <200710271946.12258.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:47314 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598AbXJ0Rqo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:44 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1026741nfb
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Move loading of IDE_NSECTOR_REG from ide_cmd() to execute_drive_cmd()
(load the IDE_NSECTOR_REG just after IDE_FEATURE_REG).

This also allows us to drop 'nsect' argument from ide_cmd() and simplify
execute_drive_cmd() code for REQ_TYPE_ATA_CMD case a bit.

It shouldn't affect anything (just a usual paranoia to separate changes
which change the way in which hardware is accessed from code cleanups).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -624,21 +624,18 @@ ide_startstop_t ide_abort(ide_drive_t *d
  *	ide_cmd		-	issue a simple drive command
  *	@drive: drive the command is for
  *	@cmd: command byte
- *	@nsect: sector byte
  *	@handler: handler for the command completion
  *
  *	Issue a simple drive command with interrupts.
  *	The drive must be selected beforehand.
  */
 
-static void ide_cmd (ide_drive_t *drive, u8 cmd, u8 nsect,
-		ide_handler_t *handler)
+static void ide_cmd(ide_drive_t *drive, u8 cmd, ide_handler_t *handler)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);	/* clear nIEN */
 	SELECT_MASK(drive,0);
-	hwif->OUTB(nsect,IDE_NSECTOR_REG);
 	ide_execute_command(drive, cmd, handler, WAIT_CMD, NULL);
 }
 
@@ -913,11 +910,12 @@ static ide_startstop_t execute_drive_cmd
  		printk("sel=0x%02x\n", args[6]);
 #endif
  		hwif->OUTB(args[1], IDE_FEATURE_REG);
+		hwif->OUTB(args[2], IDE_NSECTOR_REG);
  		hwif->OUTB(args[3], IDE_SECTOR_REG);
  		hwif->OUTB(args[4], IDE_LCYL_REG);
  		hwif->OUTB(args[5], IDE_HCYL_REG);
  		hwif->OUTB((args[6] & 0xEF)|drive->select.all, IDE_SELECT_REG);
- 		ide_cmd(drive, args[0], args[2], &drive_cmd_intr);
+		ide_cmd(drive, args[0], &drive_cmd_intr);
  		return ide_started;
  	} else if (rq->cmd_type == REQ_TYPE_ATA_CMD) {
  		u8 *args = rq->buffer;
@@ -931,16 +929,15 @@ static ide_startstop_t execute_drive_cmd
  		printk("fr=0x%02x ", args[2]);
  		printk("xx=0x%02x\n", args[3]);
 #endif
+		hwif->OUTB(args[2], IDE_FEATURE_REG);
  		if (args[0] == WIN_SMART) {
- 			hwif->OUTB(args[2],IDE_FEATURE_REG);
+			hwif->OUTB(args[3],IDE_NSECTOR_REG);
  			hwif->OUTB(args[1],IDE_SECTOR_REG);
 			hwif->OUTB(0x4f, IDE_LCYL_REG);
 			hwif->OUTB(0xc2, IDE_HCYL_REG);
- 			ide_cmd(drive, args[0], args[3], &drive_cmd_intr);
- 			return ide_started;
- 		}
- 		hwif->OUTB(args[2],IDE_FEATURE_REG);
- 		ide_cmd(drive, args[0], args[1], &drive_cmd_intr);
+		} else
+			hwif->OUTB(args[1], IDE_NSECTOR_REG);
+		ide_cmd(drive, args[0], &drive_cmd_intr);
  		return ide_started;
  	}
 
