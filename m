From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
Date: Sat, 25 Oct 2008 00:55:44 +0900 (JST)
Message-ID: <20081025.005544.92344156.anemo@mba.ocn.ne.jp>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
	<4900B6A8.30705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:65204 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204AbYJXPz2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 11:55:28 -0400
In-Reply-To: <4900B6A8.30705@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Thu, 23 Oct 2008 21:38:48 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +	unsigned int sp = (cr >> 4) & 3;
> > +	unsigned int clock = gbus_clock / (4 - sp);
> > +	unsigned int cycle = 1000000000 / clock;
> 
>     Hm, couldn't all these values be calculated only once?
> 
> > +	unsigned int wt, shwt;
> > +
> > +	/* Minimum DIOx- active time */
> > +	wt = DIV_ROUND_UP(t->act8b, cycle) - 2;
> > +	/* IORDY setup time: 35ns */
> > +	wt = max(wt, DIV_ROUND_UP(35, cycle));
> 
>     Same comment about calculating only once...

Yes.  But are there any good place to hold calculated values?  I don't
think it is not worth to allocate a local structure just for holding
such values.  And this is not a critical path anyway :-)

> > +	/* actual wait-cycle is max(wt & ~1, 1) */
> > +	if (wt > 2 && (wt & 1))
> > +		wt++;
> > +	wt &= ~1;
> > +	/* Address-valid to DIOR/DIOW setup */
> 
>     It's really address valid to -CSx assertion and -CSx to -DIOx assertion
> setup time, and contrarywise, -DIOx to -CSx release and -CSx release to 
> address invalid hold time, so it actualy applies 4 times and so constitutes 
> -DIOx recovery time. It's worth to check if the minimum cycle time is reached 
> with the setup time -- for PIO mode 0, minimum setup is 70 ns, multiplying 
> that by 4 gives 280 ns recovery and adding 290 ns active time gives 570 ns 
> cycle while the minimum is 600 ns.  Luckily, PIO0 seems the only problematic 
> mode as I doubt that EBUS controller can do back-to-back IDE reads/writes 
> keeping address and/or -CSx asserted in-between amounting to recovery time 
> being only 2x/3x setup times -- in the worst, 2x case PIO mode 3 would also 
> have too little cycle/recovery time...

Oh I had not considered the total cycle time at all...  I agree with
your analysis that PIO0 is the only problematic case.

And I also noticed that the calculated shwt value can be begger than 7
(which is max SHWT value) on fast GBUS and slow drive.  I will add
some check for it.


I'll address all other issues too (and send incremental patch).
Thanks!

---
Atsushi Nemoto
