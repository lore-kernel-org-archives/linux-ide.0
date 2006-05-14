From: Foli Ayivoh <it21@arcor.de>
Subject: [BUGREPORT 3/3] Kernel Oops with HPT372A IDE controller
Date: Sun, 14 May 2006 21:11:42 +0200
Message-ID: <200605142111.42329.it21@arcor.de>
Reply-To: 101551.753@compuserve.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:53997 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751581AbWENTKo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 May 2006 15:10:44 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 7054426D6FB
	for <linux-ide@vger.kernel.org>; Sun, 14 May 2006 21:10:42 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 5E24319E27B
	for <linux-ide@vger.kernel.org>; Sun, 14 May 2006 21:10:42 +0200 (CEST)
Received: from drx-3 (dslb-084-058-180-134.pools.arcor-ip.net [84.58.180.134])
	(Authenticated sender: it21@arcor.de)
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id A11EF13E57D
	for <linux-ide@vger.kernel.org>; Sun, 14 May 2006 21:10:41 +0200 (CEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is lspci -vvv from ubuntu 5 distro bootable CD-ROM with kernel 2.6.12-9-386

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at dc00 [size=32]
	Capabilities: <available only to root>

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at ed087000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 21
	Region 0: Memory at ed082000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 20
	Region 0: Memory at ed083000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard onboard nForce2 Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at ed086000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at e000 [size=8]
	Capabilities: <available only to root>

0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio [Via VT82C686B] (rev a2)
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 3000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at ed000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: <available only to root>

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: Asustek Computer, Inc.: Unknown device 8095
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at e400 [size=256]
	Region 1: I/O ports at d000 [size=128]
	Region 2: Memory at ed080000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00007000-0000afff
	Memory behind bridge: eb000000-ecffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: <available only to root>

0000:00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 1394) Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 809a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at ed084000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at ed085000 (32-bit, non-prefetchable) [size=64]
	Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e9000000-eaffffff
	Prefetchable memory behind bridge: c0000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:04.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
	Subsystem: Asustek Computer, Inc.: Unknown device 811a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5750ns min, 7750ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16K]
	Region 1: I/O ports at 7000 [size=256]
	Capabilities: <available only to root>

0000:01:08.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
	Subsystem: Creative Labs: Unknown device 2001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 7400 [size=64]
	Capabilities: <available only to root>

0000:01:08.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
	Subsystem: Creative Labs SB Audigy MIDI/Game Port
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at 7800 [size=8]
	Capabilities: <available only to root>

0000:01:08.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) (prog-if 10 [OHCI])
	Subsystem: Creative Labs SB Audigy FireWire Port
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at ec008000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at ec004000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

0000:01:0a.0 RAID bus controller: Triones Technologies, Inc. HPT372A (rev 02)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 7c00 [size=8]
	Region 1: I/O ports at 8000 [size=4]
	Region 2: I/O ports at 8400 [size=8]
	Region 3: I/O ports at 8800 [size=4]
	Region 4: I/O ports at 8c00 [size=256]
	Capabilities: <available only to root>

0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Asus A7N8X
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 9000 [size=8]
	Region 1: I/O ports at 9400 [size=4]
	Region 2: I/O ports at 9800 [size=8]
	Region 3: I/O ports at 9c00 [size=4]
	Region 4: I/O ports at a000 [size=16]
	Region 5: Memory at ec009000 (32-bit, non-prefetchable) [size=512]
	Capabilities: <available only to root>

0000:03:00.0 VGA compatible controller: ATI Technologies Inc RV350 AR [Radeon 9600] (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 7c19
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at ea000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

0000:03:00.1 Display controller: ATI Technologies Inc RV350 AR [Radeon 9600] (Secondary)
	Subsystem: PC Partner Limited: Unknown device 7c18
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at d0000000 (32-bit, prefetchable) [disabled] [size=256M]
	Region 1: Memory at ea010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: <available only to root>

