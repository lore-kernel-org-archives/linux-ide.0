From: Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 17:42:02 -0600
Message-ID: <45BE864A.2050907@cs.wisc.edu>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>  <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net> <1170051963.6454.7.camel@Homer.simpson.net> <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org> <45BE5AF0.3030005@cs.wisc.edu> <Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org> <Pine.LNX.4.64.0701291414410.3611@woody.linux-foundation.org> <Pine.LNX.4.64.0701291453230.3611@woody.linux-foundation.org> <Pine.LNX.4.64.0701291532050.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sabe.cs.wisc.edu ([128.105.6.20]:44919 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964845AbXA2Xwe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 18:52:34 -0500
In-Reply-To: <Pine.LNX.4.64.0701291532050.3611@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Boaz Harrosh <bharrosh@panasas.com>

Linus Torvalds wrote:
> Uwe, others, does this patch fix your problem?
> 

I can replicate the problem now using a older box, but same driver.

> It will have a few printk's that it spews out, but if it fixes your 
> problem, at least we know a bit more.
> 
> 		Linus
> ---
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> index 2528a0c..f0ff151 100644
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -333,8 +333,13 @@ static int sg_io(struct file *file, request_queue_t *q,
>  			hdr->sb_len_wr = len;
>  	}
>  
> -	if (blk_rq_unmap_user(bio))
> +	if (rq->bio != bio)
> +		printk("rq->bio = %p, bio = %p\n", rq->bio, bio);
> +

rq->bio is NULL here, so no data is coped back to userspace and it seems
nero just stops trying to talk to the drive after this.

Because nero just gives up, no more commands are sent and we do not get
flooded with status errors like before so it sort of looks like it
solves the problem but it doesn't - at least that is what is happening here.

The reason for using the bio in that patch is that
__end_that_request_first eventually sets rq->bio to NULL so the caller
of the blk_execute is supposed to save a pointer to the first bio for
later unmapping.


