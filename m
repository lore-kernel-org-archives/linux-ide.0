From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Mon, 29 Oct 2012 13:15:33 +0000 (UTC)
Message-ID: <20121029131533.0642A11FB7E@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:49511 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab2J2NPq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Oct 2012 09:15:46 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 92253202D5
	for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2012 13:15:41 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id BEC2E2033D
	for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2012 13:15:34 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151


cthx <sntmail@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sntmail@gmail.com




--- Comment #28 from cthx <sntmail@gmail.com>  2012-10-29 13:15:31 ---
I have this crash at asus M2N32-SLI-Deluxe mainboard (kernel 3.6.2, 3.6.3)

lspci -v

00:00.0 RAM memory: NVIDIA Corporation C51 Host Bridge (rev a2)
    Subsystem: NVIDIA Corporation C51 Host Bridge
    Flags: bus master, 66MHz, fast devsel, latency 0
    Capabilities: [44] HyperTransport: Slave or Primary Interface
    Capabilities: [e0] HyperTransport: MSI Mapping Enable+ Fixed-

00:00.1 RAM memory: NVIDIA Corporation C51 Memory Controller 0 (rev a2)
    Subsystem: NVIDIA Corporation C51 Memory Controller 0
    Flags: 66MHz, fast devsel

00:00.2 RAM memory: NVIDIA Corporation C51 Memory Controller 1 (rev a2)
    Subsystem: NVIDIA Corporation C51 Memory Controller 1
    Flags: 66MHz, fast devsel

00:00.3 RAM memory: NVIDIA Corporation C51 Memory Controller 5 (rev a2)
    Subsystem: NVIDIA Corporation C51 Memory Controller 5
    Flags: 66MHz, fast devsel

00:00.4 RAM memory: NVIDIA Corporation C51 Memory Controller 4 (rev a2)
    Subsystem: NVIDIA Corporation C51 Memory Controller 4
    Flags: bus master, 66MHz, fast devsel, latency 0

00:00.5 RAM memory: NVIDIA Corporation C51 Host Bridge (rev a2)
    Subsystem: NVIDIA Corporation C51 Host Bridge
    Flags: bus master, 66MHz, fast devsel, latency 0
    Capabilities: [44] #00 [0000]

00:00.6 RAM memory: NVIDIA Corporation C51 Memory Controller 3 (rev a2)
    Subsystem: NVIDIA Corporation C51 Memory Controller 3
    Flags: 66MHz, fast devsel

00:00.7 RAM memory: NVIDIA Corporation C51 Memory Controller 2 (rev a2)
    Subsystem: NVIDIA Corporation C51 Memory Controller 2
    Flags: 66MHz, fast devsel

00:04.0 PCI bridge: NVIDIA Corporation C51 PCI Express Bridge (rev a1) (prog-if
00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000a000-0000afff
    Memory behind bridge: fa000000-fcffffff
    Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff
    Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
    Capabilities: [48] Power Management version 2
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
    Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
    Capabilities: [80] Express Root Port (Slot+), MSI 00
    Capabilities: [100] Virtual Channel
    Kernel driver in use: pcieport

00:08.0 RAM memory: NVIDIA Corporation MCP55 Memory Controller (rev a1)
    Subsystem: ASUSTeK Computer Inc. Device cb84
    Flags: bus master, 66MHz, fast devsel, latency 0
    Capabilities: [44] HyperTransport: Slave or Primary Interface
    Capabilities: [e0] #00 [fee0]

00:09.0 ISA bridge: NVIDIA Corporation MCP55 LPC Bridge (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device cb84
    Flags: bus master, 66MHz, fast devsel, latency 0

00:09.1 SMBus: NVIDIA Corporation MCP55 SMBus (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device cb84
    Flags: 66MHz, fast devsel, IRQ 5
    I/O ports at 1c00 [size=64]
    I/O ports at 1c40 [size=64]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: nForce2_smbus

00:0a.0 USB controller: NVIDIA Corporation MCP55 USB Controller (rev a1)
(prog-if 10 [OHCI])
    Subsystem: ASUSTeK Computer Inc. Device cb84
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
    Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: ohci_hcd

00:0a.1 USB controller: NVIDIA Corporation MCP55 USB Controller (rev a2)
(prog-if 20 [EHCI])
    Subsystem: ASUSTeK Computer Inc. Device cb84
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
    Memory at fe02e000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [44] Debug port: BAR=1 offset=0098
    Capabilities: [80] Power Management version 2
    Kernel driver in use: ehci_hcd

00:0c.0 IDE interface: NVIDIA Corporation MCP55 IDE (rev a1) (prog-if 8a
[Master SecP PriP])
    Subsystem: ASUSTeK Computer Inc. Device cb84
    Flags: bus master, 66MHz, fast devsel, latency 0
    [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
    [virtual] Memory at 000003f0 (type 3, non-prefetchable)
    [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
    [virtual] Memory at 00000370 (type 3, non-prefetchable)
    I/O ports at f400 [size=16]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: pata_amd

00:0d.0 IDE interface: NVIDIA Corporation MCP55 SATA Controller (rev a2)
(prog-if 85 [Master SecO PriO])
    Subsystem: ASUSTeK Computer Inc. Device cb84
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
    I/O ports at 09f0 [size=8]
    I/O ports at 0bf0 [size=4]
    I/O ports at 0970 [size=8]
    I/O ports at 0b70 [size=4]
    I/O ports at e000 [size=16]
    Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
    Capabilities: [b0] MSI: Enable- Count=1/4 Maskable- 64bit+
    Capabilities: [cc] HyperTransport: MSI Mapping Enable+ Fixed+
    Kernel driver in use: sata_nv

00:0d.1 IDE interface: NVIDIA Corporation MCP55 SATA Controller (rev a2)
(prog-if 85 [Master SecO PriO])
    Subsystem: ASUSTeK Computer Inc. Device cb84
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 20
    I/O ports at 09e0 [size=8]
    I/O ports at 0be0 [size=4]
    I/O ports at 0960 [size=8]
    I/O ports at 0b60 [size=4]
    I/O ports at cc00 [size=16]
    Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
    Capabilities: [b0] MSI: Enable- Count=1/4 Maskable- 64bit+
    Capabilities: [cc] HyperTransport: MSI Mapping Enable+ Fixed+
    Kernel driver in use: sata_nv

00:0d.2 IDE interface: NVIDIA Corporation MCP55 SATA Controller (rev a2)
(prog-if 85 [Master SecO PriO])
    Subsystem: ASUSTeK Computer Inc. Device cb84
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
    I/O ports at c800 [size=8]
    I/O ports at c400 [size=4]
    I/O ports at c000 [size=8]
    I/O ports at bc00 [size=4]
    I/O ports at b800 [size=16]
    Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
    Capabilities: [b0] MSI: Enable- Count=1/4 Maskable- 64bit+
    Capabilities: [cc] HyperTransport: MSI Mapping Enable+ Fixed+
    Kernel driver in use: sata_nv

00:0e.0 PCI bridge: NVIDIA Corporation MCP55 PCI bridge (rev a2) (prog-if 01
[Subtractive decode])
    Flags: bus master, 66MHz, fast devsel, latency 0
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
    Memory behind bridge: fdf00000-fdffffff
    Capabilities: [b8] Subsystem: NVIDIA Corporation Device cb84
    Capabilities: [8c] HyperTransport: MSI Mapping Enable+ Fixed-

00:0e.1 Audio device: NVIDIA Corporation MCP55 High Definition Audio (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 81f6
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 20
    Memory at fe020000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [44] Power Management version 2
    Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
    Capabilities: [6c] HyperTransport: MSI Mapping Enable+ Fixed+
    Kernel driver in use: snd_hda_intel

00:10.0 Bridge: NVIDIA Corporation MCP55 Ethernet (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device cb84
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 42
    Memory at fe02a000 (32-bit, non-prefetchable) [size=4K]
    I/O ports at b400 [size=8]
    Memory at fe029000 (32-bit, non-prefetchable) [size=256]
    Memory at fe028000 (32-bit, non-prefetchable) [size=16]
    Capabilities: [44] Power Management version 2
    Capabilities: [70] MSI-X: Enable- Count=8 Masked-
    Capabilities: [50] MSI: Enable+ Count=1/8 Maskable+ 64bit+
    Capabilities: [6c] HyperTransport: MSI Mapping Enable+ Fixed+
    Kernel driver in use: forcedeth

00:11.0 Bridge: NVIDIA Corporation MCP55 Ethernet (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device cb84
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
    Memory at fe027000 (32-bit, non-prefetchable) [size=4K]
    I/O ports at b000 [size=8]
    Memory at fe026000 (32-bit, non-prefetchable) [size=256]
    Memory at fe025000 (32-bit, non-prefetchable) [size=16]
    Capabilities: [44] Power Management version 2
    Capabilities: [70] MSI-X: Enable- Count=8 Masked-
    Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
    Capabilities: [6c] HyperTransport: MSI Mapping Enable+ Fixed+
    Kernel driver in use: forcedeth

00:16.0 PCI bridge: NVIDIA Corporation MCP55 PCI Express bridge (rev a2)
(prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 00009000-00009fff
    Memory behind bridge: fde00000-fdefffff
    Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
    Capabilities: [48] Power Management version 2
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
    Capabilities: [60] HyperTransport: MSI Mapping Enable+ Fixed-
    Capabilities: [80] Express Root Port (Slot+), MSI 00
    Capabilities: [100] Virtual Channel
    Kernel driver in use: pcieport

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
    Flags: fast devsel
    Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address
Map
    Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller
    Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
    Flags: fast devsel
    Capabilities: [f0] Secure device <?>
    Kernel driver in use: k8temp

01:00.0 VGA compatible controller: NVIDIA Corporation G71 [GeForce 7900 GS]
(rev a1) (prog-if 00 [VGA controller])
    Subsystem: eVga.com. Corp. Device e624
    Flags: bus master, fast devsel, latency 0, IRQ 16
    Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
    Memory at e0000000 (64-bit, prefetchable) [size=256M]
    Memory at fb000000 (64-bit, non-prefetchable) [size=16M]
    I/O ports at ac00 [size=128]
    [virtual] Expansion ROM at fcfe0000 [disabled] [size=128K]
    Capabilities: [60] Power Management version 2
    Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
    Capabilities: [78] Express Endpoint, MSI 00
    Capabilities: [100] Virtual Channel
    Capabilities: [128] Power Budgeting <?>
    Kernel driver in use: nvidia

02:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22A IEEE-1394a-2000
Controller (PHY/Link) [iOHCI-Lynx] (prog-if 10 [OHCI])
    Subsystem: ASUSTeK Computer Inc. P5W DH Deluxe Motherboard
    Flags: bus master, medium devsel, latency 32, IRQ 16
    Memory at fdfff000 (32-bit, non-prefetchable) [size=2K]
    Memory at fdff8000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: firewire_ohci

03:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid
II Controller (rev 01)
    Subsystem: ASUSTeK Computer Inc. Device 819f
    Flags: bus master, fast devsel, latency 0, IRQ 16
    Memory at fdeff000 (64-bit, non-prefetchable) [size=128]
    Memory at fdef8000 (64-bit, non-prefetchable) [size=16K]
    I/O ports at 9c00 [size=128]
    Expansion ROM at fde00000 [disabled] [size=512K]
    Capabilities: [54] Power Management version 2
    Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
    Capabilities: [70] Express Legacy Endpoint, MSI 00
    Capabilities: [100] Advanced Error Reporting
    Kernel driver in use: sata_sil24

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
