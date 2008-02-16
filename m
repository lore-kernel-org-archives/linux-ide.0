From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 5/11v2] ata: replace macro with static inline in
	libata.h
Date: Fri, 15 Feb 2008 16:23:11 -0800
Message-ID: <1203121391.7442.6.camel@brick>
References: <1203113215.15275.53.camel@brick> <20080215223036.2111edd5@core>
	 <1203115574.30938.6.camel@brick> <20080215225339.0e2ed4e6@core>
	 <1203116930.30938.12.camel@brick>  <20080216000557.6f6e9588@core>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:19648 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757942AbYBPAXN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 19:23:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so630284rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 15 Feb 2008 16:23:12 -0800 (PST)
In-Reply-To: <20080216000557.6f6e9588@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Sat, 2008-02-16 at 00:05 +0000, Alan Cox wrote:
> On Fri, 15 Feb 2008 15:08:50 -0800
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > On Fri, 2008-02-15 at 22:53 +0000, Alan Cox wrote:
> > > > > NAK. This is a sparse bug, fix sparse.
> > > > 
> > > > Yes, fair enough, but that's not all the patch is about.
> > > > 
> > > > 1) it's using a max_t and min_t to force the comparisons as shorts, why
> > > > not just make it a static inline?
> > > 
> > > Because max_t and min_t also force the comparsion types
> > 
> > Umm, maybe I'm missing something then, but how does the static inline
> > not do this?
> 
> You claimed it was an advantage of the static inline earlier but both do
> anyway

Oh, I thought I said it accomplished the _same_ typechecking, my bad.

> 
> > OK, maybe not much clearer.  But isn't the inline easier to see at
> > a glance that it is returning a value constrained to be
> > 
> > vmin <= v <= vmax
> > 
> > I suppose the variable names make it clear, but the macro construction
> > is (slightly) less obvious.
> 
> Perhaps then clamp_t()
> 
> > __mint __maxt...but I'm not proposing that.
> 
> I am - as I bet there are other examples of that construct in the tree.

Lots, but form what I've seen, most could use a helper inline that is a
lot cleaner than what is currently there.  This case is about the same
either way.

> 
> > > gcc still sometimes seems to optimise macros better than inlines.
> > 
> > OK, I didn't realize that, any pointers?
> 
> Not offhand, there is discussion in the archives but it may be somewhat
> out of date for the latest gcc.
> 
> I'm not arguing your change is -wrong- I just think the original is
> tidier and clearer. Its up to Jeff anyway

Fair enough.  This change would make sparse a whole lot more useful
for libata, as it's down to 6 warnings with this and my 3/3 patch
removing another min/max nesting.  Going forward this would probably
make it easier on the maintainer to script up some automated checking.

Cheers,

Harvey




