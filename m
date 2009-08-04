From: =?iso-8859-1?B?RGF27fA=?= Steinn Geirsson <david@dsg.to>
Subject: Re: HighPoint RocketRAID 2320
Date: Tue, 4 Aug 2009 17:48:52 +0000
Message-ID: <20090804174852.GH13863@dsg.to>
References: <20090803201836.GD13863@dsg.to> <20090803203139.GE13863@dsg.to> <4A7821AF.9010609@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pFej7zHSL6C5fFIz"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gozer.dsg.to ([79.171.98.146]:60783 "EHLO gozer.dsg.to"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932979AbZHDRsz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 13:48:55 -0400
Content-Disposition: inline
In-Reply-To: <4A7821AF.9010609@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org


--pFej7zHSL6C5fFIz
Content-Type: multipart/mixed; boundary="8kI7hWEHMS8Z+7/0"
Content-Disposition: inline


--8kI7hWEHMS8Z+7/0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

I tried this and attach a dmesg output. The result was the same.

Kind regards,
David

On Tue, Aug 04, 2009 at 08:55:27PM +0900, Tejun Heo wrote:
> Hello,
>=20
> What happens if you specify "libata.force=3Dnoncq"?
>=20
> --=20
> tejun

--=20
Dav=ED=F0 Steinn Geirsson
david@dsg.to

--8kI7hWEHMS8Z+7/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sata_mv-dmesg.noncq.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-btrfsnewformat2 (2.6.30) (root@slimer) =
(gcc version 4.3.3 (Debian 4.3.3-15) ) #3 SMP Mon Aug 3 18:09:53 GMT 2009
[    0.000000] Command line: root=3D/dev/mapper/slimerroot-root ro libata.f=
orce=3Dnoncq
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
[    0.000000]  BIOS-e820: 000000000009bc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cffc0000 (usable)
[    0.000000]  BIOS-e820: 00000000cffc0000 - 00000000cffce000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cffce000 - 00000000cfff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cfff0000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 00000001b0000000 (usable)
[    0.000000] DMI 2.3 present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working around =
it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usab=
le) =3D=3D> (reserved)
[    0.000000] last_pfn =3D 0x1b0000 max_arch_pfn =3D 0x100000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000000000 mask FF80000000 write-back
[    0.000000]   1 base 0080000000 mask FFC0000000 write-back
[    0.000000]   2 base 00C0000000 mask FFF0000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 00000001b0000000 aka 6912M
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] e820 update range: 00000000d0000000 - 0000000100000000 (usab=
le) =3D=3D> (reserved)
[    0.000000] last_pfn =3D 0xcffc0 max_arch_pfn =3D 0x100000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000cffc0000
[    0.000000]  0000000000 - 00cfe00000 page 2M
[    0.000000]  00cfe00000 - 00cffc0000 page 4k
[    0.000000] kernel direct mapping tables up to cffc0000 @ 10000-16000
[    0.000000] init_memory_mapping: 0000000100000000-00000001b0000000
[    0.000000]  0100000000 - 01b0000000 page 2M
[    0.000000] kernel direct mapping tables up to 1b0000000 @ 14000-1c000
[    0.000000] RAMDISK: 37753000 - 37fef542
[    0.000000] ACPI: RSDP 00000000000fb800 00024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT 00000000cffc0100 00054 (v01 A_M_I_ OEMXSDT  09000=
710 MSFT 00000097)
[    0.000000] ACPI: FACP 00000000cffc0290 000F4 (v03 A_M_I_ OEMFACP  09000=
710 MSFT 00000097)
[    0.000000] ACPI: DSDT 00000000cffc05c0 051BD (v01  A0653 A0653000 00000=
000 INTL 02002026)
[    0.000000] ACPI: FACS 00000000cffce000 00040
[    0.000000] ACPI: APIC 00000000cffc0390 00070 (v01 A_M_I_ OEMAPIC  09000=
710 MSFT 00000097)
[    0.000000] ACPI: MCFG 00000000cffc0400 0003C (v01 A_M_I_ OEMMCFG  09000=
710 MSFT 00000097)
[    0.000000] ACPI: OEMB 00000000cffce040 00060 (v01 A_M_I_ AMI_OEM  09000=
710 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000cffc5780 00038 (v01 A_M_I_ OEMHPET0 09000=
710 MSFT 00000097)
[    0.000000] ACPI: SSDT 00000000cffc57c0 00248 (v01 A_M_I_ POWERNOW 00000=
001 AMD  00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Scanning NUMA topology in Northbridge 24
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-00000001b0000000
[    0.000000] Bootmem setup node 0 0000000000000000-00000001b0000000
[    0.000000]   NODE_DATA [0000000000017000 - 000000000001efff]
[    0.000000]   bootmap [000000000001f000 -  0000000000054fff] pages 36
[    0.000000] (8 early reservations) =3D=3D> bootmem [0000000000 - 01b0000=
000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [000=
0000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE =3D=3D> [000=
0006000 - 0000008000]
[    0.000000]   #2 [0000200000 - 00007d38cc]    TEXT DATA BSS =3D=3D> [000=
0200000 - 00007d38cc]
[    0.000000]   #3 [0037753000 - 0037fef542]          RAMDISK =3D=3D> [003=
7753000 - 0037fef542]
[    0.000000]   #4 [000009bc00 - 0000100000]    BIOS reserved =3D=3D> [000=
009bc00 - 0000100000]
[    0.000000]   #5 [00007d4000 - 00007d4290]              BRK =3D=3D> [000=
07d4000 - 00007d4290]
[    0.000000]   #6 [0000010000 - 0000014000]          PGTABLE =3D=3D> [000=
0010000 - 0000014000]
[    0.000000]   #7 [0000014000 - 0000017000]          PGTABLE =3D=3D> [000=
0014000 - 0000017000]
[    0.000000] found SMP MP-table at [ffff8800000ff780] ff780
[    0.000000]  [ffffe20000000000-ffffe20005ffffff] PMD -> [ffff88002820000=
0-ffff88002d7fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x001b0000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009b
[    0.000000]     0: 0x00000100 -> 0x000cffc0
[    0.000000]     0: 0x00100000 -> 0x001b0000
[    0.000000] On node 0 totalpages: 1572683
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1601 pages reserved
[    0.000000]   DMA zone: 2322 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 833528 pages, LIFO batch:31
[    0.000000]   Normal zone: 9856 pages used for memmap
[    0.000000]   Normal zone: 711040 pages, LIFO batch:31
[    0.000000] Detected use of extended apic ids on hypertransport bus
[    0.000000] ACPI: PM-Timer IO Port: 0x508
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 0 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009b000 - 00000000000=
9c000
[    0.000000] PM: Registered nosave memory: 000000000009c000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 00000000001=
00000
[    0.000000] PM: Registered nosave memory: 00000000cffc0000 - 00000000cff=
ce000
[    0.000000] PM: Registered nosave memory: 00000000cffce000 - 00000000cff=
f0000
[    0.000000] PM: Registered nosave memory: 00000000cfff0000 - 00000000d00=
00000
[    0.000000] PM: Registered nosave memory: 00000000d0000000 - 00000000fec=
00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec=
01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fee=
00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fef=
00000
[    0.000000] PM: Registered nosave memory: 00000000fef00000 - 00000000ff7=
80000
[    0.000000] PM: Registered nosave memory: 00000000ff780000 - 00000001000=
00000
[    0.000000] Allocating PCI resources starting at d4000000 (gap: d0000000=
:2ec00000)
[    0.000000] NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 26 pages at ffff880028034000, static data 7=
6256 bytes
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Tota=
l pages: 1546890
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=3D/dev/mapper/slimerroot-root ro l=
ibata.force=3Dnoncq
[    0.000000] Unknown boot option `libata.force=3Dnoncq': ignoring
[    0.000000] Initializing CPU#0
[    0.000000] Experimental hierarchical RCU implementation.
[    0.000000] Experimental hierarchical RCU init done.
[    0.000000] NR_IRQS:4352 nr_irqs:424
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2411.163 MHz processor.
[    0.004000] spurious 8259A interrupt: IRQ7.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Checking aperture...
[    0.004000] No AGP bridge found
[    0.004000] Node 0: aperture @ 20000000 size 32 MB
[    0.004000] Aperture pointing to e820 RAM. Ignoring.
[    0.004000] Your BIOS doesn't leave a aperture memory hole
[    0.004000] Please enable the IOMMU option in the BIOS setup
[    0.004000] This costs you 64 MB of RAM
[    0.004000] Mapping aperture over 65536 KB of RAM @ 20000000
[    0.004000] PM: Registered nosave memory: 0000000020000000 - 00000000240=
00000
[    0.004000] Memory: 6121788k/7077888k available (2784k kernel code, 7871=
56k absent, 168944k reserved, 1376k data, 560k init)
[    0.004000] hpet clockevent registered
[    0.004000] HPET: 3 timers in total, 0 timers will be used for per-cpu t=
imer
[    0.004000] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4822.32 BogoMIPS (lpj=3D9644652)
[    0.004000] Security Framework initialized
[    0.004000] SELinux:  Disabled at boot.
[    0.004000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.006475] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.009158] Mount-cache hash table entries: 256
[    0.009376] Initializing cgroup subsys ns
[    0.009426] Initializing cgroup subsys cpuacct
[    0.009477] Initializing cgroup subsys devices
[    0.009527] Initializing cgroup subsys freezer
[    0.009579] Initializing cgroup subsys net_cls
[    0.009658] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.009713] CPU: L2 Cache: 512K (64 bytes/line)
[    0.009763] CPU 0/0x0 -> Node 0
[    0.009810] tseg: 0000000000
[    0.009822] CPU: Physical Processor ID: 0
[    0.009870] CPU: Processor Core ID: 0
[    0.009925] using C1E aware idle routine
[    0.010589] ACPI: Core revision 20090320
[    0.017436] Setting APIC routing to flat
[    0.017939] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D0 apic2=3D-1 pin2=3D=
-1
[    0.024001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.024001] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.024001] ..... (found apic 0 pin 0) ...
[    0.065540] ....... works.
[    0.065586] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.068001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 4821.86 Bog=
oMIPS (lpj=3D9643728)
[    0.004000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.004000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.004000] CPU 1/0x1 -> Node 0
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x701060007=
0106
[    0.152423] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.152949] Brought up 2 CPUs
[    0.152998] Total of 2 processors activated (9644.19 BogoMIPS).
[    0.153153] CPU0 attaching sched-domain:
[    0.153156]  domain 0: span 0-1 level MC
[    0.153158]   groups: 0 1
[    0.153163] CPU1 attaching sched-domain:
[    0.153164]  domain 0: span 0-1 level MC
[    0.153167]   groups: 1 0
[    0.153223] net_namespace: 1936 bytes
[    0.153223] Booting paravirtualized kernel on bare hardware
[    0.153223] regulator: core version 0.5
[    0.153223] NET: Registered protocol family 16
[    0.153223] node 0 link 0: io port [1000, ffffff]
[    0.153223] TOM: 00000000d0000000 aka 3328M
[    0.153223] node 0 link 0: mmio [e0000000, efffffff]
[    0.153223] node 0 link 0: mmio [a0000, bffff]
[    0.153223] node 0 link 0: mmio [d0000000, fe0bffff]
[    0.153223] TOM2: 00000001b0000000 aka 6912M
[    0.153223] bus: [00,ff] on node 0 link 0
[    0.153223] bus: 00 index 0 io port: [0, ffff]
[    0.153223] bus: 00 index 1 mmio: [d0000000, ffffffff]
[    0.153223] bus: 00 index 2 mmio: [a0000, bffff]
[    0.153223] bus: 00 index 3 mmio: [1b0000000, fcffffffff]
[    0.153223] ACPI: bus type pci registered
[    0.153223] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.153223] PCI: Not using MMCONFIG.
[    0.153223] PCI: Using configuration type 1 for base access
[    0.156109] bio: create slab <bio-0> at 0
[    0.156635] ACPI: EC: Look up EC in DSDT
[    0.168770] ACPI: Interpreter enabled
[    0.168821] ACPI: (supports S0 S1 S3 S4 S5)
[    0.169024] ACPI: Using IOAPIC for interrupt routing
[    0.169127] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.175613] PCI: MCFG area at e0000000 reserved in ACPI motherboard reso=
urces
[    0.186075] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.196166] ACPI Warning (tbutils-0246): Incorrect checksum in table [OE=
MB] - E5, should be D8 [20090320]
[    0.196308] ACPI: No dock devices found.
[    0.196420] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.196501] pci 0000:00:01.1: reg 10 io port: [0xbc00-0xbc3f]
[    0.196501] pci 0000:00:01.1: reg 20 io port: [0x600-0x63f]
[    0.196501] pci 0000:00:01.1: reg 24 io port: [0x700-0x73f]
[    0.196501] pci 0000:00:01.1: PME# supported from D3hot D3cold
[    0.196501] pci 0000:00:01.1: PME# disabled
[    0.196501] pci 0000:00:02.0: reg 10 32bit mmio: [0xdfbff000-0xdfbfffff]
[    0.196501] pci 0000:00:02.0: supports D1 D2
[    0.196501] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.196501] pci 0000:00:02.0: PME# disabled
[    0.196504] pci 0000:00:02.1: reg 10 32bit mmio: [0xdfbfec00-0xdfbfecff]
[    0.196528] pci 0000:00:02.1: supports D1 D2
[    0.196530] pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.196584] pci 0000:00:02.1: PME# disabled
[    0.196687] pci 0000:00:05.0: reg 10 32bit mmio: [0xdfbf8000-0xdfbfbfff]
[    0.196710] pci 0000:00:05.0: PME# supported from D3hot D3cold
[    0.196764] pci 0000:00:05.0: PME# disabled
[    0.196842] pci 0000:00:06.0: reg 20 io port: [0xffa0-0xffaf]
[    0.196875] pci 0000:00:07.0: reg 10 32bit mmio: [0xdfbfd000-0xdfbfdfff]
[    0.196879] pci 0000:00:07.0: reg 14 io port: [0xb480-0xb487]
[    0.196898] pci 0000:00:07.0: supports D1 D2
[    0.196900] pci 0000:00:07.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.196956] pci 0000:00:07.0: PME# disabled
[    0.197023] pci 0000:00:08.0: reg 10 io port: [0xb400-0xb407]
[    0.197027] pci 0000:00:08.0: reg 14 io port: [0xb080-0xb083]
[    0.197030] pci 0000:00:08.0: reg 18 io port: [0xb000-0xb007]
[    0.197033] pci 0000:00:08.0: reg 1c io port: [0xac00-0xac03]
[    0.197037] pci 0000:00:08.0: reg 20 io port: [0xa880-0xa88f]
[    0.197040] pci 0000:00:08.0: reg 24 32bit mmio: [0xdfbfc000-0xdfbfcfff]
[    0.197068] pci 0000:00:08.1: reg 10 io port: [0xa800-0xa807]
[    0.197071] pci 0000:00:08.1: reg 14 io port: [0xa480-0xa483]
[    0.197074] pci 0000:00:08.1: reg 18 io port: [0xa400-0xa407]
[    0.197078] pci 0000:00:08.1: reg 1c io port: [0xa080-0xa083]
[    0.197081] pci 0000:00:08.1: reg 20 io port: [0xa000-0xa00f]
[    0.197084] pci 0000:00:08.1: reg 24 32bit mmio: [0xdfbf3000-0xdfbf3fff]
[    0.197126] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.197180] pci 0000:00:09.0: PME# disabled
[    0.197254] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.197308] pci 0000:00:0b.0: PME# disabled
[    0.197382] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.197436] pci 0000:00:0c.0: PME# disabled
[    0.197578] pci 0000:01:03.0: reg 10 32bit mmio: [0xdfcff800-0xdfcfffff]
[    0.197584] pci 0000:01:03.0: reg 14 io port: [0xcc00-0xcc7f]
[    0.197613] pci 0000:01:03.0: supports D2
[    0.197614] pci 0000:01:03.0: PME# supported from D2 D3hot D3cold
[    0.197669] pci 0000:01:03.0: PME# disabled
[    0.197745] pci 0000:01:0a.0: reg 10 32bit mmio: [0xdfc00000-0xdfc7ffff]
[    0.197751] pci 0000:01:0a.0: reg 14 32bit mmio: [0xd0000000-0xd7ffffff]
[    0.197768] pci 0000:01:0a.0: reg 30 32bit mmio: [0xdfce0000-0xdfceffff]
[    0.197780] pci 0000:01:0a.0: supports D1 D2
[    0.197803] pci 0000:00:04.0: transparent bridge
[    0.197854] pci 0000:00:04.0: bridge io port: [0xc000-0xcfff]
[    0.197857] pci 0000:00:04.0: bridge 32bit mmio: [0xdfc00000-0xdfcfffff]
[    0.197860] pci 0000:00:04.0: bridge 32bit mmio pref: [0xd0000000-0xd7ff=
ffff]
[    0.197893] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.197947] pci 0000:02:00.0: PME# disabled
[    0.198033] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
[    0.198087] pci 0000:02:00.2: PME# disabled
[    0.198172] pci 0000:00:09.0: bridge io port: [0xd000-0xdfff]
[    0.198174] pci 0000:00:09.0: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.198250] pci 0000:04:04.0: reg 10 64bit mmio: [0xdfe00000-0xdfefffff]
[    0.198255] pci 0000:04:04.0: reg 18 io port: [0xd800-0xd8ff]
[    0.198316] pci 0000:02:00.2: bridge io port: [0xd000-0xdfff]
[    0.198320] pci 0000:02:00.2: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.198376] pci 0000:05:00.0: reg 10 32bit mmio: [0xdffe0000-0xdfffffff]
[    0.198385] pci 0000:05:00.0: reg 14 32bit mmio: [0xdffc0000-0xdffdffff]
[    0.198394] pci 0000:05:00.0: reg 18 io port: [0xec00-0xec1f]
[    0.198421] pci 0000:05:00.0: reg 30 32bit mmio: [0xdffa0000-0xdffbffff]
[    0.198458] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.200015] pci 0000:05:00.0: PME# disabled
[    0.200109] pci 0000:00:0b.0: bridge io port: [0xe000-0xefff]
[    0.200112] pci 0000:00:0b.0: bridge 32bit mmio: [0xdff00000-0xdfffffff]
[    0.200156] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.200321] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.200436] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.200500] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR11._PRT]
[    0.200563] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR12._PRT]
[    0.208275] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *0, disab=
led.
[    0.208680] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *0, disab=
led.
[    0.209160] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *11
[    0.209614] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disab=
led.
[    0.210096] ACPI: PCI Interrupt Link [LNEA] (IRQs 16 17 18 19) *0, disab=
led.
[    0.210576] ACPI: PCI Interrupt Link [LNEB] (IRQs 16 17 18 19) *10
[    0.211028] ACPI: PCI Interrupt Link [LNEC] (IRQs 16 17 18 19) *0, disab=
led.
[    0.212287] ACPI: PCI Interrupt Link [LNED] (IRQs 16 17 18 19) *11
[    0.212737] ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *11
[    0.213187] ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *10
[    0.213637] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *11
[    0.214095] ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *11
[    0.214548] ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0, disab=
led.
[    0.215029] ACPI: PCI Interrupt Link [LMC9] (IRQs 20 21 22 23) *0, disab=
led.
[    0.215744] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *10
[    0.216218] ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *0, disab=
led.
[    0.216702] ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *15
[    0.217154] ACPI: PCI Interrupt Link [LSA1] (IRQs 20 21 22 23) *5
[    0.217649] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disab=
led.
[    0.217963] usbcore: registered new interface driver usbfs
[    0.217963] usbcore: registered new interface driver hub
[    0.217963] usbcore: registered new device driver usb
[    0.217963] PCI: Using ACPI for IRQ routing
[    0.228130] PCI-DMA: Disabling AGP.
[    0.228251] PCI-DMA: aperture base @ 20000000 size 65536 KB
[    0.228251] PCI-DMA: using GART IOMMU.
[    0.228251] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    0.228649] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.228811] hpet0: 3 comparators, 32-bit 25.000000 MHz counter
[    0.236011] Switched to high resolution mode on CPU 0
[    0.236349] Switched to high resolution mode on CPU 1
[    0.240012] pnp: PnP ACPI init
[    0.240075] ACPI: bus type pnp registered
[    0.247756] pnp: PnP ACPI: found 15 devices
[    0.247806] ACPI: ACPI bus type pnp unregistered
[    0.247866] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[    0.247920] system 00:07: ioport range 0x800-0x80f has been reserved
[    0.247978] system 00:07: ioport range 0x500-0x57f has been reserved
[    0.248044] system 00:07: ioport range 0x580-0x5ff has been reserved
[    0.248098] system 00:07: ioport range 0x800-0x87f could not be reserved
[    0.248153] system 00:07: ioport range 0x880-0x8ff has been reserved
[    0.248207] system 00:07: ioport range 0xd00-0xd7f has been reserved
[    0.248265] system 00:07: ioport range 0xd80-0xdff has been reserved
[    0.248319] system 00:07: ioport range 0x2000-0x207f has been reserved
[    0.248373] system 00:07: ioport range 0x2080-0x20ff has been reserved
[    0.248428] system 00:07: iomem range 0xfefe0000-0xfefe01ff has been res=
erved
[    0.248487] system 00:07: iomem range 0xfefe1000-0xfefe1fff has been res=
erved
[    0.248543] system 00:07: iomem range 0xfee01000-0xfeefffff has been res=
erved
[    0.248598] system 00:07: iomem range 0xffb80000-0xffffffff has been res=
erved
[    0.248656] system 00:09: iomem range 0xfec00000-0xfec00fff has been res=
erved
[    0.248712] system 00:09: iomem range 0xfee00000-0xfee00fff has been res=
erved
[    0.248774] system 00:0b: ioport range 0x230-0x23f has been reserved
[    0.248828] system 00:0b: ioport range 0x290-0x29f has been reserved
[    0.248882] system 00:0b: ioport range 0xa00-0xa0f has been reserved
[    0.248936] system 00:0b: ioport range 0xa10-0xa1f has been reserved
[    0.248996] system 00:0d: iomem range 0xe0000000-0xefffffff has been res=
erved
[    0.249061] system 00:0e: iomem range 0x0-0x9ffff could not be reserved
[    0.249115] system 00:0e: iomem range 0xc0000-0xcffff has been reserved
[    0.249170] system 00:0e: iomem range 0xe0000-0xfffff could not be reser=
ved
[    0.249225] system 00:0e: iomem range 0x100000-0xcfffffff could not be r=
eserved
[    0.249296] system 00:0e: iomem range 0xff780000-0xffffffff could not be=
 reserved
[    0.254388] pci 0000:00:04.0: PCI bridge, secondary bus 0000:01
[    0.254441] pci 0000:00:04.0:   IO window: 0xc000-0xcfff
[    0.254494] pci 0000:00:04.0:   MEM window: 0xdfc00000-0xdfcfffff
[    0.254550] pci 0000:00:04.0:   PREFETCH window: 0x000000d0000000-0x0000=
00d7ffffff
[    0.254621] pci 0000:02:00.0: PCI bridge, secondary bus 0000:03
[    0.254675] pci 0000:02:00.0:   IO window: disabled
[    0.254727] pci 0000:02:00.0:   MEM window: disabled
[    0.254778] pci 0000:02:00.0:   PREFETCH window: disabled
[    0.254835] pci 0000:02:00.2: PCI bridge, secondary bus 0000:04
[    0.254888] pci 0000:02:00.2:   IO window: 0xd000-0xdfff
[    0.254941] pci 0000:02:00.2:   MEM window: 0xdfd00000-0xdfefffff
[    0.254994] pci 0000:02:00.2:   PREFETCH window: disabled
[    0.255048] pci 0000:00:09.0: PCI bridge, secondary bus 0000:02
[    0.255100] pci 0000:00:09.0:   IO window: 0xd000-0xdfff
[    0.255152] pci 0000:00:09.0:   MEM window: 0xdfd00000-0xdfefffff
[    0.255205] pci 0000:00:09.0:   PREFETCH window: disabled
[    0.255258] pci 0000:00:0b.0: PCI bridge, secondary bus 0000:05
[    0.255310] pci 0000:00:0b.0:   IO window: 0xe000-0xefff
[    0.255362] pci 0000:00:0b.0:   MEM window: 0xdff00000-0xdfffffff
[    0.255415] pci 0000:00:0b.0:   PREFETCH window: disabled
[    0.255468] pci 0000:00:0c.0: PCI bridge, secondary bus 0000:06
[    0.255520] pci 0000:00:0c.0:   IO window: disabled
[    0.255571] pci 0000:00:0c.0:   MEM window: disabled
[    0.255622] pci 0000:00:0c.0:   PREFETCH window: disabled
[    0.255678] pci 0000:00:04.0: setting latency timer to 64
[    0.255683] pci 0000:00:09.0: setting latency timer to 64
[    0.255688] pci 0000:02:00.0: setting latency timer to 64
[    0.255693] pci 0000:02:00.2: setting latency timer to 64
[    0.255698] pci 0000:00:0b.0: setting latency timer to 64
[    0.255701] pci 0000:00:0c.0: setting latency timer to 64
[    0.255705] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.255707] pci_bus 0000:00: resource 1 mem: [0x000000-0xfffffffffffffff=
f]
[    0.255710] pci_bus 0000:01: resource 0 io:  [0xc000-0xcfff]
[    0.255712] pci_bus 0000:01: resource 1 mem: [0xdfc00000-0xdfcfffff]
[    0.255714] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xd7ffffff]
[    0.255717] pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
[    0.255719] pci_bus 0000:01: resource 4 mem: [0x000000-0xfffffffffffffff=
f]
[    0.255722] pci_bus 0000:02: resource 0 io:  [0xd000-0xdfff]
[    0.255724] pci_bus 0000:02: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.255727] pci_bus 0000:04: resource 0 io:  [0xd000-0xdfff]
[    0.255729] pci_bus 0000:04: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.255732] pci_bus 0000:05: resource 0 io:  [0xe000-0xefff]
[    0.255734] pci_bus 0000:05: resource 1 mem: [0xdff00000-0xdfffffff]
[    0.255832] NET: Registered protocol family 2
[    0.284276] IP route cache hash table entries: 262144 (order: 9, 2097152=
 bytes)
[    0.286848] TCP established hash table entries: 524288 (order: 11, 83886=
08 bytes)
[    0.292093] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.292780] TCP: Hash tables configured (established 524288 bind 65536)
[    0.292835] TCP reno registered
[    0.300125] NET: Registered protocol family 1
[    0.300231] Trying to unpack rootfs image as initramfs...
[    0.495569] Freeing initrd memory: 8817k freed
[    0.502380] audit: initializing netlink socket (disabled)
[    0.502444] type=3D2000 audit(1249407343.500:1): initialized
[    0.502998] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.503214] VFS: Disk quotas dquot_6.5.2
[    0.503303] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.503418] msgmni has been set to 11973
[    0.503663] alg: No test for stdrng (krng)
[    0.503784] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    0.503854] io scheduler noop registered
[    0.503903] io scheduler anticipatory registered
[    0.503956] io scheduler deadline registered
[    0.504049] io scheduler cfq registered (default)
[    1.028329] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028424] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028528] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028632] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028734] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028840] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028950] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.029068] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.029131] pci 0000:01:0a.0: Boot video device
[    1.029320]   alloc irq_desc for 24 on cpu 0 node 0
[    1.029322]   alloc kstat_irqs on cpu 0 node 0
[    1.029330] pcieport-driver 0000:00:09.0: irq 24 for MSI/MSI-X
[    1.029336] pcieport-driver 0000:00:09.0: setting latency timer to 64
[    1.029504]   alloc irq_desc for 25 on cpu 0 node 0
[    1.029506]   alloc kstat_irqs on cpu 0 node 0
[    1.029510] pcieport-driver 0000:00:0b.0: irq 25 for MSI/MSI-X
[    1.029516] pcieport-driver 0000:00:0b.0: setting latency timer to 64
[    1.029674]   alloc irq_desc for 26 on cpu 0 node 0
[    1.029676]   alloc kstat_irqs on cpu 0 node 0
[    1.029681] pcieport-driver 0000:00:0c.0: irq 26 for MSI/MSI-X
[    1.029686] pcieport-driver 0000:00:0c.0: setting latency timer to 64
[    1.034026] Linux agpgart interface v0.103
[    1.034080] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.034254] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.034733] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.036651] brd: module loaded
[    1.036778] input: Macintosh mouse button emulation as /devices/virtual/=
input/input0
[    1.037125] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.037178] PNP: PS/2 appears to have AUX port disabled, if this is inco=
rrect please boot with i8042.nopnp
[    1.037403] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.037601] mice: PS/2 mouse device common for all mice
[    1.037716] rtc_cmos 00:02: RTC can wake from S4
[    1.037824] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    1.037913] rtc0: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    1.037997] cpuidle: using governor ladder
[    1.038046] cpuidle: using governor menu
[    1.038098] No iBFT detected.
[    1.038481] TCP cubic registered
[    1.038621] NET: Registered protocol family 10
[    1.039141] lo: Disabled Privacy Extensions
[    1.039468] Mobile IPv6
[    1.039515] NET: Registered protocol family 17
[    1.039716] registered taskstats version 1
[    1.039956] rtc_cmos 00:02: setting system clock to 2009-08-04 17:35:44 =
UTC (1249407344)
[    1.045133] Freeing unused kernel memory: 560k freed
[    1.045433] Write protecting the kernel read-only data: 3772k
[    1.055480] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    1.178276] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.4-k4
[    1.178345] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    1.179073] ACPI: PCI Interrupt Link [LNEB] enabled at IRQ 19
[    1.179133]   alloc irq_desc for 19 on cpu 0 node 0
[    1.179135]   alloc kstat_irqs on cpu 0 node 0
[    1.179146] e1000e 0000:05:00.0: PCI INT A -> Link[LNEB] -> GSI 19 (leve=
l, low) -> IRQ 19
[    1.179224] e1000e 0000:05:00.0: setting latency timer to 64
[    1.179376]   alloc irq_desc for 27 on cpu 0 node 0
[    1.179378]   alloc kstat_irqs on cpu 0 node 0
[    1.179391] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[    1.191219] Uniform Multi-Platform E-IDE driver
[    1.195076] forcedeth: Reverse Engineered nForce ethernet driver. Versio=
n 0.64.
[    1.195486] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 23
[    1.195541]   alloc irq_desc for 23 on cpu 0 node 0
[    1.195543]   alloc kstat_irqs on cpu 0 node 0
[    1.195554] forcedeth 0000:00:07.0: PCI INT A -> Link[LMAC] -> GSI 23 (l=
evel, low) -> IRQ 23
[    1.195628] forcedeth 0000:00:07.0: setting latency timer to 64
[    1.199936] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.240648] FDC 0 is a post-1991 82077
[    1.246685] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 18
[    1.246743]   alloc irq_desc for 18 on cpu 0 node 0
[    1.246745]   alloc kstat_irqs on cpu 0 node 0
[    1.246756] firewire_ohci 0000:01:03.0: PCI INT A -> Link[LNKC] -> GSI 1=
8 (level, low) -> IRQ 18
[    1.328043] firewire_ohci: Added fw-ohci device 0000:01:03.0, OHCI versi=
on 1.10
[    1.363233] 0000:05:00.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:15:17:=
24:85:7a
[    1.363309] 0000:05:00.0: eth0: Intel(R) PRO/1000 Network Connection
[    1.363435] 0000:05:00.0: eth0: MAC: 1, PHY: 4, PBA No: d50855-002
[    1.365166] udev: renamed network interface eth0 to eth1
[    1.712861] forcedeth 0000:00:07.0: ifname eth0, PHY OUI 0x1374 @ 1, add=
r 00:18:f3:aa:18:da
[    1.712939] forcedeth 0000:00:07.0: highdma pwrctl mgmt gbit lnktim msi =
desc-v3
[    1.714139] amd74xx 0000:00:06.0: UDMA133 controller
[    1.714193] amd74xx 0000:00:06.0: IDE controller (0x10de:0x03ec rev 0xa2)
[    1.714263] amd74xx 0000:00:06.0: IDE port disabled
[    1.714322] amd74xx 0000:00:06.0: BIOS didn't set cable bits correctly. =
Enabling workaround.
[    1.714399] amd74xx 0000:00:06.0: not 100% native mode: will probe irqs =
later
[    1.714456]     ide0: BM-DMA at 0xffa0-0xffa7
[    1.714510] Probing IDE interface ide0...
[    1.825080] firewire_core: created device fw0: GUID 0011d80000f46d61, S4=
00
[    2.000115] hda: WDC WD1600JB-00GVA0, ATA DISK drive
[    2.672053] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    2.673288] hda: UDMA/100 mode selected
[    2.674643] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.696045] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 22
[    2.696099]   alloc irq_desc for 22 on cpu 0 node 0
[    2.696101]   alloc kstat_irqs on cpu 0 node 0
[    2.696111] ehci_hcd 0000:00:02.1: PCI INT B -> Link[LUB2] -> GSI 22 (le=
vel, low) -> IRQ 22
[    2.696214] ehci_hcd 0000:00:02.1: setting latency timer to 64
[    2.696217] ehci_hcd 0000:00:02.1: EHCI Host Controller
[    2.696359] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus =
number 1
[    2.696458] ehci_hcd 0000:00:02.1: debug port 1
[    2.696509] ehci_hcd 0000:00:02.1: cache line size of 64 is not supported
[    2.696530] ehci_hcd 0000:00:02.1: irq 22, io mem 0xdfbfec00
[    2.708011] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00
[    2.708083] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    2.708137] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.708206] usb usb1: Product: EHCI Host Controller
[    2.708256] usb usb1: Manufacturer: Linux 2.6.30-btrfsnewformat2 ehci_hcd
[    2.708310] usb usb1: SerialNumber: 0000:00:02.1
[    2.708409] usb usb1: configuration #1 chosen from 1 choice
[    2.708491] hub 1-0:1.0: USB hub found
[    2.708547] hub 1-0:1.0: 10 ports detected
[    2.722978] SCSI subsystem initialized
[    2.737210] libata version 3.00 loaded.
[    2.740913] sata_nv 0000:00:08.0: version 3.5
[    2.741263] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 21
[    2.741323]   alloc irq_desc for 21 on cpu 0 node 0
[    2.741325]   alloc kstat_irqs on cpu 0 node 0
[    2.741336] sata_nv 0000:00:08.0: PCI INT A -> Link[LSA0] -> GSI 21 (lev=
el, low) -> IRQ 21
[    2.741484] sata_nv 0000:00:08.0: setting latency timer to 64
[    2.742709] scsi0 : sata_nv
[    2.742981] scsi1 : sata_nv
[    2.743206] ata1: SATA max UDMA/133 cmd 0xb400 ctl 0xb080 bmdma 0xa880 i=
rq 21
[    2.743262] ata2: SATA max UDMA/133 cmd 0xb000 ctl 0xac00 bmdma 0xa888 i=
rq 21
[    2.743766] ACPI: PCI Interrupt Link [LSA1] enabled at IRQ 20
[    2.743821]   alloc irq_desc for 20 on cpu 0 node 0
[    2.743823]   alloc kstat_irqs on cpu 0 node 0
[    2.743832] sata_nv 0000:00:08.1: PCI INT B -> Link[LSA1] -> GSI 20 (lev=
el, low) -> IRQ 20
[    2.743957] sata_nv 0000:00:08.1: setting latency timer to 64
[    2.744037] scsi2 : sata_nv
[    2.744243] scsi3 : sata_nv
[    2.744505] ata3: SATA max UDMA/133 cmd 0xa800 ctl 0xa480 bmdma 0xa000 i=
rq 20
[    2.744564] ata4: SATA max UDMA/133 cmd 0xa400 ctl 0xa080 bmdma 0xa008 i=
rq 20
[    2.806937] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.807583] ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 23
[    2.807639] ohci_hcd 0000:00:02.0: PCI INT A -> Link[LUB0] -> GSI 23 (le=
vel, low) -> IRQ 23
[    2.807743] ohci_hcd 0000:00:02.0: setting latency timer to 64
[    2.807746] ohci_hcd 0000:00:02.0: OHCI Host Controller
[    2.807877] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus =
number 2
[    2.807977] ohci_hcd 0000:00:02.0: irq 23, io mem 0xdfbff000
[    2.866021] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    2.866078] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.866148] usb usb2: Product: OHCI Host Controller
[    2.866199] usb usb2: Manufacturer: Linux 2.6.30-btrfsnewformat2 ohci_hcd
[    2.866253] usb usb2: SerialNumber: 0000:00:02.0
[    2.866376] usb usb2: configuration #1 chosen from 1 choice
[    2.866461] hub 2-0:1.0: USB hub found
[    2.866517] hub 2-0:1.0: 10 ports detected
[    3.208032] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.216114] ata1.00: FORCE: horkage modified (noncq)
[    3.217512] ata1.00: ATA-6: WDC WD1600JD-00GBB0, 02.05D02, max UDMA/100
[    3.217570] ata1.00: 312581808 sectors, multi 16: LBA48=20
[    3.217633] ata1.00: applying bridge limits
[    3.233445] ata1.00: configured for UDMA/100
[    3.233588] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JD-00G 02=
=2E0 PQ: 0 ANSI: 5
[    3.700032] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.708114] ata2.00: FORCE: horkage modified (noncq)
[    3.708167] ata2.00: ATAPI: TSSTcorp CDDVDW SH-S223F, SB03, max UDMA/100
[    3.724126] ata2.00: configured for UDMA/100
[    3.725643] scsi 1:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S223F  SB=
03 PQ: 0 ANSI: 5
[    4.049150] Driver 'sd' needs updating - please use bus_type methods
[    4.049340] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 =
GB/149 GiB)
[    4.049424] sd 0:0:0:0: [sda] Write Protect is off
[    4.049479] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.049498] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    4.049654]  sda:<6>ide-gd driver 1.18
[    4.054468] hda: max request size: 512KiB
[    4.065415]  sda1 sda2 sda3
[    4.088453] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.090795] Driver 'sr' needs updating - please use bus_type methods
[    4.094230] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    4.094306] Uniform CD-ROM driver Revision: 3.20
[    4.094464] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    4.102760] hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=3D19=
457/255/63
[    4.104083] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.104166] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    4.104822] hda: cache flushes supported
[    4.104933]  hda: hda1 hda2 hda3
[    4.605632] md: raid1 personality registered for level 1
[    4.607214] xor: automatically using best checksumming function: generic=
_sse
[    4.625008]    generic_sse:  7436.000 MB/sec
[    4.625057] xor: using function: generic_sse (7436.000 MB/sec)
[    4.625617] async_tx: api initialized (async)
[    4.693013] raid6: int64x1   2222 MB/s
[    4.761016] raid6: int64x2   2870 MB/s
[    4.829012] raid6: int64x4   2230 MB/s
[    4.897018] raid6: int64x8   2010 MB/s
[    4.965057] raid6: sse2x1    1211 MB/s
[    5.033022] raid6: sse2x2    1930 MB/s
[    5.101014] raid6: sse2x4    3255 MB/s
[    5.101062] raid6: using algorithm sse2x4 (3255 MB/s)
[    5.103980] md: raid6 personality registered for level 6
[    5.104053] md: raid5 personality registered for level 5
[    5.104104] md: raid4 personality registered for level 4
[    5.236876] md: md0 stopped.
[    5.285929] md: bind<hda1>
[    5.286165] md: bind<sda1>
[    5.287435] raid1: raid set md0 active with 2 out of 2 mirrors
[    5.292114]  md0: unknown partition table
[    5.377931] md: md1 stopped.
[    5.379632] md: bind<hda2>
[    5.379849] md: bind<sda2>
[    5.381160] raid1: raid set md1 active with 2 out of 2 mirrors
[    5.386213]  md1: unknown partition table
[    5.416697] device-mapper: uevent: version 1.0.3
[    5.416988] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised:=
 dm-devel@redhat.com
[    5.581636] PM: Starting manual resume from disk
[    5.631654] kjournald starting.  Commit interval 5 seconds
[    5.631721] EXT3-fs: mounted filesystem with ordered data mode.
[    6.924171] udev: starting version 141
[    7.260210] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    7.260291] ACPI: Power Button [PWRF]
[    7.260421] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
C:00/input/input3
[    7.260497] ACPI: Power Button [PWRB]
[    7.411992] parport_pc 00:06: reported by Plug and Play ACPI
[    7.412092] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    7.671928] processor ACPI_CPU:00: registered as cooling_device0
[    7.672208] processor ACPI_CPU:01: registered as cooling_device1
[    7.678417] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    7.680832] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    7.681649] k8temp 0000:00:18.3: Temperature readouts might be wrong - c=
heck erratum #141
[    7.707732] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x600
[    7.707804] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x700
[    7.799253] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    7.983486] Error: Driver 'pcspkr' is already registered, aborting...
[    7.993187] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 22
[    7.993248] HDA Intel 0000:00:05.0: PCI INT B -> Link[LAZA] -> GSI 22 (l=
evel, low) -> IRQ 22
[    7.993491] HDA Intel 0000:00:05.0: setting latency timer to 64
[    8.733659] hda_codec: Unknown model for AD1988, trying auto-probe from =
BIOS...
[    8.733829] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:05.=
0/input/input5
[   11.577501] Adding 3943948k swap on /dev/sda3.  Priority:-1 extents:1 ac=
ross:3943948k=20
[   11.608892] Adding 3943948k swap on /dev/hda3.  Priority:-2 extents:1 ac=
ross:3943948k=20
[   11.825826] EXT3 FS on dm-0, internal journal
[   11.987684] loop: module loaded
[   12.925788] kjournald starting.  Commit interval 5 seconds
[   12.932058] EXT3 FS on md0, internal journal
[   12.932140] EXT3-fs: mounted filesystem with ordered data mode.
[   13.055377] EXT4-fs: barriers enabled
[   13.072066] kjournald2 starting: pid 2340, dev dm-3:8, commit interval 5=
 seconds
[   13.104302] EXT4 FS on dm-3, internal journal on dm-3:8
[   13.104356] EXT4-fs: delayed allocation enabled
[   13.104406] EXT4-fs: file extents enabled
[   13.105731] EXT4-fs: mballoc enabled
[   13.105793] EXT4-fs: mounted filesystem dm-3 with ordered data mode
[   14.394009] Bridge firewalling registered
[   14.424253] device eth1 entered promiscuous mode
[   14.568393] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[   14.625097] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[   14.626838] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   17.903464] Loading iSCSI transport class v2.0-870.
[   17.941732] iscsi: registered transport (tcp)
[   18.003224] iscsi: registered transport (iser)
[   18.570140] RPC: Registered udp transport module.
[   18.570210] RPC: Registered tcp transport module.
[   18.633920] Slow work thread pool: Starting up
[   18.634324] Slow work thread pool: Ready
[   18.634425] FS-Cache: Loaded
[   18.674523] FS-Cache: Netfs 'nfs' registered for caching
[   18.703198] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   24.788010] br0: no IPv6 routers present
[   27.404008] torbr: no IPv6 routers present
[   81.917171] virbr1: starting userspace STP failed, starting kernel STP
[   81.957399] svc: failed to register lockdv1 RPC service (errno 97).
[   81.957930] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recov=
ery directory
[   81.969553] NFSD: starting 90-second grace period
[   82.068055] ip_tables: (C) 2000-2006 Netfilter Core Team
[   83.829202] tun: Universal TUN/TAP device driver, 1.6
[   83.829257] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   83.831955] device vnet0 entered promiscuous mode
[   83.833678] br0: port 2(vnet0) entering learning state
[   84.035664] br0: port 2(vnet0) entering disabled state
[   84.050346] device vnet0 left promiscuous mode
[   84.050401] br0: port 2(vnet0) entering disabled state
[   84.214363] lo: Disabled Privacy Extensions
[   92.108011] virbr1: no IPv6 routers present
[  105.019642] sata_mv 0000:04:04.0: version 1.28
[  105.020160] ACPI: PCI Interrupt Link [LNED] enabled at IRQ 17
[  105.020218]   alloc irq_desc for 17 on cpu 0 node 0
[  105.020220]   alloc kstat_irqs on cpu 0 node 0
[  105.020231] sata_mv 0000:04:04.0: PCI INT A -> Link[LNED] -> GSI 17 (lev=
el, low) -> IRQ 17
[  105.020523] sata_mv 0000:04:04.0: Gen-II 32 slots 8 ports SCSI mode IRQ =
via INTx
[  105.021680] scsi4 : sata_mv
[  105.022203] scsi5 : sata_mv
[  105.023376] scsi6 : sata_mv
[  105.023569] scsi7 : sata_mv
[  105.023806] scsi8 : sata_mv
[  105.024133] scsi9 : sata_mv
[  105.024585] scsi10 : sata_mv
[  105.024730] scsi11 : sata_mv
[  105.024820] ata5: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
2000 irq 17
[  105.024891] ata6: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
4000 irq 17
[  105.024963] ata7: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
6000 irq 17
[  105.025035] ata8: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
8000 irq 17
[  105.025107] ata9: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe3=
2000 irq 17
[  105.025178] ata10: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
34000 irq 17
[  105.025248] ata11: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
36000 irq 17
[  105.025319] ata12: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
38000 irq 17
[  105.500041] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  105.508246] ata5.00: FORCE: horkage modified (noncq)
[  105.532049] ata5.00: ATA-8: WDC WD5000AAKS-00A7B0, 01.03B01, max UDMA/133
[  105.532106] ata5.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[  105.556062] ata5.00: configured for UDMA/133
[  105.556190] scsi 4:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 01=
=2E0 PQ: 0 ANSI: 5
[  105.556398] sd 4:0:0:0: Attached scsi generic sg2 type 0
[  105.556523] sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  105.556604] sd 4:0:0:0: [sdb] Write Protect is off
[  105.556656] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  105.556675] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  105.556835]  sdb:<6>ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  106.048053] ata6.00: FORCE: horkage modified (noncq)
[  106.072048] ata6.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  106.072105] ata6.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[  106.104063] ata6.00: configured for UDMA/133
[  106.104199] scsi 5:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  106.104412] sd 5:0:0:0: Attached scsi generic sg3 type 0
[  106.104540] sd 5:0:0:0: [sdc] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  106.104621] sd 5:0:0:0: [sdc] Write Protect is off
[  106.104672] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  106.104690] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  106.104850]  sdc:<6>ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  106.596052] ata7.00: FORCE: horkage modified (noncq)
[  106.620048] ata7.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  106.620103] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[  106.653060] ata7.00: configured for UDMA/133
[  106.653183] scsi 6:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  106.653385] sd 6:0:0:0: Attached scsi generic sg4 type 0
[  106.653510] sd 6:0:0:0: [sdd] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  106.653596] sd 6:0:0:0: [sdd] Write Protect is off
[  106.653647] sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[  106.653665] sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  106.653826]  sdd:<6>ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  107.144053] ata8.00: FORCE: horkage modified (noncq)
[  107.176048] ata8.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  107.176103] ata8.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[  107.208062] ata8.00: configured for UDMA/133
[  107.208198] scsi 7:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  107.208402] sd 7:0:0:0: Attached scsi generic sg5 type 0
[  107.208528] sd 7:0:0:0: [sde] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  107.213696] sd 7:0:0:0: [sde] Write Protect is off
[  107.213747] sd 7:0:0:0: [sde] Mode Sense: 00 3a 00 00
[  107.213765] sd 7:0:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  107.213928]  sde:<6>ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  107.704053] ata9.00: FORCE: horkage modified (noncq)
[  107.704107] ata9.00: ATA-7: WDC WD5000AAKS-65TMA0, 12.01C01, max UDMA/133
[  107.704162] ata9.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[  107.728068] ata9.00: configured for UDMA/133
[  107.728205] scsi 8:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-6 12=
=2E0 PQ: 0 ANSI: 5
[  107.728411] sd 8:0:0:0: Attached scsi generic sg6 type 0
[  107.728538] sd 8:0:0:0: [sdf] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  107.728620] sd 8:0:0:0: [sdf] Write Protect is off
[  107.728674] sd 8:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[  107.728692] sd 8:0:0:0: [sdf] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  107.728854]  sdf:<6>ata10: SATA link down (SStatus 0 SControl 300)
[  108.368032] ata11: SATA link down (SStatus 0 SControl 300)
[  108.688028] ata12: SATA link down (SStatus 0 SControl 300)
[  135.819010] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  135.819073] ata5.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  135.819075]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  135.819211] ata5.00: status: { DRDY }
[  135.819262] ata5: hard resetting link
[  136.292031] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  136.324062] ata5.00: configured for UDMA/133
[  136.324120] ata5: EH complete
[  136.818998] ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  136.819058] ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  136.819059]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  136.819195] ata6.00: status: { DRDY }
[  136.819246] ata6: hard resetting link
[  136.834703] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  136.834761] ata7.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  136.834762]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  136.834898] ata7.00: status: { DRDY }
[  136.834948] ata7: hard resetting link
[  137.300036] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  137.308356] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  137.380090] ata6.00: configured for UDMA/133
[  137.380153] ata6: EH complete
[  137.388063] ata7.00: configured for UDMA/133
[  137.388118] ata7: EH complete
[  137.819000] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  137.819061] ata8.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  137.819062]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  137.819202] ata8.00: status: { DRDY }
[  137.819255] ata8: hard resetting link
[  137.834715] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  137.834773] ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  137.834775]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  137.834913] ata9.00: status: { DRDY }
[  137.834962] ata9: hard resetting link
[  138.300033] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  138.308357] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  138.348218] ata9.00: configured for UDMA/133
[  138.348280] ata9: EH complete
[  138.380061] ata8.00: configured for UDMA/133
[  138.380116] ata8: EH complete
[  166.819003] ata5: limiting SATA link speed to 1.5 Gbps
[  166.819058] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  166.819118] ata5.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  166.819119]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  166.819256] ata5.00: status: { DRDY }
[  166.819306] ata5: hard resetting link
[  167.293030] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  167.332063] ata5.00: configured for UDMA/133
[  167.332120] ata5: EH complete
[  167.819003] ata6: limiting SATA link speed to 1.5 Gbps
[  167.819056] ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  167.819115] ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  167.819117]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  167.819253] ata6.00: status: { DRDY }
[  167.819303] ata6: hard resetting link
[  167.834770] ata7: limiting SATA link speed to 1.5 Gbps
[  167.834824] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  167.834882] ata7.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  167.834883]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  167.835019] ata7.00: status: { DRDY }
[  167.835069] ata7: hard resetting link
[  168.301033] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  168.309029] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  168.372092] ata6.00: configured for UDMA/133
[  168.372156] ata6: EH complete
[  168.380065] ata7.00: configured for UDMA/133
[  168.380119] ata7: EH complete
[  168.819131] ata9: limiting SATA link speed to 1.5 Gbps
[  168.819185] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  168.819245] ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  168.819246]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  168.819383] ata9.00: status: { DRDY }
[  168.819434] ata9: hard resetting link
[  168.834901] ata8: limiting SATA link speed to 1.5 Gbps
[  168.834953] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  168.835013] ata8.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  168.835014]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  168.835154] ata8.00: status: { DRDY }
[  168.835203] ata8: hard resetting link
[  169.300029] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  169.308354] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  169.341182] ata9.00: configured for UDMA/133
[  169.341247] ata9: EH complete
[  169.388061] ata8.00: configured for UDMA/133
[  169.388115] ata8: EH complete
[  197.818999] ata5.00: limiting speed to UDMA/100:PIO4
[  197.819055] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  197.819115] ata5.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  197.819116]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  197.819254] ata5.00: status: { DRDY }
[  197.819305] ata5: hard resetting link
[  198.293041] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  198.333061] ata5.00: configured for UDMA/100
[  198.333121] ata5: EH complete
[  198.819005] ata6.00: limiting speed to UDMA/100:PIO4
[  198.819061] ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  198.819121] ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  198.819122]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  198.819259] ata6.00: status: { DRDY }
[  198.819310] ata6: hard resetting link
[  198.834780] ata7.00: limiting speed to UDMA/100:PIO4
[  198.834831] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  198.834891] ata7.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  198.834892]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  198.835031] ata7.00: status: { DRDY }
[  198.835083] ata7: hard resetting link
[  199.300030] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  199.308354] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  199.364201] ata6.00: configured for UDMA/100
[  199.364257] ata6: EH complete
[  199.373061] ata7.00: configured for UDMA/100
[  199.373114] ata7: EH complete
[  199.819002] ata9.00: limiting speed to UDMA/100:PIO4
[  199.819054] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  199.819113] ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  199.819115]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  199.819252] ata9.00: status: { DRDY }
[  199.819302] ata9: hard resetting link
[  199.834768] ata8.00: limiting speed to UDMA/100:PIO4
[  199.834819] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  199.834877] ata8.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  199.834879]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  199.835018] ata8.00: status: { DRDY }
[  199.835067] ata8: hard resetting link
[  200.301033] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  200.309354] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  200.341173] ata9.00: configured for UDMA/100
[  200.341230] ata9: EH complete
[  200.389061] ata8.00: configured for UDMA/100
[  200.389118] ata8: EH complete
[  228.819137] ata5.00: limiting speed to UDMA/33:PIO4
[  228.819177] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  228.819223] ata5.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  228.819224]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  228.819308] ata5.00: status: { DRDY }
[  228.819345] ata5: hard resetting link
[  229.292030] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  229.332062] ata5.00: configured for UDMA/33
[  229.332117] ata5: EH complete
[  229.819008] ata6.00: limiting speed to UDMA/33:PIO4
[  229.819063] ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  229.819123] ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  229.819124]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  229.819262] ata6.00: status: { DRDY }
[  229.819313] ata6: hard resetting link
[  229.834782] ata7.00: limiting speed to UDMA/33:PIO4
[  229.834836] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  229.834894] ata7.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  229.834895]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  229.835031] ata7.00: status: { DRDY }
[  229.835081] ata7: hard resetting link
[  230.300032] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  230.308355] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  230.365198] ata6.00: configured for UDMA/33
[  230.365254] ata6: EH complete
[  230.373062] ata7.00: configured for UDMA/33
[  230.373115] ata7: EH complete
[  230.819000] ata9.00: limiting speed to UDMA/33:PIO4
[  230.819053] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  230.819114] ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  230.819116]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  230.819254] ata9.00: status: { DRDY }
[  230.819305] ata9: hard resetting link
[  230.834772] ata8.00: limiting speed to UDMA/33:PIO4
[  230.834823] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  230.834881] ata8.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  230.834883]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  230.835022] ata8.00: status: { DRDY }
[  230.835071] ata8: hard resetting link
[  231.300034] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  231.308355] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  231.340174] ata9.00: configured for UDMA/33
[  231.340230] ata9: EH complete
[  231.388061] ata8.00: configured for UDMA/33
[  231.388116] ata8: EH complete

--8kI7hWEHMS8Z+7/0--

--pFej7zHSL6C5fFIz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFKeHSE1zX4pjkhuygRAhPEAJ9Hnk6UNV0OI4QIhty23ZhnJzvOrwCfQ2PX
VXPmGS9IphJq5G13pOwsYSs=
=SiQr
-----END PGP SIGNATURE-----

--pFej7zHSL6C5fFIz--
