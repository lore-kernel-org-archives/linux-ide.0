From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Mon, 22 Oct 2012 15:48:03 +0000 (UTC)
Message-ID: <20121022154803.2AB5711FAE0@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35755 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab2JVPsH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2012 11:48:07 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 40B5A203D1
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 15:48:06 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 73AB9203EC
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 15:48:04 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #9 from Anonymous Emailer <anonymous@kernel-bugs.osdl.org>  2012-10-22 15:47:59 ---
Reply-To: phillip.wood@talktalk.net

On 10/21/2012 05:57 PM, Borislav Petkov wrote:
>
> What you can do, Phillip, is check whether some other specific PATA
> driver supports your hardware and enable it instead of PATA_ACPI. What
> does lspci on the box say? Or rather 'lspci -v' for more details. You
> can also send dmesg from the box.
>
lspci -v gives

00:00.0 Host bridge: ULi Electronics Inc. M1644/M1644T 
Northbridge+Trident (rev 01)
    Flags: bus master, medium devsel, latency 0
    Memory at f0000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [b0] AGP version 2.0
    Capabilities: [a4] Power Management version 1
    Kernel driver in use: agpgart-ali

00:01.0 PCI bridge: ULi Electronics Inc. PCI to AGP Controller (prog-if 
00 [Normal decode])
    Flags: bus master, slow devsel, latency 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    Memory behind bridge: f7f00000-fdffffff
    Prefetchable memory behind bridge: 30100000-301fffff

00:02.0 USB controller: ULi Electronics Inc. USB 1.1 Controller (rev 03) 
(prog-if 10 [OHCI])
    Subsystem: Toshiba America Info Systems Device 0004
    Flags: bus master, medium devsel, latency 64, IRQ 11
    Memory at f7eff000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [60] Power Management version 2
    Kernel driver in use: ohci_hcd

00:04.0 IDE interface: ULi Electronics Inc. M5229 IDE (rev c3) (prog-if f0)
    Subsystem: Toshiba America Info Systems Device 0004
    Flags: bus master, medium devsel, latency 64, IRQ 255
    [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
    [virtual] Memory at 000003f0 (type 3, non-prefetchable)
    [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
    [virtual] Memory at 00000370 (type 3, non-prefetchable)
    I/O ports at eff0 [size=16]
    Capabilities: [60] Power Management version 2
    Kernel driver in use: pata_ali

00:06.0 Multimedia audio controller: ULi Electronics Inc. M5451 PCI 
AC-Link Controller Audio Device (rev 01)
    Subsystem: Toshiba America Info Systems Device 0001
    Flags: bus master, medium devsel, latency 64, IRQ 11
    I/O ports at 1000 [size=256]
    Memory at 30001000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [dc] Power Management version 2
    Kernel driver in use: snd_ali5451

00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA 
Bridge [Aladdin IV/V/V+]
    Subsystem: Toshiba America Info Systems Device 0004
    Flags: bus master, medium devsel, latency 0
    Capabilities: [a0] Power Management version 1

00:08.0 Bridge: ULi Electronics Inc. M7101 Power Management Controller [PMU]
    Subsystem: Toshiba America Info Systems Device 0001
    Flags: medium devsel
    Kernel driver in use: ali1535_smbus

00:0a.0 Ethernet controller: Intel Corporation 82557/8/9/0/1 Ethernet 
Pro 100 (rev 0d)
    Subsystem: Toshiba America Info Systems 8255x-based Ethernet Adapter 
(10/100)
    Flags: bus master, medium devsel, latency 64, IRQ 11
    Memory at f7efe000 (32-bit, non-prefetchable) [size=4K]
    I/O ports at eec0 [size=64]
    Memory at f7ec0000 (32-bit, non-prefetchable) [size=128K]
    Capabilities: [dc] Power Management version 2
    Kernel driver in use: e100

00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to 
Cardbus Bridge with ZV Support (rev 32)
    Subsystem: Toshiba America Info Systems Device 0001
    Flags: bus master, slow devsel, latency 168, IRQ 11
    Memory at 30000000 (32-bit, non-prefetchable) [size=4K]
    Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
    Memory window 0: 34000000-37ffffff (prefetchable)
    Memory window 1: 38000000-3bffffff
    I/O window 0: 00001400-000014ff
    I/O window 1: 00001800-000018ff
    16-bit legacy interface ports at 0001
    Kernel driver in use: yenta_cardbus

00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to 
Cardbus Bridge with ZV Support (rev 32)
    Subsystem: Toshiba America Info Systems Device 0001
    Flags: bus master, slow devsel, latency 168, IRQ 11
    Memory at 3c000000 (32-bit, non-prefetchable) [size=4K]
    Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
    Memory window 0: 40000000-43ffffff (prefetchable)
    Memory window 1: 44000000-47ffffff
    I/O window 0: 00001c00-00001cff
    I/O window 1: 00002000-000020ff
    16-bit legacy interface ports at 0001
    Kernel driver in use: yenta_cardbus

00:12.0 System peripheral: Toshiba America Info Systems SD TypA 
Controller (rev 03)
    Subsystem: Toshiba America Info Systems Device 0001
    Flags: medium devsel, IRQ 255
    Memory at 30002000 (32-bit, non-prefetchable) [disabled] [size=512]
    Capabilities: [80] Power Management version 2

01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1 
(rev 82) (prog-if 00 [VGA controller])
    Subsystem: Toshiba America Info Systems Device 0001
    Flags: bus master, 66MHz, medium devsel, latency 8, IRQ 11
    Memory at fc000000 (32-bit, non-prefetchable) [size=32M]
    Memory at fbc00000 (32-bit, non-prefetchable) [size=4M]
    Memory at f8000000 (32-bit, non-prefetchable) [size=32M]
    Memory at f7ff8000 (32-bit, non-prefetchable) [size=32K]
    [virtual] Expansion ROM at 30100000 [disabled] [size=64K]
    Capabilities: [80] AGP version 2.0
    Capabilities: [90] Power Management version 2

06:00.0 Network controller: Broadcom Corporation BCM4306 802.11b/g 
Wireless LAN Controller (rev 03)
    Subsystem: Belkin F5D7011 v1000 High-Speed Mode Wireless G Notebook Card
    Flags: bus master, fast devsel, latency 64, IRQ 11
    Memory at 44000000 (32-bit, non-prefetchable) [size=8K]
    Kernel driver in use: b43-pci-bridge

If I blacklist pata_acpi and remove it from the initrd image then my 
unpatched distro kernel boots and seems to run fine (I've not checked if 
the hard drive power management is affected though). I've attached the 
dmesg from the patched kernel which was built with a minimal config.

Best Wishes

Phillip

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
