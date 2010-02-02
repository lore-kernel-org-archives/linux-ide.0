From: David Miller <davem@davemloft.net>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
 PIO data transfers in libata-aff.c
Date: Tue, 02 Feb 2010 15:21:40 -0800 (PST)
Message-ID: <20100202.152140.216335166.davem@davemloft.net>
References: <1265151518.2800.715.camel@mulgrave.site>
	<20100202150537.0f6a01c0.akpm@linux-foundation.org>
	<4B68B1E0.4090004@pobox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53957
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752792Ab0BBXV0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2010 18:21:26 -0500
In-Reply-To: <4B68B1E0.4090004@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@linux-foundation.org, James.Bottomley@suse.de, jeff@garzik.org, linux-ide@vger.kernel.org, catalin.marinas@arm.com, stable@kernel.org, tj@kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Tue, 02 Feb 2010 18:14:40 -0500

> The patch in question only affects PIO transfers, not DMA.  Data is
> transferred from a kernel buffer to hardware via out[bwl] via
> 
> 	page data -> CPU register -> out[bwl]
> 
> or, data is transferred from hardware to a kernel buffer via
> 
> 	in[bwl] -> CPU register -> page data
> 
> So what are the flushing rules given those conditions?

Any time you touch a page cache page with the cpu, you have
to get it purged from aliasing caches before it gets mapped
into userspace or similar.

That's the problem on these machines.

Actually, sparc64 is probably susceptible to the same problem.

And it's not an issue in the IDE layer, know why? :-)

In the IDE layer we have arch specific ide_*() interfaces which is
where all of this PIO dma flushing stuff deserves to live.

ATA should do something similar instead of randomly scattering
flush_dcache_page() calls all over the place.
