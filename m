From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/20] ide: convert "empty" REQ_TYPE_ATA_CMD requests to use REQ_TYPE_ATA_TASKFILE
Date: Sun, 9 Dec 2007 22:17:32 +0100
Message-ID: <200712092217.32139.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:55855 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbXLIVVF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:21:05 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381343ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:21:03 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Based on the previous work by Tejun Heo.

There should be no functionality changes caused by this patch.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c     |    4 +++-
 drivers/ide/ide-taskfile.c |    2 +-
 drivers/ide/ide.c          |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -620,8 +620,10 @@ static int set_multcount(ide_drive_t *dr
 
 	if (drive->special.b.set_multmode)
 		return -EBUSY;
+
 	ide_init_drive_cmd (&rq);
-	rq.cmd_type = REQ_TYPE_ATA_CMD;
+	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
+
 	drive->mult_req = arg;
 	drive->special.b.set_multmode = 1;
 	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -782,7 +782,7 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 		struct request rq;
 
 		ide_init_drive_cmd(&rq);
-		rq.cmd_type = REQ_TYPE_ATA_CMD;
+		rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
 
 		return ide_do_drive_cmd(drive, &rq, ide_wait);
 	}
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -876,7 +876,7 @@ int set_pio_mode(ide_drive_t *drive, int
 		return -EBUSY;
 
 	ide_init_drive_cmd(&rq);
-	rq.cmd_type = REQ_TYPE_ATA_CMD;
+	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
 
 	drive->tune_req = (u8) arg;
 	drive->special.b.set_tune = 1;
