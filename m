From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: remove broken SW/MW DMA support
Date: Fri, 16 Feb 2007 17:23:10 +0100
Message-ID: <200702161723.10858.bzolnier@gmail.com>
References: <200702080858.l188wjmG008432@harpo.it.uu.se> <200702161629.40884.bzolnier@gmail.com> <45D5CEEC.4050706@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:60019 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945976AbXBPQRV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 11:17:21 -0500
Received: by wr-out-0506.google.com with SMTP id i31so1157709wra
        for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 08:17:20 -0800 (PST)
In-Reply-To: <45D5CEEC.4050706@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org


On Friday 16 February 2007 16:34, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>>>>>Remove the bogus code pretending to set SW/MW DMA timings -- I wonder whether
> >>>>>>>its author really thought that he could achieve that wrtiting to BMIDE status
> >>>>>>>registers?  Stop fiddling with the DMA capable bits in the speedproc() -- they
> >>>>>>>do not enable DMA, and are properly dealt with by the dma_host_{on,off} methods;
> >>>>>>>also, get rid of the duplicate reads/writes of UDIDETCRx registers, and do some
> >>>>>>>coding style and whitespace changes while at it...
> >>
> >>>>>>>Unfortunately, fixing the SW/MW DMA support would requre a major driver rewrite
> >>>>>>>along with some more fixing, so I'm putting it off...
> >>
> >>>>>>>Warning: this has been compile-tested only.
> >>
> >>>>>>Worked fine on my SPARC Ultra5.
> >>
> >>>>>Correction: I was only looking for absence of errors when testing
> >>>>>this patch. However, later I found that this patch (version 1.42
> >>>>>of cmd64x.c) disabled DMA on my CMD646, dropping performance to
> >>>>>1/4th (from about 13MB/s to about 3.5MB/s according to hdparm -Tt).
> >>
> >>>>   That was expected behavior.
> >>
> >>>>>Here's the relevant kernel messages from before this patch:
> >>
> >>>>>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> >>>>>CMD646: IDE controller at PCI slot 0000:01:03.0
> >>>>>CMD646: chipset revision 3
> >>>>>CMD646: chipset revision 0x03, MultiWord DMA Force Limited
> >>
> >>>>   The driver never supported UltraDMA on this revision, as indicated by that 
> >>>>message.
> >>
> >>>>>CMD646: 100% native mode on irq 14
> >>>>>   ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027, BIOS settings: hda:pio, hdb:pio
> >>>>>   ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f, BIOS settings: hdc:pio, hdd:pio
> >>>>>Probing IDE interface ide0...
> >>>>>hda: ST320420A, ATA DISK drive
> >>>>>ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14
> >>>>>Probing IDE interface ide1...
> >>>>>hdc: CRD-8483B, ATAPI CD/DVD-ROM drive
> >>>>>ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 14 (shared with ide0)
> >>>>>hda: max request size: 128KiB
> >>>>>hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63, (U)DMA
> >>>>>hda: cache flushes not supported
> >>>>>hda: hda1 hda2 hda3 hda4 hda5
> >>
> >>>>>With the patch the kernel messages are the same, except for the
> >>>>>3rd last line which becomes:
> >>
> >>>>>hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63
> >>
> >>>>>i.e., the (U)DMA indicator is gone.
> >>
> >>>>>Please revert this until the regression is fixed.
> >>
> >>>>   The intent of the patch was exactly to *remove* broken DMA support until 
> >>>>it's fixed (which requires more work).  It only worked by chance -- because 
> >>>>MWDMA2 timings are the same as of PIO4.  Have patience please.
> >>
> >>>It only worked by chance but it _worked_, especially for the usual case,
> >>>MWDMA2/PIO4 == all newer drives (despite writing 0x10 reserved bit of
> >>>BMIDESR0/1 for the master devices).  I think I'll remove the patch for now.
> 
> >>    Then I will protest. :-) This was *not* fixable all at once. And removing 
> >>it just because some users happen to have the *known buggy* (and so reduced to 
> >>MWDMA only) chips is a wrong thing to do.
> 
>     PCI0643 would also suffer, to be precise.
> 
> > OK, I'm not removing it but it needs (rather urgent) fixing.
> 
> >>>To fix SWDMA/MWDMA properly isn't it enough to just call cmd64x_tune_pio()
> >>>from cmd64x_tune_chipset() to tune the corresponding PIO mode?
> 
> >>    No, that wouldn't be a clean fix, just a kind of workaround -- it will 
> >>also change the address setup times (which is not quite desirable).  I can 
> 
> > I see, how about:
> 
> > * splitting off setup timing programming from program_drive_counts()
> >   into separate function (setup timing is programmed into separate register)
> 
>     Yes, it's on my todo list. But consider the amount of cleanup work I had 
> to do (and have in drafts still) for 2.6.21-rc1 -- if it really gets there 
> :-).  And also, consider that currently I have a plenty of internal bugs to 
> fix besides IDE (and they're not as obvious as IDE ones).
> 
> > * pushing ide_get_best_pio_mode() call to higher layers
> >   [ cmd64x_tune_driver() only, it is not needed in cmd64x_tune_chipset() ]
> 
>     Ehm, is it really there?  I thought I left it in cmd64x_tune_pio() where 
> it's on its right place...

Yes, it is still there - I meant pushing it up to avoid programming setup
time when programming timings for DMA modes.

> > * calling new function setting setup timing from cmd64x_tune_drive()
> >   and cmd64x_tune_chipset() (here for PIO modes only)
> 
>    I ceratainly don't want to put this into cmd64x_tune_chipset() -- this 
> should be handled in cmd64x_tune_pio() still.
> 
> > * calling cmd64x_tune_pio() fro SWDMA/MWDMA
> 
>     Erm? Putting time-to-cycle converion into program_drive_counts() sound 
> like a better plan.

agreed

> > Would the above assembly into the proper SWDMA/MWDMA fix?
> 
>     Not all items did make sense to me, sorry. :-)
> 
> >>compose such quickie in five minutes though.
> 
> > I can wait some time for the proper fix but if you see that
> > it won't happen soon (week?) please send me this workaround.
> 
>     I think it will happen in a week.

OK.

Thanks,
Bart
