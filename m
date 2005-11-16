From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC] libata: honor the transfer cycle time speficied by
 the EIDE device
Date: Wed, 16 Nov 2005 07:59:56 -0500
Message-ID: <437B2D4C.2090502@pobox.com>
References: <437AF68A.6020702@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:48307 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965256AbVKPNAG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 08:00:06 -0500
In-Reply-To: <437AF68A.6020702@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Albert Lee wrote:
> Jeff,
> 
>   The following code segment is not functional because the transfer cycle time speficied by 
>   the EIDE device is later overwritten by ata_timing_quantize():
> 
> 	/*
> 	 * If the drive is an EIDE drive, it can tell us it needs extended
> 	 * PIO/MW_DMA cycle timing.
> 	 */
> 	if (adev->id[ATA_ID_FIELD_VALID] & 2) {	/* EIDE drive */
> 		memset(&p, 0, sizeof(p));
> 		(snip)
> 		ata_timing_merge(&p, t, t, ATA_TIMING_CYCLE | ATA_TIMING_CYC8B);
>                <== uninitialized "t" is used here
> 	}
> 
> 	/*
> 	 * Convert the timing to bus clock counts.
> 	 */
> 	ata_timing_quantize(s, t, T, UT);  <== t is overwritten by quantized s
> 
>   The patch has been submitted for ide-timing.h before:
>   http://marc.theaimsgroup.com/?l=linux-ide&m=110820013425454&w=2
>   Resubmitted for libata.
> 
> Changes:
>   - Minor fix to honor the following transfer cycle time speficied by the device
>     - id[65]: Minimum Multiword DMA transfer cycle time per word
>     - id[67]: Minimum PIO transfer cycle time without flow control
>     - id[68]: Minimum PIO transfer cycle time with IORDY
> 
> Patch against the mainline tree
> (f6ff56cd56b83d8edf4b3cffc5c53c56b37a5081)
> For your review, thanks.
> 
> Albert
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> 
> =======
> 
> --- linux/drivers/scsi/libata-core.c	2005-11-16 16:26:39.000000000 +0800
> +++ time/drivers/scsi/libata-core.c	2005-11-16 16:30:59.000000000 +0800
> @@ -1570,11 +1570,13 @@ int ata_timing_compute(struct ata_device
>  
>  	/*
>  	 * Find the mode. 
> -	*/
> +	 */
>  
>  	if (!(s = ata_timing_find_mode(speed)))
>  		return -EINVAL;
>  
> +	memcpy(t, s, sizeof(*s));
> +
>  	/*
>  	 * If the drive is an EIDE drive, it can tell us it needs extended
>  	 * PIO/MW_DMA cycle timing.
> @@ -1595,7 +1597,7 @@ int ata_timing_compute(struct ata_device
>  	 * Convert the timing to bus clock counts.
>  	 */
>  
> -	ata_timing_quantize(s, t, T, UT);
> +	ata_timing_quantize(t, t, T, UT);


Applied to upstream-fixes branch.  Let's see if Alan screams...  :)

	Jeff


