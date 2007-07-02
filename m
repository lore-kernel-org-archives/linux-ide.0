From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 12/15] alim15x3: ->speedproc, filter out invalid modes passed from user-space
Date: Mon, 2 Jul 2007 19:56:32 +0200
Message-ID: <200707021956.32844.bzolnier@gmail.com>
References: <200706302110.20766.bzolnier@gmail.com> <46891CD4.7020703@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:25596 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbXGBRun (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 13:50:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1306790ugf
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 10:50:41 -0700 (PDT)
In-Reply-To: <46891CD4.7020703@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 02 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > * ->speedproc, filter out invalid modes passed from user-space.
> 
> > * Add FIXME about DMA timings never being set.
> 
> > * Bump driver version.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/pci/alim15x3.c
> > ===================================================================
> > --- a/drivers/ide/pci/alim15x3.c
> > +++ b/drivers/ide/pci/alim15x3.c
> > @@ -425,6 +425,17 @@ static int ali15x3_tune_chipset (ide_dri
> >  	u8 tmpbyte		= 0x00;
> >  	int m5229_udma		= (hwif->channel) ? 0x57 : 0x56;
> >  
> > +	/*
> > +	 * Paranoia, filter out invalid modes passed from user-space
> > +	 * (unsupported UDMA modes are dealt by ide_rate_filter() call).
> > +	 *
> > +	 * This will go away once ide_set_xfer() is fixed.
> > +	 */
> > +	if ((speed > XFER_PIO_5 && speed < XFER_SW_DMA_0) ||
> > +	    (speed > XFER_SW_DMA_2 && speed < XFER_MW_DMA_0) ||
> > +	    (speed > XFER_MW_DMA_2 && speed < XFER_UDMA_0))
> > +		return -1;
> > +
> >  	if (speed == XFER_UDMA_6)
> >  		speed1 = 0x47;
> >  
> > @@ -437,6 +448,10 @@ static int ali15x3_tune_chipset (ide_dri
> >  		tmpbyte &= ultra_enable;
> >  		pci_write_config_byte(dev, m5229_udma, tmpbyte);
> >  
> > +		/*
> > +		 * FIXME: Oh, my... DMA timings are never set.
> > +		 */
> > +
> 
>     Erm, wouldn't it have been better to mark them as unsupported while at it?

This would brake setups which currently work OK, i.e. BIOS set things up
(reminds me about cmd64x vs broken MWDMA)...

The RightThing(tm) to do is to fix alim15x3 driver to program DMA timings
(especially given that pata_ali seems to already contain the needed code).

Thanks,
Bart
