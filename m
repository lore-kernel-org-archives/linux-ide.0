From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
	PIO data transfers in libata-aff.c
Date: Thu, 04 Feb 2010 15:39:11 +0000
Message-ID: <1265297951.28746.116.camel@pc1117.cambridge.arm.com>
References: <1265218789.2873.276.camel@mulgrave.site>
	 <1265294017.28746.88.camel@pc1117.cambridge.arm.com>
	 <1265295694.29959.3.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39633 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932371Ab0BDPri (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Feb 2010 10:47:38 -0500
In-Reply-To: <1265295694.29959.3.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, jeff@garzik.org, linux-ide@vger.kernel.org, stable@kernel.org, tj@kernel.org

On Thu, 2010-02-04 at 15:01 +0000, James Bottomley wrote:
> On Thu, 2010-02-04 at 14:33 +0000, Catalin Marinas wrote:
> > On Wed, 2010-02-03 at 17:39 +0000, James Bottomley wrote:
> > > On Wed, 2010-02-03 at 12:29 -0500, Jeff Garzik wrote:
> > > > On 02/03/2010 12:20 PM, Andrew Morton wrote:
> > > > > On Wed, 03 Feb 2010 12:15:46 -0500 Jeff Garzik<jgarzik@pobox.com>  wrote:
> > > > >> On 02/03/2010 12:06 PM, Andrew Morton wrote:
> > > > >>> Anyway, I'd draw your attention to this claim in the changelog: "This
> > > > >>> patch allows the ARM boards to use a rootfs on CompactFlash with the
> > > > >>> PATA platform driver." Immediate-term, we should be looking for a small
> > > > >>> fix for this issue which is acceptable for 2.6.33 and 2.6.32 and earlier.
> > > > >>
> > > > >> Sure...  see above.  hopefully one that does not punish -everybody-
> > > > >> though.  It would be sad to unconditionally slow down millions of volume
> > > > >> platform (read: x86) users for some embedded boards.
> > > > >
> > > > > Well.
> > > > > ata-call-flush_dcache_page-around-pio-data-transfers-in-libata-affc.patch
> > > > > is a no-op on x86.  It only has an effect on architectures which
> > > > > implement flush_dcache_page().  And I expect flush_dcache_page() is
> > > > > pretty light on those architectures, when compared with a PIO-mode
> > > > > transfer.
> > > >
> > > > I don't object to the patch...  as long as the arch people are happy.
> > > > Arch people seem to be the ones complaining, though
> > >
> > > Apart from the contents, which is looking like sprinkle mainline with
> > > random flushes, I'm unhappy that something which could be better
> > > implemented by thinking about the problem is now being rammed through as
> > > a must have bug fix.
> > >
> > > We got this piece of crap in the same way:
> > >
> > > commit 2d4dc890b5c8fabd818a8586607e6843c4375e62
> > > Author: Ilya Loginov <isloginov@gmail.com>
> > > Date:   Thu Nov 26 09:16:19 2009 +0100
> > >
> > >     block: add helpers to run flush_dcache_page() against a bio and a
> > > request's pages
> > >
> > > Which is another race to flush everywhere until my coherence problem
> > > goes away.
> > >
> > > This scattershot approach to coherency is really damaging in the long
> > > term because all these random flushes are going to mask real problems we
> > > may or may not have in the arch APIs ... and worse, they'll mask
> > > mostly ... there'll likely be times when the masking is incomplete and
> > > we're left with incredibly hard to debug data loss or binary crashes.
> >
> > I agree that this could be solved in a better way and I'm in favour of
> > API improvements. The current API and description in cachetlb.txt
> > suggest that flush_dcache_page() is the best approach when modifying
> > page cache pages.
> >
> > AFAICT, there are two main use cases of flush_dcache_page() (could be
> > more but that's what affects ARM): (1) filesystems modifying page cache
> > pages (NFS, cramfs etc.) and (2) drivers doing PIO (block, HCD) that may
> > write directly to page cache pages. Point (2) is a newer addition (as
> > the one above) to fix coherency problems on Harvard architectures.
> >
> > As long as you use filesystems like cramfs that call
> > flush_dcache_page(), the PIO block driver doesn't need to do any
> > flushing. That's one of the reasons why MTD didn't need any for a long
> > time. Once you start using filesystems like ext2, there is no
> > flush_dcache_page() called by the VFS layer, so we thought about moving
> > this into the driver (for a long time I had a dirty hack in
> > mpage_end_io_read() to call flush_dcache_page()).
> >
> > If we state that flush_dcache_page() should not be used in driver code,
> > than we need additional API for this (like pio_map_page etc. to be in
> > line with the dma_map_* functions). This would allow architectures to
> > implement them however they like.
> >
> > I can go on linux-arch with a proposed patch if this sounds acceptable.
> 
> I think I'd prefer some type of kmap_ variant.  The reason is that all
> the semantics are going to be the same as kmap ... down to having the
> slots for atomic.  All we need is the extra flag giving the direction of
> transfer and, of course, what you get back is a virtual address pointer
> (all the dma operations return physical address handles).

Would a kmap_pio API always require a page structure as argument?

There is a similar situation for HCD drivers and USB mass storage which
I raised recently. The idea that the USB mass storage code should do the
cache flushing was rejected as this has to be pushed down to the HCD
driver. However, the HCD driver doesn't get page information, only a
urb->transfer_buffer pointer to which it may do either DMA or PIO (both
may actually happen in the same driver as an optimisation).

If we enforce the use of a kmap_pio API in the USB mass storage, it
wouldn't be optimal since this code is not aware of whether the HCD
driver would do PIO or DMA.

Looking at the HCD drivers, there are more similarities to the DMA API
like pio_map_page, pio_map_single etc. I personally don't care much
about how the API is named but rather where such API should be called
from.

Regards.

-- 
Catalin

