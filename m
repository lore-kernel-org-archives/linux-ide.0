From: Cyber Source <peter@cybersource.us>
Subject: Re: ahci problems
Date: Wed, 16 Sep 2009 06:33:53 -0400
Message-ID: <4AB0BF11.1010301@cybersource.us>
References: <da824cf30909141354q35eefeefi720a56f3e4596c60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.thecybersource.com ([64.65.249.35]:33193 "EHLO
	email.thecybersource.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750830AbZIPKeA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Sep 2009 06:34:00 -0400
In-Reply-To: <da824cf30909141354q35eefeefi720a56f3e4596c60@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org

<snip>

Hrm...maybe it would be better to disable AHCI and try legacy mode?
Suboptimal but might help differentiate between AHCI issues and HW issu=
es.
This is not especially useful IMHO - but keep it in mind.

</snip>

How does one disable AHCI mode? The choice in the BIOS is between IDE/L=
egacy or AHCI. There appears to be no difference when either choice is =
made in the BIOS. Is there a kernel boot option I can put in grub?

<snip>

and ata3 is happy now? No, it's not. Anyone else willing to comment on =
the console messages below?

</snip>

I don't think it's happy, it keeps on bitching in the logs. This being =
a dvd/cd on this controller (ata3) I thought it might help if I can use=
 the boot option "all_generic_ide" but that doesn't appear to help eith=
er. I've seen posts on the web about "all_generic_ide1", etc., do I nee=
d to specify "all_generic_ide3" because it's on ata3? I would love to f=
ind a listing of all the possible boot arguments you can through at the=
 kernel in grub, cause they do come in handy and the explanations and p=
ossibilities are often hard to find if not impossible.
TIA,=20
Peter

Grant Grundler wrote:
> +linux-ide
>
> Please keep linux-ide CC'd - I'm really not that good at debugging
> SATA mysteries without a protocol analyzer (and just average even
> then).
>
>
> On Thu, Sep 10, 2009 at 2:26 PM, Cyber Source <peter@cybersource.us> =
wrote:
>  =20
>> Ok Grant,
>> I've attached the dmesg from that laptop after booting the 2.6.30 ke=
rnel
>> that was patched with the 2.6.31-rc9 patch. I think you may be right=
, in
>> that it's using the workaround, I still see it bitching but it appea=
rs to
>> have a some new items in the log.
>>    =20
>
> Ok.
>
>  =20
>> After patching this kernel, I put the
>> existing .config in place using , make oldconfig, that was from the =
latest
>> stock ubuntu jaunty kernel and afterwards it had a thousand question=
s in
>> which I just held down the enter key to accept all the defaults.
>>    =20
>
> That's a reasonable way to normally do it.
>
>  =20
>> The
>> backlight doesnt seem to work and the wireless no longer works, whic=
h makes
>> me think something didnt come across right from the make oldconfig.
>>    =20
>
> You'll have to create a diff of the two .config files and start
> guessing which ones matter.
>
>
>  =20
>> Your
>> thoughts on this POS? TIA, Peter
>>
>>    =20
> ...
>  =20
>> [    0.000000] Initializing cgroup subsys cpuset
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Linux version 2.6.31-rc9-open-linux-custom (root@Dola=
n) (gcc
>> version 4.3.3 (Ubuntu 4.3.3-5ubuntu4) ) #1 SMP Wed Sep 9 14:28:05 ED=
T 2009
>> [    0.000000] KERNEL supported cpus:
>> [    0.000000]   Intel GenuineIntel
>> [    0.000000]   AMD AuthenticAMD
>> [    0.000000]   NSC Geode by NSC
>> [    0.000000]   Cyrix CyrixInstead
>> [    0.000000]   Centaur CentaurHauls
>> [    0.000000]   Transmeta GenuineTMx86
>> [    0.000000]   Transmeta TransmetaCPU
>> [    0.000000]   UMC UMC UMC UMC
>> [    0.000000] BIOS-provided physical RAM map:
>> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usab=
le)
>> [    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (rese=
rved)
>> [    0.000000]  BIOS-e820: 00000000000ce000 - 0000000000100000 (rese=
rved)
>> [    0.000000]  BIOS-e820: 0000000000100000 - 000000007be60000 (usab=
le)
>> [    0.000000]  BIOS-e820: 000000007be60000 - 000000007be70000 (ACPI=
 data)
>> [    0.000000]  BIOS-e820: 000000007be70000 - 000000007be72000 (ACPI=
 NVS)
>> [    0.000000]  BIOS-e820: 000000007be72000 - 000000007beff000 (rese=
rved)
>> [    0.000000]  BIOS-e820: 000000007bf00000 - 0000000080000000 (rese=
rved)
>> [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (rese=
rved)
>> [    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (rese=
rved)
>> [    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (rese=
rved)
>> [    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (rese=
rved)
>> [    0.000000] DMI present.
>> [    0.000000] last_pfn =3D 0x7be60 max_arch_pfn =3D 0x100000
>> [    0.000000] MTRR default type: uncachable
>> [    0.000000] MTRR fixed ranges enabled:
>> [    0.000000]   00000-9FFFF write-back
>> [    0.000000]   A0000-BFFFF uncachable
>> [    0.000000]   C0000-CDFFF write-protect
>> [    0.000000]   CE000-DFFFF uncachable
>> [    0.000000]   E0000-FFFFF write-protect
>> [    0.000000] MTRR variable ranges enabled:
>> [    0.000000]   0 base 0000000000 mask FF80000000 write-back
>> [    0.000000]   1 disabled
>> [    0.000000]   2 disabled
>> [    0.000000]   3 disabled
>> [    0.000000]   4 disabled
>> [    0.000000]   5 disabled
>> [    0.000000]   6 disabled
>> [    0.000000]   7 disabled
>> [    0.000000] e820 update range: 0000000000002000 - 000000000000600=
0
>> (usable) =3D=3D> (reserved)
>> [    0.000000] Scanning 1 areas for low memory corruption
>> [    0.000000] modified physical RAM map:
>> [    0.000000]  modified: 0000000000000000 - 0000000000002000 (usabl=
e)
>> [    0.000000]  modified: 0000000000002000 - 0000000000006000 (reser=
ved)
>> [    0.000000]  modified: 0000000000006000 - 000000000009dc00 (usabl=
e)
>> [    0.000000]  modified: 000000000009dc00 - 00000000000a0000 (reser=
ved)
>> [    0.000000]  modified: 00000000000ce000 - 0000000000100000 (reser=
ved)
>> [    0.000000]  modified: 0000000000100000 - 000000007be60000 (usabl=
e)
>> [    0.000000]  modified: 000000007be60000 - 000000007be70000 (ACPI =
data)
>> [    0.000000]  modified: 000000007be70000 - 000000007be72000 (ACPI =
NVS)
>> [    0.000000]  modified: 000000007be72000 - 000000007beff000 (reser=
ved)
>> [    0.000000]  modified: 000000007bf00000 - 0000000080000000 (reser=
ved)
>> [    0.000000]  modified: 00000000e0000000 - 00000000f0000000 (reser=
ved)
>> [    0.000000]  modified: 00000000fec00000 - 00000000fec10000 (reser=
ved)
>> [    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reser=
ved)
>> [    0.000000]  modified: 00000000fff00000 - 0000000100000000 (reser=
ved)
>> [    0.000000] initial memory mapped : 0 - 00c00000
>> [    0.000000] init_memory_mapping: 0000000000000000-00000000377fe00=
0
>> [    0.000000]  0000000000 - 0000400000 page 4k
>> [    0.000000]  0000400000 - 0037400000 page 2M
>> [    0.000000]  0037400000 - 00377fe000 page 4k
>> [    0.000000] kernel direct mapping tables up to 377fe000 @ 7000-c0=
00
>> [    0.000000] RAMDISK: 34f86000 - 37fef2c1
>> [    0.000000] Allocated new RAMDISK: 00892000 - 038fb2c1
>> [    0.000000] Move RAMDISK from 0000000034f86000 - 0000000037fef2c0=
 to
>> 00892000 - 038fb2c0
>> [    0.000000] ACPI: RSDP 000f7bc0 00024 (v02 GATEWA)
>> [    0.000000] ACPI: XSDT 7be680be 0007C (v01 GATEWA SYSTEM   060400=
00  LTP
>> 00000000)
>> [    0.000000] ACPI: FACP 7be6f4fc 000F4 (v03 ATI    Moray    060400=
00 ATI
>>  000F4240)
>> [    0.000000] ACPI: DSDT 7be6813a 073C2 (v01 GATEWA   SYSTEM 060400=
00 MSFT
>> 03000000)
>> [    0.000000] ACPI: FACS 7be71fc0 00040
>> [    0.000000] ACPI: SLIC 7be6f664 00176 (v01 GATEWA SYSTEM   060400=
00 LOHR
>> 00000000)
>> [    0.000000] ACPI: EINJ 7be6f7da 001B0 (v01 PTL    WHEAPTL  060400=
00 PTL
>>  00000001)
>> [    0.000000] ACPI: HEST 7be6f98a 00168 (v01 PTL    WHEAPTL  060400=
00 PTL
>>  00000001)
>> [    0.000000] ACPI: BERT 7be6faf2 00030 (v01 PTL    WHEAPTL  060400=
00 PTL
>>  00000001)
>> [    0.000000] ACPI: SSDT 7be6fb22 000E1 (v01 wheaos  wheaosc 060400=
00 INTL
>> 20050624)
>> [    0.000000] ACPI: ERST 7be6fc03 00270 (v01 PTL    WHEAPTL  060400=
00 PTL
>>  00000001)
>> [    0.000000] ACPI: SSDT 7be6fe73 000D3 (v01 AMD    POWERNOW 060400=
00 AMD
>>  00000001)
>> [    0.000000] ACPI: APIC 7be6ff46 00046 (v01 PTLTD      APIC   0604=
0000
>>  LTP 00000000)
>> [    0.000000] ACPI: MCFG 7be6ff8c 0003C (v01 PTLTD    MCFG   060400=
00  LTP
>> 00000000)
>> [    0.000000] ACPI: HPET 7be6ffc8 00038 (v01 PTLTD  HPETTBL  060400=
00  LTP
>> 00000001)
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>> [    0.000000] 1094MB HIGHMEM available.
>> [    0.000000] 887MB LOWMEM available.
>> [    0.000000]   mapped low ram: 0 - 377fe000
>> [    0.000000]   low ram: 0 - 377fe000
>> [    0.000000]   node 0 low ram: 00000000 - 377fe000
>> [    0.000000]   node 0 bootmap 00008000 - 0000ef00
>> [    0.000000] (9 early reservations) =3D=3D> bootmem [0000000000 - =
00377fe000]
>> [    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page =3D=3D=
>
>> [0000000000 - 0000001000]
>> [    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE =3D=3D=
>
>> [0000001000 - 0000002000]
>> [    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE =3D=3D=
>
>> [0000006000 - 0000007000]
>> [    0.000000]   #3 [0000100000 - 000088d278]    TEXT DATA BSS =3D=3D=
>
>> [0000100000 - 000088d278]
>> [    0.000000]   #4 [000009dc00 - 0000100000]    BIOS reserved =3D=3D=
>
>> [000009dc00 - 0000100000]
>> [    0.000000]   #5 [000088e000 - 0000891150]              BRK =3D=3D=
>
>> [000088e000 - 0000891150]
>> [    0.000000]   #6 [0000007000 - 0000008000]          PGTABLE =3D=3D=
>
>> [0000007000 - 0000008000]
>> [    0.000000]   #7 [0000892000 - 00038fb2c1]      NEW RAMDISK =3D=3D=
>
>> [0000892000 - 00038fb2c1]
>> [    0.000000]   #8 [0000008000 - 000000f000]          BOOTMAP =3D=3D=
>
>> [0000008000 - 000000f000]
>> [    0.000000] found SMP MP-table at [c00f7c80] f7c80
>> [    0.000000] Zone PFN ranges:
>> [    0.000000]   DMA      0x00000000 -> 0x00001000
>> [    0.000000]   Normal   0x00001000 -> 0x000377fe
>> [    0.000000]   HighMem  0x000377fe -> 0x0007be60
>> [    0.000000] Movable zone start PFN for each node
>> [    0.000000] early_node_map[3] active PFN ranges
>> [    0.000000]     0: 0x00000000 -> 0x00000002
>> [    0.000000]     0: 0x00000006 -> 0x0000009d
>> [    0.000000]     0: 0x00000100 -> 0x0007be60
>> [    0.000000] On node 0 totalpages: 507385
>> [    0.000000] free_area_init_node: node 0, pgdat c075e480, node_mem=
_map
>> c38fc000
>> [    0.000000]   DMA zone: 32 pages used for memmap
>> [    0.000000]   DMA zone: 0 pages reserved
>> [    0.000000]   DMA zone: 3961 pages, LIFO batch:0
>> [    0.000000]   Normal zone: 1744 pages used for memmap
>> [    0.000000]   Normal zone: 221486 pages, LIFO batch:31
>> [    0.000000]   HighMem zone: 2189 pages used for memmap
>> [    0.000000]   HighMem zone: 277973 pages, LIFO batch:31
>> [    0.000000] Using APIC driver default
>> [    0.000000] Detected use of extended apic ids on hypertransport b=
us
>> [    0.000000] ACPI: PM-Timer IO Port: 0x8008
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>> [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
>> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
>> [    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0=
])
>> [    0.000000] IOAPIC[0]: apic_id 1, version 33, address 0xfec00000,=
 GSI
>> 0-23
>> [    0.000000] ACPI: IRQ9 used by override.
>> [    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
>> [    0.000000] Using ACPI (MADT) for SMP configuration information
>> [    0.000000] ACPI: HPET id: 0x43538310 base: 0xfed00000
>> [    0.000000] SMP: Allowing 1 CPUs, 0 hotplug CPUs
>> [    0.000000] nr_irqs_gsi: 24
>> [    0.000000] PM: Registered nosave memory: 0000000000002000 -
>> 0000000000006000
>> [    0.000000] PM: Registered nosave memory: 000000000009d000 -
>> 000000000009e000
>> [    0.000000] PM: Registered nosave memory: 000000000009e000 -
>> 00000000000a0000
>> [    0.000000] PM: Registered nosave memory: 00000000000a0000 -
>> 00000000000ce000
>> [    0.000000] PM: Registered nosave memory: 00000000000ce000 -
>> 0000000000100000
>> [    0.000000] Allocating PCI resources starting at 80000000 (gap:
>> 80000000:60000000)
>> [    0.000000] NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:=
1
>> [    0.000000] PERCPU: Embedded 14 pages at c4886000, static data 35=
356
>> bytes
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on=
=2E  Total
>> pages: 503420
>> [    0.000000] Kernel command line:
>> root=3DUUID=3Dcad17313-d790-439d-93fb-184bc0fa0de3 ro quiet splash
>> [    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
>> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 52=
4288
>> bytes)
>> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 2621=
44
>> bytes)
>> [    0.000000] Enabling fast FPU save and restore... done.
>> [    0.000000] Enabling unmasked SIMD FPU exception support... done.
>> [    0.000000] Initializing CPU#0
>> [    0.000000] allocated 10149760 bytes of page_cgroup
>> [    0.000000] please try 'cgroup_disable=3Dmemory' option if you do=
n't want
>> memory cgroups
>> [    0.000000] Initializing HighMem for node 0 (000377fe:0007be60)
>> [    0.000000] Memory: 1944608k/2029952k available (4519k kernel cod=
e,
>> 84028k reserved, 2035k data, 536k init, 1120648k highmem)
>> [    0.000000] virtual kernel memory layout:
>> [    0.000000]     fixmap  : 0xfff1e000 - 0xfffff000   ( 900 kB)
>> [    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
>> [    0.000000]     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
>> [    0.000000]     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
>> [    0.000000]       .init : 0xc0767000 - 0xc07ed000   ( 536 kB)
>> [    0.000000]       .data : 0xc0569ca1 - 0xc0766c48   (2035 kB)
>> [    0.000000]       .text : 0xc0100000 - 0xc0569ca1   (4519 kB)
>> [    0.000000] Checking if this processor honours the WP bit even in
>> supervisor mode...Ok.
>> [    0.000000] SLUB: Genslabs=3D13, HWalign=3D64, Order=3D0-3, MinOb=
jects=3D0,
>> CPUs=3D1, Nodes=3D1
>> [    0.000000] NR_IRQS:512
>> [    0.000000] Fast TSC calibration using PIT
>> [    0.000000] Detected 1596.310 MHz processor.
>> [    0.000760] Console: colour VGA+ 80x25
>> [    0.000764] console [tty0] enabled
>> [    0.000999] hpet clockevent registered
>> [    0.000999] HPET: 4 timers in total, 0 timers will be used for pe=
r-cpu
>> timer
>> [    0.001008] Calibrating delay loop (skipped), value calculated us=
ing
>> timer frequency.. 3192.62 BogoMIPS (lpj=3D1596310)
>> [    0.001032] Security Framework initialized
>> [    0.001039] SELinux:  Disabled at boot.
>> [    0.001047] Mount-cache hash table entries: 512
>> [    0.001195] Initializing cgroup subsys ns
>> [    0.001199] Initializing cgroup subsys cpuacct
>> [    0.001204] Initializing cgroup subsys memory
>> [    0.001212] Initializing cgroup subsys freezer
>> [    0.001227] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64
>> bytes/line)
>> [    0.001230] CPU: L2 Cache: 512K (64 bytes/line)
>> [    0.001234] using C1E aware idle routine
>> [    0.001243] Performance Counters: AMD PMU driver.
>> [    0.001250] ... version:                 0
>> [    0.001252] ... bit width:               48
>> [    0.001254] ... generic counters:        4
>> [    0.001256] ... value mask:              0000ffffffffffff
>> [    0.001259] ... max period:              00007fffffffffff
>> [    0.001261] ... fixed-purpose counters:  0
>> [    0.001263] ... counter mask:            000000000000000f
>> [    0.001268] Checking 'hlt' instruction... OK.
>> [    0.005620] SMP alternatives: switching to UP code
>> [    0.013306] Freeing SMP alternatives: 20k freed
>> [    0.013326] ACPI: Core revision 20090521
>> [    0.027425] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D0 apic2=3D-1 =
pin2=3D-1
>> [    0.027995] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
>> [    0.027995] ...trying to set up timer (IRQ0) through the 8259A ..=
=2E
>> [    0.027995] ..... (found apic 0 pin 0) ...
>> [    0.038677] ....... works.
>> [    0.038679] CPU0: AMD Athlon(tm) Processor 2650e stepping 02
>> [    0.038994] Brought up 1 CPUs
>> [    0.038994] Total of 1 processors activated (3192.62 BogoMIPS).
>> [    0.038994] CPU0 attaching NULL sched-domain.
>> [    0.038994] Booting paravirtualized kernel on bare hardware
>> [    0.038994] regulator: core version 0.5
>> [    0.038994] Time: 17:19:19  Date: 09/10/09
>> [    0.038994] NET: Registered protocol family 16
>> [    0.038994] EISA bus registered
>> [    0.038994] ACPI: bus type pci registered
>> [    0.038994] PCI: MCFG configuration 0: base e0000000 segment 0 bu=
ses 0 -
>> 9
>> [    0.038994] PCI: MCFG area at e0000000 reserved in E820
>> [    0.038994] PCI: Using MMCONFIG for extended config space
>> [    0.038994] PCI: Using configuration type 1 for base access
>> [    0.039935] bio: create slab <bio-0> at 0
>> [    0.040677] ACPI: EC: Look up EC in DSDT
>> [    0.044893] ACPI: BIOS _OSI(Linux) query ignored
>> [    0.046170] ACPI: Interpreter enabled
>> [    0.046176] ACPI: (supports S0 S3 S4 S5)
>> [    0.046197] ACPI: Using IOAPIC for interrupt routing
>> [    0.051178] ACPI: EC: non-query interrupt received, switching to
>> interrupt mode
>> [    0.118457] ACPI: EC: GPE =3D 0x10, I/O: command/status =3D 0x66,=
 data =3D 0x62
>> [    0.118460] ACPI: EC: driver started in interrupt mode
>> [    0.118879] ACPI: No dock devices found.
>> [    0.120637] ACPI: PCI Root Bridge [PCI0] (0000:00)
>> [    0.120758] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
>> [    0.120762] pci 0000:00:06.0: PME# disabled
>> [    0.120794] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
>> [    0.120798] pci 0000:00:07.0: PME# disabled
>> [    0.120853] pci 0000:00:12.0: reg 10 io port: [0x8440-0x8447]
>> [    0.120861] pci 0000:00:12.0: reg 14 io port: [0x8434-0x8437]
>> [    0.120870] pci 0000:00:12.0: reg 18 io port: [0x8438-0x843f]
>> [    0.120878] pci 0000:00:12.0: reg 1c io port: [0x8430-0x8433]
>> [    0.120887] pci 0000:00:12.0: reg 20 io port: [0x8400-0x840f]
>> [    0.120895] pci 0000:00:12.0: reg 24 32bit mmio: [0xfc607000-0xfc=
6073ff]
>> [    0.120915] pci 0000:00:12.0: set SATA to AHCI mode
>>    =20
>
> Hrm...maybe it would be better to disable AHCI and try legacy mode?
> Suboptimal but might help differentiate between AHCI issues and HW is=
sues.
> This is not especially useful IMHO - but keep it in mind.
>
>  =20
>> [    0.120957] pci 0000:00:13.0: reg 10 32bit mmio: [0xfc604000-0xfc=
604fff]
>> [    0.121021] pci 0000:00:13.1: reg 10 32bit mmio: [0xfc605000-0xfc=
605fff]
>> [    0.121086] pci 0000:00:13.4: reg 10 32bit mmio: [0xfc606000-0xfc=
606fff]
>> [    0.121166] pci 0000:00:13.5: reg 10 32bit mmio: [0xfc607400-0xfc=
6074ff]
>> [    0.121223] pci 0000:00:13.5: supports D1 D2
>> [    0.121225] pci 0000:00:13.5: PME# supported from D0 D1 D2 D3hot
>> [    0.121231] pci 0000:00:13.5: PME# disabled
>> [    0.121279] pci 0000:00:14.0: reg 10 io port: [0x8410-0x841f]
>> [    0.121352] pci 0000:00:14.1: reg 10 io port: [0x1f0-0x1f7]
>> [    0.121360] pci 0000:00:14.1: reg 14 io port: [0x3f4-0x3f7]
>> [    0.121368] pci 0000:00:14.1: reg 18 io port: [0x00-0x07]
>> [    0.121377] pci 0000:00:14.1: reg 1c io port: [0x00-0x03]
>> [    0.121385] pci 0000:00:14.1: reg 20 io port: [0x8420-0x842f]
>> [    0.121442] pci 0000:00:14.2: reg 10 64bit mmio: [0xfc600000-0xfc=
603fff]
>> [    0.121489] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
>> [    0.121495] pci 0000:00:14.2: PME# disabled
>> [    0.121693] pci 0000:01:05.0: reg 10 64bit mmio: [0xf8000000-0xfb=
ffffff]
>> [    0.121700] pci 0000:01:05.0: reg 18 64bit mmio: [0xfc200000-0xfc=
20ffff]
>> [    0.121705] pci 0000:01:05.0: reg 20 io port: [0x9400-0x94ff]
>> [    0.121710] pci 0000:01:05.0: reg 24 32bit mmio: [0xfc100000-0xfc=
1fffff]
>> [    0.121723] pci 0000:01:05.0: supports D1 D2
>> [    0.121741] pci 0000:00:01.0: bridge io port: [0x9000-0x9fff]
>> [    0.121745] pci 0000:00:01.0: bridge 32bit mmio: [0xfc100000-0xfc=
2fffff]
>> [    0.121750] pci 0000:00:01.0: bridge 64bit mmio pref:
>> [0xf8000000-0xfbffffff]
>> [    0.121836] pci 0000:02:00.0: reg 10 64bit mmio: [0xfc300000-0xfc=
303fff]
>> [    0.121892] pci 0000:02:00.0: supports D1 D2
>> [    0.121895] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
>> [    0.121900] pci 0000:02:00.0: PME# disabled
>> [    0.121964] pci 0000:00:06.0: bridge 32bit mmio: [0xfc300000-0xfc=
3fffff]
>> [    0.122007] pci 0000:05:00.0: reg 10 io port: [0xa400-0xa4ff]
>> [    0.122024] pci 0000:05:00.0: reg 18 64bit mmio: [0xfc010000-0xfc=
010fff]
>> [    0.122036] pci 0000:05:00.0: reg 20 64bit mmio: [0xfc000000-0xfc=
00ffff]
>> [    0.122044] pci 0000:05:00.0: reg 30 32bit mmio: [0x000000-0x01ff=
ff]
>> [    0.122075] pci 0000:05:00.0: supports D1 D2
>> [    0.122078] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot =
D3cold
>> [    0.122083] pci 0000:05:00.0: PME# disabled
>> [    0.122146] pci 0000:00:07.0: bridge io port: [0xa000-0xafff]
>> [    0.122151] pci 0000:00:07.0: bridge 64bit mmio pref:
>> [0xfc000000-0xfc0fffff]
>> [    0.122213] pci 0000:00:14.4: transparent bridge
>> [    0.122235] pci_bus 0000:00: on NUMA node 0
>> [    0.122240] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>> [    0.122385] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB6_._P=
RT]
>> [    0.122462] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB7_._P=
RT]
>> [    0.122580] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._P=
RT]
>> [    0.126020] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disa=
bled.
>> [    0.126149] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disa=
bled.
>> [    0.126276] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disa=
bled.
>> [    0.126402] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disa=
bled.
>> [    0.126529] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disa=
bled.
>> [    0.126656] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disa=
bled.
>> [    0.126783] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disa=
bled.
>> [    0.126910] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disa=
bled.
>> [    0.127106] SCSI subsystem initialized
>> [    0.127172] libata version 3.00 loaded.
>> [    0.127256] usbcore: registered new interface driver usbfs
>> [    0.127274] usbcore: registered new interface driver hub
>> [    0.127301] usbcore: registered new device driver usb
>> [    0.127491] ACPI: WMI: Mapper loaded
>> [    0.127493] PCI: Using ACPI for IRQ routing
>> [    0.127742] Bluetooth: Core ver 2.15
>> [    0.127772] NET: Registered protocol family 31
>> [    0.127774] Bluetooth: HCI device and connection manager initiali=
zed
>> [    0.127778] Bluetooth: HCI socket layer initialized
>> [    0.127781] NET: Registered protocol family 8
>> [    0.127783] NET: Registered protocol family 20
>> [    0.127795] NetLabel: Initializing
>> [    0.127797] NetLabel:  domain hash size =3D 128
>> [    0.127799] NetLabel:  protocols =3D UNLABELED CIPSOv4
>> [    0.127815] NetLabel:  unlabeled traffic allowed by default
>> [    0.127852] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
>> [    0.127858] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
>> [    0.131793] pnp: PnP ACPI init
>> [    0.131816] ACPI: bus type pnp registered
>> [    0.168034] pnp: PnP ACPI: found 11 devices
>> [    0.168037] ACPI: ACPI bus type pnp unregistered
>> [    0.168041] PnPBIOS: Disabled by ACPI PNP
>> [    0.168056] system 00:01: iomem range 0xfec00000-0xfec00fff could=
 not be
>> reserved
>> [    0.168060] system 00:01: iomem range 0xfee00000-0xfee00fff has b=
een
>> reserved
>> [    0.168069] system 00:08: ioport range 0x1080-0x1080 has been res=
erved
>> [    0.168074] system 00:08: ioport range 0x220-0x22f has been reser=
ved
>> [    0.168078] system 00:08: ioport range 0x40b-0x40b has been reser=
ved
>> [    0.168081] system 00:08: ioport range 0x4d0-0x4d1 has been reser=
ved
>> [    0.168085] system 00:08: ioport range 0x4d6-0x4d6 has been reser=
ved
>> [    0.168089] system 00:08: ioport range 0x530-0x537 has been reser=
ved
>> [    0.168093] system 00:08: ioport range 0xc00-0xc01 has been reser=
ved
>> [    0.168096] system 00:08: ioport range 0xc14-0xc14 has been reser=
ved
>> [    0.168100] system 00:08: ioport range 0xc50-0xc52 has been reser=
ved
>> [    0.168104] system 00:08: ioport range 0xc6c-0xc6c has been reser=
ved
>> [    0.168108] system 00:08: ioport range 0xc6f-0xc6f has been reser=
ved
>> [    0.168112] system 00:08: ioport range 0xcd0-0xcd1 has been reser=
ved
>> [    0.168116] system 00:08: ioport range 0xcd2-0xcd3 has been reser=
ved
>> [    0.168119] system 00:08: ioport range 0xcd4-0xcd5 has been reser=
ved
>> [    0.168123] system 00:08: ioport range 0xcd6-0xcd7 has been reser=
ved
>> [    0.168127] system 00:08: ioport range 0xcd8-0xcdf has been reser=
ved
>> [    0.168131] system 00:08: ioport range 0x8000-0x805f has been res=
erved
>> [    0.168135] system 00:08: ioport range 0xf40-0xf47 has been reser=
ved
>> [    0.168139] system 00:08: ioport range 0x87f-0x87f has been reser=
ved
>> [    0.168143] system 00:08: ioport range 0xfd60-0xfd63 has been res=
erved
>> [    0.168150] system 00:09: iomem range 0xe0000-0xfffff could not b=
e
>> reserved
>> [    0.168154] system 00:09: iomem range 0xfff00000-0xffffffff has b=
een
>> reserved
>> [    0.202905] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
>> [    0.202909] pci 0000:00:01.0:   IO window: 0x9000-0x9fff
>> [    0.202913] pci 0000:00:01.0:   MEM window: 0xfc100000-0xfc2fffff
>> [    0.202918] pci 0000:00:01.0:   PREFETCH window:
>> 0x000000f8000000-0x000000fbffffff
>> [    0.202923] pci 0000:00:06.0: PCI bridge, secondary bus 0000:02
>> [    0.202926] pci 0000:00:06.0:   IO window: disabled
>> [    0.202930] pci 0000:00:06.0:   MEM window: 0xfc300000-0xfc3fffff
>> [    0.202933] pci 0000:00:06.0:   PREFETCH window: disabled
>> [    0.202938] pci 0000:00:07.0: PCI bridge, secondary bus 0000:05
>> [    0.202942] pci 0000:00:07.0:   IO window: 0xa000-0xafff
>> [    0.202946] pci 0000:00:07.0:   MEM window: 0x80000000-0x800fffff
>> [    0.202950] pci 0000:00:07.0:   PREFETCH window:
>> 0x000000fc000000-0x000000fc0fffff
>> [    0.202955] pci 0000:00:14.4: PCI bridge, secondary bus 0000:08
>> [    0.202957] pci 0000:00:14.4:   IO window: disabled
>> [    0.202969] pci 0000:00:14.4:   MEM window: disabled
>> [    0.202973] pci 0000:00:14.4:   PREFETCH window: disabled
>> [    0.202987] pci 0000:00:06.0: setting latency timer to 64
>> [    0.202993] pci 0000:00:07.0: setting latency timer to 64
>> [    0.203002] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
>> [    0.203006] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff=
]
>> [    0.203010] pci_bus 0000:01: resource 0 io:  [0x9000-0x9fff]
>> [    0.203013] pci_bus 0000:01: resource 1 mem: [0xfc100000-0xfc2fff=
ff]
>> [    0.203017] pci_bus 0000:01: resource 2 pref mem [0xf8000000-0xfb=
ffffff]
>> [    0.203020] pci_bus 0000:02: resource 1 mem: [0xfc300000-0xfc3fff=
ff]
>> [    0.203024] pci_bus 0000:05: resource 0 io:  [0xa000-0xafff]
>> [    0.203028] pci_bus 0000:05: resource 1 mem: [0x80000000-0x800fff=
ff]
>> [    0.203031] pci_bus 0000:05: resource 2 pref mem [0xfc000000-0xfc=
0fffff]
>> [    0.203035] pci_bus 0000:08: resource 3 io:  [0x00-0xffff]
>> [    0.203038] pci_bus 0000:08: resource 4 mem: [0x000000-0xffffffff=
]
>> [    0.203081] NET: Registered protocol family 2
>> [    0.203190] IP route cache hash table entries: 32768 (order: 5, 1=
31072
>> bytes)
>> [    0.203589] TCP established hash table entries: 131072 (order: 8,=
 1048576
>> bytes)
>> [    0.204368] TCP bind hash table entries: 65536 (order: 7, 524288 =
bytes)
>> [    0.204722] TCP: Hash tables configured (established 131072 bind =
65536)
>> [    0.204725] TCP reno registered
>> [    0.204820] NET: Registered protocol family 1
>> [    0.204893] Trying to unpack rootfs image as initramfs...
>> [    0.500908] Switched to high resolution mode on CPU 0
>> [    2.278210] Freeing initrd memory: 49572k freed
>> [    2.312474] cpufreq-nforce2: No nForce2 chipset.
>> [    2.312510] Scanning for low memory corruption every 60 seconds
>> [    2.312673] audit: initializing netlink socket (disabled)
>> [    2.312697] type=3D2000 audit(1252603160.312:1): initialized
>> [    2.324022] highmem bounce pool size: 64 pages
>> [    2.324028] HugeTLB registered 4 MB page size, pre-allocated 0 pa=
ges
>> [    2.325747] VFS: Disk quotas dquot_6.5.2
>> [    2.325817] Dquot-cache hash table entries: 1024 (order 0, 4096 b=
ytes)
>> [    2.326450] fuse init (API version 7.12)
>> [    2.326546] msgmni has been set to 1707
>> [    2.326743] alg: No test for stdrng (krng)
>> [    2.326755] io scheduler noop registered
>> [    2.326758] io scheduler anticipatory registered
>> [    2.326760] io scheduler deadline registered
>> [    2.326813] io scheduler cfq registered (default)
>> [    2.326879] pci 0000:01:05.0: Boot video device
>> [    2.326992] pcieport-driver 0000:00:06.0: irq 24 for MSI/MSI-X
>> [    2.326998] pcieport-driver 0000:00:06.0: setting latency timer t=
o 64
>> [    2.327082] pcieport-driver 0000:00:07.0: irq 25 for MSI/MSI-X
>> [    2.327088] pcieport-driver 0000:00:07.0: setting latency timer t=
o 64
>> [    2.327151] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>> [    2.327177] pciehp: PCI Express Hot Plug Controller Driver versio=
n: 0.4
>> [    2.340095] ACPI: AC Adapter [ACAD] (off-line)
>> [    2.340180] input: Power Button as
>> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
>> [    2.340185] ACPI: Power Button [PWRF]
>> [    2.340241] input: Power Button as
>> /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
>> [    2.340245] ACPI: Power Button [PWRB]
>> [    2.340291] input: Sleep Button as
>> /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
>> [    2.340294] ACPI: Sleep Button [SLPB]
>> [    2.340346] input: Lid Switch as
>> /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input3
>> [    2.340399] ACPI: Lid Switch [LID]
>> [    2.340606] Marking TSC unstable due to TSC halts in idle
>> [    2.340625] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
>> [    2.340652] processor LNXCPU:00: registered as cooling_device0
>> [    2.340656] ACPI: Processor [CPU0] (supports 8 throttling states)
>> [    2.393425] ACPI: Invalid active0 threshold
>> [    2.409955] thermal LNXTHERM:01: registered as thermal_zone0
>> [    2.409963] ACPI: Thermal Zone [THRM] (29 C)
>> [    2.410150] isapnp: Scanning for PnP cards...
>> [    2.769719] isapnp: No Plug & Play device found
>> [    3.135945] ACPI: Battery Slot [BAT1] (battery present)
>> [    3.136204] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabl=
ed
>> [    3.137655] brd: module loaded
>> [    3.138187] loop: module loaded
>> [    3.138277] input: Macintosh mouse button emulation as
>> /devices/virtual/input/input4
>> [    3.138352] ahci 0000:00:12.0: version 3.0
>> [    3.138375] ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -=
> IRQ 22
>> [    3.138525] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 =
Gbps 0xf
>> impl SATA mode
>> [    3.138530] ahci 0000:00:12.0: flags: 64bit ncq sntf ilck led clo=
 pmp pio
>> [    3.139243] scsi0 : ahci
>> [    3.139368] scsi1 : ahci
>> [    3.139439] scsi2 : ahci
>> [    3.139519] scsi3 : ahci
>> [    3.139641] ata1: SATA max UDMA/133 abar m1024@0xfc607000 port 0x=
fc607100
>> irq 22
>> [    3.139646] ata2: SATA max UDMA/133 abar m1024@0xfc607000 port 0x=
fc607180
>> irq 22
>> [    3.139651] ata3: SATA max UDMA/133 abar m1024@0xfc607000 port 0x=
fc607200
>> irq 22
>> [    3.139655] ata4: SATA max UDMA/133 abar m1024@0xfc607000 port 0x=
fc607280
>> irq 22
>> [    3.140564] pata_atiixp 0000:00:14.1: enabling device (0014 -> 00=
15)
>> [    3.140576] pata_atiixp 0000:00:14.1: PCI INT A -> GSI 16 (level,=
 low) ->
>> IRQ 16
>> [    3.140610] pata_atiixp 0000:00:14.1: setting latency timer to 64
>> [    3.140734] scsi4 : pata_atiixp
>> [    3.140827] scsi5 : pata_atiixp
>> [    3.141750] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x8=
420 irq
>> 14
>> [    3.141753] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x8=
428 irq
>> 15
>> [    3.142275] Fixed MDIO Bus: probed
>> [    3.142283] PPP generic driver version 2.4.2
>> [    3.142420] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) D=
river
>> [    3.142444] ehci_hcd 0000:00:13.5: PCI INT D -> GSI 19 (level, lo=
w) ->
>> IRQ 19
>> [    3.142463] ehci_hcd 0000:00:13.5: EHCI Host Controller
>> [    3.142519] ehci_hcd 0000:00:13.5: new USB bus registered, assign=
ed bus
>> number 1
>> [    3.142551] ehci_hcd 0000:00:13.5: applying AMD SB600/SB700 USB f=
reeze
>> workaround
>> [    3.142571] ehci_hcd 0000:00:13.5: debug port 1
>> [    3.142591] ehci_hcd 0000:00:13.5: irq 19, io mem 0xfc607400
>> [    3.148023] ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00
>> [    3.148129] usb usb1: configuration #1 chosen from 1 choice
>> [    3.148169] hub 1-0:1.0: USB hub found
>> [    3.148189] hub 1-0:1.0: 10 ports detected
>> [    3.148282] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Drive=
r
>> [    3.148302] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 16 (level, lo=
w) ->
>> IRQ 16
>> [    3.148314] ohci_hcd 0000:00:13.0: OHCI Host Controller
>> [    3.148353] ohci_hcd 0000:00:13.0: new USB bus registered, assign=
ed bus
>> number 2
>> [    3.148379] ohci_hcd 0000:00:13.0: irq 16, io mem 0xfc604000
>> [    3.199111] usb usb2: configuration #1 chosen from 1 choice
>> [    3.199150] hub 2-0:1.0: USB hub found
>> [    3.199165] hub 2-0:1.0: 2 ports detected
>> [    3.199220] ohci_hcd 0000:00:13.1: PCI INT B -> GSI 17 (level, lo=
w) ->
>> IRQ 17
>> [    3.199230] ohci_hcd 0000:00:13.1: OHCI Host Controller
>> [    3.199265] ohci_hcd 0000:00:13.1: new USB bus registered, assign=
ed bus
>> number 3
>> [    3.199291] ohci_hcd 0000:00:13.1: irq 17, io mem 0xfc605000
>> [    3.250113] usb usb3: configuration #1 chosen from 1 choice
>> [    3.250143] hub 3-0:1.0: USB hub found
>> [    3.250158] hub 3-0:1.0: 2 ports detected
>> [    3.250212] ohci_hcd 0000:00:13.4: PCI INT C -> GSI 18 (level, lo=
w) ->
>> IRQ 18
>> [    3.250222] ohci_hcd 0000:00:13.4: OHCI Host Controller
>> [    3.250260] ohci_hcd 0000:00:13.4: new USB bus registered, assign=
ed bus
>> number 4
>> [    3.250285] ohci_hcd 0000:00:13.4: irq 18, io mem 0xfc606000
>> [    3.305017] usb usb4: configuration #1 chosen from 1 choice
>> [    3.305049] hub 4-0:1.0: USB hub found
>> [    3.305062] hub 4-0:1.0: 2 ports detected
>> [    3.305118] uhci_hcd: USB Universal Host Controller Interface dri=
ver
>> [    3.305212] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSS0] at 0=
x60,0x64
>> irq 1,12
>> [    3.330782] serio: i8042 KBD port at 0x60,0x64 irq 1
>> [    3.330789] serio: i8042 AUX port at 0x60,0x64 irq 12
>> [    3.330898] mice: PS/2 mouse device common for all mice
>> [    3.333240] rtc_cmos 00:04: RTC can wake from S4
>> [    3.333280] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
>> [    3.333311] rtc0: alarms up to one month, 114 bytes nvram, hpet i=
rqs
>> [    3.333427] device-mapper: uevent: version 1.0.3
>> [    3.333536] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initi=
alised:
>> dm-devel@redhat.com
>> [    3.333591] device-mapper: multipath: version 1.1.0 loaded
>> [    3.333595] device-mapper: multipath round-robin: version 1.0.0 l=
oaded
>> [    3.333728] EISA: Probing bus 0 at eisa.0
>> [    3.333739] Cannot allocate resource for EISA slot 1
>> [    3.333766] Cannot allocate resource for EISA slot 8
>> [    3.333769] EISA: Detected 0 cards.
>> [    3.333857] cpuidle: using governor ladder
>> [    3.333926] cpuidle: using governor menu
>> [    3.334452] TCP cubic registered
>> [    3.334624] NET: Registered protocol family 10
>> [    3.335116] lo: Disabled Privacy Extensions
>> [    3.335459] NET: Registered protocol family 17
>> [    3.335478] Bluetooth: L2CAP ver 2.13
>> [    3.335480] Bluetooth: L2CAP socket layer initialized
>> [    3.335483] Bluetooth: SCO (Voice Link) ver 0.6
>> [    3.335485] Bluetooth: SCO socket layer initialized
>> [    3.335518] Bluetooth: RFCOMM TTY layer initialized
>> [    3.335521] Bluetooth: RFCOMM socket layer initialized
>> [    3.335523] Bluetooth: RFCOMM ver 1.11
>> [    3.335552] powernow-k8: Found 1 AMD Athlon(tm) Processor 2650e
>> processors (1 cpu cores) (version 2.20.00)
>> [    3.335591] powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x16
>> [    3.335595] powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x16
>> [    3.335646] Using IPI No-Shortcut mode
>> [    3.335721] PM: Resume from disk failed.
>> [    3.335735] registered taskstats version 1
>> [    3.335878]   Magic number: 9:842:339
>> [    3.335926] ehci_hcd 0000:00:13.5: hash matches
>> [    3.335976] rtc_cmos 00:04: setting system clock to 2009-09-10 17=
:19:23
>> UTC (1252603163)
>> [    3.335980] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
>> [    3.335982] EDD information not available.
>> [    3.350917] input: AT Translated Set 2 keyboard as
>> /devices/platform/i8042/serio0/input/input5
>> [    3.445042] ata2: SATA link down (SStatus 0 SControl 300)
>> [    3.448036] ata4: SATA link down (SStatus 0 SControl 300)
>> [    3.516027] usb 1-10: new high speed USB device using ehci_hcd an=
d
>> address 3
>> [    3.598026] ata1: softreset failed (device not ready)
>> [    3.598066] ata1: applying SB600 PMP SRST workaround and retrying
>> [    3.598084] ata3: softreset failed (device not ready)
>> [    3.598121] ata3: applying SB600 PMP SRST workaround and retrying
>> [    3.670374] usb 1-10: configuration #1 chosen from 1 choice
>> [    3.751036] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300=
)
>>    =20
>
> So this appears to be the "Optiarc  DVD RW AD-7580S" and needs to run
> at 1.5Gbps.
>
>  =20
>> [    3.751061] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300=
)
>> [    3.765868] ata3.00: ATAPI: Optiarc DVD RW AD-7580S, FX04, max UD=
MA/100,
>> ATAPI AN
>> [    3.765893] ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
>> [    3.780365] ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
>> [    3.780369] ata3.00: configured for UDMA/100
>> [    3.799807] ata1.00: ATA-8: WDC WD1600BEVT-22ZCT0, 11.01A11, max =
UDMA/133
>> [    3.799812] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (dept=
h 31/32)
>> [    3.799836] ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
>> [    3.801143] ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
>> [    3.801147] ata1.00: configured for UDMA/133
>> [    3.801263] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600BE=
VT-2
>> 11.0 PQ: 0 ANSI: 5
>> [    3.801405] sd 0:0:0:0: Attached scsi generic sg0 type 0
>> [    3.801451] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: =
(160
>> GB/149 GiB)
>> [    3.801504] sd 0:0:0:0: [sda] Write Protect is off
>> [    3.801508] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> [    3.801536] sd 0:0:0:0: [sda] Write cache: enabled, read cache: e=
nabled,
>> doesn't support DPO or FUA
>> [    3.801675]  sda:
>> [    3.806361] scsi 2:0:0:0: CD-ROM            Optiarc  DVD RW AD-75=
80S
>>  FX04 PQ: 0 ANSI: 5
>> [    3.808136]  sda1 sda2 sda3 sda4
>> [    3.812011] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa=
/form2
>> cdda tray
>> [    3.812015] Uniform CD-ROM driver Revision: 3.20
>> [    3.812107] sr 2:0:0:0: Attached scsi CD-ROM sr0
>> [    3.812163] sr 2:0:0:0: Attached scsi generic sg1 type 5
>> [    3.830791] sd 0:0:0:0: [sda] Attached SCSI disk
>> [    3.900033] usb 2-1: new low speed USB device using ohci_hcd and =
address
>> 2
>> [    3.963098] Freeing unused kernel memory: 536k freed
>> [    3.963560] Write protecting the kernel text: 4520k
>> [    3.963597] Write protecting the kernel read-only data: 1668k
>> [    4.056154] usb 2-1: configuration #1 chosen from 1 choice
>> [    4.452973] b43-pci-bridge 0000:02:00.0: PCI INT A -> GSI 18 (lev=
el, low)
>> -> IRQ 18
>> [    4.452985] b43-pci-bridge 0000:02:00.0: setting latency timer to=
 64
>> [    4.498334] ssb: Sonics Silicon Backplane found on PCI device
>> 0000:02:00.0
>> [    4.547142] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
>> [    4.547162] r8169 0000:05:00.0: PCI INT A -> GSI 19 (level, low) =
-> IRQ
>> 19
>> [    4.547200] r8169 0000:05:00.0: setting latency timer to 64
>> [    4.547244] r8169 0000:05:00.0: irq 26 for MSI/MSI-X
>> [    4.547911] eth0: RTL8102e at 0xf81de000, 00:1e:ec:d8:d7:87, XID =
24a00000
>> IRQ 26
>> [    4.571978] usbcore: registered new interface driver hiddev
>> [    4.584409] input: Microsoft Microsoft Wireless Optical Mouse=C2=AE=
 1.00 as
>> /devices/pci0000:00/0000:00:13.0/usb2/2-1/2-1:1.0/input/input6
>> [    4.584502] generic-usb 0003:045E:00E1.0001: input,hidraw0: USB H=
ID v1.11
>> Mouse [Microsoft Microsoft Wireless Optical Mouse=C2=AE 1.00] on
>> usb-0000:00:13.0-1/input0
>> [    4.584525] usbcore: registered new interface driver usbhid
>> [    4.584529] usbhid: v2.6:USB HID core driver
>> [    4.943719] PM: Starting manual resume from disk
>> [    4.943724] PM: Resume from partition 8:4
>> [    4.943727] PM: Checking hibernation image.
>> [    4.943893] PM: Resume from disk failed.
>> [    4.947813] EXT3-fs: INFO: recovery required on readonly filesyst=
em.
>> [    4.947817] EXT3-fs: write access will be enabled during recovery=
=2E
>> [    5.016390] kjournald starting.  Commit interval 5 seconds
>> [    5.016406] EXT3-fs: recovery complete.
>> [    5.016883] EXT3-fs: mounted filesystem with writeback data mode.
>> [   10.922166] udev: starting version 141
>> [   11.369369] shpchp: Standard Hot Plug PCI Controller Driver versi=
on: 0.4
>> [   11.479755] Linux agpgart interface v0.103
>> [   11.526632] k8temp 0000:00:18.3: Temperature readouts might be wr=
ong -
>> check erratum #141
>> [   11.538693] input: PC Speaker as /devices/platform/pcspkr/input/i=
nput7
>> [   11.552042] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0x=
8410,
>> revision 0
>> [   11.850231] cfg80211: Calling CRDA to update world regulatory dom=
ain
>> [   12.027894] cfg80211: World regulatory domain updated:
>> [   12.027899]  (start_freq - end_freq @ bandwidth), (max_antenna_ga=
in,
>> max_eirp)
>> [   12.027904]  (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2=
000 mBm)
>> [   12.027908]  (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2=
000 mBm)
>> [   12.027911]  (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2=
000 mBm)
>> [   12.027915]  (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2=
000 mBm)
>> [   12.027918]  (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2=
000 mBm)
>> [   12.121833] ACPI Error: Current brightness invalid 20090521 video=
-538
>>    =20
>
> This looks like the datestamp (May 21, 2009) was used as a parameter.
>
>  =20
>> [   12.122050] input: Video Bus as
>> /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:1c/device:1d/input/=
input8
>> [   12.122100] ACPI: Video Device [VGA] (multi-head: yes  rom: no  p=
ost: no)
>> [   12.973509] r8169: eth0: link up
>> [   12.973517] r8169: eth0: link up
>> [   13.037581] b43-phy0: Broadcom 4312 WLAN found (core revision 15)
>> [   13.052066] b43-phy0 ERROR: FOUND UNSUPPORTED PHY (Analog 6, Type=
 5,
>> Revision 1)
>> [   13.052090] b43: probe of ssb0:0 failed with error -95
>> [   13.052122] Broadcom 43xx driver loaded [ Features: PL, Firmware-=
ID: FW13
>> ]
>> [   13.089281] Synaptics Touchpad, model: 1, fw: 6.3, id: 0x1280b1, =
caps:
>> 0xa04711/0xa04000
>> [   13.177228] input: SynPS/2 Synaptics TouchPad as
>> /devices/platform/i8042/serio1/input/input9
>> [   13.279221] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, l=
ow) ->
>> IRQ 16
>> [   13.379619] hda_codec: Unknown model for ALC268, trying auto-prob=
e from
>> BIOS...
>> [   13.736277] lp: driver loaded but no devices found
>> [   13.856449] Adding 2000084k swap on /dev/sda4.  Priority:-1 exten=
ts:1
>> across:2000084k
>> [   13.890645] EXT3 FS on sda3, internal journal
>> [   16.325108] ppdev: user-space parallel port driver
>> [   22.716218] pci 0000:01:05.0: power state changed by ACPI to D0
>> [   22.716229] pci 0000:01:05.0: PCI INT A -> GSI 18 (level, low) ->=
 IRQ 18
>> [   23.038089] [drm] Initialized drm 1.1.0 20060810
>> [   23.145465] [drm] Initialized radeon 1.31.0 20080528 for 0000:01:=
05.0 on
>> minor 0
>> [   23.713761] [drm] Setting GART location based on new memory map
>> [   23.714924] [drm] Loading RS690/RS740 Microcode
>> [   23.714946] [drm] Num pipes: 1
>> [   23.714954] [drm] writeback test succeeded in 1 usecs
>> [   23.794018] eth0: no IPv6 routers present
>> [   23.889021] ACPI: EC: missing confirmations, switch off interrupt=
 mode.
>> [   59.008036] ata3.00: qc timeout (cmd 0xa0)
>> [   59.008057] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action=
 0x6
>> frozen
>> [   59.008062] ata3.00: irq_stat 0x40000001
>> [   59.008075] ata3.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag =
0
>> [   59.008076]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 =
00 00 00
>> [   59.008078]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emas=
k 0x5
>> (timeout)
>> [   59.008082] ata3.00: status: { DRDY ERR }
>> [   59.008088] ata3: hard resetting link
>> [   59.466036] ata3: softreset failed (device not ready)
>> [   59.466043] ata3: applying SB600 PMP SRST workaround and retrying
>> [   59.619047] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300=
)
>> [   59.633907] ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
>> [   59.648456] ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
>> [   59.648462] ata3.00: configured for UDMA/100
>> [   59.648977] ata3: EH complete
>>    =20
>
> and ata3 is happy now? No, it's not. Anyone else willing to comment o=
n
> the console messages below?
>
> thanks,
> grant
>
>  =20
>> [   85.000042] Clocksource tsc unstable (delta =3D -250052437 ns)
>> [   89.561080] ata3.00: qc timeout (cmd 0xa0)
>> [   89.561114] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action=
 0x6
>> frozen
>> [   89.561124] ata3.00: irq_stat 0x40000001
>> [   89.561150] ata3.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag =
0
>> [   89.561153]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 =
00 00 00
>> [   89.561156]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emas=
k 0x5
>> (timeout)
>> [   89.561166] ata3.00: status: { DRDY ERR }
>> [   89.561178] ata3: hard resetting link
>> [   90.019045] ata3: softreset failed (device not ready)
>> [   90.019058] ata3: applying SB600 PMP SRST workaround and retrying
>> [   90.172079] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300=
)
>> [   90.187956] ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
>> [   90.203985] ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
>> [   90.203994] ata3.00: configured for UDMA/100
>> [   90.206016] ata3: EH complete
>> [   95.283088] ata3.00: qc timeout (cmd 0xa0)
>> [   95.283122] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action=
 0x6
>> frozen
>> [   95.283132] ata3.00: irq_stat 0x40000001
>> [   95.283156] ata3.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag =
0
>> [   95.283159]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 =
00 00 00
>> [   95.283163]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emas=
k 0x5
>> (timeout)
>> [   95.283172] ata3.00: status: { DRDY ERR }
>> [   95.283186] ata3: hard resetting link
>> [   95.741051] ata3: softreset failed (device not ready)
>> [   95.741063] ata3: applying SB600 PMP SRST workaround and retrying
>>
>>
>>    =20

--=20
cybersource.us
115 Richfield Road
Williamsville, New York 14221
716-553-8525
