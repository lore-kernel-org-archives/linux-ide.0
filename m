From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Better timeout recovery
Date: Tue, 14 Oct 2008 14:32:05 +0900
Message-ID: <48F42ED5.1030009@kernel.org>
References: <20081013141050.7772.52587.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43547 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbYJNFem (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 01:34:42 -0400
In-Reply-To: <20081013141050.7772.52587.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hello, Alan.

Alan Cox wrote:
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index a93247c..757b956 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -518,7 +518,7 @@ void ata_scsi_error(struct Scsi_Host *host)
>  
>  	/* For new EH, all qcs are finished in one of three ways -
>  	 * normal completion, error completion, and SCSI timeout.
> -	 * Both cmpletions can race against SCSI timeout.  When normal
> +	 * Both completions can race against SCSI timeout.  When normal
>  	 * completion wins, the qc never reaches EH.  When error
>  	 * completion wins, the qc has ATA_QCFLAG_FAILED set.
>  	 *

Heh.. nice catch.

> @@ -533,7 +533,19 @@ void ata_scsi_error(struct Scsi_Host *host)
>  		int nr_timedout = 0;
>  
>  		spin_lock_irqsave(ap->lock, flags);
> -
> +		
> +		/* This must occur under the ap->lock as we don't want
> +		   a polled recovery to race the real interrupt handler
> +		   
> +		   The lost_interrupt handler checks for any completed but
> +		   non-notified command and completes much like an IRQ handler.
> +		   
> +		   We then fall into the error recovery code which will treat
> +		   this as if normal completion won the race */

As Elias pointed out, I think it's better to stick with

 /* The first line.
  * The last line.
  */

as that's what the rest of the libata uses.

> +
> +		if (ap->ops->lost_interrupt)
> +			ap->ops->lost_interrupt(ap);
> +			
>  		list_for_each_entry_safe(scmd, tmp, &host->eh_cmd_q, eh_entry) {
>  			struct ata_queued_cmd *qc;

Eh... I really wish this can be folded into ata_sff_error_handler()
but, yeah, it's not easy to do as ata_scsi_error() marks commands as
timed out before error handler is entered.  Hmmm... I think it would
be better to do this before entering error handler at all and way
before the actual command out triggers but well I guess that's for
another day.

Do you mind to separate out this one from the drain changes?

> @@ -577,6 +589,9 @@ void ata_scsi_error(struct Scsi_Host *host)
>  		ap->eh_tries = ATA_EH_MAX_TRIES;
>  	} else
>  		spin_unlock_wait(ap->lock);
> +		
> +	/* If we timed raced normal completion and there is nothing to
> +	   recover nr_timedout == 0 why exactly are we doing error recovery ? */

As it's easier that way and there's no need to optimize anything as
we're already knee deep in EH.

> +	/* There was a command running, we are no longer busy and we have
> +	   no interrupt. */
> +	ata_port_printk(ap, KERN_WARNING, "lost interrupt (Status 0x%x)\n",
> +								status);

I sometimes find your indenting style a bit strange but it's equally
possible that I'm the weirdo.  :-)

> +	/* Run the host interrupt logic as if the interrupt had not been
> +	   lost */
> +	ata_sff_host_intr(ap, qc);

Ah.. we don't have ->irq_handler as port op now but it looks rather
strange to call ata_sff_host_intr() directly.  Maybe we need a
function which takes @irq_handler to call and make
ata_sff_lost_interrupt() call it with ata_sff_host_intr()?

> +/**
>   *	ata_sff_error_handler - Stock error handler for BMDMA controller
>   *	@ap: port to handle error for
>   *
> @@ -2124,6 +2201,12 @@ void ata_sff_error_handler(struct ata_port *ap)
>  	ata_sff_sync(ap);		/* FIXME: We don't need this */
>  	ap->ops->sff_check_status(ap);
>  	ap->ops->sff_irq_clear(ap);
> +	/* We *MUST* do FIFO draining before we issue a reset as several
> +	   devices helpfully clear their internal state and will lock solid
> +	   if we touch the data port post reset. Pass qc in case anyone wants
> +	   to do different PIO/DMA recovery or has per command fixups */
> +	if (ap->ops->drain_fifo)
> +		ap->ops->drain_fifo(qc);

If the mechanism is something which can be universally applied to SFF
controllers (SATA ones w/ hardreset usually don't need this BTW),
maybe we're better off with providing another flavor of
ata_sff_error_handler() instead of adding ->drain_fifo method?

>  	spin_unlock_irqrestore(ap->lock, flags);
>  
> @@ -2131,6 +2214,7 @@ void ata_sff_error_handler(struct ata_port *ap)
>  		ata_eh_thaw_port(ap);
>  
>  	/* PIO and DMA engines have been stopped, perform recovery */
> +	

Is this intentional?

Thanks.

-- 
tejun
