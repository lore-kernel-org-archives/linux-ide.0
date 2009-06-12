From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/9] cmd64x: implement clear_irq() method
Date: Fri, 12 Jun 2009 21:38:02 +0200
Message-ID: <200906122138.02533.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906122101.14520.bzolnier@gmail.com> <4A32A8E5.4070000@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:43178 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581AbZFLTco (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jun 2009 15:32:44 -0400
Received: by bwz9 with SMTP id 9so2287590bwz.37
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2009 12:32:45 -0700 (PDT)
In-Reply-To: <4A32A8E5.4070000@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 12 June 2009 21:13:41 Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>> Convert the driver's two dma_end() methods into clear_irq() methods -- the
> >>>> driver will now use the standard dma_end() method implementation, ide_dma_end().
> >>>>
> >>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> >>>>
> >>>> ---
> >>>> The patch is atop of ide-2.6.git 'for-next' branch.
> >>>>
> >>>>  drivers/ide/cmd64x.c |   31 +++++++++++++++++--------------
> >>>>  1 files changed, 17 insertions(+), 14 deletions(-)
> >>>>     
> >>>>         
> >>> [...]
> >>>   
> >>>       
> >>>> @@ -226,11 +226,10 @@ static void cmd64x_set_dma_mode(ide_driv
> >>>>  		(void) pci_write_config_byte(dev, pciU, regU);
> >>>>  }
> >>>>  
> >>>> -static int cmd648_dma_end(ide_drive_t *drive)
> >>>> +static void cmd648_clear_irq(ide_drive_t *drive)
> >>>>  {
> >>>>  	ide_hwif_t *hwif	= drive->hwif;
> >>>>  	unsigned long base	= hwif->dma_base - (hwif->channel * 8);
> >>>>     
> >>>>         
> >>> Don't we need to check whether hwif->dma_base is valid now?
> >>>   
> >>>       
> >>    You're right, I have managed to overlook this. I'll change this to 
> >> pci_resource_start() call instead...
> >>     
> >
> > Currently this driver should operate fine without BAR4 set so even if
> > this is pci_resource_start(), the return value still needs to be checked
> > against 0 -- it is the reliability/maintainability issue.
> >   
> 
>    Nay, the PCI device just must not be enabled in this case: all BARs 
> must be allocated, period -- that's what the PCI specs say, IIRC. 
> Besides, 0 doesn't generally mean "unassigned" in the PCI world.
> I know, I know, we consider it unallocated but that's not correct -- 
> only PCI 2.2 (IIRC) used to have words about 0 meaning "unassigned". 

What matters here is our Linux PCI stack implementation not the spec,
and historically it allowed use of not fully setup (because of some
weird/broken BIOSes) PCI devices -- though this may no longer be the
case..

> Note that we don't check pci_resource_start() result for 0 in the 
> drivers that do call it, like hpt366.c... I'm seeing the checks in 
> pdc202xx_*.c but they seem pretty useless -- this just must not happen. 

Care to remove them while we are at it?
