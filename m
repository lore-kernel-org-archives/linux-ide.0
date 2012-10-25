From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Thu, 25 Oct 2012 14:31:17 +0000 (UTC)
Message-ID: <20121025143117.3A99811FB82@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:34204 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759762Ab2JYObV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2012 10:31:21 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4FAAB204B2
	for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2012 14:31:20 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 692AF204B6
	for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2012 14:31:18 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151


Marius Cirsta <mforce2@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mforce2@gmail.com




--- Comment #27 from Marius Cirsta <mforce2@gmail.com>  2012-10-25 14:31:16 ---
 I'm also getting this with the 3.6 kernel, it's comming from initrd which
seems to be using dracut. 

 Here's the lspci -v:

lspci -v
00:00.0 Host bridge: Intel Corporation 82Q35 Express DRAM Controller (rev 02)
        Subsystem: Lenovo Device 3037
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information <?>
        Kernel driver in use: agpgart-intel
        Kernel modules: intel-agp

00:02.0 VGA compatible controller: Intel Corporation 82Q35 Express Integrated
Graphics Controller (rev 02) (prog-if 00 [VGA controller])
        Subsystem: Lenovo Device 3037
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at d4400000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 1c70 [size=8]
        Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Memory at d4300000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Count=1/1
Enable-
        Capabilities: [d0] Power Management version 2

00:02.1 Display controller: Intel Corporation 82Q35 Express Integrated Graphics
Controller (rev 02)
        Subsystem: Lenovo Device 3037
        Flags: fast devsel
        Memory at d4500000 (32-bit, non-prefetchable) [disabled] [size=512K]
        Capabilities: [d0] Power Management version 2

00:03.0 Communication controller: Intel Corporation 82Q35 Express MEI
Controller (rev 02)
        Subsystem: Lenovo Device 3037
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at d46a6000 (64-bit, non-prefetchable) [size=16]
        Capabilities: [50] Power Management version 3
        Capabilities: [8c] Message Signalled Interrupts: Mask- 64bit+ Count=1/1
Enable-
        Kernel driver in use: heci
        Kernel modules: heci

00:03.2 IDE interface: Intel Corporation 82Q35 Express PT IDER Controller (rev
02) (prog-if 85 [Master SecO PriO])
        Subsystem: Lenovo Device 3037
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        I/O ports at 1c88 [disabled] [size=8]
        I/O ports at 1c7c [disabled] [size=4]
        I/O ports at 1c80 [disabled] [size=8]
        I/O ports at 1c78 [disabled] [size=4]
        I/O ports at 1c20 [disabled] [size=16]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Count=1/1
Enable-
        Kernel modules: ide-pci-generic, ata_generic, pata_acpi

00:03.3 Serial controller: Intel Corporation 82Q35 Express Serial KT Controller
(rev 02) (prog-if 02 [16550])
        Subsystem: Lenovo Device 3037
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 17
        I/O ports at 1c90 [size=8]
        Memory at d44a4000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Count=1/1
Enable-
        Kernel driver in use: serial

00:19.0 Ethernet controller: Intel Corporation 82566DM-2 Gigabit Network
Connection (rev 02)
        Subsystem: Lenovo Device 3037
        Flags: bus master, fast devsel, latency 0, IRQ 4351
        Memory at d4480000 (32-bit, non-prefetchable) [size=128K]
        Memory at d44a5000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 1820 [size=32]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Count=1/1
Enable+
        Capabilities: [e0] PCIe advanced features <?>
        Kernel driver in use: e1000e
        Kernel modules: e1000e

00:1a.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Lenovo Device 3037
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at 1840 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:1a.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #5 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Lenovo Device 3037
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at 1860 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:1a.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #6 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Lenovo Device 3037
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at 1880 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:1a.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI
Controller #2 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Lenovo Device 3037
        Flags: bus master, medium devsel, latency 0, IRQ 18
        Memory at d46a6800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Capabilities: [98] PCIe advanced features <?>
        Kernel driver in use: ehci_hcd
        Kernel modules: ehci-hcd

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio
Controller (rev 02)
        Subsystem: Lenovo Device 3037
        Flags: bus master, fast devsel, latency 0, IRQ 3
        Memory at d44a0000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Count=1/1
Enable-
        Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [130] Root Complex Link <?>
        Kernel modules: snd-hda-intel

00:1d.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Lenovo Device 3037
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at 18a0 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:1d.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Lenovo Device 3037
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at 18c0 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:1d.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Lenovo Device 3037
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at 18e0 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:1d.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI
Controller #1 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Lenovo Device 3037
        Flags: bus master, medium devsel, latency 0, IRQ 16
        Memory at d46a6c00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Capabilities: [98] PCIe advanced features <?>
        Kernel driver in use: ehci_hcd
        Kernel modules: ehci-hcd

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92) (prog-if 01
[Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=11, subordinate=11, sec-latency=32
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: d0000000-d42fffff
        Capabilities: [50] Subsystem: Lenovo Device 3037

00:1f.0 ISA bridge: Intel Corporation 82801IO (ICH9DO) LPC Interface Controller
(rev 02)
        Subsystem: Lenovo Device 3037
        Flags: bus master, medium devsel, latency 0
        Capabilities: [e0] Vendor Specific Information <?>
        Kernel modules: iTCO_wdt

00:1f.2 IDE interface: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 4 port
SATA IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Lenovo Device 3037
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 17
        I/O ports at 01f0 [size=8]
        I/O ports at 03f4 [size=1]
        I/O ports at 0170 [size=8]
        I/O ports at 0374 [size=1]
        I/O ports at 1c40 [size=16]
        I/O ports at 1c30 [size=16]
        Capabilities: [70] Power Management version 3
        Capabilities: [b0] PCIe advanced features <?>
        Kernel driver in use: ata_piix
        Kernel modules: ide-pci-generic, ata_generic, pata_acpi, ata_piix

00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
        Subsystem: Lenovo Device 3037
        Flags: medium devsel, IRQ 17
        Memory at d46a7000 (64-bit, non-prefetchable) [size=256]
        I/O ports at 1c00 [size=32]
        Kernel driver in use: i801_smbus
        Kernel modules: i2c-i801

00:1f.5 IDE interface: Intel Corporation 82801I (ICH9 Family) 2 port SATA IDE
Controller (rev 02) (prog-if 85 [Master SecO PriO])
        Subsystem: Lenovo Device 3037
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
        I/O ports at 1cc0 [size=8]
        I/O ports at 1cb4 [size=4]
        I/O ports at 1cb8 [size=8]
        I/O ports at 1cb0 [size=4]
        I/O ports at 1c60 [size=16]
        I/O ports at 1c50 [size=16]
        Capabilities: [70] Power Management version 3
        Capabilities: [b0] PCIe advanced features <?>
        Kernel driver in use: ata_piix
        Kernel modules: ide-pci-generic, ata_generic, pata_acpi, ata_piix

11:0a.0 Audio device: Creative Labs SB X-Fi
        Subsystem: Creative Labs Device 6007
        Flags: bus master, medium devsel, latency 32, IRQ 22
        Memory at d4200000 (32-bit, non-prefetchable) [size=16K]
        Memory at d4000000 (64-bit, non-prefetchable) [size=2M]
        Memory at d0000000 (64-bit, non-prefetchable) [size=64M]
        I/O ports at 2000 [size=32]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Count=1/1
Enable-
        Kernel driver in use: CTALSA
        Kernel modules: ctxfi

 The machine is an Intel based one as you can see. Happens on every boot.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
