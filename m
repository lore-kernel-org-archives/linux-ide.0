From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 8/8] ata: add ATA_MWDMA* and ATA_SWDMA* defines
Date: Fri, 31 Aug 2007 04:01:15 -0400
Message-ID: <46D7CACB.6070400@garzik.org>
References: <200708271935.22751.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47711 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734AbXHaIBR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 04:01:17 -0400
In-Reply-To: <200708271935.22751.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  include/linux/ata.h |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> Index: b/include/linux/ata.h
> ===================================================================
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -73,6 +73,19 @@ enum {
>  	ATA_PIO5		= ATA_PIO4 | (1 << 5),
>  	ATA_PIO6		= ATA_PIO5 | (1 << 6),
>  
> +	ATA_SWDMA0		= (1 << 0),
> +	ATA_SWDMA1		= ATA_SWDMA0 | (1 << 1),
> +	ATA_SWDMA2		= ATA_SWDMA1 | (1 << 2),
> +
> +	ATA_SWDMA2_ONLY		= (1 << 2),
> +
> +	ATA_MWDMA0		= (1 << 0),
> +	ATA_MWDMA1		= ATA_MWDMA0 | (1 << 1),
> +	ATA_MWDMA2		= ATA_MWDMA1 | (1 << 2),
> +
> +	ATA_MWDMA12_ONLY	= (1 << 1) | (1 << 2),
> +	ATA_MWDMA2_ONLY		= (1 << 2),
> +
>  	ATA_UDMA0		= (1 << 0),
>  	ATA_UDMA1		= ATA_UDMA0 | (1 << 1),
>  	ATA_UDMA2		= ATA_UDMA1 | (1 << 2),

applied


