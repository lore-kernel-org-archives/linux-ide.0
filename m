From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git patch] libata resume fix
Date: Wed, 31 May 2006 16:56:45 +1000
Message-ID: <1149058605.766.45.camel@localhost.localdomain>
References: <20060528203419.GA15087@havoc.gtf.org>
	 <1148938482.5959.27.camel@localhost.localdomain> <447C4718.6090802@rtr.ca>
	 <Pine.LNX.4.64.0605301122340.5623@g5.osdl.org>
	 <1149028674.9986.71.camel@localhost.localdomain>
	 <20060531064730.GG29535@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59787 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964847AbWEaG5R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 May 2006 02:57:17 -0400
In-Reply-To: <20060531064730.GG29535@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


> In reality it probably doesn't matter much, since everything will be
> stalled until the queue is unfrozen anyways. Unless of course you have
> several slow-to-resume devices so you would at least get some overlap.
> But it would be nicer from a design view point.

In practice, it would be nice because most of X would restore while you
wait, it generally doesn't need the disk to do so unless you are heavy
on swap (or used suspend-to-disk :), that's one example among others...

At least letting other drivers restore in parallel, will improve things,
even if actual running of userland programs might still be stalled until
the disk kicks back in. But the whole experience of waking up the
machine will be improved from a black text screen waiting for the drive
to spin up ... :)

Ben.


