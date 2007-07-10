From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/12] ide: add missing ide_rate_filter() calls to ->speedproc()-s
Date: Tue, 10 Jul 2007 22:25:46 +0200
Message-ID: <200707102225.46628.bzolnier@gmail.com>
References: <200707081534.06163.bzolnier@gmail.com> <4692404F.6050105@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:59871 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760145AbXGJWEl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 18:04:41 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1363733wxd
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 15:04:41 -0700 (PDT)
In-Reply-To: <4692404F.6050105@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 09 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > * Fix icside, cris-ide, au1xxx-ide, amd74xx, via82cxxx and pmac host drivers
> >   to use ide_rate_filter().
> 
> >   This results in the following modes (from user requests) being clipped down:
> >   - invalid modes (values 0x46-0xFF)  [ for all hosts ]
> >   - unsupported by a host UDMA modes  [ for hosts which support UDMA]
> >   - all UDMA modes and MWDMA3-4 modes [ for hosts which doesn't support UDMA ]
> >   - invalid modes (values 0x25-0x39)  [ for hosts which doesn't support UDMA ]
> 
>     For plural 3rd person it would be "don't". ;-)
>     Sorry for the grammar nitpicking

Fixed, thanks.

> > * Host driver specific changes in behavior:
> 
> >   icside:
> >     - no change
> 
> >   cris-ide
> >     - clip unsupported UDMA3-6 modes down
> >     - fix BUG() on trying to set unsupported UDMA3-6 modes
> 
> >   au1xxx-ide/pmac
> >     - clip unsupported UDMA modes down
> 
> >   amd74xx/via82cxxx
> >     - clip unsupported UDMA modes down
> >     - fix random PIO timings being set for unsupported/invalid modes
> >     - fix unsupported/invalid modes being set on the device
> 
> > * While at it remove no longer needed checks from pmac.c driver.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added

> > ---
> > This patch series goes before ide-add-ide-set-pio-take3.patch patch
> > ("[PATCH] ide: add ide_set{_max}_pio() (take 3)") in the quilt tree.
> > The rediffed ide-add-ide-set-pio-take3.patch is also included for
> > completness.
> 
> > Index: b/drivers/ide/ppc/pmac.c
> > ===================================================================
> > --- a/drivers/ide/ppc/pmac.c
> > +++ b/drivers/ide/ppc/pmac.c
> > @@ -923,6 +923,8 @@ pmac_ide_tune_chipset (ide_drive_t *driv
> >  	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
> >  	u32 *timings, *timings2;
> >  
> > +	speed = ide_rate_filter(drive, speed);
> > +
> >  	if (pmif == NULL)
> >  		return 1;
> >  		
> > @@ -932,17 +934,9 @@ pmac_ide_tune_chipset (ide_drive_t *driv
> >  	switch(speed) {
> >  #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
> >  		case XFER_UDMA_6:
> > -		        if (pmif->kind != controller_sh_ata6)
> > -				return 1;
> >  		case XFER_UDMA_5:
> > -			if (pmif->kind != controller_un_ata6 &&
> > -			    pmif->kind != controller_k2_ata6 &&
> > -			    pmif->kind != controller_sh_ata6)
> > -				return 1;
> >  		case XFER_UDMA_4:
> >  		case XFER_UDMA_3:
> > -			if (drive->hwif->cbl != ATA_CBL_PATA80)
> > -				return 1;
> >  		case XFER_UDMA_2:
> >  		case XFER_UDMA_1:
> >  		case XFER_UDMA_0:
> 
>     BTW, I just saw a stange code in this driver that clips hwif->udma_mask 
> depending on pmif->cable_80. I somewhat doubt that it's necessary...

Yes, hwif->ultra_mask(s) shouldn't depend on pmif->cable_80.

This doesn't hurt nowadays but may hurt in the future (warmplug/hotplug).

Thanks,
Bart
