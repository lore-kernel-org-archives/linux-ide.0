From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/3] libata: add per-dev pio/mwdma/udma_mask
Date: Fri, 24 Mar 2006 09:30:02 -0500
Message-ID: <4424026A.1080504@pobox.com>
References: <11431768704184-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:6633 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932630AbWCXOaH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 09:30:07 -0500
In-Reply-To: <11431768704184-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> -static unsigned int ata_dev_xfermask(struct ata_port *ap,
> -				     struct ata_device *dev)
> +static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev)
>  {
>  	unsigned long xfer_mask;
>  	int i;
> @@ -2677,6 +2676,8 @@ static unsigned int ata_dev_xfermask(str
>  		struct ata_device *d = &ap->device[i];
>  		if (!ata_dev_present(d))
>  			continue;
> +		xfer_mask &= ata_pack_xfermask(d->pio_mask, d->mwdma_mask,
> +					       d->udma_mask);
>  		xfer_mask &= ata_id_xfermask(d->id);
>  		if (ata_dma_blacklisted(d))
>  			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
> @@ -2686,7 +2687,8 @@ static unsigned int ata_dev_xfermask(str
>  		printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, "
>  		       "disabling DMA\n", ap->id, dev->devno);
>  
> -	return xfer_mask;
> +	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
> +			    &dev->udma_mask);

applied 1-3.  You should add a TODO note somewhere, that notes that the 
current implementation intentionally limits all devices on a single port 
to the fastest mode on the slowest device.  This is necessary for SOME 
controllers but not all, and so we shouldn't do it unconditionally.

	Jeff



