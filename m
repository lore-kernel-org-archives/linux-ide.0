From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/13] serverworks: cleanup ->set_dma_mode method
Date: Tue, 13 Nov 2007 14:32:53 +0300
Message-ID: <47398B65.7090409@ru.mvista.com>
References: <200711130001.16287.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:31875 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751527AbXKMLcm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 06:32:42 -0500
In-Reply-To: <200711130001.16287.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> IDE core guarantees that ->set_dma_mode will be called only
> for DMA modes set in SWDMA/MWDMA/UDMA masks.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/pci/serverworks.c
> ===================================================================
> --- a/drivers/ide/pci/serverworks.c
> +++ b/drivers/ide/pci/serverworks.c
> @@ -164,25 +164,12 @@ static void svwks_set_dma_mode(ide_drive
>  	ultra_timing	&= ~(0x0F << (4*unit));
>  	ultra_enable	&= ~(0x01 << drive->dn);
>  
> -	switch(speed) {
> -		case XFER_MW_DMA_2:
> -		case XFER_MW_DMA_1:
> -		case XFER_MW_DMA_0:
> -			dma_timing |= dma_modes[speed - XFER_MW_DMA_0];
> -			break;
> -
> -		case XFER_UDMA_5:
> -		case XFER_UDMA_4:
> -		case XFER_UDMA_3:
> -		case XFER_UDMA_2:
> -		case XFER_UDMA_1:
> -		case XFER_UDMA_0:
> -			dma_timing   |= dma_modes[2];

    Why it needs to change in the first place?

> -			ultra_timing |= ((udma_modes[speed - XFER_UDMA_0]) << (4*unit));
> -			ultra_enable |= (0x01 << drive->dn);
> -		default:
> -			break;
> -	}
> +	if (speed >= XFER_UDMA_0) {
> +		dma_timing   |= dma_modes[2];
> +		ultra_timing |= (udma_modes[speed - XFER_UDMA_0] << (4 * unit));
> +		ultra_enable |= (0x01 << drive->dn);
> +	} else if (speed >= XFER_MW_DMA_0)
> +		dma_timing   |= dma_modes[speed - XFER_MW_DMA_0];
>  
>  	pci_write_config_byte(dev, drive_pci2[drive->dn], dma_timing);
>  	pci_write_config_byte(dev, (0x56|hwif->channel), ultra_timing);

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
