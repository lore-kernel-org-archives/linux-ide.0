From: Tejun Heo <tj@kernel.org>
Subject: Re: ide: Requeue request after DMA timeout
Date: Thu, 01 Apr 2010 15:37:47 +0900
Message-ID: <4BB43F3B.6000801@kernel.org>
References: <20100331061731.GA11480@gondor.apana.org.au> <4BB40D4C.7010204@kernel.org> <20100401043201.GA20470@gondor.apana.org.au> <4BB42795.5070008@kernel.org> <20100401055455.GA20865@gondor.apana.org.au> <4BB43C6E.3050900@kernel.org> <20100401063218.GB21284@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59342 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536Ab0DAGiN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Apr 2010 02:38:13 -0400
In-Reply-To: <20100401063218.GB21284@gondor.apana.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

Hello,

On 04/01/2010 03:32 PM, Herbert Xu wrote:
>> ide_timer_expiry() will clear hwif->rq without requeueing
>> the request and the request will be lost.  No?
> 
> It shouldn't be lost in that case because of the rq_in_flight
> thing that you added will catch it and requeue.

I feel pretty stupid now.  Thanks for enlightening me on how the code
I added works.  :-)

It was the asymmetry between the two paths that bothered me and made
me think there should be something else wrong.  So, the problem is
ide_dma_timeout_retry(), which is used only by ide_timer_expiry(),
clearing hwif->rq, right?  Then, wouldn't not clearing hwif->rq in
ide_dma_timeout_retry() a better solution?

Thanks.

-- 
tejun
