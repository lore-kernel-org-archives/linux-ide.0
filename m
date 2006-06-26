From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 11/15] libata: reimplement controller-wide PM
Date: Mon, 26 Jun 2006 14:36:47 +0800
Message-ID: <1151303807.7132.162.camel@forrest26.sh.intel.com>
References: <11511486203395-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62487 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750960AbWFZGtg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 02:49:36 -0400
In-Reply-To: <11511486203395-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Sat, 2006-06-24 at 20:30 +0900, Tejun Heo wrote:
>  
>  /**
> + *	ata_host_set_suspend - suspend host_set
> + *	@host_set: host_set to suspend
> + *	@mesg: PM message
> + *
> + *	Suspend @host_set.  Actual operation is performed by EH.  This
> + *	function requests EH to perform PM operations and waits for EH
> + *	to finish.
> + *
> + *	LOCKING:
> + *	Kernel thread context (may sleep).
> + *
> + *	RETURNS:
> + *	0 on success, -errno on failure.
> + */
> +int ata_host_set_suspend(struct ata_host_set *host_set, pm_message_t mesg)
> +{
> +	unsigned long flags;
> +	int i, j;
> +
> +	for (i = 0; i < host_set->n_ports; i++) {
> +		struct ata_port *ap = host_set->ports[i];
> +
> +		/* set SUSPENDED and make sure EH sees it */
> +		spin_lock_irqsave(&ap->host_set->lock, flags);
> +		ap->flags |= ATA_FLAG_SUSPENDED;
> +		spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +
> +		ata_port_wait_eh(ap);
> +
> +		/* EH is quiescent now.  Fail if we have any ready
> +		 * device.  This happens if hotplug occurs between
> +		 * completion of device suspension and here.
> +		 */
> +		for (j = 0; j < ATA_MAX_DEVICES; j++) {
> +			struct ata_device *dev = &ap->device[j];
> +
> +			if (ata_dev_ready(dev)) {
> +				ata_port_printk(ap, KERN_INFO,
> +						"suspend failed, device %d "
> +						"still active\n", dev->devno);
> +				goto fail;
> +			}
> +		}
> +
> +		/* freeze, won't be thawed until resume */
> +		spin_lock_irqsave(&ap->host_set->lock, flags);
> +		ata_port_freeze(ap);
> +		spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +	}
> +
> +	host_set->dev->power.power_state = mesg;
> +	return 0;
> +
> + fail:
> +	ata_host_set_resume(host_set);
> +	return -EBUSY;
> +}
> +

ata_port_schedule_eh(ap); need to be invoked in order to schedule EH,
right? But ata_port_schedule_eh(ap) is not called in
ata_host_set_suspend().

Thanks,
Forrest
