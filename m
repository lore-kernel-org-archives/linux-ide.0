From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: use single threaded work queue
Date: Thu, 20 Aug 2009 21:47:27 +0900
Message-ID: <4A8D45DF.8010307@gmail.com>
References: <20090819112554.GY12579@kernel.dk> <4A8BE932.5090300@garzik.org>	 <20090819120458.GZ12579@kernel.dk> <4A8BECC2.2060607@rtr.ca>	 <20090819122320.GA12579@kernel.dk> <1250720545.4810.37.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:49423 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbZHTMrj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Aug 2009 08:47:39 -0400
In-Reply-To: <1250720545.4810.37.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Wed, 2009-08-19 at 14:23 +0200, Jens Axboe wrote:
>> Well, that's the same thread pool suggestion that Jeff came up with.
>> And
>> I agree, that's a nicer long term solution (it's also how the per-bdi
>> flushing replacement works). The problem with that appears to be that
>> any suggested patchset for thread pools spiral into certain "but what
>> color should it be?!" death.
>>
>> I'll try and work up a simple create_threadpool() implementation, we
>> can
>> literally cut away hundreds of threads with that.
> 
> Don't we have one already ? Dave Howells slow_work or such ?

Yes, it addresses different aspect of the concurrency problem.  Might
be more suitable for ATA workqueues but definitely more costly to
convert to.  Argh...

-- 
tejun
