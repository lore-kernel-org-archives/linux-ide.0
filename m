From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/13] cy82c693: add ->set_dma_mode method
Date: Fri, 04 Jan 2008 22:57:58 +0300
Message-ID: <477E8FC6.3040107@ru.mvista.com>
References: <200711130001.38822.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:2379 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753056AbYADT5S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Jan 2008 14:57:18 -0500
In-Reply-To: <200711130001.38822.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Fix SWDMA/MWDMA masks in cy82c693_chipset.

> * Add IDE_HFLAG_CY82C693 host flag and use it in ide_tune_dma() to
>   check whether the DMA should be enabled even if ide_max_dma_mode()
>   fails.

    I didn't get why this was necessary...

> * Convert cy82c693_dma_enable() to become cy82c693_set_dma_mode()
>   and remove no longer needed cy82c693_ide_dma_on().  Then set
>   IDE_HFLAG_CY82C693 instead of IDE_HFLAG_TRUST_BIOS_FOR_DMA in
>   cy82c693_chipset.

> * Bump driver version.

> As a result of this patch cy82c693 driver will configure and use DMA on
> all SWDMA0-2 and MWDMA0-2 capable ATA devices instead of relying on BIOS.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>


> Index: b/drivers/ide/pci/cy82c693.c
> ===================================================================
> --- a/drivers/ide/pci/cy82c693.c
> +++ b/drivers/ide/pci/cy82c693.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/cy82c693.c		Version 0.43	Nov 7, 2007
> + * linux/drivers/ide/pci/cy82c693.c		Version 0.44	Nov 8, 2007
>   *
>   *  Copyright (C) 1998-2000 Andreas S. Krebs (akrebs@altavista.net), Maintainer
>   *  Copyright (C) 1998-2002 Andre Hedrick <andre@linux-ide.org>, Integrator
> @@ -176,14 +176,12 @@ static void compute_clocks (u8 pio, pio_
>   * set DMA mode a specific channel for CY82C693
>   */
>  
> -static void cy82c693_dma_enable (ide_drive_t *drive, int mode, int single)
> +static void cy82c693_set_dma_mode(ide_drive_t *drive, const u8 mode)
>  {
> -	u8 index = 0, data = 0;
> +	ide_hwif_t *hwif = drive->hwif;
> +	u8 single = (mode & 0x10) >> 4, index = 0, data = 0;

    Useless intializers for 'index' and 'data'.

MBR, Sergei
