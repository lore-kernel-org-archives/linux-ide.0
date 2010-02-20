From: "Benjamin S." <sbenni@gmx.de>
Subject: bad performance with SSD since kernel version 2.6.32
Date: Sat, 20 Feb 2010 14:28:26 +0100
Message-ID: <20100220142826.62dd5989@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34221 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755250Ab0BTN2d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Feb 2010 08:28:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


Hello list,

I have a Super Talent Ultradrive GX MLC 64GB SSD and an Intel
DH55HC board with H55 chipset. Processor is an Intel Core i5-661.

Since 2.6.32 the sequentiell read performance of the ssd is bad: 

# dd if=/dev/sda of=/dev/zero bs=1M count=300
300+0 records in
300+0 records out
314572800 bytes (315 MB) copied, 4.61777 s, 68.1 MB/s

Same results with other blocksizes (e.g tested with 4K).


With 2.6.31.7 the same hardware is able to read with about
190MB/s.


The normal hard drive reads with both kernel versions with about 100MB/s.


Does somebody have an idea what I can test before I have to bisect
it?


dmesg:

[    0.000000] Linux version 2.6.33-rc8 (root@pluto-lenny) (gcc version 4.4.3 20100108 (prerelease) (Debian 4.4.2-9) ) #4 SMP Sat Feb 20 13:39:26 CET 2010
[    0.000000] Command line: BOOT_IMAGE=//vmlinuz-2.6.33-rc8 root=/dev/mapper/ST64GB-LENNYX64--ROOT ro selinux=0 acpi_sleep=s3_bios no_console_suspend rootfstype=ext4 enable_mtrr_cleanup resume=/dev/sdb1
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
[    0.000000]  BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cb43c000 (usable)
[    0.000000]  BIOS-e820: 00000000cb43c000 - 00000000cb47c000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cb47c000 - 00000000cb4fb000 (reserved)
[    0.000000]  BIOS-e820: 00000000cb4fb000 - 00000000cb50f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cb50f000 - 00000000cb615000 (reserved)
[    0.000000]  BIOS-e820: 00000000cb615000 - 00000000cb618000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cb618000 - 00000000cb622000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cb622000 - 00000000cb62b000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cb62b000 - 00000000cb649000 (reserved)
[    0.000000]  BIOS-e820: 00000000cb649000 - 00000000cb68c000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cb68c000 - 00000000cb800000 (usable)
[    0.000000]  BIOS-e820: 00000000cde00000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x128000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F00000000 write-back
[    0.000000]   1 base 100000000 mask FE0000000 write-back
[    0.000000]   2 base 120000000 mask FF8000000 write-back
[    0.000000]   3 base 0CC000000 mask FFC000000 uncachable
[    0.000000]   4 base 0D0000000 mask FF0000000 uncachable
[    0.000000]   5 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 4GB, type WB
[    0.000000] reg 1, base: 4GB, range: 512MB, type WB
[    0.000000] reg 2, base: 4608MB, range: 128MB, type WB
[    0.000000] reg 3, base: 3264MB, range: 64MB, type UC
[    0.000000] reg 4, base: 3328MB, range: 256MB, type UC
[    0.000000] reg 5, base: 3584MB, range: 512MB, type UC
[    0.000000] total RAM covered: 3904M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 64K 	num_reg: 6  	lose cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 2GB, range: 1GB, type WB
[    0.000000] reg 2, base: 3GB, range: 128MB, type WB
[    0.000000] reg 3, base: 3200MB, range: 64MB, type WB
[    0.000000] reg 4, base: 4GB, range: 512MB, type WB
[    0.000000] reg 5, base: 4608MB, range: 128MB, type WB
[    0.000000] e820 update range: 00000000cc000000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xcb800 max_arch_pfn = 0x400000000
[    0.000000] e820 update range: 0000000000001000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000001000 (usable)
[    0.000000]  modified: 0000000000001000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009ac00 (usable)
[    0.000000]  modified: 000000000009ac00 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 00000000cb43c000 (usable)
[    0.000000]  modified: 00000000cb43c000 - 00000000cb47c000 (ACPI NVS)
[    0.000000]  modified: 00000000cb47c000 - 00000000cb4fb000 (reserved)
[    0.000000]  modified: 00000000cb4fb000 - 00000000cb50f000 (ACPI NVS)
[    0.000000]  modified: 00000000cb50f000 - 00000000cb615000 (reserved)
[    0.000000]  modified: 00000000cb615000 - 00000000cb618000 (ACPI NVS)
[    0.000000]  modified: 00000000cb618000 - 00000000cb622000 (ACPI data)
[    0.000000]  modified: 00000000cb622000 - 00000000cb62b000 (ACPI NVS)
[    0.000000]  modified: 00000000cb62b000 - 00000000cb649000 (reserved)
[    0.000000]  modified: 00000000cb649000 - 00000000cb68c000 (ACPI NVS)
[    0.000000]  modified: 00000000cb68c000 - 00000000cb800000 (usable)
[    0.000000]  modified: 00000000cde00000 - 00000000d0000000 (reserved)
[    0.000000]  modified: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  modified: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000]  modified: 0000000100000000 - 0000000128000000 (usable)
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000cb800000
[    0.000000]  0000000000 - 00cb800000 page 2M
[    0.000000] kernel direct mapping tables up to cb800000 @ 16000-1b000
[    0.000000] init_memory_mapping: 0000000100000000-0000000128000000
[    0.000000]  0100000000 - 0128000000 page 2M
[    0.000000] kernel direct mapping tables up to 128000000 @ 19000-1f000
[    0.000000] RAMDISK: 37a45000 - 37fef35c
[    0.000000] ACPI: RSDP 00000000000f0410 00024 (v02  INTEL)
[    0.000000] ACPI: XSDT 00000000cb620e18 00054 (v01 INTEL  DH55HC   01072009 MSFT 00010013)
[    0.000000] ACPI: FACP 00000000cb61fd98 000F4 (v04 INTEL  DH55HC   01072009 MSFT 00010013)
[    0.000000] ACPI Warning: 32/64 FACS address mismatch in FADT - two FACS tables! (20091214/tbfadt-369)
[    0.000000] ACPI Warning: 32/64X FACS address mismatch in FADT - CB628E40/00000000CB628D40, using 32 (20091214/tbfadt-486)
[    0.000000] ACPI: DSDT 00000000cb618018 06148 (v01 INTEL  DH55HC   00000000 INTL 20051117)
[    0.000000] ACPI: FACS 00000000cb628e40 00040
[    0.000000] ACPI: APIC 00000000cb61ff18 000CC (v02 INTEL  DH55HC   01072009 MSFT 00010013)
[    0.000000] ACPI: SSDT 00000000cb61fc18 0014E (v01 INTEL  DH55HC   00000001 MSFT 03000001)
[    0.000000] ACPI: MCFG 00000000cb621f18 0003C (v01 INTEL  DH55HC   01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000cb621e98 00038 (v01 INTEL  DH55HC   01072009 AMI. 00000003)
[    0.000000] ACPI: ASF! 00000000cb620c18 000A0 (v32 INTEL  DH55HC   00000001 TFSM 000F4240)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] (9 early reservations) ==> bootmem [0000000000 - 0128000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0001000000 - 0001421068]    TEXT DATA BSS ==> [0001000000 - 0001421068]
[    0.000000]   #2 [0037a45000 - 0037fef35c]          RAMDISK ==> [0037a45000 - 0037fef35c]
[    0.000000]   #3 [000009ac00 - 0000100000]    BIOS reserved ==> [000009ac00 - 0000100000]
[    0.000000]   #4 [0001422000 - 000142221c]              BRK ==> [0001422000 - 000142221c]
[    0.000000]   #5 [0000010000 - 0000012000]       TRAMPOLINE ==> [0000010000 - 0000012000]
[    0.000000]   #6 [0000012000 - 0000016000]      ACPI WAKEUP ==> [0000012000 - 0000016000]
[    0.000000]   #7 [0000016000 - 0000019000]          PGTABLE ==> [0000016000 - 0000019000]
[    0.000000]   #8 [0000019000 - 000001a000]          PGTABLE ==> [0000019000 - 000001a000]
[    0.000000]  [ffffea0000000000-ffffea00041fffff] PMD -> [ffff880028600000-ffff88002bdfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00128000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[5] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00000001
[    0.000000]     0: 0x00000010 -> 0x0000009a
[    0.000000]     0: 0x00000100 -> 0x000cb43c
[    0.000000]     0: 0x000cb68c -> 0x000cb800
[    0.000000]     0: 0x00100000 -> 0x00128000
[    0.000000] On node 0 totalpages: 996667
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 112 pages reserved
[    0.000000]   DMA zone: 3811 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 814568 pages, LIFO batch:31
[    0.000000]   Normal zone: 2240 pages used for memmap
[    0.000000]   Normal zone: 161600 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x06] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x08] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x09] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x0a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x0b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x0c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x0f] disabled)
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] 16 Processors exceeds NR_CPUS limit of 4
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 0000000000001000 - 0000000000010000
[    0.000000] PM: Registered nosave memory: 000000000009a000 - 000000000009b000
[    0.000000] PM: Registered nosave memory: 000000000009b000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000cb43c000 - 00000000cb47c000
[    0.000000] PM: Registered nosave memory: 00000000cb47c000 - 00000000cb4fb000
[    0.000000] PM: Registered nosave memory: 00000000cb4fb000 - 00000000cb50f000
[    0.000000] PM: Registered nosave memory: 00000000cb50f000 - 00000000cb615000
[    0.000000] PM: Registered nosave memory: 00000000cb615000 - 00000000cb618000
[    0.000000] PM: Registered nosave memory: 00000000cb618000 - 00000000cb622000
[    0.000000] PM: Registered nosave memory: 00000000cb622000 - 00000000cb62b000
[    0.000000] PM: Registered nosave memory: 00000000cb62b000 - 00000000cb649000
[    0.000000] PM: Registered nosave memory: 00000000cb649000 - 00000000cb68c000
[    0.000000] PM: Registered nosave memory: 00000000cb800000 - 00000000cde00000
[    0.000000] PM: Registered nosave memory: 00000000cde00000 - 00000000d0000000
[    0.000000] PM: Registered nosave memory: 00000000d0000000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000ff000000
[    0.000000] PM: Registered nosave memory: 00000000ff000000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at d0000000 (gap: d0000000:2ed1c000)
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 25 pages/cpu @ffff880028200000 s73624 r8192 d20584 u524288
[    0.000000] pcpu-alloc: s73624 r8192 d20584 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 979979
[    0.000000] Kernel command line: BOOT_IMAGE=//vmlinuz-2.6.33-rc8 root=/dev/mapper/ST64GB-LENNYX64--ROOT ro selinux=0 acpi_sleep=s3_bios no_console_suspend rootfstype=ext4 enable_mtrr_cleanup resume=/dev/sdb1
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 3845600k/4849664k available (2273k kernel code, 862996k absent, 140120k reserved, 1236k data, 380k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:384
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.004000] Detected 3325.507 MHz processor.
[    0.000003] Calibrating delay loop (skipped), value calculated using timer frequency.. 6651.01 BogoMIPS (lpj=13302028)
[    0.000132] Security Framework initialized
[    0.000191] Mount-cache hash table entries: 256
[    0.000310] CPU: Physical Processor ID: 0
[    0.000356] CPU: Processor Core ID: 0
[    0.000403] mce: CPU supports 9 MCE banks
[    0.000457] CPU0: Thermal monitoring enabled (TM1)
[    0.000507] CPU 0 MCA banks CMCI:2 CMCI:3 CMCI:5 CMCI:6
[    0.000648] using mwait in idle threads.
[    0.000695] Performance Events: Nehalem/Corei7 events, Intel PMU driver.
[    0.000786] ... version:                3
[    0.000833] ... bit width:              48
[    0.000879] ... generic registers:      4
[    0.000926] ... value mask:             0000ffffffffffff
[    0.000974] ... max period:             000000007fffffff
[    0.001022] ... fixed-purpose events:   3
[    0.001069] ... event mask:             000000070000000f
[    0.003075] ACPI: Core revision 20091214
[    0.011046] Setting APIC routing to flat
[    0.011431] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.051044] CPU0: Intel(R) Core(TM) i5 CPU         661  @ 3.33GHz stepping 02
[    0.155427] Booting Node   0, Processors  #1
[    0.243107] CPU 1 MCA banks SHD:2 SHD:3 SHD:5 SHD:6
[    0.263231]  #2
[    0.350764] CPU 2 MCA banks CMCI:2 CMCI:3 CMCI:5 SHD:6
[    0.370814]  #3 Ok.
[    0.458419] CPU 3 MCA banks SHD:2 SHD:3 SHD:5 SHD:6
[    0.478458] Brought up 4 CPUs
[    0.478550] Total of 4 processors activated (26600.53 BogoMIPS).
[    0.479754] NET: Registered protocol family 16
[    0.479963] ACPI: bus type pci registered
[    0.480074] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe0000000-0xe3ffffff] (base 0xe0000000)
[    0.480150] PCI: not using MMCONFIG
[    0.480196] PCI: Using configuration type 1 for base access
[    0.481026] bio: create slab <bio-0> at 0
[    0.481738] ACPI: EC: Look up EC in DSDT
[    0.483273] ACPI: Executed 1 blocks of module-level executable AML code
[    0.487600] ACPI: Interpreter enabled
[    0.487648] ACPI: (supports S0 S1 S3 S4 S5)
[    0.487798] ACPI: Using IOAPIC for interrupt routing
[    0.487880] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe0000000-0xe3ffffff] (base 0xe0000000)
[    0.488030] PCI: MMCONFIG at [mem 0xe0000000-0xe3ffffff] reserved in ACPI motherboard resources
[    0.489864] ACPI: BIOS _OSI(Linux) query ignored
[    0.496079] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.496155] pci_root PNP0A08:00: ignoring host bridge windows from ACPI; boot with "pci=use_crs" to use them
[    0.496330] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7] (ignored)
[    0.496332] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff] (ignored)
[    0.496333] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff] (ignored)
[    0.496335] pci_root PNP0A08:00: host bridge window [mem 0xd0000000-0xffffffff] (ignored)
[    0.496369] pci 0000:00:02.0: reg 10: [mem 0xfe000000-0xfe3fffff 64bit]
[    0.496373] pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.496375] pci 0000:00:02.0: reg 20: [io  0xf100-0xf107]
[    0.496442] pci 0000:00:16.0: reg 10: [mem 0xfe42a000-0xfe42a00f 64bit]
[    0.496494] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.496498] pci 0000:00:16.0: PME# disabled
[    0.496527] pci 0000:00:16.2: reg 10: [io  0xf0f0-0xf0f7]
[    0.496532] pci 0000:00:16.2: reg 14: [io  0xf0e0-0xf0e3]
[    0.496537] pci 0000:00:16.2: reg 18: [io  0xf0d0-0xf0d7]
[    0.496542] pci 0000:00:16.2: reg 1c: [io  0xf0c0-0xf0c3]
[    0.496547] pci 0000:00:16.2: reg 20: [io  0xf0b0-0xf0bf]
[    0.496610] pci 0000:00:16.3: reg 10: [io  0xf0a0-0xf0a7]
[    0.496617] pci 0000:00:16.3: reg 14: [mem 0xfe429000-0xfe429fff]
[    0.496695] pci 0000:00:19.0: reg 10: [mem 0xfe400000-0xfe41ffff]
[    0.496699] pci 0000:00:19.0: reg 14: [mem 0xfe428000-0xfe428fff]
[    0.496704] pci 0000:00:19.0: reg 18: [io  0xf040-0xf05f]
[    0.496736] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.496739] pci 0000:00:19.0: PME# disabled
[    0.496773] pci 0000:00:1a.0: reg 10: [mem 0xfe427000-0xfe4273ff]
[    0.496821] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.496825] pci 0000:00:1a.0: PME# disabled
[    0.496853] pci 0000:00:1b.0: reg 10: [mem 0xfe420000-0xfe423fff 64bit]
[    0.496889] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.496892] pci 0000:00:1b.0: PME# disabled
[    0.496947] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.496950] pci 0000:00:1c.0: PME# disabled
[    0.497008] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.497011] pci 0000:00:1c.4: PME# disabled
[    0.497049] pci 0000:00:1d.0: reg 10: [mem 0xfe426000-0xfe4263ff]
[    0.497095] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.497099] pci 0000:00:1d.0: PME# disabled
[    0.497239] pci 0000:00:1f.2: reg 10: [io  0xf090-0xf097]
[    0.497243] pci 0000:00:1f.2: reg 14: [io  0xf080-0xf083]
[    0.497247] pci 0000:00:1f.2: reg 18: [io  0xf070-0xf077]
[    0.497251] pci 0000:00:1f.2: reg 1c: [io  0xf060-0xf063]
[    0.497255] pci 0000:00:1f.2: reg 20: [io  0xf020-0xf03f]
[    0.497260] pci 0000:00:1f.2: reg 24: [mem 0xfe425000-0xfe4257ff]
[    0.497283] pci 0000:00:1f.2: PME# supported from D3hot
[    0.497285] pci 0000:00:1f.2: PME# disabled
[    0.497307] pci 0000:00:1f.3: reg 10: [mem 0xfe424000-0xfe4240ff 64bit]
[    0.497319] pci 0000:00:1f.3: reg 20: [io  0xf000-0xf01f]
[    0.497372] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.497461] pci 0000:00:1c.4: PCI bridge to [bus 02-02]
[    0.497554] pci 0000:00:1e.0: PCI bridge to [bus 03-03] (subtractive decode)
[    0.497625] pci_bus 0000:00: on NUMA node 0
[    0.497628] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.497780] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
[    0.497817] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR20._PRT]
[    0.501652] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.501990] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    0.502330] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.502649] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.502967] ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
[    0.503304] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    0.503678] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    0.504015] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *4 5 6 7 10 11 12 14 15)
[    0.504380] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.504456] vgaarb: loaded
[    0.504545] usbcore: registered new interface driver usbfs
[    0.504626] usbcore: registered new interface driver hub
[    0.504694] usbcore: registered new device driver usb
[    0.504825] PCI: Using ACPI for IRQ routing
[    0.504873] PCI: pci_cache_line_size set to 64 bytes
[    0.504982] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.505198] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.507249] Switching to clocksource tsc
[    0.507368] pnp: PnP ACPI init
[    0.507416] ACPI: bus type pnp registered
[    0.508961] pnp: PnP ACPI: found 11 devices
[    0.509009] ACPI: ACPI bus type pnp unregistered
[    0.509061] system 00:01: [mem 0xfed14000-0xfed19fff] has been reserved
[    0.509115] system 00:01: [mem 0xe0000000-0xe3ffffff] has been reserved
[    0.509165] system 00:01: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.509218] system 00:01: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.509272] system 00:01: [mem 0xfee00000-0xfee0ffff] has been reserved
[    0.509328] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.509381] system 00:09: [io  0x0400-0x047f] has been reserved
[    0.509432] system 00:09: [io  0x1180-0x119f] has been reserved
[    0.509484] system 00:09: [io  0x0500-0x057f] has been reserved
[    0.509533] system 00:09: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.509590] system 00:09: [mem 0xfec00000-0xfecfffff] could not be reserved
[    0.509644] system 00:09: [mem 0xfed08000-0xfed08fff] has been reserved
[    0.509698] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    0.514472] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.514519] pci 0000:00:1c.0:   bridge window [io  disabled]
[    0.514572] pci 0000:00:1c.0:   bridge window [mem disabled]
[    0.514624] pci 0000:00:1c.0:   bridge window [mem pref disabled]
[    0.514679] pci 0000:00:1c.4: PCI bridge to [bus 02-02]
[    0.514728] pci 0000:00:1c.4:   bridge window [io  disabled]
[    0.514778] pci 0000:00:1c.4:   bridge window [mem disabled]
[    0.514829] pci 0000:00:1c.4:   bridge window [mem pref disabled]
[    0.514883] pci 0000:00:1e.0: PCI bridge to [bus 03-03]
[    0.514933] pci 0000:00:1e.0:   bridge window [io  disabled]
[    0.514985] pci 0000:00:1e.0:   bridge window [mem disabled]
[    0.515036] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    0.515099] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.515152] pci 0000:00:1c.0: setting latency timer to 64
[    0.515158] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.515212] pci 0000:00:1c.4: setting latency timer to 64
[    0.515217] pci 0000:00:1e.0: setting latency timer to 64
[    0.515219] pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
[    0.515221] pci_bus 0000:00: resource 1 [mem 0x00000000-0xffffffffffffffff]
[    0.515222] pci_bus 0000:03: resource 3 [io  0x0000-0xffff]
[    0.515224] pci_bus 0000:03: resource 4 [mem 0x00000000-0xffffffffffffffff]
[    0.515250] NET: Registered protocol family 2
[    0.515330] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.515605] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.516597] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.516875] TCP: Hash tables configured (established 262144 bind 65536)
[    0.516929] TCP reno registered
[    0.516974] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.517044] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.517191] NET: Registered protocol family 1
[    0.517249] pci 0000:00:02.0: Boot video device
[    0.566159] PCI: CLS 64 bytes, default 64
[    0.566187] Trying to unpack rootfs image as initramfs...
[    0.648041] Freeing initrd memory: 5800k freed
[    0.648967] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.649024] Placing 64MB software IO TLB between ffff880020000000 - ffff880024000000
[    0.649098] software IO TLB at phys 0x20000000 - 0x24000000
[    0.649781] Scanning for low memory corruption every 60 seconds
[    0.650126] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.650311] VFS: Disk quotas dquot_6.5.2
[    0.650369] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.650456] msgmni has been set to 7524
[    0.650590] alg: No test for stdrng (krng)
[    0.650667] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.650742] io scheduler noop registered (default)
[    0.650790] io scheduler deadline registered
[    0.650846] io scheduler cfq registered
[    0.650948] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.650980] pcieport 0000:00:1c.0: irq 24 for MSI/MSI-X
[    0.651038] pcieport 0000:00:1c.4: setting latency timer to 64
[    0.651067] pcieport 0000:00:1c.4: irq 25 for MSI/MSI-X
[    0.652686] Linux agpgart interface v0.103
[    0.652741] agpgart-intel 0000:00:00.0: Intel Ironlake/D Chipset
[    0.653424] agpgart-intel 0000:00:00.0: detected 32764K stolen memory
[    0.704367] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    0.704448] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.704767] serial 0000:00:16.3: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    0.704901] 0000:00:16.3: ttyS0 at I/O 0xf0a0 (irq = 17) is a 16550A
[    0.705837] brd: module loaded
[    0.705884] usbmon: debugfs is not available
[    0.705973] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.706025] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    0.706583] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.706700] mice: PS/2 mouse device common for all mice
[    0.706783] rtc_cmos 00:04: RTC can wake from S4
[    0.706863] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    0.706939] rtc0: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    0.707010] cpuidle: using governor ladder
[    0.707057] cpuidle: using governor menu
[    0.707104] No iBFT detected.
[    0.707272] TCP cubic registered
[    0.707318] NET: Registered protocol family 17
[    0.733095] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.733356] rtc_cmos 00:04: setting system clock to 2010-02-20 12:41:59 UTC (1266669719)
[    0.733462] Freeing unused kernel memory: 380k freed
[    0.760450] device-mapper: uevent: version 1.0.3
[    0.760577] device-mapper: ioctl: 4.16.0-ioctl (2009-11-05) initialised: dm-devel@redhat.com
[    0.780020] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.780100] ACPI: Power Button [PWRB]
[    0.780186] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.780257] ACPI: Power Button [PWRF]
[    0.782440] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
[    0.782493] e1000e: Copyright (c) 1999 - 2009 Intel Corporation.
[    0.782580] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    0.782638] e1000e 0000:00:19.0: setting latency timer to 64
[    0.782719] e1000e 0000:00:19.0: irq 26 for MSI/MSI-X
[    0.784231] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.810504] SCSI subsystem initialized
[    0.819456] libata version 3.00 loaded.
[    1.209279] 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:27:0e:09:d5:df
[    1.209355] 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    1.209444] 0000:00:19.0: eth0: MAC: 9, PHY: 9, PBA No: ffffff-0ff
[    1.209519] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.209594] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    1.209597] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    1.209663] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    1.209761] ehci_hcd 0000:00:1a.0: debug port 2
[    1.213716] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    1.213730] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xfe427000
[    1.229667] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.229750] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.229804] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.229877] usb usb1: Product: EHCI Host Controller
[    1.229926] usb usb1: Manufacturer: Linux 2.6.33-rc8 ehci_hcd
[    1.229977] usb usb1: SerialNumber: 0000:00:1a.0
[    1.230080] hub 1-0:1.0: USB hub found
[    1.230128] hub 1-0:1.0: 3 ports detected
[    1.230215] ahci 0000:00:1f.2: version 3.0
[    1.230225] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.230305] ahci 0000:00:1f.2: irq 27 for MSI/MSI-X
[    1.246141] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    1.246223] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck pm led clo pio slum part ems sxs apst 
[    1.248282] ahci 0000:00:1f.2: setting latency timer to 64
[    1.286038] scsi0 : ahci
[    1.286146] scsi1 : ahci
[    1.286222] scsi2 : ahci
[    1.286301] scsi3 : ahci
[    1.286378] scsi4 : ahci
[    1.286455] scsi5 : ahci
[    1.286607] ata1: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425100 irq 27
[    1.286682] ata2: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425180 irq 27
[    1.286756] ata3: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425200 irq 27
[    1.286830] ata4: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425280 irq 27
[    1.286905] ata5: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425300 irq 27
[    1.286979] ata6: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425380 irq 27
[    1.287071] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.287136] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.287139] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    1.287192] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    1.287284] ehci_hcd 0000:00:1d.0: debug port 2
[    1.291270] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    1.291278] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xfe426000
[    1.304943] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.305024] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.305077] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.305151] usb usb2: Product: EHCI Host Controller
[    1.305199] usb usb2: Manufacturer: Linux 2.6.33-rc8 ehci_hcd
[    1.305250] usb usb2: SerialNumber: 0000:00:1d.0
[    1.305338] hub 2-0:1.0: USB hub found
[    1.305386] hub 2-0:1.0: 3 ports detected
[    1.540234] usb 1-1: new high speed USB device using ehci_hcd and address 2
[    1.608041] ata3: SATA link down (SStatus 0 SControl 300)
[    1.608113] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.608180] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.608396] ata5: SATA link down (SStatus 0 SControl 300)
[    1.608400] ata6: SATA link down (SStatus 0 SControl 300)
[    1.608416] ata1.00: ATA-8: STT_FTM64GX25H, 1819, max UDMA/133
[    1.608421] ata1.00: 125045424 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    1.608429] ata4: SATA link down (SStatus 0 SControl 300)
[    1.608932] ata2.00: HPA detected: current 1250261615, native 1250263728
[    1.609058] ata2.00: ATA-8: WDC WD6400AAKS-00A7B0, 01.03B01, max UDMA/133
[    1.609117] ata2.00: 1250261615 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.610116] ata2.00: configured for UDMA/133
[    1.610342] ata1.00: configured for UDMA/133
[    1.624077] scsi 0:0:0:0: Direct-Access     ATA      STT_FTM64GX25H   1819 PQ: 0 ANSI: 5
[    1.624246] scsi 1:0:0:0: Direct-Access     ATA      WDC WD6400AAKS-0 01.0 PQ: 0 ANSI: 5
[    1.626840] sd 0:0:0:0: [sda] 125045424 512-byte logical blocks: (64.0 GB/59.6 GiB)
[    1.626905] sd 1:0:0:0: [sdb] 1250261615 512-byte logical blocks: (640 GB/596 GiB)
[    1.626929] sd 1:0:0:0: [sdb] Write Protect is off
[    1.626931] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.626941] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.627009]  sdb:
[    1.627143] sd 0:0:0:0: [sda] Write Protect is off
[    1.627229] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.627238] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.627364]  sda: sda1 sda2 < sda5 >
[    1.627978] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.642051]  sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8
[    1.673676] usb 1-1: New USB device found, idVendor=8087, idProduct=0020
[    1.673771] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.673965] hub 1-1:1.0: USB hub found
[    1.674172] hub 1-1:1.0: 6 ports detected
[    1.674239]  sdb9 sdb10 sdb11 >
[    1.694390] sd 1:0:0:0: [sdb] Attached SCSI disk
[    1.783512] usb 2-1: new high speed USB device using ehci_hcd and address 2
[    1.916412] usb 2-1: New USB device found, idVendor=8087, idProduct=0020
[    1.916472] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.916675] hub 2-1:1.0: USB hub found
[    1.916777] hub 2-1:1.0: 8 ports detected
[    1.987936] usb 1-1.3: new full speed USB device using ehci_hcd and address 3
[    2.083631] usb 1-1.3: New USB device found, idVendor=04a9, idProduct=220e
[    2.083707] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.083771] usb 1-1.3: Product: CanoScan
[    2.083812] usb 1-1.3: Manufacturer: Canon
[    2.158518] usb 1-1.4: new full speed USB device using ehci_hcd and address 4
[    2.177245] PM: Starting manual resume from disk
[    2.186451] EXT4-fs (dm-0): mounted filesystem with ordered data mode
[    2.254718] usb 1-1.4: New USB device found, idVendor=1532, idProduct=00fb
[    2.254777] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.254839] usb 1-1.4: Product: Habu Mouse
[    2.254880] usb 1-1.4: Manufacturer: Tempest
[    2.330987] usb 1-1.5: new high speed USB device using ehci_hcd and address 5
[    2.365344] udev: starting version 150
[    2.422956] ACPI: SSDT 00000000cb617c18 0038C (v01    AMI      IST 00000001 MSFT 03000001)
[    2.436079] Monitor-Mwait will be used to enter C-2 state
[    2.437886] usb 1-1.5: New USB device found, idVendor=0424, idProduct=2512
[    2.437937] usb 1-1.5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.438153] hub 1-1.5:1.0: USB hub found
[    2.438258] hub 1-1.5:1.0: 2 ports detected
[    2.445559] Monitor-Mwait will be used to enter C-3 state
[    2.480207] usbcore: registered new interface driver hiddev
[    2.482442] input: Tempest Habu Mouse as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/input/input3
[    2.482570] generic-usb 0003:1532:00FB.0001: input,hidraw0: USB HID v1.00 Mouse [Tempest Habu Mouse] on usb-0000:00:1a.0-1.4/input0
[    2.482664] usbcore: registered new interface driver usbhid
[    2.482711] usbhid: USB HID core driver
[    2.522607] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    2.522723] HDA Intel 0000:00:1b.0: irq 28 for MSI/MSI-X
[    2.522742] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    2.604837] hda_codec: ALC888: BIOS auto-probing.
[    2.713762] usb 1-1.5.1: new high speed USB device using ehci_hcd and address 6
[    2.753771] Slow work thread pool: Starting up
[    2.753848] Slow work thread pool: Ready
[    2.756280] w83627ehf: Found W83627DHG-P chip at 0xa10
[    2.761163] loop: module loaded
[    2.804734] usb 1-1.5.1: New USB device found, idVendor=0424, idProduct=2602
[    2.804812] usb 1-1.5.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.804995] hub 1-1.5.1:1.0: USB hub found
[    2.805093] hub 1-1.5.1:1.0: 4 ports detected
[    2.911635] EXT4-fs (dm-5): warning: maximal mount count reached, running e2fsck is recommended
[    2.911856] EXT4-fs (dm-5): mounted filesystem with ordered data mode
[    2.917788] EXT4-fs (dm-7): warning: maximal mount count reached, running e2fsck is recommended
[    2.917998] EXT4-fs (dm-7): mounted filesystem with ordered data mode
[    2.926803] EXT2-fs (sda1): warning: mounting unchecked fs, running e2fsck is recommended
[    2.930408] EXT4-fs (dm-6): warning: maximal mount count reached, running e2fsck is recommended
[    2.930603] EXT4-fs (dm-6): mounted filesystem with ordered data mode
[    2.949253] REISERFS (device sdb11): found reiserfs format "3.6" with standard journal
[    2.949338] REISERFS (device sdb11): using ordered data mode
[    2.962467] REISERFS (device sdb11): journal params: device sdb11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[    2.962766] REISERFS (device sdb11): checking transaction log (sdb11)
[    3.030320] REISERFS (device sdb11): Using r5 hash to sort names
[    3.075800] usb 1-1.5.1.1: new high speed USB device using ehci_hcd and address 7
[    3.257251] usb 1-1.5.1.1: New USB device found, idVendor=0424, idProduct=2228
[    3.257325] usb 1-1.5.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.257399] usb 1-1.5.1.1: Product: Flash Card Reader
[    3.257443] usb 1-1.5.1.1: Manufacturer: Generic
[    3.257486] usb 1-1.5.1.1: SerialNumber: 26020128B005
[    3.265601] Initializing USB Mass Storage driver...
[    3.265739] scsi6 : usb-storage 1-1.5.1.1:1.0
[    3.265852] usbcore: registered new interface driver usb-storage
[    3.265899] USB Mass Storage support registered.
[    8.258353] scsi 6:0:0:0: Direct-Access     Generic  Flash HS-CF      5.39 PQ: 0 ANSI: 0
[    8.261613] scsi 6:0:0:1: Direct-Access     Generic  Flash HS-COMBO   5.39 PQ: 0 ANSI: 0
[    8.306857] sd 6:0:0:0: [sdc] Attached SCSI removable disk
[    8.311016] sd 6:0:0:1: [sdd] Attached SCSI removable disk
[  848.231244] Bridge firewalling registered
[  848.232209] device eth0 entered promiscuous mode
[  848.252255] e1000e 0000:00:19.0: irq 26 for MSI/MSI-X
[  848.302916] e1000e 0000:00:19.0: irq 26 for MSI/MSI-X
[  851.768292] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  851.770095] br0: port 1(eth0) entering learning state
[  866.723462] br0: port 1(eth0) entering forwarding state
[  867.519929] NET: Registered protocol family 10
[  867.520201] lo: Disabled Privacy Extensions
[  867.949030] fuse init (API version 7.13)
[  877.761384] eth0: no IPv6 routers present
[  877.874660] br0: no IPv6 routers present
[  882.669218] [drm] Initialized drm 1.1.0 20060810
[  882.691484] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[  882.691494] i915 0000:00:02.0: setting latency timer to 64
[  882.716978] i915 0000:00:02.0: irq 29 for MSI/MSI-X
[  882.716988] [drm] set up 31M of stolen space
[  882.997828] Console: switching to colour frame buffer device 240x75
[  882.997837] fb0: inteldrmfb frame buffer device
[  882.997840] registered panic notifier
[  882.997981] ACPI Exception: AE_NOT_FOUND, Evaluating _DOD (20091214/video-1891)
[  882.998054] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
[  882.998091] ACPI: Video Device [GFX0] (multi-head: no  rom: yes  post: no)
[  882.998113] [drm] Initialized i915 1.6.0 20080730 for
0000:00:02.0 on minor 0





regards 

Benjamin
