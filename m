From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Wed, 1 Aug 2007 23:07:59 +0200
Message-ID: <200708012308.00057.bzolnier@gmail.com>
References: <1185880124.3483.25.camel@localhost> <200707312332.10820.bzolnier@gmail.com> <46B08D63.4040205@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:62346 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbXHAVJp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 17:09:45 -0400
Received: by nf-out-0910.google.com with SMTP id g13so84495nfb
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 14:09:44 -0700 (PDT)
In-Reply-To: <46B08D63.4040205@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bob Ham <rah@bash.sh>, linux-ide@vger.kernel.org


Hi,

On Wednesday 01 August 2007, Sergei Shtylyov wrote:

> > Does this patch change anything?
> 
>     Heh, did you *really* hope it will? :-D

Well, ugh, yes? :)

> > [PATCH] hpt366: always tune PIO
> 
> > Index: b/drivers/ide/pci/hpt366.c
> > ===================================================================
> > --- a/drivers/ide/pci/hpt366.c
> > +++ b/drivers/ide/pci/hpt366.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * linux/drivers/ide/pci/hpt366.c		Version 1.10	Jun 29, 2007
> > + * linux/drivers/ide/pci/hpt366.c		Version 1.11	Jul 29, 2007
> >   *
> >   * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
> >   * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
> > @@ -1265,10 +1265,10 @@ static void __devinit init_hwif_hpt366(i
> >  	if (new_mcr != old_mcr)
> >  		pci_write_config_byte(dev, hwif->select_data + 1, new_mcr);
> >  
> > -	if (!hwif->dma_base) {
> > -		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
> > +	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
> > +
> > +	if (hwif->dma_base == 0)
> >  		return;
> > -	}
> >  
> >  	hwif->ultra_mask = hwif->cds->udma_mask;
> >  	hwif->mwdma_mask = 0x07;
> 
>     Concerning the patch (I lacked time to look at the driver to refresh my 
> memory before -- was looking at the new Disk-on-chip H3 driver to be submitted 
> for comments soon, BTW): it makes little sense in its current form since 
> setting any DMA mode also sets 8-bit PIO timings now (and if DMA can't be set, 
> the driver will fallback to PIO anyway)

Without ->autotune timings for PIO data transfers are never set and we need
to have a valid settings for some commands (IDENTIFY, SMART data) even if
DMA is not going to be used.  Thus why I was hoping that this patch might be
of some help.

>     I have a patch that changes this behavior and switches to always 
> auto-tuning PIO but I've changed my mind on how the DMA/PIO timing register 
> sharing should be handled now -- however, since I was unable to come up with 
> anything better all that time, I'll consider pushing out this version when I 
> have a spare time...

Please do.

Thanks,
Bart
