From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Sat, 13 Sep 2008 00:59:04 +0900 (JST)
Message-ID: <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
References: <48C851ED.4090607@ru.mvista.com>
	<20080912.005243.48535230.anemo@mba.ocn.ne.jp>
	<48CA8BEE.1090305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:55399 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbYILP64 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Sep 2008 11:58:56 -0400
In-Reply-To: <48CA8BEE.1090305@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Fri, 12 Sep 2008 19:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>   You shouldn't fake the BMDMA interrupt. If it's not there, it's not 
> >>there. Or does this actually happen?
> 
> > IIRC, Yes.
> 
>     Hum, let me think... worth printing a message if this happens.

It might be.  I'll try it.

> >>>+		/*
> >>>+		 * If only one of XFERINT and HOST was asserted, mask
> >>>+		 * this interrupt and wait for an another one.  Note
> 
> >>   This comment somewhat contradicts the code which returns 1 if only 
> >>HOST interupt is asserted if ERR is set.
> 
>     Which is not its business to test. I think you should remove that above 
> check -- if there's INTRQ asserted, then it's asserted. I wonder if BMIDE 
> interrupt bit gets set in that case (suspecting it's not)...

Well, let me explain a bit.  The datasheed say I should wait _both_
XFERINT and HOST interrupt.  So, if only one of them was asserted, I
mask it and wait another one.  But on the error case, only HOST was
asserted and XFERINT was never asserted.  Then I could not exit from
"waiting another one" state, until timeout.

> >>>+			pr_debug("%s: weired interrupt status. "
> >>>  
> 
> >>   Weird.
> 
> > Sure.  But it can happen IIRC...
> 
>     I meant the typo. :-)

Oh, thanks!

> >>>+	__ide_flush_dcache_range((unsigned long)addr, size);
> 
> >>   Why is this needed BTW?
> 
> > Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
> > inconsistency on PIO drive.  PIO transfer only writes to cache but
> > upper layers expects the data is in main memory.
> 
>     Hum, then I wonder why it's MIPS specific...

SPARC also have it.  And there were some discussions for ARM IIRC.

> >>>+	.read_sff_dma_status	= tx4939ide_read_sff_dma_status,
> 
> >>   Hum, it should be re-defined in both LE and BE mode (but actually not 
> >>called anyway).
> 
> > What do you mean?  Please elaborate?
> 
>     I mean that in LE mode you're using ide_read_sff_dma_status() but not 
> setting hwif->dma_base, so it won't work. But since it shouldn't be called in 
> this driver's case, this doesn't hurt.

Yes, I see, thanks.

---
Atsushi Nemoto
