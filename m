From: Marcin Kuk <marcin.kuk@gmail.com>
Subject: Re: toshiba ide - ide dma setting
Date: Tue, 8 Feb 2005 23:32:38 +0100
Message-ID: <28d670ae05020814323d0d2010@mail.gmail.com>
References: <28d670ae0502081139464d51c@mail.gmail.com>
	 <58cb370e050208124447c7b1e@mail.gmail.com>
	 <28d670ae0502081341467eb64f@mail.gmail.com>
	 <58cb370e050208140441bef38f@mail.gmail.com>
Reply-To: Marcin Kuk <marcin.kuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from rproxy.gmail.com ([64.233.170.206]:40869 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261644AbVBHWcm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2005 17:32:42 -0500
Received: by rproxy.gmail.com with SMTP id a36so929407rnf
        for <linux-ide@vger.kernel.org>; Tue, 08 Feb 2005 14:32:38 -0800 (PST)
In-Reply-To: <58cb370e050208140441bef38f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> output of lspci command would be also helpful

# lspci -vv 
00:00.0 Host bridge: Toshiba America Info Systems 601 (rev a0)
Subsystem: Toshiba America Info Systems: Unknown device 0001
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
Latency: 0, cache line size 08

00:04.0 VGA compatible controller: Chips and Technologies F65555
HiQVPro (rev c6) (prog-if 00 [VGA])
Subsystem: Toshiba America Info Systems: Unknown device 0001
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
Expansion ROM at <unassigned> [disabled] [size=256K]

00:0b.0 USB Controller: NEC Corporation USB (rev 02) (prog-if 10 [OHCI])
Subsystem: Toshiba America Info Systems USB
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64 (250ns min, 5250ns max)
Interrupt: pin A routed to IRQ 11
Region 0: Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]

00:11.0 Communication controller: Toshiba America Info Systems FIR Port (rev 21)
Subsystem: Toshiba America Info Systems: Unknown device 0001
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64
Interrupt: pin A routed to IRQ 11
Region 0: I/O ports at ffe0 [size=32]

# hdparm -i /dev/hda
/dev/hda:

 Model=TOSHIBA MK4006MAV, FwRev=F2.03 A, SerialNo=68527172
 Config={ Fixed }
 RawCHS=7944/16/63, TrkSize=0, SectSize=0, ECCbytes=24
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=16
 CurCHS=7944/16/63, CurSects=8007552, LBA=yes, LBAsects=8007552
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 
 UDMA modes: udma0 udma1 udma2 
 AdvancedPM=no WriteCache=enabled

 * signifies the current active mode

> This patch is in Alan's -ac tree.
> Just get the latest patch for 2.6.10 from:
> http://kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.10/

As I remember I tried kernel applied by this patch.
This was the first thing that I made after vanilla kernel.
I will try for sure again, but keep in mind that without DMA it is
horribly long.
Haha can you imagine what I felt when updatetedb for slocate was
runned at first time? Believe me I would like solve this problem as
soon as possible.

Marcin Kuk
