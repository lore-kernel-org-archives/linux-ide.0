From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/4] ide: cleanup generic_ide_ioctl()
Date: Tue, 05 Aug 2008 18:40:35 +0200
Message-ID: <20080805164035.17094.760.sendpatchset@localhost.localdomain>
References: <20080805164022.17094.27615.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:50079 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762196AbYHEQmo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 12:42:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1328086fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 05 Aug 2008 09:42:43 -0700 (PDT)
In-Reply-To: <20080805164022.17094.27615.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Fix intendation for the main 'switch ()'.

* 'switch ()' -> 'if ()' for HDIO_DRIVE_TASKFILE case.

* Move HDIO_SET_NICE case under HDIO_GET_NICE one.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   97 +++++++++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -565,8 +565,9 @@ static const struct ide_ioctl_devset ide
 { 0 }
 };
 
-int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,
-			unsigned int cmd, unsigned long arg)
+int generic_ide_ioctl(ide_drive_t *drive, struct file *file,
+		      struct block_device *bdev,
+		      unsigned int cmd, unsigned long arg)
 {
 	int err;
 
@@ -575,57 +576,49 @@ int generic_ide_ioctl(ide_drive_t *drive
 		return err;
 
 	switch (cmd) {
-		case HDIO_OBSOLETE_IDENTITY:
-		case HDIO_GET_IDENTITY:
-			if (bdev != bdev->bd_contains)
-				return -EINVAL;
-			return ide_get_identity_ioctl(drive, cmd, arg);
-		case HDIO_GET_NICE:
-			return ide_get_nice_ioctl(drive, arg);
-#ifdef CONFIG_IDE_TASK_IOCTL
-		case HDIO_DRIVE_TASKFILE:
-		        if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
-				return -EACCES;
-			switch(drive->media) {
-				case ide_disk:
-					return ide_taskfile_ioctl(drive, cmd, arg);
-				default:
-					return -ENOMSG;
-			}
-#endif /* CONFIG_IDE_TASK_IOCTL */
-
-		case HDIO_DRIVE_CMD:
-			if (!capable(CAP_SYS_RAWIO))
-				return -EACCES;
-			return ide_cmd_ioctl(drive, cmd, arg);
-
-		case HDIO_DRIVE_TASK:
-			if (!capable(CAP_SYS_RAWIO))
-				return -EACCES;
-			return ide_task_ioctl(drive, cmd, arg);
-		case HDIO_SET_NICE:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EACCES;
-			return ide_set_nice_ioctl(drive, arg);
-		case HDIO_DRIVE_RESET:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EACCES;
-
-			return generic_drive_reset(drive);
-
-		case HDIO_GET_BUSSTATE:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EACCES;
-			if (put_user(BUSSTATE_ON, (long __user *)arg))
-				return -EFAULT;
-			return 0;
-
-		case HDIO_SET_BUSSTATE:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EACCES;
-			return -EOPNOTSUPP;
-		default:
+	case HDIO_OBSOLETE_IDENTITY:
+	case HDIO_GET_IDENTITY:
+		if (bdev != bdev->bd_contains)
 			return -EINVAL;
+		return ide_get_identity_ioctl(drive, cmd, arg);
+	case HDIO_GET_NICE:
+		return ide_get_nice_ioctl(drive, arg);
+	case HDIO_SET_NICE:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+		return ide_set_nice_ioctl(drive, arg);
+#ifdef CONFIG_IDE_TASK_IOCTL
+	case HDIO_DRIVE_TASKFILE:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		if (drive->media == ide_disk)
+			return ide_taskfile_ioctl(drive, cmd, arg);
+		return -ENOMSG;
+#endif
+	case HDIO_DRIVE_CMD:
+		if (!capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ide_cmd_ioctl(drive, cmd, arg);
+	case HDIO_DRIVE_TASK:
+		if (!capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ide_task_ioctl(drive, cmd, arg);
+	case HDIO_DRIVE_RESET:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+		return generic_drive_reset(drive);
+	case HDIO_GET_BUSSTATE:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+		if (put_user(BUSSTATE_ON, (long __user *)arg))
+			return -EFAULT;
+		return 0;
+	case HDIO_SET_BUSSTATE:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
 	}
 }
 EXPORT_SYMBOL(generic_ide_ioctl);
