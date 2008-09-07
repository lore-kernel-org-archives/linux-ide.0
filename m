From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/18] ide: IDE_AFLAG_WP -> IDE_DFLAG_WP
Date: Mon, 08 Sep 2008 00:15:33 +0200
Message-ID: <20080907221533.24285.39292.sendpatchset@localhost.localdomain>
References: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:64118 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017AbYIGWRm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 18:17:42 -0400
Received: by ug-out-1314.google.com with SMTP id s2so93719uge.37
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 15:17:41 -0700 (PDT)
In-Reply-To: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |    8 ++++----
 include/linux/ide.h      |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -410,11 +410,11 @@ static int ide_floppy_get_flexible_disk_
 	}
 
 	if (pc.buf[3] & 0x80)
-		drive->atapi_flags |= IDE_AFLAG_WP;
+		drive->dev_flags |= IDE_DFLAG_WP;
 	else
-		drive->atapi_flags &= ~IDE_AFLAG_WP;
+		drive->dev_flags &= ~IDE_DFLAG_WP;
 
-	set_disk_ro(disk, !!(drive->atapi_flags & IDE_AFLAG_WP));
+	set_disk_ro(disk, !!(drive->dev_flags & IDE_DFLAG_WP));
 
 	page = &pc.buf[8];
 
@@ -684,7 +684,7 @@ static int idefloppy_open(struct inode *
 			goto out_put_floppy;
 		}
 
-		if ((drive->atapi_flags & IDE_AFLAG_WP) && (filp->f_mode & 2)) {
+		if ((drive->dev_flags & IDE_DFLAG_WP) && (filp->f_mode & 2)) {
 			ret = -EROFS;
 			goto out_put_floppy;
 		}
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -501,8 +501,6 @@ enum {
 	IDE_AFLAG_CLIK_DRIVE		= (1 << 19),
 	/* Requires BH algorithm for packets */
 	IDE_AFLAG_ZIP_DRIVE		= (1 << 20),
-	/* Write protect */
-	IDE_AFLAG_WP			= (1 << 21),
 	/* Supports format progress report */
 	IDE_AFLAG_SRFP			= (1 << 22),
 
@@ -571,6 +569,8 @@ enum {
 	IDE_DFLAG_DMA_PIO_RETRY		= (1 << 25),
 	IDE_DFLAG_LBA			= (1 << 26),
 	IDE_DFLAG_MEDIA_CHANGED		= (1 << 27),
+	/* write protect */
+	IDE_DFLAG_WP			= (1 << 28),
 };
 
 struct ide_drive_s {
