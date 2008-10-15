From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 09/18] ide: add ->set_irq method
Date: Wed, 15 Oct 2008 20:22:44 +0200
Message-ID: <200810152022.44708.bzolnier@gmail.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <20080620213424.13202.16889.sendpatchset@localhost.localdomain> <48F5DFF7.9010908@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:61913 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbYJOTuO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 15:50:14 -0400
Received: by gv-out-0910.google.com with SMTP id e6so701040gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 12:50:13 -0700 (PDT)
In-Reply-To: <48F5DFF7.9010908@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 15 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Add ->set_irq method for setting nIEN bit of ATA Device Control
> > register and use it instead of ide_set_irq().
> >
> > While at it:
> >
> > * Use ->set_irq in init_irq() and do_reset1().
> >
> > * Don't use HWIF() macro in ide_check_pm_state().
> >
> > There should be no functional changes caused by this patch.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >   
> [...]
> > Index: b/drivers/ide/ide-iops.c
> > ===================================================================
> > --- a/drivers/ide/ide-iops.c
> > +++ b/drivers/ide/ide-iops.c
> > @@ -135,6 +135,23 @@ static u8 ide_read_sff_dma_status(ide_hw
> >  		return inb(hwif->dma_base + ATA_DMA_STATUS);
> >  }
> >  
> > +static void ide_set_irq(ide_hwif_t *hwif, int on)
> > +{
> > +	u8 ctl = ATA_DEVCTL_OBS;
> > +
> > +	if (on == 4) { /* hack for SRST */
> > +		ctl |= 4;
> > +		on &= ~4;
> > +	}
> > +
> > +	ctl |= on ? 0 : 2;
> > +
> > +	if (hwif->host_flags & IDE_HFLAG_MMIO)
> > +		writeb(ctl, (void __iomem *)hwif->io_ports.ctl_addr);
> > +	else
> > +		outb(ctl, hwif->io_ports.ctl_addr);
> > +}
> > +
> >  static void ide_tf_load(ide_drive_t *drive, ide_task_t *task)
> >  {
> >  	ide_hwif_t *hwif = drive->hwif;
> >   
> [...]
> > @@ -1162,16 +1180,15 @@ static ide_startstop_t do_reset1 (ide_dr
> >  	 * immediate interrupt due to the edge transition it produces.
> >  	 * This single interrupt gives us a "fast poll" for drives that
> >  	 * recover from reset very quickly, saving us the first 50ms wait time.
> > +	 *
> > +	 * TODO: add ->softreset method and stop abusing ->set_irq
> >  	 */
> >  	/* set SRST and nIEN */
> > -	hwif->OUTBSYNC(hwif, ATA_DEVCTL_OBS | 6, io_ports->ctl_addr);
> > +	hwif->set_irq(hwif, 4);
> >  	/* more than enough time */
> >  	udelay(10);
> 
>    It seems to me that the whole idea of having 2 separate methods for 
> writing the single device control register is a wrong idea.
> I'm suggesting to convert set_irq() method to write_devctrl() method and 
> pass the register value directly to it.

Makes sense.  Care to make a patch?
