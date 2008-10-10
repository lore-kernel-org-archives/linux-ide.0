From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 7/7] ide: use queue lock instead of ide_lock when possible
Date: Fri, 10 Oct 2008 13:35:41 +0200
Message-ID: <20081010113541.GB19428@kernel.dk>
References: <20081008202930.19112.90371.sendpatchset@localhost.localdomain> <20081008203027.19112.20883.sendpatchset@localhost.localdomain> <87zllcet7k.fsf@denkblock.local> <20081010085249.GW19428@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:55519 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708AbYJJLgQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Oct 2008 07:36:16 -0400
Content-Disposition: inline
In-Reply-To: <20081010085249.GW19428@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 10 2008, Jens Axboe wrote:
> On Fri, Oct 10 2008, Elias Oltmanns wrote:
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Subject: [PATCH] ide: use queue lock instead of ide_lock when possible
> > >
> > > This is just a preparation for future changes and there should be no
> > > functional changes caused by this patch since ide_lock is currently
> > > also used as queue lock.
> > >
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > ---
> > [...]
> > > Index: b/drivers/ide/ide-io.c
> > > ===================================================================
> > > --- a/drivers/ide/ide-io.c
> > > +++ b/drivers/ide/ide-io.c
> > [...]
> > > @@ -1469,16 +1470,16 @@ out:
> > >  void ide_do_drive_cmd(ide_drive_t *drive, struct request *rq)
> > >  {
> > >  	ide_hwgroup_t *hwgroup = drive->hwif->hwgroup;
> > > +	struct request_queue *q = drive->queue;
> > >  	unsigned long flags;
> > >  
> > >  	hwgroup->rq = NULL;
> > >  
> > > -	spin_lock_irqsave(&ide_lock, flags);
> > > -	__elv_add_request(drive->queue, rq, ELEVATOR_INSERT_FRONT, 1);
> > > -	__generic_unplug_device(drive->queue);
> > > -	spin_unlock_irqrestore(&ide_lock, flags);
> > > +	spin_lock_irqsave(q->queue_lock, flags);
> > > +	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 1);
> > > +	__generic_unplug_device(q);
> > 
> > By the way, wouldn't blk_run_queue() be more appropriate here? It looks
> > to me as if blk_run_queue() was the thing intended for general usage by
> > low level drivers who don't know and care about schedulers, whereas the
> > usage of __generic_unplug_device() should mostly be restricted to the
> > block layer. On the other hand, there are other drivers in
> > drivers/block/ that use __generic_unplug_device(), so I may well be
> > wrong. Jens?
> 
> Yes, that is correct. But it's ok for now, there are too many variants
> of this around as it is already. I'm about to do a run and clean them up
> and make sure we have a single sane way of doing it that is exported.

So the right thing to do here is:

        __elv_add_request(drive->queue, rq, ELEVATOR_INSERT_FRONT, 0);
        blk_start_queueing(drive->queue);

since you don't need to do any plugging.

-- 
Jens Axboe

