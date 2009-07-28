From: rbroman@bayarea.net
Subject: Re: Software RAID Problem
Date: Tue, 28 Jul 2009 09:24:49 -0700
Message-ID: <1248798289.4a6f26510c218@myaccount.bayarea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1b.bayarea.net ([209.128.100.196]:58850 "EHLO
	smtpout1.bayarea.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755219AbZG1RUS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jul 2009 13:20:18 -0400
Received: from myaccount.bayarea.net (myaccount.bayarea.net [209.128.116.10])
	by smtpout1.bayarea.net (8.13.8/8.13.8) with ESMTP id n6SGOnl7014409
	for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2009 09:24:50 -0700
Received: from myaccount.bayarea.net (localhost.localdomain [127.0.0.1])
	by myaccount.bayarea.net (8.12.11/8.12.11) with ESMTP id n6SGOnuV015440
	for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2009 09:24:49 -0700
Received: (from apache@localhost)
	by myaccount.bayarea.net (8.12.11/8.12.11/Submit) id n6SGOnNl015439
	for linux-ide@vger.kernel.org; Tue, 28 Jul 2009 09:24:49 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> Can you attach full output of 'dmesg' after raid degradation?

For context, there are four RAID devices on this system. md0 is
/boot, md1 is / and md2 and md3 are the problem devices. /proc/mdstat
is below followed by the output of dmesg.

/proc/mdstat

Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4]
[raid10]
md_d3 : inactive sdd2[2](S)
      366289920 blocks

md_d2 : inactive sdd1[2](S)
      366281856 blocks

md1 : active raid0 sdb6[1] sda6[0]
      781256704 blocks 64k chunks

md0 : active raid1 sda1[0] sdb1[1]
      48829440 blocks [2/2] [UU]

unused devices: <none>

dmesg .....


[    0.000000] BIOS EBDA/lowmem at: 00091400/00091400
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.28.9r2 (root@jboat17) (gcc version 4.3.3
(Ubuntu 4.3.3-5ubuntu4) ) #2 SMP Tue May 5 15:25:34 PDT 2009 (Ubuntu
2.6.28-11.40-generic)
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000091400 (usable)
[    0.000000]  BIOS-e820: 0000000000091400 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cf730000 (usable)
[    0.000000]  BIOS-e820: 00000000cfe90000 - 00000000cfea8000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cfea8000 - 00000000cfed0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cfed0000 - 00000000cff00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
[    0.000000] DMI present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working it around.
[    0.000000] last_pfn = 0xcf730 max_arch_pfn = 0x100000
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 0000000000091400 (usable)
[    0.000000]  modified: 0000000000091400 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e6000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 00000000cf730000 (usable)
[    0.000000]  modified: 00000000cfe90000 - 00000000cfea8000 (ACPI data)
[    0.000000]  modified: 00000000cfea8000 - 00000000cfed0000 (ACPI NVS)
[    0.000000]  modified: 00000000cfed0000 - 00000000cff00000 (reserved)
[    0.000000]  modified: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  modified: 0000000100000000 - 0000000120000000 (usable)
[    0.000000] kernel direct mapping tables up to 373fe000 @ 10000-16000
[    0.000000] RAMDISK: 360c4000 - 37fef966
[    0.000000] Allocated new RAMDISK: 008b3000 - 027de966
[    0.000000] Move RAMDISK from 00000000360c4000 - 0000000037fef965 to 008b3000
- 027de965
[    0.000000] ACPI: RSDP 000FB8B0, 0014 (r0 ACPIAM)
[    0.000000] ACPI: RSDT CFE90000, 003C (r1 050809 RSDT2116 20090508 MSFT      
97)
[    0.000000] ACPI: FACP CFE90200, 0084 (r1 050809 FACP2116 20090508 MSFT      
97)
[    0.000000] ACPI Warning (tbfadt-0460): Optional field "Pm2ControlBlock" has
zero address or length: 0000000000000000/1 [20080926]
[    0.000000] ACPI: DSDT CFE90440, E2B2 (r1  A1152 A1152000        0 INTL
20060113)
[    0.000000] ACPI: FACS CFEA8000, 0040
[    0.000000] ACPI: APIC CFE90390, 006C (r1 050809 APIC2116 20090508 MSFT      
97)
[    0.000000] ACPI: MCFG CFE90400, 003C (r1 050809 OEMMCFG  20090508 MSFT      
97)
[    0.000000] ACPI: OEMB CFEA8040, 0072 (r1 050809 OEMB2116 20090508 MSFT      
97)
[    0.000000] ACPI: HPET CFE9F440, 0038 (r1 050809 OEMHPET  20090508 MSFT      
97)
[    0.000000] ACPI: SSDT CFE9F480, 088C (r1 A M I  POWERNOW        1 AMD       
 1)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 2435MB HIGHMEM available.
[    0.000000] 883MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 373fe000
[    0.000000]   low ram: 00000000 - 373fe000
[    0.000000]   bootmap 00012000 - 00018e80
[    0.000000] (9 early reservations) ==> bootmem [0000000000 - 00373fe000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 -
0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 -
0000002000]
[    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 -
0000007000]
[    0.000000]   #3 [0000100000 - 00008aea2c]    TEXT DATA BSS ==> [0000100000 -
00008aea2c]
[    0.000000]   #4 [00008af000 - 00008b3000]    INIT_PG_TABLE ==> [00008af000 -
00008b3000]
[    0.000000]   #5 [0000091400 - 0000100000]    BIOS reserved ==> [0000091400 -
0000100000]
[    0.000000]   #6 [0000010000 - 0000012000]          PGTABLE ==> [0000010000 -
0000012000]
[    0.000000]   #7 [00008b3000 - 00027de966]      NEW RAMDISK ==> [00008b3000 -
00027de966]
[    0.000000]   #8 [0000012000 - 0000019000]          BOOTMAP ==> [0000012000 -
0000019000]
[    0.000000] found SMP MP-table at [c00ff780] 000ff780
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000373fe
[    0.000000]   HighMem  0x000373fe -> 0x000cf730
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x00000091
[    0.000000]     0: 0x00000100 -> 0x000cf730
[    0.000000] On node 0 totalpages: 849585
[    0.000000] free_area_init_node: node 0, pgdat c0702100, node_mem_map
c27df200
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3937 pages, LIFO batch:0
[    0.000000]   Normal zone: 1736 pages used for memmap
[    0.000000]   Normal zone: 220470 pages, LIFO batch:31
[    0.000000]   HighMem zone: 4871 pages used for memmap
[    0.000000]   HighMem zone: 618539 pages, LIFO batch:31
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x8300 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 0000000000091000 - 0000000000092000
[    0.000000] PM: Registered nosave memory: 0000000000092000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e6000
[    0.000000] PM: Registered nosave memory: 00000000000e6000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at d0000000 (gap:
cff00000:30000000)
[    0.000000] PERCPU: Allocating 45056 bytes of per cpu data
[    0.000000] NR_CPUS: 64, nr_cpu_ids: 4, nr_node_ids 1
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total
pages: 842946
[    0.000000] Kernel command line: root=/dev/md1 ro quiet splash 
crashkernel=384M-2G:64M@16M,2G-:128M@16M
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2608.491 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.004000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.004000] allocated 16993920 bytes of page_cgroup
[    0.004000] please try cgroup_disable=memory option if you don't want
[    0.004000] Scanning for low memory corruption every 60 seconds
[    0.004000] Memory: 3313476k/3398848k available (4300k kernel code, 84020k
reserved, 2230k data, 528k init, 2493640k highmem)
[    0.004000] virtual kernel memory layout:
[    0.004000]     fixmap  : 0xffc78000 - 0xfffff000   (3612 kB)
[    0.004000]     pkmap   : 0xff400000 - 0xff800000   (4096 kB)
[    0.004000]     vmalloc : 0xf7bfe000 - 0xff3fe000   ( 120 MB)
[    0.004000]     lowmem  : 0xc0000000 - 0xf73fe000   ( 883 MB)
[    0.004000]       .init : 0xc0769000 - 0xc07ed000   ( 528 kB)
[    0.004000]       .data : 0xc0533383 - 0xc0760e60   (2230 kB)
[    0.004000]       .text : 0xc0100000 - 0xc0533383   (4300 kB)
[    0.004000] Checking if this processor honours the WP bit even in supervisor
mode...Ok.
[    0.004000] SLUB: Genslabs=12, HWalign=64, Order=0-3, MinObjects=0, CPUs=4,
Nodes=1
[    0.004000] hpet clockevent registered
[    0.004000] HPET: 4 timers in total, 1 timers will be used for per-cpu timer
[    0.004006] Calibrating delay loop (skipped), value calculated using timer
frequency.. 5216.98 BogoMIPS (lpj=10433964)
[    0.004017] Security Framework initialized
[    0.004020] SELinux:  Disabled at boot.
[    0.004029] AppArmor: AppArmor initialized
[    0.004034] Mount-cache hash table entries: 512
[    0.004105] Initializing cgroup subsys ns
[    0.004107] Initializing cgroup subsys cpuacct
[    0.004109] Initializing cgroup subsys memory
[    0.004112] Initializing cgroup subsys freezer
[    0.004119] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.004121] CPU: L2 Cache: 512K (64 bytes/line)
[    0.004122] CPU: Physical Processor ID: 0
[    0.004123] CPU: Processor Core ID: 0
[    0.004125] using C1E aware idle routine
[    0.004131] Checking 'hlt' instruction... OK.
[    0.021400] ACPI: Core revision 20080926
[    0.025665] ACPI: Checking initramfs for custom DSDT
[    0.908355] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.950821] CPU0: AMD Phenom(tm) II X4 910 Processor stepping 02
[    0.952002] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 5217.58 BogoMIPS
(lpj=10435169)
[    0.004000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.004000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    1.036605] CPU1: AMD Phenom(tm) II X4 910 Processor stepping 02
[    1.036618] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    1.040065] Booting processor 2 APIC 0x2 ip 0x6000
[    0.004000] Initializing CPU#2
[    0.004000] Calibrating delay using timer specific routine.. 5217.58 BogoMIPS
(lpj=10435179)
[    0.004000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.004000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 2
[    1.128619] CPU2: AMD Phenom(tm) II X4 910 Processor stepping 02
[    1.128641] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    1.132059] Booting processor 3 APIC 0x3 ip 0x6000
[    0.004000] Initializing CPU#3
[    0.004000] Calibrating delay using timer specific routine.. 5217.58 BogoMIPS
(lpj=10435168)
[    0.004000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.004000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 3
[    1.220646] CPU3: AMD Phenom(tm) II X4 910 Processor stepping 02
[    1.220668] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[    1.224023] Brought up 4 CPUs
[    1.224025] Total of 4 processors activated (20869.74 BogoMIPS).
[    1.224065] CPU0 attaching sched-domain:
[    1.224066]  domain 0: span 0-3 level CPU
[    1.224068]   groups: 0 1 2 3
[    1.224072] CPU1 attaching sched-domain:
[    1.224073]  domain 0: span 0-3 level CPU
[    1.224075]   groups: 1 2 3 0
[    1.224078] CPU2 attaching sched-domain:
[    1.224079]  domain 0: span 0-3 level CPU
[    1.224080]   groups: 2 3 0 1
[    1.224083] CPU3 attaching sched-domain:
[    1.224084]  domain 0: span 0-3 level CPU
[    1.224086]   groups: 3 0 1 2
[    1.224142] net_namespace: 776 bytes
[    1.224142] Booting paravirtualized kernel on bare hardware
[    1.224213] Time: 15:55:16  Date: 07/28/09
[    1.224213] regulator: core version 0.5
[    1.224213] NET: Registered protocol family 16
[    1.224213] EISA bus registered
[    1.224213] ACPI: bus type pci registered
[    1.224213] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    1.224213] PCI: Not using MMCONFIG.
[    1.224801] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=5
[    1.224802] PCI: Using configuration type 1 for base access
[    1.224804] PCI: Using configuration type 1 for extended access
[    1.224825] mtrr: your CPUs had inconsistent fixed MTRR settings
[    1.224826] mtrr: probably your BIOS does not setup all CPUs.
[    1.224828] mtrr: corrected configuration.
[    1.225286] ACPI: EC: Look up EC in DSDT
[    1.315815] ACPI: Interpreter enabled
[    1.315819] ACPI: (supports S0 S1 S3 S4 S5)
[    1.315836] ACPI: Using IOAPIC for interrupt routing
[    1.315899] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    1.321962] PCI: MCFG area at e0000000 reserved in ACPI motherboard resources
[    1.321964] PCI: Using MMCONFIG for extended config space
[    1.331398] ACPI: No dock devices found.
[    1.331472] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    1.331553] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    1.331556] pci 0000:00:04.0: PME# disabled
[    1.331575] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    1.331577] pci 0000:00:06.0: PME# disabled
[    1.331595] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    1.331597] pci 0000:00:07.0: PME# disabled
[    1.331644] pci 0000:00:11.0: reg 10 io port: [0xa000-0xa007]
[    1.331650] pci 0000:00:11.0: reg 14 io port: [0x9000-0x9003]
[    1.331656] pci 0000:00:11.0: reg 18 io port: [0x8000-0x8007]
[    1.331662] pci 0000:00:11.0: reg 1c io port: [0x7000-0x7003]
[    1.331668] pci 0000:00:11.0: reg 20 io port: [0x6000-0x600f]
[    1.331674] pci 0000:00:11.0: reg 24 32bit mmio: [0xfbaffc00-0xfbafffff]
[    1.331708] pci 0000:00:12.0: reg 10 32bit mmio: [0xfbafd000-0xfbafdfff]
[    1.331754] pci 0000:00:12.1: reg 10 32bit mmio: [0xfbafe000-0xfbafefff]
[    1.331817] pci 0000:00:12.2: reg 10 32bit mmio: [0xfbaff800-0xfbaff8ff]
[    1.331852] pci 0000:00:12.2: supports D1 D2
[    1.331853] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    1.331856] pci 0000:00:12.2: PME# disabled
[    1.331884] pci 0000:00:13.0: reg 10 32bit mmio: [0xfbaf7000-0xfbaf7fff]
[    1.331930] pci 0000:00:13.1: reg 10 32bit mmio: [0xfbafc000-0xfbafcfff]
[    1.331993] pci 0000:00:13.2: reg 10 32bit mmio: [0xfbaff400-0xfbaff4ff]
[    1.332034] pci 0000:00:13.2: supports D1 D2
[    1.332035] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    1.332039] pci 0000:00:13.2: PME# disabled
[    1.332135] pci 0000:00:14.1: reg 10 io port: [0x00-0x07]
[    1.332141] pci 0000:00:14.1: reg 14 io port: [0x00-0x03]
[    1.332147] pci 0000:00:14.1: reg 18 io port: [0x00-0x07]
[    1.332152] pci 0000:00:14.1: reg 1c io port: [0x00-0x03]
[    1.332158] pci 0000:00:14.1: reg 20 io port: [0xff00-0xff0f]
[    1.332209] pci 0000:00:14.2: reg 10 64bit mmio: [0xfbaf0000-0xfbaf3fff]
[    1.332239] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    1.332243] pci 0000:00:14.2: PME# disabled
[    1.332330] pci 0000:00:14.5: reg 10 32bit mmio: [0xfbaf6000-0xfbaf6fff]
[    1.332440] pci 0000:01:05.0: reg 10 32bit mmio: [0xd0000000-0xdfffffff]
[    1.332443] pci 0000:01:05.0: reg 14 io port: [0xb000-0xb0ff]
[    1.332446] pci 0000:01:05.0: reg 18 32bit mmio: [0xfbce0000-0xfbceffff]
[    1.332452] pci 0000:01:05.0: reg 24 32bit mmio: [0xfbb00000-0xfbbfffff]
[    1.332458] pci 0000:01:05.0: supports D1 D2
[    1.332471] pci 0000:01:05.1: reg 10 32bit mmio: [0xfbcfc000-0xfbcfffff]
[    1.332483] pci 0000:01:05.1: supports D1 D2
[    1.332519] pci 0000:00:01.0: bridge io port: [0xb000-0xbfff]
[    1.332521] pci 0000:00:01.0: bridge 32bit mmio: [0xfbb00000-0xfbcfffff]
[    1.332524] pci 0000:00:01.0: bridge 64bit mmio pref: [0xd0000000-0xdfffffff]
[    1.332582] pci 0000:02:00.0: reg 10 64bit mmio: [0xfbdffc00-0xfbdffc7f]
[    1.332598] pci 0000:02:00.0: reg 18 64bit mmio: [0xfbdf8000-0xfbdfbfff]
[    1.332606] pci 0000:02:00.0: reg 20 io port: [0xcc00-0xcc7f]
[    1.332622] pci 0000:02:00.0: reg 30 32bit mmio: [0xfbd00000-0xfbd7ffff]
[    1.332634] pci 0000:02:00.0: supports D1 D2
[    1.332687] pci 0000:00:04.0: bridge io port: [0xc000-0xcfff]
[    1.332689] pci 0000:00:04.0: bridge 32bit mmio: [0xfbd00000-0xfbdfffff]
[    1.332734] pci 0000:03:00.0: reg 10 64bit mmio: [0xfbec0000-0xfbefffff]
[    1.332740] pci 0000:03:00.0: reg 18 io port: [0xdc00-0xdc7f]
[    1.332769] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    1.332773] pci 0000:03:00.0: PME# disabled
[    1.332821] pci 0000:00:06.0: bridge io port: [0xd000-0xdfff]
[    1.332823] pci 0000:00:06.0: bridge 32bit mmio: [0xfbe00000-0xfbefffff]
[    1.332885] pci 0000:04:00.0: reg 10 64bit mmio: [0xfbfff800-0xfbffffff]
[    1.332894] pci 0000:04:00.0: reg 18 io port: [0xe800-0xe8ff]
[    1.332938] pci 0000:04:00.0: supports D2
[    1.332939] pci 0000:04:00.0: PME# supported from D2 D3hot D3cold
[    1.332944] pci 0000:04:00.0: PME# disabled
[    1.333000] pci 0000:00:07.0: bridge io port: [0xe000-0xefff]
[    1.333002] pci 0000:00:07.0: bridge 32bit mmio: [0xfbf00000-0xfbffffff]
[    1.333055] pci 0000:00:14.4: transparent bridge
[    1.333074] bus 00 -> node 0
[    1.333079] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.333384] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    1.333496] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE4._PRT]
[    1.333605] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE6._PRT]
[    1.333710] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
[    1.333830] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
[    1.336464] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 *10 11 12 14 15)
[    1.336611] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 *10 11 12 14 15)
[    1.336758] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 *11 12 14 15)
[    1.336903] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 *7 10 11 12 14 15)
[    1.337049] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 12 14 15) *0,
disabled.
[    1.337196] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 12 14 15) *0,
disabled.
[    1.337342] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 10 *11 12 14 15)
[    1.337488] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 12 14 15) *0,
disabled.
[    1.337612] ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] -
EE, should be E5 [20080926]
[    1.337666] ACPI: WMI: Mapper loaded
[    1.337694] SCSI subsystem initialized
[    1.337694] libata version 3.00 loaded.
[    1.337694] usbcore: registered new interface driver usbfs
[    1.337694] usbcore: registered new interface driver hub
[    1.337694] usbcore: registered new device driver usb
[    1.337694] PCI: Using ACPI for IRQ routing
[    1.344016] Bluetooth: Core ver 2.13
[    1.344034] NET: Registered protocol family 31
[    1.344034] Bluetooth: HCI device and connection manager initialized
[    1.344034] Bluetooth: HCI socket layer initialized
[    1.344034] NET: Registered protocol family 8
[    1.344034] NET: Registered protocol family 20
[    1.344034] NetLabel: Initializing
[    1.344034] NetLabel:  domain hash size = 128
[    1.344034] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.344039] NetLabel:  unlabeled traffic allowed by default
[    1.344067] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 2303, 0
[    1.344071] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    1.348024] hpet: hpet2 irq 2303 for MSI
[    1.348041] AppArmor: AppArmor Filesystem Enabled
[    1.352018] Switched to high resolution mode on CPU 0
[    1.352612] Switched to high resolution mode on CPU 1
[    1.352639] Switched to high resolution mode on CPU 2
[    1.352667] Switched to high resolution mode on CPU 3
[    1.356029] pnp: PnP ACPI init
[    1.356037] ACPI: bus type pnp registered
[    1.360788] pnp: PnP ACPI: found 17 devices
[    1.360789] ACPI: ACPI bus type pnp unregistered
[    1.360791] PnPBIOS: Disabled by ACPI PNP
[    1.360801] system 00:09: iomem range 0xfec00000-0xfec00fff has been reserved
[    1.360803] system 00:09: iomem range 0xfee00000-0xfee00fff has been reserved
[    1.360807] system 00:0a: ioport range 0x4d0-0x4d1 has been reserved
[    1.360808] system 00:0a: ioport range 0x40b-0x40b has been reserved
[    1.360810] system 00:0a: ioport range 0x4d6-0x4d6 has been reserved
[    1.360812] system 00:0a: ioport range 0xc00-0xc01 has been reserved
[    1.360813] system 00:0a: ioport range 0xc14-0xc14 has been reserved
[    1.360815] system 00:0a: ioport range 0xc50-0xc51 has been reserved
[    1.360817] system 00:0a: ioport range 0xc52-0xc52 has been reserved
[    1.360818] system 00:0a: ioport range 0xc6c-0xc6c has been reserved
[    1.360820] system 00:0a: ioport range 0xc6f-0xc6f has been reserved
[    1.360822] system 00:0a: ioport range 0xcd0-0xcd1 has been reserved
[    1.360823] system 00:0a: ioport range 0xcd2-0xcd3 has been reserved
[    1.360825] system 00:0a: ioport range 0xcd4-0xcd5 has been reserved
[    1.360827] system 00:0a: ioport range 0xcd6-0xcd7 has been reserved
[    1.360828] system 00:0a: ioport range 0xcd8-0xcdf has been reserved
[    1.360830] system 00:0a: ioport range 0xb00-0xb3f has been reserved
[    1.360832] system 00:0a: ioport range 0x800-0x89f has been reserved
[    1.360833] system 00:0a: ioport range 0xb00-0xb0f has been reserved
[    1.360835] system 00:0a: ioport range 0xb20-0xb3f has been reserved
[    1.360837] system 00:0a: ioport range 0x900-0x90f has been reserved
[    1.360839] system 00:0a: ioport range 0x910-0x91f has been reserved
[    1.360840] system 00:0a: ioport range 0xfe00-0xfefe has been reserved
[    1.360843] system 00:0a: iomem range 0xffb80000-0xffbfffff has been reserved
[    1.360845] system 00:0a: iomem range 0xfec10000-0xfec1001f has been reserved
[    1.360849] system 00:0e: ioport range 0x230-0x23f has been reserved
[    1.360850] system 00:0e: ioport range 0x290-0x29f has been reserved
[    1.360852] system 00:0e: ioport range 0xf40-0xf4f has been reserved
[    1.360854] system 00:0e: ioport range 0xa30-0xa3f has been reserved
[    1.360857] system 00:0f: iomem range 0xe0000000-0xefffffff has been reserved
[    1.360861] system 00:10: iomem range 0x0-0x9ffff could not be reserved
[    1.360863] system 00:10: iomem range 0xc0000-0xcffff could not be reserved
[    1.360865] system 00:10: iomem range 0xe0000-0xfffff could not be reserved
[    1.360866] system 00:10: iomem range 0x100000-0xcfefffff could not be
reserved
[    1.360868] system 00:10: iomem range 0xfec00000-0xffffffff could not be
reserved
[    1.395491] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    1.395493] pci 0000:00:01.0:   IO window: 0xb000-0xbfff
[    1.395495] pci 0000:00:01.0:   MEM window: 0xfbb00000-0xfbcfffff
[    1.395498] pci 0000:00:01.0:   PREFETCH window:
0x000000d0000000-0x000000dfffffff
[    1.395501] pci 0000:00:04.0: PCI bridge, secondary bus 0000:02
[    1.395503] pci 0000:00:04.0:   IO window: 0xc000-0xcfff
[    1.395505] pci 0000:00:04.0:   MEM window: 0xfbd00000-0xfbdfffff
[    1.395507] pci 0000:00:04.0:   PREFETCH window: disabled
[    1.395510] pci 0000:00:06.0: PCI bridge, secondary bus 0000:03
[    1.395511] pci 0000:00:06.0:   IO window: 0xd000-0xdfff
[    1.395513] pci 0000:00:06.0:   MEM window: 0xfbe00000-0xfbefffff
[    1.395515] pci 0000:00:06.0:   PREFETCH window: disabled
[    1.395518] pci 0000:00:07.0: PCI bridge, secondary bus 0000:04
[    1.395520] pci 0000:00:07.0:   IO window: 0xe000-0xefff
[    1.395522] pci 0000:00:07.0:   MEM window: 0xfbf00000-0xfbffffff
[    1.395524] pci 0000:00:07.0:   PREFETCH window: disabled
[    1.395526] pci 0000:00:14.4: PCI bridge, secondary bus 0000:05
[    1.395527] pci 0000:00:14.4:   IO window: disabled
[    1.395532] pci 0000:00:14.4:   MEM window: disabled
[    1.395535] pci 0000:00:14.4:   PREFETCH window: disabled
[    1.395547] pci 0000:00:04.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.395549] pci 0000:00:04.0: setting latency timer to 64
[    1.395553] pci 0000:00:06.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    1.395555] pci 0000:00:06.0: setting latency timer to 64
[    1.395559] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.395561] pci 0000:00:07.0: setting latency timer to 64
[    1.395567] bus: 00 index 0 io port: [0x00-0xffff]
[    1.395568] bus: 00 index 1 mmio: [0x000000-0xffffffff]
[    1.395570] bus: 01 index 0 io port: [0xb000-0xbfff]
[    1.395571] bus: 01 index 1 mmio: [0xfbb00000-0xfbcfffff]
[    1.395573] bus: 01 index 2 mmio: [0xd0000000-0xdfffffff]
[    1.395574] bus: 01 index 3 mmio: [0x0-0x0]
[    1.395575] bus: 02 index 0 io port: [0xc000-0xcfff]
[    1.395577] bus: 02 index 1 mmio: [0xfbd00000-0xfbdfffff]
[    1.395578] bus: 02 index 2 mmio: [0x0-0x0]
[    1.395579] bus: 02 index 3 mmio: [0x0-0x0]
[    1.395580] bus: 03 index 0 io port: [0xd000-0xdfff]
[    1.395582] bus: 03 index 1 mmio: [0xfbe00000-0xfbefffff]
[    1.395583] bus: 03 index 2 mmio: [0x0-0x0]
[    1.395584] bus: 03 index 3 mmio: [0x0-0x0]
[    1.395585] bus: 04 index 0 io port: [0xe000-0xefff]
[    1.395587] bus: 04 index 1 mmio: [0xfbf00000-0xfbffffff]
[    1.395588] bus: 04 index 2 mmio: [0x0-0x0]
[    1.395589] bus: 04 index 3 mmio: [0x0-0x0]
[    1.395590] bus: 05 index 0 mmio: [0x0-0x0]
[    1.395591] bus: 05 index 1 mmio: [0x0-0x0]
[    1.395593] bus: 05 index 2 mmio: [0x0-0x0]
[    1.395594] bus: 05 index 3 io port: [0x00-0xffff]
[    1.395595] bus: 05 index 4 mmio: [0x000000-0xffffffff]
[    1.395603] NET: Registered protocol family 2
[    1.408063] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    1.408222] TCP established hash table entries: 131072 (order: 8, 1048576
bytes)
[    1.408486] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    1.408623] TCP: Hash tables configured (established 131072 bind 65536)
[    1.408624] TCP reno registered
[    1.416071] NET: Registered protocol family 1
[    1.416142] checking if image is initramfs... it is
[    3.190466] Freeing initrd memory: 31918k freed
[    3.190789] cpufreq: No nForce2 chipset.
[    3.190871] audit: initializing netlink socket (disabled)
[    3.190883] type=2000 audit(1248796517.188:1): initialized
[    3.196439] highmem bounce pool size: 64 pages
[    3.196443] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    3.197315] VFS: Disk quotas dquot_6.5.1
[    3.197350] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    3.197813] NTFS driver 2.1.29 [Flags: R/W].
[    3.197861] fuse init (API version 7.10)
[    3.197908] msgmni has been set to 1665
[    3.198044] alg: No test for stdrng (krng)
[    3.198053] io scheduler noop registered
[    3.198055] io scheduler anticipatory registered
[    3.198056] io scheduler deadline registered
[    3.198068] io scheduler cfq registered (default)
[    3.380031] pci 0000:01:05.0: Boot video device
[    3.385132] pcieport-driver 0000:00:04.0: setting latency timer to 64
[    3.385151] pcieport-driver 0000:00:04.0: found MSI capability
[    3.385165] pcieport-driver 0000:00:04.0: irq 2302 for MSI/MSI-X
[    3.385171] pci_express 0000:00:04.0:pcie00: allocate port service
[    3.385180] pci_express 0000:00:04.0:pcie03: allocate port service
[    3.385206] pcieport-driver 0000:00:06.0: setting latency timer to 64
[    3.385222] pcieport-driver 0000:00:06.0: found MSI capability
[    3.385234] pcieport-driver 0000:00:06.0: irq 2301 for MSI/MSI-X
[    3.385239] pci_express 0000:00:06.0:pcie00: allocate port service
[    3.385246] pci_express 0000:00:06.0:pcie03: allocate port service
[    3.385271] pcieport-driver 0000:00:07.0: setting latency timer to 64
[    3.385287] pcieport-driver 0000:00:07.0: found MSI capability
[    3.385299] pcieport-driver 0000:00:07.0: irq 2300 for MSI/MSI-X
[    3.385304] pci_express 0000:00:07.0:pcie00: allocate port service
[    3.385311] pci_express 0000:00:07.0:pcie03: allocate port service
[    3.385343] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    3.385349] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    3.385434] input: Power Button (FF) as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    3.385436] ACPI: Power Button (FF) [PWRF]
[    3.385467] input: Power Button (CM) as
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    3.385473] ACPI: Power Button (CM) [PWRB]
[    3.385735] processor ACPI_CPU:00: registered as cooling_device0
[    3.385739] ACPI: Processor [P001] (supports 8 throttling states)
[    3.385768] processor ACPI_CPU:01: registered as cooling_device1
[    3.385788] processor ACPI_CPU:02: registered as cooling_device2
[    3.385810] processor ACPI_CPU:03: registered as cooling_device3
[    3.388699] isapnp: Scanning for PnP cards...
[    3.742504] isapnp: No Plug & Play device found
[    3.752212] Serial: 8250/16550 driver4 ports, IRQ sharing enabled
[    3.752309] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    3.752577] 00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    3.753016] brd: module loaded
[    3.753185] loop: module loaded
[    3.753224] Fixed MDIO Bus: probed
[    3.753228] PPP generic driver version 2.4.2
[    3.753263] input: Macintosh mouse button emulation as
/devices/virtual/input/input2
[    3.753280] Driver 'sd' needs updating - please use bus_type methods
[    3.753285] Driver 'sr' needs updating - please use bus_type methods
[    3.753304] ahci 0000:00:11.0: version 3.0
[    3.753317] ahci 0000:00:11.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    3.753436] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x3f
impl RAID mode
[    3.753439] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio
slum part
[    3.753752] scsi0 : ahci
[    3.753815] scsi1 : ahci
[    3.753850] scsi2 : ahci
[    3.753887] scsi3 : ahci
[    3.753922] scsi4 : ahci
[    3.753954] scsi5 : ahci
[    3.754017] ata1: SATA max UDMA/133 irq_stat 0x00400000 irq 22, PHY RDY
changed
[    3.754020] ata2: SATA max UDMA/133 abar m1024@0xfbaffc00 port 0xfbaffd80 irq
22
[    3.754023] ata3: SATA max UDMA/133 abar m1024@0xfbaffc00 port 0xfbaffe00 irq
22
[    3.754025] ata4: SATA max UDMA/133 abar m1024@0xfbaffc00 port 0xfbaffe80 irq
22
[    3.754028] ata5: SATA max UDMA/133 abar m1024@0xfbaffc00 port 0xfbafff00 irq
22
[    3.754030] ata6: SATA max UDMA/133 abar m1024@0xfbaffc00 port 0xfbafff80 irq
22
[    4.640027] ata1: softreset failed (device not ready)
[    4.640060] ata1: failed due to HW bug, retry pmp=0
[    4.804037] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.812654] ata1.00: ATA-8: WDC WD5001AALS-00L3B2, 01.03B01, max UDMA/133
[    4.812656] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    4.813587] ata1.00: configured for UDMA/133
[    5.312030] ata2: softreset failed (device not ready)
[    5.312062] ata2: failed due to HW bug, retry pmp=0
[    5.476037] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.482656] ata2.00: ATA-8: WDC WD5001AALS-00L3B2, 01.03B01, max UDMA/133
[    5.482658] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    5.483586] ata2.00: configured for UDMA/133
[    5.816035] ata3: SATA link down (SStatus 0 SControl 300)
[    6.152035] ata4: SATA link down (SStatus 0 SControl 300)
[    6.652027] ata5: softreset failed (device not ready)
[    6.652058] ata5: failed due to HW bug, retry pmp=0
[    6.816037] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    6.817233] ata5.00: ATAPI: HL-DT-STDVD-RAM GH22NS30, 1.01, max UDMA/100
[    6.818695] ata5.00: configured for UDMA/100
[    7.152035] ata6: SATA link down (SStatus 0 SControl 300)
[    7.168093] scsi 0:0:0:0: Direct-Access     ATA      WDC WD5001AALS-0 01.0
PQ: 0 ANSI: 5
[    7.168149] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors: (500
GB/465 GiB)
[    7.168158] sd 0:0:0:0: [sda] Write Protect is off
[    7.168160] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    7.168173] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    7.168203] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors: (500
GB/465 GiB)
[    7.168211] sd 0:0:0:0: [sda] Write Protect is off
[    7.168212] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    7.168224] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    7.168226]  sda: sda1 sda2 < sda5 sda6 > sda3
[    7.191296] sd 0:0:0:0: [sda] Attached SCSI disk
[    7.191325] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.191375] scsi 1:0:0:0: Direct-Access     ATA      WDC WD5001AALS-0 01.0
PQ: 0 ANSI: 5
[    7.191425] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500
GB/465 GiB)
[    7.191434] sd 1:0:0:0: [sdb] Write Protect is off
[    7.191436] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    7.191449] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    7.191482] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500
GB/465 GiB)
[    7.191489] sd 1:0:0:0: [sdb] Write Protect is off
[    7.191491] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    7.191503] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    7.191505]  sdb: sdb1 sdb2 < sdb5 sdb6 >
[    7.214122] sd 1:0:0:0: [sdb] Attached SCSI disk
[    7.214145] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    7.215245] scsi 4:0:0:0: CD-ROM            HL-DT-ST DVD-RAM GH22NS30 1.01
PQ: 0 ANSI: 5
[    7.218469] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda
tray
[    7.218472] Uniform CD-ROM driver Revision: 3.20
[    7.218530] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    7.218552] sr 4:0:0:0: Attached scsi generic sg2 type 5
[    7.218627] sata_sil24 0000:02:00.0: version 1.1
[    7.218638] sata_sil24 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ
16
[    7.218701] sata_sil24 0000:02:00.0: setting latency timer to 64
[    7.218830] scsi6 : sata_sil24
[    7.218879] scsi7 : sata_sil24
[    7.218900] ata7: SATA max UDMA/100 host m128@0xfbdffc00 port 0xfbdf8000 irq
16
[    7.218903] ata8: SATA max UDMA/100 host m128@0xfbdffc00 port 0xfbdfa000 irq
16
[    9.416044] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    9.416274] ata7.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat
0x1/0x9
[    9.416530] ata7.00: hard resetting link
[    9.736313] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    9.736316] ata7.01: hard resetting link
[   10.056310] ata7.01: SATA link down (SStatus 0 SControl 320)
[   10.056313] ata7.02: hard resetting link
[   10.376311] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   10.376314] ata7.03: hard resetting link
[   10.696312] ata7.03: SATA link down (SStatus 0 SControl 320)
[   10.696315] ata7.04: hard resetting link
[   11.016313] ata7.04: SATA link down (SStatus 0 SControl 320)
[   11.016316] ata7.05: hard resetting link
[   11.336307] ata7.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   11.336309] ata7.06: hard resetting link
[   11.656311] ata7.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   11.768020] ata7.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[   11.768024] ata7.15: hard resetting link
[   11.768026] ata7: controller in dubious state, performing PORT_RST
[   14.000044] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   14.736033] ata7.00: hard resetting link
[   15.056312] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   15.376033] ata7.02: hard resetting link
[   15.696310] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   16.336051] ata7.05: hard resetting link
[   16.656307] ata7.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   16.656310] ata7.06: hard resetting link
[   16.976309] ata7.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   16.977034] ata7.00: ATA-8: WDC WD7501AALS-00J7B0, 05.00K05, max UDMA/133
[   16.977037] ata7.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   16.977888] ata7.00: configured for UDMA/100
[   17.088021] ata7.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[   17.088024] ata7.15: hard resetting link
[   17.088026] ata7: controller in dubious state, performing PORT_RST
[   19.320045] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   19.320259] ata7.00: hard resetting link
[   19.640311] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   19.640314] ata7.01: hard resetting link
[   19.960310] ata7.01: SATA link down (SStatus 0 SControl 320)
[   20.696031] ata7.02: hard resetting link
[   21.016312] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   21.016315] ata7.03: hard resetting link
[   21.336311] ata7.03: SATA link down (SStatus 0 SControl 320)
[   21.336313] ata7.04: hard resetting link
[   21.656311] ata7.04: SATA link down (SStatus 0 SControl 320)
[   21.656314] ata7.05: hard resetting link
[   21.976308] ata7.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   21.976311] ata7.06: hard resetting link
[   22.296309] ata7.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   22.297890] ata7.00: configured for UDMA/100
[   22.298586] ata7.02: ATA-8: WDC WD7501AALS-00J7B1, 05.00K05, max UDMA/133
[   22.298588] ata7.02: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   22.299380] ata7.02: configured for UDMA/100
[   22.299436] ata7.05: unsupported device, disabling
[   22.299437] ata7.05: disabled
[   22.299815] ata7: EH complete
[   24.376038] ata8: SATA link down (SStatus 0 SControl 0)
[   24.376101] scsi 6:0:0:0: Direct-Access     ATA      WDC WD7501AALS-0 05.0
PQ: 0 ANSI: 5
[   24.376158] sd 6:0:0:0: [sdc] 1465149168 512-byte hardware sectors: (750
GB/698 GiB)
[   24.376166] sd 6:0:0:0: [sdc] Write Protect is off
[   24.376168] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   24.376180] sd 6:0:0:0: [sdc] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[   24.376210] sd 6:0:0:0: [sdc] 1465149168 512-byte hardware sectors: (750
GB/698 GiB)
[   24.376217] sd 6:0:0:0: [sdc] Write Protect is off
[   24.376218] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   24.376230] sd 6:0:0:0: [sdc] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[   24.376232]  sdc: sdc1 sdc2
[   24.415476] sd 6:0:0:0: [sdc] Attached SCSI disk
[   24.415501] sd 6:0:0:0: Attached scsi generic sg3 type 0
[   24.415543] scsi 6:2:0:0: Direct-Access     ATA      WDC WD7501AALS-0 05.0
PQ: 0 ANSI: 5
[   24.415591] sd 6:2:0:0: [sdd] 1465149168 512-byte hardware sectors: (750
GB/698 GiB)
[   24.415599] sd 6:2:0:0: [sdd] Write Protect is off
[   24.415601] sd 6:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   24.415613] sd 6:2:0:0: [sdd] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[   24.415641] sd 6:2:0:0: [sdd] 1465149168 512-byte hardware sectors: (750
GB/698 GiB)
[   24.415648] sd 6:2:0:0: [sdd] Write Protect is off
[   24.415649] sd 6:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   24.415661] sd 6:2:0:0: [sdd] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[   24.415663]  sdd: sdd1 sdd2
[   24.429473] sd 6:2:0:0: [sdd] Attached SCSI disk
[   24.429497] sd 6:2:0:0: Attached scsi generic sg4 type 0
[   24.429609] pata_atiixp 0000:00:14.1: PCI INT A -> GSI 16 (level, low) -> IRQ
16
[   24.429627] pata_atiixp 0000:00:14.1: setting latency timer to 64
[   24.429693] scsi8 : pata_atiixp
[   24.429744] scsi9 : pata_atiixp
[   24.430975] ata9: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
[   24.430977] ata10: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
[   24.748373] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   24.748389] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[   24.748401] ehci_hcd 0000:00:12.2: EHCI Host Controller
[   24.748432] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus
number 1
[   24.748447] ehci_hcd 0000:00:12.2: applying AMD SB600/SB700 USB freeze
workaround
[   24.748462] ehci_hcd 0000:00:12.2: debug port 1
[   24.748474] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfbaff800
[   24.760020] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[   24.760076] usb usb1: configuration #1 chosen from 1 choice
[   24.760092] hub 1-0:1.0: USB hub found
[   24.760097] hub 1-0:1.0: 6 ports detected
[   24.760167] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[   24.760178] ehci_hcd 0000:00:13.2: EHCI Host Controller
[   24.760210] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus
number 2
[   24.760224] ehci_hcd 0000:00:13.2: applying AMD SB600/SB700 USB freeze
workaround
[   24.760239] ehci_hcd 0000:00:13.2: debug port 1
[   24.760251] ehci_hcd 0000:00:13.2: irq 19, io mem 0xfbaff400
[   24.772019] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[   24.772068] usb usb2: configuration #1 chosen from 1 choice
[   24.772083] hub 2-0:1.0: USB hub found
[   24.772088] hub 2-0:1.0: 6 ports detected
[   24.772153] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   24.772168] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   24.772179] ohci_hcd 0000:00:12.0: OHCI Host Controller
[   24.772202] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus
number 3
[   24.772215] ohci_hcd 0000:00:12.0: irq 16, io mem 0xfbafd000
[   24.832049] usb usb3: configuration #1 chosen from 1 choice
[   24.832064] hub 3-0:1.0: USB hub found
[   24.832071] hub 3-0:1.0: 3 ports detected
[   24.832128] ohci_hcd 0000:00:12.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   24.832139] ohci_hcd 0000:00:12.1: OHCI Host Controller
[   24.832163] ohci_hcd 0000:00:12.1: new USB bus registered, assigned bus
number 4
[   24.832174] ohci_hcd 0000:00:12.1: irq 16, io mem 0xfbafe000
[   24.888050] usb usb4: configuration #1 chosen from 1 choice
[   24.888065] hub 4-0:1.0: USB hub found
[   24.888072] hub 4-0:1.0: 3 ports detected
[   24.888131] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   24.888142] ohci_hcd 0000:00:13.0: OHCI Host Controller
[   24.888166] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus
number 5
[   24.888182] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfbaf7000
[   24.944043] usb usb5: configuration #1 chosen from 1 choice
[   24.944058] hub 5-0:1.0: USB hub found
[   24.944069] hub 5-0:1.0: 3 ports detected
[   24.944128] ohci_hcd 0000:00:13.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   24.944138] ohci_hcd 0000:00:13.1: OHCI Host Controller
[   24.944162] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus
number 6
[   24.944174] ohci_hcd 0000:00:13.1: irq 18, io mem 0xfbafc000
[   25.000047] usb usb6: configuration #1 chosen from 1 choice
[   25.000063] hub 6-0:1.0: USB hub found
[   25.000069] hub 6-0:1.0: 3 ports detected
[   25.000134] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[   25.000145] ohci_hcd 0000:00:14.5: OHCI Host Controller
[   25.000171] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus
number 7
[   25.000182] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfbaf6000
[   25.056049] usb usb7: configuration #1 chosen from 1 choice
[   25.056064] hub 7-0:1.0: USB hub found
[   25.056070] hub 7-0:1.0: 2 ports detected
[   25.056129] uhci_hcd: USB Universal Host Controller Interface driver
[   25.056173] usbcore: registered new interface driver libusual
[   25.056191] usbcore: registered new interface driver usbserial
[   25.056197] USB Serial support registered for generic
[   25.128025] usb 2-4: new high speed USB device using ehci_hcd and address 2
[   25.262056] usb 2-4: configuration #1 chosen from 2 choices
[   25.376024] usb 2-5: new high speed USB device using ehci_hcd and address 3
[   25.510311] usb 2-5: configuration #1 chosen from 1 choice
[   25.644022] usb 4-3: new low speed USB device using ohci_hcd and address 2
[   25.812229] usb 4-3: configuration #1 chosen from 1 choice
[   25.814282] usbcore: registered new interface driver usbserial_generic
[   25.814284] usbserial: USB Serial Driver core
[   25.814314] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PSMS] at 0x60,0x64 irq
1,12
[   25.814603] serio: i8042 KBD port at 0x60,0x64 irq 1
[   25.814611] serio: i8042 AUX port at 0x60,0x64 irq 12
[   25.815225] mice: PS/2 mouse device common for all mice
[   25.815314] rtc_cmos 00:05: RTC can wake from S4
[   25.815333] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[   25.815356] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   25.815397] device-mapper: uevent: version 1.0.3
[   25.815471] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised:
dm-devel@redhat.com
[   25.815583] device-mapper: multipath: version 1.0.5 loaded
[   25.815584] device-mapper: multipath round-robin: version 1.0.0 loaded
[   25.815639] EISA: Probing bus 0 at eisa.0
[   25.815661] Cannot allocate resource for EISA slot 6
[   25.815663] Cannot allocate resource for EISA slot 7
[   25.815664] Cannot allocate resource for EISA slot 8
[   25.815665] EISA: Detected 0 cards.
[   25.815740] cpuidle: using governor ladder
[   25.815741] cpuidle: using governor menu
[   25.816044] TCP cubic registered
[   25.816109] NET: Registered protocol family 10
[   25.816360] lo: Disabled Privacy Extensions
[   25.816554] NET: Registered protocol family 17
[   25.816564] Bluetooth: L2CAP ver 2.11
[   25.816565] Bluetooth: L2CAP socket layer initialized
[   25.816567] Bluetooth: SCO (Voice Link) ver 0.6
[   25.816568] Bluetooth: SCO socket layer initialized
[   25.816613] Bluetooth: RFCOMM socket layer initialized
[   25.816616] Bluetooth: RFCOMM TTY layer initialized
[   25.816617] Bluetooth: RFCOMM ver 1.10
[   25.816671] powernow-k8: Found 1 AMD Phenom(tm) II X4 910 Processor
processors (4 cpu cores) (version 2.20.00)
[   25.816701] powernow-k8:    0 : pstate 0 (2600 MHz)
[   25.816703] powernow-k8:    1 : pstate 1 (1900 MHz)
[   25.816705] powernow-k8:    2 : pstate 2 (1400 MHz)
[   25.816706] powernow-k8:    3 : pstate 3 (800 MHz)
[   25.816881] Using IPI No-Shortcut mode
[   25.816922] registered taskstats version 1
[   25.817005]   Magic number: 1:592:943
[   25.817020] tty tty0: hash matches
[   25.817021] tty console: hash matches
[   25.817063] rtc_cmos 00:05: setting system clock to 2009-07-28 15:55:40 UTC
(1248796540)
[   25.817065] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[   25.817066] EDD information not available.
[   25.817221] Freeing unused kernel memory: 528k freed
[   25.817328] Write protecting the kernel text: 4304k
[   25.817366] Write protecting the kernel read-only data: 1552k
[   25.833350] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input3
[   25.905400] md: linear personality registered for level -1
[   25.906975] md: multipath personality registered for level -4
[   25.908387] md: raid0 personality registered for level 0
[   25.910616] md: raid1 personality registered for level 1
[   25.911903] xor: automatically using best checksumming function: pIII_sse
[   25.928504]    pIII_sse  : 10443.000 MB/sec
[   25.928506] xor: using function: pIII_sse (10443.000 MB/sec)
[   25.929384] async_tx: api initialized (async)
[   26.000058] raid6: int32x1   1190 MB/s
[   26.069546] raid6: int32x2   1157 MB/s
[   26.137520] raid6: int32x4    694 MB/s
[   26.205521] raid6: int32x8    584 MB/s
[   26.273514] raid6: mmxx1     2107 MB/s
[   26.341517] raid6: mmxx2     4109 MB/s
[   26.409524] raid6: sse1x1    1981 MB/s
[   26.477511] raid6: sse1x2    3342 MB/s
[   26.545517] raid6: sse2x1    3735 MB/s
[   26.612305] raid6: sse2x2    6362 MB/s
[   26.612306] raid6: using algorithm sse2x2 (6362 MB/s)
[   26.612308] md: raid6 personality registered for level 6
[   26.612310] md: raid5 personality registered for level 5
[   26.612311] md: raid4 personality registered for level 4
[   26.616776] md: raid10 personality registered for level 10
[   26.645429] Floppy drive(s): fd0 is 1.44M
[   26.656573] ATL1E 0000:03:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.656582] ATL1E 0000:03:00.0: setting latency timer to 64
[   26.665263] FDC 0 is a post-1991 82077
[   26.667305] ohci1394 0000:04:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   26.667313] ohci1394 0000:04:00.0: setting latency timer to 64
[   26.669800] usbcore: registered new interface driver hiddev
[   26.673463] input: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as
/devices/pci0000:00/0000:00:12.1/usb4/4-3/4-3:1.0/input/input4
[   26.719185] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19] 
MMIO=[fbfff800-fbffffff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   26.736305] generic-usb 0003:045E:0040.0001: input,hidraw0: USB HID v1.10
Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on
usb-0000:00:12.1-3/input0
[   26.736319] usbcore: registered new interface driver usbhid
[   26.736322] usbhid: v2.6:USB HID core driver
[   26.741273] md: bind<sdb1>
[   26.742923] md: bind<sda1>
[   26.744053] raid1: raid set md0 active with 2 out of 2 mirrors
[   26.746790]  md0: unknown partition table
[   26.784428] md: bind<sda6>
[   26.810936] md: bind<sdb6>
[   26.812029] md1: setting max_sectors to 128, segment boundary to 32767
[   26.812031] raid0: looking at sdb6
[   26.812033] raid0:   comparing sdb6(390628352) with sdb6(390628352)
[   26.812035] raid0:   END
[   26.812036] raid0:   ==> UNIQUE
[   26.812037] raid0: 1 zones
[   26.812038] raid0: looking at sda6
[   26.812039] raid0:   comparing sda6(390628352) with sdb6(390628352)
[   26.812041] raid0:   EQUAL
[   26.812042] raid0: FINAL 1 zones
[   26.812043] raid0: done.
[   26.812044] raid0 : md_size is 781256704 blocks.
[   26.812045] raid0 : conf->hash_spacing is 781256704 blocks.
[   26.812046] raid0 : nb_zone is 1.
[   26.812047] raid0 : Allocating 4 bytes for hash.
[   26.813074]  md1: unknown partition table
[   27.053168] PM: Starting manual resume from disk
[   27.053170] PM: Resume from partition 8:5
[   27.053171] PM: Checking hibernation image.
[   27.053307] PM: Resume from disk failed.
[   27.080982] kjournald starting.  Commit interval 5 seconds
[   27.080988] EXT3-fs: mounted filesystem with ordered data mode.
[   27.992085] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001e8c0001c87e9f]
[   30.454486] udev: starting version 141
[   30.896714] ACPI: I/O resource piix4_smbus [0xb00-0xb07] conflicts with ACPI
region SOR1 [0xb00-0xb0f]
[   30.896716] ACPI: Device needs an ACPI driver
[   30.896722] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00,
revision 0
[   30.957313] md: bind<sdd1>
[   30.974010] md: bind<sdd2>
[   31.036194] shpchp 0000:00:01.0: HPC vendor_id 1022 device_id 9602 ss_vid 0
ss_did 0
[   31.036197] shpchp 0000:00:01.0: Cannot reserve MMIO region
[   31.036234] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   31.222987] input: PC Speaker as /devices/platform/pcspkr/input/input5
[   31.302362] Linux agpgart interface v0.103
[   31.834511] fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies,
Starnberg, GERMANY' taints kernel.
[   31.856130] [fglrx] Maximum main memory to use for locked dma buffers: 3118
MBytes.
[   31.856147] [fglrx]   vendor: 1002 device: 9614 count: 1
[   31.856330] [fglrx] ioport: bar 1, base 0xb000, size: 0x100
[   31.856341] pci 0000:01:05.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   31.856345] pci 0000:01:05.0: setting latency timer to 64
[   31.858764] [fglrx] Driver built-in PAT support is enabled successfully
[   31.858786] [fglrx] module loaded - fglrx 8.62.4 [May 20 2009] with 1 minors
[   32.063068] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ
16
[   32.128478] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ
19
[   32.128521] HDA Intel 0000:01:05.1: setting latency timer to 64
[   32.409323] lp: driver loaded but no devices found
[   32.476356] Adding 1951856k swap on /dev/sda5.  Priority:-1 extents:1
across:1951856k
[   32.517697] Adding 1951856k swap on /dev/sdb5.  Priority:-2 extents:1
across:1951856k
[   33.049003] EXT3 FS on md1, internal journal
