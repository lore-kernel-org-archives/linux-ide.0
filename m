From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 10/13] sl82c105: add ->speedproc support
Date: Sat, 10 Mar 2007 23:32:12 +0100
Message-ID: <200703102332.12716.bzolnier@gmail.com>
References: <200703102209.59918.bzolnier@gmail.com> <45F32860.8040901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:2697 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbXCJWZM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 17:25:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1761891uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 14:25:11 -0800 (PST)
In-Reply-To: <45F32860.8040901@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Saturday 10 March 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > [PATCH] sl82c105: add ->speedproc support
> 
> > * add sl82c105_tunepio() wrapper for sl82c105_tune_drive()
> >   (just to get the error value)
> 
> > * add sl82c105_tune_chipset() (->speedproc method) for setting
> >   transfer mode
> 
>     Thanks for the patch!
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> 
>   > Index: b/drivers/ide/pci/sl82c105.c
> > ===================================================================
> > --- a/drivers/ide/pci/sl82c105.c
> > +++ b/drivers/ide/pci/sl82c105.c
> > @@ -77,7 +77,7 @@ static unsigned int get_timing_sl82c105(
> >  /*
> >   * Configure the drive and chipset for PIO
> >   */
> > -static void sl82c105_tune_drive(ide_drive_t *drive, u8 pio)
> > +static int sl82c105_tunepio(ide_drive_t *drive, u8 pio)
> 
>     The name sl82c105_tune_pio() would have been more in line with the other 
> drivers but well, that's your patch (and the function behaves somewhat 
> differently anyway :-)

I will change it.

> >  {
> >  	ide_hwif_t *hwif	= HWIF(drive);
> >  	struct pci_dev *dev	= hwif->pci_dev;
> > @@ -91,7 +91,7 @@ static void sl82c105_tune_drive(ide_driv
> >  	xfer_mode = ide_get_best_pio_mode(drive, pio, 5, &p) + XFER_PIO_0;
> >  
> >  	if (ide_config_drive_speed(drive, xfer_mode))
> > -		return;
> > +		return 1;
> >  
> >  	drive->drive_data = drv_ctrl = get_timing_sl82c105(&p);
> >  
> > @@ -114,17 +114,45 @@ static void sl82c105_tune_drive(ide_driv
> >  	 */
> >  	drive->io_32bit = 1;
> >  	drive->unmask	= 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static void sl82c105_tune_drive(ide_drive_t *drive, u8 pio)
> > +{
> > +	/*
> > +	 * TODO: find best PIO mode and set device speed here
> > +	 *       (requires adding helper function for getting PIO cycle time)
> > +	 */
> 
>    I thought we were doing it by calling ide_get_best_pio_mode() above...

We are also using ide_get_best_pio_mode() to get PIO cycle time
so we can't move it here ATM.

> > +	(void)sl82c105_tunepio(drive, pio);
> 
>     Erm, I thought afterwards that I vainly folded one into another. I think 
> it's worth moving those io_32bit and unmask flag assignments above back 
> there... May also recast my patch. :-)

Moving them to ->init_hwif where they belong would be even better... ;-)

> > +}
> > +
> > +static int sl82c105_tune_chipset(ide_drive_t *drive, u8 mode)
> > +{
> > +	mode = ide_rate_filter(drive, mode);
> > +
> > +	if (mode >= XFER_PIO_0 && mode <= XFER_PIO_5)
> > +		return sl82c105_tunepio(drive, mode - XFER_PIO_0);
> > +
> > +	/*
> > +	 * TODO: add MWDMA0/1 support
> > +	 */
> > +	BUG_ON(mode != XFER_MW_DMA_2);
> 
>     Well, the other drivers just return non-zero in this case...

They are are buggy and need fixing.

IDE driver itself should never ask for an unsupported mode and if user passes
such through ->speedproc interface OOPSing is IMO better than possible data
corruption.  On the second thought ide_rate_filter() takes care of filtering
UDMA modes, so it may as well take care of filtering SWDMA/MWDMA/PIO and the
problem will be solved in more gracefull way... but more work is needed...

Thanks,
Bart
