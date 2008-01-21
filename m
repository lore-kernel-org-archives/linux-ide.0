From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/16] ide: remove ->nice0 and ->nice2 fields from ide_drive_t
Date: Tue, 22 Jan 2008 00:31:30 +0100
Message-ID: <20080121233130.30311.83202.sendpatchset@localhost.localdomain>
References: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:43432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759985AbYAUXSZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 18:18:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so975307ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 15:18:24 -0800 (PST)
In-Reply-To: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


* ->nice0 and ->nice2 ide_drive_t fields are always zero so remove them.

* IDE_NICE_0 and IDE_NICE_2 defines from <linux/hdreg.h> are no longer
  used by any kernel code so cover them with #ifndef/#endif __KERNEL__.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c     |    5 +----
 include/linux/hdreg.h |    4 +++-
 include/linux/ide.h   |    2 --
 3 files changed, 4 insertions(+), 7 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1035,11 +1035,8 @@ int generic_ide_ioctl(ide_drive_t *drive
 		case HDIO_GET_NICE:
 			return put_user(drive->dsc_overlap	<<	IDE_NICE_DSC_OVERLAP	|
 					drive->atapi_overlap	<<	IDE_NICE_ATAPI_OVERLAP	|
-					drive->nice0		<< 	IDE_NICE_0		|
-					drive->nice1		<<	IDE_NICE_1		|
-					drive->nice2		<<	IDE_NICE_2,
+					drive->nice1 << IDE_NICE_1,
 					(long __user *) arg);
-
 #ifdef CONFIG_IDE_TASK_IOCTL
 		case HDIO_DRIVE_TASKFILE:
 		        if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
Index: b/include/linux/hdreg.h
===================================================================
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -706,8 +706,10 @@ struct hd_driveid {
  */
 #define IDE_NICE_DSC_OVERLAP	(0)	/* per the DSC overlap protocol */
 #define IDE_NICE_ATAPI_OVERLAP	(1)	/* not supported yet */
-#define IDE_NICE_0		(2)	/* when sure that it won't affect us */
 #define IDE_NICE_1		(3)	/* when probably won't affect us much */
+#ifndef __KERNEL__
+#define IDE_NICE_0		(2)	/* when sure that it won't affect us */
 #define IDE_NICE_2		(4)	/* when we know it's on our expense */
+#endif
 
 #endif	/* _LINUX_HDREG_H */
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -407,8 +407,6 @@ typedef struct ide_drive_s {
 	unsigned no_unmask	: 1;	/* disallow setting unmask bit */
 	unsigned no_io_32bit	: 1;	/* disallow enabling 32bit I/O */
 	unsigned atapi_overlap	: 1;	/* ATAPI overlap (not supported) */
-	unsigned nice0		: 1;	/* give obvious excess bandwidth */
-	unsigned nice2		: 1;	/* give a share in our own bandwidth */
 	unsigned doorlocking	: 1;	/* for removable only: door lock/unlock works */
 	unsigned nodma		: 1;	/* disallow DMA */
 	unsigned autotune	: 2;	/* 0=default, 1=autotune, 2=noautotune */
