From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Current git --> kaboom [bisect] seems IDE related.
Date: Sun, 10 Feb 2008 00:06:10 +0100
Message-ID: <200802100006.11086.bzolnier@gmail.com>
References: <20080209193224.GA21448@Chamillionaire.breakpoint.cc> <200802092128.39247.bzolnier@gmail.com> <20080209212237.GA22582@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:48677 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbYBIWx3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 17:53:29 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3303944fga.17
        for <linux-ide@vger.kernel.org>; Sat, 09 Feb 2008 14:53:27 -0800 (PST)
In-Reply-To: <20080209212237.GA22582@Chamillionaire.breakpoint.cc>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Siewior <ide+bug@ml.breakpoint.cc>
Cc: Tejun Heo <htejun@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Jens Axboe <jens.axboe@oracle.com>

On Saturday 09 February 2008, Sebastian Siewior wrote:
> * Bartlomiej Zolnierkiewicz | 2008-02-09 21:28:39 [+0100]:
> 
> >It could be that due to block layer changes to I/O barrier handling
> >allocating ATA command structure on the stack is no longer safe.

Update: it was never a very brilliant idea...

> >Please try booting with "hdx=noflush" kernel parameter or please try
> >the attached patch which should fix the issue (if my theory is correct).
> That was quick.
> hdx=noflush worked well. The patch delayed the disk access as you can
> see in [1]. After the IPI message the hd led enlightened and was
> active until "lost interrupt" message. The following boot process was
> verry slow. Basically everything what required disk access took a while
> and the hd-led was almost continuous on. I aborted the boot process via
> magic keys after about 15 minutes.
> 
> [1] http://download.breakpoint.cc/lnx-2.6.24-post-long-boot.jpg

Thanks, I see now that there can be > 1 flush request queued at a given time.

Please dump the old patch and try this one.

[ Christoph: this may also fix your qemu/kvm+xfs problem. ]

---
 drivers/ide/ide-disk.c |   12 ++++++------
 include/linux/blkdev.h |    5 +++++
 2 files changed, 11 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -590,20 +590,20 @@ static ide_proc_entry_t idedisk_proc[] =
 static void idedisk_prepare_flush(struct request_queue *q, struct request *rq)
 {
 	ide_drive_t *drive = q->queuedata;
-	ide_task_t task;
+	ide_task_t *task = (ide_task_t *)&rq->cmd[0];
 
 	memset(&task, 0, sizeof(task));
 	if (ide_id_has_flush_cache_ext(drive->id) &&
 	    (drive->capacity64 >= (1UL << 28)))
-		task.tf.command = WIN_FLUSH_CACHE_EXT;
+		task->tf.command = WIN_FLUSH_CACHE_EXT;
 	else
-		task.tf.command = WIN_FLUSH_CACHE;
-	task.tf_flags	= IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
-	task.data_phase	= TASKFILE_NO_DATA;
+		task->tf.command = WIN_FLUSH_CACHE;
+	task->tf_flags	 = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	task->data_phase = TASKFILE_NO_DATA;
 
 	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 	rq->cmd_flags |= REQ_SOFTBARRIER;
-	rq->special = &task;
+	rq->special = task;
 }
 
 /*
Index: b/include/linux/blkdev.h
===================================================================
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -134,7 +134,12 @@ enum rq_flag_bits {
 #define REQ_ALLOCED	(1 << __REQ_ALLOCED)
 #define REQ_RW_META	(1 << __REQ_RW_META)
 
+/* FIXME: temporary hack to make flush requests work */
+#ifdef CONFIG_IDE
+#define BLK_MAX_CDB	48 /* max sizeof(ide_task_t) */
+#else
 #define BLK_MAX_CDB	16
+#endif
 
 /*
  * try to put the fields that are referenced together in the same cacheline.
