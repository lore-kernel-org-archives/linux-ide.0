From: Tejun Heo <tj@kernel.org>
Subject: Re: ide: Requeue request after DMA timeout
Date: Thu, 01 Apr 2010 12:04:44 +0900
Message-ID: <4BB40D4C.7010204@kernel.org>
References: <20100331061731.GA11480@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34406 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab0DADFN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Mar 2010 23:05:13 -0400
In-Reply-To: <20100331061731.GA11480@gondor.apana.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

Hello, Herbert.

On 03/31/2010 03:17 PM, Herbert Xu wrote:
> commit 8f6205cd572fece673da0255d74843680f67f879
> Author: Tejun Heo <tj@kernel.org>
> Date:   Fri May 8 11:53:59 2009 +0900
> 
>     ide: dequeue in-flight request
> 
> The problem is that the function ide_dma_timeout_retry does not
> requeue the current request, causing one request to be lost for
> each DMA timeout.

Hmmm....

> diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
> index ee58c88..62a257f 100644
> --- a/drivers/ide/ide-dma.c
> +++ b/drivers/ide/ide-dma.c
> @@ -492,6 +492,7 @@ ide_startstop_t ide_dma_timeout_retry(ide_drive_t *drive, int error)
>  	if (rq) {
>  		hwif->rq = NULL;
>  		rq->errors = 0;
> +		ide_requeue_request(drive, rq);
>  	}
>  	return ret;
>  }

Hmmm... ide_dma_timeout_retry() is called from ide_timer_expiry() if
!hwif->polling.  The former returns ide_stopped if the current request
processing should be stopped, in which case ide_timer_expiry() calls
plug_device to 1 which makes it call ide_requeue_and_plug() at the end
of the function.  Does the above change make the request to be
requeued twice?

Thanks.

-- 
tejun
