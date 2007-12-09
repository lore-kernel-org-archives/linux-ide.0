From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 19/20] ide: switch ide_cmd_ioctl() to use REQ_TYPE_ATA_TASKFILE requests
Date: Sun, 9 Dec 2007 22:22:01 +0100
Message-ID: <200712092222.01490.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:55432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbXLIVVJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:21:09 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381308ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:21:08 -0800 (PST)
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
 drivers/ide/ide-iops.c     |    4 +-
 drivers/ide/ide-taskfile.c |   63 ++++++++++++++++++++++-----------------------
 2 files changed, 33 insertions(+), 34 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -619,7 +619,7 @@ no_80w:
 int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
 {
 	if (args->tf.command == WIN_SETFEATURES &&
-	    args->tf.lbal > XFER_UDMA_2 &&
+	    args->tf.nsect > XFER_UDMA_2 &&
 	    args->tf.feature == SETFEATURES_XFER) {
 		if (eighty_ninty_three(drive) == 0) {
 			printk(KERN_WARNING "%s: UDMA speeds >UDMA33 cannot "
@@ -639,7 +639,7 @@ int ide_ata66_check (ide_drive_t *drive,
 int set_transfer (ide_drive_t *drive, ide_task_t *args)
 {
 	if (args->tf.command == WIN_SETFEATURES &&
-	    args->tf.lbal >= XFER_SW_DMA_0 &&
+	    args->tf.nsect >= XFER_SW_DMA_0 &&
 	    args->tf.feature == SETFEATURES_XFER &&
 	    (drive->id->dma_ultra ||
 	     drive->id->dma_mword ||
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -751,31 +751,11 @@ abort:
 }
 #endif
 
-static int ide_wait_cmd(ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature,
-			u8 sectors, u8 *buf)
-{
-	struct request rq;
-	u8 buffer[4];
-
-	if (!buf)
-		buf = buffer;
-	memset(buf, 0, 4 + SECTOR_WORDS * 4 * sectors);
-	ide_init_drive_cmd(&rq);
-	rq.cmd_type = REQ_TYPE_ATA_CMD;
-	rq.buffer = buf;
-	*buf++ = cmd;
-	*buf++ = nsect;
-	*buf++ = feature;
-	*buf++ = sectors;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
-}
-
 int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
-	int err = 0;
-	u8 args[4], *argbuf = args;
-	u8 xfer_rate = 0;
-	int argsize = 4;
+	u8 *buf = NULL;
+	int bufsize = 0, err = 0;
+	u8 args[4], xfer_rate = 0;
 	ide_task_t tfargs;
 	struct ide_taskfile *tf = &tfargs.tf;
 
@@ -793,23 +773,39 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 
 	memset(&tfargs, 0, sizeof(ide_task_t));
 	tf->feature = args[2];
-	tf->nsect   = args[3];
-	tf->lbal    = args[1];
+	if (args[0] == WIN_SMART) {
+		tf->nsect = args[3];
+		tf->lbal  = args[1];
+		tf->lbam  = 0x4f;
+		tf->lbah  = 0xc2;
+		tfargs.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_IN_NSECT;
+	} else {
+		tf->nsect = args[1];
+		tfargs.tf_flags = IDE_TFLAG_OUT_FEATURE |
+				  IDE_TFLAG_OUT_NSECT | IDE_TFLAG_IN_NSECT;
+	}
 	tf->command = args[0];
+	tfargs.data_phase = args[3] ? TASKFILE_IN : TASKFILE_NO_DATA;
 
 	if (args[3]) {
-		argsize = 4 + (SECTOR_WORDS * 4 * args[3]);
-		argbuf = kzalloc(argsize, GFP_KERNEL);
-		if (argbuf == NULL)
+		tfargs.tf_flags |= IDE_TFLAG_IO_16BIT;
+		bufsize = SECTOR_WORDS * 4 * args[3];
+		buf = kzalloc(bufsize, GFP_KERNEL);
+		if (buf == NULL)
 			return -ENOMEM;
 	}
+
 	if (set_transfer(drive, &tfargs)) {
 		xfer_rate = args[1];
 		if (ide_ata66_check(drive, &tfargs))
 			goto abort;
 	}
 
-	err = ide_wait_cmd(drive, args[0], args[1], args[2], args[3], argbuf);
+	err = ide_raw_taskfile(drive, &tfargs, buf, args[3]);
+
+	args[0] = tf->status;
+	args[1] = tf->error;
+	args[2] = tf->nsect;
 
 	if (!err && xfer_rate) {
 		/* active-retuning-calls future */
@@ -817,10 +813,13 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 		ide_driveid_update(drive);
 	}
 abort:
-	if (copy_to_user((void __user *)arg, argbuf, argsize))
+	if (copy_to_user((void __user *)arg, &args, 4))
 		err = -EFAULT;
-	if (argsize > 4)
-		kfree(argbuf);
+	if (buf) {
+		if (copy_to_user((void __user *)(arg + 4), buf, bufsize))
+			err = -EFAULT;
+		kfree(buf);
+	}
 	return err;
 }
 
