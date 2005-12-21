From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: add dcache flushing after PIO
Date: Wed, 21 Dec 2005 16:57:05 +0100
Message-ID: <58cb370e0512210757n25ddd614p33f3d70c8ff813cd@mail.gmail.com>
References: <9DA102EC128AD511BED000306E0766C70180487A@WTCNT4GW>
	 <43A7FE89.4040909@gmail.com>
	 <58cb370e0512200823g50de6e14n148e27e4a4c267f7@mail.gmail.com>
	 <20051221094847.GA12279@htj.dyndns.org>
	 <20051221140022.GA25001@htj.dyndns.org>
	 <20051221140344.GA1736@flint.arm.linux.org.uk>
	 <43A969FD.3090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.204]:30172 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932456AbVLUP5H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Dec 2005 10:57:07 -0500
Received: by nproxy.gmail.com with SMTP id x29so57851nfb
        for <linux-ide@vger.kernel.org>; Wed, 21 Dec 2005 07:57:05 -0800 (PST)
In-Reply-To: <43A969FD.3090106@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>, James Steward <james.steward@dynamicratings.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 12/21/05, Tejun Heo <htejun@gmail.com> wrote:
> Russell King wrote:
> > On Wed, Dec 21, 2005 at 11:00:22PM +0900, Tejun Heo wrote:
> >
> >>Block drivers are responsible for cache coherency before and after IO.
> >>When using DMA, DMA API takes care of it but drivers should do manual
> >>flushing with PIO.
> >
> >
> > Are you sure you need the ones in the write path?  No other driver
> > seems to do this.
> >
>
> Unfortunately, I'm not.  I was trying to be on the safe side.
>
> Are the page caches guaranteed to have no dirty alias on entry to block
> layer for write?  I can see that aliases are handled for read(2)s and
> write(2)s but I don't know much about mmap writebacks.
>
> Another question is whether or not it's guaranteed that there's no
> user-mapped dirty cachelines on entry to block layer for read.  DMA API

It seems to be guaranteed for read() and write() but not for mmap().

> clears all cpu caches before IO and, as DMA IO doesn't touch any cpu
> caches, it doesn't do anything after IO.  The previous patch adds a
> flush_dcache_page after IO which makes sure that the kernel cache line
> is gone, but it doesn't do anything to make sure that there's no dirty
> user-mapped cachelines hanging around before IO.
>
> I couldn't find an exemplary driver doing this kind of things with page
> caches.  Most other flush_dcache_page usages I looked at didn't deal
> with user mapped page caches.

After reading excellent explanation by rmk I think that it should be
fixed at VM layer (filemap_nopage() perhaps).

Could you move the discussion to LKML (with some generic "subject")
so we can get some help from MM hackers?

Bartlomiej
