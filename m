From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] siimage: fix ->set_pio_mode method to select PIO data
 transfer
Date: Sat, 14 Jul 2007 21:35:50 +0400
Message-ID: <46990976.5020308@ru.mvista.com>
References: <200707132311.58022.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50651 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757630AbXGNRdr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jul 2007 13:33:47 -0400
In-Reply-To: <200707132311.58022.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Remember to select PIO data transfer (with IORDY monitored) in sil_tune_pio()
>   (->set_pio_mode method) so the controller is always programmed correctly for
>   PIO transfers (this is important if DMA is not going to be used).

> * Don't set DMA/UDMA timings for PIO modes in siimage_tune_chipset().

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/pci/siimage.c
> ===================================================================
> --- a/drivers/ide/pci/siimage.c
> +++ b/drivers/ide/pci/siimage.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/siimage.c		Version 1.15	Jun 29 2007
> + * linux/drivers/ide/pci/siimage.c		Version 1.16	Jul 13 2007
>   *
>   * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
>   * Copyright (C) 2003		Red Hat <alan@redhat.com>
> @@ -185,7 +185,12 @@ static void sil_tune_pio(ide_drive_t *dr
>  	u16 speedp		= 0;
>  	unsigned long addr	= siimage_seldev(drive, 0x04);
>  	unsigned long tfaddr	= siimage_selreg(hwif, 0x02);
> +	unsigned long base	= (unsigned long)hwif->hwif_data;
>  	u8 tf_pio		= pio;
> +	u8 addr_mask		= hwif->channel ? (hwif->mmio ? 0xF4 : 0x84)
> +						: (hwif->mmio ? 0xB4 : 0x80);
> +	u8 mode			= 0;
> +	u8 unit			= drive->select.b.unit;
>  
>  	/* trim *taskfile* PIO to the slowest of the master/slave */
>  	if (pair->present) {
> @@ -207,6 +212,11 @@ static void sil_tune_pio(ide_drive_t *dr
>  			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);
>  		else
>  			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);
> +
> +		mode = hwif->INB(base + addr_mask);
> +		mode &= ~(unit ? 0x30 : 0x03);
> +		mode |= (unit ? 0x10 : 0x01);
> +		hwif->OUTB(mode, base + addr_mask);
>  	} else {
>  		pci_write_config_word(hwif->pci_dev, addr, speedp);
>  		pci_write_config_word(hwif->pci_dev, tfaddr, speedt);
> @@ -216,6 +226,11 @@ static void sil_tune_pio(ide_drive_t *dr
>  		if (pio > 2)
>  			speedp |= 0x200;
>  		pci_write_config_word(hwif->pci_dev, tfaddr-2, speedp);
> +
> +		pci_read_config_byte(hwif->pci_dev, addr_mask, &mode);
> +		mode &= ~(unit ? 0x30 : 0x03);
> +		mode |= (unit ? 0x10 : 0x01);
> +		pci_write_config_byte(hwif->pci_dev, addr_mask, mode);
>  	}
>  }

    First, there's a possibility of disabling DMA mode if an invalid PIO mode
is passed -- ide_config_drive_speed() won't call dma_off_quietly() in this
case. Well, due to the way IDE core works now, one has to re-tune DMA after 
setting any PIO mode anyway, so maybe this simple code would indeed be enough...
    Second, although being correct (only for the drives supporting IORDY,
that is), this code is asymmetric to what's done for the taskfile IORDY.

    A side note: pio/mmio code patchs certalinly could use some reorg here, to
extract the common code from them... at least that's what was on my mind when
I intended to work on this driver. :-)

MBR, Sergei
