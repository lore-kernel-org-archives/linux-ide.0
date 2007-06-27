From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc5] libata: remove unused variable from ata_eh_reset()
Date: Wed, 27 Jun 2007 02:45:30 -0400
Message-ID: <4682078A.7040601@garzik.org>
References: <467FB858.1060907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37968 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759242AbXF0Gpc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jun 2007 02:45:32 -0400
In-Reply-To: <467FB858.1060907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Removed unused variable did_followup_srst from ata_eh_reset().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index d807098..48d2d54 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1616,7 +1616,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
>  	unsigned long deadline;
>  	unsigned int action;
>  	ata_reset_fn_t reset;
> -	int i, did_followup_srst, rc;
> +	int i, rc;
>  
>  	/* about to reset */
>  	ata_eh_about_to_do(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
> @@ -1689,11 +1689,9 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
>  
>  	rc = ata_do_reset(ap, reset, classes, deadline);
>  
> -	did_followup_srst = 0;
>  	if (reset == hardreset &&
>  	    ata_eh_followup_srst_needed(rc, classify, classes)) {
>  		/* okay, let's do follow-up softreset */
> -		did_followup_srst = 1;
>  		reset = softreset;
>  

applied


