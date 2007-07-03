From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 9/15] ide: add PIO masks
Date: Tue, 3 Jul 2007 21:12:44 +0200
Message-ID: <200707032112.44115.bzolnier@gmail.com>
References: <200706302107.42458.bzolnier@gmail.com> <468A89FE.1040806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:29551 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892AbXGCU0w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 16:26:52 -0400
Received: by ug-out-1314.google.com with SMTP id j3so170457ugf
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 13:26:51 -0700 (PDT)
In-Reply-To: <468A89FE.1040806@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 03 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Add ATA_PIO[0-6] defines to <linux/ata.h>.
> 
> > * Add ->pio_mask field to ide_pci_device_t and ide_hwif_t.
> 
> > * Add PIO masks to host drivers.
> 
>     Hm, the next logical step would be to use the mask constants in
> <linux/ata.h> for the drivers' DMA caps too...

Patches welcomed. :-)

> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added

> > Index: b/drivers/ide/pci/it8213.c
> > ===================================================================
> > --- a/drivers/ide/pci/it8213.c
> > +++ b/drivers/ide/pci/it8213.c
> > @@ -276,6 +276,7 @@ static void __devinit init_hwif_it8213(i
> >  		.enablebits	= {{0x41,0x80,0x80}}, \
> >  		.bootable	= ON_BOARD,		\
> >  		.host_flags	= IDE_HFLAG_SINGLE,	\
> > +		.pio_mask	= ATA_PIO4,		\
> >  	}
> >  
> >  static ide_pci_device_t it8213_chipsets[] __devinitdata = {
> [...]
> > Index: b/drivers/ide/pci/piix.c
> > ===================================================================
> > --- a/drivers/ide/pci/piix.c
> > +++ b/drivers/ide/pci/piix.c
> > @@ -498,6 +498,7 @@ static void __devinit init_hwif_piix(ide
> >  		.autodma	= AUTODMA,		\
> >  		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
> >  		.bootable	= ON_BOARD,		\
> > +		.pio_mask	= ATA_PIO4,		\
> >  		.udma_mask	= udma,			\
> >  	}
> >  
> > @@ -517,6 +518,7 @@ static ide_pci_device_t piix_pci_info[] 
> >  		.enablebits	= {{0x6d,0xc0,0x80}, {0x6d,0xc0,0xc0}},
> >  		.bootable	= ON_BOARD,
> >  		.host_flags	= IDE_HFLAG_ISA_PORTS,
> > +		.pio_mask	= ATA_PIO4,
> >  	},
> >  
> >  	/*  3 */ DECLARE_PIIX_DEV("PIIX3", 0x00),	/* no udma */
> [...]
> > Index: b/drivers/ide/pci/slc90e66.c
> > ===================================================================
> > --- a/drivers/ide/pci/slc90e66.c
> > +++ b/drivers/ide/pci/slc90e66.c
> > @@ -217,6 +217,7 @@ static ide_pci_device_t slc90e66_chipset
> >  	.autodma	= AUTODMA,
> >  	.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
> >  	.bootable	= ON_BOARD,
> > +	.pio_mask	= ATA_PIO4,
> >  };
> >
> >  static int __devinit slc90e66_init_one(struct pci_dev *dev, const struct 
> pci_device_id *id)
> 
>     Strictly speaking, these Intel/SMsC/ITE chips don't support PIO mode 1,
> only modes 0 and 2 thru 4 but the drivers are just using PIO0 timings for PIO1...

Reminds about a need to fix PIO1 in ->speedproc for Intel/SMsC (will do it).

Thanks,
Bart
