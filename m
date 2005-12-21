From: Tejun Heo <htejun@gmail.com>
Subject: Re: Execute from CF causes segmentation faults
Date: Wed, 21 Dec 2005 18:48:47 +0900
Message-ID: <20051221094847.GA12279@htj.dyndns.org>
References: <9DA102EC128AD511BED000306E0766C70180487A@WTCNT4GW> <43A7FE89.4040909@gmail.com> <58cb370e0512200823g50de6e14n148e27e4a4c267f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:1382 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932345AbVLUJsx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Dec 2005 04:48:53 -0500
Received: by zproxy.gmail.com with SMTP id 14so110936nzn
        for <linux-ide@vger.kernel.org>; Wed, 21 Dec 2005 01:48:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <58cb370e0512200823g50de6e14n148e27e4a4c267f7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: James Steward <james.steward@dynamicratings.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, rmk+lkml@arm.linux.org.uk

On Tue, Dec 20, 2005 at 05:23:45PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On 12/20/05, Tejun Heo <htejun@gmail.com> wrote:
> > >
> > > No.  I think what is happening is:
> > > * the page we submit to the block layer has some cache lines already
> > >   associated with the kernel mapping.
> 
> I'm not familiar with cache coherency issues so please help me...
> 
> I see that flush_dcache_page() call in filemap.c:do_generic_mapping_read()
> takes care of user virtual mapping but there is no code to take care of kernel
> virtual mapping?  But how could this happen in the first place that some
> cache lines are associated with the kernel mapping?

When filling page cache, cache coherency is driver's reponsibility,
which is logical as in most cases only the driver knows what's
necessary to achieve coherency.  This usually doesn't require any
extra care as dma mapping/unmapping functions automatically take care
of coherency.

However, when performing PIO, kmap/unmap are used to access the pages
but they don't do any automatic cache flushing operations.  I've
grepped through the source and it seems that it's the caller's
responsibility to explicitly flush kernel mapping's cache before
unmapping when modifying possibly-user-mapped pages.

> > > * the IDE driver uses PIO to read from CF and hits these cache lines
> > >   making them dirty.
> > > * the page is then mapped into userspace via a page fault.
> > > * userspace reads the page.  Because some of the data is sitting in
> > >   the cache corresponding with the kernel mapping of the page,
> > >   userspace doesn't see the up to date data until later.
> > >
> > >
> > >>It also seems odd to me that this requires fixes at the block driver
> > >>level. I'd have thought this would get resolved at the page cache
> > >>level, or fs level at absolute lowest.
> > >
> > >
> > > If you do it there, you hurt DMA performance.  The DMA model ensures
> > > cache coherency.  The IDE PIO IO model does not.
> > >
> > > Basically, the problem stems from IDE PIO IO not providing the same
> > > cache guarantees as other block device drivers do.
> 
> Could you point me at such block device drivers
> or explain how it should be done properly?
> 
> I tried looking at mmc, libata and scsi drivers and I couldn't find
> any driver which actually does provide such guarantees...

Yeap, they all seem to need fixing.

> 
> > [CC'ing Bartlomiej and Russell King]
> >
> > Hello, all.
> >
> > kmap/kunmap are to PIO what dma_map/unmap are to DMA.  dma_map/unmap do
> > the following two things.
> >
> > 1. make the pages accessible to the DMA'ing device
> > 2. take care of cache consistency
> >
> > kmap/unmap currently performs the counterpart of #1.
> >
> > 1. make the pages accessible to the accessing device (CPU)
> >
> > So, adding cache consistency handling to kmap/unmap seems more logical
> > solution than handling cache consistency in all places where PIO occurs
> > (there are quite a few and some are buried pretty deep).
> >
> > Hmmm... I'm not really sure whether the places where cache consistency
> > handling is needed coincides with kmap/unmap.  Would the said scheme
> > unnecessrily perform cache consistency operations in some places and
> > thus degrade performance?
> 
> From what I understand:
> * DMA API provides coherency w.r.t. to write buffers not cache aliasing issues

DMA API provides all needed coherency.  It's responsible for evicting
all related cpu cachelines before starting DMA.

> * k(un)map() is also used for addresses which have only kernel mappings

Yes, it seems that the correct way to fix this is adding
flush_dcache_page prior to kunmap in all drivers which perform PIO -
IDE, libata, SCSI, mmc...

I originally thought that performing some extra flush_dcach_page
should be okay considering most mainstream architectures have
physically indexed cache.  But as this kind of problems are already
handled by manually performing flushe in other places, it seems that
block drivers should do the same.

I'll follow up with patches soon.

-- 
tejun
