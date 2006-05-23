From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: merge irq-pio
Date: Tue, 23 May 2006 18:05:41 +0800
Message-ID: <4472DE75.6010507@tw.ibm.com>
References: <11473544042174-git-send-email-htejun@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:2744 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932162AbWEWKFy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2006 06:05:54 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4NA5rZ4027053
	for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 06:05:53 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4NA5oOo192280
	for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 04:05:53 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4NA5nDt006072
	for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 04:05:50 -0600
In-Reply-To: <11473544042174-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Tejun Heo wrote:
> Merge irq-pio.
> 

<snip>

> diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
> index 5b7fea5..56105a1 100644
> --- a/drivers/scsi/sata_mv.c
> +++ b/drivers/scsi/sata_mv.c
> @@ -87,7 +87,7 @@ enum {
>  	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
>  	MV_COMMON_FLAGS		= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>  				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
> -				   ATA_FLAG_NO_ATAPI),
> +				   ATA_FLAG_PIO_POLLING),
>  	MV_6XXX_FLAGS		= MV_FLAG_IRQ_COALESCE,
>  
>  	CRQB_FLAG_READ		= (1 << 0),

The ATA_FLAG_NO_ATAPI flag is lost by automatic merge.


> diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
> index 96d7b73..70a6954 100644
> --- a/drivers/scsi/sata_sx4.c
> +++ b/drivers/scsi/sata_sx4.c
> @@ -218,7 +218,7 @@ static const struct ata_port_info pdc_po
>  		.sht		= &pdc_sata_sht,
>  		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>  				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
> -				  ATA_FLAG_NO_ATAPI,
> +				  ATA_FLAG_PIO_POLLING,
>  		.pio_mask	= 0x1f, /* pio0-4 */
>  		.mwdma_mask	= 0x07, /* mwdma0-2 */
>  		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */

The ATA_FLAG_NO_ATAPI flag is lost.

>  		}
> diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
> index 9646c39..0372be7 100644
> --- a/drivers/scsi/sata_vsc.c
> +++ b/drivers/scsi/sata_vsc.c
> @@ -221,14 +221,21 @@ static irqreturn_t vsc_sata_interrupt (i
>  
>  			ap = host_set->ports[i];
>  
> -			if (ap && !(ap->flags &
> -				    (ATA_FLAG_DISABLED|ATA_FLAG_NOINTR))) {
> +			if (is_vsc_sata_int_err(i, int_status)) {
> +				u32 err_status;
> +				printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
> +				err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
> +				vsc_sata_scr_write(ap, SCR_ERROR, err_status);
> +				handled++;
> +			}
> +
> +			if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
>  				struct ata_queued_cmd *qc;
>  

The if(is_vsc_sata_int_err(i, int_status)) { } block is not irq-pio related.
Maybe it is from somewhere else?

Will submit a minor patch to put the ATA_FLAG_NO_ATAPI back.
--
albert




