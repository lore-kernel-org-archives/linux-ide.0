From: Jens Axboe <axboe@suse.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 2 Aug 2005 15:45:47 +0200
Message-ID: <20050802134546.GC2408@suse.de>
References: <20050802112804.GJ22569@suse.de> <42EF594C.7090902@imc-berlin.de> <20050802113328.GK22569@suse.de> <42EF626B.6090103@imc-berlin.de> <20050802122609.GM22569@suse.de> <42EF69AD.30201@imc-berlin.de> <20050802125437.GA11967@suse.de> <42EF6F18.4090905@imc-berlin.de> <20050802130646.GA7519@suse.de> <42EF7747.6050208@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:50921 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261520AbVHBNnz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Aug 2005 09:43:55 -0400
Content-Disposition: inline
In-Reply-To: <42EF7747.6050208@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

On Tue, Aug 02 2005, Steven Scholz wrote:
> Jens Axboe wrote:
> 
> >On Tue, Aug 02 2005, Steven Scholz wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>
> >>>It's not the right way, it only solves a little part of the problem.
> >>>Killing a request with an error usually looks like this:
> >>>
> >>>	blkdev_dequeue_request(rq);
> >>>	end_that_request_first(rq, 0, rq->hard_nr_sectors);
> >>>	end_that_request_last(rq);
> >>
> >>How do I get the request? do_ide_request() only get the complete 
> >>request_queue_t *q. Shell I use elv_next_request() ?
> >
> >Yes.
> 
> So my workaround for now would be
> 
> --- linux-2.6.13-rc5/drivers/ide/ide-io.c
> +++ linux-2.6.13-rc4-at91-multiIO/drivers/ide/ide-io.c
> @@ -1230,7 +1264,18 @@ void do_ide_request(request_queue_t *q)
>  {
>         ide_drive_t *drive = q->queuedata;
> 
> -       ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
> +       if (drive->present)
> +               ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
> +       else {
> +               struct request  *rq;
> +               printk("%s() drive is not present anymore! Kill 
> request.\n", __FUNCTION__);
> +               rq = elv_next_request(q);
> +               if (rq) {
> +                       blkdev_dequeue_request(rq);
> +                       end_that_request_first(rq, 0, rq->hard_nr_sectors);
> +                       end_that_request_last(rq);
> +               }
> +       }

Pretty close. Make the killing a loop:

        while ((rq = elv_next_request(q)) != NULL) {
                blkdev_dequeue_request(rq);
                end_that_request_first(rq, 0, rq->hard_nr_sectors);
                end_that_request_last(rq);
        }

and it looks ok to me. Change the printk to something a little more
appropriate as well, ala

        printk(KERN_WARNING "%s: not present, killing requests\n", drive->name);

-- 
Jens Axboe

