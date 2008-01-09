From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [CALL-FOR-HELP] pata_ali: can't get MWDMA working!
Date: Wed, 09 Jan 2008 20:27:26 +0300
Message-ID: <478503FE.7040501@ru.mvista.com>
References: <4784FBC1.7070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:36928 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752560AbYAIR0h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 12:26:37 -0500
In-Reply-To: <4784FBC1.7070804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, andre@linux-ide.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Tejun Heo wrote:
> Hello, all.
> 
> Broken MWDMA on pata_ali has caused a number of bug reports.  I've been
> trying to fix it for some time now && finally got a machine with
> pata_ali and non-working MWDMA2 ATAPI device on my desk a few weeks ago.
>  Testing confirms what users have been reporting - MWDMA2 works fine

    Heh, it works by accident: PIO4 timings correspond to MWDMA ones. The 
driver does *not* support MWDMA modes -- there's FIXME in ali_set_dma_mode().

> with the IDE alim15x3 driver while any DMA data transfer on pata_ali
> times out.

> At first I thought this was simple timing programming error, but no.
> pata_ali's mode programming wasn't wrong although it was different in
> how it programs empty slots.  Even after making pata_ali to program the
> controller exactly the same as alim15x3 (identical lspci -xxx results),
> MWDMA didn't work. (attached)

    I don't quite understand -- MWDMA mode programming is simply not there in 
the alim15x3 driver...

> I wondered whether the device was configured differently, so compared
> hdparm --Istdout results.  They were identical too. (attached)

> I walked through IDE and libata codes and found some differences in the
> order registers are accessed and which values are written (e.g. libata
> never turns on device 0/1 DMA capable bits in BMDMA status register
> while IDE does).  I made them access the registers in the same order and
> write the same values.  Still no go.

> Then, I made libata probing sequence very close to IDE such that no
> reset is performed and NIEN isn't tempered with.  No go.

> I thought maybe the drive should just be blacklisted.  I took the laptop
> apart, took out the DVD combo drive to ICH7 ata_piix.  It works just fine.

> So, I'm out of ideas at this point.  Any suggestions?  Ideas?

> Thanks.

> ------------------------------------------------------------------------
> 
> 00:10.0 IDE interface [Class 0101]: ALi Corporation M5229 IDE [10b9:5229] (rev c4) (prog-if b0)

    Hm, channel enables (bits 4/5) are set but bit 6 is cleared... looking 
into the datasheet, bits 4/5/6 should be read as 0 by default...

> 	Subsystem: Hewlett-Packard Company Pavilion ze4400 builtin IDE [103c:0024]
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (500ns min, 1000ns max)
> 	Interrupt: pin A routed to IRQ 0

    Interrupt not routed... well, we're in legacy mode anyway with native mode 
not supported, so why the device is requesting interrupt at all is not clear.

> 	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
> 	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
> 	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
> 	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]

    What?! The minimum PCI resource size is 4 bytes, not 1. And why those are 
seen as memory resources?

> 	Region 4: I/O ports at 8080 [size=16]
> 	Capabilities: [60] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: b9 10 29 52 05 00 90 02 c4 b0 01 01 00 20 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 81 80 00 00 00 00 00 00 00 00 00 00 3c 10 24 00
> 30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 02 04
> 40: 00 00 00 0f 00 00 00 00 30 00 20 c9 00 00 ba 3a
> 50: 02 00 00 89 05 00 0f 00 01 31 31 00 01 31 31 00
> 60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

MBR, Sergei
