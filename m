From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/4] ide: use only ->set_pio_mode method for programming PIO modes
Date: Mon, 23 Jul 2007 23:52:30 +0200
Message-ID: <200707232352.30381.bzolnier@gmail.com>
References: <200707201226.13405.bzolnier@gmail.com> <46A4FA3B.2050300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:19644 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382AbXGWVyz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 17:54:55 -0400
Received: by ug-out-1314.google.com with SMTP id j3so44277ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 14:54:54 -0700 (PDT)
In-Reply-To: <46A4FA3B.2050300@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 23 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Use ->set_pio_mode method to program PIO modes in ide_set_xfer_rate()
> > (the only place which used ->speedproc to program PIO modes) and remove
> > handling of PIO modes from all ->speedproc implementations.
> 
> > There should be no functionality changes caused by this patch.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/cris/ide-cris.c
> > ===================================================================
> > --- a/drivers/ide/cris/ide-cris.c
> > +++ b/drivers/ide/cris/ide-cris.c
> > @@ -724,11 +724,6 @@ static int speed_cris_ide(ide_drive_t *d
> >  {
> >  	int cyc = 0, dvs = 0, strobe = 0, hold = 0;
> >  
> > -	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
> > -		cris_set_pio_mode(drive, speed - XFER_PIO_0);
> > -		return ide_config_drive_speed(drive, speed);
> > -	}
> > -
> >  	switch(speed)
> >  	{
> >  		case XFER_UDMA_0:
> > Index: b/drivers/ide/ide-lib.c
> > ===================================================================
> > --- a/drivers/ide/ide-lib.c
> > +++ b/drivers/ide/ide-lib.c
> > @@ -398,6 +398,18 @@ int ide_set_xfer_rate(ide_drive_t *drive
> >  
> >  	rate = ide_rate_filter(drive, rate);
> >  
> > +	if (rate >= XFER_PIO_0 && rate <= XFER_PIO_5) {
> > +		if (hwif->set_pio_mode)
> > +			hwif->set_pio_mode(drive, rate - XFER_PIO_0);
> 
>     BTW, why doesn it pass CF-specific PIO6? Not an issue now, but what the 
> hell?  I'd suggest instead:
> 
> 	if (rate & XFER_PIO_0) {

Like you've said not an issue now and moreover the current code serves
as a documentation that PIO6 is not supported. ;)

Thanks,
Bart
