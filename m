From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/9] cmd64x: implement clear_irq() method
Date: Fri, 12 Jun 2009 21:01:14 +0200
Message-ID: <200906122101.14520.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906121816.58809.bzolnier@gmail.com> <4A32A0F7.3020101@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f216.google.com ([209.85.220.216]:50612 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbZFLSzz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jun 2009 14:55:55 -0400
Received: by fxm12 with SMTP id 12so822178fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2009 11:55:56 -0700 (PDT)
In-Reply-To: <4A32A0F7.3020101@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 12 June 2009 20:39:51 Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Hi Sergei,
> >
> > This is a very nice series 
> 
>    Oh, I'm flattened. :-)
> 
> > and I would like to apply it immediately
> > but unfortunately there is quite a few issues to be addressed first..
> >   
> 
>    Sigh, it's a pity -- I'm now on vacation and won't be available since 
> this Sunday... I should have posted it earlier of course. Will have to 
> try to address your comments tomorrow then.
> 
> >> Convert the driver's two dma_end() methods into clear_irq() methods -- the
> >> driver will now use the standard dma_end() method implementation, ide_dma_end().
> >>
> >> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> >>
> >> ---
> >> The patch is atop of ide-2.6.git 'for-next' branch.
> >>
> >>  drivers/ide/cmd64x.c |   31 +++++++++++++++++--------------
> >>  1 files changed, 17 insertions(+), 14 deletions(-)
> >>     
> >
> > [...]
> >   
> >> @@ -226,11 +226,10 @@ static void cmd64x_set_dma_mode(ide_driv
> >>  		(void) pci_write_config_byte(dev, pciU, regU);
> >>  }
> >>  
> >> -static int cmd648_dma_end(ide_drive_t *drive)
> >> +static void cmd648_clear_irq(ide_drive_t *drive)
> >>  {
> >>  	ide_hwif_t *hwif	= drive->hwif;
> >>  	unsigned long base	= hwif->dma_base - (hwif->channel * 8);
> >>     
> >
> > Don't we need to check whether hwif->dma_base is valid now?
> >   
> 
>    You're right, I have managed to overlook this. I'll change this to 
> pci_resource_start() call instead...

Currently this driver should operate fine without BAR4 set so even if
this is pci_resource_start(), the return value still needs to be checked
against 0 -- it is the reliability/maintainability issue.

> > Also shouldn't this patch be done after fixing core code first?
> >   
> 
>    Fixing what exactly, ide_timer_expiry()?

Yes.  Currently IRQ is cleared in ide_timer_expiry()'s code-path:

 -> hwif->handler [ ide_dma_intr() ]
     -> dma_ops->dma_end [ cmd64{x,8}_dma_end() ]

After this patch it won't be.
