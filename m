From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/13] ide-disk: add idedisk_set_doorlock() helper
Date: Tue, 13 Nov 2007 00:01:22 +0100
Message-ID: <200711130001.22710.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:11054 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914AbXKLW6J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:09 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1634397fkz
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:05 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -1004,6 +1004,17 @@ static ide_driver_t idedisk_driver = {
 #endif
 };
 
+static int idedisk_set_doorlock(ide_drive_t *drive, int on)
+{
+	ide_task_t task;
+
+	memset(&task, 0, sizeof(task));
+	task.tf.command = on ? WIN_DOORLOCK : WIN_DOORUNLOCK;
+	task.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+
+	return ide_no_data_taskfile(drive, &task);
+}
+
 static int idedisk_open(struct inode *inode, struct file *filp)
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
@@ -1018,17 +1029,13 @@ static int idedisk_open(struct inode *in
 	idkp->openers++;
 
 	if (drive->removable && idkp->openers == 1) {
-		ide_task_t args;
-		memset(&args, 0, sizeof(ide_task_t));
-		args.tf.command = WIN_DOORLOCK;
-		args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 		check_disk_change(inode->i_bdev);
 		/*
 		 * Ignore the return code from door_lock,
 		 * since the open() has already succeeded,
 		 * and the door_lock is irrelevant at this point.
 		 */
-		if (drive->doorlocking && ide_no_data_taskfile(drive, &args))
+		if (drive->doorlocking && idedisk_set_doorlock(drive, 1))
 			drive->doorlocking = 0;
 	}
 	return 0;
@@ -1044,11 +1051,7 @@ static int idedisk_release(struct inode 
 		ide_cacheflush_p(drive);
 
 	if (drive->removable && idkp->openers == 1) {
-		ide_task_t args;
-		memset(&args, 0, sizeof(ide_task_t));
-		args.tf.command = WIN_DOORUNLOCK;
-		args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
-		if (drive->doorlocking && ide_no_data_taskfile(drive, &args))
+		if (drive->doorlocking && idedisk_set_doorlock(drive, 0))
 			drive->doorlocking = 0;
 	}
 
