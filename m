From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 7/9] cs5536: convert to ide2libata
Date: Sat, 30 Jan 2010 16:55:47 -0500
Message-ID: <4B64AAE3.5040501@garzik.org>
References: <20100130194918.30779.25485.sendpatchset@localhost> <20100130195004.30779.89524.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:52280 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab0A3Vzt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jan 2010 16:55:49 -0500
In-Reply-To: <20100130195004.30779.89524.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/30/2010 02:50 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Subject: [PATCH] cs5536: convert to ide2libata
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   drivers/ata/pata_cs5536.h |   22 +++++
>   drivers/ide/cs5536.c      |  189 +---------------------------------------------
>   2 files changed, 26 insertions(+), 185 deletions(-)
>
> Index: b/drivers/ata/pata_cs5536.h
> ===================================================================
> --- a/drivers/ata/pata_cs5536.h
> +++ b/drivers/ata/pata_cs5536.h
> @@ -64,7 +64,11 @@ static int cs5536_write(struct pci_dev *
>
>   static void cs5536_program_dtc(struct ata_device *adev, u8 tim)
>   {
> +#ifndef __IDE2LIBATA
>   	struct pci_dev *pdev = to_pci_dev(adev->link->ap->host->dev);
> +#else
> +	struct pci_dev *pdev = to_pci_dev(adev->hwif->dev);
> +#endif
>   	int dshift = adev->devno ? IDE_D1_SHIFT : IDE_D0_SHIFT;
>   	u32 dtc;
>
> @@ -121,11 +125,19 @@ static void cs5536_set_piomode(struct at
>   	int mode = adev->pio_mode - XFER_PIO_0;
>   	int cmdmode = mode;
>   	int cshift = adev->devno ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
> +#ifdef __IDE2LIBATA
> +	unsigned long timings = (unsigned long)ide_get_drivedata(adev);
> +#endif
>   	u32 cast;
>
>   	if (pair)
>   		cmdmode = min(mode, pair->pio_mode - XFER_PIO_0);
>
> +#ifdef __IDE2LIBATA
> +	timings&= (IDE_DRV_MASK<<  8);
> +	timings |= drv_timings[mode];
> +	ide_set_drivedata(adev, (void *)timings);
> +#endif
>   	cs5536_program_dtc(adev, drv_timings[mode]);
>
>   	cs5536_read(pdev, CAST,&cast);
> @@ -160,7 +172,9 @@ static void cs5536_set_dmamode(struct at
>   	u32 etc;
>   	int mode = adev->dma_mode;
>   	int dshift = adev->devno ? IDE_D1_SHIFT : IDE_D0_SHIFT;
> -
> +#ifdef __IDE2LIBATA
> +	unsigned long timings = (unsigned long)ide_get_drivedata(adev);
> +#endif
>   	cs5536_read(pdev, ETC,&etc);
>
>   	if (mode>= XFER_UDMA_0) {
> @@ -168,7 +182,13 @@ static void cs5536_set_dmamode(struct at
>   		etc |= udma_timings[mode - XFER_UDMA_0]<<  dshift;
>   	} else { /* MWDMA */
>   		etc&= ~(IDE_ETC_UDMA_MASK<<  dshift);
> +#ifndef __IDE2LIBATA
>   		cs5536_program_dtc(adev, mwdma_timings[mode - XFER_MW_DMA_0]);
> +#else
> +		timings&= IDE_DRV_MASK;
> +		timings |= mwdma_timings[mode - XFER_MW_DMA_0]<<  8;
> +		ide_set_drivedata(adev, (void *)timings);
> +#endif
>   	}
>
>   	cs5536_write(pdev, ETC, etc);

Wow, that's really turning into a rat's nest of ifdefs, isn't it?

	Jeff



