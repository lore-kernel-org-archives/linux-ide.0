From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata-sff: kill spurious WARN_ON() in
 ata_hsm_move()
Date: Mon, 08 Sep 2008 12:16:20 -0400
Message-ID: <48C54FD4.6000001@garzik.org>
References: <48B8075F.9040805@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37753 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690AbYIHQQX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 12:16:23 -0400
In-Reply-To: <48B8075F.9040805@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> On HSM_ST_ERR, ata_hsm_move() triggers WARN_ON() if AC_ERR_DEV or
> AC_ERR_HSM is not set.  PHY events may trigger HSM_ST_ERR with other
> error codes and, with or without it, there just isn't much reason to
> do WARN_ON() on it.  Even if error code is not set there, core EH
> logic won't have any problem dealing with the error condition.
> 
> OSDL bz#11065 reports this problem.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/libata-sff.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 304fdc6..2a4c516 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1315,11 +1315,6 @@ fsm_start:
>  		break;
>  
>  	case HSM_ST_ERR:
> -		/* make sure qc->err_mask is available to
> -		 * know what's wrong and recover
> -		 */
> -		WARN_ON(!(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM)));
> -
>  		ap->hsm_task_state = HSM_ST_IDLE;
>  

applied


