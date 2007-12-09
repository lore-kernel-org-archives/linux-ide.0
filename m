From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/20] ide: fix ->io_32bit race in ide_taskfile_ioctl()
Date: Sun, 9 Dec 2007 22:07:55 +0100
Message-ID: <200712092207.55172.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:55327 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbXLIVUx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:20:53 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381310ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:20:52 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


In ide_taskfile_ioctl(), there was a race condition involving
drive->io_32bit.  It was cleared and restored during ioctl
requests but there was no synchronization with other requests.
So, other requests could execute with the altered ->io_32bit
setting or updated drive->io_32bit could be overwritten by
ide_taskfile_ioctl().

This patch adds IDE_TFLAG_IO_16BIT flag to indicate to
ide_pio_datablock() that 16-bit I/O is needed regardless of
drive->io_32bit settting.

Bart:
- ported it over recent IDE changes

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   17 ++++++++++++-----
 include/linux/ide.h        |    2 ++
 2 files changed, 14 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -346,9 +346,18 @@ static void ide_pio_multi(ide_drive_t *d
 static void ide_pio_datablock(ide_drive_t *drive, struct request *rq,
 				     unsigned int write)
 {
+	u8 saved_io_32bit = drive->io_32bit;
+
 	if (rq->bio)	/* fs request */
 		rq->errors = 0;
 
+	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
+		ide_task_t *task = rq->special;
+
+		if (task->tf_flags & IDE_TFLAG_IO_16BIT)
+			drive->io_32bit = 0;
+	}
+
 	touch_softlockup_watchdog();
 
 	switch (drive->hwif->data_phase) {
@@ -360,6 +369,8 @@ static void ide_pio_datablock(ide_drive_
 		ide_pio_sector(drive, write);
 		break;
 	}
+
+	drive->io_32bit = saved_io_32bit;
 }
 
 static ide_startstop_t task_error(ide_drive_t *drive, struct request *rq,
@@ -555,7 +566,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	unsigned int taskin	= 0;
 	unsigned int taskout	= 0;
 	u16 nsect		= 0;
-	u8 io_32bit		= drive->io_32bit;
 	char __user *buf = (char __user *)arg;
 
 //	printk("IDE Taskfile ...\n");
@@ -608,7 +618,7 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 
 	args.data_phase = req_task->data_phase;
 
-	args.tf_flags = IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags = IDE_TFLAG_IO_16BIT | IDE_TFLAG_OUT_DEVICE;
 	if (drive->addressing == 1)
 		args.tf_flags |= IDE_TFLAG_LBA48;
 
@@ -646,7 +656,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	if (req_task->in_flags.b.data)
 		args.tf_flags |= IDE_TFLAG_IN_DATA;
 
-	drive->io_32bit = 0;
 	switch(req_task->data_phase) {
 		case TASKFILE_MULTI_OUT:
 			if (!drive->mult_count) {
@@ -742,8 +751,6 @@ abort:
 
 //	printk("IDE Taskfile ioctl ended. rc = %i\n", err);
 
-	drive->io_32bit = io_32bit;
-
 	return err;
 }
 #endif
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -931,6 +931,8 @@ enum {
 	IDE_TFLAG_IN_TF			= IDE_TFLAG_IN_NSECT |
 					  IDE_TFLAG_IN_LBA,
 	IDE_TFLAG_IN_DEVICE		= (1 << 29),
+	/* force 16-bit I/O operations */
+	IDE_TFLAG_IO_16BIT		= (1 << 30),
 };
 
 struct ide_taskfile {
