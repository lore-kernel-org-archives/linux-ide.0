From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Tue, 30 Sep 2008 10:09:47 -0500
Message-ID: <1222787387.3232.26.camel@localhost.localdomain>
References: <48C851ED.4090607@ru.mvista.com>
	 <48CA8BEE.1090305@ru.mvista.com>
	 <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
	 <200809271819.19510.bzolnier@gmail.com>  <48DEAF1F.8040200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:43426 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751767AbYI3PKS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Sep 2008 11:10:18 -0400
In-Reply-To: <48DEAF1F.8040200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, sshtylyov@ru.mvista.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org, Jens Axboe <jens.axboe@oracle.com>

On Sun, 2008-09-28 at 07:09 +0900, Tejun Heo wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Friday 12 September 2008, Atsushi Nemoto wrote:
> >> On Fri, 12 Sep 2008 19:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > 
> > [...]
> > 
> >>>>>> +	__ide_flush_dcache_range((unsigned long)addr, size);
> >>>>>   Why is this needed BTW?
> >>>> Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
> >>>> inconsistency on PIO drive.  PIO transfer only writes to cache but
> >>>> upper layers expects the data is in main memory.
> >>>     Hum, then I wonder why it's MIPS specific...
> >> SPARC also have it.  And there were some discussions for ARM IIRC.
> > 
> > I was under the impression that it has been addressed by Tejun at
> > the higher-layer level (for both ide/libata) long time ago and that
> > MIPS/SPARC code are just a left-overs which could be removed now?
> 
> cc'ing Jens and James.  IIRC, I posted several patches but they never
> went in.  I don't remember what the objections were or whether any
> alternative fix went in.

Which patches were these?  We have several methods of doing PIO
fallback, the most common one being
scatterlist.c:sg_copy_from/to_buffer() which does the cache coherency.

James


> Thanks.
> 

