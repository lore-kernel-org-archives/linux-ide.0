From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 14:16:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701291414410.3611@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
 <1170051963.6454.7.camel@Homer.simpson.net>
 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
 <45BE5AF0.3030005@cs.wisc.edu> <Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:59477 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932812AbXA2W04 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 17:26:56 -0500
In-Reply-To: <Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Boaz Harrosh <bharrosh@panasas.com>



On Mon, 29 Jan 2007, Linus Torvalds wrote:
> 
> That said, I'm making progress with my bisection. "16 revisions left to 
> test after this", and three of those sixteen are
> 
> 	Remove unnecessary blk_queue_bounce in SG_IO
> 	fix SG_IO bio leak
> 	remove blk_queue_activity_fn

I've now bisected to the point where those are the only commits left, so 
it's definitely one of the three.

Two more reboots and I should know exactly which one broke "nero".

		Linus
