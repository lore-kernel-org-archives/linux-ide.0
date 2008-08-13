From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Wed, 13 Aug 2008 18:37:20 +0700
Message-ID: <48A2C770.2040200@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:48337 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752978AbYHMLhP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 07:37:15 -0400
In-Reply-To: <48A2C460.6040504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Now I have about 10 seconds of "disk restart" when hitting bad block=20
(with /sys/...../timeout=3D1).
Can somebody point me, if there any way to reduce it to 1/2/3 secs?

Tejun Heo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> sata_mv allowed issuing two DMA commands concurrently which the
> hardware allows.  Unfortunately, libata core layer isn't ready for
> this yet and spews ugly warning message and malfunctions on this.
> Don't allow concurrent DMA commands for now.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> No problem, Artem.
>
> Mark, does this look good to you?
>
>  drivers/ata/sata_mv.c |   34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index ad169ff..80c655f 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -1134,30 +1134,16 @@ static int mv_qc_defer(struct ata_queued_cmd =
*qc)
>  	if (ap->nr_active_links =3D=3D 0)
>  		return 0;
> =20
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
> -			if (qc->tf.protocol =3D=3D ATA_PROT_NCQ)
> -				return 0;
> -		} else {
> -			/*
> -			 * The host queue (EDMA) is in non-NCQ, DMA mode.
> -			 * If the new qc is also a non-NCQ, DMA command,
> -			 * then allow the new qc.
> -			 */
> -			if (qc->tf.protocol =3D=3D ATA_PROT_DMA)
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
> +	    (pp->pp_flags & MV_PP_FLAG_NCQ_EN) && ata_is_ncq(qc->tf.protoco=
l))
> +		return 0;
> +
>  	return ATA_DEFER_PORT;
>  }
> =20
>  =20

