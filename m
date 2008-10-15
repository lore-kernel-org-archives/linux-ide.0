From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: don't execute the next queued command from the hard-IRQ context
Date: Wed, 15 Oct 2008 21:06:45 +0200
Message-ID: <200810152106.45728.bzolnier@gmail.com>
References: <200810111617.51298.bzolnier@gmail.com> <874p3hd74p.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:59673 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbYJOTuT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 15:50:19 -0400
Received: by gv-out-0910.google.com with SMTP id e6so701047gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 12:50:18 -0700 (PDT)
In-Reply-To: <874p3hd74p.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 12 October 2008, Elias Oltmanns wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: don't execute the next queued command from the hard-IRQ context
> >
> > * Tell the block layer that we are not done handling requests by using
> >   blk_plug_device() in ide_do_request() (request handling function)
> >   and ide_timer_expiry() (timeout handler) if the queue is not empty.
> >
> > * Remove optimization which directly calls ide_do_request() for the next
> >   queued command from the ide_intr() (IRQ handler) and ide_timer_expiry().
> >
> > * Remove no longer needed IRQ masking from ide_do_request() - in case of
> >   IDE ports needing serialization disable_irq_nosync()/enable_irq() was
> >   used for the (possibly shared) IRQ of the other IDE port.
> >
> > * Put the misplaced comment in the right place in ide_do_request().
> >
> > * Drop no longer needed 'int masked_irq' argument from ide_do_request().
> >
> > * Merge ide_do_request() into do_ide_request().
> >
> > * Remove no longer needed IDE_NO_IRQ define.
> >
> > While at it:
> >
> > * Don't use HWGROUP() macro in do_ide_request().
> >
> > * Use __func__ in ide_intr().
> >
> > This patch reduces IRQ hadling latency for IDE and improves the system-wide
> > handling of shared IRQs (which should result in more timeout resistant and
> > stable IDE systems).  It also makes it possible to do some further changes
> > later (i.e. replace some busy-waiting delays with sleeping equivalents).
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> > on top of per-hwgroup locks patch and with a special dedication to people
> > complaining about improving IDE ;)
> 
> Some comments / questions. Admittedly, I don't always know enough about
> the things I'm talking about here, but I'm hoping to learn something
> that way ;-).
> 
> [...]
> > Index: b/drivers/ide/ide-io.c
> > ===================================================================
> > --- a/drivers/ide/ide-io.c
> > +++ b/drivers/ide/ide-io.c
> [...]
> > @@ -999,8 +1001,11 @@ static void ide_do_request (ide_hwgroup_
> >  			}
> >  
> >  			/* no more work for this hwgroup (for now) */
> > -			return;
> > +			goto plug_device;
> >  		}
> > +
> > +		if (drive != orig_drive)
> > +			goto plug_device;
> >  	again:
> >  		hwif = HWIF(drive);
> 
> Didn't you want to get rid of HWIF() too?

Fixed.

> >  		if (hwgroup->hwif->sharing_irq && hwif != hwgroup->hwif) {
> > @@ -1055,41 +1060,27 @@ static void ide_do_request (ide_hwgroup_
> >  				goto again;
> >  			/* We clear busy, there should be no pending ATA command at this point. */
> >  			hwgroup->busy = 0;
> > -			break;
> > +			goto plug_device;
> >  		}
> >  
> >  		hwgroup->rq = rq;
> >  
> > -		/*
> > -		 * Some systems have trouble with IDE IRQs arriving while
> > -		 * the driver is still setting things up.  So, here we disable
> > -		 * the IRQ used by this interface while the request is being started.
> > -		 * This may look bad at first, but pretty much the same thing
> > -		 * happens anyway when any interrupt comes in, IDE or otherwise
> > -		 *  -- the kernel masks the IRQ while it is being handled.
> > -		 */
> > -		if (masked_irq != IDE_NO_IRQ && hwif->irq != masked_irq)
> > -			disable_irq_nosync(hwif->irq);
> >  		spin_unlock(&hwgroup->lock);
> > +		/* allow other IRQs while we start this request */
> >  		local_irq_enable_in_hardirq();
> > -			/* allow other IRQs while we start this request */
> 
> That's the part I don't understand completely. Wouldn't it be alright to
> do just spin_unlock_irq() here and be done with it? SCSI does exactly
> that and as far as I can see, IDE is in a similar situation now that the
> ->request_fn() is not called from ide_intr() and ide_timer_expiry()
> anymore, i.e. the ->request_fn() will always be executed in process
> context.

Fixed.

> >  		startstop = start_request(drive, rq);
> >  		spin_lock_irq(&hwgroup->lock);
> > -		if (masked_irq != IDE_NO_IRQ && hwif->irq != masked_irq)
> > -			enable_irq(hwif->irq);
> > -		if (startstop == ide_stopped)
> > +
> > +		if (startstop == ide_stopped) {
> >  			hwgroup->busy = 0;
> > +			goto plug_device;
> 
> This goto statement is wrong. Simply set ->busy to zero and be done with
> it. This way, the loop will start again and either elv_next_request()
> returns NULL, in which case the queue need not be plugged, or the next
> request will be processed immediately, which is exactly what we want.

The problem is that the next loop can choose the different drive than
the current one so we can end up with the situation where we will "lose"
the blk_plug_device() call.

I fixed it by just inlining "plug_device" code for now.

> [...]
> > @@ -1438,11 +1431,11 @@ irqreturn_t ide_intr (int irq, void *dev
> >  	if (startstop == ide_stopped) {
> >  		if (hwgroup->handler == NULL) {	/* paranoia */
> >  			hwgroup->busy = 0;
> > -			ide_do_request(hwgroup, hwif->irq);
> > -		} else {
> > -			printk(KERN_ERR "%s: ide_intr: huh? expected NULL handler "
> > -				"on exit\n", drive->name);
> > -		}
> > +			if (!elv_queue_empty(drive->queue))
> > +				blk_plug_device(drive->queue);
> 
> This is perhaps not exactly what you really want. It basically means
> that there will be a delay (q->unplug_delay) after each command which
> may well hurt I/O performance. Instead, I'd suggest something like the
> following:
> 
> 	if (!elv_queue_empty(drive->queue))
> 		blk_schedule_queue_run(drive->queue);
> 
> and a function
> 
> void blk_schedule_queue_run(struct request_queue *q)
> {
> 	blk_plug_device(q);
> 	kblockd_schedule_work(&q->unplug_work);
> }
> 
> in blk-core.c. This can also be used as a helper function in blk-core.c
> itself.

Care to make a patch adding such helper to blk-core.c?

I'll update this patch to use it then, in the meantime v1->v2 interdiff:

...
v2:
Changes per review from Elias Oltmanns:
- fix wrong goto statement in 'if (startstop == ide_stopped)' block
- use spin_unlock_irq()
- don't use obsolete HWIF() macro
...

diff -u b/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- b/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1006,8 +1006,9 @@
 
 		if (drive != orig_drive)
 			goto plug_device;
-	again:
-		hwif = HWIF(drive);
+again:
+		hwif = drive->hwif;
+
 		if (hwgroup->hwif->sharing_irq && hwif != hwgroup->hwif) {
 			/*
 			 * set nIEN for previous hwif, drives in the
@@ -1065,15 +1066,14 @@
 
 		hwgroup->rq = rq;
 
-		spin_unlock(&hwgroup->lock);
-		/* allow other IRQs while we start this request */
-		local_irq_enable_in_hardirq();
+		spin_unlock_irq(&hwgroup->lock);
 		startstop = start_request(drive, rq);
 		spin_lock_irq(&hwgroup->lock);
 
 		if (startstop == ide_stopped) {
 			hwgroup->busy = 0;
-			goto plug_device;
+			if (!elv_queue_empty(orig_drive->queue))
+				blk_plug_device(orig_drive->queue);
 		}
 	}
 	return;
