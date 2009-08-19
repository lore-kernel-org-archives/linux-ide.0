From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libata: use single threaded work queue
Date: Thu, 20 Aug 2009 08:22:25 +1000
Message-ID: <1250720545.4810.37.camel@pasglop>
References: <20090819112554.GY12579@kernel.dk> <4A8BE932.5090300@garzik.org>
	 <20090819120458.GZ12579@kernel.dk> <4A8BECC2.2060607@rtr.ca>
	 <20090819122320.GA12579@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753358AbZHSWXi@vger.kernel.org>
In-Reply-To: <20090819122320.GA12579@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com
List-Id: linux-ide@vger.kernel.org

On Wed, 2009-08-19 at 14:23 +0200, Jens Axboe wrote:
> Well, that's the same thread pool suggestion that Jeff came up with.
> And
> I agree, that's a nicer long term solution (it's also how the per-bdi
> flushing replacement works). The problem with that appears to be that
> any suggested patchset for thread pools spiral into certain "but what
> color should it be?!" death.
> 
> I'll try and work up a simple create_threadpool() implementation, we
> can
> literally cut away hundreds of threads with that.

Don't we have one already ? Dave Howells slow_work or such ?

Ben.
