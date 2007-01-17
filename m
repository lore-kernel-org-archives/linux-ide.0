From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: ahci problems with sata disk.
Date: Thu, 18 Jan 2007 09:03:17 +1100
Message-ID: <20070117220317.GG3508@kernel.dk>
References: <1168785128.7865.13.camel@duo> <45AB45B2.2080602@gmail.com> <1168859112.6980.8.camel@duo> <f4527be0701160844r19fe5220i39a5834f1f4df570@mail.gmail.com> <45AD1A3A.4000706@rtr.ca> <Pine.LNX.4.64.0701161504050.18469@coffee.psychology.mcmaster.ca> <45AD4D62.5010308@garzik.org> <311601c90701161426r48998c55me0da3a2daa9ce0f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:26491 "EHLO virtualhost.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbXAQWDa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Jan 2007 17:03:30 -0500
Content-Disposition: inline
In-Reply-To: <311601c90701161426r48998c55me0da3a2daa9ce0f1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Hahn <hahn@physics.mcmaster.ca>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>

On Tue, Jan 16 2007, Eric D. Mudama wrote:

[snip lots of stuff I agree completely with]

> If done properly, queueing should never hurt performance.  High queue
> depths will increase average latency of course, but shouldn't hurt
> overall performance.

It may never hurt performance, but there are common scenarios where you
are much better off not doing queuing even if you could. A good example
of that is a media serving service, where you end up reading a bunch of
files sequentially. It's faster to read chunks of each file sequentially
at depth 1 and move on, than queue a a request from each of them and
send them to the drive. On my laptop with an NCQ enabled drive, the
mentioned approach outperforms queuing by more than 100%.

> >NCQ mainly helps with multiple threads doing reads.  Writes are
> >largely asynchronous to the user already (except for fsync-style
> >writes).  You want to be able to stuff the disk's internal elevator
> >with as many read requests as possible, because reads are very often
> >synchronous -- most apps (1) read a block, (2) do something, (3) goto
> >step #1.  The kernel's elevator isn't much use in these cases.
> 
> True.  And internal to the drive, normal elevator is "meh."  There are
> other algorithms for scheduling that perform better.

Well Linux doesn't default to using a normal elevator, so it's a moot
point.

-- 
Jens Axboe

