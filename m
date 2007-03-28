From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [git patches] libata fixes
Date: Wed, 28 Mar 2007 14:15:39 -0700
Message-ID: <20070328141539.353203a1.akpm@linux-foundation.org>
References: <20070328073219.GA26024@havoc.gtf.org>
	<460A1A3D.6050501@garzik.org>
	<Pine.LNX.4.64.0703281346060.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:59744 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995AbXC1VPn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Mar 2007 17:15:43 -0400
In-Reply-To: <Pine.LNX.4.64.0703281346060.6730@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, 28 Mar 2007 13:53:10 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Wed, 28 Mar 2007, Jeff Garzik wrote:
> >
> > Jeff Garzik wrote:
> > > This disables libata ACPI, among other things.
> > 
> > If a -rc6 is possible, that would be quite nice...
> 
> Heh. I don't think -rc6 is "possible" - it's "inevitable". We have too 
> much fallout from the timer changes still outstanding. It looks people 
> finally figured out a big issue with the HPET timer, and that hopefully 
> resolves most of the remaining timer-related regressions, but yes, we most 
> definitely _will_ have an -rc6.

yup.

> Andrew, what's your feeling apart from the timer fallout?

There are two main metrics:

a) the number of bugs which Adrian is tracking.  I think this still
   exceeds 25, which is a lot.

b) the rate at which fixes are arriving.  I have accumulated 15-20
   since the last batch (40 hours ago), which is still a pretty high rate.

Based on that, we're still quite a long way from -final.

(But you know me - I'd be happy releasing 2.6.21 in July)
(Don't ask me what year I'm referring to, either)


There is another metric to look at, too: the number of fixes which are
going into 2.6.x.y.  If that fix count is high, and if those fixes fix bugs
which were not present in 2.6.x-1 then this is an indication that something
is wrong - many regressions are sneaking through the -rc process.

And I haven't run the numbers, but I get the impression that 2.6.20.x has
an unusually large number of fixes in it.

