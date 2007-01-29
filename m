From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 10:43:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701291036540.3611@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
 <1170051963.6454.7.camel@Homer.simpson.net>
 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
 <1170064904.6322.3.camel@Homer.simpson.net> <1170094599.6691.12.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:50583 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539AbXA2Sxx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 13:53:53 -0500
In-Reply-To: <1170094599.6691.12.camel@Homer.simpson.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Cc: Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, Mike Christie <michaelc@cs.wisc.edu>, James Bottomley <James.Bottomley@SteelEye.com>



On Mon, 29 Jan 2007, Mike Galbraith wrote:
> 
> The extremely unlikely winner is:
> 
> 29b08d2bae854f66d3cfd5f57aaf2e7c2c7fce32 is first bad commit

Yeah, that's not going to be it. You probably had a bad kernel there 
somewhere that you called "good". 

Git bisect is wonderful for figuring out (reasonably quickly) where 
problems are, but exactly because it zeroes in on the bug so quickly, if 
you give it faulty data, it zeroes in on something *else* very quickly and 
without any kind of sense. 

There's just no redundancy there, so one small bit error in the input, and 
you get a totally wrong end result ;)

I'm trying to narrow it down myself. It all *seemed* to work with the 
commit I suspected initially (the "support larger block pc requests" one).

But yes, I haven't actually tried to burn anything either. I also just 
started up "nero" and looked whether I'd get the error messages in dmesg.

		Linus
