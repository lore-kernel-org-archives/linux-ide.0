From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/15] ide: remove 'tf_in_flags' field from ide_task_t
Date: Wed, 31 Oct 2007 00:55:22 +0100
Message-ID: <200710310055.22468.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:45624 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182AbXJ3Xub (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:31 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788114nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add IDE_TFLAG_IN_DATA taskfile flag to indicate the need of reading
  IDE_DATA_REG in ide_end_drive_cmd().

  Set the new flag in ide_taskfile_ioctl() if ->in_flags.b.data is set.

* Add IDE_TFLAG_FLAGGED_SET_IN_FLAGS taskfile flag to indicate the
  need of modifying ->in_flags in ide_taskfile_ioctl().

  Set the new flag in flagged_taskfile() and move the code modifying
  ->tf_in_flags to ide_taskfile_ioctl().

  While at it remove the bogus comment: ->tf_in_flags (except .b.data)
  have no effect on selection of registers to read.

* Remove no longer needed 'tf_in_flags' field from ide_task_t.

As the result we finally have the internals of HDIO_DRIVE_TASKFILE ioctl
separated from the core IDE code.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c       |    2 +-
 drivers/ide/ide-taskfile.c |   29 +++++++++++++----------------
 include/linux/ide.h        |    5 +++--
 3 files changed, 17 insertions(+), 19 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -340,7 +340,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 		if (args) {
 			struct ide_taskfile *tf = &args->tf;
 
-			if (args->tf_in_flags.b.data) {
+			if (args->tf_flags & IDE_TFLAG_IN_DATA) {
 				u16 data = hwif->INW(IDE_DATA_REG);
 
 				tf->data = data & 0xff;
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -599,8 +599,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 
 	memcpy(&args.tf_array[0], req_task->hob_ports, HDIO_DRIVE_HOB_HDR_SIZE - 2);
 	memcpy(&args.tf_array[6], req_task->io_ports, HDIO_DRIVE_TASK_HDR_SIZE);
-	args.tf_in_flags  = req_task->in_flags;
-	args.data_phase   = req_task->data_phase;
+
+	args.data_phase = req_task->data_phase;
 
 	args.tf_flags = IDE_TFLAG_OUT_DEVICE;
 	if (drive->addressing == 1)
@@ -637,6 +637,9 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 			args.tf_flags |= IDE_TFLAG_OUT_HOB;
 	}
 
+	if (req_task->in_flags.b.data)
+		args.tf_flags |= IDE_TFLAG_IN_DATA;
+
 	drive->io_32bit = 0;
 	switch(req_task->data_phase) {
 		case TASKFILE_MULTI_OUT:
@@ -704,7 +707,13 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 
 	memcpy(req_task->hob_ports, &args.tf_array[0], HDIO_DRIVE_HOB_HDR_SIZE - 2);
 	memcpy(req_task->io_ports, &args.tf_array[6], HDIO_DRIVE_TASK_HDR_SIZE);
-	req_task->in_flags  = args.tf_in_flags;
+
+	if ((args.tf_flags & IDE_TFLAG_FLAGGED_SET_IN_FLAGS) &&
+	    req_task->in_flags.all == 0) {
+		req_task->in_flags.all = IDE_TASKFILE_STD_IN_FLAGS;
+		if (drive->addressing == 1)
+			req_task->in_flags.all |= (IDE_HOB_STD_IN_FLAGS << 8);
+	}
 
 	if (copy_to_user(buf, req_task, tasksize)) {
 		err = -EFAULT;
@@ -845,19 +854,7 @@ ide_startstop_t flagged_taskfile (ide_dr
 		}
 	}
 
-	/*
-	 * (ks) Check taskfile in flags.
-	 * If set, then execute as it is defined.
-	 * If not set, then define default settings.
-	 * The default values are:
-	 *	read all taskfile registers (except data)
-	 *	read the hob registers (sector, nsector, lcyl, hcyl)
-	 */
-	if (task->tf_in_flags.all == 0) {
-		task->tf_in_flags.all = IDE_TASKFILE_STD_IN_FLAGS;
-		if (drive->addressing == 1)
-			task->tf_in_flags.all |= (IDE_HOB_STD_IN_FLAGS  << 8);
-        }
+	task->tf_flags |= IDE_TFLAG_FLAGGED_SET_IN_FLAGS;
 
 	return do_rw_taskfile(drive, task);
 }
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -917,6 +917,8 @@ enum {
 					  IDE_TFLAG_OUT_LBAH,
 	IDE_TFLAG_OUT_DEVICE		= (1 << 14),
 	IDE_TFLAG_WRITE			= (1 << 15),
+	IDE_TFLAG_FLAGGED_SET_IN_FLAGS	= (1 << 16),
+	IDE_TFLAG_IN_DATA		= (1 << 17),
 };
 
 struct ide_taskfile {
@@ -953,8 +955,7 @@ typedef struct ide_task_s {
 		struct ide_taskfile	tf;
 		u8			tf_array[14];
 	};
-	u16			tf_flags;
-	ide_reg_valid_t		tf_in_flags;
+	u32			tf_flags;
 	int			data_phase;
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
