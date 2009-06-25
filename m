From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13619] New: Inserting a video DVD causes a kernel panic
Date: Thu, 25 Jun 2009 08:12:24 GMT
Message-ID: <bug-13619-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:51574 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbZFYIMV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jun 2009 04:12:21 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5P8COeh017638
	for <linux-ide@vger.kernel.org>; Thu, 25 Jun 2009 08:12:24 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=3D13619

           Summary: Inserting a video DVD causes a kernel panic
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.30
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: debian@carbon-project.org
        Regression: Yes


Created an attachment (id=3D22088)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=3D22088)
Transcript of the output caused by the kernel panic after booting with =
a video
DVD.

Hello,
just noticed, that since 2.6.30 (2.6.29.4 worked fine) inserting (or bo=
oting
with an inserted, for that matter) video DVD causes a kernel panic. ple=
ase see
the the attached transcript of the panic output for further details.

$ dmesg | grep DVD-ROM
hdc: Pioneer DVD-ROM ATAPIModel DVD-104S 020, ATAPI CD/DVD-ROM drive
ide-cd: hdc: ATAPI DVD-ROM drive, 512kB Cache

$ lspci -vvxxx
00:00.0 Host bridge: nVidia Corporation nForce2 IGP2 (rev c1)          =
        =20
        Subsystem: ASUSTeK Computer Inc. Device 80ac                   =
        =20
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-                                      =
        =20
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-                                           =
        =20
        Latency: 0                                                     =
        =20
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D64M=
]         =20
        Capabilities: <access denied>                                  =
        =20
        Kernel driver in use: agpgart-nvidia                           =
        =20
00: de 10 e0 01 06 00 b0 00 c1 00 00 06 00 00 80 00                    =
        =20
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80                    =
        =20
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00                    =
        =20

00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 0 (rev=
 c1)    =20
        Subsystem: ASUSTeK Computer Inc. Device 80ac                   =
        =20
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-                                      =
        =20
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-                                           =
        =20
00: de 10 ea 01 00 00 20 00 c1 00 00 05 00 00 80 00                    =
        =20
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80                    =
        =20
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00                    =
        =20

00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev=
 c1)
        Subsystem: ASUSTeK Computer Inc. Device 80ac                   =
   =20
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
00: de 10 ee 01 00 00 20 00 c1 00 00 05 00 00 80 00                    =
        =20
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80                    =
        =20
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00                    =
        =20

00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev=
 c1)
        Subsystem: ASUSTeK Computer Inc. Device 80ac                   =
   =20
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
00: de 10 ed 01 00 00 20 00 c1 00 00 05 00 00 80 00                    =
        =20
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80                    =
        =20
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20

00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev=
 c1)
        Subsystem: ASUSTeK Computer Inc. Device 80ac                   =
   =20
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
00: de 10 ec 01 00 00 20 00 c1 00 00 05 00 00 80 00                    =
        =20
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80                    =
        =20
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00                    =
        =20

00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev=
 c1)
        Subsystem: ASUSTeK Computer Inc. Device 80ac                   =
   =20
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
00: de 10 ef 01 00 00 20 00 c1 00 00 05 00 00 80 00                    =
        =20
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80                    =
        =20
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00                    =
        =20

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
        Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard         =20
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
        Latency: 0                                                     =
        =20
        Capabilities: <access denied>                                  =
        =20
00: de 10 60 00 0f 00 b0 00 a4 00 01 06 00 00 80 00                    =
        =20
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ad 80                    =
        =20
30: 00 00 00 00 48 00 00 00 00 00 00 00 00 00 00 00                    =
        =20

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
        Subsystem: ASUSTeK Computer Inc. Device 0c11         =20
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
        Interrupt: pin A routed to IRQ 11                              =
        =20
        Region 0: I/O ports at e000 [size=3D32]                        =
          =20
        Capabilities: <access denied>                                  =
        =20
        Kernel driver in use: nForce2_smbus                            =
        =20
00: de 10 64 00 01 00 b0 00 a2 00 05 0c 00 00 80 00                    =
        =20
10: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c                    =
        =20
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 03 01                    =
        =20

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev =
a4)
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard               =
        =20
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
        Latency: 0 (750ns min, 250ns max)                              =
        =20
        Interrupt: pin A routed to IRQ 20                              =
        =20
        Region 0: Memory at e7001000 (32-bit, non-prefetchable) [size=3D=
4K]      =20
        Capabilities: <access denied>                                  =
        =20
        Kernel driver in use: ohci_hcd                                 =
        =20
00: de 10 67 00 07 00 b0 00 a4 10 03 0c 00 00 80 00                    =
        =20
10: 00 10 00 e7 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c                    =
        =20
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 03 01                    =
        =20

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev =
a4)
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard               =
        =20
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
        Latency: 0 (750ns min, 250ns max)                              =
        =20
        Interrupt: pin B routed to IRQ 22                              =
        =20
        Region 0: Memory at e7002000 (32-bit, non-prefetchable) [size=3D=
4K]      =20
        Capabilities: <access denied>                                  =
        =20
        Kernel driver in use: ohci_hcd                                 =
        =20
00: de 10 67 00 07 00 b0 00 a4 10 03 0c 00 00 80 00                    =
        =20
10: 00 20 00 e7 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c                    =
        =20
30: 00 00 00 00 44 00 00 00 00 00 00 00 0c 02 03 01                    =
        =20

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev =
a4)
(prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard               =
        =20
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
        Latency: 0 (750ns min, 250ns max)                              =
        =20
        Interrupt: pin C routed to IRQ 21                              =
        =20
        Region 0: Memory at e7003000 (32-bit, non-prefetchable) [size=3D=
256]     =20
        Capabilities: <access denied>                                  =
        =20
        Kernel driver in use: ehci_hcd                                 =
        =20
00: de 10 68 00 06 00 b0 00 a4 20 03 0c 00 00 80 00                    =
        =20
10: 00 30 00 e7 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c                    =
        =20
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 03 03 01                    =
        =20

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Contro=
ller
(rev a1)
        Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard onboard nForce=
2
Ethernet  =20
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
        Latency: 0 (250ns min, 5000ns max)                             =
        =20
        Interrupt: pin A routed to IRQ 22                              =
        =20
        Region 0: Memory at e7000000 (32-bit, non-prefetchable) [size=3D=
4K]      =20
        Region 1: I/O ports at e400 [size=3D8]                         =
          =20
        Capabilities: <access denied>                                  =
        =20
        Kernel driver in use: forcedeth                                =
        =20
00: de 10 66 00 07 00 b0 00 a1 00 00 02 00 00 00 00                    =
        =20
10: 00 00 00 e7 01 e4 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 a7 80                    =
        =20
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 01 14                    =
        =20

00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev=
 a3)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
        Latency: 0                                                     =
        =20
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latenc=
y=3D32          =20
        I/O behind bridge: 0000c000-0000cfff                           =
        =20
        Memory behind bridge: e6000000-e6ffffff                        =
        =20
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort+ <SERR- <PERR+    =20
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-  =
        =20
                PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-    =
        =20
00: de 10 6c 00 07 01 a0 00 a3 00 04 06 00 00 01 00                    =
        =20
10: 00 00 00 00 00 00 00 00 00 01 01 20 c0 c0 80 a2                    =
        =20
20: 00 e6 f0 e6 f0 ff 00 00 00 00 00 00 00 00 00 00                    =
        =20
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 02                    =
        =20

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if=
 8a
[Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. Device 0c11                   =
        =20
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-=20
        Latency: 0 (750ns min, 250ns max)                              =
        =20
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchabl=
e)
[size=3D8]                          =20
        Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchabl=
e)
[size=3D1]                          =20
        Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchabl=
e)
[size=3D8]                          =20
        Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchabl=
e)
[size=3D1]                          =20
        Region 4: I/O ports at f000 [size=3D16]                        =
          =20
        Capabilities: <access denied>                                  =
        =20
        Kernel driver in use: AMD_IDE                                  =
        =20
00: de 10 65 00 05 00 b0 00 a2 8a 01 01 00 00 00 00                    =
        =20
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 01 f0 00 00 00 00 00 00 00 00 00 00 43 10 11 0c                    =
        =20
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01                    =
        =20

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00=
 [Normal
decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32                                                    =
        =20
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latenc=
y=3D32          =20
        I/O behind bridge: 0000d000-0000dfff                           =
        =20
        Memory behind bridge: e4000000-e5ffffff                        =
        =20
        Prefetchable memory behind bridge: d0000000-dfffffff           =
        =20
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- <SERR- <PERR-     =20
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-  =
        =20
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-    =
        =20
00: de 10 e8 01 07 01 20 02 c1 00 04 06 00 20 01 00                    =
        =20
10: 00 00 00 00 00 00 00 00 00 02 02 20 d0 d0 20 02                    =
        =20
20: 00 e4 f0 e5 00 d0 f0 df 00 00 00 00 00 00 00 00                    =
        =20
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00                    =
        =20

01:08.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
        Subsystem: Creative Labs Device 1008                        =20
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32 (500ns min, 5000ns max)                            =
        =20
        Interrupt: pin A routed to IRQ 18                              =
        =20
        Region 0: I/O ports at c000 [size=3D64]                        =
          =20
        Capabilities: <access denied>                                  =
        =20
        Kernel driver in use: EMU10K1_Audigy                           =
        =20
00: 02 11 04 00 05 00 90 02 04 00 01 04 00 20 80 00                    =
        =20
10: 01 c0 00 00 00 00 00 00 00 00 00 00 00 00 00 00                    =
        =20
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 08 10                    =
        =20
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 02 14

01:08.1 Input device controller: Creative Labs SB Audigy Game Port (rev=
 04)
        Subsystem: Creative Labs SB Audigy2 MIDI/Game Port
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32
        Region 0: I/O ports at c400 [size=3D8]
        Capabilities: <access denied>
        Kernel driver in use: Emu10k1_gameport
00: 02 11 03 70 05 00 90 02 04 00 80 09 00 20 80 00
10: 01 c4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 60 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

01:08.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (re=
v 04)
(prog-if 10 [OHCI])
        Subsystem: Creative Labs SB Audigy FireWire Port
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32 (500ns min, 1000ns max), Cache Line Size: 32 bytes
        Interrupt: pin B routed to IRQ 19
        Region 0: Memory at e6004000 (32-bit, non-prefetchable) [size=3D=
2K]
        Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=3D=
16K]
        Capabilities: <access denied>
        Kernel driver in use: ohci1394
00: 02 11 01 40 06 00 10 02 04 10 00 0c 08 20 80 00
10: 00 40 00 e6 00 00 00 e6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 10 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0c 02 02 04

02:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 NE =
[Radeon
9500 Pro] (prog-if 00 [VGA controller])
        Subsystem: ATI Technologies Inc Radeon R300 NE [Radeon 9500 Pro=
]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping+ SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 32 (2000ns min), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D128=
M]
        Region 1: I/O ports at d000 [size=3D256]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=3D=
64K]
        [virtual] Expansion ROM at e4000000 [disabled] [size=3D128K]
        Capabilities: <access denied>
00: 02 10 45 4e 87 00 b0 22 00 00 00 03 08 20 80 00
10: 08 00 00 d0 01 d0 00 00 00 00 00 e5 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 02 00
30: 00 00 00 00 58 00 00 00 00 00 00 00 0c 01 08 00

02:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon 95=
00 Pro]
(Secondary)
        Subsystem: ATI Technologies Inc Radeon R300 NE [Radeon 9500 Pro=
]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping+ SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled]
[size=3D128M]
        Region 1: Memory at e5010000 (32-bit, non-prefetchable) [disabl=
ed]
[size=3D64K]
        Capabilities: <access denied>
00: 02 10 65 4e 80 00 b0 02 00 00 80 03 08 20 00 00
10: 08 00 00 d8 00 00 01 e5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 03 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00

If you should need further information (maybe the configuration of the
kernel?), please feel free to ask.

Kind regards,
Kai Wasserb=C3=A4ch

--=20
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are watching the assignee of the bug.