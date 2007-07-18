From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches 1/2] warnings: attack valid cases spotted by
 warnings
Date: Wed, 18 Jul 2007 11:02:46 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707181050572.27353@woody.linux-foundation.org>
References: <20070717214239.GF28448@devserv.devel.redhat.com>
 <ada8x9epuip.fsf@cisco.com> <469D3E66.3010502@garzik.org> <adamyxuo2w6.fsf@cisco.com>
 <adair8io2de.fsf@cisco.com> <alpine.LFD.0.999.0707171957300.27353@woody.linux-foundation.org>
 <adabqeamjjs.fsf@cisco.com> <alpine.LFD.0.999.0707172205270.27353@woody.linux-foundation.org>
 <adaodi9lika.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56831 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932181AbXGRSDq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 14:03:46 -0400
In-Reply-To: <adaodi9lika.fsf@cisco.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roland Dreier <rdreier@cisco.com>
Cc: Jeff Garzik <jeff@garzik.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, chas@cmf.nrl.navy.mil, rolandd@cisco.com, dwmw2@infradead.org, gregkh@suse.de



On Wed, 18 Jul 2007, Roland Dreier wrote:
> 
> BTW, I noticed one interesting thing while starting on this cleanup.
> I wanted to make sure that the generated code didn't change with the
> first step, and I actually discovered that the patch below seems to
> make the generated code *better*, maybe because some gcc alias
> analysis doesn't get as paranoid without the void *:

Absolutely.

The way to get pretty much any compiler to generate better code is:
 - code it simply
 - don't have tons of variables with overlapping lifetime
 - use limited-scope variables (ie don't have the variables at the 
   outermost scope, declare them in the smallest scope you can)

and trying to split things up into functions helps all of these. 

In fact, you can often get better code even when the functions aren't even 
inlined, because of the "simpler code" issue. Gcc sometimes tries to be 
too clever with its CSE etc, and generates really nasty complex code with 
lots of register spills, just because it keeps stuff live rather than just 
regenerating them.

So inlining a function doesn't even make it faster, all the time. You want 
to inline when 

 - the function is so small that the call is literally a big part of it, 
   and it doesn't even need more than a couple of registers, so the 
   calling convention has more register pressure than inlining the 
   function itself would have.

OR

 - the callers tend to have constant arguments that can benefit from 
   constant folding inside the function

but inlining in many other circumstances actually generates *worse* code 
and just makes debugging harder and the I$ footprint bigger.

> And here's the patch itself -- I think this is a reasonable size step
> to break things up into.  I assume that this is the basic form of the
> cleanup that you're proposing?

Yes, this looks good. Doing these kinds of things for the various other 
things is likely to make the code more readable, and as you already found 
out, the generated code doesn't tend to be worse either. It might not 
_always_ be a win size and performance-wise, but it can be, and so 
readability should generally always be the #1 goal, because quite often it 
actually does help the compiler too.

		Linus
