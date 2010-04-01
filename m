From: Tejun Heo <tj@kernel.org>
Subject: Re: ide: Must hold queue lock when requeueing
Date: Thu, 01 Apr 2010 12:06:56 +0900
Message-ID: <4BB40DD0.6050306@kernel.org>
References: <20100331061731.GA11480@gondor.apana.org.au> <20100331062029.GA11559@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34472 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910Ab0DADHV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Mar 2010 23:07:21 -0400
In-Reply-To: <20100331062029.GA11559@gondor.apana.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On 03/31/2010 03:20 PM, Herbert Xu wrote:
> ide: Must hold queue lock when requeueing
> 
> ide-atapi requeues requests without holding the queue lock.
> This patch fixes it by using the new ide_requeue_request function.
>  
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
> index eb2181a..12e9d7c 100644
> --- a/drivers/ide/ide-atapi.c
> +++ b/drivers/ide/ide-atapi.c
> @@ -263,8 +263,8 @@ void ide_retry_pc(ide_drive_t *drive)
>  	 * of it.  The failed command will be retried after sense data
>  	 * is acquired.
>  	 */
> -	blk_requeue_request(failed_rq->q, failed_rq);
>  	drive->hwif->rq = NULL;
> +	ide_requeue_request(drive, failed_rq);

Nice catch but I think it would be better to call
ide_requeue_and_plug() instead of adding ide_requeue_request().

Thanks.

-- 
tejun
