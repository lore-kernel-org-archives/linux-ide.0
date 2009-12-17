From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] pata_cs5520: use ATA_DMA_* constants
Date: Thu, 17 Dec 2009 01:20:46 -0500
Message-ID: <4B29CDBE.8040008@pobox.com>
References: <200912042339.00746.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:37764 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760352AbZLQGUt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:20:49 -0500
Received: by ywh12 with SMTP id 12so1994783ywh.21
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 22:20:48 -0800 (PST)
In-Reply-To: <200912042339.00746.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 12/04/2009 03:39 PM, Sergei Shtylyov wrote:
> Use ATA_DMA_* constants instead of the bare numbers for the BMIDE registers.
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree.
>
>   drivers/ata/pata_cs5520.c |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
>
> Index: linux-2.6/drivers/ata/pata_cs5520.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/pata_cs5520.c
> +++ linux-2.6/drivers/ata/pata_cs5520.c
> @@ -99,9 +99,9 @@ static void cs5520_set_timings(struct at
>   static void cs5520_enable_dma(struct ata_port *ap, struct ata_device *adev)
>   {
>   	/* Set the DMA enable/disable flag */
> -	u8 reg = ioread8(ap->ioaddr.bmdma_addr + 0x02);
> -	reg |= 1<<(adev->devno + 5);
> -	iowrite8(reg, ap->ioaddr.bmdma_addr + 0x02);
> +	u8 reg = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
> +	reg |= 1<<  (adev->devno + 5);
> +	iowrite8(reg, ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
>   }

skipped -- Bart's patch (940a68de56c1952c29d9f3c1a769a82b1bdd2b67) 
superceded this


