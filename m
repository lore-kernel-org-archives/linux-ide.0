From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 4/4] libata: make libata use printk_header() and mprintk
Date: Tue, 15 Jan 2008 18:48:19 -0800
Message-ID: <20080115184819.78069cce.randy.dunlap@oracle.com>
References: <1200445210549-git-send-email-htejun@gmail.com>
	<12004452112326-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:57618 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758180AbYAPCsg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 21:48:36 -0500
In-Reply-To: <12004452112326-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, daniel.ritz-ml@swissonline.ch, jeff@garzik.org, linux-ide@vger.kernel.org

On Wed, 16 Jan 2008 10:00:10 +0900 Tejun Heo wrote:

> Reimplement libata printk helpers using printk_header, implement
> helpers to initialize mprintk and use mprintk during device
> configuration and EH reporting.
> 
> This fixes various formatting related problems of libata messages such
> as misaligned multiline messages, decoded register lines with leading
> headers making them difficult to tell to which error they belong to,
> awkward manual indents and complex message printing logics.  More
> importantly, by making message assembly flexible, this patch makes
> future changes to device configuration and EH reporting easier.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c   |  202 +++++++++++++++++++++++++++----------------
>  drivers/ata/libata-eh.c     |  150 +++++++++++++++-----------------
>  drivers/ata/libata-pmp.c    |    5 +-
>  drivers/ata/libata-scsi.c   |    6 +-
>  drivers/ata/sata_inic162x.c |    2 +-
>  drivers/ata/sata_nv.c       |    4 +-
>  include/linux/libata.h      |   35 ++++----
>  7 files changed, 223 insertions(+), 181 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4753a18..6fac482 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -125,6 +125,79 @@ MODULE_LICENSE("GPL");
>  MODULE_VERSION(DRV_VERSION);
>  
>  

> @@ -2295,23 +2342,18 @@ int ata_dev_configure(struct ata_device *dev)
>  			dev->flags |= ATA_DFLAG_DIPM;
>  	}
>  
> -	if (dev->horkage & ATA_HORKAGE_DIAGNOSTIC) {
> +	if ((dev->horkage & ATA_HORKAGE_DIAGNOSTIC) && print_info) {
>  		/* Let the user know. We don't want to disallow opens for
>  		   rescue purposes, or in case the vendor is just a blithering
>  		   idiot */
> -		if (print_info) {
> -			ata_dev_printk(dev, KERN_WARNING,
> -"Drive reports diagnostics failure. This may indicate a drive\n");
> -			ata_dev_printk(dev, KERN_WARNING,
> -"fault or invalid emulation. Contact drive vendor for information.\n");
> -		}

Looks to me like several of these + lines have indent problems:
following lines (i.e., not first line) of function call should be
indented more than the first line:

> +		ata_dev_printk(dev, KERN_WARNING,
> +		"Drive reports diagnostics failure. This may indicate a drive\n"
> +		"fault or invalid emulation. Contact drive vendor for information.\n");
>  	}
>  
>  	/* limit bridge transfers to udma5, 200 sectors */
>  	if (ata_dev_knobble(dev)) {
> -		if (ata_msg_drv(ap) && print_info)
> -			ata_dev_printk(dev, KERN_INFO,
> -				       "applying bridge limits\n");
> +		mprintk_push(&mp, ", applying bridge limits");
>  		dev->udma_mask &= ATA_UDMA5;
>  		dev->max_sectors = ATA_MAX_SECTORS;
>  	}

> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index caef2bb..80bfa50 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -408,9 +408,8 @@ static int sata_pmp_configure(struct ata_device *dev, int print_info)
>  
>  		if (!(dev->flags & ATA_DFLAG_AN))
>  			ata_dev_printk(dev, KERN_INFO,
> -				"Asynchronous notification not supported, "
> -				"hotplug won't\n         work on fan-out "
> -				"ports. Use warm-plug instead.\n");

More indent needed below.

> +			"Asynchronous notification not supported, hotplug won't\n"
> +			"work on fan-out ports. Use warm-plug instead.\n");
>  	}
>  
>  	return 0;
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 264ae60..7c13663 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3207,9 +3207,9 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
>  			goto repeat;
>  		}
>  
> -		ata_port_printk(ap, KERN_ERR, "WARNING: synchronous SCSI scan "
> -				"failed without making any progress,\n"
> -				"                  switching to async\n");
> +		ata_port_printk(ap, KERN_ERR,

More indent needed below.

> +		"WARNING: synchronous SCSI scan failed without making any \n"
> +		"         progress, switching to async\n");
>  	}
>  
>  	queue_delayed_work(ata_aux_wq, &ap->hotplug_task,



---
~Randy
