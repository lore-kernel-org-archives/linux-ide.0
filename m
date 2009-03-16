From: Volker Lanz <vl@fidra.de>
Subject: AHCI errors on ICH10 board
Date: Mon, 16 Mar 2009 14:06:01 +0100
Message-ID: <200903161406.01411.vl@fidra.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from twilight.fidra.de ([88.198.14.164]:49076 "EHLO
	twilight.fidra.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbZCPNhJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Mar 2009 09:37:09 -0400
Received: from trevor.localnet (p57B1FEBE.dip.t-dialin.net [87.177.254.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by twilight.fidra.de (Postfix) with ESMTP id CEA53B98084
	for <linux-ide@vger.kernel.org>; Mon, 16 Mar 2009 14:06:01 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

last week I swapped an old Gigabyte P35 board for a new ASUS P5Q. On this new 
board, which is based on ICH10, I can't get AHCI to work reliably at all. When 
it's on, it doesn't take very long until I get massive errors in the kernel 
log like this:

ata1.00: exception Emask 0x2 SAct 0x1 SErr 0x3000400 action 0x6
ata1.00: irq_stat 0x45000008
ata1: SError: { Proto TrStaTrns UnrecFIS }
ata1.00: cmd 60/00:00:4a:b6:60/02:00:0c:00:00/40 tag 0 ncq 262144 in
res 51/84:00:4a:b6:60/4e:00:0c:00:00/40 Emask 0x412 (ATA bus error) <F>
ata1.00: status: { DRDY ERR }
ata1.00: error: { ICRC ABRT }

This occurs with both hard drives in the machine. It is easily triggered with 
a cp -a of some large dir tree within seconds.

At the same time many things start to mysteriously segfault or break in other 
strange ways.

Some observations:
* Affected kernels: 2.6.27 (Ubuntu-patched for Ubuntu 8.10), 2.6.28 (Ubuntu-
patched for Ubuntu 9.04) and 2.6.29-rc8 (mainline, installed from Ubuntu 
packages, not patched AFAIK)
* Both hard drives in the affected machine used to work in AHCI mode on the 
old Gigabyte board.
* Disabling NCQ as per the libATA FAQ does not make a difference.
* The mainboard BIOS is flashed to the latest version available from ASUS for 
the P5Q.
* In IDE mode, everything is fine.

I'll append a kernel log (from 2.6.29-rc8), lspci output and hdparm -I output 
for the drives.

Does anyone have any explanation for this? Is it a bug or a problem with this 
specific configuration? Can I do anything to fix it?

Thanks,

Volker



----- begin dmesg -----
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.29-020629rc8-generic (root@zinc) (gcc version 
4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #020629rc8 SMP Fri Mar 13 16:32:02 UTC 2009
[    0.000000] Command line: root=UUID=736330ed-0c12-4175-91a1-3ce4004f0668 ro 
nosplash
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
[    0.000000]  BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bff70000 (usable)
[    0.000000]  BIOS-e820: 00000000bff70000 - 00000000bff7e000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bff7e000 - 00000000bffd0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bffd0000 - 00000000c0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 00000001c0000000 (usable)
[    0.000000] DMI present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working around it.
[    0.000000] last_pfn = 0x1c0000 max_arch_pfn = 0x100000000
[    0.000000] last_pfn = 0xbff70 max_arch_pfn = 0x100000000
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009ec00 (usable)
[    0.000000]  modified: 000000000009ec00 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 00000000bff70000 (usable)
[    0.000000]  modified: 00000000bff70000 - 00000000bff7e000 (ACPI data)
[    0.000000]  modified: 00000000bff7e000 - 00000000bffd0000 (ACPI NVS)
[    0.000000]  modified: 00000000bffd0000 - 00000000c0000000 (reserved)
[    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  modified: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  modified: 0000000100000000 - 00000001c0000000 (usable)
[    0.000000] init_memory_mapping: 0000000000000000-00000000bff70000
[    0.000000]  0000000000 - 00bfe00000 page 2M
[    0.000000]  00bfe00000 - 00bff70000 page 4k
[    0.000000] kernel direct mapping tables up to bff70000 @ 10000-15000
[    0.000000] last_map_addr: bff70000 end: bff70000
[    0.000000] init_memory_mapping: 0000000100000000-00000001c0000000
[    0.000000]  0100000000 - 01c0000000 page 2M
[    0.000000] kernel direct mapping tables up to 1c0000000 @ 13000-1b000
[    0.000000] last_map_addr: 1c0000000 end: 1c0000000
[    0.000000] RAMDISK: 3785e000 - 37fefa6a
[    0.000000] ACPI: RSDP 000FB410, 0024 (r2 ACPIAM)
[    0.000000] ACPI: XSDT BFF70100, 005C (r1 A_M_I_ OEMXSDT  11000826 MSFT       
97)
[    0.000000] ACPI: FACP BFF70290, 00F4 (r3 A_M_I_ OEMFACP  11000826 MSFT       
97)
[    0.000000] FADT: X_PM1a_EVT_BLK.bit_width (16) does not match PM1_EVT_LEN 
(4)
[    0.000000] ACPI: DSDT BFF70440, 96DE (r1  A0993 A0993001        1 INTL 
20060113)
[    0.000000] ACPI: FACS BFF7E000, 0040
[    0.000000] ACPI: APIC BFF70390, 006C (r1 A_M_I_ OEMAPIC  11000826 MSFT       
97)
[    0.000000] ACPI: MCFG BFF70400, 003C (r1 A_M_I_ OEMMCFG  11000826 MSFT       
97)
[    0.000000] ACPI: OEMB BFF7E040, 0089 (r1 A_M_I_ AMI_OEM  11000826 MSFT       
97)
[    0.000000] ACPI: HPET BFF79B20, 0038 (r1 A_M_I_ OEMHPET  11000826 MSFT       
97)
[    0.000000] ACPI: OSFR BFF79B60, 00B0 (r1 A_M_I_ OEMOSFR  11000826 MSFT       
97)
[    0.000000] ACPI: SSDT BFF7F040, 0A7C (r1 DpgPmm    CpuPm       12 INTL 
20060113)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] (7 early reservations) ==> bootmem [0000000000 - 01c0000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 
- 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 
- 0000008000]
[    0.000000]   #2 [0000200000 - 0000b1f778]    TEXT DATA BSS ==> [0000200000 
- 0000b1f778]
[    0.000000]   #3 [003785e000 - 0037fefa6a]          RAMDISK ==> [003785e000 
- 0037fefa6a]
[    0.000000]   #4 [000009ec00 - 0000100000]    BIOS reserved ==> [000009ec00 
- 0000100000]
[    0.000000]   #5 [0000010000 - 0000013000]          PGTABLE ==> [0000010000 
- 0000013000]
[    0.000000]   #6 [0000013000 - 0000016000]          PGTABLE ==> [0000013000 
- 0000016000]
[    0.000000] found SMP MP-table at [ffff8800000ff780] 000ff780
[    0.000000]  [ffffe20000000000-ffffe200061fffff] PMD -> [ffff880028200000-
ffff88002e3fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x001c0000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x000bff70
[    0.000000]     0: 0x00100000 -> 0x001c0000
[    0.000000] On node 0 totalpages: 1572606
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 2443 pages reserved
[    0.000000]   DMA zone: 1483 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 767912 pages, LIFO batch:31
[    0.000000]   Normal zone: 10752 pages used for memmap
[    0.000000]   Normal zone: 775680 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 
000000000009f000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 
00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 
00000000000e4000
[    0.000000] PM: Registered nosave memory: 00000000000e4000 - 
0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000bff70000 - 
00000000bff7e000
[    0.000000] PM: Registered nosave memory: 00000000bff7e000 - 
00000000bffd0000
[    0.000000] PM: Registered nosave memory: 00000000bffd0000 - 
00000000c0000000
[    0.000000] PM: Registered nosave memory: 00000000c0000000 - 
00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 
00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 
00000000fff00000
[    0.000000] PM: Registered nosave memory: 00000000fff00000 - 
0000000100000000
[    0.000000] Allocating PCI resources starting at c4000000 (gap: 
c0000000:3ee00000)
[    0.000000] NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Allocating 69632 bytes of per cpu data
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total 
pages: 1545075
[    0.000000] Kernel command line: 
root=UUID=736330ed-0c12-4175-91a1-3ce4004f0668 ro nosplash
[    0.000000] Initializing CPU#0
[    0.000000] xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] TSC: PIT calibration matches PMTIMER. 1 loops
[    0.000000] Detected 2833.074 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 
bytes)
[    0.004000] Inode-cache hash table entries: 524288 (order: 10, 4194304 
bytes)
[    0.004000] allocated 73400320 bytes of page_cgroup
[    0.004000] please try cgroup_disable=memory option if you don't want
[    0.004000] Checking aperture...
[    0.004000] No AGP bridge found
[    0.004000] Calgary: detecting Calgary via BIOS EBDA area
[    0.004000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.004000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.004000] Placing 64MB software IO TLB between ffff880020000000 - 
ffff880024000000
[    0.004000] software IO TLB at phys 0x20000000 - 0x24000000
[    0.004000] Memory: 6021508k/7340032k available (4635k kernel code, 
1049608k absent, 267948k reserved, 2615k data, 544k init)
[    0.004000] SLUB: Genslabs=12, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, 
Nodes=1
[    0.004000] hpet clockevent registered
[    0.004000] HPET: 4 timers in total, 0 timers will be used for per-cpu 
timer
[    0.004000] Calibrating delay loop (skipped), value calculated using timer 
frequency.. 5666.14 BogoMIPS (lpj=11332296)
[    0.004000] Security Framework initialized
[    0.004000] SELinux:  Disabled at boot.
[    0.004000] Mount-cache hash table entries: 256
[    0.004000] Initializing cgroup subsys ns
[    0.004000] Initializing cgroup subsys cpuacct
[    0.004000] Initializing cgroup subsys memory
[    0.004000] Initializing cgroup subsys freezer
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 6144K
[    0.004000] [ds] using Core 2/Atom configuration
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 0
[    0.004000] using mwait in idle threads.
[    0.004000] ACPI: Core revision 20081204
[    0.016043] Setting APIC routing to flat
[    0.016576] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.056309] CPU0: Intel(R) Core(TM)2 Quad CPU    Q9550  @ 2.83GHz stepping 
0a
[    0.060001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 5665.93 
BogoMIPS (lpj=11331878)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 6144K
[    0.004000] [ds] using Core 2/Atom configuration
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.144826] CPU1: Intel(R) Core(TM)2 Quad CPU    Q9550  @ 2.83GHz stepping 
0a
[    0.145199] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.148145] Booting processor 2 APIC 0x2 ip 0x6000
[    0.004000] Initializing CPU#2
[    0.004000] Calibrating delay using timer specific routine.. 5665.96 
BogoMIPS (lpj=11331939)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 6144K
[    0.004000] [ds] using Core 2/Atom configuration
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 2
[    0.240870] CPU2: Intel(R) Core(TM)2 Quad CPU    Q9550  @ 2.83GHz stepping 
0a
[    0.241241] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.244121] Booting processor 3 APIC 0x3 ip 0x6000
[    0.004000] Initializing CPU#3
[    0.004000] Calibrating delay using timer specific routine.. 5665.96 
BogoMIPS (lpj=11331929)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 6144K
[    0.004000] [ds] using Core 2/Atom configuration
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 3
[    0.336873] CPU3: Intel(R) Core(TM)2 Quad CPU    Q9550  @ 2.83GHz stepping 
0a
[    0.337245] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[    0.340067] Brought up 4 CPUs
[    0.340110] Total of 4 processors activated (22664.02 BogoMIPS).
[    0.340192] CPU0 attaching sched-domain:
[    0.340193]  domain 0: span 0-1 level MC
[    0.340195]   groups: 0 1
[    0.340197]   domain 1: span 0-3 level CPU
[    0.340199]    groups: 0-1 2-3
[    0.340202] CPU1 attaching sched-domain:
[    0.340203]  domain 0: span 0-1 level MC
[    0.340204]   groups: 1 0
[    0.340206]   domain 1: span 0-3 level CPU
[    0.340207]    groups: 0-1 2-3
[    0.340210] CPU2 attaching sched-domain:
[    0.340211]  domain 0: span 2-3 level MC
[    0.340212]   groups: 2 3
[    0.340214]   domain 1: span 0-3 level CPU
[    0.340215]    groups: 2-3 0-1
[    0.340218] CPU3 attaching sched-domain:
[    0.340219]  domain 0: span 2-3 level MC
[    0.340220]   groups: 3 2
[    0.340222]   domain 1: span 0-3 level CPU
[    0.340223]    groups: 2-3 0-1
[    0.340309] net_namespace: 1840 bytes
[    0.340309] Booting paravirtualized kernel on bare hardware
[    0.340309] regulator: core version 0.5
[    0.340309] Time: 10:43:31  Date: 03/16/09
[    0.340681] NET: Registered protocol family 16
[    0.340736] ACPI: bus type pci registered
[    0.344032] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 
255
[    0.344073] PCI: Not using MMCONFIG.
[    0.344110] PCI: Using configuration type 1 for base access
[    0.348026] bio: create slab <bio-0> at 0
[    0.352005] ACPI: EC: Look up EC in DSDT
[    0.364620] ACPI: Interpreter enabled
[    0.364664] ACPI: (supports S0 S1 S3 S4 S5)
[    0.364846] ACPI: Using IOAPIC for interrupt routing
[    0.364941] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 
255
[    0.367563] PCI: MCFG area at e0000000 reserved in ACPI motherboard 
resources
[    0.374191] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.381184] ACPI: No dock devices found.
[    0.381184] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.381184] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.381184] pci 0000:00:01.0: PME# disabled
[    0.381184] pci 0000:00:1a.0: reg 20 io port: [0xc800-0xc81f]
[    0.381184] pci 0000:00:1a.1: reg 20 io port: [0xc880-0xc89f]
[    0.381184] pci 0000:00:1a.2: reg 20 io port: [0xcc00-0xcc1f]
[    0.381184] pci 0000:00:1a.7: reg 10 32bit mmio: [0xdbfffc00-0xdbffffff]
[    0.381184] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.381184] pci 0000:00:1a.7: PME# disabled
[    0.381184] pci 0000:00:1b.0: reg 10 64bit mmio: [0xdbff8000-0xdbffbfff]
[    0.381184] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.381184] pci 0000:00:1b.0: PME# disabled
[    0.381184] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.381184] pci 0000:00:1c.0: PME# disabled
[    0.381184] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.381184] pci 0000:00:1c.5: PME# disabled
[    0.381184] pci 0000:00:1d.0: reg 20 io port: [0xc080-0xc09f]
[    0.381184] pci 0000:00:1d.1: reg 20 io port: [0xc400-0xc41f]
[    0.381184] pci 0000:00:1d.2: reg 20 io port: [0xc480-0xc49f]
[    0.381184] pci 0000:00:1d.7: reg 10 32bit mmio: [0xdbfff800-0xdbfffbff]
[    0.384018] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.384060] pci 0000:00:1d.7: PME# disabled
[    0.384193] pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH6 
ACPI/GPIO/TCO
[    0.384243] pci 0000:00:1f.0: quirk: region 0500-053f claimed by ICH6 GPIO
[    0.384284] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294 
(mask 0003)
[    0.384335] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 4700 
(mask 001f)
[    0.384430] pci 0000:00:1f.2: reg 10 io port: [0xbc00-0xbc07]
[    0.384434] pci 0000:00:1f.2: reg 14 io port: [0xb880-0xb883]
[    0.384438] pci 0000:00:1f.2: reg 18 io port: [0xb800-0xb807]
[    0.384442] pci 0000:00:1f.2: reg 1c io port: [0xb480-0xb483]
[    0.384446] pci 0000:00:1f.2: reg 20 io port: [0xb400-0xb41f]
[    0.384450] pci 0000:00:1f.2: reg 24 32bit mmio: [0xdbffe800-0xdbffefff]
[    0.384474] pci 0000:00:1f.2: PME# supported from D3hot
[    0.384514] pci 0000:00:1f.2: PME# disabled
[    0.384572] pci 0000:00:1f.3: reg 10 64bit mmio: [0xdbfff400-0xdbfff4ff]
[    0.384582] pci 0000:00:1f.3: reg 20 io port: [0x400-0x41f]
[    0.384616] pci 0000:01:00.0: reg 10 32bit mmio: [0xde000000-0xdeffffff]
[    0.384623] pci 0000:01:00.0: reg 14 64bit mmio: [0xc0000000-0xcfffffff]
[    0.384630] pci 0000:01:00.0: reg 1c 64bit mmio: [0xdc000000-0xddffffff]
[    0.384634] pci 0000:01:00.0: reg 24 io port: [0xdc00-0xdc7f]
[    0.384638] pci 0000:01:00.0: reg 30 32bit mmio: [0xdfee0000-0xdfefffff]
[    0.384682] pci 0000:00:01.0: bridge io port: [0xd000-0xdfff]
[    0.384684] pci 0000:00:01.0: bridge 32bit mmio: [0xdc000000-0xdfefffff]
[    0.384687] pci 0000:00:01.0: bridge 64bit mmio pref: 
[0xc0000000-0xcfffffff]
[    0.384720] pci 0000:00:1c.0: bridge 64bit mmio pref: 
[0xdaf00000-0xdaffffff]
[    0.384764] pci 0000:02:00.0: reg 10 64bit mmio: [0xdffc0000-0xdfffffff]
[    0.384771] pci 0000:02:00.0: reg 18 io port: [0xec00-0xec7f]
[    0.384826] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.384874] pci 0000:02:00.0: PME# disabled
[    0.384947] pci 0000:00:1c.5: bridge io port: [0xe000-0xefff]
[    0.384950] pci 0000:00:1c.5: bridge 32bit mmio: [0xdff00000-0xdfffffff]
[    0.384978] pci 0000:04:00.0: reg 10 32bit mmio: [0xf0000000-0xf7ffffff]
[    0.385001] pci 0000:04:00.0: reg 30 32bit mmio: [0xfebc0000-0xfebfffff]
[    0.385016] pci 0000:04:00.0: supports D1 D2
[    0.385017] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot
[    0.385058] pci 0000:04:00.0: PME# disabled
[    0.385113] pci 0000:04:02.0: reg 10 32bit mmio: [0xfea00000-0xfeafffff]
[    0.385163] pci 0000:04:03.0: reg 10 32bit mmio: [0xfebbf000-0xfebbffff]
[    0.385200] pci 0000:04:03.0: supports D1 D2
[    0.385202] pci 0000:04:03.0: PME# supported from D0 D1 D2 D3hot
[    0.385243] pci 0000:04:03.0: PME# disabled
[    0.385312] pci 0000:00:1e.0: transparent bridge
[    0.385353] pci 0000:00:1e.0: bridge 32bit mmio: [0xf0000000-0xfebfffff]
[    0.385369] pci_bus 0000:00: on NUMA node 0
[    0.385373] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.385494] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.385549] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.385639] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    0.385700] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
[    0.400530] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 
15)
[    0.400558] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 
15)
[    0.401023] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 
*15)
[    0.401488] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 
15)
[    0.401952] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) 
*0, disabled.
[    0.402477] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 *14 
15)
[    0.404147] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 7 10 11 12 14 
15)
[    0.404611] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 
15)
[    0.405023] ACPI Warning (tbutils-0242): Incorrect checksum in table [OEMB] 
- CB, should be C3 [20081204]
[    0.405023] SCSI subsystem initialized
[    0.405023] libata version 3.00 loaded.
[    0.405023] usbcore: registered new interface driver usbfs
[    0.405023] usbcore: registered new interface driver hub
[    0.405023] usbcore: registered new device driver usb
[    0.405023] ACPI: WMI: Mapper loaded
[    0.405023] PCI: Using ACPI for IRQ routing
[    0.420008] Bluetooth: Core ver 2.14
[    0.420060] NET: Registered protocol family 31
[    0.420060] Bluetooth: HCI device and connection manager initialized
[    0.420088] Bluetooth: HCI socket layer initialized
[    0.420126] NET: Registered protocol family 8
[    0.420164] NET: Registered protocol family 20
[    0.420216] NetLabel: Initializing
[    0.420216] NetLabel:  domain hash size = 128
[    0.420216] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.420216] NetLabel:  unlabeled traffic allowed by default
[    0.420216] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.420219] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.443978] pnp: PnP ACPI init
[    0.444023] ACPI: bus type pnp registered
[    0.447667] pnp: PnP ACPI: found 15 devices
[    0.447706] ACPI: ACPI bus type pnp unregistered
[    0.447749] system 00:01: iomem range 0xfed14000-0xfed19fff has been 
reserved
[    0.447793] system 00:07: ioport range 0x290-0x29f has been reserved
[    0.447836] system 00:08: ioport range 0x4d0-0x4d1 has been reserved
[    0.447876] system 00:08: ioport range 0x800-0x87f has been reserved
[    0.447920] system 00:08: ioport range 0x500-0x57f could not be reserved
[    0.447960] system 00:08: iomem range 0xfed08000-0xfed08fff has been 
reserved
[    0.448001] system 00:08: iomem range 0xfed1c000-0xfed1ffff has been 
reserved
[    0.448042] system 00:08: iomem range 0xfed20000-0xfed3ffff has been 
reserved
[    0.448083] system 00:08: iomem range 0xfed50000-0xfed8ffff has been 
reserved
[    0.448126] system 00:0b: iomem range 0xffc00000-0xffefffff has been 
reserved
[    0.448169] system 00:0c: iomem range 0xfec00000-0xfec00fff has been 
reserved
[    0.448210] system 00:0c: iomem range 0xfee00000-0xfee00fff has been 
reserved
[    0.448252] system 00:0d: iomem range 0xe0000000-0xefffffff has been 
reserved
[    0.448295] system 00:0e: iomem range 0x0-0x9ffff could not be reserved
[    0.448335] system 00:0e: iomem range 0xc0000-0xcffff has been reserved
[    0.448376] system 00:0e: iomem range 0xe0000-0xfffff could not be reserved
[    0.448416] system 00:0e: iomem range 0x100000-0xbfffffff could not be 
reserved
[    0.448464] system 00:0e: iomem range 0xe0000000-0xffffffff could not be 
reserved
[    0.453857] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.453897] pci 0000:00:01.0:   IO window: 0xd000-0xdfff
[    0.453937] pci 0000:00:01.0:   MEM window: 0xdc000000-0xdfefffff
[    0.453977] pci 0000:00:01.0:   PREFETCH window: 
0x000000c0000000-0x000000cfffffff
[    0.454027] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:03
[    0.454066] pci 0000:00:1c.0:   IO window: disabled
[    0.454106] pci 0000:00:1c.0:   MEM window: disabled
[    0.454146] pci 0000:00:1c.0:   PREFETCH window: 
0x000000daf00000-0x000000daffffff
[    0.454197] pci 0000:00:1c.5: PCI bridge, secondary bus 0000:02
[    0.454237] pci 0000:00:1c.5:   IO window: 0xe000-0xefff
[    0.454278] pci 0000:00:1c.5:   MEM window: 0xdff00000-0xdfffffff
[    0.454319] pci 0000:00:1c.5:   PREFETCH window: disabled
[    0.454362] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:04
[    0.454401] pci 0000:00:1e.0:   IO window: disabled
[    0.454441] pci 0000:00:1e.0:   MEM window: 0xf0000000-0xfebfffff
[    0.454482] pci 0000:00:1e.0:   PREFETCH window: 
0x000000d0000000-0x000000d00fffff
[    0.454538] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.454579] pci 0000:00:01.0: setting latency timer to 64
[    0.454585] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.454626] pci 0000:00:1c.0: setting latency timer to 64
[    0.454631] pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.454672] pci 0000:00:1c.5: setting latency timer to 64
[    0.454677] pci 0000:00:1e.0: setting latency timer to 64
[    0.454679] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.454681] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.454682] pci_bus 0000:01: resource 0 io:  [0xd000-0xdfff]
[    0.454683] pci_bus 0000:01: resource 1 mem: [0xdc000000-0xdfefffff]
[    0.454685] pci_bus 0000:01: resource 2 mem: [0xc0000000-0xcfffffff]
[    0.454686] pci_bus 0000:01: resource 3 mem: [0x0-0x0]
[    0.454687] pci_bus 0000:03: resource 0 mem: [0x0-0x0]
[    0.454688] pci_bus 0000:03: resource 1 mem: [0x0-0x0]
[    0.454690] pci_bus 0000:03: resource 2 mem: [0xdaf00000-0xdaffffff]
[    0.454691] pci_bus 0000:03: resource 3 mem: [0x0-0x0]
[    0.454692] pci_bus 0000:02: resource 0 io:  [0xe000-0xefff]
[    0.454694] pci_bus 0000:02: resource 1 mem: [0xdff00000-0xdfffffff]
[    0.454695] pci_bus 0000:02: resource 2 mem: [0x0-0x0]
[    0.454696] pci_bus 0000:02: resource 3 mem: [0x0-0x0]
[    0.454697] pci_bus 0000:04: resource 0 mem: [0x0-0x0]
[    0.454699] pci_bus 0000:04: resource 1 mem: [0xf0000000-0xfebfffff]
[    0.454700] pci_bus 0000:04: resource 2 mem: [0xd0000000-0xd00fffff]
[    0.454701] pci_bus 0000:04: resource 3 io:  [0x00-0xffff]
[    0.454703] pci_bus 0000:04: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.454722] NET: Registered protocol family 2
[    0.499785] IP route cache hash table entries: 262144 (order: 9, 2097152 
bytes)
[    0.500281] TCP established hash table entries: 262144 (order: 10, 4194304 
bytes)
[    0.500424] Switched to high resolution mode on CPU 3
[    0.500427] Switched to high resolution mode on CPU 2
[    0.501066] Switched to high resolution mode on CPU 1
[    0.501628] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.502146] TCP: Hash tables configured (established 262144 bind 65536)
[    0.502186] TCP reno registered
[    0.503728] Switched to high resolution mode on CPU 0
[    0.512106] NET: Registered protocol family 1
[    0.512235] checking if image is initramfs... it is
[    1.009379] Freeing initrd memory: 7750k freed
[    1.012674] Scanning for low memory corruption every 60 seconds
[    1.013036] audit: initializing netlink socket (disabled)
[    1.013086] type=2000 audit(1237200211.012:1): initialized
[    1.020267] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.023275] VFS: Disk quotas dquot_6.5.2
[    1.023396] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.024553] fuse init (API version 7.11)
[    1.024812] msgmni has been set to 11777
[    1.025116] alg: No test for stdrng (krng)
[    1.025170] io scheduler noop registered
[    1.025224] io scheduler anticipatory registered
[    1.025262] io scheduler deadline registered
[    1.025385] io scheduler cfq registered (default)
[    1.025560] pci 0000:01:00.0: Boot video device
[    1.025676] pcieport-driver 0000:00:01.0: setting latency timer to 64
[    1.025710] pcieport-driver 0000:00:01.0: irq 24 for MSI/MSI-X
[    1.025869] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    1.025909] pcieport-driver 0000:00:1c.0: irq 25 for MSI/MSI-X
[    1.026150] pcieport-driver 0000:00:1c.5: setting latency timer to 64
[    1.026189] pcieport-driver 0000:00:1c.5: irq 26 for MSI/MSI-X
[    1.026544] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.027315] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.027810] input: Power Button (FF) as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.027859] ACPI: Power Button (FF) [PWRF]
[    1.027988] input: Power Button (CM) as 
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    1.028060] ACPI: Power Button (CM) [PWRB]
[    1.028922] ACPI: SSDT BFF7E0D0, 0235 (r1 DpgPmm  P001Ist       11 INTL 
20060113)
[    1.029398] ACPI: SSDT BFF7E9D0, 04B2 (r1  PmRef  P001Cst     3001 INTL 
20060113)
[    1.029988] Monitor-Mwait will be used to enter C-1 state
[    1.029992] Monitor-Mwait will be used to enter C-2 state
[    1.029996] Monitor-Mwait will be used to enter C-3 state
[    1.030059] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    1.030259] processor ACPI_CPU:00: registered as cooling_device0
[    1.030635] ACPI: SSDT BFF7E310, 0235 (r1 DpgPmm  P002Ist       12 INTL 
20060113)
[    1.031007] ACPI: SSDT BFF7EE90, 0085 (r1  PmRef  P002Cst     3000 INTL 
20060113)
[    1.031669] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[    1.031866] processor ACPI_CPU:01: registered as cooling_device1
[    1.032250] ACPI: SSDT BFF7E550, 0235 (r1 DpgPmm  P003Ist       12 INTL 
20060113)
[    1.032626] ACPI: SSDT BFF7EF20, 0085 (r1  PmRef  P003Cst     3000 INTL 
20060113)
[    1.033374] ACPI: CPU2 (power states: C1[C1] C2[C2] C3[C3])
[    1.033592] processor ACPI_CPU:02: registered as cooling_device2
[    1.033958] ACPI: SSDT BFF7E790, 0235 (r1 DpgPmm  P004Ist       12 INTL 
20060113)
[    1.034334] ACPI: SSDT BFF7EFB0, 0085 (r1  PmRef  P004Cst     3000 INTL 
20060113)
[    1.035083] ACPI: CPU3 (power states: C1[C1] C2[C2] C3[C3])
[    1.035279] processor ACPI_CPU:03: registered as cooling_device3
[    1.037799] XENFS: not registering filesystem on non-xen platform
[    1.072329] Linux agpgart interface v0.103
[    1.072370] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.075442] brd: module loaded
[    1.076622] loop: module loaded
[    1.076913] Fixed MDIO Bus: probed
[    1.076954] PPP generic driver version 2.4.2
[    1.077792] input: Macintosh mouse button emulation as 
/devices/virtual/input/input2
[    1.077900] Driver 'sd' needs updating - please use bus_type methods
[    1.077987] Driver 'sr' needs updating - please use bus_type methods
[    1.078138] ahci 0000:00:1f.2: version 3.0
[    1.078151] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.078223] ahci 0000:00:1f.2: irq 27 for MSI/MSI-X
[    1.078258] ahci: SSS flag set, parallel bus scan disabled
[    1.078323] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f 
impl SATA mode
[    1.078372] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp 
pio slum part ems 
[    1.078422] ahci 0000:00:1f.2: setting latency timer to 64
[    1.078731] scsi0 : ahci
[    1.078945] scsi1 : ahci
[    1.079140] scsi2 : ahci
[    1.079334] scsi3 : ahci
[    1.079529] scsi4 : ahci
[    1.079722] scsi5 : ahci
[    1.079946] ata1: SATA max UDMA/133 abar m2048@0xdbffe800 port 0xdbffe900 
irq 27
[    1.079996] ata2: SATA max UDMA/133 abar m2048@0xdbffe800 port 0xdbffe980 
irq 27
[    1.080047] ata3: SATA max UDMA/133 abar m2048@0xdbffe800 port 0xdbffea00 
irq 27
[    1.080095] ata4: SATA max UDMA/133 abar m2048@0xdbffe800 port 0xdbffea80 
irq 27
[    1.080143] ata5: SATA max UDMA/133 abar m2048@0xdbffe800 port 0xdbffeb00 
irq 27
[    1.080192] ata6: SATA max UDMA/133 abar m2048@0xdbffe800 port 0xdbffeb80 
irq 27
[    1.564011] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.584576] ata1.00: ATA-8: SAMSUNG HD501LJ, CR100-11, max UDMA7
[    1.584622] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    1.586632] ata1.00: configured for UDMA/133
[    1.600097] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 
PQ: 0 ANSI: 5
[    1.600405] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[    1.600463] sd 0:0:0:0: [sda] Write Protect is off
[    1.600502] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.600519] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[    1.600603] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[    1.600659] sd 0:0:0:0: [sda] Write Protect is off
[    1.600698] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.600715] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[    1.600765]  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 > sda3
[    1.688136] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.688328] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.168014] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.168896] ata2.00: ATA-7: ST3300831AS, 3.02, max UDMA/133
[    2.168942] ata2.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.169860] ata2.00: configured for UDMA/133
[    2.184074] scsi 1:0:0:0: Direct-Access     ATA      ST3300831AS      3.02 
PQ: 0 ANSI: 5
[    2.184373] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors: (300 
GB/279 GiB)
[    2.184431] sd 1:0:0:0: [sdb] Write Protect is off
[    2.184470] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.184489] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[    2.184582] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors: (300 
GB/279 GiB)
[    2.184638] sd 1:0:0:0: [sdb] Write Protect is off
[    2.184677] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.184694] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[    2.184744]  sdb: sdb1 sdb2
[    2.204445] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.204628] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.524011] ata3: SATA link down (SStatus 0 SControl 300)
[    3.024009] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.025187] ata4.00: ATAPI: HL-DT-STDVD-RAM GH22NS30, 1.01, max UDMA/100
[    3.026671] ata4.00: configured for UDMA/100
[    3.041104] scsi 3:0:0:0: CD-ROM            HL-DT-ST DVD-RAM GH22NS30 1.01 
PQ: 0 ANSI: 5
[    3.044436] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 
cdda tray
[    3.044489] Uniform CD-ROM driver Revision: 3.20
[    3.044690] sr 3:0:0:0: Attached scsi CD-ROM sr0
[    3.044801] sr 3:0:0:0: Attached scsi generic sg2 type 5
[    3.364011] ata5: SATA link down (SStatus 0 SControl 300)
[    3.700010] ata6: SATA link down (SStatus 0 SControl 300)
[    3.718635] usbcore: registered new interface driver libusual
[    3.718778] usbcore: registered new interface driver usbserial
[    3.718866] USB Serial support registered for generic
[    3.718954] usbcore: registered new interface driver usbserial_generic
[    3.718994] usbserial: USB Serial Driver core
[    3.719228] PNP: No PS/2 controller found. Probing ports directly.
[    3.722022] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.722064] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.741590] mice: PS/2 mouse device common for all mice
[    3.789660] rtc_cmos 00:03: RTC can wake from S4
[    3.789765] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    3.789823] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    3.790062] device-mapper: uevent: version 1.0.3
[    3.790290] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: 
dm-devel@redhat.com
[    3.790663] device-mapper: multipath: version 1.0.5 loaded
[    3.790703] device-mapper: multipath round-robin: version 1.0.0 loaded
[    3.791858] cpuidle: using governor ladder
[    3.793421] cpuidle: using governor menu
[    3.793545] Marking TSC unstable due to TSC halts in idle
[    3.793877] TCP cubic registered
[    3.794203] NET: Registered protocol family 10
[    3.794590] lo: Disabled Privacy Extensions
[    3.794837] NET: Registered protocol family 17
[    3.794936] Bluetooth: L2CAP ver 2.11
[    3.794979] Bluetooth: L2CAP socket layer initialized
[    3.795019] Bluetooth: SCO (Voice Link) ver 0.6
[    3.795057] Bluetooth: SCO socket layer initialized
[    3.795152] Bluetooth: RFCOMM socket layer initialized
[    3.795209] Bluetooth: RFCOMM TTY layer initialized
[    3.795247] Bluetooth: RFCOMM ver 1.10
[    3.797015] registered taskstats version 1
[    3.797149]   Magic number: 1:925:729
[    3.797266] rtc_cmos 00:03: setting system clock to 2009-03-16 10:43:34 UTC 
(1237200214)
[    3.797321] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    3.797360] EDD information not available.
[    3.797424] Freeing unused kernel memory: 544k freed
[    3.797579] Write protecting the kernel read-only data: 6668k
[    3.997729] uhci_hcd: USB Universal Host Controller Interface driver
[    3.997838] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 
16
[    3.997885] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    3.997887] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    3.997994] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus 
number 1
[    3.998074] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000c800
[    3.998181] usb usb1: configuration #1 chosen from 1 choice
[    3.998239] hub 1-0:1.0: USB hub found
[    3.998282] hub 1-0:1.0: 2 ports detected
[    3.998388] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 
21
[    3.998437] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    3.998439] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    3.998509] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus 
number 2
[    3.998581] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000c880
[    3.998672] usb usb2: configuration #1 chosen from 1 choice
[    3.998728] hub 2-0:1.0: USB hub found
[    3.998769] hub 2-0:1.0: 2 ports detected
[    3.998860] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 18 (level, low) -> IRQ 
18
[    3.998905] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[    3.998907] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    3.998975] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus 
number 3
[    3.999047] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000cc00
[    3.999137] usb usb3: configuration #1 chosen from 1 choice
[    3.999192] hub 3-0:1.0: USB hub found
[    3.999232] hub 3-0:1.0: 2 ports detected
[    3.999322] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 
23
[    3.999366] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.999368] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    3.999438] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus 
number 4
[    3.999508] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000c080
[    3.999597] usb usb4: configuration #1 chosen from 1 choice
[    3.999651] hub 4-0:1.0: USB hub found
[    3.999692] hub 4-0:1.0: 2 ports detected
[    3.999777] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 
19
[    3.999822] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    3.999824] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    3.999895] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus 
number 5
[    3.999965] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000c400
[    4.000062] usb usb5: configuration #1 chosen from 1 choice
[    4.000116] hub 5-0:1.0: USB hub found
[    4.000157] hub 5-0:1.0: 2 ports detected
[    4.000244] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 
18
[    4.000288] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    4.000290] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    4.000359] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus 
number 6
[    4.000424] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000c480
[    4.000512] usb usb6: configuration #1 chosen from 1 choice
[    4.000566] hub 6-0:1.0: USB hub found
[    4.000606] hub 6-0:1.0: 2 ports detected
[    4.002858] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.002899] Warning! ehci_hcd should always be loaded before uhci_hcd and 
ohci_hcd, not after
[    4.002963] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 
18
[    4.003032] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    4.003034] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    4.003708] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus 
number 7
[    4.007666] ehci_hcd 0000:00:1a.7: debug port 1
[    4.007709] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    4.007713] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xdbfffc00
[    4.013263] ATL1E 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    4.013311] ATL1E 0000:02:00.0: setting latency timer to 64
[    4.021511] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    4.021599] usb usb7: configuration #1 chosen from 1 choice
[    4.021659] hub 7-0:1.0: USB hub found
[    4.021701] hub 7-0:1.0: 6 ports detected
[    4.021803] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 
23
[    4.021851] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    4.021853] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    4.021924] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus 
number 8
[    4.025855] ehci_hcd 0000:00:1d.7: debug port 1
[    4.025896] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    4.025901] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xdbfff800
[    4.038029] ohci1394 0000:04:03.0: PCI INT A -> GSI 19 (level, low) -> IRQ 
19
[    4.041509] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    4.041605] usb usb8: configuration #1 chosen from 1 choice
[    4.041662] hub 8-0:1.0: USB hub found
[    4.041702] hub 8-0:1.0: 6 ports detected
[    4.095537] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[19]  
MMIO=[febbf000-febbf7ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
[    5.041543] usb 4-1: new full speed USB device using uhci_hcd and address 2
[    5.209696] usb 4-1: configuration #1 chosen from 1 choice
[    5.211660] hub 4-1:1.0: USB hub found
[    5.213594] hub 4-1:1.0: 4 ports detected
[    5.372136] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001e8c0001920cd1]
[    5.457555] usb 4-2: new full speed USB device using uhci_hcd and address 3
[    5.500050] Clocksource tsc unstable (delta = -101317082 ns)
[    5.580055] usb 4-2: device descriptor read/64, error -71
[    5.804046] usb 4-2: device descriptor read/64, error -71
[    6.020055] usb 4-2: new full speed USB device using uhci_hcd and address 4
[    6.140043] usb 4-2: device descriptor read/64, error -71
[    6.364044] usb 4-2: device descriptor read/64, error -71
[    6.637546] usb 4-2: new full speed USB device using uhci_hcd and address 5
[    7.052045] usb 4-2: device not accepting address 5, error -71
[    7.164042] usb 4-2: new full speed USB device using uhci_hcd and address 6
[    7.572053] usb 4-2: device not accepting address 6, error -71
[    7.572103] hub 4-0:1.0: unable to enumerate USB device on port 2
[    7.812054] usb 5-1: new full speed USB device using uhci_hcd and address 2
[    8.094165] usb 5-1: configuration #1 chosen from 1 choice
[    8.336060] usb 5-2: new low speed USB device using uhci_hcd and address 3
[    8.511122] usb 5-2: configuration #1 chosen from 1 choice
[    8.521946] usbcore: registered new interface driver hiddev
[    8.541766] input: Logitech USB RECEIVER as 
/devices/pci0000:00/0000:00:1d.1/usb5/5-2/5-2:1.0/input/input3
[    8.577467] generic-usb 0003:046D:C50E.0001: input,hidraw0: USB HID v1.11 
Mouse [Logitech USB RECEIVER] on usb-0000:00:1d.1-2/input0
[    8.577533] usbcore: registered new interface driver usbhid
[    8.578062] usbhid: v2.6:USB HID core driver
[    8.752542] usb 6-1: new full speed USB device using uhci_hcd and address 2
[    8.924576] usb 6-1: configuration #1 chosen from 1 choice
[    9.164044] usb 6-2: new low speed USB device using uhci_hcd and address 3
[    9.333578] usb 6-2: configuration #1 chosen from 1 choice
[    9.409613] usb 4-1.4: new low speed USB device using uhci_hcd and address 
7
[    9.454906] kjournald starting.  Commit interval 5 seconds
[    9.454940] EXT3-fs: mounted filesystem with ordered data mode.
[    9.550666] usb 4-1.4: configuration #1 chosen from 1 choice
[    9.577301] input: CHESEN PS2 to USB Converter as 
/devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.4/4-1.4:1.0/input/input4
[    9.601104] generic-usb 0003:0A81:0205.0002: input,hidraw1: USB HID v1.10 
Keyboard [CHESEN PS2 to USB Converter] on usb-0000:00:1d.0-1.4/input0
[    9.624878] input: CHESEN PS2 to USB Converter as 
/devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.4/4-1.4:1.1/input/input5
[    9.665070] generic-usb 0003:0A81:0205.0003: input,hidraw2: USB HID v1.10 
Mouse [CHESEN PS2 to USB Converter] on usb-0000:00:1d.0-1.4/input1
[   14.524237] udevd version 124 started
[   14.862021] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   15.303797] nvidia: module license 'NVIDIA' taints kernel.
[   15.555312] nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   15.555376] nvidia 0000:01:00.0: setting latency timer to 64
[   15.555757] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  180.11  Wed Nov 
26 10:53:43 PST 2008
[   15.638297] iTCO_vendor_support: vendor-support=0
[   15.688891] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
[   15.689045] iTCO_wdt: Found a ICH10R TCO device (Version=2, TCOBASE=0x0860)
[   15.689160] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   15.793429] Linux video capture interface: v2.00
[   15.799908] pwc: Philips webcam module version 10.0.13 loaded.
[   15.799955] pwc: Supports Philips PCA645/646, PCVC675/680/690, 
PCVC720[40]/730/740/750 & PCVC830/840.
[   15.800011] pwc: Also supports the Askey VC010, various Logitech Quickcams, 
Samsung MPC-C10 and MPC-C30,
[   15.800073] pwc: the Creative WebCam 5 & Pro Ex, SOTEC Afina Eye and 
Visionite VCS-UC300 and VCS-UM100.
[   15.800143] pwc: Logitech QuickCam 4000 Pro USB webcam detected.
[   15.800230] pwc: Registered as /dev/video0.
[   15.803099] usbcore: registered new interface driver Philips webcam
[   15.911617] Echoaudio Mia 0000:04:02.0: PCI INT A -> GSI 18 (level, low) -> 
IRQ 18
[   15.911729] Echoaudio Mia 0000:04:02.0: firmware: requesting ea/mia_dsp.fw
[   15.957024] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 
22
[   15.957146] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   15.976269] Echoaudio Mia 0000:04:02.0: firmware: requesting 
ea/loader_dsp.fw
[   16.012374] Card registered: Mia rev.1 (DSP56361) at 0xfea00000 irq 18
[   16.206411] usbcore: registered new interface driver snd-usb-audio
[   16.468106] lp: driver loaded but no devices found
[   16.512057] coretemp coretemp.0: Using relative temperature scale!
[   16.512127] coretemp coretemp.1: Using relative temperature scale!
[   16.512208] coretemp coretemp.2: Using relative temperature scale!
[   16.512323] coretemp coretemp.3: Using relative temperature scale!
[   16.527668] w83627ehf: Found W83627EHG chip at 0x290
[   16.527728] ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI 
region HWRE [0x290-0x299]
[   16.527778] ACPI: Device needs an ACPI driver
[   16.692652] Adding 6562544k swap on /dev/sda3.  Priority:-1 extents:1 
across:6562544k 
[   17.138301] EXT3 FS on sda8, internal journal
[   18.515652] kjournald starting.  Commit interval 5 seconds
[   18.515870] EXT3 FS on sda5, internal journal
[   18.515875] EXT3-fs: mounted filesystem with ordered data mode.
[   18.674401] kjournald starting.  Commit interval 5 seconds
[   18.674628] EXT3 FS on sda7, internal journal
[   18.674633] EXT3-fs: mounted filesystem with ordered data mode.
[   18.698835] kjournald starting.  Commit interval 5 seconds
[   18.699050] EXT3 FS on sda9, internal journal
[   18.699055] EXT3-fs: mounted filesystem with ordered data mode.
[   18.716537] kjournald starting.  Commit interval 5 seconds
[   18.716546] EXT3-fs: mounted filesystem with ordered data mode.
[   18.985365] kjournald starting.  Commit interval 5 seconds
[   18.993825] EXT3 FS on sdb2, internal journal
[   18.993830] EXT3-fs: mounted filesystem with ordered data mode.
[   19.287858] ip_tables: (C) 2000-2006 Netfilter Core Team
[   20.985514] warning: `avahi-daemon' uses 32-bit capabilities (legacy 
support in use)
[   23.459492] ppdev: user-space parallel port driver
[   28.737123] vboxdrv: Trying to deactivate the NMI watchdog permanently...
[   28.737126] vboxdrv: Successfully done.
[   28.737128] vboxdrv: Found 4 processor cores.
[   28.737177] VBoxDrv: dbg - g_abExecMemory=ffffffffa0a06aa0
[   28.737214] vboxdrv: fAsync=1 offMin=0x1a1b2 offMax=0x1a1b2
[   28.737258] vboxdrv: TSC mode is 'asynchronous', kernel timer mode is 
'normal'.
[   28.737260] vboxdrv: Successfully loaded version 2.1.4 (interface 
0x000a0009).
[   28.943758] VBoxNetFlt: dbg - g_abExecMemory=ffffffffa0ba3960
[   31.020231] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   31.020234] Bluetooth: BNEP filters: protocol multicast
[   31.044102] Bridge firewalling registered
[   32.917828] IRQ 16/nvidia: IRQF_DISABLED is not guaranteed on shared IRQs
[   35.129421] ATL1E 0000:02:00.0: irq 28 for MSI/MSI-X
[   35.129562] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<1000 Mbps Full 
Duplex>
[   35.130727] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   35.131980] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   36.890675] RPC: Registered udp transport module.
[   36.890678] RPC: Registered tcp transport module.
[   45.780028] eth0: no IPv6 routers present
[   93.576251] ata1.00: exception Emask 0x2 SAct 0x1 SErr 0x3000400 action 0x6
[   93.576301] ata1.00: irq_stat 0x45000008
[   93.576345] ata1: SError: { Proto TrStaTrns UnrecFIS }
[   93.576393] ata1.00: cmd 60/00:00:4a:b6:60/02:00:0c:00:00/40 tag 0 ncq 
262144 in
[   93.576394]          res 51/84:00:4a:b6:60/4e:00:0c:00:00/40 Emask 0x412 
(ATA bus error) <F>
[   93.576502] ata1.00: status: { DRDY ERR }
[   93.576546] ata1.00: error: { ICRC ABRT }
[   93.576593] ata1: hard resetting link
[   94.060055] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   94.064100] ata1.00: configured for UDMA/133
[   94.064110] ata1: EH complete
[   94.064170] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[   94.064188] sd 0:0:0:0: [sda] Write Protect is off
[   94.064190] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   94.064213] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[   94.454991] ata1.00: exception Emask 0x2 SAct 0x1 SErr 0x3000400 action 0x6
[   94.455041] ata1.00: irq_stat 0x45000008
[   94.455085] ata1: SError: { Proto TrStaTrns UnrecFIS }
[   94.455133] ata1.00: cmd 60/80:00:6a:2c:b1/01:00:04:00:00/40 tag 0 ncq 
196608 in
[   94.455134]          res 51/84:00:6a:2c:b1/4e:00:04:00:00/40 Emask 0x412 
(ATA bus error) <F>
[   94.455241] ata1.00: status: { DRDY ERR }
[   94.455285] ata1.00: error: { ICRC ABRT }
[   94.455332] ata1: hard resetting link
[   94.936080] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   94.945179] ata1.00: configured for UDMA/133
[   94.945188] ata1: EH complete
[   94.945254] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[   94.945273] sd 0:0:0:0: [sda] Write Protect is off
[   94.945276] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   94.945300] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[   96.162692] ata1.00: exception Emask 0x2 SAct 0x8000 SErr 0x3000400 action 
0x6
[   96.162749] ata1.00: irq_stat 0x45000008
[   96.162793] ata1: SError: { Proto TrStaTrns UnrecFIS }
[   96.162842] ata1.00: cmd 60/78:78:62:40:b1/01:00:04:00:00/40 tag 15 ncq 
192512 in
[   96.162843]          res 51/84:78:62:40:b1/4e:0b:04:00:00/40 Emask 0x412 
(ATA bus error) <F>
[   96.162951] ata1.00: status: { DRDY ERR }
[   96.162995] ata1.00: error: { ICRC ABRT }
[   96.163042] ata1: hard resetting link
[   96.644047] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   96.666697] ata1.00: configured for UDMA/133
[   96.666704] ata1: EH complete
[   96.666755] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[   96.666773] sd 0:0:0:0: [sda] Write Protect is off
[   96.666776] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   96.666799] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[   96.759599] ata1: limiting SATA link speed to 1.5 Gbps
[   96.759603] ata1.00: exception Emask 0x2 SAct 0x1 SErr 0x3000400 action 0x6
[   96.759650] ata1.00: irq_stat 0x45000008
[   96.759693] ata1: SError: { Proto TrStaTrns UnrecFIS }
[   96.759741] ata1.00: cmd 60/00:00:4a:4e:6f/02:00:04:00:00/40 tag 0 ncq 
262144 in
[   96.759742]          res 51/84:00:4a:4e:6f/4e:00:04:00:00/40 Emask 0x412 
(ATA bus error) <F>
[   96.759851] ata1.00: status: { DRDY ERR }
[   96.759894] ata1.00: error: { ICRC ABRT }
[   96.759941] ata1: hard resetting link
[   97.240098] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   97.255832] ata1.00: configured for UDMA/133
[   97.255841] ata1: EH complete
[   97.255896] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[   97.255912] sd 0:0:0:0: [sda] Write Protect is off
[   97.255914] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   97.255937] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[   97.290164] ata1.00: exception Emask 0x2 SAct 0x1 SErr 0x3000400 action 0x6
[   97.290219] ata1.00: irq_stat 0x45000008
[   97.290262] ata1: SError: { Proto TrStaTrns UnrecFIS }
[   97.290309] ata1.00: cmd 60/00:00:4a:50:6f/02:00:04:00:00/40 tag 0 ncq 
262144 in
[   97.290310]          res 51/84:00:4a:50:6f/4e:00:04:00:00/40 Emask 0x412 
(ATA bus error) <F>
[   97.290418] ata1.00: status: { DRDY ERR }
[   97.290462] ata1.00: error: { ICRC ABRT }
[   97.290508] ata1: hard resetting link
[   97.773546] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   97.796137] ata1.00: configured for UDMA/133
[   97.796152] ata1: EH complete
[   97.796216] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[   97.796235] sd 0:0:0:0: [sda] Write Protect is off
[   97.796237] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   97.796260] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[   98.658005] ata1.00: exception Emask 0x2 SAct 0x1 SErr 0x3000400 action 0x6
[   98.658061] ata1.00: irq_stat 0x45000008
[   98.658105] ata1: SError: { Proto TrStaTrns UnrecFIS }
[   98.658154] ata1.00: cmd 60/48:00:d2:20:6b/01:00:04:00:00/40 tag 0 ncq 
167936 in
[   98.658155]          res 51/84:00:d2:20:6b/4e:00:04:00:00/40 Emask 0x412 
(ATA bus error) <F>
[   98.658263] ata1.00: status: { DRDY ERR }
[   98.658306] ata1.00: error: { ICRC ABRT }
[   98.658353] ata1: hard resetting link
[  104.180057] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  104.190202] ata1.00: configured for UDMA/133
[  104.190210] ata1: EH complete
[  104.190260] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[  104.190285] sd 0:0:0:0: [sda] Write Protect is off
[  104.190287] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  104.190311] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[  586.943468] attempt to access beyond end of device
[  586.943472] sda8: rw=0, want=13616349448, limit=58605057
[  586.943475] attempt to access beyond end of device
[  586.943477] sda8: rw=0, want=15621368680, limit=58605057
[  586.943480] attempt to access beyond end of device
[  586.943482] sda8: rw=0, want=9036237064, limit=58605057
[  586.943485] attempt to access beyond end of device
[  586.943487] sda8: rw=0, want=13304482384, limit=58605057
[  586.943489] attempt to access beyond end of device
[  586.943491] sda8: rw=0, want=13079087944, limit=58605057
[  586.943494] attempt to access beyond end of device
[  586.943496] sda8: rw=0, want=15354012448, limit=58605057
[  586.943499] attempt to access beyond end of device
[  586.943500] sda8: rw=0, want=15359083424, limit=58605057
[  586.943503] attempt to access beyond end of device
[  586.943505] sda8: rw=0, want=13338611976, limit=58605057
[  586.943508] attempt to access beyond end of device
[  586.943510] sda8: rw=0, want=13075979104, limit=58605057
[  586.943512] attempt to access beyond end of device
[  586.943514] sda8: rw=0, want=13572981664, limit=58605057
[  586.943517] attempt to access beyond end of device
[  586.943519] sda8: rw=0, want=15083445152, limit=58605057
[  586.943521] attempt to access beyond end of device
[  586.943523] sda8: rw=0, want=4300446512, limit=58605057
[  586.943528] attempt to access beyond end of device
[  586.943530] sda8: rw=0, want=4347488520, limit=58605057
[  586.943532] attempt to access beyond end of device
[  586.943534] sda8: rw=0, want=13079478536, limit=58605057
[  586.943537] attempt to access beyond end of device
[  586.943539] sda8: rw=0, want=13036104560, limit=58605057
[  586.943541] attempt to access beyond end of device
[  586.943543] sda8: rw=0, want=15592915872, limit=58605057
[  586.943546] attempt to access beyond end of device
[  586.943548] sda8: rw=0, want=5932034312, limit=58605057
[  586.943550] attempt to access beyond end of device
[  586.943552] sda8: rw=0, want=14548703496, limit=58605057
[  586.943555] attempt to access beyond end of device
[  586.943557] sda8: rw=0, want=4355988272, limit=58605057
[  586.943558] attempt to access beyond end of device
[  586.943560] sda8: rw=0, want=14153380784, limit=58605057
[  586.943576] attempt to access beyond end of device
[  586.943578] sda8: rw=0, want=15091304712, limit=58605057
[  586.943581] attempt to access beyond end of device
[  586.943583] sda8: rw=0, want=6233983792, limit=58605057
[  586.943585] attempt to access beyond end of device
[  586.943587] sda8: rw=0, want=4355876952, limit=58605057
[  586.943590] attempt to access beyond end of device
[  586.943592] sda8: rw=0, want=4358605680, limit=58605057
[  586.943594] attempt to access beyond end of device
[  586.943596] sda8: rw=0, want=15720459032, limit=58605057
[  586.943599] attempt to access beyond end of device
[  586.943601] sda8: rw=0, want=4347603872, limit=58605057
[  586.943605] attempt to access beyond end of device
[  586.943607] sda8: rw=0, want=16297194368, limit=58605057
[  586.943610] attempt to access beyond end of device
[  586.943611] sda8: rw=0, want=13610760456, limit=58605057
[  586.943614] attempt to access beyond end of device
[  586.943616] sda8: rw=0, want=15361704824, limit=58605057
[  586.943619] attempt to access beyond end of device
[  586.943621] sda8: rw=0, want=14556033808, limit=58605057
[  586.943624] attempt to access beyond end of device
[  586.943626] sda8: rw=0, want=14819238672, limit=58605057
[  586.943628] attempt to access beyond end of device
[  586.943630] sda8: rw=0, want=4311839552, limit=58605057
[  586.943633] attempt to access beyond end of device
[  586.943634] sda8: rw=0, want=6755068576, limit=58605057
[  586.943637] attempt to access beyond end of device
[  586.943639] sda8: rw=0, want=4355475720, limit=58605057
[  586.943642] attempt to access beyond end of device
[  586.943644] sda8: rw=0, want=13617054512, limit=58605057
[  586.943646] attempt to access beyond end of device
[  586.943648] sda8: rw=0, want=13474931576, limit=58605057
[  586.943650] attempt to access beyond end of device
[  586.943652] sda8: rw=0, want=4353401096, limit=58605057
[  586.943655] attempt to access beyond end of device
[  586.943657] sda8: rw=0, want=4353401096, limit=58605057
[  589.059606] attempt to access beyond end of device
[  589.059611] sda8: rw=0, want=4353401096, limit=58605057
----- end dmesg -----

----- begin lspci -----
00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA AHCI 
Controller (prog-if 01)
        Subsystem: ASUSTeK Computer Inc. Device 82d4                                               
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0                                                                                            
        Interrupt: pin B routed to IRQ 27                                                                     
        Region 0: I/O ports at bc00 [size=8]                                                                  
        Region 1: I/O ports at b880 [size=4]                                                                  
        Region 2: I/O ports at b800 [size=8]                                                                  
        Region 3: I/O ports at b480 [size=4]                                                                  
        Region 4: I/O ports at b400 [size=32]                                                                 
        Region 5: Memory at dbffe800 (32-bit, non-prefetchable) [size=2K]                                     
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- 
Queue=0/4 Enable+                       
                Address: fee0f00c  Data: 4179                                                                 
        Capabilities: [70] Power Management version 3                                                         
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)                    
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-                                                   
        Capabilities: [a8] SATA HBA <?>                                                                       
        Capabilities: [b0] Vendor Specific Information <?>                                                    
        Kernel driver in use: ahci                                                                            
----- end lspci -----

----- begin hdparm -----
/dev/sda:

ATA device, with non-removable media
	Model Number:       SAMSUNG HD501LJ                         
	Firmware Revision:  CR100-11
	Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions, SATA Rev 
2.5

/dev/sdb:

ATA device, with non-removable media
	Model Number:       ST3300831AS                             
	Firmware Revision:  3.02    
----- end hdparm -----

