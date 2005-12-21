From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] ide: add dcache flushing after PIO
Date: Wed, 21 Dec 2005 17:54:16 +0000
Message-ID: <20051221175416.GH1736@flint.arm.linux.org.uk>
References: <9DA102EC128AD511BED000306E0766C70180487A@WTCNT4GW> <43A7FE89.4040909@gmail.com> <58cb370e0512200823g50de6e14n148e27e4a4c267f7@mail.gmail.com> <20051221094847.GA12279@htj.dyndns.org> <20051221140022.GA25001@htj.dyndns.org> <20051221140344.GA1736@flint.arm.linux.org.uk> <43A969FD.3090106@gmail.com> <58cb370e0512210757n25ddd614p33f3d70c8ff813cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14607 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751147AbVLURyZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Dec 2005 12:54:25 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e0512210757n25ddd614p33f3d70c8ff813cd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, James Steward <james.steward@dynamicratings.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Wed, Dec 21, 2005 at 04:57:05PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 12/21/05, Tejun Heo <htejun@gmail.com> wrote:
> > clears all cpu caches before IO and, as DMA IO doesn't touch any cpu
> > caches, it doesn't do anything after IO.  The previous patch adds a
> > flush_dcache_page after IO which makes sure that the kernel cache line
> > is gone, but it doesn't do anything to make sure that there's no dirty
> > user-mapped cachelines hanging around before IO.
> >
> > I couldn't find an exemplary driver doing this kind of things with page
> > caches.  Most other flush_dcache_page usages I looked at didn't deal
> > with user mapped page caches.
> 
> After reading excellent explanation by rmk I think that it should be
> fixed at VM layer (filemap_nopage() perhaps).

DaveM vetoed that with good reason - the VM layer doesn't know whether
the driver is doing PIO or not.  If it is doing PIO, it needs the
cache flush.  If it's doing DMA, the cache flush is entirely a
performance bottleneck.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
