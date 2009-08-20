From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH] libata: use single threaded work queue
Date: Thu, 20 Aug 2009 08:28:30 -0600
Message-ID: <1250778510.5533.6.camel@mulgrave.site>
References: <20090819112554.GY12579@kernel.dk> <4A8BE932.5090300@garzik.org>
	 <20090819120458.GZ12579@kernel.dk> <4A8BECC2.2060607@rtr.ca>
	 <20090819122320.GA12579@kernel.dk> <1250720545.4810.37.camel@pasglop>
	 <4A8D45DF.8010307@gmail.com>  <4A8D4603.3060900@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59905 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754286AbZHTO2n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Aug 2009 10:28:43 -0400
In-Reply-To: <4A8D4603.3060900@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jens Axboe <jens.axboe@oracle.com>, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2009-08-20 at 21:48 +0900, Tejun Heo wrote:
> Tejun Heo wrote:
> > Yes, it addresses different aspect of the concurrency problem.  Might
> > be more suitable for ATA workqueues but definitely more costly to
> > convert to.  Argh...
>             ^ compared to Jens's lazy workqueue.

So there are two issues here.  One is ATAs need for execution in user
context that won't block other execution ... I really think that if
there's an existing pattern for this in the kernel, we should use it
rather than inventing our own.

The other is the question of whether the workqueue concept itself is
flawed.  This business of some jobs blocking other jobs due to execution
order on the queue can be a nasty side effect and it can lead to
entangled deadlocks, but for some uses, the whole concept of queued jobs
following a set order is necessary.  It might be appropriate to think
about whether we want to convert the whole workqueue infrastructure to
something like slow_work instead and possibly think about ordering on
top of this.

James


