From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 13:15:09 -0800 (PST)
Message-ID: <20081109211509.952FF11D107@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53027 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755862AbYKIVPM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 16:15:12 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9LF9jL026767
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 13:15:10 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #13 from eshaffer1@mac.com  2008-11-09 13:15 -------
ubuntu@ubuntu:~$ sudo lspci -vvxxx
00:00.0 Host bridge: Motorola MPC106 [Grackle] (rev 40)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort+
<MAbort+ >SERR- <PERR+
        Latency: 0, Cache Line Size: 32 bytes
00: 57 10 02 00 06 00 80 b0 40 00 00 06 08 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 01 00 00 00 00 00 00 00 00 00 00 20 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 11 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 80 00 80 00 80 00 80 00 00 01 01 02 02 03 03
90: 7f ff 7f ff 7f ff 7f ff 00 00 01 01 02 02 03 03
a0: ff 00 00 96 00 00 00 00 1c 06 14 ff 00 02 00 22
b0: 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00
c0: 01 00 00 72 00 00 00 00 80 80 00 2c 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 42 00 ff 0f 00 00 00 00 20 00 00 00 00 00 00 00
f0: 00 00 6c f9 00 12 01 00 93 22 30 14 24 22 30 25

00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 80800000-808fffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR+
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
00: 11 10 26 00 07 01 b0 02 02 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 11 11 a0 a2
20: 80 80 80 80 81 80 71 80 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 06 03
40: 00 00 ff 02 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 02 00 0f 00 00 18 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 01
e0: 00 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:10.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD [Radeon
7200] (prog-if 00 [VGA controller])
        Subsystem: ATI Technologies Inc Unknown device 0908
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (2000ns min), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at 88000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at 80980000 (32-bit, non-prefetchable) [size=512K]
        Expansion ROM at 80000000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 44 51 87 00 b0 02 00 00 00 03 08 10 00 00
10: 08 00 00 88 01 04 00 00 00 00 98 80 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 08 09
30: 00 00 00 80 50 00 00 00 00 00 00 00 ff 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 08 09
50: 01 00 02 06 00 00 00 00 02 50 20 00 00 02 00 2f
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

01:00.0 FireWire (IEEE 1394): Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link
Layer Controller (rev 02) (prog-if 00 [Generic])
        Subsystem: Apple Computer Inc. Unknown device 001c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (750ns min, 1000ns max), Cache Line Size: 128 bytes
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at 80881000 (32-bit, non-prefetchable) [size=4K]
        Region 1: Memory at 808c0000 (32-bit, non-prefetchable) [size=64K]
        Region 2: Memory at 808b0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 808a0000 [disabled] [size=64K]
00: 4c 10 00 80 16 00 00 02 02 00 00 0c 20 10 00 00
10: 00 10 88 80 00 00 8c 80 00 00 8b 80 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 6b 10 1c 00
30: 00 00 8a 80 00 00 00 00 00 00 00 00 00 01 03 04
40: 00 00 00 00 71 00 00 00 00 00 00 00 ff 03 01 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 0d 00 00 00 0d 00 00 00 0d 00 00 00 0d 00 00 00
d0: 0d 00 00 00 0d 00 00 00 0d 00 00 00 0d 00 00 00
e0: 0d 00 00 00 0d 00 00 00 0d 00 00 00 0d 00 00 00
f0: 0d 00 00 00 0d 00 00 00 0d 00 00 00 0d 00 00 00

01:01.0 IDE interface: Silicon Image, Inc. PCI0646 (rev 05) (prog-if 8f [Master
SecP SecO PriP PriO])
        Subsystem: Silicon Image, Inc. PCI0646
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 26
        Region 0: I/O ports at 10e0 [size=8]
        Region 1: I/O ports at 10d0 [size=4]
        Region 2: I/O ports at 10c0 [size=8]
        Region 3: I/O ports at 10b0 [size=4]
        Region 4: I/O ports at 10a0 [size=16]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=3 PME-
00: 95 10 46 06 05 00 90 02 05 8f 01 01 00 40 00 00
10: e1 10 00 00 d1 10 00 00 c1 10 00 00 b1 10 00 00
20: a1 10 00 00 00 00 00 00 00 00 00 00 95 10 46 06
30: 00 00 00 00 60 00 00 00 00 00 00 00 0e 01 02 04
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
50: 40 e4 00 c0 00 c0 00 cc 00 40 00 00 00 00 00 00
60: 01 00 01 06 00 60 00 80 00 00 00 00 00 00 00 00
70: 08 00 00 f0 e8 12 e7 0f 08 00 00 f0 c8 1f ff 6f
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:04.0 SCSI storage controller: Artop Electronic Corp ATP860 (rev 01)
        Subsystem: Artop Electronic Corp ATP860
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (1500ns min, 1500ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 25
        Region 0: I/O ports at 1090 [size=8]
        Region 1: I/O ports at 1080 [size=4]
        Region 2: I/O ports at 1070 [size=8]
        Region 3: I/O ports at 1060 [size=4]
        Region 4: I/O ports at 1050 [size=16]
        Expansion ROM at 80890000 [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 91 11 07 00 15 00 90 02 01 00 00 01 08 10 00 00
10: 91 10 00 00 81 10 00 00 71 10 00 00 61 10 00 00
20: 51 10 00 00 00 00 00 00 00 00 00 00 91 11 07 00
30: 00 00 89 80 58 00 00 00 00 00 00 00 00 01 06 06
40: 31 31 00 31 55 50 00 00 70 00 06 00 00 02 00 00
50: ff ff ff ff 00 02 00 00 01 00 01 00 00 00 00 00
60: 31 31 00 31 55 50 00 00 70 00 06 00 00 02 00 00
70: 00 00 00 00 00 02 00 00 01 00 01 00 00 00 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: 31 31 00 31 55 50 00 00 70 00 06 00 00 02 00 00
d0: 00 00 00 00 00 02 00 00 01 00 01 00 00 00 00 00
e0: 31 31 00 31 55 50 00 00 70 00 06 00 00 02 00 00
f0: 00 00 00 00 00 02 00 00 01 00 01 00 00 00 00 00

01:05.0 Class ff00: Apple Computer Inc. Paddington Mac I/O
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 16, Cache Line Size: 32 bytes
        Region 0: Memory at 80800000 (32-bit, non-prefetchable) [size=512K]
00: 6b 10 17 00 16 00 00 82 00 00 00 ff 08 10 00 00
10: 00 00 80 80 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

01:06.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
        Subsystem: OPTi Inc. 82C861
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 16, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at 80880000 (32-bit, non-prefetchable) [size=4K]
00: 45 10 61 c8 16 00 80 82 10 10 03 0c 08 10 00 00
10: 00 00 88 80 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 45 10 61 c8
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 01 27 00 30 33 33 33 00 00 00 00 00 00 00 00
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


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
