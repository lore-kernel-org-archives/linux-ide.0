From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: ahci problems with sata disk.
Date: Thu, 18 Jan 2007 09:03:15 +1100
Message-ID: <20070117220315.GF3508@kernel.dk>
References: <1168785128.7865.13.camel@duo> <45AB45B2.2080602@gmail.com> <1168859112.6980.8.camel@duo> <f4527be0701160844r19fe5220i39a5834f1f4df570@mail.gmail.com> <45AD1A3A.4000706@rtr.ca> <Pine.LNX.4.64.0701161504050.18469@coffee.psychology.mcmaster.ca> <45AD4D62.5010308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:26490 "EHLO virtualhost.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbXAQWDR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Jan 2007 17:03:17 -0500
Content-Disposition: inline
In-Reply-To: <45AD4D62.5010308@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Tue, Jan 16 2007, Jeff Garzik wrote:
> Mark Hahn wrote:
> >>>>I though that NCQ was intended to increase performance ??
> >
> >intended to increase _sales_ performance ;)
> 
> Yep.
> 
> 
> >remember that you've always had command queueing (kernel elevator): the 
> >main difference with NCQ (or SCSI tagged queueing) is when
> >the disk can out-schedule the kernel.  afaikt, this means sqeezing
> >in a rotationally intermediate request along the way.
> >
> >that intermediate request must be fairly small and should be a read
> >(for head-settling reasons).
> >
> >I wonder how often this happens in the real world, given the relatively
> >small queues the disk has to work with.
> 
> ISTR either Jens or Andrew ran some numbers, and found that there was 
> little utility beyond 4 or 8 tags or so.

It entirely depends on the access pattern. For truly random reads,
performance does seem to continue to scale up with increasing drive
queue depths. It may only be a benchmark figure though, as truly random
read workloads probably aren't that common :-)

For anything else, going beyond 4 tags doesn't improve much.

> >>My hdparm test is a sequential read-ahead test, so it will
> >>naturally perform worse on a Raptor when NCQ is on.
> >
> >that's a surprisingly naive heuristic, especially since NCQ is concerned 
> >with just a max of ~4MB of reads, only a smallish
> >fraction of the available cache.
> 
> NCQ mainly helps with multiple threads doing reads.  Writes are largely 
> asynchronous to the user already (except for fsync-style writes).  You 
> want to be able to stuff the disk's internal elevator with as many read 
> requests as possible, because reads are very often synchronous -- most 
> apps (1) read a block, (2) do something, (3) goto step #1.  The kernel's 
> elevator isn't much use in these cases.

Au contraire, this is one of the cases where intelligent IO scheduling
in the kernel makes a ton of difference. It's the primary reason that AS
and CFQ are able to maintain > 90% of disk bandwidth for more than one
process, idling the drive for the duration of step 2 in the sequence
above (step 2 is typically really small, time wise). If the next block
read is close to the first one, that is. If you do that, you will
greatly outperform the same workload pushed to the drive scheduling.
I've done considerable benchmarks on this. Only if the processes are
doing random IO should the IO scheduler punt and push everything to the
drive queue.

-- 
Jens Axboe

