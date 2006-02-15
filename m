From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: minor fix for 2.6.16-rc3
Date: Wed, 15 Feb 2006 15:07:32 +0900
Message-ID: <43F2C524.6030705@gmail.com>
References: <43F0659D.9000109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:2880 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751016AbWBOGHg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 01:07:36 -0500
Received: by pproxy.gmail.com with SMTP id s49so1399103pyc
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2006 22:07:36 -0800 (PST)
In-Reply-To: <43F0659D.9000109@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Hello, Albert.  Hello, Jeff.

Albert Lee wrote:
> Jeff,
> 
> Just two minor fixes from libata-dev tree that might be good for 2.6.16:
>  - Fix the array index value in ata_rwcmd_protocol() for the added FUA commands.

Oops, this one seems critical.  Guess I messed up during FUA changes, 
sorry. :-(  Albert, can you please re-spin this part of the patch 
against #upstream?

Acked-by: Tejun Heo <htejun@gmail.com>

Thanks.

>  - Filter out ATAPI packet command error messages in ata_pio_error()
> 
> Patch against the mainline 2.6.16-rc3 tree.
> For your review, thanks.
> 
> Albert
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 
> 
> ---
> 
> --- linux-2.6.16-rc3/drivers/scsi/libata-core.c	2006-02-13 18:41:48.000000000 +0800
> +++ linux-2.6.16-rc3-mod/drivers/scsi/libata-core.c	2006-02-13 18:44:58.000000000 +0800
> @@ -614,7 +614,7 @@ int ata_rwcmd_protocol(struct ata_queued
>  	} else if (lba48 && (qc->ap->flags & ATA_FLAG_PIO_LBA48)) {
>  		/* Unable to use DMA due to host limitation */
>  		tf->protocol = ATA_PROT_PIO;
> -		index = dev->multi_count ? 0 : 4;
> +		index = dev->multi_count ? 0 : 8;
>  	} else {
>  		tf->protocol = ATA_PROT_DMA;
>  		index = 16;
> @@ -3357,11 +3357,12 @@ static void ata_pio_error(struct ata_por
>  {
>  	struct ata_queued_cmd *qc;
>  
> -	printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
> -
>  	qc = ata_qc_from_tag(ap, ap->active_tag);
>  	assert(qc != NULL);
>  
> +	if (qc->tf.command != ATA_CMD_PACKET)
> +		printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
> +
>  	/* make sure qc->err_mask is available to 
>  	 * know what's wrong and recover
>  	 */

-- 
tejun
