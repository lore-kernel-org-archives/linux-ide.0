From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: use single threaded work queue
Date: Wed, 19 Aug 2009 17:15:10 +0100
Message-ID: <20090819171510.68bef78f@lxorguk.ukuu.org.uk>
References: <20090819112554.GY12579@kernel.dk>
	<4A8BE932.5090300@garzik.org>
	<20090819120458.GZ12579@kernel.dk>
	<4A8BECC2.2060607@rtr.ca>
	<20090819122320.GA12579@kernel.dk>
	<4A8BFC79.1000004@garzik.org>
	<4A8BFDE2.1010904@garzik.org>
	<4A8C0820.8060200@gmail.com>
	<20090819162147.16aeb2db@lxorguk.ukuu.org.uk>
	<4A8C2012.6090809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753031AbZHSQPL@vger.kernel.org>
In-Reply-To: <4A8C2012.6090809@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Jens Axboe <jens.axboe@oracle.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-ide@vger.kernel.org

> Are work threads per workqueue?  Combined with per-cpu binding,
> dynamic thread pool per workqueue can get quite messy.  All three
> factors end up getting multiplied - ie. #cpus * pool_size which can be
> enlarged by the same work hopping around * #workqueues.

Stop a moment. Exactly how many work queue users need per cpu binding
wizardry ?

> Another problem is that if we apply this to the existing default
> workqueue which is used by many different supposed-to-be-short works
> in essentially batch mode, we might end up enlarging cache footprint
> by scheduling unnecessarily many threads, which, in tight situations,
> might show up as small but noticeable performance regression.

Only if you make the default assumed max wait time for the work too low -
its a tunable behaviour in fact.

Alan
