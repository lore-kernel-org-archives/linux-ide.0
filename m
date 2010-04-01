From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: ide: Requeue request after DMA timeout
Date: Thu, 1 Apr 2010 12:32:01 +0800
Message-ID: <20100401043201.GA20470@gondor.apana.org.au>
References: <20100331061731.GA11480@gondor.apana.org.au> <4BB40D4C.7010204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:39562 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750796Ab0DAEcK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Apr 2010 00:32:10 -0400
Content-Disposition: inline
In-Reply-To: <4BB40D4C.7010204@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Thu, Apr 01, 2010 at 12:04:44PM +0900, Tejun Heo wrote:
>
> > diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
> > index ee58c88..62a257f 100644
> > --- a/drivers/ide/ide-dma.c
> > +++ b/drivers/ide/ide-dma.c
> > @@ -492,6 +492,7 @@ ide_startstop_t ide_dma_timeout_retry(ide_drive_t *drive, int error)
> >  	if (rq) {
> >  		hwif->rq = NULL;
> >  		rq->errors = 0;
> > +		ide_requeue_request(drive, rq);
> >  	}
> >  	return ret;
> >  }
> 
> Hmmm... ide_dma_timeout_retry() is called from ide_timer_expiry() if
> !hwif->polling.  The former returns ide_stopped if the current request
> processing should be stopped, in which case ide_timer_expiry() calls
> plug_device to 1 which makes it call ide_requeue_and_plug() at the end
> of the function.  Does the above change make the request to be
> requeued twice?

No, we clear hwif->rq in ide_dma_timeout_retry so ide_timer_expiry
will have nothing to requeue.

Besides, we want to requeue here regardless of whether we return
ide_stopped.  For example, we may return ide_started in case of
a pending reset, but as the original request hasn't been completed
it must still be requeued.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
