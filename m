From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Current git --> kaboom [bisect] seems IDE related.
Date: Sun, 10 Feb 2008 08:19:25 -0600
Message-ID: <1202653165.3136.18.camel@localhost.localdomain>
References: <20080209193224.GA21448@Chamillionaire.breakpoint.cc>
	 <200802100006.11086.bzolnier@gmail.com>
	 <20080210052621.GA22257@infradead.org>
	 <200802101438.46698.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:53885 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750775AbYBJOTd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 09:19:33 -0500
In-Reply-To: <200802101438.46698.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Sebastian Siewior <ide+bug@ml.breakpoint.cc>, Tejun Heo <htejun@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Sun, 2008-02-10 at 14:38 +0100, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 10 February 2008, Christoph Hellwig wrote:
> > On Sun, Feb 10, 2008 at 12:06:10AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > >Please try booting with "hdx=noflush" kernel parameter or please try
> > > > >the attached patch which should fix the issue (if my theory is correct).
> > 
> > "hda=noflush hdb=noflush hdd=noflush" fixes the qemu setup for me.
> 
> Thanks for testing.
> 
> > > Thanks, I see now that there can be > 1 flush request queued at a given time.
> > > 
> > > Please dump the old patch and try this one.
> > > 
> > > [ Christoph: this may also fix your qemu/kvm+xfs problem. ]
> > 
> > It doesn't hang anymore but gives me the following oops instead (that is
> > after fixing the build as the bigger request->cmd breaks the scsi
> > build):
> 
> [...]
> 
> The OOPS is most likely (again) my fault - I was rushing out to push out
> the fix and memset() line didn't get converted.
> 
> I prepared the new patch, documented it and started looking into SCSI
> build breakage... and I no longer feel comfortable with the hack :(
> 
> It seems that fixing IDE properly will be easier than auditing the whole
> SCSI for all the weird assumptions on rq->cmd[] size (James?) so I'm back
> to the code, in the meantime here's the updated patch:

Doing something like this would have to be audited in SCSI ... we do
assume sizeof(rq->cmd) == sizeof(scmd->cmnd) which will no longer be
true.  As long as sizeof(rq->cmd) is never used in SCSI code, it's
probably safe.

Although raising MAX_CDB by a factor of three has memory concerns as
well, which aren't trivial and make this a bit too much of a hack.  It's
also incredibly fragile given that either ide_task_t could increase in
size or someone could reduce MAX_CDB both with fatal consequences.

Why not just use kmalloc(GFP_ATOMIC) instead?  That will succeed 99% of
the time and you can turn barriers off in a failure case.  You'll have
to free it in ide_end_drive_cmd(), but I think you've got (just) a spare
tf_flag to mark a volatile task that needs kfree here.

James


