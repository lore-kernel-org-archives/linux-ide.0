From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/15] ide: switch ide_task_ioctl() to use REQ_TYPE_ATA_TASKFILE requests
Date: Sat, 27 Oct 2007 19:48:33 +0200
Message-ID: <200710271948.33244.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:9321 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756207AbXJ0Rq4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:56 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1942000mue
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Based on the earlier work by Tejun Heo.

There should be no functionality changes caused by this patch.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -805,28 +805,29 @@ abort:
 	return err;
 }
 
-static int ide_wait_cmd_task(ide_drive_t *drive, u8 *buf)
-{
-	struct request rq;
-
-	ide_init_drive_cmd(&rq);
-	rq.cmd_type = REQ_TYPE_ATA_TASK;
-	rq.buffer = buf;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
-}
-
 int ide_task_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
 	void __user *p = (void __user *)arg;
 	int err = 0;
-	u8 args[7], *argbuf = args;
-	int argsize = 7;
+	u8 args[7];
+	ide_task_t task;
 
 	if (copy_from_user(args, p, 7))
 		return -EFAULT;
-	err = ide_wait_cmd_task(drive, argbuf);
-	if (copy_to_user(p, argbuf, argsize))
+
+	memset(&task, 0, sizeof(task));
+	memcpy(&task.tf_array[7], &args[1], 6);
+	task.tf.command = args[0];
+	task.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+
+	err = ide_no_data_taskfile(drive, &task);
+
+	args[0] = task.tf.command;
+	memcpy(&args[1], &task.tf_array[7], 6);
+
+	if (copy_to_user(p, args, 7))
 		err = -EFAULT;
+
 	return err;
 }
 
