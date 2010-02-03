From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
 PIO data transfers in libata-aff.c
Date: Wed, 3 Feb 2010 09:06:31 -0800
Message-ID: <20100203090631.44753f3b.akpm@linux-foundation.org>
References: <1265151518.2800.715.camel@mulgrave.site>
	<20100202150537.0f6a01c0.akpm@linux-foundation.org>
	<4B68B1E0.4090004@pobox.com>
	<20100202.152140.216335166.davem@davemloft.net>
	<1265153568.2800.815.camel@mulgrave.site>
	<1265192325.1970.28.camel@pc1117.cambridge.arm.com>
	<1265215254.2873.201.camel@mulgrave.site>
	<4B69ABCA.1030507@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53867 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932599Ab0BCRIz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 12:08:55 -0500
In-Reply-To: <4B69ABCA.1030507@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Bottomley <James.Bottomley@suse.de>, Catalin Marinas <catalin.marinas@arm.com>, David Miller <davem@davemloft.net>, jeff@garzik.org, linux-ide@vger.kernel.org, stable@kernel.org, tj@kernel.org

On Wed, 03 Feb 2010 12:00:58 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:

> On 02/03/2010 11:40 AM, James Bottomley wrote:
> > The fix to libata looks to be just that it should kmap all the time
> > rather than trying to fiddle with the page to see if its higmem.  For
> > kmap on a normal page, we should just return the offset map address and
> > do all the flushing.
> 
> libata tests PageHighMem() because it was measurably faster to do things 
> the current way (which includes local_irq_save/restore, only for 
> highmem) on boxes where it actually matters.
> 
> It seems more efficient to add a flush where necessary, than 
> unconditionally punish everyone...

kmap_atomic() tests PageHighMem() too - it's pretty lightweight for
lowmem pages.


Anyway, I'd draw your attention to this claim in the changelog: "This
patch allows the ARM boards to use a rootfs on CompactFlash with the
PATA platform driver." Immediate-term, we should be looking for a small
fix for this issue which is acceptable for 2.6.33 and 2.6.32 and earlier.

