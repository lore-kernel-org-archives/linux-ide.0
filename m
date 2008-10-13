From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH] libata: Better timeout recovery
Date: Mon, 13 Oct 2008 18:04:25 +0200
Message-ID: <87y70sbhx2.fsf@denkblock.local>
References: <20081013141050.7772.52587.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:45908 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756251AbYJMQEg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 12:04:36 -0400
In-Reply-To: <20081013141050.7772.52587.stgit@localhost.localdomain> (Alan
	Cox's message of "Mon, 13 Oct 2008 15:11:49 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> From: Alan Cox <alan@redhat.com>
>
> Check for completed commands on a timeout, also implement data draining as
> Mark Lord suggested. The former should help a lot on various promise
> controllers which show random IRQ loss now and then, the latter at least for
> me fixes the hanging DRQ cases I can test.
>
> To get the lost IRQ recovery working better we really need to short circuit a
> lot fo the recovery paths we trigger needlessly when EH finds that actually
> all was well.
>
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
[...]
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 2a4c516..ea7f0e1 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
[...]
> @@ -1660,6 +1663,47 @@ irqreturn_t ata_sff_interrupt(int irq, void *dev_instance)
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
> +	if (!(status & ATA_BUSY))
> +		return;

Shouldn't this rather be

	if (status & ATA_BUSY)
		return;
?

> +		
> +	/* There was a command running, we are no longer busy and we have
> +	   no interrupt. */
> +	ata_port_printk(ap, KERN_WARNING, "lost interrupt (Status 0x%x)\n",
> +								status);

>From your changelog entry I got the impression that this is known to
happen on various controllers and there is nothing the user or you
(kernel developers) can do about it. So, will this become a debug level
message later too?

> +	/* Run the host interrupt logic as if the interrupt had not been
> +	   lost */
> +	ata_sff_host_intr(ap, qc);
> +}
> +
> +/**
>   *	ata_sff_freeze - Freeze SFF controller port
>   *	@ap: port to freeze
>   *
> @@ -2073,6 +2117,39 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
>  }
>  
>  /**
> + *	ata_sff_drain_fifo - Stock FIFO drain logic for SFF controllers
> + *	@ap: port to drain

There is no @ap argument.

> + *	@qc: command
> + *
> + *	Drain the FIFO and device of any stuck data following a command
> + *	failing to complete. In some cases this is neccessary before a
> + *	reset will recover the device.
> + *
> + */
> + 
> +void ata_sff_drain_fifo(struct ata_queued_cmd *qc)
> +{
> +	int count;
> +	struct ata_port *ap;
> +
> +	/* We only need to flush incoming data when a command was running */
> +	if (qc == NULL || qc->dma_dir == DMA_TO_DEVICE)
> +		return;
> +
> +	ap = qc->ap;
> +	/* Drain up to 64K of data before we give up this recovery method */
> +	for (count = 0; (ap->ops->sff_check_status(ap) & ATA_DRQ)
> +						&& count < 32768; count++)
> +		ioread16(ap->ioaddr.data_addr);
> +
> +	/* Can become DEBUG later */
> +	if (count)
> +		ata_port_printk(ap, KERN_WARNING,
> +			"drained %d bytes to clear DRQ.\n", count);

							    count * 2

[...]
> diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
> index d3f2c0d..d240d08 100644
> --- a/drivers/ata/pata_pcmcia.c
> +++ b/drivers/ata/pata_pcmcia.c
[...]
> @@ -126,6 +126,38 @@ static unsigned int ata_data_xfer_8bit(struct ata_device *dev,
>  	return buflen;
>  }
>  
> +/**
> + *	pcmcia_8bit_drain_fifo - Stock FIFO drain logic for SFF controllers
> + *	@ap: port to drain

No argument @ap.

> + *	@qc: command
> + *
> + *	Drain the FIFO and device of any stuck data following a command
> + *	failing to complete. In some cases this is neccessary before a
> + *	reset will recover the device.
> + *
> + */
> + 
> +void pcmcia_8bit_drain_fifo(struct ata_queued_cmd *qc)
