From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata: use AC_ERR_TIMEOUT err_mask for time out
Date: Fri, 31 Mar 2006 10:06:09 -0500
Message-ID: <442D4561.60705@pobox.com>
References: <442CC185.3060200@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:23226 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932138AbWCaPGQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 10:06:16 -0500
In-Reply-To: <442CC185.3060200@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Use AC_ERR_TIMEOUT err_mask for time out,
> instead of generating err_mask from drv_stat.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> This patch was accepted in irq-pio before.
> 
> Patch against upstream (8b316a3973f05e572b4edeeda9072987f6bbaa44).
> For your review, thanks.
> 
> Albert
> 
> --- upstream0/drivers/scsi/libata-core.c	2006-03-31 13:33:15.000000000 +0800
> +++ upstream1/drivers/scsi/libata-core.c	2006-03-31 13:34:59.000000000 +0800
> @@ -3827,7 +3827,7 @@ static void ata_qc_timeout(struct ata_qu
>  		       ap->id, qc->tf.command, drv_stat, host_stat);
>  
>  		/* complete taskfile transaction */
> -		qc->err_mask |= ac_err_mask(drv_stat);
> +		qc->err_mask |= AC_ERR_TIMEOUT;

The intention here is to catch missed interrupts; due to flaky hardware 
or buggy drivers, we may miss an interrupt, but still be able to 
complete the qc in the timeout handler.  Thus, if the ac_err_mask() 
indicates a BSY or DRQ or DF is asserted, it will indicate an error, 
otherwise not.

So, NAK, and we should fix irq-pio for this as well...

	Jeff



