From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Tue, 30 Jan 2007 05:14:00 +0100
Message-ID: <1170130440.6679.9.camel@Homer.simpson.net>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
	 <1170051963.6454.7.camel@Homer.simpson.net>
	 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
	 <1170064904.6322.3.camel@Homer.simpson.net>
	 <1170094599.6691.12.camel@Homer.simpson.net>
	 <Pine.LNX.4.64.0701291036540.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:55499 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965127AbXA3EOD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 23:14:03 -0500
In-Reply-To: <Pine.LNX.4.64.0701291036540.3611@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, Mike Christie <michaelc@cs.wisc.edu>, James Bottomley <James.Bottomley@SteelEye.com>

On Mon, 2007-01-29 at 10:43 -0800, Linus Torvalds wrote:
> 
> On Mon, 29 Jan 2007, Mike Galbraith wrote:
> > 
> > The extremely unlikely winner is:
> > 
> > 29b08d2bae854f66d3cfd5f57aaf2e7c2c7fce32 is first bad commit
> 
> Yeah, that's not going to be it. You probably had a bad kernel there 
> somewhere that you called "good". 

Oh well, all was not wasted.  I'm now gitified (the clone wasn't nearly
as bad as I thought it was going to be with my lousy connection).  Now I
need another repeatable bug to try it against.

	-Mike

