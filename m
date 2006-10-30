From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Date: Mon, 30 Oct 2006 17:31:55 +0100
Message-ID: <1162225915.2948.49.camel@laptopd505.fenrus.org>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk>
	 <1162220239.2948.27.camel@laptopd505.fenrus.org>
	 <20061030154444.GH4563@kernel.dk>
	 <1162225002.2948.45.camel@laptopd505.fenrus.org>
	 <20061030162621.GK4563@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:30855 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965019AbWJ3QcA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Oct 2006 11:32:00 -0500
In-Reply-To: <20061030162621.GK4563@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu


> > 
> > 
> >  [<c0219091>] cfq_set_request+0x351/0x3b0
> >  [<c020c7fc>] elv_set_request+0x1c/0x40
> >  [<c020fcff>] get_request+0x23f/0x270
> >  [<c0210537>] get_request_wait+0x27/0x120
> >  [<c02107ca>] __make_request+0x5a/0x350
> >  [<c020f40f>] generic_make_request+0x16f/0x220
> >  [<c02117e4>] submit_bio+0x64/0x110
> > 
> > now cfq_set_request() uses several inlines which muddies the situation,
> > but lockdep claims one of them is not done correctly. (eg either it
> > takes the lock incorrectly or something does spin_unlock_irq while the
> > lock is held)
> 
> It's not really inlined trickery, the trace is exactly as printed.

what I meant is that cfq_set_request() calls a few inlines that also
take locks so it might be one of those instead

>  A few
> things may be allocated from that path, so we pass gfp_mask around. I'll
> double check it tonight, but I don't currently see what could be wrong.
> Would lockdep complain about:
> 
>         spin_lock_irqsave(lock, flags);
>         ...
>         spin_unlock_irq(lock);
>         ...
>         spin_lock_irq(lock);
>         ...
>         spin_unlock_irqrestore(lock, flags);

this is fine for lockdep IF and only IF there is no "out lock" held
around this that requires irqs to be off. So if you do

spin_lock_irqsave(lock1, flags);
...
spin_lock_irqsave(lock2, flags);
spin_unlock_irq(lock2)
...

then lockdep WILL complain, and rightfully so, about a violation since
lock1 gets violated here ;)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

