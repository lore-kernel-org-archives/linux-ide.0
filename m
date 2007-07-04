From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: add ide_set{_max}_pio() (take 2)
Date: Wed, 4 Jul 2007 21:51:01 +0200
Message-ID: <200707042151.01937.bzolnier@gmail.com>
References: <200707010046.15532.bzolnier@gmail.com> <200707040040.33812.bzolnier@gmail.com> <468BDEFF.5080709@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:64048 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757249AbXGDTeH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 15:34:07 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3337603mue
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 12:34:04 -0700 (PDT)
In-Reply-To: <468BDEFF.5080709@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 04 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>  reporting PIO mode selected from ->tuneproc implementations.
> 
> >>>* Rename ->tuneproc hook to ->set_pio_mode
> 
> >>    Well, tuneproc() went with speedproc() rather well. :-)
> 
> > ->set_pio_mode goes better with ->set_dma_mode ;-)
> 
>     Ah, good to know where we're moving... :-)
> 
> >>>and make 'pio' argument const.
> 
> >>    Isn't it too strict, const value argument?
> 
> > Not really, this is to prevent potential mistakes and catch them early.
> 
> > Please note that this patch pushes all logic dealing with finding the best
> > PIO mode and also limiting PIO mode passed by the user from ->tuneproc
> > to the core code.  Another logical step is to move ide_rate_filter() out
> > of ->speedproc to the core code (fixing ide_rate_filter() while at it)
> > and this step is alsmost done (I will post patch soon).
> 
>     Too many patches recently. :-)

There is never too many patches!

Only too little time... :-)

> > After ide_rate_filter() change is done we can start syncing code setting
> > PIO modes in ->set_pio_mode and ->speedproc (there are some suspicious
> > disrepancies in some drivers besides the usual bug of not setting transfer
> > mode on the device in ->tuneproc).  Finally we can switch the core code to
> > just use ->set_pio_mode for PIO modes and turn ->speedproc into new shiny
> > ->set_dma_mode method.
> 
> >>>* Remove stale comment from ide_config_drive_speed().
> 
> >>    Hm, the next logical step would be to remove a call to 
> >>ide_config_drive_speed() from the set_pio_mode() handler, wouldn't it?..
> 
> > Yes.
> 
>     Again, good to know. Too bad that these cleanups haven't happened until 

They were not possible before some massive bugfixing/rewritting of host
drivers and still wouldn't be possible if you didn't take care of some of
the worst (== most complicated ones) offenders like hpt366, sl82c105, etc.

Also some Alan's libata PATA changes were a great help.  Maybe except the
fact that the changes needed to be reverse engineered from the new drivers
(because they lacked any changelog/patchlog) which was a major PITA.

It is to be regretted that help in fixing host drivers didn't come two-three
years ago.  I had complete plan for IDE core rewrite with many changes already
done but I was still lacking some expertise (for some chipsets) and time to do
the needed changes to all host drivers.

> now -- when libata PATA support seems already ripe enough. :-)

libata PATA is quite mature but still lacks support for some popular chipsets
and have regressions for less common hardware so it may take a while.

Not to mention compulsory SCSI-emulation which I just find disgusting... ;-)

> >>>Index: b/drivers/ide/pci/it8213.c
> >>>===================================================================
> >>>--- a/drivers/ide/pci/it8213.c
> >>>+++ b/drivers/ide/pci/it8213.c
> >>>@@ -4,6 +4,8 @@
> >>>  * Copyright (C) 2006 Jack Lee
> >>>  * Copyright (C) 2006 Alan Cox
> >>>  * Copyright (C) 2007 Bartlomiej Zolnierkiewicz
> >>>+ *
> >>>+ * TODO: make ->set_pio_mode method set transfer mode on the device
> 
> >>    IMHO, this actually better be done outside of this method (if possible).
> 
> > In the long-term, yes.
> 
> >>Sigh, that would undo many of my prior fixes...
> 
> > It shouldn't if would be handled exactly as is currently done piix.c.
> 
>     Well, that would turn piix_tune_drive() into completely useless wrapper to 
> piix_tune_pio() -- exactly what I mean.
> 
> > it8213_set_pio_mode() will become a wrapper for it8213_tune_pio().
> 
>     Hm, there are currently no it8213_tune_pio() -- and would be no need for 
> it if we start calling ide_config_drive_speed() outside the set_pio_mode() 
> method...

Yes but iff we do this change before fixup change to add
ide_config_drive_speed() call.

Not a big issue really, the wrapper will disappear sooner than later.

> >>>@@ -193,7 +194,9 @@ static int it8213_tune_chipset (ide_driv
> >>> 		if (reg55 & w_flag)
> >>> 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
> >>> 	}
> >>>-	it8213_tuneproc(drive, it8213_dma_2_pio(speed));
> >>>+
> >>>+	it8213_set_pio_mode(drive, it8213_dma_2_pio(speed));
> >>
> >>    Bleh... Still haven't "divorced" PIO/DMA timings -- need to get this done 
> >>finally. :-/
> 
> > Well, if you would spend some less time nitpicking about CodingStyle... ;-)
> 
>     That's negligible compared to what I'd have to spend on piix.c (and even 
> on finding the real issues with these patches :-).

Do not underestimate yourself. 8)

> >>>@@ -307,10 +306,11 @@ static void pdc202xx_reset (ide_drive_t 
> >>> {
> >>> 	ide_hwif_t *hwif	= HWIF(drive);
> >>> 	ide_hwif_t *mate	= hwif->mate;
> >>>-	
> >>>+
> >>> 	pdc202xx_reset_host(hwif);
> >>> 	pdc202xx_reset_host(mate);
> 
> >>    Bleh... this double reset horror still needs to be sorted out as well. I'm 
> >>not at all sure it's useful -- its assumed purpose is to be able to set MWDMA 
> >>modes after UDMA (can't do this w/o reset).
> 
>     I completely disliked this whole approach and just forbade the downgrade 
> from UDMA to MWDMA in the internal tree... never got to submitting this though.
> 
> >>>-	pdc202xx_tune_drive(drive, 255);
> >>>+
> >>>+	ide_set_max_pio(drive);
> 
> >>    I wonder why the code doesn't retune all 4 drives? :-/
> 
> > Because it is buggy/broken - all drives should be re-tuned but there
> > is no needed locking in the IDE core to achieve this currently.
> 
>     Well, you have the spec... :-)

IIRC there is nothing more in the spec than we know already...

> > take 3
> 
> > [PATCH] ide: add ide_set{_max}_pio() (take 3)
> 
> > * Add IDE_HFLAG_ABUSE_{PREFETCH,FAST_DEVSEL,DMA_MODES} flags
> >   and set them in ht6560, cmd640, cmd64x and sc1200 host drivers.
> 
> > * Add set_pio_mode_abuse() for checking if host driver has a non-standard
> >   ->tuneproc() implementation and use it in do_special().
> 
> > * Add ide_set_pio() for setting PIO mode (it uses hwif->pio_mask to find
> >   the maximum PIO mode supported by the host), also add ide_set_max_pio()
> >   wrapper for ide_set_pio() to use for auto-tuning.  Convert users of
> >   ->tuneproc to use ide_set{_max}_pio() where possible.  This leaves only
> >   do_special(), set_using_pio(), ide_hwif_restore() and ide_set_pio() as
> >   a direct users of ->tuneproc.
> 
> > * Remove no longer needed ide_get_best_pio_mode() calls and printk-s
> >   reporting PIO mode selected from ->tuneproc implementations.
> 
> > * Rename ->tuneproc hook to ->set_pio_mode and make 'pio' argument const.
> 
> > * Remove stale comment from ide_config_drive_speed().
> 
> > v2:
> > * Fix "ata_" prefix (Noticed by Jeff).
> 
> > v3:
> > * Minor cleanups/fixups per Sergei's suggestions.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>     Though some nits haven't been addressed:
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > Index: b/drivers/ide/pci/jmicron.c
> > ===================================================================
> > --- a/drivers/ide/pci/jmicron.c
> > +++ b/drivers/ide/pci/jmicron.c
> > @@ -83,7 +83,7 @@ static u8 __devinit ata66_jmicron(ide_hw
> >  	return ATA_CBL_PATA80;
> >  }
> >  
> > -static void jmicron_tuneproc (ide_drive_t *drive, byte mode_wanted)
> > +static void jmicron_set_pio_mode(ide_drive_t *drive, const u8 pio)
> >  {
> >  	return;
> 
>     I was asking for adding TODO here... :-(

It is a single line fix.

Hint: exactly the number of lines of your reply above. :-)

> > Index: b/drivers/ide/pci/opti621.c
> > ===================================================================
> > --- a/drivers/ide/pci/opti621.c
> > +++ b/drivers/ide/pci/opti621.c
> > @@ -47,7 +47,7 @@
> >   * The main problem with OPTi is that some timings for master
> >   * and slave must be the same. For example, if you have master
> >   * PIO 3 and slave PIO 0, driver have to set some timings of
> > - * master for PIO 0. Second problem is that opti621_tune_drive
> > + * master for PIO 0. Second problem is that opti621_set_pio_mode
> >   * got only one drive to set, but have to set both drives.
> >   * This is solved in compute_pios. If you don't set
> >   * the second drive, compute_pios use ide_get_best_pio_mode
> > @@ -103,7 +103,7 @@
> >  
> >  #include <asm/io.h>
> >  
> > -#define OPTI621_MAX_PIO 3
> > +//#define OPTI621_MAX_PIO 3
> >  /* In fact, I do not have any PIO 4 drive
> >   * (address: 25 ns, data: 70 ns, recovery: 35 ns),
> 
>     PIO4 recovery is 25, not 35 ns. Well, it should only be achievable on 
> non-standard PCI freq's (well, except for 30 MHz probably), so this whole 
> comment may be killed...

Could you send a patch otherwise there is a chance we will forget about it.

Thanks,
Bart
