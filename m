From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
	PIO data transfers in libata-aff.c
Date: Wed, 03 Feb 2010 17:49:50 +0000
Message-ID: <1265219390.1970.84.camel@pc1117.cambridge.arm.com>
References: <1265151518.2800.715.camel@mulgrave.site>
	 <20100202150537.0f6a01c0.akpm@linux-foundation.org>
	 <4B68B1E0.4090004@pobox.com>
	 <20100202.152140.216335166.davem@davemloft.net>
	 <1265153568.2800.815.camel@mulgrave.site>
	 <1265192325.1970.28.camel@pc1117.cambridge.arm.com>
	 <1265215254.2873.201.camel@mulgrave.site>	<4B69ABCA.1030507@pobox.com>
	 <20100203090631.44753f3b.akpm@linux-foundation.org>
	 <4B69AF42.5050508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42211 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932806Ab0BCR5G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 12:57:06 -0500
In-Reply-To: <4B69AF42.5050508@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, James Bottomley <James.Bottomley@suse.de>, David Miller <davem@davemloft.net>, jeff@garzik.org, linux-ide@vger.kernel.org, stable@kernel.org, tj@kernel.org

On Wed, 2010-02-03 at 17:15 +0000, Jeff Garzik wrote:
> On 02/03/2010 12:06 PM, Andrew Morton wrote:
> > On Wed, 03 Feb 2010 12:00:58 -0500 Jeff Garzik<jgarzik@pobox.com>  wrote:
> >
> >> On 02/03/2010 11:40 AM, James Bottomley wrote:
> >>> The fix to libata looks to be just that it should kmap all the time
> >>> rather than trying to fiddle with the page to see if its higmem.  For
> >>> kmap on a normal page, we should just return the offset map address and
> >>> do all the flushing.
> >>
> >> libata tests PageHighMem() because it was measurably faster to do things
> >> the current way (which includes local_irq_save/restore, only for
> >> highmem) on boxes where it actually matters.
> >>
> >> It seems more efficient to add a flush where necessary, than
> >> unconditionally punish everyone...
> >
> > kmap_atomic() tests PageHighMem() too - it's pretty lightweight for
> > lowmem pages.
> 
> Note the lack of local_irq_save/restore in our code, though...  These
> PIO xfers are __slow__, from the perspective of a CPU manufactured in
> the past decade; you are definitely disabling local interrupts for a
> long time.  I suppose we could do
> 
>         if (high mem)
>                 local irq save
>                 kmap
>                 xfer
>                 kunmap
>                 local irq restore
>         else
>                 kmap
>                 xfer
>                 kunmap
> 
> does that solve the problem for ARM, for 2.6.33?

No, it doesn't. If the page isn't a highmem one, the kunmap doesn't do
anything to the caches (and I also have highmem disabled). My logic was
based on a statement in cachetlb.txt that flush_dcache_page() should be
called if the kernel writes to a page cache page, hence the patch (as it
was pointed out, the first call to flush_dcache_page() isn't needed).

-- 
Catalin

