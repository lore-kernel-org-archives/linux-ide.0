From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 05/18] ide-disk: move IDE_DFLAG_DOORLOCKING flag handling to idedisk_set_doorlock()
Date: Mon, 08 Sep 2008 00:14:58 +0200
Message-ID: <20080907221458.24285.31795.sendpatchset@localhost.localdomain>
References: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:33498 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbYIGWRH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 18:17:07 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1100908muf.1
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 15:17:06 -0700 (PDT)
In-Reply-To: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -811,12 +811,21 @@ static ide_driver_t idedisk_driver = {
 static int idedisk_set_doorlock(ide_drive_t *drive, int on)
 {
 	ide_task_t task;
+	int ret;
+
+	if ((drive->dev_flags & IDE_DFLAG_DOORLOCKING) == 0)
+		return 0;
 
 	memset(&task, 0, sizeof(task));
 	task.tf.command = on ? ATA_CMD_MEDIA_LOCK : ATA_CMD_MEDIA_UNLOCK;
 	task.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 
-	return ide_no_data_taskfile(drive, &task);
+	ret = ide_no_data_taskfile(drive, &task);
+
+	if (ret)
+		drive->dev_flags &= ~IDE_DFLAG_DOORLOCKING;
+
+	return ret;
 }
 
 static int idedisk_open(struct inode *inode, struct file *filp)
@@ -839,9 +848,7 @@ static int idedisk_open(struct inode *in
 		 * since the open() has already succeeded,
 		 * and the door_lock is irrelevant at this point.
 		 */
-		if ((drive->dev_flags & IDE_DFLAG_DOORLOCKING) &&
-		    idedisk_set_doorlock(drive, 1))
-			drive->dev_flags &= ~IDE_DFLAG_DOORLOCKING;
+		idedisk_set_doorlock(drive, 1);
 		check_disk_change(inode->i_bdev);
 	}
 	return 0;
@@ -856,11 +863,8 @@ static int idedisk_release(struct inode 
 	if (idkp->openers == 1)
 		ide_cacheflush_p(drive);
 
-	if ((drive->dev_flags & IDE_DFLAG_REMOVABLE) && idkp->openers == 1) {
-		if ((drive->dev_flags & IDE_DFLAG_DOORLOCKING) &&
-		    idedisk_set_doorlock(drive, 0))
-			drive->dev_flags &= ~IDE_DFLAG_DOORLOCKING;
-	}
+	if ((drive->dev_flags & IDE_DFLAG_REMOVABLE) && idkp->openers == 1)
+		idedisk_set_doorlock(drive, 0);
 
 	idkp->openers--;
 
