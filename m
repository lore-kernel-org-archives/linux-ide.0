From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/11v2] ata: replace macro with static inline in
 libata.h
Date: Sat, 16 Feb 2008 00:05:57 +0000
Message-ID: <20080216000557.6f6e9588@core>
References: <1203113215.15275.53.camel@brick>
	<20080215223036.2111edd5@core>
	<1203115574.30938.6.camel@brick>
	<20080215225339.0e2ed4e6@core>
	<1203116930.30938.12.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38770 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757779AbYBPAN7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 19:13:59 -0500
In-Reply-To: <1203116930.30938.12.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 15 Feb 2008 15:08:50 -0800
Harvey Harrison <harvey.harrison@gmail.com> wrote:

> On Fri, 2008-02-15 at 22:53 +0000, Alan Cox wrote:
> > > > NAK. This is a sparse bug, fix sparse.
> > > 
> > > Yes, fair enough, but that's not all the patch is about.
> > > 
> > > 1) it's using a max_t and min_t to force the comparisons as shorts, why
> > > not just make it a static inline?
> > 
> > Because max_t and min_t also force the comparsion types
> 
> Umm, maybe I'm missing something then, but how does the static inline
> not do this?

You claimed it was an advantage of the static inline earlier but both do
anyway

> OK, maybe not much clearer.  But isn't the inline easier to see at
> a glance that it is returning a value constrained to be
> 
> vmin <= v <= vmax
> 
> I suppose the variable names make it clear, but the macro construction
> is (slightly) less obvious.

Perhaps then clamp_t()

> __mint __maxt...but I'm not proposing that.

I am - as I bet there are other examples of that construct in the tree.

> > gcc still sometimes seems to optimise macros better than inlines.
> 
> OK, I didn't realize that, any pointers?

Not offhand, there is discussion in the archives but it may be somewhat
out of date for the latest gcc.

I'm not arguing your change is -wrong- I just think the original is
tidier and clearer. Its up to Jeff anyway
