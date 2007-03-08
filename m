From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Fix simplex adapters with libata
Date: Thu, 8 Mar 2007 13:02:50 +0000
Message-ID: <20070308130250.5647ce5c@lxorguk.ukuu.org.uk>
References: <20070308091211.GA7257@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34194 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751497AbXCHL6f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 06:58:35 -0500
In-Reply-To: <20070308091211.GA7257@vana.vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <petr@vandrovec.name>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

> And as xfermask stripped out DMA bits, host->simplex_claimed
> is always NULL with current implementation.
> 
> By allowing DMA either if simplex_claimed is NULL or if it
> points to current port DMA can be finally used - it gets
> assigned to first port which contains any DMA capable
> device.

Doh, sorry I should have caught that when testing.

> Signed-off-by: Petr Vandrovec <petr@vandrovec.name>

Acked-by: Alan Cox <alan@redhat.com>

> 
> diff -uprdN linux/drivers/ata/libata-core.c linux/drivers/ata/libata-core.c
> --- linux/drivers/ata/libata-core.c	2007-03-07 22:13:24.000000000 -0800
> +++ linux/drivers/ata/libata-core.c	2007-03-08 00:15:37.000000000 -0800
> @@ -3455,7 +3455,8 @@ static void ata_dev_xfermask(struct ata_
>  			       "device is on DMA blacklist, disabling DMA\n");
>  	}
>  
> -	if ((host->flags & ATA_HOST_SIMPLEX) && host->simplex_claimed != ap) {
> +	if ((host->flags & ATA_HOST_SIMPLEX) &&
> +            host->simplex_claimed && host->simplex_claimed != ap) {
>  		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
>  		ata_dev_printk(dev, KERN_WARNING, "simplex DMA is claimed by "
>  			       "other device, disabling DMA\n");
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
--
Sick of rip off UK rail fares ? Learn how to get far cheaper fares
		http://zeniv.linux.org.uk/~alan/GTR/
