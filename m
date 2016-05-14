From: Meelis Roos <mroos@linux.ee>
Subject: Re: UBSAN: Undefined behaviour in block/blk-mq.c:1459:27 with
 pata_amd
Date: Sat, 14 May 2016 12:05:56 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1605141205080.3730@math.ut.ee>
References: <alpine.LRH.2.20.1605121902440.4797@math.ut.ee> <22191628.vH7YQZ1hRO@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:47107 "EHLO smtp2.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbcENJUS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 May 2016 05:20:18 -0400
In-Reply-To: <22191628.vH7YQZ1hRO@amdc1976>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>

> Does the patch below help?

Yes, the warning is gone and I see not other errors.

There is nothing attached to pata_amd so I do not know if it works 
too.

> 
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Subject: [PATCH] blk-mq: fix undefined behaviour in order_to_size()
> 
> When this_order variable in blk_mq_init_rq_map() becomes zero
> the code incorrectly decrements the variable and passes the result
> to order_to_size() helper causing undefined behaviour:
> 
>  UBSAN: Undefined behaviour in block/blk-mq.c:1459:27
>  shift exponent 4294967295 is too large for 32-bit type 'unsigned int'
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc6-00072-g33656a1 #22
> 
> Fix the code by checking this_order variable for not having the zero
> value first.
> 
> Reported-by: Meelis Roos <mroos@linux.ee>
> Fixes: 320ae51feed5 ("blk-mq: new multi-queue block IO queueing mechanism")
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0c2ed83..7df9c92 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1495,7 +1495,7 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
>  		int to_do;
>  		void *p;
>  
> -		while (left < order_to_size(this_order - 1) && this_order)
> +		while (this_order && left < order_to_size(this_order - 1))
>  			this_order--;
>  
>  		do {
> 

-- 
Meelis Roos (mroos@linux.ee)
