From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: remove unnecessary blk_queue_flushing() test in
 do_ide_request()
Date: Fri, 20 Aug 2010 10:31:45 -0700 (PDT)
Message-ID: <20100820.103145.57462467.davem@davemloft.net>
References: <4C6D3329.7030901@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49716
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751208Ab0HTRb2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Aug 2010 13:31:28 -0400
In-Reply-To: <4C6D3329.7030901@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, hch@lst.de

From: Tejun Heo <tj@kernel.org>
Date: Thu, 19 Aug 2010 15:35:37 +0200

> Unplugging from a request function doesn't really help much (it's
> already in the request_fn) and soon block layer will be updated to mix
> barrier sequence with other commands, so there's no need to treat
> queue flushing any differently.
> 
> ide was the only user of blk_queue_flushing().  Remove it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
> David, can I route this patch through block tree with other barrier
> changes?

Sure:

Acked-by: David S. Miller <davem@davemloft.net>
