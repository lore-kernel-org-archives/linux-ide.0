From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 2/4] libata: Drain data on errors
Date: Wed, 22 Oct 2008 17:46:56 +0200
Message-ID: <87od1cskcv.fsf@denkblock.local>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>
	<20081017180837.7781.26372.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:36598 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbYJVPrz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 11:47:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> From: Alan Cox <alan@redhat.com>
>
> If the device is signalling that there is data to drain after an error we
> should read the bytes out and throw them away. Without this some devices
> and controllers get wedged and don't recover.
>
> Based on earlier work by Mark Lord
>
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
> diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
> index 02b596b..f08d34d 100644
> --- a/drivers/ata/pata_pcmcia.c
> +++ b/drivers/ata/pata_pcmcia.c
[...]
> @@ -126,6 +126,37 @@ static unsigned int ata_data_xfer_8bit(struct ata_device *dev,
>  	return buflen;
>  }
>  
> +/**
> + *	pcmcia_8bit_drain_fifo - Stock FIFO drain logic for SFF controllers
> + *	@qc: command
> + *
> + *	Drain the FIFO and device of any stuck data following a command
> + *	failing to complete. In some cases this is neccessary before a
> + *	reset will recover the device.
> + *
> + */
> + 
> +void pcmcia_8bit_drain_fifo(struct ata_queued_cmd *qc)
> +{
> +	int count;
> +	struct ata_port *ap;
> +
> +	/* We only need to flush incoming data when a command was running */
> +	if (qc == NULL || qc->dma_dir == DMA_TO_DEVICE)
> +		return;
> +
> +	ap = qc->ap;
> +
> +	/* Drain up to 64K of data before we give up this recovery method */
> +	for (count = 0; (ap->ops->sff_check_status(ap) & ATA_DRQ)
> +							&& count < 65536;)

Missing count++. Sorry for not spotting that in the previous round.

Regards,

Elias
