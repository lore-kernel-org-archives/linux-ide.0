From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 07/14] ide-cd: clear sense buffer before issuing
	request sense
Date: Thu, 26 Mar 2009 08:20:44 +0100
Message-ID: <20090326072044.GA32155@liondog.tnic>
References: <1237910776-10983-1-git-send-email-tj@kernel.org> <1237910776-10983-8-git-send-email-tj@kernel.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:33441 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbZCZHUv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2009 03:20:51 -0400
Content-Disposition: inline
In-Reply-To: <1237910776-10983-8-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi Tejun,

On Wed, Mar 25, 2009 at 01:06:09AM +0900, Tejun Heo wrote:
> Impact: code simplification
> 
> ide_cd_request_sense_fixup() clears the tail of the sense buffer if
> the device didn't completely fill it.  This patch makes
> cdrom_queue_request_sense() clear the sense buffer before issuing the
> command instead of clearing it afterwards.  This simplifies code and
> eases future changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ide/ide-cd.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 35729a4..b3736b4 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -217,6 +217,8 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
>  	if (sense == NULL)
>  		sense = &info->sense_data;
>  
> +	memset(sense, 0, 18);
> +

Hmm, not quite. If its info->sense_data, then 18 is not correct. Rather,
sizeof(struct request_sense) would be more likely the proper length. So,
actually, it would be more like:

unsigned sense_len = 18;

if (sense == NULL) {
	sense = &info->sense_data;
	sense_len = sizeof(struct request_sense);
}

memset(sense, 0, sense_len);

>  	/* stuff the sense request in front of our current request */
>  	blk_rq_init(NULL, rq);
>  	rq->cmd_type = REQ_TYPE_ATA_PC;
> @@ -520,14 +522,8 @@ static void ide_cd_request_sense_fixup(ide_drive_t *drive, struct ide_cmd *cmd)
>  	 * and some drives don't send them.  Sigh.
>  	 */
>  	if (rq->cmd[0] == GPCMD_REQUEST_SENSE &&
> -	    cmd->nleft > 0 && cmd->nleft <= 5) {
> -		unsigned int ofs = cmd->nbytes - cmd->nleft;
> -
> -		while (cmd->nleft > 0) {
> -			*((u8 *)rq->data + ofs++) = 0;
> -			cmd->nleft--;
> -		}
> -	}
> +	    cmd->nleft > 0 && cmd->nleft <= 5)
> +		cmd->nleft = 0;
>  }
>

Otherwise, I like it.

-- 
Regards/Gruss,
    Boris.
