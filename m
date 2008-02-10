From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Current git --> kaboom [bisect] seems IDE related.
Date: Sun, 10 Feb 2008 19:32:06 +0100
Message-ID: <200802101932.06946.bzolnier@gmail.com>
References: <20080209193224.GA21448@Chamillionaire.breakpoint.cc> <200802101438.46698.bzolnier@gmail.com> <1202653165.3136.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:8958 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbYBJSXP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 13:23:15 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4515985wxd.4
        for <linux-ide@vger.kernel.org>; Sun, 10 Feb 2008 10:23:14 -0800 (PST)
In-Reply-To: <1202653165.3136.18.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christoph Hellwig <hch@infradead.org>, Sebastian Siewior <ide+bug@ml.breakpoint.cc>, Tejun Heo <htejun@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Sunday 10 February 2008, James Bottomley wrote:
> On Sun, 2008-02-10 at 14:38 +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 10 February 2008, Christoph Hellwig wrote:
> > > On Sun, Feb 10, 2008 at 12:06:10AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > > >Please try booting with "hdx=noflush" kernel parameter or please try
> > > > > >the attached patch which should fix the issue (if my theory is correct).
> > > 
> > > "hda=noflush hdb=noflush hdd=noflush" fixes the qemu setup for me.
> > 
> > Thanks for testing.
> > 
> > > > Thanks, I see now that there can be > 1 flush request queued at a given time.
> > > > 
> > > > Please dump the old patch and try this one.
> > > > 
> > > > [ Christoph: this may also fix your qemu/kvm+xfs problem. ]
> > > 
> > > It doesn't hang anymore but gives me the following oops instead (that is
> > > after fixing the build as the bigger request->cmd breaks the scsi
> > > build):
> > 
> > [...]
> > 
> > The OOPS is most likely (again) my fault - I was rushing out to push out
> > the fix and memset() line didn't get converted.
> > 
> > I prepared the new patch, documented it and started looking into SCSI
> > build breakage... and I no longer feel comfortable with the hack :(
> > 
> > It seems that fixing IDE properly will be easier than auditing the whole
> > SCSI for all the weird assumptions on rq->cmd[] size (James?) so I'm back
> > to the code, in the meantime here's the updated patch:
> 
> Doing something like this would have to be audited in SCSI ... we do
> assume sizeof(rq->cmd) == sizeof(scmd->cmnd) which will no longer be
> true.  As long as sizeof(rq->cmd) is never used in SCSI code, it's
> probably safe.
> 
> Although raising MAX_CDB by a factor of three has memory concerns as
> well, which aren't trivial and make this a bit too much of a hack.  It's
> also incredibly fragile given that either ide_task_t could increase in
> size or someone could reduce MAX_CDB both with fatal consequences.
> 
> Why not just use kmalloc(GFP_ATOMIC) instead?  That will succeed 99% of
> the time and you can turn barriers off in a failure case.  You'll have

It seems to be too late to turn barriers off as all of the above happens
_inside_ prepare_flush_fn function.  Nevertheless this is a much nicer
workaround and it should be sufficent for the time being - thanks James!

> to free it in ide_end_drive_cmd(), but I think you've got (just) a spare
> tf_flag to mark a volatile task that needs kfree here.

My precious last tf_flag... fortunately some other ones can be recycled...

Sebastian/Christoph, please test the final patch (after your ACK I'll push
it to Linus together with the rest of pending IDE fixes).


From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-disk: fix flush requests (take 2)

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

Fix the problem (per hints from James Bottomley) by:
- dynamically allocating ide_task_t instance using kmalloc(..., GFP_ATOMIC)
- adding new taskfile flag (IDE_TFLAG_DYN)
- calling kfree() in ide_end_drive_command() if IDE_TFLAG_DYN is set
  (while at it rename 'args' to 'task' and fix whitespace damage)

[ This will be fixed properly before 2.6.25 but this bug is rather
  critical and the proper solution requires some more work + testing. ]

Thanks to Sebastian Siewior and Christoph Hellwig for reporitng the
problem and testing patches (extra thanks to Sebastian for bisecting
it to the guilty commmit).

Cc: Sebastian Siewior <ide-bug@ml.breakpoint.cc>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   18 +++++++++++-------
 drivers/ide/ide-io.c   |   16 ++++++++++------
 include/linux/ide.h    |    2 ++
 3 files changed, 23 insertions(+), 13 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -590,20 +590,24 @@ static ide_proc_entry_t idedisk_proc[] =
 static void idedisk_prepare_flush(struct request_queue *q, struct request *rq)
 {
 	ide_drive_t *drive = q->queuedata;
-	ide_task_t task;
+	ide_task_t *task = kmalloc(sizeof(*task), GFP_ATOMIC);
 
-	memset(&task, 0, sizeof(task));
+	/* FIXME: map struct ide_taskfile on rq->cmd[] */
+	BUG_ON(task == NULL);
+
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
+	task->tf_flags	 = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE |
+			   IDE_TFLAG_DYN;
+	task->data_phase = TASKFILE_NO_DATA;
 
 	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 	rq->cmd_flags |= REQ_SOFTBARRIER;
-	rq->special = &task;
+	rq->special = task;
 }
 
 /*
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -361,17 +361,21 @@ void ide_end_drive_cmd (ide_drive_t *dri
 	spin_unlock_irqrestore(&ide_lock, flags);
 
 	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
-		ide_task_t *args = (ide_task_t *) rq->special;
+		ide_task_t *task = (ide_task_t *)rq->special;
+
 		if (rq->errors == 0)
-			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
-			
-		if (args) {
-			struct ide_taskfile *tf = &args->tf;
+			rq->errors = !OK_STAT(stat, READY_STAT, BAD_STAT);
+
+		if (task) {
+			struct ide_taskfile *tf = &task->tf;
 
 			tf->error = err;
 			tf->status = stat;
 
-			ide_tf_read(drive, args);
+			ide_tf_read(drive, task);
+
+			if (task->tf_flags & IDE_TFLAG_DYN)
+				kfree(task);
 		}
 	} else if (blk_pm_request(rq)) {
 		struct request_pm_state *pm = rq->data;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -906,6 +906,8 @@ enum {
 					  IDE_TFLAG_IN_DEVICE,
 	/* force 16-bit I/O operations */
 	IDE_TFLAG_IO_16BIT		= (1 << 30),
+	/* ide_task_t was allocated using kmalloc() */
+	IDE_TFLAG_DYN			= (1 << 31),
 };
 
 struct ide_taskfile {
