From: "Cornell Gonschior" <df6fr@gmx.de>
Subject: Re: pata_ali: trouble with DVD combo
Date: Wed, 08 Aug 2007 03:31:03 +0200
Message-ID: <20070808013103.221160@gmx.net>
References: <20070808005739.221200@gmx.net>
 <20070808021938.44e45c32@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60606 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763793AbXHHBbF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 21:31:05 -0400
In-Reply-To: <20070808021938.44e45c32@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

> Please send me an lspci -vvxxx after booting both the libata and non
> libata kernel.
> 
There you go.

With libata:

00:00.0 Host bridge: ATI Technologies Inc AGP Bridge [IGP 320M] (rev 13)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at e8800000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at a010 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: 02 10 b0 ca 06 00 30 02 13 00 00 06 00 40 00 00
10: 08 00 00 ec 08 00 80 e8 11 a0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 0b 03 00 00 00 00 00 00 04 0d 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: bd 0c a6 85 24 36 e2 56 00 00 00 00 f0 01 06 c1
70: e0 0d 20 31 84 84 84 84 00 00 00 00 00 00 00 00
80: 00 00 00 00 96 10 83 00 33 00 30 00 03 00 00 00
90: 00 00 00 00 1f 1d 05 00 00 00 e4 7f 80 00 00 00
a0: 02 00 20 00 17 02 00 0f 00 00 00 00 03 00 00 00
b0: 00 00 02 00 08 00 00 00 04 04 04 04 00 00 00 00
c0: 00 00 00 ff 5a 15 05 0f 00 1c ff 1f 00 00 84 00
d0: eb 7b 0f 00 eb 7b 4f 00 6a 00 60 10 00 00 00 ff
e0: 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00 ff
f0: 1f 00 09 00 00 00 00 ff 00 08 10 18 00 00 00 00

00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 320M] (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: e8500000-e85fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 02 10 0f 70 07 00 20 02 01 00 04 06 00 63 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 44 b1 b1 20 22
20: 50 e8 50 e8 00 f0 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 0c 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: ALi Corporation USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8400000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 17 00 90 02 03 10 03 0c 00 40 00 00
10: 00 00 40 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 37 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 50
40: 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 80 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 Modem: ALi Corporation M5457 AC'97 Modem Controller (prog-if 00 [Generic])
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8401000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 8400 [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 57 54 03 00 90 02 00 00 03 07 00 40 00 00
10: 00 10 40 e8 01 84 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 0a 10
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
40: 01 00 22 c0 00 00 00 00 01 00 00 00 00 00 00 00
50: 34 17 0a 10 00 00 00 00 08 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
	Subsystem: ALi Corporation M5229 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at a000 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 29 52 05 00 90 02 c4 fa 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 a0 00 00 00 00 00 00 00 00 00 00 b9 10 29 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 02 04
40: 00 00 00 4a 00 00 00 00 30 00 20 c9 00 00 ba 3a
50: 02 00 00 89 08 00 0f 0b 01 31 31 00 01 31 31 00
60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: ALi Corporation M7101 Power Management Controller [PMU]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 01 71
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 40 08 00 00 80 21 00 e8 7f 08 30 01 00 00 00
50: 00 00 00 00 00 00 00 00 00 5f 01 c8 00 00 00 00
60: 00 00 00 b0 a5 00 00 00 00 00 00 aa 01 22 60 0e
70: 01 01 00 00 00 00 00 28 f7 77 00 80 78 02 00 00
80: 76 81 00 1b 30 27 00 00 07 02 00 20 33 00 00 00
90: 00 00 00 00 00 00 00 0a 01 00 c1 ff 30 01 00 00
a0: 00 00 00 00 00 00 00 00 10 fe 00 fe 00 00 00 00
b0: 00 04 00 00 00 00 42 00 60 0c 00 00 00 00 00 00
c0: 10 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 46 04 00 00 00 00 00 00 00 40 00 0c bf 00 00
e0: 00 80 40 80 01 00 01 00 00 00 00 00 00 00 00 00
f0: 01 00 20 6e 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge [Aladdin IV/V/V+]
	Subsystem: ALi Corporation ALi M1533 Aladdin IV/V ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 33 15
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 01 d3 0b ea 5d 02 00 03 92 02 03 59 00 00 ef 33
50: 00 00 00 00 02 00 02 00 7c 80 00 00 00 00 e0 f0
60: 63 31 00 00 00 00 00 00 00 00 00 00 00 60 00 00
70: 92 00 2b 00 01 1f 81 32 5c 00 60 02 22 00 80 91
80: a5 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 30 b0 61 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 8800 [size=256]
	Region 1: Memory at e8402000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 51 54 07 00 90 c2 02 00 01 04 00 40 00 00
10: 01 88 00 00 00 20 40 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 0a 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 02 18
40: 00 00 00 00 aa 40 08 e2 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 e6
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 8c00 [size=256]
	Region 1: Memory at e8406800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 40 00 00
10: 01 8c 00 00 00 68 40 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 0a 10
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at e8406000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at 8080 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 44 30 17 00 10 02 46 10 00 0c 10 40 00 00
10: 00 60 40 e8 81 80 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 44 30
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 00 20
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 02 e4 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 CardBus bridge: ENE Technology Inc CB1420 Cardbus Controller (rev 01)
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at 30000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-23fff000 (prefetchable)
	Memory window 1: 24000000-27fff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 24 15 20 14 07 00 10 02 01 00 07 06 10 a8 82 00
10: 00 00 00 30 a0 00 00 02 00 02 05 b0 00 00 00 20
20: 00 f0 ff 23 00 00 00 24 00 f0 ff 27 00 10 00 00
30: fc 10 00 00 00 14 00 00 fc 14 00 00 0b 01 c0 05
40: 34 17 0a 10 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 21 d0 44 08 00 00 00 00 00 00 00 00 22 11 1c 01
90: c0 06 44 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 0b 00 00 00 0b 00 00 00
b0: 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 33 10 80 00 80 00 80 00 11 0c 08 10 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.1 CardBus bridge: ENE Technology Inc CB1420 Cardbus Controller (rev 01)
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 30001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 28000000-2bfff000 (prefetchable)
	Memory window 1: 2c000000-2ffff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 24 15 20 14 07 00 10 02 01 00 07 06 10 a8 82 00
10: 00 10 00 30 a0 00 00 02 00 06 09 b0 00 00 00 28
20: 00 f0 ff 2b 00 00 00 2c 00 f0 ff 2f 00 18 00 00
30: fc 18 00 00 00 1c 00 00 fc 1c 00 00 0b 02 c0 05
40: 34 17 0a 10 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 21 d0 44 08 00 00 00 00 00 00 00 00 22 11 1c 01
90: c0 06 44 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 0b 00 00 00 0b 00 00 00
b0: 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 33 10 80 00 80 00 80 00 11 0c 08 10 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: ALi Corporation USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e8405000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 17 00 90 02 03 10 03 0c 00 40 00 00
10: 00 50 40 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 37 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 00 50
40: 00 00 1f 00 20 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 80 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1 (prog-if 00 [VGA])
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at b000 [size=256]
	Region 2: Memory at e8500000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at e8520000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 36 43 87 02 b0 02 00 00 00 03 10 42 00 00
10: 08 00 00 f0 01 b0 00 00 00 00 50 e8 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 0a 10
30: 00 00 00 00 58 00 00 00 00 00 00 00 05 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 0a 10
50: 01 00 02 06 00 00 00 00 02 50 20 00 07 02 00 2f
60: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Without libata:

00:00.0 Host bridge: ATI Technologies Inc AGP Bridge [IGP 320M] (rev 13)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at e8800000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at a010 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
00: 02 10 b0 ca 06 00 30 02 13 00 00 06 00 40 00 00
10: 08 00 00 ec 08 00 80 e8 11 a0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 0b 04 00 00 00 00 00 00 04 0d 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 45 0d a6 85 24 1b 92 55 00 00 00 00 f0 01 06 c1
70: e0 0d 20 31 84 84 84 84 00 00 00 00 00 00 00 00
80: 00 00 00 00 96 10 83 00 34 00 30 00 03 00 00 00
90: 00 00 00 00 1f 1f 05 00 00 00 e4 7f 80 00 00 00
a0: 02 00 20 00 17 02 00 0f 04 03 00 00 03 00 00 00
b0: 00 00 02 00 08 00 00 00 04 04 04 04 00 00 00 00
c0: 00 00 00 ff 5a 15 05 0f 00 1c ff 1f 00 00 84 00
d0: eb 7b 0f 00 eb 7b 4f 00 6a 00 60 10 00 00 00 ff
e0: 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00 ff
f0: 1f 00 09 00 00 00 00 ff 00 08 10 18 00 00 00 00

00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 320M] (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: e8500000-e85fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 02 10 0f 70 07 00 20 02 01 00 04 06 00 63 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 44 b1 b1 20 22
20: 50 e8 50 e8 00 f0 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 0c 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: ALi Corporation USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8400000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 17 00 90 02 03 10 03 0c 00 40 00 00
10: 00 00 40 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 37 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 50
40: 00 00 1f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 80 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 Modem: ALi Corporation M5457 AC'97 Modem Controller (prog-if 00 [Generic])
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8401000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 8400 [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 57 54 03 00 90 02 00 00 03 07 00 40 00 00
10: 00 10 40 e8 01 84 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 0a 10
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
40: 01 00 22 c0 00 00 00 00 01 00 00 00 00 00 00 00
50: 34 17 0a 10 00 00 00 00 08 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
	Subsystem: ALi Corporation M5229 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at a000 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 29 52 05 00 90 02 c4 fa 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 a0 00 00 00 00 00 00 00 00 00 00 b9 10 29 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 02 04
40: 00 00 00 4a 00 00 00 00 30 00 20 c9 00 00 ba 3a
50: 02 00 00 89 05 00 0f 0a 01 31 31 00 01 31 31 00
60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: ALi Corporation M7101 Power Management Controller [PMU]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 01 71
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 40 08 00 00 80 21 00 e8 7f 08 30 01 00 00 00
50: 00 00 00 00 00 00 00 00 00 5f 01 c8 00 00 00 00
60: 00 00 00 b0 a5 00 00 00 00 00 00 aa 01 22 60 0e
70: 01 01 00 00 00 00 00 28 f7 77 00 80 78 02 00 00
80: 76 81 00 1b 30 27 00 00 07 02 00 20 33 00 00 00
90: 00 00 00 00 00 00 00 0a 01 00 c1 ff 30 01 00 00
a0: 00 00 00 00 00 00 00 00 10 fe 00 fe 00 00 00 00
b0: 00 04 00 00 00 00 42 00 60 0c 00 00 00 00 00 00
c0: 10 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 46 04 00 00 00 00 00 00 00 40 00 0c bf 00 00
e0: 00 80 40 80 01 00 01 00 00 00 00 00 00 00 00 00
f0: 01 00 20 6e 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge [Aladdin IV/V/V+]
	Subsystem: ALi Corporation ALi M1533 Aladdin IV/V ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 33 15
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 01 d3 0b ea 5d 02 00 03 92 02 03 59 00 00 ef 33
50: 00 00 00 00 02 00 02 00 7c 80 00 00 00 00 e0 f0
60: 63 31 00 00 00 00 00 00 00 00 00 00 00 60 00 00
70: 92 00 2b 00 01 1f 81 32 5c 00 60 02 22 00 80 91
80: a5 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 30 b0 61 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 8800 [size=256]
	Region 1: Memory at e8402000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 51 54 07 00 90 c2 02 00 01 04 00 40 00 00
10: 01 88 00 00 00 20 40 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 0a 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 02 18
40: 00 00 00 00 aa 40 08 e2 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 e6
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 8c00 [size=256]
	Region 1: Memory at e8406800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 40 00 00
10: 01 8c 00 00 00 68 40 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 0a 10
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at e8406000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at 8080 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 44 30 17 00 10 02 46 10 00 0c 10 40 00 00
10: 00 60 40 e8 81 80 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 44 30
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 00 20
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 02 e4 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 CardBus bridge: ENE Technology Inc CB1420 Cardbus Controller (rev 01)
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at 30000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-23fff000 (prefetchable)
	Memory window 1: 24000000-27fff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 24 15 20 14 07 00 10 02 01 00 07 06 10 a8 82 00
10: 00 00 00 30 a0 00 00 02 00 02 05 b0 00 00 00 20
20: 00 f0 ff 23 00 00 00 24 00 f0 ff 27 00 10 00 00
30: fc 10 00 00 00 14 00 00 fc 14 00 00 0b 01 c0 05
40: 34 17 0a 10 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 21 d0 44 08 00 00 00 00 00 00 00 00 22 11 1c 01
90: c0 06 44 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 0b 00 00 00 0b 00 00 00
b0: 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 33 10 80 00 80 00 80 00 11 0c 08 10 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.1 CardBus bridge: ENE Technology Inc CB1420 Cardbus Controller (rev 01)
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 30001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 28000000-2bfff000 (prefetchable)
	Memory window 1: 2c000000-2ffff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 24 15 20 14 07 00 10 02 01 00 07 06 10 a8 82 00
10: 00 10 00 30 a0 00 00 02 00 06 09 b0 00 00 00 28
20: 00 f0 ff 2b 00 00 00 2c 00 f0 ff 2f 00 18 00 00
30: fc 18 00 00 00 1c 00 00 fc 1c 00 00 0b 02 c0 05
40: 34 17 0a 10 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 21 d0 44 08 00 00 00 00 00 00 00 00 22 11 1c 01
90: c0 06 44 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 0b 00 00 00 0b 00 00 00
b0: 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 33 10 80 00 80 00 80 00 11 0c 08 10 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: ALi Corporation USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e8405000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 17 00 90 02 03 10 03 0c 00 40 00 00
10: 00 50 40 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 37 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 00 50
40: 00 00 1f 00 20 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 80 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1 (prog-if 00 [VGA])
	Subsystem: Fujitsu Siemens Computer GmbH Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at b000 [size=256]
	Region 2: Memory at e8500000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at e8520000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=16 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 36 43 87 02 b0 02 00 00 00 03 10 42 00 00
10: 08 00 00 f0 01 b0 00 00 00 00 50 e8 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 0a 10
30: 00 00 00 00 58 00 00 00 00 00 00 00 05 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 0a 10
50: 01 00 02 06 00 00 00 00 02 50 20 00 07 02 00 2f
60: 04 03 00 0f 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-- 
                             Cornell P Gonschior, Df6fR

GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
