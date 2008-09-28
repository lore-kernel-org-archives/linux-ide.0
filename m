From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Sun, 28 Sep 2008 09:41:06 +0100
Message-ID: <20080928084106.GA5555@linux-mips.org>
References: <48C851ED.4090607@ru.mvista.com> <48CA8BEE.1090305@ru.mvista.com> <20080913.005904.07457691.anemo@mba.ocn.ne.jp> <200809271819.19510.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:44715
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751252AbYI1Il1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Sep 2008 04:41:27 -0400
Content-Disposition: inline
In-Reply-To: <200809271819.19510.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, sshtylyov@ru.mvista.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Sat, Sep 27, 2008 at 06:19:19PM +0200, Bartlomiej Zolnierkiewicz wrote:

> > > >>>+	__ide_flush_dcache_range((unsigned long)addr, size);
> > > 
> > > >>   Why is this needed BTW?
> > > 
> > > > Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
> > > > inconsistency on PIO drive.  PIO transfer only writes to cache but
> > > > upper layers expects the data is in main memory.
> > > 
> > >     Hum, then I wonder why it's MIPS specific...
> > 
> > SPARC also have it.  And there were some discussions for ARM IIRC.

It should affect any architecture that has virtually indexed data caches
with aliases.

> I was under the impression that it has been addressed by Tejun at
> the higher-layer level (for both ide/libata) long time ago and that
> MIPS/SPARC code are just a left-overs which could be removed now?

I'd highly appreciate that.  The __ide_ins? / __ide_outs? ops don't know
if a page is mapped to userspace so will have to do unnecessary flushes.
A mechanism that allows flush_dcache_page to be used would be far
preferable.

  Ralf
