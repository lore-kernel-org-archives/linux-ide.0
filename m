From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: ahci problems with sata disk.
Date: Tue, 16 Jan 2007 15:26:22 -0700
Message-ID: <311601c90701161426r48998c55me0da3a2daa9ce0f1@mail.gmail.com>
References: <1168785128.7865.13.camel@duo> <45AB45B2.2080602@gmail.com>
	 <1168859112.6980.8.camel@duo>
	 <f4527be0701160844r19fe5220i39a5834f1f4df570@mail.gmail.com>
	 <45AD1A3A.4000706@rtr.ca>
	 <Pine.LNX.4.64.0701161504050.18469@coffee.psychology.mcmaster.ca>
	 <45AD4D62.5010308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:20206 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbXAPW0X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 17:26:23 -0500
Received: by an-out-0708.google.com with SMTP id b33so1149567ana
        for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 14:26:23 -0800 (PST)
In-Reply-To: <45AD4D62.5010308@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>

On 1/16/07, Jeff Garzik <jeff@garzik.org> wrote:
> ISTR either Jens or Andrew ran some numbers, and found that there was
> little utility beyond 4 or 8 tags or so.

Write cache is effectively queueing small writes already, so NCQ
simply brings random read performance closer to writes.

I know on the Maxtor drives with ~16MB of cache, they could do almost
200 ops/s at 7200RPM with their buffer granularity.

Random reads were about 70 ops/s at a depth of 1, and 120 ops/s at a
depth of 32.  Every double of queue depth added another level of
performance, and brings it closer to the implementation of cached
writes (queued or unqueued).  (infinite queue depth basically
eliminates seek and rotate time, and brings you to your minimum settle
criteria as your minimum operation time)

It really has a lot of application dependence, but for the mixed
random workloads, a 25-30% performance increase was common in our
testing.  Drives should be able to handle normal streaming workloads
at identical performance, with or without queueing, since the patterns
are so easy to detect.

If done properly, queueing should never hurt performance.  High queue
depths will increase average latency of course, but shouldn't hurt
overall performance.

--eric

> NCQ mainly helps with multiple threads doing reads.  Writes are largely
> asynchronous to the user already (except for fsync-style writes).  You
> want to be able to stuff the disk's internal elevator with as many read
> requests as possible, because reads are very often synchronous -- most
> apps (1) read a block, (2) do something, (3) goto step #1.  The kernel's
> elevator isn't much use in these cases.

True.  And internal to the drive, normal elevator is "meh."  There are
other algorithms for scheduling that perform better.
