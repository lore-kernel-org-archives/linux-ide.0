From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: use single threaded work queue
Date: Thu, 20 Aug 2009 21:48:03 +0900
Message-ID: <4A8D4603.3060900@kernel.org>
References: <20090819112554.GY12579@kernel.dk> <4A8BE932.5090300@garzik.org>	 <20090819120458.GZ12579@kernel.dk> <4A8BECC2.2060607@rtr.ca>	 <20090819122320.GA12579@kernel.dk> <1250720545.4810.37.camel@pasglop> <4A8D45DF.8010307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50018 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754127AbZHTMtB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Aug 2009 08:49:01 -0400
In-Reply-To: <4A8D45DF.8010307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Yes, it addresses different aspect of the concurrency problem.  Might
> be more suitable for ATA workqueues but definitely more costly to
> convert to.  Argh...
            ^ compared to Jens's lazy workqueue.

-- 
tejun
