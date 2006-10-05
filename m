From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: make user scan wait for scan to complete
Date: Thu, 05 Oct 2006 07:22:40 -0400
Message-ID: <4524EB00.9040309@pobox.com>
References: <20060930090717.GO25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:18142 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750767AbWJELWn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Oct 2006 07:22:43 -0400
In-Reply-To: <20060930090717.GO25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, fajunchen@gmail.com

Tejun Heo wrote:
> Make user scan wait for scan to complete.  This way user can wait for
> warm plug request to complete and is prevented from causing EH event
> storm by repetitively issuing scan request while EH is in progress.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Fajun Chen <fajunchen@gmail.com>
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3986ec8..e1fe832 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3138,10 +3138,12 @@ static int ata_scsi_user_scan(struct Scs
>  			rc = -EINVAL;
>  	}
>  
> -	if (rc == 0)
> +	if (rc == 0) {
>  		ata_port_schedule_eh(ap);
> -
> -	spin_unlock_irqrestore(ap->lock, flags);
> +		spin_unlock_irqrestore(ap->lock, flags);
> +		ata_port_wait_eh(ap);
> +	} else
> +		spin_unlock_irqrestore(ap->lock, flags);

Given that we are now 2.6.19-rc1, would you say this applies to 
#upstream-fixes or #upstream?

I'm OK with it either way.

	Jeff



