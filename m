From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
 PIO data transfers in libata-aff.c
Date: Tue, 02 Feb 2010 17:32:48 -0600
Message-ID: <1265153568.2800.815.camel@mulgrave.site>
References: <1265151518.2800.715.camel@mulgrave.site>
	 <20100202150537.0f6a01c0.akpm@linux-foundation.org>
	 <4B68B1E0.4090004@pobox.com>
	 <20100202.152140.216335166.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:41189 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255Ab0BBXc5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Feb 2010 18:32:57 -0500
In-Reply-To: <20100202.152140.216335166.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: jgarzik@pobox.com, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, catalin.marinas@arm.com, stable@kernel.org, tj@kernel.org

On Tue, 2010-02-02 at 15:21 -0800, David Miller wrote:
> From: Jeff Garzik <jgarzik@pobox.com>
> Date: Tue, 02 Feb 2010 18:14:40 -0500
> 
> > The patch in question only affects PIO transfers, not DMA.  Data is
> > transferred from a kernel buffer to hardware via out[bwl] via
> > 
> > 	page data -> CPU register -> out[bwl]
> > 
> > or, data is transferred from hardware to a kernel buffer via
> > 
> > 	in[bwl] -> CPU register -> page data
> > 
> > So what are the flushing rules given those conditions?
> 
> Any time you touch a page cache page with the cpu, you have
> to get it purged from aliasing caches before it gets mapped
> into userspace or similar.
> 
> That's the problem on these machines.
> 
> Actually, sparc64 is probably susceptible to the same problem.
> 
> And it's not an issue in the IDE layer, know why? :-)
> 
> In the IDE layer we have arch specific ide_*() interfaces which is
> where all of this PIO dma flushing stuff deserves to live.
> 
> ATA should do something similar instead of randomly scattering
> flush_dcache_page() calls all over the place.

Agree with this, except it shouldn't be ide specific ... any driver that
does PIO (we have some examples in SCSI) is vulnerable to this issue and
should have the same fix.

The ide interfaces are very low level .. they're the ide_in/out[sw] APIs
which aren't necessarily the most useful (some of the SCSI "PIO" stuff
actually gets fed in via memory transfers to registers rather than port
in/out).  

What it looks like we need is kmap_for_pio() and kunmap_for_pio() which
take flags (or API extensions) indicating whether we're transferring to
or from the device, which return the correct kernel address to the page
(mapping it if it's in highmem) and perform the correct
flushes/invalidates.

James


