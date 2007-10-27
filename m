From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/15] ide: use IDE_TFLAG_LBA48 for REQ_TYPE_ATA_TASKFILE requests
Date: Sat, 27 Oct 2007 19:46:35 +0200
Message-ID: <200710271946.35816.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:47314 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932AbXJ0Rqt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:49 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1026741nfb
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Use IDE_TFLAG_LBA48 for REQ_TYPE_ATA_TASKFILE requests in ide_end_drive_cmd()
  to decide whether we need to read HOB taskfile registers.

* Update execute_drive_cmd() accordingly.

This is a preparation for the next patch which removes unnecessary writes to
HOB taskfile registers for some ATA commands.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -374,7 +374,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			tf->device = hwif->INB(IDE_SELECT_REG);
 			tf->status = stat;
 
-			if (drive->addressing == 1) {
+			if (args->tf_flags & IDE_TFLAG_LBA48) {
 				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
 				tf->hob_feature = hwif->INB(IDE_FEATURE_REG);
 				tf->hob_nsect   = hwif->INB(IDE_NSECTOR_REG);
@@ -872,13 +872,15 @@ static ide_startstop_t execute_drive_cmd
 		}
 
 		task->tf_flags |= IDE_TFLAG_OUT_DEVICE;
+		if (drive->addressing == 1)
+			task->tf_flags |= IDE_TFLAG_LBA48;
 
 		if (task->tf_flags & IDE_TFLAG_FLAGGED)
 			return flagged_taskfile(drive, task);
 
 		task->tf_flags |= IDE_TFLAG_OUT_TF;
-		if (drive->addressing == 1)
-			task->tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
+		if (task->tf_flags & IDE_TFLAG_LBA48)
+			task->tf_flags |= IDE_TFLAG_OUT_HOB;
 
 		return do_rw_taskfile(drive, task);
 	}
