From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [git patches 1/2] warnings: attack valid cases spotted by warnings
Date: Tue, 17 Jul 2007 21:18:15 -0700
Message-ID: <adabqeamjjs.fsf@cisco.com>
References: <20070717214239.GF28448@devserv.devel.redhat.com>
	<ada8x9epuip.fsf@cisco.com> <469D3E66.3010502@garzik.org>
	<adamyxuo2w6.fsf@cisco.com> <adair8io2de.fsf@cisco.com>
	<alpine.LFD.0.999.0707171957300.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:3712 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbXGREST (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 00:18:19 -0400
In-Reply-To: <alpine.LFD.0.999.0707171957300.27353@woody.linux-foundation.org> (Linus Torvalds's message of "Tue, 17 Jul 2007 21:00:10 -0700 (PDT)")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, chas@cmf.nrl.navy.mil, rolandd@cisco.com, dwmw2@infradead.org, gregkh@suse.de

 > Quite frankly, I don't quite understand where you get those enormous balls 
 > you have, that you can then talk about how ugly it is to just add a "= 0" 
 > that shuts up a compiler warning. That's the _least_ ugly part of the 
 > whole damn function!

The clanking when I walk annoys people in the office too...

But you're right.  It is stupid of me to make such a big deal about
this.  My excuse is that I've seen those warnings so many times and
actually given them more thought than they deserve, and I really felt
that Jeff's change makes the admittedly already ugly code a tiny
little bit worse.

 > Anyway, here's a totally untested cleanup that compiles but probably 
 > doesn't work, because I didn't check that I did the right thing with all 
 > the pointer arithmetic (ie when I change "wqe" to a real structure pointer 
 > instead of just a "void *", maybe I left some pointer arithmetic around 
 > that expected it to work as a byte pointer, but now really works on the 
 > whole structure size instead).

Given that you took the time to do this, I'll get the patch into a
working state and apply it.  And maybe split it into reviewable chunks
while I'm at it ;)

Thanks,
  Roland
