From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH]: resubmitted: Fix erroneous rq->buffer = NULL in ide-io.c:ide_dma_timeout_retry
Date: Thu, 6 Jan 2005 16:55:56 +0100
Message-ID: <20050106155552.GQ17821@suse.de>
References: <41DD5794.6080804@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:22735 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262881AbVAFP4M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2005 10:56:12 -0500
Content-Disposition: inline
In-Reply-To: <41DD5794.6080804@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prarit Bhargava <prarit@sgi.com>
Cc: linux-ide@vger.kernel.org

On Thu, Jan 06 2005, Prarit Bhargava wrote:
> Colleagues,
> 
> Please see discussion related to this patch here,
> 
> http://marc.theaimsgroup.com/?l=linux-ide&m=110485007824374&w=2

Acked-by: Jens Axboe <axboe@suse.de>

> Thanks,
> 
> Prarit.
> 
> 
> --- linux-2.5.orig/drivers/ide/ide-io.c 2005-01-04 15:45:17.000000000 -0500
> +++ linux-2.5/drivers/ide/ide-io.c      2005-01-04 15:45:27.000000000 -0500
> @@ -1205,21 +1205,21 @@
>        HWGROUP(drive)->rq = NULL;
> 
>        rq->errors = 0;
> 
>        if (!rq->bio)
>                goto out;
> 
>        rq->sector = rq->bio->bi_sector;
>        rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
>        rq->hard_cur_sectors = rq->current_nr_sectors;
> -       rq->buffer = NULL;
> +       rq->buffer = bio_data(rq->bio);
> out:
>        return ret;
> }
> 
> /**
>  *     ide_timer_expiry        -       handle lack of an IDE interrupt
>  *     @data: timer callback magic (hwgroup)
>  *
>  *     An IDE command has timed out before the expected drive return
>  *     occurred. At this point we attempt to clean up the current
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Jens Axboe

