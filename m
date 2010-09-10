From: Hugo Antunes <hugo.antunes@gmail.com>
Subject: using sata_sil24 10.4 2.6.32-25-server x86_64
Date: Fri, 10 Sep 2010 16:16:38 +0100
Message-ID: <4C8A4BD6.6090206@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030006000909050407010508"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:60721 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464Ab0IJPQu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Sep 2010 11:16:50 -0400
Received: by wwb34 with SMTP id 34so82957wwb.1
        for <linux-ide@vger.kernel.org>; Fri, 10 Sep 2010 08:16:48 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030006000909050407010508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greetings,

Following the list this pasts days as a sysadmin, building a big machine
with 45 sata2 disks (WD green 1.5TB), Sil3124 4 ports sata2 with 9 port
multipliers with 5 each also from Silicom image.
 
 This machine should smoke but it doesn't, attached is the dmesg dump
 Using Ubuntu/server 10.4 2.6.32-25-server x86_64 using sata_sil24
disks and bios controlers supports Western Digital Green drivers or any other kind of disks, 
sort of bug or simply a sysctl value.
will provide more logs if needed, 2.6.36-rc3 ? 

thanks

./hantunes
 


--------------030006000909050407010508
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.32-24-server (buildd@yellow) (gcc version 4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #41-Ubuntu SMP Thu Aug 19 02:47:08 UTC 2010 (Ubuntu 2.6.32-24.41-server 2.6.32.15+drm33.5)
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.32-24-server root=/dev/mapper/zoom--storage--srv0-root ro quiet
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d000 (usable)
[    0.000000]  BIOS-e820: 000000000009d000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cff80000 (usable)
[    0.000000]  BIOS-e820: 00000000cff80000 - 00000000cff8e000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cff8e000 - 00000000cffd0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cffd0000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
[    0.000000] DMI present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working around it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0x130000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F00000000 write-back
[    0.000000]   1 base 100000000 mask FE0000000 write-back
[    0.000000]   2 base 120000000 mask FF0000000 write-back
[    0.000000]   3 base 0D0000000 mask FF0000000 uncachable
[    0.000000]   4 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000d0000000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xcff80 max_arch_pfn = 0x400000000
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009d000 (usable)
[    0.000000]  modified: 000000000009d000 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 00000000cff80000 (usable)
[    0.000000]  modified: 00000000cff80000 - 00000000cff8e000 (ACPI data)
[    0.000000]  modified: 00000000cff8e000 - 00000000cffd0000 (ACPI NVS)
[    0.000000]  modified: 00000000cffd0000 - 00000000d0000000 (reserved)
[    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  modified: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  modified: 0000000100000000 - 0000000130000000 (usable)
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000cff80000
[    0.000000] NX (Execute Disable) protection: active
[    0.000000]  0000000000 - 00cfe00000 page 2M
[    0.000000]  00cfe00000 - 00cff80000 page 4k
[    0.000000] kernel direct mapping tables up to cff80000 @ 10000-16000
[    0.000000] init_memory_mapping: 0000000100000000-0000000130000000
[    0.000000] NX (Execute Disable) protection: active
[    0.000000]  0100000000 - 0130000000 page 2M
[    0.000000] kernel direct mapping tables up to 130000000 @ 14000-1a000
[    0.000000] RAMDISK: 371a8000 - 37fefece
[    0.000000] ACPI: RSDP 00000000000fbb10 00024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT 00000000cff80100 0005C (v01 A_M_I_ OEMXSDT  07000930 MSFT 00000097)
[    0.000000] ACPI: FACP 00000000cff80290 000F4 (v03 A_M_I_ OEMFACP  07000930 MSFT 00000097)
[    0.000000] ACPI: DSDT 00000000cff80440 09004 (v01  A1430 A1430001 00000001 INTL 20060113)
[    0.000000] ACPI: FACS 00000000cff8e000 00040
[    0.000000] ACPI: APIC 00000000cff80390 0006C (v01 A_M_I_ OEMAPIC  07000930 MSFT 00000097)
[    0.000000] ACPI: MCFG 00000000cff80400 0003C (v01 A_M_I_ OEMMCFG  07000930 MSFT 00000097)
[    0.000000] ACPI: OEMB 00000000cff8e040 00081 (v01 A_M_I_ AMI_OEM  07000930 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000cff89450 00038 (v01 A_M_I_ OEMHPET  07000930 MSFT 00000097)
[    0.000000] ACPI: OSFR 00000000cff89490 000B0 (v01 A_M_I_ OEMOSFR  07000930 MSFT 00000097)
[    0.000000] ACPI: SSDT 00000000cff8e650 00A7C (v01 DpgPmm    CpuPm 00000012 INTL 20060113)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000130000000
[    0.000000] Bootmem setup node 0 0000000000000000-0000000130000000
[    0.000000]   NODE_DATA [0000000000015000 - 0000000000019fff]
[    0.000000]   bootmap [000000000001a000 -  000000000003ffff] pages 26
[    0.000000] (8 early reservations) ==> bootmem [0000000000 - 0130000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0001000000 - 0001a4cea4]    TEXT DATA BSS ==> [0001000000 - 0001a4cea4]
[    0.000000]   #3 [00371a8000 - 0037fefece]          RAMDISK ==> [00371a8000 - 0037fefece]
[    0.000000]   #4 [000009d000 - 0000100000]    BIOS reserved ==> [000009d000 - 0000100000]
[    0.000000]   #5 [0001a4d000 - 0001a4d288]              BRK ==> [0001a4d000 - 0001a4d288]
[    0.000000]   #6 [0000010000 - 0000014000]          PGTABLE ==> [0000010000 - 0000014000]
[    0.000000]   #7 [0000014000 - 0000015000]          PGTABLE ==> [0000014000 - 0000015000]
[    0.000000] found SMP MP-table at [ffff8800000ff780] ff780
[    0.000000]  [ffffea0000000000-ffffea00043fffff] PMD -> [ffff880001c00000-ffff8800055fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00130000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x000cff80
[    0.000000]     0: 0x00100000 -> 0x00130000
[    0.000000] On node 0 totalpages: 1048333
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 107 pages reserved
[    0.000000]   DMA zone: 3818 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 833464 pages, LIFO batch:31
[    0.000000]   Normal zone: 2688 pages used for memmap
[    0.000000]   Normal zone: 193920 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
[    0.000000] PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000cff80000 - 00000000cff8e000
[    0.000000] PM: Registered nosave memory: 00000000cff8e000 - 00000000cffd0000
[    0.000000] PM: Registered nosave memory: 00000000cffd0000 - 00000000d0000000
[    0.000000] PM: Registered nosave memory: 00000000d0000000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000fff00000
[    0.000000] PM: Registered nosave memory: 00000000fff00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at d0000000 (gap: d0000000:2ee00000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 30 pages/cpu @ffff880005800000 s91544 r8192 d23144 u524288
[    0.000000] pcpu-alloc: s91544 r8192 d23144 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1031202
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.32-24-server root=/dev/mapper/zoom--storage--srv0-root ro quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.000000] Placing 64MB software IO TLB between ffff88000599e000 - ffff88000999e000
[    0.000000] software IO TLB at phys 0x599e000 - 0x999e000
[    0.000000] Memory: 4041916k/4980736k available (5512k kernel code, 787404k absent, 151416k reserved, 3084k data, 800k init)
[    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:4352 nr_irqs:440
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 41943040 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    0.000000] Fast TSC calibration failed
[    0.000000] TSC: PIT calibration matches HPET. 1 loops
[    0.000000] Detected 3329.999 MHz processor.
[    0.010006] Calibrating delay loop (skipped), value calculated using timer frequency.. 6659.99 BogoMIPS (lpj=33299990)
[    0.010027] Security Framework initialized
[    0.010043] AppArmor: AppArmor initialized
[    0.010284] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.021053] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.021879] Mount-cache hash table entries: 256
[    0.021992] Initializing cgroup subsys ns
[    0.021996] Initializing cgroup subsys cpuacct
[    0.021998] Initializing cgroup subsys memory
[    0.022004] Initializing cgroup subsys devices
[    0.022006] Initializing cgroup subsys freezer
[    0.022008] Initializing cgroup subsys net_cls
[    0.022024] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.022025] CPU: L2 cache: 6144K
[    0.022028] CPU 0/0x0 -> Node 0
[    0.022029] CPU: Physical Processor ID: 0
[    0.022030] CPU: Processor Core ID: 0
[    0.022033] mce: CPU supports 6 MCE banks
[    0.022039] CPU0: Thermal monitoring enabled (TM2)
[    0.022042] using mwait in idle threads.
[    0.022043] Performance Events: Core2 events, Intel PMU driver.
[    0.022048] ... version:                2
[    0.022049] ... bit width:              40
[    0.022050] ... generic registers:      2
[    0.022051] ... value mask:             000000ffffffffff
[    0.022052] ... max period:             000000007fffffff
[    0.022053] ... fixed-purpose events:   3
[    0.022054] ... event mask:             0000000700000003
[    0.023862] ACPI: Core revision 20090903
[    0.034575] ftrace: converting mcount calls to 0f 1f 44 00 00
[    0.034579] ftrace: allocating 22817 entries in 90 pages
[    0.040039] Setting APIC routing to flat
[    0.040336] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.141578] CPU0: Intel(R) Core(TM)2 Duo CPU     E8600  @ 3.33GHz stepping 0a
[    0.150000] Booting processor 1 APIC 0x1 ip 0x6000
[    0.020000] Initializing CPU#1
[    0.020000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.020000] CPU: L2 cache: 6144K
[    0.020000] CPU 1/0x1 -> Node 0
[    0.020000] CPU: Physical Processor ID: 0
[    0.020000] CPU: Processor Core ID: 1
[    0.020000] CPU1: Thermal monitoring enabled (TM2)
[    0.300088] CPU1: Intel(R) Core(TM)2 Duo CPU     E8600  @ 3.33GHz stepping 0a
[    0.300093] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.310017] Brought up 2 CPUs
[    0.310018] Total of 2 processors activated (13320.00 BogoMIPS).
[    0.310724] CPU0 attaching sched-domain:
[    0.310727]  domain 0: span 0-1 level MC
[    0.310728]   groups: 0 1
[    0.310733] CPU1 attaching sched-domain:
[    0.310734]  domain 0: span 0-1 level MC
[    0.310735]   groups: 1 0
[    0.310811] devtmpfs: initialized
[    0.312090] regulator: core version 0.5
[    0.312090] Time: 14:44:51  Date: 09/01/10
[    0.312090] NET: Registered protocol family 16
[    0.312090] ACPI: bus type pci registered
[    0.312090] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.312090] PCI: Not using MMCONFIG.
[    0.312090] PCI: Using configuration type 1 for base access
[    0.312090] Trying to unpack rootfs image as initramfs...
[    0.320041] bio: create slab <bio-0> at 0
[    0.320615] ACPI: EC: Look up EC in DSDT
[    0.322368] ACPI: Executed 1 blocks of module-level executable AML code
[    0.330443] ACPI: Interpreter enabled
[    0.330447] ACPI: (supports S0 S1 S3 S4 S5)
[    0.330463] ACPI: Using IOAPIC for interrupt routing
[    0.330503] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.332301] PCI: MCFG area at e0000000 reserved in ACPI motherboard resources
[    0.336904] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.342491] ACPI Warning: Incorrect checksum in table [OEMB] - A2, should be A1 (20090903/tbutils-314)
[    0.342593] ACPI: No dock devices found.
[    0.342678] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.342747] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.342749] pci 0000:00:01.0: PME# disabled
[    0.342802] pci 0000:00:1a.0: reg 20 io port: [0xa800-0xa81f]
[    0.342857] pci 0000:00:1a.1: reg 20 io port: [0xa880-0xa89f]
[    0.342911] pci 0000:00:1a.2: reg 20 io port: [0xac00-0xac1f]
[    0.342970] pci 0000:00:1a.7: reg 10 32bit mmio: [0xf9fffc00-0xf9ffffff]
[    0.343013] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.343016] pci 0000:00:1a.7: PME# disabled
[    0.343047] pci 0000:00:1b.0: reg 10 64bit mmio: [0xf9ff8000-0xf9ffbfff]
[    0.343078] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.343080] pci 0000:00:1b.0: PME# disabled
[    0.343130] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.343133] pci 0000:00:1c.0: PME# disabled
[    0.343184] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.343187] pci 0000:00:1c.4: PME# disabled
[    0.343236] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.343239] pci 0000:00:1c.5: PME# disabled
[    0.343280] pci 0000:00:1d.0: reg 20 io port: [0xa080-0xa09f]
[    0.343333] pci 0000:00:1d.1: reg 20 io port: [0xa400-0xa41f]
[    0.343386] pci 0000:00:1d.2: reg 20 io port: [0xa480-0xa49f]
[    0.343445] pci 0000:00:1d.7: reg 10 32bit mmio: [0xf9fff800-0xf9fffbff]
[    0.343488] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.343491] pci 0000:00:1d.7: PME# disabled
[    0.343625] pci 0000:00:1f.2: reg 10 io port: [0x9000-0x9007]
[    0.343628] pci 0000:00:1f.2: reg 14 io port: [0x8c00-0x8c03]
[    0.343632] pci 0000:00:1f.2: reg 18 io port: [0x8880-0x8887]
[    0.343637] pci 0000:00:1f.2: reg 1c io port: [0x8800-0x8803]
[    0.343642] pci 0000:00:1f.2: reg 20 io port: [0x8480-0x848f]
[    0.343646] pci 0000:00:1f.2: reg 24 io port: [0x8400-0x840f]
[    0.343680] pci 0000:00:1f.3: reg 10 64bit mmio: [0xf9fff400-0xf9fff4ff]
[    0.343690] pci 0000:00:1f.3: reg 20 io port: [0x400-0x41f]
[    0.343722] pci 0000:00:1f.5: reg 10 io port: [0xa000-0xa007]
[    0.343726] pci 0000:00:1f.5: reg 14 io port: [0x9c00-0x9c03]
[    0.343730] pci 0000:00:1f.5: reg 18 io port: [0x9880-0x9887]
[    0.343734] pci 0000:00:1f.5: reg 1c io port: [0x9800-0x9803]
[    0.343738] pci 0000:00:1f.5: reg 20 io port: [0x9480-0x948f]
[    0.343742] pci 0000:00:1f.5: reg 24 io port: [0x9400-0x940f]
[    0.343785] pci 0000:01:00.0: reg 10 32bit mmio: [0xfd000000-0xfdffffff]
[    0.343791] pci 0000:01:00.0: reg 14 64bit mmio pref: [0xd0000000-0xdfffffff]
[    0.343798] pci 0000:01:00.0: reg 1c 64bit mmio: [0xfa000000-0xfbffffff]
[    0.343802] pci 0000:01:00.0: reg 24 io port: [0xbc00-0xbc7f]
[    0.343805] pci 0000:01:00.0: reg 30 32bit mmio pref: [0xfe7e0000-0xfe7fffff]
[    0.343852] pci 0000:00:01.0: bridge io port: [0xb000-0xbfff]
[    0.343854] pci 0000:00:01.0: bridge 32bit mmio: [0xfa000000-0xfe7fffff]
[    0.343857] pci 0000:00:01.0: bridge 64bit mmio pref: [0xd0000000-0xdfffffff]
[    0.343893] pci 0000:00:1c.0: bridge 64bit mmio pref: [0xf8f00000-0xf8ffffff]
[    0.343940] pci 0000:03:00.0: reg 10 io port: [0xdc00-0xdc07]
[    0.343948] pci 0000:03:00.0: reg 14 io port: [0xd880-0xd883]
[    0.343955] pci 0000:03:00.0: reg 18 io port: [0xd800-0xd807]
[    0.343962] pci 0000:03:00.0: reg 1c io port: [0xd480-0xd483]
[    0.343970] pci 0000:03:00.0: reg 20 io port: [0xd400-0xd40f]
[    0.343983] pci 0000:03:00.0: reg 30 32bit mmio pref: [0xfe9f0000-0xfe9fffff]
[    0.344057] pci 0000:00:1c.4: bridge io port: [0xd000-0xdfff]
[    0.344060] pci 0000:00:1c.4: bridge 32bit mmio: [0xfe900000-0xfe9fffff]
[    0.344107] pci 0000:02:00.0: reg 10 64bit mmio: [0xfe8c0000-0xfe8fffff]
[    0.344113] pci 0000:02:00.0: reg 18 io port: [0xcc00-0xcc7f]
[    0.344163] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.344167] pci 0000:02:00.0: PME# disabled
[    0.344207] pci 0000:00:1c.5: bridge io port: [0xc000-0xcfff]
[    0.344210] pci 0000:00:1c.5: bridge 32bit mmio: [0xfe800000-0xfe8fffff]
[    0.344256] pci 0000:05:00.0: reg 10 64bit mmio: [0xfebffc00-0xfebffc7f]
[    0.344265] pci 0000:05:00.0: reg 18 64bit mmio: [0xfebf0000-0xfebf7fff]
[    0.344271] pci 0000:05:00.0: reg 20 io port: [0xec00-0xec0f]
[    0.344280] pci 0000:05:00.0: reg 30 32bit mmio pref: [0xfeb00000-0xfeb7ffff]
[    0.344302] pci 0000:05:00.0: supports D1 D2
[    0.344351] pci 0000:05:01.0: reg 10 64bit mmio: [0xfebff800-0xfebff87f]
[    0.344360] pci 0000:05:01.0: reg 18 64bit mmio: [0xfebe8000-0xfebeffff]
[    0.344366] pci 0000:05:01.0: reg 20 io port: [0xe880-0xe88f]
[    0.344376] pci 0000:05:01.0: reg 30 32bit mmio pref: [0xfea80000-0xfeafffff]
[    0.344397] pci 0000:05:01.0: supports D1 D2
[    0.344437] pci 0000:00:1e.0: transparent bridge
[    0.344439] pci 0000:00:1e.0: bridge io port: [0xe000-0xefff]
[    0.344442] pci 0000:00:1e.0: bridge 32bit mmio: [0xfea00000-0xfebfffff]
[    0.344464] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.344554] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.344593] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.344666] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
[    0.344705] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    0.344757] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
[    0.356330] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    0.356413] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.356490] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 *15)
[    0.356567] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    0.356644] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.356721] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 *14 15)
[    0.356798] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 7 10 11 12 14 15)
[    0.356875] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    0.356961] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.356964] vgaarb: loaded
[    0.357043] SCSI subsystem initialized
[    0.357114] libata version 3.00 loaded.
[    0.357160] usbcore: registered new interface driver usbfs
[    0.357168] usbcore: registered new interface driver hub
[    0.357185] usbcore: registered new device driver usb
[    0.357271] ACPI: WMI: Mapper loaded
[    0.357272] PCI: Using ACPI for IRQ routing
[    0.357398] NetLabel: Initializing
[    0.357400] NetLabel:  domain hash size = 128
[    0.357400] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.357412] NetLabel:  unlabeled traffic allowed by default
[    0.357433] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.357436] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.360026] Switching to clocksource tsc
[    0.361202] AppArmor: AppArmor Filesystem Enabled
[    0.361212] pnp: PnP ACPI init
[    0.361220] ACPI: bus type pnp registered
[    0.363323] pnp: PnP ACPI: found 16 devices
[    0.363325] ACPI: ACPI bus type pnp unregistered
[    0.363332] system 00:01: iomem range 0xfed14000-0xfed19fff has been reserved
[    0.363336] system 00:06: ioport range 0x290-0x29f has been reserved
[    0.363340] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[    0.363342] system 00:07: ioport range 0x800-0x87f has been reserved
[    0.363343] system 00:07: ioport range 0x500-0x57f has been reserved
[    0.363345] system 00:07: iomem range 0xfed08000-0xfed08fff has been reserved
[    0.363347] system 00:07: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.363349] system 00:07: iomem range 0xfed20000-0xfed3ffff has been reserved
[    0.363350] system 00:07: iomem range 0xfed50000-0xfed8ffff has been reserved
[    0.363354] system 00:0a: iomem range 0xffc00000-0xffefffff has been reserved
[    0.363357] system 00:0b: iomem range 0xfec00000-0xfec00fff could not be reserved
[    0.363359] system 00:0b: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.363363] system 00:0e: iomem range 0xe0000000-0xefffffff has been reserved
[    0.363368] system 00:0f: iomem range 0x0-0x9ffff could not be reserved
[    0.363370] system 00:0f: iomem range 0xc0000-0xcffff has been reserved
[    0.363372] system 00:0f: iomem range 0xe0000-0xfffff could not be reserved
[    0.363374] system 00:0f: iomem range 0x100000-0xcfffffff could not be reserved
[    0.367998] pci 0000:05:00.0: BAR 6: address space collision on of device [0xfeb00000-0xfeb7ffff]
[    0.368001] pci 0000:05:01.0: BAR 6: address space collision on of device [0xfea80000-0xfeafffff]
[    0.368033] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.368035] pci 0000:00:01.0:   IO window: 0xb000-0xbfff
[    0.368037] pci 0000:00:01.0:   MEM window: 0xfa000000-0xfe7fffff
[    0.368040] pci 0000:00:01.0:   PREFETCH window: 0x000000d0000000-0x000000dfffffff
[    0.368042] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:04
[    0.368044] pci 0000:00:1c.0:   IO window: 0x1000-0x1fff
[    0.368048] pci 0000:00:1c.0:   MEM window: 0xf0000000-0xf03fffff
[    0.368050] pci 0000:00:1c.0:   PREFETCH window: 0x000000f8f00000-0x000000f8ffffff
[    0.368055] pci 0000:00:1c.4: PCI bridge, secondary bus 0000:03
[    0.368057] pci 0000:00:1c.4:   IO window: 0xd000-0xdfff
[    0.368060] pci 0000:00:1c.4:   MEM window: 0xfe900000-0xfe9fffff
[    0.368062] pci 0000:00:1c.4:   PREFETCH window: 0x000000f0400000-0x000000f05fffff
[    0.368067] pci 0000:00:1c.5: PCI bridge, secondary bus 0000:02
[    0.368068] pci 0000:00:1c.5:   IO window: 0xc000-0xcfff
[    0.368072] pci 0000:00:1c.5:   MEM window: 0xfe800000-0xfe8fffff
[    0.368074] pci 0000:00:1c.5:   PREFETCH window: 0x000000f0600000-0x000000f07fffff
[    0.368079] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:05
[    0.368081] pci 0000:00:1e.0:   IO window: 0xe000-0xefff
[    0.368084] pci 0000:00:1e.0:   MEM window: 0xfea00000-0xfebfffff
[    0.368087] pci 0000:00:1e.0:   PREFETCH window: 0xf0800000-0xf08fffff
[    0.368096]   alloc irq_desc for 16 on node -1
[    0.368097]   alloc kstat_irqs on node -1
[    0.368101] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.368103] pci 0000:00:01.0: setting latency timer to 64
[    0.368108] pci 0000:00:1c.0: enabling device (0106 -> 0107)
[    0.368112]   alloc irq_desc for 17 on node -1
[    0.368113]   alloc kstat_irqs on node -1
[    0.368115] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.368117] pci 0000:00:1c.0: setting latency timer to 64
[    0.368123] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.368126] pci 0000:00:1c.4: setting latency timer to 64
[    0.368131] pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.368134] pci 0000:00:1c.5: setting latency timer to 64
[    0.368138] pci 0000:00:1e.0: setting latency timer to 64
[    0.368140] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.368142] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.368143] pci_bus 0000:01: resource 0 io:  [0xb000-0xbfff]
[    0.368145] pci_bus 0000:01: resource 1 mem: [0xfa000000-0xfe7fffff]
[    0.368146] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xdfffffff]
[    0.368148] pci_bus 0000:04: resource 0 io:  [0x1000-0x1fff]
[    0.368149] pci_bus 0000:04: resource 1 mem: [0xf0000000-0xf03fffff]
[    0.368150] pci_bus 0000:04: resource 2 pref mem [0xf8f00000-0xf8ffffff]
[    0.368152] pci_bus 0000:03: resource 0 io:  [0xd000-0xdfff]
[    0.368153] pci_bus 0000:03: resource 1 mem: [0xfe900000-0xfe9fffff]
[    0.368155] pci_bus 0000:03: resource 2 pref mem [0xf0400000-0xf05fffff]
[    0.368156] pci_bus 0000:02: resource 0 io:  [0xc000-0xcfff]
[    0.368158] pci_bus 0000:02: resource 1 mem: [0xfe800000-0xfe8fffff]
[    0.368159] pci_bus 0000:02: resource 2 pref mem [0xf0600000-0xf07fffff]
[    0.368161] pci_bus 0000:05: resource 0 io:  [0xe000-0xefff]
[    0.368162] pci_bus 0000:05: resource 1 mem: [0xfea00000-0xfebfffff]
[    0.368163] pci_bus 0000:05: resource 2 pref mem [0xf0800000-0xf08fffff]
[    0.368165] pci_bus 0000:05: resource 3 io:  [0x00-0xffff]
[    0.368166] pci_bus 0000:05: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.368188] NET: Registered protocol family 2
[    0.368302] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.369130] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.372586] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.373048] TCP: Hash tables configured (established 524288 bind 65536)
[    0.373050] TCP reno registered
[    0.373142] NET: Registered protocol family 1
[    0.373288] pci 0000:01:00.0: Boot video device
[    0.373450] Scanning for low memory corruption every 60 seconds
[    0.373542] audit: initializing netlink socket (disabled)
[    0.373553] type=2000 audit(1283352291.369:1): initialized
[    0.379816] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.380727] VFS: Disk quotas dquot_6.5.2
[    0.380760] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.381138] fuse init (API version 7.13)
[    0.381189] msgmni has been set to 7894
[    0.381329] alg: No test for stdrng (krng)
[    0.381369] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.381371] io scheduler noop registered
[    0.381372] io scheduler anticipatory registered
[    0.381374] io scheduler deadline registered (default)
[    0.381396] io scheduler cfq registered
[    0.381490]   alloc irq_desc for 24 on node -1
[    0.381492]   alloc kstat_irqs on node -1
[    0.381498] pcieport 0000:00:01.0: irq 24 for MSI/MSI-X
[    0.381504] pcieport 0000:00:01.0: setting latency timer to 64
[    0.381569]   alloc irq_desc for 25 on node -1
[    0.381570]   alloc kstat_irqs on node -1
[    0.381574] pcieport 0000:00:1c.0: irq 25 for MSI/MSI-X
[    0.381580] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.381659]   alloc irq_desc for 26 on node -1
[    0.381660]   alloc kstat_irqs on node -1
[    0.381665] pcieport 0000:00:1c.4: irq 26 for MSI/MSI-X
[    0.381671] pcieport 0000:00:1c.4: setting latency timer to 64
[    0.381749]   alloc irq_desc for 27 on node -1
[    0.381750]   alloc kstat_irqs on node -1
[    0.381754] pcieport 0000:00:1c.5: irq 27 for MSI/MSI-X
[    0.381760] pcieport 0000:00:1c.5: setting latency timer to 64
[    0.381816] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.381886] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.381964] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.381967] ACPI: Power Button [PWRB]
[    0.381996] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.381998] ACPI: Power Button [PWRF]
[    0.382535] ACPI: SSDT 00000000cff8e0d0 002B9 (v01 DpgPmm  P001Ist 00000011 INTL 20060113)
[    0.382914] processor LNXCPU:00: registered as cooling_device0
[    0.383230] ACPI: SSDT 00000000cff8e390 002B9 (v01 DpgPmm  P002Ist 00000012 INTL 20060113)
[    0.383598] processor LNXCPU:01: registered as cooling_device1
[    0.386155] Linux agpgart interface v0.103
[    0.386178] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.386261] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.386519] 00:0d: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.387170] brd: module loaded
[    0.387468] loop: module loaded
[    0.387519] input: Macintosh mouse button emulation as /devices/virtual/input/input2
[    0.387586] ata_piix 0000:00:1f.2: version 2.13
[    0.387600]   alloc irq_desc for 19 on node -1
[    0.387601]   alloc kstat_irqs on node -1
[    0.387606] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.387609] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[    0.387639] ata_piix 0000:00:1f.2: setting latency timer to 64
[    0.387687] scsi0 : ata_piix
[    0.387736] scsi1 : ata_piix
[    0.388550] ata1: SATA max UDMA/133 cmd 0x9000 ctl 0x8c00 bmdma 0x8480 irq 19
[    0.388554] ata2: SATA max UDMA/133 cmd 0x8880 ctl 0x8800 bmdma 0x8488 irq 19
[    0.388568] ata_piix 0000:00:1f.5: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.388571] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
[    0.388595] ata_piix 0000:00:1f.5: setting latency timer to 64
[    0.388619] scsi2 : ata_piix
[    0.388655] scsi3 : ata_piix
[    0.389446] ata3: SATA max UDMA/133 cmd 0xa000 ctl 0x9c00 bmdma 0x9480 irq 19
[    0.389448] ata4: SATA max UDMA/133 cmd 0x9880 ctl 0x9800 bmdma 0x9488 irq 19
[    0.389487] pata_acpi 0000:03:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.389507] pata_acpi 0000:03:00.0: setting latency timer to 64
[    0.389517] pata_acpi 0000:03:00.0: PCI INT A disabled
[    0.389717] Fixed MDIO Bus: probed
[    0.389736] PPP generic driver version 2.4.2
[    0.389757] tun: Universal TUN/TAP device driver, 1.6
[    0.389758] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    0.389816] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.389827]   alloc irq_desc for 18 on node -1
[    0.389828]   alloc kstat_irqs on node -1
[    0.389831] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.389841] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    0.389843] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    0.389863] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.389883] ehci_hcd 0000:00:1a.7: debug port 1
[    0.393750] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    0.393759] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf9fffc00
[    0.409667] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.409756] usb usb1: configuration #1 chosen from 1 choice
[    0.409776] hub 1-0:1.0: USB hub found
[    0.409785] hub 1-0:1.0: 6 ports detected
[    0.409837]   alloc irq_desc for 23 on node -1
[    0.409838]   alloc kstat_irqs on node -1
[    0.409843] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.409861] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    0.409863] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    0.409890] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    0.409909] ehci_hcd 0000:00:1d.7: debug port 1
[    0.413800] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    0.413813] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf9fff800
[    0.429662] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.429753] usb usb2: configuration #1 chosen from 1 choice
[    0.429773] hub 2-0:1.0: USB hub found
[    0.429779] hub 2-0:1.0: 6 ports detected
[    0.429830] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.429845] uhci_hcd: USB Universal Host Controller Interface driver
[    0.429881] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.429891] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    0.429894] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.429920] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    0.429949] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000a800
[    0.430004] usb usb3: configuration #1 chosen from 1 choice
[    0.430024] hub 3-0:1.0: USB hub found
[    0.430030] hub 3-0:1.0: 2 ports detected
[    0.430064]   alloc irq_desc for 21 on node -1
[    0.430065]   alloc kstat_irqs on node -1
[    0.430070] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    0.430074] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    0.430076] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.430094] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    0.430117] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a880
[    0.430172] usb usb4: configuration #1 chosen from 1 choice
[    0.430186] hub 4-0:1.0: USB hub found
[    0.430190] hub 4-0:1.0: 2 ports detected
[    0.430218] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.430222] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[    0.430224] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.430253] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    0.430271] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000ac00
[    0.430323] usb usb5: configuration #1 chosen from 1 choice
[    0.430340] hub 5-0:1.0: USB hub found
[    0.430343] hub 5-0:1.0: 2 ports detected
[    0.430371] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.430375] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    0.430377] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.430410] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    0.430430] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a080
[    0.430482] usb usb6: configuration #1 chosen from 1 choice
[    0.430498] hub 6-0:1.0: USB hub found
[    0.430502] hub 6-0:1.0: 2 ports detected
[    0.430528] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.430533] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    0.430535] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.430552] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    0.430570] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a400
[    0.430622] usb usb7: configuration #1 chosen from 1 choice
[    0.430637] hub 7-0:1.0: USB hub found
[    0.430642] hub 7-0:1.0: 2 ports detected
[    0.430670] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.430674] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    0.430676] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.430695] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    0.430713] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a480
[    0.430768] usb usb8: configuration #1 chosen from 1 choice
[    0.430782] hub 8-0:1.0: USB hub found
[    0.430786] hub 8-0:1.0: 2 ports detected
[    0.430845] PNP: PS/2 Controller [PNP0f03:PS2M] at 0x60,0x64 irq 12
[    0.430846] PNP: PS/2 controller doesn't have KBD irq; using default 1
[    0.433320] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.433324] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.433377] mice: PS/2 mouse device common for all mice
[    0.433439] rtc_cmos 00:03: RTC can wake from S4
[    0.433470] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.433490] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.433569] device-mapper: uevent: version 1.0.3
[    0.433664] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
[    0.433708] device-mapper: multipath: version 1.1.0 loaded
[    0.433710] device-mapper: multipath round-robin: version 1.0.0 loaded
[    0.433797] cpuidle: using governor ladder
[    0.433799] cpuidle: using governor menu
[    0.434020] TCP cubic registered
[    0.434100] NET: Registered protocol family 10
[    0.434386] lo: Disabled Privacy Extensions
[    0.434552] NET: Registered protocol family 17
[    0.435201] PM: Resume from disk failed.
[    0.435210] registered taskstats version 1
[    0.435563]   Magic number: 10:261:737
[    0.435635] rtc_cmos 00:03: setting system clock to 2010-09-01 14:44:52 UTC (1283352292)
[    0.435637] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    0.435638] EDD information not available.
[    0.514649] Freeing initrd memory: 14623k freed
[    0.750151] ata4: SATA link down (SStatus 0 SControl 300)
[    0.760758] ata3: SATA link down (SStatus 0 SControl 300)
[    0.760786] usb 2-3: new high speed USB device using ehci_hcd and address 2
[    0.910852] usb 2-3: configuration #1 chosen from 1 choice
[    0.911147] hub 2-3:1.0: USB hub found
[    0.911495] hub 2-3:1.0: 4 ports detected
[    1.100623] ata2.00: SATA link down (SStatus 0 SControl 300)
[    1.100633] ata2.01: SATA link down (SStatus 0 SControl 300)
[    1.120628] ata1.00: SATA link down (SStatus 0 SControl 300)
[    1.120637] ata1.01: SATA link down (SStatus 0 SControl 300)
[    1.120677] Freeing unused kernel memory: 800k freed
[    1.120924] Write protecting the kernel read-only data: 7804k
[    1.130493] udev: starting version 151
[    1.164925] pata_jmicron 0000:03:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.164958] pata_jmicron 0000:03:00.0: setting latency timer to 64
[    1.166594] vga16fb: initializing
[    1.166597] vga16fb: mapped to 0xffff8800000a0000
[    1.166635] fb0: VGA16 VGA frame buffer device
[    1.169403] sata_sil24 0000:05:00.0: version 1.1
[    1.169414] sata_sil24 0000:05:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.171435] scsi4 : pata_jmicron
[    1.176377] scsi6 : pata_jmicron
[    1.176391] ATL1E 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.176403] ATL1E 0000:02:00.0: setting latency timer to 64
[    1.176953] ata5: PATA max UDMA/100 cmd 0xdc00 ctl 0xd880 bmdma 0xd400 irq 16
[    1.176955] ata6: PATA max UDMA/100 cmd 0xd800 ctl 0xd480 bmdma 0xd408 irq 16
[    1.177550] scsi5 : sata_sil24
[    1.185774] scsi7 : sata_sil24
[    1.192630] scsi8 : sata_sil24
[    1.194306] scsi9 : sata_sil24
[    1.194335] ata7: SATA max UDMA/100 host m128@0xfebffc00 port 0xfebf0000 irq 16
[    1.194338] ata8: SATA max UDMA/100 host m128@0xfebffc00 port 0xfebf2000 irq 16
[    1.194340] ata9: SATA max UDMA/100 host m128@0xfebffc00 port 0xfebf4000 irq 16
[    1.194343] ata10: SATA max UDMA/100 host m128@0xfebffc00 port 0xfebf6000 irq 16
[    1.194373] sata_sil24 0000:05:01.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.194637] scsi10 : sata_sil24
[    1.194673] scsi11 : sata_sil24
[    1.194705] scsi12 : sata_sil24
[    1.194740] scsi13 : sata_sil24
[    1.194763] ata11: SATA max UDMA/100 host m128@0xfebff800 port 0xfebe8000 irq 17
[    1.194765] ata12: SATA max UDMA/100 host m128@0xfebff800 port 0xfebea000 irq 17
[    1.194768] ata13: SATA max UDMA/100 host m128@0xfebff800 port 0xfebec000 irq 17
[    1.194770] ata14: SATA max UDMA/100 host m128@0xfebff800 port 0xfebee000 irq 17
[    1.201508] usb 2-3.2: new low speed USB device using ehci_hcd and address 3
[    1.315567] usb 2-3.2: configuration #1 chosen from 1 choice
[    1.321496] usbcore: registered new interface driver hiddev
[    1.323855] input: NOVATEK USB Keyboard as /devices/pci0000:00/0000:00:1d.7/usb2/2-3/2-3.2/2-3.2:1.0/input/input3
[    1.323911] generic-usb 0003:0603:00F2.0001: input,hidraw0: USB HID v1.10 Keyboard [NOVATEK USB Keyboard] on usb-0000:00:1d.7-3.2/input0
[    1.329185] input: NOVATEK USB Keyboard as /devices/pci0000:00/0000:00:1d.7/usb2/2-3/2-3.2/2-3.2:1.1/input/input4
[    1.329295] generic-usb 0003:0603:00F2.0002: input,hiddev96,hidraw1: USB HID v1.10 Device [NOVATEK USB Keyboard] on usb-0000:00:1d.7-3.2/input1
[    1.329306] usbcore: registered new interface driver usbhid
[    1.329307] usbhid: v2.6:USB HID core driver
[    1.350697] ata5.01: ATA-5: MAXTOR 6L040J2, A93.0300, max UDMA/133
[    1.350700] ata5.01: 78177792 sectors, multi 0: LBA 
[    1.390260] usb 2-3.4: new low speed USB device using ehci_hcd and address 4
[    1.390706] ata5.01: configured for UDMA/100
[    1.390797] scsi 4:0:1:0: Direct-Access     ATA      MAXTOR 6L040J2   A93. PQ: 0 ANSI: 5
[    1.390940] sd 4:0:1:0: Attached scsi generic sg0 type 0
[    1.390949] sd 4:0:1:0: [sda] 78177792 512-byte logical blocks: (40.0 GB/37.2 GiB)
[    1.391098] sd 4:0:1:0: [sda] Write Protect is off
[    1.391100] sd 4:0:1:0: [sda] Mode Sense: 00 3a 00 00
[    1.391114] sd 4:0:1:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.391199]  sda: sda1 sda2 < sda5 >
[    1.409051] sd 4:0:1:0: [sda] Attached SCSI disk
[    1.502177] usb 2-3.4: configuration #1 chosen from 1 choice
[    1.504198] input: HID 062a:0000 as /devices/pci0000:00/0000:00:1d.7/usb2/2-3/2-3.4/2-3.4:1.0/input/input5
[    1.504243] generic-usb 0003:062A:0000.0003: input,hidraw2: USB HID v1.10 Mouse [HID 062a:0000] on usb-0000:00:1d.7-3.4/input0
[    3.280016] ata11: SATA link down (SStatus 0 SControl 0)
[    3.290016] ata7: SATA link down (SStatus 0 SControl 0)
[   13.290008] ata8: softreset failed (timeout)
[   23.290008] ata8: softreset failed (timeout)
[   36.590022] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   36.590065] ata8.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[   43.790016] ata8: softreset failed (SRST command error)
[   43.790019] ata8: reset failed (errno=-5), retrying in 8 secs
[   54.580020] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   57.580012] ata8.15: qc timeout (cmd 0xe4)
[   57.580017] ata8.15: failed to read PMP GSCR[0] (Emask=0x5)
[   57.580021] ata8: limiting SATA link speed to 1.5 Gbps
[   61.800020] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[   61.800205] ata8.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
[   61.800398] ata8.00: hard resetting link
[   62.150256] ata8.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   62.150282] ata8.01: hard resetting link
[   62.500255] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   62.500281] ata8.02: hard resetting link
[   62.850262] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   62.850289] ata8.03: hard resetting link
[   63.200257] ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   63.200283] ata8.04: hard resetting link
[   63.550265] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   63.550291] ata8.05: hard resetting link
[   63.900257] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   63.902368] ata8.00: ATA-8: WDC WD15EARS-22Z5B1, 80.00A80, max UDMA/133
[   63.902371] ata8.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   63.905008] ata8.00: configured for UDMA/100
[   63.907769] ata8.01: ATA-8: WDC WD15EARS-22Z5B1, 80.00A80, max UDMA/133
[   63.907772] ata8.01: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   63.910657] ata8.01: configured for UDMA/100
[   63.912779] ata8.02: ATA-8: WDC WD15EARS-22Z5B1, 80.00A80, max UDMA/133
[   63.912782] ata8.02: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   63.915768] ata8.02: configured for UDMA/100
[   63.919983] ata8.03: ATA-8: WDC WD15EARS-22Z5B1, 80.00A80, max UDMA/133
[   63.919986] ata8.03: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   63.923998] ata8.03: configured for UDMA/100
[   63.927561] ata8.04: ATA-8: WDC WD15EARS-22Z5B1, 80.00A80, max UDMA/133
[   63.927564] ata8.04: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   63.931575] ata8.04: configured for UDMA/100
[   63.931625] ata8: EH complete
[   63.931688] scsi 7:0:0:0: Direct-Access     ATA      WDC WD15EARS-22Z 80.0 PQ: 0 ANSI: 5
[   63.931787] sd 7:0:0:0: Attached scsi generic sg1 type 0
[   63.931814] sd 7:0:0:0: [sdb] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   63.931816] sd 7:0:0:0: [sdb] 4096-byte physical blocks
[   63.931843] sd 7:0:0:0: [sdb] Write Protect is off
[   63.931844] sd 7:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   63.931859] sd 7:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   63.931867] scsi 7:1:0:0: Direct-Access     ATA      WDC WD15EARS-22Z 80.0 PQ: 0 ANSI: 5
[   63.931937] sd 7:1:0:0: Attached scsi generic sg2 type 0
[   63.931943]  sdb:
[   63.931968] sd 7:1:0:0: [sdc] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   63.931970] sd 7:1:0:0: [sdc] 4096-byte physical blocks
[   63.931996] sd 7:1:0:0: [sdc] Write Protect is off
[   63.931998] sd 7:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   63.932012] sd 7:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   63.932055] scsi 7:2:0:0: Direct-Access     ATA      WDC WD15EARS-22Z 80.0 PQ: 0 ANSI: 5
[   63.932080]  sdc:
[   63.932126] sd 7:2:0:0: [sdd] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   63.932127] sd 7:2:0:0: Attached scsi generic sg3 type 0
[   63.932130] sd 7:2:0:0: [sdd] 4096-byte physical blocks
[   63.932155] sd 7:2:0:0: [sdd] Write Protect is off
[   63.932156] sd 7:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   63.932170] sd 7:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   63.932236] scsi 7:3:0:0: Direct-Access     ATA      WDC WD15EARS-22Z 80.0 PQ: 0 ANSI: 5
[   63.932239]  sdd:
[   63.932308] sd 7:3:0:0: Attached scsi generic sg4 type 0
[   63.932352] sd 7:3:0:0: [sde] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   63.932353] sd 7:3:0:0: [sde] 4096-byte physical blocks
[   63.932364] scsi 7:4:0:0: Direct-Access     ATA      WDC WD15EARS-22Z 80.0 PQ: 0 ANSI: 5
[   63.932402] sd 7:3:0:0: [sde] Write Protect is off
[   63.932404] sd 7:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   63.932429] sd 7:4:0:0: Attached scsi generic sg5 type 0
[   63.932471] sd 7:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   63.932484] sd 7:4:0:0: [sdf] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   63.932486] sd 7:4:0:0: [sdf] 4096-byte physical blocks
[   63.932513] sd 7:4:0:0: [sdf] Write Protect is off
[   63.932514] sd 7:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[   63.932529] sd 7:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   63.932554]  sde:
[   63.932603]  sdf: unknown partition table
[   63.938906] sd 7:3:0:0: [sde] Attached SCSI disk
[   63.941959]  unknown partition table
[   63.942099] sd 7:4:0:0: [sdf] Attached SCSI disk
[   63.945442]  unknown partition table
[   63.945580] sd 7:1:0:0: [sdc] Attached SCSI disk
[   64.405069]  unknown partition table
[   64.405212] sd 7:2:0:0: [sdd] Attached SCSI disk
[   64.408783]  unknown partition table
[   64.408919] sd 7:0:0:0: [sdb] Attached SCSI disk
[   66.150020] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   66.150191] ata9.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
[   66.150368] ata9.00: hard resetting link
[   66.500233] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   66.500257] ata9.01: hard resetting link
[   66.850233] ata9.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   66.850256] ata9.02: hard resetting link
[   67.200232] ata9.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   67.200256] ata9.03: hard resetting link
[   67.550237] ata9.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   67.550261] ata9.04: hard resetting link
[   67.900232] ata9.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   67.900255] ata9.05: hard resetting link
[   68.250231] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   68.252328] ata9.00: ATA-8: WDC WD15EARS-22Z5B1, 80.00A80, max UDMA/133
[   68.252330] ata9.00: 2930277168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   68.255032] ata9.00: configured for UDMA/100
[   68.257143] ata9.01: ATA-8: WDC WD15EARS-22Z5B1, 80.00A80, max UDMA/133
[   68.257146] ata9.01: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   68.259340] ata9.01: configured for UDMA/100
[   68.261722] ata9.02: ATA-8: WDC WD15EARS-22Z5B1, 80.00A80, max UDMA/133
[   68.261725] ata9.02: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   68.263906] ata9.02: configured for UDMA/100
[   68.266819] ata9.03: ATA-8: WDC WD15EARS-22Z5B1, 80.00A80, max UDMA/133
[   68.266821] ata9.03: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   68.268991] ata9.03: configured for UDMA/100
[   68.271123] ata9.04: ATA-8: WDC WD15EARS-22Z5B1, 80.00A80, max UDMA/133
[   68.271126] ata9.04: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   68.273544] ata9.04: configured for UDMA/100
[   68.273589] ata9: EH complete
[   68.273649] scsi 8:0:0:0: Direct-Access     ATA      WDC WD15EARS-22Z 80.0 PQ: 0 ANSI: 5
[   68.273767] sd 8:0:0:0: Attached scsi generic sg6 type 0
[   68.273827] sd 8:0:0:0: [sdg] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   68.273829] sd 8:0:0:0: [sdg] 4096-byte physical blocks
[   68.273835] scsi 8:1:0:0: Direct-Access     ATA      WDC WD15EARS-22Z 80.0 PQ: 0 ANSI: 5
[   68.273855] sd 8:0:0:0: [sdg] Write Protect is off
[   68.273857] sd 8:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[   68.273871] sd 8:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   68.273903] sd 8:1:0:0: Attached scsi generic sg7 type 0
[   68.273948]  sdg:
[   68.273972] sd 8:1:0:0: [sdh] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   68.273973] sd 8:1:0:0: [sdh] 4096-byte physical blocks
[   68.273999] sd 8:1:0:0: [sdh] Write Protect is off
[   68.274000] sd 8:1:0:0: [sdh] Mode Sense: 00 3a 00 00
[   68.274014] sd 8:1:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   68.274018] scsi 8:2:0:0: Direct-Access     ATA      WDC WD15EARS-22Z 80.0 PQ: 0 ANSI: 5
[   68.274090] sd 8:2:0:0: Attached scsi generic sg8 type 0
[   68.274094]  sdh:
[   68.274117] sd 8:2:0:0: [sdi] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   68.274118] sd 8:2:0:0: [sdi] 4096-byte physical blocks
[   68.274144] sd 8:2:0:0: [sdi] Write Protect is off
[   68.274145] sd 8:2:0:0: [sdi] Mode Sense: 00 3a 00 00
[   68.274159] sd 8:2:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   68.274200] scsi 8:3:0:0: Direct-Access     ATA      WDC WD15EARS-22Z 80.0 PQ: 0 ANSI: 5
[   68.274225]  sdi:
[   68.274271] sd 8:3:0:0: [sdj] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   68.274273] sd 8:3:0:0: [sdj] 4096-byte physical blocks
[   68.274273] sd 8:3:0:0: Attached scsi generic sg9 type 0
[   68.274300] sd 8:3:0:0: [sdj] Write Protect is off
[   68.274301] sd 8:3:0:0: [sdj] Mode Sense: 00 3a 00 00
[   68.274315] sd 8:3:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   68.274384]  sdj:
[   68.274385] scsi 8:4:0:0: Direct-Access     ATA      WDC WD15EARS-22Z 80.0 PQ: 0 ANSI: 5
[   68.274460] sd 8:4:0:0: Attached scsi generic sg10 type 0
[   68.274508] sd 8:4:0:0: [sdk] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   68.274510] sd 8:4:0:0: [sdk] 4096-byte physical blocks
[   68.274536] sd 8:4:0:0: [sdk] Write Protect is off
[   68.274537] sd 8:4:0:0: [sdk] Mode Sense: 00 3a 00 00
[   68.274551] sd 8:4:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   68.274620]  sdk: unknown partition table
[   68.746612] sd 8:0:0:0: [sdg] Attached SCSI disk
[   68.747530]  unknown partition table
[   68.747668] sd 8:3:0:0: [sdj] Attached SCSI disk
[   68.748178]  unknown partition table
[   68.748316] sd 8:2:0:0: [sdi] Attached SCSI disk
[   68.751877]  unknown partition table
[   68.752021] sd 8:4:0:0: [sdk] Attached SCSI disk
[   68.760745]  unknown partition table
[   68.760882] sd 8:1:0:0: [sdh] Attached SCSI disk
[   70.360016] ata10: SATA link down (SStatus 0 SControl 0)
[   72.450015] ata12: SATA link down (SStatus 0 SControl 0)
[   74.540015] ata13: SATA link down (SStatus 0 SControl 0)
[   76.630016] ata14: SATA link down (SStatus 0 SControl 0)
[   76.693514] md: bind<sdg>
[   76.695223] md: bind<sdk>
[   76.696706] md: bind<sdj>
[   76.701783] md: bind<sdh>
[   76.779658] Console: switching to colour frame buffer device 80x30
[   76.813701] md: bind<sdi>
[   77.151454] md: bind<sdb>
[   77.607116] md: bind<sde>
[   77.611880] md: bind<sdd>
[   77.623609] md: bind<sdf>
[   77.635398] md: bind<sdc>
[   77.638423] async_tx: api initialized (async)
[   77.800005] raid6: int64x1   2614 MB/s
[   77.970012] raid6: int64x2   3482 MB/s
[   78.140005] raid6: int64x4   2560 MB/s
[   78.310025] raid6: int64x8   2224 MB/s
[   78.480012] raid6: sse2x1    5703 MB/s
[   78.650009] raid6: sse2x2    6033 MB/s
[   78.820004] raid6: sse2x4    9848 MB/s
[   78.820005] raid6: using algorithm sse2x4 (9848 MB/s)
[   78.829182] xor: automatically using best checksumming function: generic_sse
[   78.869989]    generic_sse: 12729.200 MB/sec
[   78.869991] xor: using function: generic_sse (12729.200 MB/sec)
[   78.872685] md: raid6 personality registered for level 6
[   78.872686] md: raid5 personality registered for level 5
[   78.872687] md: raid4 personality registered for level 4
[   78.872799] raid5: reshape will continue
[   78.872806] raid5: device sdc operational as raid disk 1
[   78.872807] raid5: device sdf operational as raid disk 3
[   78.872808] raid5: device sdd operational as raid disk 2
[   78.872810] raid5: device sde operational as raid disk 4
[   78.872811] raid5: device sdb operational as raid disk 0
[   78.872812] raid5: device sdi operational as raid disk 7
[   78.872813] raid5: device sdh operational as raid disk 6
[   78.872815] raid5: device sdj operational as raid disk 8
[   78.872816] raid5: device sdk operational as raid disk 9
[   78.872817] raid5: device sdg operational as raid disk 5
[   78.873315] raid5: allocated 10594kB for md0
[   78.873337] 1: w=1 pa=2 pr=9 m=2 a=2 r=10 op1=0 op2=0
[   78.873338] 3: w=2 pa=2 pr=9 m=2 a=2 r=10 op1=0 op2=0
[   78.873340] 2: w=3 pa=2 pr=9 m=2 a=2 r=10 op1=0 op2=0
[   78.873341] 4: w=4 pa=2 pr=9 m=2 a=2 r=10 op1=0 op2=0
[   78.873343] 0: w=5 pa=2 pr=9 m=2 a=2 r=10 op1=0 op2=0
[   78.873345] 7: w=6 pa=2 pr=9 m=2 a=2 r=10 op1=0 op2=0
[   78.873346] 6: w=7 pa=2 pr=9 m=2 a=2 r=10 op1=0 op2=0
[   78.873348] 8: w=8 pa=2 pr=9 m=2 a=2 r=10 op1=0 op2=0
[   78.873349] 9: w=9 pa=2 pr=9 m=2 a=2 r=10 op1=0 op2=0
[   78.873351] 5: w=10 pa=2 pr=9 m=2 a=2 r=10 op1=0 op2=0
[   78.873352] raid5: raid level 6 set md0 active with 10 out of 10 devices, algorithm 2
[   78.873353] RAID5 conf printout:
[   78.873354]  --- rd:10 wd:10
[   78.873355]  disk 0, o:1, dev:sdb
[   78.873356]  disk 1, o:1, dev:sdc
[   78.873357]  disk 2, o:1, dev:sdd
[   78.873358]  disk 3, o:1, dev:sdf
[   78.873359]  disk 4, o:1, dev:sde
[   78.873360]  disk 5, o:1, dev:sdg
[   78.873361]  disk 6, o:1, dev:sdh
[   78.873362]  disk 7, o:1, dev:sdi
[   78.873363]  disk 8, o:1, dev:sdj
[   78.873364]  disk 9, o:1, dev:sdk
[   78.873365] ...ok start reshape thread
[   78.873408] md0: detected capacity change from 0 to 10502112739328
[   78.873410] md: reshape of RAID array md0
[   78.873411] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[   78.873413] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for reshape.
[   78.873419] md: using 128k window, over a total of 1465138496 blocks.
[   78.874175]  md0: [mac] p1 p2 p3 p4
[   82.330857] md: linear personality registered for level -1
[   82.332117] md: multipath personality registered for level -4
[   82.333250] md: raid0 personality registered for level 0
[   82.334964] md: raid1 personality registered for level 1
[   82.339278] md: raid10 personality registered for level 10
[   87.379974] EXT4-fs (dm-0): mounted filesystem with ordered data mode
[  102.248479] udev: starting version 151
[  102.286226] lp: driver loaded but no devices found
[  102.324847] nvidia: module license 'NVIDIA' taints kernel.
[  102.324849] Disabling lock debugging due to kernel taint
[  102.820697] nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[  102.820704] nvidia 0000:01:00.0: setting latency timer to 64
[  102.820708] vgaarb: device changed decodes: PCI:0000:01:00.0,olddecodes=io+mem,decodes=none:owns=io+mem
[  102.820815] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  195.36.24  Thu Apr 22 19:10:14 PDT 2010
[  102.821010] type=1505 audit(1283352394.884:2):  operation="profile_load" pid=688 name="/sbin/dhclient3"
[  102.821434] type=1505 audit(1283352394.884:3):  operation="profile_load" pid=688 name="/usr/lib/NetworkManager/nm-dhcp-client.action"
[  102.821648] type=1505 audit(1283352394.884:4):  operation="profile_load" pid=688 name="/usr/lib/connman/scripts/dhclient-script"
[  102.866961]   alloc irq_desc for 22 on node -1
[  102.866964]   alloc kstat_irqs on node -1
[  102.866969] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[  102.867008] HDA Intel 0000:00:1b.0: setting latency timer to 64
[  102.897796]   alloc irq_desc for 28 on node -1
[  102.897798]   alloc kstat_irqs on node -1
[  102.897810] ATL1E 0000:02:00.0: irq 28 for MSI/MSI-X
[  102.897935] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[  102.898203] ADDRCONF(NETDEV_UP): eth0: link is not ready
[  102.898491] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  102.985492] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input6
[  103.412348] type=1505 audit(1283352395.474:5):  operation="profile_load" pid=1451 name="/usr/share/gdm/guest-session/Xsession"
[  103.413222] type=1505 audit(1283352395.474:6):  operation="profile_replace" pid=1452 name="/sbin/dhclient3"
[  103.413626] type=1505 audit(1283352395.474:7):  operation="profile_replace" pid=1452 name="/usr/lib/NetworkManager/nm-dhcp-client.action"
[  103.413844] type=1505 audit(1283352395.474:8):  operation="profile_replace" pid=1452 name="/usr/lib/connman/scripts/dhclient-script"
[  103.415462] type=1505 audit(1283352395.474:9):  operation="profile_load" pid=1453 name="/usr/bin/evince"
[  103.420596] type=1505 audit(1283352395.484:10):  operation="profile_load" pid=1453 name="/usr/bin/evince-previewer"
[  103.423831] type=1505 audit(1283352395.484:11):  operation="profile_load" pid=1453 name="/usr/bin/evince-thumbnailer"
[  103.456559] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input7
[  103.719735] iSCSI Enterprise Target Software - version 1.4.19
[  103.719873] iscsi_trgt: Registered io type fileio
[  103.719875] iscsi_trgt: Registered io type blockio
[  103.719876] iscsi_trgt: Registered io type nullio
[  103.741348] RPC: Registered udp transport module.
[  103.741350] RPC: Registered tcp transport module.
[  103.741351] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  103.754509] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  103.820056] Bridge firewalling registered
[  103.827538] virbr0: starting userspace STP failed, starting kernel STP
[  103.833785] ip_tables: (C) 2000-2006 Netfilter Core Team
[  103.850906] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[  103.851057] CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
[  103.851059] nf_conntrack.acct=1 kernel parameter, acct=1 nf_conntrack module option or
[  103.851060] sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
[  103.879987] svc: failed to register lockdv1 RPC service (errno 97).
[  103.880481] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[  103.972365] NFSD: starting 90-second grace period
[  104.692312] lo: Disabled Privacy Extensions
[  105.969872] Intel AES-NI instructions are not detected.
[  105.990773] padlock: VIA PadLock not detected.
[  106.070881] padlock: VIA PadLock Hash Engine not detected.
[  107.310443] CPU0 attaching NULL sched-domain.
[  107.310447] CPU1 attaching NULL sched-domain.
[  107.371334] CPU0 attaching sched-domain:
[  107.371338]  domain 0: span 0-1 level MC
[  107.371341]   groups: 0 1
[  107.371347] CPU1 attaching sched-domain:
[  107.371349]  domain 0: span 0-1 level MC
[  107.371351]   groups: 1 0
[  107.716463] Adding 1642488k swap on /dev/mapper/cryptswap1.  Priority:-1 extents:1 across:1642488k 
[  108.060470] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[  112.964870] Loading iSCSI transport class v2.0-870.
[  112.973597] iscsi: registered transport (tcp)
[  112.995250] iscsi: registered transport (iser)
[  113.251869] scsi14 : iSCSI Initiator over TCP/IP
[  113.255480] scsi15 : iSCSI Initiator over TCP/IP
[  113.509936] scsi 14:0:0:1: Direct-Access     IET      VIRTUAL-DISK     0    PQ: 0 ANSI: 4
[  113.510076] sd 14:0:0:1: Attached scsi generic sg11 type 0
[  113.511978] scsi 15:0:0:1: Direct-Access     IET      VIRTUAL-DISK     0    PQ: 0 ANSI: 4
[  113.512074] sd 15:0:0:1: Attached scsi generic sg12 type 0
[  113.512080] sd 14:0:0:1: [sdl] Very big device. Trying to use READ CAPACITY(16).
[  113.512119] sd 14:0:0:1: [sdl] 20511938944 512-byte logical blocks: (10.5 TB/9.55 TiB)
[  113.512157] sd 14:0:0:1: [sdl] Write Protect is off
[  113.512159] sd 14:0:0:1: [sdl] Mode Sense: 77 00 00 08
[  113.512228] sd 14:0:0:1: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  113.514237] sd 14:0:0:1: [sdl] Very big device. Trying to use READ CAPACITY(16).
[  113.514388] sd 15:0:0:1: [sdm] Very big device. Trying to use READ CAPACITY(16).
[  113.514457]  sdl:
[  113.514463] sd 15:0:0:1: [sdm] 20511938944 512-byte logical blocks: (10.5 TB/9.55 TiB)
[  113.514535] sd 15:0:0:1: [sdm] Write Protect is off
[  113.514537] sd 15:0:0:1: [sdm] Mode Sense: 77 00 00 08
[  113.514584]  [mac] sdl1
[  113.514641] sd 15:0:0:1: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  113.514635]  sdl2 sdl3
[  113.514896] sd 15:0:0:1: [sdm] Very big device. Trying to use READ CAPACITY(16).
[  113.515039]  sdm: [mac] sdm1 sdm2 sdm3 sdl4
[  113.533911]  sdm4
[  113.534185] sd 15:0:0:1: [sdm] Very big device. Trying to use READ CAPACITY(16).
[  113.534351] sd 15:0:0:1: [sdm] Attached SCSI disk
[  113.535298] sd 14:0:0:1: [sdl] Very big device. Trying to use READ CAPACITY(16).
[  113.535445] sd 14:0:0:1: [sdl] Attached SCSI disk
[  113.741210] eth0: no IPv6 routers present
[  113.812580] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 85
[  113.812785] iscsi_trgt: cmnd_skip_pdu(457) 40000000 1c 85 0
[  113.812971] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 85
[  113.813139] iscsi_trgt: cmnd_skip_pdu(457) 40000000 1c 85 0
[  113.813359] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 85
[  113.813528] iscsi_trgt: cmnd_skip_pdu(457) 41000000 1c 85 0
[  113.813707] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 85
[  113.813875] iscsi_trgt: cmnd_skip_pdu(457) 41000000 1c 85 0
[  113.814069] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 85
[  113.814238] iscsi_trgt: cmnd_skip_pdu(457) 42000000 1c 85 0
[  113.814417] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 85
[  113.814584] iscsi_trgt: cmnd_skip_pdu(457) 42000000 1c 85 0
[  114.520005] virbr0: no IPv6 routers present
[  174.865946] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  177.364396] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<10 Mbps Full Duplex>
[  180.813036] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  183.132031] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[  185.354580] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  187.593707] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[  196.739829] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  198.918277] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[  293.353393]  connection2:0: detected conn error (1020)
[  293.353426]  connection1:0: detected conn error (1020)
[  294.354168] iscsi_trgt: ioctl(248) can't find the target 1
[  294.379633] iscsi_trgt: ioctl(248) can't find the target 1
[  295.518860] iSCSI Enterprise Target Software - version 1.4.19
[  295.518934] iscsi_trgt: Registered io type fileio
[  295.518936] iscsi_trgt: Registered io type blockio
[  295.518938] iscsi_trgt: Registered io type nullio
[  323.374122] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  325.917930] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<10 Mbps Full Duplex>
[  329.342313] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  331.569913] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[  333.986268] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  336.215087] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[  345.317623] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  347.623549] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[  449.416589]  connection1:0: detected conn error (1020)
[  449.416623]  connection2:0: detected conn error (1020)
[  450.416976] iscsi_trgt: ioctl(248) can't find the target 1
[  450.434606] iscsi_trgt: ioctl(248) can't find the target 1
[  451.556218] iSCSI Enterprise Target Software - version 1.4.19
[  451.556292] iscsi_trgt: Registered io type fileio
[  451.556294] iscsi_trgt: Registered io type blockio
[  451.556296] iscsi_trgt: Registered io type nullio
[  486.582027] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  488.951952] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<10 Mbps Full Duplex>
[  492.506097] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  494.854461] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[  497.075438] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  499.389535] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[  509.890963] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[  512.195215] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[  643.689454] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 5a
[  643.695967] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 5a 0
[  695.408204]  connection2:0: detected conn error (1020)
[  695.408232]  connection1:0: detected conn error (1020)
[  696.418519] iscsi_trgt: ioctl(248) can't find the target 1
[  696.422027] iscsi_trgt: ioctl(248) can't find the target 1
[  696.425334] iscsi_trgt: ioctl(248) can't find the target 1
[  697.501891] iSCSI Enterprise Target Software - version 1.4.19
[  697.501960] iscsi_trgt: Registered io type fileio
[  697.501962] iscsi_trgt: Registered io type blockio
[  697.501964] iscsi_trgt: Registered io type nullio
[  985.097411]  connection1:0: detected conn error (1020)
[  985.097449]  connection2:0: detected conn error (1020)
[  987.038643] iscsi_trgt: ioctl(248) can't find the target 1
[  987.041371] iscsi_trgt: ioctl(248) can't find the target 1
[  987.043824] iscsi_trgt: ioctl(248) can't find the target 1
[  988.266368] iSCSI Enterprise Target Software - version 1.4.19
[  988.266432] iscsi_trgt: Registered io type fileio
[  988.266433] iscsi_trgt: Registered io type blockio
[  988.266434] iscsi_trgt: Registered io type nullio
[ 1040.925085]  connection2:0: detected conn error (1020)
[ 1040.925140]  connection1:0: detected conn error (1020)
[ 1041.439639] iscsi_trgt: ioctl(248) can't find the target 1
[ 1041.451283] iscsi_trgt: ioctl(248) can't find the target 1
[ 1041.454619] iscsi_trgt: ioctl(248) can't find the target 1
[ 1042.564580] iSCSI Enterprise Target Software - version 1.4.19
[ 1042.564641] iscsi_trgt: Registered io type fileio
[ 1042.564643] iscsi_trgt: Registered io type blockio
[ 1042.564644] iscsi_trgt: Registered io type nullio
[ 1132.902767]  connection1:0: detected conn error (1020)
[ 1132.902795]  connection2:0: detected conn error (1020)
[ 1145.372606] iscsi_trgt: ioctl(248) can't find the target 1
[ 1145.375266] iscsi_trgt: ioctl(248) can't find the target 1
[ 1145.377883] iscsi_trgt: ioctl(248) can't find the target 1
[ 1145.384192] iscsi_trgt: ioctl(248) can't find the target 1
[ 1145.387272]  connection1:0: detected conn error (1020)
[ 1145.387334] iscsi_trgt: ioctl(248) can't find the target 1
[ 1145.390914]  connection2:0: detected conn error (1020)
[ 1145.390959] iscsi_trgt: ioctl(248) can't find the target 1
[ 1146.549068] iSCSI Enterprise Target Software - version 1.4.19
[ 1146.549133] iscsi_trgt: Registered io type fileio
[ 1146.549134] iscsi_trgt: Registered io type blockio
[ 1146.549136] iscsi_trgt: Registered io type nullio
[ 1168.114226]  connection2:0: detected conn error (1020)
[ 1168.114254]  connection1:0: detected conn error (1020)
[ 1168.114372] iscsi_trgt: ioctl(248) can't find the target 1
[ 1168.121885] iscsi_trgt: ioctl(248) can't find the target 1
[ 1169.205267] iSCSI Enterprise Target Software - version 1.4.19
[ 1169.205328] iscsi_trgt: Registered io type fileio
[ 1169.205329] iscsi_trgt: Registered io type blockio
[ 1169.205330] iscsi_trgt: Registered io type nullio
[ 1183.277024] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 15
[ 1183.277248] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 15 32
[ 1184.281540] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 5a
[ 1184.281775] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 5a 0
[ 1194.963407]  connection1:0: detected conn error (1020)
[ 1194.963427]  connection2:0: detected conn error (1020)
[ 1195.963637] iscsi_trgt: ioctl(248) can't find the target 1
[ 1195.972241] iscsi_trgt: ioctl(248) can't find the target 1
[ 1195.975957] iscsi_trgt: ioctl(248) can't find the target 1
[ 1195.979466] iscsi_trgt: ioctl(248) can't find the target 1
[ 1197.054894] iSCSI Enterprise Target Software - version 1.4.19
[ 1197.054954] iscsi_trgt: Registered io type fileio
[ 1197.054956] iscsi_trgt: Registered io type blockio
[ 1197.054957] iscsi_trgt: Registered io type nullio
[ 1237.740245] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 5a
[ 1237.749461] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 5a 0
[ 1299.717106]  connection2:0: detected conn error (1020)
[ 1299.717243]  connection1:0: detected conn error (1020)
[ 1299.940934] iscsi_trgt: ioctl(248) can't find the target 1
[ 1299.943739] iscsi_trgt: ioctl(248) can't find the target 1
[ 1299.946283] iscsi_trgt: ioctl(248) can't find the target 1
[ 1301.025594] iSCSI Enterprise Target Software - version 1.4.19
[ 1301.025671] iscsi_trgt: Registered io type fileio
[ 1301.025673] iscsi_trgt: Registered io type blockio
[ 1301.025674] iscsi_trgt: Registered io type nullio
[ 1340.248711] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 5a
[ 1340.257832] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 5a 0
[ 1398.488476]  connection1:0: detected conn error (1020)
[ 1398.488599]  connection2:0: detected conn error (1020)
[ 1398.675596] iscsi_trgt: ioctl(248) can't find the target 1
[ 1398.678139] iscsi_trgt: ioctl(248) can't find the target 1
[ 1398.680683] iscsi_trgt: ioctl(248) can't find the target 1
[ 1398.683378] iscsi_trgt: ioctl(248) can't find the target 1
[ 1399.746924] iSCSI Enterprise Target Software - version 1.4.19
[ 1399.746995] iscsi_trgt: Registered io type fileio
[ 1399.746996] iscsi_trgt: Registered io type blockio
[ 1399.746997] iscsi_trgt: Registered io type nullio
[ 1406.310869] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 5a
[ 1406.319735] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 5a 0
[ 1574.068870]  connection2:0: detected conn error (1020)
[ 1574.068900]  connection1:0: detected conn error (1020)
[ 1574.749235] iscsi_trgt: ioctl(248) can't find the target 1
[ 1574.752014] iscsi_trgt: ioctl(248) can't find the target 1
[ 1574.754530] iscsi_trgt: ioctl(248) can't find the target 1
[ 1574.757042] iscsi_trgt: ioctl(248) can't find the target 1
[ 1575.928236] iSCSI Enterprise Target Software - version 1.4.19
[ 1575.928296] iscsi_trgt: Registered io type fileio
[ 1575.928298] iscsi_trgt: Registered io type blockio
[ 1575.928299] iscsi_trgt: Registered io type nullio
[ 1583.732857] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 5a
[ 1583.741676] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 5a 0
[ 1649.767931]  connection1:0: detected conn error (1020)
[ 1649.770024]  connection2:0: detected conn error (1020)
[ 1650.023059] iscsi_trgt: ioctl(248) can't find the target 1
[ 1650.028366] iscsi_trgt: ioctl(248) can't find the target 1
[ 1650.028438] iscsi_trgt: ioctl(248) can't find the target 1
[ 1650.028591] iscsi_trgt: ioctl(248) can't find the target 1
[ 1651.112145] iSCSI Enterprise Target Software - version 1.4.19
[ 1651.112243] iscsi_trgt: Registered io type fileio
[ 1651.112245] iscsi_trgt: Registered io type blockio
[ 1651.112246] iscsi_trgt: Registered io type nullio
[ 1659.189185] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 15
[ 1659.196043] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 15 32
[ 1660.203956] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 5a
[ 1660.207942] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 5a 0
[ 1710.650670]  connection2:0: detected conn error (1020)
[ 1710.650717]  connection1:0: detected conn error (1020)
[ 1710.650887] iscsi_trgt: ioctl(248) can't find the target 1
[ 1710.656331] iscsi_trgt: ioctl(248) can't find the target 1
[ 1710.659727] iscsi_trgt: ioctl(248) can't find the target 1
[ 1711.734921] iSCSI Enterprise Target Software - version 1.4.19
[ 1711.734982] iscsi_trgt: Registered io type fileio
[ 1711.734983] iscsi_trgt: Registered io type blockio
[ 1711.734984] iscsi_trgt: Registered io type nullio
[ 1723.922125] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 5a
[ 1723.933235] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 5a 0
[ 6147.710014] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[ 6155.168058] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<10 Mbps Full Duplex>
[ 6158.573440] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[ 6160.836264] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[ 6163.114509] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[ 6165.342508] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[ 6186.286765] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[ 6188.494966] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[ 6214.443871] ata8.01: exception Emask 0x0 SAct 0x59ce7fb5 SErr 0x0 action 0x6
[ 6214.443876] ata8.01: irq_stat 0x03060002, device error via SDB FIS
[ 6214.443880] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.443886] ata8.01: cmd 60/10:00:d0:9e:41/00:00:29:00:00/40 tag 0 ncq 8192 in
[ 6214.443887]          res 60/10:00:d0:9e:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6214.443890] ata8.01: status: { DRDY DF }
[ 6214.443891] ata8.01: error: { IDNF }
[ 6214.443894] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.443899] ata8.01: cmd 60/30:10:e0:9e:41/00:00:29:00:00/40 tag 2 ncq 24576 in
[ 6214.443900]          res 60/30:10:e0:9e:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6214.443903] ata8.01: status: { DRDY DF }
[ 6214.443905] ata8.01: error: { IDNF }
[ 6214.443907] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.443912] ata8.01: cmd 60/20:20:d8:9d:41/00:00:29:00:00/40 tag 4 ncq 16384 in
[ 6214.443913]          res 60/20:20:d8:9d:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6214.443916] ata8.01: status: { DRDY DF }
[ 6214.443918] ata8.01: failed command: WRITE FPDMA QUEUED
[ 6214.443923] ata8.01: cmd 61/78:28:78:68:19/00:00:24:00:00/40 tag 5 ncq 61440 out
[ 6214.443924]          res 61/78:28:78:68:19/00:00:24:00:00/40 Emask 0x89 (media error)
[ 6214.443927] ata8.01: status: { DRDY DF ERR }
[ 6214.443929] ata8.01: error: { UNC IDNF }
[ 6214.443932] ata8.01: failed command: WRITE FPDMA QUEUED
[ 6214.443937] ata8.01: cmd 61/38:38:60:67:19/00:00:24:00:00/40 tag 7 ncq 28672 out
[ 6214.443938]          res 61/38:38:60:67:19/00:00:24:00:00/40 Emask 0x81 (invalid argument)
[ 6214.443940] ata8.01: status: { DRDY DF ERR }
[ 6214.443942] ata8.01: error: { IDNF }
[ 6214.443945] ata8.01: failed command: WRITE FPDMA QUEUED
[ 6214.443950] ata8.01: cmd 61/30:40:98:67:19/00:00:24:00:00/40 tag 8 ncq 24576 out
[ 6214.443951]          res 61/30:40:98:67:19/00:00:24:00:00/40 Emask 0x81 (invalid argument)
[ 6214.443953] ata8.01: status: { DRDY DF ERR }
[ 6214.443955] ata8.01: error: { IDNF }
[ 6214.443958] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.443963] ata8.01: cmd 60/28:48:30:9e:41/00:00:29:00:00/40 tag 9 ncq 20480 in
[ 6214.443964]          res 60/28:48:30:9e:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6214.443967] ata8.01: status: { DRDY DF }
[ 6214.443969] ata8.01: failed command: WRITE FPDMA QUEUED
[ 6214.443974] ata8.01: cmd 61/70:50:08:68:19/00:00:24:00:00/40 tag 10 ncq 57344 out
[ 6214.443975]          res 61/70:50:08:68:19/00:00:24:00:00/40 Emask 0x89 (media error)
[ 6214.443978] ata8.01: status: { DRDY DF ERR }
[ 6214.443980] ata8.01: error: { UNC IDNF }
[ 6214.443982] ata8.01: failed command: WRITE FPDMA QUEUED
[ 6214.443987] ata8.01: cmd 61/40:58:c8:67:19/00:00:24:00:00/40 tag 11 ncq 32768 out
[ 6214.443988]          res 61/40:58:c8:67:19/00:00:24:00:00/40 Emask 0x9 (media error)
[ 6214.443991] ata8.01: status: { DRDY DF ERR }
[ 6214.443993] ata8.01: error: { UNC }
[ 6214.443995] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.444000] ata8.01: cmd 60/28:60:10:9f:41/00:00:29:00:00/40 tag 12 ncq 20480 in
[ 6214.444001]          res 60/28:60:10:9f:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6214.444004] ata8.01: status: { DRDY DF }
[ 6214.444006] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.444011] ata8.01: cmd 60/70:68:88:9c:41/00:00:29:00:00/40 tag 13 ncq 57344 in
[ 6214.444012]          res 41/84:00:88:9c:41/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>
[ 6214.444015] ata8.01: status: { DRDY ERR }
[ 6214.444017] ata8.01: error: { ICRC ABRT }
[ 6214.444019] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.444024] ata8.01: cmd 60/10:70:98:9e:41/00:00:29:00:00/40 tag 14 ncq 8192 in
[ 6214.444025]          res 60/10:70:98:9e:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6214.444028] ata8.01: status: { DRDY DF }
[ 6214.444030] ata8.01: error: { IDNF }
[ 6214.444032] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.444037] ata8.01: cmd 60/08:88:28:9e:41/00:00:29:00:00/40 tag 17 ncq 4096 in
[ 6214.444038]          res 60/08:88:28:9e:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6214.444041] ata8.01: status: { DRDY DF }
[ 6214.444043] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.444048] ata8.01: cmd 60/c0:90:f8:9c:41/00:00:29:00:00/40 tag 18 ncq 98304 in
[ 6214.444049]          res f5/26:01:01:00:00/00:00:00:20:f5/00 Emask 0x2 (HSM violation)
[ 6214.444052] ata8.01: status: { Busy }
[ 6214.444054] ata8.01: error: { ABRT }
[ 6214.444056] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.444061] ata8.01: cmd 60/28:98:a8:9e:41/00:00:29:00:00/40 tag 19 ncq 20480 in
[ 6214.444062]          res 60/28:98:a8:9e:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6214.444065] ata8.01: status: { DRDY DF }
[ 6214.444067] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.444072] ata8.01: cmd 60/38:b0:60:9e:41/00:00:29:00:00/40 tag 22 ncq 28672 in
[ 6214.444073]          res 60/38:b0:60:9e:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6214.444076] ata8.01: status: { DRDY DF }
[ 6214.444078] ata8.01: error: { IDNF }
[ 6214.444080] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.444085] ata8.01: cmd 60/08:b8:58:9e:41/00:00:29:00:00/40 tag 23 ncq 4096 in
[ 6214.444086]          res 60/08:b8:58:9e:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6214.444089] ata8.01: status: { DRDY DF }
[ 6214.444091] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.444096] ata8.01: cmd 60/30:c0:f8:9d:41/00:00:29:00:00/40 tag 24 ncq 24576 in
[ 6214.444097]          res 60/30:c0:f8:9d:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6214.444100] ata8.01: status: { DRDY DF }
[ 6214.444102] ata8.01: error: { IDNF }
[ 6214.444104] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.444109] ata8.01: cmd 60/50:d8:38:9f:41/00:00:29:00:00/40 tag 27 ncq 40960 in
[ 6214.444110]          res 60/50:d8:38:9f:41/00:00:29:00:00/40 Emask 0x89 (media error)
[ 6214.444113] ata8.01: status: { DRDY DF }
[ 6214.444115] ata8.01: error: { UNC IDNF }
[ 6214.444117] ata8.01: failed command: WRITE FPDMA QUEUED
[ 6214.444122] ata8.01: cmd 61/c8:e0:98:66:19/00:00:24:00:00/40 tag 28 ncq 102400 out
[ 6214.444123]          res 61/c8:e0:98:66:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6214.444126] ata8.01: status: { DRDY DF ERR }
[ 6214.444128] ata8.01: error: { ICRC UNC }
[ 6214.444130] ata8.01: failed command: READ FPDMA QUEUED
[ 6214.444135] ata8.01: cmd 60/20:f0:b8:9d:41/00:00:29:00:00/40 tag 30 ncq 16384 in
[ 6214.444136]          res 60/20:f0:b8:9d:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6214.444139] ata8.01: status: { DRDY DF }
[ 6214.444205] ata8.01: hard resetting link
[ 6214.790349] ata8.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6214.796532] ata8.01: configured for UDMA/100
[ 6214.796627] ata8: EH complete
[ 6215.402641] ata8.04: exception Emask 0x0 SAct 0x64ae1350 SErr 0x0 action 0x6
[ 6215.402646] ata8.04: irq_stat 0x03060002, device error via SDB FIS
[ 6215.402650] ata8.04: failed command: READ FPDMA QUEUED
[ 6215.402655] ata8.04: cmd 60/30:20:e0:b1:41/00:00:29:00:00/40 tag 4 ncq 24576 in
[ 6215.402656]          res 60/30:20:e0:b1:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6215.402659] ata8.04: status: { DRDY DF }
[ 6215.402661] ata8.04: error: { IDNF }
[ 6215.402664] ata8.04: failed command: READ FPDMA QUEUED
[ 6215.402669] ata8.04: cmd 60/60:30:20:b2:41/00:00:29:00:00/40 tag 6 ncq 49152 in
[ 6215.402670]          res 60/60:30:20:b2:41/00:00:29:00:00/40 Emask 0x9 (media error)
[ 6215.402672] ata8.04: status: { DRDY DF }
[ 6215.402674] ata8.04: error: { UNC }
[ 6215.402677] ata8.04: failed command: READ FPDMA QUEUED
[ 6215.402682] ata8.04: cmd 60/80:40:60:b1:41/00:00:29:00:00/40 tag 8 ncq 65536 in
[ 6215.402683]          res 60/80:40:60:b1:41/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 6215.402685] ata8.04: status: { DRDY DF }
[ 6215.402687] ata8.04: error: { ICRC }
[ 6215.402690] ata8.04: failed command: READ FPDMA QUEUED
[ 6215.402695] ata8.04: cmd 60/10:48:10:b2:41/00:00:29:00:00/40 tag 9 ncq 8192 in
[ 6215.402696]          res 60/10:48:10:b2:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6215.402698] ata8.04: status: { DRDY DF }
[ 6215.402700] ata8.04: error: { IDNF }
[ 6215.402703] ata8.04: failed command: READ FPDMA QUEUED
[ 6215.402708] ata8.04: cmd 60/28:60:a8:b0:41/00:00:29:00:00/40 tag 12 ncq 20480 in
[ 6215.402709]          res 41/84:00:a8:b0:41/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>
[ 6215.402712] ata8.04: status: { DRDY ERR }
[ 6215.402714] ata8.04: error: { ICRC ABRT }
[ 6215.402716] ata8.04: failed command: READ FPDMA QUEUED
[ 6215.402721] ata8.04: cmd 60/90:88:d0:b0:41/00:00:29:00:00/40 tag 17 ncq 73728 in
[ 6215.402722]          res 60/90:88:d0:b0:41/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 6215.402725] ata8.04: status: { DRDY DF }
[ 6215.402727] ata8.04: error: { ICRC IDNF }
[ 6215.402729] ata8.04: failed command: WRITE FPDMA QUEUED
[ 6215.402734] ata8.04: cmd 61/b8:90:98:79:19/00:00:24:00:00/40 tag 18 ncq 94208 out
[ 6215.402735]          res 61/b8:90:98:79:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6215.402738] ata8.04: status: { DRDY DF ERR }
[ 6215.402740] ata8.04: error: { ICRC IDNF }
[ 6215.402742] ata8.04: failed command: READ FPDMA QUEUED
[ 6215.402747] ata8.04: cmd 60/60:98:80:b2:41/00:00:29:00:00/40 tag 19 ncq 49152 in
[ 6215.402748]          res 60/60:98:80:b2:41/00:00:29:00:00/40 Emask 0x9 (media error)
[ 6215.402751] ata8.04: status: { DRDY DF }
[ 6215.402753] ata8.04: error: { UNC }
[ 6215.402755] ata8.04: failed command: WRITE FPDMA QUEUED
[ 6215.402760] ata8.04: cmd 61/40:a8:50:7a:19/00:00:24:00:00/40 tag 21 ncq 32768 out
[ 6215.402761]          res 61/40:a8:50:7a:19/00:00:24:00:00/40 Emask 0x9 (media error)
[ 6215.402764] ata8.04: status: { DRDY DF ERR }
[ 6215.402766] ata8.04: error: { UNC }
[ 6215.402768] ata8.04: failed command: WRITE FPDMA QUEUED
[ 6215.402773] ata8.04: cmd 61/80:b8:18:79:19/00:00:24:00:00/40 tag 23 ncq 65536 out
[ 6215.402774]          res 61/80:b8:18:79:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6215.402777] ata8.04: status: { DRDY DF ERR }
[ 6215.402779] ata8.04: error: { ICRC }
[ 6215.402782] ata8.04: failed command: WRITE FPDMA QUEUED
[ 6215.402787] ata8.04: cmd 61/d8:d0:a8:77:19/00:00:24:00:00/40 tag 26 ncq 110592 out
[ 6215.402788]          res 61/d8:d0:a8:77:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6215.402791] ata8.04: status: { DRDY DF ERR }
[ 6215.402793] ata8.04: error: { ICRC UNC IDNF }
[ 6215.402795] ata8.04: failed command: READ FPDMA QUEUED
[ 6215.402800] ata8.04: cmd 60/80:e8:e0:b2:41/00:00:29:00:00/40 tag 29 ncq 65536 in
[ 6215.402801]          res 60/80:e8:e0:b2:41/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 6215.402804] ata8.04: status: { DRDY DF }
[ 6215.402806] ata8.04: error: { ICRC }
[ 6215.402808] ata8.04: failed command: WRITE FPDMA QUEUED
[ 6215.402813] ata8.04: cmd 61/98:f0:80:78:19/00:00:24:00:00/40 tag 30 ncq 77824 out
[ 6215.402814]          res 61/98:f0:80:78:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6215.402817] ata8.04: status: { DRDY DF ERR }
[ 6215.402819] ata8.04: error: { ICRC IDNF }
[ 6215.402884] ata8.04: hard resetting link
[ 6215.750355] ata8.04: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6215.757286] ata8.04: configured for UDMA/100
[ 6215.757375] ata8: EH complete
[ 6216.016784] ata8.02: exception Emask 0x0 SAct 0x311d61ab SErr 0x0 action 0x6
[ 6216.016789] ata8.02: irq_stat 0x03060002, device error via SDB FIS
[ 6216.016793] ata8.02: failed command: READ FPDMA QUEUED
[ 6216.016799] ata8.02: cmd 60/20:00:88:b9:41/00:00:29:00:00/40 tag 0 ncq 16384 in
[ 6216.016800]          res 60/20:00:88:b9:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6216.016802] ata8.02: status: { DRDY DF }
[ 6216.016805] ata8.02: failed command: READ FPDMA QUEUED
[ 6216.016810] ata8.02: cmd 60/40:08:90:b7:41/00:00:29:00:00/40 tag 1 ncq 32768 in
[ 6216.016811]          res 41/84:00:90:b7:41/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>
[ 6216.016814] ata8.02: status: { DRDY ERR }
[ 6216.016816] ata8.02: error: { ICRC ABRT }
[ 6216.016818] ata8.02: failed command: WRITE FPDMA QUEUED
[ 6216.016823] ata8.02: cmd 61/80:18:18:80:19/00:00:24:00:00/40 tag 3 ncq 65536 out
[ 6216.016824]          res 61/80:18:18:80:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6216.016827] ata8.02: status: { DRDY DF ERR }
[ 6216.016829] ata8.02: error: { ICRC }
[ 6216.016831] ata8.02: failed command: READ FPDMA QUEUED
[ 6216.016836] ata8.02: cmd 60/48:28:70:b8:41/00:00:29:00:00/40 tag 5 ncq 36864 in
[ 6216.016837]          res 60/48:28:70:b8:41/00:00:29:00:00/40 Emask 0x9 (media error)
[ 6216.016840] ata8.02: status: { DRDY DF }
[ 6216.016842] ata8.02: error: { UNC }
[ 6216.016844] ata8.02: failed command: WRITE FPDMA QUEUED
[ 6216.016849] ata8.02: cmd 61/58:38:a8:7e:19/00:00:24:00:00/40 tag 7 ncq 45056 out
[ 6216.016850]          res 61/58:38:a8:7e:19/00:00:24:00:00/40 Emask 0x89 (media error)
[ 6216.016853] ata8.02: status: { DRDY DF ERR }
[ 6216.016855] ata8.02: error: { UNC IDNF }
[ 6216.016857] ata8.02: failed command: READ FPDMA QUEUED
[ 6216.016862] ata8.02: cmd 60/10:40:b8:ba:41/00:00:29:00:00/40 tag 8 ncq 8192 in
[ 6216.016863]          res 60/10:40:b8:ba:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6216.016866] ata8.02: status: { DRDY DF }
[ 6216.016868] ata8.02: error: { IDNF }
[ 6216.016870] ata8.02: failed command: READ FPDMA QUEUED
[ 6216.016875] ata8.02: cmd 60/20:68:50:b8:41/00:00:29:00:00/40 tag 13 ncq 16384 in
[ 6216.016876]          res 60/20:68:50:b8:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6216.016879] ata8.02: status: { DRDY DF }
[ 6216.016881] ata8.02: failed command: READ FPDMA QUEUED
[ 6216.016886] ata8.02: cmd 60/50:70:68:ba:41/00:00:29:00:00/40 tag 14 ncq 40960 in
[ 6216.016887]          res 60/50:70:68:ba:41/00:00:29:00:00/40 Emask 0x89 (media error)
[ 6216.016890] ata8.02: status: { DRDY DF }
[ 6216.016892] ata8.02: error: { UNC IDNF }
[ 6216.016894] ata8.02: failed command: READ FPDMA QUEUED
[ 6216.016899] ata8.02: cmd 60/c0:80:a8:b9:41/00:00:29:00:00/40 tag 16 ncq 98304 in
[ 6216.016900]          res 60/c0:80:a8:b9:41/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 6216.016903] ata8.02: status: { DRDY DF }
[ 6216.016904] ata8.02: error: { ICRC UNC }
[ 6216.016907] ata8.02: failed command: READ FPDMA QUEUED
[ 6216.016912] ata8.02: cmd 60/50:90:d0:b7:41/00:00:29:00:00/40 tag 18 ncq 40960 in
[ 6216.016913]          res 60/50:90:d0:b7:41/00:00:29:00:00/40 Emask 0x89 (media error)
[ 6216.016916] ata8.02: status: { DRDY DF }
[ 6216.016917] ata8.02: error: { UNC IDNF }
[ 6216.016920] ata8.02: failed command: READ FPDMA QUEUED
[ 6216.016925] ata8.02: cmd 60/30:98:20:b8:41/00:00:29:00:00/40 tag 19 ncq 24576 in
[ 6216.016926]          res 60/30:98:20:b8:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6216.016928] ata8.02: status: { DRDY DF }
[ 6216.016930] ata8.02: error: { IDNF }
[ 6216.016932] ata8.02: failed command: READ FPDMA QUEUED
[ 6216.016937] ata8.02: cmd 60/b0:a0:b8:b8:41/00:00:29:00:00/40 tag 20 ncq 90112 in
[ 6216.016938]          res 60/b0:a0:b8:b8:41/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 6216.016941] ata8.02: status: { DRDY DF }
[ 6216.016943] ata8.02: error: { ICRC IDNF }
[ 6216.016945] ata8.02: failed command: READ FPDMA QUEUED
[ 6216.016950] ata8.02: cmd 60/20:c0:68:b9:41/00:00:29:00:00/40 tag 24 ncq 16384 in
[ 6216.016951]          res 60/20:c0:68:b9:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6216.016954] ata8.02: status: { DRDY DF }
[ 6216.016956] ata8.02: failed command: WRITE FPDMA QUEUED
[ 6216.016961] ata8.02: cmd 61/90:e0:00:7f:19/00:00:24:00:00/40 tag 28 ncq 73728 out
[ 6216.016962]          res 61/90:e0:00:7f:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6216.016965] ata8.02: status: { DRDY DF ERR }
[ 6216.016967] ata8.02: error: { ICRC IDNF }
[ 6216.016969] ata8.02: failed command: WRITE FPDMA QUEUED
[ 6216.016974] ata8.02: cmd 61/88:e8:90:7f:19/00:00:24:00:00/40 tag 29 ncq 69632 out
[ 6216.016975]          res 61/88:e8:90:7f:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6216.016978] ata8.02: status: { DRDY DF ERR }
[ 6216.016980] ata8.02: error: { ICRC }
[ 6216.017045] ata8.02: hard resetting link
[ 6216.360355] ata8.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6216.367429] ata8.02: configured for UDMA/100
[ 6216.367522] ata8: EH complete
[ 6217.243768] ata8.03: exception Emask 0x0 SAct 0x6a452144 SErr 0x0 action 0x6
[ 6217.243773] ata8.03: irq_stat 0x03060002, device error via SDB FIS
[ 6217.243777] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6217.243783] ata8.03: cmd 61/40:10:e8:9b:19/00:00:24:00:00/40 tag 2 ncq 32768 out
[ 6217.243784]          res 61/40:10:e8:9b:19/00:00:24:00:00/40 Emask 0x9 (media error)
[ 6217.243787] ata8.03: status: { DRDY DF ERR }
[ 6217.243789] ata8.03: error: { UNC }
[ 6217.243791] ata8.03: failed command: READ FPDMA QUEUED
[ 6217.243796] ata8.03: cmd 60/70:30:78:d7:41/00:00:29:00:00/40 tag 6 ncq 57344 in
[ 6217.243797]          res 60/70:30:78:d7:41/00:00:29:00:00/40 Emask 0x89 (media error)
[ 6217.243800] ata8.03: status: { DRDY DF }
[ 6217.243802] ata8.03: error: { UNC IDNF }
[ 6217.243804] ata8.03: failed command: READ FPDMA QUEUED
[ 6217.243809] ata8.03: cmd 60/60:40:e0:d8:41/00:00:29:00:00/40 tag 8 ncq 49152 in
[ 6217.243811]          res 60/60:40:e0:d8:41/00:00:29:00:00/40 Emask 0x9 (media error)
[ 6217.243813] ata8.03: status: { DRDY DF }
[ 6217.243815] ata8.03: error: { UNC }
[ 6217.243817] ata8.03: failed command: READ FPDMA QUEUED
[ 6217.243822] ata8.03: cmd 60/78:68:40:d9:41/00:00:29:00:00/40 tag 13 ncq 61440 in
[ 6217.243824]          res 60/78:68:40:d9:41/00:00:29:00:00/40 Emask 0x89 (media error)
[ 6217.243826] ata8.03: status: { DRDY DF }
[ 6217.243828] ata8.03: error: { UNC IDNF }
[ 6217.243831] ata8.03: failed command: READ FPDMA QUEUED
[ 6217.243836] ata8.03: cmd 60/60:80:b8:d9:41/00:00:29:00:00/40 tag 16 ncq 49152 in
[ 6217.243837]          res 60/60:80:b8:d9:41/00:00:29:00:00/40 Emask 0x9 (media error)
[ 6217.243839] ata8.03: status: { DRDY DF }
[ 6217.243841] ata8.03: error: { UNC }
[ 6217.243844] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6217.243849] ata8.03: cmd 61/10:90:98:9a:19/01:00:24:00:00/40 tag 18 ncq 139264 out
[ 6217.243850]          res 61/10:90:98:9a:19/00:00:24:00:00/40 Emask 0x81 (invalid argument)
[ 6217.243853] ata8.03: status: { DRDY DF ERR }
[ 6217.243855] ata8.03: error: { IDNF }
[ 6217.243857] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6217.243862] ata8.03: cmd 61/40:b0:a8:9b:19/00:00:24:00:00/40 tag 22 ncq 32768 out
[ 6217.243863]          res 61/40:b0:a8:9b:19/00:00:24:00:00/40 Emask 0x9 (media error)
[ 6217.243866] ata8.03: status: { DRDY DF ERR }
[ 6217.243868] ata8.03: error: { UNC }
[ 6217.243870] ata8.03: failed command: READ FPDMA QUEUED
[ 6217.243875] ata8.03: cmd 60/90:c8:50:d8:41/00:00:29:00:00/40 tag 25 ncq 73728 in
[ 6217.243876]          res 60/90:c8:50:d8:41/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 6217.243879] ata8.03: status: { DRDY DF }
[ 6217.243880] ata8.03: error: { ICRC IDNF }
[ 6217.243883] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6217.243888] ata8.03: cmd 61/c0:d8:d8:99:19/00:00:24:00:00/40 tag 27 ncq 98304 out
[ 6217.243889]          res 61/c0:d8:d8:99:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6217.243892] ata8.03: status: { DRDY DF ERR }
[ 6217.243894] ata8.03: error: { ICRC UNC }
[ 6217.243896] ata8.03: failed command: READ FPDMA QUEUED
[ 6217.243901] ata8.03: cmd 60/68:e8:10:d7:41/00:00:29:00:00/40 tag 29 ncq 53248 in
[ 6217.243902]          res 41/84:00:10:d7:41/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>
[ 6217.243905] ata8.03: status: { DRDY ERR }
[ 6217.243907] ata8.03: error: { ICRC ABRT }
[ 6217.243909] ata8.03: failed command: READ FPDMA QUEUED
[ 6217.243914] ata8.03: cmd 60/68:f0:e8:d7:41/00:00:29:00:00/40 tag 30 ncq 53248 in
[ 6217.243915]          res 60/68:f0:e8:d7:41/00:00:29:00:00/40 Emask 0x9 (media error)
[ 6217.243918] ata8.03: status: { DRDY DF }
[ 6217.243920] ata8.03: error: { UNC }
[ 6217.243985] ata8.03: hard resetting link
[ 6217.590348] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6217.598713] ata8.03: configured for UDMA/100
[ 6217.598798] ata8: EH complete
[ 6217.901465] ata8.00: exception Emask 0x0 SAct 0x483a549a SErr 0x0 action 0x6
[ 6217.901471] ata8.00: failed command: WRITE FPDMA QUEUED
[ 6217.901477] ata8.00: cmd 61/08:08:50:a1:19/00:00:24:00:00/40 tag 1 ncq 4096 out
[ 6217.901478]          res 61/08:08:50:a1:19/00:00:24:00:00/40 Emask 0x1 (device error)
[ 6217.901481] ata8.00: status: { DRDY DF ERR }
[ 6217.901484] ata8.00: failed command: READ FPDMA QUEUED
[ 6217.901489] ata8.00: cmd 60/90:18:50:e0:41/00:00:29:00:00/40 tag 3 ncq 73728 in
[ 6217.901490]          res 60/90:18:50:e0:41/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 6217.901492] ata8.00: status: { DRDY DF }
[ 6217.901494] ata8.00: error: { ICRC IDNF }
[ 6217.901497] ata8.00: failed command: WRITE FPDMA QUEUED
[ 6217.901502] ata8.00: cmd 61/20:20:58:a1:19/00:00:24:00:00/40 tag 4 ncq 16384 out
[ 6217.901503]          res 61/20:20:58:a1:19/00:00:24:00:00/40 Emask 0x1 (device error)
[ 6217.901506] ata8.00: status: { DRDY DF ERR }
[ 6217.901508] ata8.00: failed command: WRITE FPDMA QUEUED
[ 6217.901513] ata8.00: cmd 61/48:38:d0:a1:19/00:00:24:00:00/40 tag 7 ncq 36864 out
[ 6217.901514]          res 61/48:38:d0:a1:19/00:00:24:00:00/40 Emask 0x9 (media error)
[ 6217.901517] ata8.00: status: { DRDY DF ERR }
[ 6217.901519] ata8.00: error: { UNC }
[ 6217.901521] ata8.00: failed command: READ FPDMA QUEUED
[ 6217.901526] ata8.00: cmd 60/c8:50:a8:de:41/00:00:29:00:00/40 tag 10 ncq 102400 in
[ 6217.901527]          res f4/26:01:01:00:00/00:00:40:a0:f4/00 Emask 0x2 (HSM violation)
[ 6217.901530] ata8.00: status: { Busy }
[ 6217.901532] ata8.00: error: { ABRT }
[ 6217.901534] ata8.00: failed command: READ FPDMA QUEUED
[ 6217.901539] ata8.00: cmd 60/20:60:30:e0:41/00:00:29:00:00/40 tag 12 ncq 16384 in
[ 6217.901540]          res 60/20:60:30:e0:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6217.901543] ata8.00: status: { DRDY DF }
[ 6217.901545] ata8.00: failed command: READ FPDMA QUEUED
[ 6217.901550] ata8.00: cmd 60/08:70:28:e0:41/00:00:29:00:00/40 tag 14 ncq 4096 in
[ 6217.901551]          res 60/08:70:28:e0:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6217.901554] ata8.00: status: { DRDY DF }
[ 6217.901556] ata8.00: failed command: READ FPDMA QUEUED
[ 6217.901561] ata8.00: cmd 60/10:88:e0:df:41/00:00:29:00:00/40 tag 17 ncq 8192 in
[ 6217.901562]          res 60/10:88:e0:df:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6217.901565] ata8.00: status: { DRDY DF }
[ 6217.901567] ata8.00: error: { IDNF }
[ 6217.901569] ata8.00: failed command: READ FPDMA QUEUED
[ 6217.901574] ata8.00: cmd 60/28:98:00:e0:41/00:00:29:00:00/40 tag 19 ncq 20480 in
[ 6217.901575]          res 60/28:98:00:e0:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6217.901578] ata8.00: status: { DRDY DF }
[ 6217.901580] ata8.00: failed command: WRITE FPDMA QUEUED
[ 6217.901585] ata8.00: cmd 61/58:a0:f8:a0:19/00:00:24:00:00/40 tag 20 ncq 45056 out
[ 6217.901586]          res 61/58:a0:f8:a0:19/00:00:24:00:00/40 Emask 0x89 (media error)
[ 6217.901589] ata8.00: status: { DRDY DF ERR }
[ 6217.901591] ata8.00: error: { UNC IDNF }
[ 6217.901593] ata8.00: failed command: READ FPDMA QUEUED
[ 6217.901598] ata8.00: cmd 60/10:a8:f0:df:41/00:00:29:00:00/40 tag 21 ncq 8192 in
[ 6217.901599]          res 60/10:a8:f0:df:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6217.901602] ata8.00: status: { DRDY DF }
[ 6217.901603] ata8.00: error: { IDNF }
[ 6217.901606] ata8.00: failed command: READ FPDMA QUEUED
[ 6217.901611] ata8.00: cmd 60/70:d8:70:df:41/00:00:29:00:00/40 tag 27 ncq 57344 in
[ 6217.901612]          res 60/70:d8:70:df:41/00:00:29:00:00/40 Emask 0x89 (media error)
[ 6217.901614] ata8.00: status: { DRDY DF }
[ 6217.901616] ata8.00: error: { UNC IDNF }
[ 6217.901619] ata8.00: failed command: WRITE FPDMA QUEUED
[ 6217.901624] ata8.00: cmd 61/58:f0:78:a1:19/00:00:24:00:00/40 tag 30 ncq 45056 out
[ 6217.901625]          res 61/58:f0:78:a1:19/00:00:24:00:00/40 Emask 0x89 (media error)
[ 6217.901627] ata8.00: status: { DRDY DF ERR }
[ 6217.901629] ata8.00: error: { UNC IDNF }
[ 6217.901632] ata8.01: exception Emask 0x1 SAct 0x37852065 SErr 0x0 action 0x6
[ 6217.901635] ata8.01: irq_stat 0x03060002, device error via SDB FIS
[ 6217.901637] ata8.01: failed command: WRITE FPDMA QUEUED
[ 6217.901642] ata8.01: cmd 61/20:00:58:a1:19/00:00:24:00:00/40 tag 0 ncq 16384 out
[ 6217.901643]          res 61/20:00:58:a1:19/00:00:24:00:00/40 Emask 0x1 (device error)
[ 6217.901646] ata8.01: status: { DRDY DF ERR }
[ 6217.901648] ata8.01: failed command: WRITE FPDMA QUEUED
[ 6217.901653] ata8.01: cmd 61/08:10:50:a1:19/00:00:24:00:00/40 tag 2 ncq 4096 out
[ 6217.901655]          res 61/08:10:50:a1:19/00:00:24:00:00/40 Emask 0x1 (device error)
[ 6217.901657] ata8.01: status: { DRDY DF ERR }
[ 6217.901660] ata8.01: failed command: READ FPDMA QUEUED
[ 6217.901665] ata8.01: cmd 60/10:28:28:e0:41/00:00:29:00:00/40 tag 5 ncq 8192 in
[ 6217.901666]          res 60/10:28:28:e0:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6217.901668] ata8.01: status: { DRDY DF }
[ 6217.901670] ata8.01: error: { IDNF }
[ 6217.901673] ata8.01: failed command: READ FPDMA QUEUED
[ 6217.901678] ata8.01: cmd 60/00:30:e0:de:41/01:00:29:00:00/40 tag 6 ncq 131072 in
[ 6217.901679]          res 60/00:30:e0:de:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6217.901681] ata8.01: status: { DRDY DF }
[ 6217.901684] ata8.01: failed command: READ FPDMA QUEUED
[ 6217.901689] ata8.01: cmd 60/38:68:38:e0:41/00:00:29:00:00/40 tag 13 ncq 28672 in
[ 6217.901690]          res 60/38:68:38:e0:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6217.901693] ata8.01: status: { DRDY DF }
[ 6217.901695] ata8.01: error: { IDNF }
[ 6217.901697] ata8.01: failed command: WRITE FPDMA QUEUED
[ 6217.901702] ata8.01: cmd 61/70:80:78:a1:19/00:00:24:00:00/40 tag 16 ncq 57344 out
[ 6217.901703]          res 61/70:80:78:a1:19/00:00:24:00:00/40 Emask 0x89 (media error)
[ 6217.901706] ata8.01: status: { DRDY DF ERR }
[ 6217.901708] ata8.01: error: { UNC IDNF }
[ 6217.901710] ata8.01: failed command: READ FPDMA QUEUED
[ 6217.901715] ata8.01: cmd 60/70:90:70:e0:41/00:00:29:00:00/40 tag 18 ncq 57344 in
[ 6217.901716]          res 60/70:90:70:e0:41/00:00:29:00:00/40 Emask 0x89 (media error)
[ 6217.901719] ata8.01: status: { DRDY DF }
[ 6217.901721] ata8.01: error: { UNC IDNF }
[ 6217.901723] ata8.01: failed command: READ FPDMA QUEUED
[ 6217.901728] ata8.01: cmd 60/08:b8:d8:dd:41/01:00:29:00:00/40 tag 23 ncq 135168 in
[ 6217.901729]          res f5/26:01:01:00:00/00:00:00:70:f5/00 Emask 0x3 (HSM violation)
[ 6217.901732] ata8.01: status: { Busy }
[ 6217.901734] ata8.01: error: { ABRT }
[ 6217.901736] ata8.01: failed command: READ FPDMA QUEUED
[ 6217.901741] ata8.01: cmd 60/10:c0:e0:df:41/00:00:29:00:00/40 tag 24 ncq 8192 in
[ 6217.901742]          res 60/10:c0:e0:df:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6217.901744] ata8.01: status: { DRDY DF }
[ 6217.901746] ata8.01: error: { IDNF }
[ 6217.901749] ata8.01: failed command: READ FPDMA QUEUED
[ 6217.901754] ata8.01: cmd 60/28:c8:00:e0:41/00:00:29:00:00/40 tag 25 ncq 20480 in
[ 6217.901755]          res 60/28:c8:00:e0:41/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6217.901757] ata8.01: status: { DRDY DF }
[ 6217.901760] ata8.01: failed command: WRITE FPDMA QUEUED
[ 6217.901765] ata8.01: cmd 61/88:d0:c8:9f:19/01:00:24:00:00/40 tag 26 ncq 200704 out
[ 6217.901766]          res 61/88:d0:c8:9f:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6217.901768] ata8.01: status: { DRDY DF ERR }
[ 6217.901770] ata8.01: error: { ICRC }
[ 6217.901773] ata8.01: failed command: READ FPDMA QUEUED
[ 6217.901777] ata8.01: cmd 60/10:e0:f0:df:41/00:00:29:00:00/40 tag 28 ncq 8192 in
[ 6217.901778]          res 60/10:e0:f0:df:41/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6217.901781] ata8.01: status: { DRDY DF }
[ 6217.901783] ata8.01: error: { IDNF }
[ 6217.901785] ata8.01: failed command: WRITE FPDMA QUEUED
[ 6217.901790] ata8.01: cmd 61/30:e8:e8:a1:19/00:00:24:00:00/40 tag 29 ncq 24576 out
[ 6217.901791]          res 61/30:e8:e8:a1:19/00:00:24:00:00/40 Emask 0x81 (invalid argument)
[ 6217.901794] ata8.01: status: { DRDY DF ERR }
[ 6217.901796] ata8.01: error: { IDNF }
[ 6217.901863] ata8.00: hard resetting link
[ 6218.250357] ata8.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6218.250393] ata8.01: hard resetting link
[ 6218.600349] ata8.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6218.607020] ata8.00: configured for UDMA/100
[ 6218.613430] ata8.01: configured for UDMA/100
[ 6218.613547] ata8: EH complete
[ 6219.567026] ata8.00: exception Emask 0x0 SAct 0x6d49f28a SErr 0x0 action 0x6
[ 6219.567030] ata8.00: irq_stat 0x03060002, device error via SDB FIS
[ 6219.567034] ata8.00: failed command: READ FPDMA QUEUED
[ 6219.567040] ata8.00: cmd 60/18:08:90:00:42/00:00:29:00:00/40 tag 1 ncq 12288 in
[ 6219.567041]          res f4/26:01:01:00:00/00:00:00:10:f4/00 Emask 0x2 (HSM violation)
[ 6219.567043] ata8.00: status: { Busy }
[ 6219.567045] ata8.00: error: { ABRT }
[ 6219.567048] ata8.00: failed command: READ FPDMA QUEUED
[ 6219.567053] ata8.00: cmd 60/28:18:a8:00:42/00:00:29:00:00/40 tag 3 ncq 20480 in
[ 6219.567054]          res f4/26:01:01:00:00/00:00:00:30:f4/00 Emask 0x2 (HSM violation)
[ 6219.567056] ata8.00: status: { Busy }
[ 6219.567058] ata8.00: error: { ABRT }
[ 6219.567060] ata8.00: failed command: WRITE FPDMA QUEUED
[ 6219.567065] ata8.00: cmd 61/a0:38:d8:bc:19/00:00:24:00:00/40 tag 7 ncq 81920 out
[ 6219.567067]          res f4/26:01:01:00:00/00:00:00:70:f4/00 Emask 0x2 (HSM violation)
[ 6219.567069] ata8.00: status: { Busy }
[ 6219.567071] ata8.00: error: { ABRT }
[ 6219.567073] ata8.00: failed command: WRITE FPDMA QUEUED
[ 6219.567078] ata8.00: cmd 61/40:48:28:be:19/00:00:24:00:00/40 tag 9 ncq 32768 out
[ 6219.567079]          res 61/40:48:28:be:19/00:00:24:00:00/40 Emask 0x9 (media error)
[ 6219.567082] ata8.00: status: { DRDY DF ERR }
[ 6219.567084] ata8.00: error: { UNC }
[ 6219.567086] ata8.00: failed command: READ FPDMA QUEUED
[ 6219.567091] ata8.00: cmd 60/98:60:08:ff:41/00:00:29:00:00/40 tag 12 ncq 77824 in
[ 6219.567092]          res f4/26:01:01:00:00/00:00:00:c0:f4/00 Emask 0x2 (HSM violation)
[ 6219.567094] ata8.00: status: { Busy }
[ 6219.567096] ata8.00: error: { ABRT }
[ 6219.567098] ata8.00: failed command: READ FPDMA QUEUED
[ 6219.567103] ata8.00: cmd 60/98:68:a0:ff:41/00:00:29:00:00/40 tag 13 ncq 77824 in
[ 6219.567104]          res f4/26:01:01:00:00/00:00:00:d0:f4/00 Emask 0x2 (HSM violation)
[ 6219.567107] ata8.00: status: { Busy }
[ 6219.567109] ata8.00: error: { ABRT }
[ 6219.567111] ata8.00: failed command: READ FPDMA QUEUED
[ 6219.567116] ata8.00: cmd 60/18:70:88:fe:41/00:00:29:00:00/40 tag 14 ncq 12288 in
[ 6219.567117]          res 41/84:00:88:fe:41/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>
[ 6219.567120] ata8.00: status: { DRDY ERR }
[ 6219.567121] ata8.00: error: { ICRC ABRT }
[ 6219.567124] ata8.00: failed command: READ FPDMA QUEUED
[ 6219.567129] ata8.00: cmd 60/58:78:38:00:42/00:00:29:00:00/40 tag 15 ncq 45056 in
[ 6219.567130]          res f4/26:01:01:00:00/00:00:00:f0:f4/00 Emask 0x2 (HSM violation)
[ 6219.567132] ata8.00: status: { Busy }
[ 6219.567134] ata8.00: error: { ABRT }
[ 6219.567136] ata8.00: failed command: WRITE FPDMA QUEUED
[ 6219.567141] ata8.00: cmd 61/48:80:68:be:19/00:00:24:00:00/40 tag 16 ncq 36864 out
[ 6219.567142]          res 61/48:80:68:be:19/00:00:24:00:00/40 Emask 0x9 (media error)
[ 6219.567145] ata8.00: status: { DRDY DF ERR }
[ 6219.567147] ata8.00: error: { UNC }
[ 6219.567149] ata8.00: failed command: READ FPDMA QUEUED
[ 6219.567154] ata8.00: cmd 60/18:98:f0:fe:41/00:00:29:00:00/40 tag 19 ncq 12288 in
[ 6219.567155]          res f5/26:01:01:00:00/00:00:00:30:f5/00 Emask 0x2 (HSM violation)
[ 6219.567157] ata8.00: status: { Busy }
[ 6219.567159] ata8.00: error: { ABRT }
[ 6219.567161] ata8.00: failed command: READ FPDMA QUEUED
[ 6219.567166] ata8.00: cmd 60/38:b0:d0:00:42/00:00:29:00:00/40 tag 22 ncq 28672 in
[ 6219.567167]          res 60/38:b0:d0:00:42/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6219.567170] ata8.00: status: { DRDY DF }
[ 6219.567172] ata8.00: error: { IDNF }
[ 6219.567174] ata8.00: failed command: WRITE FPDMA QUEUED
[ 6219.567179] ata8.00: cmd 61/90:c0:78:bd:19/00:00:24:00:00/40 tag 24 ncq 73728 out
[ 6219.567180]          res f5/26:01:01:00:00/00:00:00:80:f5/00 Emask 0x2 (HSM violation)
[ 6219.567183] ata8.00: status: { Busy }
[ 6219.567185] ata8.00: error: { ABRT }
[ 6219.567187] ata8.00: failed command: READ FPDMA QUEUED
[ 6219.567192] ata8.00: cmd 60/50:d0:a0:fe:41/00:00:29:00:00/40 tag 26 ncq 40960 in
[ 6219.567193]          res f5/26:01:01:00:00/00:00:00:a0:f5/00 Emask 0x2 (HSM violation)
[ 6219.567195] ata8.00: status: { Busy }
[ 6219.567197] ata8.00: error: { ABRT }
[ 6219.567199] ata8.00: failed command: WRITE FPDMA QUEUED
[ 6219.567204] ata8.00: cmd 61/88:d8:50:bc:19/00:00:24:00:00/40 tag 27 ncq 69632 out
[ 6219.567205]          res f5/26:01:01:00:00/00:00:00:b0:f5/00 Emask 0x2 (HSM violation)
[ 6219.567208] ata8.00: status: { Busy }
[ 6219.567209] ata8.00: error: { ABRT }
[ 6219.567212] ata8.00: failed command: READ FPDMA QUEUED
[ 6219.567217] ata8.00: cmd 60/78:e8:08:01:42/00:00:29:00:00/40 tag 29 ncq 61440 in
[ 6219.567218]          res 60/78:e8:08:01:42/00:00:29:00:00/40 Emask 0x89 (media error)
[ 6219.567220] ata8.00: status: { DRDY DF }
[ 6219.567223] ata8.00: error: { UNC IDNF }
[ 6219.567225] ata8.00: failed command: WRITE FPDMA QUEUED
[ 6219.567230] ata8.00: cmd 61/20:f0:08:be:19/00:00:24:00:00/40 tag 30 ncq 16384 out
[ 6219.567231]          res f5/26:01:01:00:00/00:00:00:e0:f5/00 Emask 0x2 (HSM violation)
[ 6219.567233] ata8.00: status: { Busy }
[ 6219.567235] ata8.00: error: { ABRT }
[ 6219.567302] ata8.00: hard resetting link
[ 6219.910350] ata8.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6219.917311] ata8.00: configured for UDMA/100
[ 6219.917403] ata8: EH complete
[ 6220.973315] ata8.03: exception Emask 0x0 SAct 0x14911cb3 SErr 0x0 action 0x6
[ 6220.973319] ata8.03: irq_stat 0x03060002, device error via SDB FIS
[ 6220.973323] ata8.03: failed command: READ FPDMA QUEUED
[ 6220.973328] ata8.03: cmd 60/b0:00:60:26:42/00:00:29:00:00/40 tag 0 ncq 90112 in
[ 6220.973330]          res 60/b0:00:60:26:42/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 6220.973332] ata8.03: status: { DRDY DF }
[ 6220.973334] ata8.03: error: { ICRC IDNF }
[ 6220.973337] ata8.03: failed command: READ FPDMA QUEUED
[ 6220.973342] ata8.03: cmd 60/60:08:10:27:42/00:00:29:00:00/40 tag 1 ncq 49152 in
[ 6220.973343]          res 60/60:08:10:27:42/00:00:29:00:00/40 Emask 0x9 (media error)
[ 6220.973346] ata8.03: status: { DRDY DF }
[ 6220.973348] ata8.03: error: { UNC }
[ 6220.973350] ata8.03: failed command: READ FPDMA QUEUED
[ 6220.973355] ata8.03: cmd 60/38:20:78:25:42/00:00:29:00:00/40 tag 4 ncq 28672 in
[ 6220.973356]          res f4/26:01:01:00:00/00:00:00:40:f4/00 Emask 0x2 (HSM violation)
[ 6220.973358] ata8.03: status: { Busy }
[ 6220.973360] ata8.03: error: { ABRT }
[ 6220.973363] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6220.973368] ata8.03: cmd 61/c0:28:38:de:19/00:00:24:00:00/40 tag 5 ncq 98304 out
[ 6220.973369]          res 61/c0:28:38:de:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6220.973372] ata8.03: status: { DRDY DF ERR }
[ 6220.973374] ata8.03: error: { ICRC UNC }
[ 6220.973376] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6220.973381] ata8.03: cmd 61/f0:38:f8:de:19/00:00:24:00:00/40 tag 7 ncq 122880 out
[ 6220.973382]          res 61/f0:38:f8:de:19/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6220.973385] ata8.03: status: { DRDY DF ERR }
[ 6220.973387] ata8.03: error: { ICRC UNC IDNF }
[ 6220.973389] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6220.973394] ata8.03: cmd 61/60:50:f8:df:19/00:00:24:00:00/40 tag 10 ncq 49152 out
[ 6220.973396]          res 61/60:50:f8:df:19/00:00:24:00:00/40 Emask 0x9 (media error)
[ 6220.973398] ata8.03: status: { DRDY DF ERR }
[ 6220.973400] ata8.03: error: { UNC }
[ 6220.973403] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6220.973407] ata8.03: cmd 61/10:58:e8:df:19/00:00:24:00:00/40 tag 11 ncq 8192 out
[ 6220.973409]          res 61/10:58:e8:df:19/00:00:24:00:00/40 Emask 0x81 (invalid argument)
[ 6220.973411] ata8.03: status: { DRDY DF ERR }
[ 6220.973413] ata8.03: error: { IDNF }
[ 6220.973416] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6220.973421] ata8.03: cmd 61/90:60:a8:dd:19/00:00:24:00:00/40 tag 12 ncq 73728 out
[ 6220.973422]          res f4/26:01:01:00:00/00:00:00:c0:f4/00 Emask 0x2 (HSM violation)
[ 6220.973424] ata8.03: status: { Busy }
[ 6220.973426] ata8.03: error: { ABRT }
[ 6220.973428] ata8.03: failed command: READ FPDMA QUEUED
[ 6220.973433] ata8.03: cmd 60/28:80:70:27:42/00:00:29:00:00/40 tag 16 ncq 20480 in
[ 6220.973435]          res 60/28:80:70:27:42/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6220.973437] ata8.03: status: { DRDY DF }
[ 6220.973439] ata8.03: failed command: READ FPDMA QUEUED
[ 6220.973444] ata8.03: cmd 60/40:a0:20:26:42/00:00:29:00:00/40 tag 20 ncq 32768 in
[ 6220.973445]          res 60/40:a0:20:26:42/00:00:29:00:00/40 Emask 0x9 (media error)
[ 6220.973448] ata8.03: status: { DRDY DF }
[ 6220.973450] ata8.03: error: { UNC }
[ 6220.973452] ata8.03: failed command: READ FPDMA QUEUED
[ 6220.973457] ata8.03: cmd 60/38:b8:98:27:42/00:00:29:00:00/40 tag 23 ncq 28672 in
[ 6220.973458]          res 60/38:b8:98:27:42/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6220.973461] ata8.03: status: { DRDY DF }
[ 6220.973463] ata8.03: error: { IDNF }
[ 6220.973466] ata8.03: failed command: READ FPDMA QUEUED
[ 6220.973471] ata8.03: cmd 60/80:d0:f8:24:42/00:00:29:00:00/40 tag 26 ncq 65536 in
[ 6220.973472]          res 41/84:00:f8:24:42/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>
[ 6220.973474] ata8.03: status: { DRDY ERR }
[ 6220.973476] ata8.03: error: { ICRC ABRT }
[ 6220.973479] ata8.03: failed command: READ FPDMA QUEUED
[ 6220.973484] ata8.03: cmd 60/70:e0:b0:25:42/00:00:29:00:00/40 tag 28 ncq 57344 in
[ 6220.973485]          res 60/70:e0:b0:25:42/00:00:29:00:00/40 Emask 0x89 (media error)
[ 6220.973488] ata8.03: status: { DRDY DF }
[ 6220.973489] ata8.03: error: { UNC IDNF }
[ 6220.973555] ata8.03: hard resetting link
[ 6221.320356] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6221.327346] ata8.03: configured for UDMA/100
[ 6221.327434] ata8: EH complete
[ 6527.222773]  connection1:0: detected conn error (1020)
[ 6527.222802]  connection2:0: detected conn error (1020)
[ 6527.821639] iscsi_trgt: ioctl(248) can't find the target 1
[ 6527.831963] iscsi_trgt: ioctl(248) can't find the target 1
[ 6528.992076] iSCSI Enterprise Target Software - version 1.4.19
[ 6528.992147] iscsi_trgt: Registered io type fileio
[ 6528.992148] iscsi_trgt: Registered io type blockio
[ 6528.992149] iscsi_trgt: Registered io type nullio
[ 6577.750918] ata8.03: exception Emask 0x0 SAct 0x14ca44c1 SErr 0x0 action 0x6
[ 6577.766857] ata8.03: irq_stat 0x03060002, device error via SDB FIS
[ 6577.775161] ata8.03: failed command: READ FPDMA QUEUED
[ 6577.783507] ata8.03: cmd 60/30:00:f8:51:73/00:00:29:00:00/40 tag 0 ncq 24576 in
[ 6577.783507]          res 60/30:00:f8:51:73/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6577.817503] ata8.03: status: { DRDY DF }
[ 6577.826104] ata8.03: error: { IDNF }
[ 6577.834218] ata8.03: failed command: READ FPDMA QUEUED
[ 6577.842519] ata8.03: cmd 60/30:30:b0:51:73/00:00:29:00:00/40 tag 6 ncq 24576 in
[ 6577.842520]          res 60/30:30:b0:51:73/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6577.877242] ata8.03: status: { DRDY DF }
[ 6577.885303] ata8.03: error: { IDNF }
[ 6577.892713] ata8.03: failed command: READ FPDMA QUEUED
[ 6577.899969] ata8.03: cmd 60/d8:38:00:50:73/00:00:29:00:00/40 tag 7 ncq 110592 in
[ 6577.899970]          res 41/84:00:00:50:73/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>
[ 6577.930741] ata8.03: status: { DRDY ERR }
[ 6577.938580] ata8.03: error: { ICRC ABRT }
[ 6577.946367] ata8.03: failed command: READ FPDMA QUEUED
[ 6577.953997] ata8.03: cmd 60/b0:50:28:52:73/00:00:29:00:00/40 tag 10 ncq 90112 in
[ 6577.954003]          res 60/b0:50:28:52:73/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 6577.987025] ata8.03: status: { DRDY DF }
[ 6577.995165] ata8.03: error: { ICRC IDNF }
[ 6578.002767] ata8.03: failed command: READ FPDMA QUEUED
[ 6578.010185] ata8.03: cmd 60/a0:70:d8:52:73/00:00:29:00:00/40 tag 14 ncq 81920 in
[ 6578.010187]          res 60/a0:70:d8:52:73/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 6578.040741] ata8.03: status: { DRDY DF }
[ 6578.048530] ata8.03: error: { ICRC }
[ 6578.056130] ata8.03: failed command: READ FPDMA QUEUED
[ 6578.063834] ata8.03: cmd 60/48:88:d8:50:73/00:00:29:00:00/40 tag 17 ncq 36864 in
[ 6578.063835]          res 60/48:88:d8:50:73/00:00:29:00:00/40 Emask 0x9 (media error)
[ 6578.094000] ata8.03: status: { DRDY DF }
[ 6578.101582] ata8.03: error: { UNC }
[ 6578.109237] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6578.117079] ata8.03: cmd 61/98:98:88:e4:44/00:00:24:00:00/40 tag 19 ncq 77824 out
[ 6578.117080]          res 61/98:98:88:e4:44/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 6578.147001] ata8.03: status: { DRDY DF ERR }
[ 6578.154913] ata8.03: error: { ICRC IDNF }
[ 6578.162942] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6578.170734] ata8.03: cmd 61/68:b0:98:e5:44/00:00:24:00:00/40 tag 22 ncq 53248 out
[ 6578.170735]          res 61/68:b0:98:e5:44/00:00:24:00:00/40 Emask 0x9 (media error)
[ 6578.201190] ata8.03: status: { DRDY DF ERR }
[ 6578.209027] ata8.03: error: { UNC }
[ 6578.216947] ata8.03: failed command: READ FPDMA QUEUED
[ 6578.224915] ata8.03: cmd 60/90:b8:20:51:73/00:00:29:00:00/40 tag 23 ncq 73728 in
[ 6578.224916]          res 60/90:b8:20:51:73/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 6578.256890] ata8.03: status: { DRDY DF }
[ 6578.265117] ata8.03: error: { ICRC IDNF }
[ 6578.273179] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6578.281031] ata8.03: cmd 61/78:d0:20:e5:44/00:00:24:00:00/40 tag 26 ncq 61440 out
[ 6578.281032]          res 61/78:d0:20:e5:44/00:00:24:00:00/40 Emask 0x89 (media error)
[ 6578.311463] ata8.03: status: { DRDY DF ERR }
[ 6578.319432] ata8.03: error: { UNC IDNF }
[ 6578.327408] ata8.03: failed command: READ FPDMA QUEUED
[ 6578.335163] ata8.03: cmd 60/18:e0:e0:51:73/00:00:29:00:00/40 tag 28 ncq 12288 in
[ 6578.335164]          res 60/18:e0:e0:51:73/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 6578.367661] ata8.03: status: { DRDY DF }
[ 6578.375967] ata8.03: error: { IDNF }
[ 6578.384149] ata8.03: hard resetting link
[ 6578.730371] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6578.738632] ata8.03: configured for UDMA/100
[ 6578.738726] ata8: EH complete
[ 6579.008795] ata8.03: limiting SATA link speed to 1.5 Gbps
[ 6579.008854] ata8.03: exception Emask 0x0 SAct 0x40547a21 SErr 0x0 action 0x6
[ 6579.017027] ata8.03: irq_stat 0x03060002, device error via SDB FIS
[ 6579.025192] ata8.03: failed command: READ FPDMA QUEUED
[ 6579.033110] ata8.03: cmd 60/08:00:b0:57:73/01:00:29:00:00/40 tag 0 ncq 135168 in
[ 6579.033111]          res 60/08:00:b0:57:73/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6579.065750] ata8.03: status: { DRDY DF }
[ 6579.074225] ata8.03: failed command: READ FPDMA QUEUED
[ 6579.082620] ata8.03: cmd 60/40:28:b8:58:73/00:00:29:00:00/40 tag 5 ncq 32768 in
[ 6579.082621]          res 60/40:28:b8:58:73/00:00:29:00:00/40 Emask 0x9 (media error)
[ 6579.114208] ata8.03: status: { DRDY DF }
[ 6579.121993] ata8.03: error: { UNC }
[ 6579.130048] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6579.138225] ata8.03: cmd 61/b8:48:00:e6:44/00:00:24:00:00/40 tag 9 ncq 94208 out
[ 6579.138226]          res f4/26:01:01:00:00/00:00:00:90:f4/00 Emask 0x2 (HSM violation)
[ 6579.169712] ata8.03: status: { Busy }
[ 6579.178000] ata8.03: error: { ABRT }
[ 6579.186076] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6579.194051] ata8.03: cmd 61/98:58:b8:e9:44/00:00:24:00:00/40 tag 11 ncq 77824 out
[ 6579.194052]          res f4/26:01:01:00:00/00:00:00:b0:f4/00 Emask 0x2 (HSM violation)
[ 6579.225090] ata8.03: status: { Busy }
[ 6579.233201] ata8.03: error: { ABRT }
[ 6579.241270] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6579.248861] ata8.03: cmd 61/30:60:78:e7:44/00:00:24:00:00/40 tag 12 ncq 24576 out
[ 6579.248861]          res 61/30:60:78:e7:44/00:00:24:00:00/40 Emask 0x81 (invalid argument)
[ 6579.281265] ata8.03: status: { DRDY DF ERR }
[ 6579.289526] ata8.03: error: { IDNF }
[ 6579.297659] ata8.03: failed command: READ FPDMA QUEUED
[ 6579.305572] ata8.03: cmd 60/70:68:18:57:73/00:00:29:00:00/40 tag 13 ncq 57344 in
[ 6579.305572]          res f4/26:01:01:00:00/00:00:00:d0:f4/00 Emask 0x2 (HSM violation)
[ 6579.335926] ata8.03: status: { Busy }
[ 6579.343844] ata8.03: error: { ABRT }
[ 6579.351660] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6579.359145] ata8.03: cmd 61/48:70:b8:e6:44/00:00:24:00:00/40 tag 14 ncq 36864 out
[ 6579.359145]          res 61/48:70:b8:e6:44/00:00:24:00:00/40 Emask 0x9 (media error)
[ 6579.391335] ata8.03: status: { DRDY DF ERR }
[ 6579.399439] ata8.03: error: { UNC }
[ 6579.407540] ata8.03: failed command: READ FPDMA QUEUED
[ 6579.415433] ata8.03: cmd 60/48:90:50:56:73/00:00:29:00:00/40 tag 18 ncq 36864 in
[ 6579.415433]          res 41/84:00:50:56:73/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>
[ 6579.446086] ata8.03: status: { DRDY ERR }
[ 6579.453984] ata8.03: error: { ICRC ABRT }
[ 6579.461529] ata8.03: failed command: READ FPDMA QUEUED
[ 6579.469613] ata8.03: cmd 60/28:a0:88:57:73/00:00:29:00:00/40 tag 20 ncq 20480 in
[ 6579.469614]          res 60/28:a0:88:57:73/00:00:29:00:00/40 Emask 0x1 (device error)
[ 6579.502222] ata8.03: status: { DRDY DF }
[ 6579.510453] ata8.03: failed command: READ FPDMA QUEUED
[ 6579.517986] ata8.03: cmd 60/80:b0:98:56:73/00:00:29:00:00/40 tag 22 ncq 65536 in
[ 6579.517987]          res f5/26:01:01:00:00/00:00:00:60:f5/00 Emask 0x2 (HSM violation)
[ 6579.549013] ata8.03: status: { Busy }
[ 6579.556913] ata8.03: error: { ABRT }
[ 6579.564515] ata8.03: failed command: WRITE FPDMA QUEUED
[ 6579.572556] ata8.03: cmd 61/30:f0:50:ea:44/01:00:24:00:00/40 tag 30 ncq 155648 out
[ 6579.572557]          res 61/30:f0:50:ea:44/00:00:24:00:00/40 Emask 0x81 (invalid argument)
[ 6579.604455] ata8.03: status: { DRDY DF ERR }
[ 6579.612204] ata8.03: error: { IDNF }
[ 6579.619952] ata8.03: hard resetting link
[ 6579.970324] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6579.977841] ata8.03: configured for UDMA/100
[ 6579.977938] ata8: EH complete
[ 6698.697120] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 5a
[ 6698.700340] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 5a 0
[ 6844.303888] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[ 6846.480684] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[ 7974.716784] ata8.02: exception Emask 0x0 SAct 0x1b8da1b3 SErr 0x0 action 0x6
[ 7974.716789] ata8.02: irq_stat 0x03060002, device error via SDB FIS
[ 7974.716793] ata8.02: failed command: WRITE FPDMA QUEUED
[ 7974.716798] ata8.02: cmd 61/70:00:68:50:9e/00:00:24:00:00/40 tag 0 ncq 57344 out
[ 7974.716799]          res 61/70:00:68:50:9e/00:00:24:00:00/40 Emask 0x89 (media error)
[ 7974.716802] ata8.02: status: { DRDY DF ERR }
[ 7974.716804] ata8.02: error: { UNC IDNF }
[ 7974.716807] ata8.02: failed command: READ FPDMA QUEUED
[ 7974.716812] ata8.02: cmd 60/40:08:a0:83:d9/00:00:29:00:00/40 tag 1 ncq 32768 in
[ 7974.716813]          res 60/40:08:a0:83:d9/00:00:29:00:00/40 Emask 0x9 (media error)
[ 7974.716816] ata8.02: status: { DRDY DF }
[ 7974.716818] ata8.02: error: { UNC }
[ 7974.716820] ata8.02: failed command: WRITE FPDMA QUEUED
[ 7974.716825] ata8.02: cmd 61/78:20:d8:50:9e/00:00:24:00:00/40 tag 4 ncq 61440 out
[ 7974.716826]          res 61/78:20:d8:50:9e/00:00:24:00:00/40 Emask 0x89 (media error)
[ 7974.716829] ata8.02: status: { DRDY DF ERR }
[ 7974.716831] ata8.02: error: { UNC IDNF }
[ 7974.716833] ata8.02: failed command: READ FPDMA QUEUED
[ 7974.716842] ata8.02: cmd 60/80:28:e0:83:d9/00:00:29:00:00/40 tag 5 ncq 65536 in
[ 7974.716843]          res 60/80:28:e0:83:d9/00:00:29:00:00/40 Emask 0x10 (ATA bus error)
[ 7974.716844] ata8.02: status: { DRDY DF }
[ 7974.716845] ata8.02: error: { ICRC }
[ 7974.716847] ata8.02: failed command: READ FPDMA QUEUED
[ 7974.716850] ata8.02: cmd 60/a8:38:f8:82:d9/00:00:29:00:00/40 tag 7 ncq 86016 in
[ 7974.716850]          res 41/84:00:f8:82:d9/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>
[ 7974.716852] ata8.02: status: { DRDY ERR }
[ 7974.716853] ata8.02: error: { ICRC ABRT }
[ 7974.716855] ata8.02: failed command: READ FPDMA QUEUED
[ 7974.716858] ata8.02: cmd 60/08:40:f8:84:d9/00:00:29:00:00/40 tag 8 ncq 4096 in
[ 7974.716858]          res 60/08:40:f8:84:d9/00:00:29:00:00/40 Emask 0x1 (device error)
[ 7974.716860] ata8.02: status: { DRDY DF }
[ 7974.716861] ata8.02: failed command: READ FPDMA QUEUED
[ 7974.716864] ata8.02: cmd 60/08:68:60:84:d9/00:00:29:00:00/40 tag 13 ncq 4096 in
[ 7974.716865]          res 60/08:68:60:84:d9/00:00:29:00:00/40 Emask 0x1 (device error)
[ 7974.716867] ata8.02: status: { DRDY DF }
[ 7974.716868] ata8.02: failed command: READ FPDMA QUEUED
[ 7974.716871] ata8.02: cmd 60/50:78:a8:84:d9/00:00:29:00:00/40 tag 15 ncq 40960 in
[ 7974.716872]          res 60/50:78:a8:84:d9/00:00:29:00:00/40 Emask 0x89 (media error)
[ 7974.716873] ata8.02: status: { DRDY DF }
[ 7974.716875] ata8.02: error: { UNC IDNF }
[ 7974.716876] ata8.02: failed command: WRITE FPDMA QUEUED
[ 7974.716879] ata8.02: cmd 61/88:80:50:51:9e/00:00:24:00:00/40 tag 16 ncq 69632 out
[ 7974.716880]          res 61/88:80:50:51:9e/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 7974.716881] ata8.02: status: { DRDY DF ERR }
[ 7974.716882] ata8.02: error: { ICRC }
[ 7974.716884] ata8.02: failed command: WRITE FPDMA QUEUED
[ 7974.716887] ata8.02: cmd 61/90:90:08:52:9e/00:00:24:00:00/40 tag 18 ncq 73728 out
[ 7974.716887]          res 61/90:90:08:52:9e/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 7974.716889] ata8.02: status: { DRDY DF ERR }
[ 7974.716890] ata8.02: error: { ICRC IDNF }
[ 7974.716892] ata8.02: failed command: READ FPDMA QUEUED
[ 7974.716895] ata8.02: cmd 60/10:98:68:84:d9/00:00:29:00:00/40 tag 19 ncq 8192 in
[ 7974.716895]          res 60/10:98:68:84:d9/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 7974.716897] ata8.02: status: { DRDY DF }
[ 7974.716898] ata8.02: error: { IDNF }
[ 7974.716899] ata8.02: failed command: READ FPDMA QUEUED
[ 7974.716902] ata8.02: cmd 60/50:b8:c0:85:d9/00:00:29:00:00/40 tag 23 ncq 40960 in
[ 7974.716903]          res 60/50:b8:c0:85:d9/00:00:29:00:00/40 Emask 0x89 (media error)
[ 7974.716905] ata8.02: status: { DRDY DF }
[ 7974.716906] ata8.02: error: { UNC IDNF }
[ 7974.716907] ata8.02: failed command: READ FPDMA QUEUED
[ 7974.716910] ata8.02: cmd 60/70:c0:00:85:d9/00:00:29:00:00/40 tag 24 ncq 57344 in
[ 7974.716911]          res 60/70:c0:00:85:d9/00:00:29:00:00/40 Emask 0x89 (media error)
[ 7974.716912] ata8.02: status: { DRDY DF }
[ 7974.716914] ata8.02: error: { UNC IDNF }
[ 7974.716915] ata8.02: failed command: READ FPDMA QUEUED
[ 7974.716918] ata8.02: cmd 60/50:c8:70:85:d9/00:00:29:00:00/40 tag 25 ncq 40960 in
[ 7974.716919]          res 60/50:c8:70:85:d9/00:00:29:00:00/40 Emask 0x89 (media error)
[ 7974.716920] ata8.02: status: { DRDY DF }
[ 7974.716921] ata8.02: error: { UNC IDNF }
[ 7974.716923] ata8.02: failed command: WRITE FPDMA QUEUED
[ 7974.716926] ata8.02: cmd 61/30:d8:d8:51:9e/00:00:24:00:00/40 tag 27 ncq 24576 out
[ 7974.716926]          res 61/30:d8:d8:51:9e/00:00:24:00:00/40 Emask 0x81 (invalid argument)
[ 7974.716928] ata8.02: status: { DRDY DF ERR }
[ 7974.716929] ata8.02: error: { IDNF }
[ 7974.716930] ata8.02: failed command: READ FPDMA QUEUED
[ 7974.716933] ata8.02: cmd 60/30:e0:78:84:d9/00:00:29:00:00/40 tag 28 ncq 24576 in
[ 7974.716934]          res 60/30:e0:78:84:d9/00:00:29:00:00/40 Emask 0x81 (invalid argument)
[ 7974.716936] ata8.02: status: { DRDY DF }
[ 7974.716937] ata8.02: error: { IDNF }
[ 7974.717002] ata8.02: hard resetting link
[ 7975.060396] ata8.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 7975.067188] ata8.02: configured for UDMA/100
[ 7975.067322] ata8: EH complete
[ 9208.297884] ata8.04: exception Emask 0x0 SAct 0x2cdd0103 SErr 0x0 action 0x6
[ 9208.297889] ata8.04: irq_stat 0x03060002, device error via SDB FIS
[ 9208.297893] ata8.04: failed command: READ FPDMA QUEUED
[ 9208.297899] ata8.04: cmd 60/70:00:80:cc:16/00:00:2a:00:00/40 tag 0 ncq 57344 in
[ 9208.297900]          res 41/84:00:80:cc:16/00:00:2a:00:00/40 Emask 0x410 (ATA bus error) <F>
[ 9208.297903] ata8.04: status: { DRDY ERR }
[ 9208.297905] ata8.04: error: { ICRC ABRT }
[ 9208.297907] ata8.04: failed command: READ FPDMA QUEUED
[ 9208.297912] ata8.04: cmd 60/80:08:f0:cc:16/00:00:2a:00:00/40 tag 1 ncq 65536 in
[ 9208.297914]          res 60/80:08:f0:cc:16/00:00:2a:00:00/40 Emask 0x10 (ATA bus error)
[ 9208.297916] ata8.04: status: { DRDY DF }
[ 9208.297918] ata8.04: error: { ICRC }
[ 9208.297921] ata8.04: failed command: READ FPDMA QUEUED
[ 9208.297926] ata8.04: cmd 60/80:40:b8:ce:16/00:00:2a:00:00/40 tag 8 ncq 65536 in
[ 9208.297927]          res 60/80:40:b8:ce:16/00:00:2a:00:00/40 Emask 0x10 (ATA bus error)
[ 9208.297930] ata8.04: status: { DRDY DF }
[ 9208.297932] ata8.04: error: { ICRC }
[ 9208.297934] ata8.04: failed command: READ FPDMA QUEUED
[ 9208.297939] ata8.04: cmd 60/28:80:58:cf:16/00:00:2a:00:00/40 tag 16 ncq 20480 in
[ 9208.297940]          res 60/28:80:58:cf:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.297943] ata8.04: status: { DRDY DF }
[ 9208.297945] ata8.04: failed command: READ FPDMA QUEUED
[ 9208.297950] ata8.04: cmd 60/28:90:90:ce:16/00:00:2a:00:00/40 tag 18 ncq 20480 in
[ 9208.297951]          res 60/28:90:90:ce:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.297954] ata8.04: status: { DRDY DF }
[ 9208.297956] ata8.04: failed command: WRITE FPDMA QUEUED
[ 9208.297961] ata8.04: cmd 61/c0:98:e8:f1:d3/00:00:24:00:00/40 tag 19 ncq 98304 out
[ 9208.297962]          res 61/c0:98:e8:f1:d3/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 9208.297965] ata8.04: status: { DRDY DF ERR }
[ 9208.297967] ata8.04: error: { ICRC UNC }
[ 9208.297969] ata8.04: failed command: WRITE FPDMA QUEUED
[ 9208.297974] ata8.04: cmd 61/80:a0:68:f1:d3/00:00:24:00:00/40 tag 20 ncq 65536 out
[ 9208.297975]          res 61/80:a0:68:f1:d3/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 9208.297978] ata8.04: status: { DRDY DF ERR }
[ 9208.297980] ata8.04: error: { ICRC }
[ 9208.297982] ata8.04: failed command: WRITE FPDMA QUEUED
[ 9208.297987] ata8.04: cmd 61/d8:b0:90:f0:d3/00:00:24:00:00/40 tag 22 ncq 110592 out
[ 9208.297988]          res 61/d8:b0:90:f0:d3/00:00:24:00:00/40 Emask 0x10 (ATA bus error)
[ 9208.297991] ata8.04: status: { DRDY DF ERR }
[ 9208.297993] ata8.04: error: { ICRC UNC IDNF }
[ 9208.297995] ata8.04: failed command: WRITE FPDMA QUEUED
[ 9208.298000] ata8.04: cmd 61/48:b8:a8:f2:d3/00:00:24:00:00/40 tag 23 ncq 36864 out
[ 9208.298001]          res 61/48:b8:a8:f2:d3/00:00:24:00:00/40 Emask 0x9 (media error)
[ 9208.298004] ata8.04: status: { DRDY DF ERR }
[ 9208.298006] ata8.04: error: { UNC }
[ 9208.298008] ata8.04: failed command: READ FPDMA QUEUED
[ 9208.298013] ata8.04: cmd 60/90:d0:00:ce:16/00:00:2a:00:00/40 tag 26 ncq 73728 in
[ 9208.298014]          res 60/90:d0:00:ce:16/00:00:2a:00:00/40 Emask 0x10 (ATA bus error)
[ 9208.298017] ata8.04: status: { DRDY DF }
[ 9208.298019] ata8.04: error: { ICRC IDNF }
[ 9208.298021] ata8.04: failed command: READ FPDMA QUEUED
[ 9208.298026] ata8.04: cmd 60/90:d8:70:cd:16/00:00:2a:00:00/40 tag 27 ncq 73728 in
[ 9208.298027]          res 60/90:d8:70:cd:16/00:00:2a:00:00/40 Emask 0x10 (ATA bus error)
[ 9208.298030] ata8.04: status: { DRDY DF }
[ 9208.298032] ata8.04: error: { ICRC IDNF }
[ 9208.298034] ata8.04: failed command: READ FPDMA QUEUED
[ 9208.298039] ata8.04: cmd 60/20:e8:38:cf:16/00:00:2a:00:00/40 tag 29 ncq 16384 in
[ 9208.298040]          res 60/20:e8:38:cf:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.298043] ata8.04: status: { DRDY DF }
[ 9208.298108] ata8.04: hard resetting link
[ 9208.630441] ata8.04: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 9208.637514] ata8.04: configured for UDMA/100
[ 9208.637615] ata8: EH complete
[ 9208.952830] ata8.00: failed to read SCR 1 (Emask=0x40)
[ 9208.952834] ata8.01: failed to read SCR 1 (Emask=0x40)
[ 9208.952838] ata8.02: failed to read SCR 1 (Emask=0x40)
[ 9208.952841] ata8.03: failed to read SCR 1 (Emask=0x40)
[ 9208.952844] ata8.04: failed to read SCR 1 (Emask=0x40)
[ 9208.952846] ata8.05: failed to read SCR 1 (Emask=0x40)
[ 9208.952852] ata8.15: exception Emask 0x100 SAct 0x0 SErr 0x280000 action 0x6 frozen
[ 9208.952856] ata8.15: irq_stat 0x03060002, PMP DMA CS errata
[ 9208.952859] ata8.15: SError: { 10B8B BadCRC }
[ 9208.952863] ata8.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 9208.952867] ata8.01: exception Emask 0x100 SAct 0x8cc6462 SErr 0x0 action 0x6 frozen
[ 9208.952871] ata8.01: failed command: READ FPDMA QUEUED
[ 9208.952877] ata8.01: cmd 60/10:08:68:d5:16/00:00:2a:00:00/40 tag 1 ncq 8192 in
[ 9208.952878]          res f4/26:01:01:00:00/00:00:00:10:f4/00 Emask 0x2 (HSM violation)
[ 9208.952880] ata8.01: status: { Busy }
[ 9208.952882] ata8.01: error: { ABRT }
[ 9208.952885] ata8.01: failed command: READ FPDMA QUEUED
[ 9208.952890] ata8.01: cmd 60/20:28:78:d5:16/00:00:2a:00:00/40 tag 5 ncq 16384 in
[ 9208.952891]          res f4/26:01:01:00:00/00:00:00:50:f4/00 Emask 0x2 (HSM violation)
[ 9208.952893] ata8.01: status: { Busy }
[ 9208.952895] ata8.01: error: { ABRT }
[ 9208.952897] ata8.01: failed command: WRITE FPDMA QUEUED
[ 9208.952902] ata8.01: cmd 61/38:30:20:f8:d3/00:00:24:00:00/40 tag 6 ncq 28672 out
[ 9208.952903]          res 61/38:30:20:f8:d3/00:00:24:00:00/40 Emask 0x81 (invalid argument)
[ 9208.952906] ata8.01: status: { DRDY DF ERR }
[ 9208.952908] ata8.01: error: { IDNF }
[ 9208.952911] ata8.01: failed command: READ FPDMA QUEUED
[ 9208.952916] ata8.01: cmd 60/20:50:d0:d5:16/00:00:2a:00:00/40 tag 10 ncq 16384 in
[ 9208.952917]          res 60/20:50:d0:d5:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.952920] ata8.01: status: { DRDY DF }
[ 9208.952922] ata8.01: failed command: READ FPDMA QUEUED
[ 9208.952927] ata8.01: cmd 60/20:68:f0:d5:16/00:00:2a:00:00/40 tag 13 ncq 16384 in
[ 9208.952928]          res 60/20:68:f0:d5:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.952931] ata8.01: status: { DRDY DF }
[ 9208.952933] ata8.01: failed command: READ FPDMA QUEUED
[ 9208.952938] ata8.01: cmd 60/20:70:98:d5:16/00:00:2a:00:00/40 tag 14 ncq 16384 in
[ 9208.952939]          res 60/20:70:98:d5:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.952942] ata8.01: status: { DRDY DF }
[ 9208.952944] ata8.01: failed command: READ FPDMA QUEUED
[ 9208.952949] ata8.01: cmd 60/18:90:b8:d5:16/00:00:2a:00:00/40 tag 18 ncq 12288 in
[ 9208.952950]          res 60/18:90:b8:d5:16/00:00:2a:00:00/40 Emask 0x81 (invalid argument)
[ 9208.952953] ata8.01: status: { DRDY DF }
[ 9208.952955] ata8.01: error: { IDNF }
[ 9208.952957] ata8.01: failed command: WRITE FPDMA QUEUED
[ 9208.952962] ata8.01: cmd 61/20:98:58:f8:d3/00:00:24:00:00/40 tag 19 ncq 16384 out
[ 9208.952963]          res 61/20:98:58:f8:d3/00:00:24:00:00/40 Emask 0x1 (device error)
[ 9208.952966] ata8.01: status: { DRDY DF ERR }
[ 9208.952968] ata8.01: failed command: READ FPDMA QUEUED
[ 9208.952973] ata8.01: cmd 60/10:b0:28:d6:16/00:00:2a:00:00/40 tag 22 ncq 8192 in
[ 9208.952974]          res 60/10:b0:28:d6:16/00:00:2a:00:00/40 Emask 0x81 (invalid argument)
[ 9208.952977] ata8.01: status: { DRDY DF }
[ 9208.952979] ata8.01: error: { IDNF }
[ 9208.952981] ata8.01: failed command: READ FPDMA QUEUED
[ 9208.952986] ata8.01: cmd 60/18:b8:10:d6:16/00:00:2a:00:00/40 tag 23 ncq 12288 in
[ 9208.952987]          res 60/18:b8:10:d6:16/00:00:2a:00:00/40 Emask 0x81 (invalid argument)
[ 9208.952990] ata8.01: status: { DRDY DF }
[ 9208.952992] ata8.01: error: { IDNF }
[ 9208.952994] ata8.01: failed command: WRITE FPDMA QUEUED
[ 9208.952999] ata8.01: cmd 61/28:d8:78:f8:d3/00:00:24:00:00/40 tag 27 ncq 20480 out
[ 9208.953001]          res 61/28:d8:78:f8:d3/00:00:24:00:00/40 Emask 0x1 (device error)
[ 9208.953003] ata8.01: status: { DRDY DF ERR }
[ 9208.953006] ata8.02: exception Emask 0x1 SAct 0x44318385 SErr 0x0 action 0x6 frozen
[ 9208.953009] ata8.02: irq_stat 0x03060002, device error via SDB FIS
[ 9208.953011] ata8.02: failed command: WRITE FPDMA QUEUED
[ 9208.953016] ata8.02: cmd 61/28:00:78:f8:d3/00:00:24:00:00/40 tag 0 ncq 20480 out
[ 9208.953017]          res 61/28:00:78:f8:d3/00:00:24:00:00/40 Emask 0x1 (device error)
[ 9208.953020] ata8.02: status: { DRDY DF ERR }
[ 9208.953023] ata8.02: failed command: READ FPDMA QUEUED
[ 9208.953028] ata8.02: cmd 60/10:10:68:d5:16/00:00:2a:00:00/40 tag 2 ncq 8192 in
[ 9208.953029]          res f4/26:01:01:00:00/00:00:00:20:f4/00 Emask 0x3 (HSM violation)
[ 9208.953031] ata8.02: status: { Busy }
[ 9208.953033] ata8.02: error: { ABRT }
[ 9208.953035] ata8.02: failed command: READ FPDMA QUEUED
[ 9208.953040] ata8.02: cmd 60/20:38:78:d5:16/00:00:2a:00:00/40 tag 7 ncq 16384 in
[ 9208.953042]          res f4/26:01:01:00:00/00:00:00:70:f4/00 Emask 0x3 (HSM violation)
[ 9208.953044] ata8.02: status: { Busy }
[ 9208.953046] ata8.02: error: { ABRT }
[ 9208.953048] ata8.02: failed command: WRITE FPDMA QUEUED
[ 9208.953053] ata8.02: cmd 61/38:40:20:f8:d3/00:00:24:00:00/40 tag 8 ncq 28672 out
[ 9208.953054]          res 61/38:40:20:f8:d3/00:00:24:00:00/40 Emask 0x81 (invalid argument)
[ 9208.953057] ata8.02: status: { DRDY DF ERR }
[ 9208.953059] ata8.02: error: { IDNF }
[ 9208.953061] ata8.02: failed command: READ FPDMA QUEUED
[ 9208.953066] ata8.02: cmd 60/10:48:28:d6:16/00:00:2a:00:00/40 tag 9 ncq 8192 in
[ 9208.953067]          res 60/10:48:28:d6:16/00:00:2a:00:00/40 Emask 0x81 (invalid argument)
[ 9208.953070] ata8.02: status: { DRDY DF }
[ 9208.953072] ata8.02: error: { IDNF }
[ 9208.953075] ata8.02: failed command: READ FPDMA QUEUED
[ 9208.953079] ata8.02: cmd 60/20:78:98:d5:16/00:00:2a:00:00/40 tag 15 ncq 16384 in
[ 9208.953081]          res 60/20:78:98:d5:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.953083] ata8.02: status: { DRDY DF }
[ 9208.953085] ata8.02: failed command: READ FPDMA QUEUED
[ 9208.953090] ata8.02: cmd 60/20:80:f0:d5:16/00:00:2a:00:00/40 tag 16 ncq 16384 in
[ 9208.953092]          res 60/20:80:f0:d5:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.953094] ata8.02: status: { DRDY DF }
[ 9208.953097] ata8.02: failed command: READ FPDMA QUEUED
[ 9208.953102] ata8.02: cmd 60/18:a0:b8:d5:16/00:00:2a:00:00/40 tag 20 ncq 12288 in
[ 9208.953103]          res 60/18:a0:b8:d5:16/00:00:2a:00:00/40 Emask 0x81 (invalid argument)
[ 9208.953105] ata8.02: status: { DRDY DF }
[ 9208.953107] ata8.02: error: { IDNF }
[ 9208.953110] ata8.02: failed command: WRITE FPDMA QUEUED
[ 9208.953115] ata8.02: cmd 61/20:a8:58:f8:d3/00:00:24:00:00/40 tag 21 ncq 16384 out
[ 9208.953116]          res 61/20:a8:58:f8:d3/00:00:24:00:00/40 Emask 0x1 (device error)
[ 9208.953118] ata8.02: status: { DRDY DF ERR }
[ 9208.953121] ata8.02: failed command: READ FPDMA QUEUED
[ 9208.953126] ata8.02: cmd 60/20:d0:d0:d5:16/00:00:2a:00:00/40 tag 26 ncq 16384 in
[ 9208.953127]          res 60/20:d0:d0:d5:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.953129] ata8.02: status: { DRDY DF }
[ 9208.953132] ata8.02: failed command: READ FPDMA QUEUED
[ 9208.953137] ata8.02: cmd 60/18:f0:10:d6:16/00:00:2a:00:00/40 tag 30 ncq 12288 in
[ 9208.953138]          res 60/18:f0:10:d6:16/00:00:2a:00:00/40 Emask 0x81 (invalid argument)
[ 9208.953140] ata8.02: status: { DRDY DF }
[ 9208.953142] ata8.02: error: { IDNF }
[ 9208.953146] ata8.03: exception Emask 0x100 SAct 0x33021818 SErr 0x0 action 0x6 frozen
[ 9208.953148] ata8.03: failed command: READ FPDMA QUEUED
[ 9208.953153] ata8.03: cmd 60/18:18:10:d6:16/00:00:2a:00:00/40 tag 3 ncq 12288 in
[ 9208.953154]          res 60/18:18:10:d6:16/00:00:2a:00:00/40 Emask 0x81 (invalid argument)
[ 9208.953157] ata8.03: status: { DRDY DF }
[ 9208.953159] ata8.03: error: { IDNF }
[ 9208.953161] ata8.03: failed command: READ FPDMA QUEUED
[ 9208.953167] ata8.03: cmd 60/10:20:68:d5:16/00:00:2a:00:00/40 tag 4 ncq 8192 in
[ 9208.953168]          res f4/26:01:01:00:00/00:00:00:40:f4/00 Emask 0x2 (HSM violation)
[ 9208.953170] ata8.03: status: { Busy }
[ 9208.953172] ata8.03: error: { ABRT }
[ 9208.953174] ata8.03: failed command: READ FPDMA QUEUED
[ 9208.953179] ata8.03: cmd 60/20:58:78:d5:16/00:00:2a:00:00/40 tag 11 ncq 16384 in
[ 9208.953180]          res f4/26:01:01:00:00/00:00:00:b0:f4/00 Emask 0x2 (HSM violation)
[ 9208.953183] ata8.03: status: { Busy }
[ 9208.953185] ata8.03: error: { ABRT }
[ 9208.953187] ata8.03: failed command: WRITE FPDMA QUEUED
[ 9208.953192] ata8.03: cmd 61/38:60:20:f8:d3/00:00:24:00:00/40 tag 12 ncq 28672 out
[ 9208.953193]          res 61/38:60:20:f8:d3/00:00:24:00:00/40 Emask 0x81 (invalid argument)
[ 9208.953196] ata8.03: status: { DRDY DF ERR }
[ 9208.953198] ata8.03: error: { IDNF }
[ 9208.953200] ata8.03: failed command: READ FPDMA QUEUED
[ 9208.953205] ata8.03: cmd 60/20:88:98:d5:16/00:00:2a:00:00/40 tag 17 ncq 16384 in
[ 9208.953206]          res 60/20:88:98:d5:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.953209] ata8.03: status: { DRDY DF }
[ 9208.953211] ata8.03: failed command: READ FPDMA QUEUED
[ 9208.953216] ata8.03: cmd 60/18:c0:b8:d5:16/00:00:2a:00:00/40 tag 24 ncq 12288 in
[ 9208.953217]          res 60/18:c0:b8:d5:16/00:00:2a:00:00/40 Emask 0x81 (invalid argument)
[ 9208.953220] ata8.03: status: { DRDY DF }
[ 9208.953222] ata8.03: error: { IDNF }
[ 9208.953224] ata8.03: failed command: WRITE FPDMA QUEUED
[ 9208.953229] ata8.03: cmd 61/20:c8:58:f8:d3/00:00:24:00:00/40 tag 25 ncq 16384 out
[ 9208.953230]          res 61/20:c8:58:f8:d3/00:00:24:00:00/40 Emask 0x1 (device error)
[ 9208.953233] ata8.03: status: { DRDY DF ERR }
[ 9208.953235] ata8.03: failed command: READ FPDMA QUEUED
[ 9208.953240] ata8.03: cmd 60/20:e0:d0:d5:16/00:00:2a:00:00/40 tag 28 ncq 16384 in
[ 9208.953241]          res 60/20:e0:d0:d5:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.953244] ata8.03: status: { DRDY DF }
[ 9208.953246] ata8.03: failed command: READ FPDMA QUEUED
[ 9208.953251] ata8.03: cmd 60/20:e8:f0:d5:16/00:00:2a:00:00/40 tag 29 ncq 16384 in
[ 9208.953252]          res 60/20:e8:f0:d5:16/00:00:2a:00:00/40 Emask 0x1 (device error)
[ 9208.953255] ata8.03: status: { DRDY DF }
[ 9208.953258] ata8.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 9208.953261] ata8.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 9208.953266] ata8.15: hard resetting link
[ 9208.953268] ata8: controller in dubious state, performing PORT_RST
[ 9211.220036] ata8.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 9211.220317] ata8.00: hard resetting link
[ 9211.561965] ata8.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 9211.562002] ata8.01: hard resetting link
[ 9211.920394] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 9211.920435] ata8.02: hard resetting link
[ 9212.260352] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 9212.260388] ata8.03: hard resetting link
[ 9212.614049] ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 9212.614131] ata8.04: hard resetting link
[ 9212.960373] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 9212.960412] ata8.05: hard resetting link
[ 9213.310382] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 9213.364177] ata8.00: configured for UDMA/100
[ 9213.370732] ata8.01: configured for UDMA/100
[ 9213.378396] ata8.02: configured for UDMA/100
[ 9213.386196] ata8.03: configured for UDMA/100
[ 9213.393169] ata8.04: configured for UDMA/100
[ 9213.393296] ata8: EH complete
[ 9247.040036] ata8.00: failed to read SCR 1 (Emask=0x40)
[ 9247.040042] ata8.01: failed to read SCR 1 (Emask=0x40)
[ 9247.040045] ata8.02: failed to read SCR 1 (Emask=0x40)
[ 9247.040048] ata8.03: failed to read SCR 1 (Emask=0x40)
[ 9247.040050] ata8.04: failed to read SCR 1 (Emask=0x40)
[ 9247.040053] ata8.05: failed to read SCR 1 (Emask=0x40)
[ 9247.040059] ata8.15: exception Emask 0x4 SAct 0x0 SErr 0x680000 action 0x6 frozen
[ 9247.040063] ata8.15: SError: { 10B8B BadCRC Handshk }
[ 9247.040067] ata8.00: exception Emask 0x100 SAct 0x108303 SErr 0x0 action 0x6 frozen
[ 9247.040071] ata8.00: failed command: WRITE FPDMA QUEUED
[ 9247.040076] ata8.00: cmd 61/c0:00:90:a2:41/00:00:17:00:00/40 tag 0 ncq 98304 out
[ 9247.040077]          res 40/00:00:78:f8:d3/00:00:24:00:00/40 Emask 0x4 (timeout)
[ 9247.040080] ata8.00: status: { DRDY }
[ 9247.040083] ata8.00: failed command: WRITE FPDMA QUEUED
[ 9247.040088] ata8.00: cmd 61/68:08:e8:9d:41/00:00:17:00:00/40 tag 1 ncq 53248 out
[ 9247.040089]          res 40/00:01:01:00:00/00:00:00:10:f4/00 Emask 0x4 (timeout)
[ 9247.040091] ata8.00: status: { DRDY }
[ 9247.040094] ata8.00: failed command: WRITE FPDMA QUEUED
[ 9247.040099] ata8.00: cmd 61/00:40:50:9e:41/04:00:17:00:00/40 tag 8 ncq 524288 out
[ 9247.040100]          res 40/00:40:20:f8:d3/00:00:24:00:00/40 Emask 0x4 (timeout)
[ 9247.040102] ata8.00: status: { DRDY }
[ 9247.040105] ata8.00: failed command: WRITE FPDMA QUEUED
[ 9247.040110] ata8.00: cmd 61/40:48:50:a2:41/00:00:17:00:00/40 tag 9 ncq 32768 out
[ 9247.040111]          res 40/00:48:28:d6:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040113] ata8.00: status: { DRDY }
[ 9247.040115] ata8.00: failed command: WRITE FPDMA QUEUED
[ 9247.040120] ata8.00: cmd 61/b8:78:50:a3:41/00:00:17:00:00/40 tag 15 ncq 94208 out
[ 9247.040121]          res 40/00:78:98:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040124] ata8.00: status: { DRDY }
[ 9247.040126] ata8.00: failed command: WRITE FPDMA QUEUED
[ 9247.040131] ata8.00: cmd 61/e0:a0:08:a4:41/01:00:17:00:00/40 tag 20 ncq 245760 out
[ 9247.040132]          res 40/00:a0:b8:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040135] ata8.00: status: { DRDY }
[ 9247.040138] ata8.01: exception Emask 0x100 SAct 0x280c14 SErr 0x0 action 0x6 frozen
[ 9247.040141] ata8.01: failed command: WRITE FPDMA QUEUED
[ 9247.040146] ata8.01: cmd 61/c8:10:90:a2:41/00:00:17:00:00/40 tag 2 ncq 102400 out
[ 9247.040147]          res 40/00:01:01:00:00/00:00:00:20:f4/00 Emask 0x4 (timeout)
[ 9247.040149] ata8.01: status: { DRDY }
[ 9247.040152] ata8.01: failed command: WRITE FPDMA QUEUED
[ 9247.040157] ata8.01: cmd 61/60:20:f0:9d:41/00:00:17:00:00/40 tag 4 ncq 49152 out
[ 9247.040158]          res 40/00:01:01:00:00/00:00:00:40:f4/00 Emask 0x4 (timeout)
[ 9247.040160] ata8.01: status: { DRDY }
[ 9247.040163] ata8.01: failed command: WRITE FPDMA QUEUED
[ 9247.040168] ata8.01: cmd 61/00:50:50:9e:41/04:00:17:00:00/40 tag 10 ncq 524288 out
[ 9247.040169]          res 40/00:50:d0:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040171] ata8.01: status: { DRDY }
[ 9247.040173] ata8.01: failed command: WRITE FPDMA QUEUED
[ 9247.040178] ata8.01: cmd 61/40:58:50:a2:41/00:00:17:00:00/40 tag 11 ncq 32768 out
[ 9247.040179]          res 40/00:01:01:00:00/00:00:00:b0:f4/00 Emask 0x4 (timeout)
[ 9247.040182] ata8.01: status: { DRDY }
[ 9247.040184] ata8.01: failed command: WRITE FPDMA QUEUED
[ 9247.040189] ata8.01: cmd 61/b0:98:58:a3:41/00:00:17:00:00/40 tag 19 ncq 90112 out
[ 9247.040190]          res 40/00:98:58:f8:d3/00:00:24:00:00/40 Emask 0x4 (timeout)
[ 9247.040193] ata8.01: status: { DRDY }
[ 9247.040195] ata8.01: failed command: WRITE FPDMA QUEUED
[ 9247.040200] ata8.01: cmd 61/e0:a8:08:a4:41/01:00:17:00:00/40 tag 21 ncq 245760 out
[ 9247.040201]          res 40/00:a8:58:f8:d3/00:00:24:00:00/40 Emask 0x4 (timeout)
[ 9247.040204] ata8.01: status: { DRDY }
[ 9247.040207] ata8.02: exception Emask 0x100 SAct 0x4441028 SErr 0x0 action 0x6 frozen
[ 9247.040210] ata8.02: failed command: WRITE FPDMA QUEUED
[ 9247.040215] ata8.02: cmd 61/c8:18:90:a2:41/00:00:17:00:00/40 tag 3 ncq 102400 out
[ 9247.040216]          res 40/00:18:10:d6:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040219] ata8.02: status: { DRDY }
[ 9247.040221] ata8.02: failed command: WRITE FPDMA QUEUED
[ 9247.040226] ata8.02: cmd 61/68:28:e8:9d:41/00:00:17:00:00/40 tag 5 ncq 53248 out
[ 9247.040227]          res 40/00:01:01:00:00/00:00:00:50:f4/00 Emask 0x4 (timeout)
[ 9247.040230] ata8.02: status: { DRDY }
[ 9247.040232] ata8.02: failed command: WRITE FPDMA QUEUED
[ 9247.040237] ata8.02: cmd 61/00:60:50:9e:41/04:00:17:00:00/40 tag 12 ncq 524288 out
[ 9247.040238]          res 40/00:60:20:f8:d3/00:00:24:00:00/40 Emask 0x4 (timeout)
[ 9247.040241] ata8.02: status: { DRDY }
[ 9247.040243] ata8.02: failed command: WRITE FPDMA QUEUED
[ 9247.040248] ata8.02: cmd 61/b0:90:58:a3:41/00:00:17:00:00/40 tag 18 ncq 90112 out
[ 9247.040249]          res 40/00:90:b8:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040252] ata8.02: status: { DRDY }
[ 9247.040254] ata8.02: failed command: WRITE FPDMA QUEUED
[ 9247.040259] ata8.02: cmd 61/e0:b0:08:a4:41/01:00:17:00:00/40 tag 22 ncq 245760 out
[ 9247.040260]          res 40/00:b0:28:d6:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040263] ata8.02: status: { DRDY }
[ 9247.040265] ata8.02: failed command: WRITE FPDMA QUEUED
[ 9247.040270] ata8.02: cmd 61/40:d0:50:a2:41/00:00:17:00:00/40 tag 26 ncq 32768 out
[ 9247.040271]          res 40/00:d0:d0:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040273] ata8.02: status: { DRDY }
[ 9247.040276] ata8.03: exception Emask 0x100 SAct 0x61014080 SErr 0x0 action 0x6 frozen
[ 9247.040279] ata8.03: failed command: WRITE FPDMA QUEUED
[ 9247.040284] ata8.03: cmd 61/68:38:e8:9d:41/00:00:17:00:00/40 tag 7 ncq 53248 out
[ 9247.040285]          res 40/00:01:01:00:00/00:00:00:70:f4/00 Emask 0x4 (timeout)
[ 9247.040288] ata8.03: status: { DRDY }
[ 9247.040290] ata8.03: failed command: WRITE FPDMA QUEUED
[ 9247.040295] ata8.03: cmd 61/c8:70:90:a2:41/00:00:17:00:00/40 tag 14 ncq 102400 out
[ 9247.040296]          res 40/00:70:98:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040299] ata8.03: status: { DRDY }
[ 9247.040301] ata8.03: failed command: WRITE FPDMA QUEUED
[ 9247.040306] ata8.03: cmd 61/b0:80:58:a3:41/00:00:17:00:00/40 tag 16 ncq 90112 out
[ 9247.040307]          res 40/00:80:f0:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040310] ata8.03: status: { DRDY }
[ 9247.040312] ata8.03: failed command: WRITE FPDMA QUEUED
[ 9247.040317] ata8.03: cmd 61/e0:c0:08:a4:41/01:00:17:00:00/40 tag 24 ncq 245760 out
[ 9247.040318]          res 40/00:c0:b8:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040321] ata8.03: status: { DRDY }
[ 9247.040323] ata8.03: failed command: WRITE FPDMA QUEUED
[ 9247.040328] ata8.03: cmd 61/00:e8:50:9e:41/04:00:17:00:00/40 tag 29 ncq 524288 out
[ 9247.040329]          res 40/00:e8:f0:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040331] ata8.03: status: { DRDY }
[ 9247.040334] ata8.03: failed command: WRITE FPDMA QUEUED
[ 9247.040339] ata8.03: cmd 61/40:f0:50:a2:41/00:00:17:00:00/40 tag 30 ncq 32768 out
[ 9247.040340]          res 40/00:f0:10:d6:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040342] ata8.03: status: { DRDY }
[ 9247.040345] ata8.04: exception Emask 0x100 SAct 0x18822040 SErr 0x0 action 0x6 frozen
[ 9247.040348] ata8.04: failed command: WRITE FPDMA QUEUED
[ 9247.040353] ata8.04: cmd 61/68:30:e8:9d:41/00:00:17:00:00/40 tag 6 ncq 53248 out
[ 9247.040354]          res 40/00:30:20:f8:d3/00:00:24:00:00/40 Emask 0x4 (timeout)
[ 9247.040357] ata8.04: status: { DRDY }
[ 9247.040359] ata8.04: failed command: WRITE FPDMA QUEUED
[ 9247.040364] ata8.04: cmd 61/c8:68:90:a2:41/00:00:17:00:00/40 tag 13 ncq 102400 out
[ 9247.040365]          res 40/00:68:f0:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040367] ata8.04: status: { DRDY }
[ 9247.040370] ata8.04: failed command: WRITE FPDMA QUEUED
[ 9247.040375] ata8.04: cmd 61/b0:88:58:a3:41/00:00:17:00:00/40 tag 17 ncq 90112 out
[ 9247.040376]          res 40/00:88:98:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040379] ata8.04: status: { DRDY }
[ 9247.040381] ata8.04: failed command: WRITE FPDMA QUEUED
[ 9247.040386] ata8.04: cmd 61/e0:b8:08:a4:41/01:00:17:00:00/40 tag 23 ncq 245760 out
[ 9247.040387]          res 40/00:b8:10:d6:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040390] ata8.04: status: { DRDY }
[ 9247.040392] ata8.04: failed command: WRITE FPDMA QUEUED
[ 9247.040397] ata8.04: cmd 61/00:d8:50:9e:41/04:00:17:00:00/40 tag 27 ncq 524288 out
[ 9247.040398]          res 40/00:d8:78:f8:d3/00:00:24:00:00/40 Emask 0x4 (timeout)
[ 9247.040401] ata8.04: status: { DRDY }
[ 9247.040403] ata8.04: failed command: WRITE FPDMA QUEUED
[ 9247.040408] ata8.04: cmd 61/40:e0:50:a2:41/00:00:17:00:00/40 tag 28 ncq 32768 out
[ 9247.040409]          res 40/00:e0:d0:d5:16/00:00:2a:00:00/40 Emask 0x4 (timeout)
[ 9247.040412] ata8.04: status: { DRDY }
[ 9247.040414] ata8.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 9247.040419] ata8.15: hard resetting link
[ 9249.260026] ata8.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 9249.260279] ata8.00: hard resetting link
[ 9249.610334] ata8.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 9249.610368] ata8.01: hard resetting link
[ 9249.960343] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 9249.960377] ata8.02: hard resetting link
[ 9250.310346] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 9250.310380] ata8.03: hard resetting link
[ 9250.660346] ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 9250.660381] ata8.04: hard resetting link
[ 9251.010338] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 9251.010372] ata8.05: hard resetting link
[ 9251.360340] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 9251.415748] ata8.00: configured for UDMA/100
[ 9251.422112] ata8.01: configured for UDMA/100
[ 9251.428927] ata8.02: configured for UDMA/100
[ 9251.437272] ata8.03: configured for UDMA/100
[ 9251.444411] ata8.04: configured for UDMA/100
[ 9251.444557] ata8: EH complete
[18225.146008] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[19161.846718] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<10 Mbps Full Duplex>
[19165.376616] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[19167.721962] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[19169.939117] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[19172.238675] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[19186.832543] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[19189.038202] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[19189.719399] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Down
[19191.974142] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full Duplex>
[19251.016271] iscsi_trgt: scsi_cmnd_start(1035) Unsupported 5a
[19251.016277] iscsi_trgt: cmnd_skip_pdu(457) 40001 1c 5a 0

--------------030006000909050407010508--
