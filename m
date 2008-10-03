From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] ide-cd: shorten ide_cd_request_sense_fixup's param list
Date: Fri, 3 Oct 2008 19:29:23 +0200
Message-ID: <200810031929.24291.bzolnier@gmail.com>
References: <1222669799-6565-1-git-send-email-petkovbb@gmail.com> <1222669799-6565-4-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754768AbYJCRo3@vger.kernel.org>
In-Reply-To: <1222669799-6565-4-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Monday 29 September 2008, Borislav Petkov wrote:
> ... since HWGROUP(drive)->rq points to the same rq as in the irq handler. While

Since we already have obtained rq pointer why not pass it to the helper
function instead of having the helper function waste cycles on it?

Moreover it results in slightly bigger code...

> at it, remove stale comment.

I applied this part only.

> There should be no functionality change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-cd.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index e41b94d..bf92cd6 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -843,12 +843,11 @@ static void ide_cd_restore_request(ide_drive_t *drive, struct request *rq)
>  	rq->q->prep_rq_fn(rq->q, rq);
>  }
>  
> -/*
> - * All other packet commands.
> - */
> -static void ide_cd_request_sense_fixup(ide_drive_t *drive, struct request *rq)
> +static void ide_cd_request_sense_fixup(ide_drive_t *drive)
>  {
>  
> +	struct request *rq = HWGROUP(drive)->rq;
> +
>  	ide_debug_log(IDE_DBG_FUNC, "Call %s, rq->cmd[0]: 0x%x\n",
>  		      __func__, rq->cmd[0]);
>  
> @@ -1021,7 +1020,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
>  			cdrom_end_request(drive, uptodate);
>  			return ide_stopped;
>  		} else if (!blk_pc_request(rq)) {
> -			ide_cd_request_sense_fixup(drive, rq);
> +			ide_cd_request_sense_fixup(drive);
>  			/* complain if we still have data left to transfer */
>  			uptodate = rq->data_len ? 0 : 1;
>  		}
