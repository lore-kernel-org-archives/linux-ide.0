From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 03/13] libata-hp: implement SCSI part of hotplug
Date: Fri, 19 May 2006 12:05:33 -0400
Message-ID: <446DECCD.1020100@pobox.com>
References: <1148053707416-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:7082 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932422AbWESQFq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 12:05:46 -0400
In-Reply-To: <1148053707416-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement SCSI part of hotplug.
> 
> This must be done in a separate context as SCSI makes use of EH during
> probing.  Unfortunately, SCSI probing fails silently if EH is active.
> ata_eh_scsi_hotplug() does its best to avoid such conditions but,
> theoretically, it may fail to associate SCSI device to newly found ATA
> device; however, the chance is very slim and I haven't experienced any
> such event during testing.
> 
> Device removal synchronization is somewhat complex but I think I've
> got it right and haven't seen it malfunction.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |    1 +
>  drivers/scsi/libata-eh.c   |   70 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/scsi/libata-scsi.c |   59 +++++++++++++++++++++++++++++++++++++
>  drivers/scsi/libata.h      |    2 +
>  include/linux/libata.h     |    2 +
>  5 files changed, 132 insertions(+), 2 deletions(-)
> 
> 6a1cd6180ac9e13e29446378bd15245c4c7efd5d
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 1809f98..7600b5f 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -5347,6 +5347,7 @@ static void ata_host_init(struct ata_por
>  	ap->last_ctl = 0xFF;
>  
>  	INIT_WORK(&ap->port_task, NULL, NULL);
> +	INIT_WORK(&ap->hotplug_task, ata_eh_scsi_hotplug, ap);
>  	INIT_LIST_HEAD(&ap->eh_done_q);
>  
>  	/* set cable type */
> diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
> index fff93d9..0ab7d52 100644
> --- a/drivers/scsi/libata-eh.c
> +++ b/drivers/scsi/libata-eh.c
> @@ -286,9 +286,13 @@ void ata_scsi_error(struct Scsi_Host *ho
>  	/* clean up */
>  	spin_lock_irqsave(hs_lock, flags);
>  
> +	if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
> +		queue_work(ata_hotplug_wq, &ap->hotplug_task);
> +
>  	if (ap->flags & ATA_FLAG_RECOVERED)
>  		ata_port_printk(ap, KERN_INFO, "EH complete\n");
> -	ap->flags &= ~ATA_FLAG_RECOVERED;
> +
> +	ap->flags &= ~(ATA_FLAG_SCSI_HOTPLUG | ATA_FLAG_RECOVERED);
>  
>  	spin_unlock_irqrestore(hs_lock, flags);
>  
> @@ -1736,6 +1740,70 @@ static void ata_eh_finish(struct ata_por
>  }
>  
>  /**
> + *	ata_eh_scsi_hotplug - SCSI part of hotplug
> + *	@data: Pointer to ATA port to perform SCSI hotplug on
> + *
> + *	Perform SCSI part of hotplug.  It's executed from a separate
> + *	workqueue after EH completes.  This is necessary because SCSI
> + *	hot plugging requires working EH and hot unplugging is
> + *	synchronized with hot plugging with a mutex.
> + *
> + *	LOCKING:
> + *	Kernel thread context (may sleep).
> + */
> +void ata_eh_scsi_hotplug(void *data)

Would prefer ata_eh_scsi_hotplug() to be in libata-scsi.  Otherwise ACK.

	Jeff



