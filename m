From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Mon, 22 Oct 2012 12:42:35 +0000 (UTC)
Message-ID: <20121022124235.7460211FAE0@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:57205 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab2JVMmo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2012 08:42:44 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 262FD201B4
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 12:42:43 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id B2C9D20185
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 12:42:36 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #8 from Anton Boyarshinov <boyarsh@altlinux.org>  2012-10-22 12:42:35 ---
lspci -v from another box with the same problem and the same reaction on this
workaround.
---------------------------
00:00.0 RAM memory: NVIDIA Corporation C51 Host Bridge (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: bus master, 66MHz, fast devsel, latency 0
    Capabilities: [44] HyperTransport: Slave or Primary Interface
    Capabilities: [e0] HyperTransport: MSI Mapping Enable+ Fixed-

00:00.1 RAM memory: NVIDIA Corporation C51 Memory Controller 0 (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: 66MHz, fast devsel

00:00.2 RAM memory: NVIDIA Corporation C51 Memory Controller 1 (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: 66MHz, fast devsel

00:00.3 RAM memory: NVIDIA Corporation C51 Memory Controller 5 (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: 66MHz, fast devsel

00:00.4 RAM memory: NVIDIA Corporation C51 Memory Controller 4 (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: bus master, 66MHz, fast devsel, latency 0

00:00.5 RAM memory: NVIDIA Corporation C51 Host Bridge (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: bus master, 66MHz, fast devsel, latency 0
    Capabilities: [44] #00 [00fe]
    Capabilities: [fc] #00 [0000]

00:00.6 RAM memory: NVIDIA Corporation C51 Memory Controller 3 (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: 66MHz, fast devsel

00:00.7 RAM memory: NVIDIA Corporation C51 Memory Controller 2 (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: 66MHz, fast devsel

00:02.0 PCI bridge: NVIDIA Corporation C51 PCI Express Bridge (rev a1) (prog-if
00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000a000-0000afff
    Memory behind bridge: fdd00000-fddfffff
    Prefetchable memory behind bridge: 00000000fda00000-00000000fdafffff
    Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
    Capabilities: [48] Power Management version 2
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
    Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
    Capabilities: [80] Express Root Port (Slot+), MSI 00
    Capabilities: [100] Virtual Channel
    Kernel driver in use: pcieport

00:03.0 PCI bridge: NVIDIA Corporation C51 PCI Express Bridge (rev a1) (prog-if
00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 00008000-00008fff
    Memory behind bridge: fd900000-fd9fffff
    Prefetchable memory behind bridge: 00000000fde00000-00000000fdefffff
    Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
    Capabilities: [48] Power Management version 2
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
    Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
    Capabilities: [80] Express Root Port (Slot+), MSI 00
    Capabilities: [100] Virtual Channel
    Kernel driver in use: pcieport

00:04.0 PCI bridge: NVIDIA Corporation C51 PCI Express Bridge (rev a1) (prog-if
00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 0000b000-0000bfff
    Memory behind bridge: fa000000-fcffffff
    Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff
    Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
    Capabilities: [48] Power Management version 2
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
    Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
    Capabilities: [80] Express Root Port (Slot+), MSI 00
    Capabilities: [100] Virtual Channel
    Kernel driver in use: pcieport

00:09.0 RAM memory: NVIDIA Corporation MCP51 Host Bridge (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: bus master, 66MHz, fast devsel, latency 0
    Capabilities: [44] HyperTransport: Slave or Primary Interface
    Capabilities: [e0] HyperTransport: MSI Mapping Enable- Fixed-

00:0a.0 ISA bridge: NVIDIA Corporation MCP51 LPC Bridge (rev a3)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: bus master, 66MHz, fast devsel, latency 0

00:0a.1 SMBus: NVIDIA Corporation MCP51 SMBus (rev a3)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: 66MHz, fast devsel, IRQ 5
    I/O ports at 4c00 [size=64]
    I/O ports at 4c40 [size=64]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: nForce2_smbus

00:0a.2 RAM memory: NVIDIA Corporation MCP51 Memory Controller 0 (rev a3)
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: 66MHz, fast devsel

00:0b.0 USB controller: NVIDIA Corporation MCP51 USB Controller (rev a3)
(prog-if 10 [OHCI])
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
    Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: ohci_hcd

00:0b.1 USB controller: NVIDIA Corporation MCP51 USB Controller (rev a3)
(prog-if 20 [EHCI])
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
    Memory at fe02e000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [44] Debug port: BAR=1 offset=0098
    Capabilities: [80] Power Management version 2
    Kernel driver in use: ehci_hcd

00:0d.0 IDE interface: NVIDIA Corporation MCP51 IDE (rev a1) (prog-if 8a
[Master SecP PriP])
    Subsystem: ASUSTeK Computer Inc. Device 81c0
    Flags: bus master, 66MHz, fast devsel, latency 0
    [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
    [virtual] Memory at 000003f0 (type 3, non-prefetchable)
    [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
    [virtual] Memory at 00000370 (type 3, non-prefetchable)
    I/O ports at f400 [size=16]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: pata_acpi

00:0e.0 IDE interface: NVIDIA Corporation MCP51 Serial ATA Controller (rev a1)
(prog-if 85 [Master SecO PriO])
    Subsystem: ASUSTeK Computer Inc. Device 81c0
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
    Kernel driver in use: pata_acpi

00:0f.0 IDE interface: NVIDIA Corporation MCP51 Serial ATA Controller (rev a1)
(prog-if 85 [Master SecO PriO])
    Subsystem: ASUSTeK Computer Inc. Device 81c0
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
    Kernel driver in use: pata_acpi

00:10.0 PCI bridge: NVIDIA Corporation MCP51 PCI Bridge (rev a2) (prog-if 01
[Subtractive decode])
    Flags: bus master, 66MHz, fast devsel, latency 0
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=128
    I/O behind bridge: 00009000-00009fff
    Memory behind bridge: fdc00000-fdcfffff
    Prefetchable memory behind bridge: fdb00000-fdbfffff
    Capabilities: [b8] Subsystem: Gammagraphx, Inc. (or missing ID) Device 0000
    Capabilities: [8c] HyperTransport: MSI Mapping Enable+ Fixed-

00:10.1 Audio device: NVIDIA Corporation MCP51 High Definition Audio (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 81cb
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
    Memory at fe024000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [44] Power Management version 2
    Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
    Capabilities: [6c] HyperTransport: MSI Mapping Enable+ Fixed+
    Kernel driver in use: snd_hda_intel

00:14.0 Bridge: NVIDIA Corporation MCP51 Ethernet Controller (rev a3)
    Subsystem: ASUSTeK Computer Inc. Device 816a
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
    Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
    I/O ports at c800 [size=8]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: forcedeth

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

03:00.0 VGA compatible controller: NVIDIA Corporation G73 [GeForce 7600 GS]
(rev a1) (prog-if 00 [VGA controller])
    Subsystem: Giga-byte Technology Device 341a
    Flags: bus master, fast devsel, latency 0, IRQ 5
    Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
    Memory at e0000000 (64-bit, prefetchable) [size=256M]
    Memory at fb000000 (64-bit, non-prefetchable) [size=16M]
    I/O ports at bc00 [size=128]
    Expansion ROM at fcfe0000 [disabled] [size=128K]
    Capabilities: [60] Power Management version 2
    Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
    Capabilities: [78] Express Endpoint, MSI 00
    Capabilities: [100] Virtual Channel
    Capabilities: [128] Power Budgeting <?>

04:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22A IEEE-1394a-2000
Controller (PHY/Link) [iOHCI-Lynx] (prog-if 10 [OHCI])
    Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
    Flags: bus master, medium devsel, latency 32, IRQ 19
    Memory at fdcff000 (32-bit, non-prefetchable) [size=2K]
    Memory at fdcf8000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: firewire_ohci

04:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
    Subsystem: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
    Flags: bus master, medium devsel, latency 32, IRQ 17
    I/O ports at 9c00 [size=256]
    Memory at fdcfe000 (32-bit, non-prefetchable) [size=256]
    Expansion ROM at fdce0000 [disabled] [size=64K]
    Capabilities: [50] Power Management version 2
    Kernel driver in use: 8139too

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
