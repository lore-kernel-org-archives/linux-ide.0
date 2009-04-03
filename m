From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/5] ide-cd: respect REQ_QUIET for fs requests in cdrom_decode_status()
Date: Fri, 03 Apr 2009 21:57:57 +0200
Message-ID: <20090403195757.31438.16866.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:62084 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbZDCTyP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Apr 2009 15:54:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cd: respect REQ_QUIET for fs requests in cdrom_decode_status()

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -382,7 +382,8 @@ static int cdrom_decode_status(ide_drive
 				cdrom_saw_media_change(drive);
 
 				/* fail the request */
-				printk(KERN_ERR PFX "%s: tray open\n",
+				if ((rq->cmd_flags & REQ_QUIET) == 0)
+					printk(KERN_ERR PFX "%s: tray open\n",
 						drive->name);
 			} else {
 				if (ide_cd_breathe(drive, rq))
@@ -405,19 +406,23 @@ static int cdrom_decode_status(ide_drive
 			 * No point in retrying after an illegal request or data
 			 * protect error.
 			 */
-			ide_dump_status(drive, "command error", stat);
+			if ((rq->cmd_flags & REQ_QUIET) == 0)
+				ide_dump_status(drive, "command error", stat);
 			do_end_request = 1;
 		} else if (sense_key == MEDIUM_ERROR) {
 			/*
 			 * No point in re-trying a zillion times on a bad
 			 * sector. If we got here the error is not correctable.
 			 */
-			ide_dump_status(drive, "media error (bad sector)",
-					stat);
+			if ((rq->cmd_flags & REQ_QUIET) == 0)
+				ide_dump_status(drive, "media error "
+						"(bad sector)", stat);
 			do_end_request = 1;
 		} else if (sense_key == BLANK_CHECK) {
 			/* disk appears blank ?? */
-			ide_dump_status(drive, "media error (blank)", stat);
+			if ((rq->cmd_flags & REQ_QUIET) == 0)
+				ide_dump_status(drive, "media error (blank)",
+						stat);
 			do_end_request = 1;
 		} else if ((err & ~ATA_ABORTED) != 0) {
 			/* go to the default handler for other errors */
