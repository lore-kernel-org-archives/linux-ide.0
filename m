From: bogus nominus <holister@yahoo.com>
Subject: SiS 965L version 0x0183
Date: Sun, 29 Oct 2006 08:00:14 -0800 (PST)
Message-ID: <20061029160014.44572.qmail@web90509.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web90509.mail.mud.yahoo.com ([216.252.100.176]:38780 "HELO
	web90509.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965273AbWJ2QAP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Oct 2006 11:00:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a motherboard with yet another new revision of
this driver that is not supported... I was going to
attempt to update the driver myself but unfortunately
I do not have enough time to do my due diligence to
ensure I take everything into account.. it looks
pretty straightforward though. Here is the lspci
-xxvvv:
0000:00:00.0 Host bridge: Silicon Integrated Systems
[SiS] 761/M761 Host (rev 01)
        Subsystem: Elitegroup Computer Systems:
Unknown device 0131
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at f0000000 (32-bit,
non-prefetchable) [size=64M]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+
ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP-
GART64- 64bit- FW- Rate=<none>
        Capabilities: [d0] #08 [0220]
        Capabilities: [f0] #08 [8000]
        Capabilities: [5c] #08 [8825]
00: 39 10 61 07 07 00 10 22 01 00 00 06 00 20 00 00
10: 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 31 01
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 16 00 b9 8b 05 ff 90 a0 00 00 00 00 51 00 00 02
50: 00 00 00 00 00 00 00 00 00 00 00 44 08 00 25 88
60: 00 00 00 00 00 00 00 00 4c 00 00 07 dd ad e8 4d
70: 00 80 00 00 01 10 00 00 00 00 00 00 00 00 29 08
80: 00 00 00 00 00 00 14 c8 00 00 00 10 00 03 00 1e
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 d0 30 00 0b 4e 00 1f 00 02 00 00 00 00 00 00
b0: 00 00 00 00 30 0f 01 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 08 f0 20 02 20 00 11 11 d0 00 77 77 25 05 65 00
e0: 12 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 08 5c 00 80 67 01 d1 f8 00 00 00 00 67 67 44 00

0000:00:01.0 PCI bridge: Silicon Integrated Systems
[SiS] SG86C202 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: feb00000-febfffff
        Prefetchable memory behind bridge:
d8000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort-
>Reset- FastB2B-
        Capabilities: [a4] #08 [9000]
00: 39 10 02 00 07 01 30 02 00 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 e0 e0 20 02
20: b0 fe b0 fe 00 d8 f0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 a4 00 00 00 00 00 00 00 00 00 02 00
40: 10 00 00 78 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 00 00 09 00 80 00 08 00 00 00 00 00 11 00
60: b1 02 60 60 aa 18 00 00 23 23 c8 08 00 00 08 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 08 00 00 90 00 00 00 00 00 00 00 00
b0: db 00 00 00 c0 30 13 50 00 00 40 00 00 00 00 f8
c0: 40 01 18 00 02 88 43 28 00 10 00 00 00 00 40 50
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.0 ISA bridge: Silicon Integrated Systems
[SiS] SiS965 [MuTIOL Media IO] (rev 48)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 39 10 65 09 0f 00 00 02 48 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 91 85 85 8a 85 00 3d dd 12 00 00 00 11 20 04 03
50: 11 28 02 01 60 0c 20 0a a5 12 12 00 39 5d 00 00
60: 8b 85 83 85 ff c1 00 12 09 80 00 00 97 00 04 14
70: 00 00 ff ff 00 08 03 0e 20 00 00 88 02 40 00 40
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 1f 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 f0 e0 01 00 00 00 00 00 9f 00 0f 00 00 00 45
d0: 03 00 00 00 44 62 32 00 45 00 04 6b aa aa aa aa
e0: 40 00 00 f8 43 20 44 00 00 00 00 00 00 00 00 00
f0: 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.5 IDE interface: Silicon Integrated Systems
[SiS] 5513 [IDE] (rev 01) (prog-if 80 [Master])
        Subsystem: Elitegroup Computer Systems:
Unknown device 0131
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 16
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
00: 39 10 13 55 05 00 10 02 01 80 01 01 00 80 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 19 10 31 01
30: 00 00 00 00 58 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00
50: 82 21 82 21 2a 96 80 d0 01 00 02 80 00 00 00 00
60: fb aa fb aa 00 00 00 00 a8 00 00 00 00 00 ff ff
70: 56 23 06 04 b0 66 20 1e b0 66 20 1e b0 66 20 1e
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.7 Multimedia audio controller: Silicon
Integrated Systems [SiS] Sound Controller (rev a0)
        Subsystem: Elitegroup Computer Systems:
Unknown device 1880
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 23
        Region 0: I/O ports at d800 [size=256]
        Region 1: I/O ports at d400 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
00: 39 10 12 70 05 01 90 02 a0 00 01 04 00 40 00 00
10: 01 d8 00 00 01 d4 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 80 18
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 03 34 0b
40: 04 00 00 00 00 00 00 00 01 00 42 c6 00 00 00 00
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
f0: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:03.0 USB Controller: Silicon Integrated
Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10
[OHCI])
        Subsystem: Elitegroup Computer Systems:
Unknown device 0131
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at feaff000 (32-bit,
non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 0f 10 03 0c 00 40 80 00
10: 00 f0 af fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 31 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50
40: 00 00 00 00 54 af 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:03.1 USB Controller: Silicon Integrated
Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10
[OHCI])
        Subsystem: Elitegroup Computer Systems:
Unknown device 0131
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin B routed to IRQ 19
        Region 0: Memory at feafe000 (32-bit,
non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 0f 10 03 0c 00 40 00 00
10: 00 e0 af fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 31 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 50
40: 00 00 00 00 54 af 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:03.2 USB Controller: Silicon Integrated
Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10
[OHCI])
        Subsystem: Elitegroup Computer Systems:
Unknown device 0131
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin C routed to IRQ 20
        Region 0: Memory at feafd000 (32-bit,
non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 0f 10 03 0c 00 40 00 00
10: 00 d0 af fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 31 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 03 00 50
40: 00 00 00 00 54 af 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:03.3 USB Controller: Silicon Integrated
Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
        Subsystem: Elitegroup Computer Systems:
Unknown device 0131
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 17
        Region 0: Memory at feafc000 (32-bit,
non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
00: 39 10 02 70 06 01 90 02 00 20 03 0c 00 40 00 00
10: 00 c0 af fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 31 01
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 04 00 50
40: 20 00 00 00 04 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 0a 00 00 21 00 00 00 00
60: 20 20 ff 01 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 00 00 00 00 08 c0 00 00 c7 3f 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:04.0 Ethernet controller: Silicon Integrated
Systems [SiS]: Unknown device 0190
        Subsystem: Silicon Integrated Systems [SiS]:
Unknown device 0191
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at feafbc00 (32-bit,
non-prefetchable) [size=128]
        Region 1: I/O ports at d000 [size=128]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
00: 39 10 90 01 07 00 10 02 00 00 00 02 00 00 00 00
10: 00 bc af fe 01 d0 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 91 01
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00
40: 01 00 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 20 01 00 00 00 00 00 00 00 00 c0 23 04 20
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:06.0 PCI bridge: Silicon Integrated Systems
[SiS] PCI-to-PCI bridge (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=02, subordinate=02,
sec-latency=0
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort-
>Reset- FastB2B-
        Capabilities: [b0] #0d [0000]
        Capabilities: [c0] Message Signalled
Interrupts: 64bit- Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [d0] #10 [0141]
        Capabilities: [f4] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
00: 39 10 0a 00 04 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 03 00
40: 00 00 00 00 00 00 00 00 03 06 0c 00 00 00 08 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 08 b0 02 a8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 0d c0 00 00 39 10 00 00 00 00 00 00 00 00 00 00
c0: 05 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 10 f4 41 01 20 00 00 00 10 08 10 00 01 cd 00 00
e0: 00 00 01 10 00 00 00 00 c0 03 40 00 00 00 00 00
f0: 00 00 00 00 01 00 02 c8 00 00 00 00 00 00 00 00

0000:00:07.0 PCI bridge: Silicon Integrated Systems
[SiS] PCI-to-PCI bridge (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=03, subordinate=03,
sec-latency=0
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort-
>Reset- FastB2B-
        Capabilities: [b0] #0d [0000]
        Capabilities: [c0] Message Signalled
Interrupts: 64bit- Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [d0] #10 [0141]
        Capabilities: [f4] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
00: 39 10 0a 00 04 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 03 00
40: 00 00 00 00 00 00 00 00 03 06 0c 00 00 00 08 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 08 b0 02 a8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 0d c0 00 00 39 10 00 00 00 00 00 00 00 00 00 00
c0: 05 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 10 f4 41 01 20 00 00 00 10 08 10 00 01 cd 00 00
e0: 00 00 01 10 00 00 00 00 c0 03 40 00 00 00 00 00
f0: 00 00 00 00 01 00 02 c8 00 00 00 00 00 00 00 00

0000:00:08.0 IDE interface: Silicon Integrated Systems
[SiS]: Unknown device 0183 (rev 01) (prog-if 85
[Master SecO PriO])
        Subsystem: Elitegroup Computer Systems:
Unknown device 0131
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at c800 [size=8]
        Region 1: I/O ports at c400 [size=4]
        Region 2: I/O ports at c000 [size=8]
        Region 3: I/O ports at b800 [size=4]
        Region 4: I/O ports at b400 [size=16]
        Region 5: I/O ports at <unassigned>
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
00: 39 10 83 01 05 00 10 02 01 85 01 01 00 40 00 00
10: 01 c8 00 00 01 c4 00 00 01 c0 00 00 01 b8 00 00
20: 01 b4 00 00 01 00 00 00 00 00 00 00 19 10 31 01
30: 00 00 00 00 58 00 00 00 00 00 00 00 05 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: a2 00 a2 00 2a 96 80 30 01 00 02 80 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 54 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: bd 33 72 c0 bd 33 72 40 bd 33 72 40 bd 33 72 40
90: 60 00 00 50 c0 05 c0 05 cc 04 0c 10 c0 05 c0 05
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 13 01 00 00 03 02 1f 00 00 03 00 00 00 00 00 00
d0: 01 00 00 00 01 00 18 00 00 03 00 00 00 00 00 00
e0: 00 00 00 00 01 00 18 00 00 03 00 00 00 00 00 00
f0: 01 00 00 00 01 00 18 00 00 03 00 00 00 00 00 00

0000:00:09.0 Multimedia controller: Philips
Semiconductors SAA7133 Video Broadcast Decoder (rev
d1)
        Subsystem: Giga-byte Technology: Unknown
device 9003
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (21000ns min, 8000ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at feafb000 (32-bit,
non-prefetchable) [size=2K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1
PME-
00: 31 11 33 71 06 01 90 02 d1 00 80 04 00 40 00 00
10: 00 b0 af fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 03 90
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 54 20
40: 01 00 02 06 00 20 00 1c 00 00 00 00 00 00 00 00
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

0000:00:0a.0 VGA compatible controller: nVidia
Corporation NV18 [GeForce4 MX 4000 AGP 8x] (rev c1)
(prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fd000000 (32-bit,
non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit,
prefetchable) [size=128M]
        Expansion ROM at feac0000 [disabled]
[size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
00: de 10 85 01 07 00 b0 02 c1 00 00 03 00 40 00 00
10: 00 00 00 fd 08 00 00 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 ac fe 60 00 00 00 00 00 00 00 0a 01 05 01
40: 00 00 00 00 02 00 30 00 17 02 00 1f 00 00 00 00
50: 01 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
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

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD]
K8 [Athlon64/Opteron] HyperTransport Technology
Configuration
        Control: I/O- Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 00 00 00 00 e4 00 00 00 0f cc 0e 0f 1c 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 00 01 21 20 00 11 11 22 05 35 80 02 00 00 00
90: 56 04 51 02 00 00 ff 00 07 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD]
K8 [Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 1f 00 00 00 00 00 01 00 00 00
50: 00 00 00 00 02 00 00 00 00 00 00 00 03 00 00 00
60: 00 00 00 00 04 00 00 00 00 00 00 00 05 00 00 00
70: 00 00 00 00 06 00 00 00 00 00 00 00 07 00 00 00
80: 03 00 e0 00 80 ff ef 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 03 0a 00 00 00 0b 00 00 03 00 20 00 00 ff ff 00
c0: 13 10 00 00 00 f0 ff 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD]
K8 [Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 fe e0 01 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 07 00 00 00 00 00 00 00 42 35 82 13 31 0b 00 00
90: 80 cc 0c 0e 07 07 7b 3e 00 00 00 00 07 20 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 04 36 a0 18 9c 00 00 00 1a 2f 20 03 59 0a 0f 6c
c0: 00 80 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: ff f2 3e 2d 5b 0a c7 f1 b7 ea e9 a6 80 3a bc 6e
e0: c9 f5 6c 91 3e aa 52 06 53 fa ee 37 80 96 2a 76
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD]
K8 [Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 c0 e0 9b ef
60: 8f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
80: 00 00 07 23 13 21 13 21 00 00 00 00 00 00 00 00
90: 02 00 00 00 78 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 3f 00 00 20 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 01 07 0d 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 20 14 50 14 08 01 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1f.0 PCI bridge: Silicon Integrated Systems
[SiS] PCI-to-PCI bridge (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=04, subordinate=04,
sec-latency=0
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort-
>Reset- FastB2B-
        Capabilities: [d0] #10 [0141]
        Capabilities: [bc] #08 [a802]
        Capabilities: [a0] Message Signalled
Interrupts: 64bit- Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [f4] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
        Capabilities: [b0] #0d [0000]
00: 39 10 04 00 04 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 04 04 00 f1 01 00 20
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 d0 00 00 00 00 00 00 00 00 00 03 00
40: 10 00 00 70 02 10 01 00 52 e3 00 16 80 02 00 00
50: 00 00 01 02 00 00 01 00 00 84 00 00 52 ff 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 07 77 27 13 97 00 00 00 00 00 00 00 00 00 00 00
a0: 05 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 0d 00 00 00 39 10 00 00 00 00 00 00 08 a0 02 a8
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 10 bc 41 01 20 00 00 00 10 08 18 00 01 cd 10 00
e0: 00 00 01 10 80 25 00 00 c0 03 00 00 00 00 00 00
f0: 00 00 00 00 01 b0 02 c8 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: Silicon
Integrated Systems [SiS] 661/741/760/761 PCI/AGP VGA
Display Adapter (rev 03) (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS]
[M]661xX/[M]741[GX]/[M]760 PCI/AGP VGA Adapter
        Control: I/O- Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        BIST result: 00
        Region 0: Memory at d8000000 (32-bit,
prefetchable) [disabled] [size=128M]
        Region 1: Memory at febe0000 (32-bit,
non-prefetchable) [disabled] [size=128K]
        Region 2: I/O ports at e800 [disabled]
[size=128]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
        Capabilities: [50] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+
ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP-
GART64- 64bit- FW- Rate=<none>
00: 39 10 30 63 00 00 30 02 03 00 00 03 00 00 00 80
10: 08 00 00 d8 00 00 be fe 01 e8 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 30 63
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00
40: 01 50 02 06 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 30 00 0b 02 00 ff 00 00 00 00 00 00 00 00
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



 
__________________________________________________________________________________________
Check out the New Yahoo! Mail - Fire up a more powerful email and get things done faster. 
(http://advision.webevents.yahoo.com/mailbeta) 

