From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: make WARN_ON conditions in ata_sff_hsm_move()
 more strict
Date: Fri, 25 Apr 2008 00:47:41 -0400
Message-ID: <4811626D.2010607@garzik.org>
References: <480F2214.1070807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46546 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbYDYEr4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 00:47:56 -0400
In-Reply-To: <480F2214.1070807@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Albert Lee <albertcc@tw.ibm.com>

Tejun Heo wrote:
> WARN_ON()'s in ata_hsm_move() was too liberal and got triggerred when
> it shouldn't (e.g. hotplug events at the right moment).  As the HSM
> only deals with device errors and state machine violations, make it
> check only against them.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mark Lord <liml@rtr.ca>
> Cc: Albert Lee <albertcc@tw.ibm.com>
> ---
> drivers/ata/libata-sff.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 1549952..2ec65a8 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1208,7 +1208,7 @@ fsm_start:
>         DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
>             ap->print_id, qc->dev->devno, status);
> 
> -        WARN_ON(qc->err_mask);
> +        WARN_ON(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM));
> 
>         ap->hsm_task_state = HSM_ST_IDLE;
> 
> @@ -1222,7 +1222,7 @@ fsm_start:
>         /* make sure qc->err_mask is available to
>          * know what's wrong and recover
>          */
> -        WARN_ON(qc->err_mask == 0);
> +        WARN_ON(!(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM)));
> 
>         ap->hsm_task_state = HSM_ST_IDLE;

applied


