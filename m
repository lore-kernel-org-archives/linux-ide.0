From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/15] ide: remove 'command_type' field from ide_task_t
Date: Wed, 31 Oct 2007 00:55:17 +0100
Message-ID: <200710310055.17380.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:46854 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbXJ3Xuc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:32 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788152nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add 'data_buf' and 'nsect' variables in ide_taskfile_ioctl()
  to cache data buffer pointer and number of sectors to transfer
  (this allows us to have only one ide_diag_taskfile() call).

* Add IDE_TFLAG_WRITE taskfile flag and use it to check whether
  the REQ_RW request flag should be set.

* Move ->command_type handling from ide_diag_taskfile() to
  ide_taskfile_ioctl() and use ->req_cmd instead of ->command_type.

* Add 'nsect' parameter to ide_raw_taskfile().

* Merge ide_diag_taskfile() into ide_raw_taskfile().

* Initialize ->data_phase explicitly in idedisk_prepare_flush(),
  ide_start_power_step() and ide_disk_special().

* Remove no longer needed 'command_type' field from ide_task_t.

* Add #ifndef/#endif __KERNEL__ to <linux/hdreg.h> around no
  longer used by kernel IDE_DRIVE_TASK_* and TASKFILE_* defines.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c     |   15 +++----
 drivers/ide/ide-io.c       |    8 ++--
 drivers/ide/ide-taskfile.c |   89 ++++++++++++++++++++++-----------------------
 include/linux/hdreg.h      |   13 +++---
 include/linux/ide.h        |    5 +-
 5 files changed, 64 insertions(+), 66 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -542,12 +542,11 @@ static int get_smart_data(ide_drive_t *d
 	tf->lbam    = SMART_LCYL_PASS;
 	tf->lbah    = SMART_HCYL_PASS;
 	tf->command = WIN_SMART;
-	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
-	args.command_type			= IDE_DRIVE_TASK_IN;
-	args.data_phase				= TASKFILE_IN;
-	args.handler				= &task_in_intr;
+	args.tf_flags	= IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.data_phase	= TASKFILE_IN;
+	args.handler	= task_in_intr;
 	(void) smart_enable(drive);
-	return ide_raw_taskfile(drive, &args, buf);
+	return ide_raw_taskfile(drive, &args, buf, 1);
 }
 
 static int proc_idedisk_read_cache
@@ -633,9 +632,9 @@ static void idedisk_prepare_flush(struct
 		task.tf.command = WIN_FLUSH_CACHE_EXT;
 	else
 		task.tf.command = WIN_FLUSH_CACHE;
-	task.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
-	task.command_type = IDE_DRIVE_TASK_NO_DATA;
-	task.handler = task_no_data_intr;
+	task.tf_flags	= IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	task.data_phase	= TASKFILE_NO_DATA;
+	task.handler	= task_no_data_intr;
 
 	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 	rq->cmd_flags |= REQ_SOFTBARRIER;
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -232,9 +232,9 @@ static ide_startstop_t ide_start_power_s
 	return ide_stopped;
 
 out_do_tf:
-	args->tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
-	args->command_type = IDE_DRIVE_TASK_NO_DATA;
-	args->handler      = task_no_data_intr;
+	args->tf_flags	 = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args->data_phase = TASKFILE_NO_DATA;
+	args->handler	 = task_no_data_intr;
 	return do_rw_taskfile(drive, args);
 }
 
@@ -672,7 +672,7 @@ static ide_startstop_t ide_disk_special(
 	ide_task_t args;
 
 	memset(&args, 0, sizeof(ide_task_t));
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase = TASKFILE_NO_DATA;
 
 	if (s->b.set_geometry) {
 		s->b.set_geometry = 0;
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -126,11 +126,10 @@ int taskfile_lib_get_identify (ide_drive
 		args.tf.command = WIN_IDENTIFY;
 	else
 		args.tf.command = WIN_PIDENTIFY;
-	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
-	args.command_type = IDE_DRIVE_TASK_IN;
-	args.data_phase   = TASKFILE_IN;
-	args.handler	  = &task_in_intr;
-	return ide_raw_taskfile(drive, &args, buf);
+	args.tf_flags	= IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.data_phase	= TASKFILE_IN;
+	args.handler	= task_in_intr;
+	return ide_raw_taskfile(drive, &args, buf, 1);
 }
 
 static int inline task_dma_ok(ide_task_t *task)
@@ -499,7 +498,7 @@ ide_startstop_t pre_task_out_intr (ide_d
 }
 EXPORT_SYMBOL(pre_task_out_intr);
 
-static int ide_diag_taskfile(ide_drive_t *drive, ide_task_t *args, unsigned long data_size, u8 *buf)
+int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *task, u8 *buf, u16 nsect)
 {
 	struct request rq;
 
@@ -514,44 +513,26 @@ static int ide_diag_taskfile(ide_drive_t
 	 * if we would find a solution to transfer any size.
 	 * To support special commands like READ LONG.
 	 */
-	if (args->command_type != IDE_DRIVE_TASK_NO_DATA) {
-		if (data_size == 0)
-			rq.nr_sectors = (args->tf.hob_nsect << 8) | args->tf.nsect;
-		else
-			rq.nr_sectors = data_size / SECTOR_SIZE;
-
-		if (!rq.nr_sectors) {
-			printk(KERN_ERR "%s: in/out command without data\n",
-					drive->name);
-			return -EFAULT;
-		}
+	rq.hard_nr_sectors = rq.nr_sectors = nsect;
+	rq.hard_cur_sectors = rq.current_nr_sectors = nsect;
 
-		rq.hard_nr_sectors = rq.nr_sectors;
-		rq.hard_cur_sectors = rq.current_nr_sectors = rq.nr_sectors;
+	if (task->tf_flags & IDE_TFLAG_WRITE)
+		rq.cmd_flags |= REQ_RW;
 
-		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-			rq.cmd_flags |= REQ_RW;
-	}
+	rq.special = task;
+	task->rq = &rq;
 
-	rq.special = args;
-	args->rq = &rq;
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
-int ide_raw_taskfile (ide_drive_t *drive, ide_task_t *args, u8 *buf)
-{
-	return ide_diag_taskfile(drive, args, 0, buf);
-}
-
 EXPORT_SYMBOL(ide_raw_taskfile);
 
 int ide_no_data_taskfile(ide_drive_t *drive, ide_task_t *task)
 {
-	task->command_type = IDE_DRIVE_TASK_NO_DATA;
-	task->data_phase   = TASKFILE_NO_DATA;
-	task->handler      = task_no_data_intr;
+	task->data_phase = TASKFILE_NO_DATA;
+	task->handler    = task_no_data_intr;
 
-	return ide_raw_taskfile(drive, task, NULL);
+	return ide_raw_taskfile(drive, task, NULL, 0);
 }
 
 EXPORT_SYMBOL_GPL(ide_no_data_taskfile);
@@ -562,10 +543,12 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	ide_task_t		args;
 	u8 *outbuf		= NULL;
 	u8 *inbuf		= NULL;
+	u8 *data_buf		= NULL;
 	int err			= 0;
 	int tasksize		= sizeof(struct ide_task_request_s);
 	unsigned int taskin	= 0;
 	unsigned int taskout	= 0;
+	u16 nsect		= 0;
 	u8 io_32bit		= drive->io_32bit;
 	char __user *buf = (char __user *)arg;
 
@@ -618,7 +601,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	memcpy(&args.tf_array[6], req_task->io_ports, HDIO_DRIVE_TASK_HDR_SIZE);
 	args.tf_in_flags  = req_task->in_flags;
 	args.data_phase   = req_task->data_phase;
-	args.command_type = req_task->req_cmd;
 
 	args.tf_flags = IDE_TFLAG_OUT_DEVICE;
 	if (drive->addressing == 1)
@@ -657,14 +639,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 
 	drive->io_32bit = 0;
 	switch(req_task->data_phase) {
-		case TASKFILE_OUT_DMAQ:
-		case TASKFILE_OUT_DMA:
-			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
-			break;
-		case TASKFILE_IN_DMAQ:
-		case TASKFILE_IN_DMA:
-			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
-			break;
 		case TASKFILE_MULTI_OUT:
 			if (!drive->mult_count) {
 				/* (hs): give up if multcount is not set */
@@ -678,7 +652,11 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 		case TASKFILE_OUT:
 			args.prehandler = &pre_task_out_intr;
 			args.handler = &task_out_intr;
-			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
+			/* fall through */
+		case TASKFILE_OUT_DMAQ:
+		case TASKFILE_OUT_DMA:
+			nsect = taskout / SECTOR_SIZE;
+			data_buf = outbuf;
 			break;
 		case TASKFILE_MULTI_IN:
 			if (!drive->mult_count) {
@@ -692,17 +670,38 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 			/* fall through */
 		case TASKFILE_IN:
 			args.handler = &task_in_intr;
-			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
+			/* fall through */
+		case TASKFILE_IN_DMAQ:
+		case TASKFILE_IN_DMA:
+			nsect = taskin / SECTOR_SIZE;
+			data_buf = inbuf;
 			break;
 		case TASKFILE_NO_DATA:
 			args.handler = &task_no_data_intr;
-			err = ide_diag_taskfile(drive, &args, 0, NULL);
 			break;
 		default:
 			err = -EFAULT;
 			goto abort;
 	}
 
+	if (req_task->req_cmd == IDE_DRIVE_TASK_NO_DATA)
+		nsect = 0;
+	else if (!nsect) {
+		nsect = (args.tf.hob_nsect << 8) | args.tf.nsect;
+
+		if (!nsect) {
+			printk(KERN_ERR "%s: in/out command without data\n",
+					drive->name);
+			err = -EFAULT;
+			goto abort;
+		}
+	}
+
+	if (req_task->req_cmd == IDE_DRIVE_TASK_RAW_WRITE)
+		args.tf_flags |= IDE_TFLAG_WRITE;
+
+	err = ide_raw_taskfile(drive, &args, data_buf, nsect);
+
 	memcpy(req_task->hob_ports, &args.tf_array[0], HDIO_DRIVE_HOB_HDR_SIZE - 2);
 	memcpy(req_task->io_ports, &args.tf_array[6], HDIO_DRIVE_TASK_HDR_SIZE);
 	req_task->in_flags  = args.tf_in_flags;
Index: b/include/linux/hdreg.h
===================================================================
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -70,13 +70,13 @@
 #define HDIO_DRIVE_HOB_HDR_SIZE		(8 * sizeof(__u8))
 #define HDIO_DRIVE_TASK_HDR_SIZE	(8 * sizeof(__u8))
 
-#define IDE_DRIVE_TASK_INVALID		-1
 #define IDE_DRIVE_TASK_NO_DATA		0
+#ifndef __KERNEL__
+#define IDE_DRIVE_TASK_INVALID		-1
 #define IDE_DRIVE_TASK_SET_XFER		1
-
 #define IDE_DRIVE_TASK_IN		2
-
 #define IDE_DRIVE_TASK_OUT		3
+#endif
 #define IDE_DRIVE_TASK_RAW_WRITE	4
 
 /*
@@ -163,9 +163,6 @@ typedef struct hd_drive_hob_hdr {
 } hob_struct_t;
 #endif
 
-#define TASKFILE_INVALID		0x7fff
-#define TASKFILE_48			0x8000
-
 #define TASKFILE_NO_DATA		0x0000
 
 #define TASKFILE_IN			0x0001
@@ -180,12 +177,16 @@ typedef struct hd_drive_hob_hdr {
 #define TASKFILE_IN_DMAQ		0x0080
 #define TASKFILE_OUT_DMAQ		0x0100
 
+#ifndef __KERNEL__
 #define TASKFILE_P_IN			0x0200
 #define TASKFILE_P_OUT			0x0400
 #define TASKFILE_P_IN_DMA		0x0800
 #define TASKFILE_P_OUT_DMA		0x1000
 #define TASKFILE_P_IN_DMAQ		0x2000
 #define TASKFILE_P_OUT_DMAQ		0x4000
+#define TASKFILE_48			0x8000
+#define TASKFILE_INVALID		0x7fff
+#endif
 
 /* ATA/ATAPI Commands pre T13 Spec */
 #define WIN_NOP				0x00
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -916,6 +916,7 @@ enum {
 					  IDE_TFLAG_OUT_LBAM |
 					  IDE_TFLAG_OUT_LBAH,
 	IDE_TFLAG_OUT_DEVICE		= (1 << 14),
+	IDE_TFLAG_WRITE			= (1 << 15),
 };
 
 struct ide_taskfile {
@@ -955,7 +956,6 @@ typedef struct ide_task_s {
 	u16			tf_flags;
 	ide_reg_valid_t		tf_in_flags;
 	int			data_phase;
-	int			command_type;
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
 	struct request		*rq;		/* copy of request */
@@ -990,8 +990,7 @@ extern ide_startstop_t task_no_data_intr
 extern ide_startstop_t task_in_intr(ide_drive_t *);
 extern ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request *);
 
-extern int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *);
-
+int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *, u16);
 int ide_no_data_taskfile(ide_drive_t *, ide_task_t *);
 
 int ide_taskfile_ioctl(ide_drive_t *, unsigned int, unsigned long);
