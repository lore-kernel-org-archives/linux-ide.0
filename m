From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 01/18] ide: add ->read_sff_dma_status method
Date: Wed, 3 Sep 2008 20:13:08 +0200
Message-ID: <200809032013.08489.bzolnier@gmail.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <48BE8EFD.70103@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756611AbYICSQ2@vger.kernel.org>
In-Reply-To: <48BE8EFD.70103@ru.mvista.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On Wednesday 03 September 2008, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Add ->read_sff_dma_status method for reading DMA Status register
> > and use it instead of ->INB.
> 
> > While at it:
> 
> > * Use inb() directly in ns87415.c::ns87415_dma_end().
> 
> > There should be no functional changes caused by this patch.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/ide-iops.c
> > ===================================================================
> > --- a/drivers/ide/ide-iops.c
> > +++ b/drivers/ide/ide-iops.c
> > @@ -103,6 +103,14 @@ void SELECT_MASK(ide_drive_t *drive, int
> >  		port_ops->maskproc(drive, mask);
> >  }
> >  
> > +static u8 ide_read_sff_dma_status(ide_hwif_t *hwif)
> > +{
> > +	if (hwif->host_flags & IDE_HFLAG_MMIO)
> > +		return readb((void __iomem *)hwif->dma_status);
> > +	else
> > +		return inb(hwif->dma_status);
> > +}
> > +
> 
>     It's probably too late to object now (and I've been busy before) but I 
> don't understand how reading DMA status ended up here ISO ide-dma.c...
> 
> >  static void ide_tf_load(ide_drive_t *drive, ide_task_t *task)
> >  {
> >  	ide_hwif_t *hwif = drive->hwif;
> > @@ -323,6 +331,8 @@ static void ata_output_data(ide_drive_t 
> >  
> >  void default_hwif_transport(ide_hwif_t *hwif)
> >  {
> > +	hwif->read_sff_dma_status = ide_read_sff_dma_status;
> > +
> >  	hwif->tf_load	  = ide_tf_load;
> >  	hwif->tf_read	  = ide_tf_read;
> 
>     I also didn't understand the motivation behind putting this method 
> together with the transport operations... IMO, DMA programming interface 
> hardly has anything to do with transporting the data over IDE bus.

The motivation was that hwif->dma_ops is not available yet when
->read_sff_dma_status is used in ide_pci_check_simplex().

However I agree that it should somehow find its way into ->dma_ops
(as usual patches are stongly preffered :).

Thanks,
Bart
