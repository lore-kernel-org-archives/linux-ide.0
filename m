From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Wed, 13 Aug 2008 12:10:14 -0400
Message-ID: <48A30766.9030600@rtr.ca>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:54546 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbYHMQKQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 12:10:16 -0400
In-Reply-To: <48A2C460.6040504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Artem Bokhan <aptem@ngs.ru>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> sata_mv allowed issuing two DMA commands concurrently which the
> hardware allows.  Unfortunately, libata core layer isn't ready for
> this yet and spews ugly warning message and malfunctions on this.
> Don't allow concurrent DMA commands for now.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> No problem, Artem.
> 
> Mark, does this look good to you?

Yeah, looks fine.  For some odd reason, I must have been thinking
that libata-{scsi,core} would not even attempt multiple simultaneous non-NCQ.
Silly me!

> 
>  drivers/ata/sata_mv.c |   34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index ad169ff..80c655f 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -1134,30 +1134,16 @@ static int mv_qc_defer(struct ata_queued_cmd *qc)
>  	if (ap->nr_active_links == 0)
>  		return 0;
>  
> -	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
> -		/*
> -		 * The port is operating in host queuing mode (EDMA).
> -		 * It can accomodate a new qc if the qc protocol
> -		 * is compatible with the current host queue mode.
> -		 */
> -		if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {
> -			/*
> -			 * The host queue (EDMA) is in NCQ mode.
> -			 * If the new qc is also an NCQ command,
> -			 * then allow the new qc.
> -			 */
> -			if (qc->tf.protocol == ATA_PROT_NCQ)
> -				return 0;
> -		} else {
> -			/*
> -			 * The host queue (EDMA) is in non-NCQ, DMA mode.
> -			 * If the new qc is also a non-NCQ, DMA command,
> -			 * then allow the new qc.
> -			 */
> -			if (qc->tf.protocol == ATA_PROT_DMA)
> -				return 0;
> -		}
> -	}
> +	/*
> +	 * The port is operating in host queuing mode (EDMA) with NCQ
> +	 * enabled, allow multiple NCQ commands.  EDMA also allows
> +	 * queueing multiple DMA commands but libata core currently
> +	 * doesn't allow it.
> +	 */
> +	if ((pp->pp_flags & MV_PP_FLAG_EDMA_EN) &&
> +	    (pp->pp_flags & MV_PP_FLAG_NCQ_EN) && ata_is_ncq(qc->tf.protocol))
> +		return 0;
> +
>  	return ATA_DEFER_PORT;
>  }
>  

