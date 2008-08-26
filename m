From: "Gwendal Grignou" <gwendal@google.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands concurrently
Date: Mon, 25 Aug 2008 18:24:57 -0700
Message-ID: <e7510f760808251824m2da1331eq514e864209654028@mail.gmail.com>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca>
	 <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca>
	 <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru>
	 <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru>
	 <48A2C460.6040504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:24033 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbYHZBZP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 21:25:15 -0400
Received: from spaceape7.eur.corp.google.com (spaceape7.eur.corp.google.com [172.28.16.141])
	by smtp-out.google.com with ESMTP id m7Q1Ox5p026664
	for <linux-ide@vger.kernel.org>; Tue, 26 Aug 2008 02:24:59 +0100
Received: from yw-out-1718.google.com (ywk9.prod.google.com [10.192.11.9])
	by spaceape7.eur.corp.google.com with ESMTP id m7Q1OvbG003787
	for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 18:24:58 -0700
Received: by yw-out-1718.google.com with SMTP id 9so143062ywk.64
        for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 18:24:57 -0700 (PDT)
In-Reply-To: <48A2C460.6040504@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Artem Bokhan <aptem@ngs.ru>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

What happen if there is a SATA port multiplier behing the marvell
controller and NCQ is disabled?

I have the impression that with this patch we are able to only send
one DMA command at a time to all the drives behind the PM, which has
an impact on performance.

Gwendal.

On Wed, Aug 13, 2008 at 4:24 AM, Tejun Heo <htejun@gmail.com> wrote:
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
> @@ -1134,30 +1134,16 @@ static int mv_qc_defer(struct ata_queued_cmd *qc)
>        if (ap->nr_active_links == 0)
>                return 0;
>
> -       if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
> -               /*
> -                * The port is operating in host queuing mode (EDMA).
> -                * It can accomodate a new qc if the qc protocol
> -                * is compatible with the current host queue mode.
> -                */
> -               if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {
> -                       /*
> -                        * The host queue (EDMA) is in NCQ mode.
> -                        * If the new qc is also an NCQ command,
> -                        * then allow the new qc.
> -                        */
> -                       if (qc->tf.protocol == ATA_PROT_NCQ)
> -                               return 0;
> -               } else {
> -                       /*
> -                        * The host queue (EDMA) is in non-NCQ, DMA mode.
> -                        * If the new qc is also a non-NCQ, DMA command,
> -                        * then allow the new qc.
> -                        */
> -                       if (qc->tf.protocol == ATA_PROT_DMA)
> -                               return 0;
> -               }
> -       }
> +       /*
> +        * The port is operating in host queuing mode (EDMA) with NCQ
> +        * enabled, allow multiple NCQ commands.  EDMA also allows
> +        * queueing multiple DMA commands but libata core currently
> +        * doesn't allow it.
> +        */
> +       if ((pp->pp_flags & MV_PP_FLAG_EDMA_EN) &&
> +           (pp->pp_flags & MV_PP_FLAG_NCQ_EN) && ata_is_ncq(qc->tf.protocol))
> +               return 0;
> +
>        return ATA_DEFER_PORT;
>  }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
