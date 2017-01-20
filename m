From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Fri, 20 Jan 2017 20:49:26 +1300
Message-ID: <b1b409e0-9243-83a6-8379-50f933c97477@gmail.com>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com>
 <3939493.HXZ6C33pKV@amdc3058>
 <CAOmrzkJfQu6PuCpyyRJL8PNvSYxYO42F-k8jEYf2d1-5C28A_A@mail.gmail.com>
 <alpine.LNX.2.00.1701111053340.22260@nippy.intranet>
 <c55cb48c-7200-9577-974b-3c080e141907@gmail.com>
 <alpine.LNX.2.00.1701151046500.352@nippy.intranet>
 <a637f52e-d70a-4b10-3998-9db5c2534d83@gmail.com>
 <alpine.LNX.2.00.1701151541230.7981@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34283 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdATHto (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2017 02:49:44 -0500
In-Reply-To: <alpine.LNX.2.00.1701151541230.7981@nippy.intranet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>

Hi Finn,

Am 15.01.2017 um 17:42 schrieb Finn Thain:

>> No, we can't check either FDC or SCSI interrupts (or indeed any chip 
>> registers) without touching the ST-DMA. The moment we select a FDC or 
>> SCSI register for read, DMA is terminated no questions asked.
>>
> 
> Perhaps we can convert DMA operations to PDMA (by polling with local irqs 
> disabled) and avoid the whole problem of interrupt handlers executing 
> during DMA transfers. The docs suggest that it is doable.
> 
> "Poll or service the Disk Driver Controller interrupt on the MK68901 MFP 
> General Purpose I/O Register to detect the completion of a WD1772 FDC 
> command. Do not poll the FDC Busy or DMA Sector Count Zero status bits." 
> -- ST HW Spec, p. 36.
> http://dev-docs.atariforge.org/files/ST_HW_Spec_1-7-1986.pdf

The MFP interrupt in question is the same as the one used by IDE
(wired-OR of IDE, FDC and SCSI), so we would still have to figure out
where the interrupt originated. Polling instead of taking the interrupt
does not change that fundamental problem (unless I'm missing something).

> 
> On page 18 there is an algorithm for floppy writes which is interesting.

That one (and the ACSI algorithm which would apply to SCSI for Falcon)
does suggest it won't be possible to peek at the sector count register
to detect end of DMA. The addendum (note 841017G) makes it clear that a
write to the DMA mode register is required to look at the status
register error bit (which might terminate DMA).

Maybe the DMA address register can be used to check for DMA completion
... it's used to check for residual or lost bytes anyway so that appears
to work. And the FDC driver does use the same strategy to check if
enough track data have been read.

Leaves the case where DMA hasn't completed but may have been aborted by
a NCR5380 interrupt. I suppose we can detect that by checking for any
change in the DMA address while repeatedly reading the DMA address
register. No change means the DMA has got stuck. Not exactly pretty but
all I can come up with.

> 
> I suspect that we will need to keep the FDC idle during SCSI transfers 
> (and vice versa) much as the present stdma.c lock does.
> 
> "The interrupt outputs of the internal floppy disk controller and the 
> external ACSI DMA port are logically OR'ed. The pin of the MFP GPIP will 
> read as a '0' if either the FDC or a selected ACSI device controller is 
> asserting its interrupt request."
> -- ACSI/DMA Integration Guide, p.16.
> http://dev-docs.atariforge.org/files/ACSI_DMA_Guide_6-28-1991.pdf

On Falcon, the IDE interrupt is also OR'ed to the above two interrupt
lines, hence the need for including IDE in the locking scheme there.

> 
> Polling the logically OR'ed interrupt sources to detect end-of-DMA will 
> not be reliable unless we disable those sources that aren't relevant. 
> Otherwise we access the DMA registers too early (which IIUC would kill the 
> transfer). I'm afraid we shall have to expect that a few transfers will be 
> interrupted by other devices in this way, and carefully check for this. 
> 
> For example, the 5380 SCSI bus reset interrupt is not maskable, which 
> could affect FDC transfers. If this terminated the polling for DMA 
> completion, the FDC driver then has to access the FDC registers and 
> confirm that the transfer was not terminated early.
> 

We'll have to make sure FDC and SCSI don't clash in their DMA and
interrupt use.

Cheers,

	Michael


