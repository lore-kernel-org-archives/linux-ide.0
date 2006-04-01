From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 13/15] libata: add 1s sleep between resets
Date: Sat, 01 Apr 2006 14:57:00 -0500
Message-ID: <442EDB0C.4030103@pobox.com>
References: <1143823099305-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33245 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751480AbWDAT5F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 14:57:05 -0500
In-Reply-To: <1143823099305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Some devices react badly if resets are performed back-to-back.  Give
> devices some time to breath.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> e7f505c001fd4cb43b8123387285a7694790b4ae
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 30ee203..bd9ca3b 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -2633,6 +2633,7 @@ int ata_drive_probe_reset(struct ata_por
>  		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
>  		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
>  			goto done;
> +		ssleep(1);
>  	}
>  
>  	if (!hardreset)
> @@ -2649,6 +2650,7 @@ int ata_drive_probe_reset(struct ata_por
>  
>  		if (ata_down_sata_spd_limit(ap, &ap->device[0]))
>  			goto done;
> +		ssleep(1);

My gut says it should be at least 5 seconds...

	Jeff



