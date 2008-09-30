From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Tue, 30 Sep 2008 22:07:22 +0900 (JST)
Message-ID: <20080930.220722.72708027.anemo@mba.ocn.ne.jp>
References: <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
	<200809271819.19510.bzolnier@gmail.com>
	<48DEAF1F.8040200@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:60206 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbYI3NHX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Sep 2008 09:07:23 -0400
In-Reply-To: <48DEAF1F.8040200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: bzolnier@gmail.com, sshtylyov@ru.mvista.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org, jens.axboe@oracle.com, James.Bottomley@HansenPartnership.com

On Sun, 28 Sep 2008 07:09:35 +0900, Tejun Heo <htejun@gmail.com> wrote:
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

I suppose you mean thread http://lkml.org/lkml/2006/1/13/156.

IIUC flushing in ide string ops is still needed for MIPS.

---
Atsushi Nemoto
