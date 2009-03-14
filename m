From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 03/10] ide: destroy DMA mappings after ending DMA
Date: Sat, 14 Mar 2009 20:51:57 +0100
Message-ID: <200903142051.57971.bzolnier@gmail.com>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain> <20090220171201.25429.29473.sendpatchset@localhost.localdomain> <da824cf30903140012g1565696kd6c69b4cd513f15b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f175.google.com ([209.85.218.175]:63554 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454AbZCNTuS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:50:18 -0400
In-Reply-To: <da824cf30903140012g1565696kd6c69b4cd513f15b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Saturday 14 March 2009, Grant Grundler wrote:
> On Fri, Feb 20, 2009 at 6:12 PM, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: destroy DMA mappings after ending DMA
> >
> > Move ide_destroy_dmatable() call out from ->dma_end method to
> > {ide_pc,cdrom_newpc,ide_dma}_intr(), ide_dma_timeout_retry()
> > and sgiioc4_resetproc().
> ...
> > --- a/drivers/ide/ide-dma-sff.c
> > +++ b/drivers/ide/ide-dma-sff.c
> > @@ -310,8 +310,6 @@ int ide_dma_end(ide_drive_t *drive)
> >        /* clear INTR & ERROR bits */
> >        ide_dma_sff_write_status(hwif, dma_stat | ATA_DMA_ERR | ATA_DMA_INTR);
> >
> > -       /* purge DMA mappings */
> > -       ide_destroy_dmatable(drive);
> >        wmb();
> 
> Bartlomiej,
> I think the wmb() could removed as well. The outb/writeb functions are
> required to be strongly ordered and I don't see anything else touching
> DMA-able memory here.

Indeed.  IIRC this code precedes the requeirement for outb/writeb to be
strongly ordered.

Seems like wmb() in ide_dma_start() is also superfluous nowadays...

> BTW, care to remove "mask" usage from this function?
> It's really not needed (can be replaced with #define).

Feel free to remove it. :)

> I can create separate patches for both. Which git tree should I base
> them against?

linux-next git tree
(or pata-2.6 quilt tree)

> ...
> > --- a/drivers/ide/scc_pata.c
> > +++ b/drivers/ide/scc_pata.c
> > @@ -365,8 +365,6 @@ static int __scc_dma_end(ide_drive_t *dr
> >        dma_stat = scc_dma_sff_read_status(hwif);
> >        /* clear the INTR & ERROR bits */
> >        scc_ide_outb(dma_stat | 6, hwif->dma_base + 4);
> > -       /* purge DMA mappings */
> > -       ide_destroy_dmatable(drive);
> >        /* verify good DMA status */
> >        wmb();
> 
> I think this wmb() can be removed too.
> 
> ....
> > --- a/drivers/ide/tx4939ide.c
> > +++ b/drivers/ide/tx4939ide.c
> > @@ -335,11 +335,9 @@ static int tx4939ide_dma_end(ide_drive_t
> >        /* read and clear the INTR & ERROR bits */
> >        dma_stat = tx4939ide_clear_dma_status(base);
> >
> > -       /* purge DMA mappings */
> > -       ide_destroy_dmatable(drive);
> > -       /* verify good DMA status */
> >        wmb();
> 
> and this one as well.

Seems so but please cc: scc_pata & tx4939 maintainers on your patch.

Thanks,
Bart
