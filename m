From: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd question
Date: Tue, 8 Mar 2005 15:14:19 +0100
Message-ID: <20050308141417.GH13008@suse.de>
References: <7A8F92187EF7A249BF847F1BF4903C04010EE978@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ns.virtualhost.dk ([195.184.98.160]:61062 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261331AbVCHOO1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Mar 2005 09:14:27 -0500
Content-Disposition: inline
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C04010EE978@ausx2kmpc103.aus.amer.dell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stuart_Hayes@Dell.com
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, stuarthayes@austin.rr.com

On Fri, Mar 04 2005, Stuart_Hayes@Dell.com wrote:
> 
> > 
> > There's still a problem here, you are not initializing nsectors for
> > non-pc requests. And your comments wrap :) 
> > 
> >         int nsectors = rq->hard_nr_sectors;
> > 
> >         if (blk_pc_request(rq))
> >                 nsectors = (rq->data_len + 511) >> 9;
> >         if (!nsectors)
> >                 nsectors = 1;
> > 
> >         ...
> > 
> > Can you resend with that fixed up and with a Signed-off-by header?
> 
> Here it is.  Thanks for all the help.  I'm attaching as a file, too,
> just in case it gets garbled again.
> Stuart
> 
> 
> Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>
> 
> --- linux-2.6.11/drivers/ide/ide-io.c.orig	2005-03-04
> 16:11:14.000000000 -0500
> +++ linux-2.6.11/drivers/ide/ide-io.c	2005-03-04 16:19:19.000000000
> -0500
> @@ -516,7 +516,19 @@ static ide_startstop_t ide_atapi_error(i
>  		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
>  
>  	if (rq->errors >= ERROR_MAX) {
> -		drive->driver->end_request(drive, 0, 0);
> +		/* 
> +		 * make sure request is fully ended--otherwise the 
> +		 * command will be retried without rq->errors getting
> +		 * reset to zero, which could cause us to get stuck
> +		 * in a loop with infinite retries without any more
> +		 * reset attempts
> +		 */
> +		int nsectors = rq->hard_nr_sectors;
> +		if (blk_pc_request(rq))
> +			nsectors = (rq->data_len + 511) >> 9;
> +		if (!nsectors)
> +			nsectors = 1;
> +		drive->driver->end_request(drive, 0, nsectors);
>  	} else {
>  		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
>  			++rq->errors;

Looks good, Bart care to pick this up?

Signed-off-by: Jens Axboe <axboe@suse.de>

-- 
Jens Axboe

