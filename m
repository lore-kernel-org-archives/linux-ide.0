From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 20:31:40 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040329043140.GH791@holomorphy.com>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:1433 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262634AbUC2Ebu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Mar 2004 23:31:50 -0500
Content-Disposition: inline
In-Reply-To: <20040329005502.GG3039@dualathlon.random>
List-Id: linux-ide@vger.kernel.org
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Mon, Mar 29, 2004 at 02:55:02AM +0200, Andrea Arcangeli wrote:
> The point is that if you run read contigously from disk with a 1M or 32M
> request size, the wall time speed difference will be maybe 0.01% or so.
> Running 100 irqs per second or 3 irq per second doesn't make any
> measurable difference. Same goes for keeping the I/O pipeline full, 1M
> is more than enough to go at the speed of the storage with minimal cpu
> overhead. we waste 900 irqs per second just in the timer irq and
> another 900 irqs per second per-cpu in the per-cpu local interrupts in
> smp.
> In 2.4 reaching 512k DMA units that helped a lot, but going past 512k
> didn't help in my measurements.  1M maybe these days is needed (as Jens
> suggested) but >1M still sounds overkill and I completely agree with
> Jens about that.

Maybe we should try this the other way around. Assume those who want
larger request sizes are rational (unlikely as that may be) for the
sake of argument; what could they possibly be after? I'm thinking that
once we know what they're really after we might be able to satisfy the
needs some other way that makes more sense for the general case.

I have a wild guess it may reduce interrupt load and/or overhead of
request submission to the HBA by the factor of the request size
increase as the number of spindles (and of course the RAM with which
to do buffering) grows without bound, but otherwise no real notion of
why on earth anyone could want it. Maybe we should find out who (if
anyone) claims they really want the unreasonably large requests first
so they can be asked directly.


-- wli
