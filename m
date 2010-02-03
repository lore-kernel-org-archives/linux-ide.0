From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
 PIO data transfers in libata-aff.c
Date: Wed, 03 Feb 2010 11:39:49 -0600
Message-ID: <1265218789.2873.276.camel@mulgrave.site>
References: <1265151518.2800.715.camel@mulgrave.site>
	 <20100202150537.0f6a01c0.akpm@linux-foundation.org>
	 <4B68B1E0.4090004@pobox.com>
	 <20100202.152140.216335166.davem@davemloft.net>
	 <1265153568.2800.815.camel@mulgrave.site>
	 <1265192325.1970.28.camel@pc1117.cambridge.arm.com>
	 <1265215254.2873.201.camel@mulgrave.site>	<4B69ABCA.1030507@pobox.com>
	 <20100203090631.44753f3b.akpm@linux-foundation.org>
	 <4B69AF42.5050508@pobox.com>
	 <20100203092027.dbaf120b.akpm@linux-foundation.org>
	 <4B69B268.5070300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42167 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932673Ab0BCRkA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Feb 2010 12:40:00 -0500
In-Reply-To: <4B69B268.5070300@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, David Miller <davem@davemloft.net>, jeff@garzik.org, linux-ide@vger.kernel.org, stable@kernel.org, tj@kernel.org

On Wed, 2010-02-03 at 12:29 -0500, Jeff Garzik wrote:
> On 02/03/2010 12:20 PM, Andrew Morton wrote:
> > On Wed, 03 Feb 2010 12:15:46 -0500 Jeff Garzik<jgarzik@pobox.com>  wrote:
> >
> >> On 02/03/2010 12:06 PM, Andrew Morton wrote:
> >>> On Wed, 03 Feb 2010 12:00:58 -0500 Jeff Garzik<jgarzik@pobox.com>   wrote:
> >>>
> >>>> On 02/03/2010 11:40 AM, James Bottomley wrote:
> >>>>> The fix to libata looks to be just that it should kmap all the time
> >>>>> rather than trying to fiddle with the page to see if its higmem.  For
> >>>>> kmap on a normal page, we should just return the offset map address and
> >>>>> do all the flushing.
> >>>>
> >>>> libata tests PageHighMem() because it was measurably faster to do things
> >>>> the current way (which includes local_irq_save/restore, only for
> >>>> highmem) on boxes where it actually matters.
> >>>>
> >>>> It seems more efficient to add a flush where necessary, than
> >>>> unconditionally punish everyone...
> >>>
> >>> kmap_atomic() tests PageHighMem() too - it's pretty lightweight for
> >>> lowmem pages.
> >>
> >> Note the lack of local_irq_save/restore in our code, though...  These
> >> PIO xfers are __slow__, from the perspective of a CPU manufactured in
> >> the past decade; you are definitely disabling local interrupts for a
> >> long time.  I suppose we could do
> >>
> >> 	if (high mem)
> >> 		local irq save
> >> 		kmap
> >> 		xfer
> >> 		kunmap
> >> 		local irq restore
> >> 	else
> >> 		kmap
> >> 		xfer
> >> 		kunmap
> >>
> >> does that solve the problem for ARM, for 2.6.33?
> >>
> >
> > It's unclear (to me) why that code is using KM_IRQ0 at all.  Can't it
> > use a non-irq kmap slot?
> 
> libata may have to transfer data in response to an interrupt.  That is 
> normal interrupt-driven PIO -- although it should be noted that the code 
> supports polled PIO as well.
> 
> 
> >>> Anyway, I'd draw your attention to this claim in the changelog: "This
> >>> patch allows the ARM boards to use a rootfs on CompactFlash with the
> >>> PATA platform driver." Immediate-term, we should be looking for a small
> >>> fix for this issue which is acceptable for 2.6.33 and 2.6.32 and earlier.
> >>
> >> Sure...  see above.  hopefully one that does not punish -everybody-
> >> though.  It would be sad to unconditionally slow down millions of volume
> >> platform (read: x86) users for some embedded boards.
> >
> > Well.
> > ata-call-flush_dcache_page-around-pio-data-transfers-in-libata-affc.patch
> > is a no-op on x86.  It only has an effect on architectures which
> > implement flush_dcache_page().  And I expect flush_dcache_page() is
> > pretty light on those architectures, when compared with a PIO-mode
> > transfer.
> 
> I don't object to the patch...  as long as the arch people are happy. 
> Arch people seem to be the ones complaining, though

Apart from the contents, which is looking like sprinkle mainline with
random flushes, I'm unhappy that something which could be better
implemented by thinking about the problem is now being rammed through as
a must have bug fix.

We got this piece of crap in the same way:

commit 2d4dc890b5c8fabd818a8586607e6843c4375e62
Author: Ilya Loginov <isloginov@gmail.com>
Date:   Thu Nov 26 09:16:19 2009 +0100

    block: add helpers to run flush_dcache_page() against a bio and a
request's pages

Which is another race to flush everywhere until my coherence problem
goes away.

This scattershot approach to coherency is really damaging in the long
term because all these random flushes are going to mask real problems we
may or may not have in the arch APIs ... and worse, they'll mask
mostly ... there'll likely be times when the masking is incomplete and
we're left with incredibly hard to debug data loss or binary crashes.

James


