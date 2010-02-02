From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
 PIO data transfers in libata-aff.c
Date: Tue, 02 Feb 2010 17:14:58 -0600
Message-ID: <1265152498.2800.762.camel@mulgrave.site>
References: <201002022211.o12MB8cJ017441@imap1.linux-foundation.org>
	 <1265151518.2800.715.camel@mulgrave.site>
	 <20100202150537.0f6a01c0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40797 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757118Ab0BBXPG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Feb 2010 18:15:06 -0500
In-Reply-To: <20100202150537.0f6a01c0.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, catalin.marinas@arm.com, jgarzik@pobox.com, stable@kernel.org, tj@kernel.org

On Tue, 2010-02-02 at 15:05 -0800, Andrew Morton wrote:
> On Tue, 02 Feb 2010 16:58:38 -0600
> James Bottomley <James.Bottomley@suse.de> wrote:
> 
> > On Tue, 2010-02-02 at 14:11 -0800, akpm@linux-foundation.org wrote:
> > > From: Catalin Marinas <catalin.marinas@arm.com>
> > > 
> > > Depending on the direction of the transfer, flush_dcache_page() must be
> > > called either before (ATA_TFLAG_WRITE) or after (!ATA_TFLAG_WRITE) the
> > > data copying to avoid D-cache aliasing with user space or I-D cache
> > > coherency issues (when reading data from an ATA device using PIO, the
> > > kernel dirties the D-cache but there is no flush_dcache_page() required on
> > > Harvard architectures).
> > > 
> > > This patch allows the ARM boards to use a rootfs on CompactFlash with the
> > > PATA platform driver.
> > > 
> > > As Anfei Zhou mentioned in a recent patch ("flush dcache before writing
> > > into page to avoid alias"), on some architectures there may be a
> > > performance benefit in differentiating the flush_dcache_page() calls based
> > > on whether the kernel or the user page needs flushing.
> > > 
> > > IMHO, we should differentiate based on the direction (kernel reading or
> > > writing from/to such page).  In the ARM case with PIPT Harvard caches
> > > (newer processors), the kernel reading from a page that may be mapped in
> > > user space shouldn't need cache flushing.  The kernel writing to such page
> > > would require D-cache flushing because of coherency with the I-cache. 
> > > Currently on ARM, the latter happens in both cases.
> > > 
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Jeff Garzik <jgarzik@pobox.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: <stable@kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > > 
> > >  drivers/ata/libata-sff.c |    6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff -puN drivers/ata/libata-sff.c~ata-call-flush_dcache_page-around-pio-data-transfers-in-libata-affc drivers/ata/libata-sff.c
> > > --- a/drivers/ata/libata-sff.c~ata-call-flush_dcache_page-around-pio-data-transfers-in-libata-affc
> > > +++ a/drivers/ata/libata-sff.c
> > > @@ -874,6 +874,9 @@ static void ata_pio_sector(struct ata_qu
> > >  
> > >  	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
> > >  
> > > +	if (do_write)
> > > +		flush_dcache_page(page);
> > > +
> > 
> > This looks wrong; the upper layers should already have made the page
> > aliases coherent from user to kernel by calling flush_dcache_page (in
> > __get_user_pages()), so the aliases should already be up to date and
> > this flush is spurious.
> 
> The upper layers don't know that the CPU touched the data!

The upper layers know to flush the user aliases.

>   If the
> driver did a DMA transfer then such a flush is unneeded, so we don't do
> it.

The point is that this is a write case (transfer from kernel to device)
so the underlying data should remain stable.  Once __get_user_pages()
has cohered the aliases, nothing should decohere them because nothing
should be altering the data in the page.

The danger case for VI caches is the read case because there you are
altering data via the kernel aliases.

James


