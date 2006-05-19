From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/14] libata-hp-prep: add flags and eh_info/context fields
 for hotplug
Date: Fri, 19 May 2006 10:58:58 -0400
Message-ID: <446DDD32.30702@pobox.com>
References: <11480445833575-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:16294 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932323AbWESO7P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 10:59:15 -0400
In-Reply-To: <11480445833575-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add hotplug related flags and eh_info/context fields.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  include/linux/libata.h |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)
> 
> 95c2d43950709c541509bbedd692e984dc67b474
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2803ab8..3fb6dc3 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -131,6 +131,9 @@ enum {
>  
>  	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
>  
> +	ATA_DFLAG_DETACH	= (1 << 16),
> +	ATA_DFLAG_DETACHED	= (1 << 17),
> +
>  	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
>  	ATA_DEV_ATA		= 1,	/* ATA device */
>  	ATA_DEV_ATA_UNSUP	= 2,	/* ATA device (unsupported) */
> @@ -153,6 +156,9 @@ enum {
>  	ATA_FLAG_PIO_POLLING	= (1 << 10), /* use polling PIO if LLD
>  					      * doesn't handle PIO interrupts */
>  	ATA_FLAG_NCQ		= (1 << 11), /* host supports NCQ */
> +	ATA_FLAG_HRST_TO_RESUME	= (1 << 12), /* hardreset to resume phy */
> +	ATA_FLAG_CANT_WAIT_FIS34 = (1 << 13), /* can't wait for the first D2H
> +					       * Register FIS clearing BSY */

FIS34 is an awful name.  I hereby ban it from libata :)

Also those names are getting long.  Consider shortening CANT_WAIT, 
perhaps to NOWAIT.  And perhaps s/HRST_TO_RESUME/HRST_RESUMES/.

ACK everything else in this patch.

	Jeff



