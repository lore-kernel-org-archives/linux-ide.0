From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/11] au1xxx-ide: use ide_tune_dma()
Date: Thu, 9 Aug 2007 00:57:13 +0200
Message-ID: <200708090057.13155.bzolnier@gmail.com>
References: <200708042206.57529.bzolnier@gmail.com> <46B764EF.9000506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:15926 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762853AbXHHW6M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 18:58:12 -0400
Received: by nf-out-0910.google.com with SMTP id g13so83223nfb
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 15:58:11 -0700 (PDT)
In-Reply-To: <46B764EF.9000506@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 06 August 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>     Good, that's what I lacked for hpt366.c!  Were you planning to push it to 
> Linus soon?

Not really but if needed I will extract MWDMA filter part and push it sooner.

> > * Add ->mdma_filter to ide_hwif_t and use it in ide_get_mode_mask().
> 
>     Hm, why not mwdma_filter()?  That "mdma" word has unneeded connotation. ;-)

Ha!  As predicted:

->mdma_filter name would make people more ecstatic about the code

;)

> > * Remove needless setting of drive->using_dma from auide_dma_check().
> 
> > * Split off auide_mdma_filter() from auide_dma_check().
> 
> > * Use ide_tune_dma() in auide_dma_check(), this fixes following issues:
> >   - device's DMA capability bit not being checked
> >   - device not being checked against generic DMA blacklist
> >   - transfer mode not being set on device/host
> 
> > * Add PIO autotune fallback to auide_dma_check().
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/mips/au1xxx-ide.c
> > ===================================================================
> > --- a/drivers/ide/mips/au1xxx-ide.c
> > +++ b/drivers/ide/mips/au1xxx-ide.c
> > @@ -351,11 +351,18 @@ static int auide_dma_setup(ide_drive_t *
> >  	return 0;
> >  }
> >  
> > -static int auide_dma_check(ide_drive_t *drive)
> > +static u8 auide_mdma_filter(ide_drive_t *drive)
> >  {
> > -	u8 speed = ide_max_dma_mode(drive);
> > +	/*
> > +	 * FIXME: ->white_list and ->black_list are based on completely bogus
> > +	 * ->ide_dma_check implementation which didn't set neither the host
> > +	 * controller timings nor the device for the desired transfer mode.
> > +	 *
> > +	 * They should be either removed or 0x00 MWDMA mask should be
> > +	 * returned for devices on the ->black_list.
> > +	 */
> 
>     I don't get it -- why then introduce a method that does nothing?

It does something as you've noticed yourself:

> > -	if( dbdma_init_done == 0 ){
> > +	if (dbdma_init_done == 0) {
> 
>     I wonder what this code is doing here at all...
> 
> >  		auide_hwif.white_list = ide_in_drive_list(drive->id,
> >  							  dma_white_list);
> >  		auide_hwif.black_list = ide_in_drive_list(drive->id,
> 
>     Why the results of the drive list lockup gets tied to auide_hwif? :-O

To use results in auide_ddma_init()...  (which needs fixing of course).

The more interesting questions are: WTF is "safe MWDMA" mode (tsize == 1,
devwidth == 16) and whether ->white/black_list is really needed.

I planned to cc: AU1XXX platform maintainers on this patch but to my
surprise MAINTAINERS lacks AU1XXX entry.

Bart
