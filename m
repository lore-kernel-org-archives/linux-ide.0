From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 13/14] libata-hp-prep: add prereset() method and implement
 ata_std_prereset()
Date: Fri, 19 May 2006 11:20:46 -0400
Message-ID: <446DE24E.4070501@pobox.com>
References: <11480445853715-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:7079 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932342AbWESPVB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 11:21:01 -0400
In-Reply-To: <11480445853715-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> With hotplug, every reset might be a probing reset and thus something
> similar to probe_init() is needed.  prereset() method is called before
> a series of resets to a port and is the counterpart of postreset().
> prereset() can tell EH to use different type of reset or skip reset by
> modifying ehc->i.action.
> 
> This patch also implements ata_std_prereset().  Most controllers
> should be able to use this function directly or with some wrapping.
> After hotplug, different controllers need different actions to resume
> the PHY and detect the newly attached device.  Controllers can be
> categorized as follows.
> 
> * Controllers which can wait for the first FIS34 after hotplug.  Note
>   that if the waiting is implemented by polling TF status, there needs
>   to be a way to set BSY on PHY status change.  It can be implemented
>   by hardware or with the help of the driver.
> 
> * Controllers which can wait for the first FIS34 after sending
>   COMRESET.  These controllers need to issue COMRESET to wait for the
>   first FIS.  Note that the received FIS34 could be the first FIS34
>   after POR (power-on-reset) or FIS34 in response to the COMRESET.
>   Some controllers use COMRESET as TF status synchronization point and
>   clear TF automatically (sata_sil).
> 
> * Controllers which cannot wait for the first FIS34 reliably.  Blindly
>   issuing SRST to spinning-up device often results in command issue
>   failure or timeout, causing extended delay.  For these controllers,
>   ata_std_prereset() explicitly waits ATA_SPINUP_WAIT (currently 8s)
>   to give newly attached device time to spin up, then issues reset.
>   Note that failing to getting ready in ATA_SPINUP_WAIT is not
>   critical.  libata will retry.  So, the timeout needs to be long
>   enough to spin up most devices.
> 
> LLDDs can tell ata_std_prereset() which of above action is needed with
> ATA_FLAG_HRST_TO_RESUME and ATA_FLAG_CANT_WAIT_FIS34 flags.  These
> flags are PHY-specific property and will be moved to ata_link later.
> 
> While at it, this patch unifies function typedef's such that they all
> have named arguments.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/ahci.c         |    3 +-
>  drivers/scsi/libata-bmdma.c |   11 ++++--
>  drivers/scsi/libata-core.c  |   81 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/libata-eh.c    |   62 ++++++++++++++++++++++++++++-----
>  drivers/scsi/sata_sil24.c   |    3 +-
>  include/linux/libata.h      |   24 ++++++++++---
>  6 files changed, 162 insertions(+), 22 deletions(-)
> 
> 3d2d7d0fb0501519e0940f77303bdde24955aa79
> diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
> index 45fd71d..8493b02 100644
> --- a/drivers/scsi/ahci.c
> +++ b/drivers/scsi/ahci.c
> @@ -1026,7 +1026,8 @@ static void ahci_error_handler(struct at
>  	}
>  
>  	/* perform recovery */
> -	ata_do_eh(ap, ahci_softreset, ahci_hardreset, ahci_postreset);
> +	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_hardreset,
> +		  ahci_postreset);
>  }
>  
>  static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
> diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
> index 6d30d2c..4bc0537 100644
> --- a/drivers/scsi/libata-bmdma.c
> +++ b/drivers/scsi/libata-bmdma.c
> @@ -695,6 +695,7 @@ void ata_bmdma_thaw(struct ata_port *ap)
>  /**
>   *	ata_bmdma_drive_eh - Perform EH with given methods for BMDMA controller
>   *	@ap: port to handle error for
> + *	@prereset: prereset method (can be NULL)
>   *	@softreset: softreset method (can be NULL)
>   *	@hardreset: hardreset method (can be NULL)
>   *	@postreset: postreset method (can be NULL)
> @@ -710,8 +711,9 @@ void ata_bmdma_thaw(struct ata_port *ap)
>   *	LOCKING:
>   *	Kernel thread context (may sleep)
>   */
> -void ata_bmdma_drive_eh(struct ata_port *ap, ata_reset_fn_t softreset,
> -			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
> +void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
> +			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
> +			ata_postreset_fn_t postreset)
>  {
>  	struct ata_host_set *host_set = ap->host_set;
>  	struct ata_eh_context *ehc = &ap->eh_context;
> @@ -759,7 +761,7 @@ void ata_bmdma_drive_eh(struct ata_port 
>  		ata_eh_thaw_port(ap);
>  
>  	/* PIO and DMA engines have been stopped, perform recovery */
> -	ata_do_eh(ap, softreset, hardreset, postreset);
> +	ata_do_eh(ap, prereset, softreset, hardreset, postreset);
>  }
>  
>  /**
> @@ -779,7 +781,8 @@ void ata_bmdma_error_handler(struct ata_
>  	if (sata_scr_valid(ap))
>  		hardreset = sata_std_hardreset;
>  
> -	ata_bmdma_drive_eh(ap, ata_std_softreset, hardreset, ata_std_postreset);
> +	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
> +			   ata_std_postreset);
>  }
>  
>  /**
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 72eef00..b2197b0 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -2529,6 +2529,86 @@ int sata_phy_resume(struct ata_port *ap,
>  	return sata_phy_debounce(ap, params);
>  }
>  
> +static void ata_wait_spinup(struct ata_port *ap)
> +{
> +	struct ata_eh_context *ehc = &ap->eh_context;
> +	unsigned long end, secs;
> +	int rc;
> +
> +	/* first, debounce */
> +	rc = sata_phy_debounce(ap, sata_deb_timing_eh);

unconditionally calls a sata_xxx function, and so "sata_wait_spinup" 
naming is preferred.


> +	/* if debounced successfully and offline, no need to wait */
> +	if (rc == 0 && ata_port_offline(ap))
> +		return;

ISTR ata_port_offline being SATA-specific too, but anyway...  :)


> +	/* okay, let's give the drive time to spin up */
> +	end = ehc->i.hotplug_timestamp + ATA_SPINUP_WAIT * HZ / 1000;
> +	secs = ((end - jiffies) + HZ - 1) / HZ;
> +
> +	if (time_after(jiffies, end))
> +		return;
> +
> +	if (secs > 5)
> +		ata_port_printk(ap, KERN_INFO, "waiting for device to spin up "
> +				"(%lu secs)\n", secs);
> +
> +	schedule_timeout_uninterruptible(end - jiffies);

BTW:  Medium-term, re-read Hale Landis's ATADRVR probe code 
(http://www.ata-atapi.com/) to make sure the PATA probe path is still 
intact.

ACK everything else in this patch.

	Jeff


