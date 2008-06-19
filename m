From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Thu, 19 Jun 2008 22:47:24 +0200
Message-ID: <200806192247.25063.bzolnier@gmail.com>
References: <87k5gmz596.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:54600 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbYFSUqY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jun 2008 16:46:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so212855and.103
        for <linux-ide@vger.kernel.org>; Thu, 19 Jun 2008 13:46:23 -0700 (PDT)
In-Reply-To: <87k5gmz596.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org


Hi,

On Thursday 19 June 2008, Elias Oltmanns wrote:
> Hi Bart,
> 
> currently, the code path executing an HDIO_DRIVE_RESET ioctl is broken
> in various ways.  Firstly, ide_abort() is called with the ide_lock held
> and may call ide_end_request() further down the line which will try to
> grab the same lock again.  More importantly though, the whole concept of
> aborting an inflight request is flawed -- at least as far as ide_abort()
> is concerned.
> 
> The patch below tries to address these issues by handling the
> HDIO_DRIVE_RESET ioctl in-band.  I wonder whether this approach is
> acceptable and may be extended to other applications like a modified

This approach is exactly the way it should have been done. :)

> version of the disk shock protection patches.  Also, I abstained from
> using op codes 0x0 to 0x1f since at least part of this range is used by
> 
> ULDs like ide-floppy, ide-tape, etc.  On the other hand, there really
> should be no conflict because those ULDs will always set ->rq_disk thus
> preventing ide_special_rq() from snatching away what should be passed on
> to ->do_request().  So, what's you're advice on this one?  Finally,

The solution present in the patch is OK for now (+ it doesn't interfere
with some other work being done in ULDs by Borislav) but needs documenting.

> shouldn't op codes like REQ_DRIVE_RESET really be declared in a private
> header file in drivers/ide/?

I think that for such defines <linux/ide.h> is appropriate for now.

[ OTOH it sounds like a good idea in the longer term to move some
  things from <linux/ide.h> to drivers/ide/ide.h ]

One more thing, ide-2.6 is for syncing with Linus _only_ (it seems I'm to
blame for the confusion), please rebase your work on top of pata-2.6 quilt
tree (some comments which should ease the transition below):

	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/

[ This tree is pulled into linux-next so you may prefer to just use the
  latest -next snapshost instead. ]

[...]

> @@ -891,7 +904,8 @@ static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
>  			    pm->pm_step == ide_pm_state_completed)
>  				ide_complete_pm_request(drive, rq);
>  			return startstop;
> -		}
> +		} else if (!rq->rq_disk && blk_special_request(rq))

Please document with "TODO:" why we need this rq->rq_disk check here
(as ULDs should later be fixed to only check for specific rq->cmd[0]
values of blk_special_request() requests).

> +			return ide_special_rq(drive, rq);
>  
>  		drv = *(ide_driver_t **)rq->rq_disk->private_data;
>  		return drv->do_request(drive, rq, block);
> diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
> index c758dcb..4f9c796 100644
> --- a/drivers/ide/ide.c
> +++ b/drivers/ide/ide.c
> @@ -623,6 +623,19 @@ static int generic_ide_resume(struct device *dev)
>  	return err;
>  }
>  
> +static void generic_drive_reset(ide_drive_t *drive)
> +{
> +	struct request *rq;
> +
> +	rq = blk_get_request(drive->queue, 0, __GFP_WAIT);
> +	/* Should we call ide_init_drive_cmd() here? */

blk_get_request() is sufficient (ide_init_drive_cmd() is gone now)

> +	rq->cmd[0] = REQ_DRIVE_RESET;
> +	rq->cmd_type = REQ_TYPE_SPECIAL;
> +	rq->cmd_flags |= REQ_SOFTBARRIER;
> +	ide_do_drive_cmd(drive, rq, ide_end);

ide_do_drive_cmd() now handles only ide_preempt + it seems that previously
the ioctl would wait till the reset is complete so probably this needs to
use blk_execute_rq() instead

[...]

Oh, and now that you've fixed HDIO_DRIVE_RESET you get the following bonus:
ide_abort(), __ide_abort() and ide_driver_t.abort all can be removed in the
incremental patch! ;)

Thanks,
Bart
