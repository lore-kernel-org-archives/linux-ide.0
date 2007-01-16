From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ahci problems with sata disk.
Date: Tue, 16 Jan 2007 17:10:42 -0500
Message-ID: <45AD4D62.5010308@garzik.org>
References: <1168785128.7865.13.camel@duo> <45AB45B2.2080602@gmail.com>  <1168859112.6980.8.camel@duo> <f4527be0701160844r19fe5220i39a5834f1f4df570@mail.gmail.com> <45AD1A3A.4000706@rtr.ca> <Pine.LNX.4.64.0701161504050.18469@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59119 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbXAPWKp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Jan 2007 17:10:45 -0500
In-Reply-To: <Pine.LNX.4.64.0701161504050.18469@coffee.psychology.mcmaster.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>

Mark Hahn wrote:
>>>> I though that NCQ was intended to increase performance ??
> 
> intended to increase _sales_ performance ;)

Yep.


> remember that you've always had command queueing (kernel elevator): the 
> main difference with NCQ (or SCSI tagged queueing) is when
> the disk can out-schedule the kernel.  afaikt, this means sqeezing
> in a rotationally intermediate request along the way.
> 
> that intermediate request must be fairly small and should be a read
> (for head-settling reasons).
> 
> I wonder how often this happens in the real world, given the relatively
> small queues the disk has to work with.

ISTR either Jens or Andrew ran some numbers, and found that there was 
little utility beyond 4 or 8 tags or so.


>> My hdparm test is a sequential read-ahead test, so it will
>> naturally perform worse on a Raptor when NCQ is on.
> 
> that's a surprisingly naive heuristic, especially since NCQ is concerned 
> with just a max of ~4MB of reads, only a smallish
> fraction of the available cache.

NCQ mainly helps with multiple threads doing reads.  Writes are largely 
asynchronous to the user already (except for fsync-style writes).  You 
want to be able to stuff the disk's internal elevator with as many read 
requests as possible, because reads are very often synchronous -- most 
apps (1) read a block, (2) do something, (3) goto step #1.  The kernel's 
elevator isn't much use in these cases.

	Jeff



