From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: PATCH: allow ide-generic users to ask it to capture unknown devices
Date: Fri, 5 Nov 2004 22:56:27 +0100
Message-ID: <200411052256.27303.bzolnier@elka.pw.edu.pl>
References: <1099671737.5556.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:17613 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261213AbUKEVxe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 16:53:34 -0500
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:40535 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S54071AbUKEVx1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Nov 2004 22:53:27 +0100
Received: from chello062179088136.chello.pl ([62.179.88.136]:63335 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S100730AbUKEVvz (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Fri, 5 Nov 2004 22:51:55 +0100
In-Reply-To: <1099671737.5556.32.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org


ide-generic is drivers/ide/ide-generic
please don't use this name wrt to pci/generic.c

On Friday 05 November 2004 17:22, Alan Cox wrote:
> Most of this patch is neccessary noise to make the generic entry "id 0" so
> that the code is clean and won't need touching each time an identifier is
> aded.

Why can't generic entry be just added at id 14 in generic_chipsets table?

What is the exact purpose of this patch?

AFAICS this option allows users to use generic code for unknown/unsupported
devices which can result in unpredictable results (hangs, data corruptions).

[ I don't want any bugreports from users of this option. ]

> diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/pci/generic.c linux-2.6.10rc1/drivers/ide/pci/generic.c
> --- linux.vanilla-2.6.10rc1/drivers/ide/pci/generic.c	2004-11-05 15:34:47.000000000 +0000
> +++ linux-2.6.10rc1/drivers/ide/pci/generic.c	2004-11-05 16:08:02.000000000 +0000
> @@ -41,6 +41,17 @@
>  
>  #include "generic.h"
>  
> +static int ide_generic_all;		/* Set to claim all devices */
> +
> +static int __init ide_generic_all_on(char *unused)
> +{
> +	ide_generic_all = 1;
> +	printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.\n");
> +	return 1;
> +}
> +
> +__setup("all-generic-ide", ide_generic_all_on);
> +
>  static unsigned int __init init_chipset_generic (struct pci_dev *dev, const char *name)
>  {
>  	return 0;
> @@ -96,6 +107,11 @@
>  {
>  	ide_pci_device_t *d = &generic_chipsets[id->driver_data];
>  	u16 command;
> +	
> +	/* Don't use the generic entry unless instructed to do so */
> +	if (id->driver_data == 0)
> +		if(ide_generic_all == 0)
> +			return 1;
>  
>  	if (dev->vendor == PCI_VENDOR_ID_UMC &&
>  	    dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
> @@ -108,8 +124,7 @@
>  		return 1;
>  
>  	pci_read_config_word(dev, PCI_COMMAND, &command);
> -	if(!(command & PCI_COMMAND_IO))
> -	{
> +	if(!(command & PCI_COMMAND_IO)) {
>  		printk(KERN_INFO "Skipping disabled %s IDE controller.\n", d->name);
>  		return 1; 
>  	}
> @@ -118,21 +133,23 @@
>  }
>  
>  static struct pci_device_id generic_pci_tbl[] = {
> -	{ PCI_VENDOR_ID_NS,     PCI_DEVICE_ID_NS_87410,            PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> -	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
> -	{ PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
> -	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8673F,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
> -	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886A,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
> -	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886BF,        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
> -	{ PCI_VENDOR_ID_HINT,   PCI_DEVICE_ID_HINT_VXPROII_IDE,    PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
> -	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
> -	{ PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
> +	{ PCI_VENDOR_ID_NS,     PCI_DEVICE_ID_NS_87410,            PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
> +	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
> +	{ PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
> +	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8673F,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
> +	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886A,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
> +	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886BF,        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
> +	{ PCI_VENDOR_ID_HINT,   PCI_DEVICE_ID_HINT_VXPROII_IDE,    PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
> +	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
> +	{ PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
>  #ifdef CONFIG_BLK_DEV_IDE_SATA
> -	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237_SATA,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
> +	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237_SATA,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
>  #endif
> -	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
> -	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
> -	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
> +	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
> +	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
> +	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13},
> +	/* Must come last. If you add entries adjust this table appropriately and the init_one code */
> +	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 0},
>  	{ 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, generic_pci_tbl);
> diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/pci/generic.h linux-2.6.10rc1/drivers/ide/pci/generic.h
> --- linux.vanilla-2.6.10rc1/drivers/ide/pci/generic.h	2004-11-05 15:34:47.000000000 +0000
> +++ linux-2.6.10rc1/drivers/ide/pci/generic.h	2004-11-05 16:08:02.000000000 +0000
> @@ -10,6 +10,13 @@
>  
>  static ide_pci_device_t generic_chipsets[] __devinitdata = {
>  	{	/* 0 */
> +		.name		= "Unknown",
> +		.init_chipset	= init_chipset_generic,
> +		.init_hwif	= init_hwif_generic,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.bootable	= ON_BOARD,
> +	},{	/* 1 */
>  		.name		= "NS87410",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
> @@ -17,84 +24,84 @@
>  		.autodma	= AUTODMA,
>  		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
>  		.bootable	= ON_BOARD,
> -        },{	/* 1 */
> +        },{	/* 2 */
>  		.name		= "SAMURAI",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
>  		.channels	= 2,
>  		.autodma	= AUTODMA,
>  		.bootable	= ON_BOARD,
> -	},{	/* 2 */
> +	},{	/* 3 */
>  		.name		= "HT6565",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
>  		.channels	= 2,
>  		.autodma	= AUTODMA,
>  		.bootable	= ON_BOARD,
> -	},{	/* 3 */
> +	},{	/* 4 */
>  		.name		= "UM8673F",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
>  		.channels	= 2,
>  		.autodma	= NODMA,
>  		.bootable	= ON_BOARD,
> -	},{	/* 4 */
> +	},{	/* 5 */
>  		.name		= "UM8886A",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
>  		.channels	= 2,
>  		.autodma	= NODMA,
>  		.bootable	= ON_BOARD,
> -	},{	/* 5 */
> +	},{	/* 6 */
>  		.name		= "UM8886BF",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
>  		.channels	= 2,
>  		.autodma	= NODMA,
>  		.bootable	= ON_BOARD,
> -	},{	/* 6 */
> +	},{	/* 7 */
>  		.name		= "HINT_IDE",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
>  		.channels	= 2,
>  		.autodma	= AUTODMA,
>  		.bootable	= ON_BOARD,
> -	},{	/* 7 */
> +	},{	/* 8 */
>  		.name		= "VIA_IDE",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
>  		.channels	= 2,
>  		.autodma	= NOAUTODMA,
>  		.bootable	= ON_BOARD,
> -	},{	/* 8 */
> +	},{	/* 9 */
>  		.name		= "OPTI621V",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
>  		.channels	= 2,
>  		.autodma	= NOAUTODMA,
>  		.bootable	= ON_BOARD,
> -	},{	/* 9 */
> +	},{	/* 10 */
>  		.name		= "VIA8237SATA",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
>  		.channels	= 2,
>  		.autodma	= AUTODMA,
>  		.bootable	= OFF_BOARD,
> -	},{ /* 10 */
> +	},{	/* 11 */
>  		.name 		= "Piccolo0102",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
>  		.channels	= 2,
>  		.autodma	= NOAUTODMA,
>  		.bootable	= ON_BOARD,
> -	},{ /* 11 */
> +	},{	/* 12 */
>  		.name 		= "Piccolo0103",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
>  		.channels	= 2,
>  		.autodma	= NOAUTODMA,
>  		.bootable	= ON_BOARD,
> -	},{ /* 12 */
> +	},{	/* 13 */
>  		.name 		= "Piccolo0105",
>  		.init_chipset	= init_chipset_generic,
>  		.init_hwif	= init_hwif_generic,
> 
> 
