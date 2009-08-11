From: Jim Duda <jim@duda.tzo.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Tue, 11 Aug 2009 07:25:55 -0400
Message-ID: <h5rkg5$op7$1@ger.gmane.org>
References: <h5kn9c$51r$1@ger.gmane.org> <20090809072823.GA2130@liondog.tnic> <4A7F85DB.40604@duda.tzo.com> <20090811043304.GA8085@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:36564 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913AbZHKMFC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Aug 2009 08:05:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MapUV-00037p-DO
	for linux-ide@vger.kernel.org; Tue, 11 Aug 2009 11:26:07 +0000
Received: from pool-96-252-13-163.bstnma.fios.verizon.net ([96.252.13.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 11 Aug 2009 11:26:07 +0000
Received: from jim by pool-96-252-13-163.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 11 Aug 2009 11:26:07 +0000
In-Reply-To: <20090811043304.GA8085@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 08/11/2009 12:33 AM, Borislav Petkov wrote:

>
> Yes, but send me the whole boot log.

Boris,

Here is the full boot log (from /var/log/messages history).

FYI, I'm beginning to believe that my entire problem might have more to
do with understanding what's in my backup as compared to a problem with
ide-tape.  I think the driver is working proerly now.  I'm going to do
a series of smaller tests.

I've learned that I can either use ide-tape or the st/libata drivers.
I can now switch back and forth between the two.  I get the same behavior
from either.  I will do some more testing with both, with smaller backup
sets.

Jim


> Aug  9 19:42:12 linux kernel: imklog 3.21.10, log source = /proc/kmsg started.
Aug  9 19:42:12 linux kernel: Linux version 2.6.31-rc1 (jduda@linux) (gcc version 4.3.2 20081105 (Red Hat 4.3.2-7) (GCC) ) #3 SMP PREEMPT Tue Aug 4 20:35:30 EDT 2009
Aug  9 19:42:12 linux kernel: KERNEL supported cpus:
Aug  9 19:42:12 linux kernel:  Intel GenuineIntel
Aug  9 19:42:12 linux kernel:  AMD AuthenticAMD
Aug  9 19:42:12 linux kernel:  NSC Geode by NSC
Aug  9 19:42:12 linux kernel:  Cyrix CyrixInstead
Aug  9 19:42:12 linux kernel:  Centaur CentaurHauls
Aug  9 19:42:12 linux kernel:  Transmeta GenuineTMx86
Aug  9 19:42:12 linux kernel:  Transmeta TransmetaCPU
Aug  9 19:42:12 linux kernel:  UMC UMC UMC UMC
Aug  9 19:42:12 linux kernel: BIOS-provided physical RAM map:
Aug  9 19:42:12 linux kernel: BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug  9 19:42:12 linux kernel: BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug  9 19:42:12 linux kernel: BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
Aug  9 19:42:12 linux kernel: BIOS-e820: 0000000000100000 - 000000003f730000 (usable)
Aug  9 19:42:12 linux kernel: BIOS-e820: 000000003f730000 - 000000003f740000 (ACPI data)
Aug  9 19:42:12 linux kernel: BIOS-e820: 000000003f740000 - 000000003f7f0000 (ACPI NVS)
Aug  9 19:42:12 linux kernel: BIOS-e820: 000000003f7f0000 - 000000003f800000 (reserved)
Aug  9 19:42:12 linux kernel: BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
Aug  9 19:42:12 linux kernel: user-defined physical RAM map:
Aug  9 19:42:12 linux kernel: user: 0000000000000000 - 000000000009fc00 (usable)
Aug  9 19:42:12 linux kernel: user: 000000000009fc00 - 00000000000a0000 (reserved)
Aug  9 19:42:12 linux kernel: user: 00000000000e8000 - 0000000000100000 (reserved)
Aug  9 19:42:12 linux kernel: user: 0000000000100000 - 000000003e800000 (usable)
Aug  9 19:42:12 linux kernel: user: 000000003f730000 - 000000003f740000 (ACPI data)
Aug  9 19:42:12 linux kernel: user: 000000003f740000 - 000000003f7f0000 (ACPI NVS)
Aug  9 19:42:12 linux kernel: user: 000000003f7f0000 - 000000003f800000 (reserved)
Aug  9 19:42:12 linux kernel: user: 00000000ffb80000 - 0000000100000000 (reserved)
Aug  9 19:42:12 linux kernel: DMI 2.3 present.
Aug  9 19:42:12 linux kernel: AMI BIOS detected: BIOS may corrupt low RAM, working around it.
Aug  9 19:42:12 linux kernel: last_pfn = 0x3e800 max_arch_pfn = 0x100000
Aug  9 19:42:12 linux kernel: init_memory_mapping: 0000000000000000-00000000377fe000
Aug  9 19:42:12 linux kernel: RAMDISK: 37c19000 - 37fefeb4
Aug  9 19:42:12 linux kernel: Allocated new RAMDISK: 00529000 - 008ffeb4
Aug  9 19:42:12 linux kernel: Move RAMDISK from 0000000037c19000 - 0000000037fefeb3 to 00529000 - 008ffeb3
Aug  9 19:42:12 linux kernel: ACPI: RSDP 000fa1d0 00014 (v00 ACPIAM)
Aug  9 19:42:12 linux kernel: ACPI: RSDT 3f730000 00030 (v01 A M I  OEMRSDT  06000305 MSFT 00000097)
Aug  9 19:42:12 linux kernel: ACPI: FACP 3f730200 00081 (v01 A M I  OEMFACP  06000305 MSFT 00000097)
Aug  9 19:42:12 linux kernel: ACPI: DSDT 3f7303f0 036CF (v01  P4G80 P4G80000 00000000 INTL 02002026)
Aug  9 19:42:12 linux kernel: ACPI: FACS 3f740000 00040
Aug  9 19:42:12 linux kernel: ACPI: APIC 3f730390 0005C (v01 A M I  OEMAPIC  06000305 MSFT 00000097)
Aug  9 19:42:12 linux kernel: ACPI: OEMB 3f740040 0003F (v01 A M I  OEMBIOS  06000305 MSFT 00000097)
Aug  9 19:42:12 linux kernel: 112MB HIGHMEM available.
Aug  9 19:42:12 linux kernel: 887MB LOWMEM available.
Aug  9 19:42:12 linux kernel:  mapped low ram: 0 - 377fe000
Aug  9 19:42:12 linux kernel:  low ram: 0 - 377fe000
Aug  9 19:42:12 linux kernel:  node 0 low ram: 00000000 - 377fe000
Aug  9 19:42:12 linux kernel:  node 0 bootmap 00011000 - 00017f00
Aug  9 19:42:12 linux kernel: (9 early reservations) ==> bootmem [0000000000 - 00377fe000]
Aug  9 19:42:12 linux kernel:  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
Aug  9 19:42:12 linux kernel:  #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
Aug  9 19:42:12 linux kernel:  #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
Aug  9 19:42:12 linux kernel:  #3 [0000100000 - 00005254dc]    TEXT DATA BSS ==> [0000100000 - 00005254dc]
Aug  9 19:42:12 linux kernel:  #4 [000009f400 - 0000100000]    BIOS reserved ==> [000009f400 - 0000100000]
Aug  9 19:42:12 linux kernel:  #5 [0000526000 - 0000528175]              BRK ==> [0000526000 - 0000528175]
Aug  9 19:42:12 linux kernel:  #6 [0000010000 - 0000011000]          PGTABLE ==> [0000010000 - 0000011000]
Aug  9 19:42:12 linux kernel:  #7 [0000529000 - 00008ffeb4]      NEW RAMDISK ==> [0000529000 - 00008ffeb4]
Aug  9 19:42:12 linux kernel:  #8 [0000011000 - 0000018000]          BOOTMAP ==> [0000011000 - 0000018000]
Aug  9 19:42:12 linux kernel: found SMP MP-table at [c00ff780] ff780
Aug  9 19:42:12 linux kernel: Zone PFN ranges:
Aug  9 19:42:12 linux kernel:  DMA      0x00000010 -> 0x00001000
Aug  9 19:42:12 linux kernel:  Normal   0x00001000 -> 0x000377fe
Aug  9 19:42:12 linux kernel:  HighMem  0x000377fe -> 0x0003e800
Aug  9 19:42:12 linux kernel: Movable zone start PFN for each node
Aug  9 19:42:12 linux kernel: early_node_map[2] active PFN ranges
Aug  9 19:42:12 linux kernel:    0: 0x00000010 -> 0x0000009f
Aug  9 19:42:12 linux kernel:    0: 0x00000100 -> 0x0003e800
Aug  9 19:42:12 linux kernel: Using APIC driver default
Aug  9 19:42:12 linux kernel: ACPI: PM-Timer IO Port: 0x808
Aug  9 19:42:12 linux kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Aug  9 19:42:12 linux kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Aug  9 19:42:12 linux kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Aug  9 19:42:12 linux kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Aug  9 19:42:12 linux kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Aug  9 19:42:12 linux kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Aug  9 19:42:12 linux kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Aug  9 19:42:12 linux kernel: Using ACPI (MADT) for SMP configuration information
Aug  9 19:42:12 linux kernel: SMP: Allowing 2 CPUs, 0 hotplug CPUs
Aug  9 19:42:12 linux kernel: Allocating PCI resources starting at 3f800000 (gap: 3f800000:c0380000)
Aug  9 19:42:12 linux kernel: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr_node_ids:1
Aug  9 19:42:12 linux kernel: PERCPU: Embedded 13 pages at c19cc000, static data 29980 bytes
Aug  9 19:42:12 linux kernel: Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 253386
Aug  9 19:42:12 linux kernel: Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet mem=1000M
Aug  9 19:42:12 linux kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
Aug  9 19:42:12 linux kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug  9 19:42:12 linux kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug  9 19:42:12 linux kernel: Enabling fast FPU save and restore... done.
Aug  9 19:42:12 linux kernel: Enabling unmasked SIMD FPU exception support... done.
Aug  9 19:42:12 linux kernel: Initializing CPU#0
Aug  9 19:42:12 linux kernel: Initializing HighMem for node 0 (000377fe:0003e800)
Aug  9 19:42:12 linux kernel: Memory: 1004056k/1024000k available (2290k kernel code, 19140k reserved, 1157k data, 308k init, 114696k highmem)
Aug  9 19:42:12 linux kernel: virtual kernel memory layout:
Aug  9 19:42:12 linux kernel:    fixmap  : 0xfff1f000 - 0xfffff000   ( 896 kB)
Aug  9 19:42:12 linux kernel:    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
Aug  9 19:42:12 linux kernel:    vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
Aug  9 19:42:12 linux kernel:    lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
Aug  9 19:42:12 linux kernel:      .init : 0xc0463000 - 0xc04b0000   ( 308 kB)
Aug  9 19:42:12 linux kernel:      .data : 0xc033c923 - 0xc045e0f0   (1157 kB)
Aug  9 19:42:12 linux kernel:      .text : 0xc0100000 - 0xc033c923   (2290 kB)
Aug  9 19:42:12 linux kernel: Checking if this processor honours the WP bit even in supervisor mode...Ok.
Aug  9 19:42:12 linux kernel: NR_IRQS:512
Aug  9 19:42:12 linux kernel: Fast TSC calibration using PIT
Aug  9 19:42:12 linux kernel: Detected 2800.090 MHz processor.
Aug  9 19:42:12 linux kernel: Console: colour VGA+ 80x25
Aug  9 19:42:12 linux kernel: console [tty0] enabled
Aug  9 19:42:12 linux kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 5600.18 BogoMIPS (lpj=2800090)
Aug  9 19:42:12 linux kernel: Security Framework initialized
Aug  9 19:42:12 linux kernel: SELinux:  Initializing.
Aug  9 19:42:12 linux kernel: Mount-cache hash table entries: 512
Aug  9 19:42:12 linux kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Aug  9 19:42:12 linux kernel: CPU: L2 cache: 512K
Aug  9 19:42:12 linux kernel: CPU: Physical Processor ID: 0
Aug  9 19:42:12 linux kernel: CPU: Processor Core ID: 0
Aug  9 19:42:12 linux kernel: mce: CPU supports 4 MCE banks
Aug  9 19:42:12 linux kernel: CPU0: Thermal monitoring enabled (TM1)
Aug  9 19:42:12 linux kernel: Checking 'hlt' instruction... OK.
Aug  9 19:42:12 linux kernel: ACPI: Core revision 20090521
Aug  9 19:42:12 linux kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Aug  9 19:42:12 linux kernel: CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Aug  9 19:42:12 linux kernel: Booting processor 1 APIC 0x1 ip 0x6000
Aug  9 19:42:12 linux kernel: Initializing CPU#1
Aug  9 19:42:12 linux kernel: Calibrating delay using timer specific routine.. 5599.16 BogoMIPS (lpj=2799583)
Aug  9 19:42:12 linux kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Aug  9 19:42:12 linux kernel: CPU: L2 cache: 512K
Aug  9 19:42:12 linux kernel: CPU: Physical Processor ID: 0
Aug  9 19:42:12 linux kernel: CPU: Processor Core ID: 0
Aug  9 19:42:12 linux kernel: mce: CPU supports 4 MCE banks
Aug  9 19:42:12 linux kernel: CPU1: Thermal monitoring enabled (TM1)
Aug  9 19:42:12 linux kernel: CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Aug  9 19:42:12 linux kernel: checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Aug  9 19:42:12 linux kernel: Brought up 2 CPUs
Aug  9 19:42:12 linux kernel: Total of 2 processors activated (11199.34 BogoMIPS).
Aug  9 19:42:12 linux kernel: khelper used greatest stack depth: 3256 bytes left
Aug  9 19:42:12 linux kernel: NET: Registered protocol family 16
Aug  9 19:42:12 linux kernel: ACPI: bus type pci registered
Aug  9 19:42:12 linux kernel: khelper used greatest stack depth: 3184 bytes left
Aug  9 19:42:12 linux kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
Aug  9 19:42:12 linux kernel: PCI: Using configuration type 1 for base access
Aug  9 19:42:12 linux kernel: bio: create slab <bio-0> at 0
Aug  9 19:42:12 linux kernel: ACPI: Interpreter enabled
Aug  9 19:42:12 linux kernel: ACPI: (supports S0 S1 S3 S5)
Aug  9 19:42:12 linux kernel: ACPI: Using IOAPIC for interrupt routing
Aug  9 19:42:12 linux kernel: ACPI Warning: Incorrect checksum in table [OEMB] - 9C, should be 9B 20090521 tbutils-246
Aug  9 19:42:12 linux kernel: ACPI: No dock devices found.
Aug  9 19:42:12 linux kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Aug  9 19:42:12 linux kernel: pci 0000:00:00.0: Enabling MCH 'Overflow' Device
Aug  9 19:42:12 linux kernel: pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
Aug  9 19:42:12 linux kernel: pci 0000:00:1d.7: PME# disabled
Aug  9 19:42:12 linux kernel: pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
Aug  9 19:42:12 linux kernel: pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH4 GPIO
Aug  9 19:42:12 linux kernel: pci 0000:00:1f.5: PME# supported from D0 D3hot D3cold
Aug  9 19:42:12 linux kernel: pci 0000:00:1f.5: PME# disabled
Aug  9 19:42:12 linux kernel: pci 0000:01:03.0: PME# supported from D1 D2 D3hot D3cold
Aug  9 19:42:12 linux kernel: pci 0000:01:03.0: PME# disabled
Aug  9 19:42:12 linux kernel: pci 0000:01:09.0: PME# supported from D0 D2 D3hot
Aug  9 19:42:12 linux kernel: pci 0000:01:09.0: PME# disabled
Aug  9 19:42:12 linux kernel: pci 0000:01:09.1: PME# supported from D0 D2 D3hot
Aug  9 19:42:12 linux kernel: pci 0000:01:09.1: PME# disabled
Aug  9 19:42:12 linux kernel: pci 0000:01:0f.0: PME# supported from D1 D2 D3hot D3cold
Aug  9 19:42:12 linux kernel: pci 0000:01:0f.0: PME# disabled
Aug  9 19:42:12 linux kernel: pci 0000:00:1e.0: transparent bridge
Aug  9 19:42:12 linux kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Aug  9 19:42:12 linux kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
Aug  9 19:42:12 linux kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Aug  9 19:42:12 linux kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
Aug  9 19:42:12 linux kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug  9 19:42:12 linux kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 *6 7 10 11 12 14 15)
Aug  9 19:42:12 linux kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Aug  9 19:42:12 linux kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Aug  9 19:42:12 linux kernel: usbcore: registered new interface driver usbfs
Aug  9 19:42:12 linux kernel: usbcore: registered new interface driver hub
Aug  9 19:42:12 linux kernel: usbcore: registered new device driver usb
Aug  9 19:42:12 linux kernel: PCI: Using ACPI for IRQ routing
Aug  9 19:42:12 linux kernel: HPET: 3 timers in total, 0 timers will be used for per-cpu timer
Aug  9 19:42:12 linux kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Aug  9 19:42:12 linux kernel: hpet0: 3 comparators, 64-bit 14.318180 MHz counter
Aug  9 19:42:12 linux kernel: pnp: PnP ACPI init
Aug  9 19:42:12 linux kernel: ACPI: bus type pnp registered
Aug  9 19:42:12 linux kernel: pnp: PnP ACPI: found 12 devices
Aug  9 19:42:12 linux kernel: ACPI: ACPI bus type pnp unregistered
Aug  9 19:42:12 linux kernel: system 00:06: ioport range 0x680-0x6ff has been reserved
Aug  9 19:42:12 linux kernel: system 00:07: ioport range 0x4d0-0x4d1 has been reserved
Aug  9 19:42:12 linux kernel: system 00:07: ioport range 0x800-0x87f has been reserved
Aug  9 19:42:12 linux kernel: system 00:07: ioport range 0x480-0x4bf has been reserved
Aug  9 19:42:12 linux kernel: system 00:07: iomem range 0xfed20000-0xfed8ffff has been reserved
Aug  9 19:42:12 linux kernel: system 00:07: iomem range 0xffb00000-0xffbfffff could not be reserved
Aug  9 19:42:12 linux kernel: system 00:08: iomem range 0xfec00000-0xfec00fff has been reserved
Aug  9 19:42:12 linux kernel: system 00:08: iomem range 0xfee00000-0xfee00fff has been reserved
Aug  9 19:42:12 linux kernel: system 00:0b: iomem range 0x0-0x9ffff could not be reserved
Aug  9 19:42:12 linux kernel: system 00:0b: iomem range 0xc0000-0xdffff could not be reserved
Aug  9 19:42:12 linux kernel: system 00:0b: iomem range 0xe0000-0xfffff could not be reserved
Aug  9 19:42:12 linux kernel: system 00:0b: iomem range 0x100000-0x3f7effff could not be reserved
Aug  9 19:42:12 linux kernel: system 00:0b: iomem range 0xfff00000-0xffffffff has been reserved
Aug  9 19:42:12 linux kernel: pci 0000:00:1e.0: PCI bridge, secondary bus 0000:01
Aug  9 19:42:12 linux kernel: pci 0000:00:1e.0:   IO window: 0xd000-0xdfff
Aug  9 19:42:12 linux kernel: pci 0000:00:1e.0:   MEM window: 0xf6400000-0xfe5fffff
Aug  9 19:42:12 linux kernel: pci 0000:00:1e.0:   PREFETCH window: 0xe6200000-0xe62fffff
Aug  9 19:42:12 linux kernel: NET: Registered protocol family 2
Aug  9 19:42:12 linux kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Aug  9 19:42:12 linux kernel: TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
Aug  9 19:42:12 linux kernel: TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
Aug  9 19:42:12 linux kernel: TCP: Hash tables configured (established 131072 bind 65536)
Aug  9 19:42:12 linux kernel: TCP reno registered
Aug  9 19:42:12 linux kernel: NET: Registered protocol family 1
Aug  9 19:42:12 linux kernel: Trying to unpack rootfs image as initramfs...
Aug  9 19:42:12 linux kernel: Freeing initrd memory: 3931k freed
Aug  9 19:42:12 linux kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Aug  9 19:42:12 linux kernel: apm: disabled - APM is not SMP safe.
Aug  9 19:42:12 linux kernel: audit: initializing netlink socket (disabled)
Aug  9 19:42:12 linux kernel: type=2000 audit(1249861302.367:1): initialized
Aug  9 19:42:12 linux kernel: highmem bounce pool size: 64 pages
Aug  9 19:42:12 linux kernel: HugeTLB registered 4 MB page size, pre-allocated 0 pages
Aug  9 19:42:12 linux kernel: VFS: Disk quotas dquot_6.5.2
Aug  9 19:42:12 linux kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Aug  9 19:42:12 linux kernel: msgmni has been set to 1745
Aug  9 19:42:12 linux kernel: cryptomgr_test used greatest stack depth: 3024 bytes left
Aug  9 19:42:12 linux kernel: alg: No test for stdrng (krng)
Aug  9 19:42:12 linux kernel: io scheduler noop registered
Aug  9 19:42:12 linux kernel: io scheduler anticipatory registered (default)
Aug  9 19:42:12 linux kernel: io scheduler deadline registered
Aug  9 19:42:12 linux kernel: io scheduler cfq registered
Aug  9 19:42:12 linux kernel: processor LNXCPU:00: registered as cooling_device0
Aug  9 19:42:12 linux kernel: processor LNXCPU:01: registered as cooling_device1
Aug  9 19:42:12 linux kernel: isapnp: Scanning for PnP cards...
Aug  9 19:42:12 linux kernel: isapnp: No Plug & Play device found
Aug  9 19:42:12 linux kernel: Real Time Clock Driver v1.12b
Aug  9 19:42:12 linux kernel: intel_rng: FWH not detected
Aug  9 19:42:12 linux kernel: Linux agpgart interface v0.103
Aug  9 19:42:12 linux kernel: agpgart-intel 0000:00:00.0: Intel 865 Chipset
Aug  9 19:42:12 linux kernel: agpgart-intel 0000:00:00.0: detected 8060K stolen memory
Aug  9 19:42:12 linux kernel: agpgart-intel 0000:00:00.0: AGP aperture is 128M @ 0xe8000000
Aug  9 19:42:12 linux kernel: Serial: 8250/16550 driver, 8 ports, IRQ sharing enabled
Aug  9 19:42:12 linux kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug  9 19:42:12 linux kernel: Platform driver 'serial8250' needs updating - please use dev_pm_ops
Aug  9 19:42:12 linux kernel: brd: module loaded
Aug  9 19:42:12 linux kernel: Uniform Multi-Platform E-IDE driver
Aug  9 19:42:12 linux kernel: piix 0000:00:1f.1: IDE controller (0x8086:0x24db rev 0x02)
Aug  9 19:42:12 linux kernel: PIIX_IDE 0000:00:1f.1: enabling device (0005 -> 0007)
Aug  9 19:42:12 linux kernel: PIIX_IDE 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Aug  9 19:42:12 linux kernel: piix 0000:00:1f.1: not 100% native mode: will probe irqs later
Aug  9 19:42:12 linux kernel:    ide0: BM-DMA at 0xfc00-0xfc07
Aug  9 19:42:12 linux kernel:    ide1: BM-DMA at 0xfc08-0xfc0f
Aug  9 19:42:12 linux kernel: hdc: HL-DT-ST GCE-8160B, ATAPI CD/DVD-ROM drive
Aug  9 19:42:12 linux kernel: hdd: Seagate STT20000A, ATAPI TAPE drive
Aug  9 19:42:12 linux kernel: hdc: MWDMA2 mode selected
Aug  9 19:42:12 linux kernel: hdd: Disabling (U)DMA for Seagate STT20000A (blacklisted)
Aug  9 19:42:12 linux kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug  9 19:42:12 linux kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug  9 19:42:12 linux kernel: ide-gd driver 1.18
Aug  9 19:42:12 linux kernel: ide-cd driver 5.00
Aug  9 19:42:12 linux kernel: ide-cd: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache
Aug  9 19:42:12 linux kernel: Uniform CD-ROM driver Revision: 3.20
Aug  9 19:42:12 linux kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Aug  9 19:42:12 linux kernel: Platform driver 'i8042' needs updating - please use dev_pm_ops
Aug  9 19:42:12 linux kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug  9 19:42:12 linux kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug  9 19:42:12 linux kernel: mice: PS/2 mouse device common for all mice
Aug  9 19:42:12 linux kernel: cpuidle: using governor ladder
Aug  9 19:42:12 linux kernel: usbcore: registered new interface driver hiddev
Aug  9 19:42:12 linux kernel: usbcore: registered new interface driver usbhid
Aug  9 19:42:12 linux kernel: usbhid: v2.6:USB HID core driver
Aug  9 19:42:12 linux kernel: TCP cubic registered
Aug  9 19:42:12 linux kernel: Initializing XFRM netlink socket
Aug  9 19:42:12 linux kernel: NET: Registered protocol family 17
Aug  9 19:42:12 linux kernel: Using IPI No-Shortcut mode
Aug  9 19:42:12 linux kernel: Freeing unused kernel memory: 308k freed
Aug  9 19:42:12 linux kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Aug  9 19:42:12 linux kernel: ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 23 (level, low) -> IRQ 23
Aug  9 19:42:12 linux kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Aug  9 19:42:12 linux kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Aug  9 19:42:12 linux kernel: ehci_hcd 0000:00:1d.7: debug port 1
Aug  9 19:42:12 linux kernel: ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfe77bc00
Aug  9 19:42:12 linux kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
Aug  9 19:42:12 linux kernel: usb usb1: configuration #1 chosen from 1 choice
Aug  9 19:42:12 linux kernel: hub 1-0:1.0: USB hub found
Aug  9 19:42:12 linux kernel: hub 1-0:1.0: 8 ports detected
Aug  9 19:42:12 linux kernel: modprobe used greatest stack depth: 2680 bytes left
Aug  9 19:42:12 linux kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Aug  9 19:42:12 linux kernel: uhci_hcd: USB Universal Host Controller Interface driver
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000ef00
Aug  9 19:42:12 linux kernel: usb usb2: configuration #1 chosen from 1 choice
Aug  9 19:42:12 linux kernel: hub 2-0:1.0: USB hub found
Aug  9 19:42:12 linux kernel: hub 2-0:1.0: 2 ports detected
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ef20
Aug  9 19:42:12 linux kernel: usb usb3: configuration #1 chosen from 1 choice
Aug  9 19:42:12 linux kernel: hub 3-0:1.0: USB hub found
Aug  9 19:42:12 linux kernel: hub 3-0:1.0: 2 ports detected
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ef40
Aug  9 19:42:12 linux kernel: usb usb4: configuration #1 chosen from 1 choice
Aug  9 19:42:12 linux kernel: hub 4-0:1.0: USB hub found
Aug  9 19:42:12 linux kernel: hub 4-0:1.0: 2 ports detected
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.3: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Aug  9 19:42:12 linux kernel: uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000ef80
Aug  9 19:42:12 linux kernel: usb usb5: configuration #1 chosen from 1 choice
Aug  9 19:42:12 linux kernel: hub 5-0:1.0: USB hub found
Aug  9 19:42:12 linux kernel: hub 5-0:1.0: 2 ports detected
Aug  9 19:42:12 linux kernel: modprobe used greatest stack depth: 2668 bytes left
Aug  9 19:42:12 linux kernel: SCSI subsystem initialized
Aug  9 19:42:12 linux kernel: ata_piix 0000:00:1f.2: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Aug  9 19:42:12 linux kernel: ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
Aug  9 19:42:12 linux kernel: scsi0 : ata_piix
Aug  9 19:42:12 linux kernel: scsi1 : ata_piix
Aug  9 19:42:12 linux kernel: ata1: SATA max UDMA/133 cmd 0xefe0 ctl 0xefac bmdma 0xef60 irq 18
Aug  9 19:42:12 linux kernel: ata2: SATA max UDMA/133 cmd 0xefa0 ctl 0xefa8 bmdma 0xef68 irq 18
Aug  9 19:42:12 linux kernel: ata1.00: ATA-7: Maxtor 6L200S0, BANC1G10, max UDMA/133
Aug  9 19:42:12 linux kernel: ata1.00: 398297088 sectors, multi 16: LBA48 NCQ (not used)
Aug  9 19:42:12 linux kernel: ata2.00: ATA-7: Maxtor 7L300S0, BANC1G10, max UDMA/133
Aug  9 19:42:12 linux kernel: ata2.00: 586114704 sectors, multi 16: LBA48 NCQ (not used)
Aug  9 19:42:12 linux kernel: ata1.00: configured for UDMA/133
Aug  9 19:42:12 linux kernel: ata2.00: configured for UDMA/133
Aug  9 19:42:12 linux kernel: scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6L200S0   BANC PQ: 0 ANSI: 5
Aug  9 19:42:12 linux kernel: sd 0:0:0:0: [sda] 398297088 512-byte logical blocks: (203 GB/189 GiB)
Aug  9 19:42:12 linux kernel: scsi 1:0:0:0: Direct-Access     ATA      Maxtor 7L300S0   BANC PQ: 0 ANSI: 5
Aug  9 19:42:12 linux kernel: sd 0:0:0:0: [sda] Write Protect is off
Aug  9 19:42:12 linux kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  9 19:42:12 linux kernel: sd 1:0:0:0: [sdb] 586114704 512-byte logical blocks: (300 GB/279 GiB)
Aug  9 19:42:12 linux kernel: sda:
Aug  9 19:42:12 linux kernel: sd 1:0:0:0: [sdb] Write Protect is off
Aug  9 19:42:12 linux kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  9 19:42:12 linux kernel: sdb: sda1 sda2
Aug  9 19:42:12 linux kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Aug  9 19:42:12 linux kernel: unknown partition table
Aug  9 19:42:12 linux kernel: sd 1:0:0:0: [sdb] Attached SCSI disk
Aug  9 19:42:12 linux kernel: device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
Aug  9 19:42:12 linux kernel: input: PS/2 Logitech Mouse as /class/input/input0
Aug  9 19:42:12 linux kernel: input: AT Translated Set 2 keyboard as /class/input/input1
Aug  9 19:42:12 linux kernel: usb 3-1: new full speed USB device using uhci_hcd and address 2
Aug  9 19:42:12 linux kernel: lvm used greatest stack depth: 2120 bytes left
Aug  9 19:42:12 linux kernel: device-mapper: table: 253:0: target device sda2 is misaligned
Aug  9 19:42:12 linux kernel: device-mapper: table: 253:0: target device sda2 is misaligned
Aug  9 19:42:12 linux kernel: device-mapper: table: 253:1: target device sda2 is misaligned
Aug  9 19:42:12 linux kernel: device-mapper: table: 253:1: target device sda2 is misaligned
Aug  9 19:42:12 linux kernel: usb 3-1: configuration #1 chosen from 1 choice
Aug  9 19:42:12 linux kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Aug  9 19:42:12 linux kernel: EXT3-fs: write access will be enabled during recovery.
Aug  9 19:42:12 linux kernel: EXT3-fs: dm-0: orphan cleanup on readonly fs
Aug  9 19:42:12 linux kernel: EXT3-fs: dm-0: 5 orphan inodes deleted
Aug  9 19:42:12 linux kernel: EXT3-fs: recovery complete.
Aug  9 19:42:12 linux kernel: kjournald starting.  Commit interval 5 seconds
Aug  9 19:42:12 linux kernel: EXT3-fs: mounted filesystem with writeback data mode.
Aug  9 19:42:12 linux kernel: SELinux:  Disabled at runtime.
Aug  9 19:42:12 linux kernel: type=1404 audit(1249861307.958:2): selinux=0 auid=4294967295 ses=4294967295
Aug  9 19:42:12 linux kernel: cat used greatest stack depth: 2032 bytes left
Aug  9 19:42:12 linux kernel: udevd version 127 started
Aug  9 19:42:12 linux kernel: Platform driver 'pcspkr' needs updating - please use dev_pm_ops
Aug  9 19:42:12 linux kernel: input: PC Speaker as /class/input/input2
Aug  9 19:42:12 linux kernel: ide-tape: hdd <-> ht0: Seagate STT20000A rev 8A51
Aug  9 19:42:12 linux kernel: ide-tape: hdd <-> ht0: 232KBps, 6*54kB buffer, 400ms tDSC
Aug  9 19:42:12 linux kernel: 00:05: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug  9 19:42:12 linux kernel: serial 0000:01:09.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
Aug  9 19:42:12 linux kernel: ttyS4: detected caps 00000700 should be 00000100
Aug  9 19:42:12 linux kernel: 0000:01:09.0: ttyS4 at I/O 0xdea0 (irq = 21) is a 16C950/954
Aug  9 19:42:12 linux kernel: ttyS5: detected caps 00000700 should be 00000100
Aug  9 19:42:12 linux kernel: 0000:01:09.0: ttyS5 at I/O 0xdea8 (irq = 21) is a 16C950/954
Aug  9 19:42:12 linux kernel: ttyS6: detected caps 00000700 should be 00000100
Aug  9 19:42:12 linux kernel: 0000:01:09.0: ttyS6 at I/O 0xdeb0 (irq = 21) is a 16C950/954
Aug  9 19:42:12 linux kernel: ttyS7: detected caps 00000700 should be 00000100
Aug  9 19:42:12 linux kernel: 0000:01:09.0: ttyS7 at I/O 0xdeb8 (irq = 21) is a 16C950/954
Aug  9 19:42:12 linux kernel: usbcore: registered new interface driver usbserial
Aug  9 19:42:12 linux kernel: USB Serial support registered for generic
Aug  9 19:42:12 linux kernel: usbcore: registered new interface driver usbserial_generic
Aug  9 19:42:12 linux kernel: usbserial: USB Serial Driver core
Aug  9 19:42:12 linux kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Aug  9 19:42:12 linux kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
Aug  9 19:42:12 linux kernel: input: Power Button as /class/input/input3
Aug  9 19:42:12 linux kernel: ACPI: Power Button [PWRF]
Aug  9 19:42:12 linux kernel: input: Power Button as /class/input/input4
Aug  9 19:42:12 linux kernel: ACPI: Power Button [PWRB]
Aug  9 19:42:12 linux kernel: 8139too Fast Ethernet driver 0.9.28
Aug  9 19:42:12 linux kernel: 8139too 0000:01:0f.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Aug  9 19:42:12 linux kernel: eth0: RealTek RTL8139 at 0xd400, 00:0c:6e:82:94:4e, IRQ 19
Aug  9 19:42:12 linux kernel: sata_sil 0000:01:05.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
Aug  9 19:42:12 linux kernel: scsi2 : sata_sil
Aug  9 19:42:12 linux kernel: scsi3 : sata_sil
Aug  9 19:42:12 linux kernel: ata3: SATA max UDMA/100 mmio m512@0xfe5ff800 tf 0xfe5ff880 irq 21
Aug  9 19:42:12 linux kernel: ata4: SATA max UDMA/100 mmio m512@0xfe5ff800 tf 0xfe5ff8c0 irq 21
Aug  9 19:42:12 linux kernel: r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Aug  9 19:42:12 linux kernel: r8169 0000:01:03.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Aug  9 19:42:12 linux kernel: r8169 0000:01:03.0: no PCI Express capability
Aug  9 19:42:12 linux kernel: eth1: RTL8110s at 0xf8bf4c00, 00:14:bf:56:f4:1d, XID 04000000 IRQ 16
Aug  9 19:42:12 linux kernel: USB Serial support registered for pl2303
Aug  9 19:42:12 linux kernel: pl2303 3-1:1.0: pl2303 converter detected
Aug  9 19:42:12 linux kernel: usb 3-1: pl2303 converter now attached to ttyUSB0
Aug  9 19:42:12 linux kernel: usbcore: registered new interface driver pl2303
Aug  9 19:42:12 linux kernel: pl2303: Prolific PL2303 USB to serial adaptor driver
Aug  9 19:42:12 linux kernel: i801_smbus 0000:00:1f.3: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Aug  9 19:42:12 linux kernel: ata3: SATA link down (SStatus 0 SControl 310)
Aug  9 19:42:12 linux kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Aug  9 19:42:12 linux kernel: ata4.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
Aug  9 19:42:12 linux kernel: ata4.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
Aug  9 19:42:12 linux kernel: ata4.00: configured for UDMA/100
Aug  9 19:42:12 linux kernel: scsi 3:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0 ANSI: 5
Aug  9 19:42:12 linux kernel: sd 3:0:0:0: [sdc] 976773168 512-byte logical blocks: (500 GB/465 GiB)
Aug  9 19:42:12 linux kernel: sd 3:0:0:0: Attached scsi generic sg2 type 0
Aug  9 19:42:12 linux kernel: sd 3:0:0:0: [sdc] Write Protect is off
Aug  9 19:42:12 linux kernel: sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  9 19:42:12 linux kernel: sdc: unknown partition table
Aug  9 19:42:12 linux kernel: sd 3:0:0:0: [sdc] Attached SCSI disk
Aug  9 19:42:12 linux kernel: Linux video capture interface: v2.00
Aug  9 19:42:12 linux kernel: Intel ICH 0000:00:1f.5: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Aug  9 19:42:12 linux kernel: ENS1371 0000:01:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Aug  9 19:42:12 linux kernel: bttv: driver version 0.9.18 loaded
Aug  9 19:42:12 linux kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Aug  9 19:42:12 linux kernel: cx88/0: cx2388x v4l2 driver version 0.0.7 loaded
Aug  9 19:42:12 linux kernel: cx2388x alsa driver version 0.0.7 loaded
Aug  9 19:42:12 linux kernel: cx88/2: cx2388x MPEG-TS Driver Manager version 0.0.7 loaded
Aug  9 19:42:12 linux kernel: intel8x0_measure_ac97_clock: measured 50586 usecs (2438 samples)
Aug  9 19:42:12 linux kernel: intel8x0: clocking to 48000
Aug  9 19:42:12 linux kernel: modprobe used greatest stack depth: 1456 bytes left
Aug  9 19:42:12 linux kernel: bttv: Bt8xx card found (0).
Aug  9 19:42:12 linux kernel: bttv 0000:01:0b.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
Aug  9 19:42:12 linux kernel: bttv0: Bt878 (rev 17) at 0000:01:0b.0, irq: 23, latency: 64, mmio: 0xe62fe000
Aug  9 19:42:12 linux kernel: bttv0: using: GrandTec Multi Capture Card (Bt878) [card=77,insmod option]
Aug  9 19:42:12 linux kernel: IRQ 23/bttv0: IRQF_DISABLED is not guaranteed on shared IRQs
Aug  9 19:42:12 linux kernel: bttv0: tuner absent
Aug  9 19:42:12 linux kernel: bttv0: registered device video0
Aug  9 19:42:12 linux kernel: bttv0: registered device vbi0
Aug  9 19:42:12 linux kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Aug  9 19:42:12 linux kernel: cx8800 0000:01:0a.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
Aug  9 19:42:12 linux kernel: cx88[0]: subsystem: 7063:5500, board: pcHDTV HD5500 HDTV [card=47,autodetected], frontend(s): 1
Aug  9 19:42:12 linux kernel: cx88[0]: TV tuner type 64, Radio tuner type -1
Aug  9 19:42:12 linux kernel: tuner 2-0043: chip found @ 0x86 (cx88[0])
Aug  9 19:42:12 linux kernel: tda9887 2-0043: creating new instance
Aug  9 19:42:12 linux kernel: tda9887 2-0043: tda988[5/6/7] found
Aug  9 19:42:12 linux kernel: tuner 2-0061: chip found @ 0xc2 (cx88[0])
Aug  9 19:42:12 linux kernel: tuner-simple 2-0061: creating new instance
Aug  9 19:42:12 linux kernel: tuner-simple 2-0061: type set to 64 (LG TDVS-H06xF)
Aug  9 19:42:12 linux kernel: input: cx88 IR (pcHDTV HD5500 HDTV) as /class/input/input5
Aug  9 19:42:12 linux kernel: cx88[0]/0: found at 0000:01:0a.0, rev: 5, irq: 22, latency: 64, mmio: 0xfa000000
Aug  9 19:42:12 linux kernel: IRQ 22/cx88[0]: IRQF_DISABLED is not guaranteed on shared IRQs
Aug  9 19:42:12 linux kernel: cx88[0]/0: registered device video1 [v4l2]
Aug  9 19:42:12 linux kernel: cx88[0]/0: registered device vbi1
Aug  9 19:42:12 linux kernel: cx88_audio 0000:01:0a.1: PCI INT A -> GSI 22 (level, low) -> IRQ 22
Aug  9 19:42:12 linux kernel: IRQ 22/cx88[0]: IRQF_DISABLED is not guaranteed on shared IRQs
Aug  9 19:42:12 linux kernel: cx88[0]/1: CX88x/0: ALSA support for cx2388x boards
Aug  9 19:42:12 linux kernel: cx88[0]/2: cx2388x 8802 Driver Manager
Aug  9 19:42:12 linux kernel: cx88-mpeg driver manager 0000:01:0a.2: PCI INT A -> GSI 22 (level, low) -> IRQ 22
Aug  9 19:42:12 linux kernel: cx88[0]/2: found at 0000:01:0a.2, rev: 5, irq: 22, latency: 64, mmio: 0xfc000000
Aug  9 19:42:12 linux kernel: IRQ 22/cx88[0]: IRQF_DISABLED is not guaranteed on shared IRQs
Aug  9 19:42:12 linux kernel: cx88/2: cx2388x dvb driver version 0.0.7 loaded
Aug  9 19:42:12 linux kernel: cx88/2: registering cx8802 driver, type: dvb access: shared
Aug  9 19:42:12 linux kernel: cx88[0]/2: subsystem: 7063:5500, board: pcHDTV HD5500 HDTV [card=47]
Aug  9 19:42:12 linux kernel: cx88[0]/2: cx2388x based DVB/ATSC card
Aug  9 19:42:12 linux kernel: cx8802_alloc_frontends() allocating 1 frontend(s)
Aug  9 19:42:12 linux kernel: tuner-simple 2-0061: attaching existing instance
Aug  9 19:42:12 linux kernel: tuner-simple 2-0061: type set to 64 (LG TDVS-H06xF)
Aug  9 19:42:12 linux kernel: tda9887 2-0043: attaching existing instance
Aug  9 19:42:12 linux kernel: DVB: registering new adapter (cx88[0])
Aug  9 19:42:12 linux kernel: DVB: registering adapter 0 frontend 0 (LG Electronics LGDT3303 VSB/QAM Frontend)...
Aug  9 19:42:12 linux kernel: device-mapper: table: 253:2: target device sdb is misaligned
Aug  9 19:42:12 linux kernel: device-mapper: table: 253:2: target device sdc is misaligned
Aug  9 19:42:12 linux kernel: device-mapper: table: 253:2: target device sdb is misaligned
Aug  9 19:42:12 linux kernel: device-mapper: table: 253:2: target device sdc is misaligned
Aug  9 19:42:12 linux kernel: EXT3 FS on dm-0, internal journal
Aug  9 19:42:12 linux kernel: kjournald starting.  Commit interval 5 seconds
Aug  9 19:42:12 linux kernel: EXT3 FS on sda1, internal journal
Aug  9 19:42:12 linux kernel: EXT3-fs: mounted filesystem with writeback data mode.
Aug  9 19:42:12 linux kernel: kjournald starting.  Commit interval 5 seconds
Aug  9 19:42:12 linux kernel: EXT3 FS on dm-2, internal journal
Aug  9 19:42:12 linux kernel: EXT3-fs: mounted filesystem with writeback data mode.
Aug  9 19:42:12 linux kernel: Adding 1015800k swap on /dev/mapper/VolGroup00-LogVol01.  Priority:-1 extents:1 across:1015800k
Aug  9 19:42:12 linux kernel: NET: Registered protocol family 10
Aug  9 19:42:12 linux kernel: lo: Disabled Privacy Extensions
Aug  9 19:42:12 linux kernel: r8169: eth1: link up
Aug  9 19:42:12 linux rsyslogd: [origin software="rsyslogd" swVersion="3.21.10" x-pid="1679" x-info="http://www.rsyslog.com"] restart
Aug  9 19:42:12 linux rpc.statd[1717]: Version 1.1.4 Starting
Aug  9 19:42:13 linux kernel: RPC: Registered udp transport module.
Aug  9 19:42:13 linux kernel: RPC: Registered tcp transport module.
Aug  9 19:42:16 linux acpid: starting up
Aug  9 19:42:16 linux ypserv[1830]: WARNING: no securenets file found!
Aug  9 19:42:17 linux dnsmasq[1865]: started, version 2.45 cachesize 150
Aug  9 19:42:17 linux dnsmasq[1865]: compile time options: IPv6 GNU-getopt no-ISC-leasefile DBus no-I18N TFTP
Aug  9 19:42:17 linux dnsmasq[1865]: reading /etc/resolv.conf
Aug  9 19:42:17 linux dnsmasq[1865]: using nameserver 71.250.0.12#53
Aug  9 19:42:17 linux dnsmasq[1865]: using nameserver 71.243.0.12#53
Aug  9 19:42:17 linux dnsmasq[1865]: read /etc/hosts - 14 addresses
Aug  9 19:42:17 linux xinetd[1884]: /etc/xinetd.d/archive is not a regular file. It is being skipped.
Aug  9 19:42:17 linux ntpd[1891]: ntpd 4.2.4p6@1.1549-o Mon Jan 12 14:07:28 UTC 2009 (1)
Aug  9 19:42:17 linux ntpd[1892]: precision = 0.627 usec
Aug  9 19:42:17 linux ntpd[1892]: Listening on interface #0 wildcard, 0.0.0.0#123 Disabled
Aug  9 19:42:17 linux ntpd[1892]: Listening on interface #1 wildcard, ::#123 Disabled
Aug  9 19:42:17 linux ntpd[1892]: Listening on interface #2 lo, ::1#123 Enabled
Aug  9 19:42:17 linux ntpd[1892]: Listening on interface #3 eth1, fe80::214:bfff:fe56:f41d#123 Enabled
Aug  9 19:42:17 linux ntpd[1892]: Listening on interface #4 lo, 127.0.0.1#123 Enabled
Aug  9 19:42:17 linux ntpd[1892]: Listening on interface #5 eth1, 192.168.1.254#123 Enabled
Aug  9 19:42:17 linux ntpd[1892]: Listening on routing socket on fd #22 for interface updates
Aug  9 19:42:17 linux ntpd[1892]: kernel time sync status 0040
Aug  9 19:42:17 linux xinetd[1884]: /etc/xinetd.d/save is not a regular file. It is being skipped.
Aug  9 19:42:17 linux ntpd[1892]: frequency initialized -74.253 PPM from /var/lib/ntp/drift
Aug  9 19:42:17 linux xinetd[1884]: xinetd Version 2.3.14 started with libwrap loadavg labeled-networking options compiled in.
Aug  9 19:42:17 linux xinetd[1884]: Started working: 2 available services
Aug  9 19:42:18 linux kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Aug  9 19:42:18 linux rpc.idmapd[1754]: nfsdreopen: Opening '/proc/net/rpc/nfs4.nametoid/channel' failed: errno 2 (No such file or directory)
Aug  9 19:42:18 linux rpc.idmapd[1754]: nfsdreopen: Opening '/proc/net/rpc/nfs4.idtoname/channel' failed: errno 2 (No such file or directory)
Aug  9 19:42:21 linux dhcpd: Internet Systems Consortium DHCP Server 4.0.0
Aug  9 19:42:21 linux dhcpd: Copyright 2004-2007 Internet Systems Consortium.
Aug  9 19:42:21 linux dhcpd: All rights reserved.
Aug  9 19:42:21 linux dhcpd: For info, please visit http://www.isc.org/sw/dhcp/
Aug  9 19:42:21 linux dhcpd: Not searching LDAP since ldap-server, ldap-port and ldap-base-dn were not specified in the config file
Aug  9 19:42:21 linux dhcpd: Wrote 0 class decls to leases file.
Aug  9 19:42:21 linux dhcpd: Wrote 0 deleted host decls to leases file.
Aug  9 19:42:21 linux dhcpd: Wrote 0 new dynamic host decls to leases file.
Aug  9 19:42:21 linux dhcpd: Wrote 48 leases to leases file.
Aug  9 19:42:21 linux dhcpd: Listening on LPF/eth1/00:14:bf:56:f4:1d/192.168.1.0/24
Aug  9 19:42:21 linux dhcpd: Sending on   LPF/eth1/00:14:bf:56:f4:1d/192.168.1.0/24
Aug  9 19:42:21 linux dhcpd: Sending on   Socket/fallback/fallback-net
Aug  9 19:42:26 linux /usr/sbin/gpm[2165]: *** info [daemon/startup.c(136)]:
Aug  9 19:42:26 linux /usr/sbin/gpm[2165]: Started gpm successfully. Entered daemon mode.
Aug  9 19:42:26 linux /usr/sbin/gpm[2165]: *** info [mice.c(1988)]:
Aug  9 19:42:26 linux /usr/sbin/gpm[2165]: imps2: Auto-detected intellimouse PS/2
Aug  9 19:42:29 linux kernel: fuse init (API version 7.11)
Aug  9 19:42:32 linux avahi-daemon[2300]: Found user 'avahi' (UID 70) and group 'avahi' (GID 70).
Aug  9 19:42:32 linux avahi-daemon[2300]: Successfully dropped root privileges.
Aug  9 19:42:32 linux avahi-daemon[2300]: avahi-daemon 0.6.22 starting up.
Aug  9 19:42:32 linux avahi-daemon[2300]: WARNING: No NSS support for mDNS detected, consider installing nss-mdns!
Aug  9 19:42:32 linux avahi-daemon[2300]: Successfully called chroot().
Aug  9 19:42:32 linux avahi-daemon[2300]: Successfully dropped remaining capabilities.
Aug  9 19:42:32 linux avahi-daemon[2300]: Loading service file /services/ssh.service.
Aug  9 19:42:32 linux avahi-daemon[2300]: Joining mDNS multicast group on interface eth1.IPv4 with address 192.168.1.254.
Aug  9 19:42:32 linux avahi-daemon[2300]: New relevant interface eth1.IPv4 for mDNS.
Aug  9 19:42:32 linux avahi-daemon[2300]: Network interface enumeration completed.
Aug  9 19:42:32 linux avahi-daemon[2300]: Registering new address record for fe80::214:bfff:fe56:f41d on eth1.*.
Aug  9 19:42:32 linux avahi-daemon[2300]: Registering new address record for 192.168.1.254 on eth1.IPv4.
Aug  9 19:42:32 linux avahi-daemon[2300]: Registering HINFO record with values 'I686'/'LINUX'.
Aug  9 19:42:33 linux avahi-daemon[2300]: Server startup complete. Host name is linux.local. Local service cookie is 2163202976.
Aug  9 19:42:34 linux avahi-daemon[2300]: Service "linux" (/services/ssh.service) successfully established.
Aug  9 19:42:36 linux logger: Starting misterhouse:
Aug  9 19:42:36 linux logger: /usr/local/bin:/usr/X11R6/bin:/sbin:/usr/sbin:/bin:/usr/bin
Aug  9 19:42:36 linux logger: /home/misterhouse
Aug  9 19:42:36 linux acpid: client connected from 2530[68:68]
Aug  9 19:42:36 linux logger: :/usr/local/lib
Aug  9 19:42:36 linux logger: :0
Aug  9 19:42:36 linux logger: /bin/tcsh
Aug  9 19:42:44 linux pulseaudio[2562]: pid.c: Stale PID file, overwriting.
Aug  9 19:42:44 linux pulseaudio[2562]: module-alsa-card.c: Failed to find a working profile.
Aug  9 19:42:44 linux pulseaudio[2562]: module.c: Failed to load  module "module-alsa-card" (argument: "device_id=2 name=pci_14f1_8801 card_name=alsa_card.pci_14f1_8801 tsched=1"): initialization failed.
Aug  9 19:42:46 linux pulseaudio[2562]: main.c: Failed to acquire org.pulseaudio.Server: org.freedesktop.DBus.Error.AccessDenied: Connection ":1.8" is not allowed to own the service "org.pulseaudio.Server" due to security policies in the configuration file
Aug  9 19:42:46 linux smartd[2578]: smartd version 5.38 [i386-redhat-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Aug  9 19:42:46 linux smartd[2578]: Home page is http://smartmontools.sourceforge.net/#012
Aug  9 19:42:46 linux smartd[2578]: Opened configuration file /etc/smartd.conf
Aug  9 19:42:46 linux pulseaudio[2562]: alsa-sink.c: Increasing wakeup watermark to 30.00 ms
Aug  9 19:42:46 linux smartd[2578]: Drive: DEVICESCAN, implied '-a' Directive on line 28 of file /etc/smartd.conf
Aug  9 19:42:46 linux smartd[2578]: Configuration file /etc/smartd.conf was parsed, found DEVICESCAN, scanning devices
Aug  9 19:42:46 linux smartd[2578]: Device: /dev/hdc, opened
Aug  9 19:42:46 linux smartd[2578]: Device: /dev/hdc, packet devices [this device CD/DVD] not SMART capable
Aug  9 19:42:46 linux smartd[2578]: Device: /dev/sda, opened
Aug  9 19:42:46 linux smartd[2578]: Device /dev/sda: using '-d sat' for ATA disk behind SAT layer.
Aug  9 19:42:46 linux smartd[2578]: Device: /dev/sda, opened
Aug  9 19:42:46 linux smartd[2578]: Device: /dev/sda, found in smartd database.
Aug  9 19:42:46 linux smartd[2578]: Device: /dev/sda, is SMART capable. Adding to "monitor" list.
Aug  9 19:42:46 linux smartd[2578]: Device: /dev/sdb, opened
Aug  9 19:42:47 linux smartd[2578]: Device /dev/sdb: using '-d sat' for ATA disk behind SAT layer.
Aug  9 19:42:47 linux smartd[2578]: Device: /dev/sdb, opened
Aug  9 19:42:47 linux smartd[2578]: Device: /dev/sdb, found in smartd database.
Aug  9 19:42:47 linux smartd[2578]: Device: /dev/sdb, is SMART capable. Adding to "monitor" list.
Aug  9 19:42:47 linux smartd[2578]: Device: /dev/sdc, opened
Aug  9 19:42:47 linux smartd[2578]: Device /dev/sdc: using '-d sat' for ATA disk behind SAT layer.
Aug  9 19:42:47 linux smartd[2578]: Device: /dev/sdc, opened
Aug  9 19:42:47 linux smartd[2578]: Device: /dev/sdc, found in smartd database.
Aug  9 19:42:47 linux smartd[2578]: Device: /dev/sdc, is SMART capable. Adding to "monitor" list.
Aug  9 19:42:47 linux smartd[2578]: Monitoring 0 ATA and 3 SCSI devices
Aug  9 19:42:48 linux smartd[2580]: smartd has fork()ed into background mode. New PID=2580.
Aug  9 19:42:49 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 30.00 ms
Aug  9 19:42:49 linux pulseaudio[2562]: alsa-sink.c: Increasing wakeup watermark to 40.00 ms
Aug  9 19:42:49 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 40.00 ms
Aug  9 19:42:51 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 50.00 ms
Aug  9 19:42:51 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 60.00 ms
Aug  9 19:42:53 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 70.00 ms
Aug  9 19:42:54 linux pulseaudio[2562]: alsa-sink.c: Increasing wakeup watermark to 50.00 ms
Aug  9 19:42:54 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 80.00 ms
Aug  9 19:42:56 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 90.00 ms
Aug  9 19:42:56 linux kernel: bttv0: PLL can sleep, using XTAL (28636363).
Aug  9 19:42:57 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 100.00 ms
Aug  9 19:42:59 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 110.00 ms
Aug  9 19:43:00 linux acpid: client connected from 2767[0:0]
Aug  9 19:43:01 linux kernel: [drm] Initialized drm 1.1.0 20060810
Aug  9 19:43:01 linux kernel: pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Aug  9 19:43:01 linux kernel: [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
Aug  9 19:43:01 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 30.00 ms
Aug  9 19:43:02 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 120.00 ms
Aug  9 19:43:04 linux xinetd[1884]: START: telnet pid=2846 from=::ffff:192.168.1.10
Aug  9 19:43:05 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 130.00 ms
Aug  9 19:43:05 linux pulseaudio[2562]: alsa-sink.c: Increasing wakeup watermark to 60.00 ms
Aug  9 19:43:09 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 140.00 ms
Aug  9 19:43:10 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 150.00 ms
Aug  9 19:43:12 linux gdm-simple-greeter[2980]: WARNING: Unable to query filesystem type for /home/icecast: Error getting filesystem info: No such file or directory
Aug  9 19:43:13 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 160.00 ms
Aug  9 19:43:15 linux pulseaudio[2562]: alsa-sink.c: Increasing wakeup watermark to 70.00 ms
Aug  9 19:43:16 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 170.00 ms
Aug  9 19:43:19 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 180.00 ms
Aug  9 19:43:36 linux pulseaudio[2562]: alsa-source.c: Increasing wakeup watermark to 190.00 ms
Aug  9 19:44:19 linux kernel: ide-tape: hdd <-> ht0: Seagate STT20000A rev 8A51
Aug  9 19:44:19 linux kernel: ide-tape: hdd <-> ht0: 232KBps, 6*54kB buffer, 400ms tDSC
Aug  9 19:45:30 linux xinetd[1884]: START: tftp pid=4610 from=192.168.1.200
Aug  9 19:46:36 linux ntpd[1892]: synchronized to 4.79.132.217, stratum 2
Aug  9 19:46:36 linux ntpd[1892]: time reset +0.254707 s
Aug  9 19:46:36 linux ntpd[1892]: kernel time sync status change 0001
Aug  9 19:49:47 linux xinetd[1884]: START: telnet pid=8275 from=::ffff:192.168.1.10
Aug  9 19:50:41 linux kernel: Warning: /proc/ide/hd?/settings interface is obsolete, and will be removed soon!
Aug  9 19:51:02 linux ntpd[1892]: synchronized to 72.52.190.26, stratum 2
Aug  9 19:56:54 linux kernel: hello
Aug  9 19:56:54 linux kernel: hello jim2
Aug  9 19:56:54 linux kernel: ide-tape: hdd <-> ht0: Seagate STT20000A rev 8A51
Aug  9 19:56:54 linux kernel: ide-tape: hdd <-> ht0: 232KBps, 6*54kB buffer, 400ms tDSC
Aug  9 19:58:19 linux sm-notify[1719]: Unable to notify sharon, giving up
Aug  9 19:58:19 linux Backgrounding to notify hosts...
Aug  9 20:00:04 linux pulseaudio[2562]: alsa-sink.c: Increasing wakeup watermark to 30.00 ms
Aug  9 20:00:30 linux xinetd[1884]: EXIT: tftp status=0 pid=4610 duration=900(sec)
Aug  9 20:06:11 linux dhcpd: DHCPDISCOVER from 00:30:1b:2b:4e:8c via eth1
Aug  9 20:06:11 linux dhcpd: DHCPOFFER on 192.168.1.14 to 00:30:1b:2b:4e:8c via eth1
Aug  9 20:06:13 linux dhcpd: DHCPREQUEST for 192.168.1.14 (192.168.1.254) from 00:30:1b:2b:4e:8c via eth1
Aug  9 20:06:13 linux dhcpd: DHCPACK on 192.168.1.14 to 00:30:1b:2b:4e:8c via eth1
Aug  9 20:06:13 linux xinetd[1884]: START: tftp pid=26744 from=192.168.1.14
Aug  9 20:06:13 linux in.tftpd[26745]: tftp: client does not accept options
Aug  9 20:06:15 linux dhcpd: DHCPDISCOVER from 00:30:1b:2b:4e:8c via eth1
Aug  9 20:06:15 linux dhcpd: DHCPOFFER on 192.168.1.14 to 00:30:1b:2b:4e:8c via eth1
Aug  9 20:06:15 linux dhcpd: DHCPREQUEST for 192.168.1.14 (192.168.1.254) from 00:30:1b:2b:4e:8c via eth1
Aug  9 20:06:15 linux dhcpd: DHCPACK on 192.168.1.14 to 00:30:1b:2b:4e:8c via eth1
Aug  9 20:06:15 linux mountd[1933]: authenticated mount request from 192.168.1.14:952 for /tftpboot/muekow/i386 (/tftpboot/muekow)
Aug  9 20:06:23 linux mountd[1933]: authenticated mount request from 192.168.1.14:915 for /home (/home)
Aug  9 20:06:23 linux mountd[1933]: authenticated mount request from 192.168.1.14:1010 for /media (/media)
Aug  9 20:08:17 linux kernel: hello
Aug  9 20:08:17 linux kernel: hello jim2
Aug  9 20:08:17 linux kernel: ide-tape: hdd <-> ht0: Seagate STT20000A rev 8A51
Aug  9 20:08:17 linux kernel: ide-tape: hdd <-> ht0: 232KBps, 6*54kB buffer, 400ms tDSC
Aug  9 20:12:49 linux smartd[2580]: Device: /dev/sda, SMART Prefailure Attribute: 8 Seek_Time_Performance changed from 248 to 249
Aug  9 20:14:14 linux dhcpd: DHCPDISCOVER from 00:1b:24:b8:68:e2 via eth1
Aug  9 20:14:15 linux dhcpd: DHCPOFFER on 192.168.1.177 to 00:1b:24:b8:68:e2 via eth1
Aug  9 20:14:15 linux dhcpd: DHCPREQUEST for 192.168.1.177 (192.168.1.254) from 00:1b:24:b8:68:e2 via eth1
Aug  9 20:14:15 linux dhcpd: DHCPACK on 192.168.1.177 to 00:1b:24:b8:68:e2 via eth1
Aug  9 20:14:30 linux xinetd[1884]: START: telnet pid=29379 from=::ffff:192.168.1.177
Aug  9 20:17:37 linux xinetd[1884]: START: telnet pid=30948 from=::ffff:192.168.1.177
Aug  9 20:17:57 linux pulseaudio[2562]: alsa-sink.c: Increasing wakeup watermark to 80.00 ms
Aug  9 20:24:02 linux mountd[1933]: authenticated mount request from 192.168.1.177:666 for /media (/media)
Aug  9 20:24:30 linux xinetd[1884]: EXIT: tftp status=0 pid=26744 duration=1097(sec)
Aug  9 20:28:18 linux pulseaudio[2562]: alsa-sink.c: Increasing wakeup watermark to 90.00 ms
Aug  9 20:30:05 linux mountd[1933]: authenticated unmount request from 192.168.1.177:890 for /media (/media)
Aug  9 20:33:30 linux xinetd[1884]: START: tftp pid=9193 from=192.168.1.200
Aug  9 20:38:40 linux kernel: hello
Aug  9 20:38:40 linux kernel: ide-tape: hello jim
Aug  9 20:38:40 linux kernel: hello jim2
Aug  9 20:38:40 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:38:40 linux kernel: ide-tape: Retry #0, cmd = 12
Aug  9 20:38:40 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:38:40 linux kernel: ide-tape: hdd <-> ht0: Seagate STT20000A rev 8A51
Aug  9 20:38:40 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:38:40 linux kernel: ide-tape: Retry #0, cmd = 1A
Aug  9 20:38:40 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:38:40 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:38:40 linux kernel: ide-tape: Retry #0, cmd = 1A
Aug  9 20:38:40 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:38:40 linux kernel: ide-tape: hdd <-> ht0: 232KBps, 6*54kB buffer, 400ms tDSC
Aug  9 20:39:25 linux kernel: ide-tape: Enter idetape_chrdev_open
Aug  9 20:39:25 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:39:25 linux kernel: ide-tape: Retry #0, cmd = 00
Aug  9 20:39:25 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:39:25 linux kernel: ide-tape: Enter ide_tape_read_position
Aug  9 20:39:25 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:39:25 linux kernel: ide-tape: Retry #0, cmd = 34
Aug  9 20:39:25 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:39:25 linux kernel: ide-tape: BOP - Yes
Aug  9 20:39:25 linux kernel: ide-tape: EOP - No
Aug  9 20:39:25 linux kernel: ide-tape: Block Location - 0
Aug  9 20:39:25 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:39:25 linux kernel: ide-tape: Retry #0, cmd = 1A
Aug  9 20:39:25 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:39:25 linux kernel: ide-tape: Enter idetape_chrdev_ioctl, cmd=2149346562
Aug  9 20:39:25 linux kernel: ide-tape: Enter ide_tape_read_position
Aug  9 20:39:25 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:39:25 linux kernel: ide-tape: Retry #0, cmd = 34
Aug  9 20:39:25 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:39:25 linux kernel: ide-tape: BOP - Yes
Aug  9 20:39:25 linux kernel: ide-tape: EOP - No
Aug  9 20:39:25 linux kernel: ide-tape: Block Location - 0
Aug  9 20:39:25 linux kernel: ide-tape: Enter idetape_chrdev_release
Aug  9 20:39:25 linux kernel: ide-tape: Enter idetape_rewind_tape
Aug  9 20:39:25 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:39:25 linux kernel: ide-tape: Retry #0, cmd = 01
Aug  9 20:39:25 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:39:25 linux kernel: ide-tape: Enter idetape_postpone_request
Aug  9 20:39:25 linux kernel: ide-tape: Enter ide_tape_read_position
Aug  9 20:39:27 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:39:27 linux kernel: ide-tape: Retry #0, cmd = 34
Aug  9 20:39:27 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:39:27 linux kernel: ide-tape: BOP - Yes
Aug  9 20:39:27 linux kernel: ide-tape: EOP - No
Aug  9 20:39:27 linux kernel: ide-tape: Block Location - 0
Aug  9 20:40:16 linux kernel: hello
Aug  9 20:40:16 linux kernel: ide-tape: hello jim
Aug  9 20:40:16 linux kernel: hello jim2
Aug  9 20:40:16 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:40:16 linux kernel: ide-tape: Retry #0, cmd = 12
Aug  9 20:40:16 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:40:16 linux kernel: ide-tape: hdd <-> ht0: Seagate STT20000A rev 8A51
Aug  9 20:40:16 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:40:16 linux kernel: ide-tape: Retry #0, cmd = 1A
Aug  9 20:40:16 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:40:16 linux kernel: ide-tape: sector: 18446744073709551615, nr_sectors: 0
Aug  9 20:40:16 linux kernel: ide-tape: Retry #0, cmd = 1A
Aug  9 20:40:16 linux kernel: ide-tape: Enter ide_tape_callback
Aug  9 20:40:16 linux kernel: ide-tape: hdd <-> ht0: 232KBps, 6*54kB buffer, 400ms tDSC



