From: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Sun, 11 Jul 2004 11:02:22 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40F1567E.D41BE29A@verizon.net>
References: <40E99531.BDB8D339@verizon.net> <200407072143.07618.bzolnier@elka.pw.edu.pl> <40F04291.434D8AF9@verizon.net> <200407102207.19713.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out012pub.verizon.net ([206.46.170.137]:23685 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S266613AbUGKPCS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jul 2004 11:02:18 -0400
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> 
> I believe that dmesg/lspci would be useful for me or other people reading
> this because it allows us to know a bit more about this specific hardware
> ('Thinkpad 760' is really not enough).
> 

lspci =vv output:

00:00.0 Host bridge: Intel Corp. 430MX - 82437MX Mob. System Ctrlr (MTSC) & 82438MX Data Path (MTDP) (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:01.0 ISA bridge: Intel Corp. 82371FB PIIX ISA [Triton I] (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.0 CardBus bridge: Texas Instruments PCI1130 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 10812000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=03, sec-latency=176
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite-
	16-bit legacy interface ports at 0001

00:02.1 CardBus bridge: Texas Instruments PCI1130 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 0
	Region 0: Memory at 10811000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=04, subordinate=06, sec-latency=176
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite-
	16-bit legacy interface ports at 0001

00:03.0 VGA compatible controller: Trident Microsystems TGUI 9660/938x/968x (rev d3) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 08000000 (32-bit, non-prefetchable) [size=4M]
	Region 1: Memory at 08400000 (32-bit, non-prefetchable) [size=64K]
	Region 2: Memory at 08800000 (32-bit, non-prefetchable) [size=4M]
	Expansion ROM at 000c0000 [disabled] [size=64K]

00:05.0 Multimedia video controller: IBM MPEG PCI Bridge
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10810000 (32-bit, non-prefetchable) [size=256]


Hmm. No IDE interface... It must be legacy stuff behind the ISA bridge...
I think I need to look at the man page again...  If I find anything, I'll 
post this with the additional stuff.

Still working on the dmesg stuff...

Max
