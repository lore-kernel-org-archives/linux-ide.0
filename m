From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.20-rc4-mm1
Date: Mon, 15 Jan 2007 09:30:19 +1100
Message-ID: <20070114223019.GP5860@kernel.dk>
References: <20070111222627.66bb75ab.akpm@osdl.org> <1168768104.2941.53.camel@localhost.localdomain> <1168771617.2941.59.camel@localhost.localdomain> <1168785616.2941.67.camel@localhost.localdomain> <20070114220515.GG5860@kernel.dk> <1168813901.2941.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:9550 "EHLO virtualhost.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbXANW3r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Jan 2007 17:29:47 -0500
Content-Disposition: inline
In-Reply-To: <1168813901.2941.85.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sun, Jan 14 2007, Thomas Gleixner wrote:
> On Mon, 2007-01-15 at 09:05 +1100, Jens Axboe wrote:
> > raid seems to have severe problems with the plugging change. I'll try
> > and find Neil and have a chat with him, hopefully we can work it out.
> 
> Some hints:
> 
> mount(1899): WRITE block 16424 on md3
> call md_write_start
> md3_raid1(438): WRITE block 40965504 on sdb6
> md3_raid1(438): WRITE block 40965504 on sda6
> First Write sector 16424 disks 2
> 
> Stuck.
> 
> Note, that neither end_buffer_async_write() nor
> raid1_end_write_request() are invoked, 
> 
> In a previous write invoked by:
> fsck.ext3(1896): WRITE block 8552 on sdb1
> end_buffer_async_write() is invoked.
> 
> sdb1 is not a part of a raid device.

When I briefly tested this before I left (and found it broken), doing a
cat /proc/mdstat got things going again. Hard if that's your rootfs,
it's just a hint :-)

> Hope that helps,

I can reproduce, so that's not a problem. I can't do much about it until
I'm back next week, but Neil might be able to help. We shall see. Thanks
for testing.

-- 
Jens Axboe

