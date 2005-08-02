From: Jens Axboe <axboe@suse.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 2 Aug 2005 16:11:57 +0200
Message-ID: <20050802141156.GF2408@suse.de>
References: <20050802113328.GK22569@suse.de> <42EF626B.6090103@imc-berlin.de> <20050802122609.GM22569@suse.de> <42EF69AD.30201@imc-berlin.de> <20050802125437.GA11967@suse.de> <42EF6F18.4090905@imc-berlin.de> <20050802130646.GA7519@suse.de> <42EF7747.6050208@imc-berlin.de> <20050802134546.GC2408@suse.de> <42EF7AFD.9090507@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:24718 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261541AbVHBOJy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Aug 2005 10:09:54 -0400
Content-Disposition: inline
In-Reply-To: <42EF7AFD.9090507@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

On Tue, Aug 02 2005, Steven Scholz wrote:
> [PATCH] ide: kill requests when drive is not present anymore
> 
> Signed-off-by: Steven Scholz <steven.scholz@imc-berlin.de>
> 
> Ok?
> 
> Change the CHANGELOG at your will.
> 
> --
> Steven

> --- linux-2.6.13-rc5/drivers/ide/ide-io.c	2005-06-17 21:48:29.000000000 +0200
> +++ linux-2.6.13-rc4-at91-multiIO/drivers/ide/ide-io.c	2005-08-02 15:46:53.000000000 +0200
> @@ -1230,7 +1257,17 @@ void do_ide_request(request_queue_t *q)
>  {
>  	ide_drive_t *drive = q->queuedata;
>  
> -	ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
> +	if (drive->present)
> +		ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
> +	else {
> +		struct request	*rq;
> +		printk(KERN_WARNING "%s: not present, killing requests\n", drive->name);
> +		while ((rq = elv_next_request(q)) != NULL) {
> +			blkdev_dequeue_request(rq);
> +			end_that_request_first(rq, 0, rq->hard_nr_sectors);
> +			end_that_request_last(rq);
> +		}
> +	}
>  }
>  
>  /*

Looks good to me now, that's one item off Barts list :-)

-- 
Jens Axboe

