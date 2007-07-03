From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 9/15] ide: add PIO masks
Date: Tue, 3 Jul 2007 22:08:13 +0200
Message-ID: <200707032208.13580.bzolnier@gmail.com>
References: <200706302107.42458.bzolnier@gmail.com> <468AA351.4090509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.179]:18610 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758059AbXGCU0y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 16:26:54 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1479239ika
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 13:26:52 -0700 (PDT)
In-Reply-To: <468AA351.4090509@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Tuesday 03 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Add ATA_PIO[0-6] defines to <linux/ata.h>.
> 
> > * Add ->pio_mask field to ide_pci_device_t and ide_hwif_t.
> 
> > * Add PIO masks to host drivers.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>    Not sure if my ACK applies now...
> 
> > Index: b/drivers/ide/pci/jmicron.c
> > ===================================================================
> > --- a/drivers/ide/pci/jmicron.c
> > +++ b/drivers/ide/pci/jmicron.c
> > @@ -180,6 +180,7 @@ fallback:
> >  		.autodma	= AUTODMA,		\
> >  		.bootable	= ON_BOARD,		\
> >  		.enablebits	= { {0x40, 1, 1}, {0x40, 0x10, 0x10} }, \
> > +		.pio_mask	= ATA_PIO5,		\
> >  	}
> 
>     Just noticed that this driver does nothing in its tuneproc() method. So, 
> this mask is unrealistic. The method needs to be dropped for now along with 

Adding ->pio_mask doesn't change the old behavior in _any_ way.

> config-jmicron_chipset_for_pio() -- ptobably, with FIXME added.

Please see comments for jmicron_tune_chipset(), ->tuneproc just misses
setting transfer mode on the device.  Care to send a patch fixing it?

Thanks,
Bart
