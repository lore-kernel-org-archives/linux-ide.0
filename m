From: Ashish Kalra <ashish.kalra@freescale.com>
Subject: Re: [PATCH][v3] Add asynchronous notification support
Date: Tue, 28 Jul 2009 06:16:56 -0700 (PDT)
Message-ID: <24698070.post@talk.nabble.com>
References: <Pine.WNT.4.64.0907012055100.868@B00888-02.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kuber.nabble.com ([216.139.236.158]:59383 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108AbZG1NQ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jul 2009 09:16:56 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MVmY4-0002UZ-HZ
	for linux-ide@vger.kernel.org; Tue, 28 Jul 2009 06:16:56 -0700
In-Reply-To: <Pine.WNT.4.64.0907012055100.868@B00888-02.fsl.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hello,

Wish to know the status of this patch ?

When will it be reviewed and merged into the mainline ? 

Thanks,
Ashish


Ashish Kalra wrote:
> 
> Enable device hot-plug support on Port multiplier fan-out ports
> v3 fixes whitespace/identation issues
> 
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
> ---
>   drivers/ata/sata_fsl.c |   15 ++++++++++-----
>   1 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 94eaa43..5a88b44 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -34,7 +34,7 @@ enum {
> 
>   	SATA_FSL_HOST_FLAGS	= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>   				ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
> -				ATA_FLAG_PMP | ATA_FLAG_NCQ),
> +				ATA_FLAG_PMP | ATA_FLAG_NCQ | ATA_FLAG_AN),
> 
>   	SATA_FSL_MAX_CMDS	= SATA_FSL_QUEUE_DEPTH,
>   	SATA_FSL_CMD_HDR_SIZE	= 16,	/* 4 DWORDS */
> @@ -132,8 +132,8 @@ enum {
>   	INT_ON_SINGL_DEVICE_ERR = (1 << 1),
>   	INT_ON_CMD_COMPLETE = 1,
> 
> -	INT_ON_ERROR = INT_ON_FATAL_ERR |
> -	    INT_ON_PHYRDY_CHG | INT_ON_SINGL_DEVICE_ERR,
> +	INT_ON_ERROR = INT_ON_FATAL_ERR | INT_ON_SNOTIFY_UPDATE |
> +		INT_ON_PHYRDY_CHG | INT_ON_SINGL_DEVICE_ERR,
> 
>   	/*
>   	 * Host Control Register (HControl) bitdefs
> @@ -153,8 +153,8 @@ enum {
>   	IE_ON_CMD_COMPLETE = 1,
> 
>   	DEFAULT_PORT_IRQ_ENABLE_MASK = IE_ON_FATAL_ERR | IE_ON_PHYRDY_CHG |
> -	    IE_ON_SIGNATURE_UPDATE |
> -	    IE_ON_SINGL_DEVICE_ERR | IE_ON_CMD_COMPLETE,
> +		IE_ON_SIGNATURE_UPDATE | IE_ON_SNOTIFY_UPDATE |
> +		IE_ON_SINGL_DEVICE_ERR | IE_ON_CMD_COMPLETE,
> 
>   	EXT_INDIRECT_SEG_PRD_FLAG = (1 << 31),
>   	DATA_SNOOP_ENABLE = (1 << 22),
> @@ -1003,6 +1003,11 @@ static void sata_fsl_error_intr(struct ata_port
> *ap)
>   		freeze = 1;
>   	}
> 
> +	/* Handle SDB FIS receive & notify update */
> +	if (hstatus & INT_ON_SNOTIFY_UPDATE) {
> +		sata_async_notification(ap);
> +	}
> +
>   	/* Handle PHYRDY change notification */
>   	if (hstatus & INT_ON_PHYRDY_CHG) {
>   		DPRINTK("SATA FSL: PHYRDY change indication\n");
> -- 
> 1.6.0
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/-PATCH--v3--Add-asynchronous-notification-support-tp24291875p24698070.html
Sent from the linux-ide mailing list archive at Nabble.com.

