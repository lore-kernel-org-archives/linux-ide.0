From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.24-rc1] sata_promise: ASIC PRD table bug workaround
Date: Mon, 29 Oct 2007 15:07:06 -0400
Message-ID: <47262F5A.8070804@garzik.org>
References: <200710291550.l9TFocYf018050@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56133 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754822AbXJ2THJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Oct 2007 15:07:09 -0400
In-Reply-To: <200710291550.l9TFocYf018050@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, Alexander Sabourenkov <screwdriver@lxnt.info>

Mikael Pettersson wrote:
> @@ -155,7 +155,7 @@ static struct scsi_host_template pdc_ata
>  	.queuecommand		= ata_scsi_queuecmd,
>  	.can_queue		= ATA_DEF_QUEUE,
>  	.this_id		= ATA_SHT_THIS_ID,
> -	.sg_tablesize		= LIBATA_MAX_PRD,
> +	.sg_tablesize		= LIBATA_MAX_PRD-1,
>  	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
>  	.emulated		= ATA_SHT_EMULATED,
>  	.use_clustering		= ATA_SHT_USE_CLUSTERING,

IMO, this will be difficult for human eyes to see, many months from now.

I would prefer a 'PDC_MAX_PRD' constant, defined to this value.


> @@ -530,7 +608,7 @@ static void pdc_qc_prep(struct ata_queue
>  
>  	switch (qc->tf.protocol) {
>  	case ATA_PROT_DMA:
> -		ata_qc_prep(qc);
> +		pdc_fill_sg(qc);
>  		/* fall through */
>  
>  	case ATA_PROT_NODATA:
> @@ -546,11 +624,11 @@ static void pdc_qc_prep(struct ata_queue
>  		break;
>  
>  	case ATA_PROT_ATAPI:
> -		ata_qc_prep(qc);
> +		pdc_fill_sg(qc);
>  		break;
>  
>  	case ATA_PROT_ATAPI_DMA:
> -		ata_qc_prep(qc);
> +		pdc_fill_sg(qc);
>  		/*FALLTHROUGH*/

Note that this is not exactly an equivalent change -- you are removing 
the test in ata_qc_prep() that occurs prior to ata_fill_sg() call.

	Jeff


