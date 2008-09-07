From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/18] ide: IDE_AFLAG_FORMAT_IN_PROGRESS -> IDE_DFLAG_FORMAT_IN_PROGRESS
Date: Mon, 08 Sep 2008 00:15:40 +0200
Message-ID: <20080907221540.24285.83309.sendpatchset@localhost.localdomain>
References: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:25685 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066AbYIGWRs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 18:17:48 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1100873muf.1
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 15:17:47 -0700 (PDT)
In-Reply-To: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c       |    6 +++---
 drivers/ide/ide-floppy_ioctl.c |    6 +++---
 include/linux/ide.h            |    3 +--
 3 files changed, 7 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -664,7 +664,7 @@ static int idefloppy_open(struct inode *
 	floppy->openers++;
 
 	if (floppy->openers == 1) {
-		drive->atapi_flags &= ~IDE_AFLAG_FORMAT_IN_PROGRESS;
+		drive->dev_flags &= ~IDE_DFLAG_FORMAT_IN_PROGRESS;
 		/* Just in case */
 
 		if (ide_do_test_unit_ready(drive, disk))
@@ -692,7 +692,7 @@ static int idefloppy_open(struct inode *
 		ide_set_media_lock(drive, disk, 1);
 		drive->dev_flags |= IDE_DFLAG_MEDIA_CHANGED;
 		check_disk_change(inode->i_bdev);
-	} else if (drive->atapi_flags & IDE_AFLAG_FORMAT_IN_PROGRESS) {
+	} else if (drive->dev_flags & IDE_DFLAG_FORMAT_IN_PROGRESS) {
 		ret = -EBUSY;
 		goto out_put_floppy;
 	}
@@ -714,7 +714,7 @@ static int idefloppy_release(struct inod
 
 	if (floppy->openers == 1) {
 		ide_set_media_lock(drive, disk, 0);
-		drive->atapi_flags &= ~IDE_AFLAG_FORMAT_IN_PROGRESS;
+		drive->dev_flags &= ~IDE_DFLAG_FORMAT_IN_PROGRESS;
 	}
 
 	floppy->openers--;
Index: b/drivers/ide/ide-floppy_ioctl.c
===================================================================
--- a/drivers/ide/ide-floppy_ioctl.c
+++ b/drivers/ide/ide-floppy_ioctl.c
@@ -138,11 +138,11 @@ static int ide_floppy_format_unit(ide_dr
 
 	if (floppy->openers > 1) {
 		/* Don't format if someone is using the disk */
-		drive->atapi_flags &= ~IDE_AFLAG_FORMAT_IN_PROGRESS;
+		drive->dev_flags &= ~IDE_DFLAG_FORMAT_IN_PROGRESS;
 		return -EBUSY;
 	}
 
-	drive->atapi_flags |= IDE_AFLAG_FORMAT_IN_PROGRESS;
+	drive->dev_flags |= IDE_DFLAG_FORMAT_IN_PROGRESS;
 
 	/*
 	 * Send ATAPI_FORMAT_UNIT to the drive.
@@ -174,7 +174,7 @@ static int ide_floppy_format_unit(ide_dr
 
 out:
 	if (err)
-		drive->atapi_flags &= ~IDE_AFLAG_FORMAT_IN_PROGRESS;
+		drive->dev_flags &= ~IDE_DFLAG_FORMAT_IN_PROGRESS;
 	return err;
 }
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -495,8 +495,6 @@ enum {
 	IDE_AFLAG_LE_SPEED_FIELDS	= (1 << 17),
 
 	/* ide-floppy */
-	/* Format in progress */
-	IDE_AFLAG_FORMAT_IN_PROGRESS	= (1 << 18),
 	/* Avoid commands not supported in Clik drive */
 	IDE_AFLAG_CLIK_DRIVE		= (1 << 19),
 	/* Requires BH algorithm for packets */
@@ -571,6 +569,7 @@ enum {
 	IDE_DFLAG_MEDIA_CHANGED		= (1 << 27),
 	/* write protect */
 	IDE_DFLAG_WP			= (1 << 28),
+	IDE_DFLAG_FORMAT_IN_PROGRESS	= (1 << 29),
 };
 
 struct ide_drive_s {
