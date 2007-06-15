From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: convert ide_find_best_mode() users to use ide_max_dma_mode()
Date: Sat, 16 Jun 2007 01:14:59 +0200
Message-ID: <200706160114.59878.bzolnier@gmail.com>
References: <200706092210.52291.bzolnier@gmail.com> <466EA010.7090108@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:64985 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757275AbXFOX0w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jun 2007 19:26:52 -0400
Received: by ug-out-1314.google.com with SMTP id j3so964359ugf
        for <linux-ide@vger.kernel.org>; Fri, 15 Jun 2007 16:26:52 -0700 (PDT)
In-Reply-To: <466EA010.7090108@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Tuesday 12 June 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:

> > Index: b/drivers/ide/mips/au1xxx-ide.c
> > ===================================================================
> > --- a/drivers/ide/mips/au1xxx-ide.c
> > +++ b/drivers/ide/mips/au1xxx-ide.c
> > @@ -381,9 +381,7 @@ static int auide_dma_setup(ide_drive_t *
> >  
> >  static int auide_dma_check(ide_drive_t *drive)
> >  {
> > -	u8 speed;
> > -
> > -#ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
> > +	u8 speed = ide_max_dma_mode(drive);
> >  
> >  	if( dbdma_init_done == 0 ){
> 
>     Ugh, coding style isnn't kosher here. :-)

Ah, indeed I overlooked it.

Now looking at the au1xxx-ide.c I see that there are few other
non-kosher places worth fixing...  Care to send a patch?

> >  		auide_hwif.white_list = ide_in_drive_list(drive->id,
> > @@ -394,7 +392,6 @@ static int auide_dma_check(ide_drive_t *
> >  		auide_ddma_init(&auide_hwif);
> >  		dbdma_init_done = 1;
> >  	}
> > -#endif
> >  
> >  	/* Is the drive in our DMA black list? */
> >  
> > @@ -409,8 +406,6 @@ static int auide_dma_check(ide_drive_t *
> >  	else
> >  		drive->using_dma = 1;
> >  
> > -	speed = ide_find_best_mode(drive, XFER_PIO | XFER_MWDMA);
> > -	
> >  	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
> 
>     ide_max_dma_mode() returns 0 if DMA not available, so that if should have 
> looked this way:

XFER_PIO is 0x00 so the patch is correct but

>   	if (drive->autodma && speed)

is of course simpler

I think that it is not worth re-spinning the whole patch just for that
(especially since the code in question is an old one and not introduced
in this patch).  However I'll happilly apply a follow-up fix.

> >  		return 0;
> 
>     But is this really equivalent? Why there's no fallback call to 
> ide_find_best_pio_mode() like in other cases?

Because of the

	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)

check.

In other places "speed" is always used, here it is only used if it denotes
a DMA mode (XFER_PIO mask was needlessly passed to ide_find_best_mode() call
since PIO modes were always filtered out later).

Thanks,
Bart
