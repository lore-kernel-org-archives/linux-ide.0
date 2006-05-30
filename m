From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/13] libata-hp: implement bootplug
Date: Tue, 30 May 2006 00:23:08 -0400
Message-ID: <447BC8AC.4060501@pobox.com>
References: <11488847361536-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:26340 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751265AbWE3EXR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:23:17 -0400
In-Reply-To: <11488847361536-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> +static int ata_boot_probe_wait(void *dummy)
> +{
> +	schedule();

schedule_timeout(1) is preferred

> +			spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +
> +			wait_on_bit(&ap->flags, bit, ata_boot_probe_wait,
> +				    TASK_UNINTERRUPTIBLE);
> +
> +			while (scsi_host_in_recovery(ap->host))
> +				msleep(10);

Is this seemingly infinite loop _guaranteed_ to stop eventually?


> +		} else {
> +			DPRINTK("ata%u: bus probe begin\n", ap->id);
> +			rc = ata_bus_probe(ap);
> +			DPRINTK("ata%u: bus probe end\n", ap->id);
> +
> +			if (rc) {
> +				/* FIXME: do something useful here?
> +				 * Current libata behavior will
> +				 * tear down everything when
> +				 * the module is removed
> +				 * or the h/w is unplugged.
> +				 */
> +			}
> +		}
>  	}
>  
>  	/* probes are done, now scan each port's disk(s) */
> diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
> index b37575b..7b5cb02 100644
> --- a/drivers/scsi/libata-eh.c
> +++ b/drivers/scsi/libata-eh.c
> @@ -286,11 +286,16 @@ void ata_scsi_error(struct Scsi_Host *ho
>  	/* clean up */
>  	spin_lock_irqsave(hs_lock, flags);
>  
> -	if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
> -		queue_work(ata_scsi_wq, &ap->hotplug_task);
> -
> -	if (ap->flags & ATA_FLAG_RECOVERED)
> -		ata_port_printk(ap, KERN_INFO, "EH complete\n");
> +	if (ap->flags & ATA_FLAG_LOADING) {
> +		int bit = fls(ATA_FLAG_LOADING) - 1;
> +		clear_bit(bit, &ap->flags);
> +		wake_up_bit(&ap->flags, bit);
> +	} else {
> +		if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
> +			queue_work(ata_scsi_wq, &ap->hotplug_task);
> +		if (ap->flags & ATA_FLAG_RECOVERED)
> +			ata_port_printk(ap, KERN_INFO, "EH complete\n");
> +	}
>  
>  	ap->flags &= ~(ATA_FLAG_SCSI_HOTPLUG | ATA_FLAG_RECOVERED);
>  
> @@ -1329,6 +1334,7 @@ static int ata_eh_reset(struct ata_port 
>  	struct ata_eh_context *ehc = &ap->eh_context;
>  	unsigned int *classes = ehc->classes;
>  	int tries = ATA_EH_RESET_TRIES;
> +	int verbose = !(ap->flags & ATA_FLAG_LOADING);
>  	unsigned int action;
>  	ata_reset_fn_t reset;
>  	int i, did_followup_srst, rc;
> @@ -1376,8 +1382,10 @@ static int ata_eh_reset(struct ata_port 
>  	}
>  
>   retry:
> -	ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
> -			reset == softreset ? "soft" : "hard");
> +	/* shut up during boot probing */
> +	if (verbose)
> +		ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
> +				reset == softreset ? "soft" : "hard");
>  
>  	/* reset */
>  	ata_eh_about_to_do(ap, ATA_EH_RESET_MASK);
> @@ -1761,8 +1769,11 @@ void ata_do_eh(struct ata_port *ap, ata_
>  	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
>  	       ata_postreset_fn_t postreset)
>  {
> -	ata_eh_autopsy(ap);
> -	ata_eh_report(ap);
> +	if (!(ap->flags & ATA_FLAG_LOADING)) {
> +		ata_eh_autopsy(ap);
> +		ata_eh_report(ap);
> +	}
> +
>  	ata_eh_recover(ap, prereset, softreset, hardreset, postreset);
>  	ata_eh_finish(ap);
>  }

