From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Mon, 22 Oct 2012 12:21:55 +0000 (UTC)
Message-ID: <20121022122155.B252A11FAE0@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56612 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990Ab2JVMV7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2012 08:21:59 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4993B2026F
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 12:21:57 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id BC2772026B
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 12:21:55 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #7 from Anton Boyarshinov <boyarsh@altlinux.org>  2012-10-22 12:21:55 ---
lspci -v from the box above
----------------
00:00.0 RAM memory: NVIDIA Corporation MCP65 Memory Controller (rev a3)
    Subsystem: Micro-Star International Co., Ltd. Device 7369
    Flags: bus master, 66MHz, fast devsel, latency 0
    Capabilities: [44] HyperTransport: Slave or Primary Interface
    Capabilities: [dc] HyperTransport: MSI Mapping Enable+ Fixed-

00:01.0 ISA bridge: NVIDIA Corporation MCP65 LPC Bridge (rev a3)
    Subsystem: Micro-Star International Co., Ltd. Device 7369
    Flags: bus master, 66MHz, fast devsel, latency 0
    I/O ports at 2f00 [size=256]

00:01.1 SMBus: NVIDIA Corporation MCP65 SMBus (rev a1)
    Subsystem: Micro-Star International Co., Ltd. Device 7369
    Flags: 66MHz, fast devsel, IRQ 11
    I/O ports at 2900 [size=64]
    I/O ports at 2d00 [size=64]
    I/O ports at 2e00 [size=64]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: nForce2_smbus

00:01.2 RAM memory: NVIDIA Corporation MCP65 Memory Controller (rev a1)
    Subsystem: Micro-Star International Co., Ltd. Device 7369
    Flags: 66MHz, fast devsel

00:02.0 USB controller: NVIDIA Corporation MCP65 USB Controller (rev a3)
(prog-if 10 [OHCI])
    Subsystem: Micro-Star International Co., Ltd. Device 7369
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
    Memory at f9eff000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: ohci_hcd

00:02.1 USB controller: NVIDIA Corporation MCP65 USB Controller (rev a3)
(prog-if 20 [EHCI])
    Subsystem: Micro-Star International Co., Ltd. Device 7369
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
    Memory at f9efec00 (32-bit, non-prefetchable) [size=256]
    Capabilities: [44] Debug port: BAR=1 offset=0098
    Capabilities: [80] Power Management version 2
    Kernel driver in use: ehci_hcd

00:08.0 PCI bridge: NVIDIA Corporation MCP65 PCI bridge (rev a1) (prog-if 01
[Subtractive decode])
    Flags: bus master, 66MHz, fast devsel, latency 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
    Capabilities: [b8] Subsystem: Micro-Star International Co., Ltd. Device
7369
    Capabilities: [8c] HyperTransport: MSI Mapping Enable- Fixed-

00:09.0 IDE interface: NVIDIA Corporation MCP65 IDE (rev a1) (prog-if 8a
[Master SecP PriP])
    Subsystem: Micro-Star International Co., Ltd. Device 7369
    Flags: bus master, 66MHz, fast devsel, latency 0
    [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
    [virtual] Memory at 000003f0 (type 3, non-prefetchable)
    [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
    [virtual] Memory at 00000370 (type 3, non-prefetchable)
    I/O ports at ffa0 [size=16]
    Capabilities: [44] Power Management version 2
    Kernel driver in use: pata_acpi

00:0a.0 IDE interface: NVIDIA Corporation MCP65 SATA Controller (rev a3)
(prog-if 85 [Master SecO PriO])
    Subsystem: Micro-Star International Co., Ltd. Device 7369
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
    I/O ports at 0f80 [size=8]
    I/O ports at 0f00 [size=4]
    I/O ports at 0e80 [size=8]
    I/O ports at 0e00 [size=4]
    I/O ports at b800 [size=16]
    Memory at f9efc000 (32-bit, non-prefetchable) [size=8K]
    Capabilities: [44] Power Management version 2
    Capabilities: [b0] MSI: Enable- Count=1/8 Maskable- 64bit+
    Capabilities: [cc] HyperTransport: MSI Mapping Enable- Fixed+
    Kernel driver in use: pata_acpi

00:0b.0 PCI bridge: NVIDIA Corporation Device 045b (rev a1) (prog-if 00 [Normal
decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
    Capabilities: [48] Power Management version 2
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
    Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
    Capabilities: [80] Express Root Port (Slot+), MSI 00
    Capabilities: [100] Virtual Channel
    Kernel driver in use: pcieport

00:0c.0 PCI bridge: NVIDIA Corporation MCP65 PCI Express bridge (rev a1)
(prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 0000d000-0000dfff
    Memory behind bridge: f9f00000-f9ffffff
    Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
    Capabilities: [48] Power Management version 2
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
    Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
    Capabilities: [80] Express Root Port (Slot+), MSI 00
    Capabilities: [100] Virtual Channel
    Kernel driver in use: pcieport

00:0d.0 PCI bridge: NVIDIA Corporation MCP65 PCI Express bridge (rev a1)
(prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
    I/O behind bridge: 0000e000-0000efff
    Memory behind bridge: fa000000-febfffff
    Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
    Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
    Capabilities: [48] Power Management version 2
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
    Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
    Capabilities: [80] Express Root Port (Slot+), MSI 00
    Capabilities: [100] Virtual Channel
    Kernel driver in use: pcieport

00:0e.0 PCI bridge: NVIDIA Corporation MCP65 PCI Express bridge (rev a1)
(prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
    Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
    Capabilities: [48] Power Management version 2
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
    Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
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

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI
Express Gigabit Ethernet controller (rev 01)
    Subsystem: Micro-Star International Co., Ltd. Device 369c
    Flags: bus master, fast devsel, latency 0, IRQ 44
    I/O ports at d800 [size=256]
    Memory at f9fff000 (64-bit, non-prefetchable) [size=4K]
    Expansion ROM at f9fc0000 [disabled] [size=128K]
    Capabilities: [40] Power Management version 2
    Capabilities: [48] Vital Product Data
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
    Capabilities: [60] Express Endpoint, MSI 00
    Capabilities: [84] Vendor Specific Information: Len=4c <?>
    Capabilities: [100] Advanced Error Reporting
    Capabilities: [12c] Virtual Channel
    Capabilities: [148] Device Serial Number 1d-00-00-00-10-ec-81-68
    Capabilities: [154] Power Budgeting <?>
    Kernel driver in use: r8169

04:00.0 VGA compatible controller: NVIDIA Corporation G84 [GeForce 8600 GT]
(rev a1) (prog-if 00 [VGA controller])
    Flags: bus master, fast devsel, latency 0, IRQ 18
    Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
    Memory at d0000000 (64-bit, prefetchable) [size=256M]
    Memory at fa000000 (64-bit, non-prefetchable) [size=32M]
    I/O ports at ec00 [size=128]
    Expansion ROM at febe0000 [disabled] [size=128K]
    Capabilities: [60] Power Management version 2
    Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
    Capabilities: [78] Express Endpoint, MSI 00
    Capabilities: [100] Virtual Channel
    Capabilities: [128] Power Budgeting <?>
    Capabilities: [600] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
    Kernel driver in use: nouveau

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
