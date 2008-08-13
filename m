From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: bad sectors, suspicious behaviour
Date: Wed, 13 Aug 2008 17:47:56 +0700
Message-ID: <48A2BBDC.2090201@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:38339 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736AbYHMKrv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 06:47:51 -0400
In-Reply-To: <48A29E14.3090908@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

patch did not help,  but I found additional necessary condition (I=20
didn't take it into account before system reboot):

to reproduce the problem from scratch it is necessary to

echo 1 > =20
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host4/ta=
rget4:0:0/4:0:0:0/timeout

returning the value to 30 do not help.

With default 30 secs the problem can not be reproduced


Tejun Heo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hello, Mark, Artem.
>
> Mark Lord wrote:
>  =20
>> Mmm.. since it happens only once in a while, and not on every EH act=
ion,
>> one might assume that it's a race of some kind.
>>
>> One possibility, might be due to .qc_defer.
>>
>> The stock ata_qc_defer relies heavily on ata_tag_valid(),
>> which matches what the above WARN_ON uses.
>>
>> But sata_mv doesn't use ata_tag_valid, because it wants to know
>> about the entire port and not just a single individual link on the p=
ort.
>> So instead, it uses ap->nr_active_links for the test.
>>
>> My guess is that these two items are not kept in sync during EH.
>>    =20
>
> The culprit is mv_qc_defer().  If the controller is in host queueing
> mode, it allows multiple non-NCQ commands to be queued, which
> currently isn't allowed by the current libata core.  Allowing it
> shouldn't be too difficult but it would incur some core layer changes=
=2E
> For the time being, can you please test whether the following patch
> fixes the problem?
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20

