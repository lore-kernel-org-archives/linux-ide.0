From: james <jamessteward@optusnet.com.au>
Subject: Re: [PATCH] ide: add dcache flushing after PIO
Date: Sun, 08 Jan 2006 11:50:24 +1100
Message-ID: <1136681424.15944.12.camel@localhost.localdomain>
References: <43A7FE89.4040909@gmail.com>
	 <20051221094847.GA12279@htj.dyndns.org>
	 <20051221140022.GA25001@htj.dyndns.org>
	 <20051221140344.GA1736@flint.arm.linux.org.uk> <43A969FD.3090106@gmail.com>
	 <58cb370e0512210757n25ddd614p33f3d70c8ff813cd@mail.gmail.com>
	 <20051221175416.GH1736@flint.arm.linux.org.uk>
	 <20060107170623.GA15171@flint.arm.linux.org.uk>
	 <58cb370e0601071217x390fc1fpbbc9866b38ac28d7@mail.gmail.com>
	 <20060107212248.GJ31384@flint.arm.linux.org.uk>
	 <58cb370e0601071441v2d2e8f6eq18ebd8ea0280d1d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:15054 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161110AbWAHAlk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jan 2006 19:41:40 -0500
In-Reply-To: <58cb370e0601071441v2d2e8f6eq18ebd8ea0280d1d1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sat, 2006-01-07 at 23:41 +0100, Bartlomiej Zolnierkiewicz wrote:
> On 1/7/06, Russell King <rmk@arm.linux.org.uk> wrote:
> > On Sat, Jan 07, 2006 at 09:17:11PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > On 1/7/06, Russell King <rmk@arm.linux.org.uk> wrote:
> > > > On Wed, Dec 21, 2005 at 05:54:16PM +0000, Russell King wrote:
> > > > > DaveM vetoed that with good reason - the VM layer doesn't know whether
> > > > > the driver is doing PIO or not.  If it is doing PIO, it needs the
> > > > > cache flush.  If it's doing DMA, the cache flush is entirely a
> > > > > performance bottleneck.
> > > >
> > > > Bart,
> > > >
> > > > Did you miss my message, or have you decided to pay no further
> > > > attention to this issue?
> > >
> > > No, I'm waiting for ARM folks to give Tejun and me some feedback.
> >
> > We have, and I think it's been soo long that you're now confused.
> > See the entire thread on marc:
> >
> > http://marc.theaimsgroup.com/?t=113517374400003&r=1&w=2
> >
> > Yes, Tejun produced a patch and I queried whether it was going to
> > far.  There was a bit of discussion which resulted in a comment from
> > you saying:
> >
> > | After reading excellent explanation by rmk I think that it should be
> > | fixed at VM layer (filemap_nopage() perhaps).
> >
> > To which I replied:
> >
> > | DaveM vetoed that with good reason - the VM layer doesn't know whether
> > | the driver is doing PIO or not.  If it is doing PIO, it needs the
> > | cache flush.  If it's doing DMA, the cache flush is entirely a
> > | performance bottleneck.
> >
> > That's where we stand now - I'm waiting for some progress.
> 
> Tejun posted RFC to lkml which got zero replies so I thought
> that I will apply his patch if it *works*.
> 
> We can fix the problem in IDE locally - fine with me - but I want
> to know if we are actually *really* fixing the problem or just adding
> more confusion to IDE subsystem.
> 
> > > So far there was none and nobody seemed to care to test/comment
> > > this patch ("works fine" is enough).
> >
> > Odd, as demonstrated by the linux-ide archives above I've already
> > commented on it.
> 
> OK, we have discussed the way to fix the problem.
> 
> Still nothing was said whether this patch *actually* works or not.
> 
> > > What about testing the patch instead?
> >
> > Since there hasn't been a follow-up patch, there isn't anything to
> > test.  Please can we have a revised patch so folk _can_ do some
> > testing?
> 
> Test original Tejun's patch then.
> 
> I need some help from you and other ARM folks to fix this properly,
> I'm just a stupid IDE developer... :-)

I'm happy to see if it works.  I'm running 2.6.13.2 so if it applies
cleanly...

Any hints on what to look for?

I have the cachepolicy=writethrough kernel arg set at the mo to work
around the problem - I'll not set that see if I can run apps from the CF
I guess.

I saw segvs w/o the cachepolicy=... set.  So is there anything else I
need to do?  What other tests can I do and feedback can I give?

Please advise.

Russell, I note the comments by you and others above on Tejun's patch,
is there anything you (or others) think I should look for in testing
this?


BTW - thanks for keeping this going.

Happy New Year and warm regards,
James.

43 degrees C in Melbourne, Australia New Years Eve!

> 
> Bartlomiej
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

