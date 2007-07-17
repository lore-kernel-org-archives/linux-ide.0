From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] pata_platform: Fix NULL pointer dereference
Date: Tue, 17 Jul 2007 20:01:30 +0900
Message-ID: <20070717110130.GA25718@linux-sh.org>
References: <20070717084252.29884.24167.sendpatchset@clockwork.opensource.se> <20070717090219.GA24991@linux-sh.org> <469C8CCC.80009@garzik.org> <20070717094728.GA25527@linux-sh.org> <469C98F5.50101@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:55919 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbXGQLBs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jul 2007 07:01:48 -0400
Content-Disposition: inline
In-Reply-To: <469C98F5.50101@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linuxsh-dev@lists.sourceforge.net, linux-ide@vger.kernel.org, Sonic Zhang <sonic.adi@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Jul 17, 2007 at 06:24:53AM -0400, Jeff Garzik wrote:
> It's just reality that there are never enough people to verify every 
> patch before it goes in.  We just support way too much hardware for that 
> to be remotely feasible.  Sure we -try- to keep the driver maintainer 
> CC'd, but alas we are human.
> 
Try? I've never _once_ received a CC from you regarding a change to
pata_platform. The only time I've been CC'ed at all is when someone
submitting the patch had the common courtesy to do so.

Whereas the number of times I've had to clean up after something merged
behind my back has been higher than the number of times I've been CC'ed
on any of these changes.

> Your thinking is flawed if you think I'm going to hold up every patch 
> until it's verified on each of 63 ATA controller drivers, when I make a 
> core change, for example.  Not scalable.  We scale in another way:
> 
This has nothing to do with core changes that impact every driver, this
has to do with isolated changes to a _single_ driver that you're
obviously not in a position to test. That's a very different situation.

Again, if you can't be bothered to CC people on changes to their drivers
that aren't libata-wide, don't apply them in the first place. I would
much rather play API catch up with my driver than have to backtrack and
figure out what went wrong when suddenly all of my boards stop booting.

Your "merge first and hope someone else notices and fixes it later"
approach is insane. We've never done kernel development like that, libata
isn't special.
