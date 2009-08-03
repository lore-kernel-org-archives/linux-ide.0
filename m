From: =?iso-8859-1?B?RGF27fA=?= Steinn Geirsson <david@dsg.to>
Subject: Re: HighPoint RocketRAID 2320
Date: Mon, 3 Aug 2009 20:31:39 +0000
Message-ID: <20090803203139.GE13863@dsg.to>
References: <20090803201836.GD13863@dsg.to>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gozer.dsg.to ([79.171.98.146]:43407 "EHLO gozer.dsg.to"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129AbZHCUbl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Aug 2009 16:31:41 -0400
Content-Disposition: inline
In-Reply-To: <20090803201836.GD13863@dsg.to>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--GdbWtwDHkcXqP16f
Content-Type: multipart/mixed; boundary="m1UC1K4AOz1Ywdkx"
Content-Disposition: inline


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I forgot to attach the dmesg output. Sorry about that.

On Mon, Aug 03, 2009 at 08:18:36PM +0000, Dav=ED=F0 Steinn Geirsson wrote:
> Hi all,
>=20
> I'm throwing this out here in the hopes that someone smarter than me has
> a simple solution - never hurts to be optimistic. :)
>=20
> I have a HighPoint controller, RocketRAID 2320 (8-port PCIe SATA fakeraid=
). It is only supported by an ugly binary blob deceptively labeled as an "o=
pen source driver" from HighPoint (rr232x). Looking at the wrapper around t=
he blob, it seems this driver claims only the 2320 and 2322 controllers:
>=20
> static const struct pci_device_id hpt_pci_tbl[] =3D {
>         {PCI_DEVICE(0x1103, 0x2320), 0, 0, 0},
>         {PCI_DEVICE(0x1103, 0x2322), 0, 0, 0},
>         {}
> };
>=20
> I've found that this controller contains a marvell 88SX6081 chip, which
> should be supported by the sata_mv driver. That driver claims device IDs
> 2300 and 2310:
>         { PCI_VDEVICE(TTI, 0x2300), chip_7042 },
>         { PCI_VDEVICE(TTI, 0x2310), chip_7042 },
>=20
> So, ever hopeful, I tried adding the 2320 into the table:
>         { PCI_VDEVICE(TTI, 0x2320), chip_608x },
>=20
> When I do this, the kernel successfully probes the attached disks and
> their capacity, but immediately errors out and starts resetting the
> ports repeatedly.
>=20
> I've attached a dmesg output. I can provide any further debugging info
> or try different things.
>=20
> I've tried defining the controller with chip_6042, chip_604x and
> chip_7042 with no success.
>=20
> PS: Please CC me on replies, as I'm not subscribed to linux-ide.
>=20
> Kind regards,
>=20
> --=20
> Dav=ED=F0 Steinn Geirsson
> david@dsg.to



--=20
Dav=ED=F0 Steinn Geirsson
david@dsg.to

--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sata_mv-dmesg.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-btrfsnewformat2 (2.6.30) (root@slimer) =
(gcc version 4.3.3 (Debian 4.3.3-15) ) #3 SMP Mon Aug 3 18:09:53 GMT 2009
[    0.000000] Command line: root=3D/dev/mapper/slimerroot-root ro=20
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
[    0.000000] Kernel command line: root=3D/dev/mapper/slimerroot-root ro=
=20
[    0.000000] Initializing CPU#0
[    0.000000] Experimental hierarchical RCU implementation.
[    0.000000] Experimental hierarchical RCU init done.
[    0.000000] NR_IRQS:4352 nr_irqs:424
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2410.917 MHz processor.
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
er frequency.. 4821.83 BogoMIPS (lpj=3D9643668)
[    0.004000] Security Framework initialized
[    0.004000] SELinux:  Disabled at boot.
[    0.004000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.006480] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.009164] Mount-cache hash table entries: 256
[    0.009382] Initializing cgroup subsys ns
[    0.009433] Initializing cgroup subsys cpuacct
[    0.009484] Initializing cgroup subsys devices
[    0.009538] Initializing cgroup subsys freezer
[    0.009587] Initializing cgroup subsys net_cls
[    0.009667] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.009722] CPU: L2 Cache: 512K (64 bytes/line)
[    0.009772] CPU 0/0x0 -> Node 0
[    0.009823] tseg: 0000000000
[    0.009834] CPU: Physical Processor ID: 0
[    0.009886] CPU: Processor Core ID: 0
[    0.009941] using C1E aware idle routine
[    0.010605] ACPI: Core revision 20090320
[    0.017452] Setting APIC routing to flat
[    0.017951] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D0 apic2=3D-1 pin2=3D=
-1
[    0.024001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.024001] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.024001] ..... (found apic 0 pin 0) ...
[    0.065542] ....... works.
[    0.065588] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.068001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 4821.87 Bog=
oMIPS (lpj=3D9643742)
[    0.004000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.004000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.004000] CPU 1/0x1 -> Node 0
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x701060007=
0106
[    0.152416] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.152941] Brought up 2 CPUs
[    0.152989] Total of 2 processors activated (9643.70 BogoMIPS).
[    0.153144] CPU0 attaching sched-domain:
[    0.153147]  domain 0: span 0-1 level MC
[    0.153149]   groups: 0 1
[    0.153154] CPU1 attaching sched-domain:
[    0.153156]  domain 0: span 0-1 level MC
[    0.153157]   groups: 1 0
[    0.153213] net_namespace: 1936 bytes
[    0.153213] Booting paravirtualized kernel on bare hardware
[    0.153213] regulator: core version 0.5
[    0.153213] NET: Registered protocol family 16
[    0.153213] node 0 link 0: io port [1000, ffffff]
[    0.153213] TOM: 00000000d0000000 aka 3328M
[    0.153213] node 0 link 0: mmio [e0000000, efffffff]
[    0.153213] node 0 link 0: mmio [a0000, bffff]
[    0.153213] node 0 link 0: mmio [d0000000, fe0bffff]
[    0.153213] TOM2: 00000001b0000000 aka 6912M
[    0.153213] bus: [00,ff] on node 0 link 0
[    0.153213] bus: 00 index 0 io port: [0, ffff]
[    0.153213] bus: 00 index 1 mmio: [d0000000, ffffffff]
[    0.153213] bus: 00 index 2 mmio: [a0000, bffff]
[    0.153213] bus: 00 index 3 mmio: [1b0000000, fcffffffff]
[    0.153213] ACPI: bus type pci registered
[    0.153213] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.153213] PCI: Not using MMCONFIG.
[    0.153213] PCI: Using configuration type 1 for base access
[    0.156092] bio: create slab <bio-0> at 0
[    0.156648] ACPI: EC: Look up EC in DSDT
[    0.167304] ACPI: Interpreter enabled
[    0.167354] ACPI: (supports S0 S1 S3 S4 S5)
[    0.167559] ACPI: Using IOAPIC for interrupt routing
[    0.168056] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.175159] PCI: MCFG area at e0000000 reserved in ACPI motherboard reso=
urces
[    0.185519] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.196115] ACPI Warning (tbutils-0246): Incorrect checksum in table [OE=
MB] - E5, should be D8 [20090320]
[    0.196354] ACPI: No dock devices found.
[    0.196466] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.196549] pci 0000:00:01.1: reg 10 io port: [0xbc00-0xbc3f]
[    0.196549] pci 0000:00:01.1: reg 20 io port: [0x600-0x63f]
[    0.196549] pci 0000:00:01.1: reg 24 io port: [0x700-0x73f]
[    0.196549] pci 0000:00:01.1: PME# supported from D3hot D3cold
[    0.196549] pci 0000:00:01.1: PME# disabled
[    0.196549] pci 0000:00:02.0: reg 10 32bit mmio: [0xdfbff000-0xdfbfffff]
[    0.196549] pci 0000:00:02.0: supports D1 D2
[    0.196549] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.196549] pci 0000:00:02.0: PME# disabled
[    0.196549] pci 0000:00:02.1: reg 10 32bit mmio: [0xdfbfec00-0xdfbfecff]
[    0.196549] pci 0000:00:02.1: supports D1 D2
[    0.196549] pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.196600] pci 0000:00:02.1: PME# disabled
[    0.196703] pci 0000:00:05.0: reg 10 32bit mmio: [0xdfbf8000-0xdfbfbfff]
[    0.196727] pci 0000:00:05.0: PME# supported from D3hot D3cold
[    0.196780] pci 0000:00:05.0: PME# disabled
[    0.196858] pci 0000:00:06.0: reg 20 io port: [0xffa0-0xffaf]
[    0.196891] pci 0000:00:07.0: reg 10 32bit mmio: [0xdfbfd000-0xdfbfdfff]
[    0.196894] pci 0000:00:07.0: reg 14 io port: [0xb480-0xb487]
[    0.196913] pci 0000:00:07.0: supports D1 D2
[    0.196915] pci 0000:00:07.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.196971] pci 0000:00:07.0: PME# disabled
[    0.197038] pci 0000:00:08.0: reg 10 io port: [0xb400-0xb407]
[    0.197042] pci 0000:00:08.0: reg 14 io port: [0xb080-0xb083]
[    0.197045] pci 0000:00:08.0: reg 18 io port: [0xb000-0xb007]
[    0.197048] pci 0000:00:08.0: reg 1c io port: [0xac00-0xac03]
[    0.197052] pci 0000:00:08.0: reg 20 io port: [0xa880-0xa88f]
[    0.197055] pci 0000:00:08.0: reg 24 32bit mmio: [0xdfbfc000-0xdfbfcfff]
[    0.197083] pci 0000:00:08.1: reg 10 io port: [0xa800-0xa807]
[    0.197086] pci 0000:00:08.1: reg 14 io port: [0xa480-0xa483]
[    0.197090] pci 0000:00:08.1: reg 18 io port: [0xa400-0xa407]
[    0.197093] pci 0000:00:08.1: reg 1c io port: [0xa080-0xa083]
[    0.197096] pci 0000:00:08.1: reg 20 io port: [0xa000-0xa00f]
[    0.197100] pci 0000:00:08.1: reg 24 32bit mmio: [0xdfbf3000-0xdfbf3fff]
[    0.197141] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.197195] pci 0000:00:09.0: PME# disabled
[    0.197270] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.197324] pci 0000:00:0b.0: PME# disabled
[    0.197398] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.197452] pci 0000:00:0c.0: PME# disabled
[    0.197595] pci 0000:01:03.0: reg 10 32bit mmio: [0xdfcff800-0xdfcfffff]
[    0.197600] pci 0000:01:03.0: reg 14 io port: [0xcc00-0xcc7f]
[    0.197629] pci 0000:01:03.0: supports D2
[    0.197631] pci 0000:01:03.0: PME# supported from D2 D3hot D3cold
[    0.197685] pci 0000:01:03.0: PME# disabled
[    0.197762] pci 0000:01:0a.0: reg 10 32bit mmio: [0xdfc00000-0xdfc7ffff]
[    0.197767] pci 0000:01:0a.0: reg 14 32bit mmio: [0xd0000000-0xd7ffffff]
[    0.197784] pci 0000:01:0a.0: reg 30 32bit mmio: [0xdfce0000-0xdfceffff]
[    0.197797] pci 0000:01:0a.0: supports D1 D2
[    0.197820] pci 0000:00:04.0: transparent bridge
[    0.197871] pci 0000:00:04.0: bridge io port: [0xc000-0xcfff]
[    0.197874] pci 0000:00:04.0: bridge 32bit mmio: [0xdfc00000-0xdfcfffff]
[    0.197877] pci 0000:00:04.0: bridge 32bit mmio pref: [0xd0000000-0xd7ff=
ffff]
[    0.197911] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.197965] pci 0000:02:00.0: PME# disabled
[    0.198051] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
[    0.198107] pci 0000:02:00.2: PME# disabled
[    0.198192] pci 0000:00:09.0: bridge io port: [0xd000-0xdfff]
[    0.198194] pci 0000:00:09.0: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.198270] pci 0000:04:04.0: reg 10 64bit mmio: [0xdfe00000-0xdfefffff]
[    0.198275] pci 0000:04:04.0: reg 18 io port: [0xd800-0xd8ff]
[    0.198337] pci 0000:02:00.2: bridge io port: [0xd000-0xdfff]
[    0.198340] pci 0000:02:00.2: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.198397] pci 0000:05:00.0: reg 10 32bit mmio: [0xdffe0000-0xdfffffff]
[    0.198406] pci 0000:05:00.0: reg 14 32bit mmio: [0xdffc0000-0xdffdffff]
[    0.198414] pci 0000:05:00.0: reg 18 io port: [0xec00-0xec1f]
[    0.198441] pci 0000:05:00.0: reg 30 32bit mmio: [0xdffa0000-0xdffbffff]
[    0.198477] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.198533] pci 0000:05:00.0: PME# disabled
[    0.198628] pci 0000:00:0b.0: bridge io port: [0xe000-0xefff]
[    0.198630] pci 0000:00:0b.0: bridge 32bit mmio: [0xdff00000-0xdfffffff]
[    0.198674] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.198841] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.198955] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.199018] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR11._PRT]
[    0.200020] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR12._PRT]
[    0.208199] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *0, disab=
led.
[    0.208686] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *0, disab=
led.
[    0.209169] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *11
[    0.209619] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disab=
led.
[    0.210104] ACPI: PCI Interrupt Link [LNEA] (IRQs 16 17 18 19) *0, disab=
led.
[    0.210584] ACPI: PCI Interrupt Link [LNEB] (IRQs 16 17 18 19) *10
[    0.211040] ACPI: PCI Interrupt Link [LNEC] (IRQs 16 17 18 19) *0, disab=
led.
[    0.211517] ACPI: PCI Interrupt Link [LNED] (IRQs 16 17 18 19) *11
[    0.212392] ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *11
[    0.212843] ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *10
[    0.213298] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *11
[    0.213758] ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *11
[    0.214209] ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0, disab=
led.
[    0.214692] ACPI: PCI Interrupt Link [LMC9] (IRQs 20 21 22 23) *0, disab=
led.
[    0.215176] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *10
[    0.215632] ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *0, disab=
led.
[    0.216141] ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *15
[    0.216601] ACPI: PCI Interrupt Link [LSA1] (IRQs 20 21 22 23) *5
[    0.217091] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disab=
led.
[    0.217409] usbcore: registered new interface driver usbfs
[    0.217409] usbcore: registered new interface driver hub
[    0.217409] usbcore: registered new device driver usb
[    0.217409] PCI: Using ACPI for IRQ routing
[    0.224127] PCI-DMA: Disabling AGP.
[    0.224248] PCI-DMA: aperture base @ 20000000 size 65536 KB
[    0.224248] PCI-DMA: using GART IOMMU.
[    0.224248] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    0.224649] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.224816] hpet0: 3 comparators, 32-bit 25.000000 MHz counter
[    0.232011] Switched to high resolution mode on CPU 0
[    0.232349] Switched to high resolution mode on CPU 1
[    0.236012] pnp: PnP ACPI init
[    0.236077] ACPI: bus type pnp registered
[    0.243754] pnp: PnP ACPI: found 15 devices
[    0.243808] ACPI: ACPI bus type pnp unregistered
[    0.243868] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[    0.243922] system 00:07: ioport range 0x800-0x80f has been reserved
[    0.243976] system 00:07: ioport range 0x500-0x57f has been reserved
[    0.244044] system 00:07: ioport range 0x580-0x5ff has been reserved
[    0.244099] system 00:07: ioport range 0x800-0x87f could not be reserved
[    0.244155] system 00:07: ioport range 0x880-0x8ff has been reserved
[    0.244208] system 00:07: ioport range 0xd00-0xd7f has been reserved
[    0.244262] system 00:07: ioport range 0xd80-0xdff has been reserved
[    0.244319] system 00:07: ioport range 0x2000-0x207f has been reserved
[    0.244373] system 00:07: ioport range 0x2080-0x20ff has been reserved
[    0.244429] system 00:07: iomem range 0xfefe0000-0xfefe01ff has been res=
erved
[    0.244484] system 00:07: iomem range 0xfefe1000-0xfefe1fff has been res=
erved
[    0.244542] system 00:07: iomem range 0xfee01000-0xfeefffff has been res=
erved
[    0.244597] system 00:07: iomem range 0xffb80000-0xffffffff has been res=
erved
[    0.244655] system 00:09: iomem range 0xfec00000-0xfec00fff has been res=
erved
[    0.244711] system 00:09: iomem range 0xfee00000-0xfee00fff has been res=
erved
[    0.244770] system 00:0b: ioport range 0x230-0x23f has been reserved
[    0.244827] system 00:0b: ioport range 0x290-0x29f has been reserved
[    0.244881] system 00:0b: ioport range 0xa00-0xa0f has been reserved
[    0.244934] system 00:0b: ioport range 0xa10-0xa1f has been reserved
[    0.244990] system 00:0d: iomem range 0xe0000000-0xefffffff has been res=
erved
[    0.245053] system 00:0e: iomem range 0x0-0x9ffff could not be reserved
[    0.245111] system 00:0e: iomem range 0xc0000-0xcffff has been reserved
[    0.245166] system 00:0e: iomem range 0xe0000-0xfffff could not be reser=
ved
[    0.245221] system 00:0e: iomem range 0x100000-0xcfffffff could not be r=
eserved
[    0.245290] system 00:0e: iomem range 0xff780000-0xffffffff could not be=
 reserved
[    0.250383] pci 0000:00:04.0: PCI bridge, secondary bus 0000:01
[    0.250436] pci 0000:00:04.0:   IO window: 0xc000-0xcfff
[    0.250489] pci 0000:00:04.0:   MEM window: 0xdfc00000-0xdfcfffff
[    0.250543] pci 0000:00:04.0:   PREFETCH window: 0x000000d0000000-0x0000=
00d7ffffff
[    0.250617] pci 0000:02:00.0: PCI bridge, secondary bus 0000:03
[    0.250669] pci 0000:02:00.0:   IO window: disabled
[    0.250721] pci 0000:02:00.0:   MEM window: disabled
[    0.250772] pci 0000:02:00.0:   PREFETCH window: disabled
[    0.250827] pci 0000:02:00.2: PCI bridge, secondary bus 0000:04
[    0.250880] pci 0000:02:00.2:   IO window: 0xd000-0xdfff
[    0.250933] pci 0000:02:00.2:   MEM window: 0xdfd00000-0xdfefffff
[    0.250986] pci 0000:02:00.2:   PREFETCH window: disabled
[    0.251040] pci 0000:00:09.0: PCI bridge, secondary bus 0000:02
[    0.251093] pci 0000:00:09.0:   IO window: 0xd000-0xdfff
[    0.251145] pci 0000:00:09.0:   MEM window: 0xdfd00000-0xdfefffff
[    0.251198] pci 0000:00:09.0:   PREFETCH window: disabled
[    0.251251] pci 0000:00:0b.0: PCI bridge, secondary bus 0000:05
[    0.251304] pci 0000:00:0b.0:   IO window: 0xe000-0xefff
[    0.251356] pci 0000:00:0b.0:   MEM window: 0xdff00000-0xdfffffff
[    0.251408] pci 0000:00:0b.0:   PREFETCH window: disabled
[    0.251461] pci 0000:00:0c.0: PCI bridge, secondary bus 0000:06
[    0.251513] pci 0000:00:0c.0:   IO window: disabled
[    0.251564] pci 0000:00:0c.0:   MEM window: disabled
[    0.251617] pci 0000:00:0c.0:   PREFETCH window: disabled
[    0.251673] pci 0000:00:04.0: setting latency timer to 64
[    0.251678] pci 0000:00:09.0: setting latency timer to 64
[    0.251683] pci 0000:02:00.0: setting latency timer to 64
[    0.251688] pci 0000:02:00.2: setting latency timer to 64
[    0.251692] pci 0000:00:0b.0: setting latency timer to 64
[    0.251696] pci 0000:00:0c.0: setting latency timer to 64
[    0.251699] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.251701] pci_bus 0000:00: resource 1 mem: [0x000000-0xfffffffffffffff=
f]
[    0.251704] pci_bus 0000:01: resource 0 io:  [0xc000-0xcfff]
[    0.251706] pci_bus 0000:01: resource 1 mem: [0xdfc00000-0xdfcfffff]
[    0.251708] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xd7ffffff]
[    0.251711] pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
[    0.251713] pci_bus 0000:01: resource 4 mem: [0x000000-0xfffffffffffffff=
f]
[    0.251716] pci_bus 0000:02: resource 0 io:  [0xd000-0xdfff]
[    0.251718] pci_bus 0000:02: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.251721] pci_bus 0000:04: resource 0 io:  [0xd000-0xdfff]
[    0.251723] pci_bus 0000:04: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.251725] pci_bus 0000:05: resource 0 io:  [0xe000-0xefff]
[    0.251727] pci_bus 0000:05: resource 1 mem: [0xdff00000-0xdfffffff]
[    0.251825] NET: Registered protocol family 2
[    0.280277] IP route cache hash table entries: 262144 (order: 9, 2097152=
 bytes)
[    0.282840] TCP established hash table entries: 524288 (order: 11, 83886=
08 bytes)
[    0.288086] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.288771] TCP: Hash tables configured (established 524288 bind 65536)
[    0.288826] TCP reno registered
[    0.296125] NET: Registered protocol family 1
[    0.296231] Trying to unpack rootfs image as initramfs...
[    0.491639] Freeing initrd memory: 8817k freed
[    0.498455] audit: initializing netlink socket (disabled)
[    0.498519] type=3D2000 audit(1249327708.496:1): initialized
[    0.499073] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.499289] VFS: Disk quotas dquot_6.5.2
[    0.499377] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.499490] msgmni has been set to 11973
[    0.499737] alg: No test for stdrng (krng)
[    0.499857] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    0.499930] io scheduler noop registered
[    0.499979] io scheduler anticipatory registered
[    0.500045] io scheduler deadline registered
[    0.500124] io scheduler cfq registered (default)
[    1.024407] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.024502] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.024606] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.024709] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.024811] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.024917] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.025031] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.025145] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.025205] pci 0000:01:0a.0: Boot video device
[    1.025372]   alloc irq_desc for 24 on cpu 0 node 0
[    1.025375]   alloc kstat_irqs on cpu 0 node 0
[    1.025382] pcieport-driver 0000:00:09.0: irq 24 for MSI/MSI-X
[    1.025389] pcieport-driver 0000:00:09.0: setting latency timer to 64
[    1.025547]   alloc irq_desc for 25 on cpu 0 node 0
[    1.025549]   alloc kstat_irqs on cpu 0 node 0
[    1.025554] pcieport-driver 0000:00:0b.0: irq 25 for MSI/MSI-X
[    1.025559] pcieport-driver 0000:00:0b.0: setting latency timer to 64
[    1.025703]   alloc irq_desc for 26 on cpu 0 node 0
[    1.025705]   alloc kstat_irqs on cpu 0 node 0
[    1.025709] pcieport-driver 0000:00:0c.0: irq 26 for MSI/MSI-X
[    1.025715] pcieport-driver 0000:00:0c.0: setting latency timer to 64
[    1.029669] Linux agpgart interface v0.103
[    1.029721] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.029897] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.030384] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.032223] brd: module loaded
[    1.032351] input: Macintosh mouse button emulation as /devices/virtual/=
input/input0
[    1.032624] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.032678] PNP: PS/2 appears to have AUX port disabled, if this is inco=
rrect please boot with i8042.nopnp
[    1.032889] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.033278] mice: PS/2 mouse device common for all mice
[    1.033400] rtc_cmos 00:02: RTC can wake from S4
[    1.033513] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    1.033603] rtc0: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    1.033695] cpuidle: using governor ladder
[    1.033744] cpuidle: using governor menu
[    1.033796] No iBFT detected.
[    1.034176] TCP cubic registered
[    1.034321] NET: Registered protocol family 10
[    1.034850] lo: Disabled Privacy Extensions
[    1.035183] Mobile IPv6
[    1.035230] NET: Registered protocol family 17
[    1.035436] registered taskstats version 1
[    1.035670] rtc_cmos 00:02: setting system clock to 2009-08-03 19:28:29 =
UTC (1249327709)
[    1.035801] Freeing unused kernel memory: 560k freed
[    1.036132] Write protecting the kernel read-only data: 3772k
[    1.051170] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    1.196659] FDC 0 is a post-1991 82077
[    1.203883] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.204354] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 23
[    1.204410]   alloc irq_desc for 23 on cpu 0 node 0
[    1.204412]   alloc kstat_irqs on cpu 0 node 0
[    1.204424] ehci_hcd 0000:00:02.1: PCI INT B -> Link[LUB2] -> GSI 23 (le=
vel, low) -> IRQ 23
[    1.204528] ehci_hcd 0000:00:02.1: setting latency timer to 64
[    1.204531] ehci_hcd 0000:00:02.1: EHCI Host Controller
[    1.204675] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus =
number 1
[    1.204780] ehci_hcd 0000:00:02.1: debug port 1
[    1.204832] ehci_hcd 0000:00:02.1: cache line size of 64 is not supported
[    1.204853] ehci_hcd 0000:00:02.1: irq 23, io mem 0xdfbfec00
[    1.208509] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 19
[    1.208568]   alloc irq_desc for 19 on cpu 0 node 0
[    1.208570]   alloc kstat_irqs on cpu 0 node 0
[    1.208580] firewire_ohci 0000:01:03.0: PCI INT A -> Link[LNKC] -> GSI 1=
9 (level, low) -> IRQ 19
[    1.218902] Uniform Multi-Platform E-IDE driver
[    1.219022] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00
[    1.219097] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.219151] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.219221] usb usb1: Product: EHCI Host Controller
[    1.219271] usb usb1: Manufacturer: Linux 2.6.30-btrfsnewformat2 ehci_hcd
[    1.219324] usb usb1: SerialNumber: 0000:00:02.1
[    1.219436] usb usb1: configuration #1 chosen from 1 choice
[    1.219513] hub 1-0:1.0: USB hub found
[    1.219568] hub 1-0:1.0: 10 ports detected
[    1.220033] amd74xx 0000:00:06.0: UDMA133 controller
[    1.220088] amd74xx 0000:00:06.0: IDE controller (0x10de:0x03ec rev 0xa2)
[    1.220159] amd74xx 0000:00:06.0: IDE port disabled
[    1.220217] amd74xx 0000:00:06.0: BIOS didn't set cable bits correctly. =
Enabling workaround.
[    1.220289] amd74xx 0000:00:06.0: not 100% native mode: will probe irqs =
later
[    1.220346]     ide0: BM-DMA at 0xffa0-0xffa7
[    1.220399] Probing IDE interface ide0...
[    1.239811] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.258688] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.4-k4
[    1.258744] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    1.292061] firewire_ohci: Added fw-ohci device 0000:01:03.0, OHCI versi=
on 1.10
[    1.301786] ACPI: PCI Interrupt Link [LNEB] enabled at IRQ 18
[    1.301846]   alloc irq_desc for 18 on cpu 0 node 0
[    1.301848]   alloc kstat_irqs on cpu 0 node 0
[    1.301859] e1000e 0000:05:00.0: PCI INT A -> Link[LNEB] -> GSI 18 (leve=
l, low) -> IRQ 18
[    1.301938] e1000e 0000:05:00.0: setting latency timer to 64
[    1.302092]   alloc irq_desc for 27 on cpu 0 node 0
[    1.302094]   alloc kstat_irqs on cpu 0 node 0
[    1.302106] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[    1.483169] 0000:05:00.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:15:17:=
24:85:7a
[    1.483242] 0000:05:00.0: eth0: Intel(R) PRO/1000 Network Connection
[    1.483370] 0000:05:00.0: eth0: MAC: 1, PHY: 4, PBA No: d50855-002
[    1.484859] udev: renamed network interface eth0 to eth1
[    1.508107] hda: WDC WD1600JB-00GVA0, ATA DISK drive
[    1.788096] firewire_core: created device fw0: GUID 0011d80000f46d61, S4=
00
[    2.180053] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    2.181275] hda: UDMA/100 mode selected
[    2.182591] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.200156] forcedeth: Reverse Engineered nForce ethernet driver. Versio=
n 0.64.
[    2.200559] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 22
[    2.200614]   alloc irq_desc for 22 on cpu 0 node 0
[    2.200616]   alloc kstat_irqs on cpu 0 node 0
[    2.200625] forcedeth 0000:00:07.0: PCI INT A -> Link[LMAC] -> GSI 22 (l=
evel, low) -> IRQ 22
[    2.200698] forcedeth 0000:00:07.0: setting latency timer to 64
[    2.720845] forcedeth 0000:00:07.0: ifname eth0, PHY OUI 0x1374 @ 1, add=
r 00:18:f3:aa:18:da
[    2.720918] forcedeth 0000:00:07.0: highdma pwrctl mgmt gbit lnktim msi =
desc-v3
[    2.721739] ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 21
[    2.721797]   alloc irq_desc for 21 on cpu 0 node 0
[    2.721799]   alloc kstat_irqs on cpu 0 node 0
[    2.721809] ohci_hcd 0000:00:02.0: PCI INT A -> Link[LUB0] -> GSI 21 (le=
vel, low) -> IRQ 21
[    2.721911] ohci_hcd 0000:00:02.0: setting latency timer to 64
[    2.721914] ohci_hcd 0000:00:02.0: OHCI Host Controller
[    2.722070] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus =
number 2
[    2.722169] ohci_hcd 0000:00:02.0: irq 21, io mem 0xdfbff000
[    2.778017] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    2.778072] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.778141] usb usb2: Product: OHCI Host Controller
[    2.778191] usb usb2: Manufacturer: Linux 2.6.30-btrfsnewformat2 ohci_hcd
[    2.778245] usb usb2: SerialNumber: 0000:00:02.0
[    2.778347] usb usb2: configuration #1 chosen from 1 choice
[    2.778428] hub 2-0:1.0: USB hub found
[    2.778484] hub 2-0:1.0: 10 ports detected
[    2.791949] SCSI subsystem initialized
[    2.806180] libata version 3.00 loaded.
[    2.809201] sata_nv 0000:00:08.0: version 3.5
[    2.809534] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 20
[    2.809594]   alloc irq_desc for 20 on cpu 0 node 0
[    2.809596]   alloc kstat_irqs on cpu 0 node 0
[    2.809606] sata_nv 0000:00:08.0: PCI INT A -> Link[LSA0] -> GSI 20 (lev=
el, low) -> IRQ 20
[    2.809747] sata_nv 0000:00:08.0: setting latency timer to 64
[    2.809812] scsi0 : sata_nv
[    2.809970] scsi1 : sata_nv
[    2.810165] ata1: SATA max UDMA/133 cmd 0xb400 ctl 0xb080 bmdma 0xa880 i=
rq 20
[    2.810221] ata2: SATA max UDMA/133 cmd 0xb000 ctl 0xac00 bmdma 0xa888 i=
rq 20
[    2.810595] ACPI: PCI Interrupt Link [LSA1] enabled at IRQ 23
[    2.810649] sata_nv 0000:00:08.1: PCI INT B -> Link[LSA1] -> GSI 23 (lev=
el, low) -> IRQ 23
[    2.810759] sata_nv 0000:00:08.1: setting latency timer to 64
[    2.810808] scsi2 : sata_nv
[    2.810943] scsi3 : sata_nv
[    2.811141] ata3: SATA max UDMA/133 cmd 0xa800 ctl 0xa480 bmdma 0xa000 i=
rq 23
[    2.811196] ata4: SATA max UDMA/133 cmd 0xa400 ctl 0xa080 bmdma 0xa008 i=
rq 23
[    2.910771] ide-gd driver 1.18
[    2.910860] hda: max request size: 512KiB
[    2.912229] hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=3D19=
457/255/63
[    2.914312] hda: cache flushes supported
[    2.914419]  hda: hda1 hda2 hda3
[    3.284031] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.293458] ata1.00: ATA-6: WDC WD1600JD-00GBB0, 02.05D02, max UDMA/100
[    3.293516] ata1.00: 312581808 sectors, multi 16: LBA48=20
[    3.293576] ata1.00: applying bridge limits
[    3.309473] ata1.00: configured for UDMA/100
[    3.309617] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JD-00G 02=
=2E0 PQ: 0 ANSI: 5
[    3.776029] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.784112] ata2.00: ATAPI: TSSTcorp CDDVDW SH-S223F, SB03, max UDMA/100
[    3.800126] ata2.00: configured for UDMA/100
[    3.801554] scsi 1:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S223F  SB=
03 PQ: 0 ANSI: 5
[    4.133511] Driver 'sd' needs updating - please use bus_type methods
[    4.133701] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 =
GB/149 GiB)
[    4.133786] sd 0:0:0:0: [sda] Write Protect is off
[    4.133837] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.133855] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    4.134013]  sda: sda1 sda2 sda3
[    4.186285] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.188634] Driver 'sr' needs updating - please use bus_type methods
[    4.192142] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    4.192218] Uniform CD-ROM driver Revision: 3.20
[    4.192368] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    4.198397] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.198480] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    4.555496] md: raid1 personality registered for level 1
[    4.557503] xor: automatically using best checksumming function: generic=
_sse
[    4.577006]    generic_sse:  7436.000 MB/sec
[    4.577056] xor: using function: generic_sse (7436.000 MB/sec)
[    4.577890] async_tx: api initialized (async)
[    4.645034] raid6: int64x1   2251 MB/s
[    4.713017] raid6: int64x2   2856 MB/s
[    4.781012] raid6: int64x4   2204 MB/s
[    4.849031] raid6: int64x8   2016 MB/s
[    4.917047] raid6: sse2x1    1137 MB/s
[    4.985014] raid6: sse2x2    1923 MB/s
[    5.053018] raid6: sse2x4    2974 MB/s
[    5.053066] raid6: using algorithm sse2x4 (2974 MB/s)
[    5.055977] md: raid6 personality registered for level 6
[    5.056049] md: raid5 personality registered for level 5
[    5.056100] md: raid4 personality registered for level 4
[    5.169710] md: md0 stopped.
[    5.219350] md: bind<hda1>
[    5.219570] md: bind<sda1>
[    5.220821] raid1: raid set md0 active with 2 out of 2 mirrors
[    5.225630]  md0: unknown partition table
[    5.307966] md: md1 stopped.
[    5.309721] md: bind<hda2>
[    5.309932] md: bind<sda2>
[    5.311210] raid1: raid set md1 active with 2 out of 2 mirrors
[    5.312359]  md1: unknown partition table
[    5.347243] device-mapper: uevent: version 1.0.3
[    5.347920] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised:=
 dm-devel@redhat.com
[    5.457859] PM: Starting manual resume from disk
[    5.512743] kjournald starting.  Commit interval 5 seconds
[    5.512804] EXT3-fs: mounted filesystem with ordered data mode.
[    6.802146] udev: starting version 141
[    7.086766] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    7.091888] ACPI: Power Button [PWRF]
[    7.092024] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
C:00/input/input3
[    7.092184] ACPI: Power Button [PWRB]
[    7.146485] processor ACPI_CPU:00: registered as cooling_device0
[    7.146749] processor ACPI_CPU:01: registered as cooling_device1
[    7.150106] parport_pc 00:06: reported by Plug and Play ACPI
[    7.150207] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    7.157637] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    7.169413] k8temp 0000:00:18.3: Temperature readouts might be wrong - c=
heck erratum #141
[    7.229116] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    7.266115] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x600
[    7.266189] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x700
[    7.345762] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    7.485611] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 22
[    7.485669] HDA Intel 0000:00:05.0: PCI INT B -> Link[LAZA] -> GSI 22 (l=
evel, low) -> IRQ 22
[    7.485906] HDA Intel 0000:00:05.0: setting latency timer to 64
[    7.573557] Error: Driver 'pcspkr' is already registered, aborting...
[    8.240212] hda_codec: Unknown model for AD1988, trying auto-probe from =
BIOS...
[    8.240381] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:05.=
0/input/input5
[   11.119701] Adding 3943948k swap on /dev/sda3.  Priority:-1 extents:1 ac=
ross:3943948k=20
[   11.142212] Adding 3943948k swap on /dev/hda3.  Priority:-2 extents:1 ac=
ross:3943948k=20
[   11.425739] EXT3 FS on dm-0, internal journal
[   11.562496] loop: module loaded
[   12.598464] kjournald starting.  Commit interval 5 seconds
[   12.604732] EXT3 FS on md0, internal journal
[   12.604813] EXT3-fs: mounted filesystem with ordered data mode.
[   12.746590] EXT4-fs: barriers enabled
[   12.756503] kjournald2 starting: pid 2346, dev dm-3:8, commit interval 5=
 seconds
[   12.792346] EXT4 FS on dm-3, internal journal on dm-3:8
[   12.792397] EXT4-fs: delayed allocation enabled
[   12.792446] EXT4-fs: file extents enabled
[   12.793790] EXT4-fs: mballoc enabled
[   12.793852] EXT4-fs: mounted filesystem dm-3 with ordered data mode
[   14.154355] Bridge firewalling registered
[   14.171840] device eth1 entered promiscuous mode
[   14.316403] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[   14.372077] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[   14.373804] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   17.584375] Loading iSCSI transport class v2.0-870.
[   17.615761] iscsi: registered transport (tcp)
[   17.682396] iscsi: registered transport (iser)
[   18.164670] RPC: Registered udp transport module.
[   18.164738] RPC: Registered tcp transport module.
[   18.218735] Slow work thread pool: Starting up
[   18.219138] Slow work thread pool: Ready
[   18.219236] FS-Cache: Loaded
[   18.255072] FS-Cache: Netfs 'nfs' registered for caching
[   18.284829] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   24.488011] br0: no IPv6 routers present
[   27.149010] torbr: no IPv6 routers present
[   81.434840] virbr1: starting userspace STP failed, starting kernel STP
[   81.472513] svc: failed to register lockdv1 RPC service (errno 97).
[   81.473363] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recov=
ery directory
[   81.488227] NFSD: starting 90-second grace period
[   81.570257] ip_tables: (C) 2000-2006 Netfilter Core Team
[   83.783962] tun: Universal TUN/TAP device driver, 1.6
[   83.784021] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   83.786806] device vnet0 entered promiscuous mode
[   83.788268] br0: port 2(vnet0) entering learning state
[   83.887654] br0: port 2(vnet0) entering disabled state
[   83.902340] device vnet0 left promiscuous mode
[   83.902394] br0: port 2(vnet0) entering disabled state
[   84.104444] lo: Disabled Privacy Extensions
[   92.228010] virbr1: no IPv6 routers present
[   99.565802] sata_mv 0000:04:04.0: version 1.28
[   99.566298] ACPI: PCI Interrupt Link [LNED] enabled at IRQ 17
[   99.566353]   alloc irq_desc for 17 on cpu 0 node 0
[   99.566355]   alloc kstat_irqs on cpu 0 node 0
[   99.566365] sata_mv 0000:04:04.0: PCI INT A -> Link[LNED] -> GSI 17 (lev=
el, low) -> IRQ 17
[   99.566667] sata_mv 0000:04:04.0: Gen-II 32 slots 8 ports SCSI mode IRQ =
via INTx
[   99.567664] scsi4 : sata_mv
[   99.567804] scsi5 : sata_mv
[   99.567910] scsi6 : sata_mv
[   99.569475] scsi7 : sata_mv
[   99.569775] scsi8 : sata_mv
[   99.570029] scsi9 : sata_mv
[   99.570282] scsi10 : sata_mv
[   99.570528] scsi11 : sata_mv
[   99.570626] ata5: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
2000 irq 17
[   99.570697] ata6: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
4000 irq 17
[   99.570767] ata7: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
6000 irq 17
[   99.570838] ata8: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
8000 irq 17
[   99.570908] ata9: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe3=
2000 irq 17
[   99.570979] ata10: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
34000 irq 17
[   99.571049] ata11: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
36000 irq 17
[   99.571121] ata12: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
38000 irq 17
[  100.044032] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  100.076049] ata5.00: ATA-8: WDC WD5000AAKS-00A7B0, 01.03B01, max UDMA/133
[  100.076104] ata5.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  100.092063] ata5.00: configured for UDMA/133
[  100.092195] scsi 4:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 01=
=2E0 PQ: 0 ANSI: 5
[  100.092406] sd 4:0:0:0: Attached scsi generic sg2 type 0
[  100.092536] sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  100.092617] sd 4:0:0:0: [sdb] Write Protect is off
[  100.092670] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  100.092690] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  100.092855]  sdb:<6>ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  100.608048] ata6.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  100.608104] ata6.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  100.640076] ata6.00: configured for UDMA/133
[  100.640207] scsi 5:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  100.640436] sd 5:0:0:0: Attached scsi generic sg3 type 0
[  100.640457] sd 5:0:0:0: [sdc] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  100.640472] sd 5:0:0:0: [sdc] Write Protect is off
[  100.640474] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  100.640494] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  100.640639]  sdc:<6>ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  101.160047] ata7.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  101.160102] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  101.192062] ata7.00: configured for UDMA/133
[  101.192202] scsi 6:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  101.192406] sd 6:0:0:0: Attached scsi generic sg4 type 0
[  101.192533] sd 6:0:0:0: [sdd] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  101.192614] sd 6:0:0:0: [sdd] Write Protect is off
[  101.192667] sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[  101.192686] sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  101.192847]  sdd:<6>ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  101.716049] ata8.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  101.716105] ata8.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  101.748062] ata8.00: configured for UDMA/133
[  101.748216] scsi 7:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  101.748424] sd 7:0:0:0: Attached scsi generic sg5 type 0
[  101.748553] sd 7:0:0:0: [sde] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  101.748634] sd 7:0:0:0: [sde] Write Protect is off
[  101.748685] sd 7:0:0:0: [sde] Mode Sense: 00 3a 00 00
[  101.748703] sd 7:0:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  101.748864]  sde:<6>ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  102.240056] ata9.00: ATA-7: WDC WD5000AAKS-65TMA0, 12.01C01, max UDMA/133
[  102.240113] ata9.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  102.264068] ata9.00: configured for UDMA/133
[  102.264204] scsi 8:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-6 12=
=2E0 PQ: 0 ANSI: 5
[  102.264417] sd 8:0:0:0: Attached scsi generic sg6 type 0
[  102.264483] sd 8:0:0:0: [sdf] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  102.264569] sd 8:0:0:0: [sdf] Write Protect is off
[  102.264621] sd 8:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[  102.264640] sd 8:0:0:0: [sdf] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  102.264808]  sdf:<6>ata10: SATA link down (SStatus 0 SControl 300)
[  102.904029] ata11: SATA link down (SStatus 0 SControl 300)
[  103.224028] ata12: SATA link down (SStatus 0 SControl 300)
[  130.831002] ata5.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  130.831051] ata5.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  130.831052]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  130.831136] ata5.00: status: { DRDY }
[  130.831173] ata5: hard resetting link
[  130.846621] ata6.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  130.846665] ata6.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  130.846666]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  130.846749] ata6.00: status: { DRDY }
[  130.846784] ata6: hard resetting link
[  131.312030] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  131.320363] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  131.352101] ata5.00: configured for UDMA/133
[  131.352142] ata5: EH complete
[  131.384062] ata6.00: configured for UDMA/133
[  131.384102] ata6: EH complete
[  131.845963] ata7.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  131.845976] ata8.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  131.845985] ata8.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  131.845986]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  131.845988] ata8.00: status: { DRDY }
[  131.845993] ata8: hard resetting link
[  131.846199] ata7.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  131.846201]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  131.846284] ata7.00: status: { DRDY }
[  131.846320] ata7: hard resetting link
[  132.320034] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  132.324031] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  132.392064] ata8.00: configured for UDMA/133
[  132.392112] ata8: EH complete
[  132.396063] ata7.00: configured for UDMA/133
[  132.396104] ata7: EH complete
[  132.830995] ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  132.831041] ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  132.831042]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  132.831167] ata9.00: status: { DRDY }
[  132.831217] ata9: hard resetting link
[  133.304030] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  133.344066] ata9.00: configured for UDMA/133
[  133.344106] ata9: EH complete
[  161.831033] ata5.00: NCQ disabled due to excessive errors
[  161.831104] ata5.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  161.831164] ata5.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  161.831165]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  161.831302] ata5.00: status: { DRDY }
[  161.831353] ata5: hard resetting link
[  161.846816] ata6.00: NCQ disabled due to excessive errors
[  161.846868] ata6.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  161.846926] ata6.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  161.846927]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  161.847066] ata6.00: status: { DRDY }
[  161.847116] ata6: hard resetting link
[  162.316029] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  162.320045] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  162.356062] ata5.00: configured for UDMA/133
[  162.356124] ata5: EH complete
[  162.396061] ata6.00: configured for UDMA/133
[  162.396115] ata6: EH complete
[  162.833968] ata8.00: NCQ disabled due to excessive errors
[  162.833972] ata7.00: NCQ disabled due to excessive errors
[  162.833976] ata7.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  162.833982] ata7.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  162.833983]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  162.833985] ata7.00: status: { DRDY }
[  162.833988] ata7: hard resetting link
[  162.834361] ata8.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  162.834424] ata8.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  162.834426]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  162.834564] ata8.00: status: { DRDY }
[  162.834616] ata8: hard resetting link
[  163.308030] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  163.312032] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  163.380065] ata8.00: configured for UDMA/133
[  163.380125] ata8: EH complete
[  163.384064] ata7.00: configured for UDMA/133
[  163.384116] ata7: EH complete
[  163.830991] ata9.00: NCQ disabled due to excessive errors
[  163.831044] ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  163.831103] ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  163.831104]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  163.831240] ata9.00: status: { DRDY }
[  163.831290] ata9: hard resetting link
[  164.304027] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  164.344066] ata9.00: configured for UDMA/133
[  164.344119] ata9: EH complete

--m1UC1K4AOz1Ywdkx--

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFKd0kr1zX4pjkhuygRAi1LAJ463usEe2cqYhSjZ6o310sLYfIzgwCgjcPJ
UbIZ1+RuqGnPRHVSMLTyEt8=
=Zb7Y
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--
