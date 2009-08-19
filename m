From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: use single threaded work queue
Date: Wed, 19 Aug 2009 16:21:47 +0100
Message-ID: <20090819162147.16aeb2db@lxorguk.ukuu.org.uk>
References: <20090819112554.GY12579@kernel.dk>
	<4A8BE932.5090300@garzik.org>
	<20090819120458.GZ12579@kernel.dk>
	<4A8BECC2.2060607@rtr.ca>
	<20090819122320.GA12579@kernel.dk>
	<4A8BFC79.1000004@garzik.org>
	<4A8BFDE2.1010904@garzik.org>
	<4A8C0820.8060200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48434 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751548AbZHSPVv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Aug 2009 11:21:51 -0400
In-Reply-To: <4A8C0820.8060200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Jens Axboe <jens.axboe@oracle.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Somewhat simpler for the general case would be to implement

create_workqueue(min_threads,max_threads, max_thread_idle_time);
queue_work_within();

at which point you can queue work to the workqueue but with a per
workqueue timing running so you know when you might need to create a new
thread if the current work hasn't finished. Idle threads would then sleep
and either expire or pick up new work - so that under load we don't keep
destructing threads.

That might need a single thread (for the system) that does nothing but
create workqueue threads to order. It could manage the "next workqueue
deadline" timer and thread creation. The threads would then pick up their
work queue work. There is an intrinsic race where if we are just on the
limit we might create a thread just as there is no work to be done - but
it would be rare and would just then go away.

I see no point tring to fix ata when applying sanity to the workqueue
logic would sort a lot of other cases out nicely.

