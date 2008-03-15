From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] ide: sanitize handling of IDE_HFLAG_NO_SET_MODE host flag
Date: Sat, 15 Mar 2008 22:57:10 +0100
Message-ID: <200803152257.10439.bzolnier@gmail.com>
References: <200802232115.11908.bzolnier@gmail.com> <47D808BD.2080902@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:8523 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbYCOVmt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Mar 2008 17:42:49 -0400
Received: by fg-out-1718.google.com with SMTP id l27so880150fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 15 Mar 2008 14:42:47 -0700 (PDT)
In-Reply-To: <47D808BD.2080902@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Wednesday 12 March 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Check for IDE_HFLAG_NO_SET_MODE host flag in ide_set_pio(),
> >   ide_set_[pio,dma]_mode(), ide_set_xfer_rate() and set_pio_mode().
> 
> > * Remove no longer needed IDE_HFLAG_NO_SET_MODE host flag checking
> >   from ide_tune_dma().
> 
> > * Remove superfluous ->set_pio_mode checking from do_special().
> 
> > This is a part of preparations for adding 'struct ide_port_ops'.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/ide-lib.c
> > ===================================================================
> > --- a/drivers/ide/ide-lib.c
> > +++ b/drivers/ide/ide-lib.c
> > @@ -353,6 +354,9 @@ int ide_set_pio_mode(ide_drive_t *drive,
> >  {
> >  	ide_hwif_t *hwif = drive->hwif;
> >  
> > +	if (hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
> > +		return 0;
> > +
> 
>     Shouldn't this be considered an error?

Nope, we want to cheat kernel-level PIO tuning into succeeding. ;)

[ This host flag is used by it821x in "smart" mode so HW takes care of
  tuning transfer mode on controller / device itself. ]

> >  	if (hwif->set_pio_mode == NULL)
> >  		return -1;
> >  
> > @@ -380,6 +384,9 @@ int ide_set_dma_mode(ide_drive_t *drive,
> >  {
> >  	ide_hwif_t *hwif = drive->hwif;
> >  
> > +	if (hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
> > +		return 0;
> > +
> 
>     Same here....

same for DMA tuning

> >  	if (hwif->set_dma_mode == NULL)
> >  		return -1;
> >  
> > @@ -410,7 +417,8 @@ int ide_set_xfer_rate(ide_drive_t *drive
> >  {
> >  	ide_hwif_t *hwif = drive->hwif;
> >  
> > -	if (hwif->set_dma_mode == NULL)
> > +	if (hwif->set_dma_mode == NULL ||
> > +	    (hwif->host_flags & IDE_HFLAG_NO_SET_MODE))
> >  		return -1;
> 
>     Hm, this is was not considered an error before...

Yep, but transfer mode changes are unsupported on it821x in "smart" mode.

PS Thanks for detailed review of 'struct ide_dma_ops' patch
   (I'll recast the patch as soon as possible, hopefully tomorrow).

Thanks,
Bart
