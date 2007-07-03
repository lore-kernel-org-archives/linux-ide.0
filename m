From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 9/15] ide: add PIO masks
Date: Tue, 03 Jul 2007 21:40:14 +0400
Message-ID: <468A89FE.1040806@ru.mvista.com>
References: <200706302107.42458.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:25167 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754457AbXGCRid (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 13:38:33 -0400
In-Reply-To: <200706302107.42458.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Add ATA_PIO[0-6] defines to <linux/ata.h>.

> * Add ->pio_mask field to ide_pci_device_t and ide_hwif_t.

> * Add PIO masks to host drivers.

    Hm, the next logical step would be to use the mask constants in
<linux/ata.h> for the drivers' DMA caps too...

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/pci/it8213.c
> ===================================================================
> --- a/drivers/ide/pci/it8213.c
> +++ b/drivers/ide/pci/it8213.c
> @@ -276,6 +276,7 @@ static void __devinit init_hwif_it8213(i
>  		.enablebits	= {{0x41,0x80,0x80}}, \
>  		.bootable	= ON_BOARD,		\
>  		.host_flags	= IDE_HFLAG_SINGLE,	\
> +		.pio_mask	= ATA_PIO4,		\
>  	}
>  
>  static ide_pci_device_t it8213_chipsets[] __devinitdata = {
[...]
> Index: b/drivers/ide/pci/piix.c
> ===================================================================
> --- a/drivers/ide/pci/piix.c
> +++ b/drivers/ide/pci/piix.c
> @@ -498,6 +498,7 @@ static void __devinit init_hwif_piix(ide
>  		.autodma	= AUTODMA,		\
>  		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
>  		.bootable	= ON_BOARD,		\
> +		.pio_mask	= ATA_PIO4,		\
>  		.udma_mask	= udma,			\
>  	}
>  
> @@ -517,6 +518,7 @@ static ide_pci_device_t piix_pci_info[] 
>  		.enablebits	= {{0x6d,0xc0,0x80}, {0x6d,0xc0,0xc0}},
>  		.bootable	= ON_BOARD,
>  		.host_flags	= IDE_HFLAG_ISA_PORTS,
> +		.pio_mask	= ATA_PIO4,
>  	},
>  
>  	/*  3 */ DECLARE_PIIX_DEV("PIIX3", 0x00),	/* no udma */
[...]
> Index: b/drivers/ide/pci/slc90e66.c
> ===================================================================
> --- a/drivers/ide/pci/slc90e66.c
> +++ b/drivers/ide/pci/slc90e66.c
> @@ -217,6 +217,7 @@ static ide_pci_device_t slc90e66_chipset
>  	.autodma	= AUTODMA,
>  	.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
>  	.bootable	= ON_BOARD,
> +	.pio_mask	= ATA_PIO4,
>  };
>
>  static int __devinit slc90e66_init_one(struct pci_dev *dev, const struct 
pci_device_id *id)

    Strictly speaking, these Intel/SMsC/ITE chips don't support PIO mode 1,
only modes 0 and 2 thru 4 but the drivers are just using PIO0 timings for PIO1...

> Index: b/drivers/ide/pci/scc_pata.c
> ===================================================================
> --- a/drivers/ide/pci/scc_pata.c
> +++ b/drivers/ide/pci/scc_pata.c
> @@ -734,6 +734,7 @@ static void __devinit init_hwif_scc(ide_
>        .autodma	= AUTODMA,				\
>        .bootable	= ON_BOARD,				\
>        .host_flags	= IDE_HFLAG_SINGLE,		\
> +      .pio_mask		= ATA_PIO4,			\

    Erm, formatting nit: leading spaces () and contrarywise, space ISO tab
after field name wouldn't have caught an eye. B-)
    Well, I see that the style is borken all over the macros, no forget about
spaces...

>    }
>  
>  static ide_pci_device_t scc_chipsets[] __devinitdata = {
> Index: b/drivers/ide/pci/sgiioc4.c
> ===================================================================
> --- a/drivers/ide/pci/sgiioc4.c
> +++ b/drivers/ide/pci/sgiioc4.c
> @@ -586,6 +586,7 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
>  	hwif->ultra_mask = 0x0;	/* Disable Ultra DMA */
>  	hwif->mwdma_mask = 0x2;	/* Multimode-2 DMA  */
>  	hwif->swdma_mask = 0x2;
> +	hwif->pio_mask = 0x00;

    "I don't believe!" :-D Should be at least supporting PIO0. ;-)

>  	hwif->tuneproc = NULL;	/* Sets timing for PIO mode */

    ... but it won't matter anyway due to missing tuneproc() method.

MBR, Sergei

