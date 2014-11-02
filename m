From: Zlatko Calusic <zcalusic@bitsync.net>
Subject: BUG: AHCI: ata8 port resetting needlessly, slow boot
Date: Sun, 02 Nov 2014 16:14:52 +0100
Message-ID: <54564A6C.4060009@bitsync.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070607070903090501050307"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bitsync.net ([80.83.126.10]:50339 "EHLO bitsync.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbaKBPVJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Nov 2014 10:21:09 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?Q?Antoine_T=c3=a9nart?= <antoine.tenart@free-electrons.com>, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070607070903090501050307
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I have an issue with AHCI driver, starting with kernel 3.17.0, where 
ata8 port is resetting multiple times during boot, and it takes about a 
minute until it gives up, dmesg excerpt:

[    0.698367] ata8: SATA max UDMA/133 abar m8192@0xfebfe000 port 
0xfebfe180 irq 16
[    6.052229] ata8: link is slow to respond, please be patient (ready=-19)
[   10.744229] ata8: COMRESET failed (errno=-16)
[   16.098114] ata8: link is slow to respond, please be patient (ready=-19)
[   20.790040] ata8: COMRESET failed (errno=-16)
[   26.144229] ata8: link is slow to respond, please be patient (ready=-19)
[   55.826199] ata8: COMRESET failed (errno=-16)
[   55.826386] ata8: limiting SATA link speed to 1.5 Gbps
[   60.874228] ata8: COMRESET failed (errno=-16)
[   60.874413] ata8: reset failed, giving up

In kernel 3.16.0 the same port was reported as dummy and the boot 
sequence was fast:

[    0.757323] ata8: DUMMY

I took some time, bisected between 3.16 and 3.17, and eventually found 
this commit as culprit:

commit 725c7b570fda4207e465ff8856c2c12c2645a685
Author: Antoine Ténart <antoine.tenart@free-electrons.com>
Date:   Wed Jul 30 20:13:56 2014 +0200

     ata: libahci_platform: move port_map parameters into the AHCI structure

Indeed, after reverting that commit in current 3.18-rc2, once again ata8 
is reported as dummy, and the machine boots fast.

I'm attaching the full dmesg output.

Regards,

-- 
Zlatko

--------------070607070903090501050307
Content-Type: text/plain; charset=UTF-8;
 name="dmesg-3.17-ahci-bug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-3.17-ahci-bug.txt"

[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.17.0+ (zcalusic@atlas) (gcc version 4.9.1 (Debian 4.9.1-16) ) #1 SMP PREEMPT Mon Oct 6 00:23:31 CEST 2014
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.17.0+ root=/dev/md0 rootfstype=ext4 profile=2 ro
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e4000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cff6ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cff70000-0x00000000cff87fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cff88000-0x00000000cffcffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cffd0000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fff00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000022fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: System manufacturer System Product Name/P5Q PRO TURBO, BIOS 0701    10/08/2012
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x230000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask E00000000 write-back
[    0.000000]   1 base 200000000 mask FE0000000 write-back
[    0.000000]   2 base 220000000 mask FF0000000 write-back
[    0.000000]   3 base 0D0000000 mask FF0000000 uncachable
[    0.000000]   4 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 8GB, type WB
[    0.000000] reg 1, base: 8GB, range: 512MB, type WB
[    0.000000] reg 2, base: 8704MB, range: 256MB, type WB
[    0.000000] reg 3, base: 3328MB, range: 256MB, type UC
[    0.000000] reg 4, base: 3584MB, range: 512MB, type UC
[    0.000000] total RAM covered: 8192M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 64K 	num_reg: 6  	lose cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 2GB, range: 1GB, type WB
[    0.000000] reg 2, base: 3GB, range: 256MB, type WB
[    0.000000] reg 3, base: 4GB, range: 4GB, type WB
[    0.000000] reg 4, base: 8GB, range: 512MB, type WB
[    0.000000] reg 5, base: 8704MB, range: 256MB, type WB
[    0.000000] e820: update [mem 0xd0000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xcff70 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000096000] 96000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01a7d000, 0x01a7dfff] PGTABLE
[    0.000000] BRK [0x01a7e000, 0x01a7efff] PGTABLE
[    0.000000] BRK [0x01a7f000, 0x01a7ffff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x22fe00000-0x22fffffff]
[    0.000000]  [mem 0x22fe00000-0x22fffffff] page 2M
[    0.000000] BRK [0x01a80000, 0x01a80fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x22c000000-0x22fdfffff]
[    0.000000]  [mem 0x22c000000-0x22fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x200000000-0x22bffffff]
[    0.000000]  [mem 0x200000000-0x22bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xcff6ffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0xcfdfffff] page 2M
[    0.000000]  [mem 0xcfe00000-0xcff6ffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x1ffffffff]
[    0.000000]  [mem 0x100000000-0x1ffffffff] page 2M
[    0.000000] BRK [0x01a81000, 0x01a81fff] PGTABLE
[    0.000000] BRK [0x01a82000, 0x01a82fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FB160 000024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT 0x00000000CFF70100 000054 (v01 A_M_I_ OEMXSDT  10001208 MSFT 00000097)
[    0.000000] ACPI: FACP 0x00000000CFF70290 0000F4 (v03 A_M_I_ OEMFACP  10001208 MSFT 00000097)
[    0.000000] ACPI: DSDT 0x00000000CFF70440 00AEF9 (v01 A1276  A1276001 00000001 INTL 20060113)
[    0.000000] ACPI: FACS 0x00000000CFF88000 000040
[    0.000000] ACPI: APIC 0x00000000CFF70390 00006C (v01 A_M_I_ OEMAPIC  10001208 MSFT 00000097)
[    0.000000] ACPI: MCFG 0x00000000CFF70400 00003C (v01 A_M_I_ OEMMCFG  10001208 MSFT 00000097)
[    0.000000] ACPI: OEMB 0x00000000CFF88040 000089 (v01 A_M_I_ AMI_OEM  10001208 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000CFF7B340 000038 (v01 A_M_I_ OEMHPET  10001208 MSFT 00000097)
[    0.000000] ACPI: OSFR 0x00000000CFF7B380 0000B0 (v01 A_M_I_ OEMOSFR  10001208 MSFT 00000097)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea0008bfffff] PMD -> [ffff880227600000-ffff88022f5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x22fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009bfff]
[    0.000000]   node   0: [mem 0x00100000-0xcff6ffff]
[    0.000000]   node   0: [mem 0x100000000-0x22fffffff]
[    0.000000] On node 0 totalpages: 2096907
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13246 pages used for memmap
[    0.000000]   DMA32 zone: 847728 pages, LIFO batch:31
[    0.000000]   Normal zone: 19456 pages used for memmap
[    0.000000]   Normal zone: 1245184 pages, LIFO batch:31
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
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0xd0000000-0xfedfffff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 26 pages/cpu @ffff88022fc00000 s74880 r8192 d23424 u1048576
[    0.000000] pcpu-alloc: s74880 r8192 d23424 u1048576 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2064120
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.17.0+ root=/dev/md0 rootfstype=ext4 profile=2 ro
[    0.000000] kernel profiling enabled (shift: 2)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] xsave: enabled xstate_bv 0x3, cntxt size 0x240 using standard form
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Memory: 8166984K/8387628K available (6577K kernel code, 641K rwdata, 2124K rodata, 812K init, 536K bss, 220644K reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Dump stacks of tasks blocking RCU-preempt GP.
[    0.000000] NR_IRQS:4352 nr_irqs:440 0
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 4000.107 MHz processor
[    0.001002] Calibrating delay loop (skipped), value calculated using timer frequency.. 8000.21 BogoMIPS (lpj=4000107)
[    0.001077] pid_max: default: 32768 minimum: 301
[    0.001118] ACPI: Core revision 20140724
[    0.005219] ACPI: All ACPI Tables successfully acquired
[    0.006022] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.007003] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.007246] CPU: Physical Processor ID: 0
[    0.007281] CPU: Processor Core ID: 0
[    0.007316] mce: CPU supports 6 MCE banks
[    0.007355] CPU0: Thermal monitoring enabled (TM2)
[    0.007394] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
[    0.007495] Freeing SMP alternatives memory: 24K (ffffffff819f0000 - ffffffff819f6000)
[    0.007915] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.017982] smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     E8600  @ 3.33GHz (fam: 06, model: 17, stepping: 0a)
[    0.019000] Performance Events: PEBS fmt0+, 4-deep LBR, Core2 events, Intel PMU driver.
[    0.019000] ... version:                2
[    0.019000] ... bit width:              40
[    0.019000] ... generic registers:      2
[    0.019000] ... value mask:             000000ffffffffff
[    0.019000] ... max period:             000000007fffffff
[    0.019000] ... fixed-purpose events:   3
[    0.019000] ... event mask:             0000000700000003
[    0.024035] x86: Booting SMP configuration:
[    0.024071] .... node  #0, CPUs:      #1
[    0.036016] x86: Booted up 1 node, 2 CPUs
[    0.036086] smpboot: Total of 2 processors activated (16000.42 BogoMIPS)
[    0.037041] devtmpfs: initialized
[    0.037214] NET: Registered protocol family 16
[    0.037330] ACPI: bus type PCI registered
[    0.037390] PCI: Using configuration type 1 for base access
[    0.041037] ACPI: Added _OSI(Module Device)
[    0.041055] ACPI: Added _OSI(Processor Device)
[    0.041090] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.041126] ACPI: Added _OSI(Processor Aggregator Device)
[    0.042770] ACPI: Executed 1 blocks of module-level executable AML code
[    0.046051] ACPI: Interpreter enabled
[    0.046089] ACPI: (supports S0 S5)
[    0.046124] ACPI: Using IOAPIC for interrupt routing
[    0.046176] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.049577] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.049616] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.049656] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.049780] PCI host bridge to bus 0000:00
[    0.049816] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.049853] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.049890] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.049927] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.049965] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff]
[    0.050000] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xdfffffff]
[    0.050039] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xffffffff]
[    0.050081] pci 0000:00:00.0: [8086:2e20] type 00 class 0x060000
[    0.050137] pci 0000:00:01.0: [8086:2e21] type 01 class 0x060400
[    0.050159] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.050203] pci 0000:00:06.0: [8086:2e29] type 01 class 0x060400
[    0.050224] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.050277] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
[    0.050308] pci 0000:00:1a.0: reg 0x20: [io  0xa800-0xa81f]
[    0.050376] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
[    0.050407] pci 0000:00:1a.1: reg 0x20: [io  0xa880-0xa89f]
[    0.050474] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
[    0.050506] pci 0000:00:1a.2: reg 0x20: [io  0xac00-0xac1f]
[    0.050580] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
[    0.050596] pci 0000:00:1a.7: reg 0x10: [mem 0xf9fffc00-0xf9ffffff]
[    0.050663] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.050712] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300
[    0.050721] pci 0000:00:1b.0: reg 0x10: [mem 0xf9ff8000-0xf9ffbfff 64bit]
[    0.050769] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.050813] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
[    0.050860] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.050908] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
[    0.050956] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.051000] pci 0000:00:1c.5: [8086:3a4a] type 01 class 0x060400
[    0.051048] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.051096] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    0.051126] pci 0000:00:1d.0: reg 0x20: [io  0xa080-0xa09f]
[    0.051195] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    0.051225] pci 0000:00:1d.1: reg 0x20: [io  0xa400-0xa41f]
[    0.051293] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    0.051324] pci 0000:00:1d.2: reg 0x20: [io  0xa480-0xa49f]
[    0.051398] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    0.051413] pci 0000:00:1d.7: reg 0x10: [mem 0xf9fff800-0xf9fffbff]
[    0.051481] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.051527] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.051599] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100
[    0.051659] pci 0000:00:1f.0: can't claim BAR 7 [io  0x0800-0x087f]: address conflict with ACPI CPU throttle [io  0x0810-0x0815]
[    0.051711] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6 GPIO
[    0.051751] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294 (mask 0003)
[    0.051791] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 4700 (mask 001f)
[    0.051897] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601
[    0.051910] pci 0000:00:1f.2: reg 0x10: [io  0x9c00-0x9c07]
[    0.051915] pci 0000:00:1f.2: reg 0x14: [io  0x9880-0x9883]
[    0.051920] pci 0000:00:1f.2: reg 0x18: [io  0x9800-0x9807]
[    0.051925] pci 0000:00:1f.2: reg 0x1c: [io  0x9480-0x9483]
[    0.051930] pci 0000:00:1f.2: reg 0x20: [io  0x9400-0x941f]
[    0.051936] pci 0000:00:1f.2: reg 0x24: [mem 0xf9ffe800-0xf9ffefff]
[    0.051967] pci 0000:00:1f.2: PME# supported from D3hot
[    0.052008] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
[    0.052018] pci 0000:00:1f.3: reg 0x10: [mem 0xf9fff400-0xf9fff4ff 64bit]
[    0.052033] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
[    0.052110] pci 0000:01:00.0: [10de:0622] type 00 class 0x030000
[    0.052117] pci 0000:01:00.0: reg 0x10: [mem 0xfd000000-0xfdffffff]
[    0.052124] pci 0000:01:00.0: reg 0x14: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.052131] pci 0000:01:00.0: reg 0x1c: [mem 0xfa000000-0xfbffffff 64bit]
[    0.052136] pci 0000:01:00.0: reg 0x24: [io  0xbc00-0xbc7f]
[    0.052142] pci 0000:01:00.0: reg 0x30: [mem 0xfe880000-0xfe8fffff pref]
[    0.052199] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.052236] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
[    0.052237] pci 0000:00:01.0:   bridge window [mem 0xfa000000-0xfe8fffff]
[    0.052239] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.052270] pci 0000:02:00.0: [12d8:e130] type 01 class 0x060400
[    0.052324] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.052360] pci 0000:00:06.0: PCI bridge to [bus 02-03]
[    0.052397] pci 0000:00:06.0:   bridge window [io  0xc000-0xcfff]
[    0.052399] pci 0000:00:06.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.052442] pci 0000:03:00.0: [1095:3124] type 00 class 0x010400
[    0.052459] pci 0000:03:00.0: reg 0x10: [mem 0xfe9ffc00-0xfe9ffc7f 64bit]
[    0.052470] pci 0000:03:00.0: reg 0x18: [mem 0xfe9f0000-0xfe9f7fff 64bit]
[    0.052477] pci 0000:03:00.0: reg 0x20: [io  0xcc00-0xcc0f]
[    0.052490] pci 0000:03:00.0: reg 0x30: [mem 0xfe900000-0xfe97ffff pref]
[    0.052521] pci 0000:03:00.0: supports D1 D2
[    0.052573] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.052612] pci 0000:02:00.0:   bridge window [io  0xc000-0xcfff]
[    0.052615] pci 0000:02:00.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.052655] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.052697] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff 64bit pref]
[    0.052745] pci 0000:05:00.0: [197b:2361] type 00 class 0x010185
[    0.052818] pci 0000:05:00.0: reg 0x24: [mem 0xfebfe000-0xfebfffff]
[    0.052829] pci 0000:05:00.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.052872] pci 0000:05:00.0: PME# supported from D3hot
[    0.052916] pci 0000:05:00.1: [197b:2361] type 00 class 0x010185
[    0.052933] pci 0000:05:00.1: reg 0x10: [io  0xec00-0xec07]
[    0.052941] pci 0000:05:00.1: reg 0x14: [io  0xe880-0xe883]
[    0.052949] pci 0000:05:00.1: reg 0x18: [io  0xe800-0xe807]
[    0.052957] pci 0000:05:00.1: reg 0x1c: [io  0xe480-0xe483]
[    0.052965] pci 0000:05:00.1: reg 0x20: [io  0xe400-0xe40f]
[    0.053046] pci 0000:05:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.053100] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.053138] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    0.053140] pci 0000:00:1c.4:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.053191] pci 0000:04:00.0: [1969:1026] type 00 class 0x020000
[    0.053209] pci 0000:04:00.0: reg 0x10: [mem 0xfeac0000-0xfeafffff 64bit]
[    0.053218] pci 0000:04:00.0: reg 0x18: [io  0xdc00-0xdc7f]
[    0.053298] pci 0000:04:00.0: PME# supported from D3hot D3cold
[    0.053330] pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.053383] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.053421] pci 0000:00:1c.5:   bridge window [io  0xd000-0xdfff]
[    0.053423] pci 0000:00:1c.5:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.053477] pci 0000:00:1e.0: PCI bridge to [bus 07] (subtractive decode)
[    0.053520] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.053521] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.053522] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.053523] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff] (subtractive decode)
[    0.053524] pci 0000:00:1e.0:   bridge window [mem 0xd0000000-0xdfffffff] (subtractive decode)
[    0.053525] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xffffffff] (subtractive decode)
[    0.053545] pci_bus 0000:00: on NUMA node 0
[    0.053873] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    0.054238] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.054604] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 *15)
[    0.054968] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    0.055312] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.055727] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 *14 15)
[    0.056086] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 7 10 11 12 14 15)
[    0.056450] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    0.056816] ACPI: Enabled 3 GPEs in block 00 to 3F
[    0.056930] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.056930] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.057002] vgaarb: loaded
[    0.057035] vgaarb: bridge control possible 0000:01:00.0
[    0.057111] SCSI subsystem initialized
[    0.057156] libata version 3.00 loaded.
[    0.057156] ACPI: bus type USB registered
[    0.057156] usbcore: registered new interface driver usbfs
[    0.057156] usbcore: registered new interface driver hub
[    0.057156] usbcore: registered new device driver usb
[    0.057156] wmi: Mapper loaded
[    0.057156] Advanced Linux Sound Architecture Driver Initialized.
[    0.057156] PCI: Using ACPI for IRQ routing
[    0.057156] PCI: pci_cache_line_size set to 64 bytes
[    0.057177] e820: reserve RAM buffer [mem 0x0009c000-0x0009ffff]
[    0.057178] e820: reserve RAM buffer [mem 0xcff70000-0xcfffffff]
[    0.057256] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    0.057296] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.057457] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.059011] Switched to clocksource hpet
[    0.059083] pnp: PnP ACPI init
[    0.059145] system 00:00: [mem 0xfed14000-0xfed19fff] has been reserved
[    0.059183] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.059213] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.059265] system 00:02: [io  0x0290-0x029f] has been reserved
[    0.059305] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.059388] system 00:03: [io  0x04d0-0x04d1] has been reserved
[    0.060100] system 00:03: [io  0x0800-0x087f] could not be reserved
[    0.060138] system 00:03: [io  0x0500-0x057f] could not be reserved
[    0.060176] system 00:03: [mem 0xfed08000-0xfed08fff] has been reserved
[    0.060213] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.060251] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.060289] system 00:03: [mem 0xfed50000-0xfed8ffff] has been reserved
[    0.060327] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.060384] system 00:04: [mem 0xffc00000-0xffefffff] has been reserved
[    0.060423] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.060535] pnp 00:05: [dma 0 disabled]
[    0.060566] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.060633] system 00:06: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.060672] system 00:06: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.060710] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.060766] system 00:07: [mem 0xe0000000-0xefffffff] has been reserved
[    0.060805] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.060894] system 00:08: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.060933] system 00:08: [mem 0x000c0000-0x000cffff] could not be reserved
[    0.060971] system 00:08: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.061013] system 00:08: [mem 0x00100000-0xcfffffff] could not be reserved
[    0.061052] system 00:08: [mem 0xe0000000-0xffffffff] could not be reserved
[    0.061090] system 00:08: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.061157] pnp: PnP ACPI: found 9 devices
[    0.067033] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 06] add_size 1000
[    0.067035] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 06] add_size 400000
[    0.067040] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 05] add_size 200000
[    0.067046] pci 0000:00:1c.5: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000
[    0.067052] pci 0000:00:1f.0: BAR 7: [io  0x0800-0x087f] has bogus alignment
[    0.067091] pci 0000:00:1c.0: res[8]=[mem 0x00100000-0x000fffff] get_res_add_size add_size 400000
[    0.067092] pci 0000:00:1c.4: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.067093] pci 0000:00:1c.5: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.067094] pci 0000:00:1c.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    0.067097] pci 0000:00:1c.0: BAR 8: assigned [mem 0xf0000000-0xf03fffff]
[    0.067138] pci 0000:00:1c.4: BAR 9: assigned [mem 0xf0400000-0xf05fffff 64bit pref]
[    0.067178] pci 0000:00:1c.5: BAR 9: assigned [mem 0xf0600000-0xf07fffff 64bit pref]
[    0.067218] pci 0000:00:1c.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.067255] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.067292] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
[    0.067330] pci 0000:00:01.0:   bridge window [mem 0xfa000000-0xfe8fffff]
[    0.067368] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.067408] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.067445] pci 0000:02:00.0:   bridge window [io  0xc000-0xcfff]
[    0.067484] pci 0000:02:00.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.067526] pci 0000:00:06.0: PCI bridge to [bus 02-03]
[    0.067562] pci 0000:00:06.0:   bridge window [io  0xc000-0xcfff]
[    0.067600] pci 0000:00:06.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.067640] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.067676] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    0.067716] pci 0000:00:1c.0:   bridge window [mem 0xf0000000-0xf03fffff]
[    0.067755] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff 64bit pref]
[    0.067796] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.067832] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    0.067871] pci 0000:00:1c.4:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.067910] pci 0000:00:1c.4:   bridge window [mem 0xf0400000-0xf05fffff 64bit pref]
[    0.067951] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.067988] pci 0000:00:1c.5:   bridge window [io  0xd000-0xdfff]
[    0.068031] pci 0000:00:1c.5:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.068070] pci 0000:00:1c.5:   bridge window [mem 0xf0600000-0xf07fffff 64bit pref]
[    0.068111] pci 0000:00:1e.0: PCI bridge to [bus 07]
[    0.068153] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.068154] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.068155] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.068156] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
[    0.068157] pci_bus 0000:00: resource 8 [mem 0xd0000000-0xdfffffff]
[    0.068158] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xffffffff]
[    0.068159] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
[    0.068160] pci_bus 0000:01: resource 1 [mem 0xfa000000-0xfe8fffff]
[    0.068161] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.068162] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
[    0.068163] pci_bus 0000:02: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.068164] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.068165] pci_bus 0000:03: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.068166] pci_bus 0000:06: resource 0 [io  0x1000-0x1fff]
[    0.068167] pci_bus 0000:06: resource 1 [mem 0xf0000000-0xf03fffff]
[    0.068168] pci_bus 0000:06: resource 2 [mem 0xf8f00000-0xf8ffffff 64bit pref]
[    0.068170] pci_bus 0000:05: resource 0 [io  0xe000-0xefff]
[    0.068171] pci_bus 0000:05: resource 1 [mem 0xfeb00000-0xfebfffff]
[    0.068172] pci_bus 0000:05: resource 2 [mem 0xf0400000-0xf05fffff 64bit pref]
[    0.068173] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
[    0.068173] pci_bus 0000:04: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.068175] pci_bus 0000:04: resource 2 [mem 0xf0600000-0xf07fffff 64bit pref]
[    0.068176] pci_bus 0000:07: resource 4 [io  0x0000-0x0cf7]
[    0.068177] pci_bus 0000:07: resource 5 [io  0x0d00-0xffff]
[    0.068178] pci_bus 0000:07: resource 6 [mem 0x000a0000-0x000bffff]
[    0.068179] pci_bus 0000:07: resource 7 [mem 0x000d0000-0x000dffff]
[    0.068180] pci_bus 0000:07: resource 8 [mem 0xd0000000-0xdfffffff]
[    0.068181] pci_bus 0000:07: resource 9 [mem 0xf0000000-0xffffffff]
[    0.068193] NET: Registered protocol family 2
[    0.068320] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.068440] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.068631] TCP: Hash tables configured (established 65536 bind 65536)
[    0.068686] TCP: reno registered
[    0.068721] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.068781] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.068858] NET: Registered protocol family 1
[    0.069505] pci 0000:01:00.0: Video device with shadowed ROM
[    0.069514] PCI: CLS 32 bytes, default 64
[    0.069542] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.069580] software IO TLB [mem 0xcbf70000-0xcff70000] (64MB) mapped at [ffff8800cbf70000-ffff8800cff6ffff]
[    0.069947] sha1_ssse3: Using SSSE3 optimized SHA-1 implementation
[    0.070002] sha256_ssse3: Using SSSE3 optimized SHA-256 implementation
[    0.070157] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.070206] audit: initializing netlink subsys (disabled)
[    0.070249] audit: type=2000 audit(1414939619.069:1): initialized
[    0.071867] fuse init (API version 7.23)
[    0.071973] msgmni has been set to 15951
[    0.072358] NET: Registered protocol family 38
[    0.072417] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.072456] io scheduler noop registered
[    0.072492] io scheduler deadline registered
[    0.072546] io scheduler cfq registered (default)
[    0.072700] pcieport 0000:00:1c.0: enabling device (0106 -> 0107)
[    0.072973] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
[    0.093479] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.093649] Non-volatile memory driver v1.3
[    0.093690] [drm] Initialized drm 1.1.0 20060810
[    0.093869] nouveau  [  DEVICE][0000:01:00.0] BOOT0  : 0x094100a1
[    0.093907] nouveau  [  DEVICE][0000:01:00.0] Chipset: G94 (NV94)
[    0.093944] nouveau  [  DEVICE][0000:01:00.0] Family : NV50
[    0.093993] nouveau  [   VBIOS][0000:01:00.0] checking PRAMIN for image...
[    0.138413] nouveau  [   VBIOS][0000:01:00.0] ... appears to be valid
[    0.138450] nouveau  [   VBIOS][0000:01:00.0] using image from PRAMIN
[    0.138554] nouveau  [   VBIOS][0000:01:00.0] BIT signature found
[    0.138592] nouveau  [   VBIOS][0000:01:00.0] version 62.94.3c.00.00
[    0.158792] nouveau 0000:01:00.0: irq 24 for MSI/MSI-X
[    0.158797] nouveau  [     PMC][0000:01:00.0] MSI interrupts enabled
[    0.158851] nouveau  [     PFB][0000:01:00.0] RAM type: GDDR3
[    0.158896] nouveau  [     PFB][0000:01:00.0] RAM size: 512 MiB
[    0.158940] nouveau  [     PFB][0000:01:00.0]    ZCOMP: 4096 tags
[    0.159652] nouveau  [    VOLT][0000:01:00.0] GPU voltage: 1000000uv
[    0.187368] nouveau  [  PTHERM][0000:01:00.0] FAN control: none / external
[    0.187418] nouveau  [  PTHERM][0000:01:00.0] fan management: automatic
[    0.187469] nouveau  [  PTHERM][0000:01:00.0] internal sensor: yes
[    0.187534] nouveau  [     CLK][0000:01:00.0] 0f: core 650 MHz shader 1625 MHz memory 900 MHz
[    0.187618] nouveau  [     CLK][0000:01:00.0] --: core 500 MHz shader 1250 MHz memory 499 MHz
[    0.187754] [TTM] Zone  kernel: Available graphics memory: 4083504 kiB
[    0.187799] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    0.187844] [TTM] Initializing pool allocator
[    0.187889] [TTM] Initializing DMA pool allocator
[    0.187941] nouveau  [     DRM] VRAM: 512 MiB
[    0.187984] nouveau  [     DRM] GART: 1048576 MiB
[    0.188033] nouveau  [     DRM] TMDS table version 2.0
[    0.188077] nouveau  [     DRM] DCB version 4.0
[    0.188121] nouveau  [     DRM] DCB outp 00: 02000300 00000028
[    0.188166] nouveau  [     DRM] DCB outp 01: 01000302 00020030
[    0.188211] nouveau  [     DRM] DCB outp 02: 04011310 00000028
[    0.188255] nouveau  [     DRM] DCB outp 03: 02022332 00020030
[    0.188300] nouveau  [     DRM] DCB conn 00: 00001030
[    0.188376] nouveau  [     DRM] DCB conn 01: 00000100
[    0.188452] nouveau  [     DRM] DCB conn 02: 00002261
[    0.194973] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.195022] [drm] Driver supports precise vblank timestamp query.
[    0.451719] nouveau  [     DRM] MM: using CRYPT for buffer copies
[    0.582536] nouveau  [     DRM] allocated 1920x1080 fb: 0x70000, bo ffff8802258d8c00
[    0.582625] fbcon: nouveaufb (fb0) is primary device
[    0.670850] Console: switching to colour frame buffer device 240x67
[    0.672927] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
[    0.672935] nouveau 0000:01:00.0: registered panic notifier
[    0.677011] [drm] Initialized nouveau 1.2.0 20120801 for 0000:01:00.0 on minor 0
[    0.677094] brd: module loaded
[    0.677486] loop: module loaded
[    0.677526] ahci 0000:00:1f.2: version 3.0
[    0.677584] ahci 0000:00:1f.2: irq 25 for MSI/MSI-X
[    0.677608] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.677635] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    0.677640] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ccc ems sxs 
[    0.687340] scsi host0: ahci
[    0.687422] scsi host1: ahci
[    0.687481] scsi host2: ahci
[    0.687540] scsi host3: ahci
[    0.687600] scsi host4: ahci
[    0.687657] scsi host5: ahci
[    0.687687] ata1: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffe900 irq 25
[    0.687692] ata2: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffe980 irq 25
[    0.687695] ata3: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffea00 irq 25
[    0.687699] ata4: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffea80 irq 25
[    0.687702] ata5: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffeb00 irq 25
[    0.687706] ata6: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffeb80 irq 25
[    0.687754] ahci 0000:05:00.0: JMB361 has only one port
[    0.698071] ahci 0000:05:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[    0.698076] ahci 0000:05:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[    0.698268] scsi host6: ahci
[    0.698329] scsi host7: ahci
[    0.698362] ata7: SATA max UDMA/133 abar m8192@0xfebfe000 port 0xfebfe100 irq 16
[    0.698367] ata8: SATA max UDMA/133 abar m8192@0xfebfe000 port 0xfebfe180 irq 16
[    0.698385] sata_sil24 0000:03:00.0: version 1.1
[    0.698422] sata_sil24 0000:03:00.0: Applying completion IRQ loss on PCI-X errata fix
[    0.698781] scsi host8: sata_sil24
[    0.698837] scsi host9: sata_sil24
[    0.698892] scsi host10: sata_sil24
[    0.698949] scsi host11: sata_sil24
[    0.698976] ata9: SATA max UDMA/100 host m128@0xfe9ffc00 port 0xfe9f0000 irq 16
[    0.698981] ata10: SATA max UDMA/100 host m128@0xfe9ffc00 port 0xfe9f2000 irq 16
[    0.698985] ata11: SATA max UDMA/100 host m128@0xfe9ffc00 port 0xfe9f4000 irq 16
[    0.698988] ata12: SATA max UDMA/100 host m128@0xfe9ffc00 port 0xfe9f6000 irq 16
[    0.699017] pata_jmicron 0000:05:00.1: enabling device (0000 -> 0001)
[    0.699427] scsi host12: pata_jmicron
[    0.699480] scsi host13: pata_jmicron
[    0.699507] ata13: PATA max UDMA/100 cmd 0xec00 ctl 0xe880 bmdma 0xe400 irq 17
[    0.699510] ata14: PATA max UDMA/100 cmd 0xe800 ctl 0xe480 bmdma 0xe408 irq 17
[    0.711100] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.711251] ehci-pci: EHCI PCI platform driver
[    0.711450] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    0.711597] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.711862] ehci-pci 0000:00:1a.7: debug port 1
[    0.716034] ehci-pci 0000:00:1a.7: cache line size of 32 is not supported
[    0.716043] ehci-pci 0000:00:1a.7: irq 18, io mem 0xf9fffc00
[    0.722035] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.722203] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.722343] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.722495] usb usb1: Product: EHCI Host Controller
[    0.722780] usb usb1: Manufacturer: Linux 3.17.0+ ehci_hcd
[    0.723065] usb usb1: SerialNumber: 0000:00:1a.7
[    0.723413] hub 1-0:1.0: USB hub found
[    0.723638] hub 1-0:1.0: 6 ports detected
[    0.724056] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    0.724209] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    0.724509] ehci-pci 0000:00:1d.7: debug port 1
[    0.728697] ehci-pci 0000:00:1d.7: cache line size of 32 is not supported
[    0.728706] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf9fff800
[    0.734032] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.734210] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    0.734353] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.734559] usb usb2: Product: EHCI Host Controller
[    0.734862] usb usb2: Manufacturer: Linux 3.17.0+ ehci_hcd
[    0.735168] usb usb2: SerialNumber: 0000:00:1d.7
[    0.735518] hub 2-0:1.0: USB hub found
[    0.735758] hub 2-0:1.0: 6 ports detected
[    0.736135] uhci_hcd: USB Universal Host Controller Interface driver
[    0.736376] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.736627] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    0.736930] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000a800
[    0.737238] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    0.737500] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.737789] usb usb3: Product: UHCI Host Controller
[    0.738083] usb usb3: Manufacturer: Linux 3.17.0+ uhci_hcd
[    0.738356] usb usb3: SerialNumber: 0000:00:1a.0
[    0.738700] hub 3-0:1.0: USB hub found
[    0.738939] hub 3-0:1.0: 2 ports detected
[    0.739323] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.739526] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    0.739851] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a880
[    0.740162] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    0.740440] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.740755] usb usb4: Product: UHCI Host Controller
[    0.741077] usb usb4: Manufacturer: Linux 3.17.0+ uhci_hcd
[    0.741393] usb usb4: SerialNumber: 0000:00:1a.1
[    0.741777] hub 4-0:1.0: USB hub found
[    0.742049] hub 4-0:1.0: 2 ports detected
[    0.742447] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.742678] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    0.743015] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000ac00
[    0.743341] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    0.743636] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.743963] usb usb5: Product: UHCI Host Controller
[    0.744290] usb usb5: Manufacturer: Linux 3.17.0+ uhci_hcd
[    0.744606] usb usb5: SerialNumber: 0000:00:1a.2
[    0.744980] hub 5-0:1.0: USB hub found
[    0.745260] hub 5-0:1.0: 2 ports detected
[    0.745665] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.745904] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    0.746248] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a080
[    0.746582] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    0.746894] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.747231] usb usb6: Product: UHCI Host Controller
[    0.747557] usb usb6: Manufacturer: Linux 3.17.0+ uhci_hcd
[    0.747892] usb usb6: SerialNumber: 0000:00:1d.0
[    0.748279] hub 6-0:1.0: USB hub found
[    0.748557] hub 6-0:1.0: 2 ports detected
[    0.748972] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.749218] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    0.749565] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a400
[    0.749902] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    0.750213] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.750547] usb usb7: Product: UHCI Host Controller
[    0.750882] usb usb7: Manufacturer: Linux 3.17.0+ uhci_hcd
[    0.751224] usb usb7: SerialNumber: 0000:00:1d.1
[    0.751607] hub 7-0:1.0: USB hub found
[    0.751886] hub 7-0:1.0: 2 ports detected
[    0.752300] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.752541] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    0.752890] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a480
[    0.753239] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    0.753550] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.753888] usb usb8: Product: UHCI Host Controller
[    0.754227] usb usb8: Manufacturer: Linux 3.17.0+ uhci_hcd
[    0.754561] usb usb8: SerialNumber: 0000:00:1d.2
[    0.754953] hub 8-0:1.0: USB hub found
[    0.755246] hub 8-0:1.0: 2 ports detected
[    0.755648] usbcore: registered new interface driver usb-storage
[    0.755925] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    0.758777] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.758939] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.759140] mousedev: PS/2 mouse device common for all mice
[    0.759399] rtc_cmos 00:01: RTC can wake from S4
[    0.759790] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    0.760069] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.760390] i2c /dev entries driver
[    0.761046] md: raid0 personality registered for level 0
[    0.761186] md: raid1 personality registered for level 1
[    0.761432] device-mapper: uevent: version 1.0.3
[    0.761782] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel@redhat.com
[    0.762414] usbcore: registered new interface driver usbhid
[    0.762556] usbhid: USB HID core driver
[    0.762899] snd_hda_intel 0000:00:1b.0: irq 26 for MSI/MSI-X
[    0.762931] oprofile: using NMI interrupt.
[    0.763114] Netfilter messages via NETLINK v0.30.
[    0.763443] nfnl_acct: registering with nfnetlink.
[    0.763790] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    0.764195] ctnetlink v0.93: registering with nfnetlink.
[    0.764553] ip_tables: (C) 2000-2006 Netfilter Core Team
[    0.764822] TCP: cubic registered
[    0.765157] Initializing XFRM netlink socket
[    0.765560] NET: Registered protocol family 10
[    0.765962] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    0.766197] NET: Registered protocol family 17
[    0.766514] NET: Registered protocol family 15
[    0.767005] registered taskstats version 1
[    0.768045] rtc_cmos 00:01: setting system clock to 2014-11-02 14:47:00 UTC (1414939620)
[    0.768215] ALSA device list:
[    0.768357]   No soundcards found.
[    0.771167] sound hdaudioC0D0: autoconfig: line_outs=4 (0x1c/0x19/0x22/0x23/0x0) type:line
[    0.771315] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    0.771458] sound hdaudioC0D0:    hp_outs=1 (0x1d/0x0/0x0/0x0/0x0)
[    0.771798] sound hdaudioC0D0:    mono: mono_out=0x0
[    0.772147] sound hdaudioC0D0:    dig-out=0x20/0x21
[    0.772487] sound hdaudioC0D0:    inputs:
[    0.772828] sound hdaudioC0D0:      Rear Mic=0x1a
[    0.773169] sound hdaudioC0D0:      Front Mic=0x1e
[    0.773497] sound hdaudioC0D0:      Line=0x1b
[    0.773827] sound hdaudioC0D0:      CD=0x1f
[    0.853493] ata13.00: ATAPI: TSSTcorp CDDVDW SH-S222A, SB02, max UDMA/66
[    0.859498] ata13.00: configured for UDMA/66
[    0.992036] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.992651] ata1.00: ATA-8: WDC WD2001FFSX-68JNUN0, 81.00A81, max UDMA/133
[    0.992796] ata1.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    0.993405] ata1.00: configured for UDMA/133
[    0.993621] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2001FFSX-6 0A81 PQ: 0 ANSI: 5
[    0.993886] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[    0.993887] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    0.994378] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    0.994734] sd 0:0:0:0: [sda] Write Protect is off
[    0.995059] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.995069] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.001259]  sda: sda1 sda2
[    1.001534] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.004027] ata7: SATA link down (SStatus 0 SControl 300)
[    1.072157] tsc: Refined TSC clocksource calibration: 3999.852 MHz
[    1.298040] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.298668] ata2.00: ATA-8: WDC WD2001FFSX-68JNUN0, 81.00A81, max UDMA/133
[    1.298823] ata2.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    1.300403] ata2.00: configured for UDMA/133
[    1.300594] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2001FFSX-6 0A81 PQ: 0 ANSI: 5
[    1.300827] sd 1:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[    1.301089] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    1.301098] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    1.301838] sd 1:0:0:0: [sdb] Write Protect is off
[    1.302175] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.302184] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.315775]  sdb: sdb1 sdb2
[    1.316055] sd 1:0:0:0: [sdb] Attached SCSI disk
[    1.606031] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.606722] ata3.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133
[    1.606884] ata3.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    1.607597] ata3.00: configured for UDMA/133
[    1.607793] scsi 2:0:0:0: Direct-Access     ATA      WDC WD30EFRX-68E 0A80 PQ: 0 ANSI: 5
[    1.608039] sd 2:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    1.608053] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    1.608720] sd 2:0:0:0: [sdc] 4096-byte physical blocks
[    1.609117] sd 2:0:0:0: [sdc] Write Protect is off
[    1.609476] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    1.609486] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.668914]  sdc: sdc1
[    1.669175] sd 2:0:0:0: [sdc] Attached SCSI disk
[    1.808236] usb 6-2: new low-speed USB device number 2 using uhci_hcd
[    1.913039] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.913659] ata4.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133
[    1.913826] ata4.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    1.914534] ata4.00: configured for UDMA/133
[    1.914735] scsi 3:0:0:0: Direct-Access     ATA      WDC WD30EFRX-68E 0A80 PQ: 0 ANSI: 5
[    1.915007] sd 3:0:0:0: [sdd] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    1.915021] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    1.915715] sd 3:0:0:0: [sdd] 4096-byte physical blocks
[    1.916134] sd 3:0:0:0: [sdd] Write Protect is off
[    1.916502] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    1.916512] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.986578] usb 6-2: New USB device found, idVendor=051d, idProduct=0002
[    1.986755] usb 6-2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    1.987009] usb 6-2: Product: Smart-UPS 750 FW:651.18.I USB FW:7.3
[    1.987406] usb 6-2: Manufacturer: American Power Conversion
[    1.987804] usb 6-2: SerialNumber: AS0848123490
[    2.072388] Switched to clocksource tsc
[    2.220036] ata5: SATA link down (SStatus 0 SControl 300)
[    2.525035] ata6: SATA link down (SStatus 0 SControl 300)
[    2.677161]  sdd: sdd1
[    2.677441] sd 3:0:0:0: [sdd] Attached SCSI disk
[    2.831058] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    2.839606] ata9.00: ATA-8: OCZ-REVODRIVE, 1.35, max UDMA/133
[    2.839781] ata9.00: 78161328 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.849607] ata9.00: configured for UDMA/100
[    3.790602] hid-generic 0003:051D:0002.0001: hiddev0: USB HID v1.10 Device [American Power Conversion Smart-UPS 750 FW:651.18.I USB FW:7.3] on usb-0000:00:1d.0-2/input0
[    3.996228] usb 8-1: new low-speed USB device number 2 using uhci_hcd
[    4.161236] usb 8-1: New USB device found, idVendor=046d, idProduct=c31c
[    4.161419] usb 8-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.161725] usb 8-1: Product: USB Keyboard
[    4.162167] usb 8-1: Manufacturer: Logitech
[    4.196480] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:1d.2/usb8/8-1/8-1:1.0/0003:046D:C31C.0002/input/input2
[    4.196690] hid-generic 0003:046D:C31C.0002: input: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:00:1d.2-1/input0
[    4.246265] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:1d.2/usb8/8-1/8-1:1.1/0003:046D:C31C.0003/input/input3
[    4.246466] hid-generic 0003:046D:C31C.0003: input: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:00:1d.2-1/input1
[    4.452145] usb 8-2: new full-speed USB device number 3 using uhci_hcd
[    4.620236] usb 8-2: New USB device found, idVendor=1532, idProduct=001c
[    4.620419] usb 8-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.620780] usb 8-2: Product: Razer Abyssus
[    4.621252] usb 8-2: Manufacturer: Razer 
[    4.629507] input: Razer  Razer Abyssus as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.0/0003:1532:001C.0004/input/input4
[    4.629723] hid-generic 0003:1532:001C.0004: input: USB HID v1.11 Mouse [Razer  Razer Abyssus] on usb-0000:00:1d.2-2/input0
[    6.052229] ata8: link is slow to respond, please be patient (ready=-19)
[   10.744229] ata8: COMRESET failed (errno=-16)
[   16.098114] ata8: link is slow to respond, please be patient (ready=-19)
[   20.790040] ata8: COMRESET failed (errno=-16)
[   26.144229] ata8: link is slow to respond, please be patient (ready=-19)
[   49.186452] random: nonblocking pool is initialized
[   55.826199] ata8: COMRESET failed (errno=-16)
[   55.826386] ata8: limiting SATA link speed to 1.5 Gbps
[   60.874228] ata8: COMRESET failed (errno=-16)
[   60.874413] ata8: reset failed, giving up
[   60.874815] scsi 8:0:0:0: Direct-Access     ATA      OCZ-REVODRIVE    1.35 PQ: 0 ANSI: 5
[   60.875341] sd 8:0:0:0: [sde] 78161328 512-byte logical blocks: (40.0 GB/37.2 GiB)
[   60.875768] sd 8:0:0:0: Attached scsi generic sg4 type 0
[   60.875787] sd 8:0:0:0: [sde] Write Protect is off
[   60.875788] sd 8:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   60.875797] sd 8:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   60.883247]  sde: sde1
[   60.883547] sd 8:0:0:0: [sde] Attached SCSI disk
[   63.031059] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   63.040445] ata10.00: ATA-8: OCZ-REVODRIVE, 1.35, max UDMA/133
[   63.040627] ata10.00: 78161328 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   63.050445] ata10.00: configured for UDMA/100
[   63.050651] scsi 9:0:0:0: Direct-Access     ATA      OCZ-REVODRIVE    1.35 PQ: 0 ANSI: 5
[   63.051072] sd 9:0:0:0: [sdf] 78161328 512-byte logical blocks: (40.0 GB/37.2 GiB)
[   63.051086] sd 9:0:0:0: Attached scsi generic sg5 type 0
[   63.052014] sd 9:0:0:0: [sdf] Write Protect is off
[   63.052458] sd 9:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   63.052468] sd 9:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   63.053156]  sdf: sdf1
[   63.053525] sd 9:0:0:0: [sdf] Attached SCSI disk
[   65.093097] ata11: SATA link down (SStatus 0 SControl 0)
[   67.135276] ata12: SATA link down (SStatus 0 SControl 0)
[   67.136068] scsi 12:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S222A  SB02 PQ: 0 ANSI: 5
[   67.157998] sr 12:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[   67.158179] cdrom: Uniform CD-ROM driver Revision: 3.20
[   67.158605] sr 12:0:0:0: Attached scsi CD-ROM sr0
[   67.158634] sr 12:0:0:0: Attached scsi generic sg6 type 5
[   67.322024] md: Waiting for all devices to be available before autodetect
[   67.322203] md: If you don't use raid, use raid=noautodetect
[   67.322643] md: Autodetecting RAID arrays.
[   67.392841] md: Scanned 8 and added 8 devices.
[   67.393019] md: autorun ...
[   67.393380] md: considering sdf1 ...
[   67.393854] md:  adding sdf1 ...
[   67.394327] md:  adding sde1 ...
[   67.394791] md: sdd1 has different UUID to sdf1
[   67.395270] md: sdc1 has different UUID to sdf1
[   67.395731] md: sdb2 has different UUID to sdf1
[   67.396198] md: sdb1 has different UUID to sdf1
[   67.396656] md: sda2 has different UUID to sdf1
[   67.397113] md: sda1 has different UUID to sdf1
[   67.397556] md: created md0
[   67.397996] md: bind<sde1>
[   67.398430] md: bind<sdf1>
[   67.398837] md: running: <sdf1><sde1>
[   67.399293] md/raid0:md0: md_size is 156317696 sectors.
[   67.399640] md: RAID0 configuration for md0 - 1 zone
[   67.400042] md: zone0=[sde1/sdf1]
[   67.400443]       zone-offset=         0KB, device-offset=         0KB, size=  78158848KB

[   67.401241] md0: detected capacity change from 0 to 80034660352
[   67.401621] md: considering sdd1 ...
[   67.401996] md:  adding sdd1 ...
[   67.402358] md:  adding sdc1 ...
[   67.402709] md: sdb2 has different UUID to sdd1
[   67.403066] md: sdb1 has different UUID to sdd1
[   67.403412] md: sda2 has different UUID to sdd1
[   67.403758] md: sda1 has different UUID to sdd1
[   67.404155] md: created md3
[   67.404420] md: bind<sdc1>
[   67.404735] md: bind<sdd1>
[   67.405036] md: running: <sdd1><sdc1>
[   67.405384] md/raid1:md3: active with 2 out of 2 mirrors
[   67.405667] created bitmap (22 pages) for device md3
[   67.406199] md3: bitmap initialized from disk: read 2 pages, set 0 of 44713 bits
[   68.094207] md3: detected capacity change from 0 to 3000591843328
[   68.094367] md: considering sdb2 ...
[   68.094513] md:  adding sdb2 ...
[   68.094732] md: sdb1 has different UUID to sdb2
[   68.095033] md:  adding sda2 ...
[   68.095322] md: sda1 has different UUID to sdb2
[   68.095669] md: created md2
[   68.095894] md: bind<sda2>
[   68.096185] md: bind<sdb2>
[   68.096453] md: running: <sdb2><sda2>
[   68.096770] md/raid1:md2: active with 2 out of 2 mirrors
[   68.097028] created bitmap (15 pages) for device md2
[   68.097428] md2: bitmap initialized from disk: read 1 pages, set 0 of 29801 bits
[   68.106602] md2: detected capacity change from 0 to 1999860924416
[   68.106758] md: considering sdb1 ...
[   68.106897] md:  adding sdb1 ...
[   68.107053] md:  adding sda1 ...
[   68.107364] md: created md1
[   68.107557] md: bind<sda1>
[   68.107811] md: bind<sdb1>
[   68.108055] md: running: <sdb1><sda1>
[   68.108336] md/raid1:md1: active with 2 out of 2 mirrors
[   68.108557] created bitmap (1 pages) for device md1
[   68.108799] md1: bitmap initialized from disk: read 1 pages, set 0 of 8 bits
[   68.138134] md1: detected capacity change from 0 to 536805376
[   68.138283] md: ... autorun DONE.
[   68.138559]  md0: unknown partition table
[   68.140622] EXT4-fs (md0): mounted filesystem with ordered data mode. Opts: (null)
[   68.140768] VFS: Mounted root (ext4 filesystem) readonly on device 9:0.
[   68.141877] devtmpfs: mounted
[   68.142218] Freeing unused kernel memory: 812K (ffffffff81925000 - ffffffff819f0000)
[   68.191025] systemd[1]: systemd 215 running in system mode. (+PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
[   68.191251] systemd[1]: Detected architecture 'x86-64'.
[   68.195200] systemd[1]: Set hostname to <atlas>.
[   68.275969] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[   68.276162] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   68.276312] systemd[1]: Starting Remote File Systems (Pre).
[   68.276782] systemd[1]: Reached target Remote File Systems (Pre).
[   68.277078] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[   68.277393] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   68.277706] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[   68.278379] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   68.278709] systemd[1]: Starting Encrypted Volumes.
[   68.279407] systemd[1]: Reached target Encrypted Volumes.
[   68.279735] systemd[1]: Starting Swap.
[   68.280423] systemd[1]: Reached target Swap.
[   68.280743] systemd[1]: Expecting device dev-md1.device...
[   68.281429] systemd[1]: Expecting device dev-md2.device...
[   68.282126] systemd[1]: Expecting device dev-md3.device...
[   68.282844] systemd[1]: Starting Root Slice.
[   68.284397] systemd[1]: Created slice Root Slice.
[   68.284556] systemd[1]: Starting User and Session Slice.
[   68.285308] systemd[1]: Created slice User and Session Slice.
[   68.285672] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[   68.286428] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[   68.286793] systemd[1]: Starting Delayed Shutdown Socket.
[   68.287564] systemd[1]: Listening on Delayed Shutdown Socket.
[   68.287935] systemd[1]: Starting Journal Socket (/dev/log).
[   68.288722] systemd[1]: Listening on Journal Socket (/dev/log).
[   68.289105] systemd[1]: Starting Syslog Socket.
[   68.289906] systemd[1]: Listening on Syslog Socket.
[   68.290296] systemd[1]: Starting udev Control Socket.
[   68.291098] systemd[1]: Listening on udev Control Socket.
[   68.291476] systemd[1]: Starting udev Kernel Socket.
[   68.292273] systemd[1]: Listening on udev Kernel Socket.
[   68.292661] systemd[1]: Starting Journal Socket.
[   68.293480] systemd[1]: Listening on Journal Socket.
[   68.293884] systemd[1]: Starting System Slice.
[   68.294711] systemd[1]: Created slice System Slice.
[   68.295119] systemd[1]: Mounting Temporary Directory...
[   68.296176] systemd[1]: Starting File System Check on Root Device...
[   68.296954] systemd[1]: Starting system-systemd\x2dfsck.slice.
[   68.297573] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   68.297982] systemd[1]: Starting system-getty.slice.
[   68.298781] systemd[1]: Created slice system-getty.slice.
[   68.299157] systemd[1]: Starting system-postgresql.slice.
[   68.299931] systemd[1]: Created slice system-postgresql.slice.
[   68.300368] systemd[1]: Mounted Huge Pages File System.
[   68.300859] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[   68.301688] systemd[1]: Mounting Debug File System...
[   68.302438] systemd[1]: Mounting POSIX Message Queue File System...
[   68.303234] systemd[1]: Starting udev Coldplug all Devices...
[   68.308792] systemd[1]: Starting Load Kernel Modules...
[   68.313798] systemd[1]: Started Set Up Additional Binary Formats.
[   68.313987] systemd[1]: Starting Journal Service...
[   68.314891] systemd[1]: Started Journal Service.
[   68.423037] systemd-udevd[173]: starting version 215
[   68.551082]  md1: unknown partition table
[   68.551985]  md2: unknown partition table
[   68.632095]  md3: unknown partition table
[   69.226055] EXT4-fs (md0): re-mounted. Opts: barrier=0
[   69.233204] EXT4-fs (md1): barriers disabled
[   69.252306] EXT4-fs (md3): barriers disabled
[   69.279165] EXT4-fs (md3): mounted filesystem with ordered data mode. Opts: barrier=0
[   69.311975] EXT4-fs (md2): barriers disabled
[   69.349736] EXT4-fs (md1): mounted filesystem with ordered data mode. Opts: barrier=0
[   69.351555] EXT4-fs (md2): mounted filesystem with ordered data mode. Opts: barrier=0
[   69.361300] systemd-journald[155]: Received request to flush runtime journal from PID 1
[   69.515020] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   69.515085] ATL1E 0000:04:00.0 eth0: NIC Link is Up <100 Mbps Full Duplex>
[   69.515089] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   70.371068] Process accounting resumed

--------------070607070903090501050307--

