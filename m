From: Frans Pop <elendil@planet.nl>
Subject: [2.6.23-rc3] Regression: "spurious completions during NCQ"
Date: Mon, 13 Aug 2007 20:05:14 +0200
Message-ID: <200708132005.14697.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_a1JwGtzkuJcxHpw"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml13.kpnxchange.com ([213.75.38.113]:21408 "EHLO
	hpsmtp-eml13.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965941AbXHMSVq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Aug 2007 14:21:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_a1JwGtzkuJcxHpw
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've been running 2.6.23-rc2 without problems. Today I compiled 2.6.23-rc3
and shortly after boot got the following messages in my logs:

kernel: ata1.00: spurious completions during NCQ issue=0x0 SAct=0x7ffc7 FIS=005040a1:00000020
kernel: ata1.00: cmd 61/30:00:73:96:db/00:00:04:00:00/40 tag 0 cdb 0x0 data 24576 out
kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
[...]
kernel: ata1: soft resetting port
kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
kernel: ata1.00: configured for UDMA/133
kernel: ata1: EH complete
kernel: sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
kernel: sd 0:0:0:0: [sda] Write Protect is off
kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

A grep in the logs shows that the first error has never occurred before.
I was doing nothing special at the time (SVN checkout, not even running X).

Full kern.log for that boot and lsmod attached.
My system is Debian unstable with 2.6.23 built from Linus' git tree.

Cheers,
Frans Pop


--Boundary-00=_a1JwGtzkuJcxHpw
Content-Type: text/x-log;
  charset="us-ascii";
  name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kern.log"

Aug 13 19:32:42 faramir kernel: klogd 1.5.0#1, log source = /proc/kmsg started.
Aug 13 19:32:42 faramir kernel: Linux version 2.6.23-rc3 (root@faramir) (gcc version 4.1.3 20070718 (prerelease) (Debian 4.1.2-14)) #1 SMP Mon Aug 13 17:24:51 CEST 2007
Aug 13 19:32:42 faramir kernel: Command line: root=/dev/mapper/main-root ro quiet vga=791 
Aug 13 19:32:42 faramir kernel: BIOS-provided physical RAM map:
Aug 13 19:32:42 faramir kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 13 19:32:42 faramir kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 13 19:32:42 faramir kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Aug 13 19:32:42 faramir kernel:  BIOS-e820: 0000000000100000 - 000000007fe74000 (usable)
Aug 13 19:32:42 faramir kernel:  BIOS-e820: 000000007fe74000 - 000000007fee9000 (ACPI NVS)
Aug 13 19:32:42 faramir kernel:  BIOS-e820: 000000007fee9000 - 000000007feec000 (usable)
Aug 13 19:32:42 faramir kernel:  BIOS-e820: 000000007feec000 - 000000007feff000 (ACPI data)
Aug 13 19:32:42 faramir kernel:  BIOS-e820: 000000007feff000 - 000000007ff00000 (usable)
Aug 13 19:32:42 faramir kernel: Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Aug 13 19:32:42 faramir kernel: Entering add_active_range(0, 256, 523892) 1 entries of 3200 used
Aug 13 19:32:42 faramir kernel: Entering add_active_range(0, 524009, 524012) 2 entries of 3200 used
Aug 13 19:32:42 faramir kernel: Entering add_active_range(0, 524031, 524032) 3 entries of 3200 used
Aug 13 19:32:42 faramir kernel: end_pfn_map = 524032
Aug 13 19:32:42 faramir kernel: DMI 2.3 present.
Aug 13 19:32:42 faramir kernel: ACPI: RSDP 000FE020, 0014 (r0 INTEL )
Aug 13 19:32:42 faramir kernel: ACPI: RSDT 7FEFDE48, 0058 (r1 INTEL  D945GCZ       FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: FACP 7FEFCF10, 0074 (r1 INTEL  D945GCZ       FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: DSDT 7FEF7010, 4348 (r1 INTEL  D945GCZ       FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: FACS 7FEE2C40, 0040
Aug 13 19:32:42 faramir kernel: ACPI: APIC 7FEFCE10, 0078 (r1 INTEL  D945GCZ       FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: WDDT 7FEF6F90, 0040 (r1 INTEL  D945GCZ       FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: MCFG 7FEF6F10, 003C (r1 INTEL  D945GCZ       FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: ASF! 7FEFCD10, 00A6 (r32 INTEL  D945GCZ       FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: HPET 7FEF6E90, 0038 (r1 INTEL  D945GCZ       FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: SSDT 7FEFDC10, 01BC (r1 INTEL     CpuPm      FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: SSDT 7FEFDA10, 0175 (r1 INTEL   Cpu0Ist      FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: SSDT 7FEFD810, 0175 (r1 INTEL   Cpu1Ist      FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: SSDT 7FEFD610, 0175 (r1 INTEL   Cpu2Ist      FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: SSDT 7FEFD410, 0175 (r1 INTEL   Cpu3Ist      FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: SSDT 7FEF6E10, 002F (r1 INTEL  SetupVar      FF9 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: ACPI: TCPA 7FEE4D90, 0032 (r1 INTEL  TIANO           2 MSFT  1000013)
Aug 13 19:32:42 faramir kernel: No NUMA configuration found
Aug 13 19:32:42 faramir kernel: Faking a node at 0000000000000000-000000007ff00000
Aug 13 19:32:42 faramir kernel: Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Aug 13 19:32:42 faramir kernel: Entering add_active_range(0, 256, 523892) 1 entries of 3200 used
Aug 13 19:32:42 faramir kernel: Entering add_active_range(0, 524009, 524012) 2 entries of 3200 used
Aug 13 19:32:42 faramir kernel: Entering add_active_range(0, 524031, 524032) 3 entries of 3200 used
Aug 13 19:32:42 faramir kernel: Bootmem setup node 0 0000000000000000-000000007ff00000
Aug 13 19:32:42 faramir kernel: Zone PFN ranges:
Aug 13 19:32:42 faramir kernel:   DMA             0 ->     4096
Aug 13 19:32:42 faramir kernel:   DMA32        4096 ->  1048576
Aug 13 19:32:42 faramir kernel:   Normal    1048576 ->  1048576
Aug 13 19:32:42 faramir kernel: Movable zone start PFN for each node
Aug 13 19:32:42 faramir kernel: early_node_map[4] active PFN ranges
Aug 13 19:32:42 faramir kernel:     0:        0 ->      159
Aug 13 19:32:42 faramir kernel:     0:      256 ->   523892
Aug 13 19:32:42 faramir kernel:     0:   524009 ->   524012
Aug 13 19:32:42 faramir kernel:     0:   524031 ->   524032
Aug 13 19:32:42 faramir kernel: On node 0 totalpages: 523799
Aug 13 19:32:42 faramir kernel:   DMA zone: 56 pages used for memmap
Aug 13 19:32:42 faramir kernel:   DMA zone: 1015 pages reserved
Aug 13 19:32:42 faramir kernel:   DMA zone: 2928 pages, LIFO batch:0
Aug 13 19:32:42 faramir kernel:   DMA32 zone: 7108 pages used for memmap
Aug 13 19:32:42 faramir kernel:   DMA32 zone: 512692 pages, LIFO batch:31
Aug 13 19:32:42 faramir kernel:   Normal zone: 0 pages used for memmap
Aug 13 19:32:42 faramir kernel:   Movable zone: 0 pages used for memmap
Aug 13 19:32:42 faramir kernel: ACPI: PM-Timer IO Port: 0x408
Aug 13 19:32:42 faramir kernel: ACPI: Local APIC address 0xfee00000
Aug 13 19:32:42 faramir kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Aug 13 19:32:42 faramir kernel: Processor #0 (Bootup-CPU)
Aug 13 19:32:42 faramir kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Aug 13 19:32:42 faramir kernel: Processor #1
Aug 13 19:32:42 faramir kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
Aug 13 19:32:42 faramir kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
Aug 13 19:32:42 faramir kernel: ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Aug 13 19:32:42 faramir kernel: ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Aug 13 19:32:42 faramir kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Aug 13 19:32:42 faramir kernel: IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
Aug 13 19:32:42 faramir kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Aug 13 19:32:42 faramir kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Aug 13 19:32:42 faramir kernel: ACPI: IRQ0 used by override.
Aug 13 19:32:42 faramir kernel: ACPI: IRQ2 used by override.
Aug 13 19:32:42 faramir kernel: ACPI: IRQ9 used by override.
Aug 13 19:32:42 faramir kernel: Setting APIC routing to flat
Aug 13 19:32:42 faramir kernel: ACPI: HPET id: 0x8086a201 base: 0xfed00000
Aug 13 19:32:42 faramir kernel: Using ACPI (MADT) for SMP configuration information
Aug 13 19:32:42 faramir kernel: swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
Aug 13 19:32:42 faramir kernel: swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000e0000
Aug 13 19:32:42 faramir kernel: swsusp: Registered nosave memory region: 00000000000e0000 - 0000000000100000
Aug 13 19:32:42 faramir kernel: swsusp: Registered nosave memory region: 000000007fe74000 - 000000007fee9000
Aug 13 19:32:42 faramir kernel: swsusp: Registered nosave memory region: 000000007feec000 - 000000007feff000
Aug 13 19:32:42 faramir kernel: Allocating PCI resources starting at 80000000 (gap: 7ff00000:80100000)
Aug 13 19:32:42 faramir kernel: SMP: Allowing 4 CPUs, 2 hotplug CPUs
Aug 13 19:32:42 faramir kernel: PERCPU: Allocating 35040 bytes of per cpu data
Aug 13 19:32:42 faramir kernel: Built 1 zonelists in Node order.  Total pages: 515620
Aug 13 19:32:42 faramir kernel: Policy zone: DMA32
Aug 13 19:32:42 faramir kernel: Kernel command line: root=/dev/mapper/main-root ro quiet vga=791 
Aug 13 19:32:42 faramir kernel: Initializing CPU#0
Aug 13 19:32:42 faramir kernel: PID hash table entries: 4096 (order: 12, 32768 bytes)
Aug 13 19:32:42 faramir kernel: time.c: Detected 3199.884 MHz processor.
Aug 13 19:32:42 faramir kernel: Console: colour dummy device 80x25
Aug 13 19:32:42 faramir kernel: console [tty0] enabled
Aug 13 19:32:42 faramir kernel: Checking aperture...
Aug 13 19:32:42 faramir kernel: Calgary: detecting Calgary via BIOS EBDA area
Aug 13 19:32:42 faramir kernel: Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Aug 13 19:32:42 faramir kernel: Memory: 2058208k/2096128k available (2016k kernel code, 36988k reserved, 949k data, 304k init)
Aug 13 19:32:42 faramir kernel: Calibrating delay using timer specific routine.. 6405.18 BogoMIPS (lpj=12810360)
Aug 13 19:32:42 faramir kernel: Security Framework v1.0.0 initialized
Aug 13 19:32:42 faramir kernel: SELinux:  Disabled at boot.
Aug 13 19:32:42 faramir kernel: Capability LSM initialized
Aug 13 19:32:42 faramir kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Aug 13 19:32:42 faramir kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Aug 13 19:32:42 faramir kernel: Mount-cache hash table entries: 256
Aug 13 19:32:42 faramir kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Aug 13 19:32:42 faramir kernel: CPU: L2 cache: 1024K
Aug 13 19:32:42 faramir kernel: CPU 0/0 -> Node 0
Aug 13 19:32:42 faramir kernel: using mwait in idle threads.
Aug 13 19:32:42 faramir kernel: CPU: Physical Processor ID: 0
Aug 13 19:32:42 faramir kernel: CPU: Processor Core ID: 0
Aug 13 19:32:42 faramir kernel: CPU0: Thermal monitoring enabled (TM1)
Aug 13 19:32:42 faramir kernel: SMP alternatives: switching to UP code
Aug 13 19:32:42 faramir kernel: ACPI: Core revision 20070126
Aug 13 19:32:42 faramir kernel: Using local APIC timer interrupts.
Aug 13 19:32:42 faramir kernel: result 12499507
Aug 13 19:32:42 faramir kernel: Detected 12.499 MHz APIC timer.
Aug 13 19:32:42 faramir kernel: SMP alternatives: switching to SMP code
Aug 13 19:32:42 faramir kernel: Booting processor 1/2 APIC 0x1
Aug 13 19:32:42 faramir kernel: Initializing CPU#1
Aug 13 19:32:42 faramir kernel: Calibrating delay using timer specific routine.. 6400.07 BogoMIPS (lpj=12800147)
Aug 13 19:32:42 faramir kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Aug 13 19:32:42 faramir kernel: CPU: L2 cache: 1024K
Aug 13 19:32:42 faramir kernel: CPU 1/1 -> Node 0
Aug 13 19:32:42 faramir kernel: CPU: Physical Processor ID: 0
Aug 13 19:32:42 faramir kernel: CPU: Processor Core ID: 1
Aug 13 19:32:42 faramir kernel: CPU1: Thermal monitoring enabled (TM1)
Aug 13 19:32:42 faramir kernel:               Intel(R) Pentium(R) D CPU 3.20GHz stepping 07
Aug 13 19:32:42 faramir kernel: checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Aug 13 19:32:42 faramir kernel: Brought up 2 CPUs
Aug 13 19:32:42 faramir kernel: NET: Registered protocol family 16
Aug 13 19:32:42 faramir kernel: ACPI: bus type pci registered
Aug 13 19:32:42 faramir kernel: PCI: Found Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub without MMCONFIG support.
Aug 13 19:32:42 faramir kernel: PCI: Using configuration type 1
Aug 13 19:32:42 faramir kernel: ACPI: EC: Look up EC in DSDT
Aug 13 19:32:42 faramir kernel: ACPI: Interpreter enabled
Aug 13 19:32:42 faramir kernel: ACPI: (supports S0 S1 S3)
Aug 13 19:32:42 faramir kernel: ACPI: Using IOAPIC for interrupt routing
Aug 13 19:32:42 faramir kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Aug 13 19:32:42 faramir kernel: PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
Aug 13 19:32:42 faramir kernel: PCI quirk: region 0500-053f claimed by ICH6 GPIO
Aug 13 19:32:42 faramir kernel: PCI: Transparent bridge - 0000:00:1e.0
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 *10 11 12)
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11 12)
Aug 13 19:32:42 faramir kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 13 19:32:42 faramir kernel: pnp: PnP ACPI init
Aug 13 19:32:42 faramir kernel: ACPI: bus type pnp registered
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0A03
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0C02
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0200
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0B00
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0C04
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0800
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0C02
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0C31
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0C02
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0700
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0401
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0501
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0003
Aug 13 19:32:42 faramir kernel: pnp: ACPI device : hid PNP0103
Aug 13 19:32:42 faramir kernel: pnp: PnP ACPI: found 14 devices
Aug 13 19:32:42 faramir kernel: ACPI: ACPI bus type pnp unregistered
Aug 13 19:32:42 faramir kernel: usbcore: registered new interface driver usbfs
Aug 13 19:32:42 faramir kernel: usbcore: registered new interface driver hub
Aug 13 19:32:42 faramir kernel: usbcore: registered new device driver usb
Aug 13 19:32:42 faramir kernel: PCI: Using ACPI for IRQ routing
Aug 13 19:32:42 faramir kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Aug 13 19:32:42 faramir kernel: PCI-GART: No AMD northbridge found.
Aug 13 19:32:42 faramir kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Aug 13 19:32:42 faramir kernel: hpet0: 3 64-bit timers, 14318180 Hz
Aug 13 19:32:42 faramir kernel: ACPI: RTC can wake from S4
Aug 13 19:32:42 faramir kernel: Time: tsc clocksource has been installed.
Aug 13 19:32:42 faramir kernel: pnp: the driver 'system' has been registered
Aug 13 19:32:42 faramir kernel: pnp: match found with the PnP device '00:01' and the driver 'system'
Aug 13 19:32:42 faramir kernel: pnp: 00:01: iomem range 0xf0000000-0xf3ffffff has been reserved
Aug 13 19:32:42 faramir kernel: pnp: 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
Aug 13 19:32:42 faramir kernel: pnp: 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
Aug 13 19:32:42 faramir kernel: pnp: 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
Aug 13 19:32:42 faramir kernel: pnp: match found with the PnP device '00:06' and the driver 'system'
Aug 13 19:32:42 faramir kernel: pnp: 00:06: ioport range 0x500-0x53f has been reserved
Aug 13 19:32:42 faramir kernel: pnp: 00:06: ioport range 0x400-0x47f has been reserved
Aug 13 19:32:42 faramir kernel: pnp: 00:06: ioport range 0x680-0x6ff has been reserved
Aug 13 19:32:42 faramir kernel: pnp: match found with the PnP device '00:07' and the driver 'system'
Aug 13 19:32:42 faramir kernel: pnp: 00:07: iomem range 0xfed40000-0xfed44fff has been reserved
Aug 13 19:32:42 faramir kernel: pnp: match found with the PnP device '00:08' and the driver 'system'
Aug 13 19:32:42 faramir kernel: PCI: Bridge: 0000:00:01.0
Aug 13 19:32:42 faramir kernel:   IO window: 2000-2fff
Aug 13 19:32:42 faramir kernel:   MEM window: 90300000-903fffff
Aug 13 19:32:42 faramir kernel:   PREFETCH window: 80000000-8fffffff
Aug 13 19:32:42 faramir kernel: PCI: Bridge: 0000:00:1c.0
Aug 13 19:32:42 faramir kernel:   IO window: 1000-1fff
Aug 13 19:32:42 faramir kernel:   MEM window: 90100000-902fffff
Aug 13 19:32:42 faramir kernel:   PREFETCH window: disabled.
Aug 13 19:32:42 faramir kernel: PCI: Bridge: 0000:00:1c.2
Aug 13 19:32:42 faramir kernel:   IO window: disabled.
Aug 13 19:32:42 faramir kernel:   MEM window: 90500000-905fffff
Aug 13 19:32:42 faramir kernel:   PREFETCH window: disabled.
Aug 13 19:32:42 faramir kernel: PCI: Bridge: 0000:00:1c.3
Aug 13 19:32:42 faramir kernel:   IO window: disabled.
Aug 13 19:32:42 faramir kernel:   MEM window: 90600000-906fffff
Aug 13 19:32:42 faramir kernel:   PREFETCH window: disabled.
Aug 13 19:32:42 faramir kernel: PCI: Bridge: 0000:00:1c.4
Aug 13 19:32:42 faramir kernel:   IO window: disabled.
Aug 13 19:32:42 faramir kernel:   MEM window: 90700000-907fffff
Aug 13 19:32:42 faramir kernel:   PREFETCH window: disabled.
Aug 13 19:32:42 faramir kernel: PCI: Bridge: 0000:00:1c.5
Aug 13 19:32:42 faramir kernel:   IO window: disabled.
Aug 13 19:32:42 faramir kernel:   MEM window: 90800000-908fffff
Aug 13 19:32:42 faramir kernel:   PREFETCH window: disabled.
Aug 13 19:32:42 faramir kernel: PCI: Bridge: 0000:00:1e.0
Aug 13 19:32:42 faramir kernel:   IO window: disabled.
Aug 13 19:32:42 faramir kernel:   MEM window: 90000000-900fffff
Aug 13 19:32:42 faramir kernel:   PREFETCH window: disabled.
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1c.2 to 64
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1c.3 to 64
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1c.4 to 64
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1c.5 to 64
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1e.0 to 64
Aug 13 19:32:42 faramir kernel: NET: Registered protocol family 2
Aug 13 19:32:42 faramir kernel: IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
Aug 13 19:32:42 faramir kernel: TCP established hash table entries: 262144 (order: 10, 6291456 bytes)
Aug 13 19:32:42 faramir kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Aug 13 19:32:42 faramir kernel: TCP: Hash tables configured (established 262144 bind 65536)
Aug 13 19:32:42 faramir kernel: TCP reno registered
Aug 13 19:32:42 faramir kernel: checking if image is initramfs... it is
Aug 13 19:32:42 faramir kernel: Freeing initrd memory: 4014k freed
Aug 13 19:32:42 faramir kernel: audit: initializing netlink socket (disabled)
Aug 13 19:32:42 faramir kernel: audit(1187026335.748:1): initialized
Aug 13 19:32:42 faramir kernel: VFS: Disk quotas dquot_6.5.1
Aug 13 19:32:42 faramir kernel: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Aug 13 19:32:42 faramir kernel: io scheduler noop registered
Aug 13 19:32:42 faramir kernel: io scheduler anticipatory registered
Aug 13 19:32:42 faramir kernel: io scheduler deadline registered
Aug 13 19:32:42 faramir kernel: io scheduler cfq registered (default)
Aug 13 19:32:42 faramir kernel: Boot video device is 0000:01:00.0
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Aug 13 19:32:42 faramir kernel: assign_interrupt_mode Found MSI capability
Aug 13 19:32:42 faramir kernel: Allocate Port Service[0000:00:01.0:pcie00]
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Aug 13 19:32:42 faramir kernel: assign_interrupt_mode Found MSI capability
Aug 13 19:32:42 faramir kernel: Allocate Port Service[0000:00:1c.0:pcie00]
Aug 13 19:32:42 faramir kernel: Allocate Port Service[0000:00:1c.0:pcie02]
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1c.2 to 64
Aug 13 19:32:42 faramir kernel: assign_interrupt_mode Found MSI capability
Aug 13 19:32:42 faramir kernel: Allocate Port Service[0000:00:1c.2:pcie00]
Aug 13 19:32:42 faramir kernel: Allocate Port Service[0000:00:1c.2:pcie02]
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1c.3 to 64
Aug 13 19:32:42 faramir kernel: assign_interrupt_mode Found MSI capability
Aug 13 19:32:42 faramir kernel: Allocate Port Service[0000:00:1c.3:pcie00]
Aug 13 19:32:42 faramir kernel: Allocate Port Service[0000:00:1c.3:pcie02]
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1c.4 to 64
Aug 13 19:32:42 faramir kernel: assign_interrupt_mode Found MSI capability
Aug 13 19:32:42 faramir kernel: Allocate Port Service[0000:00:1c.4:pcie00]
Aug 13 19:32:42 faramir kernel: Allocate Port Service[0000:00:1c.4:pcie02]
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1c.5 to 64
Aug 13 19:32:42 faramir kernel: assign_interrupt_mode Found MSI capability
Aug 13 19:32:42 faramir kernel: Allocate Port Service[0000:00:1c.5:pcie00]
Aug 13 19:32:42 faramir kernel: Allocate Port Service[0000:00:1c.5:pcie02]
Aug 13 19:32:42 faramir kernel: vesafb: framebuffer at 0x80000000, mapped to 0xffffc20000b00000, using 3072k, total 16384k
Aug 13 19:32:42 faramir kernel: vesafb: mode is 1024x768x16, linelength=2048, pages=9
Aug 13 19:32:42 faramir kernel: vesafb: scrolling: redraw
Aug 13 19:32:42 faramir kernel: vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Aug 13 19:32:42 faramir kernel: Console: switching to colour frame buffer device 128x48
Aug 13 19:32:42 faramir kernel: fb0: VESA VGA frame buffer device
Aug 13 19:32:42 faramir kernel: fb1: Virtual frame buffer device, using 1024K of video memory
Aug 13 19:32:42 faramir kernel: Real Time Clock Driver v1.12ac
Aug 13 19:32:42 faramir kernel: hpet_resources: 0xfed00000 is busy
Aug 13 19:32:42 faramir kernel: Linux agpgart interface v0.102
Aug 13 19:32:42 faramir kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Aug 13 19:32:42 faramir kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 13 19:32:42 faramir kernel: pnp: the driver 'serial' has been registered
Aug 13 19:32:42 faramir kernel: pnp: match found with the PnP device '00:0b' and the driver 'serial'
Aug 13 19:32:42 faramir kernel: 00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:02:00.3[C] -> GSI 18 (level, low) -> IRQ 18
Aug 13 19:32:42 faramir kernel: 0000:02:00.3: ttyS1 at I/O 0x1020 (irq = 18) is a 16550A
Aug 13 19:32:42 faramir kernel: RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
Aug 13 19:32:42 faramir kernel: pnp: the driver 'i8042 kbd' has been registered
Aug 13 19:32:42 faramir kernel: pnp: the driver 'i8042 aux' has been registered
Aug 13 19:32:42 faramir kernel: pnp: the driver 'i8042 kbd' has been unregistered
Aug 13 19:32:42 faramir kernel: pnp: the driver 'i8042 aux' has been unregistered
Aug 13 19:32:42 faramir kernel: PNP: No PS/2 controller found. Probing ports directly.
Aug 13 19:32:42 faramir kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 13 19:32:42 faramir kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 13 19:32:42 faramir kernel: mice: PS/2 mouse device common for all mice
Aug 13 19:32:42 faramir kernel: TCP bic registered
Aug 13 19:32:42 faramir kernel: NET: Registered protocol family 1
Aug 13 19:32:42 faramir kernel: NET: Registered protocol family 17
Aug 13 19:32:42 faramir kernel: Freeing unused kernel memory: 304k freed
Aug 13 19:32:42 faramir kernel: ACPI Exception (processor_core-0790): AE_NOT_FOUND, Processor Device is not present [20070126]
Aug 13 19:32:42 faramir kernel: ACPI Exception (processor_core-0790): AE_NOT_FOUND, Processor Device is not present [20070126]
Aug 13 19:32:42 faramir kernel: Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Aug 13 19:32:42 faramir kernel: Copyright (c) 1999-2006 Intel Corporation.
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:02:00.0 to 64
Aug 13 19:32:42 faramir kernel: USB Universal Host Controller Interface driver v3.0
Aug 13 19:32:42 faramir kernel: e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:16:76:04:ff:09
Aug 13 19:32:42 faramir kernel: SCSI subsystem initialized
Aug 13 19:32:42 faramir kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 13 19:32:42 faramir kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 13 19:32:42 faramir kernel: pnp: the driver 'ide' has been registered
Aug 13 19:32:42 faramir kernel: Floppy drive(s): fd0 is 1.44M
Aug 13 19:32:42 faramir kernel: libata version 2.21 loaded.
Aug 13 19:32:42 faramir kernel: FDC 0 is a post-1991 82077
Aug 13 19:32:42 faramir kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.0: irq 23, io base 0x00003080
Aug 13 19:32:42 faramir kernel: usb usb1: configuration #1 chosen from 1 choice
Aug 13 19:32:42 faramir kernel: hub 1-0:1.0: USB hub found
Aug 13 19:32:42 faramir kernel: hub 1-0:1.0: 2 ports detected
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003060
Aug 13 19:32:42 faramir kernel: usb usb2: configuration #1 chosen from 1 choice
Aug 13 19:32:42 faramir kernel: hub 2-0:1.0: USB hub found
Aug 13 19:32:42 faramir kernel: hub 2-0:1.0: 2 ports detected
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
Aug 13 19:32:42 faramir kernel: usb usb3: configuration #1 chosen from 1 choice
Aug 13 19:32:42 faramir kernel: hub 3-0:1.0: USB hub found
Aug 13 19:32:42 faramir kernel: hub 3-0:1.0: 2 ports detected
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
Aug 13 19:32:42 faramir kernel: uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003020
Aug 13 19:32:42 faramir kernel: usb usb4: configuration #1 chosen from 1 choice
Aug 13 19:32:42 faramir kernel: hub 4-0:1.0: USB hub found
Aug 13 19:32:42 faramir kernel: hub 4-0:1.0: 2 ports detected
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Aug 13 19:32:42 faramir kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Aug 13 19:32:42 faramir kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
Aug 13 19:32:42 faramir kernel: ehci_hcd 0000:00:1d.7: debug port 1
Aug 13 19:32:42 faramir kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Aug 13 19:32:42 faramir kernel: ehci_hcd 0000:00:1d.7: irq 23, io mem 0x90404400
Aug 13 19:32:42 faramir kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Aug 13 19:32:42 faramir kernel: usb usb5: configuration #1 chosen from 1 choice
Aug 13 19:32:42 faramir kernel: hub 5-0:1.0: USB hub found
Aug 13 19:32:42 faramir kernel: hub 5-0:1.0: 8 ports detected
Aug 13 19:32:42 faramir kernel: ahci 0000:00:1f.2: version 2.3
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
Aug 13 19:32:42 faramir kernel: usb 3-1: new low speed USB device using uhci_hcd and address 2
Aug 13 19:32:42 faramir kernel: usb 3-1: configuration #1 chosen from 1 choice
Aug 13 19:32:42 faramir kernel: ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
Aug 13 19:32:42 faramir kernel: ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part 
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Aug 13 19:32:42 faramir kernel: scsi0 : ahci
Aug 13 19:32:42 faramir kernel: scsi1 : ahci
Aug 13 19:32:42 faramir kernel: scsi2 : ahci
Aug 13 19:32:42 faramir kernel: scsi3 : ahci
Aug 13 19:32:42 faramir kernel: ata1: SATA max UDMA/133 cmd 0xffffc20000ab4100 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 1273
Aug 13 19:32:42 faramir kernel: ata2: SATA max UDMA/133 cmd 0xffffc20000ab4180 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 1273
Aug 13 19:32:42 faramir kernel: ata3: SATA max UDMA/133 cmd 0xffffc20000ab4200 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 1273
Aug 13 19:32:42 faramir kernel: ata4: SATA max UDMA/133 cmd 0xffffc20000ab4280 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 1273
Aug 13 19:32:42 faramir kernel: usb 4-1: new low speed USB device using uhci_hcd and address 2
Aug 13 19:32:42 faramir kernel: usb 4-1: configuration #1 chosen from 1 choice
Aug 13 19:32:42 faramir kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 13 19:32:42 faramir kernel: ata1.00: ATA-7: HDT722516DLA380, V43OA96A, max UDMA/133
Aug 13 19:32:42 faramir kernel: ata1.00: 321672960 sectors, multi 16: LBA48 NCQ (depth 31/32)
Aug 13 19:32:42 faramir kernel: ata1.00: configured for UDMA/133
Aug 13 19:32:42 faramir kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 13 19:32:42 faramir kernel: ata2.00: ATA-7: HDT722516DLA380, V43OA91A, max UDMA/133
Aug 13 19:32:42 faramir kernel: ata2.00: 321672960 sectors, multi 16: LBA48 NCQ (depth 31/32)
Aug 13 19:32:42 faramir kernel: ata2.00: configured for UDMA/133
Aug 13 19:32:42 faramir kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 13 19:32:42 faramir kernel: ata3.00: ATAPI: Optiarc DVD RW AD-7170S, 1.00, max UDMA/66
Aug 13 19:32:42 faramir kernel: ata3.00: configured for UDMA/66
Aug 13 19:32:42 faramir kernel: ata4: SATA link down (SStatus 0 SControl 300)
Aug 13 19:32:42 faramir kernel: scsi 0:0:0:0: Direct-Access     ATA      HDT722516DLA380  V43O PQ: 0 ANSI: 5
Aug 13 19:32:42 faramir kernel: scsi 1:0:0:0: Direct-Access     ATA      HDT722516DLA380  V43O PQ: 0 ANSI: 5
Aug 13 19:32:42 faramir kernel: scsi 2:0:0:0: CD-ROM            Optiarc  DVD RW AD-7170S  1.00 PQ: 0 ANSI: 5
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:07:05.0[A] -> GSI 17 (level, low) -> IRQ 17
Aug 13 19:32:42 faramir kernel: firewire_ohci: Added fw-ohci device 0000:07:05.0, OHCI version 1.10
Aug 13 19:32:42 faramir kernel: ICH7: IDE controller at PCI slot 0000:00:1f.1
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
Aug 13 19:32:42 faramir kernel: ICH7: chipset revision 1
Aug 13 19:32:42 faramir kernel: ICH7: not 100% native mode: will probe irqs later
Aug 13 19:32:42 faramir kernel:     ide0: BM-DMA at 0x30b0-0x30b7, BIOS settings: hda:DMA, hdb:pio
Aug 13 19:32:42 faramir kernel: Probing IDE interface ide0...
Aug 13 19:32:42 faramir kernel: sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
Aug 13 19:32:42 faramir kernel: sd 0:0:0:0: [sda] Write Protect is off
Aug 13 19:32:42 faramir kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Aug 13 19:32:42 faramir kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 13 19:32:42 faramir kernel: sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
Aug 13 19:32:42 faramir kernel: sd 0:0:0:0: [sda] Write Protect is off
Aug 13 19:32:42 faramir kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Aug 13 19:32:42 faramir kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 13 19:32:42 faramir kernel:  sda: sda1 sda2 < sda5 sda6 > sda3 sda4
Aug 13 19:32:42 faramir kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Aug 13 19:32:42 faramir kernel: sd 1:0:0:0: [sdb] 321672960 512-byte hardware sectors (164697 MB)
Aug 13 19:32:42 faramir kernel: sd 1:0:0:0: [sdb] Write Protect is off
Aug 13 19:32:42 faramir kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Aug 13 19:32:42 faramir kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 13 19:32:42 faramir kernel: sd 1:0:0:0: [sdb] 321672960 512-byte hardware sectors (164697 MB)
Aug 13 19:32:42 faramir kernel: sd 1:0:0:0: [sdb] Write Protect is off
Aug 13 19:32:42 faramir kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Aug 13 19:32:42 faramir kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 13 19:32:42 faramir kernel:  sdb: sdb1 sdb2 < sdb5<6>usbcore: registered new interface driver hiddev
Aug 13 19:32:42 faramir kernel:  sdb6 >
Aug 13 19:32:42 faramir kernel: sd 1:0:0:0: [sdb] Attached SCSI disk
Aug 13 19:32:42 faramir kernel: sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Aug 13 19:32:42 faramir kernel: Uniform CD-ROM driver Revision: 3.20
Aug 13 19:32:42 faramir kernel: sr 2:0:0:0: Attached scsi CD-ROM sr0
Aug 13 19:32:42 faramir kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Aug 13 19:32:42 faramir kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
Aug 13 19:32:42 faramir kernel: sr 2:0:0:0: Attached scsi generic sg2 type 5
Aug 13 19:32:42 faramir kernel: input: USB Compliant Keyboard as /class/input/input0
Aug 13 19:32:42 faramir kernel: input: USB HID v1.10 Keyboard [USB Compliant Keyboard] on usb-0000:00:1d.2-1
Aug 13 19:32:42 faramir kernel: input: USB Compliant Keyboard as /class/input/input1
Aug 13 19:32:42 faramir kernel: input: USB HID v1.10 Device [USB Compliant Keyboard] on usb-0000:00:1d.2-1
Aug 13 19:32:42 faramir kernel: input: Logitech USB Receiver as /class/input/input2
Aug 13 19:32:42 faramir kernel: input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.3-1
Aug 13 19:32:42 faramir kernel: usbcore: registered new interface driver usbhid
Aug 13 19:32:42 faramir kernel: drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Aug 13 19:32:42 faramir kernel: firewire_core: created new fw device fw0 (0 config rom retries, S400)
Aug 13 19:32:42 faramir kernel: hda: LITE-ON DVD SOHD-16P9SV, ATAPI CD/DVD-ROM drive
Aug 13 19:32:42 faramir kernel: hda: selected mode 0x42
Aug 13 19:32:42 faramir kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 13 19:32:42 faramir kernel: hda: ATAPI 48X DVD-ROM drive, 254kB Cache, UDMA(33)
Aug 13 19:32:42 faramir kernel: device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
Aug 13 19:32:42 faramir kernel: kjournald starting.  Commit interval 5 seconds
Aug 13 19:32:42 faramir kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 13 19:32:42 faramir kernel: input: PC Speaker as /class/input/input3
Aug 13 19:32:42 faramir kernel: pnp: the driver 'parport_pc' has been registered
Aug 13 19:32:42 faramir kernel: pnp: match found with the PnP device '00:0a' and the driver 'parport_pc'
Aug 13 19:32:42 faramir kernel: parport_pc 00:0a: reported by Plug and Play ACPI
Aug 13 19:32:42 faramir kernel: parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Aug 13 19:32:42 faramir kernel: parport0: Printer, HEWLETT-PACKARD PHOTOSMART P1100
Aug 13 19:32:42 faramir kernel: iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
Aug 13 19:32:42 faramir kernel: iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, TCOBASE=0x0460)
Aug 13 19:32:42 faramir kernel: iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
Aug 13 19:32:42 faramir kernel: input: Power Button (FF) as /class/input/input4
Aug 13 19:32:42 faramir kernel: ACPI: Power Button (FF) [PWRF]
Aug 13 19:32:42 faramir kernel: input: Sleep Button (CM) as /class/input/input5
Aug 13 19:32:42 faramir kernel: ACPI: Sleep Button (CM) [SLPB]
Aug 13 19:32:42 faramir kernel: intel_rng: Firmware space is locked read-only. If you can't or
Aug 13 19:32:42 faramir kernel: intel_rng: don't want to disable this in firmware setup, and if
Aug 13 19:32:42 faramir kernel: intel_rng: you are certain that your system has a functional
Aug 13 19:32:42 faramir kernel: intel_rng: RNG, try using the 'no_fwh_detect' option.
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
Aug 13 19:32:42 faramir kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
Aug 13 19:32:42 faramir kernel: PCI: Setting latency timer of device 0000:00:1b.0 to 64
Aug 13 19:32:42 faramir kernel: Adding 979924k swap on /dev/sda6.  Priority:-1 extents:1 across:979924k
Aug 13 19:32:42 faramir kernel: EXT3 FS on dm-0, internal journal
Aug 13 19:32:42 faramir kernel: NET: Registered protocol family 10
Aug 13 19:32:42 faramir kernel: lo: Disabled Privacy Extensions
Aug 13 19:32:42 faramir kernel: i2c-adapter i2c-0: lm85: Detected SMSC chip
Aug 13 19:32:42 faramir kernel: i2c-adapter i2c-0: lm85: Unrecognized version/stepping 0x68 Defaulting to Generic LM85.
Aug 13 19:32:42 faramir kernel: fuse init (API version 7.8)
Aug 13 19:32:42 faramir kernel: kjournald starting.  Commit interval 5 seconds
Aug 13 19:32:42 faramir kernel: EXT3 FS on sda1, internal journal
Aug 13 19:32:42 faramir kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 13 19:32:42 faramir kernel: kjournald starting.  Commit interval 5 seconds
Aug 13 19:32:42 faramir kernel: EXT3 FS on dm-2, internal journal
Aug 13 19:32:42 faramir kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 13 19:32:42 faramir kernel: kjournald starting.  Commit interval 5 seconds
Aug 13 19:32:42 faramir kernel: EXT3 FS on dm-4, internal journal
Aug 13 19:32:42 faramir kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 13 19:32:42 faramir kernel: kjournald starting.  Commit interval 5 seconds
Aug 13 19:32:42 faramir kernel: EXT3 FS on dm-1, internal journal
Aug 13 19:32:42 faramir kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 13 19:32:42 faramir kernel: kjournald starting.  Commit interval 5 seconds
Aug 13 19:32:42 faramir kernel: EXT3 FS on dm-3, internal journal
Aug 13 19:32:42 faramir kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 13 19:32:42 faramir kernel: kjournald starting.  Commit interval 5 seconds
Aug 13 19:32:42 faramir kernel: EXT3 FS on dm-5, internal journal
Aug 13 19:32:42 faramir kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 13 19:32:42 faramir kernel: ADDRCONF(NETDEV_UP): eth0: link is not ready
Aug 13 19:32:42 faramir kernel: e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
Aug 13 19:32:42 faramir kernel: e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
Aug 13 19:32:42 faramir kernel: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Aug 13 19:32:45 faramir kernel: lp0: using parport0 (interrupt-driven).
Aug 13 19:32:45 faramir kernel: ppdev: user-space parallel port driver
Aug 13 19:32:50 faramir kernel: eth0: no IPv6 routers present
Aug 13 19:40:50 faramir kernel: ata1.00: exception Emask 0x2 SAct 0x7ffc7 SErr 0x0 action 0x2 frozen
Aug 13 19:40:50 faramir kernel: ata1.00: spurious completions during NCQ issue=0x0 SAct=0x7ffc7 FIS=005040a1:00000020
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/30:00:73:96:db/00:00:04:00:00/40 tag 0 cdb 0x0 data 24576 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/30:08:1b:97:db/00:00:04:00:00/40 tag 1 cdb 0x0 data 24576 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/10:10:53:97:db/00:00:04:00:00/40 tag 2 cdb 0x0 data 8192 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/08:30:1b:80:db/00:00:04:00:00/40 tag 6 cdb 0x0 data 4096 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/08:38:2b:80:db/00:00:04:00:00/40 tag 7 cdb 0x0 data 4096 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/60:40:3b:80:db/00:00:04:00:00/40 tag 8 cdb 0x0 data 49152 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/d0:48:a3:80:db/01:00:04:00:00/40 tag 9 cdb 0x0 data 237568 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/10:50:7b:82:db/00:00:04:00:00/40 tag 10 cdb 0x0 data 8192 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/08:58:93:82:db/00:00:04:00:00/40 tag 11 cdb 0x0 data 4096 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/10:60:a3:82:db/00:00:04:00:00/40 tag 12 cdb 0x0 data 8192 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/38:68:ab:96:db/00:00:04:00:00/40 tag 13 cdb 0x0 data 28672 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/10:70:eb:96:db/00:00:04:00:00/40 tag 14 cdb 0x0 data 8192 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/38:78:bb:82:db/00:00:04:00:00/40 tag 15 cdb 0x0 data 28672 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/10:80:03:97:db/00:00:04:00:00/40 tag 16 cdb 0x0 data 8192 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/08:88:6b:97:db/00:00:04:00:00/40 tag 17 cdb 0x0 data 4096 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1.00: cmd 61/08:90:7b:97:db/00:00:04:00:00/40 tag 18 cdb 0x0 data 4096 out
Aug 13 19:40:50 faramir kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
Aug 13 19:40:50 faramir kernel: ata1: soft resetting port
Aug 13 19:40:50 faramir kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 13 19:40:50 faramir kernel: ata1.00: configured for UDMA/133
Aug 13 19:40:50 faramir kernel: ata1: EH complete
Aug 13 19:40:50 faramir kernel: sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
Aug 13 19:40:50 faramir kernel: sd 0:0:0:0: [sda] Write Protect is off
Aug 13 19:40:50 faramir kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Aug 13 19:40:50 faramir kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 13 19:45:28 faramir kernel: fuse exit
Aug 13 19:45:29 faramir kernel: Kernel logging (proc) stopped.
Aug 13 19:45:29 faramir kernel: Kernel log daemon terminating.

--Boundary-00=_a1JwGtzkuJcxHpw
Content-Type: text/plain;
  charset="us-ascii";
  name="lsmod.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lsmod.txt"

Module                  Size  Used by
i915                   31488  2 
drm                   100392  3 i915
ppdev                  13832  0 
lp                     17480  0 
ac                     10632  0 
battery                17936  0 
nfs                   264440  1 
lockd                  73392  2 nfs
nfs_acl                 8192  1 nfs
sunrpc                189192  4 nfs,lockd,nfs_acl
fuse                   50480  1 
lm85                   39332  0 
hwmon_vid               7296  1 lm85
cpufreq_ondemand       13456  2 
acpi_cpufreq           13832  0 
freq_table              9728  2 cpufreq_ondemand,acpi_cpufreq
firewire_sbp2          18820  0 
ipv6                  294536  16 
snd_hda_intel         339364  1 
snd_pcm_oss            48288  0 
snd_mixer_oss          21376  1 snd_pcm_oss
snd_pcm                89864  2 snd_hda_intel,snd_pcm_oss
snd_seq_dummy           8452  0 
snd_seq_oss            36736  0 
snd_seq_midi           13376  0 
snd_rawmidi            30624  1 snd_seq_midi
snd_seq_midi_event     12416  2 snd_seq_oss,snd_seq_midi
snd_seq                58752  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              28552  2 snd_pcm,snd_seq
snd_seq_device         12948  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd                    65640  11 snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore              13216  1 snd
i2c_i801               13980  0 
psmouse                45724  0 
parport_pc             42664  1 
parport                44556  3 ppdev,lp,parport_pc
snd_page_alloc         14608  2 snd_hda_intel,snd_pcm
iTCO_wdt               17232  0 
intel_agp              32032  1 
serio_raw              11908  0 
i2c_core               30976  2 lm85,i2c_i801
button                 13856  0 
evdev                  15360  0 
tsdev                  13440  0 
joydev                 15744  0 
pcspkr                  7808  0 
ext3                  137232  7 
jbd                    68080  1 ext3
mbcache                13952  1 ext3
dm_mirror              27008  0 
dm_snapshot            21960  0 
dm_mod                 64112  15 dm_mirror,dm_snapshot
ide_cd                 44704  0 
ata_piix               23300  0 
ata_generic            13188  0 
sg                     40872  0 
sr_mod                 22436  0 
sd_mod                 33408  4 
cdrom                  39592  2 ide_cd,sr_mod
usbhid                 34144  0 
hid                    33152  1 usbhid
piix                   15236  0 [permanent]
ahci                   29700  3 
floppy                 67112  0 
generic                10372  0 [permanent]
firewire_ohci          22784  0 
firewire_core          49344  2 firewire_sbp2,firewire_ohci
crc_itu_t               6656  1 firewire_core
libata                129584  3 ata_piix,ata_generic,ahci
scsi_mod              164152  5 firewire_sbp2,sg,sr_mod,sd_mod,libata
ehci_hcd               39308  0 
ide_core              144168  3 ide_cd,piix,generic
uhci_hcd               29984  0 
e1000                 127296  0 
thermal                19728  1 
processor              42472  2 acpi_cpufreq,thermal
fan                    10248  1 

--Boundary-00=_a1JwGtzkuJcxHpw--
