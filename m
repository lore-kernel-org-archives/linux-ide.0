From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] siimage: fix ->set_pio_mode method to select PIO data transfer
Date: Wed, 18 Jul 2007 23:20:05 +0200
Message-ID: <200707182320.05716.bzolnier@gmail.com>
References: <200707132311.58022.bzolnier@gmail.com> <46990976.5020308@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:48969 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbXGRVHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 17:07:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so325086ugf
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 14:07:15 -0700 (PDT)
In-Reply-To: <46990976.5020308@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 14 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Remember to select PIO data transfer (with IORDY monitored) in sil_tune_pio()
> >   (->set_pio_mode method) so the controller is always programmed correctly for
> >   PIO transfers (this is important if DMA is not going to be used).
> 
> > * Don't set DMA/UDMA timings for PIO modes in siimage_tune_chipset().
> 
> > * Bump driver version.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added

> > Index: b/drivers/ide/pci/siimage.c
> > ===================================================================
> > --- a/drivers/ide/pci/siimage.c
> > +++ b/drivers/ide/pci/siimage.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * linux/drivers/ide/pci/siimage.c		Version 1.15	Jun 29 2007
> > + * linux/drivers/ide/pci/siimage.c		Version 1.16	Jul 13 2007
> >   *
> >   * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
> >   * Copyright (C) 2003		Red Hat <alan@redhat.com>
> > @@ -185,7 +185,12 @@ static void sil_tune_pio(ide_drive_t *dr
> >  	u16 speedp		= 0;
> >  	unsigned long addr	= siimage_seldev(drive, 0x04);
> >  	unsigned long tfaddr	= siimage_selreg(hwif, 0x02);
> > +	unsigned long base	= (unsigned long)hwif->hwif_data;
> >  	u8 tf_pio		= pio;
> > +	u8 addr_mask		= hwif->channel ? (hwif->mmio ? 0xF4 : 0x84)
> > +						: (hwif->mmio ? 0xB4 : 0x80);
> > +	u8 mode			= 0;
> > +	u8 unit			= drive->select.b.unit;
> >  
> >  	/* trim *taskfile* PIO to the slowest of the master/slave */
> >  	if (pair->present) {
> > @@ -207,6 +212,11 @@ static void sil_tune_pio(ide_drive_t *dr
> >  			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);
> >  		else
> >  			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);
> > +
> > +		mode = hwif->INB(base + addr_mask);
> > +		mode &= ~(unit ? 0x30 : 0x03);
> > +		mode |= (unit ? 0x10 : 0x01);
> > +		hwif->OUTB(mode, base + addr_mask);
> >  	} else {
> >  		pci_write_config_word(hwif->pci_dev, addr, speedp);
> >  		pci_write_config_word(hwif->pci_dev, tfaddr, speedt);
> > @@ -216,6 +226,11 @@ static void sil_tune_pio(ide_drive_t *dr
> >  		if (pio > 2)
> >  			speedp |= 0x200;
> >  		pci_write_config_word(hwif->pci_dev, tfaddr-2, speedp);
> > +
> > +		pci_read_config_byte(hwif->pci_dev, addr_mask, &mode);
> > +		mode &= ~(unit ? 0x30 : 0x03);
> > +		mode |= (unit ? 0x10 : 0x01);
> > +		pci_write_config_byte(hwif->pci_dev, addr_mask, mode);
> >  	}
> >  }
> 
>     First, there's a possibility of disabling DMA mode if an invalid PIO mode
> is passed -- ide_config_drive_speed() won't call dma_off_quietly() in this

#ifdef CONFIG_BLK_DEV_IDEDMA
        if (speed >= XFER_SW_DMA_0)
                hwif->dma_host_on(drive);
        else if (hwif->ide_dma_check)   /* check if host supports DMA */
                hwif->dma_off_quietly(drive);
#endif

It looks like it will?

> case. Well, due to the way IDE core works now, one has to re-tune DMA after 
> setting any PIO mode anyway, so maybe this simple code would indeed be enough...

Yep.

>     Second, although being correct (only for the drives supporting IORDY,
> that is), this code is asymmetric to what's done for the taskfile IORDY.

Improvements are welcomed. :)

>     A side note: pio/mmio code patchs certalinly could use some reorg here, to
> extract the common code from them... at least that's what was on my mind when
> I intended to work on this driver. :-)

Certainly, I would even say that it is worth adding sil_io{read,write}8/16/32
since none of the methods containing pci/mmio split are performance critical.

Thanks,
Bart
