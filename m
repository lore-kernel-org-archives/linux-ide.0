From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/5] ide: factor out HDIO_*_NICE ioctl handling to ide_*_nice_ioctl()
Date: Mon, 28 Jul 2008 22:41:31 +0200
Message-ID: <20080728204131.4283.96095.sendpatchset@localhost.localdomain>
References: <20080728204102.4283.74632.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:15694 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760101AbYG1Una (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 16:43:30 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3550806fkq.5
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 13:43:30 -0700 (PDT)
In-Reply-To: <20080728204102.4283.74632.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Factor out HDIO_{GET,SET}_NICE ioctl handling from
generic_ide_ioctl() to ide_{get,set}_nice_ioctl().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -558,6 +558,28 @@ out:
 	return rc;
 }
 
+static int ide_get_nice_ioctl(ide_drive_t *drive, unsigned long arg)
+{
+	return put_user((drive->dsc_overlap << IDE_NICE_DSC_OVERLAP) |
+			(drive->nice1 << IDE_NICE_1), (long __user *)arg);
+}
+
+static int ide_set_nice_ioctl(ide_drive_t *drive, unsigned long arg)
+{
+	if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP) | (1 << IDE_NICE_1))))
+		return -EPERM;
+
+	if (((arg >> IDE_NICE_DSC_OVERLAP) & 1) &&
+	    (drive->media == ide_disk || drive->media == ide_floppy ||
+	     drive->scsi))
+		return -EPERM;
+
+	drive->dsc_overlap = (arg >> IDE_NICE_DSC_OVERLAP) & 1;
+	drive->nice1 = (arg >> IDE_NICE_1) & 1;
+
+	return 0;
+}
+
 int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,
 			unsigned int cmd, unsigned long arg)
 {
@@ -583,9 +605,7 @@ int generic_ide_ioctl(ide_drive_t *drive
 				return -EINVAL;
 			return ide_get_identity_ioctl(drive, cmd, arg);
 		case HDIO_GET_NICE:
-			return put_user(drive->dsc_overlap	<<	IDE_NICE_DSC_OVERLAP	|
-					drive->nice1 << IDE_NICE_1,
-					(long __user *) arg);
+			return ide_get_nice_ioctl(drive, arg);
 #ifdef CONFIG_IDE_TASK_IOCTL
 		case HDIO_DRIVE_TASKFILE:
 		        if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
@@ -608,17 +628,9 @@ int generic_ide_ioctl(ide_drive_t *drive
 				return -EACCES;
 			return ide_task_ioctl(drive, cmd, arg);
 		case HDIO_SET_NICE:
-			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP) | (1 << IDE_NICE_1))))
-				return -EPERM;
-			if (((arg >> IDE_NICE_DSC_OVERLAP) & 1) &&
-			    (drive->media == ide_disk ||
-			     drive->media == ide_floppy ||
-			     drive->scsi))
-				return -EPERM;
-			drive->dsc_overlap = (arg >> IDE_NICE_DSC_OVERLAP) & 1;
-			drive->nice1 = (arg >> IDE_NICE_1) & 1;
-			return 0;
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+			return ide_set_nice_ioctl(drive, arg);
 		case HDIO_DRIVE_RESET:
 			if (!capable(CAP_SYS_ADMIN))
 				return -EACCES;
