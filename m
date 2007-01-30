From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 16:23:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701291614020.3611@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
 <1170051963.6454.7.camel@Homer.simpson.net>
 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
 <45BE5AF0.3030005@cs.wisc.edu> <Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701291414410.3611@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701291453230.3611@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701291532050.3611@woody.linux-foundation.org>
 <45BE864A.2050907@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:35195 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965147AbXA3AdD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 19:33:03 -0500
In-Reply-To: <45BE864A.2050907@cs.wisc.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Boaz Harrosh <bharrosh@panasas.com>



On Mon, 29 Jan 2007, Mike Christie wrote:
> 
> rq->bio is NULL here, so no data is coped back to userspace and it seems
> nero just stops trying to talk to the drive after this.

Well, except that's what we used to do in 2.6.19 too. So what changed?

> Because nero just gives up, no more commands are sent and we do not get
> flooded with status errors like before so it sort of looks like it
> solves the problem but it doesn't - at least that is what is happening here.

Yeah, I can't burn with Nero either, although I'll also say that I've 
never even tried before, so my leet Nero skillz are nonexistant.

		Linus
