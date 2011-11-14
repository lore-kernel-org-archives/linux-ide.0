From: Arkadiusz =?utf-8?q?Mi=C5=9Bkiewicz?= <a.miskiewicz@gmail.com>
Subject: suspend & resume on battery and ahci device goes down from 3Gbps to 1.5Gbps
Date: Mon, 14 Nov 2011 22:22:18 +0100
Message-ID: <201111142222.19052.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65074 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab1KNVW2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Nov 2011 16:22:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

I have a problem on thinkpad t400 (currently on Linus git master but it=
 happens
for quite long time on older kernels; didn't care earlier, so have no s=
olid data for
older kernels).

When I make suspend and resume while being on battery then sometimes di=
sk link
speed gets down from 3Gbps to 1.5Gbps. I tried to reproduce that while =
being
on regular power but failed after several tries - it stays at 3Gbps. Wh=
ile being
on battery after 1-3 suspend & resume cycles I'm down at 1.5Gbps.

What's worse is that I never can go back to 3Gbps by doing only suspend
& resume cycles. I have to reboot whole notebook to get 3Gbps back.

Disk is OCZ-VERTEX2 SSD drive. Controller is:
00:1f.2 SATA controller [0106]: Intel Corporation ICH9M/M-E SATA AHCI C=
ontroller [8086:2929] (rev 03)

So two issues:
1) it goes down to 1.5Gbps with suspend/resume while being on battery
2) it doesn't go back to 3Gbps=20

Any ideas?

Below is dmesg when on battery. I have another dmesg, with mixed on pow=
er and on battery
suspend and resumes - http://ixion.pld-linux.org/~arekm/dmesg-1.5Gbps.t=
xt

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-rc1-00306-g7f80850-dirty (arekm@ixio=
n-pld) (gcc version 4.6.2 20111111 (release) (PLD-Linux) ) #148 SMP PRE=
EMPT Mon Nov 14 21:34:06 CET 2011
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.2.0 root=3D/dev/ma=
pper/lrootfs ro resume=3D/dev/sda2 panic=3D60 reboot=3Dacpi
[    0.000000] Disabled fast string operations
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
[    0.000000]  BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserve=
d)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bd4a1000 (usable)
[    0.000000]  BIOS-e820: 00000000bd4a1000 - 00000000bd4a7000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000bd4a7000 - 00000000bd5b7000 (usable)
[    0.000000]  BIOS-e820: 00000000bd5b7000 - 00000000bd60f000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000bd60f000 - 00000000bd6c6000 (usable)
[    0.000000]  BIOS-e820: 00000000bd6c6000 - 00000000bd6d1000 (ACPI NV=
S)
[    0.000000]  BIOS-e820: 00000000bd6d1000 - 00000000bd6d4000 (ACPI da=
ta)
[    0.000000]  BIOS-e820: 00000000bd6d4000 - 00000000bd6d8000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000bd6d8000 - 00000000bd6dc000 (ACPI NV=
S)
[    0.000000]  BIOS-e820: 00000000bd6dc000 - 00000000bd6df000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000bd6df000 - 00000000bd706000 (ACPI NV=
S)
[    0.000000]  BIOS-e820: 00000000bd706000 - 00000000bd708000 (ACPI da=
ta)
[    0.000000]  BIOS-e820: 00000000bd708000 - 00000000bd90f000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000bd90f000 - 00000000bd99f000 (ACPI NV=
S)
[    0.000000]  BIOS-e820: 00000000bd99f000 - 00000000bd9ff000 (ACPI da=
ta)
[    0.000000]  BIOS-e820: 00000000bd9ff000 - 00000000bda00000 (usable)
[    0.000000]  BIOS-e820: 00000000bdc00000 - 00000000c0000000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed14000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fed18000 - 00000000fed1a000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserve=
d)
[    0.000000]  BIOS-e820: 0000000100000000 - 000000013c000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI present.
[    0.000000] DMI: LENOVO 2764CTO/2764CTO, BIOS 7UET91WW (3.21 ) 12/06=
/2010
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (=
usable) =3D=3D> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (=
usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn =3D 0x13c000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 13C000000 mask FFC000000 uncachable
[    0.000000]   1 base 0BE000000 mask FFE000000 uncachable
[    0.000000]   2 base 000000000 mask F80000000 write-back
[    0.000000]   3 base 080000000 mask FC0000000 write-back
[    0.000000]   4 base 100000000 mask FC0000000 write-back
[    0.000000]   5 base 0BDE00000 mask FFFE00000 uncachable
[    0.000000]   6 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x70106=
00070106
[    0.000000] e820 update range: 00000000bde00000 - 0000000100000000 (=
usable) =3D=3D> (reserved)
[    0.000000] last_pfn =3D 0xbda00 max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000f6480] f6480
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size =
20480
[    0.000000] init_memory_mapping: 0000000000000000-00000000bda00000
[    0.000000]  0000000000 - 00bda00000 page 2M
[    0.000000] kernel direct mapping tables up to bda00000 @ 1fffc000-2=
0000000
[    0.000000] init_memory_mapping: 0000000100000000-000000013c000000
[    0.000000]  0100000000 - 013c000000 page 2M
[    0.000000] kernel direct mapping tables up to 13c000000 @ bd6c0000-=
bd6c6000
[    0.000000] RAMDISK: 37d90000 - 37ec0000
[    0.000000] ACPI: RSDP 00000000000f6440 00024 (v02 LENOVO)
[    0.000000] ACPI: XSDT 00000000bd949b5a 0009C (v01 LENOVO TP-7U    0=
0003210  LTP 00000000)
[    0.000000] ACPI: FACP 00000000bd949d00 000F4 (v03 LENOVO TP-7U    0=
0003210 LNVO 00000001)
[    0.000000] ACPI: DSDT 00000000bd94a10e 0FAE1 (v01 LENOVO TP-7U    0=
0003210 MSFT 03000000)
[    0.000000] ACPI: FACS 00000000bd98e000 00040
[    0.000000] ACPI: SSDT 00000000bd949eb4 0025A (v01 LENOVO TP-7U    0=
0003210 MSFT 03000000)
[    0.000000] ACPI: ECDT 00000000bd959bef 00052 (v01 LENOVO TP-7U    0=
0003210 LNVO 00000001)
[    0.000000] ACPI: APIC 00000000bd959c41 00078 (v01 LENOVO TP-7U    0=
0003210 LNVO 00000001)
[    0.000000] ACPI: MCFG 00000000bd959cb9 0003C (v01 LENOVO TP-7U    0=
0003210 LNVO 00000001)
[    0.000000] ACPI: HPET 00000000bd959cf5 00038 (v01 LENOVO TP-7U    0=
0003210 LNVO 00000001)
[    0.000000] ACPI: SLIC 00000000bd959dc2 00176 (v01 LENOVO TP-7U    0=
0003210  LTP 00000000)
[    0.000000] ACPI: BOOT 00000000bd959f38 00028 (v01 LENOVO TP-7U    0=
0003210  LTP 00000001)
[    0.000000] ACPI: ASF! 00000000bd959f60 000A0 (v16 LENOVO TP-7U    0=
0003210 PTL  00000001)
[    0.000000] ACPI: SSDT 00000000bd98d1fa 00568 (v01 LENOVO TP-7U    0=
0003210 INTL 20050513)
[    0.000000] ACPI: TCPA 00000000bd707000 00032 (v00                 0=
0000000      00000000)
[    0.000000] ACPI: DMAR 00000000bd706000 00120 (v01               ? 0=
0000001      00000000)
[    0.000000] ACPI: SSDT 00000000bd6d3000 00655 (v01  PmRef    CpuPm 0=
0003000 INTL 20050624)
[    0.000000] ACPI: SSDT 00000000bd6d2000 00274 (v01  PmRef  Cpu0Tst 0=
0003000 INTL 20050624)
[    0.000000] ACPI: SSDT 00000000bd6d1000 00242 (v01  PmRef    ApTst 0=
0003000 INTL 20050624)
[    0.000000] ACPI: DMI detected: Lenovo ThinkPad T400
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea0004ffffff] PMD -> [ffff8801376=
00000-ffff88013b5fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0013c000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x000bd4a1
[    0.000000]     0: 0x000bd4a7 -> 0x000bd5b7
[    0.000000]     0: 0x000bd60f -> 0x000bd6c6
[    0.000000]     0: 0x000bd9ff -> 0x000bda00
[    0.000000]     0: 0x00100000 -> 0x0013c000
[    0.000000] On node 0 totalpages: 1021431
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3913 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 16320 pages used for memmap
[    0.000000]   DMA32 zone: 755369 pages, LIFO batch:31
[    0.000000]   Normal zone: 3840 pages used for memmap
[    0.000000]   Normal zone: 241920 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GS=
I 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high lev=
el)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] 4 Processors exceeds NR_CPUS limit of 2
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 0000000=
00009f000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 0000000=
0000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 0000000=
0000dc000
[    0.000000] PM: Registered nosave memory: 00000000000dc000 - 0000000=
000100000
[    0.000000] PM: Registered nosave memory: 00000000bd4a1000 - 0000000=
0bd4a7000
[    0.000000] PM: Registered nosave memory: 00000000bd5b7000 - 0000000=
0bd60f000
[    0.000000] PM: Registered nosave memory: 00000000bd6c6000 - 0000000=
0bd6d1000
[    0.000000] PM: Registered nosave memory: 00000000bd6d1000 - 0000000=
0bd6d4000
[    0.000000] PM: Registered nosave memory: 00000000bd6d4000 - 0000000=
0bd6d8000
[    0.000000] PM: Registered nosave memory: 00000000bd6d8000 - 0000000=
0bd6dc000
[    0.000000] PM: Registered nosave memory: 00000000bd6dc000 - 0000000=
0bd6df000
[    0.000000] PM: Registered nosave memory: 00000000bd6df000 - 0000000=
0bd706000
[    0.000000] PM: Registered nosave memory: 00000000bd706000 - 0000000=
0bd708000
[    0.000000] PM: Registered nosave memory: 00000000bd708000 - 0000000=
0bd90f000
[    0.000000] PM: Registered nosave memory: 00000000bd90f000 - 0000000=
0bd99f000
[    0.000000] PM: Registered nosave memory: 00000000bd99f000 - 0000000=
0bd9ff000
[    0.000000] PM: Registered nosave memory: 00000000bda00000 - 0000000=
0bdc00000
[    0.000000] PM: Registered nosave memory: 00000000bdc00000 - 0000000=
0c0000000
[    0.000000] PM: Registered nosave memory: 00000000c0000000 - 0000000=
0e0000000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 - 0000000=
0f0000000
[    0.000000] PM: Registered nosave memory: 00000000f0000000 - 0000000=
0fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 0000000=
0fec10000
[    0.000000] PM: Registered nosave memory: 00000000fec10000 - 0000000=
0fed00000
[    0.000000] PM: Registered nosave memory: 00000000fed00000 - 0000000=
0fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 - 0000000=
0fed14000
[    0.000000] PM: Registered nosave memory: 00000000fed14000 - 0000000=
0fed18000
[    0.000000] PM: Registered nosave memory: 00000000fed18000 - 0000000=
0fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 - 0000000=
0fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 0000000=
0fed90000
[    0.000000] PM: Registered nosave memory: 00000000fed90000 - 0000000=
0fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 0000000=
0fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 0000000=
0ff800000
[    0.000000] PM: Registered nosave memory: 00000000ff800000 - 0000000=
100000000
[    0.000000] Allocating PCI resources starting at c0000000 (gap: c000=
0000:20000000)
[    0.000000] setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 n=
r_node_ids:1
[    0.000000] PERCPU: Embedded 26 pages/cpu @ffff88013bc00000 s75136 r=
8192 d23168 u1048576
[    0.000000] pcpu-alloc: s75136 r8192 d23168 u1048576 alloc=3D1*20971=
52
[    0.000000] pcpu-alloc: [0] 0 1=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 1001202
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-3.2.0 root=3D=
/dev/mapper/lrootfs ro resume=3D/dev/sda2 panic=3D60 reboot=3Dacpi
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194=
304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 209715=
2 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 3938232k/5177344k available (3864k kernel code, =
1091620k absent, 147492k reserved, 2680k data, 488k init)
[    0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, MinObjec=
ts=3D0, CPUs=3D2, Nodes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:4352 nr_irqs:512 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 33554432 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't=
 want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2526.947 MHz processor.
[    0.004008] Calibrating delay loop (skipped), value calculated using=
 timer frequency.. 5053.89 BogoMIPS (lpj=3D10107788)
[    0.004161] pid_max: default: 32768 minimum: 301
[    0.004306] Security Framework initialized
[    0.008053] Mount-cache hash table entries: 256
[    0.008462] Initializing cgroup subsys cpuacct
[    0.008544] Initializing cgroup subsys memory
[    0.008640] Initializing cgroup subsys devices
[    0.008712] Initializing cgroup subsys freezer
[    0.008786] Initializing cgroup subsys perf_event
[    0.008931] Disabled fast string operations
[    0.009010] CPU: Physical Processor ID: 0
[    0.009082] CPU: Processor Core ID: 0
[    0.009154] mce: CPU supports 6 MCE banks
[    0.009238] CPU0: Thermal monitoring enabled (TM2)
[    0.009315] using mwait in idle threads.
[    0.009416] ACPI: Core revision 20110623
[    0.032180] DMAR: Host address width 36
[    0.032258] DMAR: DRHD base: 0x000000feb03000 flags: 0x0
[    0.032347] IOMMU 0: reg_base_addr feb03000 ver 1:0 cap c9008020e302=
60 ecap 1000
[    0.032441] DMAR: DRHD base: 0x000000feb01000 flags: 0x0
[    0.032528] IOMMU 1: reg_base_addr feb01000 ver 1:0 cap c00000206302=
60 ecap 1000
[    0.036010] DMAR: DRHD base: 0x000000feb00000 flags: 0x0
[    0.036098] IOMMU 2: reg_base_addr feb00000 ver 1:0 cap c00000206302=
70 ecap 1000
[    0.036191] DMAR: DRHD base: 0x000000feb02000 flags: 0x1
[    0.036282] IOMMU 3: reg_base_addr feb02000 ver 1:0 cap c90080206302=
60 ecap 1000
[    0.036375] DMAR: RMRR base: 0x000000fc226c00 end: 0x000000fc2273ff
[    0.036455] DMAR: RMRR base: 0x000000bdc00000 end: 0x000000bfffffff
[    0.037236] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin=
2=3D-1
[    0.077308] CPU0: Intel(R) Core(TM)2 Duo CPU     T9400  @ 2.53GHz st=
epping 06
[    0.080004] Performance Events: PEBS fmt0+, Core2 events, Intel PMU =
driver.
[    0.080004] ... version:                2
[    0.080004] ... bit width:              40
[    0.080004] ... generic registers:      2
[    0.080004] ... value mask:             000000ffffffffff
[    0.080004] ... max period:             000000007fffffff
[    0.080004] ... fixed-purpose events:   3
[    0.080004] ... event mask:             0000000700000003
[    0.104041] Booting Node   0, Processors  #1 Ok.
[    0.104170] smpboot cpu 1: start_ip =3D 99000
[    0.008000] Disabled fast string operations
[    0.200045] Brought up 2 CPUs
[    0.200192] Total of 2 processors activated (10107.92 BogoMIPS).
[    0.204148] devtmpfs: initialized
[    0.204579] PM: Registering ACPI NVS region at bd6c6000 (45056 bytes=
)
[    0.204579] PM: Registering ACPI NVS region at bd6d8000 (16384 bytes=
)
[    0.204579] PM: Registering ACPI NVS region at bd6df000 (159744 byte=
s)
[    0.204579] PM: Registering ACPI NVS region at bd90f000 (589824 byte=
s)
[    0.204602] pinctrl core: initialized pinctrl subsystem
[    0.204758] print_constraints: dummy:=20
[    0.204758] NET: Registered protocol family 16
[    0.208177] ACPI FADT declares the system doesn't support PCIe ASPM,=
 so disable it
[    0.208274] ACPI: bus type pci registered
[    0.208380] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe000=
0000-0xe3ffffff] (base 0xe0000000)
[    0.208380] PCI: MMCONFIG at [mem 0xe0000000-0xe3ffffff] reserved in=
 E820
[    0.236806] PCI: Using configuration type 1 for base access
[    0.244102] bio: create slab <bio-0> at 0
[    0.244186] ACPI: Added _OSI(Module Device)
[    0.244186] ACPI: Added _OSI(Processor Device)
[    0.244227] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.244303] ACPI: Added _OSI(Processor Aggregator Device)
[    0.244380] ACPI: Added _OSI(Linux)
[    0.251475] ACPI: EC: EC description table is found, configuring boo=
t EC
[    0.271033] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query honored via=
 DMI
[    0.292386] ACPI: SSDT 00000000bd6d6c20 002C8 (v01  PmRef  Cpu0Ist 0=
0003000 INTL 20050624)
[    0.293847] ACPI: Dynamic OEM Table Load:
[    0.294023] ACPI: SSDT           (null) 002C8 (v01  PmRef  Cpu0Ist 0=
0003000 INTL 20050624)
[    0.294657] ACPI: SSDT 00000000bd6d4020 0087A (v01  PmRef  Cpu0Cst 0=
0003001 INTL 20050624)
[    0.296218] ACPI: Dynamic OEM Table Load:
[    0.296395] ACPI: SSDT           (null) 0087A (v01  PmRef  Cpu0Cst 0=
0003001 INTL 20050624)
[    0.316794] ACPI: SSDT 00000000bd6d5ca0 001CF (v01  PmRef    ApIst 0=
0003000 INTL 20050624)
[    0.318311] ACPI: Dynamic OEM Table Load:
[    0.318488] ACPI: SSDT           (null) 001CF (v01  PmRef    ApIst 0=
0003000 INTL 20050624)
[    0.328257] ACPI: SSDT 00000000bd6d5f20 0008D (v01  PmRef    ApCst 0=
0003000 INTL 20050624)
[    0.329717] ACPI: Dynamic OEM Table Load:
[    0.329894] ACPI: SSDT           (null) 0008D (v01  PmRef    ApCst 0=
0003000 INTL 20050624)
[    0.344486] ACPI: Interpreter enabled
[    0.344567] ACPI: (supports S0 S3 S4 S5)
[    0.344891] ACPI: Using IOAPIC for interrupt routing
[    0.356381] ACPI: Power Resource [PUBS] (on)
[    0.380258] ACPI: EC: GPE =3D 0x11, I/O: command/status =3D 0x66, da=
ta =3D 0x62
[    0.384163] ACPI: ACPI Dock Station Driver: 3 docks/bays found
[    0.384245] HEST: Table not found.
[    0.384321] PCI: Using host bridge windows from ACPI; if necessary, =
use "pci=3Dnocrs" and report a bug
[    0.385038] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.385209] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0c=
f7]
[    0.385209] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xff=
ff]
[    0.385209] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-=
0x000bffff]
[    0.385209] pci_root PNP0A08:00: host bridge window [mem 0x000d0000-=
0x000d3fff]
[    0.385209] pci_root PNP0A08:00: host bridge window [mem 0x000d4000-=
0x000d7fff]
[    0.385209] pci_root PNP0A08:00: host bridge window [mem 0x000d8000-=
0x000dbfff]
[    0.385209] pci_root PNP0A08:00: host bridge window [mem 0xc0000000-=
0xfebfffff]
[    0.385209] pci 0000:00:00.0: [8086:2a40] type 0 class 0x000600
[    0.385209] DMAR: Forcing write-buffer flush capability
[    0.385209] DMAR: Disabling IOMMU for graphics on this chipset
[    0.385209] pci 0000:00:02.0: [8086:2a42] type 0 class 0x000300
[    0.385209] pci 0000:00:02.0: reg 10: [mem 0xf4400000-0xf47fffff 64b=
it]
[    0.385209] pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff 64b=
it pref]
[    0.385209] pci 0000:00:02.0: reg 20: [io  0x1800-0x1807]
[    0.385209] pci 0000:00:02.1: [8086:2a43] type 0 class 0x000380
[    0.385212] pci 0000:00:02.1: reg 10: [mem 0xf4200000-0xf42fffff 64b=
it]
[    0.385326] pci 0000:00:03.0: [8086:2a44] type 0 class 0x000780
[    0.385360] pci 0000:00:03.0: reg 10: [mem 0xfc226800-0xfc22680f 64b=
it]
[    0.385447] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.385456] pci 0000:00:03.0: PME# disabled
[    0.385568] pci 0000:00:19.0: [8086:10f5] type 0 class 0x000200
[    0.385611] pci 0000:00:19.0: reg 10: [mem 0xfc000000-0xfc01ffff]
[    0.385633] pci 0000:00:19.0: reg 14: [mem 0xfc025000-0xfc025fff]
[    0.385654] pci 0000:00:19.0: reg 18: [io  0x1840-0x185f]
[    0.385767] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.385776] pci 0000:00:19.0: PME# disabled
[    0.385823] pci 0000:00:1a.0: [8086:2937] type 0 class 0x000c03
[    0.385915] pci 0000:00:1a.0: reg 20: [io  0x1860-0x187f]
[    0.386016] pci 0000:00:1a.1: [8086:2938] type 0 class 0x000c03
[    0.386108] pci 0000:00:1a.1: reg 20: [io  0x1880-0x189f]
[    0.386208] pci 0000:00:1a.2: [8086:2939] type 0 class 0x000c03
[    0.386300] pci 0000:00:1a.2: reg 20: [io  0x18a0-0x18bf]
[    0.386418] pci 0000:00:1a.7: [8086:293c] type 0 class 0x000c03
[    0.386461] pci 0000:00:1a.7: reg 10: [mem 0xfc226c00-0xfc226fff]
[    0.386603] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.386614] pci 0000:00:1a.7: PME# disabled
[    0.386671] pci 0000:00:1b.0: [8086:293e] type 0 class 0x000403
[    0.386707] pci 0000:00:1b.0: reg 10: [mem 0xfc020000-0xfc023fff 64b=
it]
[    0.388079] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.388090] pci 0000:00:1b.0: PME# disabled
[    0.388147] pci 0000:00:1c.0: [8086:2940] type 1 class 0x000604
[    0.388278] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.388288] pci 0000:00:1c.0: PME# disabled
[    0.388349] pci 0000:00:1c.1: [8086:2942] type 1 class 0x000604
[    0.388480] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.388490] pci 0000:00:1c.1: PME# disabled
[    0.388551] pci 0000:00:1c.3: [8086:2946] type 1 class 0x000604
[    0.388681] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.388691] pci 0000:00:1c.3: PME# disabled
[    0.388749] pci 0000:00:1c.4: [8086:2948] type 1 class 0x000604
[    0.388879] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.388889] pci 0000:00:1c.4: PME# disabled
[    0.388953] pci 0000:00:1d.0: [8086:2934] type 0 class 0x000c03
[    0.389046] pci 0000:00:1d.0: reg 20: [io  0x18c0-0x18df]
[    0.389146] pci 0000:00:1d.1: [8086:2935] type 0 class 0x000c03
[    0.389238] pci 0000:00:1d.1: reg 20: [io  0x18e0-0x18ff]
[    0.389339] pci 0000:00:1d.2: [8086:2936] type 0 class 0x000c03
[    0.389431] pci 0000:00:1d.2: reg 20: [io  0x1c00-0x1c1f]
[    0.389550] pci 0000:00:1d.7: [8086:293a] type 0 class 0x000c03
[    0.389593] pci 0000:00:1d.7: reg 10: [mem 0xfc227000-0xfc2273ff]
[    0.389736] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.389746] pci 0000:00:1d.7: PME# disabled
[    0.389794] pci 0000:00:1e.0: [8086:2448] type 1 class 0x000604
[    0.389932] pci 0000:00:1f.0: [8086:2917] type 0 class 0x000601
[    0.390165] pci 0000:00:1f.2: [8086:2929] type 0 class 0x000106
[    0.390211] pci 0000:00:1f.2: reg 10: [io  0x1c48-0x1c4f]
[    0.390232] pci 0000:00:1f.2: reg 14: [io  0x183c-0x183f]
[    0.390252] pci 0000:00:1f.2: reg 18: [io  0x1c40-0x1c47]
[    0.390273] pci 0000:00:1f.2: reg 1c: [io  0x1838-0x183b]
[    0.390293] pci 0000:00:1f.2: reg 20: [io  0x1c20-0x1c3f]
[    0.390314] pci 0000:00:1f.2: reg 24: [mem 0xfc226000-0xfc2267ff]
[    0.390396] pci 0000:00:1f.2: PME# supported from D3hot
[    0.390405] pci 0000:00:1f.2: PME# disabled
[    0.390451] pci 0000:00:1f.3: [8086:2930] type 0 class 0x000c05
[    0.390487] pci 0000:00:1f.3: reg 10: [mem 0xfc227400-0xfc2274ff 64b=
it]
[    0.390537] pci 0000:00:1f.3: reg 20: [io  0x1c60-0x1c7f]
[    0.390690] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.391033] pci 0000:03:00.0: [8086:423b] type 0 class 0x000280
[    0.391181] pci 0000:03:00.0: reg 10: [mem 0xf4300000-0xf4301fff 64b=
it]
[    0.391725] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.391765] pci 0000:03:00.0: PME# disabled
[    0.391923] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.392010] pci 0000:00:1c.1:   bridge window [mem 0xf4300000-0xf43f=
ffff]
[    0.392140] pci 0000:00:1c.3: PCI bridge to [bus 05-0c]
[    0.392223] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
[    0.392234] pci 0000:00:1c.3:   bridge window [mem 0xf8000000-0xf9ff=
ffff]
[    0.392249] pci 0000:00:1c.3:   bridge window [mem 0xf4000000-0xf40f=
ffff 64bit pref]
[    0.392344] pci 0000:00:1c.4: PCI bridge to [bus 0d-14]
[    0.392426] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    0.392436] pci 0000:00:1c.4:   bridge window [mem 0xfa000000-0xfbff=
ffff]
[    0.392451] pci 0000:00:1c.4:   bridge window [mem 0xf4100000-0xf41f=
ffff 64bit pref]
[    0.392533] pci 0000:15:00.0: [1180:0476] type 2 class 0x000607
[    0.392569] pci 0000:15:00.0: proprietary Ricoh MMC controller disab=
led (via cardbus function)
[    0.392666] pci 0000:15:00.0: MMC cards are now supported by standar=
d SDHCI controller
[    0.392784] pci 0000:15:00.0: reg 10: [mem 0xf4800000-0xf4800fff]
[    0.392829] pci 0000:15:00.0: supports D1 D2
[    0.392834] pci 0000:15:00.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.392845] pci 0000:15:00.0: PME# disabled
[    0.392889] pci 0000:15:00.1: [1180:0832] type 0 class 0x000c00
[    0.392930] pci 0000:15:00.1: reg 10: [mem 0xf4801000-0xf48017ff]
[    0.393078] pci 0000:15:00.1: supports D1 D2
[    0.393084] pci 0000:15:00.1: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.393094] pci 0000:15:00.1: PME# disabled
[    0.393138] pci 0000:15:00.2: [1180:0822] type 0 class 0x000805
[    0.393178] pci 0000:15:00.2: reg 10: [mem 0xf4801800-0xf48018ff]
[    0.393326] pci 0000:15:00.2: supports D1 D2
[    0.393332] pci 0000:15:00.2: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.393343] pci 0000:15:00.2: PME# disabled
[    0.393389] pci 0000:15:00.4: [1180:0592] type 0 class 0x000880
[    0.393429] pci 0000:15:00.4: reg 10: [mem 0xf4802000-0xf48020ff]
[    0.393577] pci 0000:15:00.4: supports D1 D2
[    0.393583] pci 0000:15:00.4: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.393594] pci 0000:15:00.4: PME# disabled
[    0.393640] pci 0000:15:00.5: [1180:0852] type 0 class 0x000880
[    0.393680] pci 0000:15:00.5: reg 10: [mem 0xf4802400-0xf48024ff]
[    0.393828] pci 0000:15:00.5: supports D1 D2
[    0.393834] pci 0000:15:00.5: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.393845] pci 0000:15:00.5: PME# disabled
[    0.393954] pci 0000:00:1e.0: PCI bridge to [bus 15-18] (subtractive=
 decode)
[    0.394041] pci 0000:00:1e.0:   bridge window [io  0x4000-0x7fff]
[    0.394051] pci 0000:00:1e.0:   bridge window [mem 0xf4800000-0xf7ff=
ffff]
[    0.394066] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xf3ff=
ffff 64bit pref]
[    0.394074] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (s=
ubtractive decode)
[    0.394081] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (s=
ubtractive decode)
[    0.394089] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000b=
ffff] (subtractive decode)
[    0.394096] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000d=
3fff] (subtractive decode)
[    0.394103] pci 0000:00:1e.0:   bridge window [mem 0x000d4000-0x000d=
7fff] (subtractive decode)
[    0.394111] pci 0000:00:1e.0:   bridge window [mem 0x000d8000-0x000d=
bfff] (subtractive decode)
[    0.394118] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xfebf=
ffff] (subtractive decode)
[    0.394246] pci_bus 0000:00: on NUMA node 0
[    0.394255] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.394611] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
[    0.394706] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.394803] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
[    0.394901] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP4._PRT]
[    0.395002] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[    0.395747]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.396831]  pci0000:00: ACPI _OSC control (0x1d) granted
[    0.412238] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11=
)
[    0.412989] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11=
)
[    0.413747] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11=
)
[    0.416093] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11=
)
[    0.416856] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11=
)
[    0.417616] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11=
)
[    0.418372] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11=
)
[    0.419136] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11=
)
[    0.420235] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,=
owns=3Dio+mem,locks=3Dnone
[    0.420235] vgaarb: loaded
[    0.420274] vgaarb: bridge control possible 0000:00:02.0
[    0.420383] PCI: Using ACPI for IRQ routing
[    0.425055] PCI: pci_cache_line_size set to 64 bytes
[    0.425306] reserve RAM buffer: 000000000009ec00 - 000000000009ffff=20
[    0.425313] reserve RAM buffer: 00000000bd4a1000 - 00000000bfffffff=20
[    0.425326] reserve RAM buffer: 00000000bd5b7000 - 00000000bfffffff=20
[    0.425339] reserve RAM buffer: 00000000bd6c6000 - 00000000bfffffff=20
[    0.425350] reserve RAM buffer: 00000000bda00000 - 00000000bfffffff=20
[    0.425399] NetLabel: Initializing
[    0.425399] NetLabel:  domain hash size =3D 128
[    0.425399] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.425399] NetLabel:  unlabeled traffic allowed by default
[    0.425399] HPET: 4 timers in total, 0 timers will be used for per-c=
pu timer
[    0.425399] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.425399] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.436157] Switching to clocksource hpet
[    0.440393] pnp: PnP ACPI init
[    0.440492] ACPI: bus type pnp registered
[    0.462974] pnp 00:00: [mem 0x00000000-0x0009ffff]
[    0.462981] pnp 00:00: [mem 0x000c0000-0x000c3fff]
[    0.462988] pnp 00:00: [mem 0x000c4000-0x000c7fff]
[    0.462994] pnp 00:00: [mem 0x000c8000-0x000cbfff]
[    0.462999] pnp 00:00: [mem 0x000cc000-0x000cffff]
[    0.463006] pnp 00:00: [mem 0x000d0000-0x000cffff disabled]
[    0.463012] pnp 00:00: [mem 0x000d4000-0x000d3fff disabled]
[    0.463019] pnp 00:00: [mem 0x000d8000-0x000d7fff disabled]
[    0.463025] pnp 00:00: [mem 0x000dc000-0x000dffff]
[    0.463031] pnp 00:00: [mem 0x000e0000-0x000e3fff]
[    0.463036] pnp 00:00: [mem 0x000e4000-0x000e7fff]
[    0.463042] pnp 00:00: [mem 0x000e8000-0x000ebfff]
[    0.463048] pnp 00:00: [mem 0x000ec000-0x000effff]
[    0.463054] pnp 00:00: [mem 0x000f0000-0x000fffff]
[    0.463060] pnp 00:00: [mem 0x00100000-0xbfffffff]
[    0.463066] pnp 00:00: [mem 0xfec00000-0xffffffff]
[    0.463072] pnp 00:00: [mem 0xfed4c000-0xfed4bfff disabled]
[    0.463329] system 00:00: [mem 0x00000000-0x0009ffff] could not be r=
eserved
[    0.463416] system 00:00: [mem 0x000c0000-0x000c3fff] could not be r=
eserved
[    0.463500] system 00:00: [mem 0x000c4000-0x000c7fff] could not be r=
eserved
[    0.463583] system 00:00: [mem 0x000c8000-0x000cbfff] has been reser=
ved
[    0.463666] system 00:00: [mem 0x000cc000-0x000cffff] has been reser=
ved
[    0.463749] system 00:00: [mem 0x000dc000-0x000dffff] could not be r=
eserved
[    0.463832] system 00:00: [mem 0x000e0000-0x000e3fff] could not be r=
eserved
[    0.463915] system 00:00: [mem 0x000e4000-0x000e7fff] could not be r=
eserved
[    0.463998] system 00:00: [mem 0x000e8000-0x000ebfff] could not be r=
eserved
[    0.464139] system 00:00: [mem 0x000ec000-0x000effff] could not be r=
eserved
[    0.464223] system 00:00: [mem 0x000f0000-0x000fffff] could not be r=
eserved
[    0.464307] system 00:00: [mem 0x00100000-0xbfffffff] could not be r=
eserved
[    0.464391] system 00:00: [mem 0xfec00000-0xffffffff] could not be r=
eserved
[    0.464476] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (ac=
tive)
[    0.464533] pnp 00:01: [bus 00-ff]
[    0.464539] pnp 00:01: [io  0x0cf8-0x0cff]
[    0.464546] pnp 00:01: [io  0x0000-0x0cf7 window]
[    0.464552] pnp 00:01: [io  0x0d00-0xffff window]
[    0.464558] pnp 00:01: [mem 0x000a0000-0x000bffff window]
[    0.464565] pnp 00:01: [mem 0x000c0000-0x000c3fff window]
[    0.464571] pnp 00:01: [mem 0x000c4000-0x000c7fff window]
[    0.464578] pnp 00:01: [mem 0x000c8000-0x000cbfff window]
[    0.464584] pnp 00:01: [mem 0x000cc000-0x000cffff window]
[    0.464591] pnp 00:01: [mem 0x000d0000-0x000d3fff window]
[    0.464597] pnp 00:01: [mem 0x000d4000-0x000d7fff window]
[    0.464607] pnp 00:01: [mem 0x000d8000-0x000dbfff window]
[    0.464614] pnp 00:01: [mem 0x000dc000-0x000dffff window]
[    0.464620] pnp 00:01: [mem 0x000e0000-0x000e3fff window]
[    0.464626] pnp 00:01: [mem 0x000e4000-0x000e7fff window]
[    0.464632] pnp 00:01: [mem 0x000e8000-0x000ebfff window]
[    0.464638] pnp 00:01: [mem 0x000ec000-0x000effff window]
[    0.464645] pnp 00:01: [mem 0xc0000000-0xfebfffff window]
[    0.464651] pnp 00:01: [mem 0xfed40000-0xfed4bfff window]
[    0.464870] pnp 00:01: Plug and Play ACPI device, IDs PNP0a08 PNP0a0=
3 (active)
[    0.486366] pnp 00:02: [io  0x0010-0x001f]
[    0.486373] pnp 00:02: [io  0x0090-0x009f]
[    0.486379] pnp 00:02: [io  0x0024-0x0025]
[    0.486384] pnp 00:02: [io  0x0028-0x0029]
[    0.486390] pnp 00:02: [io  0x002c-0x002d]
[    0.486395] pnp 00:02: [io  0x0030-0x0031]
[    0.486400] pnp 00:02: [io  0x0034-0x0035]
[    0.486406] pnp 00:02: [io  0x0038-0x0039]
[    0.486411] pnp 00:02: [io  0x003c-0x003d]
[    0.486417] pnp 00:02: [io  0x00a4-0x00a5]
[    0.486422] pnp 00:02: [io  0x00a8-0x00a9]
[    0.486428] pnp 00:02: [io  0x00ac-0x00ad]
[    0.486433] pnp 00:02: [io  0x00b0-0x00b5]
[    0.486438] pnp 00:02: [io  0x00b8-0x00b9]
[    0.486444] pnp 00:02: [io  0x00bc-0x00bd]
[    0.486449] pnp 00:02: [io  0x0050-0x0053]
[    0.486455] pnp 00:02: [io  0x0072-0x0077]
[    0.486460] pnp 00:02: [io  0x002e-0x002f]
[    0.486466] pnp 00:02: [io  0x1000-0x107f]
[    0.486471] pnp 00:02: [io  0x1180-0x11ff]
[    0.486477] pnp 00:02: [io  0x0800-0x080f]
[    0.486482] pnp 00:02: [io  0x15e0-0x15ef]
[    0.486488] pnp 00:02: [io  0x1600-0x167f]
[    0.486493] pnp 00:02: [io  0x1680-0x169f]
[    0.486499] pnp 00:02: [mem 0xe0000000-0xefffffff]
[    0.486506] pnp 00:02: [mem 0xfed1c000-0xfed1ffff]
[    0.486512] pnp 00:02: [mem 0xfed10000-0xfed13fff]
[    0.486517] pnp 00:02: [mem 0xfed18000-0xfed18fff]
[    0.486523] pnp 00:02: [mem 0xfed19000-0xfed19fff]
[    0.486529] pnp 00:02: [mem 0xfed45000-0xfed4bfff]
[    0.486535] pnp 00:02: [mem 0xfed40000-0xfed44fff]
[    0.486846] system 00:02: [io  0x1000-0x107f] has been reserved
[    0.486930] system 00:02: [io  0x1180-0x11ff] has been reserved
[    0.487011] system 00:02: [io  0x0800-0x080f] has been reserved
[    0.487092] system 00:02: [io  0x15e0-0x15ef] has been reserved
[    0.487172] system 00:02: [io  0x1600-0x167f] has been reserved
[    0.487253] system 00:02: [io  0x1680-0x169f] has been reserved
[    0.487335] system 00:02: [mem 0xe0000000-0xefffffff] has been reser=
ved
[    0.487418] system 00:02: [mem 0xfed1c000-0xfed1ffff] has been reser=
ved
[    0.487501] system 00:02: [mem 0xfed10000-0xfed13fff] has been reser=
ved
[    0.487583] system 00:02: [mem 0xfed18000-0xfed18fff] has been reser=
ved
[    0.487666] system 00:02: [mem 0xfed19000-0xfed19fff] has been reser=
ved
[    0.487749] system 00:02: [mem 0xfed45000-0xfed4bfff] has been reser=
ved
[    0.487832] system 00:02: [mem 0xfed40000-0xfed44fff] has been reser=
ved
[    0.487916] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (ac=
tive)
[    0.488079] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    0.488239] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (activ=
e)
[    0.488268] pnp 00:04: [io  0x0000-0x000f]
[    0.488278] pnp 00:04: [io  0x0080-0x008f]
[    0.488283] pnp 00:04: [io  0x00c0-0x00df]
[    0.488289] pnp 00:04: [dma 4]
[    0.488442] pnp 00:04: Plug and Play ACPI device, IDs PNP0200 (activ=
e)
[    0.488470] pnp 00:05: [io  0x0061]
[    0.488619] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (activ=
e)
[    0.488647] pnp 00:06: [io  0x00f0]
[    0.488664] pnp 00:06: [irq 13]
[    0.488818] pnp 00:06: Plug and Play ACPI device, IDs PNP0c04 (activ=
e)
[    0.488846] pnp 00:07: [io  0x0070-0x0071]
[    0.488859] pnp 00:07: [irq 8]
[    0.489007] pnp 00:07: Plug and Play ACPI device, IDs PNP0b00 (activ=
e)
[    0.489035] pnp 00:08: [io  0x0060]
[    0.489041] pnp 00:08: [io  0x0064]
[    0.489053] pnp 00:08: [irq 1]
[    0.489207] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (activ=
e)
[    0.489241] pnp 00:09: [irq 12]
[    0.489394] pnp 00:09: Plug and Play ACPI device, IDs IBM0057 PNP0f1=
3 (active)
[    0.511784] pnp: PnP ACPI: found 10 devices
[    0.511862] ACPI: ACPI bus type pnp unregistered
[    0.528809] PCI: max bus depth: 2 pci_try_num: 3
[    0.528912] pci 0000:00:1c.1: BAR 15: assigned [mem 0xc0000000-0xc01=
fffff 64bit pref]
[    0.529014] pci 0000:00:1c.1: BAR 13: assigned [io  0x8000-0x8fff]
[    0.529099] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc0200000-0xc03=
fffff]
[    0.529186] pci 0000:00:1c.0: BAR 15: assigned [mem 0xc0400000-0xc05=
fffff 64bit pref]
[    0.529285] pci 0000:00:1c.0: BAR 13: assigned [io  0x9000-0x9fff]
[    0.529366] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.529446] pci 0000:00:1c.0:   bridge window [io  0x9000-0x9fff]
[    0.529532] pci 0000:00:1c.0:   bridge window [mem 0xc0200000-0xc03f=
ffff]
[    0.529617] pci 0000:00:1c.0:   bridge window [mem 0xc0400000-0xc05f=
ffff 64bit pref]
[    0.529720] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.529800] pci 0000:00:1c.1:   bridge window [io  0x8000-0x8fff]
[    0.529885] pci 0000:00:1c.1:   bridge window [mem 0xf4300000-0xf43f=
ffff]
[    0.529971] pci 0000:00:1c.1:   bridge window [mem 0xc0000000-0xc01f=
ffff 64bit pref]
[    0.530073] pci 0000:00:1c.3: PCI bridge to [bus 05-0c]
[    0.530152] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
[    0.530238] pci 0000:00:1c.3:   bridge window [mem 0xf8000000-0xf9ff=
ffff]
[    0.530324] pci 0000:00:1c.3:   bridge window [mem 0xf4000000-0xf40f=
ffff 64bit pref]
[    0.530426] pci 0000:00:1c.4: PCI bridge to [bus 0d-14]
[    0.530505] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    0.530591] pci 0000:00:1c.4:   bridge window [mem 0xfa000000-0xfbff=
ffff]
[    0.530677] pci 0000:00:1c.4:   bridge window [mem 0xf4100000-0xf41f=
ffff 64bit pref]
[    0.530787] pci 0000:15:00.0: BAR 16: assigned [mem 0xc4000000-0xc7f=
fffff]
[    0.533174] pci 0000:15:00.0: BAR 15: assigned [mem 0xf0000000-0xf3f=
fffff pref]
[    0.533271] pci 0000:15:00.0: BAR 14: assigned [io  0x4000-0x40ff]
[    0.533352] pci 0000:15:00.0: BAR 13: assigned [io  0x4400-0x44ff]
[    0.533433] pci 0000:15:00.0: CardBus bridge to [bus 16-17]
[    0.533511] pci 0000:15:00.0:   bridge window [io  0x4400-0x44ff]
[    0.533596] pci 0000:15:00.0:   bridge window [io  0x4000-0x40ff]
[    0.533680] pci 0000:15:00.0:   bridge window [mem 0xf0000000-0xf3ff=
ffff pref]
[    0.533778] pci 0000:15:00.0:   bridge window [mem 0xc4000000-0xc7ff=
ffff]
[    0.533864] pci 0000:00:1e.0: PCI bridge to [bus 15-18]
[    0.533943] pci 0000:00:1e.0:   bridge window [io  0x4000-0x7fff]
[    0.534029] pci 0000:00:1e.0:   bridge window [mem 0xf4800000-0xf7ff=
ffff]
[    0.534114] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xf3ff=
ffff 64bit pref]
[    0.534242] pci 0000:00:1c.0: PCI INT A -> GSI 20 (level, low) -> IR=
Q 20
[    0.534329] pci 0000:00:1c.0: setting latency timer to 64
[    0.534352] pci 0000:00:1c.1: PCI INT B -> GSI 21 (level, low) -> IR=
Q 21
[    0.534438] pci 0000:00:1c.1: setting latency timer to 64
[    0.534460] pci 0000:00:1c.3: PCI INT D -> GSI 23 (level, low) -> IR=
Q 23
[    0.534545] pci 0000:00:1c.3: setting latency timer to 64
[    0.534561] pci 0000:00:1c.4: PCI INT A -> GSI 20 (level, low) -> IR=
Q 20
[    0.534646] pci 0000:00:1c.4: setting latency timer to 64
[    0.534662] pci 0000:00:1e.0: setting latency timer to 64
[    0.534687] pci 0000:15:00.0: PCI INT A -> GSI 16 (level, low) -> IR=
Q 16
[    0.534776] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.534782] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.534789] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.534795] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff]
[    0.534801] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff]
[    0.534808] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff]
[    0.534814] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xfebfffff]
[    0.534821] pci_bus 0000:02: resource 0 [io  0x9000-0x9fff]
[    0.534827] pci_bus 0000:02: resource 1 [mem 0xc0200000-0xc03fffff]
[    0.534834] pci_bus 0000:02: resource 2 [mem 0xc0400000-0xc05fffff 6=
4bit pref]
[    0.534841] pci_bus 0000:03: resource 0 [io  0x8000-0x8fff]
[    0.534847] pci_bus 0000:03: resource 1 [mem 0xf4300000-0xf43fffff]
[    0.534854] pci_bus 0000:03: resource 2 [mem 0xc0000000-0xc01fffff 6=
4bit pref]
[    0.534860] pci_bus 0000:05: resource 0 [io  0x2000-0x2fff]
[    0.534866] pci_bus 0000:05: resource 1 [mem 0xf8000000-0xf9ffffff]
[    0.534873] pci_bus 0000:05: resource 2 [mem 0xf4000000-0xf40fffff 6=
4bit pref]
[    0.534880] pci_bus 0000:0d: resource 0 [io  0x3000-0x3fff]
[    0.534886] pci_bus 0000:0d: resource 1 [mem 0xfa000000-0xfbffffff]
[    0.534893] pci_bus 0000:0d: resource 2 [mem 0xf4100000-0xf41fffff 6=
4bit pref]
[    0.534899] pci_bus 0000:15: resource 0 [io  0x4000-0x7fff]
[    0.534906] pci_bus 0000:15: resource 1 [mem 0xf4800000-0xf7ffffff]
[    0.534912] pci_bus 0000:15: resource 2 [mem 0xf0000000-0xf3ffffff 6=
4bit pref]
[    0.534919] pci_bus 0000:15: resource 4 [io  0x0000-0x0cf7]
[    0.534925] pci_bus 0000:15: resource 5 [io  0x0d00-0xffff]
[    0.534931] pci_bus 0000:15: resource 6 [mem 0x000a0000-0x000bffff]
[    0.534937] pci_bus 0000:15: resource 7 [mem 0x000d0000-0x000d3fff]
[    0.534943] pci_bus 0000:15: resource 8 [mem 0x000d4000-0x000d7fff]
[    0.534949] pci_bus 0000:15: resource 9 [mem 0x000d8000-0x000dbfff]
[    0.534956] pci_bus 0000:15: resource 10 [mem 0xc0000000-0xfebfffff]
[    0.534962] pci_bus 0000:16: resource 0 [io  0x4400-0x44ff]
[    0.534968] pci_bus 0000:16: resource 1 [io  0x4000-0x40ff]
[    0.534975] pci_bus 0000:16: resource 2 [mem 0xf0000000-0xf3ffffff p=
ref]
[    0.534981] pci_bus 0000:16: resource 3 [mem 0xc4000000-0xc7ffffff]
[    0.535067] NET: Registered protocol family 2
[    0.535267] IP route cache hash table entries: 131072 (order: 8, 104=
8576 bytes)
[    0.537269] TCP established hash table entries: 262144 (order: 10, 4=
194304 bytes)
[    0.539935] TCP bind hash table entries: 65536 (order: 8, 1048576 by=
tes)
[    0.541065] TCP: Hash tables configured (established 262144 bind 655=
36)
[    0.541149] TCP reno registered
[    0.541226] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.541362] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes=
)
[    0.541679] NET: Registered protocol family 1
[    0.541789] pci 0000:00:02.0: Boot video device
[    0.542155] PCI: CLS 64 bytes, default 64
[    0.542268] Trying to unpack rootfs image as initramfs...
[    0.549109] rootfs image is not initramfs (no cpio magic); looks lik=
e an initrd
[    0.551554] Freeing initrd memory: 1216k freed
[    0.552301] DMAR: Device scope device [0000:00:03.02] not found
[    0.552380] DMAR: Device scope device [0000:00:03.02] not found
[    0.552460] DMAR: Device scope device [0000:00:03.03] not found
[    0.552538] DMAR: Device scope device [0000:00:03.03] not found
[    0.552634] DMAR: No ATSR found
[    0.552849] IOMMU 2 0xfeb00000: using Register based invalidation
[    0.552929] IOMMU 0 0xfeb03000: using Register based invalidation
[    0.553007] IOMMU 3 0xfeb02000: using Register based invalidation
[    0.553094] IOMMU: Setting RMRR:
[    0.553196] IOMMU: Setting identity map for device 0000:00:1d.0 [0xf=
c226c00 - 0xfc2273ff]
[    0.553357] IOMMU: Setting identity map for device 0000:00:1d.1 [0xf=
c226c00 - 0xfc2273ff]
[    0.553503] IOMMU: Setting identity map for device 0000:00:1d.2 [0xf=
c226c00 - 0xfc2273ff]
[    0.553645] IOMMU: Setting identity map for device 0000:00:1d.7 [0xf=
c226c00 - 0xfc2273ff]
[    0.553787] IOMMU: Setting identity map for device 0000:00:1a.0 [0xf=
c226c00 - 0xfc2273ff]
[    0.553932] IOMMU: Setting identity map for device 0000:00:1a.1 [0xf=
c226c00 - 0xfc2273ff]
[    0.554074] IOMMU: Setting identity map for device 0000:00:1a.2 [0xf=
c226c00 - 0xfc2273ff]
[    0.554216] IOMMU: Setting identity map for device 0000:00:1a.7 [0xf=
c226c00 - 0xfc2273ff]
[    0.554338] IOMMU: Prepare 0-16MiB unity mapping for LPC
[    0.554443] IOMMU: Setting identity map for device 0000:00:1f.0 [0x0=
 - 0xffffff]
[    0.554904] PCI-DMA: Intel(R) Virtualization Technology for Directed=
 I/O
[    0.560599] Simple Boot Flag at 0x35 set to 0x1
[    0.563034] audit: initializing netlink socket (disabled)
[    0.563131] type=3D2000 audit(1321303460.556:1): initialized
[    0.586031] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.637648] VFS: Disk quotas dquot_6.5.2
[    0.637957] Dquot-cache hash table entries: 512 (order 0, 4096 bytes=
)
[    0.638328] ROMFS MTD (C) 2007 Red Hat, Inc.
[    0.638570] msgmni has been set to 7823
[    0.639537] Block layer SCSI generic (bsg) driver version 0.4 loaded=
 (major 253)
[    0.639633] io scheduler noop registered
[    0.639706] io scheduler deadline registered (default)
[    0.640162] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.640259] pcieport 0000:00:1c.0: irq 43 for MSI/MSI-X
[    0.640730] pcieport 0000:00:1c.1: setting latency timer to 64
[    0.640819] pcieport 0000:00:1c.1: irq 44 for MSI/MSI-X
[    0.641290] pcieport 0000:00:1c.3: setting latency timer to 64
[    0.641378] pcieport 0000:00:1c.3: irq 45 for MSI/MSI-X
[    0.641834] pcieport 0000:00:1c.4: setting latency timer to 64
[    0.641922] pcieport 0000:00:1c.4: irq 46 for MSI/MSI-X
[    0.642619] pcieport 0000:00:1c.0: Signaling PME through PCIe PME in=
terrupt
[    0.642708] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme lo=
aded
[    0.642759] pcieport 0000:00:1c.1: Signaling PME through PCIe PME in=
terrupt
[    0.642841] pci 0000:03:00.0: Signaling PME through PCIe PME interru=
pt
[    0.642926] pcie_pme 0000:00:1c.1:pcie01: service driver pcie_pme lo=
aded
[    0.642974] pcieport 0000:00:1c.3: Signaling PME through PCIe PME in=
terrupt
[    0.643061] pcie_pme 0000:00:1c.3:pcie01: service driver pcie_pme lo=
aded
[    0.643108] pcieport 0000:00:1c.4: Signaling PME through PCIe PME in=
terrupt
[    0.643194] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme lo=
aded
[    0.643532] intel_idle: MWAIT substates: 0x3122220
[    0.643538] intel_idle: does not run on family 6 model 23
[    0.643782] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0=
C0D:00/input/input0
[    0.644075] ACPI: Lid Switch [LID]
[    0.644359] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PN=
P0C0E:00/input/input1
[    0.644460] ACPI: Sleep Button [SLPB]
[    0.644781] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/=
input/input2
[    0.644878] ACPI: Power Button [PWRF]
[    0.645193] ERST: Table is not found!
[    0.645267] GHES: HEST is not enabled!
[    0.727079] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.837152] Linux agpgart interface v0.103
[    0.837660] agpgart-intel 0000:00:00.0: Intel GM45 Chipset
[    0.838108] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K =
total, 262144K mappable
[    0.844079] agpgart-intel 0000:00:00.0: detected 32768K stolen memor=
y
[    0.844512] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd00=
00000
[    0.844860] [drm] Initialized drm 1.1.0 20060810
[    0.845059] [drm] radeon defaulting to userspace modesetting.
[    0.848537] i915 0000:00:02.0: power state changed by ACPI to D0
[    0.848624] i915 0000:00:02.0: power state changed by ACPI to D0
[    0.848713] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> I=
RQ 16
[    0.848798] i915 0000:00:02.0: setting latency timer to 64
[    1.021939] i915 0000:00:02.0: irq 47 for MSI/MSI-X
[    1.021953] [drm] Supports vblank timestamp caching Rev 1 (10.10.201=
0).
[    1.022038] [drm] Driver supports precise vblank timestamp query.
[    1.022215] vgaarb: device changed decodes: PCI:0000:00:02.0,olddeco=
des=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    1.463232] fbcon: inteldrmfb (fb0) is primary device
[    1.560033] Refined TSC clocksource calibration: 2526.999 MHz.
[    1.560044] Switching to clocksource tsc
[    1.639770] Console: switching to colour frame buffer device 180x56
[    1.650974] fb0: inteldrmfb frame buffer device
[    1.651050] drm: registered panic notifier
[    1.752342] acpi device:02: registered as cooling_device0
[    1.752788] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A=
08:00/LNXVIDEO:00/input/input3
[    1.752940] ACPI: Video Device [VID] (multi-head: yes  rom: no  post=
: no)
[    1.753223] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 o=
n minor 0
[    1.759526] brd: module loaded
[    1.759844] Fixed MDIO Bus: probed
[    1.760196] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at=
 0x60,0x64 irq 1,12
[    1.769256] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.769438] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.770037] mousedev: PS/2 mouse device common for all mice
[    1.770275] rtc_cmos 00:07: RTC can wake from S4
[    1.770669] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[    1.770814] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet=
 irqs
[    1.771015] cpuidle: using governor ladder
[    1.771087] cpuidle: using governor menu
[    1.771879] TCP cubic registered
[    1.771940] NET: Registered protocol family 17
[    1.775078] input: AT Translated Set 2 keyboard as /devices/platform=
/i8042/serio0/input/input4
[    1.781904] registered taskstats version 1
[    1.803579] rtc_cmos 00:07: setting system clock to 2011-11-14 20:44=
:22 UTC (1321303462)
[    1.804190] RAMDISK: lzo image found at block 0
[    1.847849] VFS: Mounted root (romfs filesystem) readonly on device =
1:0.
[    1.867841] SCSI subsystem initialized
[    1.876478] libata version 3.00 loaded.
[    1.879441] ahci 0000:00:1f.2: version 3.0
[    1.879475] ahci 0000:00:1f.2: PCI INT B -> GSI 16 (level, low) -> I=
RQ 16
[    1.883334] ahci 0000:00:1f.2: irq 48 for MSI/MSI-X
[    1.883410] ahci: SSS flag set, parallel bus scan disabled
[    1.887204] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 4 ports 3 Gbp=
s 0x3 impl SATA mode
[    1.891026] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo=
 pio slum part ccc sxs=20
[    1.894842] ahci 0000:00:1f.2: setting latency timer to 64
[    1.897181] scsi0 : ahci
[    1.901295] scsi1 : ahci
[    1.905303] scsi2 : ahci
[    1.909273] scsi3 : ahci
[    1.913777] ata1: SATA max UDMA/133 abar m2048@0xfc226000 port 0xfc2=
26100 irq 48
[    1.917432] ata2: SATA max UDMA/133 abar m2048@0xfc226000 port 0xfc2=
26180 irq 48
[    1.921019] ata3: DUMMY
[    1.924545] ata4: DUMMY
[    2.248034] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.256302] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[    2.256313] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[    2.259951] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[    2.274285] ata1.00: ATA-8: OCZ-VERTEX2, 1.35, max UDMA/133
[    2.277849] ata1.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 3=
1/32), AA
[    2.294285] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[    2.294296] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[    2.297864] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[    2.314289] ata1.00: configured for UDMA/133
[    2.318068] scsi 0:0:0:0: Direct-Access     ATA      OCZ-VERTEX2    =
  1.35 PQ: 0 ANSI: 5
[    2.640034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.646619] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
[    2.647691] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
[    2.647702] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[    2.652487] ata2.00: ATAPI: Optiarc  DVD RW AD-7910S, 1.D0, max UDMA=
/100
[    2.659675] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
[    2.660806] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
[    2.660816] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[    2.665628] ata2.00: configured for UDMA/100
[    2.671786] scsi 1:0:0:0: CD-ROM            Optiarc  DVD RW AD-7910S=
  1.D0 PQ: 0 ANSI: 5
[    2.679360] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initiali=
sed: dm-devel@redhat.com
[    2.689896] Intel AES-NI instructions are not detected.
[    2.708069] sd 0:0:0:0: [sda] 468862128 512-byte logical blocks: (24=
0 GB/223 GiB)
[    2.712221] sd 0:0:0:0: [sda] Write Protect is off
[    2.716155] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.716216] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
[    2.721594]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
[    2.727177] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.752901] SGI XFS with ACLs, security attributes, large block/inod=
e numbers, no debug enabled
[    2.758812] SGI XFS Quota Management subsystem
[   15.860563] XFS (dm-0): Mounting Filesystem
[   16.007747] XFS (dm-0): Ending clean mount
[   16.011811] VFS: Mounted root (xfs filesystem) readonly on device 25=
4:0.
[   16.015858] Trying to move old root to /initrd ... okay
[   16.020965] devtmpfs: mounted
[   16.027499] Freeing unused kernel memory: 488k freed
[   16.031929] Write protecting the kernel read-only data: 6144k
[   16.038202] Freeing unused kernel memory: 212k freed
[   16.044705] Freeing unused kernel memory: 244k freed
[   17.107403] e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k
[   17.107411] e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
[   17.107476] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) ->=
 IRQ 20
[   17.107502] e1000e 0000:00:19.0: setting latency timer to 64
[   17.107789] e1000e 0000:00:19.0: irq 49 for MSI/MSI-X
[   17.118234] usbcore: registered new interface driver usbfs
[   17.118316] usbcore: registered new interface driver hub
[   17.124692] usbcore: registered new device driver usb
[   17.131849] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[   17.143232] cfg80211: Calling CRDA to update world regulatory domain
[   17.193023] thermal LNXTHERM:00: registered as thermal_zone0
[   17.193032] ACPI: Thermal Zone [THM0] (50 C)
[   17.194237] wmi: Mapper loaded
[   17.202699] Intel(R) Wireless WiFi Link AGN driver for Linux, in-tre=
e:d
[   17.202707] Copyright(c) 2003-2011 Intel Corporation
[   17.202824] iwlwifi 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -=
> IRQ 17
[   17.202841] iwlwifi 0000:03:00.0: setting latency timer to 64
[   17.202892] iwlwifi 0000:03:00.0: pci_resource_len =3D 0x00002000
[   17.202899] iwlwifi 0000:03:00.0: pci_resource_base =3D ffffc9000005=
8000
[   17.202906] iwlwifi 0000:03:00.0: HW Revision ID =3D 0x0
[   17.203013] iwlwifi 0000:03:00.0: irq 50 for MSI/MSI-X
[   17.203089] iwlwifi 0000:03:00.0: Detected Intel(R) WiMAX/WiFi Link =
5350 AGN, REV=3D0x24
[   17.203261] iwlwifi 0000:03:00.0: L1 Disabled; Enabling L0S
[   17.209648] thermal LNXTHERM:01: registered as thermal_zone1
[   17.209656] ACPI: Thermal Zone [THM1] (41 C)
[   17.221836] Monitor-Mwait will be used to enter C-1 state
[   17.225976] Monitor-Mwait will be used to enter C-2 state
[   17.228094] Monitor-Mwait will be used to enter C-3 state
[   17.228599] Marking TSC unstable due to TSC halts in idle
[   17.228672] ACPI: acpi_idle registered with cpuidle
[   17.232081] Switching to clocksource hpet
[   17.307665] ACPI: AC Adapter [AC] (off-line)
[   17.326991] Non-volatile memory driver v1.3
[   17.343072] iwlwifi 0000:03:00.0: device EEPROM VER=3D0x21e, CALIB=3D=
0x4
[   17.343081] iwlwifi 0000:03:00.0: Device SKU: 0Xf0
[   17.343088] iwlwifi 0000:03:00.0: Valid Tx ant: 0X7, Valid Rx ant: 0=
X7
[   17.343120] iwlwifi 0000:03:00.0: Tunable channels: 13 802.11bg, 24 =
802.11a channels
[   17.344658] input: PC Speaker as /devices/platform/pcspkr/input/inpu=
t5
[   17.351402] iTCO_vendor_support: vendor-support=3D0
[   17.355504] e1000e 0000:00:19.0: eth0: (PCI Express:2.5GT/s:Width x1=
) 00:21:86:a2:19:06
[   17.355519] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Con=
nection
[   17.355559] e1000e 0000:00:19.0: eth0: MAC: 7, PHY: 8, PBA No: 1008F=
=46-0FF
[   17.355609] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D0
[   17.355621] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D0
[   17.355640] ehci_hcd 0000:00:1a.7: PCI INT D -> GSI 23 (level, low) =
-> IRQ 23
[   17.355696] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[   17.355705] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[   17.355774] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned =
bus number 1
[   17.355878] ehci_hcd 0000:00:1a.7: debug port 1
[   17.359772] ehci_hcd 0000:00:1a.7: cache line size of 64 is not supp=
orted
[   17.359818] ehci_hcd 0000:00:1a.7: irq 23, io mem 0xfc226c00
[   17.363783] yenta_cardbus 0000:15:00.0: CardBus bridge found [17aa:2=
0c6]
[   17.404057] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[   17.404149] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[   17.404158] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[   17.404165] usb usb1: Product: EHCI Host Controller
[   17.404170] usb usb1: Manufacturer: Linux 3.2.0-rc1-00306-g7f80850-d=
irty ehci_hcd
[   17.404177] usb usb1: SerialNumber: 0000:00:1a.7
[   17.404720] hub 1-0:1.0: USB hub found
[   17.404734] hub 1-0:1.0: 6 ports detected
[   17.405084] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D0
[   17.405097] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D0
[   17.405138] ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 19 (level, low) =
-> IRQ 19
[   17.405212] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[   17.405220] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   17.405245] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned =
bus number 2
[   17.405343] ehci_hcd 0000:00:1d.7: debug port 1
[   17.410201] ehci_hcd 0000:00:1d.7: cache line size of 64 is not supp=
orted
[   17.410249] ehci_hcd 0000:00:1d.7: irq 19, io mem 0xfc227000
[   17.420782] thinkpad_acpi: ThinkPad ACPI Extras v0.24
[   17.420789] thinkpad_acpi: http://ibm-acpi.sf.net/
[   17.420795] thinkpad_acpi: ThinkPad BIOS 7UET91WW (3.21 ), EC 7VHT16=
WW-1.06
[   17.420822] thinkpad_acpi: Lenovo ThinkPad T400, model 2764CTO
[   17.445695] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[   17.445747] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[   17.445756] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[   17.445762] usb usb2: Product: EHCI Host Controller
[   17.445768] usb usb2: Manufacturer: Linux 3.2.0-rc1-00306-g7f80850-d=
irty ehci_hcd
[   17.445774] usb usb2: SerialNumber: 0000:00:1d.7
[   17.451849] hub 2-0:1.0: USB hub found
[   17.451864] hub 2-0:1.0: 6 ports detected
[   17.453741] snd_hda_intel 0000:00:1b.0: PCI INT B -> GSI 17 (level, =
low) -> IRQ 17
[   17.453876] snd_hda_intel 0000:00:1b.0: irq 51 for MSI/MSI-X
[   17.453938] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[   17.463644] Monitor-Mwait will be used to enter C-3 state
[   17.475216] uhci_hcd: USB Universal Host Controller Interface driver
[   17.478627] thinkpad_acpi: detected a 8-level brightness capable Thi=
nkPad
[   17.480784] ACPI: Battery Slot [BAT0] (battery present)
[   17.484499] thinkpad_acpi: radio switch found; radios are enabled
[   17.487427] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.07
[   17.487652] iTCO_wdt: Found a ICH9M-E TCO device (Version=3D2, TCOBA=
SE=3D0x1060)
[   17.489908] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   17.492760] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio =
is unblocked
[   17.495549] sdhci: Secure Digital Host Controller Interface driver
[   17.495556] sdhci: Copyright(c) Pierre Ossman
[   17.507711] thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is un=
blocked
[   17.511033] Registered led device: tpacpi::thinklight
[   17.511128] Registered led device: tpacpi::power
[   17.511186] Registered led device: tpacpi::standby
[   17.511234] Registered led device: tpacpi::thinkvantage
[   17.515263] ALSA sound/pci/hda/hda_codec.c:3987 hda_codec: model 'la=
ptop' is selected
[   17.515459] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00=
:1b.0/input/input6
[   17.525518] thinkpad_acpi: Standard ACPI backlight interface availab=
le, not loading native one
[   17.525725] thinkpad_acpi: Console audio control enabled, mode: over=
ride (read/write)
[   17.533993] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0=
/sound/card0/input7
[   17.534261] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0=
/sound/card0/input8
[   17.534507] input: HDA Intel Headphone as /devices/pci0000:00/0000:0=
0:1b.0/sound/card0/input9
[   17.535513] i801_smbus 0000:00:1f.3: PCI INT A -> GSI 23 (level, low=
) -> IRQ 23
[   17.535943] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   17.535952] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   17.535966] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 20 (level, low) =
-> IRQ 20
[   17.535983] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[   17.535992] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   17.536044] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned =
bus number 3
[   17.536128] uhci_hcd 0000:00:1a.0: irq 20, io base 0x00001860
[   17.536254] usb usb3: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[   17.536262] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[   17.536268] usb usb3: Product: UHCI Host Controller
[   17.536274] usb usb3: Manufacturer: Linux 3.2.0-rc1-00306-g7f80850-d=
irty uhci_hcd
[   17.536280] usb usb3: SerialNumber: 0000:00:1a.0
[   17.536561] hub 3-0:1.0: USB hub found
[   17.536574] hub 3-0:1.0: 2 ports detected
[   17.536852] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) =
-> IRQ 21
[   17.536869] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[   17.536877] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   17.536896] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned =
bus number 4
[   17.536969] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001880
[   17.537088] usb usb4: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[   17.537095] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[   17.537101] usb usb4: Product: UHCI Host Controller
[   17.537107] usb usb4: Manufacturer: Linux 3.2.0-rc1-00306-g7f80850-d=
irty uhci_hcd
[   17.537113] usb usb4: SerialNumber: 0000:00:1a.1
[   17.537386] hub 4-0:1.0: USB hub found
[   17.537398] hub 4-0:1.0: 2 ports detected
[   17.537657] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D0
[   17.537666] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D0
[   17.537695] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 22 (level, low) =
-> IRQ 22
[   17.537711] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[   17.537718] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[   17.537740] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned =
bus number 5
[   17.537810] uhci_hcd 0000:00:1a.2: irq 22, io base 0x000018a0
[   17.537933] usb usb5: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[   17.537941] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[   17.537947] usb usb5: Product: UHCI Host Controller
[   17.537953] usb usb5: Manufacturer: Linux 3.2.0-rc1-00306-g7f80850-d=
irty uhci_hcd
[   17.537959] usb usb5: SerialNumber: 0000:00:1a.2
[   17.538217] hub 5-0:1.0: USB hub found
[   17.538229] hub 5-0:1.0: 2 ports detected
[   17.538784] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   17.538794] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   17.538807] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 16 (level, low) =
-> IRQ 16
[   17.538822] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[   17.538830] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   17.538851] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned =
bus number 6
[   17.538897] uhci_hcd 0000:00:1d.0: irq 16, io base 0x000018c0
[   17.539016] usb usb6: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[   17.539023] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[   17.539029] usb usb6: Product: UHCI Host Controller
[   17.539035] usb usb6: Manufacturer: Linux 3.2.0-rc1-00306-g7f80850-d=
irty uhci_hcd
[   17.539041] usb usb6: SerialNumber: 0000:00:1d.0
[   17.539299] hub 6-0:1.0: USB hub found
[   17.539311] hub 6-0:1.0: 2 ports detected
[   17.540257] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 17 (level, low) =
-> IRQ 17
[   17.540273] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[   17.540281] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   17.540301] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned =
bus number 7
[   17.540370] uhci_hcd 0000:00:1d.1: irq 17, io base 0x000018e0
[   17.540491] usb usb7: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[   17.540498] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[   17.540505] usb usb7: Product: UHCI Host Controller
[   17.540510] usb usb7: Manufacturer: Linux 3.2.0-rc1-00306-g7f80850-d=
irty uhci_hcd
[   17.540516] usb usb7: SerialNumber: 0000:00:1d.1
[   17.541344] hub 7-0:1.0: USB hub found
[   17.541356] hub 7-0:1.0: 2 ports detected
[   17.541872] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) =
-> IRQ 18
[   17.541888] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[   17.541896] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   17.541916] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned =
bus number 8
[   17.541984] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001c00
[   17.542110] usb usb8: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[   17.542117] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[   17.542124] usb usb8: Product: UHCI Host Controller
[   17.542129] usb usb8: Manufacturer: Linux 3.2.0-rc1-00306-g7f80850-d=
irty uhci_hcd
[   17.542136] usb usb8: SerialNumber: 0000:00:1d.2
[   17.542388] hub 8-0:1.0: USB hub found
[   17.542400] hub 8-0:1.0: 2 ports detected
[   17.543076] input: ThinkPad Extra Buttons as /devices/platform/think=
pad_acpi/input/input10
[   17.583707] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   17.583846] sr 1:0:0:0: Attached scsi generic sg1 type 5
[   17.588168] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/fo=
rm2 cdda tray
[   17.588176] cdrom: Uniform CD-ROM driver Revision: 3.20
[   17.590729] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   17.609265] yenta_cardbus 0000:15:00.0: ISA IRQ mask 0x0cb8, PCI irq=
 16
[   17.609274] yenta_cardbus 0000:15:00.0: Socket status: 30000006
[   17.609290] yenta_cardbus 0000:15:00.0: pcmcia: parent PCI bridge wi=
ndow: [io  0x4000-0x7fff]
[   17.609299] yenta_cardbus 0000:15:00.0: pcmcia: parent PCI bridge wi=
ndow: [mem 0xf4800000-0xf7ffffff]
[   17.609307] pcmcia_socket pcmcia_socket0: cs: memory probe 0xf480000=
0-0xf7ffffff: excluding 0xf4800000-0xf4b7ffff
[   17.609350] yenta_cardbus 0000:15:00.0: pcmcia: parent PCI bridge wi=
ndow: [mem 0xf0000000-0xf3ffffff 64bit pref]
[   17.609358] pcmcia_socket pcmcia_socket0: cs: memory probe 0xf000000=
0-0xf3ffffff: excluding 0xf0000000-0xf3ffffff
[   17.616883] firewire_ohci 0000:15:00.1: PCI INT B -> GSI 17 (level, =
low) -> IRQ 17
[   17.680189] firewire_ohci: Added fw-ohci device 0000:15:00.1, OHCI v=
1.10, 4 IR + 4 IT contexts, quirks 0x1
[   17.680528] sdhci-pci 0000:15:00.2: SDHCI controller found [1180:082=
2] (rev 21)
[   17.680558] sdhci-pci 0000:15:00.2: PCI INT C -> GSI 18 (level, low)=
 -> IRQ 18
[   17.681622] sdhci-pci 0000:15:00.2: Will use DMA mode even though HW=
 doesn't fully claim to support it.
[   17.681647] mmc0: no vmmc regulator found
[   17.682715] Registered led device: mmc0::
[   17.689387] mmc0: SDHCI controller on PCI [0000:15:00.2] using DMA
[   17.940120] usb 1-6: new high-speed USB device number 4 using ehci_h=
cd
[   18.086145] usb 1-6: New USB device found, idVendor=3D17ef, idProduc=
t=3D1004
[   18.086155] usb 1-6: New USB device strings: Mfr=3D2, Product=3D1, S=
erialNumber=3D3
[   18.086162] usb 1-6: Product: Integrated Camera
[   18.086167] usb 1-6: Manufacturer: Chicony Electronics Co., Ltd.
[   18.086173] usb 1-6: SerialNumber: SN0001
[   18.152848] iwlwifi 0000:03:00.0: loaded firmware version 8.83.5.1 b=
uild 33692
[   18.154129] Registered led device: phy0-led
[   18.169049] ieee80211 phy0: Selected rate control algorithm 'iwl-agn=
-rs'
[   18.173612] Linux media interface: v0.10
[   18.180237] firewire_core: created device fw0: GUID 00061b032a347baa=
, S400
[   18.190406] Linux video capture interface: v2.00
[   18.200093] usb 2-4: new high-speed USB device number 2 using ehci_h=
cd
[   18.208386] uvcvideo: Found UVC 1.00 device Integrated Camera (17ef:=
1004)
[   18.216526] udevd[1455]: renamed network interface wlan0 to eth1
[   18.245718] input: Integrated Camera as /devices/pci0000:00/0000:00:=
1a.7/usb1/1-6/1-6:1.0/input/input11
[   18.245916] usbcore: registered new interface driver uvcvideo
[   18.245922] USB Video Class driver (1.1.1)
[   18.274825] psmouse serio1: synaptics: Touchpad model: 1, fw: 7.0, i=
d: 0x1c0b1, caps: 0xd04791/0xb00000/0x20000
[   18.274842] psmouse serio1: synaptics: serio: Synaptics pass-through=
 port at isa0060/serio1/input0
[   18.319433] input: SynPS/2 Synaptics TouchPad as /devices/platform/i=
8042/serio1/input/input12
[   18.405224] usb 2-4: New USB device found, idVendor=3D0bdb, idProduc=
t=3D1900
[   18.405233] usb 2-4: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D3
[   18.405241] usb 2-4: Product: Ericsson F3507g Mobile Broadband Minic=
ard Composite Device
[   18.405247] usb 2-4: Manufacturer: Ericsson
[   18.405253] usb 2-4: SerialNumber: 3541430228088360
[   18.418557] TCP illinois registered
[   18.469999] cdc_acm 2-4:1.1: ttyACM0: USB ACM device
[   18.473601] cdc_acm 2-4:1.3: ttyACM1: USB ACM device
[   18.475431] cdc_acm 2-4:1.9: ttyACM2: USB ACM device
[   18.477387] cdc_wdm 2-4:1.5: cdc-wdm-176: USB WDM device
[   18.477569] cdc_wdm 2-4:1.6: cdc-wdm-175: USB WDM device
[   18.477971] usbcore: registered new interface driver cdc_wdm
[   18.479048] usbcore: registered new interface driver cdc_acm
[   18.479055] cdc_acm: USB Abstract Control Model driver for USB modem=
s and ISDN adapters
[   18.489623] cdc_ether 2-4:1.7: wwan0: register 'cdc_ether' at usb-00=
00:00:1d.7-4, Mobile Broadband Network Device, 02:80:37:ec:02:00
[   18.489697] usbcore: registered new interface driver cdc_ether
[   18.692063] usb 3-1: new full-speed USB device number 2 using uhci_h=
cd
[   18.872275] usb 3-1: New USB device found, idVendor=3D046d, idProduc=
t=3Dc52b
[   18.872284] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[   18.872291] usb 3-1: Product: USB Receiver
[   18.872296] usb 3-1: Manufacturer: Logitech
[   18.900145] usbcore: registered new interface driver usbhid
[   18.900152] usbhid: USB HID core driver
[   18.914571] logitech-djreceiver 0003:046D:C52B.0003: hiddev0,hidraw0=
: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:1a.0-1/in=
put2
[   18.918939] input: Logitech Unifying Device. Wireless PID:1028 as /d=
evices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1:1.2/0003:046D:C52B.0003/inp=
ut/input13
[   18.919327] logitech-djdevice 0003:046D:C52B.0004: input,hidraw1: US=
B HID v1.11 Mouse [Logitech Unifying Device. Wireless PID:1028] on usb-=
0000:00:1a.0-1:1
[   19.116064] usb 4-2: new full-speed USB device number 2 using uhci_h=
cd
[   19.288118] usb 4-2: New USB device found, idVendor=3D0a5c, idProduc=
t=3D2145
[   19.288127] usb 4-2: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[   19.288134] usb 4-2: Product: ThinkPad Bluetooth with Enhanced Data =
Rate II
[   19.288141] usb 4-2: Manufacturer: Lenovo Computer Corp
[   19.332429] Bluetooth: Core ver 2.16
[   19.332492] NET: Registered protocol family 31
[   19.332498] Bluetooth: HCI device and connection manager initialized
[   19.332506] Bluetooth: HCI socket layer initialized
[   19.332511] Bluetooth: L2CAP socket layer initialized
[   19.332525] Bluetooth: SCO socket layer initialized
[   19.343960] Bluetooth: Generic Bluetooth USB driver ver 0.6
[   19.347167] usbcore: registered new interface driver btusb
[   20.139862] init: cpusets pre-start process (2200) terminated with s=
tatus 3
[   20.140835] init: blockdev pre-start process (2197) terminated with =
status 1
[   20.169155] init: sys-chroots pre-start process (2226) terminated wi=
th status 1
[   20.508161] NET: Registered protocol family 10
[   20.751119] e1000e 0000:00:19.0: irq 49 for MSI/MSI-X
[   20.804201] e1000e 0000:00:19.0: irq 49 for MSI/MSI-X
[   20.805690] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   24.064759] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[   24.299779] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/=
serio1/serio2/input/input14
[   24.739793] iwlwifi 0000:03:00.0: L1 Disabled; Enabling L0S
[   24.740190] iwlwifi 0000:03:00.0: Radio type=3D0x0-0x1-0x0
[   24.892625] iwlwifi 0000:03:00.0: L1 Disabled; Enabling L0S
[   24.893020] iwlwifi 0000:03:00.0: Radio type=3D0x0-0x1-0x0
[   24.947853] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   28.163831] eth1: authenticate with e0:46:9a:4e:93:25 (try 1)
[   28.360125] eth1: authenticate with e0:46:9a:4e:93:25 (try 2)
[   28.360648] eth1: authenticated
[   28.367829] eth1: associate with e0:46:9a:4e:93:25 (try 1)
[   28.564095] eth1: associate with e0:46:9a:4e:93:25 (try 2)
[   28.565079] eth1: RX AssocResp from e0:46:9a:4e:93:25 (capab=3D0x411=
 status=3D0 aid=3D1)
[   28.565086] eth1: associated
[   28.573866] ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   35.316401] auditd (2932): /proc/2932/oom_adj is deprecated, please =
use /proc/2932/oom_score_adj instead.
[   35.810797] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   35.810800] Bluetooth: BNEP filters: protocol multicast
[   35.837114] Bluetooth: RFCOMM TTY layer initialized
[   35.837118] Bluetooth: RFCOMM socket layer initialized
[   35.837120] Bluetooth: RFCOMM ver 1.11
[   40.816637] iwlwifi 0000:03:00.0: Tx aggregation enabled on ra =3D e=
0:46:9a:4e:93:25 tid =3D 0
[   95.053753] PM: Syncing filesystems ... done.
[   95.602876] Freezing user space processes ... (elapsed 0.01 seconds)=
 done.
[   95.616093] Freezing remaining freezable tasks ... (elapsed 0.01 sec=
onds) done.
[   95.632209] Suspending console(s) (use no_console_suspend to debug)
[   95.802246] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   95.802336] sd 0:0:0:0: [sda] Stopping disk
[   95.849080] ------------[ cut here ]------------
[   95.849096] WARNING: at drivers/pci/pci-driver.c:607 pci_has_legacy_=
pm_support.isra.6+0x4e/0x54()
[   95.849102] Hardware name: 2764CTO
[   95.849106] Modules linked in: rfcomm bnep sch_sfq ipv6 ext2 mbcache=
 md_mod acpi_cpufreq mperf btusb bluetooth crc16 hid_logitech_dj usbhid=
 hid cdc_ether usbnet mii cdc_wdm cdc_acm=20
tcp_illinois joydev uvcvideo videodev media v4l2_compat_ioctl32 arc4 pc=
mcia sg sr_mod cdrom snd_hda_codec_conexant sdhci_pci sdhci psmouse iTC=
O_wdt firewire_ohci uhci_hcd mmc_core=20
yenta_socket thinkpad_acpi serio_raw i2c_i801 firewire_core iTCO_vendor=
_support battery pcspkr pcmcia_rsrc crc_itu_t pcmcia_core nvram ac snd_=
hda_intel evdev snd_hda_codec iwlwifi=20
snd_hwdep wmi snd_pcm mac80211 thermal cfg80211 ehci_hcd processor rfki=
ll snd_timer e1000e usbcore snd soundcore snd_page_alloc usb_common xfs=
 sd_mod crc_t10dif cbc cryptd=20
aes_x86_64 aes_generic dm_crypt dm_mod ahci libahci libata scsi_mod [la=
st unloaded: scsi_wait_scan]
[   95.849234] Pid: 1208, comm: kworker/u:5 Not tainted 3.2.0-rc1-00306=
-g7f80850-dirty #148
[   95.849239] Call Trace:
[   95.849251]  [<ffffffff8103c870>] warn_slowpath_common+0x7e/0x96
[   95.849262]  [<ffffffff8103c89d>] warn_slowpath_null+0x15/0x17
[   95.849270]  [<ffffffff811a5072>] pci_has_legacy_pm_support.isra.6+0=
x4e/0x54
[   95.849280]  [<ffffffff8105cd93>] ? async_run_entry_fn+0x116/0x14f
[   95.849287]  [<ffffffff811a564c>] pci_pm_suspend+0x2f/0xff
[   95.849298]  [<ffffffff812e81ce>] pm_op+0x86/0x144
[   95.849306]  [<ffffffff812e8474>] __device_suspend+0x18f/0x239
[   95.849314]  [<ffffffff8105cc7d>] ? async_schedule+0x12/0x12
[   95.849322]  [<ffffffff812e8538>] async_suspend+0x1a/0x85
[   95.849329]  [<ffffffff8105cd1a>] async_run_entry_fn+0x9d/0x14f
[   95.849336]  [<ffffffff8105cd93>] ? async_run_entry_fn+0x116/0x14f
[   95.849343]  [<ffffffff81052e57>] process_one_work+0x201/0x391
[   95.849351]  [<ffffffff81053444>] worker_thread+0x15b/0x21c
[   95.849358]  [<ffffffff810532e9>] ? manage_workers.isra.24+0x16b/0x1=
6b
[   95.849366]  [<ffffffff81056f93>] kthread+0x7f/0x87
[   95.849376]  [<ffffffff813c3294>] kernel_thread_helper+0x4/0x10
[   95.849384]  [<ffffffff81056f14>] ? kthread_worker_fn+0x141/0x141
[   95.849391]  [<ffffffff813c3290>] ? gs_change+0xb/0xb
[   95.849397] ---[ end trace 1f04e1393772359e ]---
[   95.851476] ACPI handle has no context!
[   95.851495] sdhci-pci 0000:15:00.2: PCI INT C disabled
[   95.851506] ACPI handle has no context!
[   95.851551] ehci_hcd 0000:00:1d.7: PCI INT D disabled
[   95.851579] uhci_hcd 0000:00:1d.2: PCI INT C disabled
[   95.851600] uhci_hcd 0000:00:1d.1: PCI INT B disabled
[   95.851626] uhci_hcd 0000:00:1d.0: PCI INT A disabled
[   95.851812] ehci_hcd 0000:00:1a.7: PCI INT D disabled
[   95.851843] uhci_hcd 0000:00:1a.2: PCI INT C disabled
[   95.851860] uhci_hcd 0000:00:1a.1: PCI INT B disabled
[   95.851883] uhci_hcd 0000:00:1a.0: PCI INT A disabled
[   95.856179] ACPI handle has no context!
[   95.868157] i915 0000:00:02.0: power state changed by ACPI to D3
[   95.944485] e1000e 0000:00:19.0: PCI INT A disabled
[   95.944499] e1000e 0000:00:19.0: PME# enabled
[   95.944516] e1000e 0000:00:19.0: wake-up capability enabled by ACPI
[   95.956494] snd_hda_intel 0000:00:1b.0: PCI INT B disabled
[   95.972170] PM: suspend of devices complete after 339.323 msecs
[   95.972690] ------------[ cut here ]------------
[   95.972700] WARNING: at drivers/pci/pci-driver.c:607 pci_has_legacy_=
pm_support.isra.6+0x4e/0x54()
[   95.972704] Hardware name: 2764CTO
[   95.972708] Modules linked in: rfcomm bnep sch_sfq ipv6 ext2 mbcache=
 md_mod acpi_cpufreq mperf btusb bluetooth crc16 hid_logitech_dj usbhid=
 hid cdc_ether usbnet mii cdc_wdm cdc_acm=20
tcp_illinois joydev uvcvideo videodev media v4l2_compat_ioctl32 arc4 pc=
mcia sg sr_mod cdrom snd_hda_codec_conexant sdhci_pci sdhci psmouse iTC=
O_wdt firewire_ohci uhci_hcd mmc_core=20
yenta_socket thinkpad_acpi serio_raw i2c_i801 firewire_core iTCO_vendor=
_support battery pcspkr pcmcia_rsrc crc_itu_t pcmcia_core nvram ac snd_=
hda_intel evdev snd_hda_codec iwlwifi=20
snd_hwdep wmi snd_pcm mac80211 thermal cfg80211 ehci_hcd processor rfki=
ll snd_timer e1000e usbcore snd soundcore snd_page_alloc usb_common xfs=
 sd_mod crc_t10dif cbc cryptd=20
aes_x86_64 aes_generic dm_crypt dm_mod ahci libahci libata scsi_mod [la=
st unloaded: scsi_wait_scan]
[   95.972817] Pid: 4151, comm: s2ram Tainted: G        W    3.2.0-rc1-=
00306-g7f80850-dirty #148
[   95.972822] Call Trace:
[   95.972832]  [<ffffffff8103c870>] warn_slowpath_common+0x7e/0x96
[   95.972842]  [<ffffffff8103c89d>] warn_slowpath_null+0x15/0x17
[   95.972850]  [<ffffffff811a5072>] pci_has_legacy_pm_support.isra.6+0=
x4e/0x54
[   95.972858]  [<ffffffff811a52e9>] pci_pm_suspend_noirq+0x2f/0x125
[   95.972867]  [<ffffffff812e88a9>] pm_noirq_op+0xcf/0x1b1
[   95.972875]  [<ffffffff812e8cb1>] dpm_suspend_noirq+0x10f/0x264
[   95.972885]  [<ffffffff8107020c>] suspend_devices_and_enter+0xf6/0x2=
73
[   95.972892]  [<ffffffff810704c3>] enter_state+0x13a/0x18b
[   95.972899]  [<ffffffff8106f41a>] state_store+0xb7/0x101
[   95.972906]  [<ffffffff8106f363>] ? pm_async_store+0x45/0x45
[   95.972916]  [<ffffffff8118442b>] kobj_attr_store+0x17/0x19
[   95.972924]  [<ffffffff8114e93b>] sysfs_write_file+0xef/0x12b
[   95.972933]  [<ffffffff810f330e>] vfs_write+0xad/0x13d
[   95.972940]  [<ffffffff810f3589>] sys_write+0x45/0x6c
[   95.972948]  [<ffffffff813c213b>] system_call_fastpath+0x16/0x1b
[   95.972954] ---[ end trace 1f04e1393772359f ]---
[   95.988291] ehci_hcd 0000:00:1d.7: PME# enabled
[   95.988306] ehci_hcd 0000:00:1d.7: wake-up capability enabled by ACP=
I
[   96.004115] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D3
[   96.004342] uhci_hcd 0000:00:1d.0: wake-up capability enabled by ACP=
I
[   96.004353] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D2
[   96.004428] ehci_hcd 0000:00:1a.7: PME# enabled
[   96.004441] ehci_hcd 0000:00:1a.7: wake-up capability enabled by ACP=
I
[   96.020134] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D3
[   96.020242] uhci_hcd 0000:00:1a.2: wake-up capability enabled by ACP=
I
[   96.020252] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D2
[   96.020394] uhci_hcd 0000:00:1a.0: wake-up capability enabled by ACP=
I
[   96.020404] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D2
[   96.020534] PM: late suspend of devices complete after 48.355 msecs
[   96.022610] ACPI: Preparing to enter system sleep state S3
[   96.180180] PM: Saving platform NVS memory
[   96.193497] Disabling non-boot CPUs ...
[   96.194206] Broke affinity for irq 9
[   96.194218] Broke affinity for irq 12
[   96.194239] Broke affinity for irq 17
[   96.296086] CPU 1 is now offline
[   96.296975] Extended CMOS year: 2000
[   96.296975] ACPI: Low-level resume complete
[   96.296975] PM: Restoring platform NVS memory
[   96.296975] Extended CMOS year: 2000
[   96.296975] Enabling non-boot CPUs ...
[   96.305203] Booting Node 0 Processor 1 APIC 0x1
[   96.305205] smpboot cpu 1: start_ip =3D 99000
[   96.195306] Calibrating delay loop (skipped) already calibrated this=
 CPU
[   96.195306] Disabled fast string operations
[   96.341758] CPU1 is up
[   96.343621] ACPI: Waking up from system sleep state S3
[   96.948309] i915 0000:00:02.0: restoring config space at offset 0x1 =
(was 0x900007, writing 0x900407)
[   96.948367] pci 0000:00:02.1: restoring config space at offset 0x1 (=
was 0x900000, writing 0x900007)
[   96.948394] pci 0000:00:03.0: restoring config space at offset 0xf (=
was 0x100, writing 0x10b)
[   96.948420] pci 0000:00:03.0: restoring config space at offset 0x1 (=
was 0x100006, writing 0x180006)
[   96.948517] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   96.948525] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   96.948571] uhci_hcd 0000:00:1a.0: restoring config space at offset =
0x1 (was 0x2900005, writing 0x2900001)
[   96.948636] uhci_hcd 0000:00:1a.0: wake-up capability disabled by AC=
PI
[   96.948645] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   96.948652] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   96.948702] uhci_hcd 0000:00:1a.1: restoring config space at offset =
0x1 (was 0x2900005, writing 0x2900001)
[   96.948728] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D0
[   96.948735] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D0
[   96.948781] uhci_hcd 0000:00:1a.2: restoring config space at offset =
0x1 (was 0x2900005, writing 0x2900001)
[   96.948840] uhci_hcd 0000:00:1a.2: wake-up capability disabled by AC=
PI
[   96.948848] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D0
[   96.948855] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D0
[   96.948915] ehci_hcd 0000:00:1a.7: restoring config space at offset =
0x1 (was 0x2900106, writing 0x2900102)
[   96.948952] ehci_hcd 0000:00:1a.7: wake-up capability disabled by AC=
PI
[   96.948963] ehci_hcd 0000:00:1a.7: PME# disabled
[   96.948970] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D0
[   96.948980] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D0
[   96.949043] snd_hda_intel 0000:00:1b.0: restoring config space at of=
fset 0x1 (was 0x100106, writing 0x100102)
[   96.949107] pcieport 0000:00:1c.0: restoring config space at offset =
0x9 (was 0x1fff1, writing 0xc051c041)
[   96.949118] pcieport 0000:00:1c.0: restoring config space at offset =
0x8 (was 0xfff0, writing 0xc030c020)
[   96.949130] pcieport 0000:00:1c.0: restoring config space at offset =
0x7 (was 0xf0, writing 0x9090)
[   96.949151] pcieport 0000:00:1c.0: restoring config space at offset =
0x1 (was 0x100107, writing 0x100507)
[   96.949243] pcieport 0000:00:1c.1: restoring config space at offset =
0x9 (was 0x1fff1, writing 0xc011c001)
[   96.949256] pcieport 0000:00:1c.1: restoring config space at offset =
0x7 (was 0x200000f0, writing 0x8080)
[   96.949278] pcieport 0000:00:1c.1: restoring config space at offset =
0x1 (was 0x100107, writing 0x100507)
[   96.949384] pcieport 0000:00:1c.3: restoring config space at offset =
0x1 (was 0x100107, writing 0x100507)
[   96.949491] pcieport 0000:00:1c.4: restoring config space at offset =
0x1 (was 0x100107, writing 0x100507)
[   96.949550] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   96.949557] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   96.949603] uhci_hcd 0000:00:1d.0: restoring config space at offset =
0x1 (was 0x2900005, writing 0x2900001)
[   96.949662] uhci_hcd 0000:00:1d.0: wake-up capability disabled by AC=
PI
[   96.949670] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   96.949677] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   96.949726] uhci_hcd 0000:00:1d.1: restoring config space at offset =
0x1 (was 0x2900005, writing 0x2900001)
[   96.949790] uhci_hcd 0000:00:1d.2: restoring config space at offset =
0x1 (was 0x2900005, writing 0x2900001)
[   96.949863] ehci_hcd 0000:00:1d.7: restoring config space at offset =
0x1 (was 0x2900106, writing 0x2900102)
[   96.949899] ehci_hcd 0000:00:1d.7: wake-up capability disabled by AC=
PI
[   96.949909] ehci_hcd 0000:00:1d.7: PME# disabled
[   96.949917] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D0
[   96.949926] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D0
[   96.950108] ahci 0000:00:1f.2: restoring config space at offset 0x1 =
(was 0x2b00007, writing 0x2b00407)
[   96.964130] firewire_ohci 0000:15:00.1: BAR 0: set to [mem 0xf480100=
0-0xf48017ff] (PCI address [0xf4801000-0xf48017ff])
[   96.964185] firewire_ohci 0000:15:00.1: restoring config space at of=
fset 0x3 (was 0x800000, writing 0x802010)
[   96.964201] firewire_ohci 0000:15:00.1: restoring config space at of=
fset 0x1 (was 0x2100000, writing 0x2100106)
[   96.980120] sdhci-pci 0000:15:00.2: BAR 0: set to [mem 0xf4801800-0x=
f48018ff] (PCI address [0xf4801800-0xf48018ff])
[   96.980172] sdhci-pci 0000:15:00.2: restoring config space at offset=
 0x3 (was 0x800000, writing 0x802010)
[   96.980187] sdhci-pci 0000:15:00.2: restoring config space at offset=
 0x1 (was 0x2100000, writing 0x2100106)
[   96.980209] ------------[ cut here ]------------
[   96.980222] WARNING: at drivers/pci/pci-driver.c:607 pci_has_legacy_=
pm_support.isra.6+0x4e/0x54()
[   96.980227] Hardware name: 2764CTO
[   96.980231] Modules linked in: rfcomm bnep sch_sfq ipv6 ext2 mbcache=
 md_mod acpi_cpufreq mperf btusb bluetooth crc16 hid_logitech_dj usbhid=
 hid cdc_ether usbnet mii cdc_wdm cdc_acm=20
tcp_illinois joydev uvcvideo videodev media v4l2_compat_ioctl32 arc4 pc=
mcia sg sr_mod cdrom snd_hda_codec_conexant sdhci_pci sdhci psmouse iTC=
O_wdt firewire_ohci uhci_hcd mmc_core=20
yenta_socket thinkpad_acpi serio_raw i2c_i801 firewire_core iTCO_vendor=
_support battery pcspkr pcmcia_rsrc crc_itu_t pcmcia_core nvram ac snd_=
hda_intel evdev snd_hda_codec iwlwifi=20
snd_hwdep wmi snd_pcm mac80211 thermal cfg80211 ehci_hcd processor rfki=
ll snd_timer e1000e usbcore snd soundcore snd_page_alloc usb_common xfs=
 sd_mod crc_t10dif cbc cryptd=20
aes_x86_64 aes_generic dm_crypt dm_mod ahci libahci libata scsi_mod [la=
st unloaded: scsi_wait_scan]
[   96.980363] Pid: 4151, comm: s2ram Tainted: G        W    3.2.0-rc1-=
00306-g7f80850-dirty #148
[   96.980368] Call Trace:
[   96.980381]  [<ffffffff8103c870>] warn_slowpath_common+0x7e/0x96
[   96.980391]  [<ffffffff8103c89d>] warn_slowpath_null+0x15/0x17
[   96.980399]  [<ffffffff811a5072>] pci_has_legacy_pm_support.isra.6+0=
x4e/0x54
[   96.980407]  [<ffffffff811a51ec>] pci_pm_resume_noirq+0x26/0x58
[   96.980418]  [<ffffffff812e88c7>] pm_noirq_op+0xed/0x1b1
[   96.980426]  [<ffffffff812e8ac6>] dpm_resume_noirq+0x13b/0x217
[   96.980435]  [<ffffffff810702c0>] suspend_devices_and_enter+0x1aa/0x=
273
[   96.980443]  [<ffffffff810704c3>] enter_state+0x13a/0x18b
[   96.980450]  [<ffffffff8106f41a>] state_store+0xb7/0x101
[   96.980456]  [<ffffffff8106f363>] ? pm_async_store+0x45/0x45
[   96.980467]  [<ffffffff8118442b>] kobj_attr_store+0x17/0x19
[   96.980475]  [<ffffffff8114e93b>] sysfs_write_file+0xef/0x12b
[   96.980484]  [<ffffffff810f330e>] vfs_write+0xad/0x13d
[   96.980491]  [<ffffffff810f3589>] sys_write+0x45/0x6c
[   96.980500]  [<ffffffff813c213b>] system_call_fastpath+0x16/0x1b
[   96.980506] ---[ end trace 1f04e139377235a0 ]---
[   96.981484] PM: early resume of devices complete after 33.326 msecs
[   96.981635] i915 0000:00:02.0: power state changed by ACPI to D0
[   96.981646] i915 0000:00:02.0: power state changed by ACPI to D0
[   96.981658] i915 0000:00:02.0: setting latency timer to 64
[   96.982028] e1000e 0000:00:19.0: wake-up capability disabled by ACPI
[   96.982039] e1000e 0000:00:19.0: PME# disabled
[   96.982192] e1000e 0000:00:19.0: irq 49 for MSI/MSI-X
[   96.984395] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   96.984403] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   96.984419] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 20 (level, low) =
-> IRQ 20
[   96.984431] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[   96.984470] usb usb3: root hub lost power or was reset
[   96.984496] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) =
-> IRQ 21
[   96.984509] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[   96.984544] usb usb4: root hub lost power or was reset
[   96.984563] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D0
[   96.984570] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D0
[   96.984580] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 22 (level, low) =
-> IRQ 22
[   96.984592] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[   96.984627] usb usb5: root hub lost power or was reset
[   96.984649] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D0
[   96.984659] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D0
[   96.984671] ehci_hcd 0000:00:1a.7: PCI INT D -> GSI 23 (level, low) =
-> IRQ 23
[   96.984684] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[   96.984756] snd_hda_intel 0000:00:1b.0: PCI INT B -> GSI 17 (level, =
low) -> IRQ 17
[   96.984769] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[   96.984840] snd_hda_intel 0000:00:1b.0: irq 51 for MSI/MSI-X
[   96.984968] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   96.984976] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   96.984986] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 17 (level, low) =
-> IRQ 17
[   96.984995] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 16 (level, low) =
-> IRQ 16
[   96.985002] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[   96.985008] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[   96.985047] usb usb7: root hub lost power or was reset
[   96.985052] usb usb6: root hub lost power or was reset
[   96.985073] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) =
-> IRQ 18
[   96.985080] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D0
[   96.985087] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[   96.985092] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D0
[   96.985108] ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 19 (level, low) =
-> IRQ 19
[   96.985124] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[   96.985131] usb usb8: root hub lost power or was reset
[   96.985155] pci 0000:00:1e.0: setting latency timer to 64
[   96.985184] ahci 0000:00:1f.2: setting latency timer to 64
[   96.985224] ------------[ cut here ]------------
[   96.985234] WARNING: at drivers/pci/pci-driver.c:607 pci_has_legacy_=
pm_support.isra.6+0x4e/0x54()
[   96.985239] Hardware name: 2764CTO
[   96.985242] Modules linked in: rfcomm bnep sch_sfq ipv6 ext2 mbcache=
 md_mod acpi_cpufreq mperf btusb bluetooth crc16 hid_logitech_dj usbhid=
 hid cdc_ether usbnet mii cdc_wdm cdc_acm=20
tcp_illinois joydev uvcvideo videodev media v4l2_compat_ioctl32 arc4 pc=
mcia sg sr_mod cdrom snd_hda_codec_conexant sdhci_pci sdhci psmouse iTC=
O_wdt firewire_ohci uhci_hcd mmc_core=20
yenta_socket thinkpad_acpi serio_raw i2c_i801 firewire_core iTCO_vendor=
_support battery pcspkr pcmcia_rsrc crc_itu_t pcmcia_core nvram ac
[   96.985314] sd 0:0:0:0: [sda] Starting disk
[   96.985319]  snd_hda_intel evdev snd_hda_codec iwlwifi snd_hwdep wmi=
 snd_pcm mac80211 thermal cfg80211 ehci_hcd processor rfkill snd_timer =
e1000e usbcore snd soundcore=20
snd_page_alloc usb_common xfs sd_mod crc_t10dif cbc cryptd aes_x86_64 a=
es_generic dm_crypt dm_mod ahci libahci libata scsi_mod [last unloaded:=
 scsi_wait_scan]
[   96.985365] Pid: 4152, comm: kworker/u:6 Tainted: G        W    3.2.=
0-rc1-00306-g7f80850-dirty #148
[   96.985370] Call Trace:
[   96.985379]  [<ffffffff8103c870>] warn_slowpath_common+0x7e/0x96
[   96.985390]  [<ffffffff8103c89d>] warn_slowpath_null+0x15/0x17
[   96.985398]  [<ffffffff811a5072>] pci_has_legacy_pm_support.isra.6+0=
x4e/0x54
[   96.985405]  [<ffffffff811a5521>] pci_pm_resume+0x42/0x9b
[   96.985413]  [<ffffffff812e81ec>] pm_op+0xa4/0x144
[   96.985420]  [<ffffffff812e8723>] device_resume+0x133/0x1a8
[   96.985429]  [<ffffffff8105cc7d>] ? async_schedule+0x12/0x12
[   96.985436]  [<ffffffff812e87b2>] async_resume+0x1a/0x42
[   96.985444]  [<ffffffff8105cd1a>] async_run_entry_fn+0x9d/0x14f
[   96.985452]  [<ffffffff81052e57>] process_one_work+0x201/0x391
[   96.985461]  [<ffffffff81050b56>] ? need_to_create_worker+0xd/0x21
[   96.985468]  [<ffffffff81053444>] worker_thread+0x15b/0x21c
[   96.985475]  [<ffffffff810532e9>] ? manage_workers.isra.24+0x16b/0x1=
6b
[   96.985484]  [<ffffffff81056f93>] kthread+0x7f/0x87
[   96.985493]  [<ffffffff813c3294>] kernel_thread_helper+0x4/0x10
[   96.985501]  [<ffffffff81056f14>] ? kthread_worker_fn+0x141/0x141
[   96.985508]  [<ffffffff813c3290>] ? gs_change+0xb/0xb
[   96.985513] ---[ end trace 1f04e139377235a1 ]---
[   96.985530] sdhci-pci 0000:15:00.2: PCI INT C -> GSI 18 (level, low)=
 -> IRQ 18
[   96.985537] sdhci-pci 0000:15:00.2: Will use DMA mode even though HW=
 doesn't fully claim to support it.
[   97.048107] firewire_core: skipped bus generations, destroying all n=
odes
[   97.107858] Extended CMOS year: 2000
[   97.304099] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   97.304149] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   97.307048] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
[   97.308092] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
[   97.308102] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[   97.312665] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
[   97.313734] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
[   97.313743] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[   97.314748] ata2.00: configured for UDMA/100
[   97.348145] usb 3-1: reset full-speed USB device number 2 using uhci=
_hcd
[   97.548125] firewire_core: rediscovered device fw0
[   97.600096] usb 4-2: reset full-speed USB device number 2 using uhci=
_hcd
[   97.664698] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[   97.664708] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[   97.664717] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[   97.744372] btusb 4-2:1.0: no reset_resume for driver btusb?
[   97.744379] btusb 4-2:1.1: no reset_resume for driver btusb?
[   97.811245] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[   97.811255] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[   97.811264] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[   97.844137] usb 1-6: reset high-speed USB device number 4 using ehci=
_hcd
[   97.881074] ata1.00: configured for UDMA/133
[   98.044164] iwlwifi 0000:03:00.0: L1 Disabled; Enabling L0S
[   98.047116] iwlwifi 0000:03:00.0: Radio type=3D0x0-0x1-0x0
[   98.047443] ------------[ cut here ]------------
[   98.047456] WARNING: at drivers/iommu/intel-iommu.c:2895 intel_unmap=
_page+0x9c/0x146()
[   98.047460] Hardware name: 2764CTO
[   98.047464] Driver unmaps unmatched page at PFN ffd6a000
[   98.047468] Modules linked in: rfcomm bnep sch_sfq ipv6 ext2 mbcache=
 md_mod acpi_cpufreq mperf btusb bluetooth crc16 hid_logitech_dj usbhid=
 hid cdc_ether usbnet mii cdc_wdm cdc_acm=20
tcp_illinois joydev uvcvideo videodev media v4l2_compat_ioctl32 arc4 pc=
mcia sg sr_mod cdrom snd_hda_codec_conexant sdhci_pci sdhci psmouse iTC=
O_wdt firewire_ohci uhci_hcd mmc_core=20
yenta_socket thinkpad_acpi serio_raw i2c_i801 firewire_core iTCO_vendor=
_support battery pcspkr pcmcia_rsrc crc_itu_t pcmcia_core nvram ac snd_=
hda_intel evdev snd_hda_codec iwlwifi=20
snd_hwdep wmi snd_pcm mac80211 thermal cfg80211 ehci_hcd processor rfki=
ll snd_timer e1000e usbcore snd soundcore snd_page_alloc usb_common xfs=
 sd_mod crc_t10dif cbc cryptd=20
aes_x86_64 aes_generic dm_crypt dm_mod ahci libahci libata scsi_mod [la=
st unloaded: scsi_wait_scan]
[   98.047590] Pid: 4151, comm: s2ram Tainted: G        W    3.2.0-rc1-=
00306-g7f80850-dirty #148
[   98.047595] Call Trace:
[   98.047606]  [<ffffffff8103c870>] warn_slowpath_common+0x7e/0x96
[   98.047615]  [<ffffffff8103c91c>] warn_slowpath_fmt+0x41/0x43
[   98.047623]  [<ffffffff8130a83b>] ? find_iova+0x5a/0x64
[   98.047630]  [<ffffffff8130da31>] intel_unmap_page+0x9c/0x146
[   98.047665]  [<ffffffffa0375135>] iwl_trans_rxq_free_rx_bufs+0x70/0x=
d2 [iwlwifi]
[   98.047696]  [<ffffffffa0376e45>] iwl_trans_pcie_start_device+0x423/=
0xcdb [iwlwifi]
[   98.047704]  [<ffffffff81048c86>] ? del_timer_sync+0x39/0x46
[   98.047726]  [<ffffffffa035f2da>] iwlagn_load_ucode_wait_alive+0x2b/=
0x39d [iwlwifi]
[   98.047752]  [<ffffffffa0367c29>] ? iwl_sta_alloc_lq+0x6d/0x79 [iwlw=
ifi]
[   98.047779]  [<ffffffffa036893d>] ? iwlagn_alloc_bcast_station+0x100=
/0x10f [iwlwifi]
[   98.047799]  [<ffffffffa0359cc1>] iwlagn_mac_start+0x131/0x2ac [iwlw=
ifi]
[   98.047820]  [<ffffffffa030578d>] ? wiphy_suspend+0x5b/0x5b [cfg8021=
1]
[   98.047849]  [<ffffffffa018712f>] ieee80211_reconfig+0xe8/0x47b [mac=
80211]
[   98.047862]  [<ffffffffa01d0871>] ? socket_insert+0x127/0x133 [pcmci=
a_core]
[   98.047880]  [<ffffffffa030578d>] ? wiphy_suspend+0x5b/0x5b [cfg8021=
1]
[   98.047905]  [<ffffffffa017ee63>] ieee80211_resume+0x5b/0x60 [mac802=
11]
[   98.047924]  [<ffffffffa03057ff>] wiphy_resume+0x72/0x85 [cfg80211]
[   98.047934]  [<ffffffff812e85c2>] legacy_resume+0x1f/0x4d
[   98.047942]  [<ffffffff812e8751>] device_resume+0x161/0x1a8
[   98.047950]  [<ffffffff812e930b>] dpm_resume+0xe4/0x1f2
[   98.047959]  [<ffffffff8108de1e>] ? resume_device_irqs+0xb/0xd
[   98.047968]  [<ffffffff812e95df>] dpm_resume_end+0xd/0x18
[   98.047976]  [<ffffffff810702ff>] suspend_devices_and_enter+0x1e9/0x=
273
[   98.047984]  [<ffffffff810704c3>] enter_state+0x13a/0x18b
[   98.047991]  [<ffffffff8106f41a>] state_store+0xb7/0x101
[   98.047998]  [<ffffffff8106f363>] ? pm_async_store+0x45/0x45
[   98.048008]  [<ffffffff8118442b>] kobj_attr_store+0x17/0x19
[   98.048016]  [<ffffffff8114e93b>] sysfs_write_file+0xef/0x12b
[   98.048025]  [<ffffffff810f330e>] vfs_write+0xad/0x13d
[   98.048031]  [<ffffffff810f3589>] sys_write+0x45/0x6c
[   98.048039]  [<ffffffff813c213b>] system_call_fastpath+0x16/0x1b
[   98.048045] ---[ end trace 1f04e139377235a2 ]---
[  107.744504] PM: resume of devices complete after 10762.943 msecs
[  107.745742] Restarting tasks ...=20
[  107.745836] usb 2-4: USB disconnect, device number 2
[  107.759543] cdc_ether 2-4:1.7: wwan0: unregister 'cdc_ether' usb-000=
0:00:1d.7-4, Mobile Broadband Network Device
[  107.760410] done.
[  107.760414] video LNXVIDEO:00: Restoring backlight state
[  108.045081] usb 2-4: new high-speed USB device number 3 using ehci_h=
cd
[  108.270667] usb 2-4: New USB device found, idVendor=3D0bdb, idProduc=
t=3D1900
[  108.270670] usb 2-4: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D3
[  108.270672] usb 2-4: Product: Ericsson F3507g Mobile Broadband Minic=
ard Composite Device
[  108.270674] usb 2-4: Manufacturer: Ericsson
[  108.270676] usb 2-4: SerialNumber: 3541430228088360
[  108.311123] cdc_acm 2-4:1.1: ttyACM0: USB ACM device
[  108.318109] cdc_acm 2-4:1.3: ttyACM1: USB ACM device
[  108.328059] cdc_wdm 2-4:1.5: cdc-wdm-176: USB WDM device
[  108.331377] cdc_wdm 2-4:1.6: cdc-wdm-175: USB WDM device
[  108.336286] cdc_ether 2-4:1.7: wwan0: register 'cdc_ether' at usb-00=
00:00:1d.7-4, Mobile Broadband Network Device, 02:80:37:ec:02:00
[  108.348974] cdc_acm 2-4:1.9: ttyACM2: USB ACM device
[  111.235759] e1000e 0000:00:19.0: eth0: Unsupported Speed/Duplex conf=
iguration
[  111.238519] e1000e 0000:00:19.0: eth0: Unsupported Speed/Duplex conf=
iguration
[  112.722559] e1000e 0000:00:19.0: PME# enabled
[  116.689131] ata1: exception Emask 0x10 SAct 0x0 SErr 0x4040000 actio=
n 0xe frozen
[  116.689140] ata1: irq_stat 0x00000040, connection status changed
[  116.689148] ata1: SError: { CommWake DevExch }
[  116.689164] ata1: hard resetting link
[  117.416104] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  117.471427] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[  117.471439] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[  117.471450] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[  117.581423] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[  117.581434] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[  117.581444] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[  117.631374] ata1.00: configured for UDMA/133
[  117.642065] ata1: EH complete
[  119.520070] thinkpad_acpi: fan watchdog: enabling fan
[  119.689164] ata1: exception Emask 0x10 SAct 0x0 SErr 0x4040000 actio=
n 0xe frozen
[  119.689172] ata1: irq_stat 0x00000040, connection status changed
[  119.689181] ata1: SError: { CommWake DevExch }
[  119.689197] ata1: hard resetting link
[  120.412167] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  120.471437] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[  120.471442] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[  120.471445] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[  120.581456] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[  120.581468] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[  120.581478] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[  120.631355] ata1.00: configured for UDMA/133
[  120.642055] ata1: EH complete
[  122.688869] ata1: exception Emask 0x10 SAct 0x0 SErr 0x4040000 actio=
n 0xe frozen
[  122.688878] ata1: irq_stat 0x00000040, connection status changed
[  122.688886] ata1: SError: { CommWake DevExch }
[  122.688902] ata1: hard resetting link
[  123.416140] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  123.471494] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[  123.471506] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[  123.471516] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[  123.581478] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[  123.581483] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[  123.581486] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[  123.631497] ata1.00: configured for UDMA/133
[  123.642199] ata1: EH complete
[  125.689076] ata1: limiting SATA link speed to 1.5 Gbps
[  125.689087] ata1: exception Emask 0x10 SAct 0x0 SErr 0x4040000 actio=
n 0xe frozen
[  125.689094] ata1: irq_stat 0x00000040, connection status changed
[  125.689102] ata1: SError: { CommWake DevExch }
[  125.689118] ata1: hard resetting link
[  126.412143] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  126.471530] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[  126.471542] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[  126.471552] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[  126.581530] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
[  126.581541] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
[  126.581551] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
[  126.631342] ata1.00: configured for UDMA/133
[  126.642048] ata1: EH complete


#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 3.2.0-rc1 Kernel Configuration
#
CONFIG_64BIT=3Dy
# CONFIG_X86_32 is not set
CONFIG_X86_64=3Dy
CONFIG_X86=3Dy
CONFIG_INSTRUCTION_DECODER=3Dy
CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/x86_64_defconfig"
CONFIG_GENERIC_CMOS_UPDATE=3Dy
CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_ARCH_CLOCKSOURCE_DATA=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
CONFIG_MMU=3Dy
CONFIG_ZONE_DMA=3Dy
CONFIG_NEED_DMA_MAP_STATE=3Dy
CONFIG_NEED_SG_DMA_LENGTH=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_GPIO=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_ARCH_HAS_CPU_RELAX=3Dy
CONFIG_ARCH_HAS_DEFAULT_IDLE=3Dy
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
CONFIG_ZONE_DMA32=3Dy
CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
CONFIG_AUDIT_ARCH=3Dy
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_HAVE_INTEL_TXT=3Dy
CONFIG_X86_64_SMP=3Dy
CONFIG_X86_HT=3Dy
CONFIG_ARCH_HWEIGHT_CFLAGS=3D"-fcall-saved-rdi -fcall-saved-rsi -fcall-=
saved-rdx -fcall-saved-rcx -fcall-saved-r8 -fcall-saved-r9 -fcall-saved=
-r10 -fcall-saved-r11"
# CONFIG_KTIME_SCALAR is not set
CONFIG_ARCH_CPU_PROBE_RELEASE=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
CONFIG_HAVE_IRQ_WORK=3Dy
CONFIG_IRQ_WORK=3Dy

#
# General setup
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_CROSS_COMPILE=3D""
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_HAVE_KERNEL_GZIP=3Dy
CONFIG_HAVE_KERNEL_BZIP2=3Dy
CONFIG_HAVE_KERNEL_LZMA=3Dy
CONFIG_HAVE_KERNEL_XZ=3Dy
CONFIG_HAVE_KERNEL_LZO=3Dy
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=3Dy
# CONFIG_KERNEL_LZO is not set
CONFIG_DEFAULT_HOSTNAME=3D"(none)"
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_BSD_PROCESS_ACCT_V3=3Dy
CONFIG_FHANDLE=3Dy
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy
CONFIG_AUDIT=3Dy
CONFIG_AUDITSYSCALL=3Dy
CONFIG_AUDIT_WATCH=3Dy
CONFIG_AUDIT_TREE=3Dy
CONFIG_HAVE_GENERIC_HARDIRQS=3Dy

#
# IRQ subsystem
#
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_HAVE_SPARSE_IRQ=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_GENERIC_IRQ_SHOW=3Dy
CONFIG_GENERIC_PENDING_IRQ=3Dy
CONFIG_IRQ_FORCED_THREADING=3Dy
CONFIG_SPARSE_IRQ=3Dy

#
# RCU Subsystem
#
CONFIG_TREE_PREEMPT_RCU=3Dy
CONFIG_PREEMPT_RCU=3Dy
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_FANOUT=3D64
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_BOOST=3Dy
CONFIG_RCU_BOOST_PRIO=3D1
CONFIG_RCU_BOOST_DELAY=3D500
CONFIG_IKCONFIG=3Dm
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_LOG_BUF_SHIFT=3D19
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
CONFIG_CGROUPS=3Dy
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_FREEZER=3Dy
CONFIG_CGROUP_DEVICE=3Dy
CONFIG_CPUSETS=3Dy
CONFIG_PROC_PID_CPUSET=3Dy
CONFIG_CGROUP_CPUACCT=3Dy
CONFIG_RESOURCE_COUNTERS=3Dy
CONFIG_CGROUP_MEM_RES_CTLR=3Dy
CONFIG_CGROUP_MEM_RES_CTLR_SWAP=3Dy
CONFIG_CGROUP_MEM_RES_CTLR_SWAP_ENABLED=3Dy
CONFIG_CGROUP_PERF=3Dy
CONFIG_CGROUP_SCHED=3Dy
CONFIG_FAIR_GROUP_SCHED=3Dy
CONFIG_CFS_BANDWIDTH=3Dy
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_BLK_CGROUP=3Dm
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_NAMESPACES=3Dy
CONFIG_UTS_NS=3Dy
CONFIG_IPC_NS=3Dy
CONFIG_USER_NS=3Dy
# CONFIG_PID_NS is not set
CONFIG_NET_NS=3Dy
CONFIG_SCHED_AUTOGROUP=3Dy
CONFIG_MM_OWNER=3Dy
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=3Dy
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_RD_GZIP=3Dy
CONFIG_RD_BZIP2=3Dy
CONFIG_RD_LZMA=3Dy
CONFIG_RD_XZ=3Dy
CONFIG_RD_LZO=3Dy
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_ANON_INODES=3Dy
# CONFIG_EXPERT is not set
CONFIG_UID16=3Dy
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_PCSPKR_PLATFORM=3Dy
CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_AIO=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=3Dy

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=3Dy
CONFIG_PERF_COUNTERS=3Dy
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_PCI_QUIRKS=3Dy
CONFIG_SLUB_DEBUG=3Dy
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=3Dy
CONFIG_PROFILING=3Dy
CONFIG_TRACEPOINTS=3Dy
CONFIG_OPROFILE=3Dm
CONFIG_OPROFILE_EVENT_MULTIPLEX=3Dy
CONFIG_HAVE_OPROFILE=3Dy
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
CONFIG_USER_RETURN_NOTIFIER=3Dy
CONFIG_HAVE_IOREMAP_PROT=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_HAVE_OPTPROBES=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_DMA_ATTRS=3Dy
CONFIG_USE_GENERIC_SMP_HELPERS=3Dy
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
CONFIG_HAVE_DMA_API_DEBUG=3Dy
CONFIG_HAVE_HW_BREAKPOINT=3Dy
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_STOP_MACHINE=3Dy
CONFIG_BLOCK=3Dy
CONFIG_BLK_DEV_BSG=3Dy
CONFIG_BLK_DEV_BSGLIB=3Dy
CONFIG_BLK_DEV_INTEGRITY=3Dy
CONFIG_BLOCK_COMPAT=3Dy

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dm
CONFIG_CFQ_GROUP_IOSCHED=3Dy
CONFIG_DEFAULT_DEADLINE=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"deadline"
CONFIG_PREEMPT_NOTIFIERS=3Dy
CONFIG_PADATA=3Dy
# CONFIG_INLINE_SPIN_TRYLOCK is not set
# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK is not set
# CONFIG_INLINE_SPIN_LOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
# CONFIG_INLINE_SPIN_UNLOCK is not set
# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_READ_TRYLOCK is not set
# CONFIG_INLINE_READ_LOCK is not set
# CONFIG_INLINE_READ_LOCK_BH is not set
# CONFIG_INLINE_READ_LOCK_IRQ is not set
# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
# CONFIG_INLINE_READ_UNLOCK is not set
# CONFIG_INLINE_READ_UNLOCK_BH is not set
# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_WRITE_TRYLOCK is not set
# CONFIG_INLINE_WRITE_LOCK is not set
# CONFIG_INLINE_WRITE_LOCK_BH is not set
# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
# CONFIG_INLINE_WRITE_UNLOCK is not set
# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
CONFIG_FREEZER=3Dy

#
# Processor type and features
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
CONFIG_SMP=3Dy
CONFIG_X86_X2APIC=3Dy
CONFIG_X86_MPPARSE=3Dy
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
# CONFIG_PARAVIRT_GUEST is not set
CONFIG_NO_BOOTMEM=3Dy
# CONFIG_MEMTEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_MCORE2=3Dy
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
CONFIG_X86_CMPXCHG=3Dy
CONFIG_CMPXCHG_LOCAL=3Dy
CONFIG_CMPXCHG_DOUBLE=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_X86_XADD=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_P6_NOP=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_CMPXCHG64=3Dy
CONFIG_X86_CMOV=3Dy
CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
CONFIG_X86_DEBUGCTLMSR=3Dy
CONFIG_CPU_SUP_INTEL=3Dy
CONFIG_CPU_SUP_AMD=3Dy
CONFIG_CPU_SUP_CENTAUR=3Dy
CONFIG_HPET_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
CONFIG_DMI=3Dy
CONFIG_GART_IOMMU=3Dy
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=3Dy
CONFIG_IOMMU_HELPER=3Dy
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS=3D2
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=3Dy
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_COUNT=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_INTEL=3Dy
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=3Dy
CONFIG_X86_MCE_INJECT=3Dm
CONFIG_X86_THERMAL_VECTOR=3Dy
# CONFIG_I8K is not set
CONFIG_MICROCODE=3Dm
CONFIG_MICROCODE_INTEL=3Dy
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=3Dy
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm
CONFIG_ARCH_PHYS_ADDR_T_64BIT=3Dy
CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
CONFIG_DIRECT_GBPAGES=3Dy
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_SPARSEMEM_MANUAL=3Dy
CONFIG_SPARSEMEM=3Dy
CONFIG_HAVE_MEMORY_PRESENT=3Dy
CONFIG_SPARSEMEM_EXTREME=3Dy
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=3Dy
CONFIG_SPARSEMEM_VMEMMAP=3Dy
CONFIG_HAVE_MEMBLOCK=3Dy
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_PAGEFLAGS_EXTENDED=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_COMPACTION=3Dy
CONFIG_MIGRATION=3Dy
CONFIG_PHYS_ADDR_T_64BIT=3Dy
CONFIG_ZONE_DMA_FLAG=3D1
CONFIG_BOUNCE=3Dy
CONFIG_VIRT_TO_BUS=3Dy
CONFIG_MMU_NOTIFIER=3Dy
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=3D65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_CLEANCACHE=3Dy
CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=3D64
CONFIG_MTRR=3Dy
CONFIG_MTRR_SANITIZER=3Dy
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
CONFIG_X86_PAT=3Dy
CONFIG_ARCH_USES_PG_UNCACHED=3Dy
CONFIG_ARCH_RANDOM=3Dy
CONFIG_EFI=3Dy
# CONFIG_SECCOMP is not set
# CONFIG_CC_STACKPROTECTOR is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=3Dy
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D250
CONFIG_SCHED_HRTICK=3Dy
CONFIG_KEXEC=3Dy
# CONFIG_CRASH_DUMP is not set
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=3D0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=3D0x1000000
CONFIG_HOTPLUG_CPU=3Dy
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=3Dy
CONFIG_SUSPEND=3Dy
CONFIG_SUSPEND_FREEZER=3Dy
CONFIG_HIBERNATE_CALLBACKS=3Dy
CONFIG_HIBERNATION=3Dy
CONFIG_PM_STD_PARTITION=3D""
CONFIG_PM_SLEEP=3Dy
CONFIG_PM_SLEEP_SMP=3Dy
CONFIG_PM_RUNTIME=3Dy
CONFIG_PM=3Dy
# CONFIG_PM_DEBUG is not set
CONFIG_ACPI=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_PROCFS=3Dy
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_PROC_EVENT=3Dy
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_VIDEO=3Dy
CONFIG_ACPI_FAN=3Dm
CONFIG_ACPI_DOCK=3Dy
CONFIG_ACPI_PROCESSOR=3Dm
CONFIG_ACPI_IPMI=3Dm
CONFIG_ACPI_HOTPLUG_CPU=3Dy
CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dm
CONFIG_ACPI_THERMAL=3Dm
CONFIG_ACPI_CUSTOM_DSDT_FILE=3D""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=3Dm
CONFIG_X86_PM_TIMER=3Dy
CONFIG_ACPI_CONTAINER=3Dm
CONFIG_ACPI_SBS=3Dm
CONFIG_ACPI_HED=3Dy
CONFIG_ACPI_CUSTOM_METHOD=3Dm
CONFIG_ACPI_APEI=3Dy
CONFIG_ACPI_APEI_GHES=3Dy
CONFIG_ACPI_APEI_PCIEAER=3Dy
CONFIG_ACPI_APEI_EINJ=3Dm
CONFIG_ACPI_APEI_ERST_DEBUG=3Dm
CONFIG_SFI=3Dy

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy
CONFIG_CPU_FREQ_STAT=3Dm
CONFIG_CPU_FREQ_STAT_DETAILS=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm

#
# x86 CPU frequency scaling drivers
#
CONFIG_X86_PCC_CPUFREQ=3Dm
CONFIG_X86_ACPI_CPUFREQ=3Dm
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# CONFIG_X86_SPEEDSTEP_LIB is not set
CONFIG_CPU_IDLE=3Dy
CONFIG_CPU_IDLE_GOV_LADDER=3Dy
CONFIG_CPU_IDLE_GOV_MENU=3Dy
CONFIG_INTEL_IDLE=3Dy

#
# Memory power savings
#
CONFIG_I7300_IDLE_IOAT_CHANNEL=3Dy
CONFIG_I7300_IDLE=3Dm

#
# Bus options (PCI etc.)
#
CONFIG_PCI=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_PCI_DOMAINS=3Dy
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=3Dy
# CONFIG_HOTPLUG_PCI_PCIE is not set
CONFIG_PCIEAER=3Dy
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEAER_INJECT=3Dm
CONFIG_PCIEASPM=3Dy
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIE_PME=3Dy
CONFIG_ARCH_SUPPORTS_MSI=3Dy
CONFIG_PCI_MSI=3Dy
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=3Dm
CONFIG_HT_IRQ=3Dy
CONFIG_PCI_ATS=3Dy
CONFIG_PCI_IOV=3Dy
CONFIG_PCI_PRI=3Dy
CONFIG_PCI_PASID=3Dy
CONFIG_PCI_IOAPIC=3Dy
CONFIG_PCI_LABEL=3Dy
CONFIG_ISA_DMA_API=3Dy
CONFIG_AMD_NB=3Dy
CONFIG_PCCARD=3Dm
CONFIG_PCMCIA=3Dm
CONFIG_PCMCIA_LOAD_CIS=3Dy
CONFIG_CARDBUS=3Dy

#
# PC-card bridges
#
CONFIG_YENTA=3Dm
CONFIG_YENTA_O2=3Dy
CONFIG_YENTA_RICOH=3Dy
CONFIG_YENTA_TI=3Dy
CONFIG_YENTA_ENE_TUNE=3Dy
CONFIG_YENTA_TOSHIBA=3Dy
CONFIG_PD6729=3Dm
CONFIG_I82092=3Dm
CONFIG_PCCARD_NONSTATIC=3Dy
CONFIG_HOTPLUG_PCI=3Dm
# CONFIG_HOTPLUG_PCI_FAKE is not set
CONFIG_HOTPLUG_PCI_ACPI=3Dm
CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set
# CONFIG_RAPIDIO is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_COMPAT_BINFMT_ELF=3Dy
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=3Dm
CONFIG_IA32_EMULATION=3Dy
# CONFIG_IA32_AOUT is not set
CONFIG_COMPAT=3Dy
CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
CONFIG_KEYS_COMPAT=3Dy
CONFIG_HAVE_TEXT_POKE_SMP=3Dy
CONFIG_NET=3Dy
CONFIG_COMPAT_NETLINK_MESSAGES=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_UNIX=3Dy
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=3Dy
CONFIG_XFRM_STATISTICS=3Dy
CONFIG_XFRM_IPCOMP=3Dm
CONFIG_NET_KEY=3Dm
CONFIG_NET_KEY_MIGRATE=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_ROUTE_CLASSID=3Dy
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
CONFIG_IP_PNP_BOOTP=3Dy
CONFIG_IP_PNP_RARP=3Dy
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE_DEMUX=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_NET_IPGRE_BROADCAST=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_XFRM_TUNNEL=3Dm
CONFIG_INET_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_BEET=3Dm
CONFIG_INET_LRO=3Dy
CONFIG_INET_DIAG=3Dm
CONFIG_INET_TCP_DIAG=3Dm
CONFIG_TCP_CONG_ADVANCED=3Dy
CONFIG_TCP_CONG_BIC=3Dm
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_TCP_CONG_WESTWOOD=3Dm
CONFIG_TCP_CONG_HTCP=3Dm
CONFIG_TCP_CONG_HSTCP=3Dm
CONFIG_TCP_CONG_HYBLA=3Dm
CONFIG_TCP_CONG_VEGAS=3Dm
CONFIG_TCP_CONG_SCALABLE=3Dm
CONFIG_TCP_CONG_LP=3Dm
CONFIG_TCP_CONG_VENO=3Dm
CONFIG_TCP_CONG_YEAH=3Dm
CONFIG_TCP_CONG_ILLINOIS=3Dm
CONFIG_DEFAULT_CUBIC=3Dy
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
CONFIG_TCP_MD5SIG=3Dy
CONFIG_IPV6=3Dm
CONFIG_IPV6_PRIVACY=3Dy
CONFIG_IPV6_ROUTER_PREF=3Dy
CONFIG_IPV6_ROUTE_INFO=3Dy
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_IPCOMP=3Dm
CONFIG_IPV6_MIP6=3Dm
CONFIG_INET6_XFRM_TUNNEL=3Dm
CONFIG_INET6_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET6_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_BEET=3Dm
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=3Dm
CONFIG_IPV6_SIT=3Dm
CONFIG_IPV6_SIT_6RD=3Dy
CONFIG_IPV6_NDISC_NODETYPE=3Dy
CONFIG_IPV6_TUNNEL=3Dm
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_SUBTREES=3Dy
CONFIG_IPV6_MROUTE=3Dy
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_PIMSM_V2=3Dy
CONFIG_NETLABEL=3Dy
CONFIG_NETWORK_SECMARK=3Dy
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=3Dy
CONFIG_BRIDGE_NETFILTER=3Dy

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=3Dm
CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
CONFIG_NETFILTER_NETLINK_LOG=3Dm
CONFIG_NF_CONNTRACK=3Dm
CONFIG_NF_CONNTRACK_MARK=3Dy
CONFIG_NF_CONNTRACK_SECMARK=3Dy
CONFIG_NF_CONNTRACK_ZONES=3Dy
CONFIG_NF_CONNTRACK_EVENTS=3Dy
CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
CONFIG_NF_CT_PROTO_DCCP=3Dm
CONFIG_NF_CT_PROTO_GRE=3Dm
CONFIG_NF_CT_PROTO_SCTP=3Dm
CONFIG_NF_CT_PROTO_UDPLITE=3Dm
CONFIG_NF_CONNTRACK_AMANDA=3Dm
CONFIG_NF_CONNTRACK_FTP=3Dm
CONFIG_NF_CONNTRACK_H323=3Dm
CONFIG_NF_CONNTRACK_IRC=3Dm
CONFIG_NF_CONNTRACK_BROADCAST=3Dm
CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
CONFIG_NF_CONNTRACK_SNMP=3Dm
CONFIG_NF_CONNTRACK_PPTP=3Dm
CONFIG_NF_CONNTRACK_SANE=3Dm
CONFIG_NF_CONNTRACK_SIP=3Dm
CONFIG_NF_CONNTRACK_TFTP=3Dm
CONFIG_NF_CT_NETLINK=3Dm
CONFIG_NETFILTER_TPROXY=3Dm
CONFIG_NETFILTER_XTABLES=3Dm

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=3Dm
CONFIG_NETFILTER_XT_CONNMARK=3Dm
CONFIG_NETFILTER_XT_SET=3Dm

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dm
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CT=3Dm
CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
CONFIG_NETFILTER_XT_TARGET_HL=3Dm
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
CONFIG_NETFILTER_XT_TARGET_LED=3Dm
CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
CONFIG_NETFILTER_XT_MATCH_HL=3Dm
CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
CONFIG_NETFILTER_XT_MATCH_TIME=3Dm
CONFIG_NETFILTER_XT_MATCH_U32=3Dm
CONFIG_IP_SET=3Dm
CONFIG_IP_SET_MAX=3D256
CONFIG_IP_SET_BITMAP_IP=3Dm
CONFIG_IP_SET_BITMAP_IPMAC=3Dm
CONFIG_IP_SET_BITMAP_PORT=3Dm
CONFIG_IP_SET_HASH_IP=3Dm
CONFIG_IP_SET_HASH_IPPORT=3Dm
CONFIG_IP_SET_HASH_IPPORTIP=3Dm
CONFIG_IP_SET_HASH_IPPORTNET=3Dm
CONFIG_IP_SET_HASH_NET=3Dm
CONFIG_IP_SET_HASH_NETPORT=3Dm
CONFIG_IP_SET_HASH_NETIFACE=3Dm
CONFIG_IP_SET_LIST_SET=3Dm
CONFIG_IP_VS=3Dm
CONFIG_IP_VS_IPV6=3Dy
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=3D12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=3Dy
CONFIG_IP_VS_PROTO_UDP=3Dy
CONFIG_IP_VS_PROTO_AH_ESP=3Dy
CONFIG_IP_VS_PROTO_ESP=3Dy
CONFIG_IP_VS_PROTO_AH=3Dy
CONFIG_IP_VS_PROTO_SCTP=3Dy

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=3Dm
CONFIG_IP_VS_WRR=3Dm
CONFIG_IP_VS_LC=3Dm
CONFIG_IP_VS_WLC=3Dm
CONFIG_IP_VS_LBLC=3Dm
CONFIG_IP_VS_LBLCR=3Dm
CONFIG_IP_VS_DH=3Dm
CONFIG_IP_VS_SH=3Dm
CONFIG_IP_VS_SED=3Dm
CONFIG_IP_VS_NQ=3Dm

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=3Dm
CONFIG_IP_VS_NFCT=3Dy
CONFIG_IP_VS_PE_SIP=3Dm

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=3Dm
CONFIG_NF_CONNTRACK_IPV4=3Dm
CONFIG_NF_CONNTRACK_PROC_COMPAT=3Dy
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_AH=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_NF_NAT=3Dm
CONFIG_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_NETMAP=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_NF_NAT_SNMP_BASIC=3Dm
CONFIG_NF_NAT_PROTO_DCCP=3Dm
CONFIG_NF_NAT_PROTO_GRE=3Dm
CONFIG_NF_NAT_PROTO_UDPLITE=3Dm
CONFIG_NF_NAT_PROTO_SCTP=3Dm
CONFIG_NF_NAT_FTP=3Dm
CONFIG_NF_NAT_IRC=3Dm
CONFIG_NF_NAT_TFTP=3Dm
CONFIG_NF_NAT_AMANDA=3Dm
CONFIG_NF_NAT_PPTP=3Dm
CONFIG_NF_NAT_H323=3Dm
CONFIG_NF_NAT_SIP=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_TTL=3Dm
CONFIG_IP_NF_RAW=3Dm
CONFIG_IP_NF_SECURITY=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=3Dm
CONFIG_NF_CONNTRACK_IPV6=3Dm
CONFIG_IP6_NF_QUEUE=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_AH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_MH=3Dm
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_TARGET_HL=3Dm
CONFIG_IP6_NF_TARGET_LOG=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_REJECT=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_RAW=3Dm
CONFIG_IP6_NF_SECURITY=3Dm
CONFIG_BRIDGE_NF_EBTABLES=3Dm
CONFIG_BRIDGE_EBT_BROUTE=3Dm
CONFIG_BRIDGE_EBT_T_FILTER=3Dm
CONFIG_BRIDGE_EBT_T_NAT=3Dm
CONFIG_BRIDGE_EBT_802_3=3Dm
CONFIG_BRIDGE_EBT_AMONG=3Dm
CONFIG_BRIDGE_EBT_ARP=3Dm
CONFIG_BRIDGE_EBT_IP=3Dm
CONFIG_BRIDGE_EBT_IP6=3Dm
CONFIG_BRIDGE_EBT_LIMIT=3Dm
CONFIG_BRIDGE_EBT_MARK=3Dm
CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
CONFIG_BRIDGE_EBT_STP=3Dm
CONFIG_BRIDGE_EBT_VLAN=3Dm
CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
CONFIG_BRIDGE_EBT_DNAT=3Dm
CONFIG_BRIDGE_EBT_MARK_T=3Dm
CONFIG_BRIDGE_EBT_REDIRECT=3Dm
CONFIG_BRIDGE_EBT_SNAT=3Dm
CONFIG_BRIDGE_EBT_LOG=3Dm
CONFIG_BRIDGE_EBT_ULOG=3Dm
CONFIG_BRIDGE_EBT_NFLOG=3Dm
CONFIG_IP_DCCP=3Dm
CONFIG_INET_DCCP_DIAG=3Dm

#
# DCCP CCIDs Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=3Dy
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=3Dy

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=3Dm
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=3Dy
CONFIG_RDS=3Dm
CONFIG_RDS_TCP=3Dm
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=3Dm
CONFIG_TIPC_ADVANCED=3Dy
CONFIG_TIPC_PORTS=3D8191
CONFIG_TIPC_LOG=3D0
# CONFIG_TIPC_DEBUG is not set
# CONFIG_ATM is not set
CONFIG_L2TP=3Dm
# CONFIG_L2TP_DEBUGFS is not set
CONFIG_L2TP_V3=3Dy
CONFIG_L2TP_IP=3Dm
CONFIG_L2TP_ETH=3Dm
CONFIG_STP=3Dm
CONFIG_GARP=3Dm
CONFIG_BRIDGE=3Dm
CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=3Dm
CONFIG_VLAN_8021Q_GVRP=3Dy
# CONFIG_DECNET is not set
CONFIG_LLC=3Dm
CONFIG_LLC2=3Dm
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
CONFIG_X25=3Dm
CONFIG_LAPB=3Dm
CONFIG_ECONET=3Dm
CONFIG_ECONET_AUNUDP=3Dy
# CONFIG_ECONET_NATIVE is not set
CONFIG_WAN_ROUTER=3Dm
# CONFIG_PHONET is not set
CONFIG_IEEE802154=3Dm
CONFIG_IEEE802154_6LOWPAN=3Dm
CONFIG_NET_SCHED=3Dy

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_MULTIQ=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFB=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_NETEM=3Dm
CONFIG_NET_SCH_DRR=3Dm
CONFIG_NET_SCH_MQPRIO=3Dm
CONFIG_NET_SCH_CHOKE=3Dm
CONFIG_NET_SCH_QFQ=3Dm
CONFIG_NET_SCH_INGRESS=3Dm

#
# Classification
#
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_BASIC=3Dm
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_CLS_U32_PERF=3Dy
CONFIG_CLS_U32_MARK=3Dy
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_FLOW=3Dm
CONFIG_NET_CLS_CGROUP=3Dm
CONFIG_NET_EMATCH=3Dy
CONFIG_NET_EMATCH_STACK=3D32
CONFIG_NET_EMATCH_CMP=3Dm
CONFIG_NET_EMATCH_NBYTE=3Dm
CONFIG_NET_EMATCH_U32=3Dm
CONFIG_NET_EMATCH_META=3Dm
CONFIG_NET_EMATCH_TEXT=3Dm
CONFIG_NET_CLS_ACT=3Dy
CONFIG_NET_ACT_POLICE=3Dm
CONFIG_NET_ACT_GACT=3Dm
# CONFIG_GACT_PROB is not set
CONFIG_NET_ACT_MIRRED=3Dm
CONFIG_NET_ACT_IPT=3Dm
CONFIG_NET_ACT_NAT=3Dm
CONFIG_NET_ACT_PEDIT=3Dm
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_ACT_SKBEDIT=3Dm
CONFIG_NET_ACT_CSUM=3Dm
CONFIG_NET_CLS_IND=3Dy
CONFIG_NET_SCH_FIFO=3Dy
CONFIG_DCB=3Dy
CONFIG_DNS_RESOLVER=3Dm
# CONFIG_BATMAN_ADV is not set
CONFIG_RPS=3Dy
CONFIG_RFS_ACCEL=3Dy
CONFIG_XPS=3Dy
CONFIG_HAVE_BPF_JIT=3Dy
CONFIG_BPF_JIT=3Dy

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
CONFIG_CAN=3Dm
CONFIG_CAN_RAW=3Dm
CONFIG_CAN_BCM=3Dm
CONFIG_CAN_GW=3Dm

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=3Dm
CONFIG_CAN_SLCAN=3Dm
CONFIG_CAN_DEV=3Dm
CONFIG_CAN_CALC_BITTIMING=3Dy
# CONFIG_PCH_CAN is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_C_CAN is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_SOFTING is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_IRDA is not set
CONFIG_BT=3Dm
CONFIG_BT_L2CAP=3Dy
CONFIG_BT_SCO=3Dy
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_HIDP=3Dm

#
# Bluetooth device drivers
#
CONFIG_BT_HCIBTUSB=3Dm
CONFIG_BT_HCIBTSDIO=3Dm
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
# CONFIG_BT_HCIUART_ATH3K is not set
CONFIG_BT_HCIUART_LL=3Dy
CONFIG_BT_HCIBCM203X=3Dm
CONFIG_BT_HCIBPA10X=3Dm
CONFIG_BT_HCIBFUSB=3Dm
CONFIG_BT_HCIDTL1=3Dm
CONFIG_BT_HCIBT3C=3Dm
CONFIG_BT_HCIBLUECARD=3Dm
CONFIG_BT_HCIBTUART=3Dm
CONFIG_BT_HCIVHCI=3Dm
# CONFIG_BT_MRVL is not set
# CONFIG_BT_ATH3K is not set
CONFIG_AF_RXRPC=3Dm
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=3Dm
CONFIG_FIB_RULES=3Dy
CONFIG_WIRELESS=3Dy
CONFIG_WEXT_CORE=3Dy
CONFIG_WEXT_PROC=3Dy
CONFIG_CFG80211=3Dm
CONFIG_NL80211_TESTMODE=3Dy
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_REG_DEBUG is not set
CONFIG_CFG80211_DEFAULT_PS=3Dy
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_INTERNAL_REGDB is not set
CONFIG_CFG80211_WEXT=3Dy
CONFIG_WIRELESS_EXT_SYSFS=3Dy
CONFIG_LIB80211=3Dm
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=3Dm
CONFIG_MAC80211_HAS_RC=3Dy
CONFIG_MAC80211_RC_MINSTREL=3Dy
CONFIG_MAC80211_RC_MINSTREL_HT=3Dy
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=3Dy
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_WIMAX=3Dm
CONFIG_WIMAX_DEBUG_LEVEL=3D8
CONFIG_RFKILL=3Dm
CONFIG_RFKILL_LEDS=3Dy
CONFIG_RFKILL_INPUT=3Dy
CONFIG_RFKILL_REGULATOR=3Dm
# CONFIG_NET_9P is not set
CONFIG_CAIF=3Dm
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=3Dm
CONFIG_CEPH_LIB=3Dm
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=3Dy
CONFIG_NFC=3Dm
CONFIG_NFC_NCI=3Dm

#
# Near Field Communication (NFC) devices
#
# CONFIG_PN544_NFC is not set
# CONFIG_NFC_PN533 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
CONFIG_DEVTMPFS=3Dy
CONFIG_DEVTMPFS_MOUNT=3Dy
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=3D""
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=3Dm
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=3Dy
CONFIG_BLK_DEV=3Dy
CONFIG_BLK_DEV_FD=3Dm
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
CONFIG_BLK_DEV_DRBD=3Dm
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_OSD=3Dm
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D16384
# CONFIG_BLK_DEV_XIP is not set
CONFIG_CDROM_PKTCDVD=3Dm
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
CONFIG_CDROM_PKTCDVD_WCACHE=3Dy
CONFIG_ATA_OVER_ETH=3Dm
CONFIG_VIRTIO_BLK=3Dm
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_RBD=3Dm
# CONFIG_SENSORS_LIS3LV02D is not set
CONFIG_MISC_DEVICES=3Dy
# CONFIG_AD525X_DPOT is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_INTEL_MID_PTI is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=3Dm
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1780 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=3Dm
# CONFIG_BMP085 is not set
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=3Dm
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_CB710_CORE is not set
CONFIG_IWMC3200TOP=3Dm
# CONFIG_IWMC3200TOP_DEBUG is not set
# CONFIG_IWMC3200TOP_DEBUGFS is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_HAVE_IDE=3Dy
CONFIG_IDE=3Dm

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=3Dy
CONFIG_IDE_ATAPI=3Dy
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=3Dm
CONFIG_IDE_GD_ATA=3Dy
# CONFIG_IDE_GD_ATAPI is not set
CONFIG_BLK_DEV_IDECS=3Dm
# CONFIG_BLK_DEV_DELKIN is not set
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=3Dy
CONFIG_BLK_DEV_IDETAPE=3Dm
CONFIG_BLK_DEV_IDEACPI=3Dy
CONFIG_IDE_TASK_IOCTL=3Dy
CONFIG_IDE_PROC_FS=3Dy

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=3Dm
CONFIG_BLK_DEV_PLATFORM=3Dm
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=3Dm
CONFIG_BLK_DEV_IDEDMA_SFF=3Dy

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=3Dm
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=3Dm
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set
CONFIG_BLK_DEV_IDEDMA=3Dy

#
# SCSI device support
#
CONFIG_SCSI_MOD=3Dm
CONFIG_RAID_ATTRS=3Dm
CONFIG_SCSI=3Dm
CONFIG_SCSI_DMA=3Dy
# CONFIG_SCSI_TGT is not set
CONFIG_SCSI_NETLINK=3Dy
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
CONFIG_CHR_DEV_SCH=3Dm
CONFIG_SCSI_ENCLOSURE=3Dm
CONFIG_SCSI_MULTI_LUN=3Dy
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=3Dy
CONFIG_SCSI_SCAN_ASYNC=3Dy
CONFIG_SCSI_WAIT_SCAN=3Dm

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dm
CONFIG_SCSI_FC_ATTRS=3Dm
CONFIG_SCSI_ISCSI_ATTRS=3Dm
CONFIG_SCSI_SAS_ATTRS=3Dm
CONFIG_SCSI_SAS_LIBSAS=3Dm
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=3Dy
CONFIG_SCSI_SRP_ATTRS=3Dm
CONFIG_SCSI_LOWLEVEL=3Dy
CONFIG_ISCSI_TCP=3Dm
CONFIG_ISCSI_BOOT_SYSFS=3Dm
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_SCSI_BNX2X_FCOE is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_VMWARE_PVSCSI=3Dm
CONFIG_LIBFC=3Dm
CONFIG_LIBFCOE=3Dm
CONFIG_FCOE=3Dm
# CONFIG_FCOE_FNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_SRP is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
CONFIG_SCSI_DH=3Dm
CONFIG_SCSI_DH_RDAC=3Dm
# CONFIG_SCSI_DH_HP_SW is not set
# CONFIG_SCSI_DH_EMC is not set
CONFIG_SCSI_DH_ALUA=3Dm
CONFIG_SCSI_OSD_INITIATOR=3Dm
CONFIG_SCSI_OSD_ULD=3Dm
CONFIG_SCSI_OSD_DPRINT_SENSE=3D1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=3Dm
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=3Dy
CONFIG_ATA_ACPI=3Dy
CONFIG_SATA_PMP=3Dy

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=3Dm
CONFIG_SATA_AHCI_PLATFORM=3Dm
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=3Dy

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=3Dy

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=3Dm
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARASAN_CF is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=3Dm
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
CONFIG_PATA_MPIIX=3Dm
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PCMCIA is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=3Dm
CONFIG_ATA_GENERIC=3Dm
CONFIG_PATA_LEGACY=3Dm
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dm
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID10=3Dm
CONFIG_MD_RAID456=3Dm
CONFIG_MULTICORE_RAID456=3Dy
CONFIG_MD_MULTIPATH=3Dm
CONFIG_MD_FAULTY=3Dm
CONFIG_BLK_DEV_DM=3Dm
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=3Dm
CONFIG_DM_PERSISTENT_DATA=3Dm
CONFIG_DM_CRYPT=3Dm
CONFIG_DM_SNAPSHOT=3Dm
CONFIG_DM_THIN_PROVISIONING=3Dm
# CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
# CONFIG_DM_DEBUG_SPACE_MAPS is not set
CONFIG_DM_MIRROR=3Dm
CONFIG_DM_RAID=3Dm
CONFIG_DM_LOG_USERSPACE=3Dm
CONFIG_DM_ZERO=3Dm
CONFIG_DM_MULTIPATH=3Dm
CONFIG_DM_MULTIPATH_QL=3Dm
CONFIG_DM_MULTIPATH_ST=3Dm
# CONFIG_DM_DELAY is not set
# CONFIG_DM_UEVENT is not set
# CONFIG_DM_FLAKEY is not set
CONFIG_TARGET_CORE=3Dm
CONFIG_TCM_IBLOCK=3Dm
CONFIG_TCM_FILEIO=3Dm
CONFIG_TCM_PSCSI=3Dm
CONFIG_LOOPBACK_TARGET=3Dm
CONFIG_TCM_FC=3Dm
CONFIG_ISCSI_TARGET=3Dm
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=3Dm
CONFIG_FIREWIRE_OHCI=3Dm
CONFIG_FIREWIRE_OHCI_DEBUG=3Dy
CONFIG_FIREWIRE_SBP2=3Dm
CONFIG_FIREWIRE_NET=3Dm
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_I2O=3Dm
CONFIG_I2O_LCT_NOTIFY_ON_CHANGES=3Dy
# CONFIG_I2O_EXT_ADAPTEC is not set
CONFIG_I2O_CONFIG=3Dm
CONFIG_I2O_CONFIG_OLD_IOCTL=3Dy
CONFIG_I2O_BUS=3Dm
CONFIG_I2O_BLOCK=3Dm
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dm
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=3Dy
CONFIG_NET_CORE=3Dy
CONFIG_BONDING=3Dm
CONFIG_DUMMY=3Dm
CONFIG_EQUALIZER=3Dm
CONFIG_NET_FC=3Dy
CONFIG_MII=3Dm
CONFIG_IEEE802154_DRIVERS=3Dm
# CONFIG_IEEE802154_FAKEHARD is not set
CONFIG_IFB=3Dm
CONFIG_MACVLAN=3Dm
CONFIG_MACVTAP=3Dm
CONFIG_NETCONSOLE=3Dm
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=3Dy
CONFIG_NETPOLL_TRAP=3Dy
CONFIG_NET_POLL_CONTROLLER=3Dy
CONFIG_TUN=3Dm
CONFIG_VETH=3Dm
CONFIG_VIRTIO_NET=3Dm
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#
CONFIG_CAIF_TTY=3Dm
# CONFIG_CAIF_SPI_SLAVE is not set
# CONFIG_CAIF_HSI is not set
CONFIG_ETHERNET=3Dy
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_FUJITSU is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_INTEL=3Dy
# CONFIG_E100 is not set
# CONFIG_E1000 is not set
CONFIG_E1000E=3Dm
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_NET_VENDOR_I825XX is not set
# CONFIG_IP1000 is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_PACKET_ENGINE is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_SFC is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_XIRCOM is not set
# CONFIG_FDDI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=3Dy

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_LXT_PHY=3Dm
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MICREL_PHY is not set
CONFIG_FIXED_PHY=3Dy
CONFIG_MDIO_BITBANG=3Dm
CONFIG_MDIO_GPIO=3Dm
CONFIG_PPP=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_MPPE=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPPOE=3Dm
CONFIG_PPTP=3Dm
CONFIG_PPPOL2TP=3Dm
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLHC=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy
# CONFIG_TR is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_USBNET=3Dm
CONFIG_USB_NET_AX8817X=3Dm
CONFIG_USB_NET_CDCETHER=3Dm
CONFIG_USB_NET_CDC_EEM=3Dm
CONFIG_USB_NET_CDC_NCM=3Dm
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
CONFIG_USB_NET_NET1080=3Dm
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
CONFIG_USB_NET_RNDIS_HOST=3Dm
CONFIG_USB_NET_CDC_SUBSET=3Dm
# CONFIG_USB_ALI_M5632 is not set
# CONFIG_USB_AN2720 is not set
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_ARMLINUX=3Dy
# CONFIG_USB_EPSON2888 is not set
# CONFIG_USB_KC2190 is not set
CONFIG_USB_NET_ZAURUS=3Dm
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
CONFIG_USB_IPHETH=3Dm
CONFIG_USB_SIERRA_NET=3Dm
# CONFIG_USB_VL600 is not set
CONFIG_WLAN=3Dy
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_AIRO is not set
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set
# CONFIG_PRISM54 is not set
# CONFIG_USB_ZD1201 is not set
CONFIG_USB_NET_RNDIS_WLAN=3Dm
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_ADM8211 is not set
CONFIG_MAC80211_HWSIM=3Dm
# CONFIG_MWL8K is not set
CONFIG_ATH_COMMON=3Dm
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH5K=3Dm
# CONFIG_ATH5K_DEBUG is not set
# CONFIG_ATH5K_TRACER is not set
CONFIG_ATH5K_PCI=3Dy
CONFIG_ATH9K_HW=3Dm
CONFIG_ATH9K_COMMON=3Dm
CONFIG_ATH9K=3Dm
CONFIG_ATH9K_PCI=3Dy
# CONFIG_ATH9K_AHB is not set
# CONFIG_ATH9K_DEBUGFS is not set
CONFIG_ATH9K_RATE_CONTROL=3Dy
CONFIG_ATH9K_HTC=3Dm
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
# CONFIG_HOSTAP is not set
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLWIFI=3Dm

#
# Debugging Options
#
CONFIG_IWLWIFI_DEBUG=3Dy
CONFIG_IWLWIFI_DEBUG_EXPERIMENTAL_UCODE=3Dy
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
CONFIG_IWLWIFI_DEVICE_SVTOOL=3Dy
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWM is not set
# CONFIG_LIBERTAS is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_RT2X00 is not set
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_WL1251 is not set
# CONFIG_WL12XX_MENU is not set
# CONFIG_ZD1211RW is not set
# CONFIG_MWIFIEX is not set

#
# WiMAX Wireless Broadband devices
#
CONFIG_WIMAX_I2400M=3Dm
CONFIG_WIMAX_I2400M_USB=3Dm
CONFIG_WIMAX_I2400M_SDIO=3Dm
CONFIG_WIMAX_IWMC3200_SDIO=3Dy
CONFIG_WIMAX_I2400M_DEBUG_LEVEL=3D8
# CONFIG_WAN is not set
CONFIG_VMXNET3=3Dm
# CONFIG_ISDN is not set
CONFIG_PHONE=3Dm
CONFIG_PHONE_IXJ=3Dm
CONFIG_PHONE_IXJ_PCMCIA=3Dm

#
# Input device support
#
CONFIG_INPUT=3Dy
CONFIG_INPUT_FF_MEMLESS=3Dm
CONFIG_INPUT_POLLDEV=3Dm
CONFIG_INPUT_SPARSEKMAP=3Dm

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dm
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=3Dm
CONFIG_KEYBOARD_GPIO_POLLED=3Dm
# CONFIG_KEYBOARD_TCA6416 is not set
CONFIG_KEYBOARD_MATRIX=3Dm
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_XTKBD=3Dm
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dm
CONFIG_MOUSE_PS2_ALPS=3Dy
CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_SERIAL=3Dm
# CONFIG_MOUSE_APPLETOUCH is not set
CONFIG_MOUSE_BCM5974=3Dm
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=3Dm
CONFIG_MOUSE_SYNAPTICS_I2C=3Dm
CONFIG_INPUT_JOYSTICK=3Dy
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=3Dm
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=3Dm
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=3Dm
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_PCSPKR=3Dm
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_MPU3050 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=3Dm
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_CMA3000 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dm
CONFIG_SERIO_CT82C710=3Dm
CONFIG_SERIO_PCIPS2=3Dm
CONFIG_SERIO_LIBPS2=3Dy
CONFIG_SERIO_RAW=3Dm
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_GAMEPORT=3Dm
CONFIG_GAMEPORT_NS558=3Dm
CONFIG_GAMEPORT_L4=3Dm
CONFIG_GAMEPORT_EMU10K1=3Dm
CONFIG_GAMEPORT_FM801=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_VT_CONSOLE_SLEEP=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_VT_HW_CONSOLE_BINDING=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_DEVPTS_MULTIPLE_INSTANCES=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_NOZOMI=3Dm
CONFIG_N_GSM=3Dm
# CONFIG_TRACE_SINK is not set
CONFIG_DEVKMEM=3Dy

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_FIX_EARLYCON_MEM=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
CONFIG_SERIAL_8250_PNP=3Dy
CONFIG_SERIAL_8250_CS=3Dm
CONFIG_SERIAL_8250_NR_UARTS=3D8
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
CONFIG_SERIAL_8250_EXTENDED=3Dy
CONFIG_SERIAL_8250_MANY_PORTS=3Dy
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
CONFIG_SERIAL_8250_RSA=3Dy

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MFD_HSU is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_SERIAL_JSM=3Dm
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_HVC_DRIVER=3Dy
CONFIG_VIRTIO_CONSOLE=3Dm
CONFIG_IPMI_HANDLER=3Dm
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=3Dm
CONFIG_IPMI_SI=3Dm
CONFIG_IPMI_WATCHDOG=3Dm
CONFIG_IPMI_POWEROFF=3Dm
CONFIG_HW_RANDOM=3Dy
CONFIG_HW_RANDOM_TIMERIOMEM=3Dm
CONFIG_HW_RANDOM_INTEL=3Dm
CONFIG_HW_RANDOM_AMD=3Dy
CONFIG_HW_RANDOM_VIA=3Dy
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=3Dm
# CONFIG_R3964 is not set
CONFIG_APPLICOM=3Dm

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=3Dm
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
CONFIG_IPWIRELESS=3Dm
CONFIG_MWAVE=3Dm
CONFIG_RAW_DRIVER=3Dm
CONFIG_MAX_RAW_DEVS=3D1024
CONFIG_HPET=3Dy
CONFIG_HPET_MMAP=3Dy
CONFIG_HANGCHECK_TIMER=3Dm
CONFIG_TCG_TPM=3Dm
CONFIG_TCG_TIS=3Dm
CONFIG_TCG_NSC=3Dm
CONFIG_TCG_ATMEL=3Dm
CONFIG_TCG_INFINEON=3Dm
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=3Dy
CONFIG_RAMOOPS=3Dm
CONFIG_I2C=3Dy
CONFIG_I2C_BOARDINFO=3Dy
CONFIG_I2C_COMPAT=3Dy
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_MUX=3Dm

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=3Dm
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_HELPER_AUTO=3Dy
CONFIG_I2C_SMBUS=3Dm
CONFIG_I2C_ALGOBIT=3Dy

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=3Dm
CONFIG_I2C_ISCH=3Dm
CONFIG_I2C_PIIX4=3Dm
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=3Dm

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_GPIO=3Dm
CONFIG_I2C_INTEL_MID=3Dm
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set
# CONFIG_I2C_EG20T is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT_LIGHT=3Dm
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set

#
# PPS support
#
CONFIG_PPS=3Dm
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=3Dm
CONFIG_PPS_CLIENT_GPIO=3Dm

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=3Dm

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional cloc=
ks.
#
CONFIG_PINCTRL=3Dy
CONFIG_PINMUX=3Dy
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
CONFIG_GPIOLIB=3Dy
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=3Dy
CONFIG_GPIO_GENERIC=3Dm

#
# Memory mapped GPIO drivers:
#
CONFIG_GPIO_GENERIC_PLATFORM=3Dm
# CONFIG_GPIO_IT8761E is not set
CONFIG_GPIO_SCH=3Dm
# CONFIG_GPIO_VX855 is not set

#
# I2C GPIO expanders:
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_SX150X is not set
# CONFIG_GPIO_ADP5588 is not set

#
# PCI GPIO expanders:
#
CONFIG_GPIO_BT8XX=3Dm
# CONFIG_GPIO_LANGWELL is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders:
#
# CONFIG_GPIO_MCP23S08 is not set

#
# AC97 GPIO expanders:
#

#
# MODULbus GPIO expanders:
#
CONFIG_W1=3Dm
CONFIG_W1_CON=3Dy

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=3Dm
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2760 is not set
# CONFIG_W1_SLAVE_DS2780 is not set
# CONFIG_W1_SLAVE_BQ27000 is not set
CONFIG_POWER_SUPPLY=3Dy
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=3Dm
CONFIG_TEST_POWER=3Dm
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_BQ20Z75 is not set
# CONFIG_BATTERY_BQ27x00 is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_GPIO=3Dm
CONFIG_HWMON=3Dy
# CONFIG_HWMON_VID is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_GPIO_FAN=3Dm
CONFIG_SENSORS_CORETEMP=3Dm
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=3Dm
CONFIG_SENSORS_PMBUS=3Dm
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LTC2978 is not set
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_UCD9000 is not set
# CONFIG_SENSORS_UCD9200 is not set
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_APPLESMC is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=3Dm
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=3Dy
CONFIG_THERMAL_HWMON=3Dy
CONFIG_WATCHDOG=3Dy
CONFIG_WATCHDOG_CORE=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=3Dm
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SC520_WDT is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=3Dm
CONFIG_ITCO_WDT=3Dm
CONFIG_ITCO_VENDOR_SUPPORT=3Dy
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83697HF_WDT is not set
# CONFIG_W83697UG_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=3Dy

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=3Dy

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=3Dm
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_LPC_SCH=3Dm
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_REGULATOR=3Dy
# CONFIG_REGULATOR_DEBUG is not set
# CONFIG_REGULATOR_DUMMY is not set
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=3Dm
CONFIG_REGULATOR_GPIO=3Dm
# CONFIG_REGULATOR_BQ24022 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_MEDIA_SUPPORT=3Dm

#
# Multimedia core support
#
CONFIG_MEDIA_CONTROLLER=3Dy
CONFIG_VIDEO_DEV=3Dm
CONFIG_VIDEO_V4L2_COMMON=3Dm
CONFIG_VIDEO_V4L2_SUBDEV_API=3Dy
CONFIG_DVB_CORE=3Dm
CONFIG_DVB_NET=3Dy
CONFIG_VIDEO_MEDIA=3Dm

#
# Multimedia drivers
#
CONFIG_RC_CORE=3Dm
CONFIG_LIRC=3Dm
CONFIG_RC_MAP=3Dm
CONFIG_IR_NEC_DECODER=3Dm
CONFIG_IR_RC5_DECODER=3Dm
CONFIG_IR_RC6_DECODER=3Dm
CONFIG_IR_JVC_DECODER=3Dm
CONFIG_IR_SONY_DECODER=3Dm
CONFIG_IR_RC5_SZ_DECODER=3Dm
CONFIG_IR_MCE_KBD_DECODER=3Dm
CONFIG_IR_LIRC_CODEC=3Dm
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=3Dm
CONFIG_RC_LOOPBACK=3Dm
# CONFIG_MEDIA_ATTACH is not set
CONFIG_MEDIA_TUNER=3Dm
# CONFIG_MEDIA_TUNER_CUSTOMISE is not set
CONFIG_MEDIA_TUNER_SIMPLE=3Dm
CONFIG_MEDIA_TUNER_TDA8290=3Dm
CONFIG_MEDIA_TUNER_TDA827X=3Dm
CONFIG_MEDIA_TUNER_TDA18271=3Dm
CONFIG_MEDIA_TUNER_TDA9887=3Dm
CONFIG_MEDIA_TUNER_TEA5761=3Dm
CONFIG_MEDIA_TUNER_TEA5767=3Dm
CONFIG_MEDIA_TUNER_MT20XX=3Dm
CONFIG_MEDIA_TUNER_MT2060=3Dm
CONFIG_MEDIA_TUNER_MT2266=3Dm
CONFIG_MEDIA_TUNER_QT1010=3Dm
CONFIG_MEDIA_TUNER_XC2028=3Dm
CONFIG_MEDIA_TUNER_XC5000=3Dm
CONFIG_MEDIA_TUNER_XC4000=3Dm
CONFIG_MEDIA_TUNER_MXL5005S=3Dm
CONFIG_MEDIA_TUNER_MXL5007T=3Dm
CONFIG_MEDIA_TUNER_MC44S803=3Dm
CONFIG_MEDIA_TUNER_TDA18218=3Dm
CONFIG_VIDEO_V4L2=3Dm
CONFIG_VIDEOBUF_GEN=3Dm
CONFIG_VIDEOBUF_DMA_CONTIG=3Dm
CONFIG_VIDEOBUF2_CORE=3Dm
CONFIG_VIDEOBUF2_MEMOPS=3Dm
CONFIG_VIDEOBUF2_VMALLOC=3Dm
CONFIG_VIDEO_CAPTURE_DRIVERS=3Dy
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_HELPER_CHIPS_AUTO=3Dy
CONFIG_VIDEO_IR_I2C=3Dm

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=3Dm

#
# Video and audio decoders
#

#
# MPEG video encoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Miscelaneous helper chips
#
CONFIG_VIDEO_VIVI=3Dm
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_CPIA2 is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
CONFIG_VIDEO_TIMBERDALE=3Dm
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_CX23885 is not set
# CONFIG_VIDEO_CX25821 is not set
# CONFIG_VIDEO_AU0828 is not set
# CONFIG_VIDEO_IVTV is not set
# CONFIG_VIDEO_CX18 is not set
# CONFIG_VIDEO_SAA7164 is not set
# CONFIG_VIDEO_CAFE_CCIC is not set
# CONFIG_SOC_CAMERA is not set
CONFIG_V4L_USB_DRIVERS=3Dy
CONFIG_USB_VIDEO_CLASS=3Dm
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy
CONFIG_USB_GSPCA=3Dm
CONFIG_USB_M5602=3Dm
CONFIG_USB_STV06XX=3Dm
CONFIG_USB_GL860=3Dm
# CONFIG_USB_GSPCA_BENQ is not set
CONFIG_USB_GSPCA_CONEX=3Dm
# CONFIG_USB_GSPCA_CPIA1 is not set
CONFIG_USB_GSPCA_ETOMS=3Dm
CONFIG_USB_GSPCA_FINEPIX=3Dm
CONFIG_USB_GSPCA_JEILINJ=3Dm
CONFIG_USB_GSPCA_KINECT=3Dm
# CONFIG_USB_GSPCA_KONICA is not set
CONFIG_USB_GSPCA_MARS=3Dm
CONFIG_USB_GSPCA_MR97310A=3Dm
# CONFIG_USB_GSPCA_NW80X is not set
CONFIG_USB_GSPCA_OV519=3Dm
CONFIG_USB_GSPCA_OV534=3Dm
# CONFIG_USB_GSPCA_OV534_9 is not set
CONFIG_USB_GSPCA_PAC207=3Dm
CONFIG_USB_GSPCA_PAC7302=3Dm
CONFIG_USB_GSPCA_PAC7311=3Dm
# CONFIG_USB_GSPCA_SE401 is not set
# CONFIG_USB_GSPCA_SN9C2028 is not set
CONFIG_USB_GSPCA_SN9C20X=3Dm
CONFIG_USB_GSPCA_SONIXB=3Dm
CONFIG_USB_GSPCA_SONIXJ=3Dm
CONFIG_USB_GSPCA_SPCA500=3Dm
CONFIG_USB_GSPCA_SPCA501=3Dm
CONFIG_USB_GSPCA_SPCA505=3Dm
CONFIG_USB_GSPCA_SPCA506=3Dm
CONFIG_USB_GSPCA_SPCA508=3Dm
CONFIG_USB_GSPCA_SPCA561=3Dm
# CONFIG_USB_GSPCA_SPCA1528 is not set
CONFIG_USB_GSPCA_SQ905=3Dm
CONFIG_USB_GSPCA_SQ905C=3Dm
# CONFIG_USB_GSPCA_SQ930X is not set
CONFIG_USB_GSPCA_STK014=3Dm
CONFIG_USB_GSPCA_STV0680=3Dm
CONFIG_USB_GSPCA_SUNPLUS=3Dm
CONFIG_USB_GSPCA_T613=3Dm
# CONFIG_USB_GSPCA_TOPRO is not set
CONFIG_USB_GSPCA_TV8532=3Dm
CONFIG_USB_GSPCA_VC032X=3Dm
# CONFIG_USB_GSPCA_VICAM is not set
# CONFIG_USB_GSPCA_XIRLINK_CIT is not set
CONFIG_USB_GSPCA_ZC3XX=3Dm
# CONFIG_VIDEO_PVRUSB2 is not set
# CONFIG_VIDEO_HDPVR is not set
# CONFIG_VIDEO_EM28XX is not set
# CONFIG_VIDEO_TLG2300 is not set
# CONFIG_VIDEO_CX231XX is not set
# CONFIG_VIDEO_TM6000 is not set
# CONFIG_VIDEO_USBVISION is not set
# CONFIG_USB_ET61X251 is not set
# CONFIG_USB_SN9C102 is not set
CONFIG_USB_PWC=3Dm
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=3Dy
# CONFIG_USB_ZR364XX is not set
# CONFIG_USB_STKWEBCAM is not set
# CONFIG_USB_S2255 is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_DVB_MAX_ADAPTERS=3D8
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_CAPTURE_DRIVERS=3Dy

#
# Supported SAA7146 based PCI Adapters
#
# CONFIG_TTPCI_EEPROM is not set
# CONFIG_DVB_AV7110 is not set
# CONFIG_DVB_BUDGET_CORE is not set

#
# Supported USB Adapters
#
CONFIG_DVB_USB=3Dm
CONFIG_DVB_USB_DEBUG=3Dy
# CONFIG_DVB_USB_A800 is not set
CONFIG_DVB_USB_DIBUSB_MB=3Dm
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=3Dm
CONFIG_DVB_USB_DIB0700=3Dm
# CONFIG_DVB_USB_UMT_010 is not set
# CONFIG_DVB_USB_CXUSB is not set
# CONFIG_DVB_USB_M920X is not set
# CONFIG_DVB_USB_GL861 is not set
# CONFIG_DVB_USB_AU6610 is not set
# CONFIG_DVB_USB_DIGITV is not set
# CONFIG_DVB_USB_VP7045 is not set
# CONFIG_DVB_USB_VP702X is not set
# CONFIG_DVB_USB_GP8PSK is not set
# CONFIG_DVB_USB_NOVA_T_USB2 is not set
# CONFIG_DVB_USB_TTUSB2 is not set
CONFIG_DVB_USB_DTT200U=3Dm
# CONFIG_DVB_USB_OPERA1 is not set
CONFIG_DVB_USB_AF9005=3Dm
CONFIG_DVB_USB_AF9005_REMOTE=3Dm
# CONFIG_DVB_USB_PCTV452E is not set
# CONFIG_DVB_USB_DW2102 is not set
CONFIG_DVB_USB_CINERGY_T2=3Dm
# CONFIG_DVB_USB_ANYSEE is not set
# CONFIG_DVB_USB_DTV5100 is not set
CONFIG_DVB_USB_AF9015=3Dm
# CONFIG_DVB_USB_CE6230 is not set
# CONFIG_DVB_USB_FRIIO is not set
# CONFIG_DVB_USB_EC168 is not set
# CONFIG_DVB_USB_AZ6027 is not set
# CONFIG_DVB_USB_LME2510 is not set
# CONFIG_DVB_USB_TECHNISAT_USB2 is not set
# CONFIG_DVB_USB_IT913X is not set
# CONFIG_DVB_USB_MXL111SF is not set
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
# CONFIG_SMS_SIANO_MDTV is not set

#
# Supported FlexCopII (B2C2) Adapters
#
# CONFIG_DVB_B2C2_FLEXCOP is not set

#
# Supported BT878 Adapters
#

#
# Supported Pluto2 Adapters
#
# CONFIG_DVB_PLUTO2 is not set

#
# Supported SDMC DM1105 Adapters
#
# CONFIG_DVB_DM1105 is not set

#
# Supported FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set

#
# Supported Earthsoft PT1 Adapters
#
# CONFIG_DVB_PT1 is not set

#
# Supported Mantis Adapters
#
# CONFIG_MANTIS_CORE is not set

#
# Supported nGene Adapters
#
# CONFIG_DVB_NGENE is not set

#
# Supported ddbridge ('Octopus') Adapters
#
# CONFIG_DVB_DDBRIDGE is not set

#
# Supported DVB Frontends
#
# CONFIG_DVB_FE_CUSTOMISE is not set

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_DIB3000MB=3Dm
CONFIG_DVB_DIB3000MC=3Dm
CONFIG_DVB_DIB7000M=3Dm
CONFIG_DVB_DIB7000P=3Dm
CONFIG_DVB_AF9013=3Dm

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_LGDT3305=3Dm
CONFIG_DVB_S5H1411=3Dm

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=3Dm

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=3Dm
CONFIG_DVB_TUNER_DIB0070=3Dm
CONFIG_DVB_TUNER_DIB0090=3Dm

#
# SEC control devices for DVB-S
#

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
CONFIG_AGP=3Dy
CONFIG_AGP_AMD64=3Dy
CONFIG_AGP_INTEL=3Dy
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_VGA_ARB=3Dy
CONFIG_VGA_ARB_MAX_GPUS=3D16
CONFIG_VGA_SWITCHEROO=3Dy
CONFIG_DRM=3Dy
CONFIG_DRM_KMS_HELPER=3Dy
CONFIG_DRM_TTM=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=3Dy
# CONFIG_DRM_RADEON_KMS is not set
CONFIG_DRM_I915=3Dy
CONFIG_DRM_I915_KMS=3Dy
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_VMWGFX=3Dm
# CONFIG_STUB_POULSBO is not set
# CONFIG_VGASTATE is not set
CONFIG_VIDEO_OUTPUT_CONTROL=3Dy
CONFIG_FB=3Dy
CONFIG_FIRMWARE_EDID=3Dy
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_WMT_GE_ROPS is not set
CONFIG_FB_DEFERRED_IO=3Dy
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_TILEBLITTING=3Dy

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_TMIO is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
CONFIG_LCD_CLASS_DEVICE=3Dm
CONFIG_LCD_PLATFORM=3Dm
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
CONFIG_BACKLIGHT_GENERIC=3Dm
# CONFIG_BACKLIGHT_PROGEAR is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set

#
# Display device support
#
CONFIG_DISPLAY_SUPPORT=3Dm

#
# Display hardware drivers
#

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_MONO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy
CONFIG_SOUND=3Dm
CONFIG_SOUND_OSS_CORE=3Dy
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_JACK=3Dy
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_HRTIMER=3Dm
CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
CONFIG_SND_DYNAMIC_MINORS=3Dy
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_VERBOSE_PROCFS=3Dy
CONFIG_SND_VERBOSE_PRINTK=3Dy
CONFIG_SND_DEBUG=3Dy
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=3Dy
CONFIG_SND_DMA_SGBUF=3Dy
CONFIG_SND_RAWMIDI_SEQ=3Dm
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_DRIVERS=3Dy
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=3Dm
CONFIG_SND_VIRMIDI=3Dm
CONFIG_SND_MTPAV=3Dm
CONFIG_SND_SERIAL_U16550=3Dm
CONFIG_SND_MPU401=3Dm
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_PCI=3Dy
CONFIG_SND_AD1889=3Dm
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDA_INTEL=3Dm
CONFIG_SND_HDA_PREALLOC_SIZE=3D64
CONFIG_SND_HDA_HWDEP=3Dy
CONFIG_SND_HDA_RECONFIG=3Dy
CONFIG_SND_HDA_INPUT_BEEP=3Dy
CONFIG_SND_HDA_INPUT_BEEP_MODE=3D1
CONFIG_SND_HDA_INPUT_JACK=3Dy
CONFIG_SND_HDA_PATCH_LOADER=3Dy
CONFIG_SND_HDA_CODEC_REALTEK=3Dy
CONFIG_SND_HDA_ENABLE_REALTEK_QUIRKS=3Dy
CONFIG_SND_HDA_CODEC_ANALOG=3Dy
CONFIG_SND_HDA_CODEC_SIGMATEL=3Dy
CONFIG_SND_HDA_CODEC_VIA=3Dy
CONFIG_SND_HDA_CODEC_HDMI=3Dy
CONFIG_SND_HDA_CODEC_CIRRUS=3Dy
CONFIG_SND_HDA_CODEC_CONEXANT=3Dy
CONFIG_SND_HDA_CODEC_CA0110=3Dy
CONFIG_SND_HDA_CODEC_CA0132=3Dy
CONFIG_SND_HDA_CODEC_CMEDIA=3Dy
CONFIG_SND_HDA_CODEC_SI3054=3Dy
CONFIG_SND_HDA_GENERIC=3Dy
CONFIG_SND_HDA_POWER_SAVE=3Dy
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D10
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=3Dm
CONFIG_SND_INTEL8X0M=3Dm
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
CONFIG_SND_USB=3Dy
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_PCMCIA=3Dy
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set
# CONFIG_SND_SOC is not set
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=3Dm
CONFIG_HID_SUPPORT=3Dy
CONFIG_HID=3Dm
CONFIG_HIDRAW=3Dy

#
# USB Input Devices
#
CONFIG_USB_HID=3Dm
CONFIG_HID_PID=3Dy
CONFIG_USB_HIDDEV=3Dy

#
# Special HID drivers
#
CONFIG_HID_A4TECH=3Dm
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=3Dm
CONFIG_HID_BELKIN=3Dm
CONFIG_HID_CHERRY=3Dm
CONFIG_HID_CHICONY=3Dm
# CONFIG_HID_PRODIKEYS is not set
CONFIG_HID_CYPRESS=3Dm
CONFIG_HID_DRAGONRISE=3Dm
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=3Dm
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=3Dm
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=3Dm
CONFIG_HID_TWINHAN=3Dm
CONFIG_HID_KENSINGTON=3Dm
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LOGITECH=3Dm
CONFIG_HID_LOGITECH_DJ=3Dm
CONFIG_LOGITECH_FF=3Dy
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=3Dy
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MICROSOFT=3Dm
CONFIG_HID_MONTEREY=3Dm
CONFIG_HID_MULTITOUCH=3Dm
CONFIG_HID_NTRIG=3Dm
CONFIG_HID_ORTEK=3Dm
CONFIG_HID_PANTHERLORD=3Dm
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=3Dm
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_QUANTA is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAMSUNG=3Dm
CONFIG_HID_SONY=3Dm
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_SUNPLUS=3Dm
CONFIG_HID_GREENASIA=3Dm
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=3Dm
CONFIG_SMARTJOYPLUS_FF=3Dy
CONFIG_HID_TOPSEED=3Dm
CONFIG_HID_THRUSTMASTER=3Dm
CONFIG_THRUSTMASTER_FF=3Dy
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=3Dm
CONFIG_HID_ZEROPLUS=3Dm
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_COMMON=3Dm
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
CONFIG_USB_ARCH_HAS_XHCI=3Dy
CONFIG_USB=3Dm
# CONFIG_USB_DEBUG is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_DEVICE_CLASS=3Dy
CONFIG_USB_DYNAMIC_MINORS=3Dy
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_MON=3Dm
# CONFIG_USB_WUSB is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=3Dm
# CONFIG_USB_XHCI_HCD_DEBUGGING is not set
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_OXU210HP_HCD is not set
CONFIG_USB_ISP116X_HCD=3Dm
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_OHCI_HCD=3Dm
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_UHCI_HCD=3Dm
CONFIG_USB_SL811_HCD=3Dm
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_SL811_CS=3Dm
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
# CONFIG_USB_HWA_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_WDM=3Dm
CONFIG_USB_TMC=3Dm

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
CONFIG_USB_STORAGE_DATAFAB=3Dm
CONFIG_USB_STORAGE_FREECOM=3Dm
CONFIG_USB_STORAGE_ISD200=3Dm
CONFIG_USB_STORAGE_USBAT=3Dm
CONFIG_USB_STORAGE_SDDR09=3Dm
CONFIG_USB_STORAGE_SDDR55=3Dm
CONFIG_USB_STORAGE_JUMPSHOT=3Dm
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=3Dm
CONFIG_USB_LIBUSUAL=3Dy

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
CONFIG_USB_MICROTEK=3Dm

#
# USB port drivers
#
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_EZUSB=3Dy
CONFIG_USB_SERIAL_GENERIC=3Dy
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
# CONFIG_USB_SERIAL_EMPEG is not set
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
# CONFIG_USB_SERIAL_FUNSOFT is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_GARMIN is not set
CONFIG_USB_SERIAL_IPW=3Dm
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
CONFIG_USB_SERIAL_MOTOROLA=3Dm
# CONFIG_USB_SERIAL_NAVMAN is not set
CONFIG_USB_SERIAL_PL2303=3Dm
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
CONFIG_USB_SERIAL_QUALCOMM=3Dm
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_HP4X is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIEMENS_MPI is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
CONFIG_USB_SERIAL_WWAN=3Dm
CONFIG_USB_SERIAL_OPTION=3Dm
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_VIVOPAY_SERIAL is not set
# CONFIG_USB_SERIAL_ZIO is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
CONFIG_USB_LED=3Dm
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_GADGET is not set

#
# OTG and related infrastructure
#
CONFIG_USB_OTG_UTILS=3Dy
CONFIG_USB_GPIO_VBUS=3Dm
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_UWB is not set
CONFIG_MMC=3Dm
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_UNSAFE_RESUME is not set
# CONFIG_MMC_CLKGATE is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=3Dm
CONFIG_MMC_BLOCK_MINORS=3D8
CONFIG_MMC_BLOCK_BOUNCE=3Dy
CONFIG_SDIO_UART=3Dm
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=3Dm
CONFIG_MMC_SDHCI_PCI=3Dm
CONFIG_MMC_RICOH_MMC=3Dy
CONFIG_MMC_SDHCI_PLTFM=3Dm
CONFIG_MMC_WBSD=3Dm
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SDRICOH_CS=3Dm
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=3Dm
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=3Dy
CONFIG_LEDS_CLASS=3Dy

#
# LED drivers
#
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=3Dm
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_REGULATOR=3Dm
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_DELL_NETBOOKS is not set
CONFIG_LEDS_TRIGGERS=3Dy

#
# LED Triggers
#
CONFIG_LEDS_TRIGGER_TIMER=3Dm
CONFIG_LEDS_TRIGGER_IDE_DISK=3Dy
CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_ACCESSIBILITY=3Dy
# CONFIG_A11Y_BRAILLE_CONSOLE is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
CONFIG_RTC_INTF_DEV_UIE_EMUL=3Dy
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# SPI RTC drivers
#

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=3Dy
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
CONFIG_DMADEVICES=3Dy
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_INTEL_MID_DMAC=3Dm
CONFIG_INTEL_IOATDMA=3Dm
CONFIG_TIMB_DMA=3Dm
# CONFIG_PCH_DMA is not set
CONFIG_DMA_ENGINE=3Dy

#
# DMA Clients
#
CONFIG_NET_DMA=3Dy
CONFIG_ASYNC_TX_DMA=3Dy
# CONFIG_DMATEST is not set
CONFIG_DCA=3Dm
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=3Dm
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV=3Dm
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=3Dm
# CONFIG_UIO_NETX is not set
CONFIG_VIRTIO=3Dm
CONFIG_VIRTIO_RING=3Dm

#
# Virtio drivers
#
CONFIG_VIRTIO_PCI=3Dm
CONFIG_VIRTIO_BALLOON=3Dm
CONFIG_VIRTIO_MMIO=3Dm
CONFIG_STAGING=3Dy
# CONFIG_ET131X is not set
# CONFIG_SLICOSS is not set
CONFIG_USBIP_CORE=3Dm
CONFIG_USBIP_VHCI_HCD=3Dm
CONFIG_USBIP_HOST=3Dm
# CONFIG_USBIP_DEBUG is not set
# CONFIG_W35UND is not set
# CONFIG_PRISM2_USB is not set
# CONFIG_ECHO is not set
# CONFIG_COMEDI is not set
# CONFIG_ASUS_OLED is not set
# CONFIG_R8187SE is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTL8192E is not set
# CONFIG_R8712U is not set
# CONFIG_RTS_PSTOR is not set
# CONFIG_RTS5139 is not set
# CONFIG_TRANZPORT is not set
CONFIG_POHMELFS=3Dm
# CONFIG_POHMELFS_DEBUG is not set
# CONFIG_IDE_PHISON is not set
# CONFIG_LINE6_USB is not set
# CONFIG_DRM_NOUVEAU is not set

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_USB_SERIAL_QUATECH2 is not set
# CONFIG_USB_SERIAL_QUATECH_USB2 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_VME_BUS is not set
# CONFIG_DX_SEP is not set
# CONFIG_IIO is not set
CONFIG_XVMALLOC=3Dy
CONFIG_ZRAM=3Dm
# CONFIG_ZRAM_DEBUG is not set
CONFIG_ZCACHE=3Dm
# CONFIG_WLAGS49_H2 is not set
# CONFIG_WLAGS49_H25 is not set
# CONFIG_FB_SM7XX is not set
CONFIG_CRYSTALHD=3Dm
# CONFIG_FB_XGI is not set
CONFIG_ACPI_QUICKSTART=3Dm
# CONFIG_USB_ENESTORAGE is not set
# CONFIG_BCM_WIMAX is not set
# CONFIG_FT1000 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_TOUCHSCREEN_CLEARPAD_TM1217 is not set
# CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4 is not set
# CONFIG_DRM_PSB is not set
CONFIG_INTEL_MEI=3Dm
CONFIG_STAGING_MEDIA=3Dy
# CONFIG_DVB_AS102 is not set
# CONFIG_DVB_CXD2099 is not set
# CONFIG_VIDEO_DT3155 is not set
# CONFIG_EASYCAP is not set
# CONFIG_VIDEO_GO7007 is not set
# CONFIG_SOLO6X10 is not set
# CONFIG_LIRC_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=3Dy
# CONFIG_ACER_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_WMI is not set
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WMI is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
CONFIG_IDEAPAD_LAPTOP=3Dm
CONFIG_THINKPAD_ACPI=3Dm
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=3Dy
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=3Dy
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy
CONFIG_SENSORS_HDAPS=3Dm
CONFIG_INTEL_MENLOW=3Dm
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_ASUS_WMI is not set
CONFIG_ACPI_WMI=3Dm
# CONFIG_MSI_WMI is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
CONFIG_ACPI_CMPC=3Dm
CONFIG_INTEL_IPS=3Dm
CONFIG_IBM_RTL=3Dm
# CONFIG_XO15_EBOOK is not set
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_MXM_WMI=3Dm
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set

#
# Hardware Spinlock drivers
#
CONFIG_CLKEVT_I8253=3Dy
CONFIG_I8253_LOCK=3Dy
CONFIG_CLKBLD_I8253=3Dy
CONFIG_IOMMU_API=3Dy
CONFIG_IOMMU_SUPPORT=3Dy
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=3Dy
CONFIG_INTEL_IOMMU=3Dy
CONFIG_INTEL_IOMMU_DEFAULT_ON=3Dy
CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy
CONFIG_IRQ_REMAP=3Dy
CONFIG_VIRT_DRIVERS=3Dy
# CONFIG_HYPERV is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=3Dy
# CONFIG_EFI_VARS is not set
CONFIG_DELL_RBU=3Dm
CONFIG_DCDBAS=3Dm
CONFIG_DMIID=3Dy
CONFIG_DMI_SYSFS=3Dm
CONFIG_ISCSI_IBFT_FIND=3Dy
CONFIG_ISCSI_IBFT=3Dm
CONFIG_SIGMA=3Dm
# CONFIG_GOOGLE_FIRMWARE is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dm
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dm
# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_EXT4_FS=3Dm
CONFIG_EXT4_FS_XATTR=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD=3Dm
# CONFIG_JBD_DEBUG is not set
CONFIG_JBD2=3Dm
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dm
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=3Dm
CONFIG_XFS_QUOTA=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
# CONFIG_XFS_RT is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=3Dm
CONFIG_GFS2_FS_LOCKING_DLM=3Dy
CONFIG_OCFS2_FS=3Dm
CONFIG_OCFS2_FS_O2CB=3Dm
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm
CONFIG_OCFS2_FS_STATS=3Dy
CONFIG_OCFS2_DEBUG_MASKLOG=3Dy
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=3Dm
CONFIG_BTRFS_FS_POSIX_ACL=3Dy
# CONFIG_NILFS2_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_FILE_LOCKING=3Dy
CONFIG_FSNOTIFY=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
CONFIG_FANOTIFY=3Dy
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=3Dy
CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
CONFIG_PRINT_QUOTA_WARNING=3Dy
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=3Dm
CONFIG_QFMT_V1=3Dm
CONFIG_QFMT_V2=3Dm
CONFIG_QUOTACTL=3Dy
CONFIG_QUOTACTL_COMPAT=3Dy
CONFIG_AUTOFS4_FS=3Dm
CONFIG_FUSE_FS=3Dm
CONFIG_CUSE=3Dm
CONFIG_GENERIC_ACL=3Dy

#
# Caches
#
CONFIG_FSCACHE=3Dm
CONFIG_FSCACHE_STATS=3Dy
CONFIG_FSCACHE_HISTOGRAM=3Dy
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=3Dm
# CONFIG_CACHEFILES_DEBUG is not set
CONFIG_CACHEFILES_HISTOGRAM=3Dy

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=3Dy

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_TMPFS_XATTR=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_CONFIGFS_FS=3Dm
CONFIG_MISC_FILESYSTEMS=3Dy
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=3Dm
CONFIG_ECRYPT_FS=3Dm
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_LOGFS=3Dm
CONFIG_CRAMFS=3Dm
CONFIG_SQUASHFS=3Dm
CONFIG_SQUASHFS_XATTR=3Dy
CONFIG_SQUASHFS_ZLIB=3Dy
CONFIG_SQUASHFS_LZO=3Dy
CONFIG_SQUASHFS_XZ=3Dy
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=3Dy
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
CONFIG_VXFS_FS=3Dm
CONFIG_MINIX_FS=3Dm
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
CONFIG_ROMFS_FS=3Dy
CONFIG_ROMFS_BACKED_BY_BLOCK=3Dy
CONFIG_ROMFS_ON_BLOCK=3Dy
CONFIG_PSTORE=3Dy
CONFIG_SYSV_FS=3Dm
CONFIG_UFS_FS=3Dm
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V3_ACL=3Dy
CONFIG_NFS_V4=3Dy
# CONFIG_NFS_V4_1 is not set
CONFIG_NFS_FSCACHE=3Dy
CONFIG_NFS_USE_LEGACY_DNS=3Dy
CONFIG_NFS_USE_NEW_IDMAPPER=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V2_ACL=3Dy
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V3_ACL=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_ACL_SUPPORT=3Dm
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_RPCSEC_GSS_KRB5=3Dm
CONFIG_CEPH_FS=3Dm
CONFIG_CIFS=3Dm
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=3Dy
CONFIG_CIFS_POSIX=3Dy
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DFS_UPCALL is not set
CONFIG_CIFS_FSCACHE=3Dy
# CONFIG_CIFS_ACL is not set
CONFIG_NCP_FS=3Dm
CONFIG_NCPFS_PACKET_SIGNING=3Dy
CONFIG_NCPFS_IOCTL_LOCKING=3Dy
CONFIG_NCPFS_STRONG=3Dy
CONFIG_NCPFS_NFS_NS=3Dy
CONFIG_NCPFS_OS2_NS=3Dy
CONFIG_NCPFS_SMALLDOS=3Dy
CONFIG_NCPFS_NLS=3Dy
CONFIG_NCPFS_EXTRAS=3Dy
CONFIG_CODA_FS=3Dm
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
CONFIG_ACORN_PARTITION=3Dy
CONFIG_ACORN_PARTITION_CUMANA=3Dy
CONFIG_ACORN_PARTITION_EESOX=3Dy
CONFIG_ACORN_PARTITION_ICS=3Dy
CONFIG_ACORN_PARTITION_ADFS=3Dy
CONFIG_ACORN_PARTITION_POWERTEC=3Dy
CONFIG_ACORN_PARTITION_RISCIX=3Dy
CONFIG_OSF_PARTITION=3Dy
CONFIG_AMIGA_PARTITION=3Dy
CONFIG_ATARI_PARTITION=3Dy
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
CONFIG_MINIX_SUBPARTITION=3Dy
CONFIG_SOLARIS_X86_PARTITION=3Dy
CONFIG_UNIXWARE_DISKLABEL=3Dy
CONFIG_LDM_PARTITION=3Dy
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=3Dy
CONFIG_ULTRIX_PARTITION=3Dy
CONFIG_SUN_PARTITION=3Dy
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=3Dy
# CONFIG_SYSV68_PARTITION is not set
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_UTF8=3Dm
CONFIG_DLM=3Dm
# CONFIG_DLM_DEBUG is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_PRINTK_TIME=3Dy
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D4
CONFIG_ENABLE_WARN_DEPRECATED=3Dy
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=3D1024
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_STRIP_ASM_SYMS=3Dy
CONFIG_UNUSED_SYMBOLS=3Dy
CONFIG_DEBUG_FS=3Dy
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
# CONFIG_LOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=3Dy
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
CONFIG_SCHED_DEBUG=3Dy
CONFIG_SCHEDSTATS=3Dy
CONFIG_TIMER_STATS=3Dy
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=3Dy
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_WRITECOUNT is not set
CONFIG_DEBUG_MEMORY_INIT=3Dy
# CONFIG_DEBUG_LIST is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set
CONFIG_ARCH_WANT_FRAME_POINTERS=3Dy
CONFIG_FRAME_POINTER=3Dy
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
CONFIG_RCU_CPU_STALL_VERBOSE=3Dy
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_LKDTM is not set
CONFIG_CPU_NOTIFIER_ERROR_INJECT=3Dm
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=3Dy
CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_USER_STACKTRACE_SUPPORT=3Dy
CONFIG_NOP_TRACER=3Dy
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=3Dy
CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_HAVE_C_RECORDMCOUNT=3Dy
CONFIG_RING_BUFFER=3Dy
CONFIG_EVENT_TRACING=3Dy
# CONFIG_EVENT_POWER_TRACING_DEPRECATED is not set
CONFIG_CONTEXT_SWITCH_TRACER=3Dy
CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy
CONFIG_TRACING=3Dy
CONFIG_GENERIC_TRACER=3Dy
CONFIG_TRACING_SUPPORT=3Dy
CONFIG_FTRACE=3Dy
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_BRANCH_PROFILE_NONE=3Dy
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
CONFIG_BLK_DEV_IO_TRACE=3Dy
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_FIREWIRE_OHCI_REMOTE_DMA is not set
CONFIG_DYNAMIC_DEBUG=3Dy
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_ATOMIC64_SELFTEST is not set
CONFIG_ASYNC_RAID6_TEST=3Dm
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
CONFIG_HAVE_ARCH_KMEMCHECK=3Dy
# CONFIG_TEST_KSTRTOX is not set
CONFIG_STRICT_DEVMEM=3Dy
CONFIG_X86_VERBOSE_BOOTUP=3Dy
CONFIG_EARLY_PRINTK=3Dy
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_RODATA=3Dy
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_SET_MODULE_RONX=3Dy
# CONFIG_DEBUG_NX_TEST is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
CONFIG_IO_DELAY_TYPE_0X80=3D0
CONFIG_IO_DELAY_TYPE_0XED=3D1
CONFIG_IO_DELAY_TYPE_UDELAY=3D2
CONFIG_IO_DELAY_TYPE_NONE=3D3
CONFIG_IO_DELAY_0X80=3Dy
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=3D0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_STRICT_USER_COPY_CHECKS is not set

#
# Security options
#
CONFIG_KEYS=3Dy
CONFIG_TRUSTED_KEYS=3Dm
CONFIG_ENCRYPTED_KEYS=3Dm
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=3Dy
CONFIG_SECURITYFS=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_SECURITY_NETWORK_XFRM=3Dy
CONFIG_SECURITY_PATH=3Dy
CONFIG_INTEL_TXT=3Dy
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_IMA is not set
CONFIG_DEFAULT_SECURITY_DAC=3Dy
CONFIG_DEFAULT_SECURITY=3D""
CONFIG_XOR_BLOCKS=3Dm
CONFIG_ASYNC_CORE=3Dm
CONFIG_ASYNC_MEMCPY=3Dm
CONFIG_ASYNC_XOR=3Dm
CONFIG_ASYNC_PQ=3Dm
CONFIG_ASYNC_RAID6_RECOV=3Dm
CONFIG_ASYNC_TX_DISABLE_PQ_VAL_DMA=3Dy
CONFIG_ASYNC_TX_DISABLE_XOR_VAL_DMA=3Dy
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_ALGAPI2=3Dy
CONFIG_CRYPTO_AEAD=3Dm
CONFIG_CRYPTO_AEAD2=3Dy
CONFIG_CRYPTO_BLKCIPHER=3Dm
CONFIG_CRYPTO_BLKCIPHER2=3Dy
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_HASH2=3Dy
CONFIG_CRYPTO_RNG=3Dm
CONFIG_CRYPTO_RNG2=3Dy
CONFIG_CRYPTO_PCOMP=3Dm
CONFIG_CRYPTO_PCOMP2=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_MANAGER2=3Dy
CONFIG_CRYPTO_USER=3Dm
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
CONFIG_CRYPTO_GF128MUL=3Dm
CONFIG_CRYPTO_NULL=3Dm
CONFIG_CRYPTO_PCRYPT=3Dm
CONFIG_CRYPTO_WORKQUEUE=3Dy
CONFIG_CRYPTO_CRYPTD=3Dm
CONFIG_CRYPTO_AUTHENC=3Dm
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=3Dm
CONFIG_CRYPTO_GCM=3Dm
CONFIG_CRYPTO_SEQIV=3Dm

#
# Block modes
#
CONFIG_CRYPTO_CBC=3Dm
CONFIG_CRYPTO_CTR=3Dm
CONFIG_CRYPTO_CTS=3Dm
CONFIG_CRYPTO_ECB=3Dm
CONFIG_CRYPTO_LRW=3Dm
CONFIG_CRYPTO_PCBC=3Dm
CONFIG_CRYPTO_XTS=3Dm

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_XCBC=3Dm
CONFIG_CRYPTO_VMAC=3Dm

#
# Digest
#
CONFIG_CRYPTO_CRC32C=3Dm
CONFIG_CRYPTO_CRC32C_INTEL=3Dm
CONFIG_CRYPTO_GHASH=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
CONFIG_CRYPTO_RMD128=3Dm
CONFIG_CRYPTO_RMD160=3Dm
CONFIG_CRYPTO_RMD256=3Dm
CONFIG_CRYPTO_RMD320=3Dm
CONFIG_CRYPTO_SHA1=3Dm
CONFIG_CRYPTO_SHA1_SSSE3=3Dm
CONFIG_CRYPTO_SHA256=3Dy
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_TGR192=3Dm
CONFIG_CRYPTO_WP512=3Dm
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm

#
# Ciphers
#
CONFIG_CRYPTO_AES=3Dm
CONFIG_CRYPTO_AES_X86_64=3Dm
CONFIG_CRYPTO_AES_NI_INTEL=3Dm
CONFIG_CRYPTO_ANUBIS=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_BLOWFISH_COMMON=3Dm
CONFIG_CRYPTO_BLOWFISH_X86_64=3Dm
CONFIG_CRYPTO_CAMELLIA=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_FCRYPT=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_SALSA20=3Dm
CONFIG_CRYPTO_SALSA20_X86_64=3Dm
CONFIG_CRYPTO_SEED=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_TWOFISH_COMMON=3Dm
CONFIG_CRYPTO_TWOFISH_X86_64=3Dm
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dm

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_ZLIB=3Dm
CONFIG_CRYPTO_LZO=3Dm

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=3Dm
CONFIG_CRYPTO_USER_API=3Dm
CONFIG_CRYPTO_USER_API_HASH=3Dm
CONFIG_CRYPTO_USER_API_SKCIPHER=3Dm
CONFIG_CRYPTO_HW=3Dy
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_HAVE_KVM=3Dy
CONFIG_HAVE_KVM_IRQCHIP=3Dy
CONFIG_HAVE_KVM_EVENTFD=3Dy
CONFIG_KVM_APIC_ARCHITECTURE=3Dy
CONFIG_KVM_MMIO=3Dy
CONFIG_KVM_ASYNC_PF=3Dy
CONFIG_VIRTUALIZATION=3Dy
CONFIG_KVM=3Dm
CONFIG_KVM_INTEL=3Dm
CONFIG_KVM_AMD=3Dm
# CONFIG_KVM_MMU_AUDIT is not set
CONFIG_VHOST_NET=3Dm
CONFIG_BINARY_PRINTF=3Dy

#
# Library routines
#
CONFIG_RAID6_PQ=3Dm
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
CONFIG_CRC_CCITT=3Dm
CONFIG_CRC16=3Dm
CONFIG_CRC_T10DIF=3Dm
CONFIG_CRC_ITU_T=3Dm
CONFIG_CRC32=3Dy
CONFIG_CRC7=3Dm
CONFIG_LIBCRC32C=3Dm
CONFIG_CRC8=3Dm
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_LZO_COMPRESS=3Dy
CONFIG_LZO_DECOMPRESS=3Dy
CONFIG_XZ_DEC=3Dy
CONFIG_XZ_DEC_X86=3Dy
CONFIG_XZ_DEC_POWERPC=3Dy
CONFIG_XZ_DEC_IA64=3Dy
CONFIG_XZ_DEC_ARM=3Dy
CONFIG_XZ_DEC_ARMTHUMB=3Dy
CONFIG_XZ_DEC_SPARC=3Dy
CONFIG_XZ_DEC_BCJ=3Dy
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=3Dy
CONFIG_DECOMPRESS_BZIP2=3Dy
CONFIG_DECOMPRESS_LZMA=3Dy
CONFIG_DECOMPRESS_XZ=3Dy
CONFIG_DECOMPRESS_LZO=3Dy
CONFIG_GENERIC_ALLOCATOR=3Dy
CONFIG_TEXTSEARCH=3Dy
CONFIG_TEXTSEARCH_KMP=3Dm
CONFIG_TEXTSEARCH_BM=3Dm
CONFIG_TEXTSEARCH_FSM=3Dm
CONFIG_BTREE=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_CHECK_SIGNATURE=3Dy
CONFIG_CPU_RMAP=3Dy
CONFIG_NLATTR=3Dy
CONFIG_LRU_CACHE=3Dm
CONFIG_AVERAGE=3Dy
CONFIG_CORDIC=3Dm

--=20
Arkadiusz Mi=C5=9Bkiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
