From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
Date: Thu, 24 Feb 2005 15:48:33 +0100 (CET)
Message-ID: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56862 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S51483AbVBXOsl (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 2 others); Thu, 24 Feb 2005 15:48:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org


ide_task_ioctl() rewritten to use taskfile transport.
This is the last user of REQ_DRIVE_TASK.

bart: ported to recent IDE changes by me

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2005-02-24 15:30:02 +01:00
+++ b/drivers/ide/ide-taskfile.c	2005-02-24 15:30:02 +01:00
@@ -777,30 +777,42 @@
 	return err;
 }

-static int ide_wait_cmd_task(ide_drive_t *drive, u8 *buf)
-{
-	struct request rq;
-
-	ide_init_drive_cmd(&rq);
-	rq.flags = REQ_DRIVE_TASK;
-	rq.buffer = buf;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
-}
-
-/*
- * FIXME : this needs to map into at taskfile. <andre@linux-ide.org>
- */
-int ide_task_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
+int ide_task_ioctl(ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
 	void __user *p = (void __user *)arg;
-	int err = 0;
-	u8 args[7], *argbuf = args;
-	int argsize = 7;
+	int err;
+	u8 args[7];
+	ide_task_t task;
+	struct ata_taskfile *tf = &task.tf;

 	if (copy_from_user(args, p, 7))
 		return -EFAULT;
-	err = ide_wait_cmd_task(drive, argbuf);
-	if (copy_to_user(p, argbuf, argsize))
+
+	memset(&task, 0, sizeof(task));
+
+	tf->command	= args[0];
+	tf->feature	= args[1];
+	tf->nsect	= args[2];
+	tf->lbal	= args[3];
+	tf->lbam	= args[4];
+	tf->lbah	= args[5];
+	tf->device	= args[6];
+
+	task.command_type = IDE_DRIVE_TASK_NO_DATA;
+	task.data_phase = TASKFILE_NO_DATA;
+	task.handler = &task_no_data_intr;
+
+	err = ide_diag_taskfile(drive, &task, 0, NULL);
+
+	args[0] = tf->command;
+	args[1] = tf->feature;
+	args[2] = tf->nsect;
+	args[3] = tf->lbal;
+	args[4] = tf->lbam;
+	args[5] = tf->lbah;
+	args[6] = tf->device;
+
+	if (copy_to_user(p, args, 7))
 		err = -EFAULT;
 	return err;
 }
