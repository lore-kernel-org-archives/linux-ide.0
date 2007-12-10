From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: SAS v SATA interface performance
Date: Mon, 10 Dec 2007 15:36:57 +0100
Message-ID: <20071210143656.GD9227@kernel.dk>
References: <47506237.3000406@clear.net.nz> <47507F9A.3080109@msgid.tls.msk.ru> <475CEBBA.3050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:21069 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbXLJOkD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Dec 2007 09:40:03 -0500
Content-Disposition: inline
In-Reply-To: <475CEBBA.3050409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org

On Mon, Dec 10 2007, Tejun Heo wrote:
> There's one thing we can do to improve the situation tho.  Several
> drives including raptors and 7200.11s suffer serious performance hit if
> sequential transfer is performed by multiple NCQ commands.  My 7200.11
> can do > 100MB/s if non-NCQ command is used or only upto two NCQ
> commands are issued; however, if all 31 (maximum currently supported by
> libata) are used, the transfer rate drops to miserable 70MB/s.
> 
> It seems that what we need to do is not issuing too many commands to one
> sequential stream.  In fact, there isn't much to gain by issuing more
> than two commands to one sequential stream.

Well... CFQ wont go to deep queue depths across processes if they are
doing streaming IO, but it wont stop a single process from doing so. I'd
like to know what real life process would issue a streaming IO in some
async manner as to get 31 pending commands sequentially? Not very likely
:-)

So I'd consider your case above a microbenchmark results. I'd also claim
that the firmware is very crappy, if it performs like described.

There's another possibility as well - that the queueing by the drive
generates a worse issue IO pattern, and that is why the performance
drops. Did you check with blktrace what the generated IO looks like?

> Both raptors and 7200.11 perform noticeably better on random workload
> with NCQ enabled.  So, it's about time to update IO schedulers
> accordingly, it seems.

Definitely. Again microbenchmarks are able to show 30-40% improvements
when I last tested. That's a pure random workload though, again not
something that you would see in real life.

I tend to always run with a depth around 4 here. It seems to be a good
value, you get some benefits from NCQ but you don't allow the drive
firmware to screw you over.

-- 
Jens Axboe

