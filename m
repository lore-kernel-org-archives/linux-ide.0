From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] ide-cd: fix REQ_QUIET tests in cdrom_decode_status
Date: Tue, 28 Apr 2009 23:40:14 +0200
Message-ID: <49F777BE.6010608@gmx.de>
References: <9ea470500904270903n720ab411o4a6c47945442bea4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:43341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752252AbZD1VkS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Apr 2009 17:40:18 -0400
In-Reply-To: <9ea470500904270903n720ab411o4a6c47945442bea4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, sshtylyov@ru.mvista.com

Borislav Petkov wrote:
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Mon, 27 Apr 2009 14:11:32 +0200
> Subject: [PATCH] ide-cd: fix REQ_QUIET tests in cdrom_decode_status
> 
> Original patch (dfa4411cc3a690011cab90e9a536938795366cf9) was buggy.
> This is a more proper fix which introduces blk_rq_quiet() macro
> alleviating the need for dumb, too short caching variables.
> 
> Thanks to Helge Deller and Bart for debugging this.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

Thanks a lot Borislav !
As Sergei already mentioned, the patch below is line-wrapped.

Anyway, I applied it on top of 2.6.30-rc3, fixed up the rejections manually 
and can confirm that this patch fixes the problems I reported for the parisc 
platform.

You may add my signed-off-by when you resend the fixed patch:
Signed-off-by: Helge Deller <deller@gmx.de>


> ---
>  drivers/ide/ide-cd.c   |    9 ++++-----
>  include/linux/blkdev.h |    1 +
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 6736287..a75e4ee 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -283,7 +283,6 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
>  	ide_hwif_t *hwif = drive->hwif;
>  	struct request *rq = hwif->rq;
>  	int err, sense_key, do_end_request = 0;
> -	u8 quiet = rq->cmd_flags & REQ_QUIET;
> 
>  	/* get the IDE error register */
>  	err = ide_read_error(drive);
> @@ -318,7 +317,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
>  		} else {
>  			cdrom_saw_media_change(drive);
> 
> -			if (blk_fs_request(rq) && !quiet)
> +			if (blk_fs_request(rq) && !blk_rq_quiet(rq))
>  				printk(KERN_ERR PFX "%s: tray open\n",
>  					drive->name);
>  		}
> @@ -353,7 +352,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
>  		 * No point in retrying after an illegal request or data
>  		 * protect error.
>  		 */
> -		if (!quiet)
> +		if (!blk_rq_quiet(rq))
>  			ide_dump_status(drive, "command error", stat);
>  		do_end_request = 1;
>  		break;
> @@ -362,14 +361,14 @@ static int cdrom_decode_status(ide_drive_t
> *drive, u8 stat)
>  		 * No point in re-trying a zillion times on a bad sector.
>  		 * If we got here the error is not correctable.
>  		 */
> -		if (!quiet)
> +		if (!blk_rq_quiet(rq))
>  			ide_dump_status(drive, "media error "
>  					"(bad sector)", stat);
>  		do_end_request = 1;
>  		break;
>  	case BLANK_CHECK:
>  		/* disk appears blank? */
> -		if (!quiet)
> +		if (!blk_rq_quiet(rq))
>  			ide_dump_status(drive, "media error (blank)",
>  					stat);
>  		do_end_request = 1;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ba54c83..6f841fb 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -598,6 +598,7 @@ enum {
>  				 blk_failfast_transport(rq) ||	\
>  				 blk_failfast_driver(rq))
>  #define blk_rq_started(rq)	((rq)->cmd_flags & REQ_STARTED)
> +#define blk_rq_quiet(rq)	((rq)->cmd_flags & REQ_QUIET)
> 
>  #define blk_account_rq(rq)	(blk_rq_started(rq) && (blk_fs_request(rq)
> || blk_discard_rq(rq)))
> 

