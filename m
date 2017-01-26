From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Thu, 26 Jan 2017 19:47:48 +1100 (AEDT)
Message-ID: <alpine.LNX.2.00.1701261944160.23370@nippy.intranet>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com> <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com> <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com> <3939493.HXZ6C33pKV@amdc3058>
 <CAOmrzkJfQu6PuCpyyRJL8PNvSYxYO42F-k8jEYf2d1-5C28A_A@mail.gmail.com> <alpine.LNX.2.00.1701111053340.22260@nippy.intranet> <c55cb48c-7200-9577-974b-3c080e141907@gmail.com> <alpine.LNX.2.00.1701151046500.352@nippy.intranet> <a637f52e-d70a-4b10-3998-9db5c2534d83@gmail.com>
 <alpine.LNX.2.00.1701151541230.7981@nippy.intranet> <b1b409e0-9243-83a6-8379-50f933c97477@gmail.com> <alpine.LNX.2.00.1701211805050.18276@nippy.intranet> <1585626b-5642-3e42-2d40-52fae49c9e59@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:44252 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbdAZIqh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2017 03:46:37 -0500
In-Reply-To: <1585626b-5642-3e42-2d40-52fae49c9e59@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>


On Mon, 23 Jan 2017, Michael Schmitz wrote:

> 
> Am 21.01.2017 um 20:37 schrieb Finn Thain:
> 
> > 
> > Actually, the fundamental problem you are describing is partly solved. 
> > By polling for DMA completion with local irqs disabled, we mostly 
> > avoid the need for the stdma.c "lock" because FDC/SCSI/IDE interrupt 
> > handlers can never interfere with a FDC/SCSI DMA process that might be 
> > underway.
> 
> I hadn't considered that. Can PDMA for Falcon SCSI coexist with 
> interrupt-using DMA for TT SCSI in the same driver (i.e. as runtime 
> options)?

Sure, why not?

> How much overhead and latency would polling for DMA completion add?
> 

A polled DMA transfer should be faster than PDMA (i.e. mac_scsi, g_NCR5380 
etc). mac_scsi gets about 0.5 MBps from PDMA with sg_tablesize == 1, and I 
hope that DMA could get twice that (notwithstanding dumb hardware design). 

This would imply CPU overhead that is half of that which mac_scsi incurs. 
That's the best case, but I see no reason to expect worse performance than 
PDMA gets.

> atari_irq_pending(IRQ_MFP_FSCSI) should show the interrupt pending 
> condition if you want to poll for it.

The difficulty will be arranging for disabled FDC & IDE interrupt sources 
during SCSI DMA, and disabled SCSI & IDE interrupt sources during FDC DMA. 
(Not all 5380 interrupts can be disabled; no idea about the IDE device or 
WD1772 FDC.)

But if that is impossible, we just have to detect the short DMA that might 
result from an undesired interrupt.

> That's actually given me another idea to pursue - if we can ensure the 
> IDE interrupt handler is always run first,

There are no interrupts from the ATA driver you're testing, right? If you 
would re-introduce them, the whole polled DMA idea is moot.

> and check whether the interrupt is still pending when the SCSI or floppy 
> interrupt handler runs and DMA has been in progress, we should be able 
> to avoid calling the respective handlers unnecessarily.
> 
> (The output of atari_irq_pending() does not directly reflect the status 
> of the MFP IRQ inputs - that would require testing bits in 
> st_mfp.par_dt_reg instead. )
> 
> > I don't think the IDE/ATA driver needs to be included. atari_scsi and 
> > ataflop would though (if both drivers need DMA transfers).
> 
> If we manage to separate interrupt sharing from DMA access locking, IDE 
> would not need to take part in the locking. I'm assuming that IDE can 
> cope with spurious interrupts and won't get confused by a SCSI 
> interrupt.
> 

The ATA driver will never have to cope with a spurious interrupt under my 
simplifying assumptions discussed earlier, so the spurious interrupt 
question seems to belong to some alternative approach...

> I think it could work both ways - polling for DMA completion or avoiding 
> to call the SCSI interrupt handler the interrupt was caused by IDE only. 
> But it's indeed time to put that to the test.
> 

... "Both ways"? I don't follow. I don't see how IDE can share the FDC and 
SCSI interrupt line without sharing the stdma.c locking scheme. What is 
the alternative approach (i.e not polled DMA) that you alude to?

-- 
