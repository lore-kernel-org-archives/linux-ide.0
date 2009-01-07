From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 5/7] libata: Improve timeout handling
Date: Tue, 06 Jan 2009 18:29:44 -0600
Message-ID: <4963F778.5090209@shaw.ca>
References: <20090105141102.28189.44312.stgit@localhost.localdomain> <20090105141532.28189.58209.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:50448 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbZAGA36 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jan 2009 19:29:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LKMJ3-0000Fd-4m
	for linux-ide@vger.kernel.org; Wed, 07 Jan 2009 00:29:57 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 07 Jan 2009 00:29:57 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 07 Jan 2009 00:29:57 +0000
In-Reply-To: <20090105141532.28189.58209.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
> 
> On a timeout call a device specific handler early in the recovery so that
> we can complete and process successful commands which timed out due to IRQ
> loss or the like rather more elegantly.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

(snip)

> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index e74b3db..e9c09cd 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -65,6 +65,8 @@ const struct ata_port_operations ata_sff_port_ops = {
>  	.sff_irq_on		= ata_sff_irq_on,
>  	.sff_irq_clear		= ata_sff_irq_clear,
>  
> +	.lost_interrupt		= ata_sff_lost_interrupt,
> +
>  	.port_start		= ata_sff_port_start,
>  };
>  
> @@ -1543,7 +1545,7 @@ bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc)
>   *	RETURNS:
>   *	One if interrupt was handled, zero if not (shared irq).
>   */
> -inline unsigned int ata_sff_host_intr(struct ata_port *ap,
> +unsigned int ata_sff_host_intr(struct ata_port *ap,
>  				      struct ata_queued_cmd *qc)
>  {
>  	struct ata_eh_info *ehi = &ap->link.eh_info;
> @@ -1670,6 +1672,47 @@ irqreturn_t ata_sff_interrupt(int irq, void *dev_instance)
>  }
>  
>  /**
> + *	ata_sff_lost_interrupt	-	Check for an apparent lost interrupt
> + *	@ap: port that appears to have timed out
> + *
> + *	Called from the libata error handlers when the core code suspects
> + *	an interrupt has been lost. If it has complete anything we can and
> + *	then return. Interface must support altstatus for this faster
> + *	recovery to occur.
> + *
> + *	Locking:
> + *	Caller holds host lock
> + */
> +
> +void ata_sff_lost_interrupt(struct ata_port *ap)
> +{
> +	u8 status;
> +	struct ata_queued_cmd *qc;
> +
> +	/* Only one outstanding command per SFF channel */
> +	qc = ata_qc_from_tag(ap, ap->link.active_tag);
> +	/* Check we have a live one.. */
> +	if (qc == NULL ||  !(qc->flags & ATA_QCFLAG_ACTIVE))
> +		return;
> +	/* We cannot lose an interrupt on a polled command */
> +	if (qc->tf.flags & ATA_TFLAG_POLLING)
> +		return;
> +	/* See if the controller thinks it is still busy - if so the command
> +	   isn't a lost IRQ but is still in progress */
> +	status = ata_sff_altstatus(ap);
> +	if (status & ATA_BUSY)
> +		return;
> +
> +	/* There was a command running, we are no longer busy and we have
> +	   no interrupt. */
> +	ata_port_printk(ap, KERN_WARNING, "lost interrupt (Status 0x%x)\n",
> +								status);
> +	/* Run the host interrupt logic as if the interrupt had not been
> +	   lost */
> +	ata_sff_host_intr(ap, qc);
> +}
> +
> +/**

I suspect this may have to be more of an opt-in thing or else all 
drivers inheriting the SFF port ops will have to be checked to make sure 
it will work. Looking at sata_nv ADMA, it inherits from the SFF 
operations but the above code won't work as expected if the timeout 
happened while the controller was in ADMA mode (we're not allowed to 
access the taskfile registers for one thing). There may be others that 
have similar problems.

