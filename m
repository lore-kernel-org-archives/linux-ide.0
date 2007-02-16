From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: remove broken SW/MW DMA support
Date: Fri, 16 Feb 2007 15:37:37 +0100
Message-ID: <200702161537.37691.bzolnier@gmail.com>
References: <200702080858.l188wjmG008432@harpo.it.uu.se> <17877.33048.23816.692749@alkaid.it.uu.se> <45D5AD8B.1060702@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:47536 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368AbXBPObs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 09:31:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so160871uga
        for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 06:31:47 -0800 (PST)
In-Reply-To: <45D5AD8B.1060702@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org


Hi,

On Friday 16 February 2007 14:11, Sergei Shtylyov wrote:
> Mikael Pettersson wrote:
> > On Thu, 8 Feb 2007 09:58:45 +0100 (MET), Mikael Pettersson wrote:
> > 
> >>On Thu, 8 Feb 2007 00:00:32 +0300, Sergei Shtylyov wrote:
> >>
> >>>Remove the bogus code pretending to set SW/MW DMA timings -- I wonder whether
> >>>its author really thought that he could achieve that wrtiting to BMIDE status
> >>>registers?  Stop fiddling with the DMA capable bits in the speedproc() -- they
> >>>do not enable DMA, and are properly dealt with by the dma_host_{on,off} methods;
> >>>also, get rid of the duplicate reads/writes of UDIDETCRx registers, and do some
> >>>coding style and whitespace changes while at it...
> 
> >>>Unfortunately, fixing the SW/MW DMA support would requre a major driver rewrite
> >>>along with some more fixing, so I'm putting it off...
> 
> >>>Warning: this has been compile-tested only.
> 
> >>Worked fine on my SPARC Ultra5.
> 
> > Correction: I was only looking for absence of errors when testing
> > this patch. However, later I found that this patch (version 1.42
> > of cmd64x.c) disabled DMA on my CMD646, dropping performance to
> > 1/4th (from about 13MB/s to about 3.5MB/s according to hdparm -Tt).
> 
>     That was expected behavior.
> 
> > Here's the relevant kernel messages from before this patch:
> 
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > CMD646: IDE controller at PCI slot 0000:01:03.0
> > CMD646: chipset revision 3
> > CMD646: chipset revision 0x03, MultiWord DMA Force Limited
> 
>     The driver never supported UltraDMA on this revision, as indicated by that 
> message.
> 
> > CMD646: 100% native mode on irq 14
> >     ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027, BIOS settings: hda:pio, hdb:pio
> >     ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f, BIOS settings: hdc:pio, hdd:pio
> > Probing IDE interface ide0...
> > hda: ST320420A, ATA DISK drive
> > ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14
> > Probing IDE interface ide1...
> > hdc: CRD-8483B, ATAPI CD/DVD-ROM drive
> > ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 14 (shared with ide0)
> > hda: max request size: 128KiB
> > hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63, (U)DMA
> > hda: cache flushes not supported
> >  hda: hda1 hda2 hda3 hda4 hda5
> 
> > With the patch the kernel messages are the same, except for the
> > 3rd last line which becomes:
> 
> > hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63
> 
> > i.e., the (U)DMA indicator is gone.
> 
> > Please revert this until the regression is fixed.
> 
>     The intent of the patch was exactly to *remove* broken DMA support until 
> it's fixed (which requires more work).  It only worked by chance -- because 
> MWDMA2 timings are the same as of PIO4.  Have patience please.

It only worked by chance but it _worked_, especially for the usual case,
MWDMA2/PIO4 == all newer drives (despite writing 0x10 reserved bit of
BMIDESR0/1 for the master devices).  I think I'll remove the patch for now.

To fix SWDMA/MWDMA properly isn't it enough to just call cmd64x_tune_pio()
from cmd64x_tune_chipset() to tune the corresponding PIO mode?

Bart
