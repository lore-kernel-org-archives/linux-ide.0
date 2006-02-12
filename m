From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/4] libata: add per-device max_sectors
Date: Sun, 12 Feb 2006 14:37:05 -0500
Message-ID: <43EF8E61.5040409@pobox.com>
References: <1139754779159-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:40922 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751433AbWBLThL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 14:37:11 -0500
In-Reply-To: <1139754779159-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> If a low level driver wants to control max_sectors, it had to adjust
> ap->host->max_sectors and set ATA_DFLAG_LOCK_SECTORS to tell
> ata_scsi_slave_config not to override the limit.  This is not only
> cumbersome but also incorrect for hosts which support more than one
> devices per port.
> 
> This patch adds per-device ->max_sectors.  If the field is unset
> (zero), libata core layer will adjust ->max_sectors according to
> default rules.  If the field is set, libata honors the setting.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |    4 +---
>  drivers/scsi/libata-scsi.c |   18 +++++++++---------
>  drivers/scsi/sata_sil.c    |    4 +---
>  include/linux/libata.h     |    4 ++--
>  4 files changed, 13 insertions(+), 17 deletions(-)
> 
> 43ec393ac52f72d2a45f93ee2abf5255bed1d8db
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index c62798c..4db3db0 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -1147,9 +1147,7 @@ void ata_dev_config(struct ata_port *ap,
>  		printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
>  		       ap->id, i);
>  		ap->udma_mask &= ATA_UDMA5;
> -		ap->host->max_sectors = ATA_MAX_SECTORS;
> -		ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
> -		ap->device[i].flags |= ATA_DFLAG_LOCK_SECTORS;
> +		ap->device[i].max_sectors = ATA_MAX_SECTORS;
>  	}
>  
>  	if (ap->ops->dev_config)
> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
> index 3628fed..86da465 100644
> --- a/drivers/scsi/libata-scsi.c
> +++ b/drivers/scsi/libata-scsi.c
> @@ -684,23 +684,23 @@ int ata_scsi_slave_config(struct scsi_de
>  	if (sdev->id < ATA_MAX_DEVICES) {
>  		struct ata_port *ap;
>  		struct ata_device *dev;
> +		unsigned int max_sectors;
>  
>  		ap = (struct ata_port *) &sdev->host->hostdata[0];
>  		dev = &ap->device[sdev->id];
>  
> -		/* TODO: 1024 is an arbitrary number, not the
> +		/* TODO: 2048 is an arbitrary number, not the
>  		 * hardware maximum.  This should be increased to
>  		 * 65534 when Jens Axboe's patch for dynamically
>  		 * determining max_sectors is merged.
>  		 */
> -		if ((dev->flags & ATA_DFLAG_LBA48) &&
> -		    ((dev->flags & ATA_DFLAG_LOCK_SECTORS) == 0)) {
> -			/*
> -			 * do not overwrite sdev->host->max_sectors, since
> -			 * other drives on this host may not support LBA48
> -			 */
> -			blk_queue_max_sectors(sdev->request_queue, 2048);
> -		}
> +		max_sectors = ATA_MAX_SECTORS;
> +		if (dev->flags & ATA_DFLAG_LBA48)
> +			max_sectors = 2048;
> +		if (dev->max_sectors)
> +			max_sectors = dev->max_sectors;

applied 3-4, though note that the Axboe code mentioned in the comment is 
now in the kernel, so lba48 can be fixed properly.

	Jeff



