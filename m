From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] resolve collision of generic ATA_FLAG_LOWTAG and driver
 specific flag
Date: Fri, 10 Apr 2015 04:15:16 -0700
Message-ID: <20150410111516.GA15230@infradead.org>
References: <201504092009.08703.ronny.hegewald@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41973 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbbDJLPR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Apr 2015 07:15:17 -0400
Content-Disposition: inline
In-Reply-To: <201504092009.08703.ronny.hegewald@online.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ronny Hegewald <ronny.hegewald@online.de>
Cc: linux-ide@vger.kernel.org

On Thu, Apr 09, 2015 at 08:09:08PM +0000, Ronny Hegewald wrote:
> The patch "libata: allow sata_sil24 to opt-out of tag ordered submission" 
> (72dd299d5039a336493993dcc63413cf31d0e662) introduces a regression with the 
> sata_sil24 driver.
> 
> The new flag ATA_FLAG_LOWTAG accidentially uses the same bit as 
> SIL24_FLAG_PCIX_IRQ_WOC in the driver. This activates code for Silicon Image 
> 3132, which is only suppossed to run under 3124.
> 
> ATA_FLAG_LOWTAG is only used in sata_sil24 and is planned to be removed soon, 
> so lets just use another bit for the flag in sata_sil24. 
> 
> Signed-off-by: Ronny Hegewald <Ronny.Hegewald@online.de>
> Cc: stable@vger.kernel.org
> 
> --- linux-3.18.5/drivers/ata/sata_sil24.c.org
> +++ linux-3.18.5/drivers/ata/sata_sil24.c
> @@ -247,7 +247,7 @@
>  	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
>  				  ATA_FLAG_NCQ | ATA_FLAG_ACPI_SATA |
>  				  ATA_FLAG_AN | ATA_FLAG_PMP | ATA_FLAG_LOWTAG,
> -	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
> +	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 25), /* IRQ loss errata on PCI-X */

And this will clash as soon as the next flag is added.  Please don't
abuse the common flag space for driver specific ones, and add a separate
flags field for driver specific flags.
