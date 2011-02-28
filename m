From: Philippe De Muyter <phdm@macqel.be>
Subject: Re: Intel ICH9M bug : sata unusable with usbserial
Date: Mon, 28 Feb 2011 18:05:56 +0100
Message-ID: <20110228170556.GA29545@frolo.macqel>
References: <20110228140149.GA18189@frolo.macqel> <20110228150553.66d02bc7@lxorguk.ukuu.org.uk> <20110228151618.GA16322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:48903 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690Ab1B1RGR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2011 12:06:17 -0500
Content-Disposition: inline
In-Reply-To: <20110228151618.GA16322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello Tejun and Alan,

Thanks for the quick answer.

On Mon, Feb 28, 2011 at 04:16:18PM +0100, Tejun Heo wrote:
> On Mon, Feb 28, 2011 at 03:05:53PM +0000, Alan Cox wrote:
> > > The running running processes keep running, and the GPS listening process
> > > continues to get messages from the USB GPS receiver each second.
> > > 
> > > Is that a known (an fixed) problem ?
> > 
> > No and I doubt it is a general problem or it would have been reported
> > long ago. Looks like your hard drive just dropped offline - power
> > problems perhaps ?
> 
> Looks more like a irq problem to me.  Maybe the USB device causes
> screaming IRQ and SATA controller is sharing IRQ with the USB host?
> Phillippe, can you please post the output 'cat /proc/interrupts' and
> full output of dmesg after the failure?

Here you are.  (I had called `cat' and `dmesg' each once before starting to
listen to /dev/ttyUSB0, otherwise I would have got
 -bash: /bin/cat: Input/output error
and
 -bash: /bin/dmesg: Input/output error
as only answers :))

tmp199:~ # cat /proc/interrupts
           CPU0
  0:        118    XT-PIC-XT-PIC    timer
  1:          8    XT-PIC-XT-PIC    i8042
  2:          0    XT-PIC-XT-PIC    cascade
  5:      17183    XT-PIC-XT-PIC    ata_piix, ata_piix, ehci_hcd:usb1, ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb5, uhci_hcd:usb6, uhci_hcd:usb7, uhci_hcd:usb8
  6:        146    XT-PIC-XT-PIC    uhci_hcd:usb4, firewire_ohci
  7:          0    XT-PIC-XT-PIC    parport0
  8:         65    XT-PIC-XT-PIC    rtc0
  9:          0    XT-PIC-XT-PIC    acpi
 12:        132    XT-PIC-XT-PIC    i8042
 16:        825   PCI-MSI-edge      i915
 17:       9710   PCI-MSI-edge      eth0
 21:        309   PCI-MSI-edge      hda_intel
NMI:         10   Non-maskable interrupts
LOC:      37238   Local timer interrupts
SPU:          0   Spurious interrupts
PMI:         10   Performance monitoring interrupts
IWI:          0   IRQ work interrupts
RES:          0   Rescheduling interrupts
CAL:          0   Function call interrupts
TLB:          0   TLB shootdowns
TRM:          0   Thermal event interrupts
THR:          0   Threshold APIC interrupts
MCE:          0   Machine check exceptions
MCP:          1   Machine check polls
ERR:          0
MIS:          0
tmp199:~ # dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.37-20-desktop (geeko@buildhost) (gcc version 4.5.1 20101208 [gcc-4_5-branch revision 167585] (SUSE Linux) ) #1 SMP PREEMPT 2011-01-22 00:41:44 +0100
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
[    0.000000]  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007bb90000 (usable)
[    0.000000]  BIOS-e820: 000000007bb90000 - 000000007bbe3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007bbe3000 - 000000007bbf0000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007bbf0000 - 000000007bd00000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.5 present.
[    0.000000] DMI: Cantiga/OEM, BIOS 6.00 PG 05/05/2010
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] last_pfn = 0x7bb90 max_arch_pfn = 0x1000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CEFFF write-protect
[    0.000000]   CF000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 base 040000000 mask FE0000000 write-back
[    0.000000]   2 base 060000000 mask FF0000000 write-back
[    0.000000]   3 base 070000000 mask FF8000000 write-back
[    0.000000]   4 base 078000000 mask FFC000000 write-back
[    0.000000]   5 base 07BE00000 mask FFFE00000 uncachable
[    0.000000]   6 base 07C000000 mask FFC000000 uncachable
[    0.000000]   7 base 07BD00000 mask FFFF00000 uncachable
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] initial memory mapped : 0 - 01000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000371fe000
[    0.000000]  0000000000 - 0000200000 page 4k
[    0.000000]  0000200000 - 0037000000 page 2M
[    0.000000]  0037000000 - 00371fe000 page 4k
[    0.000000] kernel direct mapping tables up to 371fe000 @ ff6000-1000000
[    0.000000] RAMDISK: 37769000 - 37ff0000
[    0.000000] Allocated new RAMDISK: 36977000 - 371fd822
[    0.000000] Move RAMDISK from 0000000037769000 - 0000000037fef821 to 36977000 - 371fd821
[    0.000000] ACPI: RSDP 000f82a0 00024 (v02 IntelR)
[    0.000000] ACPI: XSDT 7bbe3080 00044 (v01 IntelR AWRDACPI 42302E31 AWRD 00000000)
[    0.000000] ACPI: FACP 7bbe94c0 000F4 (v03 IntelR AWRDACPI 42302E31 AWRD 00000000)
[    0.000000] ACPI: DSDT 7bbe3200 062AC (v01 INTELR AWRDACPI 00001000 MSFT 03000000)
[    0.000000] ACPI: FACS 7bb90000 00040
[    0.000000] ACPI: HPET 7bbe96c0 00038 (v01 IntelR AWRDACPI 42302E31 AWRD 00000098)
[    0.000000] ACPI: MCFG 7bbe9700 0003C (v01 IntelR AWRDACPI 42302E31 AWRD 00000000)
[    0.000000] ACPI: SSDT 7bbe9e60 00A23 (v01  PmRef    CpuPm 00003000 INTL 20040311)
[    0.000000] could not find any ACPI SRAT memory areas.
[    0.000000] failed to get NUMA memory information from SRAT table
[    0.000000] NUMA - single node, flat memory mode
[    0.000000] Node: 0, start_pfn: 0, end_pfn: 7bb90
[    0.000000]   Setting physnode_map array to node 0 for pfns:
[    0.000000]   0 4000 8000 c000 10000 14000 18000 1c000 20000 24000 28000 2c000 30000 34000 38000 3c000 40000 44000 48000 4c000 50000 54000 58000 5c000 60000 64000 68000 6c000 70000 74000 78000
[    0.000000] node 0 pfn: [0 - 7bb90]
[    0.000000] Reserving 4096 pages of KVA for lmem_map of node 0 at 7aa00
[    0.000000] Reserving total of 1000 pages for numa KVA remap
[    0.000000] kva_start_pfn ~ 35800 max_low_pfn ~ 371fe
[    0.000000] max_pfn = 7bb90
[    0.000000] 1097MB HIGHMEM available.
[    0.000000] 881MB LOWMEM available.
[    0.000000] max_low_pfn = 371fe, highstart_pfn = 371fe
[    0.000000] Low memory ends at vaddr f71fe000
[    0.000000] node 0 will remap to vaddr f5800000 - f6800000
[    0.000000] allocate_pgdat: node 0 NODE_DATA f5800000
[    0.000000] remap_numa_kva: node 0
[    0.000000] remap_numa_kva: f5800000 to pfn 0007aa00
[    0.000000] remap_numa_kva: f5a00000 to pfn 0007ac00
[    0.000000] remap_numa_kva: f5c00000 to pfn 0007ae00
[    0.000000] remap_numa_kva: f5e00000 to pfn 0007b000
[    0.000000] remap_numa_kva: f6000000 to pfn 0007b200
[    0.000000] remap_numa_kva: f6200000 to pfn 0007b400
[    0.000000] remap_numa_kva: f6400000 to pfn 0007b600
[    0.000000] remap_numa_kva: f6600000 to pfn 0007b800
[    0.000000] High memory starts at vaddr f71fe000
[    0.000000]   mapped low ram: 0 - 371fe000
[    0.000000]   low ram: 0 - 371fe000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000371fe
[    0.000000]   HighMem  0x000371fe -> 0x0007bb90
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0007bb90
[    0.000000] On node 0 totalpages: 506655
[    0.000000] free_area_init_node: node 0, pgdat f5800000, node_mem_map f5802200
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3951 pages, LIFO batch:0
[    0.000000]   Normal zone: 1732 pages used for memmap
[    0.000000]   Normal zone: 219962 pages, LIFO batch:31
[    0.000000]   HighMem zone: 2196 pages used for memmap
[    0.000000]   HighMem zone: 278782 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] Found and enabled local APIC!
[    0.000000] nr_irqs_gsi: 16
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 7bd00000 (gap: 7bd00000:64300000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:1 nr_node_ids:8
[    0.000000] PERCPU: Embedded 12 pages/cpu @f5600000 s28160 r0 d20992 u2097152
[    0.000000] pcpu-alloc: s28160 r0 d20992 u2097152 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 502695
[    0.000000] Policy zone: HighMem
[    0.000000] Kernel command line: root=/dev/disk/by-id/ata-WDC_WD2500BEKT-00PVMT0_WD-WXK1AB098585-part2 resume=/dev/disk/by-id/ata-WDC_WD2500BEKT-00PVMT0_WD-WXK1AB098585-part1 splash=silent quiet vga=0x317 ignore_loglevel
[    0.000000] bootsplash: silent mode.
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
[    0.000000] allocated 10135040 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Initializing HighMem for node 0 (000371fe:0007bb90)
[    0.000000] Memory: 1964580k/2027072k available (4695k kernel code, 45656k reserved, 3509k data, 452k init, 1107528k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xff5b4000 - 0xfffff000   (10540 kB)
[    0.000000]     pkmap   : 0xff200000 - 0xff400000   (2048 kB)
[    0.000000]     vmalloc : 0xf79fe000 - 0xff1fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf71fe000   ( 881 MB)
[    0.000000]       .init : 0xc0a04000 - 0xc0a75000   ( 452 kB)
[    0.000000]       .data : 0xc0695d6d - 0xc0a03408   (3509 kB)
[    0.000000]       .text : 0xc0200000 - 0xc0695d6d   (4695 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] Preemptable hierarchical RCU implementation.
[    0.000000]  RCU-based detection of stalled CPUs is disabled.
[    0.000000]  Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:8448 nr_irqs:256 16
[    0.000000] CPU 0 irqstacks, hard=f480c000 soft=f480e000
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2527.029 MHz processor.
[    0.001003] Calibrating delay loop (skipped), value calculated using timer frequency.. 5054.05 BogoMIPS (lpj=2527029)
[    0.001011] pid_max: default: 32768 minimum: 301
[    0.001051] Security Framework initialized
[    0.001065] AppArmor: AppArmor initialized
[    0.001117] Mount-cache hash table entries: 512
[    0.001224] Initializing cgroup subsys ns
[    0.001229] ns_cgroup deprecated: consider using the 'clone_children' flag without the ns_cgroup.
[    0.001236] Initializing cgroup subsys cpuacct
[    0.001241] Initializing cgroup subsys memory
[    0.001254] Initializing cgroup subsys devices
[    0.001258] Initializing cgroup subsys freezer
[    0.001261] Initializing cgroup subsys net_cls
[    0.001265] Initializing cgroup subsys blkio
[    0.001298] CPU: Unsupported number of siblings 2
[    0.001302] mce: CPU supports 6 MCE banks
[    0.001311] CPU0: Thermal monitoring enabled (TM2)
[    0.001316] using mwait in idle threads.
[    0.001324] Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.
[    0.001332] ... version:                2
[    0.001335] ... bit width:              40
[    0.001338] ... generic registers:      2
[    0.001341] ... value mask:             000000ffffffffff
[    0.001345] ... max period:             000000007fffffff
[    0.001349] ... fixed-purpose events:   3
[    0.001351] ... event mask:             0000000700000003
[    0.002350] SMP alternatives: switching to UP code
[    0.006582] Freeing SMP alternatives: 20k freed
[    0.006589] ACPI: Core revision 20101013
[    0.014040] ACPI: setting ELCR to 0200 (from 0000)
[    0.015045] weird, boot CPU (#0) not listed by the BIOS.
[    0.015049] SMP motherboard not detected.
[    0.015053] Mapping cpu 0 to node 0
[    0.015061] Enabling APIC mode:  Flat.  Using 0 I/O APICs
[    0.015999] SMP disabled
[    0.015999] Mapping cpu 0 to node 0
[    0.019046] NMI watchdog enabled, takes one hw-pmu counter.
[    0.020064] Brought up 1 CPUs
[    0.020070] Total of 1 processors activated (5054.05 BogoMIPS).
[    0.021118] devtmpfs: initialized
[    0.022101] regulator: core version 0.5
[    0.022143] regulator: dummy:
[    0.022164] Time: 16:53:17  Date: 02/28/11
[    0.022203] NET: Registered protocol family 16
[    0.022368] ACPI: bus type pci registered
[    0.022436] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.022443] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.022447] PCI: Using MMCONFIG for extended config space
[    0.022451] PCI: Using configuration type 1 for base access
[    0.023232] bio: create slab <bio-0> at 0
[    0.024346] ACPI: EC: Look up EC in DSDT
[    0.030620] ACPI: Interpreter enabled
[    0.030625] ACPI: (supports S0 S3 S4 S5)
[    0.030648] ACPI: Using PIC for interrupt routing
[    0.033431] ACPI Exception: AE_NOT_FOUND, Evaluating _PRW (20101013/scan-743)
[    0.033623] ACPI Exception: AE_NOT_FOUND, Evaluating _PRW (20101013/scan-743)
[    0.036834] ACPI Exception: AE_NOT_FOUND, Evaluating _PRW (20101013/scan-743)
[    0.037345] ACPI: No dock devices found.
[    0.037350] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.037445] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.037641] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.037647] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.037651] pci_root PNP0A08:00: host bridge window [mem 0xfed40000-0xfed44fff]
[    0.037657] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.037662] pci_root PNP0A08:00: host bridge window [mem 0x000c0000-0x000dffff]
[    0.037667] pci_root PNP0A08:00: host bridge window [mem 0x7bc00000-0xfebfffff]
[    0.037683] pci 0000:00:00.0: [8086:2a40] type 0 class 0x000600
[    0.037704] DMAR: Forcing write-buffer flush capability
[    0.037707] DMAR: Disabling IOMMU for graphics on this chipset
[    0.037727] pci 0000:00:01.0: [8086:2a41] type 1 class 0x000604
[    0.037757] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.037762] pci 0000:00:01.0: PME# disabled
[    0.037776] pci 0000:00:02.0: [8086:2a42] type 0 class 0x000300
[    0.037789] pci 0000:00:02.0: reg 10: [mem 0xfcc00000-0xfcffffff 64bit]
[    0.037799] pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.037806] pci 0000:00:02.0: reg 20: [io  0xff00-0xff07]
[    0.037833] pci 0000:00:02.1: [8086:2a43] type 0 class 0x000380
[    0.037844] pci 0000:00:02.1: reg 10: [mem 0x00000000-0x000fffff 64bit]
[    0.037906] pci 0000:00:19.0: [8086:10f5] type 0 class 0x000200
[    0.037924] pci 0000:00:19.0: reg 10: [mem 0xfdfc0000-0xfdfdffff]
[    0.037935] pci 0000:00:19.0: reg 14: [mem 0xfdfff000-0xfdffffff]
[    0.037945] pci 0000:00:19.0: reg 18: [io  0xfe00-0xfe1f]
[    0.037991] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.037997] pci 0000:00:19.0: PME# disabled
[    0.038017] pci 0000:00:1a.0: [8086:2937] type 0 class 0x000c03
[    0.038058] pci 0000:00:1a.0: reg 20: [io  0xfd00-0xfd1f]
[    0.038100] pci 0000:00:1a.1: [8086:2938] type 0 class 0x000c03
[    0.038142] pci 0000:00:1a.1: reg 20: [io  0xfc00-0xfc1f]
[    0.038183] pci 0000:00:1a.2: [8086:2939] type 0 class 0x000c03
[    0.038224] pci 0000:00:1a.2: reg 20: [io  0xfb00-0xfb1f]
[    0.038274] pci 0000:00:1a.7: [8086:293c] type 0 class 0x000c03
[    0.038295] pci 0000:00:1a.7: reg 10: [mem 0xfdffe000-0xfdffe3ff]
[    0.038365] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.038371] pci 0000:00:1a.7: PME# disabled
[    0.038393] pci 0000:00:1b.0: [8086:293e] type 0 class 0x000403
[    0.038409] pci 0000:00:1b.0: reg 10: [mem 0xfdff4000-0xfdff7fff 64bit]
[    0.038461] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.038466] pci 0000:00:1b.0: PME# disabled
[    0.038485] pci 0000:00:1c.0: [8086:2940] type 1 class 0x000604
[    0.038536] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.038542] pci 0000:00:1c.0: PME# disabled
[    0.038562] pci 0000:00:1c.1: [8086:2942] type 1 class 0x000604
[    0.038614] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.038619] pci 0000:00:1c.1: PME# disabled
[    0.038640] pci 0000:00:1c.2: [8086:2944] type 1 class 0x000604
[    0.038691] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.038697] pci 0000:00:1c.2: PME# disabled
[    0.038717] pci 0000:00:1c.3: [8086:2946] type 1 class 0x000604
[    0.038768] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.038774] pci 0000:00:1c.3: PME# disabled
[    0.038798] pci 0000:00:1d.0: [8086:2934] type 0 class 0x000c03
[    0.038839] pci 0000:00:1d.0: reg 20: [io  0xfa00-0xfa1f]
[    0.038881] pci 0000:00:1d.1: [8086:2935] type 0 class 0x000c03
[    0.038922] pci 0000:00:1d.1: reg 20: [io  0xf900-0xf91f]
[    0.038964] pci 0000:00:1d.2: [8086:2936] type 0 class 0x000c03
[    0.039011] pci 0000:00:1d.2: reg 20: [io  0xf800-0xf81f]
[    0.039061] pci 0000:00:1d.7: [8086:293a] type 0 class 0x000c03
[    0.039082] pci 0000:00:1d.7: reg 10: [mem 0xfdffd000-0xfdffd3ff]
[    0.039151] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.039158] pci 0000:00:1d.7: PME# disabled
[    0.039177] pci 0000:00:1e.0: [8086:2448] type 1 class 0x000604
[    0.039230] pci 0000:00:1f.0: [8086:2919] type 0 class 0x000601
[    0.039331] pci 0000:00:1f.2: [8086:2928] type 0 class 0x000101
[    0.039347] pci 0000:00:1f.2: reg 10: [io  0xf700-0xf707]
[    0.039356] pci 0000:00:1f.2: reg 14: [io  0xf600-0xf603]
[    0.039366] pci 0000:00:1f.2: reg 18: [io  0xf500-0xf507]
[    0.039375] pci 0000:00:1f.2: reg 1c: [io  0xf400-0xf403]
[    0.039384] pci 0000:00:1f.2: reg 20: [io  0xf300-0xf30f]
[    0.039394] pci 0000:00:1f.2: reg 24: [io  0xf200-0xf20f]
[    0.039429] pci 0000:00:1f.3: [8086:2930] type 0 class 0x000c05
[    0.039445] pci 0000:00:1f.3: reg 10: [mem 0xfdffc000-0xfdffc0ff 64bit]
[    0.039466] pci 0000:00:1f.3: reg 20: [io  0x0500-0x051f]
[    0.039498] pci 0000:00:1f.5: [8086:292d] type 0 class 0x000101
[    0.039514] pci 0000:00:1f.5: reg 10: [io  0xf000-0xf007]
[    0.039523] pci 0000:00:1f.5: reg 14: [io  0xef00-0xef03]
[    0.039532] pci 0000:00:1f.5: reg 18: [io  0xee00-0xee07]
[    0.039542] pci 0000:00:1f.5: reg 1c: [io  0xed00-0xed03]
[    0.039551] pci 0000:00:1f.5: reg 20: [io  0xec00-0xec0f]
[    0.039560] pci 0000:00:1f.5: reg 24: [io  0xeb00-0xeb0f]
[    0.039614] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.039619] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
[    0.039624] pci 0000:00:01.0:   bridge window [mem 0xfd300000-0xfd3fffff]
[    0.039630] pci 0000:00:01.0:   bridge window [mem 0xfd600000-0xfd6fffff 64bit pref]
[    0.039693] pci 0000:02:00.0: [8086:10d3] type 0 class 0x000200
[    0.039719] pci 0000:02:00.0: reg 10: [mem 0xfdec0000-0xfdedffff]
[    0.039752] pci 0000:02:00.0: reg 18: [io  0xbf00-0xbf1f]
[    0.039771] pci 0000:02:00.0: reg 1c: [mem 0xfdefc000-0xfdefffff]
[    0.039869] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.039877] pci 0000:02:00.0: PME# disabled
[    0.041018] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.041027] pci 0000:00:1c.0:   bridge window [io  0xb000-0xbfff]
[    0.041036] pci 0000:00:1c.0:   bridge window [mem 0xfde00000-0xfdefffff]
[    0.041047] pci 0000:00:1c.0:   bridge window [mem 0xfdd00000-0xfddfffff 64bit pref]
[    0.041098] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.041106] pci 0000:00:1c.1:   bridge window [io  0xa000-0xafff]
[    0.041115] pci 0000:00:1c.1:   bridge window [mem 0xfdc00000-0xfdcfffff]
[    0.041125] pci 0000:00:1c.1:   bridge window [mem 0xfdb00000-0xfdbfffff 64bit pref]
[    0.041177] pci 0000:00:1c.2: PCI bridge to [bus 04-04]
[    0.041182] pci 0000:00:1c.2:   bridge window [io  0x8000-0x8fff]
[    0.041188] pci 0000:00:1c.2:   bridge window [mem 0xfda00000-0xfdafffff]
[    0.041196] pci 0000:00:1c.2:   bridge window [mem 0xfd900000-0xfd9fffff 64bit pref]
[    0.041235] pci 0000:00:1c.3: PCI bridge to [bus 05-05]
[    0.041240] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.041246] pci 0000:00:1c.3:   bridge window [mem 0xfd800000-0xfd8fffff]
[    0.041254] pci 0000:00:1c.3:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
[    0.041296] pci 0000:06:09.0: [1106:3044] type 0 class 0x000c00
[    0.041315] pci 0000:06:09.0: reg 10: [mem 0xfd5ff000-0xfd5ff7ff]
[    0.041327] pci 0000:06:09.0: reg 14: [io  0x9f00-0x9f7f]
[    0.041385] pci 0000:06:09.0: supports D2
[    0.041388] pci 0000:06:09.0: PME# supported from D2 D3hot D3cold
[    0.041395] pci 0000:06:09.0: PME# disabled
[    0.041427] pci 0000:00:1e.0: PCI bridge to [bus 06-06] (subtractive decode)
[    0.041434] pci 0000:00:1e.0:   bridge window [io  0x9000-0x9fff]
[    0.041440] pci 0000:00:1e.0:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.041447] pci 0000:00:1e.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
[    0.041453] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.041459] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.041464] pci 0000:00:1e.0:   bridge window [mem 0xfed40000-0xfed44fff] (subtractive decode)
[    0.041470] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.041476] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.041482] pci 0000:00:1e.0:   bridge window [mem 0x7bc00000-0xfebfffff] (subtractive decode)
[    0.041509] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.041698] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[    0.041749] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
[    0.041800] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
[    0.041850] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
[    0.041906] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[    0.059689] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.059761] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
[    0.059830] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.059900] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.059969] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
[    0.060045] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
[    0.060115] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
[    0.060184] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.060220] HEST: Table is not found!
[    0.060363] SCSI subsystem initialized
[    0.060396] libata version 3.00 loaded.
[    0.060445] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.060457] vgaarb: loaded
[    0.060483] usbcore: registered new interface driver usbfs
[    0.060497] usbcore: registered new interface driver hub
[    0.060521] usbcore: registered new device driver usb
[    0.060588] PCI: Using ACPI for IRQ routing
[    0.060592] PCI: pci_cache_line_size set to 64 bytes
[    0.060665] Expanded resource reserved due to conflict with PCI Bus 0000:00
[    0.060671] reserve RAM buffer: 000000000009f400 - 000000000009ffff
[    0.060675] reserve RAM buffer: 000000007bb90000 - 000000007bffffff
[    0.060759] NetLabel: Initializing
[    0.060764] NetLabel:  domain hash size = 128
[    0.060767] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.060777] NetLabel:  unlabeled traffic allowed by default
[    0.060784] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    0.060791] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.060797] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.064023] Switching to clocksource tsc
[    0.065008] AppArmor: AppArmor Filesystem Enabled
[    0.065017] pnp: PnP ACPI init
[    0.065033] ACPI: bus type pnp registered
[    0.065139] pnp 00:00: [bus 00-ff]
[    0.065144] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.065147] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.065151] pnp 00:00: [io  0x0d00-0xffff window]
[    0.065155] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    0.065160] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.065164] pnp 00:00: [mem 0x000c0000-0x000dffff window]
[    0.065169] pnp 00:00: [mem 0x7bc00000-0xfebfffff window]
[    0.065211] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.065292] pnp 00:01: [io  0x0010-0x001f]
[    0.065296] pnp 00:01: [io  0x0022-0x003f]
[    0.065299] pnp 00:01: [io  0x0044-0x004d]
[    0.065302] pnp 00:01: [io  0x0050-0x005e]
[    0.065306] pnp 00:01: [io  0x0062-0x0063]
[    0.065309] pnp 00:01: [io  0x0065-0x006f]
[    0.065313] pnp 00:01: [io  0x0074-0x007f]
[    0.065316] pnp 00:01: [io  0x0091-0x0093]
[    0.065320] pnp 00:01: [io  0x00a2-0x00bf]
[    0.065323] pnp 00:01: [io  0x00e0-0x00ef]
[    0.065327] pnp 00:01: [io  0x04d0-0x04d1]
[    0.065330] pnp 00:01: [io  0x0290-0x029f]
[    0.065333] pnp 00:01: [io  0x0880-0x088f]
[    0.065385] pnp 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.065401] pnp 00:02: [dma 4]
[    0.065404] pnp 00:02: [io  0x0000-0x000f]
[    0.065407] pnp 00:02: [io  0x0080-0x0090]
[    0.065411] pnp 00:02: [io  0x0094-0x009f]
[    0.065414] pnp 00:02: [io  0x00c0-0x00df]
[    0.065443] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.065511] pnp 00:03: [irq 0 disabled]
[    0.065516] ERROR: Unable to locate IOAPIC for GSI 8
[    0.065520] pnp 00:03: [irq 8]
[    0.065523] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    0.065552] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.065592] pnp 00:04: [io  0x0070-0x0073]
[    0.065622] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.065634] pnp 00:05: [io  0x0061]
[    0.065664] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.065677] pnp 00:06: [io  0x00f0-0x00ff]
[    0.065680] ERROR: Unable to locate IOAPIC for GSI 13
[    0.065684] pnp 00:06: [irq 13]
[    0.065713] pnp 00:06: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.066015] pnp 00:07: [io  0x03f8-0x03ff]
[    0.066019] ERROR: Unable to locate IOAPIC for GSI 4
[    0.066023] pnp 00:07: [irq 4]
[    0.066075] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.066388] pnp 00:08: [io  0x02f8-0x02ff]
[    0.066392] ERROR: Unable to locate IOAPIC for GSI 3
[    0.066396] pnp 00:08: [irq 3]
[    0.066447] pnp 00:08: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.066776] pnp 00:09: [io  0x0378-0x037f]
[    0.066780] ERROR: Unable to locate IOAPIC for GSI 7
[    0.066784] pnp 00:09: [irq 7]
[    0.066830] pnp 00:09: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.066992] ERROR: Unable to locate IOAPIC for GSI 12
[    0.066998] pnp 00:0a: [irq 12]
[    0.067030] pnp 00:0a: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.067062] pnp 00:0b: [io  0x0060]
[    0.067065] pnp 00:0b: [io  0x0064]
[    0.067068] ERROR: Unable to locate IOAPIC for GSI 1
[    0.067073] pnp 00:0b: [irq 1]
[    0.067107] pnp 00:0b: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.067368] pnp 00:0c: [io  0x03e8-0x03ef]
[    0.067372] ERROR: Unable to locate IOAPIC for GSI 10
[    0.067376] pnp 00:0c: [irq 10]
[    0.067427] pnp 00:0c: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.067656] pnp 00:0d: [io  0x02e8-0x02ef]
[    0.067660] ERROR: Unable to locate IOAPIC for GSI 11
[    0.067664] pnp 00:0d: [irq 11]
[    0.067716] pnp 00:0d: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.067939] pnp 00:0e: [io  0x02e0-0x02e7]
[    0.067943] ERROR: Unable to locate IOAPIC for GSI 10
[    0.067947] pnp 00:0e: [irq 10]
[    0.067998] pnp 00:0e: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.068222] pnp 00:0f: [io  0x02f0-0x02f7]
[    0.068226] ERROR: Unable to locate IOAPIC for GSI 11
[    0.068230] pnp 00:0f: [irq 11]
[    0.068274] pnp 00:0f: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.068301] pnp 00:10: [io  0x0400-0x04bf]
[    0.068344] pnp 00:10: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.068372] pnp 00:11: [mem 0xffb80000-0xffbfffff]
[    0.068406] pnp 00:11: Plug and Play ACPI device, IDs INT0800 (active)
[    0.068676] pnp 00:12: [mem 0xe0000000-0xefffffff]
[    0.068728] pnp 00:12: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.068862] pnp 00:13: [mem 0x000f0000-0x000fffff]
[    0.068867] pnp 00:13: [mem 0x7bc00000-0x7bcfffff]
[    0.068871] pnp 00:13: [mem 0xfed00000-0xfed000ff]
[    0.068874] pnp 00:13: [mem 0x7bb90000-0x7bbfffff]
[    0.068878] pnp 00:13: [mem 0x00000000-0x0009ffff]
[    0.068882] pnp 00:13: [mem 0x00100000-0x7bb8ffff]
[    0.068885] pnp 00:13: [mem 0xfec00000-0xfec00fff]
[    0.068889] pnp 00:13: [mem 0xfed13000-0xfed1ffff]
[    0.068893] pnp 00:13: [mem 0xfed20000-0xfed3ffff]
[    0.068897] pnp 00:13: [mem 0xfed45000-0xfed9ffff]
[    0.068900] pnp 00:13: [mem 0xfee00000-0xfee00fff]
[    0.068904] pnp 00:13: [mem 0xffb00000-0xffb7ffff]
[    0.068908] pnp 00:13: [mem 0xfff00000-0xffffffff]
[    0.068911] pnp 00:13: [mem 0x000e0000-0x000effff]
[    0.068921] pnp 00:13: disabling [mem 0x000f0000-0x000fffff] because it overlaps 0000:00:02.1 BAR 0 [mem 0x00000000-0x000fffff 64bit]
[    0.068929] pnp 00:13: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:02.1 BAR 0 [mem 0x00000000-0x000fffff 64bit]
[    0.068937] pnp 00:13: disabling [mem 0x000e0000-0x000effff] because it overlaps 0000:00:02.1 BAR 0 [mem 0x00000000-0x000fffff 64bit]
[    0.069002] pnp 00:13: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.069014] pnp: PnP ACPI: found 20 devices
[    0.069018] ACPI: ACPI bus type pnp unregistered
[    0.069028] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.069033] system 00:01: [io  0x0290-0x029f] has been reserved
[    0.069037] system 00:01: [io  0x0880-0x088f] has been reserved
[    0.069047] system 00:10: [io  0x0400-0x04bf] has been reserved
[    0.069054] system 00:12: [mem 0xe0000000-0xefffffff] has been reserved
[    0.069061] system 00:13: [mem 0x7bc00000-0x7bcfffff] has been reserved
[    0.069066] system 00:13: [mem 0xfed00000-0xfed000ff] has been reserved
[    0.069071] system 00:13: [mem 0x7bb90000-0x7bbfffff] could not be reserved
[    0.069076] system 00:13: [mem 0x00100000-0x7bb8ffff] could not be reserved
[    0.069081] system 00:13: [mem 0xfec00000-0xfec00fff] has been reserved
[    0.069086] system 00:13: [mem 0xfed13000-0xfed1ffff] has been reserved
[    0.069092] system 00:13: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.069097] system 00:13: [mem 0xfed45000-0xfed9ffff] has been reserved
[    0.069102] system 00:13: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.069107] system 00:13: [mem 0xffb00000-0xffb7ffff] has been reserved
[    0.069111] system 00:13: [mem 0xfff00000-0xffffffff] has been reserved
[    0.105372] pci 0000:00:02.1: BAR 0: assigned [mem 0x7bd00000-0x7bdfffff 64bit]
[    0.105381] pci 0000:00:02.1: BAR 0: set to [mem 0x7bd00000-0x7bdfffff 64bit] (PCI address [0x7bd00000-0x7bdfffff])
[    0.105388] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.105393] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
[    0.105398] pci 0000:00:01.0:   bridge window [mem 0xfd300000-0xfd3fffff]
[    0.105404] pci 0000:00:01.0:   bridge window [mem 0xfd600000-0xfd6fffff 64bit pref]
[    0.105411] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.105416] pci 0000:00:1c.0:   bridge window [io  0xb000-0xbfff]
[    0.105422] pci 0000:00:1c.0:   bridge window [mem 0xfde00000-0xfdefffff]
[    0.105429] pci 0000:00:1c.0:   bridge window [mem 0xfdd00000-0xfddfffff 64bit pref]
[    0.105437] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.105442] pci 0000:00:1c.1:   bridge window [io  0xa000-0xafff]
[    0.105448] pci 0000:00:1c.1:   bridge window [mem 0xfdc00000-0xfdcfffff]
[    0.105454] pci 0000:00:1c.1:   bridge window [mem 0xfdb00000-0xfdbfffff 64bit pref]
[    0.105463] pci 0000:00:1c.2: PCI bridge to [bus 04-04]
[    0.105468] pci 0000:00:1c.2:   bridge window [io  0x8000-0x8fff]
[    0.105474] pci 0000:00:1c.2:   bridge window [mem 0xfda00000-0xfdafffff]
[    0.105480] pci 0000:00:1c.2:   bridge window [mem 0xfd900000-0xfd9fffff 64bit pref]
[    0.105489] pci 0000:00:1c.3: PCI bridge to [bus 05-05]
[    0.105493] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.105500] pci 0000:00:1c.3:   bridge window [mem 0xfd800000-0xfd8fffff]
[    0.105506] pci 0000:00:1c.3:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
[    0.105515] pci 0000:00:1e.0: PCI bridge to [bus 06-06]
[    0.105519] pci 0000:00:1e.0:   bridge window [io  0x9000-0x9fff]
[    0.105526] pci 0000:00:1e.0:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.105532] pci 0000:00:1e.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
[    0.105632] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
[    0.105637] PCI: setting IRQ 5 as level-triggered
[    0.105643] pci 0000:00:01.0: PCI INT A -> Link[LNKA] -> GSI 5 (level, low) -> IRQ 5
[    0.105650] pci 0000:00:01.0: setting latency timer to 64
[    0.105658] pci 0000:00:1c.0: PCI INT A -> Link[LNKA] -> GSI 5 (level, low) -> IRQ 5
[    0.105665] pci 0000:00:1c.0: setting latency timer to 64
[    0.105754] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 6
[    0.105758] PCI: setting IRQ 6 as level-triggered
[    0.105764] pci 0000:00:1c.1: PCI INT B -> Link[LNKB] -> GSI 6 (level, low) -> IRQ 6
[    0.105772] pci 0000:00:1c.1: setting latency timer to 64
[    0.105860] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
[    0.105866] pci 0000:00:1c.2: PCI INT C -> Link[LNKC] -> GSI 5 (level, low) -> IRQ 5
[    0.105873] pci 0000:00:1c.2: setting latency timer to 64
[    0.105966] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
[    0.105971] pci 0000:00:1c.3: PCI INT D -> Link[LNKD] -> GSI 5 (level, low) -> IRQ 5
[    0.105978] pci 0000:00:1c.3: setting latency timer to 64
[    0.105986] pci 0000:00:1e.0: setting latency timer to 64
[    0.105992] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.105996] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.106000] pci_bus 0000:00: resource 6 [mem 0xfed40000-0xfed44fff]
[    0.106005] pci_bus 0000:00: resource 7 [mem 0x000a0000-0x000bffff]
[    0.106009] pci_bus 0000:00: resource 8 [mem 0x000c0000-0x000dffff]
[    0.106014] pci_bus 0000:00: resource 9 [mem 0x7bc00000-0xfebfffff]
[    0.106018] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
[    0.106023] pci_bus 0000:01: resource 1 [mem 0xfd300000-0xfd3fffff]
[    0.106027] pci_bus 0000:01: resource 2 [mem 0xfd600000-0xfd6fffff 64bit pref]
[    0.106033] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
[    0.106037] pci_bus 0000:02: resource 1 [mem 0xfde00000-0xfdefffff]
[    0.106042] pci_bus 0000:02: resource 2 [mem 0xfdd00000-0xfddfffff 64bit pref]
[    0.106047] pci_bus 0000:03: resource 0 [io  0xa000-0xafff]
[    0.106051] pci_bus 0000:03: resource 1 [mem 0xfdc00000-0xfdcfffff]
[    0.106056] pci_bus 0000:03: resource 2 [mem 0xfdb00000-0xfdbfffff 64bit pref]
[    0.106061] pci_bus 0000:04: resource 0 [io  0x8000-0x8fff]
[    0.106066] pci_bus 0000:04: resource 1 [mem 0xfda00000-0xfdafffff]
[    0.106070] pci_bus 0000:04: resource 2 [mem 0xfd900000-0xfd9fffff 64bit pref]
[    0.106075] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
[    0.106080] pci_bus 0000:05: resource 1 [mem 0xfd800000-0xfd8fffff]
[    0.106084] pci_bus 0000:05: resource 2 [mem 0xfd700000-0xfd7fffff 64bit pref]
[    0.106090] pci_bus 0000:06: resource 0 [io  0x9000-0x9fff]
[    0.106094] pci_bus 0000:06: resource 1 [mem 0xfd500000-0xfd5fffff]
[    0.106099] pci_bus 0000:06: resource 2 [mem 0xfd400000-0xfd4fffff 64bit pref]
[    0.106104] pci_bus 0000:06: resource 4 [io  0x0000-0x0cf7]
[    0.106108] pci_bus 0000:06: resource 5 [io  0x0d00-0xffff]
[    0.106112] pci_bus 0000:06: resource 6 [mem 0xfed40000-0xfed44fff]
[    0.106117] pci_bus 0000:06: resource 7 [mem 0x000a0000-0x000bffff]
[    0.106121] pci_bus 0000:06: resource 8 [mem 0x000c0000-0x000dffff]
[    0.106126] pci_bus 0000:06: resource 9 [mem 0x7bc00000-0xfebfffff]
[    0.106160] NET: Registered protocol family 2
[    0.106205] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.106368] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.106656] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.106790] TCP: Hash tables configured (established 131072 bind 65536)
[    0.106794] TCP reno registered
[    0.106798] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.106806] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.106861] NET: Registered protocol family 1
[    0.106874] pci 0000:00:02.0: Boot video device
[    0.107005] PCI: CLS 64 bytes, default 64
[    0.107036] Unpacking initramfs...
[    0.265265] Freeing initrd memory: 8732k freed
[    0.268674] Scanning for low memory corruption every 60 seconds
[    0.268829] audit: initializing netlink socket (disabled)
[    0.268844] type=2000 audit(1298911997.266:1): initialized
[    0.278032] highmem bounce pool size: 64 pages
[    0.278039] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.278158] VFS: Disk quotas dquot_6.5.2
[    0.278183] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.278291] msgmni has been set to 422
[    0.278437] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.278445] io scheduler noop registered
[    0.278448] io scheduler deadline registered
[    0.278462] io scheduler cfq registered (default)
[    0.278630] pci-stub: invalid id string ""
[    0.278920] vesafb: framebuffer at 0xd0000000, mapped to 0xf7a80000, using 3072k, total 65472k
[    0.278927] vesafb: mode is 1024x768x16, linelength=2048, pages=41
[    0.278931] vesafb: scrolling: redraw
[    0.278934] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    0.279238] bootsplash 3.1.6-2004/03/31: looking for picture...
[    0.279240] bootsplash: silentjpeg size 133037 bytes
[    0.290549] bootsplash: ...found (1024x768, 90743 bytes, v3).
[    0.327367] Console: switching to colour frame buffer device 124x44
[    0.363847] fb0: VESA VGA frame buffer device
[    0.363881] intel_idle: MWAIT substates: 0x3122220
[    0.363884] intel_idle: does not run on family 6 model 23
[    0.363899] ERST: Table is not found!
[    0.364108] Non-volatile memory driver v1.3
[    0.364113] Linux agpgart interface v0.103
[    0.364191] agpgart-intel 0000:00:00.0: Intel GM45 Chipset
[    0.364246] agpgart-intel 0000:00:00.0: detected gtt size: 524288K total, 262144K mappable
[    0.365378] agpgart-intel 0000:00:00.0: detected 65536K stolen memory, trimming to 32768K
[    0.371224] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    0.371295] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    0.391798] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.414418] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.437407] serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[    0.460400] serial8250: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
[    0.499509] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.523340] 00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.547390] 00:0c: ttyS2 at I/O 0x3e8 (irq = 10) is a 16550A
[    0.571307] 00:0d: ttyS3 at I/O 0x2e8 (irq = 11) is a 16550A
[    0.595288] 00:0e: ttyS4 at I/O 0x2e0 (irq = 10) is a 16550A
[    0.619267] 00:0f: ttyS5 at I/O 0x2f0 (irq = 11) is a 16550A
[    0.622930] ata_piix 0000:00:1f.2: version 2.13
[    0.622989] ata_piix 0000:00:1f.2: PCI INT B -> Link[LNKD] -> GSI 5 (level, low) -> IRQ 5
[    0.623039] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
[    0.623116] ata_piix 0000:00:1f.2: setting latency timer to 64
[    0.623389] scsi0 : ata_piix
[    0.623509] scsi1 : ata_piix
[    0.624191] ata1: SATA max UDMA/133 cmd 0xf700 ctl 0xf600 bmdma 0xf300 irq 5
[    0.624241] ata2: SATA max UDMA/133 cmd 0xf500 ctl 0xf400 bmdma 0xf308 irq 5
[    0.624302] ata_piix 0000:00:1f.5: PCI INT B -> Link[LNKD] -> GSI 5 (level, low) -> IRQ 5
[    0.624352] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
[    0.624423] ata_piix 0000:00:1f.5: setting latency timer to 64
[    0.624722] scsi2 : ata_piix
[    0.624839] scsi3 : ata_piix
[    0.625425] ata3: SATA max UDMA/133 cmd 0xf000 ctl 0xef00 bmdma 0xec00 irq 5
[    0.625475] ata4: SATA max UDMA/133 cmd 0xee00 ctl 0xed00 bmdma 0xec08 irq 5
[    0.625570] Fixed MDIO Bus: probed
[    0.625621] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.625680] ehci_hcd 0000:00:1a.7: PCI INT C -> Link[LNKC] -> GSI 5 (level, low) -> IRQ 5
[    0.625746] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    0.625797] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    0.625861] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.626754] ehci_hcd 0000:00:1a.7: debug port 1
[    0.630713] ehci_hcd 0000:00:1a.7: cache line size of 64 is not supported
[    0.630766] ehci_hcd 0000:00:1a.7: irq 5, io mem 0xfdffe000
[    0.639702] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.639802] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.639877] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.639927] usb usb1: Product: EHCI Host Controller
[    0.639976] usb usb1: Manufacturer: Linux 2.6.37-20-desktop ehci_hcd
[    0.640025] usb usb1: SerialNumber: 0000:00:1a.7
[    0.640157] hub 1-0:1.0: USB hub found
[    0.640209] hub 1-0:1.0: 6 ports detected
[    0.640415] ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
[    0.640467] ehci_hcd 0000:00:1d.7: PCI INT A -> Link[LNK1] -> GSI 5 (level, low) -> IRQ 5
[    0.640525] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    0.640575] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    0.640631] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    0.641719] ehci_hcd 0000:00:1d.7: debug port 1
[    0.645697] ehci_hcd 0000:00:1d.7: cache line size of 64 is not supported
[    0.645751] ehci_hcd 0000:00:1d.7: irq 5, io mem 0xfdffd000
[    0.655680] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.655800] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    0.655869] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.655919] usb usb2: Product: EHCI Host Controller
[    0.655968] usb usb2: Manufacturer: Linux 2.6.37-20-desktop ehci_hcd
[    0.656017] usb usb2: SerialNumber: 0000:00:1d.7
[    0.656143] hub 2-0:1.0: USB hub found
[    0.656193] hub 2-0:1.0: 6 ports detected
[    0.656305] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.656362] uhci_hcd: USB Universal Host Controller Interface driver
[    0.656427] uhci_hcd 0000:00:1a.0: PCI INT A -> Link[LNKA] -> GSI 5 (level, low) -> IRQ 5
[    0.656479] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    0.656529] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.656581] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    0.657696] uhci_hcd 0000:00:1a.0: irq 5, io base 0x0000fd00
[    0.657806] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    0.657869] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.657917] usb usb3: Product: UHCI Host Controller
[    0.657963] usb usb3: Manufacturer: Linux 2.6.37-20-desktop uhci_hcd
[    0.658009] usb usb3: SerialNumber: 0000:00:1a.0
[    0.658136] hub 3-0:1.0: USB hub found
[    0.658184] hub 3-0:1.0: 2 ports detected
[    0.658374] ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 6
[    0.658423] uhci_hcd 0000:00:1a.1: PCI INT B -> Link[LNKF] -> GSI 6 (level, low) -> IRQ 6
[    0.658472] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    0.658520] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.658570] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    0.659696] uhci_hcd 0000:00:1a.1: irq 6, io base 0x0000fc00
[    0.659803] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    0.659865] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.659912] usb usb4: Product: UHCI Host Controller
[    0.659957] usb usb4: Manufacturer: Linux 2.6.37-20-desktop uhci_hcd
[    0.660003] usb usb4: SerialNumber: 0000:00:1a.1
[    0.660128] hub 4-0:1.0: USB hub found
[    0.660176] hub 4-0:1.0: 2 ports detected
[    0.660278] uhci_hcd 0000:00:1a.2: PCI INT D -> Link[LNKD] -> GSI 5 (level, low) -> IRQ 5
[    0.660330] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[    0.660378] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.660427] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    0.661685] uhci_hcd 0000:00:1a.2: irq 5, io base 0x0000fb00
[    0.661794] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    0.661856] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.661902] usb usb5: Product: UHCI Host Controller
[    0.661947] usb usb5: Manufacturer: Linux 2.6.37-20-desktop uhci_hcd
[    0.661992] usb usb5: SerialNumber: 0000:00:1a.2
[    0.662115] hub 5-0:1.0: USB hub found
[    0.662163] hub 5-0:1.0: 2 ports detected
[    0.662266] uhci_hcd 0000:00:1d.0: PCI INT A -> Link[LNK1] -> GSI 5 (level, low) -> IRQ 5
[    0.662317] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    0.662365] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.662415] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    0.663680] uhci_hcd 0000:00:1d.0: irq 5, io base 0x0000fa00
[    0.663789] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    0.663852] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.663899] usb usb6: Product: UHCI Host Controller
[    0.663946] usb usb6: Manufacturer: Linux 2.6.37-20-desktop uhci_hcd
[    0.663992] usb usb6: SerialNumber: 0000:00:1d.0
[    0.664118] hub 6-0:1.0: USB hub found
[    0.664166] hub 6-0:1.0: 2 ports detected
[    0.664268] uhci_hcd 0000:00:1d.1: PCI INT B -> Link[LNKD] -> GSI 5 (level, low) -> IRQ 5
[    0.664320] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    0.664369] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.664419] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    0.665671] uhci_hcd 0000:00:1d.1: irq 5, io base 0x0000f900
[    0.665780] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    0.665843] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.665891] usb usb7: Product: UHCI Host Controller
[    0.665938] usb usb7: Manufacturer: Linux 2.6.37-20-desktop uhci_hcd
[    0.665985] usb usb7: SerialNumber: 0000:00:1d.1
[    0.666107] hub 7-0:1.0: USB hub found
[    0.666156] hub 7-0:1.0: 2 ports detected
[    0.666257] uhci_hcd 0000:00:1d.2: PCI INT C -> Link[LNKC] -> GSI 5 (level, low) -> IRQ 5
[    0.666309] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    0.666358] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.666411] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    0.667667] uhci_hcd 0000:00:1d.2: irq 5, io base 0x0000f800
[    0.667777] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    0.667840] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.667888] usb usb8: Product: UHCI Host Controller
[    0.667935] usb usb8: Manufacturer: Linux 2.6.37-20-desktop uhci_hcd
[    0.667982] usb usb8: SerialNumber: 0000:00:1d.2
[    0.668108] hub 8-0:1.0: USB hub found
[    0.668157] hub 8-0:1.0: 2 ports detected
[    0.668261] Initializing USB Mass Storage driver...
[    0.668337] usbcore: registered new interface driver usb-storage
[    0.668383] USB Mass Storage support registered.
[    0.668438] usbcore: registered new interface driver ums-alauda
[    0.668493] usbcore: registered new interface driver ums-cypress
[    0.668548] usbcore: registered new interface driver ums-datafab
[    0.668603] usbcore: registered new interface driver ums-freecom
[    0.668662] usbcore: registered new interface driver ums-isd200
[    0.668715] usbcore: registered new interface driver ums-jumpshot
[    0.668768] usbcore: registered new interface driver ums-karma
[    0.668821] usbcore: registered new interface driver ums-onetouch
[    0.668875] usbcore: registered new interface driver ums-sddr09
[    0.668927] usbcore: registered new interface driver ums-sddr55
[    0.668978] usbcore: registered new interface driver ums-usbat
[    0.669089] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.671571] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.671645] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.671765] mice: PS/2 mouse device common for all mice
[    0.671874] rtc_cmos 00:04: RTC can wake from S4
[    0.673691] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    0.673781] rtc0: alarms up to one month, 242 bytes nvram, hpet irqs
[    0.673843] cpuidle: using governor ladder
[    0.673887] cpuidle: using governor menu
[    0.674138] usbcore: registered new interface driver usbhid
[    0.674183] usbhid: USB HID core driver
[    0.674375] TCP cubic registered
[    0.674457] NET: Registered protocol family 10
[    0.674718] lo: Disabled Privacy Extensions
[    0.674902] lib80211: common routines for IEEE802.11 drivers
[    0.674946] lib80211_crypt: registered algorithm 'NULL'
[    0.674990] Registering the dns_resolver key type
[    0.675054] libceph: loaded (mon/osd proto 15/24, osdmap 5/5 5/5)
[    0.675103] Using IPI No-Shortcut mode
[    0.675218] PM: Checking hibernation image partition /dev/disk/by-id/ata-WDC_WD2500BEKT-00PVMT0_WD-WXK1AB098585-part1
[    0.697827] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.863984] psmouse serio1: ID: 20 03 3c
[    0.939040] ata2: SATA link down (SStatus 0 SControl 300)
[    0.950993] ata3: SATA link down (SStatus 0 SControl 300)
[    0.961716] ata4: SATA link down (SStatus 0 SControl 300)
[    1.105717] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.142104] ata1.00: ATA-8: WDC WD2500BEKT-00PVMT0, 01.01A01, max UDMA/133
[    1.142174] ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    1.148236] ata1.00: configured for UDMA/133
[    1.148406] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500BEKT-0 01.0 PQ: 0 ANSI: 5
[    1.148602] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/232 GiB)
[    1.148684] sd 0:0:0:0: [sda] Write Protect is off
[    1.148729] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.148789] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.155382]  sda: sda1 sda2
[    1.155638] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.371010] usb 7-1: new full speed USB device using uhci_hcd and address 2
[    1.383259] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input1
[    1.386506] PM: Hibernation image not present or could not be loaded.
[    1.386594] registered taskstats version 1
[    1.386916]   Magic number: 15:116:895
[    1.387008] rtc_cmos 00:04: setting system clock to 2011-02-28 16:53:19 UTC (1298911999)
[    1.387107] Freeing unused kernel memory: 452k freed
[    1.387258] Write protecting the kernel text: 4696k
[    1.387349] Write protecting the kernel read-only data: 3204k
[    1.415704] ACPI Error: [RTMP] Namespace lookup failure, AE_NOT_FOUND (20101013/psargs-359)
[    1.415760] ACPI Error: Method parse/execution failed [\_TZ_.THRM._TMP] (Node f483c2d8), AE_NOT_FOUND (20101013/psparse-537)
[    1.426650] ACPI: acpi_idle registered with cpuidle
[    1.428211] ACPI: Fan [FAN] (on)
[    1.436102] udev[84]: starting version 165
[    1.453082] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[    1.453176] ACPI: Power Button [PWRB]
[    1.453279] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.453349] ACPI: Power Button [PWRF]
[    1.517781] usb 7-1: New USB device found, idVendor=067b, idProduct=2303
[    1.517837] usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.517883] usb 7-1: Product: USB-Serial Controller
[    1.517928] usb 7-1: Manufacturer: Prolific Technology Inc.
[    1.595958] [drm] Initialized drm 1.1.0 20060810
[    1.616501] i915 0000:00:02.0: PCI INT A -> Link[LNKA] -> GSI 5 (level, low) -> IRQ 5
[    1.616553] i915 0000:00:02.0: setting latency timer to 64
[    1.627255] mtrr: no more MTRRs available
[    1.627303] [drm] MTRR allocation failed.  Graphics performance may suffer.
[    1.627871] i915 0000:00:02.0: irq 16 for MSI/MSI-X
[    1.661294] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.772614] checking generic (d0000000 3ff0000) vs hw (d0000000 10000000)
[    1.772668] fb: conflicting fb hw usage inteldrmfb vs VESA VGA - removing generic driver
[    1.772726] Console: switching to colour dummy device 80x25
[    1.795047] Console: switching to colour frame buffer device 106x30
[    1.809728] bootsplash: scaling image from 1024x768 to 848x480
[    1.856662] bootsplash: scaling image from 1024x768 to 848x480
[    1.893461] bootsplash: scaling image from 1024x768 to 848x480
[    1.939963] bootsplash: scaling image from 1024x768 to 848x480
[    1.963656] fb0: inteldrmfb frame buffer device
[    1.963679] drm: registered panic notifier
[    1.965852] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input4
[    1.965954] ACPI: Video Device [IGD0] (multi-head: yes  rom: no  post: no)
[    1.966226] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    2.021844] PM: Marking nosave pages: 000000000009f000 - 0000000000100000
[    2.021872] PM: Basic memory bitmaps created
[    2.031229] PM: Basic memory bitmaps freed
[    2.031265] video LNXVIDEO:00: Restoring backlight state
[    2.095853] PM: Starting manual resume from disk
[    2.095879] PM: Hibernation image partition 8:1 present
[    2.095901] PM: Looking for hibernation image.
[    2.096107] PM: Image not found (code -22)
[    2.096145] PM: Hibernation image not present or could not be loaded.
[    2.805885] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[    2.879731] EXT4-fs (sda2): re-mounted. Opts: acl,user_xattr
[    3.777126] udev[363]: starting version 165
[    4.161259] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    4.230127] e1000e: Intel(R) PRO/1000 Network Driver - 1.2.7-k2
[    4.230155] e1000e: Copyright (c) 1999 - 2010 Intel Corporation.
[    4.230317] ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 6
[    4.230345] e1000e 0000:00:19.0: PCI INT A -> Link[LNKE] -> GSI 6 (level, low) -> IRQ 6
[    4.230379] e1000e 0000:00:19.0: setting latency timer to 64
[    4.230482] e1000e 0000:00:19.0: irq 17 for MSI/MSI-X
[    4.261499] iTCO_vendor_support: vendor-support=0
[    4.288739] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    4.317189] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.327431] usbcore: registered new interface driver usbserial
[    4.327585] USB Serial support registered for generic
[    4.327747] usbcore: registered new interface driver usbserial_generic
[    4.327774] usbserial: USB Serial Driver core
[    4.345051] IT8712 SuperIO detected.
[    4.345332] parport_pc 00:09: reported by Plug and Play ACPI
[    4.345398] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    4.373521] firewire_ohci 0000:06:09.0: PCI INT A -> Link[LNKB] -> GSI 6 (level, low) -> IRQ 6
[    4.402188] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[    4.402586] iTCO_wdt: Found a ICH9M TCO device (Version=2, TCOBASE=0x0460)
[    4.402865] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    4.406309] e1000e 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:07:32:17:5f:fe
[    4.406339] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    4.406383] e1000e 0000:00:19.0: eth0: MAC: 7, PHY: 8, PBA No: ffffff-0ff
[    4.406476] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    4.406533] i801_smbus 0000:00:1f.3: PCI INT B -> Link[LNKD] -> GSI 5 (level, low) -> IRQ 5
[    4.407377] e1000e 0000:02:00.0: PCI INT A -> Link[LNKA] -> GSI 5 (level, low) -> IRQ 5
[    4.407421] e1000e 0000:02:00.0: setting latency timer to 64
[    4.407613] e1000e 0000:02:00.0: irq 18 for MSI/MSI-X
[    4.407643] e1000e 0000:02:00.0: irq 19 for MSI/MSI-X
[    4.407670] e1000e 0000:02:00.0: irq 20 for MSI/MSI-X
[    4.408183] e1000e 0000:02:00.0: Disabling ASPM L0s
[    4.419657] USB Serial support registered for pl2303
[    4.419699] pl2303 7-1:1.0: pl2303 converter detected
[    4.419858] ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 6
[    4.419887] HDA Intel 0000:00:1b.0: PCI INT A -> Link[LNK0] -> GSI 6 (level, low) -> IRQ 6
[    4.419948] HDA Intel 0000:00:1b.0: irq 21 for MSI/MSI-X
[    4.419993] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    4.426053] firewire_ohci: Added fw-ohci device 0000:06:09.0, OHCI v1.0, 4 IR + 8 IT contexts, quirks 0x11
[    4.431805] usb 7-1: pl2303 converter now attached to ttyUSB0
[    4.431846] usbcore: registered new interface driver pl2303
[    4.431875] pl2303: Prolific PL2303 USB to serial adaptor driver
[    4.474224] ppdev: user-space parallel port driver
[    4.500514] e1000e 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:07:32:17:81:c5
[    4.500545] e1000e 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
[    4.500655] e1000e 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: ffffff-0ff
[    4.595392] hda_codec: ALC888: BIOS auto-probing.
[    4.595425] hda_codec: ALC888: SKU not ready 0x00000100
[    4.595457] ALSA hda_codec.c:4630: autoconfig: line_outs=4 (0x14/0x16/0x15/0x17/0x0)
[    4.595487] ALSA hda_codec.c:4634:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.595516] ALSA hda_codec.c:4638:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    4.595545] ALSA hda_codec.c:4639:    mono: mono_out=0x0
[    4.595573] ALSA hda_codec.c:4642:    dig-out=0x1e/0x0
[    4.595600] ALSA hda_codec.c:4643:    inputs:
[    4.595604] ALSA hda_codec.c:4649:
[    4.597243] ALSA patch_realtek.c:1581: realtek: No valid SSID, checking pincfg 0x00000100 for NID 0x1d
[    4.597299] ALSA patch_realtek.c:1665: realtek: Enable default setup for auto mode as fallback
[    4.600837] input: HDA Intel Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[    4.927096] firewire_core: created device fw0: GUID 000800080008095f, S400
[    4.928015] firewire_core: phy config: card 0, new root=ffc1, gap_count=5
[    5.302583] netconsole: local port 6665
[    5.302614] netconsole: local IP 10.1.40.199
[    5.302641] netconsole: interface 'eth0'
[    5.302667] netconsole: remote port 6666
[    5.302693] netconsole: remote IP 10.1.40.73
[    5.302719] netconsole: remote ethernet address 00:1d:60:b9:fb:77
[    5.302746] netconsole: device eth0 not up yet, forcing it
[    5.369228] e1000e 0000:00:19.0: irq 17 for MSI/MSI-X
[    5.420044] e1000e 0000:00:19.0: irq 17 for MSI/MSI-X
[    5.420278] ADDRCONF(NETDEV_UP): eth0: link is not ready
[    6.982861] e1000e: eth0 NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[    6.982891] e1000e 0000:00:19.0: eth0: 10/100 speed: disabling TSO
[    6.983064] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    7.006123] console [netcon0] enabled
[    7.006153] netconsole: network logging started
[    7.048628] Adding 2103292k swap on /dev/sda1.  Priority:-1 extents:1 across:2103292k
[    7.939194] firewire_core: created device fw1: GUID 00b09d01007ad738, S400, 1 config ROM retries
[    8.208984] device-mapper: uevent: version 1.0.3
[    8.209291] device-mapper: ioctl: 4.18.0-ioctl (2010-06-29) initialised: dm-devel@redhat.com
[    9.121813] type=1400 audit(1298912007.233:2): apparmor="STATUS" operation="profile_load" name="/bin/ping" pid=763 comm="apparmor_parser"
[    9.163663] type=1400 audit(1298912007.275:3): apparmor="STATUS" operation="profile_load" name="/sbin/klogd" pid=779 comm="apparmor_parser"
[    9.260717] type=1400 audit(1298912007.372:4): apparmor="STATUS" operation="profile_load" name="/sbin/syslog-ng" pid=783 comm="apparmor_parser"
[    9.352546] type=1400 audit(1298912007.464:5): apparmor="STATUS" operation="profile_load" name="/sbin/syslogd" pid=787 comm="apparmor_parser"
[    9.776380] type=1400 audit(1298912007.888:6): apparmor="STATUS" operation="profile_load" name="/usr/lib/apache2/mpm-prefork/apache2" pid=798 comm="apparmor_parser"
[    9.776456] type=1400 audit(1298912007.888:7): apparmor="STATUS" operation="profile_load" name="/usr/lib/apache2/mpm-prefork/apache2//DEFAULT_URI" pid=798 comm="apparmor_parser"
[    9.776508] type=1400 audit(1298912007.888:8): apparmor="STATUS" operation="profile_load" name="/usr/lib/apache2/mpm-prefork/apache2//HANDLING_UNTRUSTED_INPUT" pid=798 comm="apparmor_parser"
[    9.776601] type=1400 audit(1298912007.888:9): apparmor="STATUS" operation="profile_load" name="/usr/lib/apache2/mpm-prefork/apache2//phpsysinfo" pid=798 comm="apparmor_parser"
[    9.869436] type=1400 audit(1298912007.981:10): apparmor="STATUS" operation="profile_load" name="/usr/lib/dovecot/deliver" pid=835 comm="apparmor_parser"
[    9.965983] type=1400 audit(1298912008.077:11): apparmor="STATUS" operation="profile_load" name="/usr/lib/dovecot/dovecot-auth" pid=839 comm="apparmor_parser"
[   12.526129] NET: Registered protocol family 17
[   15.036065] bootsplash: scaling image from 1024x768 to 848x480
[   15.082377] bootsplash: scaling image from 1024x768 to 848x480
[   15.380295] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[   15.926484] powernow: This module only works with AMD K7 CPUs
[  175.706014] ata1: lost interrupt (Status 0x50)
[  175.706040] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  175.706050] ata1.00: failed command: READ DMA
[  175.706062] ata1.00: cmd c8/00:08:28:41:01/00:00:00:00:00/e1 tag 0 dma 4096 in
[  175.706064]          res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
[  175.706079] ata1.00: status: { DRDY }
[  175.706091] ata1: hard resetting link
[  176.162049] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  181.165024] ata1.00: qc timeout (cmd 0x27)
[  181.165034] ata1.00: failed to read native max address (err_mask=0x4)
[  181.165043] ata1.00: revalidation failed (errno=-5)
[  181.165054] ata1: hard resetting link
[  181.621053] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  191.624025] ata1.00: qc timeout (cmd 0x27)
[  191.624036] ata1.00: failed to read native max address (err_mask=0x4)
[  191.624045] ata1.00: revalidation failed (errno=-5)
[  191.624053] ata1: limiting SATA link speed to 1.5 Gbps
[  191.624065] ata1: hard resetting link
[  192.080046] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  202.083023] ata1.00: qc timeout (cmd 0x27)
[  202.083033] ata1.00: failed to read native max address (err_mask=0x4)
[  202.083042] ata1.00: revalidation failed (errno=-5)
[  202.083049] ata1.00: disabled
[  202.083066] ata1: hard resetting link
[  202.539046] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  202.539068] ata1: EH complete
[  202.539084] sd 0:0:0:0: [sda] Unhandled error code
[  202.539092] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539104] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 41 28 00 00 08 00
[  202.539133] end_request: I/O error, dev sda, sector 16859432
[  202.539170] sd 0:0:0:0: [sda] Unhandled error code
[  202.539175] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539182] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 01 84 66 78 00 00 08 00
[  202.539197] end_request: I/O error, dev sda, sector 25454200
[  202.539208] sd 0:0:0:0: [sda] Unhandled error code
[  202.539213] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539220] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 01 84 66 80 00 00 08 00
[  202.539236] end_request: I/O error, dev sda, sector 25454208
[  202.539247] Aborting journal on device sda2-8.
[  202.539262] sd 0:0:0:0: [sda] Unhandled error code
[  202.539267] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539274] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 01 84 58 08 00 00 08 00
[  202.539290] end_request: I/O error, dev sda, sector 25450504
[  202.539295] quiet_error: 45 callbacks suppressed
[  202.539300] Buffer I/O error on device sda2, logical block 2655233
[  202.539305] lost page write due to I/O error on sda2
[  202.539314] JBD2: I/O error detected when updating journal superblock for sda2-8.
[  202.539462] sd 0:0:0:0: [sda] Unhandled error code
[  202.539468] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539475] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 c0 40 f0 00 00 08 00
[  202.539491] end_request: I/O error, dev sda, sector 12599536
[  202.539496] Buffer I/O error on device sda2, logical block 1048862
[  202.539501] lost page write due to I/O error on sda2
[  202.539515] sd 0:0:0:0: [sda] Unhandled error code
[  202.539520] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539527] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 01 00 39 00 00 00 08 00
[  202.539543] end_request: I/O error, dev sda, sector 16791808
[  202.539548] Buffer I/O error on device sda2, logical block 1572896
[  202.539553] lost page write due to I/O error on sda2
[  202.539565] sd 0:0:0:0: [sda] Unhandled error code
[  202.539571] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539577] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 01 c0 43 b8 00 00 08 00
[  202.539593] end_request: I/O error, dev sda, sector 29377464
[  202.539598] Buffer I/O error on device sda2, logical block 3146103
[  202.539603] lost page write due to I/O error on sda2
[  202.539613] EXT4-fs error (device sda2) in ext4_reserve_inode_write:5600: Journal has aborted
[  202.539640] EXT4-fs error (device sda2) in ext4_reserve_inode_write:5600: Journal has aborted
[  202.539649] sd 0:0:0:0: [sda] Unhandled error code
[  202.539653] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539660] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 40 38 00 00 00 08 00
[  202.539676] end_request: I/O error, dev sda, sector 4208640
[  202.539681] Buffer I/O error on device sda2, logical block 0
[  202.539685] lost page write due to I/O error on sda2
[  202.539696] EXT4-fs error (device sda2) in ext4_dirty_inode:5727: Journal has aborted
[  202.539702] EXT4-fs (sda2): previous I/O error to superblock detected
[  202.539717] sd 0:0:0:0: [sda] Unhandled error code
[  202.539722] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539729] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 40 38 00 00 00 08 00
[  202.539745] end_request: I/O error, dev sda, sector 4208640
[  202.539750] Buffer I/O error on device sda2, logical block 0
[  202.539755] lost page write due to I/O error on sda2
[  202.539783] EXT4-fs (sda2): I/O error while writing superblock
[  202.539792] EXT4-fs error (device sda2) in ext4_dirty_inode:5727: Journal has aborted
[  202.539827] sd 0:0:0:0: [sda] Unhandled error code
[  202.539832] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539839] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 40 38 00 00 00 08 00
[  202.539855] end_request: I/O error, dev sda, sector 4208640
[  202.539860] Buffer I/O error on device sda2, logical block 0
[  202.539864] lost page write due to I/O error on sda2
[  202.539916] sd 0:0:0:0: [sda] Unhandled error code
[  202.539921] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539928] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 45 6a 40 00 00 08 00
[  202.539943] end_request: I/O error, dev sda, sector 4549184
[  202.539949] Buffer I/O error on device sda2, logical block 42568
[  202.539953] lost page write due to I/O error on sda2
[  202.539968] sd 0:0:0:0: [sda] Unhandled error code
[  202.539973] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.539980] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 02 06 7a 20 00 00 08 00
[  202.539997] end_request: I/O error, dev sda, sector 33978912
[  202.540006] Buffer I/O error on device sda2, logical block 3721284
[  202.540011] lost page write due to I/O error on sda2
[  202.540022] JBD2: Detected IO errors while flushing file data on sda2-8
[  202.541790] EXT4-fs (sda2): previous I/O error to superblock detected
[  202.541810] sd 0:0:0:0: [sda] Unhandled error code
[  202.541815] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.541822] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 40 38 00 00 00 08 00
[  202.541839] end_request: I/O error, dev sda, sector 4208640
[  202.541844] Buffer I/O error on device sda2, logical block 0
[  202.541849] lost page write due to I/O error on sda2
[  202.542101] EXT4-fs error (device sda2): ext4_journal_start_sb:260: Detected aborted journal
[  202.542110] EXT4-fs (sda2): Remounting filesystem read-only
[  202.542117] EXT4-fs (sda2): previous I/O error to superblock detected
[  202.542133] sd 0:0:0:0: [sda] Unhandled error code
[  202.542139] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.542147] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 40 38 00 00 00 08 00
[  202.542169] end_request: I/O error, dev sda, sector 4208640
[  202.550021] sd 0:0:0:0: [sda] Unhandled error code
[  202.550032] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.550042] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 41 10 00 00 08 00
[  202.550068] end_request: I/O error, dev sda, sector 16859408
[  202.550168] sd 0:0:0:0: [sda] Unhandled error code
[  202.550177] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.550188] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 41 38 00 00 08 00
[  202.550214] end_request: I/O error, dev sda, sector 16859448
[  202.550267] sd 0:0:0:0: [sda] Unhandled error code
[  202.550273] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.550281] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 41 58 00 00 08 00
[  202.550297] end_request: I/O error, dev sda, sector 16859480
[  202.550355] sd 0:0:0:0: [sda] Unhandled error code
[  202.550361] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.550368] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 41 50 00 00 08 00
[  202.550383] end_request: I/O error, dev sda, sector 16859472
[  202.550434] sd 0:0:0:0: [sda] Unhandled error code
[  202.550440] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.550447] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 41 30 00 00 08 00
[  202.550462] end_request: I/O error, dev sda, sector 16859440
[  202.550514] sd 0:0:0:0: [sda] Unhandled error code
[  202.550520] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.550528] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 41 00 00 00 08 00
[  202.550544] end_request: I/O error, dev sda, sector 16859392
[  202.550603] sd 0:0:0:0: [sda] Unhandled error code
[  202.550609] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.550616] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 40 f8 00 00 08 00
[  202.550631] end_request: I/O error, dev sda, sector 16859384
[  202.550682] sd 0:0:0:0: [sda] Unhandled error code
[  202.550687] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.550694] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 41 08 00 00 08 00
[  202.550710] end_request: I/O error, dev sda, sector 16859400
[  202.550760] sd 0:0:0:0: [sda] Unhandled error code
[  202.550766] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.550773] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 40 f0 00 00 08 00
[  202.550790] end_request: I/O error, dev sda, sector 16859376
[  202.550852] sd 0:0:0:0: [sda] Unhandled error code
[  202.550858] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.550865] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 43 d0 00 00 08 00
[  202.550880] end_request: I/O error, dev sda, sector 16860112
[  202.550930] sd 0:0:0:0: [sda] Unhandled error code
[  202.550936] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.550942] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 42 30 00 00 08 00
[  202.550958] end_request: I/O error, dev sda, sector 16859696
[  202.551065] sd 0:0:0:0: [sda] Unhandled error code
[  202.551072] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.551078] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 46 40 00 00 08 00
[  202.551095] end_request: I/O error, dev sda, sector 16860736
[  202.551150] sd 0:0:0:0: [sda] Unhandled error code
[  202.551156] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.551162] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 3e c0 00 00 08 00
[  202.551179] end_request: I/O error, dev sda, sector 16858816
[  202.551229] sd 0:0:0:0: [sda] Unhandled error code
[  202.551234] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.551241] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 3d f0 00 00 08 00
[  202.551257] end_request: I/O error, dev sda, sector 16858608
[  202.551318] sd 0:0:0:0: [sda] Unhandled error code
[  202.551324] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.551330] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 3f a0 00 00 08 00
[  202.551346] end_request: I/O error, dev sda, sector 16859040
[  202.551401] sd 0:0:0:0: [sda] Unhandled error code
[  202.551407] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.551414] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 47 20 00 00 08 00
[  202.551429] end_request: I/O error, dev sda, sector 16860960
[  202.551521] sd 0:0:0:0: [sda] Unhandled error code
[  202.551528] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.551535] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 00 5f 00 00 01 08 00
[  202.551550] end_request: I/O error, dev sda, sector 16801536
[  202.551570] EXT4-fs (sda2): previous I/O error to superblock detected
[  202.551585] sd 0:0:0:0: [sda] Unhandled error code
[  202.551591] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.551597] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 40 38 00 00 00 08 00
[  202.551613] end_request: I/O error, dev sda, sector 4208640
[  202.551624] EXT4-fs error (device sda2): __ext4_get_inode_loc:4749: inode #413447: block 1574112: comm find: unable to read itable block
[  202.551682] sd 0:0:0:0: [sda] Unhandled error code
[  202.551688] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.551694] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3e 68 00 00 08 00
[  202.551710] end_request: I/O error, dev sda, sector 33635944
[  202.551760] sd 0:0:0:0: [sda] Unhandled error code
[  202.551766] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.551772] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4d 68 00 00 08 00
[  202.551790] end_request: I/O error, dev sda, sector 16862568
[  202.551882] sd 0:0:0:0: [sda] Unhandled error code
[  202.551888] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.551895] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 3b d0 00 00 08 00
[  202.551910] end_request: I/O error, dev sda, sector 16858064
[  202.551962] sd 0:0:0:0: [sda] Unhandled error code
[  202.551967] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.551974] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 49 88 00 00 08 00
[  202.551990] end_request: I/O error, dev sda, sector 29444488
[  202.552087] sd 0:0:0:0: [sda] Unhandled error code
[  202.552093] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.552100] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4d e0 00 00 08 00
[  202.552116] end_request: I/O error, dev sda, sector 16862688
[  202.552190] sd 0:0:0:0: [sda] Unhandled error code
[  202.552196] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.552203] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 3a 78 00 00 08 00
[  202.552219] end_request: I/O error, dev sda, sector 12663416
[  202.552270] sd 0:0:0:0: [sda] Unhandled error code
[  202.552277] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.552284] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 46 38 00 00 08 00
[  202.552300] end_request: I/O error, dev sda, sector 12666424
[  202.552357] sd 0:0:0:0: [sda] Unhandled error code
[  202.552363] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.552370] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 43 50 00 00 08 00
[  202.552386] end_request: I/O error, dev sda, sector 12665680
[  202.552437] sd 0:0:0:0: [sda] Unhandled error code
[  202.552443] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.552449] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 3a c0 00 00 08 00
[  202.552465] end_request: I/O error, dev sda, sector 12663488
[  202.552517] sd 0:0:0:0: [sda] Unhandled error code
[  202.552525] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.552531] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 46 50 00 00 08 00
[  202.552547] end_request: I/O error, dev sda, sector 12666448
[  202.552649] sd 0:0:0:0: [sda] Unhandled error code
[  202.552655] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.552662] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c0 4f 08 00 00 f8 00
[  202.552678] end_request: I/O error, dev sda, sector 12603144
[  202.552690] sd 0:0:0:0: [sda] Unhandled error code
[  202.552694] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.552701] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c0 4f 10 00 00 f0 00
[  202.552717] end_request: I/O error, dev sda, sector 12603152
[  202.552730] EXT4-fs (sda2): previous I/O error to superblock detected
[  202.552746] sd 0:0:0:0: [sda] Unhandled error code
[  202.552751] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.552758] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 40 38 00 00 00 08 00
[  202.552775] end_request: I/O error, dev sda, sector 4208640
[  202.552792] EXT4-fs error (device sda2): __ext4_get_inode_loc:4749: inode #274067: block 1049321: comm find: unable to read itable block
[  202.552846] sd 0:0:0:0: [sda] Unhandled error code
[  202.552852] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.552859] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4e 78 00 00 08 00
[  202.552874] end_request: I/O error, dev sda, sector 16862840
[  202.552925] sd 0:0:0:0: [sda] Unhandled error code
[  202.552930] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.552937] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4c 40 00 00 08 00
[  202.552954] end_request: I/O error, dev sda, sector 16862272
[  202.553048] sd 0:0:0:0: [sda] Unhandled error code
[  202.553053] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553060] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 4a 50 00 00 08 00
[  202.553075] end_request: I/O error, dev sda, sector 29444688
[  202.553129] sd 0:0:0:0: [sda] Unhandled error code
[  202.553134] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553141] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 4f 68 00 00 08 00
[  202.553156] end_request: I/O error, dev sda, sector 21057384
[  202.553207] sd 0:0:0:0: [sda] Unhandled error code
[  202.553213] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553221] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 3b c0 00 00 08 00
[  202.553237] end_request: I/O error, dev sda, sector 16858048
[  202.553296] sd 0:0:0:0: [sda] Unhandled error code
[  202.553302] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553308] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4d c0 00 00 08 00
[  202.553324] end_request: I/O error, dev sda, sector 16862656
[  202.553373] sd 0:0:0:0: [sda] Unhandled error code
[  202.553379] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553385] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4c 70 00 00 08 00
[  202.553401] end_request: I/O error, dev sda, sector 16862320
[  202.553451] sd 0:0:0:0: [sda] Unhandled error code
[  202.553457] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553464] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 49 38 00 00 08 00
[  202.553480] end_request: I/O error, dev sda, sector 16861496
[  202.553537] sd 0:0:0:0: [sda] Unhandled error code
[  202.553543] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553549] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4c 78 00 00 08 00
[  202.553564] end_request: I/O error, dev sda, sector 16862328
[  202.553615] sd 0:0:0:0: [sda] Unhandled error code
[  202.553621] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553628] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 5d 80 00 00 08 00
[  202.553644] end_request: I/O error, dev sda, sector 12672384
[  202.553694] sd 0:0:0:0: [sda] Unhandled error code
[  202.553700] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553706] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 5a 28 00 00 08 00
[  202.553724] end_request: I/O error, dev sda, sector 29448744
[  202.553824] sd 0:0:0:0: [sda] Unhandled error code
[  202.553830] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553836] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 3e 00 00 00 08 00
[  202.553852] end_request: I/O error, dev sda, sector 21052928
[  202.553905] sd 0:0:0:0: [sda] Unhandled error code
[  202.553911] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553917] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 3e 50 00 00 08 00
[  202.553933] end_request: I/O error, dev sda, sector 21053008
[  202.553984] sd 0:0:0:0: [sda] Unhandled error code
[  202.553990] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.553997] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 59 d0 00 00 08 00
[  202.554018] end_request: I/O error, dev sda, sector 29448656
[  202.554750] sd 0:0:0:0: [sda] Unhandled error code
[  202.554756] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.554763] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 55 c0 00 00 08 00
[  202.554779] end_request: I/O error, dev sda, sector 12670400
[  202.554835] sd 0:0:0:0: [sda] Unhandled error code
[  202.554840] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.554847] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 55 b8 00 00 08 00
[  202.554862] end_request: I/O error, dev sda, sector 12670392
[  202.554916] sd 0:0:0:0: [sda] Unhandled error code
[  202.554922] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.554929] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4c 10 00 00 08 00
[  202.554944] end_request: I/O error, dev sda, sector 16862224
[  202.555398] sd 0:0:0:0: [sda] Unhandled error code
[  202.555404] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.555411] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a e8 00 00 08 00
[  202.555427] end_request: I/O error, dev sda, sector 16861928
[  202.557235] sd 0:0:0:0: [sda] Unhandled error code
[  202.557241] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.557248] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4c 00 00 00 08 00
[  202.557264] end_request: I/O error, dev sda, sector 16862208
[  202.557646] sd 0:0:0:0: [sda] Unhandled error code
[  202.557652] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.557659] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a f8 00 00 08 00
[  202.557675] end_request: I/O error, dev sda, sector 16861944
[  202.558316] sd 0:0:0:0: [sda] Unhandled error code
[  202.558322] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.558329] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a 88 00 00 08 00
[  202.558346] end_request: I/O error, dev sda, sector 16861832
[  202.559172] sd 0:0:0:0: [sda] Unhandled error code
[  202.559178] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.559185] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a 60 00 00 08 00
[  202.559201] end_request: I/O error, dev sda, sector 16861792
[  202.559348] sd 0:0:0:0: [sda] Unhandled error code
[  202.559354] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.559361] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a 78 00 00 08 00
[  202.559377] end_request: I/O error, dev sda, sector 16861816
[  202.559436] sd 0:0:0:0: [sda] Unhandled error code
[  202.559442] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.559449] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a 80 00 00 08 00
[  202.559464] end_request: I/O error, dev sda, sector 16861824
[  202.559716] sd 0:0:0:0: [sda] Unhandled error code
[  202.559722] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.559729] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a b8 00 00 08 00
[  202.559746] end_request: I/O error, dev sda, sector 16861880
[  202.559883] sd 0:0:0:0: [sda] Unhandled error code
[  202.559889] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.559896] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a b0 00 00 08 00
[  202.559914] end_request: I/O error, dev sda, sector 16861872
[  202.560574] sd 0:0:0:0: [sda] Unhandled error code
[  202.560580] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.560588] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a d8 00 00 08 00
[  202.560604] end_request: I/O error, dev sda, sector 16861912
[  202.561711] sd 0:0:0:0: [sda] Unhandled error code
[  202.561717] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.561724] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a c8 00 00 08 00
[  202.561740] end_request: I/O error, dev sda, sector 16861896
[  202.561799] sd 0:0:0:0: [sda] Unhandled error code
[  202.561805] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.561812] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a a0 00 00 08 00
[  202.561828] end_request: I/O error, dev sda, sector 16861856
[  202.561977] sd 0:0:0:0: [sda] Unhandled error code
[  202.561983] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.561990] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a c0 00 00 08 00
[  202.562011] end_request: I/O error, dev sda, sector 16861888
[  202.562203] sd 0:0:0:0: [sda] Unhandled error code
[  202.562210] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.562216] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4e 68 00 00 08 00
[  202.562233] end_request: I/O error, dev sda, sector 16862824
[  202.562416] sd 0:0:0:0: [sda] Unhandled error code
[  202.562422] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.562429] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4d b0 00 00 08 00
[  202.562445] end_request: I/O error, dev sda, sector 16862640
[  202.562565] sd 0:0:0:0: [sda] Unhandled error code
[  202.562571] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.562578] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 3b c8 00 00 08 00
[  202.562594] end_request: I/O error, dev sda, sector 16858056
[  202.562769] sd 0:0:0:0: [sda] Unhandled error code
[  202.562775] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.562782] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4c 60 00 00 08 00
[  202.562798] end_request: I/O error, dev sda, sector 16862304
[  202.563377] sd 0:0:0:0: [sda] Unhandled error code
[  202.563384] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.563391] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 49 40 00 00 08 00
[  202.563407] end_request: I/O error, dev sda, sector 16861504
[  202.564125] sd 0:0:0:0: [sda] Unhandled error code
[  202.564132] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.564139] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 4f 40 00 00 08 00
[  202.564155] end_request: I/O error, dev sda, sector 21057344
[  202.564302] sd 0:0:0:0: [sda] Unhandled error code
[  202.564308] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.564315] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 46 68 00 00 08 00
[  202.564331] end_request: I/O error, dev sda, sector 12666472
[  202.564496] sd 0:0:0:0: [sda] Unhandled error code
[  202.564502] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.564509] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 49 a0 00 00 08 00
[  202.564531] end_request: I/O error, dev sda, sector 16861600
[  202.564673] sd 0:0:0:0: [sda] Unhandled error code
[  202.564679] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.564686] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 49 90 00 00 08 00
[  202.564703] end_request: I/O error, dev sda, sector 16861584
[  202.564754] sd 0:0:0:0: [sda] Unhandled error code
[  202.564760] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.564767] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 49 78 00 00 08 00
[  202.564784] end_request: I/O error, dev sda, sector 16861560
[  202.564934] sd 0:0:0:0: [sda] Unhandled error code
[  202.564940] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.564947] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 49 98 00 00 08 00
[  202.564963] end_request: I/O error, dev sda, sector 16861592
[  202.565069] sd 0:0:0:0: [sda] Unhandled error code
[  202.565075] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.565082] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 49 88 00 00 08 00
[  202.565100] end_request: I/O error, dev sda, sector 16861576
[  202.565192] sd 0:0:0:0: [sda] Unhandled error code
[  202.565198] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.565205] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a 00 00 00 08 00
[  202.565221] end_request: I/O error, dev sda, sector 16861696
[  202.565403] sd 0:0:0:0: [sda] Unhandled error code
[  202.565409] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.565416] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4a 48 00 00 08 00
[  202.565432] end_request: I/O error, dev sda, sector 16861768
[  202.565481] sd 0:0:0:0: [sda] Unhandled error code
[  202.565487] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.565494] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 49 68 00 00 08 00
[  202.565511] end_request: I/O error, dev sda, sector 16861544
[  202.565561] sd 0:0:0:0: [sda] Unhandled error code
[  202.565567] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.565573] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 49 60 00 00 08 00
[  202.565589] end_request: I/O error, dev sda, sector 16861536
[  202.566081] sd 0:0:0:0: [sda] Unhandled error code
[  202.566088] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.566095] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 49 a8 00 00 08 00
[  202.566111] end_request: I/O error, dev sda, sector 16861608
[  202.566267] sd 0:0:0:0: [sda] Unhandled error code
[  202.566273] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.566282] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 39 b0 00 00 08 00
[  202.566297] end_request: I/O error, dev sda, sector 12663216
[  202.579860] sd 0:0:0:0: [sda] Unhandled error code
[  202.579867] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.579874] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f b0 00 00 08 00
[  202.579889] end_request: I/O error, dev sda, sector 12668848
[  202.581059] sd 0:0:0:0: [sda] Unhandled error code
[  202.581066] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.581073] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 51 d0 00 00 08 00
[  202.581088] end_request: I/O error, dev sda, sector 12669392
[  202.581177] sd 0:0:0:0: [sda] Unhandled error code
[  202.581183] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.581190] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4e d8 00 00 08 00
[  202.581206] end_request: I/O error, dev sda, sector 16862936
[  202.581276] sd 0:0:0:0: [sda] Unhandled error code
[  202.581282] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.581289] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4c 58 00 00 08 00
[  202.581305] end_request: I/O error, dev sda, sector 12667992
[  202.581398] sd 0:0:0:0: [sda] Unhandled error code
[  202.581404] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.581411] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f a0 00 00 08 00
[  202.581426] end_request: I/O error, dev sda, sector 12668832
[  202.581495] sd 0:0:0:0: [sda] Unhandled error code
[  202.581501] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.581508] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e 70 00 00 08 00
[  202.581526] end_request: I/O error, dev sda, sector 12668528
[  202.581588] sd 0:0:0:0: [sda] Unhandled error code
[  202.581594] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.581601] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 52 28 00 00 08 00
[  202.581617] end_request: I/O error, dev sda, sector 12669480
[  202.581680] sd 0:0:0:0: [sda] Unhandled error code
[  202.581685] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.581692] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 59 e8 00 00 08 00
[  202.581708] end_request: I/O error, dev sda, sector 12671464
[  202.582388] sd 0:0:0:0: [sda] Unhandled error code
[  202.582394] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.582402] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 52 88 00 00 08 00
[  202.582418] end_request: I/O error, dev sda, sector 12669576
[  202.582488] sd 0:0:0:0: [sda] Unhandled error code
[  202.582494] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.582501] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f 40 00 00 08 00
[  202.582518] end_request: I/O error, dev sda, sector 12668736
[  202.582860] sd 0:0:0:0: [sda] Unhandled error code
[  202.582866] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.582873] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 51 b0 00 00 08 00
[  202.582891] end_request: I/O error, dev sda, sector 12669360
[  202.585515] sd 0:0:0:0: [sda] Unhandled error code
[  202.585521] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.585528] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4c 48 00 00 08 00
[  202.585545] end_request: I/O error, dev sda, sector 12667976
[  202.585658] sd 0:0:0:0: [sda] Unhandled error code
[  202.585664] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.585671] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 50 60 00 00 08 00
[  202.585686] end_request: I/O error, dev sda, sector 12669024
[  202.585777] sd 0:0:0:0: [sda] Unhandled error code
[  202.585783] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.585790] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 52 40 00 00 08 00
[  202.585806] end_request: I/O error, dev sda, sector 12669504
[  202.586379] sd 0:0:0:0: [sda] Unhandled error code
[  202.586386] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.586393] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 5d a8 00 00 08 00
[  202.586409] end_request: I/O error, dev sda, sector 12672424
[  202.587368] sd 0:0:0:0: [sda] Unhandled error code
[  202.587375] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.587382] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e 30 00 00 08 00
[  202.587398] end_request: I/O error, dev sda, sector 12668464
[  202.587464] sd 0:0:0:0: [sda] Unhandled error code
[  202.587469] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.587476] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 5a 88 00 00 08 00
[  202.587492] end_request: I/O error, dev sda, sector 12671624
[  202.588126] sd 0:0:0:0: [sda] Unhandled error code
[  202.588132] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.588139] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 5a 30 00 00 08 00
[  202.588156] end_request: I/O error, dev sda, sector 12671536
[  202.588207] sd 0:0:0:0: [sda] Unhandled error code
[  202.588213] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.588220] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e 90 00 00 08 00
[  202.588235] end_request: I/O error, dev sda, sector 12668560
[  202.588294] sd 0:0:0:0: [sda] Unhandled error code
[  202.588300] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.588307] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e b0 00 00 08 00
[  202.588322] end_request: I/O error, dev sda, sector 12668592
[  202.588372] sd 0:0:0:0: [sda] Unhandled error code
[  202.588377] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.588384] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e 98 00 00 08 00
[  202.588400] end_request: I/O error, dev sda, sector 12668568
[  202.588471] sd 0:0:0:0: [sda] Unhandled error code
[  202.588477] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.588484] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e c0 00 00 08 00
[  202.588499] end_request: I/O error, dev sda, sector 12668608
[  202.588594] sd 0:0:0:0: [sda] Unhandled error code
[  202.588600] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.588607] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f a8 00 00 08 00
[  202.588622] end_request: I/O error, dev sda, sector 12668840
[  202.588680] sd 0:0:0:0: [sda] Unhandled error code
[  202.588686] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.588693] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e e0 00 00 08 00
[  202.588710] end_request: I/O error, dev sda, sector 12668640
[  202.588800] sd 0:0:0:0: [sda] Unhandled error code
[  202.588806] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.588812] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 5a b8 00 00 08 00
[  202.588829] end_request: I/O error, dev sda, sector 12671672
[  202.589091] sd 0:0:0:0: [sda] Unhandled error code
[  202.589097] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.589103] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e d0 00 00 08 00
[  202.589120] end_request: I/O error, dev sda, sector 12668624
[  202.589230] sd 0:0:0:0: [sda] Unhandled error code
[  202.589236] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.589243] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c0 57 08 00 00 f8 00
[  202.589261] end_request: I/O error, dev sda, sector 12605192
[  202.589278] sd 0:0:0:0: [sda] Unhandled error code
[  202.589283] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.589290] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c0 57 10 00 00 f0 00
[  202.589305] end_request: I/O error, dev sda, sector 12605200
[  202.589810] EXT4-fs (sda2): previous I/O error to superblock detected
[  202.589935] sd 0:0:0:0: [sda] Unhandled error code
[  202.589941] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.589948] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 40 38 00 00 00 08 00
[  202.589964] end_request: I/O error, dev sda, sector 4208640
[  202.589975] EXT4-fs error (device sda2): __ext4_get_inode_loc:4749: inode #278176: block 1049577: comm find: unable to read itable block
[  202.590087] sd 0:0:0:0: [sda] Unhandled error code
[  202.590093] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.590100] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 50 40 00 00 08 00
[  202.590116] end_request: I/O error, dev sda, sector 12668992
[  202.590179] sd 0:0:0:0: [sda] Unhandled error code
[  202.590184] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.590191] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 51 b8 00 00 08 00
[  202.590208] end_request: I/O error, dev sda, sector 12669368
[  202.590293] sd 0:0:0:0: [sda] Unhandled error code
[  202.590299] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.590305] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 52 70 00 00 08 00
[  202.590322] end_request: I/O error, dev sda, sector 12669552
[  202.590378] sd 0:0:0:0: [sda] Unhandled error code
[  202.590384] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.590391] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 52 98 00 00 08 00
[  202.590406] end_request: I/O error, dev sda, sector 12669592
[  202.590486] sd 0:0:0:0: [sda] Unhandled error code
[  202.590492] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.590498] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 6e f8 00 00 08 00
[  202.590514] end_request: I/O error, dev sda, sector 16871160
[  202.590632] sd 0:0:0:0: [sda] Unhandled error code
[  202.590638] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.590645] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 59 f0 00 00 08 00
[  202.590661] end_request: I/O error, dev sda, sector 12671472
[  202.590871] sd 0:0:0:0: [sda] Unhandled error code
[  202.590877] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.590884] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f 28 00 00 08 00
[  202.590900] end_request: I/O error, dev sda, sector 12668712
[  202.590961] sd 0:0:0:0: [sda] Unhandled error code
[  202.590967] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.590973] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e d8 00 00 08 00
[  202.590989] end_request: I/O error, dev sda, sector 12668632
[  202.591164] sd 0:0:0:0: [sda] Unhandled error code
[  202.591171] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.591177] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c0 57 08 00 00 f8 00
[  202.591193] end_request: I/O error, dev sda, sector 12605192
[  202.591205] sd 0:0:0:0: [sda] Unhandled error code
[  202.591210] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.591217] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c0 57 10 00 00 f0 00
[  202.591233] end_request: I/O error, dev sda, sector 12605200
[  202.591966] EXT4-fs (sda2): previous I/O error to superblock detected
[  202.591984] sd 0:0:0:0: [sda] Unhandled error code
[  202.591989] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.591996] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 40 38 00 00 00 08 00
[  202.592017] end_request: I/O error, dev sda, sector 4208640
[  202.592238] EXT4-fs error (device sda2): __ext4_get_inode_loc:4749: inode #278058: block 1049570: comm find: unable to read itable block
[  202.593151] sd 0:0:0:0: [sda] Unhandled error code
[  202.593157] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.593164] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 59 70 00 00 08 00
[  202.593180] end_request: I/O error, dev sda, sector 12671344
[  202.593237] sd 0:0:0:0: [sda] Unhandled error code
[  202.593243] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.593250] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f f8 00 00 08 00
[  202.593266] end_request: I/O error, dev sda, sector 12668920
[  202.593333] sd 0:0:0:0: [sda] Unhandled error code
[  202.593339] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.593345] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 52 38 00 00 08 00
[  202.593362] end_request: I/O error, dev sda, sector 12669496
[  202.593461] sd 0:0:0:0: [sda] Unhandled error code
[  202.593467] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.593474] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e f8 00 00 08 00
[  202.593490] end_request: I/O error, dev sda, sector 12668664
[  202.593563] sd 0:0:0:0: [sda] Unhandled error code
[  202.593569] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.593575] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c0 57 08 00 00 f8 00
[  202.593591] end_request: I/O error, dev sda, sector 12605192
[  202.593602] sd 0:0:0:0: [sda] Unhandled error code
[  202.593607] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.593614] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c0 57 10 00 00 f0 00
[  202.593630] end_request: I/O error, dev sda, sector 12605200
[  202.593643] EXT4-fs (sda2): previous I/O error to superblock detected
[  202.593657] sd 0:0:0:0: [sda] Unhandled error code
[  202.593663] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.593669] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 40 38 00 00 00 08 00
[  202.593685] end_request: I/O error, dev sda, sector 4208640
[  202.593695] EXT4-fs error (device sda2): __ext4_get_inode_loc:4749: inode #278091: block 1049572: comm find: unable to read itable block
[  202.593753] sd 0:0:0:0: [sda] Unhandled error code
[  202.593759] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.593766] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 50 18 00 00 08 00
[  202.593785] end_request: I/O error, dev sda, sector 12668952
[  202.593872] sd 0:0:0:0: [sda] Unhandled error code
[  202.593878] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.593885] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e c8 00 00 08 00
[  202.593901] end_request: I/O error, dev sda, sector 12668616
[  202.594140] sd 0:0:0:0: [sda] Unhandled error code
[  202.594146] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.594153] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 5a 70 00 00 08 00
[  202.594168] end_request: I/O error, dev sda, sector 12671600
[  202.594226] sd 0:0:0:0: [sda] Unhandled error code
[  202.594232] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.594239] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e 38 00 00 08 00
[  202.594255] end_request: I/O error, dev sda, sector 12668472
[  202.594516] sd 0:0:0:0: [sda] Unhandled error code
[  202.594522] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.594529] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 50 d0 00 00 08 00
[  202.594544] end_request: I/O error, dev sda, sector 12669136
[  202.594623] sd 0:0:0:0: [sda] Unhandled error code
[  202.594628] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.594635] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 51 a8 00 00 08 00
[  202.594651] end_request: I/O error, dev sda, sector 12669352
[  202.595104] sd 0:0:0:0: [sda] Unhandled error code
[  202.595106] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.595108] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e f0 00 00 08 00
[  202.595112] end_request: I/O error, dev sda, sector 12668656
[  202.595169] sd 0:0:0:0: [sda] Unhandled error code
[  202.595171] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.595173] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e 78 00 00 08 00
[  202.595177] end_request: I/O error, dev sda, sector 12668536
[  202.595259] sd 0:0:0:0: [sda] Unhandled error code
[  202.595261] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.595263] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4e f8 00 00 08 00
[  202.595267] end_request: I/O error, dev sda, sector 16862968
[  202.595343] sd 0:0:0:0: [sda] Unhandled error code
[  202.595345] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.595346] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 50 68 00 00 08 00
[  202.595350] end_request: I/O error, dev sda, sector 12669032
[  202.595443] sd 0:0:0:0: [sda] Unhandled error code
[  202.595444] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.595446] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4e e8 00 00 08 00
[  202.595450] end_request: I/O error, dev sda, sector 16862952
[  202.595605] sd 0:0:0:0: [sda] Unhandled error code
[  202.595607] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.595609] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 50 d8 00 00 08 00
[  202.595612] end_request: I/O error, dev sda, sector 12669144
[  202.595780] sd 0:0:0:0: [sda] Unhandled error code
[  202.595781] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.595783] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 58 f0 00 00 08 00
[  202.595787] end_request: I/O error, dev sda, sector 12671216
[  202.596283] sd 0:0:0:0: [sda] Unhandled error code
[  202.596290] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.596297] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 5a a0 00 00 08 00
[  202.596312] end_request: I/O error, dev sda, sector 12671648
[  202.596428] sd 0:0:0:0: [sda] Unhandled error code
[  202.596434] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.596441] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f 58 00 00 08 00
[  202.596459] end_request: I/O error, dev sda, sector 12668760
[  202.597188] sd 0:0:0:0: [sda] Unhandled error code
[  202.597194] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.597201] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f f0 00 00 08 00
[  202.597218] end_request: I/O error, dev sda, sector 12668912
[  202.597883] sd 0:0:0:0: [sda] Unhandled error code
[  202.597889] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.597897] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 50 58 00 00 08 00
[  202.597913] end_request: I/O error, dev sda, sector 12669016
[  202.598121] sd 0:0:0:0: [sda] Unhandled error code
[  202.598127] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.598134] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 59 d0 00 00 08 00
[  202.598150] end_request: I/O error, dev sda, sector 12671440
[  202.598243] sd 0:0:0:0: [sda] Unhandled error code
[  202.598249] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.598256] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 5a 18 00 00 08 00
[  202.598272] end_request: I/O error, dev sda, sector 12671512
[  202.599086] sd 0:0:0:0: [sda] Unhandled error code
[  202.599092] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.599099] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 51 d8 00 00 08 00
[  202.599115] end_request: I/O error, dev sda, sector 12669400
[  202.599189] sd 0:0:0:0: [sda] Unhandled error code
[  202.599195] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.599202] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 52 a0 00 00 08 00
[  202.599218] end_request: I/O error, dev sda, sector 12669600
[  202.599294] sd 0:0:0:0: [sda] Unhandled error code
[  202.599299] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.599306] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 50 e0 00 00 08 00
[  202.599322] end_request: I/O error, dev sda, sector 12669152
[  202.599396] sd 0:0:0:0: [sda] Unhandled error code
[  202.599402] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.599409] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f 38 00 00 08 00
[  202.599424] end_request: I/O error, dev sda, sector 12668728
[  202.599479] sd 0:0:0:0: [sda] Unhandled error code
[  202.599485] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.599492] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 52 48 00 00 08 00
[  202.599507] end_request: I/O error, dev sda, sector 12669512
[  202.599574] sd 0:0:0:0: [sda] Unhandled error code
[  202.599579] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.599586] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 50 20 00 00 08 00
[  202.599602] end_request: I/O error, dev sda, sector 12668960
[  202.599683] sd 0:0:0:0: [sda] Unhandled error code
[  202.599688] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.599695] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 01 4e f0 00 00 08 00
[  202.599711] end_request: I/O error, dev sda, sector 16862960
[  202.599783] sd 0:0:0:0: [sda] Unhandled error code
[  202.599789] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.599796] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 5a e8 00 00 08 00
[  202.599811] end_request: I/O error, dev sda, sector 12671720
[  202.599899] sd 0:0:0:0: [sda] Unhandled error code
[  202.599904] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.599911] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e 58 00 00 08 00
[  202.599928] end_request: I/O error, dev sda, sector 12668504
[  202.599991] sd 0:0:0:0: [sda] Unhandled error code
[  202.599997] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.600008] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 52 a8 00 00 08 00
[  202.600025] end_request: I/O error, dev sda, sector 12669608
[  202.600149] sd 0:0:0:0: [sda] Unhandled error code
[  202.600155] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.600162] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4e 68 00 00 08 00
[  202.600178] end_request: I/O error, dev sda, sector 12668520
[  202.600234] sd 0:0:0:0: [sda] Unhandled error code
[  202.600240] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.600247] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 59 f8 00 00 08 00
[  202.600263] end_request: I/O error, dev sda, sector 12671480
[  202.600510] sd 0:0:0:0: [sda] Unhandled error code
[  202.600516] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.600522] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 5a 08 00 00 08 00
[  202.600538] end_request: I/O error, dev sda, sector 12671496
[  202.600592] sd 0:0:0:0: [sda] Unhandled error code
[  202.600598] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.600605] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 59 e0 00 00 08 00
[  202.600622] end_request: I/O error, dev sda, sector 12671456
[  202.600673] sd 0:0:0:0: [sda] Unhandled error code
[  202.600678] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.600685] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 51 e0 00 00 08 00
[  202.600701] end_request: I/O error, dev sda, sector 12669408
[  202.600817] sd 0:0:0:0: [sda] Unhandled error code
[  202.600823] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.600829] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f e0 00 00 08 00
[  202.600845] end_request: I/O error, dev sda, sector 12668896
[  202.601266] sd 0:0:0:0: [sda] Unhandled error code
[  202.601274] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.601282] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 50 10 00 00 08 00
[  202.601297] end_request: I/O error, dev sda, sector 12668944
[  202.601441] sd 0:0:0:0: [sda] Unhandled error code
[  202.601447] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.601454] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f 50 00 00 08 00
[  202.601469] end_request: I/O error, dev sda, sector 12668752
[  202.601567] sd 0:0:0:0: [sda] Unhandled error code
[  202.601572] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.601579] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f 78 00 00 08 00
[  202.601595] end_request: I/O error, dev sda, sector 12668792
[  202.602672] sd 0:0:0:0: [sda] Unhandled error code
[  202.602678] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.602685] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f 68 00 00 08 00
[  202.602701] end_request: I/O error, dev sda, sector 12668776
[  202.603109] sd 0:0:0:0: [sda] Unhandled error code
[  202.603115] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.603122] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f 98 00 00 08 00
[  202.603139] end_request: I/O error, dev sda, sector 12668824
[  202.603193] sd 0:0:0:0: [sda] Unhandled error code
[  202.603199] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.603206] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f 80 00 00 08 00
[  202.603222] end_request: I/O error, dev sda, sector 12668800
[  202.603360] sd 0:0:0:0: [sda] Unhandled error code
[  202.603366] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.603373] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 4f 88 00 00 08 00
[  202.603390] end_request: I/O error, dev sda, sector 12668808
[  202.604169] sd 0:0:0:0: [sda] Unhandled error code
[  202.604176] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.604183] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 54 d0 00 00 08 00
[  202.604199] end_request: I/O error, dev sda, sector 12670160
[  202.604235] sd 0:0:0:0: [sda] Unhandled error code
[  202.604241] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.604248] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 54 d0 00 00 08 00
[  202.604263] end_request: I/O error, dev sda, sector 12670160
[  202.604334] sd 0:0:0:0: [sda] Unhandled error code
[  202.604339] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.604346] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 c1 39 98 00 00 08 00
[  202.604362] end_request: I/O error, dev sda, sector 12663192
[  202.604583] sd 0:0:0:0: [sda] Unhandled error code
[  202.604589] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.604596] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 39 98 00 00 08 00
[  202.604612] end_request: I/O error, dev sda, sector 29440408
[  202.604660] sd 0:0:0:0: [sda] Unhandled error code
[  202.604666] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.604673] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3f 60 00 00 08 00
[  202.604689] end_request: I/O error, dev sda, sector 33636192
[  202.604742] sd 0:0:0:0: [sda] Unhandled error code
[  202.604748] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.604755] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 47 b8 00 00 08 00
[  202.604770] end_request: I/O error, dev sda, sector 29444024
[  202.604828] sd 0:0:0:0: [sda] Unhandled error code
[  202.604834] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.604841] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 41 58 00 00 08 00
[  202.604856] end_request: I/O error, dev sda, sector 33636696
[  202.605476] sd 0:0:0:0: [sda] Unhandled error code
[  202.605482] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.605489] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 46 28 00 00 08 00
[  202.605504] end_request: I/O error, dev sda, sector 29443624
[  202.606927] sd 0:0:0:0: [sda] Unhandled error code
[  202.606933] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.606940] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 47 b0 00 00 08 00
[  202.606956] end_request: I/O error, dev sda, sector 29444016
[  202.607226] sd 0:0:0:0: [sda] Unhandled error code
[  202.607232] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.607239] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3d 70 00 00 08 00
[  202.607255] end_request: I/O error, dev sda, sector 33635696
[  202.608086] sd 0:0:0:0: [sda] Unhandled error code
[  202.608092] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.608099] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 47 a0 00 00 08 00
[  202.608115] end_request: I/O error, dev sda, sector 29444000
[  202.608168] sd 0:0:0:0: [sda] Unhandled error code
[  202.608174] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.608181] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 47 90 00 00 08 00
[  202.608197] end_request: I/O error, dev sda, sector 29443984
[  202.608268] sd 0:0:0:0: [sda] Unhandled error code
[  202.608274] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.608281] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 46 f8 00 00 08 00
[  202.608297] end_request: I/O error, dev sda, sector 29443832
[  202.608378] sd 0:0:0:0: [sda] Unhandled error code
[  202.608384] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.608391] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3d 68 00 00 08 00
[  202.608406] end_request: I/O error, dev sda, sector 33635688
[  202.608847] sd 0:0:0:0: [sda] Unhandled error code
[  202.608853] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.608860] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 46 e8 00 00 08 00
[  202.608877] end_request: I/O error, dev sda, sector 29443816
[  202.608951] sd 0:0:0:0: [sda] Unhandled error code
[  202.608958] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.608964] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 47 a8 00 00 08 00
[  202.608980] end_request: I/O error, dev sda, sector 29444008
[  202.609266] sd 0:0:0:0: [sda] Unhandled error code
[  202.609272] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.609279] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 46 78 00 00 08 00
[  202.609297] end_request: I/O error, dev sda, sector 29443704
[  202.609741] sd 0:0:0:0: [sda] Unhandled error code
[  202.609748] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.609755] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 46 80 00 00 08 00
[  202.609771] end_request: I/O error, dev sda, sector 29443712
[  202.609899] sd 0:0:0:0: [sda] Unhandled error code
[  202.609904] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.609912] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3e 38 00 00 08 00
[  202.609927] end_request: I/O error, dev sda, sector 33635896
[  202.610468] sd 0:0:0:0: [sda] Unhandled error code
[  202.610474] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.610481] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3f e8 00 00 08 00
[  202.610497] end_request: I/O error, dev sda, sector 33636328
[  202.611181] sd 0:0:0:0: [sda] Unhandled error code
[  202.611192] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.611200] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 46 a8 00 00 08 00
[  202.611215] end_request: I/O error, dev sda, sector 29443752
[  202.612086] sd 0:0:0:0: [sda] Unhandled error code
[  202.612092] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.612099] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 46 b0 00 00 08 00
[  202.612115] end_request: I/O error, dev sda, sector 29443760
[  202.612177] sd 0:0:0:0: [sda] Unhandled error code
[  202.612183] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.612190] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 46 70 00 00 08 00
[  202.612206] end_request: I/O error, dev sda, sector 29443696
[  202.612300] sd 0:0:0:0: [sda] Unhandled error code
[  202.612306] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.612313] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 39 d0 00 00 08 00
[  202.612329] end_request: I/O error, dev sda, sector 29440464
[  202.612380] sd 0:0:0:0: [sda] Unhandled error code
[  202.612385] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.612392] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 46 08 00 00 08 00
[  202.612407] end_request: I/O error, dev sda, sector 29443592
[  202.612594] sd 0:0:0:0: [sda] Unhandled error code
[  202.612600] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.612607] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 43 98 00 00 08 00
[  202.612622] end_request: I/O error, dev sda, sector 29442968
[  202.612676] sd 0:0:0:0: [sda] Unhandled error code
[  202.612682] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.612689] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 46 10 00 00 08 00
[  202.612705] end_request: I/O error, dev sda, sector 29443600
[  202.612755] sd 0:0:0:0: [sda] Unhandled error code
[  202.612760] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.612769] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 45 f0 00 00 08 00
[  202.612784] end_request: I/O error, dev sda, sector 29443568
[  202.612841] sd 0:0:0:0: [sda] Unhandled error code
[  202.612846] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.612853] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 43 90 00 00 08 00
[  202.612868] end_request: I/O error, dev sda, sector 29442960
[  202.612996] sd 0:0:0:0: [sda] Unhandled error code
[  202.613006] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.613013] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3f c0 00 00 08 00
[  202.613030] end_request: I/O error, dev sda, sector 33636288
[  202.613210] sd 0:0:0:0: [sda] Unhandled error code
[  202.613216] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.613223] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 42 f8 00 00 08 00
[  202.613239] end_request: I/O error, dev sda, sector 29442808
[  202.613442] sd 0:0:0:0: [sda] Unhandled error code
[  202.613448] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.613455] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 43 00 00 00 08 00
[  202.613471] end_request: I/O error, dev sda, sector 29442816
[  202.613526] sd 0:0:0:0: [sda] Unhandled error code
[  202.613531] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.613538] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 42 d8 00 00 08 00
[  202.613555] end_request: I/O error, dev sda, sector 29442776
[  202.614168] sd 0:0:0:0: [sda] Unhandled error code
[  202.614175] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.614182] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 39 a8 00 00 08 00
[  202.614197] end_request: I/O error, dev sda, sector 29440424
[  202.614597] sd 0:0:0:0: [sda] Unhandled error code
[  202.614603] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.614610] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 43 80 00 00 08 00
[  202.614625] end_request: I/O error, dev sda, sector 29442944
[  202.616196] sd 0:0:0:0: [sda] Unhandled error code
[  202.616202] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.616209] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 43 50 00 00 08 00
[  202.616225] end_request: I/O error, dev sda, sector 29442896
[  202.616731] sd 0:0:0:0: [sda] Unhandled error code
[  202.616737] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.616744] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 43 20 00 00 08 00
[  202.616760] end_request: I/O error, dev sda, sector 29442848
[  202.616890] sd 0:0:0:0: [sda] Unhandled error code
[  202.616896] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.616903] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3f 98 00 00 08 00
[  202.616919] end_request: I/O error, dev sda, sector 33636248
[  202.616976] sd 0:0:0:0: [sda] Unhandled error code
[  202.616982] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.616989] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 43 10 00 00 08 00
[  202.617010] end_request: I/O error, dev sda, sector 29442832
[  202.617102] sd 0:0:0:0: [sda] Unhandled error code
[  202.617108] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.617115] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 49 18 00 00 08 00
[  202.617131] end_request: I/O error, dev sda, sector 29444376
[  202.617230] sd 0:0:0:0: [sda] Unhandled error code
[  202.617236] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.617243] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 70 00 00 08 00
[  202.617258] end_request: I/O error, dev sda, sector 29444208
[  202.617403] sd 0:0:0:0: [sda] Unhandled error code
[  202.617409] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.617416] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 47 e0 00 00 08 00
[  202.617432] end_request: I/O error, dev sda, sector 29444064
[  202.617534] sd 0:0:0:0: [sda] Unhandled error code
[  202.617540] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.617547] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 b0 00 00 08 00
[  202.617562] end_request: I/O error, dev sda, sector 29444272
[  202.618078] sd 0:0:0:0: [sda] Unhandled error code
[  202.618084] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.618091] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 08 00 00 08 00
[  202.618107] end_request: I/O error, dev sda, sector 29444104
[  202.618189] sd 0:0:0:0: [sda] Unhandled error code
[  202.618195] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.618202] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 80 00 00 08 00
[  202.618218] end_request: I/O error, dev sda, sector 29444224
[  202.618304] sd 0:0:0:0: [sda] Unhandled error code
[  202.618310] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.618317] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 98 00 00 08 00
[  202.618333] end_request: I/O error, dev sda, sector 29444248
[  202.618384] sd 0:0:0:0: [sda] Unhandled error code
[  202.618389] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.618396] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 90 00 00 08 00
[  202.618414] end_request: I/O error, dev sda, sector 29444240
[  202.618473] sd 0:0:0:0: [sda] Unhandled error code
[  202.618479] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.618485] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 20 00 00 08 00
[  202.618501] end_request: I/O error, dev sda, sector 29444128
[  202.618575] sd 0:0:0:0: [sda] Unhandled error code
[  202.618581] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.618588] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 88 00 00 08 00
[  202.618603] end_request: I/O error, dev sda, sector 29444232
[  202.618653] sd 0:0:0:0: [sda] Unhandled error code
[  202.618659] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.618667] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 47 c8 00 00 08 00
[  202.618682] end_request: I/O error, dev sda, sector 29444040
[  202.618861] sd 0:0:0:0: [sda] Unhandled error code
[  202.618866] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.618873] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3e 30 00 00 08 00
[  202.618889] end_request: I/O error, dev sda, sector 33635888
[  202.618969] sd 0:0:0:0: [sda] Unhandled error code
[  202.618974] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.618981] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 38 00 00 08 00
[  202.618997] end_request: I/O error, dev sda, sector 29444152
[  202.619147] sd 0:0:0:0: [sda] Unhandled error code
[  202.619153] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.619160] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 3a 08 00 00 08 00
[  202.619177] end_request: I/O error, dev sda, sector 29440520
[  202.619657] sd 0:0:0:0: [sda] Unhandled error code
[  202.619664] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.619671] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 5a 20 00 00 08 00
[  202.619687] end_request: I/O error, dev sda, sector 29448736
[  202.619739] sd 0:0:0:0: [sda] Unhandled error code
[  202.619745] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.619751] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 b8 00 00 08 00
[  202.619767] end_request: I/O error, dev sda, sector 29444280
[  202.621260] sd 0:0:0:0: [sda] Unhandled error code
[  202.621266] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.621273] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 5a c0 00 00 08 00
[  202.621289] end_request: I/O error, dev sda, sector 29448896
[  202.621478] sd 0:0:0:0: [sda] Unhandled error code
[  202.621484] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.621490] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 5a 78 00 00 08 00
[  202.621506] end_request: I/O error, dev sda, sector 29448824
[  202.622232] sd 0:0:0:0: [sda] Unhandled error code
[  202.622239] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.622246] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 f0 00 00 08 00
[  202.622262] end_request: I/O error, dev sda, sector 29444336
[  202.622386] sd 0:0:0:0: [sda] Unhandled error code
[  202.622392] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.622399] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 e0 00 00 08 00
[  202.622414] end_request: I/O error, dev sda, sector 29444320
[  202.622472] sd 0:0:0:0: [sda] Unhandled error code
[  202.622478] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.622485] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 e8 00 00 08 00
[  202.622501] end_request: I/O error, dev sda, sector 29444328
[  202.622637] sd 0:0:0:0: [sda] Unhandled error code
[  202.622643] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.622650] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 f8 00 00 08 00
[  202.622666] end_request: I/O error, dev sda, sector 29444344
[  202.622719] sd 0:0:0:0: [sda] Unhandled error code
[  202.622725] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.622732] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 60 00 00 08 00
[  202.622748] end_request: I/O error, dev sda, sector 29444192
[  202.623100] sd 0:0:0:0: [sda] Unhandled error code
[  202.623106] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.623113] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 c1 48 78 00 00 08 00
[  202.623129] end_request: I/O error, dev sda, sector 29444216
[  202.623257] sd 0:0:0:0: [sda] Unhandled error code
[  202.623263] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.623270] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 81 39 98 00 00 08 00
[  202.623286] end_request: I/O error, dev sda, sector 8468888
[  202.846538] sd 0:0:0:0: [sda] Unhandled error code
[  202.846549] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.846557] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 81 39 a0 00 00 08 00
[  202.846576] end_request: I/O error, dev sda, sector 42023328
[  202.850484] sd 0:0:0:0: [sda] Unhandled error code
[  202.850491] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.850499] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3e f8 00 00 08 00
[  202.850516] end_request: I/O error, dev sda, sector 33636088
[  202.850575] sd 0:0:0:0: [sda] Unhandled error code
[  202.850580] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.850588] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3f 70 00 00 08 00
[  202.850606] end_request: I/O error, dev sda, sector 33636208
[  202.850656] sd 0:0:0:0: [sda] Unhandled error code
[  202.850661] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.850670] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 41 68 00 00 08 00
[  202.850687] end_request: I/O error, dev sda, sector 33636712
[  202.850747] sd 0:0:0:0: [sda] Unhandled error code
[  202.850752] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.850760] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 3f 68 00 00 08 00
[  202.850776] end_request: I/O error, dev sda, sector 33636200
[  202.850827] sd 0:0:0:0: [sda] Unhandled error code
[  202.850833] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.850840] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 01 39 a0 00 00 08 00
[  202.850855] end_request: I/O error, dev sda, sector 33634720
[  202.852202] sd 0:0:0:0: [sda] Unhandled error code
[  202.852208] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.852215] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3f 60 00 00 08 00
[  202.852231] end_request: I/O error, dev sda, sector 37830496
[  202.852292] sd 0:0:0:0: [sda] Unhandled error code
[  202.852298] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.852305] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3f 28 00 00 08 00
[  202.852321] end_request: I/O error, dev sda, sector 37830440
[  202.852377] sd 0:0:0:0: [sda] Unhandled error code
[  202.852383] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.852390] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c 38 00 00 08 00
[  202.852405] end_request: I/O error, dev sda, sector 37829688
[  202.852466] sd 0:0:0:0: [sda] Unhandled error code
[  202.852471] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.852478] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c 48 00 00 08 00
[  202.852494] end_request: I/O error, dev sda, sector 37829704
[  202.852720] sd 0:0:0:0: [sda] Unhandled error code
[  202.852726] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.852733] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3f 40 00 00 08 00
[  202.852748] end_request: I/O error, dev sda, sector 37830464
[  202.852814] sd 0:0:0:0: [sda] Unhandled error code
[  202.852820] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.852826] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3e c0 00 00 08 00
[  202.852842] end_request: I/O error, dev sda, sector 37830336
[  202.852892] sd 0:0:0:0: [sda] Unhandled error code
[  202.852898] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.852905] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3f 68 00 00 08 00
[  202.852921] end_request: I/O error, dev sda, sector 37830504
[  202.852984] sd 0:0:0:0: [sda] Unhandled error code
[  202.852990] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.852997] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b 60 00 00 08 00
[  202.853017] end_request: I/O error, dev sda, sector 37829472
[  202.854495] sd 0:0:0:0: [sda] Unhandled error code
[  202.854506] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.854514] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a 30 00 00 08 00
[  202.854529] end_request: I/O error, dev sda, sector 37829168
[  202.854701] sd 0:0:0:0: [sda] Unhandled error code
[  202.854707] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.854714] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 39 f0 00 00 08 00
[  202.854730] end_request: I/O error, dev sda, sector 37829104
[  202.854801] sd 0:0:0:0: [sda] Unhandled error code
[  202.854807] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.854814] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c e8 00 00 08 00
[  202.854830] end_request: I/O error, dev sda, sector 37829864
[  202.854971] sd 0:0:0:0: [sda] Unhandled error code
[  202.854977] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.854984] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b 18 00 00 08 00
[  202.855006] end_request: I/O error, dev sda, sector 37829400
[  202.856490] sd 0:0:0:0: [sda] Unhandled error code
[  202.856497] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.856504] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b 00 00 00 08 00
[  202.856520] end_request: I/O error, dev sda, sector 37829376
[  202.856670] sd 0:0:0:0: [sda] Unhandled error code
[  202.856676] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.856683] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b 20 00 00 08 00
[  202.856700] end_request: I/O error, dev sda, sector 37829408
[  202.856801] sd 0:0:0:0: [sda] Unhandled error code
[  202.856807] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.856813] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 42 88 00 00 08 00
[  202.856830] end_request: I/O error, dev sda, sector 37831304
[  202.856886] sd 0:0:0:0: [sda] Unhandled error code
[  202.856891] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.856898] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 42 f0 00 00 08 00
[  202.856914] end_request: I/O error, dev sda, sector 37831408
[  202.858290] sd 0:0:0:0: [sda] Unhandled error code
[  202.858297] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.858304] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a 68 00 00 08 00
[  202.858319] end_request: I/O error, dev sda, sector 37829224
[  202.858380] sd 0:0:0:0: [sda] Unhandled error code
[  202.858385] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.858392] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 42 70 00 00 08 00
[  202.858409] end_request: I/O error, dev sda, sector 37831280
[  202.858462] sd 0:0:0:0: [sda] Unhandled error code
[  202.858467] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.858474] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a 40 00 00 08 00
[  202.858489] end_request: I/O error, dev sda, sector 37829184
[  202.858600] sd 0:0:0:0: [sda] Unhandled error code
[  202.858605] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.858612] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a 50 00 00 08 00
[  202.858628] end_request: I/O error, dev sda, sector 37829200
[  202.858679] sd 0:0:0:0: [sda] Unhandled error code
[  202.858685] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.858691] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a 58 00 00 08 00
[  202.858707] end_request: I/O error, dev sda, sector 37829208
[  202.858759] sd 0:0:0:0: [sda] Unhandled error code
[  202.858765] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.858772] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a 98 00 00 08 00
[  202.858789] end_request: I/O error, dev sda, sector 37829272
[  202.858844] sd 0:0:0:0: [sda] Unhandled error code
[  202.858850] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.858857] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a 48 00 00 08 00
[  202.858872] end_request: I/O error, dev sda, sector 37829192
[  202.858923] sd 0:0:0:0: [sda] Unhandled error code
[  202.858928] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.858936] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a 88 00 00 08 00
[  202.858952] end_request: I/O error, dev sda, sector 37829256
[  202.861353] sd 0:0:0:0: [sda] Unhandled error code
[  202.861360] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.861367] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b 88 00 00 08 00
[  202.861383] end_request: I/O error, dev sda, sector 37829512
[  202.861443] sd 0:0:0:0: [sda] Unhandled error code
[  202.861449] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.861456] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3d 20 00 00 08 00
[  202.861471] end_request: I/O error, dev sda, sector 37829920
[  202.861558] sd 0:0:0:0: [sda] Unhandled error code
[  202.861564] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.861571] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c c8 00 00 08 00
[  202.861588] end_request: I/O error, dev sda, sector 37829832
[  202.861647] sd 0:0:0:0: [sda] Unhandled error code
[  202.861653] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.861660] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 42 f8 00 00 08 00
[  202.861675] end_request: I/O error, dev sda, sector 37831416
[  202.861776] sd 0:0:0:0: [sda] Unhandled error code
[  202.861782] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.861789] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c d8 00 00 08 00
[  202.861804] end_request: I/O error, dev sda, sector 37829848
[  202.861887] sd 0:0:0:0: [sda] Unhandled error code
[  202.861892] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.861899] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3d 00 00 00 08 00
[  202.861915] end_request: I/O error, dev sda, sector 37829888
[  202.863777] sd 0:0:0:0: [sda] Unhandled error code
[  202.863783] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.863790] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 42 b0 00 00 08 00
[  202.863807] end_request: I/O error, dev sda, sector 37831344
[  202.863910] sd 0:0:0:0: [sda] Unhandled error code
[  202.863916] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.863923] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c 90 00 00 08 00
[  202.863939] end_request: I/O error, dev sda, sector 37829776
[  202.864714] sd 0:0:0:0: [sda] Unhandled error code
[  202.864721] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.864728] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b e0 00 00 08 00
[  202.864744] end_request: I/O error, dev sda, sector 37829600
[  202.864802] sd 0:0:0:0: [sda] Unhandled error code
[  202.864807] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.864814] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3d 10 00 00 08 00
[  202.864830] end_request: I/O error, dev sda, sector 37829904
[  202.864891] sd 0:0:0:0: [sda] Unhandled error code
[  202.864896] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.864903] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a b0 00 00 08 00
[  202.864919] end_request: I/O error, dev sda, sector 37829296
[  202.865006] sd 0:0:0:0: [sda] Unhandled error code
[  202.865012] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.865019] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a b8 00 00 08 00
[  202.865035] end_request: I/O error, dev sda, sector 37829304
[  202.866306] sd 0:0:0:0: [sda] Unhandled error code
[  202.866312] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.866319] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3f 20 00 00 08 00
[  202.866336] end_request: I/O error, dev sda, sector 37830432
[  202.866443] sd 0:0:0:0: [sda] Unhandled error code
[  202.866449] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.866456] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c 40 00 00 08 00
[  202.866472] end_request: I/O error, dev sda, sector 37829696
[  202.866593] sd 0:0:0:0: [sda] Unhandled error code
[  202.866599] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.866606] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b c0 00 00 08 00
[  202.866621] end_request: I/O error, dev sda, sector 37829568
[  202.866672] sd 0:0:0:0: [sda] Unhandled error code
[  202.866678] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.866685] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b c8 00 00 08 00
[  202.866701] end_request: I/O error, dev sda, sector 37829576
[  202.866751] sd 0:0:0:0: [sda] Unhandled error code
[  202.866757] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.866764] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b b8 00 00 08 00
[  202.866779] end_request: I/O error, dev sda, sector 37829560
[  202.866960] sd 0:0:0:0: [sda] Unhandled error code
[  202.866966] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.866973] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 39 88 00 00 08 00
[  202.866989] end_request: I/O error, dev sda, sector 37829000
[  202.867635] sd 0:0:0:0: [sda] Unhandled error code
[  202.867641] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.867648] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b 48 00 00 08 00
[  202.867664] end_request: I/O error, dev sda, sector 37829448
[  202.867723] sd 0:0:0:0: [sda] Unhandled error code
[  202.867729] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.867736] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 42 58 00 00 08 00
[  202.867752] end_request: I/O error, dev sda, sector 37831256
[  202.867870] sd 0:0:0:0: [sda] Unhandled error code
[  202.867878] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.867884] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c a0 00 00 08 00
[  202.867900] end_request: I/O error, dev sda, sector 37829792
[  202.868891] sd 0:0:0:0: [sda] Unhandled error code
[  202.868898] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.868904] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 42 68 00 00 08 00
[  202.868921] end_request: I/O error, dev sda, sector 37831272
[  202.869079] sd 0:0:0:0: [sda] Unhandled error code
[  202.869085] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.869092] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c 30 00 00 08 00
[  202.869108] end_request: I/O error, dev sda, sector 37829680
[  202.869201] sd 0:0:0:0: [sda] Unhandled error code
[  202.869207] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.869214] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3f 30 00 00 08 00
[  202.869230] end_request: I/O error, dev sda, sector 37830448
[  202.870085] sd 0:0:0:0: [sda] Unhandled error code
[  202.870092] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.870099] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a 08 00 00 08 00
[  202.870115] end_request: I/O error, dev sda, sector 37829128
[  202.870173] sd 0:0:0:0: [sda] Unhandled error code
[  202.870179] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.870185] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 42 90 00 00 08 00
[  202.870201] end_request: I/O error, dev sda, sector 37831312
[  202.870288] sd 0:0:0:0: [sda] Unhandled error code
[  202.870295] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.870302] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 39 98 00 00 08 00
[  202.870318] end_request: I/O error, dev sda, sector 37829016
[  202.870606] sd 0:0:0:0: [sda] Unhandled error code
[  202.870612] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.870619] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3e a8 00 00 08 00
[  202.870634] end_request: I/O error, dev sda, sector 37830312
[  202.870694] sd 0:0:0:0: [sda] Unhandled error code
[  202.870700] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.870707] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b 40 00 00 08 00
[  202.870722] end_request: I/O error, dev sda, sector 37829440
[  202.870825] sd 0:0:0:0: [sda] Unhandled error code
[  202.870831] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.870838] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 42 80 00 00 08 00
[  202.870854] end_request: I/O error, dev sda, sector 37831296
[  202.871080] sd 0:0:0:0: [sda] Unhandled error code
[  202.871086] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.871093] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c f0 00 00 08 00
[  202.871110] end_request: I/O error, dev sda, sector 37829872
[  202.871170] sd 0:0:0:0: [sda] Unhandled error code
[  202.871176] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.871183] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b 30 00 00 08 00
[  202.871199] end_request: I/O error, dev sda, sector 37829424
[  202.871981] sd 0:0:0:0: [sda] Unhandled error code
[  202.871988] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.871995] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3d 28 00 00 08 00
[  202.872017] end_request: I/O error, dev sda, sector 37829928
[  202.872255] sd 0:0:0:0: [sda] Unhandled error code
[  202.872261] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.872268] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 39 c8 00 00 08 00
[  202.872285] end_request: I/O error, dev sda, sector 37829064
[  202.873365] sd 0:0:0:0: [sda] Unhandled error code
[  202.873371] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.873378] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 39 b8 00 00 08 00
[  202.873394] end_request: I/O error, dev sda, sector 37829048
[  202.873449] sd 0:0:0:0: [sda] Unhandled error code
[  202.873455] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.873461] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3d 48 00 00 08 00
[  202.873477] end_request: I/O error, dev sda, sector 37829960
[  202.873530] sd 0:0:0:0: [sda] Unhandled error code
[  202.873535] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.873542] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3b d8 00 00 08 00
[  202.873558] end_request: I/O error, dev sda, sector 37829592
[  202.873613] sd 0:0:0:0: [sda] Unhandled error code
[  202.873621] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.873628] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c 80 00 00 08 00
[  202.873646] end_request: I/O error, dev sda, sector 37829760
[  202.873706] sd 0:0:0:0: [sda] Unhandled error code
[  202.873712] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.873719] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 39 d0 00 00 08 00
[  202.873734] end_request: I/O error, dev sda, sector 37829072
[  202.876774] sd 0:0:0:0: [sda] Unhandled error code
[  202.876780] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.876787] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3e 88 00 00 08 00
[  202.876805] end_request: I/O error, dev sda, sector 37830280
[  202.877685] sd 0:0:0:0: [sda] Unhandled error code
[  202.877692] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.877699] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3e 80 00 00 08 00
[  202.877716] end_request: I/O error, dev sda, sector 37830272
[  202.879323] sd 0:0:0:0: [sda] Unhandled error code
[  202.879330] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.879337] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a d8 00 00 08 00
[  202.879353] end_request: I/O error, dev sda, sector 37829336
[  202.880194] sd 0:0:0:0: [sda] Unhandled error code
[  202.880200] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.880207] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 42 50 00 00 08 00
[  202.880224] end_request: I/O error, dev sda, sector 37831248
[  202.880279] sd 0:0:0:0: [sda] Unhandled error code
[  202.880286] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.880293] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3d 50 00 00 08 00
[  202.880308] end_request: I/O error, dev sda, sector 37829968
[  202.880365] sd 0:0:0:0: [sda] Unhandled error code
[  202.880371] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.880378] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c 60 00 00 08 00
[  202.880394] end_request: I/O error, dev sda, sector 37829728
[  202.880447] sd 0:0:0:0: [sda] Unhandled error code
[  202.880453] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.880460] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3e 38 00 00 08 00
[  202.880476] end_request: I/O error, dev sda, sector 37830200
[  202.880592] sd 0:0:0:0: [sda] Unhandled error code
[  202.880598] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.880605] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3a 00 00 00 08 00
[  202.880620] end_request: I/O error, dev sda, sector 37829120
[  202.880696] sd 0:0:0:0: [sda] Unhandled error code
[  202.880701] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.880708] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c 18 00 00 08 00
[  202.880724] end_request: I/O error, dev sda, sector 37829656
[  202.880790] sd 0:0:0:0: [sda] Unhandled error code
[  202.880796] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.880802] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 02 41 3c 10 00 00 08 00
[  202.880818] end_request: I/O error, dev sda, sector 37829648
[  202.880899] sd 0:0:0:0: [sda] Unhandled error code
[  202.880905] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.880912] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 39 80 00 00 08 00
[  202.880928] end_request: I/O error, dev sda, sector 21051776
[  202.880998] sd 0:0:0:0: [sda] Unhandled error code
[  202.881008] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.881015] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 41 59 90 00 00 60 00
[  202.881032] end_request: I/O error, dev sda, sector 4282768
[  202.881212] EXT4-fs (sda2): previous I/O error to superblock detected
[  202.881229] sd 0:0:0:0: [sda] Unhandled error code
[  202.881235] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.881242] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 40 38 00 00 00 08 00
[  202.881258] end_request: I/O error, dev sda, sector 4208640
[  202.881269] EXT4-fs error (device sda2): ext4_readdir:157: inode #11: comm find: directory contains a hole at offset 0
[  202.881294] sd 0:0:0:0: [sda] Unhandled error code
[  202.881299] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.881306] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 41 59 98 00 00 08 00
[  202.881322] end_request: I/O error, dev sda, sector 4282776
[  202.881339] sd 0:0:0:0: [sda] Unhandled error code
[  202.881345] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.881351] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 41 59 a0 00 00 08 00
[  202.881367] end_request: I/O error, dev sda, sector 4282784
[  202.881384] sd 0:0:0:0: [sda] Unhandled error code
[  202.881389] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.881396] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 00 41 59 a8 00 00 08 00
[  202.881411] end_request: I/O error, dev sda, sector 4282792
[  202.881945] sd 0:0:0:0: [sda] Unhandled error code
[  202.881951] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.881958] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 39 90 00 00 08 00
[  202.881973] end_request: I/O error, dev sda, sector 21051792
[  202.883166] sd 0:0:0:0: [sda] Unhandled error code
[  202.883173] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.883180] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 39 e8 00 00 08 00
[  202.883196] end_request: I/O error, dev sda, sector 21051880
[  202.920893] sd 0:0:0:0: [sda] Unhandled error code
[  202.920901] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.920908] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 3a 88 00 00 08 00
[  202.920924] end_request: I/O error, dev sda, sector 21052040
[  202.921559] sd 0:0:0:0: [sda] Unhandled error code
[  202.921565] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.921573] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 3a a0 00 00 08 00
[  202.921588] end_request: I/O error, dev sda, sector 21052064
[  202.921770] sd 0:0:0:0: [sda] Unhandled error code
[  202.921775] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.921783] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 39 d0 00 00 08 00
[  202.921798] end_request: I/O error, dev sda, sector 21051856
[  202.921859] sd 0:0:0:0: [sda] Unhandled error code
[  202.921865] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.921872] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 58 c8 00 00 08 00
[  202.921890] end_request: I/O error, dev sda, sector 21059784
[  202.921949] sd 0:0:0:0: [sda] Unhandled error code
[  202.921955] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.921962] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 58 e8 00 00 08 00
[  202.921977] end_request: I/O error, dev sda, sector 21059816
[  202.922903] sd 0:0:0:0: [sda] Unhandled error code
[  202.922910] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.922917] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 39 f8 00 00 08 00
[  202.922933] end_request: I/O error, dev sda, sector 21051896
[  202.923557] sd 0:0:0:0: [sda] Unhandled error code
[  202.923563] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.923570] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 39 a0 00 00 08 00
[  202.923586] end_request: I/O error, dev sda, sector 21051808
[  202.923668] sd 0:0:0:0: [sda] Unhandled error code
[  202.923674] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.923681] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 39 d8 00 00 08 00
[  202.923696] end_request: I/O error, dev sda, sector 21051864
[  202.924817] sd 0:0:0:0: [sda] Unhandled error code
[  202.924823] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.924830] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 3a 08 00 00 08 00
[  202.924847] end_request: I/O error, dev sda, sector 21051912
[  202.924968] sd 0:0:0:0: [sda] Unhandled error code
[  202.924974] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  202.924981] sd 0:0:0:0: [sda] CDB: Read(10): 28 00 01 41 3a 30 00 00 08 00
[  202.924997] end_request: I/O error, dev sda, sector 21051952
tmp199:~ #

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
