From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/11] libata-eh: implement BMDMA EH
Date: Sat, 13 May 2006 18:21:34 -0400
Message-ID: <44665BEE.5020903@pobox.com>
References: <1147353687173-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52871 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932367AbWEMWVn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 18:21:43 -0400
In-Reply-To: <1147353687173-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement stock BMDMA error handling methods.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-bmdma.c |  144 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/libata-core.c  |    5 +
>  include/linux/libata.h      |    8 ++
>  3 files changed, 157 insertions(+), 0 deletions(-)
> 
> 33c8c944f97629b555fc6a14ca49803c47f9d50b
> diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
> index 835dff0..751ec18 100644
> --- a/drivers/scsi/libata-bmdma.c
> +++ b/drivers/scsi/libata-bmdma.c
> @@ -652,6 +652,150 @@ void ata_bmdma_stop(struct ata_queued_cm
>  	ata_altstatus(ap);        /* dummy read */
>  }
>  
> +/**
> + *	ata_bmdma_freeze - Freeze BMDMA controller port
> + *	@ap: port to freeze
> + *
> + *	Freeze BMDMA controller port.
> + *
> + *	LOCKING:
> + *	Inherited from caller.
> + */
> +void ata_bmdma_freeze(struct ata_port *ap)
> +{
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +
> +	ap->ctl |= ATA_NIEN;
> +	ap->last_ctl = ap->ctl;
> +
> +	if (ap->flags & ATA_FLAG_MMIO)
> +		writeb(ap->ctl, (void __iomem *)ioaddr->ctl_addr);
> +	else
> +		outb(ap->ctl, ioaddr->ctl_addr);
> +}
> +
> +/**
> + *	ata_bmdma_thaw - Thaw BMDMA controller port
> + *	@ap: port to thaw
> + *
> + *	Thaw BMDMA controller port.
> + *
> + *	LOCKING:
> + *	Inherited from caller.
> + */
> +void ata_bmdma_thaw(struct ata_port *ap)
> +{
> +	/* clear & re-enable interrupts */
> +	ata_chk_status(ap);
> +	ap->ops->irq_clear(ap);
> +	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
> +		ata_irq_on(ap);
> +}

What's the plan for the class of PATA controllers without Device Control 
shadow registers?

There are multiple examples of such in drivers/ide...

I ACK the patch's content, but don't forget we definitely need a plan 
for PATA controllers without nIEN support.

	Jeff




