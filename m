From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 19/19] ide: use PIO/MMIO operations directly where possible
Date: Fri, 12 Jan 2007 15:19:43 +0100
Message-ID: <58cb370e0701120619v27ca51dek48154136e54defd5@mail.gmail.com>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	 <20070112042807.28794.8251.sendpatchset@localhost.localdomain>
	 <20070112100641.02858876@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:37607 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbXALOTp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 09:19:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so793986uga
        for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 06:19:44 -0800 (PST)
In-Reply-To: <20070112100641.02858876@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 1/12/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> On Fri, 12 Jan 2007 05:28:07 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> > [PATCH] ide: use PIO/MMIO operations directly where possible
> >
> > This results in smaller/faster/simpler code and allows future optimizations.
> > Also remove no longer needed ide[_mm]_{inl,outl}() and ide_hwif_t.{INL,OUTL}.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>
> > --- a.orig/drivers/ide/ide-dma.c
> > +++ a/drivers/ide/ide-dma.c
> > @@ -565,7 +565,10 @@ int ide_dma_setup(ide_drive_t *drive)
> >       }
> >
> >       /* PRD table */
> > -     hwif->OUTL(hwif->dmatable_dma, hwif->dma_prdtable);
> > +     if (hwif->mmio == 2)
> > +             writel(hwif->dmatable_dma, (void __iomem *)hwif->dma_prdtable);
> > +     else
> > +             outl(hwif->dmatable_dma, hwif->dma_prdtable);
>
>
> This should simply be if (hwif->mmio)
>
> mmio = 1 is still used by some amiga and other oddments and indicates
> mmio in old form. I don't think this causes a bug as they don't use the
> DMA layer, but its a bug waiting to happen if the mmio==1 case doesn't
> get handled correctly or BUG()

mmio = 1 isn't used in the current IDE code and we have BUG_ON()
for it in ide.c:ide_hwif_request_regions() so the above change is safe.

Anyway thanks for bringing mmio = 1 issue - it can be converted
to flag now (will let us avoid similar confusions in the future).

Bart
