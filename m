From: David Miller <davem@davemloft.net>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
 PIO data transfers in libata-aff.c
Date: Wed, 03 Feb 2010 09:09:27 -0800 (PST)
Message-ID: <20100203.090927.94734849.davem@davemloft.net>
References: <1265153568.2800.815.camel@mulgrave.site>
	<1265192325.1970.28.camel@pc1117.cambridge.arm.com>
	<1265215254.2873.201.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38560
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932609Ab0BCRJO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 12:09:14 -0500
In-Reply-To: <1265215254.2873.201.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James.Bottomley@suse.de
Cc: catalin.marinas@arm.com, jgarzik@pobox.com, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, stable@kernel.org, tj@kernel.org

From: James Bottomley <James.Bottomley@suse.de>
Date: Wed, 03 Feb 2010 10:40:54 -0600

> Actually, thinking about the semantics, the normal kmap has to have
> these flushes in the map and unmap anyway ... otherwise the page gets
> decohered if you do normal read/write on it.  The only information we
> don't have in current kmap is whether we're mapping for read/write or
> both.  So the API I'd propose is keep current kmap as is for the read
> and write case, and introduce a kmap_for_read and kmap_for_write (with
> corresponding umaps, and obviously atomics).

This would basically force non-highmem platforms to implement the
kmap_*() interfaces.

I understand that MIPS does this already to deal with cache aliasing.

But that's currently a choice, and sparc64 for example has no need
to do things that way.  It would in fact be more expensive than
how sparc64 currently handles cache aliasing.

So I'm more in support of a new interface.  Platforms like sparc64
can implement it and then get rid of the ide_*() string op cache
flushes and instead we put the new API calls in the right spots.
