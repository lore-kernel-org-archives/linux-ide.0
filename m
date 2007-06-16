From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE fixes
Date: Sat, 16 Jun 2007 02:28:10 +0200
Message-ID: <200706160228.10389.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:45727 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755687AbXFPARQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jun 2007 20:17:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so970491ugf
        for <linux-ide@vger.kernel.org>; Fri, 15 Jun 2007 17:17:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/ide.c       |    9 ++++++---
 drivers/scsi/ide-scsi.c |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)


Bartlomiej Zolnierkiewicz (1):
      ide-scsi: fix OOPS in idescsi_expiry()

Rafael J. Wysocki (1):
      Resume from RAM on HPC nx6325 broken


diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 0af0d16..0cd76bf 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1010,7 +1010,6 @@ static int generic_ide_resume(struct device *dev)
 {
 	ide_drive_t *drive = dev->driver_data;
 	ide_hwif_t *hwif = HWIF(drive);
-	ide_driver_t *drv = to_ide_driver(dev->driver);
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
@@ -1033,8 +1032,12 @@ static int generic_ide_resume(struct device *dev)
 
 	err = ide_do_drive_cmd(drive, &rq, ide_head_wait);
 
-	if (err == 0 && drv && drv->resume)
-		drv->resume(drive);
+	if (err == 0 && dev->driver) {
+		ide_driver_t *drv = to_ide_driver(dev->driver);
+
+		if (drv->resume)
+			drv->resume(drive);
+	}
 
 	return err;
 }
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index 8263f75..bb90df8 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -463,7 +463,7 @@ static inline unsigned long get_timeout(idescsi_pc_t *pc)
 
 static int idescsi_expiry(ide_drive_t *drive)
 {
-	idescsi_scsi_t *scsi = drive->driver_data;
+	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
 	idescsi_pc_t   *pc   = scsi->pc;
 
 #if IDESCSI_DEBUG_LOG
