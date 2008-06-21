From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 04/18] ide: remove ide_setup_dma()
Date: Sat, 21 Jun 2008 21:06:03 +0200
Message-ID: <200806212106.03484.bzolnier@gmail.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <20080620213350.13202.73557.sendpatchset@localhost.localdomain> <485C2924.7040905@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:56041 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbYFUTWM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Jun 2008 15:22:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so410881and.103
        for <linux-ide@vger.kernel.org>; Sat, 21 Jun 2008 12:22:11 -0700 (PDT)
In-Reply-To: <485C2924.7040905@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 21 June 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > Export sff_dma_ops and then remove ide_setup_dma().
> >
> > There should be no functional changes caused by this patch.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >
> >   
> [...]
> > Index: b/drivers/ide/arm/palm_bk3710.c
> > ===================================================================
> > --- a/drivers/ide/arm/palm_bk3710.c
> > +++ b/drivers/ide/arm/palm_bk3710.c
> > @@ -318,15 +318,14 @@ static u8 __devinit palm_bk3710_cable_de
> >  static int __devinit palm_bk3710_init_dma(ide_hwif_t *hwif,
> >  					  const struct ide_port_info *d)
> >  {
> > -	unsigned long base =
> > -		hwif->io_ports.data_addr - IDE_PALM_ATA_PRI_REG_OFFSET;
> > -
> >  	printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
> >  
> >  	if (ide_allocate_dma_engine(hwif))
> >  		return -1;
> >  
> > -	ide_setup_dma(hwif, base);
> > +	hwif->dma_base = hwif->io_ports.data_addr - IDE_PALM_ATA_PRI_REG_OFFSET;
> >   
> 
>    That's er... too complex. Actually, 'base' has the value for 
> 'dma_base' at that moment...

Well, the above place is the only user of 'base' so isn't the variable
kind of superfluous?

Thanks,
Bart
