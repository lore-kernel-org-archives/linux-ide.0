From: =?iso-8859-1?B?RGF27fA=?= Steinn Geirsson <david@dsg.to>
Subject: Re: HighPoint RocketRAID 2320
Date: Wed, 5 Aug 2009 21:01:54 +0000
Message-ID: <20090805210154.GJ13863@dsg.to>
References: <20090803201836.GD13863@dsg.to> <20090803203139.GE13863@dsg.to> <4A7821AF.9010609@kernel.org> <20090804174852.GH13863@dsg.to> <4A78FE5A.1080203@rtr.ca> <4A790008.3020601@rtr.ca> <4A790352.6080804@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WOTjKnJ88wpJKlWH"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gozer.dsg.to ([79.171.98.146]:38525 "EHLO gozer.dsg.to"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbZHEVB6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Aug 2009 17:01:58 -0400
Content-Disposition: inline
In-Reply-To: <4A790352.6080804@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org


--WOTjKnJ88wpJKlWH
Content-Type: multipart/mixed; boundary="4ickEXl+ukcSQ/3E"
Content-Disposition: inline


--4ickEXl+ukcSQ/3E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi guys,

On Wed, Aug 05, 2009 at 12:58:10PM +0900, Tejun Heo wrote:
> Mark Lord wrote:
> > Mark Lord wrote:
> >> Dav=ED=F0 Steinn Geirsson wrote:
> >>> Hi Tejun,
> >>>
> >>> I tried this and attach a dmesg output. The result was the same.
> >> ..
> >> Mmm... interrupts are not getting through the bridge chip.
> > ..
> >=20
> > This is just a blind shot in the dark, but easy enough to try:
> >=20
> > How about booting with pci=3Dnomsi on the kernel command line ?
>=20
> And if that fails irqpoll.  :-)

Neither of those options seems to have an effect. I did however
make some progress fiddling further with kernel options:

If I disable the APIC (noapic), I am able to read (correct) data off
the disks, albeit very slowly due to repeated DMA and NCQ errors (took abou=
t 4
minutes to transfer 88KB).

If I further disable DMA and NCQ (libata.dma=3D0 and libata.force=3Dnoncq),
I get no errors in my logs and can transfer data at a reasonable rate
considering it's PIO.

So, at least we're moving somewhere, though I really don't understand
how the APIC would be handling the interrupts any differently than the
standard PIC.

I'm attaching the dmesg output from these tries (pci=3Dnomsi and irqpoll
which did not work, and with noapic with and without DMA).

>=20
> --=20
> tejun

Kind regards and thanks for all your help,

--=20
Dav=ED=F0 Steinn Geirsson
david@dsg.to

--4ickEXl+ukcSQ/3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sata_mv-dmesg.noapic.noncq.nodma-working.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-btrfsnewformat2 (2.6.30) (root@slimer) =
(gcc version 4.3.3 (Debian 4.3.3-15) ) #3 SMP Mon Aug 3 18:09:53 GMT 2009
[    0.000000] Command line: root=3D/dev/mapper/slimerroot-root ro noapic l=
ibata.force=3Dnoncq libata.dma=3D0
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
[    0.000000] ACPI: Skipping IOAPIC probe due to 'noapic' option.
[    0.000000] Using ACPI for processor (LAPIC) configuration information
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000] MPTABLE: OEM ID: TEMPLATE
[    0.000000] MPTABLE: Product ID: 1394       =20
[    0.000000] MPTABLE: APIC at: 0xFEE00000
[    0.000000] I/O APIC #2 Version 17 at 0xFEC00000.
[    0.000000] Processors: 2
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
[    0.000000] Kernel command line: root=3D/dev/mapper/slimerroot-root ro n=
oapic libata.force=3Dnoncq libata.dma=3D0
[    0.000000] Unknown boot option `libata.force=3Dnoncq': ignoring
[    0.000000] Unknown boot option `libata.dma=3D0': ignoring
[    0.000000] Initializing CPU#0
[    0.000000] Experimental hierarchical RCU implementation.
[    0.000000] Experimental hierarchical RCU init done.
[    0.000000] NR_IRQS:4352 nr_irqs:424
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2410.960 MHz processor.
[    0.004000] spurious 8259A interrupt: IRQ7.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Checking aperture...
[    0.004000] No AGP bridge found
[    0.004000] Node 0: aperture @ d730000000 size 32 MB
[    0.004000] Aperture beyond 4GB. Ignoring.
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
er frequency.. 4821.92 BogoMIPS (lpj=3D9643840)
[    0.004000] Security Framework initialized
[    0.004000] SELinux:  Disabled at boot.
[    0.004000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.006481] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.009167] Mount-cache hash table entries: 256
[    0.009385] Initializing cgroup subsys ns
[    0.009435] Initializing cgroup subsys cpuacct
[    0.009487] Initializing cgroup subsys devices
[    0.009536] Initializing cgroup subsys freezer
[    0.009588] Initializing cgroup subsys net_cls
[    0.009668] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.009722] CPU: L2 Cache: 512K (64 bytes/line)
[    0.009775] CPU 0/0x0 -> Node 0
[    0.009822] tseg: 0000000000
[    0.009833] CPU: Physical Processor ID: 0
[    0.009882] CPU: Processor Core ID: 0
[    0.009940] using C1E aware idle routine
[    0.010603] ACPI: Core revision 20090320
[    0.017074] ACPI: setting ELCR to 0200 (from 8c20)
[    0.017503] Setting APIC routing to flat
[    0.017556] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.020000] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 4821.84 Bog=
oMIPS (lpj=3D9643690)
[    0.004000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.004000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.004000] CPU 1/0x1 -> Node 0
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x701060007=
0106
[    0.104395] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.104922] Brought up 2 CPUs
[    0.104970] Total of 2 processors activated (9643.76 BogoMIPS).
[    0.105047] CPU0 attaching sched-domain:
[    0.105050]  domain 0: span 0-1 level MC
[    0.105052]   groups: 0 1
[    0.105056] CPU1 attaching sched-domain:
[    0.105058]  domain 0: span 0-1 level MC
[    0.105060]   groups: 1 0
[    0.105116] net_namespace: 1936 bytes
[    0.105116] Booting paravirtualized kernel on bare hardware
[    0.105116] regulator: core version 0.5
[    0.105116] NET: Registered protocol family 16
[    0.105116] node 0 link 0: io port [1000, ffffff]
[    0.105116] TOM: 00000000d0000000 aka 3328M
[    0.105116] node 0 link 0: mmio [e0000000, efffffff]
[    0.105116] node 0 link 0: mmio [a0000, bffff]
[    0.105116] node 0 link 0: mmio [d0000000, fe0bffff]
[    0.105116] TOM2: 00000001b0000000 aka 6912M
[    0.105116] bus: [00,ff] on node 0 link 0
[    0.105116] bus: 00 index 0 io port: [0, ffff]
[    0.105116] bus: 00 index 1 mmio: [d0000000, ffffffff]
[    0.105116] bus: 00 index 2 mmio: [a0000, bffff]
[    0.105116] bus: 00 index 3 mmio: [1b0000000, fcffffffff]
[    0.105116] ACPI: bus type pci registered
[    0.105116] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.105116] PCI: Not using MMCONFIG.
[    0.105116] PCI: Using configuration type 1 for base access
[    0.108052] bio: create slab <bio-0> at 0
[    0.108594] ACPI: EC: Look up EC in DSDT
[    0.119161] ACPI: Interpreter enabled
[    0.120003] ACPI: (supports S0 S1 S3 S4 S5)
[    0.120206] ACPI: Using PIC for interrupt routing
[    0.120310] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.127049] PCI: MCFG area at e0000000 reserved in ACPI motherboard reso=
urces
[    0.137416] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.148114] ACPI Warning (tbutils-0246): Incorrect checksum in table [OE=
MB] - E5, should be D8 [20090320]
[    0.148309] ACPI: No dock devices found.
[    0.148425] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.148511] pci 0000:00:01.1: reg 10 io port: [0xbc00-0xbc3f]
[    0.148511] pci 0000:00:01.1: reg 20 io port: [0x600-0x63f]
[    0.148511] pci 0000:00:01.1: reg 24 io port: [0x700-0x73f]
[    0.148511] pci 0000:00:01.1: PME# supported from D3hot D3cold
[    0.148511] pci 0000:00:01.1: PME# disabled
[    0.148511] pci 0000:00:02.0: reg 10 32bit mmio: [0xdfbff000-0xdfbfffff]
[    0.148511] pci 0000:00:02.0: supports D1 D2
[    0.148511] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.148511] pci 0000:00:02.0: PME# disabled
[    0.148511] pci 0000:00:02.1: reg 10 32bit mmio: [0xdfbfec00-0xdfbfecff]
[    0.148532] pci 0000:00:02.1: supports D1 D2
[    0.148533] pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.148588] pci 0000:00:02.1: PME# disabled
[    0.148691] pci 0000:00:05.0: reg 10 32bit mmio: [0xdfbf8000-0xdfbfbfff]
[    0.148715] pci 0000:00:05.0: PME# supported from D3hot D3cold
[    0.148768] pci 0000:00:05.0: PME# disabled
[    0.148848] pci 0000:00:06.0: reg 20 io port: [0xffa0-0xffaf]
[    0.148881] pci 0000:00:07.0: reg 10 32bit mmio: [0xdfbfd000-0xdfbfdfff]
[    0.148885] pci 0000:00:07.0: reg 14 io port: [0xb480-0xb487]
[    0.148904] pci 0000:00:07.0: supports D1 D2
[    0.148906] pci 0000:00:07.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.148962] pci 0000:00:07.0: PME# disabled
[    0.149030] pci 0000:00:08.0: reg 10 io port: [0xb400-0xb407]
[    0.149034] pci 0000:00:08.0: reg 14 io port: [0xb080-0xb083]
[    0.149037] pci 0000:00:08.0: reg 18 io port: [0xb000-0xb007]
[    0.149040] pci 0000:00:08.0: reg 1c io port: [0xac00-0xac03]
[    0.149043] pci 0000:00:08.0: reg 20 io port: [0xa880-0xa88f]
[    0.149047] pci 0000:00:08.0: reg 24 32bit mmio: [0xdfbfc000-0xdfbfcfff]
[    0.149074] pci 0000:00:08.1: reg 10 io port: [0xa800-0xa807]
[    0.149078] pci 0000:00:08.1: reg 14 io port: [0xa480-0xa483]
[    0.149081] pci 0000:00:08.1: reg 18 io port: [0xa400-0xa407]
[    0.149085] pci 0000:00:08.1: reg 1c io port: [0xa080-0xa083]
[    0.149088] pci 0000:00:08.1: reg 20 io port: [0xa000-0xa00f]
[    0.149092] pci 0000:00:08.1: reg 24 32bit mmio: [0xdfbf3000-0xdfbf3fff]
[    0.149133] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.149188] pci 0000:00:09.0: PME# disabled
[    0.149262] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.149317] pci 0000:00:0b.0: PME# disabled
[    0.149391] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.149445] pci 0000:00:0c.0: PME# disabled
[    0.149588] pci 0000:01:03.0: reg 10 32bit mmio: [0xdfcff800-0xdfcfffff]
[    0.149593] pci 0000:01:03.0: reg 14 io port: [0xcc00-0xcc7f]
[    0.149621] pci 0000:01:03.0: supports D2
[    0.149623] pci 0000:01:03.0: PME# supported from D2 D3hot D3cold
[    0.149678] pci 0000:01:03.0: PME# disabled
[    0.149755] pci 0000:01:0a.0: reg 10 32bit mmio: [0xdfc00000-0xdfc7ffff]
[    0.149760] pci 0000:01:0a.0: reg 14 32bit mmio: [0xd0000000-0xd7ffffff]
[    0.149777] pci 0000:01:0a.0: reg 30 32bit mmio: [0xdfce0000-0xdfceffff]
[    0.149790] pci 0000:01:0a.0: supports D1 D2
[    0.149812] pci 0000:00:04.0: transparent bridge
[    0.149866] pci 0000:00:04.0: bridge io port: [0xc000-0xcfff]
[    0.149869] pci 0000:00:04.0: bridge 32bit mmio: [0xdfc00000-0xdfcfffff]
[    0.149872] pci 0000:00:04.0: bridge 32bit mmio pref: [0xd0000000-0xd7ff=
ffff]
[    0.149906] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.149963] pci 0000:02:00.0: PME# disabled
[    0.150049] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
[    0.150103] pci 0000:02:00.2: PME# disabled
[    0.150189] pci 0000:00:09.0: bridge io port: [0xd000-0xdfff]
[    0.150192] pci 0000:00:09.0: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.150267] pci 0000:04:04.0: reg 10 64bit mmio: [0xdfe00000-0xdfefffff]
[    0.150272] pci 0000:04:04.0: reg 18 io port: [0xd800-0xd8ff]
[    0.150334] pci 0000:02:00.2: bridge io port: [0xd000-0xdfff]
[    0.150337] pci 0000:02:00.2: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.150393] pci 0000:05:00.0: reg 10 32bit mmio: [0xdffe0000-0xdfffffff]
[    0.150402] pci 0000:05:00.0: reg 14 32bit mmio: [0xdffc0000-0xdffdffff]
[    0.150411] pci 0000:05:00.0: reg 18 io port: [0xec00-0xec1f]
[    0.150439] pci 0000:05:00.0: reg 30 32bit mmio: [0xdffa0000-0xdffbffff]
[    0.150475] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.150534] pci 0000:05:00.0: PME# disabled
[    0.150629] pci 0000:00:0b.0: bridge io port: [0xe000-0xefff]
[    0.150631] pci 0000:00:0b.0: bridge 32bit mmio: [0xdff00000-0xdfffffff]
[    0.150675] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.150842] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.150956] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.151019] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR11._PRT]
[    0.151082] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR12._PRT]
[    0.160159] ACPI: PCI Interrupt Link [LNKA] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.160605] ACPI: PCI Interrupt Link [LNKB] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.161051] ACPI: PCI Interrupt Link [LNKC] (IRQs 7 10 *11 14)
[    0.161443] ACPI: PCI Interrupt Link [LNKD] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.161890] ACPI: PCI Interrupt Link [LNEA] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.162336] ACPI: PCI Interrupt Link [LNEB] (IRQs 7 *10 11 14)
[    0.162726] ACPI: PCI Interrupt Link [LNEC] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.163174] ACPI: PCI Interrupt Link [LNED] (IRQs 7 10 *11 14)
[    0.163567] ACPI: PCI Interrupt Link [LUB0] (IRQs 7 10 *11 14)
[    0.164095] ACPI: PCI Interrupt Link [LUB2] (IRQs 7 *10 11 14)
[    0.164488] ACPI: PCI Interrupt Link [LMAC] (IRQs 7 10 *11 14)
[    0.164881] ACPI: PCI Interrupt Link [LAZA] (IRQs 7 10 *11 14)
[    0.165271] ACPI: PCI Interrupt Link [LACI] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.165719] ACPI: PCI Interrupt Link [LMC9] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.166170] ACPI: PCI Interrupt Link [LSMB] (IRQs 7 *10 11 14)
[    0.166564] ACPI: PCI Interrupt Link [LPMU] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.167017] ACPI: PCI Interrupt Link [LSA0] (IRQs *15)
[    0.167328] ACPI: PCI Interrupt Link [LSA1] (IRQs *5)
[    0.167675] ACPI: PCI Interrupt Link [LATA] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.168034] usbcore: registered new interface driver usbfs
[    0.168067] usbcore: registered new interface driver hub
[    0.168067] usbcore: registered new device driver usb
[    0.168067] PCI: Using ACPI for IRQ routing
[    0.176133] PCI-DMA: Disabling AGP.
[    0.176257] PCI-DMA: aperture base @ 20000000 size 65536 KB
[    0.176257] PCI-DMA: using GART IOMMU.
[    0.176257] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    0.176653] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.176815] hpet0: 3 comparators, 32-bit 25.000000 MHz counter
[    0.184011] Switched to high resolution mode on CPU 0
[    0.184349] Switched to high resolution mode on CPU 1
[    0.188012] pnp: PnP ACPI init
[    0.188076] ACPI: bus type pnp registered
[    0.195946] pnp: PnP ACPI: found 15 devices
[    0.195997] ACPI: ACPI bus type pnp unregistered
[    0.196071] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[    0.196125] system 00:07: ioport range 0x800-0x80f has been reserved
[    0.196180] system 00:07: ioport range 0x500-0x57f has been reserved
[    0.196234] system 00:07: ioport range 0x580-0x5ff has been reserved
[    0.196288] system 00:07: ioport range 0x800-0x87f could not be reserved
[    0.196342] system 00:07: ioport range 0x880-0x8ff has been reserved
[    0.196400] system 00:07: ioport range 0xd00-0xd7f has been reserved
[    0.196454] system 00:07: ioport range 0xd80-0xdff has been reserved
[    0.196508] system 00:07: ioport range 0x2000-0x207f has been reserved
[    0.196562] system 00:07: ioport range 0x2080-0x20ff has been reserved
[    0.196618] system 00:07: iomem range 0xfefe0000-0xfefe01ff has been res=
erved
[    0.196673] system 00:07: iomem range 0xfefe1000-0xfefe1fff has been res=
erved
[    0.196729] system 00:07: iomem range 0xfee01000-0xfeefffff has been res=
erved
[    0.196784] system 00:07: iomem range 0xffb80000-0xffffffff has been res=
erved
[    0.196845] system 00:09: iomem range 0xfec00000-0xfec00fff has been res=
erved
[    0.196900] system 00:09: iomem range 0xfee00000-0xfee00fff has been res=
erved
[    0.196959] system 00:0b: ioport range 0x230-0x23f has been reserved
[    0.197018] system 00:0b: ioport range 0x290-0x29f has been reserved
[    0.197072] system 00:0b: ioport range 0xa00-0xa0f has been reserved
[    0.197130] system 00:0b: ioport range 0xa10-0xa1f has been reserved
[    0.197185] system 00:0d: iomem range 0xe0000000-0xefffffff has been res=
erved
[    0.197243] system 00:0e: iomem range 0x0-0x9ffff could not be reserved
[    0.197297] system 00:0e: iomem range 0xc0000-0xcffff has been reserved
[    0.197353] system 00:0e: iomem range 0xe0000-0xfffff could not be reser=
ved
[    0.197408] system 00:0e: iomem range 0x100000-0xcfffffff could not be r=
eserved
[    0.197480] system 00:0e: iomem range 0xff780000-0xffffffff could not be=
 reserved
[    0.202565] pci 0000:00:04.0: PCI bridge, secondary bus 0000:01
[    0.202619] pci 0000:00:04.0:   IO window: 0xc000-0xcfff
[    0.202672] pci 0000:00:04.0:   MEM window: 0xdfc00000-0xdfcfffff
[    0.202725] pci 0000:00:04.0:   PREFETCH window: 0x000000d0000000-0x0000=
00d7ffffff
[    0.202797] pci 0000:02:00.0: PCI bridge, secondary bus 0000:03
[    0.202849] pci 0000:02:00.0:   IO window: disabled
[    0.202900] pci 0000:02:00.0:   MEM window: disabled
[    0.202951] pci 0000:02:00.0:   PREFETCH window: disabled
[    0.203005] pci 0000:02:00.2: PCI bridge, secondary bus 0000:04
[    0.203058] pci 0000:02:00.2:   IO window: 0xd000-0xdfff
[    0.203111] pci 0000:02:00.2:   MEM window: 0xdfd00000-0xdfefffff
[    0.203164] pci 0000:02:00.2:   PREFETCH window: disabled
[    0.203217] pci 0000:00:09.0: PCI bridge, secondary bus 0000:02
[    0.203270] pci 0000:00:09.0:   IO window: 0xd000-0xdfff
[    0.203322] pci 0000:00:09.0:   MEM window: 0xdfd00000-0xdfefffff
[    0.203375] pci 0000:00:09.0:   PREFETCH window: disabled
[    0.203427] pci 0000:00:0b.0: PCI bridge, secondary bus 0000:05
[    0.203480] pci 0000:00:0b.0:   IO window: 0xe000-0xefff
[    0.203532] pci 0000:00:0b.0:   MEM window: 0xdff00000-0xdfffffff
[    0.203584] pci 0000:00:0b.0:   PREFETCH window: disabled
[    0.203637] pci 0000:00:0c.0: PCI bridge, secondary bus 0000:06
[    0.203689] pci 0000:00:0c.0:   IO window: disabled
[    0.203739] pci 0000:00:0c.0:   MEM window: disabled
[    0.203793] pci 0000:00:0c.0:   PREFETCH window: disabled
[    0.203850] pci 0000:00:04.0: setting latency timer to 64
[    0.203854] pci 0000:00:09.0: setting latency timer to 64
[    0.203859] pci 0000:02:00.0: setting latency timer to 64
[    0.203864] pci 0000:02:00.2: setting latency timer to 64
[    0.203868] pci 0000:00:0b.0: setting latency timer to 64
[    0.203872] pci 0000:00:0c.0: setting latency timer to 64
[    0.203876] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.203878] pci_bus 0000:00: resource 1 mem: [0x000000-0xfffffffffffffff=
f]
[    0.203880] pci_bus 0000:01: resource 0 io:  [0xc000-0xcfff]
[    0.203883] pci_bus 0000:01: resource 1 mem: [0xdfc00000-0xdfcfffff]
[    0.203885] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xd7ffffff]
[    0.203887] pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
[    0.203889] pci_bus 0000:01: resource 4 mem: [0x000000-0xfffffffffffffff=
f]
[    0.203892] pci_bus 0000:02: resource 0 io:  [0xd000-0xdfff]
[    0.203894] pci_bus 0000:02: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.203897] pci_bus 0000:04: resource 0 io:  [0xd000-0xdfff]
[    0.203899] pci_bus 0000:04: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.203902] pci_bus 0000:05: resource 0 io:  [0xe000-0xefff]
[    0.203904] pci_bus 0000:05: resource 1 mem: [0xdff00000-0xdfffffff]
[    0.204016] NET: Registered protocol family 2
[    0.240273] IP route cache hash table entries: 262144 (order: 9, 2097152=
 bytes)
[    0.242829] TCP established hash table entries: 524288 (order: 11, 83886=
08 bytes)
[    0.248073] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.248760] TCP: Hash tables configured (established 524288 bind 65536)
[    0.248816] TCP reno registered
[    0.256127] NET: Registered protocol family 1
[    0.256233] Trying to unpack rootfs image as initramfs...
[    0.451577] Freeing initrd memory: 8817k freed
[    0.458342] audit: initializing netlink socket (disabled)
[    0.458406] type=3D2000 audit(1249505004.456:1): initialized
[    0.458959] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.459177] VFS: Disk quotas dquot_6.5.2
[    0.459264] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.459378] msgmni has been set to 11973
[    0.459626] alg: No test for stdrng (krng)
[    0.459745] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    0.459816] io scheduler noop registered
[    0.459864] io scheduler anticipatory registered
[    0.459914] io scheduler deadline registered
[    0.459995] io scheduler cfq registered (default)
[    0.984280] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984375] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984478] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984583] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984685] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984791] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984901] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.985019] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.985080] pci 0000:01:0a.0: Boot video device
[    0.985270]   alloc irq_desc for 24 on cpu 0 node 0
[    0.985272]   alloc kstat_irqs on cpu 0 node 0
[    0.985280] pcieport-driver 0000:00:09.0: irq 24 for MSI/MSI-X
[    0.985286] pcieport-driver 0000:00:09.0: setting latency timer to 64
[    0.985451]   alloc irq_desc for 25 on cpu 0 node 0
[    0.985453]   alloc kstat_irqs on cpu 0 node 0
[    0.985457] pcieport-driver 0000:00:0b.0: irq 25 for MSI/MSI-X
[    0.985463] pcieport-driver 0000:00:0b.0: setting latency timer to 64
[    0.985622]   alloc irq_desc for 26 on cpu 0 node 0
[    0.985624]   alloc kstat_irqs on cpu 0 node 0
[    0.985628] pcieport-driver 0000:00:0c.0: irq 26 for MSI/MSI-X
[    0.985634] pcieport-driver 0000:00:0c.0: setting latency timer to 64
[    0.989969] Linux agpgart interface v0.103
[    0.990023] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.990198] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    0.990678] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    0.992591] brd: module loaded
[    0.992717] input: Macintosh mouse button emulation as /devices/virtual/=
input/input0
[    0.992993] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.993051] PNP: PS/2 appears to have AUX port disabled, if this is inco=
rrect please boot with i8042.nopnp
[    0.993248] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.993454] mice: PS/2 mouse device common for all mice
[    0.993574] rtc_cmos 00:02: RTC can wake from S4
[    0.993688] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.993767] rtc0: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    0.993857] cpuidle: using governor ladder
[    0.993907] cpuidle: using governor menu
[    0.993958] No iBFT detected.
[    0.994332] TCP cubic registered
[    0.994472] NET: Registered protocol family 10
[    0.994997] lo: Disabled Privacy Extensions
[    0.995328] Mobile IPv6
[    0.995375] NET: Registered protocol family 17
[    0.995581] registered taskstats version 1
[    0.995811] rtc_cmos 00:02: setting system clock to 2009-08-05 20:43:26 =
UTC (1249505006)
[    0.995960] Freeing unused kernel memory: 560k freed
[    0.996285] Write protecting the kernel read-only data: 3772k
[    1.015253] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    1.160187] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.161576] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 10
[    1.161632] PCI: setting IRQ 10 as level-triggered
[    1.161637] ehci_hcd 0000:00:02.1: PCI INT B -> Link[LUB2] -> GSI 10 (le=
vel, low) -> IRQ 10
[    1.161741] ehci_hcd 0000:00:02.1: setting latency timer to 64
[    1.161744] ehci_hcd 0000:00:02.1: EHCI Host Controller
[    1.161896] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus =
number 1
[    1.162002] ehci_hcd 0000:00:02.1: debug port 1
[    1.162053] ehci_hcd 0000:00:02.1: cache line size of 64 is not supported
[    1.162064] ehci_hcd 0000:00:02.1: irq 10, io mem 0xdfbfec00
[    1.163907] FDC 0 is a post-1991 82077
[    1.169177] Uniform Multi-Platform E-IDE driver
[    1.176037] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00
[    1.176120] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.176174] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.176243] usb usb1: Product: EHCI Host Controller
[    1.176296] usb usb1: Manufacturer: Linux 2.6.30-btrfsnewformat2 ehci_hcd
[    1.176350] usb usb1: SerialNumber: 0000:00:02.1
[    1.176473] usb usb1: configuration #1 chosen from 1 choice
[    1.176554] hub 1-0:1.0: USB hub found
[    1.176611] hub 1-0:1.0: 10 ports detected
[    1.177218] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
[    1.177271] PCI: setting IRQ 11 as level-triggered
[    1.177276] firewire_ohci 0000:01:03.0: PCI INT A -> Link[LNKC] -> GSI 1=
1 (level, low) -> IRQ 11
[    1.179648] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.180121] amd74xx 0000:00:06.0: UDMA133 controller
[    1.180176] amd74xx 0000:00:06.0: IDE controller (0x10de:0x03ec rev 0xa2)
[    1.180246] amd74xx 0000:00:06.0: IDE port disabled
[    1.180308] amd74xx 0000:00:06.0: BIOS didn't set cable bits correctly. =
Enabling workaround.
[    1.180383] amd74xx 0000:00:06.0: not 100% native mode: will probe irqs =
later
[    1.180440]     ide0: BM-DMA at 0xffa0-0xffa7
[    1.180497] Probing IDE interface ide0...
[    1.266341] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.4-k4
[    1.266397] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    1.266483] firewire_ohci: Added fw-ohci device 0000:01:03.0, OHCI versi=
on 1.10
[    1.266954] ACPI: PCI Interrupt Link [LNEB] enabled at IRQ 10
[    1.267008] e1000e 0000:05:00.0: PCI INT A -> Link[LNEB] -> GSI 10 (leve=
l, low) -> IRQ 10
[    1.267088] e1000e 0000:05:00.0: setting latency timer to 64
[    1.267241]   alloc irq_desc for 27 on cpu 0 node 0
[    1.267243]   alloc kstat_irqs on cpu 0 node 0
[    1.267257] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[    1.447176] 0000:05:00.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:15:17:=
24:85:7a
[    1.447249] 0000:05:00.0: eth0: Intel(R) PRO/1000 Network Connection
[    1.447378] 0000:05:00.0: eth0: MAC: 1, PHY: 4, PBA No: d50855-002
[    1.449131] udev: renamed network interface eth0 to eth1
[    1.468111] hda: WDC WD1600JB-00GVA0, ATA DISK drive
[    1.764090] firewire_core: created device fw0: GUID 0011d80000f46d61, S4=
00
[    2.140050] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    2.141276] hda: UDMA/100 mode selected
[    2.142593] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.167262] ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 11
[    2.167319] ohci_hcd 0000:00:02.0: PCI INT A -> Link[LUB0] -> GSI 11 (le=
vel, low) -> IRQ 11
[    2.167425] ohci_hcd 0000:00:02.0: setting latency timer to 64
[    2.167428] ohci_hcd 0000:00:02.0: OHCI Host Controller
[    2.167566] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus =
number 2
[    2.167650] ohci_hcd 0000:00:02.0: irq 11, io mem 0xdfbff000
[    2.222017] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    2.222072] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.222141] usb usb2: Product: OHCI Host Controller
[    2.222191] usb usb2: Manufacturer: Linux 2.6.30-btrfsnewformat2 ohci_hcd
[    2.222248] usb usb2: SerialNumber: 0000:00:02.0
[    2.222348] usb usb2: configuration #1 chosen from 1 choice
[    2.222431] hub 2-0:1.0: USB hub found
[    2.222488] hub 2-0:1.0: 10 ports detected
[    2.222787] forcedeth: Reverse Engineered nForce ethernet driver. Versio=
n 0.64.
[    2.223123] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 11
[    2.223177] forcedeth 0000:00:07.0: PCI INT A -> Link[LMAC] -> GSI 11 (l=
evel, low) -> IRQ 11
[    2.223251] forcedeth 0000:00:07.0: setting latency timer to 64
[    2.740862] forcedeth 0000:00:07.0: ifname eth0, PHY OUI 0x1374 @ 1, add=
r 00:18:f3:aa:18:da
[    2.740938] forcedeth 0000:00:07.0: highdma pwrctl mgmt gbit lnktim msi =
desc-v3
[    2.753300] SCSI subsystem initialized
[    2.768118] libata version 3.00 loaded.
[    2.771134] sata_nv 0000:00:08.0: version 3.5
[    2.771420] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 15
[    2.771475] PCI: setting IRQ 15 as level-triggered
[    2.771480] sata_nv 0000:00:08.0: PCI INT A -> Link[LSA0] -> GSI 15 (lev=
el, low) -> IRQ 15
[    2.771626] sata_nv 0000:00:08.0: setting latency timer to 64
[    2.771705] scsi0 : sata_nv
[    2.771879] scsi1 : sata_nv
[    2.772097] ata1: SATA max UDMA/133 cmd 0xb400 ctl 0xb080 bmdma 0xa880 i=
rq 15
[    2.772155] ata2: SATA max UDMA/133 cmd 0xb000 ctl 0xac00 bmdma 0xa888 i=
rq 15
[    2.772523] ACPI: PCI Interrupt Link [LSA1] enabled at IRQ 5
[    2.772575] PCI: setting IRQ 5 as level-triggered
[    2.772579] sata_nv 0000:00:08.1: PCI INT B -> Link[LSA1] -> GSI 5 (leve=
l, low) -> IRQ 5
[    2.772695] sata_nv 0000:00:08.1: setting latency timer to 64
[    2.772865] scsi2 : sata_nv
[    2.772992] scsi3 : sata_nv
[    2.773198] ata3: SATA max UDMA/133 cmd 0xa800 ctl 0xa480 bmdma 0xa000 i=
rq 5
[    2.773253] ata4: SATA max UDMA/133 cmd 0xa400 ctl 0xa080 bmdma 0xa008 i=
rq 5
[    2.872338] ide-gd driver 1.18
[    2.872420] hda: max request size: 512KiB
[    2.873757] hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=3D19=
457/255/63
[    2.875862] hda: cache flushes supported
[    2.875950]  hda: hda1 hda2 hda3
[    3.248036] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.256114] ata1.00: FORCE: horkage modified (noncq)
[    3.257534] ata1.00: ATA-6: WDC WD1600JD-00GBB0, 02.05D02, max UDMA/100
[    3.257591] ata1.00: 312581808 sectors, multi 16: LBA48=20
[    3.257652] ata1.00: applying bridge limits
[    3.273468] ata1.00: configured for PIO4
[    3.273622] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JD-00G 02=
=2E0 PQ: 0 ANSI: 5
[    3.740032] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.748111] ata2.00: FORCE: horkage modified (noncq)
[    3.748164] ata2.00: ATAPI: TSSTcorp CDDVDW SH-S223F, SB03, max UDMA/100
[    3.764126] ata2.00: configured for PIO4
[    3.765670] scsi 1:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S223F  SB=
03 PQ: 0 ANSI: 5
[    4.098146] Driver 'sd' needs updating - please use bus_type methods
[    4.098336] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 =
GB/149 GiB)
[    4.098422] sd 0:0:0:0: [sda] Write Protect is off
[    4.098475] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.098492] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    4.098645]  sda: sda1 sda2 sda3
[    4.139767] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.142108] Driver 'sr' needs updating - please use bus_type methods
[    4.147729] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    4.147805] Uniform CD-ROM driver Revision: 3.20
[    4.147962] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    4.154660] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.154745] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    4.620946] md: raid1 personality registered for level 1
[    4.622763] xor: automatically using best checksumming function: generic=
_sse
[    4.640008]    generic_sse:  7436.000 MB/sec
[    4.640058] xor: using function: generic_sse (7436.000 MB/sec)
[    4.640626] async_tx: api initialized (async)
[    4.708008] raid6: int64x1   2258 MB/s
[    4.776013] raid6: int64x2   2882 MB/s
[    4.844017] raid6: int64x4   2247 MB/s
[    4.912036] raid6: int64x8   2016 MB/s
[    4.980063] raid6: sse2x1    1043 MB/s
[    5.048031] raid6: sse2x2    1674 MB/s
[    5.116031] raid6: sse2x4    2286 MB/s
[    5.116079] raid6: using algorithm sse2x4 (2286 MB/s)
[    5.119013] md: raid6 personality registered for level 6
[    5.119068] md: raid5 personality registered for level 5
[    5.119119] md: raid4 personality registered for level 4
[    5.232595] md: md0 stopped.
[    5.272724] md: bind<hda1>
[    5.273333] md: bind<sda1>
[    5.274552] raid1: raid set md0 active with 2 out of 2 mirrors
[    5.279314]  md0: unknown partition table
[    5.344780] md: md1 stopped.
[    5.347457] md: bind<hda2>
[    5.348070] md: bind<sda2>
[    5.348133] md: md1: raid array is not clean -- starting background reco=
nstruction
[    5.349862] raid1: raid set md1 active with 2 out of 2 mirrors
[    5.352801]  md1: unknown partition table
[    5.401226] device-mapper: uevent: version 1.0.3
[    5.401612] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised:=
 dm-devel@redhat.com
[    5.539166] PM: Starting manual resume from disk
[    5.591241] kjournald starting.  Commit interval 5 seconds
[    5.591302] EXT3-fs: mounted filesystem with ordered data mode.
[    7.088132] udev: starting version 141
[    7.537547] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    7.537624] ACPI: Power Button [PWRF]
[    7.537757] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
C:00/input/input3
[    7.537834] ACPI: Power Button [PWRB]
[    8.537928] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    8.543600] parport_pc 00:06: reported by Plug and Play ACPI
[    8.543700] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    8.553157] processor ACPI_CPU:00: registered as cooling_device0
[    8.553427] processor ACPI_CPU:01: registered as cooling_device1
[    8.562240] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    8.571142] k8temp 0000:00:18.3: Temperature readouts might be wrong - c=
heck erratum #141
[    8.703846] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x600
[    8.703919] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x700
[    9.056876] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 11
[    9.056933] HDA Intel 0000:00:05.0: PCI INT B -> Link[LAZA] -> GSI 11 (l=
evel, low) -> IRQ 11
[    9.057162] HDA Intel 0000:00:05.0: setting latency timer to 64
[    9.104215] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    9.128923] Error: Driver 'pcspkr' is already registered, aborting...
[    9.814340] hda_codec: Unknown model for AD1988, trying auto-probe from =
BIOS...
[    9.814512] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:05.=
0/input/input5
[   12.272211] Adding 3943948k swap on /dev/sda3.  Priority:-1 extents:1 ac=
ross:3943948k=20
[   12.277613] Adding 3943948k swap on /dev/hda3.  Priority:-2 extents:1 ac=
ross:3943948k=20
[   12.488653] EXT3 FS on dm-0, <6>md: resync of RAID array md1
[   12.488658] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[   12.488661] md: using maximum available idle IO bandwidth (but not more =
than 200000 KB/sec) for resync.
[   12.488664] md: using 128k window, over a total of 151364352 blocks.
[   12.488666] md: resuming resync of md1 from checkpoint.
[   12.488935] internal journal
[   12.849491] loop: module loaded
[   13.843359] kjournald starting.  Commit interval 5 seconds
[   13.848847] EXT3 FS on md0, internal journal
[   13.848928] EXT3-fs: mounted filesystem with ordered data mode.
[   14.016783] EXT4-fs: barriers enabled
[   14.031603] kjournald2 starting: pid 2352, dev dm-3:8, commit interval 5=
 seconds
[   14.032662] EXT4 FS on dm-3, internal journal on dm-3:8
[   14.032714] EXT4-fs: delayed allocation enabled
[   14.032763] EXT4-fs: file extents enabled
[   14.034089] EXT4-fs: mballoc enabled
[   14.034151] EXT4-fs: mounted filesystem dm-3 with ordered data mode
[   15.734281] Bridge firewalling registered
[   15.762229] device eth1 entered promiscuous mode
[   15.904387] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[   15.960078] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[   15.961781] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   19.284847] Loading iSCSI transport class v2.0-870.
[   19.320165] iscsi: registered transport (tcp)
[   19.402444] iscsi: registered transport (iser)
[   19.931919] RPC: Registered udp transport module.
[   19.931990] RPC: Registered tcp transport module.
[   20.002507] Slow work thread pool: Starting up
[   20.002624] Slow work thread pool: Ready
[   20.002739] FS-Cache: Loaded
[   20.080948] FS-Cache: Netfs 'nfs' registered for caching
[   20.143294] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   26.288008] br0: no IPv6 routers present
[   28.585008] torbr: no IPv6 routers present
[   86.402426] virbr1: starting userspace STP failed, starting kernel STP
[   86.443667] svc: failed to register lockdv1 RPC service (errno 97).
[   86.444273] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recov=
ery directory
[   86.457208] NFSD: starting 90-second grace period
[   86.618889] ip_tables: (C) 2000-2006 Netfilter Core Team
[   88.684985] tun: Universal TUN/TAP device driver, 1.6
[   88.685042] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   88.687548] device vnet0 entered promiscuous mode
[   88.689051] br0: port 2(vnet0) entering learning state
[   88.838659] br0: port 2(vnet0) entering disabled state
[   88.853336] device vnet0 left promiscuous mode
[   88.853390] br0: port 2(vnet0) entering disabled state
[   88.998418] lo: Disabled Privacy Extensions
[   95.737787] sata_mv 0000:04:04.0: version 1.28
[   95.738241] ACPI: PCI Interrupt Link [LNED] enabled at IRQ 11
[   95.738296] sata_mv 0000:04:04.0: PCI INT A -> Link[LNED] -> GSI 11 (lev=
el, low) -> IRQ 11
[   95.738584] sata_mv 0000:04:04.0: Gen-II 32 slots 8 ports SCSI mode IRQ =
via INTx
[   95.739657] scsi4 : sata_mv
[   95.740279] scsi5 : sata_mv
[   95.741221] scsi6 : sata_mv
[   95.749542] scsi7 : sata_mv
[   95.749704] scsi8 : sata_mv
[   95.749812] scsi9 : sata_mv
[   95.749922] scsi10 : sata_mv
[   95.750032] scsi11 : sata_mv
[   95.750121] ata5: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
2000 irq 11
[   95.750193] ata6: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
4000 irq 11
[   95.750265] ata7: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
6000 irq 11
[   95.750337] ata8: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
8000 irq 11
[   95.750412] ata9: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe3=
2000 irq 11
[   95.750482] ata10: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
34000 irq 11
[   95.750557] ata11: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
36000 irq 11
[   95.750628] ata12: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
38000 irq 11
[   96.224041] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   96.233243] ata5.00: FORCE: horkage modified (noncq)
[   96.256048] ata5.00: ATA-8: WDC WD5000AAKS-00A7B0, 01.03B01, max UDMA/133
[   96.256104] ata5.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[   96.272062] ata5.00: configured for PIO4
[   96.272205] scsi 4:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 01=
=2E0 PQ: 0 ANSI: 5
[   96.272423] sd 4:0:0:0: Attached scsi generic sg2 type 0
[   96.272555] sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[   96.272637] sd 4:0:0:0: [sdb] Write Protect is off
[   96.272688] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   96.272709] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   96.272878]  sdb:<4>ata5: sata_mv: attempting PIO w/multiple DRQ: this m=
ay fail due to h/w errata
[   96.298591]  sdb1
[   96.298824] sd 4:0:0:0: [sdb] Attached SCSI disk
[   96.301341] ata5: sata_mv: attempting PIO w/multiple DRQ: this may fail =
due to h/w errata
[   96.301947] ata5: sata_mv: attempting PIO w/multiple DRQ: this may fail =
due to h/w errata
[   96.314785] ata5: sata_mv: attempting PIO w/multiple DRQ: this may fail =
due to h/w errata
[   96.354571] ata5: sata_mv: attempting PIO w/multiple DRQ: this may fail =
due to h/w errata
[   96.370164] ata5: sata_mv: attempting PIO w/multiple DRQ: this may fail =
due to h/w errata
[   96.381571] ata5: sata_mv: attempting PIO w/multiple DRQ: this may fail =
due to h/w errata
[   96.393599] ata5: sata_mv: attempting PIO w/multiple DRQ: this may fail =
due to h/w errata
[   96.415409] ata5: sata_mv: attempting PIO w/multiple DRQ: this may fail =
due to h/w errata
[   96.432198] ata5: sata_mv: attempting PIO w/multiple DRQ: this may fail =
due to h/w errata
[   96.748035] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   96.764053] ata6.00: FORCE: horkage modified (noncq)
[   96.773045] ata6.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[   96.773100] ata6.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[   96.804087] ata6.00: configured for PIO4
[   96.804217] scsi 5:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[   96.804422] sd 5:0:0:0: Attached scsi generic sg3 type 0
[   96.804553] sd 5:0:0:0: [sdc] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[   96.804643] sd 5:0:0:0: [sdc] Write Protect is off
[   96.804700] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   96.804721] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   96.804880]  sdc: sdc1
[   96.814821] sd 5:0:0:0: [sdc] Attached SCSI disk
[   97.020008] virbr1: no IPv6 routers present
[   97.280039] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   97.296054] ata7.00: FORCE: horkage modified (noncq)
[   97.320049] ata7.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[   97.320104] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[   97.344062] ata7.00: configured for PIO4
[   97.344205] scsi 6:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[   97.344408] sd 6:0:0:0: Attached scsi generic sg4 type 0
[   97.344536] sd 6:0:0:0: [sdd] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[   97.344617] sd 6:0:0:0: [sdd] Write Protect is off
[   97.344668] sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   97.344688] sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   97.344851]  sdd: sdd1
[   97.354810] sd 6:0:0:0: [sdd] Attached SCSI disk
[   97.828034] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   97.886421] ata8.00: FORCE: horkage modified (noncq)
[   97.924049] ata8.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[   97.924105] ata8.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[   97.969788] ata8.00: configured for PIO4
[   97.974998] scsi 7:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[   97.975205] sd 7:0:0:0: Attached scsi generic sg5 type 0
[   97.975340] sd 7:0:0:0: [sde] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[   97.975422] sd 7:0:0:0: [sde] Write Protect is off
[   97.975473] sd 7:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   97.975493] sd 7:0:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   97.975656]  sde: sde1
[   97.983461] sd 7:0:0:0: [sde] Attached SCSI disk
[   98.448035] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   98.464053] ata9.00: FORCE: horkage modified (noncq)
[   98.464107] ata9.00: ATA-7: WDC WD5000AAKS-65TMA0, 12.01C01, max UDMA/133
[   98.464163] ata9.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[   98.488067] ata9.00: configured for PIO4
[   98.488206] scsi 8:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-6 12=
=2E0 PQ: 0 ANSI: 5
[   98.488417] sd 8:0:0:0: Attached scsi generic sg6 type 0
[   98.488546] sd 8:0:0:0: [sdf] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[   98.488627] sd 8:0:0:0: [sdf] Write Protect is off
[   98.488678] sd 8:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   98.488697] sd 8:0:0:0: [sdf] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   98.488860]  sdf: sdf1
[   98.514814] sd 8:0:0:0: [sdf] Attached SCSI disk
[   98.809029] ata10: SATA link down (SStatus 0 SControl 300)
[   99.128032] ata11: SATA link down (SStatus 0 SControl 300)
[   99.448028] ata12: SATA link down (SStatus 0 SControl 300)

--4ickEXl+ukcSQ/3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sata_mv-dmesg.noapic.noncq-workingslow.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-btrfsnewformat2 (2.6.30) (root@slimer) =
(gcc version 4.3.3 (Debian 4.3.3-15) ) #3 SMP Mon Aug 3 18:09:53 GMT 2009
[    0.000000] Command line: root=3D/dev/mapper/slimerroot-root ro noapic l=
ibata.force=3Dnoncq
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
[    0.000000] ACPI: Skipping IOAPIC probe due to 'noapic' option.
[    0.000000] Using ACPI for processor (LAPIC) configuration information
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000] MPTABLE: OEM ID: TEMPLATE
[    0.000000] MPTABLE: Product ID: 1394       =20
[    0.000000] MPTABLE: APIC at: 0xFEE00000
[    0.000000] I/O APIC #2 Version 17 at 0xFEC00000.
[    0.000000] Processors: 2
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
[    0.000000] Kernel command line: root=3D/dev/mapper/slimerroot-root ro n=
oapic libata.force=3Dnoncq
[    0.000000] Unknown boot option `libata.force=3Dnoncq': ignoring
[    0.000000] Initializing CPU#0
[    0.000000] Experimental hierarchical RCU implementation.
[    0.000000] Experimental hierarchical RCU init done.
[    0.000000] NR_IRQS:4352 nr_irqs:424
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Fast TSC calibration failed
[    0.000000] TSC: PIT calibration matches PMTIMER. 1 loops
[    0.000000] Detected 2410.947 MHz processor.
[    0.004000] spurious 8259A interrupt: IRQ7.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Checking aperture...
[    0.004000] No AGP bridge found
[    0.004000] Node 0: aperture @ d730000000 size 32 MB
[    0.004000] Aperture beyond 4GB. Ignoring.
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
er frequency.. 4821.89 BogoMIPS (lpj=3D9643788)
[    0.004000] Security Framework initialized
[    0.004000] SELinux:  Disabled at boot.
[    0.004000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.006481] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.009166] Mount-cache hash table entries: 256
[    0.009385] Initializing cgroup subsys ns
[    0.009435] Initializing cgroup subsys cpuacct
[    0.009490] Initializing cgroup subsys devices
[    0.009540] Initializing cgroup subsys freezer
[    0.009590] Initializing cgroup subsys net_cls
[    0.009669] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.009724] CPU: L2 Cache: 512K (64 bytes/line)
[    0.009777] CPU 0/0x0 -> Node 0
[    0.009824] tseg: 0000000000
[    0.009835] CPU: Physical Processor ID: 0
[    0.009883] CPU: Processor Core ID: 0
[    0.009941] using C1E aware idle routine
[    0.010605] ACPI: Core revision 20090320
[    0.017076] ACPI: setting ELCR to 0200 (from 8c20)
[    0.017506] Setting APIC routing to flat
[    0.017562] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.020000] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 4821.85 Bog=
oMIPS (lpj=3D9643705)
[    0.004000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.004000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.004000] CPU 1/0x1 -> Node 0
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x701060007=
0106
[    0.104347] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.104869] Brought up 2 CPUs
[    0.104917] Total of 2 processors activated (9643.74 BogoMIPS).
[    0.104994] CPU0 attaching sched-domain:
[    0.104996]  domain 0: span 0-1 level MC
[    0.104998]   groups: 0 1
[    0.105003] CPU1 attaching sched-domain:
[    0.105005]  domain 0: span 0-1 level MC
[    0.105007]   groups: 1 0
[    0.105062] net_namespace: 1936 bytes
[    0.105062] Booting paravirtualized kernel on bare hardware
[    0.105062] regulator: core version 0.5
[    0.105062] NET: Registered protocol family 16
[    0.105062] node 0 link 0: io port [1000, ffffff]
[    0.105062] TOM: 00000000d0000000 aka 3328M
[    0.105062] node 0 link 0: mmio [e0000000, efffffff]
[    0.105062] node 0 link 0: mmio [a0000, bffff]
[    0.105062] node 0 link 0: mmio [d0000000, fe0bffff]
[    0.105062] TOM2: 00000001b0000000 aka 6912M
[    0.105062] bus: [00,ff] on node 0 link 0
[    0.105062] bus: 00 index 0 io port: [0, ffff]
[    0.105062] bus: 00 index 1 mmio: [d0000000, ffffffff]
[    0.105062] bus: 00 index 2 mmio: [a0000, bffff]
[    0.105062] bus: 00 index 3 mmio: [1b0000000, fcffffffff]
[    0.105062] ACPI: bus type pci registered
[    0.105062] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.105062] PCI: Not using MMCONFIG.
[    0.105062] PCI: Using configuration type 1 for base access
[    0.105062] bio: create slab <bio-0> at 0
[    0.108582] ACPI: EC: Look up EC in DSDT
[    0.119104] ACPI: Interpreter enabled
[    0.120003] ACPI: (supports S0 S1 S3 S4 S5)
[    0.120207] ACPI: Using PIC for interrupt routing
[    0.120309] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.127106] PCI: MCFG area at e0000000 reserved in ACPI motherboard reso=
urces
[    0.137471] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.148114] ACPI Warning (tbutils-0246): Incorrect checksum in table [OE=
MB] - E5, should be D8 [20090320]
[    0.148310] ACPI: No dock devices found.
[    0.148424] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.148509] pci 0000:00:01.1: reg 10 io port: [0xbc00-0xbc3f]
[    0.148509] pci 0000:00:01.1: reg 20 io port: [0x600-0x63f]
[    0.148509] pci 0000:00:01.1: reg 24 io port: [0x700-0x73f]
[    0.148509] pci 0000:00:01.1: PME# supported from D3hot D3cold
[    0.148509] pci 0000:00:01.1: PME# disabled
[    0.148509] pci 0000:00:02.0: reg 10 32bit mmio: [0xdfbff000-0xdfbfffff]
[    0.148509] pci 0000:00:02.0: supports D1 D2
[    0.148509] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.148509] pci 0000:00:02.0: PME# disabled
[    0.148509] pci 0000:00:02.1: reg 10 32bit mmio: [0xdfbfec00-0xdfbfecff]
[    0.148531] pci 0000:00:02.1: supports D1 D2
[    0.148533] pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.148587] pci 0000:00:02.1: PME# disabled
[    0.148690] pci 0000:00:05.0: reg 10 32bit mmio: [0xdfbf8000-0xdfbfbfff]
[    0.148714] pci 0000:00:05.0: PME# supported from D3hot D3cold
[    0.148767] pci 0000:00:05.0: PME# disabled
[    0.148848] pci 0000:00:06.0: reg 20 io port: [0xffa0-0xffaf]
[    0.148880] pci 0000:00:07.0: reg 10 32bit mmio: [0xdfbfd000-0xdfbfdfff]
[    0.148884] pci 0000:00:07.0: reg 14 io port: [0xb480-0xb487]
[    0.148903] pci 0000:00:07.0: supports D1 D2
[    0.148905] pci 0000:00:07.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.148961] pci 0000:00:07.0: PME# disabled
[    0.149029] pci 0000:00:08.0: reg 10 io port: [0xb400-0xb407]
[    0.149032] pci 0000:00:08.0: reg 14 io port: [0xb080-0xb083]
[    0.149035] pci 0000:00:08.0: reg 18 io port: [0xb000-0xb007]
[    0.149039] pci 0000:00:08.0: reg 1c io port: [0xac00-0xac03]
[    0.149042] pci 0000:00:08.0: reg 20 io port: [0xa880-0xa88f]
[    0.149046] pci 0000:00:08.0: reg 24 32bit mmio: [0xdfbfc000-0xdfbfcfff]
[    0.149074] pci 0000:00:08.1: reg 10 io port: [0xa800-0xa807]
[    0.149077] pci 0000:00:08.1: reg 14 io port: [0xa480-0xa483]
[    0.149080] pci 0000:00:08.1: reg 18 io port: [0xa400-0xa407]
[    0.149083] pci 0000:00:08.1: reg 1c io port: [0xa080-0xa083]
[    0.149087] pci 0000:00:08.1: reg 20 io port: [0xa000-0xa00f]
[    0.149090] pci 0000:00:08.1: reg 24 32bit mmio: [0xdfbf3000-0xdfbf3fff]
[    0.149131] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.149186] pci 0000:00:09.0: PME# disabled
[    0.149260] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.149314] pci 0000:00:0b.0: PME# disabled
[    0.149388] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.149443] pci 0000:00:0c.0: PME# disabled
[    0.149585] pci 0000:01:03.0: reg 10 32bit mmio: [0xdfcff800-0xdfcfffff]
[    0.149591] pci 0000:01:03.0: reg 14 io port: [0xcc00-0xcc7f]
[    0.149620] pci 0000:01:03.0: supports D2
[    0.149622] pci 0000:01:03.0: PME# supported from D2 D3hot D3cold
[    0.149676] pci 0000:01:03.0: PME# disabled
[    0.149753] pci 0000:01:0a.0: reg 10 32bit mmio: [0xdfc00000-0xdfc7ffff]
[    0.149758] pci 0000:01:0a.0: reg 14 32bit mmio: [0xd0000000-0xd7ffffff]
[    0.149775] pci 0000:01:0a.0: reg 30 32bit mmio: [0xdfce0000-0xdfceffff]
[    0.149788] pci 0000:01:0a.0: supports D1 D2
[    0.149810] pci 0000:00:04.0: transparent bridge
[    0.149864] pci 0000:00:04.0: bridge io port: [0xc000-0xcfff]
[    0.149868] pci 0000:00:04.0: bridge 32bit mmio: [0xdfc00000-0xdfcfffff]
[    0.149871] pci 0000:00:04.0: bridge 32bit mmio pref: [0xd0000000-0xd7ff=
ffff]
[    0.149904] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.149960] pci 0000:02:00.0: PME# disabled
[    0.150046] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
[    0.150100] pci 0000:02:00.2: PME# disabled
[    0.150186] pci 0000:00:09.0: bridge io port: [0xd000-0xdfff]
[    0.150188] pci 0000:00:09.0: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.150264] pci 0000:04:04.0: reg 10 64bit mmio: [0xdfe00000-0xdfefffff]
[    0.150269] pci 0000:04:04.0: reg 18 io port: [0xd800-0xd8ff]
[    0.150331] pci 0000:02:00.2: bridge io port: [0xd000-0xdfff]
[    0.150334] pci 0000:02:00.2: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.150390] pci 0000:05:00.0: reg 10 32bit mmio: [0xdffe0000-0xdfffffff]
[    0.150399] pci 0000:05:00.0: reg 14 32bit mmio: [0xdffc0000-0xdffdffff]
[    0.150407] pci 0000:05:00.0: reg 18 io port: [0xec00-0xec1f]
[    0.150435] pci 0000:05:00.0: reg 30 32bit mmio: [0xdffa0000-0xdffbffff]
[    0.150471] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.150527] pci 0000:05:00.0: PME# disabled
[    0.150621] pci 0000:00:0b.0: bridge io port: [0xe000-0xefff]
[    0.150623] pci 0000:00:0b.0: bridge 32bit mmio: [0xdff00000-0xdfffffff]
[    0.150667] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.150834] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.150947] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.151011] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR11._PRT]
[    0.151074] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR12._PRT]
[    0.160175] ACPI: PCI Interrupt Link [LNKA] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.160630] ACPI: PCI Interrupt Link [LNKB] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.161081] ACPI: PCI Interrupt Link [LNKC] (IRQs 7 10 *11 14)
[    0.161471] ACPI: PCI Interrupt Link [LNKD] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.161920] ACPI: PCI Interrupt Link [LNEA] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.162366] ACPI: PCI Interrupt Link [LNEB] (IRQs 7 *10 11 14)
[    0.162757] ACPI: PCI Interrupt Link [LNEC] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.163204] ACPI: PCI Interrupt Link [LNED] (IRQs 7 10 *11 14)
[    0.163595] ACPI: PCI Interrupt Link [LUB0] (IRQs 7 10 *11 14)
[    0.164159] ACPI: PCI Interrupt Link [LUB2] (IRQs 7 *10 11 14)
[    0.164553] ACPI: PCI Interrupt Link [LMAC] (IRQs 7 10 *11 14)
[    0.164951] ACPI: PCI Interrupt Link [LAZA] (IRQs 7 10 *11 14)
[    0.165344] ACPI: PCI Interrupt Link [LACI] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.165796] ACPI: PCI Interrupt Link [LMC9] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.166246] ACPI: PCI Interrupt Link [LSMB] (IRQs 7 *10 11 14)
[    0.166635] ACPI: PCI Interrupt Link [LPMU] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.167084] ACPI: PCI Interrupt Link [LSA0] (IRQs *15)
[    0.167393] ACPI: PCI Interrupt Link [LSA1] (IRQs *5)
[    0.167746] ACPI: PCI Interrupt Link [LATA] (IRQs 7 10 11 14) *0, disabl=
ed.
[    0.168052] usbcore: registered new interface driver usbfs
[    0.168066] usbcore: registered new interface driver hub
[    0.168066] usbcore: registered new device driver usb
[    0.168066] PCI: Using ACPI for IRQ routing
[    0.176116] PCI-DMA: Disabling AGP.
[    0.176239] PCI-DMA: aperture base @ 20000000 size 65536 KB
[    0.176239] PCI-DMA: using GART IOMMU.
[    0.176239] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    0.176648] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.176810] hpet0: 3 comparators, 32-bit 25.000000 MHz counter
[    0.184011] Switched to high resolution mode on CPU 0
[    0.184348] Switched to high resolution mode on CPU 1
[    0.192012] pnp: PnP ACPI init
[    0.192077] ACPI: bus type pnp registered
[    0.199714] pnp: PnP ACPI: found 15 devices
[    0.199765] ACPI: ACPI bus type pnp unregistered
[    0.199825] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[    0.199879] system 00:07: ioport range 0x800-0x80f has been reserved
[    0.199933] system 00:07: ioport range 0x500-0x57f has been reserved
[    0.199987] system 00:07: ioport range 0x580-0x5ff has been reserved
[    0.200053] system 00:07: ioport range 0x800-0x87f could not be reserved
[    0.200107] system 00:07: ioport range 0x880-0x8ff has been reserved
[    0.200161] system 00:07: ioport range 0xd00-0xd7f has been reserved
[    0.200215] system 00:07: ioport range 0xd80-0xdff has been reserved
[    0.200269] system 00:07: ioport range 0x2000-0x207f has been reserved
[    0.200323] system 00:07: ioport range 0x2080-0x20ff has been reserved
[    0.200378] system 00:07: iomem range 0xfefe0000-0xfefe01ff has been res=
erved
[    0.200433] system 00:07: iomem range 0xfefe1000-0xfefe1fff has been res=
erved
[    0.200489] system 00:07: iomem range 0xfee01000-0xfeefffff has been res=
erved
[    0.200545] system 00:07: iomem range 0xffb80000-0xffffffff has been res=
erved
[    0.200603] system 00:09: iomem range 0xfec00000-0xfec00fff has been res=
erved
[    0.200658] system 00:09: iomem range 0xfee00000-0xfee00fff has been res=
erved
[    0.200717] system 00:0b: ioport range 0x230-0x23f has been reserved
[    0.200771] system 00:0b: ioport range 0x290-0x29f has been reserved
[    0.200825] system 00:0b: ioport range 0xa00-0xa0f has been reserved
[    0.200879] system 00:0b: ioport range 0xa10-0xa1f has been reserved
[    0.200935] system 00:0d: iomem range 0xe0000000-0xefffffff has been res=
erved
[    0.200992] system 00:0e: iomem range 0x0-0x9ffff could not be reserved
[    0.201052] system 00:0e: iomem range 0xc0000-0xcffff has been reserved
[    0.201106] system 00:0e: iomem range 0xe0000-0xfffff could not be reser=
ved
[    0.201161] system 00:0e: iomem range 0x100000-0xcfffffff could not be r=
eserved
[    0.201231] system 00:0e: iomem range 0xff780000-0xffffffff could not be=
 reserved
[    0.206318] pci 0000:00:04.0: PCI bridge, secondary bus 0000:01
[    0.206372] pci 0000:00:04.0:   IO window: 0xc000-0xcfff
[    0.206425] pci 0000:00:04.0:   MEM window: 0xdfc00000-0xdfcfffff
[    0.206479] pci 0000:00:04.0:   PREFETCH window: 0x000000d0000000-0x0000=
00d7ffffff
[    0.206551] pci 0000:02:00.0: PCI bridge, secondary bus 0000:03
[    0.206603] pci 0000:02:00.0:   IO window: disabled
[    0.206655] pci 0000:02:00.0:   MEM window: disabled
[    0.206706] pci 0000:02:00.0:   PREFETCH window: disabled
[    0.206760] pci 0000:02:00.2: PCI bridge, secondary bus 0000:04
[    0.206813] pci 0000:02:00.2:   IO window: 0xd000-0xdfff
[    0.206866] pci 0000:02:00.2:   MEM window: 0xdfd00000-0xdfefffff
[    0.206920] pci 0000:02:00.2:   PREFETCH window: disabled
[    0.206973] pci 0000:00:09.0: PCI bridge, secondary bus 0000:02
[    0.207026] pci 0000:00:09.0:   IO window: 0xd000-0xdfff
[    0.207078] pci 0000:00:09.0:   MEM window: 0xdfd00000-0xdfefffff
[    0.207131] pci 0000:00:09.0:   PREFETCH window: disabled
[    0.207184] pci 0000:00:0b.0: PCI bridge, secondary bus 0000:05
[    0.207236] pci 0000:00:0b.0:   IO window: 0xe000-0xefff
[    0.207288] pci 0000:00:0b.0:   MEM window: 0xdff00000-0xdfffffff
[    0.207341] pci 0000:00:0b.0:   PREFETCH window: disabled
[    0.207393] pci 0000:00:0c.0: PCI bridge, secondary bus 0000:06
[    0.207446] pci 0000:00:0c.0:   IO window: disabled
[    0.207496] pci 0000:00:0c.0:   MEM window: disabled
[    0.207547] pci 0000:00:0c.0:   PREFETCH window: disabled
[    0.207607] pci 0000:00:04.0: setting latency timer to 64
[    0.207611] pci 0000:00:09.0: setting latency timer to 64
[    0.207616] pci 0000:02:00.0: setting latency timer to 64
[    0.207621] pci 0000:02:00.2: setting latency timer to 64
[    0.207625] pci 0000:00:0b.0: setting latency timer to 64
[    0.207629] pci 0000:00:0c.0: setting latency timer to 64
[    0.207632] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.207635] pci_bus 0000:00: resource 1 mem: [0x000000-0xfffffffffffffff=
f]
[    0.207637] pci_bus 0000:01: resource 0 io:  [0xc000-0xcfff]
[    0.207640] pci_bus 0000:01: resource 1 mem: [0xdfc00000-0xdfcfffff]
[    0.207642] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xd7ffffff]
[    0.207644] pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
[    0.207647] pci_bus 0000:01: resource 4 mem: [0x000000-0xfffffffffffffff=
f]
[    0.207649] pci_bus 0000:02: resource 0 io:  [0xd000-0xdfff]
[    0.207651] pci_bus 0000:02: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.207654] pci_bus 0000:04: resource 0 io:  [0xd000-0xdfff]
[    0.207656] pci_bus 0000:04: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.207659] pci_bus 0000:05: resource 0 io:  [0xe000-0xefff]
[    0.207661] pci_bus 0000:05: resource 1 mem: [0xdff00000-0xdfffffff]
[    0.207758] NET: Registered protocol family 2
[    0.236272] IP route cache hash table entries: 262144 (order: 9, 2097152=
 bytes)
[    0.238838] TCP established hash table entries: 524288 (order: 11, 83886=
08 bytes)
[    0.244310] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.244993] TCP: Hash tables configured (established 524288 bind 65536)
[    0.245054] TCP reno registered
[    0.256126] NET: Registered protocol family 1
[    0.256232] Trying to unpack rootfs image as initramfs...
[    0.451588] Freeing initrd memory: 8817k freed
[    0.458370] audit: initializing netlink socket (disabled)
[    0.458434] type=3D2000 audit(1249504312.456:1): initialized
[    0.458986] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.459207] VFS: Disk quotas dquot_6.5.2
[    0.459295] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.459408] msgmni has been set to 11973
[    0.459656] alg: No test for stdrng (krng)
[    0.459776] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    0.459847] io scheduler noop registered
[    0.459895] io scheduler anticipatory registered
[    0.459945] io scheduler deadline registered
[    0.460042] io scheduler cfq registered (default)
[    0.984322] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984417] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984521] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984623] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984725] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984831] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.984941] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.985059] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.985120] pci 0000:01:0a.0: Boot video device
[    0.985310]   alloc irq_desc for 24 on cpu 0 node 0
[    0.985313]   alloc kstat_irqs on cpu 0 node 0
[    0.985320] pcieport-driver 0000:00:09.0: irq 24 for MSI/MSI-X
[    0.985326] pcieport-driver 0000:00:09.0: setting latency timer to 64
[    0.985490]   alloc irq_desc for 25 on cpu 0 node 0
[    0.985491]   alloc kstat_irqs on cpu 0 node 0
[    0.985496] pcieport-driver 0000:00:0b.0: irq 25 for MSI/MSI-X
[    0.985501] pcieport-driver 0000:00:0b.0: setting latency timer to 64
[    0.985659]   alloc irq_desc for 26 on cpu 0 node 0
[    0.985661]   alloc kstat_irqs on cpu 0 node 0
[    0.985665] pcieport-driver 0000:00:0c.0: irq 26 for MSI/MSI-X
[    0.985671] pcieport-driver 0000:00:0c.0: setting latency timer to 64
[    0.990031] Linux agpgart interface v0.103
[    0.990087] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.990263] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    0.990747] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    0.992718] brd: module loaded
[    0.992848] input: Macintosh mouse button emulation as /devices/virtual/=
input/input0
[    0.993208] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.993263] PNP: PS/2 appears to have AUX port disabled, if this is inco=
rrect please boot with i8042.nopnp
[    0.993480] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.993687] mice: PS/2 mouse device common for all mice
[    0.993806] rtc_cmos 00:02: RTC can wake from S4
[    0.993913] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.993993] rtc0: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    0.994076] cpuidle: using governor ladder
[    0.994126] cpuidle: using governor menu
[    0.994179] No iBFT detected.
[    0.994553] TCP cubic registered
[    0.994695] NET: Registered protocol family 10
[    0.995219] lo: Disabled Privacy Extensions
[    0.995549] Mobile IPv6
[    0.995596] NET: Registered protocol family 17
[    0.995796] registered taskstats version 1
[    0.996069] rtc_cmos 00:02: setting system clock to 2009-08-05 20:31:53 =
UTC (1249504313)
[    0.996200] Freeing unused kernel memory: 560k freed
[    0.996501] Write protecting the kernel read-only data: 3772k
[    1.016395] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    1.156730] FDC 0 is a post-1991 82077
[    1.162265] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.162663] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 10
[    1.162719] PCI: setting IRQ 10 as level-triggered
[    1.162725] ehci_hcd 0000:00:02.1: PCI INT B -> Link[LUB2] -> GSI 10 (le=
vel, low) -> IRQ 10
[    1.162831] ehci_hcd 0000:00:02.1: setting latency timer to 64
[    1.162834] ehci_hcd 0000:00:02.1: EHCI Host Controller
[    1.162994] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus =
number 1
[    1.163102] ehci_hcd 0000:00:02.1: debug port 1
[    1.163154] ehci_hcd 0000:00:02.1: cache line size of 64 is not supported
[    1.163163] ehci_hcd 0000:00:02.1: irq 10, io mem 0xdfbfec00
[    1.173003] Uniform Multi-Platform E-IDE driver
[    1.176347] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00
[    1.176421] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.176475] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.176544] usb usb1: Product: EHCI Host Controller
[    1.176595] usb usb1: Manufacturer: Linux 2.6.30-btrfsnewformat2 ehci_hcd
[    1.176650] usb usb1: SerialNumber: 0000:00:02.1
[    1.176763] usb usb1: configuration #1 chosen from 1 choice
[    1.176841] hub 1-0:1.0: USB hub found
[    1.176897] hub 1-0:1.0: 10 ports detected
[    1.177770] amd74xx 0000:00:06.0: UDMA133 controller
[    1.177824] amd74xx 0000:00:06.0: IDE controller (0x10de:0x03ec rev 0xa2)
[    1.177897] amd74xx 0000:00:06.0: IDE port disabled
[    1.177958] amd74xx 0000:00:06.0: BIOS didn't set cable bits correctly. =
Enabling workaround.
[    1.178031] amd74xx 0000:00:06.0: not 100% native mode: will probe irqs =
later
[    1.178089]     ide0: BM-DMA at 0xffa0-0xffa7
[    1.178143] Probing IDE interface ide0...
[    1.187362] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
[    1.187415] PCI: setting IRQ 11 as level-triggered
[    1.187420] firewire_ohci 0000:01:03.0: PCI INT A -> Link[LNKC] -> GSI 1=
1 (level, low) -> IRQ 11
[    1.197094] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.4-k4
[    1.197150] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    1.197565] ACPI: PCI Interrupt Link [LNEB] enabled at IRQ 10
[    1.197620] e1000e 0000:05:00.0: PCI INT A -> Link[LNEB] -> GSI 10 (leve=
l, low) -> IRQ 10
[    1.197699] e1000e 0000:05:00.0: setting latency timer to 64
[    1.197844]   alloc irq_desc for 27 on cpu 0 node 0
[    1.197846]   alloc kstat_irqs on cpu 0 node 0
[    1.197861] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[    1.269688] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.272069] firewire_ohci: Added fw-ohci device 0000:01:03.0, OHCI versi=
on 1.10
[    1.379166] 0000:05:00.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:15:17:=
24:85:7a
[    1.379241] 0000:05:00.0: eth0: Intel(R) PRO/1000 Network Connection
[    1.379370] 0000:05:00.0: eth0: MAC: 1, PHY: 4, PBA No: d50855-002
[    1.380991] udev: renamed network interface eth0 to eth1
[    1.464108] hda: WDC WD1600JB-00GVA0, ATA DISK drive
[    1.768085] firewire_core: created device fw0: GUID 0011d80000f46d61, S4=
00
[    2.136038] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    2.137259] hda: UDMA/100 mode selected
[    2.138601] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.163161] forcedeth: Reverse Engineered nForce ethernet driver. Versio=
n 0.64.
[    2.163517] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 11
[    2.163571] forcedeth 0000:00:07.0: PCI INT A -> Link[LMAC] -> GSI 11 (l=
evel, low) -> IRQ 11
[    2.163648] forcedeth 0000:00:07.0: setting latency timer to 64
[    2.684848] forcedeth 0000:00:07.0: ifname eth0, PHY OUI 0x1374 @ 1, add=
r 00:18:f3:aa:18:da
[    2.684923] forcedeth 0000:00:07.0: highdma pwrctl mgmt gbit lnktim msi =
desc-v3
[    2.685584] ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 11
[    2.685638] ohci_hcd 0000:00:02.0: PCI INT A -> Link[LUB0] -> GSI 11 (le=
vel, low) -> IRQ 11
[    2.685732] ohci_hcd 0000:00:02.0: setting latency timer to 64
[    2.685735] ohci_hcd 0000:00:02.0: OHCI Host Controller
[    2.685872] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus =
number 2
[    2.685957] ohci_hcd 0000:00:02.0: irq 11, io mem 0xdfbff000
[    2.742021] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    2.742081] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.742150] usb usb2: Product: OHCI Host Controller
[    2.742200] usb usb2: Manufacturer: Linux 2.6.30-btrfsnewformat2 ohci_hcd
[    2.742254] usb usb2: SerialNumber: 0000:00:02.0
[    2.742372] usb usb2: configuration #1 chosen from 1 choice
[    2.742460] hub 2-0:1.0: USB hub found
[    2.742517] hub 2-0:1.0: 10 ports detected
[    2.755144] SCSI subsystem initialized
[    2.770564] libata version 3.00 loaded.
[    2.774987] sata_nv 0000:00:08.0: version 3.5
[    2.775278] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 15
[    2.775334] PCI: setting IRQ 15 as level-triggered
[    2.775339] sata_nv 0000:00:08.0: PCI INT A -> Link[LSA0] -> GSI 15 (lev=
el, low) -> IRQ 15
[    2.775487] sata_nv 0000:00:08.0: setting latency timer to 64
[    2.775547] scsi0 : sata_nv
[    2.775726] scsi1 : sata_nv
[    2.775928] ata1: SATA max UDMA/133 cmd 0xb400 ctl 0xb080 bmdma 0xa880 i=
rq 15
[    2.775984] ata2: SATA max UDMA/133 cmd 0xb000 ctl 0xac00 bmdma 0xa888 i=
rq 15
[    2.776433] ACPI: PCI Interrupt Link [LSA1] enabled at IRQ 5
[    2.776485] PCI: setting IRQ 5 as level-triggered
[    2.776490] sata_nv 0000:00:08.1: PCI INT B -> Link[LSA1] -> GSI 5 (leve=
l, low) -> IRQ 5
[    2.776605] sata_nv 0000:00:08.1: setting latency timer to 64
[    2.776646] scsi2 : sata_nv
[    2.776757] scsi3 : sata_nv
[    2.776955] ata3: SATA max UDMA/133 cmd 0xa800 ctl 0xa480 bmdma 0xa000 i=
rq 5
[    2.777017] ata4: SATA max UDMA/133 cmd 0xa400 ctl 0xa080 bmdma 0xa008 i=
rq 5
[    3.252034] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.260115] ata1.00: FORCE: horkage modified (noncq)
[    3.261532] ata1.00: ATA-6: WDC WD1600JD-00GBB0, 02.05D02, max UDMA/100
[    3.261590] ata1.00: 312581808 sectors, multi 16: LBA48=20
[    3.261650] ata1.00: applying bridge limits
[    3.277461] ata1.00: configured for UDMA/100
[    3.277610] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JD-00G 02=
=2E0 PQ: 0 ANSI: 5
[    3.744031] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.752112] ata2.00: FORCE: horkage modified (noncq)
[    3.752164] ata2.00: ATAPI: TSSTcorp CDDVDW SH-S223F, SB03, max UDMA/100
[    3.768125] ata2.00: configured for UDMA/100
[    3.769647] scsi 1:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S223F  SB=
03 PQ: 0 ANSI: 5
[    4.095198] ide-gd driver 1.18
[    4.095280] hda: max request size: 512KiB
[    4.096622] hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=3D19=
457/255/63
[    4.098752] hda: cache flushes supported
[    4.098864]  hda:<4>Driver 'sd' needs updating - please use bus_type met=
hods
[    4.102638] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 =
GB/149 GiB)
[    4.102721] sd 0:0:0:0: [sda] Write Protect is off
[    4.102772] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.102789] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    4.102936]  sda: hda1 hda2 hda3
[    4.122929]  sda1 sda2 sda3
[    4.145949] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.148534] Driver 'sr' needs updating - please use bus_type methods
[    4.152122] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    4.152199] Uniform CD-ROM driver Revision: 3.20
[    4.152363] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    4.158571] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.158654] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    4.637337] md: raid1 personality registered for level 1
[    4.639381] xor: automatically using best checksumming function: generic=
_sse
[    4.655999]    generic_sse:  7437.000 MB/sec
[    4.656050] xor: using function: generic_sse (7437.000 MB/sec)
[    4.657235] async_tx: api initialized (async)
[    4.724003] raid6: int64x1   2213 MB/s
[    4.792003] raid6: int64x2   2859 MB/s
[    4.860003] raid6: int64x4   2230 MB/s
[    4.928023] raid6: int64x8   2016 MB/s
[    4.996012] raid6: sse2x1    1134 MB/s
[    5.064029] raid6: sse2x2    1923 MB/s
[    5.132015] raid6: sse2x4    2858 MB/s
[    5.132065] raid6: using algorithm sse2x4 (2858 MB/s)
[    5.134979] md: raid6 personality registered for level 6
[    5.135034] md: raid5 personality registered for level 5
[    5.135085] md: raid4 personality registered for level 4
[    5.249840] md: md0 stopped.
[    5.298348] md: bind<hda1>
[    5.298578] md: bind<sda1>
[    5.299828] raid1: raid set md0 active with 2 out of 2 mirrors
[    5.304534]  md0: unknown partition table
[    5.378608] md: md1 stopped.
[    5.380345] md: bind<hda2>
[    5.380565] md: bind<sda2>
[    5.380630] md: md1: raid array is not clean -- starting background reco=
nstruction
[    5.381935] raid1: raid set md1 active with 2 out of 2 mirrors
[    5.382983]  md1: unknown partition table
[    5.416229] device-mapper: uevent: version 1.0.3
[    5.416390] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised:=
 dm-devel@redhat.com
[    5.590278] PM: Starting manual resume from disk
[    5.605243] EXT3-fs: INFO: recovery required on readonly filesystem.
[    5.605300] EXT3-fs: write access will be enabled during recovery.
[    5.794093] md: resync of RAID array md1
[    5.794146] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[    5.794208] md: using maximum available idle IO bandwidth (but not more =
than 200000 KB/sec) for resync.
[    5.799994] md: using 128k window, over a total of 151364352 blocks.
[    5.800066] md: resuming resync of md1 from checkpoint.
[    6.368190] kjournald starting.  Commit interval 5 seconds
[    6.368257] EXT3-fs: recovery complete.
[    6.368639] EXT3-fs: mounted filesystem with ordered data mode.
[    7.686591] udev: starting version 141
[    7.896800] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    7.896877] ACPI: Power Button [PWRF]
[    7.897056] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
C:00/input/input3
[    7.897132] ACPI: Power Button [PWRB]
[    7.941158] processor ACPI_CPU:00: registered as cooling_device0
[    7.941420] processor ACPI_CPU:01: registered as cooling_device1
[    8.041187] parport_pc 00:06: reported by Plug and Play ACPI
[    8.041285] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    8.049590] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    8.133366] k8temp 0000:00:18.3: Temperature readouts might be wrong - c=
heck erratum #141
[    8.155529] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    8.168847] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    8.261457] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x600
[    8.261532] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x700
[    8.855831] Error: Driver 'pcspkr' is already registered, aborting...
[    8.953757] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 11
[    8.953816] HDA Intel 0000:00:05.0: PCI INT B -> Link[LAZA] -> GSI 11 (l=
evel, low) -> IRQ 11
[    8.954053] HDA Intel 0000:00:05.0: setting latency timer to 64
[    9.699697] hda_codec: Unknown model for AD1988, trying auto-probe from =
BIOS...
[    9.699868] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:05.=
0/input/input5
[   11.993293] Adding 3943948k swap on /dev/sda3.  Priority:-1 extents:1 ac=
ross:3943948k=20
[   12.021416] Adding 3943948k swap on /dev/hda3.  Priority:-2 extents:1 ac=
ross:3943948k=20
[   12.190096] EXT3 FS on dm-0, internal journal
[   12.290058] loop: module loaded
[   13.251123] kjournald starting.  Commit interval 5 seconds
[   13.251585] EXT3 FS on md0, internal journal
[   13.251663] EXT3-fs: mounted filesystem with ordered data mode.
[   13.373002] EXT4-fs: barriers enabled
[   13.387820] kjournald2 starting: pid 2331, dev dm-3:8, commit interval 5=
 seconds
[   13.388376] EXT4 FS on dm-3, internal journal on dm-3:8
[   13.388427] EXT4-fs: delayed allocation enabled
[   13.388477] EXT4-fs: file extents enabled
[   13.389783] EXT4-fs: mballoc enabled
[   13.389845] EXT4-fs: recovery complete.
[   13.389895] EXT4-fs: mounted filesystem dm-3 with ordered data mode
[   14.323829] Bridge firewalling registered
[   14.348389] device eth1 entered promiscuous mode
[   14.492398] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[   14.548079] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[   14.549806] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   17.798469] Loading iSCSI transport class v2.0-870.
[   17.833250] iscsi: registered transport (tcp)
[   17.903893] iscsi: registered transport (iser)
[   18.357761] RPC: Registered udp transport module.
[   18.357829] RPC: Registered tcp transport module.
[   18.424550] Slow work thread pool: Starting up
[   18.424954] Slow work thread pool: Ready
[   18.425053] FS-Cache: Loaded
[   18.465121] FS-Cache: Netfs 'nfs' registered for caching
[   18.494004] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   25.328011] br0: no IPv6 routers present
[   27.568010] torbr: no IPv6 routers present
[   81.471785] svc: failed to register lockdv1 RPC service (errno 97).
[   81.513577] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recov=
ery directory
[   81.516209] NFSD: starting 90-second grace period
[   81.558659] virbr1: starting userspace STP failed, starting kernel STP
[   81.714660] ip_tables: (C) 2000-2006 Netfilter Core Team
[   83.275876] tun: Universal TUN/TAP device driver, 1.6
[   83.275930] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   83.281044] device vnet0 entered promiscuous mode
[   83.284951] br0: port 2(vnet0) entering learning state
[   83.414681] br0: port 2(vnet0) entering disabled state
[   83.429354] device vnet0 left promiscuous mode
[   83.429408] br0: port 2(vnet0) entering disabled state
[   83.578399] lo: Disabled Privacy Extensions
[   91.890157] sata_mv 0000:04:04.0: version 1.28
[   91.890605] ACPI: PCI Interrupt Link [LNED] enabled at IRQ 11
[   91.890660] sata_mv 0000:04:04.0: PCI INT A -> Link[LNED] -> GSI 11 (lev=
el, low) -> IRQ 11
[   91.890951] sata_mv 0000:04:04.0: Gen-II 32 slots 8 ports SCSI mode IRQ =
via INTx
[   91.892338] scsi4 : sata_mv
[   91.892819] scsi5 : sata_mv
[   91.897506] scsi6 : sata_mv
[   91.899718] scsi7 : sata_mv
[   91.899860] scsi8 : sata_mv
[   91.899964] scsi9 : sata_mv
[   91.902742] scsi10 : sata_mv
[   91.907380] scsi11 : sata_mv
[   91.907501] ata5: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
2000 irq 11
[   91.907573] ata6: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
4000 irq 11
[   91.907645] ata7: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
6000 irq 11
[   91.907717] ata8: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
8000 irq 11
[   91.907788] ata9: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe3=
2000 irq 11
[   91.907861] ata10: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
34000 irq 11
[   91.907932] ata11: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
36000 irq 11
[   91.908031] ata12: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
38000 irq 11
[   92.388035] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   92.397243] ata5.00: FORCE: horkage modified (noncq)
[   92.420054] ata5.00: ATA-8: WDC WD5000AAKS-00A7B0, 01.03B01, max UDMA/133
[   92.420110] ata5.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[   92.437059] ata5.00: configured for UDMA/133
[   92.437212] scsi 4:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 01=
=2E0 PQ: 0 ANSI: 5
[   92.437413] sd 4:0:0:0: Attached scsi generic sg2 type 0
[   92.437539] sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[   92.437620] sd 4:0:0:0: [sdb] Write Protect is off
[   92.437671] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   92.437690] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   92.437861]  sdb:<7>virbr1: no IPv6 routers present
[   92.912033] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   92.928053] ata6.00: FORCE: horkage modified (noncq)
[   92.952048] ata6.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[   92.952104] ata6.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[   92.984062] ata6.00: configured for UDMA/133
[   92.984193] scsi 5:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[   92.984403] sd 5:0:0:0: Attached scsi generic sg3 type 0
[   92.984530] sd 5:0:0:0: [sdc] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[   92.984612] sd 5:0:0:0: [sdc] Write Protect is off
[   92.984663] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   92.984683] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   92.984843]  sdc:<6>ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[   93.476053] ata7.00: FORCE: horkage modified (noncq)
[   93.485045] ata7.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[   93.485101] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[   93.516062] ata7.00: configured for UDMA/133
[   93.516212] scsi 6:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[   93.516415] sd 6:0:0:0: Attached scsi generic sg4 type 0
[   93.516539] sd 6:0:0:0: [sdd] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[   93.516623] sd 6:0:0:0: [sdd] Write Protect is off
[   93.516676] sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   93.516695] sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   93.516858]  sdd:<6>ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[   94.008051] ata8.00: FORCE: horkage modified (noncq)
[   94.040047] ata8.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[   94.040103] ata8.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[   94.072062] ata8.00: configured for UDMA/133
[   94.072194] scsi 7:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[   94.072420] sd 7:0:0:0: Attached scsi generic sg5 type 0
[   94.072562] sd 7:0:0:0: [sde] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[   94.072658] sd 7:0:0:0: [sde] Write Protect is off
[   94.072720] sd 7:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   94.072739] sd 7:0:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   94.072934]  sde:<6>ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[   94.564051] ata9.00: FORCE: horkage modified (noncq)
[   94.564106] ata9.00: ATA-7: WDC WD5000AAKS-65TMA0, 12.01C01, max UDMA/133
[   94.564161] ata9.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
[   94.588079] ata9.00: configured for UDMA/133
[   94.588212] scsi 8:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-6 12=
=2E0 PQ: 0 ANSI: 5
[   94.588448] sd 8:0:0:0: Attached scsi generic sg6 type 0
[   94.588479] sd 8:0:0:0: [sdf] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[   94.588493] sd 8:0:0:0: [sdf] Write Protect is off
[   94.588496] sd 8:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   94.588515] sd 8:0:0:0: [sdf] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   94.588617]  sdf:<6>ata10: SATA link down (SStatus 0 SControl 300)
[   95.228028] ata11: SATA link down (SStatus 0 SControl 300)
[   95.548034] ata12: SATA link down (SStatus 0 SControl 300)
[  106.021701]  sdc1
[  106.021841]  sdb1
[  106.022058] sd 5:0:0:0: [sdc] Attached SCSI disk
[  106.022077] sd 4:0:0:0: [sdb] Attached SCSI disk
[  106.022145]  sde1
[  106.022298] sd 7:0:0:0: [sde] Attached SCSI disk
[  106.022347]  sdf1
[  106.022447]  sdd1
[  106.022619] sd 8:0:0:0: [sdf] Attached SCSI disk
[  106.022642] sd 6:0:0:0: [sdd] Attached SCSI disk
[  167.833988] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  167.834069] ata5.00: cmd c8/00:20:00:00:00/00:00:00:00:00/e0 tag 0 dma 1=
6384 in
[  167.834070]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  167.834078] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  167.834086] ata9.00: cmd c8/00:20:00:00:00/00:00:00:00:00/e0 tag 0 dma 1=
6384 in
[  167.834087]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  167.834090] ata9.00: status: { DRDY }
[  167.834095] ata9: hard resetting link
[  167.834492] ata5.00: status: { DRDY }
[  167.834545] ata5: hard resetting link
[  167.864494] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  167.864555] ata7.00: cmd c8/00:20:00:00:00/00:00:00:00:00/e0 tag 0 dma 1=
6384 in
[  167.864556]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  167.864563] ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  167.864569] ata6.00: cmd 25/00:08:bf:4b:38/00:00:3a:00:00/e0 tag 0 dma 4=
096 in
[  167.864570]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  167.864572] ata6.00: status: { DRDY }
[  167.864575] ata6: hard resetting link
[  167.864976] ata7.00: status: { DRDY }
[  167.879994] ata7: hard resetting link
[  167.880076] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  167.880138] ata8.00: cmd c8/00:20:00:00:00/00:00:00:00:00/e0 tag 0 dma 1=
6384 in
[  167.880139]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  167.880276] ata8.00: status: { DRDY }
[  167.880325] ata8: hard resetting link
[  168.344032] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  168.344218] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  168.348039] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  168.353026] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  168.360085] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  168.388092] ata5.00: configured for UDMA/133
[  168.388154] ata5: EH complete
[  168.392387] ata9.00: configured for UDMA/133
[  168.392444] ata9: EH complete
[  168.408224] ata6.00: configured for UDMA/133
[  168.408283] ata6: EH complete
[  168.412163] ata7.00: configured for UDMA/133
[  168.412217] ata7: EH complete
[  168.440063] ata8.00: configured for UDMA/133
[  168.440127] ata8: EH complete
[  223.819032] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  223.819096] ata5.00: cmd 25/00:06:c1:4b:38/00:00:3a:00:00/e0 tag 0 dma 3=
072 in
[  223.819097]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  223.819236] ata5.00: status: { DRDY }
[  223.819287] ata5: hard resetting link
[  223.849720] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  223.849783] ata7.00: cmd 25/00:06:c1:4b:38/00:00:3a:00:00/e0 tag 0 dma 3=
072 in
[  223.849785]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  223.849811] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  223.849820] ata9.00: cmd 25/00:06:c1:4b:38/00:00:3a:00:00/e0 tag 0 dma 3=
072 in
[  223.849821]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  223.849823] ata9.00: status: { DRDY }
[  223.849828] ata9: hard resetting link
[  223.850206] ata7.00: status: { DRDY }
[  223.850256] ata7: hard resetting link
[  223.865327] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  223.865389] ata8.00: cmd 25/00:06:c1:4b:38/00:00:3a:00:00/e0 tag 0 dma 3=
072 in
[  223.865390]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  223.865529] ata8.00: status: { DRDY }
[  223.865579] ata8: hard resetting link
[  224.316031] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  224.325380] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  224.333571] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  224.340246] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  224.349114] ata5.00: configured for UDMA/133
[  224.349186] ata5: EH complete
[  224.372065] ata9.00: configured for UDMA/133
[  224.372124] ata9: EH complete
[  224.388089] ata7.00: configured for UDMA/133
[  224.388156] ata7: EH complete
[  224.420059] ata8.00: configured for UDMA/133
[  224.420145] ata8: EH complete
[  254.819013] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  254.819107] ata5.00: cmd 25/00:06:c1:4b:38/00:00:3a:00:00/e0 tag 0 dma 3=
072 in
[  254.819108]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  254.819277] ata5.00: status: { DRDY }
[  254.819338] ata5: hard resetting link
[  254.849782] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  254.849844] ata7.00: cmd 25/00:06:c1:4b:38/00:00:3a:00:00/e0 tag 0 dma 3=
072 in
[  254.849845]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  254.849862] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  254.849870] ata8.00: cmd 25/00:06:c1:4b:38/00:00:3a:00:00/e0 tag 0 dma 3=
072 in
[  254.849871]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  254.849874] ata8.00: status: { DRDY }
[  254.849879] ata8: hard resetting link
[  254.850263] ata7.00: status: { DRDY }
[  254.850313] ata7: hard resetting link
[  254.865370] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  254.865431] ata9.00: cmd 25/00:06:c1:4b:38/00:00:3a:00:00/e0 tag 0 dma 3=
072 in
[  254.865432]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  254.865570] ata9.00: status: { DRDY }
[  254.865619] ata9: hard resetting link
[  255.316032] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  255.324366] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  255.332034] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  255.340247] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  255.356110] ata5.00: configured for UDMA/133
[  255.356211] ata5: EH complete
[  255.380106] ata7.00: configured for UDMA/133
[  255.380116] ata9.00: configured for UDMA/133
[  255.380124] ata9: EH complete
[  255.380262] ata7: EH complete
[  255.412061] ata8.00: configured for UDMA/133
[  255.412115] ata8: EH complete
[  287.819025] ata7: limiting SATA link speed to 1.5 Gbps
[  287.819093] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  287.819164] ata7.00: cmd c8/00:90:20:00:00/00:00:00:00:00/e0 tag 0 dma 7=
3728 in
[  287.819165]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  287.819335] ata7.00: status: { DRDY }
[  287.819397] ata7: hard resetting link
[  288.292033] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  288.364062] ata7.00: configured for UDMA/133
[  288.364124] ata7: EH complete
[  318.819016] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  318.819097] ata7.00: cmd c8/00:90:20:00:00/00:00:00:00:00/e0 tag 0 dma 7=
3728 in
[  318.819099]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  318.819238] ata7.00: status: { DRDY }
[  318.819289] ata7: hard resetting link
[  319.292030] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  319.340123] ata7.00: configured for UDMA/133
[  319.340182] ata7: EH complete
[  351.831002] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  351.831080] ata7.00: cmd 25/00:c0:b0:00:00/00:01:00:00:00/e0 tag 0 dma 2=
29376 in
[  351.831081]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  351.831218] ata7.00: status: { DRDY }
[  351.831269] ata7: hard resetting link
[  352.304031] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  352.376061] ata7.00: configured for UDMA/133
[  352.376129] ata7: EH complete
[  382.831066] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  382.831130] ata7.00: cmd 25/00:c0:b0:00:00/00:01:00:00:00/e0 tag 0 dma 2=
29376 in
[  382.831131]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  382.831269] ata7.00: status: { DRDY }
[  382.831321] ata7: hard resetting link
[  383.304029] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  383.352106] ata7.00: configured for UDMA/133
[  383.352219] ata7: EH complete

--4ickEXl+ukcSQ/3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sata_mv-dmesg.nomsi.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-btrfsnewformat2 (2.6.30) (root@slimer) =
(gcc version 4.3.3 (Debian 4.3.3-15) ) #3 SMP Mon Aug 3 18:09:53 GMT 2009
[    0.000000] Command line: root=3D/dev/mapper/slimerroot-root ro pci=3Dno=
msi
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
[    0.000000] Kernel command line: root=3D/dev/mapper/slimerroot-root ro p=
ci=3Dnomsi
[    0.000000] Initializing CPU#0
[    0.000000] Experimental hierarchical RCU implementation.
[    0.000000] Experimental hierarchical RCU init done.
[    0.000000] NR_IRQS:4352 nr_irqs:424
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Fast TSC calibration failed
[    0.000000] TSC: PIT calibration matches PMTIMER. 1 loops
[    0.000000] Detected 2410.938 MHz processor.
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
er frequency.. 4821.87 BogoMIPS (lpj=3D9643752)
[    0.004000] Security Framework initialized
[    0.004000] SELinux:  Disabled at boot.
[    0.004000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.006483] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.009167] Mount-cache hash table entries: 256
[    0.009387] Initializing cgroup subsys ns
[    0.009438] Initializing cgroup subsys cpuacct
[    0.009489] Initializing cgroup subsys devices
[    0.009539] Initializing cgroup subsys freezer
[    0.009589] Initializing cgroup subsys net_cls
[    0.009669] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.009726] CPU: L2 Cache: 512K (64 bytes/line)
[    0.009776] CPU 0/0x0 -> Node 0
[    0.009823] tseg: 0000000000
[    0.009834] CPU: Physical Processor ID: 0
[    0.009885] CPU: Processor Core ID: 0
[    0.009940] using C1E aware idle routine
[    0.010604] ACPI: Core revision 20090320
[    0.017452] Setting APIC routing to flat
[    0.017950] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D0 apic2=3D-1 pin2=3D=
-1
[    0.024001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.024001] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.024001] ..... (found apic 0 pin 0) ...
[    0.065543] ....... works.
[    0.065589] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.068001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 4821.87 Bog=
oMIPS (lpj=3D9643745)
[    0.004000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.004000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.004000] CPU 1/0x1 -> Node 0
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x701060007=
0106
[    0.152337] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.152869] Brought up 2 CPUs
[    0.152916] Total of 2 processors activated (9643.74 BogoMIPS).
[    0.153071] CPU0 attaching sched-domain:
[    0.153074]  domain 0: span 0-1 level MC
[    0.153076]   groups: 0 1
[    0.153081] CPU1 attaching sched-domain:
[    0.153083]  domain 0: span 0-1 level MC
[    0.153085]   groups: 1 0
[    0.153141] net_namespace: 1936 bytes
[    0.153141] Booting paravirtualized kernel on bare hardware
[    0.153141] regulator: core version 0.5
[    0.153141] NET: Registered protocol family 16
[    0.153141] node 0 link 0: io port [1000, ffffff]
[    0.153141] TOM: 00000000d0000000 aka 3328M
[    0.153141] node 0 link 0: mmio [e0000000, efffffff]
[    0.153141] node 0 link 0: mmio [a0000, bffff]
[    0.153141] node 0 link 0: mmio [d0000000, fe0bffff]
[    0.153141] TOM2: 00000001b0000000 aka 6912M
[    0.153141] bus: [00,ff] on node 0 link 0
[    0.153141] bus: 00 index 0 io port: [0, ffff]
[    0.153141] bus: 00 index 1 mmio: [d0000000, ffffffff]
[    0.153141] bus: 00 index 2 mmio: [a0000, bffff]
[    0.153141] bus: 00 index 3 mmio: [1b0000000, fcffffffff]
[    0.153141] ACPI: bus type pci registered
[    0.153141] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.153141] PCI: Not using MMCONFIG.
[    0.153141] PCI: Using configuration type 1 for base access
[    0.156080] bio: create slab <bio-0> at 0
[    0.160594] ACPI: EC: Look up EC in DSDT
[    0.172346] ACPI: Interpreter enabled
[    0.172397] ACPI: (supports S0 S1 S3 S4 S5)
[    0.172600] ACPI: Using IOAPIC for interrupt routing
[    0.172703] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.179187] PCI: MCFG area at e0000000 reserved in ACPI motherboard reso=
urces
[    0.189553] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.200114] ACPI Warning (tbutils-0246): Incorrect checksum in table [OE=
MB] - E5, should be D8 [20090320]
[    0.200310] ACPI: No dock devices found.
[    0.200424] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.200508] pci 0000:00:01.1: reg 10 io port: [0xbc00-0xbc3f]
[    0.200508] pci 0000:00:01.1: reg 20 io port: [0x600-0x63f]
[    0.200508] pci 0000:00:01.1: reg 24 io port: [0x700-0x73f]
[    0.200508] pci 0000:00:01.1: PME# supported from D3hot D3cold
[    0.200508] pci 0000:00:01.1: PME# disabled
[    0.200508] pci 0000:00:02.0: reg 10 32bit mmio: [0xdfbff000-0xdfbfffff]
[    0.200508] pci 0000:00:02.0: supports D1 D2
[    0.200508] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.200508] pci 0000:00:02.0: PME# disabled
[    0.200508] pci 0000:00:02.1: reg 10 32bit mmio: [0xdfbfec00-0xdfbfecff]
[    0.200531] pci 0000:00:02.1: supports D1 D2
[    0.200533] pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.200588] pci 0000:00:02.1: PME# disabled
[    0.200691] pci 0000:00:05.0: reg 10 32bit mmio: [0xdfbf8000-0xdfbfbfff]
[    0.200714] pci 0000:00:05.0: PME# supported from D3hot D3cold
[    0.200768] pci 0000:00:05.0: PME# disabled
[    0.200848] pci 0000:00:06.0: reg 20 io port: [0xffa0-0xffaf]
[    0.200881] pci 0000:00:07.0: reg 10 32bit mmio: [0xdfbfd000-0xdfbfdfff]
[    0.200885] pci 0000:00:07.0: reg 14 io port: [0xb480-0xb487]
[    0.200904] pci 0000:00:07.0: supports D1 D2
[    0.200906] pci 0000:00:07.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.200962] pci 0000:00:07.0: PME# disabled
[    0.201031] pci 0000:00:08.0: reg 10 io port: [0xb400-0xb407]
[    0.201034] pci 0000:00:08.0: reg 14 io port: [0xb080-0xb083]
[    0.201037] pci 0000:00:08.0: reg 18 io port: [0xb000-0xb007]
[    0.201041] pci 0000:00:08.0: reg 1c io port: [0xac00-0xac03]
[    0.201044] pci 0000:00:08.0: reg 20 io port: [0xa880-0xa88f]
[    0.201048] pci 0000:00:08.0: reg 24 32bit mmio: [0xdfbfc000-0xdfbfcfff]
[    0.201076] pci 0000:00:08.1: reg 10 io port: [0xa800-0xa807]
[    0.201079] pci 0000:00:08.1: reg 14 io port: [0xa480-0xa483]
[    0.201082] pci 0000:00:08.1: reg 18 io port: [0xa400-0xa407]
[    0.201086] pci 0000:00:08.1: reg 1c io port: [0xa080-0xa083]
[    0.201089] pci 0000:00:08.1: reg 20 io port: [0xa000-0xa00f]
[    0.201092] pci 0000:00:08.1: reg 24 32bit mmio: [0xdfbf3000-0xdfbf3fff]
[    0.201134] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.201188] pci 0000:00:09.0: PME# disabled
[    0.201263] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.201318] pci 0000:00:0b.0: PME# disabled
[    0.201392] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.201446] pci 0000:00:0c.0: PME# disabled
[    0.201589] pci 0000:01:03.0: reg 10 32bit mmio: [0xdfcff800-0xdfcfffff]
[    0.201595] pci 0000:01:03.0: reg 14 io port: [0xcc00-0xcc7f]
[    0.201624] pci 0000:01:03.0: supports D2
[    0.201626] pci 0000:01:03.0: PME# supported from D2 D3hot D3cold
[    0.201680] pci 0000:01:03.0: PME# disabled
[    0.201756] pci 0000:01:0a.0: reg 10 32bit mmio: [0xdfc00000-0xdfc7ffff]
[    0.201762] pci 0000:01:0a.0: reg 14 32bit mmio: [0xd0000000-0xd7ffffff]
[    0.201779] pci 0000:01:0a.0: reg 30 32bit mmio: [0xdfce0000-0xdfceffff]
[    0.201792] pci 0000:01:0a.0: supports D1 D2
[    0.201814] pci 0000:00:04.0: transparent bridge
[    0.201868] pci 0000:00:04.0: bridge io port: [0xc000-0xcfff]
[    0.201871] pci 0000:00:04.0: bridge 32bit mmio: [0xdfc00000-0xdfcfffff]
[    0.201874] pci 0000:00:04.0: bridge 32bit mmio pref: [0xd0000000-0xd7ff=
ffff]
[    0.201908] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.201964] pci 0000:02:00.0: PME# disabled
[    0.202050] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
[    0.202104] pci 0000:02:00.2: PME# disabled
[    0.202189] pci 0000:00:09.0: bridge io port: [0xd000-0xdfff]
[    0.202192] pci 0000:00:09.0: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.202267] pci 0000:04:04.0: reg 10 64bit mmio: [0xdfe00000-0xdfefffff]
[    0.202273] pci 0000:04:04.0: reg 18 io port: [0xd800-0xd8ff]
[    0.202335] pci 0000:02:00.2: bridge io port: [0xd000-0xdfff]
[    0.202338] pci 0000:02:00.2: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.202395] pci 0000:05:00.0: reg 10 32bit mmio: [0xdffe0000-0xdfffffff]
[    0.202404] pci 0000:05:00.0: reg 14 32bit mmio: [0xdffc0000-0xdffdffff]
[    0.202412] pci 0000:05:00.0: reg 18 io port: [0xec00-0xec1f]
[    0.202440] pci 0000:05:00.0: reg 30 32bit mmio: [0xdffa0000-0xdffbffff]
[    0.202477] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.202536] pci 0000:05:00.0: PME# disabled
[    0.202631] pci 0000:00:0b.0: bridge io port: [0xe000-0xefff]
[    0.202633] pci 0000:00:0b.0: bridge 32bit mmio: [0xdff00000-0xdfffffff]
[    0.202677] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.202843] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.202957] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.203021] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR11._PRT]
[    0.203085] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR12._PRT]
[    0.212215] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *0, disab=
led.
[    0.212702] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *0, disab=
led.
[    0.213189] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *11
[    0.213643] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disab=
led.
[    0.214128] ACPI: PCI Interrupt Link [LNEA] (IRQs 16 17 18 19) *0, disab=
led.
[    0.214609] ACPI: PCI Interrupt Link [LNEB] (IRQs 16 17 18 19) *10
[    0.215299] ACPI: PCI Interrupt Link [LNEC] (IRQs 16 17 18 19) *0, disab=
led.
[    0.215782] ACPI: PCI Interrupt Link [LNED] (IRQs 16 17 18 19) *11
[    0.216436] ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *11
[    0.216891] ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *10
[    0.217344] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *11
[    0.217798] ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *11
[    0.218254] ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0, disab=
led.
[    0.218735] ACPI: PCI Interrupt Link [LMC9] (IRQs 20 21 22 23) *0, disab=
led.
[    0.219215] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *10
[    0.219668] ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *0, disab=
led.
[    0.220188] ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *15
[    0.220641] ACPI: PCI Interrupt Link [LSA1] (IRQs 20 21 22 23) *5
[    0.221134] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disab=
led.
[    0.221449] usbcore: registered new interface driver usbfs
[    0.221449] usbcore: registered new interface driver hub
[    0.221449] usbcore: registered new device driver usb
[    0.221449] PCI: Using ACPI for IRQ routing
[    0.232117] PCI-DMA: Disabling AGP.
[    0.232239] PCI-DMA: aperture base @ 20000000 size 65536 KB
[    0.232239] PCI-DMA: using GART IOMMU.
[    0.232239] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    0.232651] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.232813] hpet0: 3 comparators, 32-bit 25.000000 MHz counter
[    0.240011] Switched to high resolution mode on CPU 0
[    0.240349] Switched to high resolution mode on CPU 1
[    0.244012] pnp: PnP ACPI init
[    0.244079] ACPI: bus type pnp registered
[    0.251755] pnp: PnP ACPI: found 15 devices
[    0.251806] ACPI: ACPI bus type pnp unregistered
[    0.251866] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[    0.251920] system 00:07: ioport range 0x800-0x80f has been reserved
[    0.251974] system 00:07: ioport range 0x500-0x57f has been reserved
[    0.252044] system 00:07: ioport range 0x580-0x5ff has been reserved
[    0.252100] system 00:07: ioport range 0x800-0x87f could not be reserved
[    0.252154] system 00:07: ioport range 0x880-0x8ff has been reserved
[    0.252208] system 00:07: ioport range 0xd00-0xd7f has been reserved
[    0.252262] system 00:07: ioport range 0xd80-0xdff has been reserved
[    0.252320] system 00:07: ioport range 0x2000-0x207f has been reserved
[    0.252374] system 00:07: ioport range 0x2080-0x20ff has been reserved
[    0.252429] system 00:07: iomem range 0xfefe0000-0xfefe01ff has been res=
erved
[    0.252485] system 00:07: iomem range 0xfefe1000-0xfefe1fff has been res=
erved
[    0.252543] system 00:07: iomem range 0xfee01000-0xfeefffff has been res=
erved
[    0.252598] system 00:07: iomem range 0xffb80000-0xffffffff has been res=
erved
[    0.252656] system 00:09: iomem range 0xfec00000-0xfec00fff has been res=
erved
[    0.252712] system 00:09: iomem range 0xfee00000-0xfee00fff has been res=
erved
[    0.252771] system 00:0b: ioport range 0x230-0x23f has been reserved
[    0.252828] system 00:0b: ioport range 0x290-0x29f has been reserved
[    0.252882] system 00:0b: ioport range 0xa00-0xa0f has been reserved
[    0.252935] system 00:0b: ioport range 0xa10-0xa1f has been reserved
[    0.252991] system 00:0d: iomem range 0xe0000000-0xefffffff has been res=
erved
[    0.253054] system 00:0e: iomem range 0x0-0x9ffff could not be reserved
[    0.253113] system 00:0e: iomem range 0xc0000-0xcffff has been reserved
[    0.253167] system 00:0e: iomem range 0xe0000-0xfffff could not be reser=
ved
[    0.253222] system 00:0e: iomem range 0x100000-0xcfffffff could not be r=
eserved
[    0.253292] system 00:0e: iomem range 0xff780000-0xffffffff could not be=
 reserved
[    0.258385] pci 0000:00:04.0: PCI bridge, secondary bus 0000:01
[    0.258439] pci 0000:00:04.0:   IO window: 0xc000-0xcfff
[    0.258492] pci 0000:00:04.0:   MEM window: 0xdfc00000-0xdfcfffff
[    0.258546] pci 0000:00:04.0:   PREFETCH window: 0x000000d0000000-0x0000=
00d7ffffff
[    0.258620] pci 0000:02:00.0: PCI bridge, secondary bus 0000:03
[    0.258673] pci 0000:02:00.0:   IO window: disabled
[    0.258725] pci 0000:02:00.0:   MEM window: disabled
[    0.258776] pci 0000:02:00.0:   PREFETCH window: disabled
[    0.258830] pci 0000:02:00.2: PCI bridge, secondary bus 0000:04
[    0.258886] pci 0000:02:00.2:   IO window: 0xd000-0xdfff
[    0.258940] pci 0000:02:00.2:   MEM window: 0xdfd00000-0xdfefffff
[    0.258994] pci 0000:02:00.2:   PREFETCH window: disabled
[    0.259050] pci 0000:00:09.0: PCI bridge, secondary bus 0000:02
[    0.259102] pci 0000:00:09.0:   IO window: 0xd000-0xdfff
[    0.259154] pci 0000:00:09.0:   MEM window: 0xdfd00000-0xdfefffff
[    0.259208] pci 0000:00:09.0:   PREFETCH window: disabled
[    0.259260] pci 0000:00:0b.0: PCI bridge, secondary bus 0000:05
[    0.259313] pci 0000:00:0b.0:   IO window: 0xe000-0xefff
[    0.259366] pci 0000:00:0b.0:   MEM window: 0xdff00000-0xdfffffff
[    0.259419] pci 0000:00:0b.0:   PREFETCH window: disabled
[    0.259472] pci 0000:00:0c.0: PCI bridge, secondary bus 0000:06
[    0.259524] pci 0000:00:0c.0:   IO window: disabled
[    0.259575] pci 0000:00:0c.0:   MEM window: disabled
[    0.259626] pci 0000:00:0c.0:   PREFETCH window: disabled
[    0.259685] pci 0000:00:04.0: setting latency timer to 64
[    0.259690] pci 0000:00:09.0: setting latency timer to 64
[    0.259695] pci 0000:02:00.0: setting latency timer to 64
[    0.259700] pci 0000:02:00.2: setting latency timer to 64
[    0.259704] pci 0000:00:0b.0: setting latency timer to 64
[    0.259708] pci 0000:00:0c.0: setting latency timer to 64
[    0.259711] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.259713] pci_bus 0000:00: resource 1 mem: [0x000000-0xfffffffffffffff=
f]
[    0.259716] pci_bus 0000:01: resource 0 io:  [0xc000-0xcfff]
[    0.259718] pci_bus 0000:01: resource 1 mem: [0xdfc00000-0xdfcfffff]
[    0.259720] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xd7ffffff]
[    0.259723] pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
[    0.259725] pci_bus 0000:01: resource 4 mem: [0x000000-0xfffffffffffffff=
f]
[    0.259728] pci_bus 0000:02: resource 0 io:  [0xd000-0xdfff]
[    0.259730] pci_bus 0000:02: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.259732] pci_bus 0000:04: resource 0 io:  [0xd000-0xdfff]
[    0.259734] pci_bus 0000:04: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.259737] pci_bus 0000:05: resource 0 io:  [0xe000-0xefff]
[    0.259739] pci_bus 0000:05: resource 1 mem: [0xdff00000-0xdfffffff]
[    0.259837] NET: Registered protocol family 2
[    0.288273] IP route cache hash table entries: 262144 (order: 9, 2097152=
 bytes)
[    0.290833] TCP established hash table entries: 524288 (order: 11, 83886=
08 bytes)
[    0.296071] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.296755] TCP: Hash tables configured (established 524288 bind 65536)
[    0.296811] TCP reno registered
[    0.304126] NET: Registered protocol family 1
[    0.304232] Trying to unpack rootfs image as initramfs...
[    0.499642] Freeing initrd memory: 8817k freed
[    0.506465] audit: initializing netlink socket (disabled)
[    0.506531] type=3D2000 audit(1249502224.504:1): initialized
[    0.507087] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.507302] VFS: Disk quotas dquot_6.5.2
[    0.507391] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.507506] msgmni has been set to 11973
[    0.507754] alg: No test for stdrng (krng)
[    0.507873] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    0.507943] io scheduler noop registered
[    0.507992] io scheduler anticipatory registered
[    0.508056] io scheduler deadline registered
[    0.508135] io scheduler cfq registered (default)
[    1.032401] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.032496] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.032600] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.032703] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.032805] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.032914] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.033029] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.033144] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.033204] pci 0000:01:0a.0: Boot video device
[    1.033367] pcieport-driver 0000:00:09.0: setting latency timer to 64
[    1.033477] pcieport-driver 0000:00:0b.0: setting latency timer to 64
[    1.033582] pcieport-driver 0000:00:0c.0: setting latency timer to 64
[    1.037493] Linux agpgart interface v0.103
[    1.037545] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.037722] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.038209] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.039996] brd: module loaded
[    1.040146] input: Macintosh mouse button emulation as /devices/virtual/=
input/input0
[    1.040420] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.040473] PNP: PS/2 appears to have AUX port disabled, if this is inco=
rrect please boot with i8042.nopnp
[    1.040679] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.040888] mice: PS/2 mouse device common for all mice
[    1.041008] rtc_cmos 00:02: RTC can wake from S4
[    1.041151] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    1.041242] rtc0: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    1.041327] cpuidle: using governor ladder
[    1.041376] cpuidle: using governor menu
[    1.041428] No iBFT detected.
[    1.041812] TCP cubic registered
[    1.041952] NET: Registered protocol family 10
[    1.042476] lo: Disabled Privacy Extensions
[    1.042804] Mobile IPv6
[    1.042851] NET: Registered protocol family 17
[    1.043056] registered taskstats version 1
[    1.043298] rtc_cmos 00:02: setting system clock to 2009-08-05 19:57:05 =
UTC (1249502225)
[    1.043429] Freeing unused kernel memory: 560k freed
[    1.048871] Write protecting the kernel read-only data: 3772k
[    1.058753] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    1.204664] FDC 0 is a post-1991 82077
[    1.209557] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.210005] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 23
[    1.210060]   alloc irq_desc for 23 on cpu 0 node 0
[    1.210062]   alloc kstat_irqs on cpu 0 node 0
[    1.210072] ehci_hcd 0000:00:02.1: PCI INT B -> Link[LUB2] -> GSI 23 (le=
vel, low) -> IRQ 23
[    1.210176] ehci_hcd 0000:00:02.1: setting latency timer to 64
[    1.210179] ehci_hcd 0000:00:02.1: EHCI Host Controller
[    1.210320] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus =
number 1
[    1.210424] ehci_hcd 0000:00:02.1: debug port 1
[    1.210476] ehci_hcd 0000:00:02.1: cache line size of 64 is not supported
[    1.210496] ehci_hcd 0000:00:02.1: irq 23, io mem 0xdfbfec00
[    1.214519] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 19
[    1.214578]   alloc irq_desc for 19 on cpu 0 node 0
[    1.214580]   alloc kstat_irqs on cpu 0 node 0
[    1.214591] firewire_ohci 0000:01:03.0: PCI INT A -> Link[LNKC] -> GSI 1=
9 (level, low) -> IRQ 19
[    1.224067] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00
[    1.224151] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.224205] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.224276] usb usb1: Product: EHCI Host Controller
[    1.224326] usb usb1: Manufacturer: Linux 2.6.30-btrfsnewformat2 ehci_hcd
[    1.224380] usb usb1: SerialNumber: 0000:00:02.1
[    1.224503] usb usb1: configuration #1 chosen from 1 choice
[    1.224582] hub 1-0:1.0: USB hub found
[    1.224638] hub 1-0:1.0: 10 ports detected
[    1.227279] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.227724] ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 22
[    1.227778]   alloc irq_desc for 22 on cpu 0 node 0
[    1.227780]   alloc kstat_irqs on cpu 0 node 0
[    1.227790] ohci_hcd 0000:00:02.0: PCI INT A -> Link[LUB0] -> GSI 22 (le=
vel, low) -> IRQ 22
[    1.227894] ohci_hcd 0000:00:02.0: setting latency timer to 64
[    1.227896] ohci_hcd 0000:00:02.0: OHCI Host Controller
[    1.228089] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus =
number 2
[    1.228187] ohci_hcd 0000:00:02.0: irq 22, io mem 0xdfbff000
[    1.238623] Uniform Multi-Platform E-IDE driver
[    1.268619] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.4-k4
[    1.268675] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    1.269178] ACPI: PCI Interrupt Link [LNEB] enabled at IRQ 18
[    1.269236]   alloc irq_desc for 18 on cpu 0 node 0
[    1.269239]   alloc kstat_irqs on cpu 0 node 0
[    1.269249] e1000e 0000:05:00.0: PCI INT A -> Link[LNEB] -> GSI 18 (leve=
l, low) -> IRQ 18
[    1.269332] e1000e 0000:05:00.0: setting latency timer to 64
[    1.269449] 0000:05:00.0: 0000:05:00.0: Failed to initialize MSI interru=
pts.  Falling back to legacy interrupts.
[    1.286084] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.286142] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.286214] usb usb2: Product: OHCI Host Controller
[    1.286265] usb usb2: Manufacturer: Linux 2.6.30-btrfsnewformat2 ohci_hcd
[    1.286319] usb usb2: SerialNumber: 0000:00:02.0
[    1.286442] usb usb2: configuration #1 chosen from 1 choice
[    1.286525] hub 2-0:1.0: USB hub found
[    1.286582] hub 2-0:1.0: 10 ports detected
[    1.287541] forcedeth: Reverse Engineered nForce ethernet driver. Versio=
n 0.64.
[    1.287958] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 21
[    1.288059]   alloc irq_desc for 21 on cpu 0 node 0
[    1.288061]   alloc kstat_irqs on cpu 0 node 0
[    1.288072] forcedeth 0000:00:07.0: PCI INT A -> Link[LMAC] -> GSI 21 (l=
evel, low) -> IRQ 21
[    1.288146] forcedeth 0000:00:07.0: setting latency timer to 64
[    1.300062] firewire_ohci: Added fw-ohci device 0000:01:03.0, OHCI versi=
on 1.10
[    1.451166] 0000:05:00.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:15:17:=
24:85:7a
[    1.451239] 0000:05:00.0: eth0: Intel(R) PRO/1000 Network Connection
[    1.451370] 0000:05:00.0: eth0: MAC: 1, PHY: 4, PBA No: d50855-002
[    1.452846] udev: renamed network interface eth0 to eth1
[    1.796090] firewire_core: created device fw0: GUID 0011d80000f46d61, S4=
00
[    1.808860] forcedeth 0000:00:07.0: ifname eth0, PHY OUI 0x1374 @ 1, add=
r 00:18:f3:aa:18:da
[    1.808935] forcedeth 0000:00:07.0: highdma pwrctl mgmt gbit lnktim msi =
desc-v3
[    1.809359] amd74xx 0000:00:06.0: UDMA133 controller
[    1.809411] amd74xx 0000:00:06.0: IDE controller (0x10de:0x03ec rev 0xa2)
[    1.809485] amd74xx 0000:00:06.0: IDE port disabled
[    1.809543] amd74xx 0000:00:06.0: BIOS didn't set cable bits correctly. =
Enabling workaround.
[    1.809616] amd74xx 0000:00:06.0: not 100% native mode: will probe irqs =
later
[    1.809674]     ide0: BM-DMA at 0xffa0-0xffa7
[    1.809727] Probing IDE interface ide0...
[    2.096106] hda: WDC WD1600JB-00GVA0, ATA DISK drive
[    2.768042] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    2.769290] hda: UDMA/100 mode selected
[    2.770625] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.807205] SCSI subsystem initialized
[    2.822111] libata version 3.00 loaded.
[    2.825722] sata_nv 0000:00:08.0: version 3.5
[    2.826062] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 20
[    2.826119]   alloc irq_desc for 20 on cpu 0 node 0
[    2.826121]   alloc kstat_irqs on cpu 0 node 0
[    2.826130] sata_nv 0000:00:08.0: PCI INT A -> Link[LSA0] -> GSI 20 (lev=
el, low) -> IRQ 20
[    2.826270] sata_nv 0000:00:08.0: setting latency timer to 64
[    2.826335] scsi0 : sata_nv
[    2.826570] scsi1 : sata_nv
[    2.826768] ata1: SATA max UDMA/133 cmd 0xb400 ctl 0xb080 bmdma 0xa880 i=
rq 20
[    2.826824] ata2: SATA max UDMA/133 cmd 0xb000 ctl 0xac00 bmdma 0xa888 i=
rq 20
[    2.827228] ACPI: PCI Interrupt Link [LSA1] enabled at IRQ 23
[    2.827282] sata_nv 0000:00:08.1: PCI INT B -> Link[LSA1] -> GSI 23 (lev=
el, low) -> IRQ 23
[    2.827390] sata_nv 0000:00:08.1: setting latency timer to 64
[    2.827427] scsi2 : sata_nv
[    2.827572] scsi3 : sata_nv
[    2.827763] ata3: SATA max UDMA/133 cmd 0xa800 ctl 0xa480 bmdma 0xa000 i=
rq 23
[    2.827821] ata4: SATA max UDMA/133 cmd 0xa400 ctl 0xa080 bmdma 0xa008 i=
rq 23
[    2.899918] ide-gd driver 1.18
[    2.899999] hda: max request size: 512KiB
[    2.901344] hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=3D19=
457/255/63
[    2.903465] hda: cache flushes supported
[    2.903558]  hda: hda1 hda2 hda3
[    3.300036] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.309434] ata1.00: ATA-6: WDC WD1600JD-00GBB0, 02.05D02, max UDMA/100
[    3.309488] ata1.00: 312581808 sectors, multi 16: LBA48=20
[    3.309548] ata1.00: applying bridge limits
[    3.325461] ata1.00: configured for UDMA/100
[    3.325597] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JD-00G 02=
=2E0 PQ: 0 ANSI: 5
[    3.792033] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.800113] ata2.00: ATAPI: TSSTcorp CDDVDW SH-S223F, SB03, max UDMA/100
[    3.816136] ata2.00: configured for UDMA/100
[    3.817542] scsi 1:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S223F  SB=
03 PQ: 0 ANSI: 5
[    4.149265] Driver 'sd' needs updating - please use bus_type methods
[    4.149447] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 =
GB/149 GiB)
[    4.149532] sd 0:0:0:0: [sda] Write Protect is off
[    4.149583] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.149600] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    4.149753]  sda: sda1 sda2 sda3
[    4.189351] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.191758] Driver 'sr' needs updating - please use bus_type methods
[    4.195233] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    4.195309] Uniform CD-ROM driver Revision: 3.20
[    4.195460] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    4.202264] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.202350] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    4.563414] md: raid1 personality registered for level 1
[    4.565354] xor: automatically using best checksumming function: generic=
_sse
[    4.585006]    generic_sse:  7436.000 MB/sec
[    4.585056] xor: using function: generic_sse (7436.000 MB/sec)
[    4.585897] async_tx: api initialized (async)
[    4.653025] raid6: int64x1   2253 MB/s
[    4.721023] raid6: int64x2   2887 MB/s
[    4.789022] raid6: int64x4   2234 MB/s
[    4.857026] raid6: int64x8   2020 MB/s
[    4.925011] raid6: sse2x1    1136 MB/s
[    4.993032] raid6: sse2x2    1942 MB/s
[    5.061018] raid6: sse2x4    2857 MB/s
[    5.061068] raid6: using algorithm sse2x4 (2857 MB/s)
[    5.063973] md: raid6 personality registered for level 6
[    5.064046] md: raid5 personality registered for level 5
[    5.064097] md: raid4 personality registered for level 4
[    5.179315] md: md0 stopped.
[    5.228977] md: bind<hda1>
[    5.229211] md: bind<sda1>
[    5.230744] raid1: raid set md0 active with 2 out of 2 mirrors
[    5.235511]  md0: unknown partition table
[    5.334286] md: md1 stopped.
[    5.335989] md: bind<hda2>
[    5.336209] md: bind<sda2>
[    5.336272] md: md1: raid array is not clean -- starting background reco=
nstruction
[    5.337563] raid1: raid set md1 active with 2 out of 2 mirrors
[    5.338672]  md1: unknown partition table
[    5.394201] device-mapper: uevent: version 1.0.3
[    5.394571] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised:=
 dm-devel@redhat.com
[    5.539374] PM: Starting manual resume from disk
[    5.582500] kjournald starting.  Commit interval 5 seconds
[    5.582509] EXT3-fs: mounted filesystem with ordered data mode.
[    6.762349] udev: starting version 141
[    7.169360] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    7.169437] ACPI: Power Button [PWRF]
[    7.169563] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
C:00/input/input3
[    7.169642] ACPI: Power Button [PWRB]
[    7.241240] processor ACPI_CPU:00: registered as cooling_device0
[    7.241496] processor ACPI_CPU:01: registered as cooling_device1
[    8.225247] parport_pc 00:06: reported by Plug and Play ACPI
[    8.225346] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    8.229387] k8temp 0000:00:18.3: Temperature readouts might be wrong - c=
heck erratum #141
[    8.235375] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    8.238064] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    8.370730] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    8.392902] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x600
[    8.392975] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x700
[    8.459635] Error: Driver 'pcspkr' is already registered, aborting...
[    8.487594] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 22
[    8.487652] HDA Intel 0000:00:05.0: PCI INT B -> Link[LAZA] -> GSI 22 (l=
evel, low) -> IRQ 22
[    8.487891] HDA Intel 0000:00:05.0: setting latency timer to 64
[    9.226307] hda_codec: Unknown model for AD1988, trying auto-probe from =
BIOS...
[    9.226478] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:05.=
0/input/input5
[   11.597996] Adding 3943948k swap on /dev/sda3.  Priority:-1 extents:1 ac=
ross:3943948k=20
[   11.603477] Adding 3943948k swap on /dev/hda3.  Priority:-2 extents:1 ac=
ross:3943948k=20
[   11.771617] md: resync of RAID array md1
[   11.771669] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[   11.771733] md: using maximum available idle IO bandwidth (but not more =
than 200000 KB/sec) for resync.
[   11.771829] EXT3 FS on dm-0, <6>md: using 128k window, over a total of 1=
51364352 blocks.
[   11.771834] md: resuming resync of md1 from checkpoint.
[   11.771978] internal journal
[   11.958537] loop: module loaded
[   12.851706] kjournald starting.  Commit interval 5 seconds
[   12.857985] EXT3 FS on md0, internal journal
[   12.858064] EXT3-fs: mounted filesystem with ordered data mode.
[   12.966499] EXT4-fs: barriers enabled
[   12.981308] kjournald2 starting: pid 2342, dev dm-3:8, commit interval 5=
 seconds
[   12.985291] EXT4 FS on dm-3, internal journal on dm-3:8
[   12.985345] EXT4-fs: delayed allocation enabled
[   12.985394] EXT4-fs: file extents enabled
[   12.986720] EXT4-fs: mballoc enabled
[   12.986782] EXT4-fs: mounted filesystem dm-3 with ordered data mode
[   14.192401] Bridge firewalling registered
[   14.233579] device eth1 entered promiscuous mode
[   14.381973] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   17.679411] Loading iSCSI transport class v2.0-870.
[   17.735226] iscsi: registered transport (tcp)
[   17.804174] iscsi: registered transport (iser)
[   18.311115] RPC: Registered udp transport module.
[   18.311183] RPC: Registered tcp transport module.
[   18.360033] Slow work thread pool: Starting up
[   18.360443] Slow work thread pool: Ready
[   18.360539] FS-Cache: Loaded
[   18.400365] FS-Cache: Netfs 'nfs' registered for caching
[   18.445729] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   25.149010] br0: no IPv6 routers present
[   27.465010] torbr: no IPv6 routers present
[   82.029758] virbr1: starting userspace STP failed, starting kernel STP
[   82.176064] ip_tables: (C) 2000-2006 Netfilter Core Team
[   82.190733] svc: failed to register lockdv1 RPC service (errno 97).
[   82.191316] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recov=
ery directory
[   82.201011] NFSD: starting 90-second grace period
[   83.834204] tun: Universal TUN/TAP device driver, 1.6
[   83.834258] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   83.836916] device vnet0 entered promiscuous mode
[   83.838611] br0: port 2(vnet0) entering learning state
[   83.967666] br0: port 2(vnet0) entering disabled state
[   83.982342] device vnet0 left promiscuous mode
[   83.982397] br0: port 2(vnet0) entering disabled state
[   84.101384] lo: Disabled Privacy Extensions
[   92.184011] virbr1: no IPv6 routers present
[  122.248048] sata_mv 0000:04:04.0: version 1.28
[  122.248549] ACPI: PCI Interrupt Link [LNED] enabled at IRQ 17
[  122.248607]   alloc irq_desc for 17 on cpu 0 node 0
[  122.248609]   alloc kstat_irqs on cpu 0 node 0
[  122.248620] sata_mv 0000:04:04.0: PCI INT A -> Link[LNED] -> GSI 17 (lev=
el, low) -> IRQ 17
[  122.248908] sata_mv 0000:04:04.0: Gen-II 32 slots 8 ports SCSI mode IRQ =
via INTx
[  122.249916] scsi4 : sata_mv
[  122.250122] scsi5 : sata_mv
[  122.250230] scsi6 : sata_mv
[  122.250328] scsi7 : sata_mv
[  122.250427] scsi8 : sata_mv
[  122.250533] scsi9 : sata_mv
[  122.250633] scsi10 : sata_mv
[  122.250732] scsi11 : sata_mv
[  122.250820] ata5: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
2000 irq 17
[  122.250892] ata6: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
4000 irq 17
[  122.250962] ata7: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
6000 irq 17
[  122.251033] ata8: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
8000 irq 17
[  122.251105] ata9: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe3=
2000 irq 17
[  122.251176] ata10: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
34000 irq 17
[  122.251247] ata11: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
36000 irq 17
[  122.251319] ata12: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
38000 irq 17
[  122.728030] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  122.760048] ata5.00: ATA-8: WDC WD5000AAKS-00A7B0, 01.03B01, max UDMA/133
[  122.760103] ata5.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  122.776077] ata5.00: configured for UDMA/133
[  122.776233] scsi 4:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 01=
=2E0 PQ: 0 ANSI: 5
[  122.776442] sd 4:0:0:0: Attached scsi generic sg2 type 0
[  122.776570] sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  122.776652] sd 4:0:0:0: [sdb] Write Protect is off
[  122.776703] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  122.776721] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  122.776882]  sdb:<6>ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  123.292050] ata6.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  123.292118] ata6.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  123.324059] ata6.00: configured for UDMA/133
[  123.324212] scsi 5:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  123.324441] sd 5:0:0:0: Attached scsi generic sg3 type 0
[  123.324477] sd 5:0:0:0: [sdc] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  123.324490] sd 5:0:0:0: [sdc] Write Protect is off
[  123.324493] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  123.324511] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  123.324610]  sdc:<6>ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  123.840047] ata7.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  123.840114] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  123.872064] ata7.00: configured for UDMA/133
[  123.872219] scsi 6:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  123.872439] sd 6:0:0:0: Attached scsi generic sg4 type 0
[  123.872581] sd 6:0:0:0: [sdd] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  123.872678] sd 6:0:0:0: [sdd] Write Protect is off
[  123.872740] sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[  123.872759] sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  123.872938]  sdd:<6>ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  124.388049] ata8.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  124.388105] ata8.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  124.421907] ata8.00: configured for UDMA/133
[  124.422035] scsi 7:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  124.422249] sd 7:0:0:0: Attached scsi generic sg5 type 0
[  124.422377] sd 7:0:0:0: [sde] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  124.422458] sd 7:0:0:0: [sde] Write Protect is off
[  124.422570] sd 7:0:0:0: [sde] Mode Sense: 00 3a 00 00
[  124.422589] sd 7:0:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  124.422767]  sde:<6>ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  124.914177] ata9.00: ATA-7: WDC WD5000AAKS-65TMA0, 12.01C01, max UDMA/133
[  124.914244] ata9.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  124.937462] ata9.00: configured for UDMA/133
[  124.937588] scsi 8:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-6 12=
=2E0 PQ: 0 ANSI: 5
[  124.937803] sd 8:0:0:0: Attached scsi generic sg6 type 0
[  124.937935] sd 8:0:0:0: [sdf] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  124.938015] sd 8:0:0:0: [sdf] Write Protect is off
[  124.938123] sd 8:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[  124.938142] sd 8:0:0:0: [sdf] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  124.938305]  sdf:<6>ata10: SATA link down (SStatus 0 SControl 300)
[  125.576033] ata11: SATA link down (SStatus 0 SControl 300)
[  125.896027] ata12: SATA link down (SStatus 0 SControl 300)
[  152.831031] ata5.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  152.831094] ata5.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  152.831096]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  152.831235] ata5.00: status: { DRDY }
[  152.831286] ata5: hard resetting link
[  153.304030] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  153.344062] ata5.00: configured for UDMA/133
[  153.344120] ata5: EH complete
[  153.831050] ata6.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  153.831116] ata6.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  153.831118]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  153.831256] ata6.00: status: { DRDY }
[  153.831307] ata6: hard resetting link
[  154.304031] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  154.376062] ata6.00: configured for UDMA/133
[  154.381026] ata6: EH complete
[  154.819003] ata8.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  154.819062] ata8.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  154.819063]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  154.819202] ata8.00: status: { DRDY }
[  154.819252] ata8: hard resetting link
[  154.834706] ata7.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  154.834765] ata7.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  154.834766]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  154.834904] ata7.00: status: { DRDY }
[  154.834955] ata7: hard resetting link
[  155.304030] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  155.308044] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  155.376090] ata8.00: configured for UDMA/133
[  155.376144] ata8: EH complete
[  155.384060] ata7.00: configured for UDMA/133
[  155.384113] ata7: EH complete
[  155.819001] ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  155.819060] ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  155.819061]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  155.819197] ata9.00: status: { DRDY }
[  155.819247] ata9: hard resetting link
[  156.292030] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  156.332066] ata9.00: configured for UDMA/133
[  156.332122] ata9: EH complete
[  183.820110] ata5.00: NCQ disabled due to excessive errors
[  183.820168] ata5.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  183.820227] ata5.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  183.820229]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  183.820365] ata5.00: status: { DRDY }
[  183.820416] ata5: hard resetting link
[  184.297029] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  184.329061] ata5.00: configured for UDMA/133
[  184.329128] ata5: EH complete
[  184.831001] ata6.00: NCQ disabled due to excessive errors
[  184.831069] ata6.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  184.831141] ata6.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  184.831142]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  184.831311] ata6.00: status: { DRDY }
[  184.831373] ata6: hard resetting link
[  185.304032] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  185.376062] ata6.00: configured for UDMA/133
[  185.376119] ata6: EH complete
[  185.830996] ata8.00: NCQ disabled due to excessive errors
[  185.831049] ata8.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  185.831107] ata8.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  185.831108]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  185.831244] ata8.00: status: { DRDY }
[  185.831294] ata8: hard resetting link
[  185.846750] ata7.00: NCQ disabled due to excessive errors
[  185.846802] ata7.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  185.846861] ata7.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  185.846862]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  185.846998] ata7.00: status: { DRDY }
[  185.847048] ata7: hard resetting link
[  186.312027] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  186.320353] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  186.392087] ata8.00: configured for UDMA/133
[  186.392141] ata8: EH complete
[  186.400060] ata7.00: configured for UDMA/133
[  186.400125] ata7: EH complete
[  186.831002] ata9.00: NCQ disabled due to excessive errors
[  186.831070] ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  186.831142] ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  186.831143]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  186.831312] ata9.00: status: { DRDY }
[  186.831373] ata9: hard resetting link
[  187.304031] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  187.344068] ata9.00: configured for UDMA/133
[  187.344137] ata9: EH complete
[  214.820125] ata5: limiting SATA link speed to 1.5 Gbps
[  214.820182] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  214.820242] ata5.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  214.820243]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  214.820381] ata5.00: status: { DRDY }
[  214.820432] ata5: hard resetting link
[  215.296030] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  215.336062] ata5.00: configured for UDMA/133
[  215.336119] ata5: EH complete
[  215.831003] ata6: limiting SATA link speed to 1.5 Gbps
[  215.831059] ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  215.831119] ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  215.831121]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  215.831257] ata6.00: status: { DRDY }
[  215.831308] ata6: hard resetting link
[  216.304031] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  216.376062] ata6.00: configured for UDMA/133
[  216.376118] ata6: EH complete
[  216.830994] ata8: limiting SATA link speed to 1.5 Gbps
[  216.831047] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  216.831106] ata8.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  216.831107]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  216.831243] ata8.00: status: { DRDY }
[  216.831294] ata8: hard resetting link
[  216.846754] ata7: limiting SATA link speed to 1.5 Gbps
[  216.846805] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  216.846864] ata7.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  216.846865]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  216.847001] ata7.00: status: { DRDY }
[  216.847051] ata7: hard resetting link
[  217.312030] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  217.320354] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  217.392091] ata8.00: configured for UDMA/133
[  217.392147] ata8: EH complete
[  217.400060] ata7.00: configured for UDMA/133
[  217.400115] ata7: EH complete
[  217.830998] ata9: limiting SATA link speed to 1.5 Gbps
[  217.831062] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  217.831134] ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  217.831135]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  217.831305] ata9.00: status: { DRDY }
[  217.831365] ata9: hard resetting link
[  218.304035] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  218.344067] ata9.00: configured for UDMA/133
[  218.344127] ata9: EH complete
[  245.819005] ata5.00: limiting speed to UDMA/100:PIO4
[  245.819074] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  245.819138] ata5.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  245.819139]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  245.819279] ata5.00: status: { DRDY }
[  245.819331] ata5: hard resetting link
[  246.293030] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  246.333061] ata5.00: configured for UDMA/100
[  246.333129] ata5: EH complete
[  246.831005] ata6.00: limiting speed to UDMA/100:PIO4
[  246.831061] ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  246.831121] ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  246.831122]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  246.831262] ata6.00: status: { DRDY }
[  246.831313] ata6: hard resetting link
[  247.304033] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  247.376059] ata6.00: configured for UDMA/100
[  247.376130] ata6: EH complete
[  247.845991] ata7.00: limiting speed to UDMA/100:PIO4
[  247.846064] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  247.846080] ata8.00: limiting speed to UDMA/100:PIO4
[  247.846084] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  247.846091] ata8.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  247.846093]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  247.846095] ata8.00: status: { DRDY }
[  247.846100] ata8: hard resetting link
[  247.846462] ata7.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  247.846463]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  247.846609] ata7.00: status: { DRDY }
[  247.846669] ata7: hard resetting link
[  248.320034] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  248.320292] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  248.393061] ata8.00: configured for UDMA/100
[  248.393130] ata8: EH complete
[  248.396064] ata7.00: configured for UDMA/100
[  248.396138] ata7: EH complete
[  248.832571] ata9.00: limiting speed to UDMA/100:PIO4
[  248.832653] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  248.832728] ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  248.832729]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  248.832902] ata9.00: status: { DRDY }
[  248.832963] ata9: hard resetting link
[  249.308033] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  249.348064] ata9.00: configured for UDMA/100
[  249.348131] ata9: EH complete

--4ickEXl+ukcSQ/3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sata_mv-dmesg.irqpoll.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-btrfsnewformat2 (2.6.30) (root@slimer) =
(gcc version 4.3.3 (Debian 4.3.3-15) ) #3 SMP Mon Aug 3 18:09:53 GMT 2009
[    0.000000] Command line: root=3D/dev/mapper/slimerroot-root ro irqpoll
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
[    0.000000] Kernel command line: root=3D/dev/mapper/slimerroot-root ro i=
rqpoll
[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance
[    0.000000] Initializing CPU#0
[    0.000000] Experimental hierarchical RCU implementation.
[    0.000000] Experimental hierarchical RCU init done.
[    0.000000] NR_IRQS:4352 nr_irqs:424
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2410.659 MHz processor.
[    0.004000] spurious 8259A interrupt: IRQ7.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Checking aperture...
[    0.004000] No AGP bridge found
[    0.004000] Node 0: aperture @ 5630000000 size 32 MB
[    0.004000] Aperture beyond 4GB. Ignoring.
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
er frequency.. 4821.31 BogoMIPS (lpj=3D9642636)
[    0.004000] Security Framework initialized
[    0.004000] SELinux:  Disabled at boot.
[    0.004000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.006483] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.009173] Mount-cache hash table entries: 256
[    0.009391] Initializing cgroup subsys ns
[    0.009442] Initializing cgroup subsys cpuacct
[    0.009493] Initializing cgroup subsys devices
[    0.009543] Initializing cgroup subsys freezer
[    0.009593] Initializing cgroup subsys net_cls
[    0.009673] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.009727] CPU: L2 Cache: 512K (64 bytes/line)
[    0.009777] CPU 0/0x0 -> Node 0
[    0.009824] tseg: 0000000000
[    0.009836] CPU: Physical Processor ID: 0
[    0.009885] CPU: Processor Core ID: 0
[    0.009940] using C1E aware idle routine
[    0.010604] ACPI: Core revision 20090320
[    0.017458] Setting APIC routing to flat
[    0.017958] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D0 apic2=3D-1 pin2=3D=
-1
[    0.024001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.024001] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.024001] ..... (found apic 0 pin 0) ...
[    0.065139] ....... works.
[    0.065188] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.068001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 4821.86 Bog=
oMIPS (lpj=3D9643729)
[    0.004000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.004000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.004000] CPU 1/0x1 -> Node 0
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x701060007=
0106
[    0.152352] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ steppin=
g 02
[    0.152880] Brought up 2 CPUs
[    0.152927] Total of 2 processors activated (9643.18 BogoMIPS).
[    0.153085] CPU0 attaching sched-domain:
[    0.153088]  domain 0: span 0-1 level MC
[    0.153090]   groups: 0 1
[    0.153095] CPU1 attaching sched-domain:
[    0.153097]  domain 0: span 0-1 level MC
[    0.153098]   groups: 1 0
[    0.153155] net_namespace: 1936 bytes
[    0.153155] Booting paravirtualized kernel on bare hardware
[    0.153155] regulator: core version 0.5
[    0.153155] NET: Registered protocol family 16
[    0.153155] node 0 link 0: io port [1000, ffffff]
[    0.153155] TOM: 00000000d0000000 aka 3328M
[    0.153155] node 0 link 0: mmio [e0000000, efffffff]
[    0.153155] node 0 link 0: mmio [a0000, bffff]
[    0.153155] node 0 link 0: mmio [d0000000, fe0bffff]
[    0.153155] TOM2: 00000001b0000000 aka 6912M
[    0.153155] bus: [00,ff] on node 0 link 0
[    0.153155] bus: 00 index 0 io port: [0, ffff]
[    0.153155] bus: 00 index 1 mmio: [d0000000, ffffffff]
[    0.153155] bus: 00 index 2 mmio: [a0000, bffff]
[    0.153155] bus: 00 index 3 mmio: [1b0000000, fcffffffff]
[    0.153155] ACPI: bus type pci registered
[    0.153155] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.153155] PCI: Not using MMCONFIG.
[    0.153155] PCI: Using configuration type 1 for base access
[    0.156098] bio: create slab <bio-0> at 0
[    0.160594] ACPI: EC: Look up EC in DSDT
[    0.172117] ACPI: Interpreter enabled
[    0.172168] ACPI: (supports S0 S1 S3 S4 S5)
[    0.172371] ACPI: Using IOAPIC for interrupt routing
[    0.172473] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.178924] PCI: MCFG area at e0000000 reserved in ACPI motherboard reso=
urces
[    0.189378] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.200114] ACPI Warning (tbutils-0246): Incorrect checksum in table [OE=
MB] - E5, should be D8 [20090320]
[    0.200310] ACPI: No dock devices found.
[    0.200423] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.200507] pci 0000:00:01.1: reg 10 io port: [0xbc00-0xbc3f]
[    0.200507] pci 0000:00:01.1: reg 20 io port: [0x600-0x63f]
[    0.200507] pci 0000:00:01.1: reg 24 io port: [0x700-0x73f]
[    0.200507] pci 0000:00:01.1: PME# supported from D3hot D3cold
[    0.200507] pci 0000:00:01.1: PME# disabled
[    0.200507] pci 0000:00:02.0: reg 10 32bit mmio: [0xdfbff000-0xdfbfffff]
[    0.200507] pci 0000:00:02.0: supports D1 D2
[    0.200507] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.200507] pci 0000:00:02.0: PME# disabled
[    0.200507] pci 0000:00:02.1: reg 10 32bit mmio: [0xdfbfec00-0xdfbfecff]
[    0.200529] pci 0000:00:02.1: supports D1 D2
[    0.200531] pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.200586] pci 0000:00:02.1: PME# disabled
[    0.200689] pci 0000:00:05.0: reg 10 32bit mmio: [0xdfbf8000-0xdfbfbfff]
[    0.200712] pci 0000:00:05.0: PME# supported from D3hot D3cold
[    0.200765] pci 0000:00:05.0: PME# disabled
[    0.200844] pci 0000:00:06.0: reg 20 io port: [0xffa0-0xffaf]
[    0.200876] pci 0000:00:07.0: reg 10 32bit mmio: [0xdfbfd000-0xdfbfdfff]
[    0.200880] pci 0000:00:07.0: reg 14 io port: [0xb480-0xb487]
[    0.200899] pci 0000:00:07.0: supports D1 D2
[    0.200901] pci 0000:00:07.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.200957] pci 0000:00:07.0: PME# disabled
[    0.201024] pci 0000:00:08.0: reg 10 io port: [0xb400-0xb407]
[    0.201027] pci 0000:00:08.0: reg 14 io port: [0xb080-0xb083]
[    0.201030] pci 0000:00:08.0: reg 18 io port: [0xb000-0xb007]
[    0.201034] pci 0000:00:08.0: reg 1c io port: [0xac00-0xac03]
[    0.201037] pci 0000:00:08.0: reg 20 io port: [0xa880-0xa88f]
[    0.201040] pci 0000:00:08.0: reg 24 32bit mmio: [0xdfbfc000-0xdfbfcfff]
[    0.201068] pci 0000:00:08.1: reg 10 io port: [0xa800-0xa807]
[    0.201072] pci 0000:00:08.1: reg 14 io port: [0xa480-0xa483]
[    0.201075] pci 0000:00:08.1: reg 18 io port: [0xa400-0xa407]
[    0.201078] pci 0000:00:08.1: reg 1c io port: [0xa080-0xa083]
[    0.201082] pci 0000:00:08.1: reg 20 io port: [0xa000-0xa00f]
[    0.201085] pci 0000:00:08.1: reg 24 32bit mmio: [0xdfbf3000-0xdfbf3fff]
[    0.201126] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.201180] pci 0000:00:09.0: PME# disabled
[    0.201255] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.201309] pci 0000:00:0b.0: PME# disabled
[    0.201383] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.201438] pci 0000:00:0c.0: PME# disabled
[    0.201581] pci 0000:01:03.0: reg 10 32bit mmio: [0xdfcff800-0xdfcfffff]
[    0.201586] pci 0000:01:03.0: reg 14 io port: [0xcc00-0xcc7f]
[    0.201615] pci 0000:01:03.0: supports D2
[    0.201617] pci 0000:01:03.0: PME# supported from D2 D3hot D3cold
[    0.201671] pci 0000:01:03.0: PME# disabled
[    0.201748] pci 0000:01:0a.0: reg 10 32bit mmio: [0xdfc00000-0xdfc7ffff]
[    0.201753] pci 0000:01:0a.0: reg 14 32bit mmio: [0xd0000000-0xd7ffffff]
[    0.201770] pci 0000:01:0a.0: reg 30 32bit mmio: [0xdfce0000-0xdfceffff]
[    0.201783] pci 0000:01:0a.0: supports D1 D2
[    0.201805] pci 0000:00:04.0: transparent bridge
[    0.201857] pci 0000:00:04.0: bridge io port: [0xc000-0xcfff]
[    0.201860] pci 0000:00:04.0: bridge 32bit mmio: [0xdfc00000-0xdfcfffff]
[    0.201863] pci 0000:00:04.0: bridge 32bit mmio pref: [0xd0000000-0xd7ff=
ffff]
[    0.201896] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.201950] pci 0000:02:00.0: PME# disabled
[    0.202038] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
[    0.202092] pci 0000:02:00.2: PME# disabled
[    0.202178] pci 0000:00:09.0: bridge io port: [0xd000-0xdfff]
[    0.202180] pci 0000:00:09.0: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.202255] pci 0000:04:04.0: reg 10 64bit mmio: [0xdfe00000-0xdfefffff]
[    0.202261] pci 0000:04:04.0: reg 18 io port: [0xd800-0xd8ff]
[    0.202323] pci 0000:02:00.2: bridge io port: [0xd000-0xdfff]
[    0.202326] pci 0000:02:00.2: bridge 32bit mmio: [0xdfd00000-0xdfefffff]
[    0.202383] pci 0000:05:00.0: reg 10 32bit mmio: [0xdffe0000-0xdfffffff]
[    0.202392] pci 0000:05:00.0: reg 14 32bit mmio: [0xdffc0000-0xdffdffff]
[    0.202400] pci 0000:05:00.0: reg 18 io port: [0xec00-0xec1f]
[    0.202428] pci 0000:05:00.0: reg 30 32bit mmio: [0xdffa0000-0xdffbffff]
[    0.202464] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.202521] pci 0000:05:00.0: PME# disabled
[    0.202618] pci 0000:00:0b.0: bridge io port: [0xe000-0xefff]
[    0.202621] pci 0000:00:0b.0: bridge 32bit mmio: [0xdff00000-0xdfffffff]
[    0.202665] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.202830] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.202944] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.203008] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR11._PRT]
[    0.203071] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR12._PRT]
[    0.212199] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *0, disab=
led.
[    0.212683] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *0, disab=
led.
[    0.213167] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *11
[    0.213622] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disab=
led.
[    0.214103] ACPI: PCI Interrupt Link [LNEA] (IRQs 16 17 18 19) *0, disab=
led.
[    0.214583] ACPI: PCI Interrupt Link [LNEB] (IRQs 16 17 18 19) *10
[    0.215034] ACPI: PCI Interrupt Link [LNEC] (IRQs 16 17 18 19) *0, disab=
led.
[    0.215512] ACPI: PCI Interrupt Link [LNED] (IRQs 16 17 18 19) *11
[    0.216364] ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *11
[    0.216818] ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *10
[    0.217275] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *11
[    0.217739] ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *11
[    0.218194] ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0, disab=
led.
[    0.218685] ACPI: PCI Interrupt Link [LMC9] (IRQs 20 21 22 23) *0, disab=
led.
[    0.219165] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *10
[    0.219620] ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *0, disab=
led.
[    0.220117] ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *15
[    0.220576] ACPI: PCI Interrupt Link [LSA1] (IRQs 20 21 22 23) *5
[    0.221067] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disab=
led.
[    0.221382] usbcore: registered new interface driver usbfs
[    0.221382] usbcore: registered new interface driver hub
[    0.221382] usbcore: registered new device driver usb
[    0.221382] PCI: Using ACPI for IRQ routing
[    0.228133] PCI-DMA: Disabling AGP.
[    0.228257] PCI-DMA: aperture base @ 20000000 size 65536 KB
[    0.228257] PCI-DMA: using GART IOMMU.
[    0.228257] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    0.228647] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.228812] hpet0: 3 comparators, 32-bit 25.000000 MHz counter
[    0.236011] Switched to high resolution mode on CPU 0
[    0.236349] Switched to high resolution mode on CPU 1
[    0.240019] pnp: PnP ACPI init
[    0.240101] ACPI: bus type pnp registered
[    0.247784] pnp: PnP ACPI: found 15 devices
[    0.247837] ACPI: ACPI bus type pnp unregistered
[    0.247897] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[    0.247952] system 00:07: ioport range 0x800-0x80f has been reserved
[    0.248017] system 00:07: ioport range 0x500-0x57f has been reserved
[    0.248071] system 00:07: ioport range 0x580-0x5ff has been reserved
[    0.248126] system 00:07: ioport range 0x800-0x87f could not be reserved
[    0.248182] system 00:07: ioport range 0x880-0x8ff has been reserved
[    0.248236] system 00:07: ioport range 0xd00-0xd7f has been reserved
[    0.248290] system 00:07: ioport range 0xd80-0xdff has been reserved
[    0.248347] system 00:07: ioport range 0x2000-0x207f has been reserved
[    0.248401] system 00:07: ioport range 0x2080-0x20ff has been reserved
[    0.248457] system 00:07: iomem range 0xfefe0000-0xfefe01ff has been res=
erved
[    0.248512] system 00:07: iomem range 0xfefe1000-0xfefe1fff has been res=
erved
[    0.248569] system 00:07: iomem range 0xfee01000-0xfeefffff has been res=
erved
[    0.248626] system 00:07: iomem range 0xffb80000-0xffffffff has been res=
erved
[    0.248684] system 00:09: iomem range 0xfec00000-0xfec00fff has been res=
erved
[    0.248739] system 00:09: iomem range 0xfee00000-0xfee00fff has been res=
erved
[    0.248798] system 00:0b: ioport range 0x230-0x23f has been reserved
[    0.248855] system 00:0b: ioport range 0x290-0x29f has been reserved
[    0.248909] system 00:0b: ioport range 0xa00-0xa0f has been reserved
[    0.248962] system 00:0b: ioport range 0xa10-0xa1f has been reserved
[    0.249024] system 00:0d: iomem range 0xe0000000-0xefffffff has been res=
erved
[    0.249082] system 00:0e: iomem range 0x0-0x9ffff could not be reserved
[    0.249139] system 00:0e: iomem range 0xc0000-0xcffff has been reserved
[    0.249193] system 00:0e: iomem range 0xe0000-0xfffff could not be reser=
ved
[    0.249248] system 00:0e: iomem range 0x100000-0xcfffffff could not be r=
eserved
[    0.249318] system 00:0e: iomem range 0xff780000-0xffffffff could not be=
 reserved
[    0.254411] pci 0000:00:04.0: PCI bridge, secondary bus 0000:01
[    0.254465] pci 0000:00:04.0:   IO window: 0xc000-0xcfff
[    0.254518] pci 0000:00:04.0:   MEM window: 0xdfc00000-0xdfcfffff
[    0.254572] pci 0000:00:04.0:   PREFETCH window: 0x000000d0000000-0x0000=
00d7ffffff
[    0.254646] pci 0000:02:00.0: PCI bridge, secondary bus 0000:03
[    0.254699] pci 0000:02:00.0:   IO window: disabled
[    0.254751] pci 0000:02:00.0:   MEM window: disabled
[    0.254803] pci 0000:02:00.0:   PREFETCH window: disabled
[    0.254857] pci 0000:02:00.2: PCI bridge, secondary bus 0000:04
[    0.254914] pci 0000:02:00.2:   IO window: 0xd000-0xdfff
[    0.254967] pci 0000:02:00.2:   MEM window: 0xdfd00000-0xdfefffff
[    0.255021] pci 0000:02:00.2:   PREFETCH window: disabled
[    0.255077] pci 0000:00:09.0: PCI bridge, secondary bus 0000:02
[    0.255130] pci 0000:00:09.0:   IO window: 0xd000-0xdfff
[    0.255183] pci 0000:00:09.0:   MEM window: 0xdfd00000-0xdfefffff
[    0.255235] pci 0000:00:09.0:   PREFETCH window: disabled
[    0.255288] pci 0000:00:0b.0: PCI bridge, secondary bus 0000:05
[    0.255341] pci 0000:00:0b.0:   IO window: 0xe000-0xefff
[    0.255393] pci 0000:00:0b.0:   MEM window: 0xdff00000-0xdfffffff
[    0.255446] pci 0000:00:0b.0:   PREFETCH window: disabled
[    0.255498] pci 0000:00:0c.0: PCI bridge, secondary bus 0000:06
[    0.255550] pci 0000:00:0c.0:   IO window: disabled
[    0.255601] pci 0000:00:0c.0:   MEM window: disabled
[    0.255652] pci 0000:00:0c.0:   PREFETCH window: disabled
[    0.255712] pci 0000:00:04.0: setting latency timer to 64
[    0.255716] pci 0000:00:09.0: setting latency timer to 64
[    0.255721] pci 0000:02:00.0: setting latency timer to 64
[    0.255726] pci 0000:02:00.2: setting latency timer to 64
[    0.255730] pci 0000:00:0b.0: setting latency timer to 64
[    0.255734] pci 0000:00:0c.0: setting latency timer to 64
[    0.255738] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.255740] pci_bus 0000:00: resource 1 mem: [0x000000-0xfffffffffffffff=
f]
[    0.255742] pci_bus 0000:01: resource 0 io:  [0xc000-0xcfff]
[    0.255745] pci_bus 0000:01: resource 1 mem: [0xdfc00000-0xdfcfffff]
[    0.255747] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xd7ffffff]
[    0.255749] pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
[    0.255752] pci_bus 0000:01: resource 4 mem: [0x000000-0xfffffffffffffff=
f]
[    0.255754] pci_bus 0000:02: resource 0 io:  [0xd000-0xdfff]
[    0.255757] pci_bus 0000:02: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.255759] pci_bus 0000:04: resource 0 io:  [0xd000-0xdfff]
[    0.255761] pci_bus 0000:04: resource 1 mem: [0xdfd00000-0xdfefffff]
[    0.255764] pci_bus 0000:05: resource 0 io:  [0xe000-0xefff]
[    0.255766] pci_bus 0000:05: resource 1 mem: [0xdff00000-0xdfffffff]
[    0.255864] NET: Registered protocol family 2
[    0.284276] IP route cache hash table entries: 262144 (order: 9, 2097152=
 bytes)
[    0.286845] TCP established hash table entries: 524288 (order: 11, 83886=
08 bytes)
[    0.292091] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.292775] TCP: Hash tables configured (established 524288 bind 65536)
[    0.292833] TCP reno registered
[    0.300126] NET: Registered protocol family 1
[    0.300231] Trying to unpack rootfs image as initramfs...
[    0.495609] Freeing initrd memory: 8817k freed
[    0.502425] audit: initializing netlink socket (disabled)
[    0.502493] type=3D2000 audit(1249502648.500:1): initialized
[    0.503048] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.503264] VFS: Disk quotas dquot_6.5.2
[    0.503351] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.503465] msgmni has been set to 11973
[    0.503714] alg: No test for stdrng (krng)
[    0.503835] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    0.503906] io scheduler noop registered
[    0.503955] io scheduler anticipatory registered
[    0.504021] io scheduler deadline registered
[    0.504103] io scheduler cfq registered (default)
[    1.028378] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028473] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028578] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028680] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028782] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028889] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.028999] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.029117] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    1.029180] pci 0000:01:0a.0: Boot video device
[    1.029369]   alloc irq_desc for 24 on cpu 0 node 0
[    1.029371]   alloc kstat_irqs on cpu 0 node 0
[    1.029379] pcieport-driver 0000:00:09.0: irq 24 for MSI/MSI-X
[    1.029386] pcieport-driver 0000:00:09.0: setting latency timer to 64
[    1.029549]   alloc irq_desc for 25 on cpu 0 node 0
[    1.029551]   alloc kstat_irqs on cpu 0 node 0
[    1.029555] pcieport-driver 0000:00:0b.0: irq 25 for MSI/MSI-X
[    1.029561] pcieport-driver 0000:00:0b.0: setting latency timer to 64
[    1.029721]   alloc irq_desc for 26 on cpu 0 node 0
[    1.029723]   alloc kstat_irqs on cpu 0 node 0
[    1.029727] pcieport-driver 0000:00:0c.0: irq 26 for MSI/MSI-X
[    1.029733] pcieport-driver 0000:00:0c.0: setting latency timer to 64
[    1.034011] Linux agpgart interface v0.103
[    1.034064] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.034236] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.034690] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.036411] brd: module loaded
[    1.036536] input: Macintosh mouse button emulation as /devices/virtual/=
input/input0
[    1.036793] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.036846] PNP: PS/2 appears to have AUX port disabled, if this is inco=
rrect please boot with i8042.nopnp
[    1.037048] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.037259] mice: PS/2 mouse device common for all mice
[    1.037384] rtc_cmos 00:02: RTC can wake from S4
[    1.037502] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    1.037593] rtc0: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    1.037690] cpuidle: using governor ladder
[    1.037739] cpuidle: using governor menu
[    1.037791] No iBFT detected.
[    1.038180] TCP cubic registered
[    1.038325] NET: Registered protocol family 10
[    1.038848] lo: Disabled Privacy Extensions
[    1.039177] Mobile IPv6
[    1.039224] NET: Registered protocol family 17
[    1.039448] registered taskstats version 1
[    1.039693] rtc_cmos 00:02: setting system clock to 2009-08-05 20:04:09 =
UTC (1249502649)
[    1.039825] Freeing unused kernel memory: 560k freed
[    1.045079] Write protecting the kernel read-only data: 3772k
[    1.054836] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    1.204471] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.204630] FDC 0 is a post-1991 82077
[    1.204948] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 23
[    1.205004]   alloc irq_desc for 23 on cpu 0 node 0
[    1.205006]   alloc kstat_irqs on cpu 0 node 0
[    1.205016] ehci_hcd 0000:00:02.1: PCI INT B -> Link[LUB2] -> GSI 23 (le=
vel, low) -> IRQ 23
[    1.205117] ehci_hcd 0000:00:02.1: setting latency timer to 64
[    1.205119] ehci_hcd 0000:00:02.1: EHCI Host Controller
[    1.205260] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus =
number 1
[    1.205402] ehci_hcd 0000:00:02.1: debug port 1
[    1.205484] ehci_hcd 0000:00:02.1: cache line size of 64 is not supported
[    1.205509] ehci_hcd 0000:00:02.1: irq 23, io mem 0xdfbfec00
[    1.216986] Uniform Multi-Platform E-IDE driver
[    1.220022] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00
[    1.220103] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.220157] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.220227] usb usb1: Product: EHCI Host Controller
[    1.220277] usb usb1: Manufacturer: Linux 2.6.30-btrfsnewformat2 ehci_hcd
[    1.220331] usb usb1: SerialNumber: 0000:00:02.1
[    1.220454] usb usb1: configuration #1 chosen from 1 choice
[    1.220541] hub 1-0:1.0: USB hub found
[    1.220598] hub 1-0:1.0: 10 ports detected
[    1.251508] forcedeth: Reverse Engineered nForce ethernet driver. Versio=
n 0.64.
[    1.251926] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 22
[    1.251981]   alloc irq_desc for 22 on cpu 0 node 0
[    1.251983]   alloc kstat_irqs on cpu 0 node 0
[    1.251994] forcedeth 0000:00:07.0: PCI INT A -> Link[LMAC] -> GSI 22 (l=
evel, low) -> IRQ 22
[    1.252112] forcedeth 0000:00:07.0: setting latency timer to 64
[    1.253014] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 19
[    1.253067]   alloc irq_desc for 19 on cpu 0 node 0
[    1.253069]   alloc kstat_irqs on cpu 0 node 0
[    1.253077] firewire_ohci 0000:01:03.0: PCI INT A -> Link[LNKC] -> GSI 1=
9 (level, low) -> IRQ 19
[    1.308844] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.311542] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.4-k4
[    1.311600] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    1.313742] ACPI: PCI Interrupt Link [LNEB] enabled at IRQ 18
[    1.313800]   alloc irq_desc for 18 on cpu 0 node 0
[    1.313802]   alloc kstat_irqs on cpu 0 node 0
[    1.313814] e1000e 0000:05:00.0: PCI INT A -> Link[LNEB] -> GSI 18 (leve=
l, low) -> IRQ 18
[    1.313892] e1000e 0000:05:00.0: setting latency timer to 64
[    1.314040]   alloc irq_desc for 27 on cpu 0 node 0
[    1.314042]   alloc kstat_irqs on cpu 0 node 0
[    1.314054] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[    1.336050] firewire_ohci: Added fw-ohci device 0000:01:03.0, OHCI versi=
on 1.10
[    1.503183] 0000:05:00.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:15:17:=
24:85:7a
[    1.503256] 0000:05:00.0: eth0: Intel(R) PRO/1000 Network Connection
[    1.503387] 0000:05:00.0: eth0: MAC: 1, PHY: 4, PBA No: d50855-002
[    1.505231] udev: renamed network interface eth0 to eth1
[    1.768858] forcedeth 0000:00:07.0: ifname eth0, PHY OUI 0x1374 @ 1, add=
r 00:18:f3:aa:18:da
[    1.768933] forcedeth 0000:00:07.0: highdma pwrctl mgmt gbit lnktim msi =
desc-v3
[    1.769332] amd74xx 0000:00:06.0: UDMA133 controller
[    1.769385] amd74xx 0000:00:06.0: IDE controller (0x10de:0x03ec rev 0xa2)
[    1.769454] amd74xx 0000:00:06.0: IDE port disabled
[    1.769512] amd74xx 0000:00:06.0: BIOS didn't set cable bits correctly. =
Enabling workaround.
[    1.769584] amd74xx 0000:00:06.0: not 100% native mode: will probe irqs =
later
[    1.769642]     ide0: BM-DMA at 0xffa0-0xffa7
[    1.769695] Probing IDE interface ide0...
[    1.833076] firewire_core: created device fw0: GUID 0011d80000f46d61, S4=
00
[    2.056108] hda: WDC WD1600JB-00GVA0, ATA DISK drive
[    2.728061] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    2.729287] hda: UDMA/100 mode selected
[    2.730619] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.759472] ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 21
[    2.759527]   alloc irq_desc for 21 on cpu 0 node 0
[    2.759529]   alloc kstat_irqs on cpu 0 node 0
[    2.759538] ohci_hcd 0000:00:02.0: PCI INT A -> Link[LUB0] -> GSI 21 (le=
vel, low) -> IRQ 21
[    2.759643] ohci_hcd 0000:00:02.0: setting latency timer to 64
[    2.759646] ohci_hcd 0000:00:02.0: OHCI Host Controller
[    2.759774] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus =
number 2
[    2.759870] ohci_hcd 0000:00:02.0: irq 21, io mem 0xdfbff000
[    2.814017] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    2.814071] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.814140] usb usb2: Product: OHCI Host Controller
[    2.814191] usb usb2: Manufacturer: Linux 2.6.30-btrfsnewformat2 ohci_hcd
[    2.814245] usb usb2: SerialNumber: 0000:00:02.0
[    2.814344] usb usb2: configuration #1 chosen from 1 choice
[    2.814428] hub 2-0:1.0: USB hub found
[    2.814485] hub 2-0:1.0: 10 ports detected
[    2.827951] SCSI subsystem initialized
[    2.842229] libata version 3.00 loaded.
[    2.845771] sata_nv 0000:00:08.0: version 3.5
[    2.846109] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 20
[    2.846168]   alloc irq_desc for 20 on cpu 0 node 0
[    2.846170]   alloc kstat_irqs on cpu 0 node 0
[    2.846181] sata_nv 0000:00:08.0: PCI INT A -> Link[LSA0] -> GSI 20 (lev=
el, low) -> IRQ 20
[    2.846328] sata_nv 0000:00:08.0: setting latency timer to 64
[    2.846388] scsi0 : sata_nv
[    2.846542] scsi1 : sata_nv
[    2.846739] ata1: SATA max UDMA/133 cmd 0xb400 ctl 0xb080 bmdma 0xa880 i=
rq 20
[    2.846794] ata2: SATA max UDMA/133 cmd 0xb000 ctl 0xac00 bmdma 0xa888 i=
rq 20
[    2.847201] ACPI: PCI Interrupt Link [LSA1] enabled at IRQ 23
[    2.847254] sata_nv 0000:00:08.1: PCI INT B -> Link[LSA1] -> GSI 23 (lev=
el, low) -> IRQ 23
[    2.847366] sata_nv 0000:00:08.1: setting latency timer to 64
[    2.847411] scsi2 : sata_nv
[    2.847513] scsi3 : sata_nv
[    2.847705] ata3: SATA max UDMA/133 cmd 0xa800 ctl 0xa480 bmdma 0xa000 i=
rq 23
[    2.847761] ata4: SATA max UDMA/133 cmd 0xa400 ctl 0xa080 bmdma 0xa008 i=
rq 23
[    3.320036] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.329463] ata1.00: ATA-6: WDC WD1600JD-00GBB0, 02.05D02, max UDMA/100
[    3.329522] ata1.00: 312581808 sectors, multi 16: LBA48=20
[    3.329582] ata1.00: applying bridge limits
[    3.346458] ata1.00: configured for UDMA/100
[    3.346606] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JD-00G 02=
=2E0 PQ: 0 ANSI: 5
[    3.812034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.820114] ata2.00: ATAPI: TSSTcorp CDDVDW SH-S223F, SB03, max UDMA/100
[    3.836126] ata2.00: configured for UDMA/100
[    3.837614] scsi 1:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S223F  SB=
03 PQ: 0 ANSI: 5
[    4.161566] Driver 'sd' needs updating - please use bus_type methods
[    4.161754] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 =
GB/149 GiB)
[    4.161834] sd 0:0:0:0: [sda] Write Protect is off
[    4.161885] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.161901] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    4.162048]  sda:<6>ide-gd driver 1.18
[    4.164188] hda: max request size: 512KiB
[    4.165532] hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=3D19=
457/255/63
[    4.167641] hda: cache flushes supported
[    4.167751]  hda: hda1 hda2 hda3
[    4.181467]  sda1 sda2 sda3
[    4.204497] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.206826] Driver 'sr' needs updating - please use bus_type methods
[    4.210283] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    4.210359] Uniform CD-ROM driver Revision: 3.20
[    4.210525] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    4.217872] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.217958] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    4.660897] md: raid1 personality registered for level 1
[    4.662679] xor: automatically using best checksumming function: generic=
_sse
[    4.681007]    generic_sse:  7436.000 MB/sec
[    4.681057] xor: using function: generic_sse (7436.000 MB/sec)
[    4.681627] async_tx: api initialized (async)
[    4.749012] raid6: int64x1   2259 MB/s
[    4.817016] raid6: int64x2   2899 MB/s
[    4.885025] raid6: int64x4   2244 MB/s
[    4.953007] raid6: int64x8   1996 MB/s
[    5.021040] raid6: sse2x1    1191 MB/s
[    5.089013] raid6: sse2x2    1930 MB/s
[    5.157018] raid6: sse2x4    2841 MB/s
[    5.157066] raid6: using algorithm sse2x4 (2841 MB/s)
[    5.159972] md: raid6 personality registered for level 6
[    5.160045] md: raid5 personality registered for level 5
[    5.160096] md: raid4 personality registered for level 4
[    5.290515] md: md0 stopped.
[    5.347939] md: bind<hda1>
[    5.348175] md: bind<sda1>
[    5.349423] raid1: raid set md0 active with 2 out of 2 mirrors
[    5.354399]  md0: unknown partition table
[    5.514944] md: md1 stopped.
[    5.516495] md: bind<hda2>
[    5.516705] md: bind<sda2>
[    5.516769] md: md1: raid array is not clean -- starting background reco=
nstruction
[    5.518014] raid1: raid set md1 active with 2 out of 2 mirrors
[    5.519026]  md1: unknown partition table
[    5.557314] device-mapper: uevent: version 1.0.3
[    5.557819] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised:=
 dm-devel@redhat.com
[    5.655748] PM: Starting manual resume from disk
[    5.671079] EXT3-fs: INFO: recovery required on readonly filesystem.
[    5.671136] EXT3-fs: write access will be enabled during recovery.
[    5.952650] md: resync of RAID array md1
[    5.952700] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[    5.952763] md: using maximum available idle IO bandwidth (but not more =
than 200000 KB/sec) for resync.
[    5.958124] md: using 128k window, over a total of 151364352 blocks.
[    5.958189] md: resuming resync of md1 from checkpoint.
[    6.512355] kjournald starting.  Commit interval 5 seconds
[    6.512425] EXT3-fs: recovery complete.
[    6.541305] EXT3-fs: mounted filesystem with ordered data mode.
[    7.752614] udev: starting version 141
[    8.668004] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    8.668082] ACPI: Power Button [PWRF]
[    8.668210] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
C:00/input/input3
[    8.668287] ACPI: Power Button [PWRB]
[    8.793711] parport_pc 00:06: reported by Plug and Play ACPI
[    8.793811] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    8.978724] processor ACPI_CPU:00: registered as cooling_device0
[    8.978987] processor ACPI_CPU:01: registered as cooling_device1
[    9.046937] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    9.047813] k8temp 0000:00:18.3: Temperature readouts might be wrong - c=
heck erratum #141
[    9.415581] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    9.466091] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    9.547048] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x600
[    9.547120] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x700
[    9.950148] Error: Driver 'pcspkr' is already registered, aborting...
[    9.950591] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 22
[    9.950651] HDA Intel 0000:00:05.0: PCI INT B -> Link[LAZA] -> GSI 22 (l=
evel, low) -> IRQ 22
[    9.950908] HDA Intel 0000:00:05.0: setting latency timer to 64
[   10.699919] hda_codec: Unknown model for AD1988, trying auto-probe from =
BIOS...
[   10.700100] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:05.=
0/input/input5
[   12.701986] Adding 3943948k swap on /dev/sda3.  Priority:-1 extents:1 ac=
ross:3943948k=20
[   12.707413] Adding 3943948k swap on /dev/hda3.  Priority:-2 extents:1 ac=
ross:3943948k=20
[   12.831215] EXT3 FS on dm-0, internal journal
[   12.915406] loop: module loaded
[   13.787882] kjournald starting.  Commit interval 5 seconds
[   13.788331] EXT3 FS on md0, internal journal
[   13.788410] EXT3-fs: mounted filesystem with ordered data mode.
[   13.873331] EXT4-fs: barriers enabled
[   13.899862] kjournald2 starting: pid 2321, dev dm-3:8, commit interval 5=
 seconds
[   13.900308] EXT4 FS on dm-3, internal journal on dm-3:8
[   13.900362] EXT4-fs: delayed allocation enabled
[   13.900411] EXT4-fs: file extents enabled
[   13.901735] EXT4-fs: mballoc enabled
[   13.901795] EXT4-fs: recovery complete.
[   13.901995] EXT4-fs: mounted filesystem dm-3 with ordered data mode
[   14.765839] Bridge firewalling registered
[   14.782151] device eth1 entered promiscuous mode
[   14.924375] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[   14.980092] e1000e 0000:05:00.0: irq 27 for MSI/MSI-X
[   14.981795] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   18.319494] Loading iSCSI transport class v2.0-870.
[   18.350285] iscsi: registered transport (tcp)
[   18.427573] iscsi: registered transport (iser)
[   18.884528] RPC: Registered udp transport module.
[   18.884596] RPC: Registered tcp transport module.
[   18.916786] Slow work thread pool: Starting up
[   18.916903] Slow work thread pool: Ready
[   18.917023] FS-Cache: Loaded
[   18.957100] FS-Cache: Netfs 'nfs' registered for caching
[   18.986045] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   25.817014] br0: no IPv6 routers present
[   27.964012] torbr: no IPv6 routers present
[   81.636269] virbr1: starting userspace STP failed, starting kernel STP
[   81.781718] ip_tables: (C) 2000-2006 Netfilter Core Team
[   81.813041] svc: failed to register lockdv1 RPC service (errno 97).
[   81.813622] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recov=
ery directory
[   81.823563] NFSD: starting 90-second grace period
[   83.348105] tun: Universal TUN/TAP device driver, 1.6
[   83.348159] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   83.350945] device vnet0 entered promiscuous mode
[   83.352442] br0: port 2(vnet0) entering learning state
[   83.499660] br0: port 2(vnet0) entering disabled state
[   83.514343] device vnet0 left promiscuous mode
[   83.514399] br0: port 2(vnet0) entering disabled state
[   83.662348] lo: Disabled Privacy Extensions
[   91.713009] virbr1: no IPv6 routers present
[  138.738429] sata_mv 0000:04:04.0: version 1.28
[  138.738934] ACPI: PCI Interrupt Link [LNED] enabled at IRQ 17
[  138.738989]   alloc irq_desc for 17 on cpu 0 node 0
[  138.738991]   alloc kstat_irqs on cpu 0 node 0
[  138.739002] sata_mv 0000:04:04.0: PCI INT A -> Link[LNED] -> GSI 17 (lev=
el, low) -> IRQ 17
[  138.739298] sata_mv 0000:04:04.0: Gen-II 32 slots 8 ports SCSI mode IRQ =
via INTx
[  138.740415] scsi4 : sata_mv
[  138.741994] scsi5 : sata_mv
[  138.747654] scsi6 : sata_mv
[  138.748757] scsi7 : sata_mv
[  138.750564] scsi8 : sata_mv
[  138.751574] scsi9 : sata_mv
[  138.753611] scsi10 : sata_mv
[  138.753906] scsi11 : sata_mv
[  138.753998] ata5: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
2000 irq 17
[  138.754070] ata6: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
4000 irq 17
[  138.754141] ata7: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
6000 irq 17
[  138.754212] ata8: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe2=
8000 irq 17
[  138.754283] ata9: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe3=
2000 irq 17
[  138.754354] ata10: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
34000 irq 17
[  138.754425] ata11: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
36000 irq 17
[  138.754496] ata12: SATA max UDMA/133 mmio m1048576@0xdfe00000 port 0xdfe=
38000 irq 17
[  139.228034] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  139.260048] ata5.00: ATA-8: WDC WD5000AAKS-00A7B0, 01.03B01, max UDMA/133
[  139.260103] ata5.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  139.284063] ata5.00: configured for UDMA/133
[  139.284193] scsi 4:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 01=
=2E0 PQ: 0 ANSI: 5
[  139.284402] sd 4:0:0:0: Attached scsi generic sg2 type 0
[  139.284532] sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  139.284613] sd 4:0:0:0: [sdb] Write Protect is off
[  139.284664] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  139.284684] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  139.284848]  sdb:<6>ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  139.784049] ata6.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  139.784105] ata6.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  139.816069] ata6.00: configured for UDMA/133
[  139.816222] scsi 5:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  139.816455] sd 5:0:0:0: Attached scsi generic sg3 type 0
[  139.816512] sd 5:0:0:0: [sdc] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  139.816595] sd 5:0:0:0: [sdc] Write Protect is off
[  139.816646] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  139.816664] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  139.816834]  sdc:<6>ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  140.332048] ata7.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  140.332103] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  140.364063] ata7.00: configured for UDMA/133
[  140.364204] scsi 6:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  140.364444] sd 6:0:0:0: Attached scsi generic sg4 type 0
[  140.364457] sd 6:0:0:0: [sdd] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  140.364470] sd 6:0:0:0: [sdd] Write Protect is off
[  140.364472] sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[  140.364491] sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  140.364595]  sdd:<6>ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  140.881103] ata8.00: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[  140.881159] ata8.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  140.912063] ata8.00: configured for UDMA/133
[  140.912203] scsi 7:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12=
=2E0 PQ: 0 ANSI: 5
[  140.912409] sd 7:0:0:0: Attached scsi generic sg5 type 0
[  140.912539] sd 7:0:0:0: [sde] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  140.912622] sd 7:0:0:0: [sde] Write Protect is off
[  140.912675] sd 7:0:0:0: [sde] Mode Sense: 00 3a 00 00
[  140.912695] sd 7:0:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  140.912858]  sde:<6>ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[  141.404055] ata9.00: ATA-7: WDC WD5000AAKS-65TMA0, 12.01C01, max UDMA/133
[  141.404110] ata9.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  141.428069] ata9.00: configured for UDMA/133
[  141.428187] scsi 8:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-6 12=
=2E0 PQ: 0 ANSI: 5
[  141.428392] sd 8:0:0:0: Attached scsi generic sg6 type 0
[  141.428518] sd 8:0:0:0: [sdf] 976773168 512-byte hardware sectors: (500 =
GB/465 GiB)
[  141.428600] sd 8:0:0:0: [sdf] Write Protect is off
[  141.428651] sd 8:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[  141.428671] sd 8:0:0:0: [sdf] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[  141.428831]  sdf:<6>ata10: SATA link down (SStatus 0 SControl 300)
[  142.068033] ata11: SATA link down (SStatus 0 SControl 300)
[  142.388032] ata12: SATA link down (SStatus 0 SControl 300)
[  169.820109] ata5.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  169.820174] ata5.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  169.820175]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  169.820314] ata5.00: status: { DRDY }
[  169.820365] ata5: hard resetting link
[  170.296032] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  170.336062] ata5.00: configured for UDMA/133
[  170.336119] ata5: EH complete
[  170.819022] ata7.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  170.819089] ata7.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  170.819090]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  170.819238] ata7.00: status: { DRDY }
[  170.833995] ata7: hard resetting link
[  170.834002] ata6.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  170.834009] ata6.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  170.834010]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  170.834012] ata6.00: status: { DRDY }
[  170.834016] ata6: hard resetting link
[  171.308043] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  171.308047] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  171.364086] ata7.00: configured for UDMA/133
[  171.364089] ata6.00: configured for UDMA/133
[  171.364098] ata6: EH complete
[  171.364247] ata7: EH complete
[  171.819001] ata8.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  171.819063] ata8.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  171.819064]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  171.819200] ata8.00: status: { DRDY }
[  171.819250] ata8: hard resetting link
[  171.834715] ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  171.834778] ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  171.834779]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  171.834919] ata9.00: status: { DRDY }
[  171.834968] ata9: hard resetting link
[  172.039129]  sdb1
[  172.039280]  sdd1
[  172.039507] sd 4:0:0:0: [sdb] Attached SCSI disk
[  172.039532] sd 6:0:0:0: [sdd] Attached SCSI disk
[  172.039619]  sdc1
[  172.039778] sdd: detected capacity change from 0 to 500107862016
[  172.039782] sd 5:0:0:0: [sdc] Attached SCSI disk
[  172.300031] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  172.309352] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  172.348220] ata9.00: configured for UDMA/133
[  172.348282] ata9: EH complete
[  172.380062] ata8.00: configured for UDMA/133
[  172.380117] ata8: EH complete
[  202.834987] ata7.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 fr=
ozen
[  202.835052] ata6.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 fr=
ozen
[  202.835060] ata7.00: cmd 60/02:00:3f:00:00/00:00:00:00:00/40 tag 0 ncq 1=
024 in
[  202.835062]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  202.835066] ata7.00: status: { DRDY }
[  202.835072] ata7.00: cmd 60/1e:08:41:00:00/00:00:00:00:00/40 tag 1 ncq 1=
5360 in
[  202.835073]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  202.835075] ata7.00: status: { DRDY }
[  202.835080] ata7: hard resetting link
[  202.835544] ata6.00: cmd 60/02:00:3f:00:00/00:00:00:00:00/40 tag 0 ncq 1=
024 in
[  202.835545]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  202.835692] ata6.00: status: { DRDY }
[  202.835747] ata6.00: cmd 60/1e:08:41:00:00/00:00:00:00:00/40 tag 1 ncq 1=
5360 in
[  202.835749]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  202.841204] ata6.00: status: { DRDY }
[  202.850515] ata5.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 fr=
ozen
[  202.850575] ata5.00: cmd 60/02:00:3f:00:00/00:00:00:00:00/40 tag 0 ncq 1=
024 in
[  202.850576]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  202.850580] ata6: hard resetting link
[  202.850766] ata5.00: status: { DRDY }
[  202.850818] ata5.00: cmd 60/1e:08:41:00:00/00:00:00:00:00/40 tag 1 ncq 1=
5360 in
[  202.850819]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  202.850955] ata5.00: status: { DRDY }
[  202.851004] ata5: hard resetting link
[  202.866165] ata9.00: NCQ disabled due to excessive errors
[  202.866218] ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  202.866277] ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  202.866278]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  202.866414] ata9.00: status: { DRDY }
[  202.866463] ata9: hard resetting link
[  202.881980] ata8.00: NCQ disabled due to excessive errors
[  202.882032] ata8.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen
[  202.882091] ata8.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4=
096 in
[  202.882092]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  202.882231] ata8.00: status: { DRDY }
[  202.882280] ata8: hard resetting link
[  203.320031] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  203.332027] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  203.348036] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  203.348224] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  203.357464] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  203.368282] ata5.00: configured for UDMA/133
[  203.368342] ata5: EH complete
[  203.384064] ata7.00: configured for UDMA/133
[  203.384119] ata7: EH complete
[  203.388210] ata9.00: configured for UDMA/133
[  203.388271] ata9: EH complete
[  203.412381] ata6.00: configured for UDMA/133
[  203.412436] ata6: EH complete
[  203.429059] ata8.00: configured for UDMA/133
[  203.429113] ata8: EH complete
[  233.835050] ata9: limiting SATA link speed to 1.5 Gbps
[  233.835108] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  233.835123] ata8: limiting SATA link speed to 1.5 Gbps
[  233.835127] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  233.835134] ata8.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  233.835135]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  233.835138] ata8.00: status: { DRDY }
[  233.835142] ata8: hard resetting link
[  233.835505] ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  233.835506]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  233.835645] ata9.00: status: { DRDY }
[  233.850623] ata6.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 fr=
ozen
[  233.850686] ata6.00: cmd 60/1e:00:41:00:00/00:00:00:00:00/40 tag 0 ncq 1=
5360 in
[  233.850687]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  233.850691] ata9: hard resetting link
[  233.850874] ata6.00: status: { DRDY }
[  233.850926] ata6.00: cmd 60/02:08:3f:00:00/00:00:00:00:00/40 tag 1 ncq 1=
024 in
[  233.850927]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  233.851064] ata6.00: status: { DRDY }
[  233.851113] ata6: hard resetting link
[  233.866571] ata5.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 fr=
ozen
[  233.866643] ata5.00: cmd 60/1e:00:41:00:00/00:00:00:00:00/40 tag 0 ncq 1=
5360 in
[  233.866644]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  233.866815] ata5.00: status: { DRDY }
[  233.866878] ata5.00: cmd 60/02:08:3f:00:00/00:00:00:00:00/40 tag 1 ncq 1=
024 in
[  233.866880]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  233.867027] ata5.00: status: { DRDY }
[  233.867076] ata5: hard resetting link
[  233.882534] ata7.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 fr=
ozen
[  233.882595] ata7.00: cmd 60/1e:00:41:00:00/00:00:00:00:00/40 tag 0 ncq 1=
5360 in
[  233.882596]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  233.882737] ata7.00: status: { DRDY }
[  233.882789] ata7.00: cmd 60/02:08:3f:00:00/00:00:00:00:00/40 tag 1 ncq 1=
024 in
[  233.882791]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  233.882930] ata7.00: status: { DRDY }
[  233.882979] ata7: hard resetting link
[  234.324031] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  234.348035] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  234.348235] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  234.348355] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  234.356679] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  234.365066] ata9.00: configured for UDMA/133
[  234.365126] ata9: EH complete
[  234.396438] ata5.00: configured for UDMA/133
[  234.396495] ata5: EH complete
[  234.412230] ata6.00: configured for UDMA/133
[  234.412285] ata6: EH complete
[  234.420093] ata7.00: configured for UDMA/133
[  234.420148] ata7: EH complete
[  234.420225] ata8.00: configured for UDMA/133
[  234.420278] ata8: EH complete
[  264.833977] ata9.00: limiting speed to UDMA/100:PIO4
[  264.833982] ata5.00: NCQ disabled due to excessive errors
[  264.833988] ata5.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 fr=
ozen
[  264.833995] ata5.00: cmd 60/02:00:3f:00:00/00:00:00:00:00/40 tag 0 ncq 1=
024 in
[  264.833996]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  264.833998] ata5.00: status: { DRDY }
[  264.834003] ata5.00: cmd 60/1e:08:41:00:00/00:00:00:00:00/40 tag 1 ncq 1=
5360 in
[  264.834005]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  264.834007] ata5.00: status: { DRDY }
[  264.834011] ata5: hard resetting link
[  264.834561] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  264.834626] ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  264.834627]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  264.834773] ata9.00: status: { DRDY }
[  264.849444] ata9: hard resetting link
[  264.849447] ata6.00: NCQ disabled due to excessive errors
[  264.849450] ata6.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 fr=
ozen
[  264.849456] ata6.00: cmd 60/02:00:3f:00:00/00:00:00:00:00/40 tag 0 ncq 1=
024 in
[  264.849457]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  264.849459] ata6.00: status: { DRDY }
[  264.849464] ata6.00: cmd 60/1e:08:41:00:00/00:00:00:00:00/40 tag 1 ncq 1=
5360 in
[  264.849465]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  264.849467] ata6.00: status: { DRDY }
[  264.849470] ata6: hard resetting link
[  264.864888] ata7.00: NCQ disabled due to excessive errors
[  264.864958] ata7.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 fr=
ozen
[  264.865032] ata7.00: cmd 60/02:00:3f:00:00/00:00:00:00:00/40 tag 0 ncq 1=
024 in
[  264.865034]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  264.865203] ata7.00: status: { DRDY }
[  264.865264] ata7.00: cmd 60/1e:08:41:00:00/00:00:00:00:00/40 tag 1 ncq 1=
5360 in
[  264.865266]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  264.865437] ata7.00: status: { DRDY }
[  264.865498] ata7: hard resetting link
[  264.880956] ata8.00: limiting speed to UDMA/100:PIO4
[  264.881026] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
[  264.881098] ata8.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
[  264.881099]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (=
timeout)
[  264.881268] ata8.00: status: { DRDY }
[  264.881327] ata8: hard resetting link
[  265.324033] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  265.348038] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  265.348258] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  265.348381] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  265.356842] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  265.365078] ata9.00: configured for UDMA/100
[  265.365135] ata9: EH complete
[  265.396417] ata5.00: configured for UDMA/133
[  265.396475] ata5: EH complete
[  265.412430] ata6.00: configured for UDMA/133
[  265.412484] ata6: EH complete
[  265.428381] ata7.00: configured for UDMA/133
[  265.428439] ata7: EH complete
[  265.444062] ata8.00: configured for UDMA/100
[  265.444114] ata8: EH complete

--4ickEXl+ukcSQ/3E--

--WOTjKnJ88wpJKlWH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFKefNC1zX4pjkhuygRAqfMAJ9Rxu5lfS0mKE5PNGkMkKxYshfclACbBYQE
bY2Qlo2SBFIqOOZnYkOOSs8=
=pwnZ
-----END PGP SIGNATURE-----

--WOTjKnJ88wpJKlWH--
