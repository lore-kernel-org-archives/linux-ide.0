From: Robin Humble <rjh@cita.utoronto.ca>
Subject: 2.6.20-rc4, ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
Date: Fri, 12 Jan 2007 11:27:54 -0500
Message-ID: <20070112162754.GA384@lemming.cita.utoronto.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from quail.cita.utoronto.ca ([128.100.76.6]:34051 "EHLO
	quail.cita.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302AbXALRUJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 12:20:09 -0500
Received: from cita.utoronto.ca (lemming.cita.utoronto.ca [128.100.76.53])
	by quail.cita.utoronto.ca (8.13.1/8.13.1) with ESMTP id l0CGRsaT005170
	for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 11:27:54 -0500
Received: from lemming.cita.utoronto.ca (localhost [127.0.0.1])
	by cita.utoronto.ca (8.13.8/8.12.8) with ESMTP id l0CGRsAa008461
	for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 11:27:54 -0500
Received: (from rjh@localhost)
	by lemming.cita.utoronto.ca (8.13.8/8.13.8/Submit) id l0CGRshG008460
	for linux-ide@vger.kernel.org; Fri, 12 Jan 2007 11:27:54 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


in 2.6.20-rc4 I see a bunch of these guys:
  ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x1ff)
  ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3f)
  ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
  ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
which I don't see with 2.6.19.2.
I've tried this on 2 identical machines and it seems repeatable.
I get one or two of the above lines for each hdparm -Tt that runs.

is this something to be worried about?

judging from previous threads it may be relevant that ncq is now on:
  dmesg.2.6.20-rc4  ahci 0000:00:1f.2: flags: 64bit ncq pm led pmp slum part 
  dmesg.2.6.19.2    ahci 0000:00:1f.2: flags: 64bit stag led pmp 

it's an (8086:2681) SATA controller which I believe is ESB2.
lspci -v and dmesg for each kernel attached. OS is CentOS 4.4, x86_64.
BIOS is in enhanced ahci mode. versions:
  Serial ATA AHCI BIOS, Version iSrc 1.08 09252006
  Bios Version: S5000.86B.04.00.0066.101220061333
  Platform ID:  S5000PAL

cheers,
robin

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci-v

00:00.0 Host bridge: Intel Corporation 5000P Chipset Memory Controller Hub (rev 93)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, fast devsel, latency 0
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
	Capabilities: [6c] Express Root Port (Slot-) IRQ 0

00:02.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x8 Port 2-3 (rev 93) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=06, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: b8800000-b91fffff
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable+
	Capabilities: [6c] Express Root Port (Slot-) IRQ 0

00:03.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 Port 3 (rev 93) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable+
	Capabilities: [6c] Express Root Port (Slot-) IRQ 0

00:04.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x8 Port 4-5 (rev 93) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
	Memory behind bridge: b9300000-b93fffff
	Prefetchable memory behind bridge: 00000000b8000000-00000000b8700000
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable+
	Capabilities: [6c] Express Root Port (Slot+) IRQ 0

00:05.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 Port 5 (rev 93) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable+
	Capabilities: [6c] Express Root Port (Slot-) IRQ 0

00:06.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 Port 6 (rev 93) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=0
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable+
	Capabilities: [6c] Express Root Port (Slot+) IRQ 0

00:07.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 Port 7 (rev 93) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=0b, subordinate=0b, sec-latency=0
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable+
	Capabilities: [6c] Express Root Port (Slot+) IRQ 0

00:08.0 System peripheral: Intel Corporation 5000 Series Chipset DMA Engine (rev 93)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, fast devsel, latency 0, IRQ 1
	Memory at fe700000 (64-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [6c] Express Unknown type IRQ 0

00:10.0 Host bridge: Intel Corporation 5000 Series Chipset Error Reporting Registers (rev 93)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: fast devsel

00:10.1 Host bridge: Intel Corporation 5000 Series Chipset Error Reporting Registers (rev 93)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: fast devsel

00:10.2 Host bridge: Intel Corporation 5000 Series Chipset Error Reporting Registers (rev 93)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: fast devsel

00:11.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved Registers (rev 93)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: fast devsel

00:13.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved Registers (rev 93)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: fast devsel

00:15.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Registers (rev 93)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: fast devsel

00:16.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Registers (rev 93)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: fast devsel

00:1d.0 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI USB Controller #1 (rev 09) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, medium devsel, latency 0, IRQ 23
	I/O ports at 30a0 [size=32]

00:1d.1 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI USB Controller #2 (rev 09) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, medium devsel, latency 0, IRQ 22
	I/O ports at 3080 [size=32]

00:1d.2 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI USB Controller #3 (rev 09) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, medium devsel, latency 0, IRQ 23
	I/O ports at 3060 [size=32]

00:1d.3 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI USB Controller #4 (rev 09) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, medium devsel, latency 0, IRQ 22
	I/O ports at 3040 [size=32]

00:1d.7 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset EHCI USB2 Controller (rev 09) (prog-if 20 [EHCI])
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at b9400400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d9) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=0c, subordinate=0c, sec-latency=32
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: b9200000-b92fffff
	Prefetchable memory behind bridge: 00000000b0000000-00000000b7f00000
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 631xESB/632xESB/3100 Chipset LPC Interface Controller (rev 09)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 631xESB/632xESB IDE Controller (rev 09) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, medium devsel, latency 0, IRQ 20
	I/O ports at 01f0 [size=8]
	I/O ports at 03f4 [size=1]
	I/O ports at 0170 [size=8]
	I/O ports at 0374 [size=1]
	I/O ports at 30c0 [size=16]

00:1f.2 SATA controller: Intel Corporation 631xESB/632xESB SATA Storage Controller AHCI (rev 09) (prog-if 01 [AHCI 1.0])
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 20
	I/O ports at 30d8 [size=8]
	I/O ports at 30f4 [size=4]
	I/O ports at 30d0 [size=8]
	I/O ports at 30f0 [size=4]
	I/O ports at 3020 [size=32]
	Memory at b9400000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2
	Capabilities: [a8] #12 [0010]

00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus Controller (rev 09)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: medium devsel, IRQ 20
	I/O ports at 3000 [size=32]

01:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Upstream Port (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: b8800000-b90fffff
	Capabilities: [44] Express Upstream Port IRQ 0
	Capabilities: [70] Power Management version 2
	Capabilities: [80] #0d [0000]

01:00.3 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express to PCI-X Bridge (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=01, secondary=06, subordinate=06, sec-latency=64
	Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
	Capabilities: [6c] Power Management version 2
	Capabilities: [80] #0d [0000]
	Capabilities: [d8] PCI-X bridge device.

02:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Downstream Port E1 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
	Capabilities: [44] Express Downstream Port (Slot+) IRQ 0
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable+
	Capabilities: [70] Power Management version 2
	Capabilities: [80] #0d [0000]

02:01.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Downstream Port E2 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
	Capabilities: [44] Express Downstream Port (Slot-) IRQ 0
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable+
	Capabilities: [70] Power Management version 2
	Capabilities: [80] #0d [0000]

02:02.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Downstream Port E3 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: b8800000-b90fffff
	Capabilities: [44] Express Downstream Port (Slot-) IRQ 0
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable+
	Capabilities: [70] Power Management version 2
	Capabilities: [80] #0d [0000]

05:00.0 Ethernet controller: Intel Corporation 631xESB/632xESB DPT LAN Controller Copper (rev 01)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, fast devsel, latency 0, IRQ 374
	Memory at b9020000 (32-bit, non-prefetchable) [size=128K]
	Memory at b8c00000 (32-bit, non-prefetchable) [size=4M]
	I/O ports at 2020 [size=32]
	Capabilities: [c8] Power Management version 2
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable+
	Capabilities: [e0] Express Endpoint IRQ 0

05:00.1 Ethernet controller: Intel Corporation 631xESB/632xESB DPT LAN Controller Copper (rev 01)
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, fast devsel, latency 0, IRQ 19
	Memory at b9000000 (32-bit, non-prefetchable) [size=128K]
	Memory at b8800000 (32-bit, non-prefetchable) [size=4M]
	I/O ports at 2000 [size=32]
	Capabilities: [c8] Power Management version 2
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [e0] Express Endpoint IRQ 0

08:00.0 InfiniBand: Mellanox Technologies MT25204 [InfiniHost III Lx HCA] (rev 20)
	Subsystem: Mellanox Technologies MT25204 [InfiniHost III Lx HCA]
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at b9300000 (64-bit, non-prefetchable) [size=1M]
	Memory at b8000000 (64-bit, prefetchable) [size=8M]
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Vital Product Data
	Capabilities: [90] Message Signalled Interrupts: 64bit+ Queue=0/5 Enable-
	Capabilities: [84] MSI-X: Enable- Mask- TabSize=32
	Capabilities: [60] Express Endpoint IRQ 0

0c:0c.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02) (prog-if 00 [VGA])
	Subsystem: Intel Corporation: Unknown device 346c
	Flags: bus master, stepping, fast Back2Back, medium devsel, latency 32, IRQ 11
	Memory at b0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 1000 [size=256]
	Memory at b9200000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at fffe0000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.2.6.20-rc4"

Linux version 2.6.20-rc4 (root@xe) (gcc version 3.4.6 20060404 (Red Hat 3.4.6-3)) #0 SMP Sat Jan 13 00:58:37 EST 2007
Command line: initrd=initrd-2.6.20-rc4.img root=/dev/sdb1 ro console=tty0 console=ttyS1,115200n8 BOOT_IMAGE=vmlinuz-2.6.20-rc4 
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000009f91f000 (usable)
 BIOS-e820: 000000009f91f000 - 000000009f9d1000 (ACPI NVS)
 BIOS-e820: 000000009f9d1000 - 000000009fa42000 (usable)
 BIOS-e820: 000000009fa42000 - 000000009fa9a000 (reserved)
 BIOS-e820: 000000009fa9a000 - 000000009fad4000 (usable)
 BIOS-e820: 000000009fad4000 - 000000009fb1a000 (ACPI NVS)
 BIOS-e820: 000000009fb1a000 - 000000009fb2c000 (usable)
 BIOS-e820: 000000009fb2c000 - 000000009fb3a000 (ACPI data)
 BIOS-e820: 000000009fb3a000 - 000000009fc00000 (usable)
 BIOS-e820: 00000000ffc00000 - 00000000ffc0c000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000260000000 (usable)
Entering add_active_range(0, 0, 158) 0 entries of 256 used
Entering add_active_range(0, 256, 653599) 1 entries of 256 used
Entering add_active_range(0, 653777, 653890) 2 entries of 256 used
Entering add_active_range(0, 653978, 654036) 3 entries of 256 used
Entering add_active_range(0, 654106, 654124) 4 entries of 256 used
Entering add_active_range(0, 654138, 654336) 5 entries of 256 used
Entering add_active_range(0, 1048576, 2490368) 6 entries of 256 used
end_pfn_map = 2490368
DMI 2.5 present.
ACPI: RSDP (v002 INTEL                                 ) @ 0x00000000000f03b0
ACPI: XSDT (v001 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000009fb39120
ACPI: FADT (v003 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000009fb36000
ACPI: MADT (v001 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000009fb35000
ACPI: SPCR (v001 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000009fb2e000
ACPI: HPET (v001 INTEL  S5000PAL 0x00000001 INTL 0x01000013) @ 0x000000009fb2d000
ACPI: MCFG (v001 INTEL  S5000PAL 0x00000001 INTL 0x01000013) @ 0x000000009fb2c000
ACPI: DSDT (v002 INTEL  S5000PAL 0x00000008 INTL 0x01000013) @ 0x0000000000000000
Entering add_active_range(0, 0, 158) 0 entries of 256 used
Entering add_active_range(0, 256, 653599) 1 entries of 256 used
Entering add_active_range(0, 653777, 653890) 2 entries of 256 used
Entering add_active_range(0, 653978, 654036) 3 entries of 256 used
Entering add_active_range(0, 654106, 654124) 4 entries of 256 used
Entering add_active_range(0, 654138, 654336) 5 entries of 256 used
Entering add_active_range(0, 1048576, 2490368) 6 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  2490368
early_node_map[7] active PFN ranges
    0:        0 ->      158
    0:      256 ->   653599
    0:   653777 ->   653890
    0:   653978 ->   654036
    0:   654106 ->   654124
    0:   654138 ->   654336
    0:  1048576 ->  2490368
On node 0 totalpages: 2095680
  DMA zone: 64 pages used for memmap
  DMA zone: 950 pages reserved
  DMA zone: 2984 pages, LIFO batch:0
  DMA32 zone: 16320 pages used for memmap
  DMA32 zone: 633570 pages, LIFO batch:31
  Normal zone: 22528 pages used for memmap
  Normal zone: 1419264 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x84] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x85] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x86] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x87] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, address 0xfec80000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009e000 - 000000000009f000
Nosave address range: 000000000009f000 - 0000000000100000
Nosave address range: 000000009f91f000 - 000000009f9d1000
Nosave address range: 000000009fa42000 - 000000009fa9a000
Nosave address range: 000000009fad4000 - 000000009fb1a000
Nosave address range: 000000009fb2c000 - 000000009fb3a000
Nosave address range: 000000009fc00000 - 00000000ffc00000
Nosave address range: 00000000ffc00000 - 00000000ffc0c000
Nosave address range: 00000000ffc0c000 - 0000000100000000
Allocating PCI resources starting at a0000000 (gap: 9fc00000:60000000)
PERCPU: Allocating 32320 bytes of per cpu data
Built 1 zonelists.  Total pages: 2055818
Kernel command line: initrd=initrd-2.6.20-rc4.img root=/dev/sdb1 ro console=tty0 console=ttyS1,115200n8 BOOT_IMAGE=vmlinuz-2.6.20-rc4 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Checking aperture...
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0xb47d000 - 0xf47d000
Memory: 8142844k/9961472k available (2022k kernel code, 239216k reserved, 913k data, 220k init)
Calibrating delay using timer specific routine.. 5324.73 BogoMIPS (lpj=10649472)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
Freeing SMP alternatives: 24k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 20781255
Detected 20.781 MHz APIC timer.
Booting processor 1/4 APIC 0x6
Initializing CPU#1
Calibrating delay using timer specific routine.. 5320.28 BogoMIPS (lpj=10640563)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM2)
Intel(R) Xeon(R) CPU            5150  @ 2.66GHz stepping 06
Booting processor 2/4 APIC 0x1
Initializing CPU#2
Calibrating delay using timer specific routine.. 5320.16 BogoMIPS (lpj=10640334)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU2: Thermal monitoring enabled (TM2)
Intel(R) Xeon(R) CPU            5150  @ 2.66GHz stepping 06
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 5320.15 BogoMIPS (lpj=10640304)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 1
CPU3: Thermal monitoring enabled (TM2)
Intel(R) Xeon(R) CPU            5150  @ 2.66GHz stepping 06
Brought up 4 CPUs
testing NMI watchdog ... OK.
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 2660.002 MHz processor.
migration_cost=14,8079
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at a0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:0c:0c.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXPC._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW.PCIO._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW.PCIP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW.PCIQ._PRT]
intel_rng: FWH not detected
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-GART: No AMD northbridge found.
PCI: Bridge: 0000:02:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:02.0
  IO window: 2000-2fff
  MEM window: b8800000-b90fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.0
  IO window: 2000-2fff
  MEM window: b8800000-b90fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.3
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: 2000-2fff
  MEM window: b8800000-b91fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: b9300000-b93fffff
  PREFETCH window: b8000000-b87fffff
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: b9200000-b92fffff
  PREFETCH window: b0000000-b7ffffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:01.0 to 64
ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:02.0 to 64
PCI: Setting latency timer of device 0000:01:00.3 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:03.0 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:04.0 to 64
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:05.0 to 64
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:07.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1033k freed
audit: initializing netlink socket (disabled)
audit(1168650731.100:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
PCI: Setting latency timer of device 0000:00:03.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
PCI: Setting latency timer of device 0000:00:04.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
PCI: Setting latency timer of device 0000:00:05.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:05.0:pcie00]
PCI: Setting latency timer of device 0000:00:06.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
PCI: Setting latency timer of device 0000:00:07.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
PCI: Setting latency timer of device 0000:01:00.0 to 64
Allocate Port Service[0000:01:00.0:pcie10]
PCI: Setting latency timer of device 0000:02:00.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:02:00.0:pcie20]
Allocate Port Service[0000:02:00.0:pcie22]
PCI: Setting latency timer of device 0000:02:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:02:01.0:pcie20]
PCI: Setting latency timer of device 0000:02:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:02:02.0:pcie20]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: HPC vendor_id 8086 device_id 3510 ss_vid 0 ss_did 0
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Cannot get control of hotplug hardware for pci 0000:02:00.0
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
ACPI: Processor [CPU3] (supports 8 throttling states)
ACPI: Getting cpuindex for acpiid 0x4
ACPI: Getting cpuindex for acpiid 0x5
ACPI: Getting cpuindex for acpiid 0x6
ACPI: Getting cpuindex for acpiid 0x7
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.1.0 20060810
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
usbmon: debugfs is not available
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 220k freed
SCSI subsystem initialized
libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led pmp slum part 
ata1: SATA max UDMA/133 cmd 0xFFFFC20000004100 ctl 0x0 bmdma 0x0 irq 20
ata2: SATA max UDMA/133 cmd 0xFFFFC20000004180 ctl 0x0 bmdma 0x0 irq 20
ata3: SATA max UDMA/133 cmd 0xFFFFC20000004200 ctl 0x0 bmdma 0x0 irq 20
ata4: SATA max UDMA/133 cmd 0xFFFFC20000004280 ctl 0x0 bmdma 0x0 irq 20
ata5: SATA max UDMA/133 cmd 0xFFFFC20000004300 ctl 0x0 bmdma 0x0 irq 20
ata6: SATA max UDMA/133 cmd 0xFFFFC20000004380 ctl 0x0 bmdma 0x0 irq 20
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/133
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
scsi4 : ahci
ata5: SATA link down (SStatus 0 SControl 300)
scsi5 : ahci
ata6: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      HDT722525DLA380  V44O PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: Direct-Access     ATA      HDT722525DLA380  V44O PQ: 0 ANSI: 5
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3
sd 1:0:0:0: Attached scsi disk sdb
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Probing IDE interface ide0...
Probing IDE interface ide1...
ata_piix 0000:00:1f.1: version 2.00ac7
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata7: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x30C0 irq 14
ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x30C8 irq 15
scsi6 : ata_piix
scsi7 : ata_piix
ATA: abnormal status 0x7F on port 0x177
floppy0: no floppy controllers found
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:05:00.0 to 64
e1000: 0000:05:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x4) 00:04:23:d6:66:42
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:05:00.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:05:00.1 to 64
e1000: 0000:05:00.1: e1000_probe: (PCI Express:2.5Gb/s:Width x4) 00:04:23:d6:66:43
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
ib_mthca: Mellanox InfiniBand HCA driver v0.08 (February 14, 2006)
ib_mthca: Initializing 0000:08:00.0
ACPI: PCI Interrupt 0000:08:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:08:00.0 to 64
ib_mthca 0000:08:00.0: HCA FW version 1.0.700 is old (1.1.0 is current).
ib_mthca 0000:08:00.0: If you have problems, try updating your HCA FW.
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xb9400400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 23, io base 0x000030a0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 22, io base 0x00003080
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 23, io base 0x00003060
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 22, io base 0x00003040
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
EXT3 FS on sdb1, internal journal
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
Adding 8000360k swap on /dev/sdb2.  Priority:-1 extents:1 across:8000360k
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x1ff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3f)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0xe)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x5)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0xf)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7b)
eth0: no IPv6 routers present
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0xfff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x1d)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x1ffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3f)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x1f)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x1f)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x1f)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x1f)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x1f)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0xffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0xfffffff)
ip_tables: (C) 2000-2006 Netfilter Core Team
ADDRCONF(NETDEV_UP): ib0: link is not ready
ADDRCONF(NETDEV_CHANGE): ib0: link becomes ready
ib0: no IPv6 routers present
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0xffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7ff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x1d)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0xf)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0xffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0xf)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7ffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7f)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x7fffffff)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)
ata2: spurious interrupt (irq_stat 0x4 active_tag -84148995 sactive 0x3)

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.2.6.19.2"

Linux version 2.6.19.2 (root@xe) (gcc version 3.4.6 20060404 (Red Hat 3.4.6-3)) #1 SMP Fri Jan 12 23:14:43 EST 2007
Command line: initrd=initrd-2.6.19.2.img root=/dev/sdb1 ro console=tty0 console=ttyS1,115200n8 BOOT_IMAGE=vmlinuz-2.6.19.2 
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000009f91f000 (usable)
 BIOS-e820: 000000009f91f000 - 000000009f9d1000 (ACPI NVS)
 BIOS-e820: 000000009f9d1000 - 000000009fa42000 (usable)
 BIOS-e820: 000000009fa42000 - 000000009fa9a000 (reserved)
 BIOS-e820: 000000009fa9a000 - 000000009fad4000 (usable)
 BIOS-e820: 000000009fad4000 - 000000009fb1a000 (ACPI NVS)
 BIOS-e820: 000000009fb1a000 - 000000009fb2c000 (usable)
 BIOS-e820: 000000009fb2c000 - 000000009fb3a000 (ACPI data)
 BIOS-e820: 000000009fb3a000 - 000000009fc00000 (usable)
 BIOS-e820: 00000000ffe00000 - 00000000ffe0c000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000260000000 (usable)
Entering add_active_range(0, 0, 158) 0 entries of 256 used
Entering add_active_range(0, 256, 653599) 1 entries of 256 used
Entering add_active_range(0, 653777, 653890) 2 entries of 256 used
Entering add_active_range(0, 653978, 654036) 3 entries of 256 used
Entering add_active_range(0, 654106, 654124) 4 entries of 256 used
Entering add_active_range(0, 654138, 654336) 5 entries of 256 used
Entering add_active_range(0, 1048576, 2490368) 6 entries of 256 used
end_pfn_map = 2490368
DMI 2.5 present.
ACPI: RSDP (v002 INTEL                                 ) @ 0x00000000000f03b0
ACPI: XSDT (v001 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000009fb39120
ACPI: FADT (v003 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000009fb36000
ACPI: MADT (v001 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000009fb35000
ACPI: SPCR (v001 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000009fb2e000
ACPI: HPET (v001 INTEL  S5000PAL 0x00000001 INTL 0x01000013) @ 0x000000009fb2d000
ACPI: MCFG (v001 INTEL  S5000PAL 0x00000001 INTL 0x01000013) @ 0x000000009fb2c000
ACPI: DSDT (v002 INTEL  S5000PAL 0x00000008 INTL 0x01000013) @ 0x0000000000000000
Entering add_active_range(0, 0, 158) 0 entries of 256 used
Entering add_active_range(0, 256, 653599) 1 entries of 256 used
Entering add_active_range(0, 653777, 653890) 2 entries of 256 used
Entering add_active_range(0, 653978, 654036) 3 entries of 256 used
Entering add_active_range(0, 654106, 654124) 4 entries of 256 used
Entering add_active_range(0, 654138, 654336) 5 entries of 256 used
Entering add_active_range(0, 1048576, 2490368) 6 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  2490368
early_node_map[7] active PFN ranges
    0:        0 ->      158
    0:      256 ->   653599
    0:   653777 ->   653890
    0:   653978 ->   654036
    0:   654106 ->   654124
    0:   654138 ->   654336
    0:  1048576 ->  2490368
On node 0 totalpages: 2095680
  DMA zone: 64 pages used for memmap
  DMA zone: 942 pages reserved
  DMA zone: 2992 pages, LIFO batch:0
  DMA32 zone: 16320 pages used for memmap
  DMA32 zone: 633570 pages, LIFO batch:31
  Normal zone: 22528 pages used for memmap
  Normal zone: 1419264 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x84] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x85] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x86] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x87] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, address 0xfec80000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009e000 - 000000000009f000
Nosave address range: 000000000009f000 - 0000000000100000
Nosave address range: 000000009f91f000 - 000000009f9d1000
Nosave address range: 000000009fa42000 - 000000009fa9a000
Nosave address range: 000000009fad4000 - 000000009fb1a000
Nosave address range: 000000009fb2c000 - 000000009fb3a000
Nosave address range: 000000009fc00000 - 00000000ffe00000
Nosave address range: 00000000ffe00000 - 00000000ffe0c000
Nosave address range: 00000000ffe0c000 - 0000000100000000
Allocating PCI resources starting at a0000000 (gap: 9fc00000:60200000)
PERCPU: Allocating 33024 bytes of per cpu data
Built 1 zonelists.  Total pages: 2055826
Kernel command line: initrd=initrd-2.6.19.2.img root=/dev/sdb1 ro console=tty0 console=ttyS1,115200n8 BOOT_IMAGE=vmlinuz-2.6.19.2 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Checking aperture...
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0xb47e000 - 0xf47e000
Memory: 8142876k/9961472k available (2014k kernel code, 239184k reserved, 877k data, 224k init)
Calibrating delay using timer specific routine.. 5324.71 BogoMIPS (lpj=10649425)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
Freeing SMP alternatives: 24k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 20781277
Detected 20.781 MHz APIC timer.
Booting processor 1/4 APIC 0x6
Initializing CPU#1
Calibrating delay using timer specific routine.. 5320.17 BogoMIPS (lpj=10640356)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM2)
Intel(R) Xeon(R) CPU            5150  @ 2.66GHz stepping 06
Booting processor 2/4 APIC 0x1
Initializing CPU#2
Calibrating delay using timer specific routine.. 5320.16 BogoMIPS (lpj=10640331)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU2: Thermal monitoring enabled (TM2)
Intel(R) Xeon(R) CPU            5150  @ 2.66GHz stepping 06
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 5320.07 BogoMIPS (lpj=10640154)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 1
CPU3: Thermal monitoring enabled (TM2)
Intel(R) Xeon(R) CPU            5150  @ 2.66GHz stepping 06
Brought up 4 CPUs
testing NMI watchdog ... OK.
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 2660.005 MHz processor.
migration_cost=19,8098
checking if image is initramfs... it is
Freeing initrd memory: 1029k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at a0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:0c:0c.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXPC._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW.PCIO._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW.PCIP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW.PCIQ._PRT]
intel_rng: FWH not detected
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-GART: No AMD northbridge found.
PCI: Bridge: 0000:02:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:02.0
  IO window: 2000-2fff
  MEM window: b8800000-b90fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.0
  IO window: 2000-2fff
  MEM window: b8800000-b90fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.3
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: 2000-2fff
  MEM window: b8800000-b91fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: b9300000-b93fffff
  PREFETCH window: b8000000-b87fffff
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: b9200000-b92fffff
  PREFETCH window: b0000000-b7ffffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:01.0 to 64
ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:02.0 to 64
PCI: Setting latency timer of device 0000:01:00.3 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:03.0 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:04.0 to 64
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:05.0 to 64
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:07.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1168647504.152:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
PCI: Setting latency timer of device 0000:00:03.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
PCI: Setting latency timer of device 0000:00:04.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
PCI: Setting latency timer of device 0000:00:05.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:05.0:pcie00]
PCI: Setting latency timer of device 0000:00:06.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
PCI: Setting latency timer of device 0000:00:07.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
PCI: Setting latency timer of device 0000:01:00.0 to 64
Allocate Port Service[0000:01:00.0:pcie10]
PCI: Setting latency timer of device 0000:02:00.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:02:00.0:pcie20]
Allocate Port Service[0000:02:00.0:pcie22]
PCI: Setting latency timer of device 0000:02:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:02:01.0:pcie20]
PCI: Setting latency timer of device 0000:02:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:02:02.0:pcie20]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: HPC vendor_id 8086 device_id 3510 ss_vid 0 ss_did 0
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Cannot get control of hotplug hardware for pci 0000:02:00.0
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
ACPI: Processor [CPU3] (supports 8 throttling states)
ACPI: Getting cpuindex for acpiid 0x4
ACPI: Getting cpuindex for acpiid 0x5
ACPI: Getting cpuindex for acpiid 0x6
ACPI: Getting cpuindex for acpiid 0x7
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
usbmon: debugfs is not available
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 224k freed
SCSI subsystem initialized
libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports ? Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit stag led pmp 
ata1: SATA max UDMA/133 cmd 0xFFFFC20000004100 ctl 0x0 bmdma 0x0 irq 20
ata2: SATA max UDMA/133 cmd 0xFFFFC20000004180 ctl 0x0 bmdma 0x0 irq 20
ata3: SATA max UDMA/133 cmd 0xFFFFC20000004200 ctl 0x0 bmdma 0x0 irq 20
ata4: SATA max UDMA/133 cmd 0xFFFFC20000004280 ctl 0x0 bmdma 0x0 irq 20
ata5: SATA max UDMA/133 cmd 0xFFFFC20000004300 ctl 0x0 bmdma 0x0 irq 20
ata6: SATA max UDMA/133 cmd 0xFFFFC20000004380 ctl 0x0 bmdma 0x0 irq 20
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/133
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
scsi4 : ahci
ata5: SATA link down (SStatus 0 SControl 300)
scsi5 : ahci
ata6: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      HDT722525DLA380  V44O PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write through
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write through
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: Direct-Access     ATA      HDT722525DLA380  V44O PQ: 0 ANSI: 5
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write through
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3
sd 1:0:0:0: Attached scsi disk sdb
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Probing IDE interface ide0...
Probing IDE interface ide1...
ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata7: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x30C0 irq 14
ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x30C8 irq 15
scsi6 : ata_piix
scsi7 : ata_piix
ATA: abnormal status 0x7F on port 0x177
floppy0: no floppy controllers found
Intel(R) PRO/1000 Network Driver - version 7.2.9-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:05:00.0 to 64
e1000: 0000:05:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 00:04:23:d6:61:52
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:05:00.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:05:00.1 to 64
e1000: 0000:05:00.1: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 00:04:23:d6:61:53
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
ib_mthca: Mellanox InfiniBand HCA driver v0.08 (February 14, 2006)
ib_mthca: Initializing 0000:08:00.0
ACPI: PCI Interrupt 0000:08:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:08:00.0 to 64
ib_mthca 0000:08:00.0: HCA FW version 1.0.700 is old (1.1.0 is current).
ib_mthca 0000:08:00.0: If you have problems, try updating your HCA FW.
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xb9400400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 23, io base 0x000030a0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 22, io base 0x00003080
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 23, io base 0x00003060
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 22, io base 0x00003040
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
EXT3 FS on sdb1, internal journal
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
Adding 8000360k swap on /dev/sdb2.  Priority:-1 extents:1 across:8000360k
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
eth0: no IPv6 routers present

--y0ulUmNC+osPPQO6--
