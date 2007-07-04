From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/6] siimage: PIO mode setup fixes
Date: Wed, 4 Jul 2007 20:59:31 +0200
Message-ID: <200707042059.31567.bzolnier@gmail.com>
References: <200706232004.08914.bzolnier@gmail.com> <200706300012.12394.bzolnier@gmail.com> <468BC7D2.2030901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:48752 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbXGDSqG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 14:46:06 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3324180mue
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 11:46:04 -0700 (PDT)
In-Reply-To: <468BC7D2.2030901@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 04 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>    A lot to argue about here...
> 
> >>>* Add sil_tuneproc() wrapper for siimage_tuneproc() which also sets
> >>>  PIO mode on the device.
> 
> >>    Planning on the global prefix change? :-)
> 
> > Yep.
> 
>     Well, it didn't work out with 'ata_'... ;-)

Because of bad libata taking over our precioussssss namespace... ;-)

Fortunately pata_sil680 driver uses "sil680_" prefix.

> >>>* Add code limiting maximum PIO mode according to the pair device capabilities
> >>>  to sil_tuneproc().
> 
> >>    Ugh... that part is terrible. :-/
> >>    Actually, we only need to limit the taskfile, not the data transfers --
> >>unlike it was done before.
> 
> > Fixed.
> 
>     Let's see... :-)
> 
> >>    Note that PIO setup keeps being somewhat borken IODRY-wise even with this
> >>patch as sil_tune_pio() only controls taskfile IORDY sampling -- the Right
> >>Thing could only be done via speedproc() method...
> 
> > After rehashing the datasheet I see the source of the issue:
> 
> > IORDY is controlled in two registers and moreover it is always enabled
> > if MDMA or UDMA transfer modes are selected.
> 
>     Yeah. I drafted some patch for pata_sil.c but Alan fixed it first and in a 
> more simple way -- libata calls PIO/DMA setting methods in the strict 
> sequence, and that allowed to bypass some checks...

I fail to see how this helps in this case, care to explain?

> > +	/* cheat for now and use the docs */
> > +	speedp = data_speed[pio];
> > +	speedt = tf_speed[tf_pio];
> > +
> >  	if (hwif->mmio) {
> >  		hwif->OUTW(speedp, addr);
> >  		hwif->OUTW(speedt, tfaddr);
> >  		/* Now set up IORDY */
> > -		if(mode_wanted == 3 || mode_wanted == 4)
> > +		if (pio > 2)
> 
>     Not tf_pio? This IORDY bit is for taskfile accesses...

Would this be really OK (tf_pio takes minimum PIO mode)?

> >  			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);
> >  		else
> >  			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);
> > @@ -245,42 +213,17 @@ static void siimage_tuneproc (ide_drive_
> >  		pci_read_config_word(hwif->pci_dev, tfaddr-2, &speedp);
> >  		speedp &= ~0x200;
> >  		/* Set IORDY for mode 3 or 4 */
> > -		if(mode_wanted == 3 || mode_wanted == 4)
> > +		if (pio > 2)
> 
>     Same question here.
>     However... this logic should rely on both drives' PIO modes, so would be 
> broken either way until this is fixed...

Yep.

Thanks,
Bart
