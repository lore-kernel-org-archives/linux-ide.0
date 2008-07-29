From: "Felipe Sere" <dodofxp@gmail.com>
Subject: Re: ata_piix problem with MacBook Pro and 2.6.26
Date: Tue, 29 Jul 2008 07:55:52 +0200
Message-ID: <da38d7b90807282255l5aabd1c7lb763307a5bac9c64@mail.gmail.com>
References: <da38d7b90807240227q165cb5elad937973a58bf88f@mail.gmail.com>
	 <488D757B.6000002@gmail.com>
	 <da38d7b90807280101y44ef5624of99f7038967405a6@mail.gmail.com>
	 <da38d7b90807281154p6cd45e0pf0acd83cd583d06a@mail.gmail.com>
	 <488E7D0F.4040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.156]:40013 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbYG2Fzx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2008 01:55:53 -0400
Received: by po-out-1718.google.com with SMTP id c31so9488819poi.1
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 22:55:52 -0700 (PDT)
In-Reply-To: <488E7D0F.4040204@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, Jul 29, 2008 at 4:14 AM, Tejun Heo <htejun@gmail.com> wrote:
> Felipe Sere wrote:
>> 00:1f.2 IDE interface [0101]: Intel Corporation 82801HBM/HEM
>
>> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>
> The apple workaround is not kicking in probably because your machine has
> different subsystem id which doesn't show in lspci -nn output.  Can you
> please post "lspci -nnv" result?
>
> --
> tejun
>

Here is the output of lspci -nnv:
00:00.0 Host bridge [0600]: Intel Corporation Mobile PM965/GM965/GL960
Memory Controller Hub [8086:2a00] (rev 03)
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information <?>
	Kernel modules: intel-agp

00:01.0 PCI bridge [0604]: Intel Corporation Mobile PM965/GM965/GL960
PCI Express Root Port [8086:2a01] (rev 03) (prog-if 00 [Normal
decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00007000-00007fff
	Memory behind bridge: 90000000-930fffff
	Prefetchable memory behind bridge: 0000000080000000-000000008fffffff
	Capabilities: [88] Subsystem: Intel Corporation Unknown device [8086:0000]
	Capabilities: [80] Power Management version 3
	Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [a0] Express Root Port (Slot+), MSI 00
	Kernel driver in use: pcieport-driver

00:1a.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #4 [8086:2834] (rev 03) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 0, IRQ 20
	I/O ports at 80c0 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1a.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #5 [8086:2835] (rev 03) (prog-if 00 [UHCI])
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at 80a0 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1a.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB2 EHCI Controller #2 [8086:283a] (rev 03) (prog-if 20 [EHCI])
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, medium devsel, latency 0, IRQ 21
	Memory at 9b504c00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd

00:1b.0 Audio device [0403]: Intel Corporation 82801H (ICH8 Family) HD
Audio Controller [8086:284b] (rev 03)
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, fast devsel, latency 0, IRQ 20
	Memory at 9b500000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
	Kernel driver in use: HDA Intel
	Kernel modules: snd-hda-intel

00:1c.0 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 1 [8086:283f] (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: 9b400000-9b4fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [90] Subsystem: Gammagraphx, Inc. Unknown device [0000:0000]
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport-driver

00:1c.2 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 3 [8086:2843] (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=0a, sec-latency=0
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: 97400000-9b3fffff
	Prefetchable memory behind bridge: 0000000093100000-00000000970fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [90] Subsystem: Gammagraphx, Inc. Unknown device [0000:0000]
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport-driver

00:1c.4 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 5 [8086:2847] (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=0b, subordinate=0b, sec-latency=0
	Memory behind bridge: 97300000-973fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [90] Subsystem: Gammagraphx, Inc. Unknown device [0000:0000]
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport-driver

00:1c.5 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 6 [8086:2849] (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=0c, subordinate=0c, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: 97200000-972fffff
	Prefetchable memory behind bridge: 000000009b600000-000000009b6fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [90] Subsystem: Gammagraphx, Inc. Unknown device [0000:0000]
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport-driver

00:1d.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #1 [8086:2830] (rev 03) (prog-if 00 [UHCI])
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at 8080 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1d.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #2 [8086:2831] (rev 03) (prog-if 00 [UHCI])
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at 8060 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1d.2 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #3 [8086:2832] (rev 03) (prog-if 00 [UHCI])
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, medium devsel, latency 0, IRQ 21
	I/O ports at 8040 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1d.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB2 EHCI Controller #1 [8086:2836] (rev 03) (prog-if 20 [EHCI])
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, medium devsel, latency 0, IRQ 20
	Memory at 9b504800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd

00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
[8086:2448] (rev f3) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=0d, subordinate=0d, sec-latency=32
	Memory behind bridge: 97100000-971fffff
	Capabilities: [50] Subsystem: Gammagraphx, Inc. Unknown device [0000:0000]

00:1f.0 ISA bridge [0601]: Intel Corporation 82801HEM (ICH8M) LPC
Interface Controller [8086:2815] (rev 03)
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information <?>

00:1f.1 IDE interface [0101]: Intel Corporation 82801HBM/HEM
(ICH8M/ICH8M-E) IDE Controller [8086:2850] (rev 03) (prog-if 8f
[Master SecP SecO PriP PriO])
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, medium devsel, latency 0, IRQ 21
	I/O ports at 8108 [size=8]
	I/O ports at 811c [size=4]
	I/O ports at 8100 [size=8]
	I/O ports at 8118 [size=4]
	I/O ports at 80e0 [size=16]
	Kernel driver in use: ata_piix

00:1f.2 IDE interface [0101]: Intel Corporation 82801HBM/HEM
(ICH8M/ICH8M-E) SATA IDE Controller [8086:2828] (rev 03) (prog-if 8f
[Master SecP SecO PriP PriO])
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
	I/O ports at 80f8 [size=8]
	I/O ports at 8114 [size=4]
	I/O ports at 80f0 [size=8]
	I/O ports at 8110 [size=4]
	I/O ports at 8020 [size=16]
	I/O ports at 4000 [size=16]
	Capabilities: [70] Power Management version 3
	Kernel driver in use: ata_piix

00:1f.3 SMBus [0c05]: Intel Corporation 82801H (ICH8 Family) SMBus
Controller [8086:283e] (rev 03)
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: medium devsel, IRQ 20
	Memory at 9b505000 (32-bit, non-prefetchable) [size=256]
	I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c-i801

01:00.0 VGA compatible controller [0300]: nVidia Corporation GeForce
8600M GT [10de:0407] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: Apple Computer Inc. Unknown device [106b:00a3]
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at 92000000 (32-bit, non-prefetchable) [size=16M]
	Memory at 80000000 (64-bit, prefetchable) [size=256M]
	Memory at 90000000 (64-bit, non-prefetchable) [size=32M]
	I/O ports at 7000 [size=128]
	[virtual] Expansion ROM at 93000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [78] Express Endpoint, MSI 00
	Kernel driver in use: nvidia
	Kernel modules: nvidia, nvidiafb

0b:00.0 Network controller [0280]: Broadcom Corporation BCM4328
802.11a/b/g/n [14e4:4328] (rev 05)
	Subsystem: Apple Computer Inc. Unknown device [106b:008c]
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at 97300000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [58] Vendor Specific Information <?>
	Capabilities: [e8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [d0] Express Endpoint, MSI 00
	Kernel driver in use: b43-pci-bridge
	Kernel modules: ssb

0c:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd.
Marvell Yukon 88E8058 PCI-E Gigabit Ethernet Controller [11ab:436a]
(rev 13)
	Subsystem: Marvell Technology Group Ltd. Unknown device [11ab:00ba]
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Memory at 97200000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at 5000 [size=256]
	Expansion ROM at 9b600000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 3
	Capabilities: [50] Vital Product Data <?>
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [e0] Express Legacy Endpoint, MSI 00
	Kernel driver in use: sky2
	Kernel modules: sky2

0d:03.0 FireWire (IEEE 1394) [0c00]: Texas Instruments TSB82AA2
IEEE-1394b Link Layer Controller [104c:8025] (rev 02) (prog-if 10
[OHCI])
	Flags: bus master, medium devsel, latency 248, IRQ 19
	Memory at 97104000 (32-bit, non-prefetchable) [size=2K]
	Memory at 97100000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
	Kernel driver in use: ohci1394
	Kernel modules: ohci1394



-- 
Felipe Sere
