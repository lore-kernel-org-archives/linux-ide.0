From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 11:01:44 +0100
Message-ID: <1170064904.6322.3.camel@Homer.simpson.net>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
	 <1170051963.6454.7.camel@Homer.simpson.net>
	 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46007 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750857AbXA2KBy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 05:01:54 -0500
In-Reply-To: <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, Mike Christie <michaelc@cs.wisc.edu>, James Bottomley <James.Bottomley@SteelEye.com>

On Sun, 2007-01-28 at 23:04 -0800, Linus Torvalds wrote:
> 
> [ Added Jeff, Jens and Mike Christie to Cc. I would _guess_ this is 
>   associated with the "larger block pc request" stuff: Mike, Jens? James B 
>   added for good luck.
> 
>   It apparently started happening somewhere between 2.6.19 and 2.6.20-rc2, 

2.6.20-rc1 is bad for me.  Ripping the diff apart manually is proving
challenging, so I suppose I'll bite the bullet and do the git clone.  No
idea how long that'll take at ~45KB/S, but I'll do the bisect if nobody
beats me to it.

	-Mike

