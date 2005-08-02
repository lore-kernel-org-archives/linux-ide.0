From: Jens Axboe <axboe@suse.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 2 Aug 2005 14:54:37 +0200
Message-ID: <20050802125437.GA11967@suse.de>
References: <20050802104859.GG22569@suse.de> <42EF5488.9020802@imc-berlin.de> <20050802111302.GH22569@suse.de> <42EF5651.1040905@imc-berlin.de> <20050802112804.GJ22569@suse.de> <42EF594C.7090902@imc-berlin.de> <20050802113328.GK22569@suse.de> <42EF626B.6090103@imc-berlin.de> <20050802122609.GM22569@suse.de> <42EF69AD.30201@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:57540 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261472AbVHBMym (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Aug 2005 08:54:42 -0400
Content-Disposition: inline
In-Reply-To: <42EF69AD.30201@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

On Tue, Aug 02 2005, Steven Scholz wrote:
> Jens Axboe wrote:
> 
> >>>No, those waiters will be woken up when ide does an end_request for
> >>>requests coming in for a device which no longer exists.
> >>
> >>But that would mean generating requests for devices, drives and hwifs 
> >>that no longer exists. But exactly there it will crash! In 
> >>do_ide_request() and ide_do_request().
> >
> >
> >ide doesn't generate the requests, it just receives them for processing.
> I know.
> 
> >And you want to halt that at the earliest stage possible.
> Agreed.
> 
> Problems seems to be:
> 
> A refererenc to the request queue is stored in struct gendisk. Thus if you 
> unregister a block device you should make sure that noone can still try to 
> access that request queue, right?

Well the problem is that ide-cs/ide doesn't handle unplug gracefully.
You are trying to fix it in the wrong location, fix belongs in ide.

> >>~ # umount /mnt/pcmcia/
> >>sys_umount(494)
> >>generic_make_request(2859) q=c02d3040
> >>__generic_unplug_device(1447) calling q->request_fn() @ c00f97e4
> >>do_ide_request(1279) HWIF=c01dee8c (0), HWGROUP=c0fac2a0 (738987520), 
> >>drive=c01def1c (0, 0), queue=c02d3040 (00000000)
> >
> >
> >I don't understand what values you are dumping above, please explain. Is
> >HWIF c01dee8c or 0?
> 
> printk("%s(%d) HWIF=%p (%d), HWGROUP=%p (%d), drive=%p (%d, %d), queue=%p 
> (%p)\n", __FUNCTION__, __LINE__, hwif, hwif->present, hwgroup, 
> hwgroup->busy, drive, drive->present, drive->dead, q, drive->queue);
> 
> So HWIF is a c01dee8c and hwif->present=0.

Ok, so you could kill any request arriving for a !hwif->present hardware
interface.

> >>Assertion '(hwif->present)' failed in 
> >>drivers/ide/ide-io.c:do_ide_request(1284)
> >>Assertion '(drive->present)' failed in 
> >>drivers/ide/ide-io.c:do_ide_request(1290)
> >>ide_do_request(1133) hwgroup is busy!
> >>ide_do_request(1135) hwif=01000406
> >>
> >>The "738987520" above is hwgroup->busy! Obviously completly wrong. This 
> >>seems to be a hint that an invalid pointer is dereferenced! The pointer 
> >>hwif=01000406 also does not look very healthy! drive=c01def1c is the 
> >>result of
> >
> >
> >Yeah it looks very bad. Same thing with the reference counting, ide
> >should not be freeing various structures that the block layer still
> >holds a reference to.
> 
> Well or better tell the block layer that the drive is gone and it makes no 
> sense to make any requests ...

It's not enough! What if requests are already on the queue waiting to be
serviced? Again, forget request generation.

> >>So how could you generate requests (and handle them sanely) for devices 
> >>that where removed?
> >
> >Generation is not a problem, that happens outside of your scope. The job
> >of the driver is just to make sure that it plays by the rule and at
> >least makes sure it doesn't crash on its own for an active queue.
> 
> do_ide_request() could check hwif->present and/or drive->present.

Precisely.

> BUT: at this point the request is already made and the low level block 
> layer is sleeping and waiting for it's completion.

Which will complete when you error the request, as I wrote a few mails
ago.

> I could not figure out how to kill a request in do_ide_request() and wake 
> up the block layer (sleeping in __wait_on_buffer()).
> That's why I thought preventing the generation of such reuqests would be 
> the right way.

It's not the right way, it only solves a little part of the problem.
Killing a request with an error usually looks like this:

	blkdev_dequeue_request(rq);
	end_that_request_first(rq, 0, rq->hard_nr_sectors);
	end_that_request_last(rq);


-- 
Jens Axboe

