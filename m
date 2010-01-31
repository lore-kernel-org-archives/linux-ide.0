From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/9] cs5536: convert to ide2libata
Date: Sun, 31 Jan 2010 01:30:23 +0100
Message-ID: <201001310130.23898.bzolnier@gmail.com>
References: <20100130194918.30779.25485.sendpatchset@localhost> <20100130195004.30779.89524.sendpatchset@localhost> <4B64AAE3.5040501@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:37158 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab0AaAbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jan 2010 19:31:16 -0500
In-Reply-To: <4B64AAE3.5040501@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 30 January 2010 10:55:47 pm Jeff Garzik wrote:
> On 01/30/2010 02:50 PM, Bartlomiej Zolnierkiewicz wrote:
> > From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> > Subject: [PATCH] cs5536: convert to ide2libata
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> > ---
> >   drivers/ata/pata_cs5536.h |   22 +++++
> >   drivers/ide/cs5536.c      |  189 +---------------------------------------------
> >   2 files changed, 26 insertions(+), 185 deletions(-)
> >
> > Index: b/drivers/ata/pata_cs5536.h
> > ===================================================================
> > --- a/drivers/ata/pata_cs5536.h
> > +++ b/drivers/ata/pata_cs5536.h
> > @@ -64,7 +64,11 @@ static int cs5536_write(struct pci_dev *
> >
> >   static void cs5536_program_dtc(struct ata_device *adev, u8 tim)
> >   {
> > +#ifndef __IDE2LIBATA
> >   	struct pci_dev *pdev = to_pci_dev(adev->link->ap->host->dev);
> > +#else
> > +	struct pci_dev *pdev = to_pci_dev(adev->hwif->dev);
> > +#endif
> >   	int dshift = adev->devno ? IDE_D1_SHIFT : IDE_D0_SHIFT;
> >   	u32 dtc;
> >
> > @@ -121,11 +125,19 @@ static void cs5536_set_piomode(struct at
> >   	int mode = adev->pio_mode - XFER_PIO_0;
> >   	int cmdmode = mode;
> >   	int cshift = adev->devno ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
> > +#ifdef __IDE2LIBATA
> > +	unsigned long timings = (unsigned long)ide_get_drivedata(adev);
> > +#endif
> >   	u32 cast;
> >
> >   	if (pair)
> >   		cmdmode = min(mode, pair->pio_mode - XFER_PIO_0);
> >
> > +#ifdef __IDE2LIBATA
> > +	timings&= (IDE_DRV_MASK<<  8);
> > +	timings |= drv_timings[mode];
> > +	ide_set_drivedata(adev, (void *)timings);
> > +#endif
> >   	cs5536_program_dtc(adev, drv_timings[mode]);
> >
> >   	cs5536_read(pdev, CAST,&cast);
> > @@ -160,7 +172,9 @@ static void cs5536_set_dmamode(struct at
> >   	u32 etc;
> >   	int mode = adev->dma_mode;
> >   	int dshift = adev->devno ? IDE_D1_SHIFT : IDE_D0_SHIFT;
> > -
> > +#ifdef __IDE2LIBATA
> > +	unsigned long timings = (unsigned long)ide_get_drivedata(adev);
> > +#endif
> >   	cs5536_read(pdev, ETC,&etc);
> >
> >   	if (mode>= XFER_UDMA_0) {
> > @@ -168,7 +182,13 @@ static void cs5536_set_dmamode(struct at
> >   		etc |= udma_timings[mode - XFER_UDMA_0]<<  dshift;
> >   	} else { /* MWDMA */
> >   		etc&= ~(IDE_ETC_UDMA_MASK<<  dshift);
> > +#ifndef __IDE2LIBATA
> >   		cs5536_program_dtc(adev, mwdma_timings[mode - XFER_MW_DMA_0]);
> > +#else
> > +		timings&= IDE_DRV_MASK;
> > +		timings |= mwdma_timings[mode - XFER_MW_DMA_0]<<  8;
> > +		ide_set_drivedata(adev, (void *)timings);
> > +#endif
> >   	}
> >
> >   	cs5536_write(pdev, ETC, etc);
> 
> Wow, that's really turning into a rat's nest of ifdefs, isn't it?

I'm sorry to say it but this is missing the point entirely.

With such ifdefs around I'm finally able to see some still remaining to
be fixed libata PATA issues (BTW work on ide2libata is what allowed me to
quickly do previous "PATA fixes" and "more PATA fixes" patchsets).

i.e. I can see that pata_cs5536 still needs to be fixed to handle non-matching
PIO/MWDMA timings (pata_ali.h patch is even better example of the concept).

[ As added bonus I'm cutting LOC and enabling possibility of sharing testing
  efforts for much of IDE/libata low-level code ('"leave it alone" stability
  promise of an old-IDE' is a wishful thinking anyway given that whole kernel
  evolves, not to even mention that it is completely unnecessary as we have
  much better stability promise in distributions that need it -- they are
  simply using much older kernel version (i.e. RHEL). ]

In reality I'm doing a long overdue work that should have been done four yours
ago before commit 669a5db got merged without any review or integration work
being done...

-- 
Bartlomiej Zolnierkiewicz
