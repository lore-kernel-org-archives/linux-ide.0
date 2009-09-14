From: Grant Grundler <grundler@google.com>
Subject: Re:
Date: Mon, 14 Sep 2009 13:54:18 -0700
Message-ID: <da824cf30909141354q35eefeefi720a56f3e4596c60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:28217 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756796AbZINUyY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Sep 2009 16:54:24 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id n8EKsOxU027085
	for <linux-ide@vger.kernel.org>; Mon, 14 Sep 2009 21:54:25 +0100
Received: from pzk28 (pzk28.prod.google.com [10.243.19.156])
	by zps78.corp.google.com with ESMTP id n8EKsLt5020276
	for <linux-ide@vger.kernel.org>; Mon, 14 Sep 2009 13:54:22 -0700
Received: by pzk28 with SMTP id 28so2795282pzk.20
        for <linux-ide@vger.kernel.org>; Mon, 14 Sep 2009 13:54:21 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cyber Source <peter@cybersource.us>
Cc: linux-ide@vger.kernel.org

+linux-ide

Please keep linux-ide CC'd - I'm really not that good at debugging
SATA mysteries without a protocol analyzer (and just average even
then).


On Thu, Sep 10, 2009 at 2:26 PM, Cyber Source <peter@cybersource.us> wr=
ote:
> Ok Grant,
> I've attached the dmesg from that laptop after booting the 2.6.30 ker=
nel
> that was patched with the 2.6.31-rc9 patch. I think you may be right,=
 in
> that it's using the workaround, I still see it bitching but it appear=
s to
> have a some new items in the log.

Ok.

> After patching this kernel, I put the
> existing .config in place using , make oldconfig, that was from the l=
atest
> stock ubuntu jaunty kernel and afterwards it had a thousand questions=
 in
> which I just held down the enter key to accept all the defaults.

That's a reasonable way to normally do it.

>The
> backlight doesnt seem to work and the wireless no longer works, which=
 makes
> me think something didnt come across right from the make oldconfig.

You'll have to create a diff of the two .config files and start
guessing which ones matter.


> Your
> thoughts on this POS? TIA, Peter
>
=2E..
> [ =C2=A0 =C2=A00.000000] Initializing cgroup subsys cpuset
> [ =C2=A0 =C2=A00.000000] Initializing cgroup subsys cpu
> [ =C2=A0 =C2=A00.000000] Linux version 2.6.31-rc9-open-linux-custom (=
root@Dolan) (gcc
> version 4.3.3 (Ubuntu 4.3.3-5ubuntu4) ) #1 SMP Wed Sep 9 14:28:05 EDT=
 2009
> [ =C2=A0 =C2=A00.000000] KERNEL supported cpus:
> [ =C2=A0 =C2=A00.000000] =C2=A0 Intel GenuineIntel
> [ =C2=A0 =C2=A00.000000] =C2=A0 AMD AuthenticAMD
> [ =C2=A0 =C2=A00.000000] =C2=A0 NSC Geode by NSC
> [ =C2=A0 =C2=A00.000000] =C2=A0 Cyrix CyrixInstead
> [ =C2=A0 =C2=A00.000000] =C2=A0 Centaur CentaurHauls
> [ =C2=A0 =C2=A00.000000] =C2=A0 Transmeta GenuineTMx86
> [ =C2=A0 =C2=A00.000000] =C2=A0 Transmeta TransmetaCPU
> [ =C2=A0 =C2=A00.000000] =C2=A0 UMC UMC UMC UMC
> [ =C2=A0 =C2=A00.000000] BIOS-provided physical RAM map:
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 0000000000000000 - 00000000=
0009dc00 (usable)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 000000000009dc00 - 00000000=
000a0000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000000ce000 - 00000000=
00100000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 0000000000100000 - 00000000=
7be60000 (usable)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 000000007be60000 - 00000000=
7be70000 (ACPI data)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 000000007be70000 - 00000000=
7be72000 (ACPI NVS)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 000000007be72000 - 00000000=
7beff000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 000000007bf00000 - 00000000=
80000000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000e0000000 - 00000000=
f0000000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000fec00000 - 00000000=
fec10000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000fee00000 - 00000000=
fee01000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000fff00000 - 00000001=
00000000 (reserved)
> [ =C2=A0 =C2=A00.000000] DMI present.
> [ =C2=A0 =C2=A00.000000] last_pfn =3D 0x7be60 max_arch_pfn =3D 0x1000=
00
> [ =C2=A0 =C2=A00.000000] MTRR default type: uncachable
> [ =C2=A0 =C2=A00.000000] MTRR fixed ranges enabled:
> [ =C2=A0 =C2=A00.000000] =C2=A0 00000-9FFFF write-back
> [ =C2=A0 =C2=A00.000000] =C2=A0 A0000-BFFFF uncachable
> [ =C2=A0 =C2=A00.000000] =C2=A0 C0000-CDFFF write-protect
> [ =C2=A0 =C2=A00.000000] =C2=A0 CE000-DFFFF uncachable
> [ =C2=A0 =C2=A00.000000] =C2=A0 E0000-FFFFF write-protect
> [ =C2=A0 =C2=A00.000000] MTRR variable ranges enabled:
> [ =C2=A0 =C2=A00.000000] =C2=A0 0 base 0000000000 mask FF80000000 wri=
te-back
> [ =C2=A0 =C2=A00.000000] =C2=A0 1 disabled
> [ =C2=A0 =C2=A00.000000] =C2=A0 2 disabled
> [ =C2=A0 =C2=A00.000000] =C2=A0 3 disabled
> [ =C2=A0 =C2=A00.000000] =C2=A0 4 disabled
> [ =C2=A0 =C2=A00.000000] =C2=A0 5 disabled
> [ =C2=A0 =C2=A00.000000] =C2=A0 6 disabled
> [ =C2=A0 =C2=A00.000000] =C2=A0 7 disabled
> [ =C2=A0 =C2=A00.000000] e820 update range: 0000000000002000 - 000000=
0000006000
> (usable) =3D=3D> (reserved)
> [ =C2=A0 =C2=A00.000000] Scanning 1 areas for low memory corruption
> [ =C2=A0 =C2=A00.000000] modified physical RAM map:
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 0000000000000000 - 000000000=
0002000 (usable)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 0000000000002000 - 000000000=
0006000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 0000000000006000 - 000000000=
009dc00 (usable)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 000000000009dc00 - 000000000=
00a0000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 00000000000ce000 - 000000000=
0100000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 0000000000100000 - 000000007=
be60000 (usable)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 000000007be60000 - 000000007=
be70000 (ACPI data)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 000000007be70000 - 000000007=
be72000 (ACPI NVS)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 000000007be72000 - 000000007=
beff000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 000000007bf00000 - 000000008=
0000000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 00000000e0000000 - 00000000f=
0000000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 00000000fec00000 - 00000000f=
ec10000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 00000000fee00000 - 00000000f=
ee01000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0modified: 00000000fff00000 - 000000010=
0000000 (reserved)
> [ =C2=A0 =C2=A00.000000] initial memory mapped : 0 - 00c00000
> [ =C2=A0 =C2=A00.000000] init_memory_mapping: 0000000000000000-000000=
00377fe000
> [ =C2=A0 =C2=A00.000000] =C2=A00000000000 - 0000400000 page 4k
> [ =C2=A0 =C2=A00.000000] =C2=A00000400000 - 0037400000 page 2M
> [ =C2=A0 =C2=A00.000000] =C2=A00037400000 - 00377fe000 page 4k
> [ =C2=A0 =C2=A00.000000] kernel direct mapping tables up to 377fe000 =
@ 7000-c000
> [ =C2=A0 =C2=A00.000000] RAMDISK: 34f86000 - 37fef2c1
> [ =C2=A0 =C2=A00.000000] Allocated new RAMDISK: 00892000 - 038fb2c1
> [ =C2=A0 =C2=A00.000000] Move RAMDISK from 0000000034f86000 - 0000000=
037fef2c0 to
> 00892000 - 038fb2c0
> [ =C2=A0 =C2=A00.000000] ACPI: RSDP 000f7bc0 00024 (v02 GATEWA)
> [ =C2=A0 =C2=A00.000000] ACPI: XSDT 7be680be 0007C (v01 GATEWA SYSTEM=
 =C2=A0 06040000 =C2=A0LTP
> 00000000)
> [ =C2=A0 =C2=A00.000000] ACPI: FACP 7be6f4fc 000F4 (v03 ATI =C2=A0 =C2=
=A0Moray =C2=A0 =C2=A006040000 ATI
> =C2=A0000F4240)
> [ =C2=A0 =C2=A00.000000] ACPI: DSDT 7be6813a 073C2 (v01 GATEWA =C2=A0=
 SYSTEM 06040000 MSFT
> 03000000)
> [ =C2=A0 =C2=A00.000000] ACPI: FACS 7be71fc0 00040
> [ =C2=A0 =C2=A00.000000] ACPI: SLIC 7be6f664 00176 (v01 GATEWA SYSTEM=
 =C2=A0 06040000 LOHR
> 00000000)
> [ =C2=A0 =C2=A00.000000] ACPI: EINJ 7be6f7da 001B0 (v01 PTL =C2=A0 =C2=
=A0WHEAPTL =C2=A006040000 PTL
> =C2=A000000001)
> [ =C2=A0 =C2=A00.000000] ACPI: HEST 7be6f98a 00168 (v01 PTL =C2=A0 =C2=
=A0WHEAPTL =C2=A006040000 PTL
> =C2=A000000001)
> [ =C2=A0 =C2=A00.000000] ACPI: BERT 7be6faf2 00030 (v01 PTL =C2=A0 =C2=
=A0WHEAPTL =C2=A006040000 PTL
> =C2=A000000001)
> [ =C2=A0 =C2=A00.000000] ACPI: SSDT 7be6fb22 000E1 (v01 wheaos =C2=A0=
wheaosc 06040000 INTL
> 20050624)
> [ =C2=A0 =C2=A00.000000] ACPI: ERST 7be6fc03 00270 (v01 PTL =C2=A0 =C2=
=A0WHEAPTL =C2=A006040000 PTL
> =C2=A000000001)
> [ =C2=A0 =C2=A00.000000] ACPI: SSDT 7be6fe73 000D3 (v01 AMD =C2=A0 =C2=
=A0POWERNOW 06040000 AMD
> =C2=A000000001)
> [ =C2=A0 =C2=A00.000000] ACPI: APIC 7be6ff46 00046 (v01 PTLTD =C2=A0 =
=C2=A0 =C2=A0APIC =C2=A0 06040000
> =C2=A0LTP 00000000)
> [ =C2=A0 =C2=A00.000000] ACPI: MCFG 7be6ff8c 0003C (v01 PTLTD =C2=A0 =
=C2=A0MCFG =C2=A0 06040000 =C2=A0LTP
> 00000000)
> [ =C2=A0 =C2=A00.000000] ACPI: HPET 7be6ffc8 00038 (v01 PTLTD =C2=A0H=
PETTBL =C2=A006040000 =C2=A0LTP
> 00000001)
> [ =C2=A0 =C2=A00.000000] ACPI: Local APIC address 0xfee00000
> [ =C2=A0 =C2=A00.000000] 1094MB HIGHMEM available.
> [ =C2=A0 =C2=A00.000000] 887MB LOWMEM available.
> [ =C2=A0 =C2=A00.000000] =C2=A0 mapped low ram: 0 - 377fe000
> [ =C2=A0 =C2=A00.000000] =C2=A0 low ram: 0 - 377fe000
> [ =C2=A0 =C2=A00.000000] =C2=A0 node 0 low ram: 00000000 - 377fe000
> [ =C2=A0 =C2=A00.000000] =C2=A0 node 0 bootmap 00008000 - 0000ef00
> [ =C2=A0 =C2=A00.000000] (9 early reservations) =3D=3D> bootmem [0000=
000000 - 00377fe000]
> [ =C2=A0 =C2=A00.000000] =C2=A0 #0 [0000000000 - 0000001000] =C2=A0 B=
IOS data page =3D=3D>
> [0000000000 - 0000001000]
> [ =C2=A0 =C2=A00.000000] =C2=A0 #1 [0000001000 - 0000002000] =C2=A0 =C2=
=A0EX TRAMPOLINE =3D=3D>
> [0000001000 - 0000002000]
> [ =C2=A0 =C2=A00.000000] =C2=A0 #2 [0000006000 - 0000007000] =C2=A0 =C2=
=A0 =C2=A0 TRAMPOLINE =3D=3D>
> [0000006000 - 0000007000]
> [ =C2=A0 =C2=A00.000000] =C2=A0 #3 [0000100000 - 000088d278] =C2=A0 =C2=
=A0TEXT DATA BSS =3D=3D>
> [0000100000 - 000088d278]
> [ =C2=A0 =C2=A00.000000] =C2=A0 #4 [000009dc00 - 0000100000] =C2=A0 =C2=
=A0BIOS reserved =3D=3D>
> [000009dc00 - 0000100000]
> [ =C2=A0 =C2=A00.000000] =C2=A0 #5 [000088e000 - 0000891150] =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BRK =3D=3D>
> [000088e000 - 0000891150]
> [ =C2=A0 =C2=A00.000000] =C2=A0 #6 [0000007000 - 0000008000] =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0PGTABLE =3D=3D>
> [0000007000 - 0000008000]
> [ =C2=A0 =C2=A00.000000] =C2=A0 #7 [0000892000 - 00038fb2c1] =C2=A0 =C2=
=A0 =C2=A0NEW RAMDISK =3D=3D>
> [0000892000 - 00038fb2c1]
> [ =C2=A0 =C2=A00.000000] =C2=A0 #8 [0000008000 - 000000f000] =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0BOOTMAP =3D=3D>
> [0000008000 - 000000f000]
> [ =C2=A0 =C2=A00.000000] found SMP MP-table at [c00f7c80] f7c80
> [ =C2=A0 =C2=A00.000000] Zone PFN ranges:
> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA =C2=A0 =C2=A0 =C2=A00x00000000 ->=
 0x00001000
> [ =C2=A0 =C2=A00.000000] =C2=A0 Normal =C2=A0 0x00001000 -> 0x000377f=
e
> [ =C2=A0 =C2=A00.000000] =C2=A0 HighMem =C2=A00x000377fe -> 0x0007be6=
0
> [ =C2=A0 =C2=A00.000000] Movable zone start PFN for each node
> [ =C2=A0 =C2=A00.000000] early_node_map[3] active PFN ranges
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 0: 0x00000000 -> 0x00000002
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 0: 0x00000006 -> 0x0000009d
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 0: 0x00000100 -> 0x0007be60
> [ =C2=A0 =C2=A00.000000] On node 0 totalpages: 507385
> [ =C2=A0 =C2=A00.000000] free_area_init_node: node 0, pgdat c075e480,=
 node_mem_map
> c38fc000
> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 32 pages used for memmap
> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 0 pages reserved
> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 3961 pages, LIFO batch:0
> [ =C2=A0 =C2=A00.000000] =C2=A0 Normal zone: 1744 pages used for memm=
ap
> [ =C2=A0 =C2=A00.000000] =C2=A0 Normal zone: 221486 pages, LIFO batch=
:31
> [ =C2=A0 =C2=A00.000000] =C2=A0 HighMem zone: 2189 pages used for mem=
map
> [ =C2=A0 =C2=A00.000000] =C2=A0 HighMem zone: 277973 pages, LIFO batc=
h:31
> [ =C2=A0 =C2=A00.000000] Using APIC driver default
> [ =C2=A0 =C2=A00.000000] Detected use of extended apic ids on hypertr=
ansport bus
> [ =C2=A0 =C2=A00.000000] ACPI: PM-Timer IO Port: 0x8008
> [ =C2=A0 =C2=A00.000000] ACPI: Local APIC address 0xfee00000
> [ =C2=A0 =C2=A00.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] en=
abled)
> [ =C2=A0 =C2=A00.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lin=
t[0x1])
> [ =C2=A0 =C2=A00.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] g=
si_base[0])
> [ =C2=A0 =C2=A00.000000] IOAPIC[0]: apic_id 1, version 33, address 0x=
fec00000, GSI
> 0-23
> [ =C2=A0 =C2=A00.000000] ACPI: IRQ9 used by override.
> [ =C2=A0 =C2=A00.000000] Enabling APIC mode: =C2=A0Flat. =C2=A0Using =
1 I/O APICs
> [ =C2=A0 =C2=A00.000000] Using ACPI (MADT) for SMP configuration info=
rmation
> [ =C2=A0 =C2=A00.000000] ACPI: HPET id: 0x43538310 base: 0xfed00000
> [ =C2=A0 =C2=A00.000000] SMP: Allowing 1 CPUs, 0 hotplug CPUs
> [ =C2=A0 =C2=A00.000000] nr_irqs_gsi: 24
> [ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: 00000000000020=
00 -
> 0000000000006000
> [ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: 000000000009d0=
00 -
> 000000000009e000
> [ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: 000000000009e0=
00 -
> 00000000000a0000
> [ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: 00000000000a00=
00 -
> 00000000000ce000
> [ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: 00000000000ce0=
00 -
> 0000000000100000
> [ =C2=A0 =C2=A00.000000] Allocating PCI resources starting at 8000000=
0 (gap:
> 80000000:60000000)
> [ =C2=A0 =C2=A00.000000] NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_=
node_ids:1
> [ =C2=A0 =C2=A00.000000] PERCPU: Embedded 14 pages at c4886000, stati=
c data 35356
> bytes
> [ =C2=A0 =C2=A00.000000] Built 1 zonelists in Zone order, mobility gr=
ouping on. =C2=A0Total
> pages: 503420
> [ =C2=A0 =C2=A00.000000] Kernel command line:
> root=3DUUID=3Dcad17313-d790-439d-93fb-184bc0fa0de3 ro quiet splash
> [ =C2=A0 =C2=A00.000000] PID hash table entries: 4096 (order: 12, 163=
84 bytes)
> [ =C2=A0 =C2=A00.000000] Dentry cache hash table entries: 131072 (ord=
er: 7, 524288
> bytes)
> [ =C2=A0 =C2=A00.000000] Inode-cache hash table entries: 65536 (order=
: 6, 262144
> bytes)
> [ =C2=A0 =C2=A00.000000] Enabling fast FPU save and restore... done.
> [ =C2=A0 =C2=A00.000000] Enabling unmasked SIMD FPU exception support=
=2E.. done.
> [ =C2=A0 =C2=A00.000000] Initializing CPU#0
> [ =C2=A0 =C2=A00.000000] allocated 10149760 bytes of page_cgroup
> [ =C2=A0 =C2=A00.000000] please try 'cgroup_disable=3Dmemory' option =
if you don't want
> memory cgroups
> [ =C2=A0 =C2=A00.000000] Initializing HighMem for node 0 (000377fe:00=
07be60)
> [ =C2=A0 =C2=A00.000000] Memory: 1944608k/2029952k available (4519k k=
ernel code,
> 84028k reserved, 2035k data, 536k init, 1120648k highmem)
> [ =C2=A0 =C2=A00.000000] virtual kernel memory layout:
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 fixmap =C2=A0: 0xfff1e000 - 0x=
fffff000 =C2=A0 ( 900 kB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 pkmap =C2=A0 : 0xff800000 - 0x=
ffc00000 =C2=A0 (4096 kB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 vmalloc : 0xf7ffe000 - 0xff7fe=
000 =C2=A0 ( 120 MB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 lowmem =C2=A0: 0xc0000000 - 0x=
f77fe000 =C2=A0 ( 887 MB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 =C2=A0 .init : 0xc0767000 - 0x=
c07ed000 =C2=A0 ( 536 kB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 =C2=A0 .data : 0xc0569ca1 - 0x=
c0766c48 =C2=A0 (2035 kB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 =C2=A0 .text : 0xc0100000 - 0x=
c0569ca1 =C2=A0 (4519 kB)
> [ =C2=A0 =C2=A00.000000] Checking if this processor honours the WP bi=
t even in
> supervisor mode...Ok.
> [ =C2=A0 =C2=A00.000000] SLUB: Genslabs=3D13, HWalign=3D64, Order=3D0=
-3, MinObjects=3D0,
> CPUs=3D1, Nodes=3D1
> [ =C2=A0 =C2=A00.000000] NR_IRQS:512
> [ =C2=A0 =C2=A00.000000] Fast TSC calibration using PIT
> [ =C2=A0 =C2=A00.000000] Detected 1596.310 MHz processor.
> [ =C2=A0 =C2=A00.000760] Console: colour VGA+ 80x25
> [ =C2=A0 =C2=A00.000764] console [tty0] enabled
> [ =C2=A0 =C2=A00.000999] hpet clockevent registered
> [ =C2=A0 =C2=A00.000999] HPET: 4 timers in total, 0 timers will be us=
ed for per-cpu
> timer
> [ =C2=A0 =C2=A00.001008] Calibrating delay loop (skipped), value calc=
ulated using
> timer frequency.. 3192.62 BogoMIPS (lpj=3D1596310)
> [ =C2=A0 =C2=A00.001032] Security Framework initialized
> [ =C2=A0 =C2=A00.001039] SELinux: =C2=A0Disabled at boot.
> [ =C2=A0 =C2=A00.001047] Mount-cache hash table entries: 512
> [ =C2=A0 =C2=A00.001195] Initializing cgroup subsys ns
> [ =C2=A0 =C2=A00.001199] Initializing cgroup subsys cpuacct
> [ =C2=A0 =C2=A00.001204] Initializing cgroup subsys memory
> [ =C2=A0 =C2=A00.001212] Initializing cgroup subsys freezer
> [ =C2=A0 =C2=A00.001227] CPU: L1 I Cache: 64K (64 bytes/line), D cach=
e 64K (64
> bytes/line)
> [ =C2=A0 =C2=A00.001230] CPU: L2 Cache: 512K (64 bytes/line)
> [ =C2=A0 =C2=A00.001234] using C1E aware idle routine
> [ =C2=A0 =C2=A00.001243] Performance Counters: AMD PMU driver.
> [ =C2=A0 =C2=A00.001250] ... version: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0
> [ =C2=A0 =C2=A00.001252] ... bit width: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 48
> [ =C2=A0 =C2=A00.001254] ... generic counters: =C2=A0 =C2=A0 =C2=A0 =C2=
=A04
> [ =C2=A0 =C2=A00.001256] ... value mask: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00000ffffffffffff
> [ =C2=A0 =C2=A00.001259] ... max period: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A000007fffffffffff
> [ =C2=A0 =C2=A00.001261] ... fixed-purpose counters: =C2=A00
> [ =C2=A0 =C2=A00.001263] ... counter mask: =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0000000000000000f
> [ =C2=A0 =C2=A00.001268] Checking 'hlt' instruction... OK.
> [ =C2=A0 =C2=A00.005620] SMP alternatives: switching to UP code
> [ =C2=A0 =C2=A00.013306] Freeing SMP alternatives: 20k freed
> [ =C2=A0 =C2=A00.013326] ACPI: Core revision 20090521
> [ =C2=A0 =C2=A00.027425] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D0 ap=
ic2=3D-1 pin2=3D-1
> [ =C2=A0 =C2=A00.027995] ..MP-BIOS bug: 8254 timer not connected to I=
O-APIC
> [ =C2=A0 =C2=A00.027995] ...trying to set up timer (IRQ0) through the=
 8259A ...
> [ =C2=A0 =C2=A00.027995] ..... (found apic 0 pin 0) ...
> [ =C2=A0 =C2=A00.038677] ....... works.
> [ =C2=A0 =C2=A00.038679] CPU0: AMD Athlon(tm) Processor 2650e steppin=
g 02
> [ =C2=A0 =C2=A00.038994] Brought up 1 CPUs
> [ =C2=A0 =C2=A00.038994] Total of 1 processors activated (3192.62 Bog=
oMIPS).
> [ =C2=A0 =C2=A00.038994] CPU0 attaching NULL sched-domain.
> [ =C2=A0 =C2=A00.038994] Booting paravirtualized kernel on bare hardw=
are
> [ =C2=A0 =C2=A00.038994] regulator: core version 0.5
> [ =C2=A0 =C2=A00.038994] Time: 17:19:19 =C2=A0Date: 09/10/09
> [ =C2=A0 =C2=A00.038994] NET: Registered protocol family 16
> [ =C2=A0 =C2=A00.038994] EISA bus registered
> [ =C2=A0 =C2=A00.038994] ACPI: bus type pci registered
> [ =C2=A0 =C2=A00.038994] PCI: MCFG configuration 0: base e0000000 seg=
ment 0 buses 0 -
> 9
> [ =C2=A0 =C2=A00.038994] PCI: MCFG area at e0000000 reserved in E820
> [ =C2=A0 =C2=A00.038994] PCI: Using MMCONFIG for extended config spac=
e
> [ =C2=A0 =C2=A00.038994] PCI: Using configuration type 1 for base acc=
ess
> [ =C2=A0 =C2=A00.039935] bio: create slab <bio-0> at 0
> [ =C2=A0 =C2=A00.040677] ACPI: EC: Look up EC in DSDT
> [ =C2=A0 =C2=A00.044893] ACPI: BIOS _OSI(Linux) query ignored
> [ =C2=A0 =C2=A00.046170] ACPI: Interpreter enabled
> [ =C2=A0 =C2=A00.046176] ACPI: (supports S0 S3 S4 S5)
> [ =C2=A0 =C2=A00.046197] ACPI: Using IOAPIC for interrupt routing
> [ =C2=A0 =C2=A00.051178] ACPI: EC: non-query interrupt received, swit=
ching to
> interrupt mode
> [ =C2=A0 =C2=A00.118457] ACPI: EC: GPE =3D 0x10, I/O: command/status =
=3D 0x66, data =3D 0x62
> [ =C2=A0 =C2=A00.118460] ACPI: EC: driver started in interrupt mode
> [ =C2=A0 =C2=A00.118879] ACPI: No dock devices found.
> [ =C2=A0 =C2=A00.120637] ACPI: PCI Root Bridge [PCI0] (0000:00)
> [ =C2=A0 =C2=A00.120758] pci 0000:00:06.0: PME# supported from D0 D3h=
ot D3cold
> [ =C2=A0 =C2=A00.120762] pci 0000:00:06.0: PME# disabled
> [ =C2=A0 =C2=A00.120794] pci 0000:00:07.0: PME# supported from D0 D3h=
ot D3cold
> [ =C2=A0 =C2=A00.120798] pci 0000:00:07.0: PME# disabled
> [ =C2=A0 =C2=A00.120853] pci 0000:00:12.0: reg 10 io port: [0x8440-0x=
8447]
> [ =C2=A0 =C2=A00.120861] pci 0000:00:12.0: reg 14 io port: [0x8434-0x=
8437]
> [ =C2=A0 =C2=A00.120870] pci 0000:00:12.0: reg 18 io port: [0x8438-0x=
843f]
> [ =C2=A0 =C2=A00.120878] pci 0000:00:12.0: reg 1c io port: [0x8430-0x=
8433]
> [ =C2=A0 =C2=A00.120887] pci 0000:00:12.0: reg 20 io port: [0x8400-0x=
840f]
> [ =C2=A0 =C2=A00.120895] pci 0000:00:12.0: reg 24 32bit mmio: [0xfc60=
7000-0xfc6073ff]
> [ =C2=A0 =C2=A00.120915] pci 0000:00:12.0: set SATA to AHCI mode

Hrm...maybe it would be better to disable AHCI and try legacy mode?
Suboptimal but might help differentiate between AHCI issues and HW issu=
es.
This is not especially useful IMHO - but keep it in mind.

> [ =C2=A0 =C2=A00.120957] pci 0000:00:13.0: reg 10 32bit mmio: [0xfc60=
4000-0xfc604fff]
> [ =C2=A0 =C2=A00.121021] pci 0000:00:13.1: reg 10 32bit mmio: [0xfc60=
5000-0xfc605fff]
> [ =C2=A0 =C2=A00.121086] pci 0000:00:13.4: reg 10 32bit mmio: [0xfc60=
6000-0xfc606fff]
> [ =C2=A0 =C2=A00.121166] pci 0000:00:13.5: reg 10 32bit mmio: [0xfc60=
7400-0xfc6074ff]
> [ =C2=A0 =C2=A00.121223] pci 0000:00:13.5: supports D1 D2
> [ =C2=A0 =C2=A00.121225] pci 0000:00:13.5: PME# supported from D0 D1 =
D2 D3hot
> [ =C2=A0 =C2=A00.121231] pci 0000:00:13.5: PME# disabled
> [ =C2=A0 =C2=A00.121279] pci 0000:00:14.0: reg 10 io port: [0x8410-0x=
841f]
> [ =C2=A0 =C2=A00.121352] pci 0000:00:14.1: reg 10 io port: [0x1f0-0x1=
f7]
> [ =C2=A0 =C2=A00.121360] pci 0000:00:14.1: reg 14 io port: [0x3f4-0x3=
f7]
> [ =C2=A0 =C2=A00.121368] pci 0000:00:14.1: reg 18 io port: [0x00-0x07=
]
> [ =C2=A0 =C2=A00.121377] pci 0000:00:14.1: reg 1c io port: [0x00-0x03=
]
> [ =C2=A0 =C2=A00.121385] pci 0000:00:14.1: reg 20 io port: [0x8420-0x=
842f]
> [ =C2=A0 =C2=A00.121442] pci 0000:00:14.2: reg 10 64bit mmio: [0xfc60=
0000-0xfc603fff]
> [ =C2=A0 =C2=A00.121489] pci 0000:00:14.2: PME# supported from D0 D3h=
ot D3cold
> [ =C2=A0 =C2=A00.121495] pci 0000:00:14.2: PME# disabled
> [ =C2=A0 =C2=A00.121693] pci 0000:01:05.0: reg 10 64bit mmio: [0xf800=
0000-0xfbffffff]
> [ =C2=A0 =C2=A00.121700] pci 0000:01:05.0: reg 18 64bit mmio: [0xfc20=
0000-0xfc20ffff]
> [ =C2=A0 =C2=A00.121705] pci 0000:01:05.0: reg 20 io port: [0x9400-0x=
94ff]
> [ =C2=A0 =C2=A00.121710] pci 0000:01:05.0: reg 24 32bit mmio: [0xfc10=
0000-0xfc1fffff]
> [ =C2=A0 =C2=A00.121723] pci 0000:01:05.0: supports D1 D2
> [ =C2=A0 =C2=A00.121741] pci 0000:00:01.0: bridge io port: [0x9000-0x=
9fff]
> [ =C2=A0 =C2=A00.121745] pci 0000:00:01.0: bridge 32bit mmio: [0xfc10=
0000-0xfc2fffff]
> [ =C2=A0 =C2=A00.121750] pci 0000:00:01.0: bridge 64bit mmio pref:
> [0xf8000000-0xfbffffff]
> [ =C2=A0 =C2=A00.121836] pci 0000:02:00.0: reg 10 64bit mmio: [0xfc30=
0000-0xfc303fff]
> [ =C2=A0 =C2=A00.121892] pci 0000:02:00.0: supports D1 D2
> [ =C2=A0 =C2=A00.121895] pci 0000:02:00.0: PME# supported from D0 D3h=
ot D3cold
> [ =C2=A0 =C2=A00.121900] pci 0000:02:00.0: PME# disabled
> [ =C2=A0 =C2=A00.121964] pci 0000:00:06.0: bridge 32bit mmio: [0xfc30=
0000-0xfc3fffff]
> [ =C2=A0 =C2=A00.122007] pci 0000:05:00.0: reg 10 io port: [0xa400-0x=
a4ff]
> [ =C2=A0 =C2=A00.122024] pci 0000:05:00.0: reg 18 64bit mmio: [0xfc01=
0000-0xfc010fff]
> [ =C2=A0 =C2=A00.122036] pci 0000:05:00.0: reg 20 64bit mmio: [0xfc00=
0000-0xfc00ffff]
> [ =C2=A0 =C2=A00.122044] pci 0000:05:00.0: reg 30 32bit mmio: [0x0000=
00-0x01ffff]
> [ =C2=A0 =C2=A00.122075] pci 0000:05:00.0: supports D1 D2
> [ =C2=A0 =C2=A00.122078] pci 0000:05:00.0: PME# supported from D0 D1 =
D2 D3hot D3cold
> [ =C2=A0 =C2=A00.122083] pci 0000:05:00.0: PME# disabled
> [ =C2=A0 =C2=A00.122146] pci 0000:00:07.0: bridge io port: [0xa000-0x=
afff]
> [ =C2=A0 =C2=A00.122151] pci 0000:00:07.0: bridge 64bit mmio pref:
> [0xfc000000-0xfc0fffff]
> [ =C2=A0 =C2=A00.122213] pci 0000:00:14.4: transparent bridge
> [ =C2=A0 =C2=A00.122235] pci_bus 0000:00: on NUMA node 0
> [ =C2=A0 =C2=A00.122240] ACPI: PCI Interrupt Routing Table [\_SB_.PCI=
0._PRT]
> [ =C2=A0 =C2=A00.122385] ACPI: PCI Interrupt Routing Table [\_SB_.PCI=
0.PB6_._PRT]
> [ =C2=A0 =C2=A00.122462] ACPI: PCI Interrupt Routing Table [\_SB_.PCI=
0.PB7_._PRT]
> [ =C2=A0 =C2=A00.122580] ACPI: PCI Interrupt Routing Table [\_SB_.PCI=
0.AGP_._PRT]
> [ =C2=A0 =C2=A00.126020] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11)=
 *0, disabled.
> [ =C2=A0 =C2=A00.126149] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11)=
 *0, disabled.
> [ =C2=A0 =C2=A00.126276] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11)=
 *0, disabled.
> [ =C2=A0 =C2=A00.126402] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11)=
 *0, disabled.
> [ =C2=A0 =C2=A00.126529] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11)=
 *0, disabled.
> [ =C2=A0 =C2=A00.126656] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11)=
 *0, disabled.
> [ =C2=A0 =C2=A00.126783] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11)=
 *0, disabled.
> [ =C2=A0 =C2=A00.126910] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11)=
 *0, disabled.
> [ =C2=A0 =C2=A00.127106] SCSI subsystem initialized
> [ =C2=A0 =C2=A00.127172] libata version 3.00 loaded.
> [ =C2=A0 =C2=A00.127256] usbcore: registered new interface driver usb=
fs
> [ =C2=A0 =C2=A00.127274] usbcore: registered new interface driver hub
> [ =C2=A0 =C2=A00.127301] usbcore: registered new device driver usb
> [ =C2=A0 =C2=A00.127491] ACPI: WMI: Mapper loaded
> [ =C2=A0 =C2=A00.127493] PCI: Using ACPI for IRQ routing
> [ =C2=A0 =C2=A00.127742] Bluetooth: Core ver 2.15
> [ =C2=A0 =C2=A00.127772] NET: Registered protocol family 31
> [ =C2=A0 =C2=A00.127774] Bluetooth: HCI device and connection manager=
 initialized
> [ =C2=A0 =C2=A00.127778] Bluetooth: HCI socket layer initialized
> [ =C2=A0 =C2=A00.127781] NET: Registered protocol family 8
> [ =C2=A0 =C2=A00.127783] NET: Registered protocol family 20
> [ =C2=A0 =C2=A00.127795] NetLabel: Initializing
> [ =C2=A0 =C2=A00.127797] NetLabel: =C2=A0domain hash size =3D 128
> [ =C2=A0 =C2=A00.127799] NetLabel: =C2=A0protocols =3D UNLABELED CIPS=
Ov4
> [ =C2=A0 =C2=A00.127815] NetLabel: =C2=A0unlabeled traffic allowed by=
 default
> [ =C2=A0 =C2=A00.127852] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> [ =C2=A0 =C2=A00.127858] hpet0: 4 comparators, 32-bit 14.318180 MHz c=
ounter
> [ =C2=A0 =C2=A00.131793] pnp: PnP ACPI init
> [ =C2=A0 =C2=A00.131816] ACPI: bus type pnp registered
> [ =C2=A0 =C2=A00.168034] pnp: PnP ACPI: found 11 devices
> [ =C2=A0 =C2=A00.168037] ACPI: ACPI bus type pnp unregistered
> [ =C2=A0 =C2=A00.168041] PnPBIOS: Disabled by ACPI PNP
> [ =C2=A0 =C2=A00.168056] system 00:01: iomem range 0xfec00000-0xfec00=
fff could not be
> reserved
> [ =C2=A0 =C2=A00.168060] system 00:01: iomem range 0xfee00000-0xfee00=
fff has been
> reserved
> [ =C2=A0 =C2=A00.168069] system 00:08: ioport range 0x1080-0x1080 has=
 been reserved
> [ =C2=A0 =C2=A00.168074] system 00:08: ioport range 0x220-0x22f has b=
een reserved
> [ =C2=A0 =C2=A00.168078] system 00:08: ioport range 0x40b-0x40b has b=
een reserved
> [ =C2=A0 =C2=A00.168081] system 00:08: ioport range 0x4d0-0x4d1 has b=
een reserved
> [ =C2=A0 =C2=A00.168085] system 00:08: ioport range 0x4d6-0x4d6 has b=
een reserved
> [ =C2=A0 =C2=A00.168089] system 00:08: ioport range 0x530-0x537 has b=
een reserved
> [ =C2=A0 =C2=A00.168093] system 00:08: ioport range 0xc00-0xc01 has b=
een reserved
> [ =C2=A0 =C2=A00.168096] system 00:08: ioport range 0xc14-0xc14 has b=
een reserved
> [ =C2=A0 =C2=A00.168100] system 00:08: ioport range 0xc50-0xc52 has b=
een reserved
> [ =C2=A0 =C2=A00.168104] system 00:08: ioport range 0xc6c-0xc6c has b=
een reserved
> [ =C2=A0 =C2=A00.168108] system 00:08: ioport range 0xc6f-0xc6f has b=
een reserved
> [ =C2=A0 =C2=A00.168112] system 00:08: ioport range 0xcd0-0xcd1 has b=
een reserved
> [ =C2=A0 =C2=A00.168116] system 00:08: ioport range 0xcd2-0xcd3 has b=
een reserved
> [ =C2=A0 =C2=A00.168119] system 00:08: ioport range 0xcd4-0xcd5 has b=
een reserved
> [ =C2=A0 =C2=A00.168123] system 00:08: ioport range 0xcd6-0xcd7 has b=
een reserved
> [ =C2=A0 =C2=A00.168127] system 00:08: ioport range 0xcd8-0xcdf has b=
een reserved
> [ =C2=A0 =C2=A00.168131] system 00:08: ioport range 0x8000-0x805f has=
 been reserved
> [ =C2=A0 =C2=A00.168135] system 00:08: ioport range 0xf40-0xf47 has b=
een reserved
> [ =C2=A0 =C2=A00.168139] system 00:08: ioport range 0x87f-0x87f has b=
een reserved
> [ =C2=A0 =C2=A00.168143] system 00:08: ioport range 0xfd60-0xfd63 has=
 been reserved
> [ =C2=A0 =C2=A00.168150] system 00:09: iomem range 0xe0000-0xfffff co=
uld not be
> reserved
> [ =C2=A0 =C2=A00.168154] system 00:09: iomem range 0xfff00000-0xfffff=
fff has been
> reserved
> [ =C2=A0 =C2=A00.202905] pci 0000:00:01.0: PCI bridge, secondary bus =
0000:01
> [ =C2=A0 =C2=A00.202909] pci 0000:00:01.0: =C2=A0 IO window: 0x9000-0=
x9fff
> [ =C2=A0 =C2=A00.202913] pci 0000:00:01.0: =C2=A0 MEM window: 0xfc100=
000-0xfc2fffff
> [ =C2=A0 =C2=A00.202918] pci 0000:00:01.0: =C2=A0 PREFETCH window:
> 0x000000f8000000-0x000000fbffffff
> [ =C2=A0 =C2=A00.202923] pci 0000:00:06.0: PCI bridge, secondary bus =
0000:02
> [ =C2=A0 =C2=A00.202926] pci 0000:00:06.0: =C2=A0 IO window: disabled
> [ =C2=A0 =C2=A00.202930] pci 0000:00:06.0: =C2=A0 MEM window: 0xfc300=
000-0xfc3fffff
> [ =C2=A0 =C2=A00.202933] pci 0000:00:06.0: =C2=A0 PREFETCH window: di=
sabled
> [ =C2=A0 =C2=A00.202938] pci 0000:00:07.0: PCI bridge, secondary bus =
0000:05
> [ =C2=A0 =C2=A00.202942] pci 0000:00:07.0: =C2=A0 IO window: 0xa000-0=
xafff
> [ =C2=A0 =C2=A00.202946] pci 0000:00:07.0: =C2=A0 MEM window: 0x80000=
000-0x800fffff
> [ =C2=A0 =C2=A00.202950] pci 0000:00:07.0: =C2=A0 PREFETCH window:
> 0x000000fc000000-0x000000fc0fffff
> [ =C2=A0 =C2=A00.202955] pci 0000:00:14.4: PCI bridge, secondary bus =
0000:08
> [ =C2=A0 =C2=A00.202957] pci 0000:00:14.4: =C2=A0 IO window: disabled
> [ =C2=A0 =C2=A00.202969] pci 0000:00:14.4: =C2=A0 MEM window: disable=
d
> [ =C2=A0 =C2=A00.202973] pci 0000:00:14.4: =C2=A0 PREFETCH window: di=
sabled
> [ =C2=A0 =C2=A00.202987] pci 0000:00:06.0: setting latency timer to 6=
4
> [ =C2=A0 =C2=A00.202993] pci 0000:00:07.0: setting latency timer to 6=
4
> [ =C2=A0 =C2=A00.203002] pci_bus 0000:00: resource 0 io: =C2=A0[0x00-=
0xffff]
> [ =C2=A0 =C2=A00.203006] pci_bus 0000:00: resource 1 mem: [0x000000-0=
xffffffff]
> [ =C2=A0 =C2=A00.203010] pci_bus 0000:01: resource 0 io: =C2=A0[0x900=
0-0x9fff]
> [ =C2=A0 =C2=A00.203013] pci_bus 0000:01: resource 1 mem: [0xfc100000=
-0xfc2fffff]
> [ =C2=A0 =C2=A00.203017] pci_bus 0000:01: resource 2 pref mem [0xf800=
0000-0xfbffffff]
> [ =C2=A0 =C2=A00.203020] pci_bus 0000:02: resource 1 mem: [0xfc300000=
-0xfc3fffff]
> [ =C2=A0 =C2=A00.203024] pci_bus 0000:05: resource 0 io: =C2=A0[0xa00=
0-0xafff]
> [ =C2=A0 =C2=A00.203028] pci_bus 0000:05: resource 1 mem: [0x80000000=
-0x800fffff]
> [ =C2=A0 =C2=A00.203031] pci_bus 0000:05: resource 2 pref mem [0xfc00=
0000-0xfc0fffff]
> [ =C2=A0 =C2=A00.203035] pci_bus 0000:08: resource 3 io: =C2=A0[0x00-=
0xffff]
> [ =C2=A0 =C2=A00.203038] pci_bus 0000:08: resource 4 mem: [0x000000-0=
xffffffff]
> [ =C2=A0 =C2=A00.203081] NET: Registered protocol family 2
> [ =C2=A0 =C2=A00.203190] IP route cache hash table entries: 32768 (or=
der: 5, 131072
> bytes)
> [ =C2=A0 =C2=A00.203589] TCP established hash table entries: 131072 (=
order: 8, 1048576
> bytes)
> [ =C2=A0 =C2=A00.204368] TCP bind hash table entries: 65536 (order: 7=
, 524288 bytes)
> [ =C2=A0 =C2=A00.204722] TCP: Hash tables configured (established 131=
072 bind 65536)
> [ =C2=A0 =C2=A00.204725] TCP reno registered
> [ =C2=A0 =C2=A00.204820] NET: Registered protocol family 1
> [ =C2=A0 =C2=A00.204893] Trying to unpack rootfs image as initramfs..=
=2E
> [ =C2=A0 =C2=A00.500908] Switched to high resolution mode on CPU 0
> [ =C2=A0 =C2=A02.278210] Freeing initrd memory: 49572k freed
> [ =C2=A0 =C2=A02.312474] cpufreq-nforce2: No nForce2 chipset.
> [ =C2=A0 =C2=A02.312510] Scanning for low memory corruption every 60 =
seconds
> [ =C2=A0 =C2=A02.312673] audit: initializing netlink socket (disabled=
)
> [ =C2=A0 =C2=A02.312697] type=3D2000 audit(1252603160.312:1): initial=
ized
> [ =C2=A0 =C2=A02.324022] highmem bounce pool size: 64 pages
> [ =C2=A0 =C2=A02.324028] HugeTLB registered 4 MB page size, pre-alloc=
ated 0 pages
> [ =C2=A0 =C2=A02.325747] VFS: Disk quotas dquot_6.5.2
> [ =C2=A0 =C2=A02.325817] Dquot-cache hash table entries: 1024 (order =
0, 4096 bytes)
> [ =C2=A0 =C2=A02.326450] fuse init (API version 7.12)
> [ =C2=A0 =C2=A02.326546] msgmni has been set to 1707
> [ =C2=A0 =C2=A02.326743] alg: No test for stdrng (krng)
> [ =C2=A0 =C2=A02.326755] io scheduler noop registered
> [ =C2=A0 =C2=A02.326758] io scheduler anticipatory registered
> [ =C2=A0 =C2=A02.326760] io scheduler deadline registered
> [ =C2=A0 =C2=A02.326813] io scheduler cfq registered (default)
> [ =C2=A0 =C2=A02.326879] pci 0000:01:05.0: Boot video device
> [ =C2=A0 =C2=A02.326992] pcieport-driver 0000:00:06.0: irq 24 for MSI=
/MSI-X
> [ =C2=A0 =C2=A02.326998] pcieport-driver 0000:00:06.0: setting latenc=
y timer to 64
> [ =C2=A0 =C2=A02.327082] pcieport-driver 0000:00:07.0: irq 25 for MSI=
/MSI-X
> [ =C2=A0 =C2=A02.327088] pcieport-driver 0000:00:07.0: setting latenc=
y timer to 64
> [ =C2=A0 =C2=A02.327151] pci_hotplug: PCI Hot Plug PCI Core version: =
0.5
> [ =C2=A0 =C2=A02.327177] pciehp: PCI Express Hot Plug Controller Driv=
er version: 0.4
> [ =C2=A0 =C2=A02.340095] ACPI: AC Adapter [ACAD] (off-line)
> [ =C2=A0 =C2=A02.340180] input: Power Button as
> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [ =C2=A0 =C2=A02.340185] ACPI: Power Button [PWRF]
> [ =C2=A0 =C2=A02.340241] input: Power Button as
> /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
> [ =C2=A0 =C2=A02.340245] ACPI: Power Button [PWRB]
> [ =C2=A0 =C2=A02.340291] input: Sleep Button as
> /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
> [ =C2=A0 =C2=A02.340294] ACPI: Sleep Button [SLPB]
> [ =C2=A0 =C2=A02.340346] input: Lid Switch as
> /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input3
> [ =C2=A0 =C2=A02.340399] ACPI: Lid Switch [LID]
> [ =C2=A0 =C2=A02.340606] Marking TSC unstable due to TSC halts in idl=
e
> [ =C2=A0 =C2=A02.340625] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C=
3])
> [ =C2=A0 =C2=A02.340652] processor LNXCPU:00: registered as cooling_d=
evice0
> [ =C2=A0 =C2=A02.340656] ACPI: Processor [CPU0] (supports 8 throttlin=
g states)
> [ =C2=A0 =C2=A02.393425] ACPI: Invalid active0 threshold
> [ =C2=A0 =C2=A02.409955] thermal LNXTHERM:01: registered as thermal_z=
one0
> [ =C2=A0 =C2=A02.409963] ACPI: Thermal Zone [THRM] (29 C)
> [ =C2=A0 =C2=A02.410150] isapnp: Scanning for PnP cards...
> [ =C2=A0 =C2=A02.769719] isapnp: No Plug & Play device found
> [ =C2=A0 =C2=A03.135945] ACPI: Battery Slot [BAT1] (battery present)
> [ =C2=A0 =C2=A03.136204] Serial: 8250/16550 driver, 4 ports, IRQ shar=
ing enabled
> [ =C2=A0 =C2=A03.137655] brd: module loaded
> [ =C2=A0 =C2=A03.138187] loop: module loaded
> [ =C2=A0 =C2=A03.138277] input: Macintosh mouse button emulation as
> /devices/virtual/input/input4
> [ =C2=A0 =C2=A03.138352] ahci 0000:00:12.0: version 3.0
> [ =C2=A0 =C2=A03.138375] ahci 0000:00:12.0: PCI INT A -> GSI 22 (leve=
l, low) -> IRQ 22
> [ =C2=A0 =C2=A03.138525] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4=
 ports 3 Gbps 0xf
> impl SATA mode
> [ =C2=A0 =C2=A03.138530] ahci 0000:00:12.0: flags: 64bit ncq sntf ilc=
k led clo pmp pio
> [ =C2=A0 =C2=A03.139243] scsi0 : ahci
> [ =C2=A0 =C2=A03.139368] scsi1 : ahci
> [ =C2=A0 =C2=A03.139439] scsi2 : ahci
> [ =C2=A0 =C2=A03.139519] scsi3 : ahci
> [ =C2=A0 =C2=A03.139641] ata1: SATA max UDMA/133 abar m1024@0xfc60700=
0 port 0xfc607100
> irq 22
> [ =C2=A0 =C2=A03.139646] ata2: SATA max UDMA/133 abar m1024@0xfc60700=
0 port 0xfc607180
> irq 22
> [ =C2=A0 =C2=A03.139651] ata3: SATA max UDMA/133 abar m1024@0xfc60700=
0 port 0xfc607200
> irq 22
> [ =C2=A0 =C2=A03.139655] ata4: SATA max UDMA/133 abar m1024@0xfc60700=
0 port 0xfc607280
> irq 22
> [ =C2=A0 =C2=A03.140564] pata_atiixp 0000:00:14.1: enabling device (0=
014 -> 0015)
> [ =C2=A0 =C2=A03.140576] pata_atiixp 0000:00:14.1: PCI INT A -> GSI 1=
6 (level, low) ->
> IRQ 16
> [ =C2=A0 =C2=A03.140610] pata_atiixp 0000:00:14.1: setting latency ti=
mer to 64
> [ =C2=A0 =C2=A03.140734] scsi4 : pata_atiixp
> [ =C2=A0 =C2=A03.140827] scsi5 : pata_atiixp
> [ =C2=A0 =C2=A03.141750] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 =
bmdma 0x8420 irq
> 14
> [ =C2=A0 =C2=A03.141753] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 =
bmdma 0x8428 irq
> 15
> [ =C2=A0 =C2=A03.142275] Fixed MDIO Bus: probed
> [ =C2=A0 =C2=A03.142283] PPP generic driver version 2.4.2
> [ =C2=A0 =C2=A03.142420] ehci_hcd: USB 2.0 'Enhanced' Host Controller=
 (EHCI) Driver
> [ =C2=A0 =C2=A03.142444] ehci_hcd 0000:00:13.5: PCI INT D -> GSI 19 (=
level, low) ->
> IRQ 19
> [ =C2=A0 =C2=A03.142463] ehci_hcd 0000:00:13.5: EHCI Host Controller
> [ =C2=A0 =C2=A03.142519] ehci_hcd 0000:00:13.5: new USB bus registere=
d, assigned bus
> number 1
> [ =C2=A0 =C2=A03.142551] ehci_hcd 0000:00:13.5: applying AMD SB600/SB=
700 USB freeze
> workaround
> [ =C2=A0 =C2=A03.142571] ehci_hcd 0000:00:13.5: debug port 1
> [ =C2=A0 =C2=A03.142591] ehci_hcd 0000:00:13.5: irq 19, io mem 0xfc60=
7400
> [ =C2=A0 =C2=A03.148023] ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI=
 1.00
> [ =C2=A0 =C2=A03.148129] usb usb1: configuration #1 chosen from 1 cho=
ice
> [ =C2=A0 =C2=A03.148169] hub 1-0:1.0: USB hub found
> [ =C2=A0 =C2=A03.148189] hub 1-0:1.0: 10 ports detected
> [ =C2=A0 =C2=A03.148282] ohci_hcd: USB 1.1 'Open' Host Controller (OH=
CI) Driver
> [ =C2=A0 =C2=A03.148302] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 16 (=
level, low) ->
> IRQ 16
> [ =C2=A0 =C2=A03.148314] ohci_hcd 0000:00:13.0: OHCI Host Controller
> [ =C2=A0 =C2=A03.148353] ohci_hcd 0000:00:13.0: new USB bus registere=
d, assigned bus
> number 2
> [ =C2=A0 =C2=A03.148379] ohci_hcd 0000:00:13.0: irq 16, io mem 0xfc60=
4000
> [ =C2=A0 =C2=A03.199111] usb usb2: configuration #1 chosen from 1 cho=
ice
> [ =C2=A0 =C2=A03.199150] hub 2-0:1.0: USB hub found
> [ =C2=A0 =C2=A03.199165] hub 2-0:1.0: 2 ports detected
> [ =C2=A0 =C2=A03.199220] ohci_hcd 0000:00:13.1: PCI INT B -> GSI 17 (=
level, low) ->
> IRQ 17
> [ =C2=A0 =C2=A03.199230] ohci_hcd 0000:00:13.1: OHCI Host Controller
> [ =C2=A0 =C2=A03.199265] ohci_hcd 0000:00:13.1: new USB bus registere=
d, assigned bus
> number 3
> [ =C2=A0 =C2=A03.199291] ohci_hcd 0000:00:13.1: irq 17, io mem 0xfc60=
5000
> [ =C2=A0 =C2=A03.250113] usb usb3: configuration #1 chosen from 1 cho=
ice
> [ =C2=A0 =C2=A03.250143] hub 3-0:1.0: USB hub found
> [ =C2=A0 =C2=A03.250158] hub 3-0:1.0: 2 ports detected
> [ =C2=A0 =C2=A03.250212] ohci_hcd 0000:00:13.4: PCI INT C -> GSI 18 (=
level, low) ->
> IRQ 18
> [ =C2=A0 =C2=A03.250222] ohci_hcd 0000:00:13.4: OHCI Host Controller
> [ =C2=A0 =C2=A03.250260] ohci_hcd 0000:00:13.4: new USB bus registere=
d, assigned bus
> number 4
> [ =C2=A0 =C2=A03.250285] ohci_hcd 0000:00:13.4: irq 18, io mem 0xfc60=
6000
> [ =C2=A0 =C2=A03.305017] usb usb4: configuration #1 chosen from 1 cho=
ice
> [ =C2=A0 =C2=A03.305049] hub 4-0:1.0: USB hub found
> [ =C2=A0 =C2=A03.305062] hub 4-0:1.0: 2 ports detected
> [ =C2=A0 =C2=A03.305118] uhci_hcd: USB Universal Host Controller Inte=
rface driver
> [ =C2=A0 =C2=A03.305212] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:M=
SS0] at 0x60,0x64
> irq 1,12
> [ =C2=A0 =C2=A03.330782] serio: i8042 KBD port at 0x60,0x64 irq 1
> [ =C2=A0 =C2=A03.330789] serio: i8042 AUX port at 0x60,0x64 irq 12
> [ =C2=A0 =C2=A03.330898] mice: PS/2 mouse device common for all mice
> [ =C2=A0 =C2=A03.333240] rtc_cmos 00:04: RTC can wake from S4
> [ =C2=A0 =C2=A03.333280] rtc_cmos 00:04: rtc core: registered rtc_cmo=
s as rtc0
> [ =C2=A0 =C2=A03.333311] rtc0: alarms up to one month, 114 bytes nvra=
m, hpet irqs
> [ =C2=A0 =C2=A03.333427] device-mapper: uevent: version 1.0.3
> [ =C2=A0 =C2=A03.333536] device-mapper: ioctl: 4.15.0-ioctl (2009-04-=
01) initialised:
> dm-devel@redhat.com
> [ =C2=A0 =C2=A03.333591] device-mapper: multipath: version 1.1.0 load=
ed
> [ =C2=A0 =C2=A03.333595] device-mapper: multipath round-robin: versio=
n 1.0.0 loaded
> [ =C2=A0 =C2=A03.333728] EISA: Probing bus 0 at eisa.0
> [ =C2=A0 =C2=A03.333739] Cannot allocate resource for EISA slot 1
> [ =C2=A0 =C2=A03.333766] Cannot allocate resource for EISA slot 8
> [ =C2=A0 =C2=A03.333769] EISA: Detected 0 cards.
> [ =C2=A0 =C2=A03.333857] cpuidle: using governor ladder
> [ =C2=A0 =C2=A03.333926] cpuidle: using governor menu
> [ =C2=A0 =C2=A03.334452] TCP cubic registered
> [ =C2=A0 =C2=A03.334624] NET: Registered protocol family 10
> [ =C2=A0 =C2=A03.335116] lo: Disabled Privacy Extensions
> [ =C2=A0 =C2=A03.335459] NET: Registered protocol family 17
> [ =C2=A0 =C2=A03.335478] Bluetooth: L2CAP ver 2.13
> [ =C2=A0 =C2=A03.335480] Bluetooth: L2CAP socket layer initialized
> [ =C2=A0 =C2=A03.335483] Bluetooth: SCO (Voice Link) ver 0.6
> [ =C2=A0 =C2=A03.335485] Bluetooth: SCO socket layer initialized
> [ =C2=A0 =C2=A03.335518] Bluetooth: RFCOMM TTY layer initialized
> [ =C2=A0 =C2=A03.335521] Bluetooth: RFCOMM socket layer initialized
> [ =C2=A0 =C2=A03.335523] Bluetooth: RFCOMM ver 1.11
> [ =C2=A0 =C2=A03.335552] powernow-k8: Found 1 AMD Athlon(tm) Processo=
r 2650e
> processors (1 cpu cores) (version 2.20.00)
> [ =C2=A0 =C2=A03.335591] powernow-k8: =C2=A0 =C2=A00 : fid 0x8 (1600 =
MHz), vid 0x16
> [ =C2=A0 =C2=A03.335595] powernow-k8: =C2=A0 =C2=A01 : fid 0x0 (800 M=
Hz), vid 0x16
> [ =C2=A0 =C2=A03.335646] Using IPI No-Shortcut mode
> [ =C2=A0 =C2=A03.335721] PM: Resume from disk failed.
> [ =C2=A0 =C2=A03.335735] registered taskstats version 1
> [ =C2=A0 =C2=A03.335878] =C2=A0 Magic number: 9:842:339
> [ =C2=A0 =C2=A03.335926] ehci_hcd 0000:00:13.5: hash matches
> [ =C2=A0 =C2=A03.335976] rtc_cmos 00:04: setting system clock to 2009=
-09-10 17:19:23
> UTC (1252603163)
> [ =C2=A0 =C2=A03.335980] BIOS EDD facility v0.16 2004-Jun-25, 0 devic=
es found
> [ =C2=A0 =C2=A03.335982] EDD information not available.
> [ =C2=A0 =C2=A03.350917] input: AT Translated Set 2 keyboard as
> /devices/platform/i8042/serio0/input/input5
> [ =C2=A0 =C2=A03.445042] ata2: SATA link down (SStatus 0 SControl 300=
)
> [ =C2=A0 =C2=A03.448036] ata4: SATA link down (SStatus 0 SControl 300=
)
> [ =C2=A0 =C2=A03.516027] usb 1-10: new high speed USB device using eh=
ci_hcd and
> address 3
> [ =C2=A0 =C2=A03.598026] ata1: softreset failed (device not ready)
> [ =C2=A0 =C2=A03.598066] ata1: applying SB600 PMP SRST workaround and=
 retrying
> [ =C2=A0 =C2=A03.598084] ata3: softreset failed (device not ready)
> [ =C2=A0 =C2=A03.598121] ata3: applying SB600 PMP SRST workaround and=
 retrying
> [ =C2=A0 =C2=A03.670374] usb 1-10: configuration #1 chosen from 1 cho=
ice
> [ =C2=A0 =C2=A03.751036] ata3: SATA link up 1.5 Gbps (SStatus 113 SCo=
ntrol 300)

So this appears to be the "Optiarc  DVD RW AD-7580S" and needs to run
at 1.5Gbps.

> [ =C2=A0 =C2=A03.751061] ata1: SATA link up 3.0 Gbps (SStatus 123 SCo=
ntrol 300)
> [ =C2=A0 =C2=A03.765868] ata3.00: ATAPI: Optiarc DVD RW AD-7580S, FX0=
4, max UDMA/100,
> ATAPI AN
> [ =C2=A0 =C2=A03.765893] ata3.00: SB600 AHCI: limiting to 255 sectors=
 per cmd
> [ =C2=A0 =C2=A03.780365] ata3.00: SB600 AHCI: limiting to 255 sectors=
 per cmd
> [ =C2=A0 =C2=A03.780369] ata3.00: configured for UDMA/100
> [ =C2=A0 =C2=A03.799807] ata1.00: ATA-8: WDC WD1600BEVT-22ZCT0, 11.01=
A11, max UDMA/133
> [ =C2=A0 =C2=A03.799812] ata1.00: 312581808 sectors, multi 16: LBA48 =
NCQ (depth 31/32)
> [ =C2=A0 =C2=A03.799836] ata1.00: SB600 AHCI: limiting to 255 sectors=
 per cmd
> [ =C2=A0 =C2=A03.801143] ata1.00: SB600 AHCI: limiting to 255 sectors=
 per cmd
> [ =C2=A0 =C2=A03.801147] ata1.00: configured for UDMA/133
> [ =C2=A0 =C2=A03.801263] scsi 0:0:0:0: Direct-Access =C2=A0 =C2=A0 AT=
A =C2=A0 =C2=A0 =C2=A0WDC WD1600BEVT-2
> 11.0 PQ: 0 ANSI: 5
> [ =C2=A0 =C2=A03.801405] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [ =C2=A0 =C2=A03.801451] sd 0:0:0:0: [sda] 312581808 512-byte logical=
 blocks: (160
> GB/149 GiB)
> [ =C2=A0 =C2=A03.801504] sd 0:0:0:0: [sda] Write Protect is off
> [ =C2=A0 =C2=A03.801508] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ =C2=A0 =C2=A03.801536] sd 0:0:0:0: [sda] Write cache: enabled, read=
 cache: enabled,
> doesn't support DPO or FUA
> [ =C2=A0 =C2=A03.801675] =C2=A0sda:
> [ =C2=A0 =C2=A03.806361] scsi 2:0:0:0: CD-ROM =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Optiarc =C2=A0DVD RW AD-7580S
> =C2=A0FX04 PQ: 0 ANSI: 5
> [ =C2=A0 =C2=A03.808136] =C2=A0sda1 sda2 sda3 sda4
> [ =C2=A0 =C2=A03.812011] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram=
 cd/rw xa/form2
> cdda tray
> [ =C2=A0 =C2=A03.812015] Uniform CD-ROM driver Revision: 3.20
> [ =C2=A0 =C2=A03.812107] sr 2:0:0:0: Attached scsi CD-ROM sr0
> [ =C2=A0 =C2=A03.812163] sr 2:0:0:0: Attached scsi generic sg1 type 5
> [ =C2=A0 =C2=A03.830791] sd 0:0:0:0: [sda] Attached SCSI disk
> [ =C2=A0 =C2=A03.900033] usb 2-1: new low speed USB device using ohci=
_hcd and address
> 2
> [ =C2=A0 =C2=A03.963098] Freeing unused kernel memory: 536k freed
> [ =C2=A0 =C2=A03.963560] Write protecting the kernel text: 4520k
> [ =C2=A0 =C2=A03.963597] Write protecting the kernel read-only data: =
1668k
> [ =C2=A0 =C2=A04.056154] usb 2-1: configuration #1 chosen from 1 choi=
ce
> [ =C2=A0 =C2=A04.452973] b43-pci-bridge 0000:02:00.0: PCI INT A -> GS=
I 18 (level, low)
> -> IRQ 18
> [ =C2=A0 =C2=A04.452985] b43-pci-bridge 0000:02:00.0: setting latency=
 timer to 64
> [ =C2=A0 =C2=A04.498334] ssb: Sonics Silicon Backplane found on PCI d=
evice
> 0000:02:00.0
> [ =C2=A0 =C2=A04.547142] r8169 Gigabit Ethernet driver 2.3LK-NAPI loa=
ded
> [ =C2=A0 =C2=A04.547162] r8169 0000:05:00.0: PCI INT A -> GSI 19 (lev=
el, low) -> IRQ
> 19
> [ =C2=A0 =C2=A04.547200] r8169 0000:05:00.0: setting latency timer to=
 64
> [ =C2=A0 =C2=A04.547244] r8169 0000:05:00.0: irq 26 for MSI/MSI-X
> [ =C2=A0 =C2=A04.547911] eth0: RTL8102e at 0xf81de000, 00:1e:ec:d8:d7=
:87, XID 24a00000
> IRQ 26
> [ =C2=A0 =C2=A04.571978] usbcore: registered new interface driver hid=
dev
> [ =C2=A0 =C2=A04.584409] input: Microsoft Microsoft Wireless Optical =
Mouse=C2=AE 1.00 as
> /devices/pci0000:00/0000:00:13.0/usb2/2-1/2-1:1.0/input/input6
> [ =C2=A0 =C2=A04.584502] generic-usb 0003:045E:00E1.0001: input,hidra=
w0: USB HID v1.11
> Mouse [Microsoft Microsoft Wireless Optical Mouse=C2=AE 1.00] on
> usb-0000:00:13.0-1/input0
> [ =C2=A0 =C2=A04.584525] usbcore: registered new interface driver usb=
hid
> [ =C2=A0 =C2=A04.584529] usbhid: v2.6:USB HID core driver
> [ =C2=A0 =C2=A04.943719] PM: Starting manual resume from disk
> [ =C2=A0 =C2=A04.943724] PM: Resume from partition 8:4
> [ =C2=A0 =C2=A04.943727] PM: Checking hibernation image.
> [ =C2=A0 =C2=A04.943893] PM: Resume from disk failed.
> [ =C2=A0 =C2=A04.947813] EXT3-fs: INFO: recovery required on readonly=
 filesystem.
> [ =C2=A0 =C2=A04.947817] EXT3-fs: write access will be enabled during=
 recovery.
> [ =C2=A0 =C2=A05.016390] kjournald starting. =C2=A0Commit interval 5 =
seconds
> [ =C2=A0 =C2=A05.016406] EXT3-fs: recovery complete.
> [ =C2=A0 =C2=A05.016883] EXT3-fs: mounted filesystem with writeback d=
ata mode.
> [ =C2=A0 10.922166] udev: starting version 141
> [ =C2=A0 11.369369] shpchp: Standard Hot Plug PCI Controller Driver v=
ersion: 0.4
> [ =C2=A0 11.479755] Linux agpgart interface v0.103
> [ =C2=A0 11.526632] k8temp 0000:00:18.3: Temperature readouts might b=
e wrong -
> check erratum #141
> [ =C2=A0 11.538693] input: PC Speaker as /devices/platform/pcspkr/inp=
ut/input7
> [ =C2=A0 11.552042] piix4_smbus 0000:00:14.0: SMBus Host Controller a=
t 0x8410,
> revision 0
> [ =C2=A0 11.850231] cfg80211: Calling CRDA to update world regulatory=
 domain
> [ =C2=A0 12.027894] cfg80211: World regulatory domain updated:
> [ =C2=A0 12.027899] =C2=A0(start_freq - end_freq @ bandwidth), (max_a=
ntenna_gain,
> max_eirp)
> [ =C2=A0 12.027904] =C2=A0(2402000 KHz - 2472000 KHz @ 40000 KHz), (3=
00 mBi, 2000 mBm)
> [ =C2=A0 12.027908] =C2=A0(2457000 KHz - 2482000 KHz @ 20000 KHz), (3=
00 mBi, 2000 mBm)
> [ =C2=A0 12.027911] =C2=A0(2474000 KHz - 2494000 KHz @ 20000 KHz), (3=
00 mBi, 2000 mBm)
> [ =C2=A0 12.027915] =C2=A0(5170000 KHz - 5250000 KHz @ 40000 KHz), (3=
00 mBi, 2000 mBm)
> [ =C2=A0 12.027918] =C2=A0(5735000 KHz - 5835000 KHz @ 40000 KHz), (3=
00 mBi, 2000 mBm)
> [ =C2=A0 12.121833] ACPI Error: Current brightness invalid 20090521 v=
ideo-538

This looks like the datestamp (May 21, 2009) was used as a parameter.

> [ =C2=A0 12.122050] input: Video Bus as
> /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:1c/device:1d/input/i=
nput8
> [ =C2=A0 12.122100] ACPI: Video Device [VGA] (multi-head: yes =C2=A0r=
om: no =C2=A0post: no)
> [ =C2=A0 12.973509] r8169: eth0: link up
> [ =C2=A0 12.973517] r8169: eth0: link up
> [ =C2=A0 13.037581] b43-phy0: Broadcom 4312 WLAN found (core revision=
 15)
> [ =C2=A0 13.052066] b43-phy0 ERROR: FOUND UNSUPPORTED PHY (Analog 6, =
Type 5,
> Revision 1)
> [ =C2=A0 13.052090] b43: probe of ssb0:0 failed with error -95
> [ =C2=A0 13.052122] Broadcom 43xx driver loaded [ Features: PL, Firmw=
are-ID: FW13
> ]
> [ =C2=A0 13.089281] Synaptics Touchpad, model: 1, fw: 6.3, id: 0x1280=
b1, caps:
> 0xa04711/0xa04000
> [ =C2=A0 13.177228] input: SynPS/2 Synaptics TouchPad as
> /devices/platform/i8042/serio1/input/input9
> [ =C2=A0 13.279221] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (leve=
l, low) ->
> IRQ 16
> [ =C2=A0 13.379619] hda_codec: Unknown model for ALC268, trying auto-=
probe from
> BIOS...
> [ =C2=A0 13.736277] lp: driver loaded but no devices found
> [ =C2=A0 13.856449] Adding 2000084k swap on /dev/sda4. =C2=A0Priority=
:-1 extents:1
> across:2000084k
> [ =C2=A0 13.890645] EXT3 FS on sda3, internal journal
> [ =C2=A0 16.325108] ppdev: user-space parallel port driver
> [ =C2=A0 22.716218] pci 0000:01:05.0: power state changed by ACPI to =
D0
> [ =C2=A0 22.716229] pci 0000:01:05.0: PCI INT A -> GSI 18 (level, low=
) -> IRQ 18
> [ =C2=A0 23.038089] [drm] Initialized drm 1.1.0 20060810
> [ =C2=A0 23.145465] [drm] Initialized radeon 1.31.0 20080528 for 0000=
:01:05.0 on
> minor 0
> [ =C2=A0 23.713761] [drm] Setting GART location based on new memory m=
ap
> [ =C2=A0 23.714924] [drm] Loading RS690/RS740 Microcode
> [ =C2=A0 23.714946] [drm] Num pipes: 1
> [ =C2=A0 23.714954] [drm] writeback test succeeded in 1 usecs
> [ =C2=A0 23.794018] eth0: no IPv6 routers present
> [ =C2=A0 23.889021] ACPI: EC: missing confirmations, switch off inter=
rupt mode.
> [ =C2=A0 59.008036] ata3.00: qc timeout (cmd 0xa0)
> [ =C2=A0 59.008057] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 ac=
tion 0x6
> frozen
> [ =C2=A0 59.008062] ata3.00: irq_stat 0x40000001
> [ =C2=A0 59.008075] ata3.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 =
tag 0
> [ =C2=A0 59.008076] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cdb 00 00 00 00=
 00 00 00 00 =C2=A000 00 00 00 00 00 00 00
> [ =C2=A0 59.008078] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res 51/20:03:00=
:00:00/00:00:00:00:00/a0 Emask 0x5
> (timeout)
> [ =C2=A0 59.008082] ata3.00: status: { DRDY ERR }
> [ =C2=A0 59.008088] ata3: hard resetting link
> [ =C2=A0 59.466036] ata3: softreset failed (device not ready)
> [ =C2=A0 59.466043] ata3: applying SB600 PMP SRST workaround and retr=
ying
> [ =C2=A0 59.619047] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl=
 300)
> [ =C2=A0 59.633907] ata3.00: SB600 AHCI: limiting to 255 sectors per =
cmd
> [ =C2=A0 59.648456] ata3.00: SB600 AHCI: limiting to 255 sectors per =
cmd
> [ =C2=A0 59.648462] ata3.00: configured for UDMA/100
> [ =C2=A0 59.648977] ata3: EH complete

and ata3 is happy now? No, it's not. Anyone else willing to comment on
the console messages below?

thanks,
grant

> [ =C2=A0 85.000042] Clocksource tsc unstable (delta =3D -250052437 ns=
)
> [ =C2=A0 89.561080] ata3.00: qc timeout (cmd 0xa0)
> [ =C2=A0 89.561114] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 ac=
tion 0x6
> frozen
> [ =C2=A0 89.561124] ata3.00: irq_stat 0x40000001
> [ =C2=A0 89.561150] ata3.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 =
tag 0
> [ =C2=A0 89.561153] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cdb 00 00 00 00=
 00 00 00 00 =C2=A000 00 00 00 00 00 00 00
> [ =C2=A0 89.561156] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res 51/20:03:00=
:00:00/00:00:00:00:00/a0 Emask 0x5
> (timeout)
> [ =C2=A0 89.561166] ata3.00: status: { DRDY ERR }
> [ =C2=A0 89.561178] ata3: hard resetting link
> [ =C2=A0 90.019045] ata3: softreset failed (device not ready)
> [ =C2=A0 90.019058] ata3: applying SB600 PMP SRST workaround and retr=
ying
> [ =C2=A0 90.172079] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl=
 300)
> [ =C2=A0 90.187956] ata3.00: SB600 AHCI: limiting to 255 sectors per =
cmd
> [ =C2=A0 90.203985] ata3.00: SB600 AHCI: limiting to 255 sectors per =
cmd
> [ =C2=A0 90.203994] ata3.00: configured for UDMA/100
> [ =C2=A0 90.206016] ata3: EH complete
> [ =C2=A0 95.283088] ata3.00: qc timeout (cmd 0xa0)
> [ =C2=A0 95.283122] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 ac=
tion 0x6
> frozen
> [ =C2=A0 95.283132] ata3.00: irq_stat 0x40000001
> [ =C2=A0 95.283156] ata3.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 =
tag 0
> [ =C2=A0 95.283159] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cdb 00 00 00 00=
 00 00 00 00 =C2=A000 00 00 00 00 00 00 00
> [ =C2=A0 95.283163] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res 51/20:03:00=
:00:00/00:00:00:00:00/a0 Emask 0x5
> (timeout)
> [ =C2=A0 95.283172] ata3.00: status: { DRDY ERR }
> [ =C2=A0 95.283186] ata3: hard resetting link
> [ =C2=A0 95.741051] ata3: softreset failed (device not ready)
> [ =C2=A0 95.741063] ata3: applying SB600 PMP SRST workaround and retr=
ying
>
>
