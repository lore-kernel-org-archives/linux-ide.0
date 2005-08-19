From: Jens Axboe <axboe@suse.de>
Subject: Re: Why toggle_bounce only for disks?
Date: Fri, 19 Aug 2005 12:21:33 +0200
Message-ID: <20050819102132.GM6273@suse.de>
References: <20050806235615.GK3505@roadwarrior.mcmartin.ca> <58cb370e05081903073d9a2b73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:432 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932615AbVHSKTN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Aug 2005 06:19:13 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e05081903073d9a2b73@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Kyle McMartin <kyle@parisc-linux.org>, linux-ide@vger.kernel.org, parisc-linux@lists.parisc-linux.org

On Fri, Aug 19 2005, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0209.1/1074.html
> 
> Jens, is this still true??

It is, ide-cd would require changes to accept highmem pages.

> > Ahoi,
> > 
> > The following patch fixes a crash caused by attempting to bounce buffer
> > when an IDE CD-ROM is used on a machine with an IO-MMU. [At least, this
> > patch fixes things so I can use my IDE CD-ROM behind an ns87415 on a
> > HP PA-RISC workstation.]
> > 
> > Why was this only allowed for disks?

Because not bouncing is a performance optimization and I only did the
work on ide-cd to allow it. Your patch breaks ide-cd on highmem i386
machines, so it's not acceptable.

Tells us more about this crash instead, I'm pretty sure you are working
around another issue (your io-mmu code, is it hardware or software?)
somehwere with this patch.


> > --- a/drivers/ide/ide-lib.c   18 Jul 2005 18:46:30 -0000
> > +++ b/drivers/ide/ide-lib.c   6 Aug 2005 20:28:04 -0000
> > @@ -410,7 +410,7 @@ void ide_toggle_bounce(ide_drive_t *driv
> >  {
> >         u64 addr = BLK_BOUNCE_HIGH;     /* dma64_addr_t */
> > 
> > -       if (on && drive->media == ide_disk) {
> > +       if (on) {
> >                 if (!PCI_DMA_BUS_IS_PHYS)
> >                         addr = BLK_BOUNCE_ANY;
> >                 else if (HWIF(drive)->pci_dev)
> > 
> > Cheers,
> > --
> > Kyle McMartin
> 

-- 
Jens Axboe

