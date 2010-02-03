From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
	PIO data transfers in libata-aff.c
Date: Wed, 03 Feb 2010 10:18:45 +0000
Message-ID: <1265192325.1970.28.camel@pc1117.cambridge.arm.com>
References: <1265151518.2800.715.camel@mulgrave.site>
	 <20100202150537.0f6a01c0.akpm@linux-foundation.org>
	 <4B68B1E0.4090004@pobox.com>
	 <20100202.152140.216335166.davem@davemloft.net>
	 <1265153568.2800.815.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:35347 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757071Ab0BCKcW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 05:32:22 -0500
In-Reply-To: <1265153568.2800.815.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: David Miller <davem@davemloft.net>, jgarzik@pobox.com, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, stable@kernel.org, tj@kernel.org

On Tue, 2010-02-02 at 23:32 +0000, James Bottomley wrote:
> On Tue, 2010-02-02 at 15:21 -0800, David Miller wrote:
> > From: Jeff Garzik <jgarzik@pobox.com>
> > Date: Tue, 02 Feb 2010 18:14:40 -0500
> >
> > > The patch in question only affects PIO transfers, not DMA.  Data is
> > > transferred from a kernel buffer to hardware via out[bwl] via
> > >
> > >     page data -> CPU register -> out[bwl]
> > >
> > > or, data is transferred from hardware to a kernel buffer via
> > >
> > >     in[bwl] -> CPU register -> page data
> > >
> > > So what are the flushing rules given those conditions?
> >
> > Any time you touch a page cache page with the cpu, you have
> > to get it purged from aliasing caches before it gets mapped
> > into userspace or similar.
> >
> > That's the problem on these machines.
> >
> > Actually, sparc64 is probably susceptible to the same problem.
> >
> > And it's not an issue in the IDE layer, know why? :-)
> >
> > In the IDE layer we have arch specific ide_*() interfaces which is
> > where all of this PIO dma flushing stuff deserves to live.
> >
> > ATA should do something similar instead of randomly scattering
> > flush_dcache_page() calls all over the place.
> 
> Agree with this, except it shouldn't be ide specific ... any driver that
> does PIO (we have some examples in SCSI) is vulnerable to this issue and
> should have the same fix.
> 
> The ide interfaces are very low level .. they're the ide_in/out[sw] APIs
> which aren't necessarily the most useful (some of the SCSI "PIO" stuff
> actually gets fed in via memory transfers to registers rather than port
> in/out). 
> 
> What it looks like we need is kmap_for_pio() and kunmap_for_pio() which
> take flags (or API extensions) indicating whether we're transferring to
> or from the device, which return the correct kernel address to the page
> (mapping it if it's in highmem) and perform the correct
> flushes/invalidates.

In a similar patch for dealing with a PIO USB HCD driver (ISP1760) I
suggested something like pio_map_single/pio_unmap_single similar to the
dma_* API. The problem with the HCD drivers is that the page information
is lost when they are called. They only have access to a
urb->transfer_buffer pointer and you can never know whether it is a
highmem one or not. Hence I think an API that deals directly with
pointers rather than page structures would be better.

If you are OK with the idea, I'm happy to propose a patch on linux-arch.

Thanks for the feedback so far.

-- 
Catalin

