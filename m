From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Current git --> kaboom [bisect] seems IDE related.
Date: Sun, 10 Feb 2008 14:38:46 +0100
Message-ID: <200802101438.46698.bzolnier@gmail.com>
References: <20080209193224.GA21448@Chamillionaire.breakpoint.cc> <200802100006.11086.bzolnier@gmail.com> <20080210052621.GA22257@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:36418 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYBJN0Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 08:26:16 -0500
Received: by py-out-1112.google.com with SMTP id u52so6317325pyb.10
        for <linux-ide@vger.kernel.org>; Sun, 10 Feb 2008 05:26:15 -0800 (PST)
In-Reply-To: <20080210052621.GA22257@infradead.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Sebastian Siewior <ide+bug@ml.breakpoint.cc>, Tejun Heo <htejun@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@hansenpartnership.com>

On Sunday 10 February 2008, Christoph Hellwig wrote:
> On Sun, Feb 10, 2008 at 12:06:10AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > >Please try booting with "hdx=noflush" kernel parameter or please try
> > > >the attached patch which should fix the issue (if my theory is correct).
> 
> "hda=noflush hdb=noflush hdd=noflush" fixes the qemu setup for me.

Thanks for testing.

> > Thanks, I see now that there can be > 1 flush request queued at a given time.
> > 
> > Please dump the old patch and try this one.
> > 
> > [ Christoph: this may also fix your qemu/kvm+xfs problem. ]
> 
> It doesn't hang anymore but gives me the following oops instead (that is
> after fixing the build as the bigger request->cmd breaks the scsi
> build):

[...]

The OOPS is most likely (again) my fault - I was rushing out to push out
the fix and memset() line didn't get converted.

I prepared the new patch, documented it and started looking into SCSI
build breakage... and I no longer feel comfortable with the hack :(

It seems that fixing IDE properly will be easier than auditing the whole
SCSI for all the weird assumptions on rq->cmd[] size (James?) so I'm back
to the code, in the meantime here's the updated patch:


From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-disk: fix flush requests

commit 813a0eb233ee67d7166241a8b389b6a76f2247f9
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Fri Jan 25 22:17:10 2008 +0100

    ide: switch idedisk_prepare_flush() to use REQ_TYPE_ATA_TASKFILE requests

...

broke flush requests.

Allocating IDE command structure on the stack for flush requests is not
a very brilliant idea:

- idedisk_prepare_flush() only prepares the request and it doesn't wait
  for it to be completed

- there are can be multiple flush requests queued in the queue

Fix it by temporarily increasing size of BLK_MAX_CDB to accomodate for
ide_task_t structure if IDE subsystem is going to be used.

[ Jens: This will be fixed properly before 2.6.25 but this bug is rather
  critical and the proper solution requires some more work + testing. ]

Thanks to Sebastian Siewior for bisecting/reporting the problem.

Cc: Sebastian Siewior <ide-bug@ml.breakpoint.cc>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com> 
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   14 +++++++-------
 include/linux/blkdev.h |    5 +++++
 2 files changed, 12 insertions(+), 7 deletions(-)

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
 
-	memset(&task, 0, sizeof(task));
+	memset(task, 0, sizeof(*task));
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
