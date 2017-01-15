From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Sun, 15 Jan 2017 15:42:56 +1100 (AEDT)
Message-ID: <alpine.LNX.2.00.1701151541230.7981@nippy.intranet>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com> <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com> <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com> <3939493.HXZ6C33pKV@amdc3058>
 <CAOmrzkJfQu6PuCpyyRJL8PNvSYxYO42F-k8jEYf2d1-5C28A_A@mail.gmail.com> <alpine.LNX.2.00.1701111053340.22260@nippy.intranet> <c55cb48c-7200-9577-974b-3c080e141907@gmail.com> <alpine.LNX.2.00.1701151046500.352@nippy.intranet>
 <a637f52e-d70a-4b10-3998-9db5c2534d83@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:38936 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdAOEl4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jan 2017 23:41:56 -0500
In-Reply-To: <a637f52e-d70a-4b10-3998-9db5c2534d83@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>


On Sun, 15 Jan 2017, Michael Schmitz wrote:

> Am 15.01.2017 um 12:47 schrieb Finn Thain:
> 
> > For the sake of discussion, I'll assume that the FDC driver will not 
> > be using DMA. (Perhaps FDC and SCSI can share the ST-DMA chip, using 
> > the present locking mechanism, but it would not simplify things much: 
> > when IDE no longer participates in that locking mechanism then both 
> > FDC and SCSI drivers have to solve the same issues.)
> 
> Correct - IIRC the FDC registers are also accessible 'through' the 
> ST-DMA registers only so the same problem WRT DMA status arises.
> 

I had not considered that limitation.

> > What compiler are you using, BTW? Are you still using the gcc-4.6.3 
> > m68k cross-compiler from kernel.org? I had to abandon it in order to 
> > get my SCSI driver patches to work.
> 
> 4.6.3 is the version I still use. You had trouble with that one? I 
> recall some discussion on gcc versions on the m68k list a while back, 
> just never seemed to see any problems...
> 

... none that could be easily blamed on the compiler, anyway.

The gcc 4.6.3 issue affecting my builds was discussed back in 
November. There are alternative compilers available:
http://marc.info/?l=linux-m68k&m=147859596303294&w=2
http://marc.info/?l=linux-m68k&m=147859567903210&w=2

> >> I need to think about that some more - if no DMA is in progress we 
> >> can safely peek at the SCSI registers. So the logic could be changed 
> >> to test for DMA operation first, and just try and service the 
> >> interrupt if DMA wasn't active.
> >> 
> > 
> > OK, so based on the above, we handle the possible IDE interrupt 
> > (without checking DMA registers), handle the possible FDC interrupt 
> > (again without checking DMA registers) and finally handle the possible 
> > SCSI interrupt.
> 
> No, we can't check either FDC or SCSI interrupts (or indeed any chip 
> registers) without touching the ST-DMA. The moment we select a FDC or 
> SCSI register for read, DMA is terminated no questions asked.
> 

Perhaps we can convert DMA operations to PDMA (by polling with local irqs 
disabled) and avoid the whole problem of interrupt handlers executing 
during DMA transfers. The docs suggest that it is doable.

"Poll or service the Disk Driver Controller interrupt on the MK68901 MFP 
General Purpose I/O Register to detect the completion of a WD1772 FDC 
command. Do not poll the FDC Busy or DMA Sector Count Zero status bits." 
-- ST HW Spec, p. 36.
http://dev-docs.atariforge.org/files/ST_HW_Spec_1-7-1986.pdf

On page 18 there is an algorithm for floppy writes which is interesting.

I suspect that we will need to keep the FDC idle during SCSI transfers 
(and vice versa) much as the present stdma.c lock does.

"The interrupt outputs of the internal floppy disk controller and the 
external ACSI DMA port are logically OR'ed. The pin of the MFP GPIP will 
read as a '0' if either the FDC or a selected ACSI device controller is 
asserting its interrupt request."
-- ACSI/DMA Integration Guide, p.16.
http://dev-docs.atariforge.org/files/ACSI_DMA_Guide_6-28-1991.pdf

Polling the logically OR'ed interrupt sources to detect end-of-DMA will 
not be reliable unless we disable those sources that aren't relevant. 
Otherwise we access the DMA registers too early (which IIUC would kill the 
transfer). I'm afraid we shall have to expect that a few transfers will be 
interrupted by other devices in this way, and carefully check for this. 

For example, the 5380 SCSI bus reset interrupt is not maskable, which 
could affect FDC transfers. If this terminated the polling for DMA 
completion, the FDC driver then has to access the FDC registers and 
confirm that the transfer was not terminated early.

-- 
