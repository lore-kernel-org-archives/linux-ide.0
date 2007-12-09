From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 18/20] ide: switch set_xfer_rate() to use REQ_TYPE_ATA_TASKFILE requests
Date: Sun, 9 Dec 2007 22:20:50 +0100
Message-ID: <200712092220.51066.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:55840 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbXLIVVI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:21:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381341ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:21:08 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Based on the earlier work by Tejun Heo.

Switch set_xfer_rate() to use REQ_TYPE_ATA_TASKFILE requests
and make ide_wait_cmd() static.

There should be no functionality changes caused by this patch.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-proc.c     |   12 +++++++++---
 drivers/ide/ide-taskfile.c |    3 ++-
 include/linux/ide.h        |    8 --------
 3 files changed, 11 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -346,14 +346,20 @@ static int ide_write_setting(ide_drive_t
 
 static int set_xfer_rate (ide_drive_t *drive, int arg)
 {
+	ide_task_t task;
 	int err;
 
 	if (arg < 0 || arg > 70)
 		return -EINVAL;
 
-	err = ide_wait_cmd(drive,
-			WIN_SETFEATURES, (u8) arg,
-			SETFEATURES_XFER, 0, NULL);
+	memset(&task, 0, sizeof(task));
+	task.tf.command = WIN_SETFEATURES;
+	task.tf.feature = SETFEATURES_XFER;
+	task.tf.nsect   = (u8)arg;
+	task.tf_flags = IDE_TFLAG_OUT_FEATURE | IDE_TFLAG_OUT_NSECT |
+			IDE_TFLAG_IN_NSECT;
+
+	err = ide_no_data_taskfile(drive, &task);
 
 	if (!err && arg) {
 		ide_set_xfer_rate(drive, (u8) arg);
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -751,7 +751,8 @@ abort:
 }
 #endif
 
-int ide_wait_cmd (ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8 sectors, u8 *buf)
+static int ide_wait_cmd(ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature,
+			u8 sectors, u8 *buf)
 {
 	struct request rq;
 	u8 buffer[4];
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -870,14 +870,6 @@ extern int ide_do_drive_cmd(ide_drive_t 
 
 extern void ide_end_drive_cmd(ide_drive_t *, u8, u8);
 
-/*
- * Issue ATA command and wait for completion.
- * Use for implementing commands in kernel
- *
- *  (ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8 sectors, u8 *buf)
- */
-extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
-
 enum {
 	IDE_TFLAG_LBA48			= (1 << 0),
 	IDE_TFLAG_NO_SELECT_MASK	= (1 << 1),
