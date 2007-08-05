From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/11] it8213/piix/slc90e66: remove {it8213,piix,slc90e66}_dma_2_pio()
Date: Sun, 05 Aug 2007 19:55:49 +0400
Message-ID: <46B5F305.5040206@ru.mvista.com>
References: <200708042206.22546.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:63008 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755343AbXHEPxq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 5 Aug 2007 11:53:46 -0400
In-Reply-To: <200708042206.22546.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    Sigh... when I was talking about getting rid of that function, I meant 
that we need to also decouple UltraDMA from PIO -- which is what this patch 
misses...
    Actually, I intended to decouple DMA form PIO in this drivers completely 
but that would be a next step...

> Index: b/drivers/ide/pci/it8213.c
> ===================================================================
> --- a/drivers/ide/pci/it8213.c
> +++ b/drivers/ide/pci/it8213.c
> @@ -124,7 +93,7 @@ static void it8213_set_dma_mode(ide_driv
>  	int w_flag		= 0x10 << drive->dn;
>  	int u_speed		= 0;
>  	u16			reg4042, reg4a;
> -	u8			reg48, reg54, reg55;
> +	u8			reg48, reg54, reg55, pio;
>  
>  	pci_read_config_word(dev, maslave, &reg4042);
>  	pci_read_config_byte(dev, 0x48, &reg48);
> @@ -165,7 +134,11 @@ static void it8213_set_dma_mode(ide_driv
>  				pci_write_config_byte(dev, 0x54, reg54 | v_flag);
>  		} else
>  			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
> +
> +		pio = 4;

    Why let this stupidity live?

>  	} else {
> +		const u8 mwdma_to_pio[] = { 0, 3, 4 };
> +
>  		if (reg48 & u_flag)
>  			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
>  		if (reg4a & a_speed)
> @@ -174,9 +147,14 @@ static void it8213_set_dma_mode(ide_driv
>  			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
>  		if (reg55 & w_flag)
>  			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
> +
> +		if (speed >= XFER_MW_DMA_0)
> +			pio = mwdma_to_pio[speed - XFER_MW_DMA_0];
> +		else
> +			pio = 2; /* only SWDMA2 is allowed */

    Well, MWDMA0 is also not allowed, so you could have cut on mwdma_to_pio 
array size.

MBR, Sergei
