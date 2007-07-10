From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/12] ide: mode limiting fixes for user requested speed changes
Date: Tue, 10 Jul 2007 22:21:09 +0200
Message-ID: <200707102221.09536.bzolnier@gmail.com>
References: <200707081534.13187.bzolnier@gmail.com> <469290FF.1020307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:59871 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758357AbXGJWEl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 18:04:41 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1363733wxd
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 15:04:40 -0700 (PDT)
In-Reply-To: <469290FF.1020307@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 09 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>     Sorry, more grammar nitpicking follows (-:
> 
> > * Add an extra argument to ide_max_dma_mode() for passing requested transfer
> >   mode.  Use it as an upper limit when finding the best DMA for device/host.
> 
> > * Rename ide_max_dma_mode() to ide_find_dma_mode() and at the same time add
> >   ide_max_dma_mode() wrapper which passes XFER_UDMA_6 as a requested mode to
> >   ide_find_dma_mode().  Also add inline ide_find_dma_mode() version for
> >   CONFIG_BLK_DEV_IDEDMA=n case.
> 
> > * Pass requested transfer mode from ide_find_dma_mode() to ide_get_mode_mask()
> >   to avoid false warning from eighty_ninty_three().
> 
> > * Use ide_find_dma_mode() to limit the user requested transfer mode in
> >   ide_rate_filter().  Also limit the requested mode by host max PIO mode.
> 
> 
> > Above changes make ide_rate_filter() to:
> 
> > * Clip desired transfer mode down if it is invalid (values 0x0F, 0x13-0x19
> >   and 0x25-0x39, values > 0x46 values were already clipped down, same for
> 
>     Too many "values".

Fixed.

> >   0x25-0x39 values but iff UDMA was not supported by the host).
> 
> > * Clip desired transfer mode down down if it is currently unsupported by
> 
>     Again, one "down" to many.

Fixed.

> >   IDE core (PIO6 and MWDMA3-4, the latter were already clipped down but
> >   iff UDMA was not supported by the host).
> 
> > * Clip desired transfer mode down according to the host capabilities
> >   (UDMA modes were already clipped down but MWDMA/SWDMA/PIO weren't,
> >   also ->atapi_dma flag was not respected).
> 
> > * Clip desired transfer mode down according to the device capabilities
> >   (except PIO modes for now which require mode work) - shouldn't be a
> >   problem since ide_set_xfer_rate() is called _after_ device has accepted
> >   given transfer mode.
> 
> > and also result in a number of host driver specific bugfixes:
> 
> [...]
> 
> > * cs5530
> >   - clip unsupported PIO5 and SWDMA0-2 modes down
> >   - fix unsupported/invalid modes being set on the device
> >   - fix bug BUG() on unsupported/invalid modes
> 
>     Buggy BUG()? :-)

Fixed.

> >     (which happend if the device accepted the setting)
> 
>     So, "happens" or "happened"?

the latter, fixed

> > * hpt366
> >   - clip unsupported PIO5 and SWDMA0-2 modes down
> >   - fix PIO0 timings being programmed for unsupported/invalid modes
> >   - fix DMA timings being cleared for MWDMA3-4 and 0x25-0x39 modes
> >   - fix unsupported/invalid modes being set on the device
> 
>     Oops, inherited that behavior from the old driver.
> 
> > * sc1200
> >   - clip unsupported PIO5 and SWDMA0-2 modes down
> >   - fix unsupported/invalid modes being set on the device
> >   - fix bug BUG() on unsupported/invalid modes
> 
>     Buggy BUG() again? :-)

Fixed.

> >     (which happend if the device accepted the setting)
> 
>     So, what tense? :-)

Past Simple :)

> > * tc86c001
> >   - clip unsupported PIO5 and SWDMA0-2 modes down
> >   - fix PIO0 timings being programmed for PIO5/0x0F/SWDMA0-2/0x13-0x19 modes
> >   - fix invalid 0x00 DMA timing being programmed for MWDMA3-4/0x25-0x39 modes
> >   - fix unsupported/invalid modes being set on the device
> 
>     Oops, that's me who overlooked this. :-<

Self-criticism accepted. ;)

> > While at it:
> 
> > * Use ide_rate_filter() in cs5520.c::cs5520_tune_chipset().
> 
>     Hm, I thought the previous patch was intended for adding the missing 
> ide_rate_filter() calls...

cs5520 is a special case.

It was limiting transfer mode to XFER_PIO_4 so adding ide_rate_filter() call
before fixing ide_rate_fiter() itself would make cs5520 incorrectly limit
transfer mode to XFER_MW_DMA_2.

> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added

> ... with a minor nit:
> 
> > Index: b/drivers/ide/ide-dma.c
> > ===================================================================
> > --- a/drivers/ide/ide-dma.c
> > +++ b/drivers/ide/ide-dma.c
> [...]
> > @@ -694,8 +694,13 @@ static unsigned int ide_get_mode_mask(id
> >  		if (hwif->udma_filter)
> >  			mask &= hwif->udma_filter(drive);
> >  
> > -		if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
> > -			mask &= 0x07;
> > +		/*
> > +		 * avoid false cable warning from eighty_ninty_three()
> > +		 */
> > +		if (req_mode > XFER_UDMA_2) {
> > +			if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
> > +				mask &= 0x07;
> > +		}
> 
>     Unneeded curly braces, two if's could be collapsed into single one...

The comment is for the first if() only and I find the code to be slightly more
readable this way... :-P

Thanks,
Bart
