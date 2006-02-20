From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 7/7] libata: reorganize ata_bus_probe()
Date: Mon, 20 Feb 2006 05:43:19 -0500
Message-ID: <43F99D47.4060603@pobox.com>
References: <113999544950-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:63953 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964866AbWBTKnX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 05:43:23 -0500
In-Reply-To: <113999544950-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Now that reset and configure are converted such that they don't modify
> or disable libata core data structures, reorganize ata_bus_probe() to
> reflect this change.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |   46 ++++++++++++++++++++++++--------------------
>  1 files changed, 25 insertions(+), 21 deletions(-)
> 
> 04a9356ddbbfafba7ec9b6b71db30ccad2190e02
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 761186d..8c0d48f 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -1207,35 +1207,40 @@ err_out_nosup:
>  
>  static int ata_bus_probe(struct ata_port *ap)
>  {
> -	unsigned int i, found = 0;
> +	unsigned int classes[ATA_MAX_DEVICES];
> +	unsigned int i, rc, found = 0;
>  
> -	if (ap->ops->probe_reset) {
> -		unsigned int classes[ATA_MAX_DEVICES];
> -		int rc;
> -
> -		ata_port_probe(ap);
> +	ata_port_probe(ap);
>  
> +	/* reset */
> +	if (ap->ops->probe_reset) {
>  		rc = ap->ops->probe_reset(ap, classes);
> -		if (rc == 0) {
> -			for (i = 0; i < ATA_MAX_DEVICES; i++) {
> -				if (classes[i] == ATA_DEV_UNKNOWN)
> -					classes[i] = ATA_DEV_NONE;
> -				ap->device[i].class = classes[i];
> -			}
> -		} else {
> -			printk(KERN_ERR "ata%u: probe reset failed, "
> -			       "disabling port\n", ap->id);
> -			ata_port_disable(ap);
> +		if (rc) {
> +			printk("ata%u: reset failed (errno=%d)\n", ap->id, rc);
> +			return rc;
>  		}
> -	} else
> +
> +		for (i = 0; i < ATA_MAX_DEVICES; i++)
> +			if (classes[i] == ATA_DEV_UNKNOWN)
> +				classes[i] = ATA_DEV_NONE;
> +	} else {
>  		ap->ops->phy_reset(ap);
>  
> -	if (ap->flags & ATA_FLAG_PORT_DISABLED)
> -		goto err_out;
> +		for (i = 0; i < ATA_MAX_DEVICES; i++) {
> +			if (!(ap->flags & ATA_FLAG_PORT_DISABLED))
> +				classes[i] = ap->device[i].class;
> +			else
> +				ap->device[i].class = ATA_DEV_UNKNOWN;
> +		}
> +		ata_port_probe(ap);
> +	}

the legacy phy_reset code path appears to call ata_port_probe() a second 
time.  otherwise, seems OK.

	Jeff



