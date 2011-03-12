From: Peter <elekesp@freemail.hu>
Subject: Re: sata problem...
Date: Sat, 12 Mar 2011 21:33:17 +0100
Message-ID: <E0ABD6B5-3B05-48D8-AFDC-9FD559AF2583@freemail.hu>
References: <04BB68BD-352B-45B0-A7FC-42B6005A80B3@freemail.hu> <20110227153338.GA23527@mtj.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay01.digicable.hu ([92.249.128.189]:46797 "EHLO
	relay01.digicable.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab1CLVSD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Mar 2011 16:18:03 -0500
In-Reply-To: <20110227153338.GA23527@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi!

Motherboard is
GIGABYTE GA-D510UD

dmesg:
dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.35-25-generic (buildd@crested) (gcc version 4.4.5 (Ubuntu/Linaro 4.4.4-14ubuntu5) ) #44-Ubuntu SMP Fri Jan 21 17:40:44 UTC 2011 (Ubuntu 2.6.35-25.44-generic 2.6.35.10)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-2.6.35-25-generic root=UUID=5405184f-bd88-4bef-b11c-3afe030a69f3 ro quiet splash
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003f5e0000 (usable)
[    0.000000]  BIOS-e820: 000000003f5e0000 - 000000003f5e3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003f5e3000 - 000000003f5f0000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003f5f0000 - 000000003f600000 (reserved)
[    0.000000]  BIOS-e820: 00000000c0000000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.4 present.
[    0.000000] e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x3f5e0 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CCFFF write-protect
[    0.000000]   CD000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 base 03F800000 mask FFF800000 uncachable
[    0.000000]   2 base 03F700000 mask FFFF00000 uncachable
[    0.000000]   3 base 03F600000 mask FFFF00000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 0000000000001000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009f800 (usable)
[    0.000000]  modified: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 000000003f5e0000 (usable)
[    0.000000]  modified: 000000003f5e0000 - 000000003f5e3000 (ACPI NVS)
[    0.000000]  modified: 000000003f5e3000 - 000000003f5f0000 (ACPI data)
[    0.000000]  modified: 000000003f5f0000 - 000000003f600000 (reserved)
[    0.000000]  modified: 00000000c0000000 - 00000000d0000000 (reserved)
[    0.000000]  modified: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] found SMP MP-table at [ffff8800000f48c0] f48c0
[    0.000000] init_memory_mapping: 0000000000000000-000000003f5e0000
[    0.000000]  0000000000 - 003f400000 page 2M
[    0.000000]  003f400000 - 003f5e0000 page 4k
[    0.000000] kernel direct mapping tables up to 3f5e0000 @ 16000-19000
[    0.000000] RAMDISK: 2edf1000 - 2f8a8000
[    0.000000] ACPI: RSDP 00000000000f62d0 00014 (v00 GBT   )
[    0.000000] ACPI: RSDT 000000003f5e3040 00034 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: FACP 000000003f5e30c0 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: DSDT 000000003f5e3180 04F6E (v01 GBT    GBTUACPI 00001000 MSFT 0100000C)
[    0.000000] ACPI: FACS 000000003f5e0000 00040
[    0.000000] ACPI: MCFG 000000003f5e82c0 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: TAMG 000000003f5e8300 062E2 (v01 GBT    GBT   B0 5455312E BG?? 00020101)
[    0.000000] ACPI: APIC 000000003f5e8140 00084 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000003f5e0000
[    0.000000] Initmem setup node 0 0000000000000000-000000003f5e0000
[    0.000000]   NODE_DATA [0000000001d18100 - 0000000001d1d0ff]
[    0.000000]  [ffffea0000000000-ffffea0000dfffff] PMD -> [ffff880002600000-ffff8800033fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   empty
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0003f5e0
[    0.000000] On node 0 totalpages: 259439
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3927 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 3493 pages used for memmap
[    0.000000]   DMA32 zone: 251963 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] early_res array is doubled to 64 at [17000 - 177ff]
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 3f600000 (gap: 3f600000:80a00000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 30 pages/cpu @ffff880001e00000 s91520 r8192 d23168 u524288
[    0.000000] pcpu-alloc: s91520 r8192 d23168 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 255890
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-2.6.35-25-generic root=UUID=5405184f-bd88-4bef-b11c-3afe030a69f3 ro quiet splash
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Subtract (47 early reservations)
[    0.000000]   #1 [0001000000 - 0001d17114]   TEXT DATA BSS
[    0.000000]   #2 [002edf1000 - 002f8a8000]         RAMDISK
[    0.000000]   #3 [0001d18000 - 0001d180ee]             BRK
[    0.000000]   #4 [00000f48d0 - 0000100000]   BIOS reserved
[    0.000000]   #5 [00000f48c0 - 00000f48d0]    MP-table mpf
[    0.000000]   #6 [000009f800 - 00000f0d00]   BIOS reserved
[    0.000000]   #7 [00000f0e5c - 00000f48c0]   BIOS reserved
[    0.000000]   #8 [00000f0d00 - 00000f0e5c]    MP-table mpc
[    0.000000]   #9 [0000010000 - 0000012000]      TRAMPOLINE
[    0.000000]   #10 [0000012000 - 0000016000]     ACPI WAKEUP
[    0.000000]   #11 [0000016000 - 0000017000]         PGTABLE
[    0.000000]   #12 [0001d18100 - 0001d1d100]       NODE_DATA
[    0.000000]   #13 [0001d1d100 - 0001d1e100]         BOOTMEM
[    0.000000]   #14 [0001d17140 - 0001d17200]         BOOTMEM
[    0.000000]   #15 [000251f000 - 0002520000]         BOOTMEM
[    0.000000]   #16 [0002520000 - 0002521000]         BOOTMEM
[    0.000000]   #17 [0002600000 - 0003400000]        MEMMAP 0
[    0.000000]   #18 [0001d17200 - 0001d17380]         BOOTMEM
[    0.000000]   #19 [0001d1e100 - 0001d24100]         BOOTMEM
[    0.000000]   #20 [0001d25000 - 0001d26000]         BOOTMEM
[    0.000000]   #21 [0001d17380 - 0001d173c3]         BOOTMEM
[    0.000000]   #22 [0001d17400 - 0001d17630]         BOOTMEM
[    0.000000]   #23 [0001d17640 - 0001d176a8]         BOOTMEM
[    0.000000]   #24 [0001d176c0 - 0001d17728]         BOOTMEM
[    0.000000]   #25 [0001d17740 - 0001d177a8]         BOOTMEM
[    0.000000]   #26 [0001d177c0 - 0001d17828]         BOOTMEM
[    0.000000]   #27 [0001d17840 - 0001d178a8]         BOOTMEM
[    0.000000]   #28 [0001d178c0 - 0001d17928]         BOOTMEM
[    0.000000]   #29 [0001d17940 - 0001d179a8]         BOOTMEM
[    0.000000]   #30 [0001d179c0 - 0001d17a28]         BOOTMEM
[    0.000000]   #31 [0001d17a40 - 0001d17aa8]         BOOTMEM
[    0.000000]   #32 [0001d17ac0 - 0001d17ae0]         BOOTMEM
[    0.000000]   #33 [0001d17b00 - 0001d17b6a]         BOOTMEM
[    0.000000]   #34 [0001d17b80 - 0001d17bea]         BOOTMEM
[    0.000000]   #35 [0001e00000 - 0001e1e000]         BOOTMEM
[    0.000000]   #36 [0001e80000 - 0001e9e000]         BOOTMEM
[    0.000000]   #37 [0001f00000 - 0001f1e000]         BOOTMEM
[    0.000000]   #38 [0001f80000 - 0001f9e000]         BOOTMEM
[    0.000000]   #39 [0001d17c00 - 0001d17c08]         BOOTMEM
[    0.000000]   #40 [0001d17c40 - 0001d17c48]         BOOTMEM
[    0.000000]   #41 [0001d17c80 - 0001d17c90]         BOOTMEM
[    0.000000]   #42 [0001d17cc0 - 0001d17ce0]         BOOTMEM
[    0.000000]   #43 [0001d17d00 - 0001d17e30]         BOOTMEM
[    0.000000]   #44 [0001d17e40 - 0001d17e90]         BOOTMEM
[    0.000000]   #45 [0001d17ec0 - 0001d17f10]         BOOTMEM
[    0.000000]   #46 [0001d26000 - 0001d2e000]         BOOTMEM
[    0.000000] Memory: 998436k/1038208k available (5714k kernel code, 452k absent, 39320k reserved, 5377k data, 908k init)
[    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU-based detection of stalled CPUs is disabled.
[    0.000000] 	Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:4352 nr_irqs:712
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 10485760 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1667.005 MHz processor.
[    0.010015] Calibrating delay loop (skipped), value calculated using timer frequency.. 3334.01 BogoMIPS (lpj=16670050)
[    0.010028] pid_max: default: 32768 minimum: 301
[    0.010091] Security Framework initialized
[    0.010140] AppArmor: AppArmor initialized
[    0.010144] Yama: becoming mindful.
[    0.010535] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.011512] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.011948] Mount-cache hash table entries: 256
[    0.012268] Initializing cgroup subsys ns
[    0.012280] Initializing cgroup subsys cpuacct
[    0.012292] Initializing cgroup subsys memory
[    0.012312] Initializing cgroup subsys devices
[    0.012319] Initializing cgroup subsys freezer
[    0.012325] Initializing cgroup subsys net_cls
[    0.012387] CPU: Physical Processor ID: 0
[    0.012393] CPU: Processor Core ID: 0
[    0.012398] mce: CPU supports 5 MCE banks
[    0.012413] CPU0: Thermal monitoring enabled (TM1)
[    0.012423] using mwait in idle threads.
[    0.012428] Performance Events: PEBS fmt0+, Atom events, Intel PMU driver.
[    0.012446] ... version:                3
[    0.012451] ... bit width:              40
[    0.012456] ... generic registers:      2
[    0.012461] ... value mask:             000000ffffffffff
[    0.012466] ... max period:             000000007fffffff
[    0.012471] ... fixed-purpose events:   3
[    0.012476] ... event mask:             0000000700000003
[    0.015951] ACPI: Core revision 20100428
[    0.025968] ftrace: converting mcount calls to 0f 1f 44 00 00
[    0.025980] ftrace: allocating 22681 entries in 89 pages
[    0.030123] Setting APIC routing to flat
[    0.030481] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.135452] CPU0: Intel(R) Atom(TM) CPU D510   @ 1.66GHz stepping 0a
[    0.140000] Booting Node   0, Processors  #1 #2
[    0.470000] TSC synchronization [CPU#0 -> CPU#2]:
[    0.470000] Measured 20 cycles TSC warp between CPUs, turning off TSC clock.
[    0.470000] Marking TSC unstable due to check_tsc_sync_source failed
[    0.470202]  #3 Ok.
[    0.630112] Brought up 4 CPUs
[    0.630122] Total of 4 processors activated (13334.06 BogoMIPS).
[    0.631713] devtmpfs: initialized
[    0.631852] regulator: core version 0.5
[    0.631890] Time: 20:23:20  Date: 03/12/11
[    0.631986] NET: Registered protocol family 16
[    0.632015] Trying to unpack rootfs image as initramfs...
[    0.632324] ACPI: bus type pci registered
[    0.632474] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[    0.632483] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
[    0.671961] PCI: Using configuration type 1 for base access
[    0.673763] bio: create slab <bio-0> at 0
[    0.673763] ACPI: EC: Look up EC in DSDT
[    0.687365] ACPI: Interpreter enabled
[    0.687375] ACPI: (supports S0 S3 S4 S5)
[    0.687425] ACPI: Using IOAPIC for interrupt routing
[    0.704573] ACPI: No dock devices found.
[    0.704584] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.704815] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.705257] pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7]
[    0.705265] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
[    0.705272] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.705279] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
[    0.705286] pci_root PNP0A03:00: host bridge window [mem 0x3f600000-0xfebfffff]
[    0.705371] pci 0000:00:02.0: reg 10: [mem 0xe1300000-0xe137ffff]
[    0.705380] pci 0000:00:02.0: reg 14: [io  0xe000-0xe007]
[    0.705388] pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff pref]
[    0.705397] pci 0000:00:02.0: reg 1c: [mem 0xe1000000-0xe10fffff]
[    0.705521] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.705529] pci 0000:00:1c.0: PME# disabled
[    0.705610] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.705618] pci 0000:00:1c.1: PME# disabled
[    0.705685] pci 0000:00:1d.0: reg 20: [io  0xe100-0xe11f]
[    0.705751] pci 0000:00:1d.1: reg 20: [io  0xe200-0xe21f]
[    0.705820] pci 0000:00:1d.2: reg 20: [io  0xe300-0xe31f]
[    0.705880] pci 0000:00:1d.3: reg 20: [io  0xe400-0xe41f]
[    0.705944] pci 0000:00:1d.7: reg 10: [mem 0xe1380000-0xe13803ff]
[    0.706125] pci 0000:00:1f.0: [Firmware Bug]: TigerPoint LPC.BM_STS cleared
[    0.706183] pci 0000:00:1f.2: reg 10: [io  0xe500-0xe507]
[    0.706193] pci 0000:00:1f.2: reg 14: [io  0xe600-0xe603]
[    0.706202] pci 0000:00:1f.2: reg 18: [io  0xe700-0xe707]
[    0.706212] pci 0000:00:1f.2: reg 1c: [io  0xe800-0xe803]
[    0.706222] pci 0000:00:1f.2: reg 20: [io  0xe900-0xe90f]
[    0.706231] pci 0000:00:1f.2: reg 24: [mem 0xe1381000-0xe13813ff]
[    0.706263] pci 0000:00:1f.2: PME# supported from D3hot
[    0.706270] pci 0000:00:1f.2: PME# disabled
[    0.706325] pci 0000:00:1f.3: reg 20: [io  0x0500-0x051f]
[    0.706441] pci 0000:01:00.0: reg 10: [io  0xc000-0xc0ff]
[    0.706467] pci 0000:01:00.0: reg 18: [mem 0xe1104000-0xe1104fff 64bit pref]
[    0.706486] pci 0000:01:00.0: reg 20: [mem 0xe1100000-0xe1103fff 64bit pref]
[    0.706499] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
[    0.706546] pci 0000:01:00.0: supports D1 D2
[    0.706552] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.706560] pci 0000:01:00.0: PME# disabled
[    0.720034] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.720043] pci 0000:00:1c.0:   bridge window [io  0xc000-0xcfff]
[    0.720052] pci 0000:00:1c.0:   bridge window [mem 0xe0000000-0xe0ffffff]
[    0.720062] pci 0000:00:1c.0:   bridge window [mem 0xe1100000-0xe11fffff 64bit pref]
[    0.720213] pci 0000:02:00.0: reg 24: [mem 0xe1200000-0xe1201fff]
[    0.720262] pci 0000:02:00.0: PME# supported from D3hot
[    0.720271] pci 0000:02:00.0: PME# disabled
[    0.720328] pci 0000:02:00.1: reg 10: [io  0xd000-0xd007]
[    0.720341] pci 0000:02:00.1: reg 14: [io  0xd100-0xd103]
[    0.720354] pci 0000:02:00.1: reg 18: [io  0xd200-0xd207]
[    0.720367] pci 0000:02:00.1: reg 1c: [io  0xd300-0xd303]
[    0.720380] pci 0000:02:00.1: reg 20: [io  0xd400-0xd40f]
[    0.720450] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.720473] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    0.720481] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
[    0.720489] pci 0000:00:1c.1:   bridge window [mem 0xe1200000-0xe12fffff]
[    0.720499] pci 0000:00:1c.1:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    0.720582] pci 0000:00:1e.0: PCI bridge to [bus 03-03] (subtractive decode)
[    0.720591] pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (disabled)
[    0.720599] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    0.720611] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    0.720619] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.720626] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.720633] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.720640] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.720647] pci 0000:00:1e.0:   bridge window [mem 0x3f600000-0xfebfffff] (subtractive decode)
[    0.720676] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.721042] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[    0.721170] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
[    0.721367] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[    0.746394] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.746617] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.746836] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.747053] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.747271] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.747492] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.747713] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.747941] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.748045] HEST: Table is not found!
[    0.748239] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.748263] vgaarb: loaded
[    0.748625] SCSI subsystem initialized
[    0.748677] libata version 3.00 loaded.
[    0.748677] usbcore: registered new interface driver usbfs
[    0.748677] usbcore: registered new interface driver hub
[    0.748677] usbcore: registered new device driver usb
[    0.748677] ACPI: WMI: Mapper loaded
[    0.748677] PCI: Using ACPI for IRQ routing
[    0.748677] PCI: pci_cache_line_size set to 64 bytes
[    0.748677] reserve RAM buffer: 000000000009f800 - 000000000009ffff 
[    0.748677] reserve RAM buffer: 000000003f5e0000 - 000000003fffffff 
[    0.750130] NetLabel: Initializing
[    0.750135] NetLabel:  domain hash size = 128
[    0.750139] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.750177] NetLabel:  unlabeled traffic allowed by default
[    0.774282] AppArmor: AppArmor Filesystem Enabled
[    0.774327] pnp: PnP ACPI init
[    0.774376] ACPI: bus type pnp registered
[    0.781299] pnp: PnP ACPI: found 14 devices
[    0.781305] ACPI: ACPI bus type pnp unregistered
[    0.781334] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.781341] system 00:01: [io  0x0290-0x029f] has been reserved
[    0.781348] system 00:01: [io  0x0800-0x087f] has been reserved
[    0.781355] system 00:01: [io  0x0290-0x0294] has been reserved
[    0.781362] system 00:01: [io  0x0880-0x088f] has been reserved
[    0.781380] system 00:0a: [io  0x0400-0x04cf] has been reserved
[    0.781394] system 00:0b: [mem 0xc0000000-0xcfffffff] has been reserved
[    0.781408] system 00:0c: [mem 0x000cda00-0x000cffff] has been reserved
[    0.781416] system 00:0c: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.781424] system 00:0c: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.781431] system 00:0c: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.781439] system 00:0c: [mem 0x3f5e0000-0x3f5fffff] could not be reserved
[    0.781447] system 00:0c: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.781454] system 00:0c: [mem 0x00100000-0x3f5dffff] could not be reserved
[    0.781462] system 00:0c: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.781469] system 00:0c: [mem 0xfed13000-0xfed1dfff] has been reserved
[    0.781477] system 00:0c: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.781484] system 00:0c: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.781491] system 00:0c: [mem 0xffb00000-0xffb7ffff] has been reserved
[    0.781499] system 00:0c: [mem 0xfff00000-0xffffffff] has been reserved
[    0.781506] system 00:0c: [mem 0x000e0000-0x000effff] has been reserved
[    0.790189] Switching to clocksource acpi_pm
[    0.790832] pci 0000:00:1c.1: BAR 15: assigned [mem 0x3f600000-0x3f7fffff 64bit pref]
[    0.790843] pci 0000:01:00.0: BAR 6: assigned [mem 0xe1120000-0xe113ffff pref]
[    0.790851] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.790858] pci 0000:00:1c.0:   bridge window [io  0xc000-0xcfff]
[    0.790867] pci 0000:00:1c.0:   bridge window [mem 0xe0000000-0xe0ffffff]
[    0.790875] pci 0000:00:1c.0:   bridge window [mem 0xe1100000-0xe11fffff 64bit pref]
[    0.790887] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    0.790893] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
[    0.790902] pci 0000:00:1c.1:   bridge window [mem 0xe1200000-0xe12fffff]
[    0.790910] pci 0000:00:1c.1:   bridge window [mem 0x3f600000-0x3f7fffff 64bit pref]
[    0.790921] pci 0000:00:1e.0: PCI bridge to [bus 03-03]
[    0.790926] pci 0000:00:1e.0:   bridge window [io  disabled]
[    0.790933] pci 0000:00:1e.0:   bridge window [mem disabled]
[    0.790940] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    0.790970]   alloc irq_desc for 16 on node -1
[    0.790975]   alloc kstat_irqs on node -1
[    0.790991] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.791001] pci 0000:00:1c.0: setting latency timer to 64
[    0.791015]   alloc irq_desc for 17 on node -1
[    0.791020]   alloc kstat_irqs on node -1
[    0.791030] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    0.791038] pci 0000:00:1c.1: setting latency timer to 64
[    0.791051] pci 0000:00:1e.0: setting latency timer to 64
[    0.791059] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.791065] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.791071] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.791078] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
[    0.791084] pci_bus 0000:00: resource 8 [mem 0x3f600000-0xfebfffff]
[    0.791091] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
[    0.791097] pci_bus 0000:01: resource 1 [mem 0xe0000000-0xe0ffffff]
[    0.791103] pci_bus 0000:01: resource 2 [mem 0xe1100000-0xe11fffff 64bit pref]
[    0.791110] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.791116] pci_bus 0000:02: resource 1 [mem 0xe1200000-0xe12fffff]
[    0.791122] pci_bus 0000:02: resource 2 [mem 0x3f600000-0x3f7fffff 64bit pref]
[    0.791129] pci_bus 0000:03: resource 4 [io  0x0000-0x0cf7]
[    0.791135] pci_bus 0000:03: resource 5 [io  0x0d00-0xffff]
[    0.791141] pci_bus 0000:03: resource 6 [mem 0x000a0000-0x000bffff]
[    0.791147] pci_bus 0000:03: resource 7 [mem 0x000c0000-0x000dffff]
[    0.791154] pci_bus 0000:03: resource 8 [mem 0x3f600000-0xfebfffff]
[    0.791242] NET: Registered protocol family 2
[    0.791439] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.792437] TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
[    0.794122] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.794848] TCP: Hash tables configured (established 131072 bind 65536)
[    0.794856] TCP reno registered
[    0.794882] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.794909] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.795191] NET: Registered protocol family 1
[    0.795234] pci 0000:00:02.0: Boot video device
[    0.810076] PCI: CLS 32 bytes, default 64
[    0.810832] Scanning for low memory corruption every 60 seconds
[    0.811208] audit: initializing netlink socket (disabled)
[    0.811240] type=2000 audit(1299961400.809:1): initialized
[    0.836139] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.839978] VFS: Disk quotas dquot_6.5.2
[    0.840152] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.841730] fuse init (API version 7.14)
[    0.841972] msgmni has been set to 1950
[    0.843171] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.843180] io scheduler noop registered
[    0.843185] io scheduler deadline registered
[    0.843286] io scheduler cfq registered (default)
[    0.843513] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.843558]   alloc irq_desc for 40 on node -1
[    0.843563]   alloc kstat_irqs on node -1
[    0.843584] pcieport 0000:00:1c.0: irq 40 for MSI/MSI-X
[    0.843748] pcieport 0000:00:1c.1: setting latency timer to 64
[    0.843800]   alloc irq_desc for 41 on node -1
[    0.843806]   alloc kstat_irqs on node -1
[    0.843823] pcieport 0000:00:1c.1: irq 41 for MSI/MSI-X
[    0.844028] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.844204] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.844411] intel_idle: MWAIT substates: 0x10
[    0.844417] intel_idle: v0.4 model 0x1C
[    0.844421] intel_idle: lapic_timer_reliable_states 0x2
[    0.844677] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.844690] ACPI: Power Button [PWRB]
[    0.844825] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.844835] ACPI: Power Button [PWRF]
[    0.845372] ACPI: acpi_idle yielding to intel_idle
[    0.850929] ERST: Table is not found!
[    0.851250] Linux agpgart interface v0.103
[    0.851304] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.851455] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.851613] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.852115] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.852331] 00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.855408] brd: module loaded
[    0.856802] loop: module loaded
[    0.857403] pata_acpi 0000:02:00.1: enabling device (0000 -> 0001)
[    0.857423]   alloc irq_desc for 18 on node -1
[    0.857428]   alloc kstat_irqs on node -1
[    0.857447] pata_acpi 0000:02:00.1: PCI INT B -> GSI 18 (level, low) -> IRQ 18
[    0.857509] pata_acpi 0000:02:00.1: setting latency timer to 64
[    0.857537] pata_acpi 0000:02:00.1: PCI INT B disabled
[    0.858283] Fixed MDIO Bus: probed
[    0.858367] PPP generic driver version 2.4.2
[    0.858483] tun: Universal TUN/TAP device driver, 1.6
[    0.858488] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    0.858703] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.858748]   alloc irq_desc for 23 on node -1
[    0.858753]   alloc kstat_irqs on node -1
[    0.858767] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.858800] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    0.858807] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    0.858913] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    0.858958] ehci_hcd 0000:00:1d.7: using broken periodic workaround
[    0.862863] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    0.862905] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xe1380000
[    0.883779] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.884102] hub 1-0:1.0: USB hub found
[    0.884115] hub 1-0:1.0: 8 ports detected
[    0.884292] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.884329] uhci_hcd: USB Universal Host Controller Interface driver
[    0.884481] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.884495] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    0.884502] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.884606] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    0.884648] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000e100
[    0.884956] hub 2-0:1.0: USB hub found
[    0.884969] hub 2-0:1.0: 2 ports detected
[    0.885107]   alloc irq_desc for 19 on node -1
[    0.885113]   alloc kstat_irqs on node -1
[    0.885128] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.885141] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    0.885147] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.885241] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    0.885296] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000e200
[    0.885591] hub 3-0:1.0: USB hub found
[    0.885604] hub 3-0:1.0: 2 ports detected
[    0.885732] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.885751] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    0.885758] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.885868] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    0.885930] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e300
[    0.886218] hub 4-0:1.0: USB hub found
[    0.886231] hub 4-0:1.0: 2 ports detected
[    0.886394] uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
[    0.886406] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    0.886413] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    0.886505] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    0.886561] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000e400
[    0.886853] hub 5-0:1.0: USB hub found
[    0.886866] hub 5-0:1.0: 2 ports detected
[    0.887126] PNP: No PS/2 controller found. Probing ports directly.
[    0.887594] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.887614] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.887835] mice: PS/2 mouse device common for all mice
[    0.888109] rtc_cmos 00:03: RTC can wake from S4
[    0.888218] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.888255] rtc0: alarms up to one month, 242 bytes nvram
[    0.888534] device-mapper: uevent: version 1.0.3
[    0.888787] device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@redhat.com
[    0.889191] device-mapper: multipath: version 1.1.1 loaded
[    0.889201] device-mapper: multipath round-robin: version 1.0.0 loaded
[    0.890081] cpuidle: using governor ladder
[    0.890317] cpuidle: using governor menu
[    0.890955] TCP cubic registered
[    0.891283] NET: Registered protocol family 10
[    0.892109] lo: Disabled Privacy Extensions
[    0.892580] NET: Registered protocol family 17
[    0.893000] PM: Resume from disk failed.
[    0.893030] registered taskstats version 1
[    0.893429]   Magic number: 3:826:396
[    0.893605] rtc_cmos 00:03: setting system clock to 2011-03-12 20:23:21 UTC (1299961401)
[    0.893613] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    0.893618] EDD information not available.
[    1.161306] Freeing initrd memory: 10972k freed
[    1.169743] Freeing unused kernel memory: 908k freed
[    1.170258] Write protecting the kernel read-only data: 10240k
[    1.170732] Freeing unused kernel memory: 412k freed
[    1.171376] Freeing unused kernel memory: 1644k freed
[    1.210095] usb 1-1: new high speed USB device using ehci_hcd and address 2
[    1.215875] udev[98]: starting version 163
[    1.249060] md: linear personality registered for level -1
[    1.270896] md: multipath personality registered for level -4
[    1.279002] md: raid0 personality registered for level 0
[    1.320099] pata_jmicron 0000:02:00.1: PCI INT B -> GSI 18 (level, low) -> IRQ 18
[    1.320189] pata_jmicron 0000:02:00.1: setting latency timer to 64
[    1.327654] md: raid1 personality registered for level 1
[    1.363857] scsi0 : pata_jmicron
[    1.387516] Floppy drive(s): fd0 is unknown type 13 (usb?)
[    1.389473] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.389526] r8169 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.389601] r8169 0000:01:00.0: setting latency timer to 64
[    1.389668]   alloc irq_desc for 42 on node -1
[    1.389677]   alloc kstat_irqs on node -1
[    1.389708] r8169 0000:01:00.0: irq 42 for MSI/MSI-X
[    1.391299] r8169 0000:01:00.0: eth0: RTL8168d/8111d at 0xffffc90010582000, 6c:f0:49:9f:fc:5f, XID 083000c0 IRQ 42
[    1.425750] ahci 0000:00:1f.2: version 3.0
[    1.425795] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.425883]   alloc irq_desc for 43 on node -1
[    1.425890]   alloc kstat_irqs on node -1
[    1.425915] ahci 0000:00:1f.2: irq 43 for MSI/MSI-X
[    1.426037] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    1.426050] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part 
[    1.426061] ahci 0000:00:1f.2: setting latency timer to 64
[    1.430394] scsi1 : pata_jmicron
[    1.431657] scsi2 : ahci
[    1.432645] ata1: PATA max UDMA/100 cmd 0xd000 ctl 0xd100 bmdma 0xd400 irq 18
[    1.432656] ata2: PATA max UDMA/100 cmd 0xd200 ctl 0xd300 bmdma 0xd408 irq 18
[    1.436428] scsi3 : ahci
[    1.436757] scsi4 : ahci
[    1.437046] scsi5 : ahci
[    1.437575] ata3: SATA max UDMA/133 abar m1024@0xe1381000 port 0xe1381100 irq 43
[    1.437588] ata4: SATA max UDMA/133 abar m1024@0xe1381000 port 0xe1381180 irq 43
[    1.437599] ata5: SATA max UDMA/133 abar m1024@0xe1381000 port 0xe1381200 irq 43
[    1.437609] ata6: SATA max UDMA/133 abar m1024@0xe1381000 port 0xe1381280 irq 43
[    1.437731] ahci 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.437933] ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[    1.437946] ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[    1.437964] ahci 0000:02:00.0: setting latency timer to 64
[    1.438561] FDC 0 is a post-1991 82077
[    1.441459] scsi6 : ahci
[    1.442056] scsi7 : ahci
[    1.442486] ata7: SATA max UDMA/133 abar m8192@0xe1200000 port 0xe1200100 irq 17
[    1.442500] ata8: SATA max UDMA/133 abar m8192@0xe1200000 port 0xe1200180 irq 17
[    1.445630] async_tx: api initialized (async)
[    1.473826] usb 1-2: new high speed USB device using ehci_hcd and address 3
[    1.491281] Initializing USB Mass Storage driver...
[    1.491668] scsi8 : usb-storage 1-1:1.0
[    1.491983] usbcore: registered new interface driver usb-storage
[    1.491993] USB Mass Storage support registered.
[    1.639133] hub 1-2:1.0: USB hub found
[    1.639242] hub 1-2:1.0: 3 ports detected
[    1.782547] ata5: SATA link down (SStatus 0 SControl 300)
[    1.782599] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.782629] ata6: SATA link down (SStatus 0 SControl 300)
[    1.782644] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.785561] ata4.00: ATA-8: WDC WD10EARS-00Y5B1, 80.00A80, max UDMA/133
[    1.785570] ata4.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.787834] ata4.00: configured for UDMA/133
[    1.788000] ata3.00: ATA-7: SAMSUNG HD161HJ, JF100-19, max UDMA7
[    1.788008] ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.793517] ata3.00: configured for UDMA/133
[    1.793799] scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD161HJ  JF10 PQ: 0 ANSI: 5
[    1.794325] sd 2:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    1.794395] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    1.794778] sd 2:0:0:0: [sda] Write Protect is off
[    1.794789] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.794868] scsi 3:0:0:0: Direct-Access     ATA      WDC WD10EARS-00Y 80.0 PQ: 0 ANSI: 5
[    1.794902] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.795390] sd 3:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    1.795452] sd 3:0:0:0: Attached scsi generic sg1 type 0
[    1.795681] sd 3:0:0:0: [sdb] Write Protect is off
[    1.795690] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.795714]  sda:
[    1.795803] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.796505]  sdb: sda1 sda2 < sdb1
[    1.810163] sd 3:0:0:0: [sdb] Attached SCSI disk
[    1.824393]  sda5 >
[    1.825432] sd 2:0:0:0: [sda] Attached SCSI disk
[    2.001308] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.001350] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.003772] ata7.00: ATA-8: WDC WD10EARS-00Y5B1, 80.00A80, max UDMA/133
[    2.003783] ata7.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.003952] ata8.00: ATA-8: WDC WD10EARS-00MVWB0, 51.0AB51, max UDMA/133
[    2.003960] ata8.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.005719] ata7.00: configured for UDMA/133
[    2.006685] ata8.00: configured for UDMA/133
[    2.022771] scsi 6:0:0:0: Direct-Access     ATA      WDC WD10EARS-00Y 80.0 PQ: 0 ANSI: 5
[    2.023219] sd 6:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    2.023298] sd 6:0:0:0: Attached scsi generic sg2 type 0
[    2.023518] sd 6:0:0:0: [sdc] Write Protect is off
[    2.023529] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.023635] sd 6:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.024497]  sdc:
[    2.031526] scsi 7:0:0:0: Direct-Access     ATA      WDC WD10EARS-00M 51.0 PQ: 0 ANSI: 5
[    2.031950] sd 7:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    2.032046] sd 7:0:0:0: Attached scsi generic sg3 type 0
[    2.032184] sd 7:0:0:0: [sdd] Write Protect is off
[    2.032193] sd 7:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    2.032313] sd 7:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.033134]  sdd: sdd1
[    2.038738] sd 7:0:0:0: [sdd] Attached SCSI disk
[    2.041738]  sdc1
[    2.042478] sd 6:0:0:0: [sdc] Attached SCSI disk
[    2.081300] usb 5-1: new low speed USB device using uhci_hcd and address 2
[    2.098472] ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
[    2.098483] ata4.00: irq_stat 0x40000008
[    2.098493] ata4.00: failed command: READ FPDMA QUEUED
[    2.098512] ata4.00: cmd 60/20:00:bf:0c:0e/00:00:74:00:00/40 tag 0 ncq 16384 in
[    2.098516]          res 41/40:00:c7:0c:0e/00:00:74:00:00/40 Emask 0x409 (media error) <F>
[    2.098526] ata4.00: status: { DRDY ERR }
[    2.098532] ata4.00: error: { UNC }
[    2.104001] ata4.00: configured for UDMA/133
[    2.104026] ata4: EH complete
[    2.212704] raid6: int64x1    308 MB/s
[    2.276257] ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
[    2.276267] ata4.00: irq_stat 0x40000008
[    2.276277] ata4.00: failed command: READ FPDMA QUEUED
[    2.276297] ata4.00: cmd 60/20:00:bf:0c:0e/00:00:74:00:00/40 tag 0 ncq 16384 in
[    2.276301]          res 41/40:00:c7:0c:0e/00:00:74:00:00/40 Emask 0x409 (media error) <F>
[    2.276311] ata4.00: status: { DRDY ERR }
[    2.276318] ata4.00: error: { UNC }
[    2.281446] ata4.00: configured for UDMA/133
[    2.281470] ata4: EH complete
[    2.374639] usbcore: registered new interface driver hiddev
[    2.382573] raid6: int64x2    515 MB/s
[    2.431407] usb 1-2.2: new low speed USB device using ehci_hcd and address 5
[    2.454028] ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
[    2.454035] ata4.00: irq_stat 0x40000008
[    2.454044] ata4.00: failed command: READ FPDMA QUEUED
[    2.454059] ata4.00: cmd 60/20:00:bf:0c:0e/00:00:74:00:00/40 tag 0 ncq 16384 in
[    2.454062]          res 41/40:00:c7:0c:0e/00:00:74:00:00/40 Emask 0x409 (media error) <F>
[    2.454070] ata4.00: status: { DRDY ERR }
[    2.454075] ata4.00: error: { UNC }
[    2.459643] ata4.00: configured for UDMA/133
[    2.459669] ata4: EH complete
[    2.484941] scsi 8:0:0:0: Direct-Access     Kingston DT 100 G2        PMAP PQ: 0 ANSI: 0 CCS
[    2.486511] sd 8:0:0:0: Attached scsi generic sg4 type 0
[    2.487076] sd 8:0:0:0: [sde] 31342592 512-byte logical blocks: (16.0 GB/14.9 GiB)
[    2.488916] sd 8:0:0:0: [sde] Write Protect is off
[    2.488926] sd 8:0:0:0: [sde] Mode Sense: 23 00 00 00
[    2.488934] sd 8:0:0:0: [sde] Assuming drive cache: write through
[    2.493285] sd 8:0:0:0: [sde] Assuming drive cache: write through
[    2.493300]  sde: sde1
[    2.497715] sd 8:0:0:0: [sde] Assuming drive cache: write through
[    2.497731] sd 8:0:0:0: [sde] Attached SCSI removable disk
[    2.552608] raid6: int64x4    546 MB/s
[    2.631810] ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
[    2.631818] ata4.00: irq_stat 0x40000008
[    2.631827] ata4.00: failed command: READ FPDMA QUEUED
[    2.631842] ata4.00: cmd 60/20:00:bf:0c:0e/00:00:74:00:00/40 tag 0 ncq 16384 in
[    2.631845]          res 41/40:00:c7:0c:0e/00:00:74:00:00/40 Emask 0x409 (media error) <F>
[    2.631852] ata4.00: status: { DRDY ERR }
[    2.631858] ata4.00: error: { UNC }
[    2.637476] ata4.00: configured for UDMA/133
[    2.637502] ata4: EH complete
[    2.722590] raid6: int64x8    660 MB/s
[    2.809591] ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
[    2.809599] ata4.00: irq_stat 0x40000008
[    2.809606] ata4.00: failed command: READ FPDMA QUEUED
[    2.809620] ata4.00: cmd 60/20:00:bf:0c:0e/00:00:74:00:00/40 tag 0 ncq 16384 in
[    2.809624]          res 41/40:00:c7:0c:0e/00:00:74:00:00/40 Emask 0x409 (media error) <F>
[    2.809631] ata4.00: status: { DRDY ERR }
[    2.809636] ata4.00: error: { UNC }
[    2.814957] ata4.00: configured for UDMA/133
[    2.814985] ata4: EH complete
[    2.892520] raid6: sse2x1     489 MB/s
[    2.987370] ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
[    2.987379] ata4.00: irq_stat 0x40000008
[    2.987388] ata4.00: failed command: READ FPDMA QUEUED
[    2.987407] ata4.00: cmd 60/20:00:bf:0c:0e/00:00:74:00:00/40 tag 0 ncq 16384 in
[    2.987411]          res 41/40:00:c7:0c:0e/00:00:74:00:00/40 Emask 0x409 (media error) <F>
[    2.987420] ata4.00: status: { DRDY ERR }
[    2.987427] ata4.00: error: { UNC }
[    2.992058] ata4.00: configured for UDMA/133
[    2.992111] sd 3:0:0:0: [sdb] Unhandled sense code
[    2.992119] sd 3:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[    2.992130] sd 3:0:0:0: [sdb] Sense Key : Medium Error [current] [descriptor]
[    2.992144] Descriptor sense data with sense descriptors (in hex):
[    2.992151]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00 
[    2.992182]         74 0e 0c c7 
[    2.992195] sd 3:0:0:0: [sdb] Add. Sense: Unrecovered read error - auto reallocate failed
[    2.992211] sd 3:0:0:0: [sdb] CDB: Read(10): 28 00 74 0e 0c bf 00 00 20 00
[    2.992233] end_request: I/O error, dev sdb, sector 1947077831
[    2.992242] Buffer I/O error on device sdb1, logical block 1947077768
[    2.992250] Buffer I/O error on device sdb1, logical block 1947077769
[    2.992257] Buffer I/O error on device sdb1, logical block 1947077770
[    2.992264] Buffer I/O error on device sdb1, logical block 1947077771
[    2.992271] Buffer I/O error on device sdb1, logical block 1947077772
[    2.992278] Buffer I/O error on device sdb1, logical block 1947077773
[    2.992286] Buffer I/O error on device sdb1, logical block 1947077774
[    2.992293] Buffer I/O error on device sdb1, logical block 1947077775
[    2.992306] Buffer I/O error on device sdb1, logical block 1947077776
[    2.992362] ata4: EH complete
[    3.062524] raid6: sse2x2     755 MB/s
[    3.232512] raid6: sse2x4    1034 MB/s
[    3.232518] raid6: using algorithm sse2x4 (1034 MB/s)
[    3.238055] xor: automatically using best checksumming function: generic_sse
[    3.270648] md: bind<sdb1>
[    3.282516]    generic_sse:  5095.200 MB/sec
[    3.282523] xor: using function: generic_sse (5095.200 MB/sec)
[    3.295582] md: raid6 personality registered for level 6
[    3.295591] md: raid5 personality registered for level 5
[    3.295598] md: raid4 personality registered for level 4
[    3.312719] md: raid10 personality registered for level 10
[    3.909056] generic-usb 0003:051D:0002.0001: hiddev96,hidraw0: USB HID v1.10 Device [American Power Conversion Back-UPS CS 500 FW:808.q5.I USB FW:q5] on usb-0000:00:1d.3-1/input0
[    3.909293] usbcore: registered new interface driver usbhid
[    3.909298] usbhid: USB HID core driver
[    4.463429] udev[387]: starting version 163
[    4.977955] agpgart-intel 0000:00:00.0: Intel GMA3150 Chipset
[    4.978497] agpgart-intel 0000:00:00.0: detected 7676K stolen memory
[    5.020903] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    5.237637] lp: driver loaded but no devices found
[    5.344153] md: bind<sdc1>
[    5.382900] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1d.7/usb1/1-2/1-2.2/1-2.2:1.0/input/input2
[    5.383574] apple 0003:05AC:0221.0002: input,hidraw1: USB HID v1.11 Keyboard [Apple, Inc Apple Keyboard] on usb-0000:00:1d.7-2.2/input0
[    5.387439] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1d.7/usb1/1-2/1-2.2/1-2.2:1.1/input/input3
[    5.389008] apple 0003:05AC:0221.0003: input,hidraw2: USB HID v1.11 Device [Apple, Inc Apple Keyboard] on usb-0000:00:1d.7-2.2/input1
[    5.410143] parport_pc 00:09: reported by Plug and Play ACPI
[    5.410211] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    5.434087] ppdev: user-space parallel port driver
[    5.477907] [drm] Initialized drm 1.1.0 20060810
[    5.484223] lp0: using parport0 (interrupt-driven).
[    5.544449] md: bind<sdd1>
[    5.584448] md/raid:md0: device sdd1 operational as raid disk 1
[    5.584457] md/raid:md0: device sdc1 operational as raid disk 0
[    5.584464] md/raid:md0: device sdb1 operational as raid disk 2
[    5.585622] md/raid:md0: allocated 3230kB
[    5.585791] md/raid:md0: raid level 5 active with 3 out of 3 devices, algorithm 2
[    5.585799] RAID conf printout:
[    5.585806]  --- level:5 rd:3 wd:3
[    5.585815]  disk 0, o:1, dev:sdc1
[    5.585822]  disk 1, o:1, dev:sdd1
[    5.585830]  disk 2, o:1, dev:sdb1
[    5.585948] md0: detected capacity change from 0 to 1993807626240
[    5.590157]  md0: unknown partition table
[    5.775512] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    5.775524] i915 0000:00:02.0: setting latency timer to 64
[    5.827731]   alloc irq_desc for 44 on node -1
[    5.827739]   alloc kstat_irqs on node -1
[    5.827759] i915 0000:00:02.0: irq 44 for MSI/MSI-X
[    5.827781] [drm] set up 7M of stolen space
[    5.828504] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    5.828891] [drm] initialized overlay support
[    6.082280] Console: switching to colour frame buffer device 128x48
[    6.090527] fb0: inteldrmfb frame buffer device
[    6.090532] drm: registered panic notifier
[    6.090539] Slow work thread pool: Starting up
[    6.090720] Slow work thread pool: Ready
[    6.091110] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    6.217619] audit_printk_skb: 33 callbacks suppressed
[    6.217627] type=1400 audit(1299961406.812:8): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient3" pid=815 comm="apparmor_parser"
[    6.218189] type=1400 audit(1299961406.812:9): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=815 comm="apparmor_parser"
[    6.218522] type=1400 audit(1299961406.812:10): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=815 comm="apparmor_parser"
[    6.227517] type=1400 audit(1299961406.822:11): apparmor="STATUS" operation="profile_load" name="/usr/sbin/tcpdump" pid=817 comm="apparmor_parser"
[    6.243429] type=1400 audit(1299961406.842:12): apparmor="STATUS" operation="profile_load" name="/usr/lib/cups/backend/cups-pdf" pid=816 comm="apparmor_parser"
[    6.244470] type=1400 audit(1299961406.842:13): apparmor="STATUS" operation="profile_load" name="/usr/sbin/cupsd" pid=816 comm="apparmor_parser"
[    6.271261] r8169 0000:01:00.0: eth0: link up
[    6.271281] r8169 0000:01:00.0: eth0: link up
[    6.575886] type=1400 audit(1299961407.172:14): apparmor="STATUS" operation="profile_replace" name="/usr/lib/cups/backend/cups-pdf" pid=868 comm="apparmor_parser"
[    6.576954] type=1400 audit(1299961407.172:15): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/cupsd" pid=868 comm="apparmor_parser"
[   16.700025] eth0: no IPv6 routers present
[  180.083668] usb 1-2: USB disconnect, address 3
[  180.083676] usb 1-2.2: USB disconnect, address 5


lspci -nn:
lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation N10 Family DMI Bridge [8086:a000] (rev 02)
00:02.0 VGA compatible controller [0300]: Intel Corporation N10 Family Integrated Graphics Controller [8086:a001] (rev 02)
00:1c.0 PCI bridge [0604]: Intel Corporation N10/ICH 7 Family PCI Express Port 1 [8086:27d0] (rev 02)
00:1c.1 PCI bridge [0604]: Intel Corporation N10/ICH 7 Family PCI Express Port 2 [8086:27d2] (rev 02)
00:1d.0 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB UHCI Controller #1 [8086:27c8] (rev 02)
00:1d.1 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB UHCI Controller #2 [8086:27c9] (rev 02)
00:1d.2 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB UHCI Controller #3 [8086:27ca] (rev 02)
00:1d.3 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB UHCI Controller #4 [8086:27cb] (rev 02)
00:1d.7 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB2 EHCI Controller [8086:27cc] (rev 02)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge [8086:2448] (rev e2)
00:1f.0 ISA bridge [0601]: Intel Corporation NM10 Family LPC Controller [8086:27bc] (rev 02)
00:1f.2 SATA controller [0106]: Intel Corporation N10/ICH7 Family SATA AHCI Controller [8086:27c1] (rev 02)
00:1f.3 SMBus [0c05]: Intel Corporation N10/ICH 7 Family SMBus Controller [8086:27da] (rev 02)
01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168] (rev 03)
02:00.0 SATA controller [0106]: JMicron Technology Corp. JMB362/JMB363 Serial ATA Controller [197b:2363] (rev 02)
02:00.1 IDE interface [0101]: JMicron Technology Corp. JMB362/JMB363 Serial ATA Controller [197b:2363] (rev 02)



I dont know why there is "[    2.098493] ata4.00: failed command: READ FPDMA QUEUED" in dmesg.

I have 3 WD Green 1TB HDD, and I samsung 160GB HDD.
1 SAMSUNG and 1 WD on the intel SATA,
2 WD on the GIGABYTE Sata.
I think the problem is only with the gigabye sata port.


Thanks for your help.

Peter Elekes
>From Hungary




On 2011.02.27., at 16:33, Tejun Heo wrote:

> Hello,
> 
> Please cc linux-ide@vger.kernel.org when replying.
> 
> On Sun, Feb 27, 2011 at 03:23:06PM +0100, Peter wrote:
>> Hi!
>> 
>> I have a gigabyte d510-ud atom cpu motherboard with a gigabyte sata port.
>> 
>> When I use debian lenny I have no problem.
>> But when I switch to ubuntu 10.10 (2.6.36 kernel) it says
>> failed command: READ FPDMA QUEUED
>> 
>> I think there is a problem with the gigabyte sata chip driver.
>> 
>> Do you have any ideas?
> 
> Can you please attach the output of 'lspci -nn' and 'dmesg' after such
> error occurs?
> 
> -- 
> tejun
> 

