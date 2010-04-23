From: Richard Mawson <richard@crow.mawsonit.co.uk>
Subject: Re: SATA driver sata_sil24
Date: Fri, 23 Apr 2010 15:06:02 +0100
Message-ID: <20100423140602.GE1883@crow.mawsonit.co.uk>
References: <20100422083226.GA6018@crow.mawsonit.co.uk> <4BD0203C.7010903@gmail.com> <20100422121747.GC6018@crow.mawsonit.co.uk> <4BD05043.10709@gmail.com> <20100422223309.GA1883@crow.mawsonit.co.uk> <4BD1129E.6030104@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smarthost02.mail.zen.net.uk ([212.23.3.141]:37180 "EHLO
	smarthost02.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754033Ab0DWOm3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Apr 2010 10:42:29 -0400
Content-Disposition: inline
In-Reply-To: <4BD1129E.6030104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org


--7cm2iqirTL37Ot+N
Content-Type: multipart/mixed; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2010 at 09:23:10PM -0600, Robert Hancock wrote:
> Hmm, that seems like this line in drivers/ata/sata_sil24.c:
>
>         /* Set max read request size to 4096.  This slightly increases
>          * write throughput for pci-e variants.
>          */
>         pcie_set_readrq(pdev, 4096);
>
> Can you try commenting out or deleting that line and rebuilding, and see =
=20
> if things work better? That's not really a solution, but if it worked, =
=20
> it would indicate there's something about the system configuration with =
=20
> that converter card installed that explodes when trying to set the max =
=20
> read request size. In that case can you post the output of "lspci -vv" =
=20
> and the full dmesg boot log?

This did not solve the problem -- it did stop the alt-sysrq-t trick from wo=
rking
though, so it changed something. Is there an easy way to get a crashdump --=
 does
it require patching the kernel? I've not done this before.

I've attached dmesg and lspci output.

--=20
Richard Mawson
Mawson IT Services

--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_2.6.33.2"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.33.2 (root@dom0.mawsonit.co.uk) (gcc versi=
on 4.3.2 (Debian 4.3.2-1.1) ) #1 SMP Thu Apr 22 19:06:15 UTC 2010
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bfffb000 (usable)
[    0.000000]  BIOS-e820: 00000000bfffb000 - 00000000bffff000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU or di=
sabled in BIOS!
[    0.000000] DMI 2.3 present.
[    0.000000] last_pfn =3D 0xbfffb max_arch_pfn =3D 0x1000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 080000000 mask FC0000000 write-back
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT not supported by CPU.
[    0.000000] initial memory mapped : 0 - 00a00000
[    0.000000] found SMP MP-table at [c00f5270] f5270
[    0.000000] init_memory_mapping: 0000000000000000-00000000379fe000
[    0.000000]  0000000000 - 0000200000 page 4k
[    0.000000]  0000200000 - 0037800000 page 2M
[    0.000000]  0037800000 - 00379fe000 page 4k
[    0.000000] kernel direct mapping tables up to 379fe000 @ 7000-d000
[    0.000000] RAMDISK: 7f899000 - 7ffef9d1
[    0.000000] Allocated new RAMDISK: 004e9000 - 00c3f9d1
[    0.000000] Move RAMDISK from 000000007f899000 - 000000007ffef9d0 to 004=
e9000 - 00c3f9d0
[    0.000000] ASUS CUR-DLS detected: force use of acpi=3Dht
[    0.000000] ACPI: RSDP 000f6250 00014 (v00 ASUS  )
[    0.000000] ACPI: RSDT bfffb000 00030 (v01 ASUS   CUR-DLS  30303031 MSFT=
 31313031)
[    0.000000] ACPI: FACP bfffb100 00074 (v01 ASUS   CUR-DLS  30303031 MSFT=
 31313031)
[    0.000000] ACPI: DSDT bfffb180 032BD (v01   ASUS CUR-DLS  00001000 MSFT=
 0100000B)
[    0.000000] ACPI: FACS bffff000 00040
[    0.000000] ACPI: BOOT bfffb040 00028 (v01 ASUS   CUR-DLS  30303031 MSFT=
 31313031)
[    0.000000] ACPI: APIC bfffb080 00068 (v01 ASUS   CUR-DLS  30303031 MSFT=
 31313031)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 2181MB HIGHMEM available.
[    0.000000] 889MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 379fe000
[    0.000000]   low ram: 0 - 379fe000
[    0.000000]   node 0 low ram: 00000000 - 379fe000
[    0.000000]   node 0 bootmap 00009000 - 0000ff40
[    0.000000] (14 early reservations) =3D=3D> bootmem [0000000000 - 00379f=
e000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [000=
0000000 - 0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE =3D=3D> [000=
0001000 - 0000002000]
[    0.000000]   #2 [0000100000 - 00004e2808]    TEXT DATA BSS =3D=3D> [000=
0100000 - 00004e2808]
[    0.000000]   #3 [00004e3000 - 00004e8150]              BRK =3D=3D> [000=
04e3000 - 00004e8150]
[    0.000000]   #4 [00000f5280 - 0000100000]    BIOS reserved =3D=3D> [000=
00f5280 - 0000100000]
[    0.000000]   #5 [00000f5270 - 00000f5280]     MP-table mpf =3D=3D> [000=
00f5270 - 00000f5280]
[    0.000000]   #6 [000009f000 - 00000f4e60]    BIOS reserved =3D=3D> [000=
009f000 - 00000f4e60]
[    0.000000]   #7 [00000f4f7c - 00000f5270]    BIOS reserved =3D=3D> [000=
00f4f7c - 00000f5270]
[    0.000000]   #8 [00000f4e60 - 00000f4f7c]     MP-table mpc =3D=3D> [000=
00f4e60 - 00000f4f7c]
[    0.000000]   #9 [0000002000 - 0000003000]       TRAMPOLINE =3D=3D> [000=
0002000 - 0000003000]
[    0.000000]   #10 [0000003000 - 0000007000]      ACPI WAKEUP =3D=3D> [00=
00003000 - 0000007000]
[    0.000000]   #11 [0000007000 - 0000009000]          PGTABLE =3D=3D> [00=
00007000 - 0000009000]
[    0.000000]   #12 [00004e9000 - 0000c3f9d1]      NEW RAMDISK =3D=3D> [00=
004e9000 - 0000c3f9d1]
[    0.000000]   #13 [0000009000 - 0000010000]          BOOTMAP =3D=3D> [00=
00009000 - 0000010000]
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000379fe
[    0.000000]   HighMem  0x000379fe -> 0x000bfffb
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x000000a0
[    0.000000]     0: 0x00000100 -> 0x000bfffb
[    0.000000] On node 0 totalpages: 786331
[    0.000000] free_area_init_node: node 0, pgdat c0407440, node_mem_map c1=
001000
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3968 pages, LIFO batch:0
[    0.000000]   Normal zone: 1748 pages used for memmap
[    0.000000]   Normal zone: 221994 pages, LIFO batch:31
[    0.000000]   HighMem zone: 4364 pages used for memmap
[    0.000000]   HighMem zone: 554225 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0xe408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Using ACPI for processor (LAPIC) configuration information
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] MPTABLE: OEM ID: OEM00000
[    0.000000] MPTABLE: Product ID: PROD00000000
[    0.000000] MPTABLE: APIC at: 0xFEE00000
[    0.000000] I/O APIC #2 Version 17 at 0xFEC00000.
[    0.000000] I/O APIC #3 Version 17 at 0xFEC01000.
[    0.000000] Processors: 2
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 32
[    0.000000] Allocating PCI resources starting at c0000000 (gap: c0000000=
:3ec00000)
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr_no=
de_ids:1
[    0.000000] PERCPU: Embedded 13 pages/cpu @c2a00000 s29688 r0 d23560 u10=
48576
[    0.000000] pcpu-alloc: s29688 r0 d23560 u1048576 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 780187
[    0.000000] Kernel command line: root=3D/dev/mapper/vg0-dom0_root ro ini=
t=3D/bin/bash
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (000379fe:000bfffb)
[    0.000000] Memory: 3107296k/3145708k available (2128k kernel code, 3710=
0k reserved, 1005k data, 320k init, 2234356k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff1f000 - 0xfffff000   ( 896 kB)
[    0.000000]     pkmap   : 0xffa00000 - 0xffc00000   (2048 kB)
[    0.000000]     vmalloc : 0xf81fe000 - 0xff9fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf79fe000   ( 889 MB)
[    0.000000]       .init : 0xc0410000 - 0xc0460000   ( 320 kB)
[    0.000000]       .data : 0xc0314232 - 0xc040f688   (1005 kB)
[    0.000000]       .text : 0xc0100000 - 0xc0314232   (2128 kB)
[    0.000000] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.000000] Hierarchical RCU implementation.
[    0.000000] RCU-based detection of stalled CPUs is enabled.
[    0.000000] NR_IRQS:512
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1399.808 MHz processor.
[    0.004010] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 2799.61 BogoMIPS (lpj=3D5599232)
[    0.004253] Security Framework initialized
[    0.004345] SELinux:  Disabled at boot.
[    0.004448] Mount-cache hash table entries: 512
[    0.004827] Initializing cgroup subsys ns
[    0.004908] Initializing cgroup subsys cpuacct
[    0.004987] Initializing cgroup subsys devices
[    0.005137] Performance Events: p6 PMU driver.
[    0.005245] ... version:                0
[    0.005317] ... bit width:              32
[    0.005390] ... generic registers:      2
[    0.005462] ... value mask:             00000000ffffffff
[    0.005540] ... max period:             000000007fffffff
[    0.005617] ... fixed-purpose events:   0
[    0.008017] ... event mask:             0000000000000003
[    0.008104] Checking 'hlt' instruction... OK.
[    0.024600] Enabling APIC mode:  Flat.  Using 2 I/O APICs
[    0.024796] ExtINT not setup in hardware but reported by MP table
[    0.025090] BIOS bug, IO-APIC#1 ID 3 is already used!...
[    0.025169] ... fixing up to 1. (tell your hw vendor)
[    0.025470] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D0 pin2=3D0
[    0.028000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.028000] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.028000] ..... (found apic 0 pin 0) ...
[    0.069145] ....... works.
[    0.069212] CPU0: Intel(R) Pentium(R) III CPU family      1400MHz steppi=
ng 01
[    0.072000] Booting Node   0, Processors  #1 Ok.
[    0.008000] Initializing CPU#1
[    0.164098] Brought up 2 CPUs
[    0.164239] Total of 2 processors activated (5599.92 BogoMIPS).
[    0.166173] NET: Registered protocol family 16
[    0.168499] PCI: PCI BIOS revision 2.10 entry at 0xf0a80, last bus=3D2
[    0.168585] PCI: Using configuration type 1 for base access
[    0.172784] bio: create slab <bio-0> at 0
[    0.173163] ACPI: Interpreter disabled.
[    0.173537] vgaarb: loaded
[    0.174121] PCI: Probing PCI hardware
[    0.174195] PCI: Probing PCI hardware (bus 00)
[    0.174323] * The chipset may have PM-Timer Bug. Due to workarounds for =
a bug,
[    0.174325] * this clock source is slow. If you are sure your timer does=
 not have
[    0.174328] * this bug, please use "acpi_pm_good" to disable the workaro=
und
[    0.174667] * The chipset may have PM-Timer Bug. Due to workarounds for =
a bug,
[    0.174669] * this clock source is slow. If you are sure your timer does=
 not have
[    0.174672] * this bug, please use "acpi_pm_good" to disable the workaro=
und
[    0.175027] pci 0000:00:02.0: reg 10: [mem 0xfe000000-0xfe000fff]
[    0.175035] pci 0000:00:02.0: reg 14: [io  0xd800-0xd83f]
[    0.175043] pci 0000:00:02.0: reg 18: [mem 0xfd800000-0xfd8fffff]
[    0.175070] pci 0000:00:02.0: supports D1 D2
[    0.175074] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
[    0.175080] pci 0000:00:02.0: PME# disabled
[    0.175170] pci 0000:00:07.0: reg 10: [mem 0xfb000000-0xfbffffff]
[    0.175178] pci 0000:00:07.0: reg 14: [io  0xb800-0xb8ff]
[    0.175187] pci 0000:00:07.0: reg 18: [mem 0xfa800000-0xfa800fff]
[    0.175205] pci 0000:00:07.0: reg 30: [mem 0xfebe0000-0xfebfffff pref]
[    0.175222] pci 0000:00:07.0: supports D1 D2
[    0.175292] pci 0000:00:0f.1: reg 20: [io  0xb400-0xb40f]
[    0.175322] pci 0000:00:0f.2: reg 10: [mem 0xfa000000-0xfa000fff]
[    0.175423] pci 0000:01:00.0: reg 10: [mem 0xfd000000-0xfd00007f 64bit]
[    0.175445] pci 0000:01:00.0: reg 18: [mem 0xfc800000-0xfc801fff 64bit]
[    0.175458] pci 0000:01:00.0: reg 20: [io  0xc800-0xc87f]
[    0.175521] pci 0000:01:00.0: supports D1 D2
[    0.175568] pci 0000:00:05.0: PCI bridge to [bus 01-01]
[    0.175651] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
[    0.175658] pci 0000:00:05.0:   bridge window [mem 0xfc800000-0xfd7fffff]
[    0.176223] vgaarb: device added: PCI:0000:00:07.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.177029] PCI: Discovered peer bus 02
[    0.177237] pci 0000:02:05.0: reg 10: [io  0xb000-0xb0ff]
[    0.177249] pci 0000:02:05.0: reg 14: [mem 0xf9800000-0xf98003ff 64bit]
[    0.177261] pci 0000:02:05.0: reg 1c: [mem 0xf9000000-0xf9001fff 64bit]
[    0.177285] pci 0000:02:05.0: supports D1 D2
[    0.177313] pci 0000:02:05.1: reg 10: [io  0xa800-0xa8ff]
[    0.177325] pci 0000:02:05.1: reg 14: [mem 0xf8800000-0xf88003ff 64bit]
[    0.177337] pci 0000:02:05.1: reg 1c: [mem 0xf8000000-0xf8001fff 64bit]
[    0.177359] pci 0000:02:05.1: supports D1 D2
[    0.177656] pci 0000:00:0f.0: ServerWorks IRQ router [1166:0200]
[    0.177751] PCI: pci_cache_line_size set to 32 bytes
[    0.178147] Switching to clocksource tsc
[    0.180000] pnp: PnP ACPI: disabled
[    0.214619] pci 0000:00:05.0: PCI bridge to [bus 01-01]
[    0.214709] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
[    0.214795] pci 0000:00:05.0:   bridge window [mem 0xfc800000-0xfd7fffff]
[    0.214882] pci 0000:00:05.0:   bridge window [mem pref disabled]
[    0.214978] pci 0000:00:05.0: can't find IRQ for PCI INT A; probably bug=
gy MP table
[    0.215103] pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
[    0.215108] pci_bus 0000:00: resource 1 [mem 0x00000000-0xffffffffffffff=
ff]
[    0.215114] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
[    0.215119] pci_bus 0000:01: resource 1 [mem 0xfc800000-0xfd7fffff]
[    0.215125] pci_bus 0000:02: resource 0 [io  0x0000-0xffff]
[    0.215130] pci_bus 0000:02: resource 1 [mem 0x00000000-0xffffffffffffff=
ff]
[    0.215252] NET: Registered protocol family 2
[    0.215478] IP route cache hash table entries: 32768 (order: 5, 131072 b=
ytes)
[    0.216241] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes)
[    0.220894] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.223431] TCP: Hash tables configured (established 131072 bind 65536)
[    0.223530] TCP reno registered
[    0.223615] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.223779] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.227881] NET: Registered protocol family 1
[    0.228046] pci 0000:00:02.0: Firmware left e100 interrupts enabled; dis=
abling
[    0.228177] pci 0000:00:07.0: Boot video device
[    0.228220] PCI: CLS 32 bytes, default 32
[    0.228355] Trying to unpack rootfs image as initramfs...
[    0.628557] Freeing initrd memory: 7514k freed
[    0.649988] Simple Boot Flag at 0x3a set to 0x80
[    0.650418] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.651396] audit: initializing netlink socket (disabled)
[    0.651507] type=3D2000 audit(1272031804.649:1): initialized
[    0.652023] highmem bounce pool size: 64 pages
[    0.652335] VFS: Disk quotas dquot_6.5.2
[    0.652466] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.652639] msgmni has been set to 1721
[    0.653112] alg: No test for stdrng (krng)
[    0.653378] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    0.653496] io scheduler noop registered
[    0.653569] io scheduler deadline registered
[    0.653674] io scheduler cfq registered (default)
[    0.661906] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.662232] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    0.662529] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[    0.667436] brd: module loaded
[    0.667852] PNP: No PS/2 controller found. Probing ports directly.
[    0.918282] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.918744] mice: PS/2 mouse device common for all mice
[    0.919178] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    0.919303] rtc0: alarms up to one day, 114 bytes nvram
[    0.919465] cpuidle: using governor ladder
[    0.919545] No iBFT detected.
[    0.920198] TCP cubic registered
[    0.920270] NET: Registered protocol family 17
[    0.920360] Using IPI No-Shortcut mode
[    0.920754] registered taskstats version 1
[    0.921142] rtc_cmos rtc_cmos: setting system clock to 2010-04-23 14:10:=
06 UTC (1272031806)
[    0.921354] Freeing unused kernel memory: 320k freed
[    0.940036] input: AT Translated Set 2 keyboard as /class/input/input0
[    1.450556] SCSI subsystem initialized
[    1.475051] sym53c8xx 0000:02:05.0: PCI->APIC IRQ transform: INT A -> IR=
Q 24
[    1.510788] Uniform Multi-Platform E-IDE driver
[    1.561525] serverworks 0000:00:0f.1: IDE controller (0x1166:0x0211 rev =
0x00)
[    1.561670] serverworks 0000:00:0f.1: not 100% native mode: will probe i=
rqs later
[    1.561793]     ide0: BM-DMA at 0xb400-0xb407
[    1.561877]     ide1: BM-DMA at 0xb408-0xb40f
[    1.561958] Probing IDE interface ide0...
[    1.583147] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    1.583238] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.587617] usbcore: registered new interface driver usbfs
[    1.587788] usbcore: registered new interface driver hub
[    1.610775] usbcore: registered new device driver usb
[    1.615546] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.625669] sym0: <896> rev 0x7 at pci 0000:02:05.0 irq 24
[    1.627878] sym0: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
[    1.627962] sym0: open drain IRQ line driver, using on-chip SRAM
[    1.628044] sym0: using LOAD/STORE-based firmware.
[    1.628119] sym0: handling phase mismatch from SCRIPTS.
[    1.629948] sym0: SCSI BUS has been reset.
[    1.635033] scsi0 : sym-2.2.3
[    1.635429] sym53c8xx 0000:02:05.1: PCI->APIC IRQ transform: INT B -> IR=
Q 25
[    1.785098] sym1: <896> rev 0x7 at pci 0000:02:05.1 irq 25
[    1.787248] sym1: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
[    1.787332] sym1: open drain IRQ line driver, using on-chip SRAM
[    1.787413] sym1: using LOAD/STORE-based firmware.
[    1.787489] sym1: handling phase mismatch from SCRIPTS.
[    1.789983] sym1: SCSI BUS has been reset.
[    1.794387] scsi1 : sym-2.2.3
[    1.858305] hda: WDC WD3200JB-00KFA0, ATA DISK drive
[    2.194219] hdb: WDC WD3200JB-00KFA0, ATA DISK drive
[    2.194407] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    2.194481] hda: MWDMA2 mode selected
[    2.194631] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    2.194705] hdb: MWDMA2 mode selected
[    2.194862] Probing IDE interface ide1...
[    2.482438] hdc: WDC WD2500SB-01KBA0, ATA DISK drive
[    2.818358] hdd: WDC WD2500SB-01KBA0, ATA DISK drive
[    2.818493] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    2.819714] hdc: MWDMA2 mode selected
[    2.821047] hdd: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    2.822292] hdd: MWDMA2 mode selected
[    2.823668] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.823842] ide1 at 0x170-0x177,0x376 on irq 15
[    2.824294] e100 0000:00:02.0: PCI->APIC IRQ transform: INT A -> IRQ 20
[    2.847348] e100 0000:00:02.0: PME# disabled
[    2.847798] e100: eth0: e100_probe: addr 0xfe000000, irq 20, MAC addr 00=
:e0:18:51:e6:be
[    2.847994] ohci_hcd 0000:00:0f.2: PCI->APIC IRQ transform: INT A -> IRQ=
 30
[    2.848094] ohci_hcd 0000:00:0f.2: OHCI Host Controller
[    2.848215] ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus =
number 1
[    2.848370] ohci_hcd 0000:00:0f.2: irq 30, io mem 0xfa000000
[    2.876989] libata version 3.00 loaded.
[    2.904429] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    2.904524] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.904639] usb usb1: Product: OHCI Host Controller
[    2.904715] usb usb1: Manufacturer: Linux 2.6.33.2 ohci_hcd
[    2.904795] usb usb1: SerialNumber: 0000:00:0f.2
[    2.905112] hub 1-0:1.0: USB hub found
[    2.905196] hub 1-0:1.0: 4 ports detected
[    2.952771] ide-gd driver 1.18
[    2.952913] hda: max request size: 512KiB
[    2.962567] hda: 625142448 sectors (320072 MB) w/8192KiB Cache, CHS=3D38=
913/255/63
[    2.962891] hda: cache flushes supported
[    2.963079]  hda: hda1 hda2
[    2.975367] hdb: max request size: 512KiB
[    2.986491] hdb: 625142448 sectors (320072 MB) w/8192KiB Cache, CHS=3D38=
913/255/63
[    2.986746] hdb: cache flushes supported
[    2.986906]  hdb: hdb1 hdb2
[    2.997934] hdc: max request size: 512KiB
[    3.023633] hdc: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=3D30=
401/255/63
[    3.025736] hdc: cache flushes supported
[    3.025886]  hdc: unknown partition table
[    3.040207] hdd: max request size: 512KiB
[    3.063660] hdd: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=3D30=
401/255/63
[    3.065779] hdd: cache flushes supported
[    3.065932]  hdd: unknown partition table
[    3.278485] usb 1-2: new low speed USB device using ohci_hcd and address=
 2
[    3.497208] md: raid1 personality registered for level 1
[    3.514623] md: md0 stopped.
[    3.603688] md: bind<hdb1>
[    3.604173] md: bind<hda1>
[    3.623974] raid1: raid set md0 active with 2 out of 2 mirrors
[    3.624095] md0: detected capacity change from 0 to 98566144
[    3.624699] md: md1 stopped.
[    3.624959]  md0: unknown partition table
[    3.781889] md: bind<hdb2>
[    3.782406] md: bind<hda2>
[    3.802355] raid1: raid set md1 active with 2 out of 2 mirrors
[    3.802519] md1: detected capacity change from 0 to 319971524608
[    3.803225] md: md2 stopped.
[    3.803531]  md1: unknown partition table
[    3.992177] md: bind<hdd>
[    3.997028] md: bind<hdc>
[    4.016906] raid1: raid set md2 active with 2 out of 2 mirrors
[    4.017027] md2: detected capacity change from 0 to 250059227136
[    4.017533]  md2: unknown partition table
[    4.164606] device-mapper: uevent: version 1.0.3
[    4.164968] device-mapper: ioctl: 4.16.0-ioctl (2009-11-05) initialised:=
 dm-devel@redhat.com
[    8.279579] ohci_hcd 0000:00:0f.2: Unlink after no-IRQ?  Controller is p=
robably using the wrong IRQ.
[    8.675548] SGI XFS with ACLs, security attributes, realtime, large bloc=
k/inode numbers, no debug enabled
[    8.676738] SGI XFS Quota Management subsystem
[    8.768197] XFS mounting filesystem dm-26
[    8.931046] Starting XFS recovery on filesystem: dm-26 (logdev: internal)
[    9.096115] Ending XFS recovery on filesystem: dm-26 (logdev: internal)

--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci_vv

00:00.0 Host bridge: Broadcom CNB20LE Host Bridge (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 32 bytes
	Kernel modules: sworks-agp

00:00.1 Host bridge: Broadcom CNB20LE Host Bridge (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 48, Cache Line Size: 32 bytes
	Kernel modules: sworks-agp

00:02.0 Ethernet controller: Intel Corporation 82557/8/9/0/1 Ethernet Pro 100 (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Server Adapter (PILA8470B)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (2000ns min, 14000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fe000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d800 [size=64]
	Region 2: Memory at fd800000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
	Kernel driver in use: e100
	Kernel modules: e100, eepro100

00:05.0 PCI bridge: Pericom Semiconductor Device e111 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc800000-fd7fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] PCI-X bridge device
		Secondary Status: 64bit- 133MHz- SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=ff:1f.0 64bit- 133MHz- SCD- USC- SCO- SRD-
		Upstream: Capacity=16 CommitmentLimit=16
		Downstream: Capacity=16 CommitmentLimit=16
	Capabilities: [a8] Subsystem: Gammagraphx, Inc. Device 0000
	Capabilities: [b0] Express (v1) PCI/PCI-X Bridge, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr+ UnsuppReq- AuxPwr+ TransPend+
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <1us
			ClockPM- Suprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
	Capabilities: [d8] Vital Product Data <?>
	Capabilities: [f0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Kernel modules: shpchp

00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device 802b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (2000ns min), Cache Line Size: 32 bytes
	Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at b800 [size=256]
	Region 2: Memory at fa800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at febe0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: Broadcom OSB4 South Bridge (rev 50)
	Subsystem: Broadcom OSB4 South Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c-piix4

00:0f.1 IDE interface: Broadcom OSB4 IDE Controller (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at b400 [size=16]
	Kernel driver in use: Serverworks_IDE
	Kernel modules: serverworks

00:0f.2 USB Controller: Broadcom OSB4/CSB5 OHCI USB Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: Broadcom OSB4/CSB5 OHCI USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (20000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 30
	Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

01:00.0 Mass storage controller: Silicon Image, Inc. Sil 3531 [SATALink/SATARaid] Serial ATA Controller (rev 01)
	Subsystem: Silicon Image, Inc. Sil 3531 [SATALink/SATARaid] Serial ATA Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fd000000 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at fc800000 (64-bit, non-prefetchable) [size=8K]
	Region 4: I/O ports at c800 [size=128]
	Capabilities: [54] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Kernel modules: sata_sil24

02:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 07)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 72 (4250ns min, 16000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at b000 [size=256]
	Region 1: Memory at f9800000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at f9000000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: sym53c8xx
	Kernel modules: sym53c8xx

02:05.1 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 07)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 72 (4250ns min, 16000ns max), Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 25
	Region 0: I/O ports at a800 [size=256]
	Region 1: Memory at f8800000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at f8000000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: sym53c8xx
	Kernel modules: sym53c8xx


--4Epv4kl9IRBfg3rk--

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvRqUoACgkQEqu+mbnN8VIPsACgmu0/aNCb0JgfphZk6wkF9WqZ
k/EAn179hSZN60klt8hdFtBGrHNlYElo
=R2x0
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
