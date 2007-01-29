From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 19:16:39 +0100
Message-ID: <1170094599.6691.12.camel@Homer.simpson.net>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
	 <1170051963.6454.7.camel@Homer.simpson.net>
	 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
	 <1170064904.6322.3.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60659 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752539AbXA2SQs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 13:16:48 -0500
In-Reply-To: <1170064904.6322.3.camel@Homer.simpson.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, Mike Christie <michaelc@cs.wisc.edu>, James Bottomley <James.Bottomley@SteelEye.com>

On Mon, 2007-01-29 at 11:01 +0100, Mike Galbraith wrote:
> On Sun, 2007-01-28 at 23:04 -0800, Linus Torvalds wrote:
> > 
> > [ Added Jeff, Jens and Mike Christie to Cc. I would _guess_ this is 
> >   associated with the "larger block pc request" stuff: Mike, Jens? James B 
> >   added for good luck.
> > 
> >   It apparently started happening somewhere between 2.6.19 and 2.6.20-rc2, 
> 
> 2.6.20-rc1 is bad for me.  Ripping the diff apart manually is proving
> challenging, so I suppose I'll bite the bullet and do the git clone.  No
> idea how long that'll take at ~45KB/S, but I'll do the bisect if nobody
> beats me to it.

Done.  Horse-pookey result.

My criteria for "good" during bisection was no endless error loop.  At
no time during bisection did nero actually work, as in allow me to
select a burner.  It started off "bad", turned "good" after the third
build and stayed that way.

The extremely unlikely winner is:

29b08d2bae854f66d3cfd5f57aaf2e7c2c7fce32 is first bad commit
commit 29b08d2bae854f66d3cfd5f57aaf2e7c2c7fce32
Author: Heiko Carstens <heiko.carstens@de.ibm.com>
Date:   Mon Dec 4 15:40:40 2006 +0100

    [S390] pfault code cleanup.

    Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
    Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

:040000 040000 cdf0a6e6468eb76f58702a35394bb54368aba916
ad1bb21e85c76efa44b2a25af0f05c2bde160a80 M      arch
:040000 040000 de5ead61f0a183d7b9cb81ac919b08ae1712a4c7
6fbc043b58d4045e3e9544f079f9edc352909ba6 M      include

poo.

	-Mike

