From: Marcin Kuk <marcin.kuk@gmail.com>
Subject: Re: toshiba ide - ide dma setting
Date: Wed, 9 Feb 2005 03:00:49 +0100
Message-ID: <28d670ae0502081800236852c6@mail.gmail.com>
References: <28d670ae0502081139464d51c@mail.gmail.com>
	 <58cb370e050208124447c7b1e@mail.gmail.com>
	 <28d670ae0502081341467eb64f@mail.gmail.com>
	 <58cb370e050208140441bef38f@mail.gmail.com>
	 <28d670ae05020814323d0d2010@mail.gmail.com>
Reply-To: Marcin Kuk <marcin.kuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from rproxy.gmail.com ([64.233.170.200]:54948 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261742AbVBICAu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2005 21:00:50 -0500
Received: by rproxy.gmail.com with SMTP id z35so990425rne
        for <linux-ide@vger.kernel.org>; Tue, 08 Feb 2005 18:00:49 -0800 (PST)
In-Reply-To: <28d670ae05020814323d0d2010@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Bad news :-(.

Now I am working with my new compiled 2..6.10ac12 kernel.
I can't enable DMA setting.

My system: Slackware 10

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

# dmesg
..............
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: TOSHIBA MK4006MAV, ATA DISK drive
Probing IDE interface ide1...
hdc: CD-220EA, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 8007552 sectors (4099 MB), CHS=7944/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 20X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
................

# hdparm -d1 /dev/hda
/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

What can I do?

Marcin Kuk
