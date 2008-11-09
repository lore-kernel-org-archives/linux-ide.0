From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 11:47:42 -0800 (PST)
Message-ID: <20081109194742.E0F85108041@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39640 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752555AbYKITsM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 14:48:12 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9JlgXV020171
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 11:47:44 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #11 from eshaffer1@mac.com  2008-11-09 11:47 -------
ubuntu@ubuntu:~$ lspci -vvxxx
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
        Capabilities: <access denied>
00: 11 10 26 00 07 01 b0 02 02 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 11 11 a0 a2
20: 80 80 80 80 81 80 71 80 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 06 03

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
        Capabilities: <access denied>
00: 02 10 44 51 87 00 b0 02 00 00 00 03 08 10 00 00
10: 08 00 00 88 01 04 00 00 00 00 98 80 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 08 09
30: 00 00 00 80 50 00 00 00 00 00 00 00 ff 01 08 00

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
        Capabilities: <access denied>
00: 95 10 46 06 05 00 90 02 05 8f 01 01 00 40 00 00
10: e1 10 00 00 d1 10 00 00 c1 10 00 00 b1 10 00 00
20: a1 10 00 00 00 00 00 00 00 00 00 00 95 10 46 06
30: 00 00 00 00 60 00 00 00 00 00 00 00 0e 01 02 04

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
        Capabilities: <access denied>
00: 91 11 07 00 15 00 90 02 01 00 00 01 08 10 00 00
10: 91 10 00 00 81 10 00 00 71 10 00 00 61 10 00 00
20: 51 10 00 00 00 00 00 00 00 00 00 00 91 11 07 00
30: 00 00 89 80 58 00 00 00 00 00 00 00 00 01 06 06

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


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
