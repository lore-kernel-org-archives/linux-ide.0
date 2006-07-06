From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata EH appears to be NFG up to 2.6.17 (at least).
Date: Thu, 06 Jul 2006 18:09:41 -0400
Message-ID: <44AD8A25.7020006@pobox.com>
References: <44AD749C.1070208@rtr.ca> <44AD76CA.40100@pobox.com> <44AD77D5.90905@rtr.ca> <200607061724.13448.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:30148 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750904AbWGFWJp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jul 2006 18:09:45 -0400
In-Reply-To: <200607061724.13448.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>, Ric Wheeler <ric@emc.com>

Mark Lord wrote:
> Enable libata-scsi to report correct sense data on errors.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>
> ---
> --- linux/drivers/scsi/libata-scsi.c.orig	2006-07-06 17:09:54.000000000 -0400
> +++ linux/drivers/scsi/libata-scsi.c	2006-07-06 17:17:43.000000000 -0400
> @@ -667,6 +667,13 @@
>  	qc->ap->ops->tf_read(qc->ap, tf);
>  
>  	/*
> +	 * Restore the error bit, which got cleared when the
> +	 * interrupt handler first read the ata_status.
> +	 */
> +	if (qc->err_mask & AC_ERR_DEV)
> +		tf->command |= ATA_ERR;
> +
> +	/*
>  	 * Use ata_to_sense_error() to map status register bits


Again it's an LLDD issue.  Your answer of "all LLDDs" sounds a bit 
suspicious.

AC_ERR_DEV should not be set unless (a) some code noticed that ATA_ERR 
was already present in the Status register, or (b) some code set 
AC_ERR_DEV for some reason other than ATA_ERR presence.  Both of those 
factors depend heavily on LLDD behavior.

ANYWAY, your above patch is not wrong, but it begs the question of where 
the problem REALLY lies.  Which LLDD sets AC_ERR_DEV when ATA_ERR is not 
present?

	Jeff


