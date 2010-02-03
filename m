From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
	PIO data transfers in libata-aff.c
Date: Wed, 03 Feb 2010 10:07:08 +0000
Message-ID: <1265191628.1970.24.camel@pc1117.cambridge.arm.com>
References: <201002022211.o12MB8cJ017441@imap1.linux-foundation.org>
	 <1265151518.2800.715.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:34468 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757049Ab0BCKVJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 05:21:09 -0500
In-Reply-To: <1265151518.2800.715.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, stable@kernel.org, tj@kernel.org

On Tue, 2010-02-02 at 22:58 +0000, James Bottomley wrote:
> On Tue, 2010-02-02 at 14:11 -0800, akpm@linux-foundation.org wrote:
> > From: Catalin Marinas <catalin.marinas@arm.com>
> >
> > Depending on the direction of the transfer, flush_dcache_page() must be
> > called either before (ATA_TFLAG_WRITE) or after (!ATA_TFLAG_WRITE) the
> > data copying to avoid D-cache aliasing with user space or I-D cache
> > coherency issues (when reading data from an ATA device using PIO, the
> > kernel dirties the D-cache but there is no flush_dcache_page() required on
> > Harvard architectures).
> >
> > This patch allows the ARM boards to use a rootfs on CompactFlash with the
> > PATA platform driver.
> >
> > As Anfei Zhou mentioned in a recent patch ("flush dcache before writing
> > into page to avoid alias"), on some architectures there may be a
> > performance benefit in differentiating the flush_dcache_page() calls based
> > on whether the kernel or the user page needs flushing.
> >
> > IMHO, we should differentiate based on the direction (kernel reading or
> > writing from/to such page).  In the ARM case with PIPT Harvard caches
> > (newer processors), the kernel reading from a page that may be mapped in
> > user space shouldn't need cache flushing.  The kernel writing to such page
> > would require D-cache flushing because of coherency with the I-cache.
> > Currently on ARM, the latter happens in both cases.
[...]
> > diff -puN drivers/ata/libata-sff.c~ata-call-flush_dcache_page-around-pio-data-transfers-in-libata-affc drivers/ata/libata-sff.c
> > --- a/drivers/ata/libata-sff.c~ata-call-flush_dcache_page-around-pio-data-transfers-in-libata-affc
> > +++ a/drivers/ata/libata-sff.c
> > @@ -874,6 +874,9 @@ static void ata_pio_sector(struct ata_qu
> > 
> >       DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
> > 
> > +     if (do_write)
> > +             flush_dcache_page(page);
> > +
> 
> This looks wrong; the upper layers should already have made the page
> aliases coherent from user to kernel by calling flush_dcache_page (in
> __get_user_pages()), so the aliases should already be up to date and
> this flush is spurious.

In my case it was working fine even without this. I just added this for
completeness following the cachetlb.txt document.

> >       if (PageHighMem(page)) {
> >               unsigned long flags;
> > 
> > @@ -893,6 +896,9 @@ static void ata_pio_sector(struct ata_qu
> >                                      do_write);
> >       }
> > 
> > +     if (!do_write)
> > +             flush_dcache_page(page);
> > +
> 
> OK, so this too looks wrong for two reasons
> 
>      1. it's over flushing.  Even after the write to the page by the
>         kernel PIO, the only alias that is dirty should be the kernel,
>         so this needs a flush_kernel_dcache_page() to empty the kernel
>         alias.  It is possible user space will have speculated over the
>         user aliases, but there's stuff further up the block stack to
>         bring this back into coherence.

In the ARM case, it's not necessarily the user D-cache aliasing (which
on my current hardware does not exist) but the I and D cache coherency.

With non-aliasing D-cache on ARM, the flush_kernel_dcache_page() is a
no-op. If we consider the I-cache as being an alias, this function would
need to be implemented. So far this issue has been handled by
flush_dcache_page() (lazily).

>      2. If the page really is in highmem, the flush has to happen along
>         the kernel alias, which you just lost because this flush is
>         happening after the kunmap_atomic(), so it has to occur
>         somewhere between the PIO operation and the kunmap.

The kunmap_atomic(), at least in the ARM case, seems to do the cache
flushing. My cache coherency issues show up with highmem disabled.

-- 
Catalin

