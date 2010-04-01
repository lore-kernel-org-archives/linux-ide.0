From: Tejun Heo <tj@kernel.org>
Subject: Re: ide: Requeue request after DMA timeout
Date: Thu, 01 Apr 2010 13:56:53 +0900
Message-ID: <4BB42795.5070008@kernel.org>
References: <20100331061731.GA11480@gondor.apana.org.au> <4BB40D4C.7010204@kernel.org> <20100401043201.GA20470@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59154 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648Ab0DAE5V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Apr 2010 00:57:21 -0400
In-Reply-To: <20100401043201.GA20470@gondor.apana.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

Hello,

On 04/01/2010 01:32 PM, Herbert Xu wrote:
>> Does the above change make the request to be requeued twice?
> 
> No, we clear hwif->rq in ide_dma_timeout_retry so ide_timer_expiry
> will have nothing to requeue.

OIC.  It's also cleared in ide_timer_expiry() too.  Asymmetry among
different failure paths worries me.  e.g. looking at the code, I can't
find how ide_error() would requeue the request either.  It looks like
each hwif->rq = NULL in failure path should be investigated and the
affected ones should be replaced with a function which requeues and
clears hwif->rq.  Hmmm.... am I misunderstanding something?

> Besides, we want to requeue here regardless of whether we return
> ide_stopped.  For example, we may return ide_started in case of
> a pending reset, but as the original request hasn't been completed
> it must still be requeued.

Yeap, right.  ide_started/stopped doesn't have much bearing with the
current request.  It indicates the current controller/driver state.

Thanks.

-- 
tejun
