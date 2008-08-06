From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] ide-floppy: add ide_floppy_format_ioctl() helper
Date: Wed, 6 Aug 2008 18:37:23 +0200
Message-ID: <200808061837.23906.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:16900 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756971AbYHFQnc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 12:43:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1555fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 06 Aug 2008 09:43:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

* Factor out IDEFLOPPY_IOCTL_FORMAT_* ioctls handling from
  idefloppy_ioctl() to ide_floppy_format_ioctl().

While at it:

* Pass 'drive' instead of 'floppy' to ide_floppy_format_unit().

* idefloppy_get_format_progress() -> ide_floppy_get_format_progress()

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |   46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -926,7 +926,7 @@ static int ide_floppy_get_format_capacit
  * the dsc bit, and return either 0 or 65536.
  */
 
-static int idefloppy_get_format_progress(ide_drive_t *drive, int __user *arg)
+static int ide_floppy_get_format_progress(ide_drive_t *drive, int __user *arg)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	struct ide_atapi_pc pc;
@@ -1232,11 +1232,10 @@ static int ide_floppy_lockdoor(ide_drive
 	return 0;
 }
 
-static int ide_floppy_format_unit(idefloppy_floppy_t *floppy,
-				  int __user *arg)
+static int ide_floppy_format_unit(ide_drive_t *drive, int __user *arg)
 {
+	idefloppy_floppy_t *floppy = drive->driver_data;
 	struct ide_atapi_pc pc;
-	ide_drive_t *drive = floppy->drive;
 	int blocks, length, flags, err = 0;
 
 	if (floppy->openers > 1) {
@@ -1281,6 +1280,24 @@ out:
 	return err;
 }
 
+static int ide_floppy_format_ioctl(ide_drive_t *drive, struct file *file,
+				   unsigned int cmd, void __user *argp)
+{
+	switch (cmd) {
+	case IDEFLOPPY_IOCTL_FORMAT_SUPPORTED:
+		return 0;
+	case IDEFLOPPY_IOCTL_FORMAT_GET_CAPACITY:
+		return ide_floppy_get_format_capacities(drive, argp);
+	case IDEFLOPPY_IOCTL_FORMAT_START:
+		if (!(file->f_mode & 2))
+			return -EPERM;
+		return ide_floppy_format_unit(drive, (int __user *)argp);
+	case IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS:
+		return ide_floppy_get_format_progress(drive, argp);
+	default:
+		return -ENOTTY;
+	}
+}
 
 static int idefloppy_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
@@ -1292,23 +1309,12 @@ static int idefloppy_ioctl(struct inode 
 	void __user *argp = (void __user *)arg;
 	int err;
 
-	switch (cmd) {
-	case CDROMEJECT:
-		/* fall through */
-	case CDROM_LOCKDOOR:
+	if (cmd == CDROMEJECT || cmd == CDROM_LOCKDOOR)
 		return ide_floppy_lockdoor(drive, &pc, arg, cmd);
-	case IDEFLOPPY_IOCTL_FORMAT_SUPPORTED:
-		return 0;
-	case IDEFLOPPY_IOCTL_FORMAT_GET_CAPACITY:
-		return ide_floppy_get_format_capacities(drive, argp);
-	case IDEFLOPPY_IOCTL_FORMAT_START:
-		if (!(file->f_mode & 2))
-			return -EPERM;
 
-		return ide_floppy_format_unit(floppy, (int __user *)arg);
-	case IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS:
-		return idefloppy_get_format_progress(drive, argp);
-	}
+	err = ide_floppy_format_ioctl(drive, file, cmd, argp);
+	if (err != -ENOTTY)
+		return err;
 
 	/*
 	 * skip SCSI_IOCTL_SEND_COMMAND (deprecated)
@@ -1317,8 +1323,6 @@ static int idefloppy_ioctl(struct inode 
 	if (cmd != CDROM_SEND_PACKET && cmd != SCSI_IOCTL_SEND_COMMAND)
 		err = scsi_cmd_ioctl(file, bdev->bd_disk->queue,
 					bdev->bd_disk, cmd, argp);
-	else
-		err = -ENOTTY;
 
 	if (err == -ENOTTY)
 		err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
