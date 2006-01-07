From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: add dcache flushing after PIO
Date: Sat, 7 Jan 2006 23:41:53 +0100
Message-ID: <58cb370e0601071441v2d2e8f6eq18ebd8ea0280d1d1@mail.gmail.com>
References: <43A7FE89.4040909@gmail.com>
	 <20051221094847.GA12279@htj.dyndns.org>
	 <20051221140022.GA25001@htj.dyndns.org>
	 <20051221140344.GA1736@flint.arm.linux.org.uk>
	 <43A969FD.3090106@gmail.com>
	 <58cb370e0512210757n25ddd614p33f3d70c8ff813cd@mail.gmail.com>
	 <20051221175416.GH1736@flint.arm.linux.org.uk>
	 <20060107170623.GA15171@flint.arm.linux.org.uk>
	 <58cb370e0601071217x390fc1fpbbc9866b38ac28d7@mail.gmail.com>
	 <20060107212248.GJ31384@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.201]:6154 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161032AbWAGWm2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jan 2006 17:42:28 -0500
Received: by nproxy.gmail.com with SMTP id x37so40899nfc
        for <linux-ide@vger.kernel.org>; Sat, 07 Jan 2006 14:41:53 -0800 (PST)
In-Reply-To: <20060107212248.GJ31384@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, James Steward <james.steward@dynamicratings.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 1/7/06, Russell King <rmk@arm.linux.org.uk> wrote:
> On Sat, Jan 07, 2006 at 09:17:11PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On 1/7/06, Russell King <rmk@arm.linux.org.uk> wrote:
> > > On Wed, Dec 21, 2005 at 05:54:16PM +0000, Russell King wrote:
> > > > DaveM vetoed that with good reason - the VM layer doesn't know whether
> > > > the driver is doing PIO or not.  If it is doing PIO, it needs the
> > > > cache flush.  If it's doing DMA, the cache flush is entirely a
> > > > performance bottleneck.
> > >
> > > Bart,
> > >
> > > Did you miss my message, or have you decided to pay no further
> > > attention to this issue?
> >
> > No, I'm waiting for ARM folks to give Tejun and me some feedback.
>
> We have, and I think it's been soo long that you're now confused.
> See the entire thread on marc:
>
> http://marc.theaimsgroup.com/?t=113517374400003&r=1&w=2
>
> Yes, Tejun produced a patch and I queried whether it was going to
> far.  There was a bit of discussion which resulted in a comment from
> you saying:
>
> | After reading excellent explanation by rmk I think that it should be
> | fixed at VM layer (filemap_nopage() perhaps).
>
> To which I replied:
>
> | DaveM vetoed that with good reason - the VM layer doesn't know whether
> | the driver is doing PIO or not.  If it is doing PIO, it needs the
> | cache flush.  If it's doing DMA, the cache flush is entirely a
> | performance bottleneck.
>
> That's where we stand now - I'm waiting for some progress.

Tejun posted RFC to lkml which got zero replies so I thought
that I will apply his patch if it *works*.

We can fix the problem in IDE locally - fine with me - but I want
to know if we are actually *really* fixing the problem or just adding
more confusion to IDE subsystem.

> > So far there was none and nobody seemed to care to test/comment
> > this patch ("works fine" is enough).
>
> Odd, as demonstrated by the linux-ide archives above I've already
> commented on it.

OK, we have discussed the way to fix the problem.

Still nothing was said whether this patch *actually* works or not.

> > What about testing the patch instead?
>
> Since there hasn't been a follow-up patch, there isn't anything to
> test.  Please can we have a revised patch so folk _can_ do some
> testing?

Test original Tejun's patch then.

I need some help from you and other ARM folks to fix this properly,
I'm just a stupid IDE developer... :-)

Bartlomiej
