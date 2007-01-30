From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 17:45:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701291736550.3611@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
 <1170051963.6454.7.camel@Homer.simpson.net>
 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
 <45BE5AF0.3030005@cs.wisc.edu> <Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701291414410.3611@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701291453230.3611@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701291532050.3611@woody.linux-foundation.org>
 <45BE864A.2050907@cs.wisc.edu> <Pine.LNX.4.64.0701291614020.3611@woody.linux-foundation.org>
 <45BE9774.20105@cs.wisc.edu> <45BE99A4.9080503@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:37713 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932856AbXA3B4P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 20:56:15 -0500
In-Reply-To: <45BE99A4.9080503@cs.wisc.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Boaz Harrosh <bharrosh@panasas.com>



On Mon, 29 Jan 2007, Mike Christie wrote:
> 
> Actually, I do not think we did this in 2.6.19. Tomo added a bug when he
> ported a patch and mixed up some things so we did something weird for
> 2.6.20-rc1.

Ah, ok. Warring bugs.  Have you pinpointed the original one? Is it your 
original "block: support larger block pc requests" after all? It looks 
like yours is the one that did the big changes, with Tomo then fixing some 
of the fallout?

In fact, now that I look closer, I see that it's definitely your first 
patch that first removes the old code:

> In 2.6.19, we did:
> 
> bio = rq->bio;
> blk_execute_rq() <- the execution sets rq->bio to null so that is why we
> save a bio pointer.
> blk_rq_unmap_user(bio);

And then your patch introduces the bug:

> For a while in 2.6.20-rc1, we basically did
> 
> blk_execute_rq()
> blk_rq_unmap_user(rq->bio) <- this was a bug that caused the mem leak
> and caused data to not be copied because rq->bio was null.

.. and perhaps introduced somethign else too?

and thus:

> Tomo and Jens then fixes this in 2.6.20-rc2 or rc3 to what we have in rc6:
> 
> bio = rq->bio;
> blk_execute_rq() <- the execution sets rq->bio to null so that is why we
> save a bio pointer.
> blk_rq_unmap_user(bio);

didn't actually help, because if fixed the bio leak, but it didn't fix 
whatever else went wrong..

Mike, with (a) you being attributed as the author of that original 
"support larger block pc requests" and (b) Jens apparently off gallivating 
somewhere, I really hope we you can find this, because otherwise I get the 
feeling that I have to revert that series if I'm to release a 2.6.20 in 
any kind of timely manner.

(Not that I haven't held up releases before, but this seems to be the main 
remaining thing, and in that light I think I'd probably end up 
reverting..)

No pressure ;)

(But it certainly doesn't have to be "today", so don't take it that way)

		Linus
