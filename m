From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Date: Mon, 30 Oct 2006 18:54:00 +0100
Message-ID: <20061030175400.GA31581@elte.hu>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161330AbWJ3Rya@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061030175224.GB14055@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


* Jens Axboe <jens.axboe@oracle.com> wrote:

> > > things may be allocated from that path, so we pass gfp_mask around. I'll
> > > double check it tonight, but I don't currently see what could be wrong.
> > > Would lockdep complain about:
> > > 
> > >         spin_lock_irqsave(lock, flags);
> > >         ...
> > >         spin_unlock_irq(lock);
> > >         ...
> > >         spin_lock_irq(lock);
> > >         ...
> > >         spin_unlock_irqrestore(lock, flags);
> > 
> > this is fine for lockdep IF and only IF there is no "out lock" held
> > around this that requires irqs to be off. So if you do
> > 
> > spin_lock_irqsave(lock1, flags);
> > ...
> > spin_lock_irqsave(lock2, flags);
> > spin_unlock_irq(lock2)
> > ...
> > 
> > then lockdep WILL complain, and rightfully so, about a violation since
> > lock1 gets violated here ;)
> 
> Naturally, that is a bug fair and simple, nothing to do with lockdep.

well, finding such locking bugs is the main purpose of lockdep, so there 
is at least some connection i'd say ;-)

	Ingo
