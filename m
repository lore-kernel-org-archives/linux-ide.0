From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_it8213: MWDMA0 is unsupported
Date: Thu, 26 Nov 2009 18:00:54 +0100
Message-ID: <200911261800.55025.bzolnier@gmail.com>
References: <200911261728.36433.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60854 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759955AbZKZRB6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 12:01:58 -0500
In-Reply-To: <200911261728.36433.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Thursday 26 November 2009 05:28:36 pm Bartlomiej Zolnierkiewicz wrote:
> 
> MWDMA0 timings cannot be met with the PIIX based controller
> programming interface.
> 
> This change should be safe as this is how we have been doing
> things in IDE it8213 host driver for years.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> Verified with the documentation (similar case as with pata_efar).

Uhhh, no...

Too many damn drivers.

Too much damn duplication.

Too much damn subtle differences here and there.

The hardware is probably fine for MWMDA0 when it comes to pata_{efar,it8213},
it just not documented properly in the data sheet.

I'll drop those two patches from my tree and take some break..

> On top of patches from yesterday.
> 
>  drivers/ata/pata_it8213.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/drivers/ata/pata_it8213.c
> ===================================================================
> --- a/drivers/ata/pata_it8213.c
> +++ b/drivers/ata/pata_it8213.c
> @@ -227,7 +227,7 @@ static int it8213_init_one (struct pci_d
>  	static const struct ata_port_info info = {
>  		.flags		= ATA_FLAG_SLAVE_POSS,
>  		.pio_mask	= ATA_PIO4,
> -		.mwdma_mask	= ATA_MWDMA2,
> +		.mwdma_mask	= ATA_MWDMA12_ONLY,
>  		.udma_mask 	= ATA_UDMA6,
>  		.port_ops	= &it8213_ops,
>  	};
