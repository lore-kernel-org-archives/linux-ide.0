From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: use single threaded work queue
Date: Wed, 19 Aug 2009 09:28:02 -0400
Message-ID: <4A8BFDE2.1010904@garzik.org>
References: <20090819112554.GY12579@kernel.dk> <4A8BE932.5090300@garzik.org> <20090819120458.GZ12579@kernel.dk> <4A8BECC2.2060607@rtr.ca> <20090819122320.GA12579@kernel.dk> <4A8BFC79.1000004@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52689 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbZHSN2E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Aug 2009 09:28:04 -0400
In-Reply-To: <4A8BFC79.1000004@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>

>>> It would be nice to just create these threads on-demand,
>>> and destroy them again after periods of dis-use.
>>> Kind of like how Apache does worker threads.
>>
>> Well, that's the same thread pool suggestion that Jeff came up with. And
>> I agree, that's a nicer long term solution (it's also how the per-bdi
>> flushing replacement works). The problem with that appears to be that
>> any suggested patchset for thread pools spiral into certain "but what
>> color should it be?!" death.
>
> Let people complain with code :) libata has two basic needs in this area:
> (1) specifying a thread count other than "1" or "nr-cpus"
> (2) don't start unneeded threads / idle out unused threads

To be even more general,

libata needs a workqueue or thread pool that can

(a) scale up to nr-drives-that-use-pio threads, on demand
(b) scale down to zero threads, with lack of demand

That handles the worst case of each PIO-polling drive needing to sleep 
(thus massively impacting latency, if any other PIO-polling drive must 
wait for a free thread).

That also handles the best case of not needing any threads at all.

	Jeff


