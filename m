From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: move request type specific code from ide_end_drive_cmd() to callers (v2)
Date: Tue, 10 Feb 2009 22:52:12 +0100
Message-ID: <200902102252.13101.bzolnier@gmail.com>
References: <200902052129.40866.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757157AbZBJVv6@vger.kernel.org>
In-Reply-To: <200902052129.40866.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@googlemail.com>
List-Id: linux-ide@vger.kernel.org

On Thursday 05 February 2009, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: move request type specific code from ide_end_drive_cmd() to callers (v2)
> 
> * Move request type specific code from ide_end_drive_cmd() to callers.
> 
> * Remove stale ide_end_drive_cmd() documentation and drop no longer
>   used 'stat' argument.  Then rename the function to ide_complete_rq().
> 
> v2:
> * Fix handling of blk_pm_request() requests in task_no_data_intr().

v2->v3 interdiff:

...
v3:
* Some ide_no_data_taskfile() users (HPA code and HDIO_DRIVE_* ioctls
  handlers) access original command later so we need to update it in
  ide_complete_task().
...
diff -u b/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- b/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -147,12 +147,16 @@
 void ide_complete_task(ide_drive_t *drive, ide_task_t *task, u8 stat, u8 err)
 {
 	struct ide_taskfile *tf = &task->tf;
+	struct request *rq = task->rq;
 
 	tf->error = err;
 	tf->status = stat;
 
 	drive->hwif->tp_ops->tf_read(drive, task);
 
+	if (rq && rq->cmd_type == REQ_TYPE_ATA_TASKFILE)
+		memcpy(rq->special, task, sizeof(*task));
+
 	if (task->tf_flags & IDE_TFLAG_DYN)
 		kfree(task);
 }
