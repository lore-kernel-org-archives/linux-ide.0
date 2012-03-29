From: Gwendal Grignou <gwendal@google.com>
Subject: Re: Fwd: libata-pmp patch for 3.2.x and later for eSATA Port
 Multiplier Sil3726
Date: Thu, 29 Mar 2012 14:08:57 +0800
Message-ID: <CAMHSBOVaswiCg4WisCLMWkqndixM54wzN6Gwn1bTaKKLsCk1Yg@mail.gmail.com>
References: <4F5ECD06.3000608@yahoo.co.jp>
	<4F5F7C4C.7080800@teksavvy.com>
	<4F662AFB.9050106@yahoo.co.jp>
	<CAMHSBOWg+rxxrVjf05r1tYDpW1S75XzdrLQ+U8TrjC9okRYtuA@mail.gmail.com>
	<4F6AAC37.7040907@yahoo.co.jp>
	<4F6B30D9.2070805@yahoo.co.jp>
	<CAMHSBOVD4wAtwAravVkDjyWV+Nwtuybt=yae=26PcGxxirw=Lg@mail.gmail.com>
	<4F6B679C.60004@yahoo.co.jp>
	<CAMHSBOWDYyLRREZNGqhBtvF_gSrvB-b=PVx3qULCqpc7yeJCcQ@mail.gmail.com>
	<4F6C1AE5.5060405@yahoo.co.jp>
	<CAMHSBOXuX1U8uPyN136AQ_LRW85Ex8EUu1-_hdBqnSMtdmg+0Q@mail.gmail.com>
	<4F6C4967.80309@yahoo.co.jp>
	<4F6E728A.3090203@yahoo.co.jp>
	<CAMHSBOVtj8pXVtSK7qUmzSzXTCJWTK6-m7ZY6TB3gj-dT70ptw@mail.gmail.com>
	<4F6FBB3E.8060409@yahoo.co.jp>
	<4F6FD4CD.5040608@yahoo.co.jp>
	<4F703BEB.1040309@yahoo.co.jp>
	<4F70527A.4000005@world.odn.ne.jp>
	<CAMHSBOWOLj0igQYK16qQ+BznzmS2KV89dw4ahRz0h5tUw+YOdQ@mail.gmail.com>
	<4F72A1C5.8070704@yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33432 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab2C2GI7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Mar 2012 02:08:59 -0400
Received: by iagz16 with SMTP id z16so2573703iag.19
        for <linux-ide@vger.kernel.org>; Wed, 28 Mar 2012 23:08:57 -0700 (PDT)
In-Reply-To: <4F72A1C5.8070704@yahoo.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "ANEZAKI, Akira" <fireblade1230@yahoo.co.jp>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Wed, Mar 28, 2012 at 1:29 PM, ANEZAKI, Akira
<fireblade1230@yahoo.co.jp> wrote:
> Hello Gwendal,
>
> (2012/03/27 20:17), Gwendal Grignou wrote:
>> Regarding the machine with 10 disks, I see that all the drives have
>> been found; I don't see any other error from the /var/log/messages
>> snippet that could explain md not finding the volumes.
>
> I have attached 11 disks log. RAID1 is not assembled. Both of md1 and
> md2 were not assembled. md1 is root partition.
=46rom your original post md1 is composed of sda2 and sdb2. Both disks
are not behind a PMP, so it is different problem.

Gwendal.
>
> Best Regards,
> Akira
>
> --- 3.2.10 2pmp power cycle error on root ---
>> [ =A0 =A00.000000] Initializing cgroup subsys cpuset
>> [ =A0 =A00.000000] Initializing cgroup subsys cpu
>> [ =A0 =A00.000000] Linux version 3.2.10-3.fc16.i686.PAE (mockbuild@x=
86-02.phx2.fedoraproject.org) (gcc version 4.6.2 20111027 (Red Hat 4.6.=
2-1) (GCC) ) #1 SMP Thu Mar 15 20:37:01 UTC 2012
>> [ =A0 =A00.000000] BIOS-provided physical RAM map:
>> [ =A0 =A00.000000] =A0BIOS-e820: 0000000000000000 - 000000000009b800=
 (usable)
>> [ =A0 =A00.000000] =A0BIOS-e820: 000000000009b800 - 00000000000a0000=
 (reserved)
>> [ =A0 =A00.000000] =A0BIOS-e820: 00000000000e3000 - 0000000000100000=
 (reserved)
>> [ =A0 =A00.000000] =A0BIOS-e820: 0000000000100000 - 00000000bffb0000=
 (usable)
>> [ =A0 =A00.000000] =A0BIOS-e820: 00000000bffb0000 - 00000000bffbe000=
 (ACPI data)
>> [ =A0 =A00.000000] =A0BIOS-e820: 00000000bffbe000 - 00000000bfff0000=
 (ACPI NVS)
>> [ =A0 =A00.000000] =A0BIOS-e820: 00000000bfff0000 - 00000000c0000000=
 (reserved)
>> [ =A0 =A00.000000] =A0BIOS-e820: 00000000fee00000 - 00000000fee01000=
 (reserved)
>> [ =A0 =A00.000000] =A0BIOS-e820: 00000000ffb00000 - 0000000100000000=
 (reserved)
>> [ =A0 =A00.000000] NX (Execute Disable) protection: active
>> [ =A0 =A00.000000] DMI present.
>> [ =A0 =A00.000000] DMI: MICRO-STAR INTERNATIONAL CO.,LTD MS-7360/MS-=
7360, BIOS V1.AB2 05/28/2007
>> [ =A0 =A00.000000] e820 update range: 0000000000000000 - 00000000000=
10000 (usable) =3D=3D> (reserved)
>> [ =A0 =A00.000000] e820 remove range: 00000000000a0000 - 00000000001=
00000 (usable)
>> [ =A0 =A00.000000] last_pfn =3D 0xbffb0 max_arch_pfn =3D 0x1000000
>> [ =A0 =A00.000000] MTRR default type: uncachable
>> [ =A0 =A00.000000] MTRR fixed ranges enabled:
>> [ =A0 =A00.000000] =A0 00000-9FFFF write-back
>> [ =A0 =A00.000000] =A0 A0000-BFFFF uncachable
>> [ =A0 =A00.000000] =A0 C0000-CFFFF write-protect
>> [ =A0 =A00.000000] =A0 D0000-DFFFF uncachable
>> [ =A0 =A00.000000] =A0 E0000-EFFFF write-through
>> [ =A0 =A00.000000] =A0 F0000-FFFFF write-protect
>> [ =A0 =A00.000000] MTRR variable ranges enabled:
>> [ =A0 =A00.000000] =A0 0 base 000000000 mask F80000000 write-back
>> [ =A0 =A00.000000] =A0 1 base 080000000 mask FC0000000 write-back
>> [ =A0 =A00.000000] =A0 2 disabled
>> [ =A0 =A00.000000] =A0 3 disabled
>> [ =A0 =A00.000000] =A0 4 disabled
>> [ =A0 =A00.000000] =A0 5 disabled
>> [ =A0 =A00.000000] =A0 6 disabled
>> [ =A0 =A00.000000] =A0 7 disabled
>> [ =A0 =A00.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new =
0x7010600070106
>> [ =A0 =A00.000000] found SMP MP-table at [c00ff780] ff780
>> [ =A0 =A00.000000] initial memory mapped : 0 - 01200000
>> [ =A0 =A00.000000] Base memory trampoline at [c0097000] 97000 size 1=
6384
>> [ =A0 =A00.000000] init_memory_mapping: 0000000000000000-00000000375=
fe000
>> [ =A0 =A00.000000] =A00000000000 - 0000200000 page 4k
>> [ =A0 =A00.000000] =A00000200000 - 0037400000 page 2M
>> [ =A0 =A00.000000] =A00037400000 - 00375fe000 page 4k
>> [ =A0 =A00.000000] kernel direct mapping tables up to 375fe000 @ 11f=
8000-1200000
>> [ =A0 =A00.000000] RAMDISK: 37081000 - 37ff0000
>> [ =A0 =A00.000000] Allocated new RAMDISK: 36112000 - 37080e5b
>> [ =A0 =A00.000000] Move RAMDISK from 0000000037081000 - 0000000037fe=
fe5a to 36112000 - 37080e5a
>> [ =A0 =A00.000000] ACPI: RSDP 000f95c0 00014 (v00 ACPIAM)
>> [ =A0 =A00.000000] ACPI: RSDT bffb0000 00044 (v01 Mouse =A0Computer =
20070528 MSFT 00000097)
>> [ =A0 =A00.000000] ACPI: FACP bffb0200 00084 (v01 052807 FACP1414 20=
070528 MSFT 00000097)
>> [ =A0 =A00.000000] ACPI: DSDT bffb05c0 05564 (v01 =A00AAAA 0AAAA000 =
00000000 INTL 20051117)
>> [ =A0 =A00.000000] ACPI: FACS bffbe000 00040
>> [ =A0 =A00.000000] ACPI: APIC bffb0390 0006C (v01 052807 APIC1414 20=
070528 MSFT 00000097)
>> [ =A0 =A00.000000] ACPI: MCFG bffb0400 0003C (v01 052807 OEMMCFG =A0=
20070528 MSFT 00000097)
>> [ =A0 =A00.000000] ACPI: SLIC bffb0440 00176 (v01 Mouse =A0Computer =
20070528 MSFT 00000097)
>> [ =A0 =A00.000000] ACPI: SLIC bffb0440 00176 (v01 Mouse =A0Computer =
20070528 MSFT 00000097)
>> [ =A0 =A00.000000] ACPI: OEMB bffbe040 00071 (v01 052807 OEMB1414 20=
070528 MSFT 00000097)
>> [ =A0 =A00.000000] ACPI: GSCI bffbe0c0 02024 (v01 052807 GMCHSCI =A0=
20070528 MSFT 00000097)
>> [ =A0 =A00.000000] ACPI: SSDT bffc1330 0082F (v01 DpgPmm =A0 =A0CpuP=
m 00000012 INTL 20051117)
>> [ =A0 =A00.000000] ACPI: Local APIC address 0xfee00000
>> [ =A0 =A00.000000] 2185MB HIGHMEM available.
>> [ =A0 =A00.000000] 885MB LOWMEM available.
>> [ =A0 =A00.000000] =A0 mapped low ram: 0 - 375fe000
>> [ =A0 =A00.000000] =A0 low ram: 0 - 375fe000
>> [ =A0 =A00.000000] Zone PFN ranges:
>> [ =A0 =A00.000000] =A0 DMA =A0 =A0 =A00x00000010 -> 0x00001000
>> [ =A0 =A00.000000] =A0 Normal =A0 0x00001000 -> 0x000375fe
>> [ =A0 =A00.000000] =A0 HighMem =A00x000375fe -> 0x000bffb0
>> [ =A0 =A00.000000] Movable zone start PFN for each node
>> [ =A0 =A00.000000] early_node_map[2] active PFN ranges
>> [ =A0 =A00.000000] =A0 =A0 0: 0x00000010 -> 0x0000009b
>> [ =A0 =A00.000000] =A0 =A0 0: 0x00000100 -> 0x000bffb0
>> [ =A0 =A00.000000] On node 0 totalpages: 786235
>> [ =A0 =A00.000000] free_area_init_node: node 0, pgdat c0bb3bc0, node=
_mem_map f4912200
>> [ =A0 =A00.000000] =A0 DMA zone: 32 pages used for memmap
>> [ =A0 =A00.000000] =A0 DMA zone: 0 pages reserved
>> [ =A0 =A00.000000] =A0 DMA zone: 3947 pages, LIFO batch:0
>> [ =A0 =A00.000000] =A0 Normal zone: 1740 pages used for memmap
>> [ =A0 =A00.000000] =A0 Normal zone: 220978 pages, LIFO batch:31
>> [ =A0 =A00.000000] =A0 HighMem zone: 4372 pages used for memmap
>> [ =A0 =A00.000000] =A0 HighMem zone: 555166 pages, LIFO batch:31
>> [ =A0 =A00.000000] Using APIC driver default
>> [ =A0 =A00.000000] ACPI: PM-Timer IO Port: 0x808
>> [ =A0 =A00.000000] ACPI: Local APIC address 0xfee00000
>> [ =A0 =A00.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled=
)
>> [ =A0 =A00.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled=
)
>> [ =A0 =A00.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled=
)
>> [ =A0 =A00.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled=
)
>> [ =A0 =A00.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_ba=
se[0])
>> [ =A0 =A00.000000] IOAPIC[0]: apic_id 4, version 32, address 0xfec00=
000, GSI 0-23
>> [ =A0 =A00.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 d=
fl dfl)
>> [ =A0 =A00.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 h=
igh level)
>> [ =A0 =A00.000000] ACPI: IRQ0 used by override.
>> [ =A0 =A00.000000] ACPI: IRQ2 used by override.
>> [ =A0 =A00.000000] ACPI: IRQ9 used by override.
>> [ =A0 =A00.000000] Using ACPI (MADT) for SMP configuration informati=
on
>> [ =A0 =A00.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
>> [ =A0 =A00.000000] nr_irqs_gsi: 40
>> [ =A0 =A00.000000] PM: Registered nosave memory: 000000000009b000 - =
000000000009c000
>> [ =A0 =A00.000000] PM: Registered nosave memory: 000000000009c000 - =
00000000000a0000
>> [ =A0 =A00.000000] PM: Registered nosave memory: 00000000000a0000 - =
00000000000e3000
>> [ =A0 =A00.000000] PM: Registered nosave memory: 00000000000e3000 - =
0000000000100000
>> [ =A0 =A00.000000] Allocating PCI resources starting at c0000000 (ga=
p: c0000000:3ee00000)
>> [ =A0 =A00.000000] Booting paravirtualized kernel on bare hardware
>> [ =A0 =A00.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cp=
u_ids:4 nr_node_ids:1
>> [ =A0 =A00.000000] PERCPU: Embedded 14 pages/cpu @f7200000 s34240 r0=
 d23104 u524288
>> [ =A0 =A00.000000] pcpu-alloc: s34240 r0 d23104 u524288 alloc=3D1*20=
97152
>> [ =A0 =A00.000000] pcpu-alloc: [0] 0 1 2 3
>> [ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility groupin=
g on. =A0Total pages: 780091
>> [ =A0 =A00.000000] Kernel command line: ro root=3DUUID=3D773cb4b3-4b=
b0-4705-b494-08cb9c2b5d73 LANG=3Dja_JP.UTF-8 KEYBOARDTYPE=3Dpc KEYTABLE=
=3Djp106 rhgb quiet nomodeset
>> [ =A0 =A00.000000] PID hash table entries: 4096 (order: 2, 16384 byt=
es)
>> [ =A0 =A00.000000] Dentry cache hash table entries: 131072 (order: 7=
, 524288 bytes)
>> [ =A0 =A00.000000] Inode-cache hash table entries: 65536 (order: 6, =
262144 bytes)
>> [ =A0 =A00.000000] Initializing CPU#0
>> [ =A0 =A00.000000] allocated 12581376 bytes of page_cgroup
>> [ =A0 =A00.000000] please try 'cgroup_disable=3Dmemory' option if yo=
u don't want memory cgroups
>> [ =A0 =A00.000000] Initializing HighMem for node 0 (000375fe:000bffb=
0)
>> [ =A0 =A00.000000] Memory: 3081612k/3145408k available (5404k kernel=
 code, 63328k reserved, 2569k data, 644k init, 2238152k highmem)
>> [ =A0 =A00.000000] virtual kernel memory layout:
>> [ =A0 =A00.000000] =A0 =A0 fixmap =A0: 0xffa95000 - 0xfffff000 =A0 (=
5544 kB)
>> [ =A0 =A00.000000] =A0 =A0 pkmap =A0 : 0xff600000 - 0xff800000 =A0 (=
2048 kB)
>> [ =A0 =A00.000000] =A0 =A0 vmalloc : 0xf7dfe000 - 0xff5fe000 =A0 ( 1=
20 MB)
>> [ =A0 =A00.000000] =A0 =A0 lowmem =A0: 0xc0000000 - 0xf75fe000 =A0 (=
 885 MB)
>> [ =A0 =A00.000000] =A0 =A0 =A0 .init : 0xc0bca000 - 0xc0c6b000 =A0 (=
 644 kB)
>> [ =A0 =A00.000000] =A0 =A0 =A0 .data : 0xc094723f - 0xc0bc9980 =A0 (=
2569 kB)
>> [ =A0 =A00.000000] =A0 =A0 =A0 .text : 0xc0400000 - 0xc094723f =A0 (=
5404 kB)
>> [ =A0 =A00.000000] Checking if this processor honours the WP bit eve=
n in supervisor mode...Ok.
>> [ =A0 =A00.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, M=
inObjects=3D0, CPUs=3D4, Nodes=3D1
>> [ =A0 =A00.000000] Hierarchical RCU implementation.
>> [ =A0 =A00.000000] =A0 =A0 =A0 =A0RCU dyntick-idle grace-period acce=
leration is enabled.
>> [ =A0 =A00.000000] NR_IRQS:2304 nr_irqs:712 16
>> [ =A0 =A00.000000] CPU 0 irqstacks, hard=3Df380a000 soft=3Df380c000
>> [ =A0 =A00.000000] Console: colour VGA+ 80x25
>> [ =A0 =A00.000000] console [tty0] enabled
>> [ =A0 =A00.000000] Fast TSC calibration failed
>> [ =A0 =A00.000000] TSC: PIT calibration matches PMTIMER. 1 loops
>> [ =A0 =A00.000000] Detected 2402.370 MHz processor.
>> [ =A0 =A00.002001] Calibrating delay loop (skipped), value calculate=
d using timer frequency.. 4804.74 BogoMIPS (lpj=3D2402370)
>> [ =A0 =A00.002005] pid_max: default: 32768 minimum: 301
>> [ =A0 =A00.002025] Security Framework initialized
>> [ =A0 =A00.002032] SELinux: =A0Initializing.
>> [ =A0 =A00.002040] SELinux: =A0Starting in permissive mode
>> [ =A0 =A00.002087] Mount-cache hash table entries: 512
>> [ =A0 =A00.002210] Initializing cgroup subsys cpuacct
>> [ =A0 =A00.002215] Initializing cgroup subsys memory
>> [ =A0 =A00.002222] Initializing cgroup subsys devices
>> [ =A0 =A00.002224] Initializing cgroup subsys freezer
>> [ =A0 =A00.002226] Initializing cgroup subsys net_cls
>> [ =A0 =A00.002228] Initializing cgroup subsys blkio
>> [ =A0 =A00.002233] Initializing cgroup subsys perf_event
>> [ =A0 =A00.002255] CPU: Physical Processor ID: 0
>> [ =A0 =A00.002256] CPU: Processor Core ID: 0
>> [ =A0 =A00.002259] mce: CPU supports 6 MCE banks
>> [ =A0 =A00.002266] CPU0: Thermal monitoring enabled (TM2)
>> [ =A0 =A00.002268] using mwait in idle threads.
>> [ =A0 =A00.003853] ACPI: Core revision 20110623
>> [ =A0 =A00.007009] ftrace: allocating 22484 entries in 45 pages
>> [ =A0 =A00.008042] Enabling APIC mode: =A0Flat. =A0Using 1 I/O APICs
>> [ =A0 =A00.008385] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D=
-1 pin2=3D-1
>> [ =A0 =A00.018812] CPU0: Intel(R) Core(TM)2 Quad CPU =A0 =A0Q6600 =A0=
@ 2.40GHz stepping 0b
>> [ =A0 =A00.018998] Performance Events: PEBS fmt0+, Core2 events, Int=
el PMU driver.
>> [ =A0 =A00.018998] PEBS disabled due to CPU errata.
>> [ =A0 =A00.018998] ... version: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
>> [ =A0 =A00.018998] ... bit width: =A0 =A0 =A0 =A0 =A0 =A0 =A040
>> [ =A0 =A00.018998] ... generic registers: =A0 =A0 =A02
>> [ =A0 =A00.018998] ... value mask: =A0 =A0 =A0 =A0 =A0 =A0 000000fff=
fffffff
>> [ =A0 =A00.018998] ... max period: =A0 =A0 =A0 =A0 =A0 =A0 000000007=
fffffff
>> [ =A0 =A00.018998] ... fixed-purpose events: =A0 3
>> [ =A0 =A00.018998] ... event mask: =A0 =A0 =A0 =A0 =A0 =A0 000000070=
0000003
>> [ =A0 =A00.018998] NMI watchdog enabled, takes one hw-pmu counter.
>> [ =A0 =A00.018998] CPU 1 irqstacks, hard=3Df3902000 soft=3Df3904000
>> [ =A0 =A00.018998] Booting Node =A0 0, Processors =A0#1
>> [ =A0 =A00.018998] smpboot cpu 1: start_ip =3D 97000
>> [ =A0 =A00.002999] Initializing CPU#1
>> [ =A0 =A00.090020] NMI watchdog enabled, takes one hw-pmu counter.
>> [ =A0 =A00.090116] CPU 2 irqstacks, hard=3Df3930000 soft=3Df3932000
>> [ =A0 =A00.090118] =A0#2
>> [ =A0 =A00.090119] smpboot cpu 2: start_ip =3D 97000
>> [ =A0 =A00.002999] Initializing CPU#2
>> [ =A0 =A00.162002] NMI watchdog enabled, takes one hw-pmu counter.
>> [ =A0 =A00.162084] CPU 3 irqstacks, hard=3Df393e000 soft=3Df3948000
>> [ =A0 =A00.162086] =A0#3 Ok.
>> [ =A0 =A00.162087] smpboot cpu 3: start_ip =3D 97000
>> [ =A0 =A00.002999] Initializing CPU#3
>> [ =A0 =A00.233992] NMI watchdog enabled, takes one hw-pmu counter.
>> [ =A0 =A00.234016] Brought up 4 CPUs
>> [ =A0 =A00.234019] Total of 4 processors activated (19216.44 BogoMIP=
S).
>> [ =A0 =A00.235092] devtmpfs: initialized
>> [ =A0 =A00.235211] PM: Registering ACPI NVS region at bffbe000 (2048=
00 bytes)
>> [ =A0 =A00.236847] atomic64 test passed for i586+ platform with CX8 =
and with SSE
>> [ =A0 =A00.236872] RTC time: 18:51:35, date: 03/26/12
>> [ =A0 =A00.236905] NET: Registered protocol family 16
>> [ =A0 =A00.237081] ACPI: bus type pci registered
>> [ =A0 =A00.237141] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem=
 0xe0000000-0xefffffff] (base 0xe0000000)
>> [ =A0 =A00.237144] PCI: not using MMCONFIG
>> [ =A0 =A00.237231] PCI : PCI BIOS aera is rw and x. Use pci=3Dnobios=
 if you want it NX.
>> [ =A0 =A00.237289] PCI: PCI BIOS revision 3.00 entry at 0xf0031, las=
t bus=3D7
>> [ =A0 =A00.237290] PCI: Using configuration type 1 for base access
>> [ =A0 =A00.238391] bio: create slab <bio-0> at 0
>> [ =A0 =A00.238391] ACPI: Added _OSI(Module Device)
>> [ =A0 =A00.238391] ACPI: Added _OSI(Processor Device)
>> [ =A0 =A00.238391] ACPI: Added _OSI(3.0 _SCP Extensions)
>> [ =A0 =A00.238391] ACPI: Added _OSI(Processor Aggregator Device)
>> [ =A0 =A00.239491] ACPI: EC: Detected MSI hardware, enabling workaro=
unds.
>> [ =A0 =A00.239497] ACPI: EC: Look up EC in DSDT
>> [ =A0 =A00.240586] ACPI: Executed 1 blocks of module-level executabl=
e AML code
>> [ =A0 =A00.243093] ACPI: SSDT bffc00f0 00277 (v01 DpgPmm =A0P001Ist =
00000011 INTL 20051117)
>> [ =A0 =A00.243315] ACPI: Dynamic OEM Table Load:
>> [ =A0 =A00.243318] ACPI: SSDT =A0 (null) 00277 (v01 DpgPmm =A0P001Is=
t 00000011 INTL 20051117)
>> [ =A0 =A00.243555] ACPI: SSDT bffc0580 00277 (v01 DpgPmm =A0P002Ist =
00000012 INTL 20051117)
>> [ =A0 =A00.243776] ACPI: Dynamic OEM Table Load:
>> [ =A0 =A00.243779] ACPI: SSDT =A0 (null) 00277 (v01 DpgPmm =A0P002Is=
t 00000012 INTL 20051117)
>> [ =A0 =A00.244019] ACPI: SSDT bffc0a10 00277 (v01 DpgPmm =A0P003Ist =
00000012 INTL 20051117)
>> [ =A0 =A00.244242] ACPI: Dynamic OEM Table Load:
>> [ =A0 =A00.244245] ACPI: SSDT =A0 (null) 00277 (v01 DpgPmm =A0P003Is=
t 00000012 INTL 20051117)
>> [ =A0 =A00.244478] ACPI: SSDT bffc0ea0 00277 (v01 DpgPmm =A0P004Ist =
00000012 INTL 20051117)
>> [ =A0 =A00.244704] ACPI: Dynamic OEM Table Load:
>> [ =A0 =A00.244707] ACPI: SSDT =A0 (null) 00277 (v01 DpgPmm =A0P004Is=
t 00000012 INTL 20051117)
>> [ =A0 =A00.244925] ACPI: Interpreter enabled
>> [ =A0 =A00.244945] ACPI: (supports S0 S3 S4 S5)
>> [ =A0 =A00.244962] ACPI: Using IOAPIC for interrupt routing
>> [ =A0 =A00.244986] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem=
 0xe0000000-0xefffffff] (base 0xe0000000)
>> [ =A0 =A00.245998] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] rese=
rved in ACPI motherboard resources
>> [ =A0 =A00.246000] PCI: Using MMCONFIG for extended config space
>> [ =A0 =A00.251283] ACPI: No dock devices found.
>> [ =A0 =A00.251285] HEST: Table not found.
>> [ =A0 =A00.251290] PCI: Ignoring host bridge windows from ACPI; if n=
ecessary, use "pci=3Duse_crs" and report a bug
>> [ =A0 =A00.251452] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00=
-ff])
>> [ =A0 =A00.251617] pci_root PNP0A08:00: host bridge window [io =A00x=
0000-0x0cf7] (ignored)
>> [ =A0 =A00.251620] pci_root PNP0A08:00: host bridge window [io =A00x=
0d00-0xffff] (ignored)
>> [ =A0 =A00.251623] pci_root PNP0A08:00: host bridge window [mem 0x00=
0a0000-0x000bffff] (ignored)
>> [ =A0 =A00.251625] pci_root PNP0A08:00: host bridge window [mem 0x00=
0d0000-0x000dffff] (ignored)
>> [ =A0 =A00.251627] pci_root PNP0A08:00: host bridge window [mem 0xc0=
000000-0xdfffffff] (ignored)
>> [ =A0 =A00.251629] pci_root PNP0A08:00: host bridge window [mem 0xf0=
000000-0xffffffff] (ignored)
>> [ =A0 =A00.251639] pci 0000:00:00.0: [8086:29c0] type 0 class 0x0006=
00
>> [ =A0 =A00.251680] pci 0000:00:01.0: [8086:29c1] type 1 class 0x0006=
04
>> [ =A0 =A00.251719] pci 0000:00:01.0: PME# supported from D0 D3hot D3=
cold
>> [ =A0 =A00.251722] pci 0000:00:01.0: PME# disabled
>> [ =A0 =A00.251757] pci 0000:00:1a.0: [8086:2937] type 0 class 0x000c=
03
>> [ =A0 =A00.251797] pci 0000:00:1a.0: reg 20: [io =A00x9c00-0x9c1f]
>> [ =A0 =A00.251844] pci 0000:00:1a.1: [8086:2938] type 0 class 0x000c=
03
>> [ =A0 =A00.251884] pci 0000:00:1a.1: reg 20: [io =A00x9880-0x989f]
>> [ =A0 =A00.251940] pci 0000:00:1a.7: [8086:293c] type 0 class 0x000c=
03
>> [ =A0 =A00.251960] pci 0000:00:1a.7: reg 10: [mem 0xf9fffc00-0xf9fff=
fff]
>> [ =A0 =A00.252049] pci 0000:00:1a.7: PME# supported from D0 D3hot D3=
cold
>> [ =A0 =A00.252054] pci 0000:00:1a.7: PME# disabled
>> [ =A0 =A00.252076] pci 0000:00:1b.0: [8086:293e] type 0 class 0x0004=
03
>> [ =A0 =A00.252090] pci 0000:00:1b.0: reg 10: [mem 0xf9ff8000-0xf9ffb=
fff 64bit]
>> [ =A0 =A00.252152] pci 0000:00:1b.0: PME# supported from D0 D3hot D3=
cold
>> [ =A0 =A00.252156] pci 0000:00:1b.0: PME# disabled
>> [ =A0 =A00.252174] pci 0000:00:1c.0: [8086:2940] type 1 class 0x0006=
04
>> [ =A0 =A00.252238] pci 0000:00:1c.0: PME# supported from D0 D3hot D3=
cold
>> [ =A0 =A00.252241] pci 0000:00:1c.0: PME# disabled
>> [ =A0 =A00.252261] pci 0000:00:1c.1: [8086:2942] type 1 class 0x0006=
04
>> [ =A0 =A00.252325] pci 0000:00:1c.1: PME# supported from D0 D3hot D3=
cold
>> [ =A0 =A00.252328] pci 0000:00:1c.1: PME# disabled
>> [ =A0 =A00.252348] pci 0000:00:1c.2: [8086:2944] type 1 class 0x0006=
04
>> [ =A0 =A00.252412] pci 0000:00:1c.2: PME# supported from D0 D3hot D3=
cold
>> [ =A0 =A00.252416] pci 0000:00:1c.2: PME# disabled
>> [ =A0 =A00.252436] pci 0000:00:1c.4: [8086:2948] type 1 class 0x0006=
04
>> [ =A0 =A00.252500] pci 0000:00:1c.4: PME# supported from D0 D3hot D3=
cold
>> [ =A0 =A00.252503] pci 0000:00:1c.4: PME# disabled
>> [ =A0 =A00.252523] pci 0000:00:1c.5: [8086:294a] type 1 class 0x0006=
04
>> [ =A0 =A00.252587] pci 0000:00:1c.5: PME# supported from D0 D3hot D3=
cold
>> [ =A0 =A00.252590] pci 0000:00:1c.5: PME# disabled
>> [ =A0 =A00.252611] pci 0000:00:1d.0: [8086:2934] type 0 class 0x000c=
03
>> [ =A0 =A00.252651] pci 0000:00:1d.0: reg 20: [io =A00x9800-0x981f]
>> [ =A0 =A00.252698] pci 0000:00:1d.1: [8086:2935] type 0 class 0x000c=
03
>> [ =A0 =A00.252737] pci 0000:00:1d.1: reg 20: [io =A00x9480-0x949f]
>> [ =A0 =A00.252786] pci 0000:00:1d.2: [8086:2936] type 0 class 0x000c=
03
>> [ =A0 =A00.252826] pci 0000:00:1d.2: reg 20: [io =A00x9400-0x941f]
>> [ =A0 =A00.252873] pci 0000:00:1d.3: [8086:2939] type 0 class 0x000c=
03
>> [ =A0 =A00.252912] pci 0000:00:1d.3: reg 20: [io =A00x9080-0x909f]
>> [ =A0 =A00.252967] pci 0000:00:1d.7: [8086:293a] type 0 class 0x000c=
03
>> [ =A0 =A00.252991] pci 0000:00:1d.7: reg 10: [mem 0xf9fff800-0xf9fff=
bff]
>> [ =A0 =A00.253075] pci 0000:00:1d.7: PME# supported from D0 D3hot D3=
cold
>> [ =A0 =A00.253079] pci 0000:00:1d.7: PME# disabled
>> [ =A0 =A00.253096] pci 0000:00:1e.0: [8086:244e] type 1 class 0x0006=
04
>> [ =A0 =A00.253154] pci 0000:00:1f.0: [8086:2918] type 0 class 0x0006=
01
>> [ =A0 =A00.253230] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PI=
O at 0a00 (mask 00ff)
>> [ =A0 =A00.253275] pci 0000:00:1f.2: [8086:2921] type 0 class 0x0001=
01
>> [ =A0 =A00.253289] pci 0000:00:1f.2: reg 10: [io =A00x9000-0x9007]
>> [ =A0 =A00.253296] pci 0000:00:1f.2: reg 14: [io =A00x8c00-0x8c03]
>> [ =A0 =A00.253304] pci 0000:00:1f.2: reg 18: [io =A00x8880-0x8887]
>> [ =A0 =A00.253311] pci 0000:00:1f.2: reg 1c: [io =A00x8800-0x8803]
>> [ =A0 =A00.253318] pci 0000:00:1f.2: reg 20: [io =A00x8480-0x848f]
>> [ =A0 =A00.253325] pci 0000:00:1f.2: reg 24: [io =A00x8400-0x840f]
>> [ =A0 =A00.253368] pci 0000:00:1f.3: [8086:2930] type 0 class 0x000c=
05
>> [ =A0 =A00.253382] pci 0000:00:1f.3: reg 10: [mem 0xf9fff400-0xf9fff=
4ff 64bit]
>> [ =A0 =A00.253402] pci 0000:00:1f.3: reg 20: [io =A00x0400-0x041f]
>> [ =A0 =A00.253432] pci 0000:00:1f.5: [8086:2926] type 0 class 0x0001=
01
>> [ =A0 =A00.253446] pci 0000:00:1f.5: reg 10: [io =A00x8000-0x8007]
>> [ =A0 =A00.253454] pci 0000:00:1f.5: reg 14: [io =A00x7c00-0x7c03]
>> [ =A0 =A00.253461] pci 0000:00:1f.5: reg 18: [io =A00x7880-0x7887]
>> [ =A0 =A00.253469] pci 0000:00:1f.5: reg 1c: [io =A00x7800-0x7803]
>> [ =A0 =A00.253476] pci 0000:00:1f.5: reg 20: [io =A00x7480-0x748f]
>> [ =A0 =A00.253483] pci 0000:00:1f.5: reg 24: [io =A00x7400-0x740f]
>> [ =A0 =A00.253556] pci 0000:01:00.0: [10de:0615] type 0 class 0x0003=
00
>> [ =A0 =A00.253566] pci 0000:01:00.0: reg 10: [mem 0xfd000000-0xfdfff=
fff]
>> [ =A0 =A00.253576] pci 0000:01:00.0: reg 14: [mem 0xd0000000-0xdffff=
fff 64bit pref]
>> [ =A0 =A00.253587] pci 0000:01:00.0: reg 1c: [mem 0xfa000000-0xfbfff=
fff 64bit]
>> [ =A0 =A00.253594] pci 0000:01:00.0: reg 24: [io =A00xac00-0xac7f]
>> [ =A0 =A00.253601] pci 0000:01:00.0: reg 30: [mem 0xfe7e0000-0xfe7ff=
fff pref]
>> [ =A0 =A00.253652] pci 0000:00:01.0: PCI bridge to [bus 01-01]
>> [ =A0 =A00.253655] pci 0000:00:01.0: =A0 bridge window [io =A00xa000=
-0xafff]
>> [ =A0 =A00.253658] pci 0000:00:01.0: =A0 bridge window [mem 0xfa0000=
00-0xfe7fffff]
>> [ =A0 =A00.253662] pci 0000:00:01.0: =A0 bridge window [mem 0xd00000=
00-0xdfffffff 64bit pref]
>> [ =A0 =A00.253698] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
>> [ =A0 =A00.253762] pci 0000:03:00.0: [1095:3132] type 0 class 0x0001=
80
>> [ =A0 =A00.253787] pci 0000:03:00.0: reg 10: [mem 0xfe8ffc00-0xfe8ff=
c7f 64bit]
>> [ =A0 =A00.253807] pci 0000:03:00.0: reg 18: [mem 0xfe8f8000-0xfe8fb=
fff 64bit]
>> [ =A0 =A00.253821] pci 0000:03:00.0: reg 20: [io =A00xbc00-0xbc7f]
>> [ =A0 =A00.253846] pci 0000:03:00.0: reg 30: [mem 0xfe800000-0xfe87f=
fff pref]
>> [ =A0 =A00.253910] pci 0000:03:00.0: supports D1 D2
>> [ =A0 =A00.253931] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe =
device. =A0You can enable it with 'pcie_aspm=3Dforce'
>> [ =A0 =A00.253935] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
>> [ =A0 =A00.253939] pci 0000:00:1c.1: =A0 bridge window [io =A00xb000=
-0xbfff]
>> [ =A0 =A00.253942] pci 0000:00:1c.1: =A0 bridge window [mem 0xfe8000=
00-0xfe8fffff]
>> [ =A0 =A00.254007] pci 0000:04:00.0: [1095:3132] type 0 class 0x0001=
80
>> [ =A0 =A00.254033] pci 0000:04:00.0: reg 10: [mem 0xfe9ffc00-0xfe9ff=
c7f 64bit]
>> [ =A0 =A00.254054] pci 0000:04:00.0: reg 18: [mem 0xfe9f8000-0xfe9fb=
fff 64bit]
>> [ =A0 =A00.254067] pci 0000:04:00.0: reg 20: [io =A00xcc00-0xcc7f]
>> [ =A0 =A00.254093] pci 0000:04:00.0: reg 30: [mem 0xfe900000-0xfe97f=
fff pref]
>> [ =A0 =A00.254157] pci 0000:04:00.0: supports D1 D2
>> [ =A0 =A00.254177] pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe =
device. =A0You can enable it with 'pcie_aspm=3Dforce'
>> [ =A0 =A00.254182] pci 0000:00:1c.2: PCI bridge to [bus 04-04]
>> [ =A0 =A00.254185] pci 0000:00:1c.2: =A0 bridge window [io =A00xc000=
-0xcfff]
>> [ =A0 =A00.254189] pci 0000:00:1c.2: =A0 bridge window [mem 0xfe9000=
00-0xfe9fffff]
>> [ =A0 =A00.254245] pci 0000:05:00.0: [11ab:6121] type 0 class 0x0001=
01
>> [ =A0 =A00.254260] pci 0000:05:00.0: reg 10: [io =A00xdc00-0xdc07]
>> [ =A0 =A00.254272] pci 0000:05:00.0: reg 14: [io =A00xd880-0xd883]
>> [ =A0 =A00.254283] pci 0000:05:00.0: reg 18: [io =A00xd800-0xd807]
>> [ =A0 =A00.254295] pci 0000:05:00.0: reg 1c: [io =A00xd480-0xd483]
>> [ =A0 =A00.254306] pci 0000:05:00.0: reg 20: [io =A00xd400-0xd40f]
>> [ =A0 =A00.254317] pci 0000:05:00.0: reg 24: [mem 0xfeaffc00-0xfeaff=
fff]
>> [ =A0 =A00.254379] pci 0000:05:00.0: supports D1
>> [ =A0 =A00.254381] pci 0000:05:00.0: PME# supported from D0 D1 D3hot
>> [ =A0 =A00.254386] pci 0000:05:00.0: PME# disabled
>> [ =A0 =A00.254402] pci 0000:05:00.0: disabling ASPM on pre-1.1 PCIe =
device. =A0You can enable it with 'pcie_aspm=3Dforce'
>> [ =A0 =A00.254406] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
>> [ =A0 =A00.254410] pci 0000:00:1c.4: =A0 bridge window [io =A00xd000=
-0xdfff]
>> [ =A0 =A00.254414] pci 0000:00:1c.4: =A0 bridge window [mem 0xfea000=
00-0xfeafffff]
>> [ =A0 =A00.254475] pci 0000:06:00.0: [10ec:8168] type 0 class 0x0002=
00
>> [ =A0 =A00.254493] pci 0000:06:00.0: reg 10: [io =A00xe800-0xe8ff]
>> [ =A0 =A00.254523] pci 0000:06:00.0: reg 18: [mem 0xfebff000-0xfebff=
fff 64bit]
>> [ =A0 =A00.254558] pci 0000:06:00.0: reg 30: [mem 0xfebc0000-0xfebdf=
fff pref]
>> [ =A0 =A00.254635] pci 0000:06:00.0: supports D1 D2
>> [ =A0 =A00.254637] pci 0000:06:00.0: PME# supported from D1 D2 D3hot=
 D3cold
>> [ =A0 =A00.254642] pci 0000:06:00.0: PME# disabled
>> [ =A0 =A00.254664] pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe =
device. =A0You can enable it with 'pcie_aspm=3Dforce'
>> [ =A0 =A00.254668] pci 0000:00:1c.5: PCI bridge to [bus 06-06]
>> [ =A0 =A00.254672] pci 0000:00:1c.5: =A0 bridge window [io =A00xe000=
-0xefff]
>> [ =A0 =A00.254676] pci 0000:00:1c.5: =A0 bridge window [mem 0xfeb000=
00-0xfebfffff]
>> [ =A0 =A00.254735] pci 0000:00:1e.0: PCI bridge to [bus 07-07] (subt=
ractive decode)
>> [ =A0 =A00.254744] pci 0000:00:1e.0: =A0 bridge window [io =A00x0000=
-0xffff] (subtractive decode)
>> [ =A0 =A00.254747] pci 0000:00:1e.0: =A0 bridge window [mem 0x000000=
00-0xfffffffff] (subtractive decode)
>> [ =A0 =A00.254772] pci_bus 0000:00: on NUMA node 0
>> [ =A0 =A00.254775] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PR=
T]
>> [ =A0 =A00.254920] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P=
1._PRT]
>> [ =A0 =A00.255028] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P=
4._PRT]
>> [ =A0 =A00.255069] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P=
5._PRT]
>> [ =A0 =A00.255110] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P=
6._PRT]
>> [ =A0 =A00.255153] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P=
8._PRT]
>> [ =A0 =A00.255193] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P=
9._PRT]
>> [ =A0 =A00.255323] =A0pci0000:00: Requesting ACPI _OSC control (0x1d=
)
>> [ =A0 =A00.255478] =A0pci0000:00: ACPI _OSC control (0x1d) granted
>> [ =A0 =A00.264124] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10=
 11 12 14 15)
>> [ =A0 =A00.264168] ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
>> [ =A0 =A00.264208] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 =
*11 12 14 15)
>> [ =A0 =A00.264250] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 =
11 12 14 *15)
>> [ =A0 =A00.264292] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 =
11 12 14 15) *0, disabled.
>> [ =A0 =A00.264337] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 =
11 12 *14 15)
>> [ =A0 =A00.264379] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 6 7 10=
 11 12 14 15)
>> [ =A0 =A00.264421] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 *10=
 11 12 14 15)
>> [ =A0 =A00.264500] vgaarb: device added: PCI:0000:01:00.0,decodes=3D=
io+mem,owns=3Dio+mem,locks=3Dnone
>> [ =A0 =A00.264500] vgaarb: loaded
>> [ =A0 =A00.264500] vgaarb: bridge control possible 0000:01:00.0
>> [ =A0 =A00.264500] SCSI subsystem initialized
>> [ =A0 =A00.264517] libata version 3.00 loaded.
>> [ =A0 =A00.264517] usbcore: registered new interface driver usbfs
>> [ =A0 =A00.264517] usbcore: registered new interface driver hub
>> [ =A0 =A00.264517] usbcore: registered new device driver usb
>> [ =A0 =A00.264517] PCI: Using ACPI for IRQ routing
>> [ =A0 =A00.264517] PCI: pci_cache_line_size set to 64 bytes
>> [ =A0 =A00.264517] reserve RAM buffer: 000000000009b800 - 0000000000=
09ffff
>> [ =A0 =A00.264517] reserve RAM buffer: 00000000bffb0000 - 00000000bf=
ffffff
>> [ =A0 =A00.264991] NetLabel: Initializing
>> [ =A0 =A00.264992] NetLabel: =A0domain hash size =3D 128
>> [ =A0 =A00.264994] NetLabel: =A0protocols =3D UNLABELED CIPSOv4
>> [ =A0 =A00.265003] NetLabel: =A0unlabeled traffic allowed by default
>> [ =A0 =A00.272818] pnp: PnP ACPI init
>> [ =A0 =A00.272833] ACPI: bus type pnp registered
>> [ =A0 =A00.272930] pnp 00:00: [bus 00-ff]
>> [ =A0 =A00.272933] pnp 00:00: [io =A00x0cf8-0x0cff]
>> [ =A0 =A00.272935] pnp 00:00: [io =A00x0000-0x0cf7 window]
>> [ =A0 =A00.272938] pnp 00:00: [io =A00x0d00-0xffff window]
>> [ =A0 =A00.272940] pnp 00:00: [mem 0x000a0000-0x000bffff window]
>> [ =A0 =A00.272942] pnp 00:00: [mem 0x000d0000-0x000dffff window]
>> [ =A0 =A00.272946] pnp 00:00: [mem 0xc0000000-0xdfffffff window]
>> [ =A0 =A00.272948] pnp 00:00: [mem 0xf0000000-0xffffffff window]
>> [ =A0 =A00.273001] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08=
 PNP0a03 (active)
>> [ =A0 =A00.273011] pnp 00:01: [mem 0xfed14000-0xfed19fff]
>> [ =A0 =A00.273064] system 00:01: [mem 0xfed14000-0xfed19fff] has bee=
n reserved
>> [ =A0 =A00.273067] system 00:01: Plug and Play ACPI device, IDs PNP0=
c01 (active)
>> [ =A0 =A00.273096] pnp 00:02: [dma 4]
>> [ =A0 =A00.273098] pnp 00:02: [io =A00x0000-0x000f]
>> [ =A0 =A00.273100] pnp 00:02: [io =A00x0081-0x0083]
>> [ =A0 =A00.273102] pnp 00:02: [io =A00x0087]
>> [ =A0 =A00.273104] pnp 00:02: [io =A00x0089-0x008b]
>> [ =A0 =A00.273105] pnp 00:02: [io =A00x008f]
>> [ =A0 =A00.273107] pnp 00:02: [io =A00x00c0-0x00df]
>> [ =A0 =A00.273132] pnp 00:02: Plug and Play ACPI device, IDs PNP0200=
 (active)
>> [ =A0 =A00.273142] pnp 00:03: [io =A00x0070-0x0071]
>> [ =A0 =A00.273151] pnp 00:03: [irq 8]
>> [ =A0 =A00.273178] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00=
 (active)
>> [ =A0 =A00.273186] pnp 00:04: [io =A00x0061]
>> [ =A0 =A00.273210] pnp 00:04: Plug and Play ACPI device, IDs PNP0800=
 (active)
>> [ =A0 =A00.273218] pnp 00:05: [io =A00x00f0-0x00ff]
>> [ =A0 =A00.273223] pnp 00:05: [irq 13]
>> [ =A0 =A00.273248] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04=
 (active)
>> [ =A0 =A00.273481] pnp 00:06: [io =A00x03f8-0x03ff]
>> [ =A0 =A00.273486] pnp 00:06: [irq 4]
>> [ =A0 =A00.273488] pnp 00:06: [dma 0 disabled]
>> [ =A0 =A00.273553] pnp 00:06: Plug and Play ACPI device, IDs PNP0501=
 (active)
>> [ =A0 =A00.273948] pnp 00:07: [io =A00x0378-0x037f]
>> [ =A0 =A00.273953] pnp 00:07: [irq 7]
>> [ =A0 =A00.273955] pnp 00:07: [dma 0 disabled]
>> [ =A0 =A00.274087] pnp 00:07: Plug and Play ACPI device, IDs PNP0400=
 (active)
>> [ =A0 =A00.274113] pnp 00:08: [io =A00x0060]
>> [ =A0 =A00.274115] pnp 00:08: [io =A00x0064]
>> [ =A0 =A00.274119] pnp 00:08: [irq 1]
>> [ =A0 =A00.274155] pnp 00:08: Plug and Play ACPI device, IDs PNP0303=
 PNP030b (active)
>> [ =A0 =A00.274196] pnp 00:09: [irq 12]
>> [ =A0 =A00.274229] pnp 00:09: Plug and Play ACPI device, IDs PNP0f03=
 PNP0f13 (active)
>> [ =A0 =A00.274307] pnp 00:0a: [io =A00x0000-0xffffffffffffffff disab=
led]
>> [ =A0 =A00.274310] pnp 00:0a: [io =A00x0a00-0x0adf]
>> [ =A0 =A00.274312] pnp 00:0a: [io =A00x0ae0-0x0aef]
>> [ =A0 =A00.274363] system 00:0a: [io =A00x0a00-0x0adf] has been rese=
rved
>> [ =A0 =A00.274366] system 00:0a: [io =A00x0ae0-0x0aef] has been rese=
rved
>> [ =A0 =A00.274369] system 00:0a: Plug and Play ACPI device, IDs PNP0=
c02 (active)
>> [ =A0 =A00.274437] pnp 00:0b: [io =A00x0010-0x001f]
>> [ =A0 =A00.274440] pnp 00:0b: [io =A00x0022-0x003f]
>> [ =A0 =A00.274441] pnp 00:0b: [io =A00x0044-0x005f]
>> [ =A0 =A00.274443] pnp 00:0b: [io =A00x0062-0x0063]
>> [ =A0 =A00.274445] pnp 00:0b: [io =A00x0065-0x006f]
>> [ =A0 =A00.274447] pnp 00:0b: [io =A00x0072-0x007f]
>> [ =A0 =A00.274448] pnp 00:0b: [io =A00x0080]
>> [ =A0 =A00.274450] pnp 00:0b: [io =A00x0084-0x0086]
>> [ =A0 =A00.274452] pnp 00:0b: [io =A00x0088]
>> [ =A0 =A00.274455] pnp 00:0b: [io =A00x008c-0x008e]
>> [ =A0 =A00.274457] pnp 00:0b: [io =A00x0090-0x009f]
>> [ =A0 =A00.274459] pnp 00:0b: [io =A00x00a2-0x00bf]
>> [ =A0 =A00.274461] pnp 00:0b: [io =A00x00e0-0x00ef]
>> [ =A0 =A00.274463] pnp 00:0b: [io =A00x04d0-0x04d1]
>> [ =A0 =A00.274464] pnp 00:0b: [io =A00x0800-0x087f]
>> [ =A0 =A00.274466] pnp 00:0b: [io =A00x0000-0xffffffffffffffff disab=
led]
>> [ =A0 =A00.274468] pnp 00:0b: [io =A00x0480-0x04bf]
>> [ =A0 =A00.274470] pnp 00:0b: [mem 0xfed1c000-0xfed1ffff]
>> [ =A0 =A00.274472] pnp 00:0b: [mem 0xfed20000-0xfed8ffff]
>> [ =A0 =A00.274541] system 00:0b: [io =A00x04d0-0x04d1] has been rese=
rved
>> [ =A0 =A00.274544] system 00:0b: [io =A00x0800-0x087f] has been rese=
rved
>> [ =A0 =A00.274546] system 00:0b: [io =A00x0480-0x04bf] has been rese=
rved
>> [ =A0 =A00.274549] system 00:0b: [mem 0xfed1c000-0xfed1ffff] has bee=
n reserved
>> [ =A0 =A00.274551] system 00:0b: [mem 0xfed20000-0xfed8ffff] has bee=
n reserved
>> [ =A0 =A00.274554] system 00:0b: Plug and Play ACPI device, IDs PNP0=
c02 (active)
>> [ =A0 =A00.274625] pnp 00:0c: [mem 0xffb00000-0xffbfffff]
>> [ =A0 =A00.274627] pnp 00:0c: [mem 0xfff00000-0xffffffff]
>> [ =A0 =A00.274655] pnp 00:0c: Plug and Play ACPI device, IDs INT0800=
 (active)
>> [ =A0 =A00.274694] pnp 00:0d: [mem 0xffc00000-0xffefffff]
>> [ =A0 =A00.274744] system 00:0d: [mem 0xffc00000-0xffefffff] has bee=
n reserved
>> [ =A0 =A00.274747] system 00:0d: Plug and Play ACPI device, IDs PNP0=
c02 (active)
>> [ =A0 =A00.274820] pnp 00:0e: [mem 0xfec00000-0xfec00fff]
>> [ =A0 =A00.274822] pnp 00:0e: [mem 0xfee00000-0xfee00fff]
>> [ =A0 =A00.274870] system 00:0e: [mem 0xfec00000-0xfec00fff] could n=
ot be reserved
>> [ =A0 =A00.274873] system 00:0e: [mem 0xfee00000-0xfee00fff] has bee=
n reserved
>> [ =A0 =A00.274876] system 00:0e: Plug and Play ACPI device, IDs PNP0=
c02 (active)
>> [ =A0 =A00.274906] pnp 00:0f: [mem 0xe0000000-0xefffffff]
>> [ =A0 =A00.274956] system 00:0f: [mem 0xe0000000-0xefffffff] has bee=
n reserved
>> [ =A0 =A00.274959] system 00:0f: Plug and Play ACPI device, IDs PNP0=
c02 (active)
>> [ =A0 =A00.275113] pnp 00:10: [mem 0x00000000-0x0009ffff]
>> [ =A0 =A00.275115] pnp 00:10: [mem 0x000c0000-0x000cffff]
>> [ =A0 =A00.275117] pnp 00:10: [mem 0x000e0000-0x000fffff]
>> [ =A0 =A00.275119] pnp 00:10: [mem 0x00100000-0xbfffffff]
>> [ =A0 =A00.275121] pnp 00:10: [mem 0x00000000-0xffffffffffffffff dis=
abled]
>> [ =A0 =A00.275180] system 00:10: [mem 0x00000000-0x0009ffff] could n=
ot be reserved
>> [ =A0 =A00.275183] system 00:10: [mem 0x000c0000-0x000cffff] could n=
ot be reserved
>> [ =A0 =A00.275186] system 00:10: [mem 0x000e0000-0x000fffff] could n=
ot be reserved
>> [ =A0 =A00.275188] system 00:10: [mem 0x00100000-0xbfffffff] could n=
ot be reserved
>> [ =A0 =A00.275191] system 00:10: Plug and Play ACPI device, IDs PNP0=
c01 (active)
>> [ =A0 =A00.275308] pnp: PnP ACPI: found 17 devices
>> [ =A0 =A00.275309] ACPI: ACPI bus type pnp unregistered
>> [ =A0 =A00.312103] Switching to clocksource acpi_pm
>> [ =A0 =A00.312137] PCI: max bus depth: 1 pci_try_num: 2
>> [ =A0 =A00.312182] pci 0000:00:1c.5: BAR 15: assigned [mem 0xc000000=
0-0xc01fffff 64bit pref]
>> [ =A0 =A00.312186] pci 0000:00:1c.4: BAR 15: assigned [mem 0xc020000=
0-0xc03fffff 64bit pref]
>> [ =A0 =A00.312189] pci 0000:00:1c.2: BAR 15: assigned [mem 0xc040000=
0-0xc05fffff 64bit pref]
>> [ =A0 =A00.312192] pci 0000:00:1c.1: BAR 15: assigned [mem 0xc060000=
0-0xc07fffff 64bit pref]
>> [ =A0 =A00.312195] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc080000=
0-0xc09fffff]
>> [ =A0 =A00.312198] pci 0000:00:1c.0: BAR 15: assigned [mem 0xc0a0000=
0-0xc0bfffff 64bit pref]
>> [ =A0 =A00.312201] pci 0000:00:1c.0: BAR 13: assigned [io =A00x1000-=
0x1fff]
>> [ =A0 =A00.312204] pci 0000:00:01.0: PCI bridge to [bus 01-01]
>> [ =A0 =A00.312207] pci 0000:00:01.0: =A0 bridge window [io =A00xa000=
-0xafff]
>> [ =A0 =A00.312210] pci 0000:00:01.0: =A0 bridge window [mem 0xfa0000=
00-0xfe7fffff]
>> [ =A0 =A00.312214] pci 0000:00:01.0: =A0 bridge window [mem 0xd00000=
00-0xdfffffff 64bit pref]
>> [ =A0 =A00.312218] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
>> [ =A0 =A00.312221] pci 0000:00:1c.0: =A0 bridge window [io =A00x1000=
-0x1fff]
>> [ =A0 =A00.312225] pci 0000:00:1c.0: =A0 bridge window [mem 0xc08000=
00-0xc09fffff]
>> [ =A0 =A00.312229] pci 0000:00:1c.0: =A0 bridge window [mem 0xc0a000=
00-0xc0bfffff 64bit pref]
>> [ =A0 =A00.312234] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
>> [ =A0 =A00.312237] pci 0000:00:1c.1: =A0 bridge window [io =A00xb000=
-0xbfff]
>> [ =A0 =A00.312241] pci 0000:00:1c.1: =A0 bridge window [mem 0xfe8000=
00-0xfe8fffff]
>> [ =A0 =A00.312245] pci 0000:00:1c.1: =A0 bridge window [mem 0xc06000=
00-0xc07fffff 64bit pref]
>> [ =A0 =A00.312250] pci 0000:00:1c.2: PCI bridge to [bus 04-04]
>> [ =A0 =A00.312253] pci 0000:00:1c.2: =A0 bridge window [io =A00xc000=
-0xcfff]
>> [ =A0 =A00.312257] pci 0000:00:1c.2: =A0 bridge window [mem 0xfe9000=
00-0xfe9fffff]
>> [ =A0 =A00.312261] pci 0000:00:1c.2: =A0 bridge window [mem 0xc04000=
00-0xc05fffff 64bit pref]
>> [ =A0 =A00.312267] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
>> [ =A0 =A00.312269] pci 0000:00:1c.4: =A0 bridge window [io =A00xd000=
-0xdfff]
>> [ =A0 =A00.312274] pci 0000:00:1c.4: =A0 bridge window [mem 0xfea000=
00-0xfeafffff]
>> [ =A0 =A00.312277] pci 0000:00:1c.4: =A0 bridge window [mem 0xc02000=
00-0xc03fffff 64bit pref]
>> [ =A0 =A00.312283] pci 0000:00:1c.5: PCI bridge to [bus 06-06]
>> [ =A0 =A00.312285] pci 0000:00:1c.5: =A0 bridge window [io =A00xe000=
-0xefff]
>> [ =A0 =A00.312290] pci 0000:00:1c.5: =A0 bridge window [mem 0xfeb000=
00-0xfebfffff]
>> [ =A0 =A00.312293] pci 0000:00:1c.5: =A0 bridge window [mem 0xc00000=
00-0xc01fffff 64bit pref]
>> [ =A0 =A00.312299] pci 0000:00:1e.0: PCI bridge to [bus 07-07]
>> [ =A0 =A00.312318] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low=
) -> IRQ 16
>> [ =A0 =A00.312321] pci 0000:00:01.0: setting latency timer to 64
>> [ =A0 =A00.312326] pci 0000:00:1c.0: enabling device (0104 -> 0107)
>> [ =A0 =A00.312333] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low=
) -> IRQ 17
>> [ =A0 =A00.312337] pci 0000:00:1c.0: setting latency timer to 64
>> [ =A0 =A00.312342] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low=
) -> IRQ 16
>> [ =A0 =A00.312346] pci 0000:00:1c.1: setting latency timer to 64
>> [ =A0 =A00.312354] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low=
) -> IRQ 18
>> [ =A0 =A00.312357] pci 0000:00:1c.2: setting latency timer to 64
>> [ =A0 =A00.312363] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low=
) -> IRQ 17
>> [ =A0 =A00.312366] pci 0000:00:1c.4: setting latency timer to 64
>> [ =A0 =A00.312371] pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low=
) -> IRQ 16
>> [ =A0 =A00.312375] pci 0000:00:1c.5: setting latency timer to 64
>> [ =A0 =A00.312380] pci 0000:00:1e.0: setting latency timer to 64
>> [ =A0 =A00.312384] pci_bus 0000:00: resource 0 [io =A00x0000-0xffff]
>> [ =A0 =A00.312386] pci_bus 0000:00: resource 1 [mem 0x00000000-0xfff=
ffffff]
>> [ =A0 =A00.312388] pci_bus 0000:01: resource 0 [io =A00xa000-0xafff]
>> [ =A0 =A00.312390] pci_bus 0000:01: resource 1 [mem 0xfa000000-0xfe7=
fffff]
>> [ =A0 =A00.312393] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdff=
fffff 64bit pref]
>> [ =A0 =A00.312395] pci_bus 0000:02: resource 0 [io =A00x1000-0x1fff]
>> [ =A0 =A00.312397] pci_bus 0000:02: resource 1 [mem 0xc0800000-0xc09=
fffff]
>> [ =A0 =A00.312399] pci_bus 0000:02: resource 2 [mem 0xc0a00000-0xc0b=
fffff 64bit pref]
>> [ =A0 =A00.312401] pci_bus 0000:03: resource 0 [io =A00xb000-0xbfff]
>> [ =A0 =A00.312403] pci_bus 0000:03: resource 1 [mem 0xfe800000-0xfe8=
fffff]
>> [ =A0 =A00.312405] pci_bus 0000:03: resource 2 [mem 0xc0600000-0xc07=
fffff 64bit pref]
>> [ =A0 =A00.312408] pci_bus 0000:04: resource 0 [io =A00xc000-0xcfff]
>> [ =A0 =A00.312409] pci_bus 0000:04: resource 1 [mem 0xfe900000-0xfe9=
fffff]
>> [ =A0 =A00.312412] pci_bus 0000:04: resource 2 [mem 0xc0400000-0xc05=
fffff 64bit pref]
>> [ =A0 =A00.312414] pci_bus 0000:05: resource 0 [io =A00xd000-0xdfff]
>> [ =A0 =A00.312416] pci_bus 0000:05: resource 1 [mem 0xfea00000-0xfea=
fffff]
>> [ =A0 =A00.312418] pci_bus 0000:05: resource 2 [mem 0xc0200000-0xc03=
fffff 64bit pref]
>> [ =A0 =A00.312420] pci_bus 0000:06: resource 0 [io =A00xe000-0xefff]
>> [ =A0 =A00.312422] pci_bus 0000:06: resource 1 [mem 0xfeb00000-0xfeb=
fffff]
>> [ =A0 =A00.312425] pci_bus 0000:06: resource 2 [mem 0xc0000000-0xc01=
fffff 64bit pref]
>> [ =A0 =A00.312427] pci_bus 0000:07: resource 4 [io =A00x0000-0xffff]
>> [ =A0 =A00.312429] pci_bus 0000:07: resource 5 [mem 0x00000000-0xfff=
ffffff]
>> [ =A0 =A00.312453] NET: Registered protocol family 2
>> [ =A0 =A00.312491] IP route cache hash table entries: 32768 (order: =
5, 131072 bytes)
>> [ =A0 =A00.312587] TCP established hash table entries: 131072 (order=
: 8, 1048576 bytes)
>> [ =A0 =A00.312959] TCP bind hash table entries: 65536 (order: 7, 524=
288 bytes)
>> [ =A0 =A00.313062] TCP: Hash tables configured (established 131072 b=
ind 65536)
>> [ =A0 =A00.313064] TCP reno registered
>> [ =A0 =A00.313066] UDP hash table entries: 512 (order: 2, 16384 byte=
s)
>> [ =A0 =A00.313075] UDP-Lite hash table entries: 512 (order: 2, 16384=
 bytes)
>> [ =A0 =A00.313132] NET: Registered protocol family 1
>> [ =A0 =A00.313150] pci 0000:00:1a.0: PCI INT A -> GSI 16 (level, low=
) -> IRQ 16
>> [ =A0 =A00.313165] pci 0000:00:1a.0: PCI INT A disabled
>> [ =A0 =A00.313177] pci 0000:00:1a.1: PCI INT B -> GSI 21 (level, low=
) -> IRQ 21
>> [ =A0 =A00.313191] pci 0000:00:1a.1: PCI INT B disabled
>> [ =A0 =A00.313199] pci 0000:00:1a.7: PCI INT C -> GSI 18 (level, low=
) -> IRQ 18
>> [ =A0 =A00.313219] pci 0000:00:1a.7: PCI INT C disabled
>> [ =A0 =A00.313239] pci 0000:00:1d.0: PCI INT A -> GSI 23 (level, low=
) -> IRQ 23
>> [ =A0 =A00.313254] pci 0000:00:1d.0: PCI INT A disabled
>> [ =A0 =A00.313263] pci 0000:00:1d.1: PCI INT B -> GSI 19 (level, low=
) -> IRQ 19
>> [ =A0 =A00.313277] pci 0000:00:1d.1: PCI INT B disabled
>> [ =A0 =A00.313284] pci 0000:00:1d.2: PCI INT C -> GSI 18 (level, low=
) -> IRQ 18
>> [ =A0 =A00.313298] pci 0000:00:1d.2: PCI INT C disabled
>> [ =A0 =A00.313304] pci 0000:00:1d.3: PCI INT D -> GSI 16 (level, low=
) -> IRQ 16
>> [ =A0 =A00.313319] pci 0000:00:1d.3: PCI INT D disabled
>> [ =A0 =A00.313326] pci 0000:00:1d.7: PCI INT A -> GSI 23 (level, low=
) -> IRQ 23
>> [ =A0 =A00.313339] pci 0000:00:1d.7: PCI INT A disabled
>> [ =A0 =A00.313360] pci 0000:01:00.0: Boot video device
>> [ =A0 =A00.313373] PCI: CLS 32 bytes, default 64
>> [ =A0 =A00.313428] Unpacking initramfs...
>> [ =A0 =A00.653964] Freeing initrd memory: 15804k freed
>> [ =A0 =A00.660788] apm: BIOS version 1.2 Flags 0x03 (Driver version =
1.16ac)
>> [ =A0 =A00.660791] apm: disabled - APM is not SMP safe.
>> [ =A0 =A00.660926] Intel AES-NI instructions are not detected.
>> [ =A0 =A00.661079] audit: initializing netlink socket (disabled)
>> [ =A0 =A00.661095] type=3D2000 audit(1332787894.661:1): initialized
>> [ =A0 =A00.684390] highmem bounce pool size: 64 pages
>> [ =A0 =A00.684395] HugeTLB registered 2 MB page size, pre-allocated =
0 pages
>> [ =A0 =A00.695503] VFS: Disk quotas dquot_6.5.2
>> [ =A0 =A00.695557] Dquot-cache hash table entries: 1024 (order 0, 40=
96 bytes)
>> [ =A0 =A00.696083] msgmni has been set to 1678
>> [ =A0 =A00.696142] SELinux: =A0Registering netfilter hooks
>> [ =A0 =A00.696558] alg: No test for stdrng (krng)
>> [ =A0 =A00.696571] NET: Registered protocol family 38
>> [ =A0 =A00.696613] Block layer SCSI generic (bsg) driver version 0.4=
 loaded (major 253)
>> [ =A0 =A00.696650] io scheduler noop registered
>> [ =A0 =A00.696652] io scheduler deadline registered
>> [ =A0 =A00.696658] io scheduler cfq registered (default)
>> [ =A0 =A00.696876] pcieport 0000:00:01.0: setting latency timer to 6=
4
>> [ =A0 =A00.696905] pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
>> [ =A0 =A00.696970] pcieport 0000:00:1c.0: setting latency timer to 6=
4
>> [ =A0 =A00.697023] pcieport 0000:00:1c.0: irq 41 for MSI/MSI-X
>> [ =A0 =A00.697112] pcieport 0000:00:1c.1: setting latency timer to 6=
4
>> [ =A0 =A00.697146] pcieport 0000:00:1c.1: irq 42 for MSI/MSI-X
>> [ =A0 =A00.697234] pcieport 0000:00:1c.2: setting latency timer to 6=
4
>> [ =A0 =A00.697267] pcieport 0000:00:1c.2: irq 43 for MSI/MSI-X
>> [ =A0 =A00.697355] pcieport 0000:00:1c.4: setting latency timer to 6=
4
>> [ =A0 =A00.697388] pcieport 0000:00:1c.4: irq 44 for MSI/MSI-X
>> [ =A0 =A00.697476] pcieport 0000:00:1c.5: setting latency timer to 6=
4
>> [ =A0 =A00.697509] pcieport 0000:00:1c.5: irq 45 for MSI/MSI-X
>> [ =A0 =A00.697627] pcieport 0000:00:01.0: Signaling PME through PCIe=
 PME interrupt
>> [ =A0 =A00.697629] pci 0000:01:00.0: Signaling PME through PCIe PME =
interrupt
>> [ =A0 =A00.697632] pcie_pme 0000:00:01.0:pcie01: service driver pcie=
_pme loaded
>> [ =A0 =A00.697648] pcieport 0000:00:1c.0: Signaling PME through PCIe=
 PME interrupt
>> [ =A0 =A00.697652] pcie_pme 0000:00:1c.0:pcie01: service driver pcie=
_pme loaded
>> [ =A0 =A00.697668] pcieport 0000:00:1c.1: Signaling PME through PCIe=
 PME interrupt
>> [ =A0 =A00.697670] pci 0000:03:00.0: Signaling PME through PCIe PME =
interrupt
>> [ =A0 =A00.697674] pcie_pme 0000:00:1c.1:pcie01: service driver pcie=
_pme loaded
>> [ =A0 =A00.697689] pcieport 0000:00:1c.2: Signaling PME through PCIe=
 PME interrupt
>> [ =A0 =A00.697691] pci 0000:04:00.0: Signaling PME through PCIe PME =
interrupt
>> [ =A0 =A00.697695] pcie_pme 0000:00:1c.2:pcie01: service driver pcie=
_pme loaded
>> [ =A0 =A00.697710] pcieport 0000:00:1c.4: Signaling PME through PCIe=
 PME interrupt
>> [ =A0 =A00.697712] pci 0000:05:00.0: Signaling PME through PCIe PME =
interrupt
>> [ =A0 =A00.697716] pcie_pme 0000:00:1c.4:pcie01: service driver pcie=
_pme loaded
>> [ =A0 =A00.697732] pcieport 0000:00:1c.5: Signaling PME through PCIe=
 PME interrupt
>> [ =A0 =A00.697734] pci 0000:06:00.0: Signaling PME through PCIe PME =
interrupt
>> [ =A0 =A00.697738] pcie_pme 0000:00:1c.5:pcie01: service driver pcie=
_pme loaded
>> [ =A0 =A00.697757] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>> [ =A0 =A00.697807] pciehp 0000:00:1c.0:pcie04: HPC vendor_id 8086 de=
vice_id 2940 ss_vid 1462 ss_did 7360
>> [ =A0 =A00.697825] pciehp 0000:00:1c.0:pcie04: service driver pciehp=
 loaded
>> [ =A0 =A00.697834] pciehp 0000:00:1c.1:pcie04: HPC vendor_id 8086 de=
vice_id 2942 ss_vid 1462 ss_did 7360
>> [ =A0 =A00.697850] pciehp 0000:00:1c.1:pcie04: service driver pciehp=
 loaded
>> [ =A0 =A00.697860] pciehp 0000:00:1c.2:pcie04: HPC vendor_id 8086 de=
vice_id 2944 ss_vid 1462 ss_did 7360
>> [ =A0 =A00.697876] pciehp 0000:00:1c.2:pcie04: service driver pciehp=
 loaded
>> [ =A0 =A00.697886] pciehp 0000:00:1c.4:pcie04: HPC vendor_id 8086 de=
vice_id 2948 ss_vid 1462 ss_did 7360
>> [ =A0 =A00.697902] pciehp 0000:00:1c.4:pcie04: service driver pciehp=
 loaded
>> [ =A0 =A00.697912] pciehp 0000:00:1c.5:pcie04: HPC vendor_id 8086 de=
vice_id 294a ss_vid 1462 ss_did 7360
>> [ =A0 =A00.697929] pciehp 0000:00:1c.5:pcie04: service driver pciehp=
 loaded
>> [ =A0 =A00.697937] pciehp: PCI Express Hot Plug Controller Driver ve=
rsion: 0.4
>> [ =A0 =A00.697939] acpiphp: ACPI Hot Plug PCI Controller Driver vers=
ion: 0.5
>> [ =A0 =A00.698253] intel_idle: MWAIT substates: 0x20
>> [ =A0 =A00.698255] intel_idle: does not run on family 6 model 15
>> [ =A0 =A00.698326] input: Power Button as /devices/LNXSYSTM:00/devic=
e:00/PNP0C0C:00/input/input0
>> [ =A0 =A00.698330] ACPI: Power Button [PWRB]
>> [ =A0 =A00.698375] input: Power Button as /devices/LNXSYSTM:00/LNXPW=
RBN:00/input/input1
>> [ =A0 =A00.698378] ACPI: Power Button [PWRF]
>> [ =A0 =A00.700070] ERST: Table is not found!
>> [ =A0 =A00.700072] GHES: HEST is not enabled!
>> [ =A0 =A00.700085] isapnp: Scanning for PnP cards...
>> [ =A0 =A01.055917] isapnp: No Plug & Play device found
>> [ =A0 =A01.056011] Serial: 8250/16550 driver, 4 ports, IRQ sharing e=
nabled
>> [ =A0 =A01.076497] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 1=
6550A
>> [ =A0 =A01.097724] 00:06: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
>> [ =A0 =A01.106358] Non-volatile memory driver v1.3
>> [ =A0 =A01.106360] Linux agpgart interface v0.103
>> [ =A0 =A01.107481] loop: module loaded
>> [ =A0 =A01.107541] ahci 0000:05:00.0: version 3.0
>> [ =A0 =A01.107565] ata_piix 0000:00:1f.2: version 2.13
>> [ =A0 =A01.107577] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level=
, low) -> IRQ 19
>> [ =A0 =A01.107581] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
>> [ =A0 =A01.107613] ata_piix 0000:00:1f.2: setting latency timer to 6=
4
>> [ =A0 =A01.107848] scsi0 : ata_piix
>> [ =A0 =A01.107929] scsi1 : ata_piix
>> [ =A0 =A01.109107] ata1: SATA max UDMA/133 cmd 0x9000 ctl 0x8c00 bmd=
ma 0x8480 irq 19
>> [ =A0 =A01.109111] ata2: SATA max UDMA/133 cmd 0x8880 ctl 0x8800 bmd=
ma 0x8488 irq 19
>> [ =A0 =A01.109128] ata_piix 0000:00:1f.5: PCI INT B -> GSI 19 (level=
, low) -> IRQ 19
>> [ =A0 =A01.109134] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
>> [ =A0 =A01.109177] ata_piix 0000:00:1f.5: setting latency timer to 6=
4
>> [ =A0 =A01.109401] scsi2 : ata_piix
>> [ =A0 =A01.109481] scsi3 : ata_piix
>> [ =A0 =A01.110534] ata3: SATA max UDMA/133 cmd 0x8000 ctl 0x7c00 bmd=
ma 0x7480 irq 19
>> [ =A0 =A01.110538] ata4: SATA max UDMA/133 cmd 0x7880 ctl 0x7800 bmd=
ma 0x7488 irq 19
>> [ =A0 =A01.110597] Fixed MDIO Bus: probed
>> [ =A0 =A01.110664] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHC=
I) Driver
>> [ =A0 =A01.110677] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level=
, low) -> IRQ 18
>> [ =A0 =A01.110692] ehci_hcd 0000:00:1a.7: setting latency timer to 6=
4
>> [ =A0 =A01.110695] ehci_hcd 0000:00:1a.7: EHCI Host Controller
>> [ =A0 =A01.110765] ehci_hcd 0000:00:1a.7: new USB bus registered, as=
signed bus number 1
>> [ =A0 =A01.110787] ehci_hcd 0000:00:1a.7: debug port 1
>> [ =A0 =A01.114672] ehci_hcd 0000:00:1a.7: cache line size of 32 is n=
ot supported
>> [ =A0 =A01.114686] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf9fffc00
>> [ =A0 =A01.124019] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
>> [ =A0 =A01.124038] usb usb1: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002
>> [ =A0 =A01.124041] usb usb1: New USB device strings: Mfr=3D3, Produc=
t=3D2, SerialNumber=3D1
>> [ =A0 =A01.124043] usb usb1: Product: EHCI Host Controller
>> [ =A0 =A01.124045] usb usb1: Manufacturer: Linux 3.2.10-3.fc16.i686.=
PAE ehci_hcd
>> [ =A0 =A01.124047] usb usb1: SerialNumber: 0000:00:1a.7
>> [ =A0 =A01.124164] hub 1-0:1.0: USB hub found
>> [ =A0 =A01.124168] hub 1-0:1.0: 4 ports detected
>> [ =A0 =A01.124239] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level=
, low) -> IRQ 23
>> [ =A0 =A01.124249] ehci_hcd 0000:00:1d.7: setting latency timer to 6=
4
>> [ =A0 =A01.124252] ehci_hcd 0000:00:1d.7: EHCI Host Controller
>> [ =A0 =A01.124305] ehci_hcd 0000:00:1d.7: new USB bus registered, as=
signed bus number 2
>> [ =A0 =A01.124325] ehci_hcd 0000:00:1d.7: debug port 1
>> [ =A0 =A01.128222] ehci_hcd 0000:00:1d.7: cache line size of 32 is n=
ot supported
>> [ =A0 =A01.128235] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf9fff800
>> [ =A0 =A01.138019] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
>> [ =A0 =A01.138032] usb usb2: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002
>> [ =A0 =A01.138034] usb usb2: New USB device strings: Mfr=3D3, Produc=
t=3D2, SerialNumber=3D1
>> [ =A0 =A01.138036] usb usb2: Product: EHCI Host Controller
>> [ =A0 =A01.138038] usb usb2: Manufacturer: Linux 3.2.10-3.fc16.i686.=
PAE ehci_hcd
>> [ =A0 =A01.138040] usb usb2: SerialNumber: 0000:00:1d.7
>> [ =A0 =A01.138147] hub 2-0:1.0: USB hub found
>> [ =A0 =A01.138151] hub 2-0:1.0: 8 ports detected
>> [ =A0 =A01.138230] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) D=
river
>> [ =A0 =A01.138243] uhci_hcd: USB Universal Host Controller Interface=
 driver
>> [ =A0 =A01.138258] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level=
, low) -> IRQ 16
>> [ =A0 =A01.138265] uhci_hcd 0000:00:1a.0: setting latency timer to 6=
4
>> [ =A0 =A01.138268] uhci_hcd 0000:00:1a.0: UHCI Host Controller
>> [ =A0 =A01.138322] uhci_hcd 0000:00:1a.0: new USB bus registered, as=
signed bus number 3
>> [ =A0 =A01.138350] uhci_hcd 0000:00:1a.0: irq 16, io base 0x00009c00
>> [ =A0 =A01.138376] usb usb3: New USB device found, idVendor=3D1d6b, =
idProduct=3D0001
>> [ =A0 =A01.138378] usb usb3: New USB device strings: Mfr=3D3, Produc=
t=3D2, SerialNumber=3D1
>> [ =A0 =A01.138380] usb usb3: Product: UHCI Host Controller
>> [ =A0 =A01.138382] usb usb3: Manufacturer: Linux 3.2.10-3.fc16.i686.=
PAE uhci_hcd
>> [ =A0 =A01.138384] usb usb3: SerialNumber: 0000:00:1a.0
>> [ =A0 =A01.138490] hub 3-0:1.0: USB hub found
>> [ =A0 =A01.138493] hub 3-0:1.0: 2 ports detected
>> [ =A0 =A01.138559] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level=
, low) -> IRQ 21
>> [ =A0 =A01.138565] uhci_hcd 0000:00:1a.1: setting latency timer to 6=
4
>> [ =A0 =A01.138568] uhci_hcd 0000:00:1a.1: UHCI Host Controller
>> [ =A0 =A01.138621] uhci_hcd 0000:00:1a.1: new USB bus registered, as=
signed bus number 4
>> [ =A0 =A01.138649] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00009880
>> [ =A0 =A01.138674] usb usb4: New USB device found, idVendor=3D1d6b, =
idProduct=3D0001
>> [ =A0 =A01.138676] usb usb4: New USB device strings: Mfr=3D3, Produc=
t=3D2, SerialNumber=3D1
>> [ =A0 =A01.138679] usb usb4: Product: UHCI Host Controller
>> [ =A0 =A01.138680] usb usb4: Manufacturer: Linux 3.2.10-3.fc16.i686.=
PAE uhci_hcd
>> [ =A0 =A01.138682] usb usb4: SerialNumber: 0000:00:1a.1
>> [ =A0 =A01.138787] hub 4-0:1.0: USB hub found
>> [ =A0 =A01.138791] hub 4-0:1.0: 2 ports detected
>> [ =A0 =A01.138857] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level=
, low) -> IRQ 23
>> [ =A0 =A01.138864] uhci_hcd 0000:00:1d.0: setting latency timer to 6=
4
>> [ =A0 =A01.138866] uhci_hcd 0000:00:1d.0: UHCI Host Controller
>> [ =A0 =A01.138918] uhci_hcd 0000:00:1d.0: new USB bus registered, as=
signed bus number 5
>> [ =A0 =A01.138938] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00009800
>> [ =A0 =A01.138963] usb usb5: New USB device found, idVendor=3D1d6b, =
idProduct=3D0001
>> [ =A0 =A01.138965] usb usb5: New USB device strings: Mfr=3D3, Produc=
t=3D2, SerialNumber=3D1
>> [ =A0 =A01.138968] usb usb5: Product: UHCI Host Controller
>> [ =A0 =A01.138969] usb usb5: Manufacturer: Linux 3.2.10-3.fc16.i686.=
PAE uhci_hcd
>> [ =A0 =A01.138971] usb usb5: SerialNumber: 0000:00:1d.0
>> [ =A0 =A01.139081] hub 5-0:1.0: USB hub found
>> [ =A0 =A01.139085] hub 5-0:1.0: 2 ports detected
>> [ =A0 =A01.139154] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level=
, low) -> IRQ 19
>> [ =A0 =A01.139160] uhci_hcd 0000:00:1d.1: setting latency timer to 6=
4
>> [ =A0 =A01.139163] uhci_hcd 0000:00:1d.1: UHCI Host Controller
>> [ =A0 =A01.139223] uhci_hcd 0000:00:1d.1: new USB bus registered, as=
signed bus number 6
>> [ =A0 =A01.139245] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00009480
>> [ =A0 =A01.139270] usb usb6: New USB device found, idVendor=3D1d6b, =
idProduct=3D0001
>> [ =A0 =A01.139272] usb usb6: New USB device strings: Mfr=3D3, Produc=
t=3D2, SerialNumber=3D1
>> [ =A0 =A01.139274] usb usb6: Product: UHCI Host Controller
>> [ =A0 =A01.139276] usb usb6: Manufacturer: Linux 3.2.10-3.fc16.i686.=
PAE uhci_hcd
>> [ =A0 =A01.139278] usb usb6: SerialNumber: 0000:00:1d.1
>> [ =A0 =A01.139379] hub 6-0:1.0: USB hub found
>> [ =A0 =A01.139383] hub 6-0:1.0: 2 ports detected
>> [ =A0 =A01.139446] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level=
, low) -> IRQ 18
>> [ =A0 =A01.139453] uhci_hcd 0000:00:1d.2: setting latency timer to 6=
4
>> [ =A0 =A01.139456] uhci_hcd 0000:00:1d.2: UHCI Host Controller
>> [ =A0 =A01.139508] uhci_hcd 0000:00:1d.2: new USB bus registered, as=
signed bus number 7
>> [ =A0 =A01.139529] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00009400
>> [ =A0 =A01.139553] usb usb7: New USB device found, idVendor=3D1d6b, =
idProduct=3D0001
>> [ =A0 =A01.139556] usb usb7: New USB device strings: Mfr=3D3, Produc=
t=3D2, SerialNumber=3D1
>> [ =A0 =A01.139558] usb usb7: Product: UHCI Host Controller
>> [ =A0 =A01.139559] usb usb7: Manufacturer: Linux 3.2.10-3.fc16.i686.=
PAE uhci_hcd
>> [ =A0 =A01.139561] usb usb7: SerialNumber: 0000:00:1d.2
>> [ =A0 =A01.139660] hub 7-0:1.0: USB hub found
>> [ =A0 =A01.139663] hub 7-0:1.0: 2 ports detected
>> [ =A0 =A01.139727] uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level=
, low) -> IRQ 16
>> [ =A0 =A01.139733] uhci_hcd 0000:00:1d.3: setting latency timer to 6=
4
>> [ =A0 =A01.139736] uhci_hcd 0000:00:1d.3: UHCI Host Controller
>> [ =A0 =A01.139787] uhci_hcd 0000:00:1d.3: new USB bus registered, as=
signed bus number 8
>> [ =A0 =A01.139808] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00009080
>> [ =A0 =A01.139832] usb usb8: New USB device found, idVendor=3D1d6b, =
idProduct=3D0001
>> [ =A0 =A01.139835] usb usb8: New USB device strings: Mfr=3D3, Produc=
t=3D2, SerialNumber=3D1
>> [ =A0 =A01.139837] usb usb8: Product: UHCI Host Controller
>> [ =A0 =A01.139839] usb usb8: Manufacturer: Linux 3.2.10-3.fc16.i686.=
PAE uhci_hcd
>> [ =A0 =A01.139841] usb usb8: SerialNumber: 0000:00:1d.3
>> [ =A0 =A01.139939] hub 8-0:1.0: USB hub found
>> [ =A0 =A01.139943] hub 8-0:1.0: 2 ports detected
>> [ =A0 =A01.140061] usbcore: registered new interface driver usbseria=
l
>> [ =A0 =A01.140070] USB Serial support registered for generic
>> [ =A0 =A01.140083] usbcore: registered new interface driver usbseria=
l_generic
>> [ =A0 =A01.140085] usbserial: USB Serial Driver core
>> [ =A0 =A01.140144] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03=
:PS2M] at 0x60,0x64 irq 1,12
>> [ =A0 =A01.142542] serio: i8042 KBD port at 0x60,0x64 irq 1
>> [ =A0 =A01.142548] serio: i8042 AUX port at 0x60,0x64 irq 12
>> [ =A0 =A01.142650] mousedev: PS/2 mouse device common for all mice
>> [ =A0 =A01.142850] rtc_cmos 00:03: RTC can wake from S4
>> [ =A0 =A01.142965] rtc_cmos 00:03: rtc core: registered rtc_cmos as =
rtc0
>> [ =A0 =A01.142985] rtc0: alarms up to one month, y3k, 114 bytes nvra=
m
>> [ =A0 =A01.143049] device-mapper: uevent: version 1.0.3
>> [ =A0 =A01.143129] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) i=
nitialised: dm-devel@redhat.com
>> [ =A0 =A01.143173] cpuidle: using governor ladder
>> [ =A0 =A01.143175] cpuidle: using governor menu
>> [ =A0 =A01.143310] EFI Variables Facility v0.08 2004-May-17
>> [ =A0 =A01.143451] usbcore: registered new interface driver usbhid
>> [ =A0 =A01.143453] usbhid: USB HID core driver
>> [ =A0 =A01.143499] ip_tables: (C) 2000-2006 Netfilter Core Team
>> [ =A0 =A01.143510] TCP cubic registered
>> [ =A0 =A01.143512] Initializing XFRM netlink socket
>> [ =A0 =A01.143626] NET: Registered protocol family 10
>> [ =A0 =A01.143745] Mobile IPv6
>> [ =A0 =A01.143748] NET: Registered protocol family 17
>> [ =A0 =A01.143759] Registering the dns_resolver key type
>> [ =A0 =A01.143773] Using IPI No-Shortcut mode
>> [ =A0 =A01.143895] PM: Hibernation image not present or could not be=
 loaded.
>> [ =A0 =A01.143909] registered taskstats version 1
>> [ =A0 =A01.149523] =A0 Magic number: 4:185:899
>> [ =A0 =A01.149603] rtc_cmos 00:03: setting system clock to 2012-03-2=
6 18:51:35 UTC (1332787895)
>> [ =A0 =A01.150476] Initializing network drop monitor service
>> [ =A0 =A01.161406] input: AT Translated Set 2 keyboard as /devices/p=
latform/i8042/serio0/input/input2
>> [ =A0 =A01.425771] ata3: SATA link down (SStatus 0 SControl 300)
>> [ =A0 =A01.512378] input: PS2++ Logitech Wheel Mouse as /devices/pla=
tform/i8042/serio1/input/input3
>> [ =A0 =A01.565064] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl=
 300)
>> [ =A0 =A01.565168] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl=
 300)
>> [ =A0 =A01.576064] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl=
 300)
>> [ =A0 =A01.580317] ata4.00: ATA-7: Maxtor 7V250F0, VA111630, max UDM=
A/133
>> [ =A0 =A01.580321] ata4.00: 490234752 sectors, multi 16: LBA48 NCQ (=
depth 0/32)
>> [ =A0 =A01.581021] usb 4-1: new low-speed USB device number 2 using =
uhci_hcd
>> [ =A0 =A01.587163] ata4.00: configured for UDMA/133
>> [ =A0 =A01.608220] ata2.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
>> [ =A0 =A01.608223] ata2.00: 625142448 sectors, multi 16: LBA48 NCQ (=
depth 0/32)
>> [ =A0 =A01.616082] ata1.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
>> [ =A0 =A01.616086] ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (=
depth 0/32)
>> [ =A0 =A01.662033] Refined TSC clocksource calibration: 2402.378 MHz=
=2E
>> [ =A0 =A01.662038] Switching to clocksource tsc
>> [ =A0 =A01.683190] ata2.00: configured for UDMA/133
>> [ =A0 =A01.691047] ata1.00: configured for UDMA/133
>> [ =A0 =A01.691200] scsi 0:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
ST3320620AS =A0 =A0 =A03.AA PQ: 0 ANSI: 5
>> [ =A0 =A01.691402] sd 0:0:0:0: [sda] 625142448 512-byte logical bloc=
ks: (320 GB/298 GiB)
>> [ =A0 =A01.691414] sd 0:0:0:0: Attached scsi generic sg0 type 0
>> [ =A0 =A01.691473] sd 0:0:0:0: [sda] Write Protect is off
>> [ =A0 =A01.691477] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> [ =A0 =A01.691511] sd 0:0:0:0: [sda] Write cache: enabled, read cach=
e: enabled, doesn't support DPO or FUA
>> [ =A0 =A01.691657] scsi 1:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
ST3320620AS =A0 =A0 =A03.AA PQ: 0 ANSI: 5
>> [ =A0 =A01.691878] sd 1:0:0:0: [sdb] 625142448 512-byte logical bloc=
ks: (320 GB/298 GiB)
>> [ =A0 =A01.691889] sd 1:0:0:0: Attached scsi generic sg1 type 0
>> [ =A0 =A01.691988] sd 1:0:0:0: [sdb] Write Protect is off
>> [ =A0 =A01.691992] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>> [ =A0 =A01.692032] sd 1:0:0:0: [sdb] Write cache: enabled, read cach=
e: enabled, doesn't support DPO or FUA
>> [ =A0 =A01.692091] scsi 3:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
Maxtor 7V250F0 =A0 VA11 PQ: 0 ANSI: 5
>> [ =A0 =A01.692268] sd 3:0:0:0: [sdc] 490234752 512-byte logical bloc=
ks: (251 GB/233 GiB)
>> [ =A0 =A01.692310] sd 3:0:0:0: Attached scsi generic sg2 type 0
>> [ =A0 =A01.692360] sd 3:0:0:0: [sdc] Write Protect is off
>> [ =A0 =A01.692364] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>> [ =A0 =A01.692393] sd 3:0:0:0: [sdc] Write cache: enabled, read cach=
e: enabled, doesn't support DPO or FUA
>> [ =A0 =A01.715627] =A0sdc: sdc1
>> [ =A0 =A01.715885] sd 3:0:0:0: [sdc] Attached SCSI disk
>> [ =A0 =A01.722872] =A0sdb: sdb1 sdb2 sdb3
>> [ =A0 =A01.723190] sd 1:0:0:0: [sdb] Attached SCSI disk
>> [ =A0 =A01.730721] =A0sda: sda1 sda2 sda3
>> [ =A0 =A01.730990] sd 0:0:0:0: [sda] Attached SCSI disk
>> [ =A0 =A01.731061] Freeing unused kernel memory: 644k freed
>> [ =A0 =A01.731261] Write protecting the kernel text: 5408k
>> [ =A0 =A01.731315] Write protecting the kernel read-only data: 2096k
>> [ =A0 =A01.731319] NX-protecting the kernel data: 4832k
>> [ =A0 =A01.768691] usb 4-1: New USB device found, idVendor=3D051d, i=
dProduct=3D0002
>> [ =A0 =A01.768696] usb 4-1: New USB device strings: Mfr=3D3, Product=
=3D1, SerialNumber=3D2
>> [ =A0 =A01.768700] usb 4-1: Product: APC ES 725 FW:821.y2 .A USB FW:=
y2
>> [ =A0 =A01.768703] usb 4-1: Manufacturer: APC
>> [ =A0 =A01.768706] usb 4-1: SerialNumber: 3B0628X18842
>> [ =A0 =A01.867527] dracut: dracut-013-20.fc16
>> [ =A0 =A01.892049] udevd[122]: starting version 173
>> [ =A0 =A01.960670] dracut: Starting plymouth daemon
>> [ =A0 =A02.056749] sata_sil24 0000:03:00.0: version 1.1
>> [ =A0 =A02.056771] sata_sil24 0000:03:00.0: PCI INT A -> GSI 17 (lev=
el, low) -> IRQ 17
>> [ =A0 =A02.056826] sata_sil24 0000:03:00.0: setting latency timer to=
 64
>> [ =A0 =A02.059272] pata_marvell 0000:05:00.0: PCI INT A -> GSI 16 (l=
evel, low) -> IRQ 16
>> [ =A0 =A02.059303] pata_marvell 0000:05:00.0: setting latency timer =
to 64
>> [ =A0 =A02.061729] scsi5 : pata_marvell
>> [ =A0 =A02.062173] scsi4 : sata_sil24
>> [ =A0 =A02.062765] scsi7 : sata_sil24
>> [ =A0 =A02.062830] ata5: SATA max UDMA/100 host m128@0xfe8ffc00 port=
 0xfe8f8000 irq 17
>> [ =A0 =A02.062835] ata6: SATA max UDMA/100 host m128@0xfe8ffc00 port=
 0xfe8fa000 irq 17
>> [ =A0 =A02.062874] sata_sil24 0000:04:00.0: PCI INT A -> GSI 18 (lev=
el, low) -> IRQ 18
>> [ =A0 =A02.062881] scsi6 : pata_marvell
>> [ =A0 =A02.062942] sata_sil24 0000:04:00.0: setting latency timer to=
 64
>> [ =A0 =A02.062948] ata7: PATA max UDMA/100 cmd 0xdc00 ctl 0xd880 bmd=
ma 0xd400 irq 16
>> [ =A0 =A02.062952] ata8: PATA max UDMA/133 cmd 0xd800 ctl 0xd480 bmd=
ma 0xd408 irq 16
>> [ =A0 =A02.065053] scsi8 : sata_sil24
>> [ =A0 =A02.065207] scsi9 : sata_sil24
>> [ =A0 =A02.065259] ata9: SATA max UDMA/100 host m128@0xfe9ffc00 port=
 0xfe9f8000 irq 18
>> [ =A0 =A02.065263] ata10: SATA max UDMA/100 host m128@0xfe9ffc00 por=
t 0xfe9fa000 irq 18
>> [ =A0 =A02.217434] ata7.00: ATAPI: HL-DT-STDVD-RAM GSA-H58N, 1.03, m=
ax UDMA/66
>> [ =A0 =A02.221802] mdadm: sending ioctl 800c0910 to a partition!
>> [ =A0 =A02.221806] mdadm: sending ioctl 800c0910 to a partition!
>> [ =A0 =A02.221889] mdadm: sending ioctl 1261 to a partition!
>> [ =A0 =A02.221891] mdadm: sending ioctl 1261 to a partition!
>> [ =A0 =A02.223422] ata7.00: configured for UDMA/66
>> [ =A0 =A02.235804] generic-usb 0003:051D:0002.0001: hiddev0,hidraw0:=
 USB HID v1.10 Device [APC APC ES 725 FW:821.y2 .A USB FW:y2 ] on usb-0=
000:00:1a.1-1/input0
>> [ =A0 =A02.243045] mdadm: sending ioctl 800c0910 to a partition!
>> [ =A0 =A02.243048] mdadm: sending ioctl 800c0910 to a partition!
>> [ =A0 =A02.243137] mdadm: sending ioctl 1261 to a partition!
>> [ =A0 =A02.243139] mdadm: sending ioctl 1261 to a partition!
>> [ =A0 =A02.255680] mdadm: sending ioctl 800c0910 to a partition!
>> [ =A0 =A02.255684] mdadm: sending ioctl 800c0910 to a partition!
>> [ =A0 =A02.278604] md: bind<sdb1>
>> [ =A0 =A02.280946] md: bind<sda1>
>> [ =A0 =A02.283163] md: raid1 personality registered for level 1
>> [ =A0 =A04.082034] ata5: SATA link down (SStatus 0 SControl 0)
>> [ =A0 =A04.197035] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl=
 0)
>> [ =A0 =A04.197372] ata9.15: Port Multiplier 1.1, 0x1095:0x3726 r23, =
6 ports, feat 0x1/0x9
>> [ =A0 =A04.199141] ata9.00: hard resetting link
>> [ =A0 =A04.537254] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SCont=
rol 320)
>> [ =A0 =A04.537290] ata9.01: hard resetting link
>> [ =A0 =A04.963015] ata9.01: softreset failed (SRST command error)
>> [ =A0 =A05.073014] ata9.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0 =A05.073019] ata9.01: reset failed (errno=3D-85), retrying in =
10 secs
>> [ =A0 =A06.102041] ata6: SATA link down (SStatus 0 SControl 0)
>> [ =A0 =A06.103522] scsi 5:0:0:0: CD-ROM =A0 =A0 =A0 =A0 =A0 =A0HL-DT=
-ST DVD-RAM GSA-H58N 1.03 PQ: 0 ANSI: 5
>> [ =A0 =A06.106341] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/r=
w xa/form2 cdda tray
>> [ =A0 =A06.106345] cdrom: Uniform CD-ROM driver Revision: 3.20
>> [ =A0 =A06.106541] sr 5:0:0:0: Attached scsi CD-ROM sr0
>> [ =A0 =A06.106728] sr 5:0:0:0: Attached scsi generic sg3 type 5
>> [ =A0 14.537112] ata9.01: reset failed, giving up
>> [ =A0 14.537117] ata9.15: hard resetting link
>> [ =A0 14.537120] ata9: controller in dubious state, performing PORT_=
RST
>> [ =A0 16.691040] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 16.691389] ata9.00: hard resetting link
>> [ =A0 17.029255] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 320)
>> [ =A0 17.029290] ata9.01: hard resetting link
>> [ =A0 17.367252] ata9.01: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 17.367287] ata9.02: hard resetting link
>> [ =A0 17.683040] ata9.02: softreset failed (SRST command error)
>> [ =A0 17.683099] ata9.02: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0 17.683103] ata9.02: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 27.367023] ata9.02: reset failed, giving up
>> [ =A0 27.367028] ata9.15: hard resetting link
>> [ =A0 29.488078] ata9.15: softreset failed (SRST command error)
>> [ =A0 29.488082] ata9.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0 37.367018] ata9.15: hard resetting link
>> [ =A0 39.488071] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 39.488077] ata9.15: PMP revalidation failed (errno=3D-19)
>> [ =A0 44.488012] ata9.15: hard resetting link
>> [ =A0 46.620040] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 46.620470] ata9.00: hard resetting link
>> [ =A0 46.958247] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 320)
>> [ =A0 46.958285] ata9.01: hard resetting link
>> [ =A0 47.296247] ata9.01: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 47.296284] ata9.02: hard resetting link
>> [ =A0 47.634249] ata9.02: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 47.634286] ata9.03: hard resetting link
>> [ =A0 48.060017] ata9.03: softreset failed (SRST command error)
>> [ =A0 48.060035] ata9.03: failed to read SCR 0 (Emask=3D0x40)
>> [ =A0 48.060038] ata9.03: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 57.634037] ata9.03: reset failed, giving up
>> [ =A0 57.634041] ata9.15: hard resetting link
>> [ =A0 57.634043] ata9: controller in dubious state, performing PORT_=
RST
>> [ =A0 59.788039] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 59.788377] ata9.00: hard resetting link
>> [ =A0 60.126253] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 320)
>> [ =A0 60.126289] ata9.01: hard resetting link
>> [ =A0 60.464250] ata9.01: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 60.464285] ata9.02: hard resetting link
>> [ =A0 60.802251] ata9.02: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 60.802286] ata9.03: hard resetting link
>> [ =A0 61.140252] ata9.03: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 61.140287] ata9.04: hard resetting link
>> [ =A0 61.445390] ata9.04: SATA link down (SStatus 0 SControl 320)
>> [ =A0 61.445457] ata9.05: hard resetting link
>> [ =A0 61.750359] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0 61.779136] ata9.00: ATA-8: ST31500341AS, CC1H, max UDMA/133
>> [ =A0 61.779141] ata9.00: 2930277168 sectors, multi 16: LBA48 NCQ (d=
epth 31/32)
>> [ =A0 61.821129] ata9.00: configured for UDMA/100
>> [ =A0 61.849775] ata9.01: ATA-8: ST31500341AS, CC1H, max UDMA/133
>> [ =A0 61.849779] ata9.01: 2930277168 sectors, multi 0: LBA48 NCQ (de=
pth 31/32)
>> [ =A0 61.891640] ata9.01: configured for UDMA/100
>> [ =A0 61.920328] ata9.02: ATA-8: ST31500341AS, CC1H, max UDMA/133
>> [ =A0 61.920333] ata9.02: 2930277168 sectors, multi 0: LBA48 NCQ (de=
pth 31/32)
>> [ =A0 61.962282] ata9.02: configured for UDMA/100
>> [ =A0 61.990999] ata9.03: ATA-8: ST31500341AS, CC1H, max UDMA/133
>> [ =A0 61.991009] ata9.03: 2930277168 sectors, multi 0: LBA48 NCQ (de=
pth 31/32)
>> [ =A0 62.032997] ata9.03: configured for UDMA/100
>> [ =A0 62.033088] ata9: EH complete
>> [ =A0 62.033219] scsi 8:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
ST31500341AS =A0 =A0 CC1H PQ: 0 ANSI: 5
>> [ =A0 62.033413] sd 8:0:0:0: [sdd] 2930277168 512-byte logical block=
s: (1.50 TB/1.36 TiB)
>> [ =A0 62.033453] sd 8:0:0:0: Attached scsi generic sg4 type 0
>> [ =A0 62.033511] sd 8:0:0:0: [sdd] Write Protect is off
>> [ =A0 62.033516] sd 8:0:0:0: [sdd] Mode Sense: 00 3a 00 00
>> [ =A0 62.033557] sd 8:0:0:0: [sdd] Write cache: enabled, read cache:=
 enabled, doesn't support DPO or FUA
>> [ =A0 62.033638] scsi 8:1:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
ST31500341AS =A0 =A0 CC1H PQ: 0 ANSI: 5
>> [ =A0 62.033810] sd 8:1:0:0: [sde] 2930277168 512-byte logical block=
s: (1.50 TB/1.36 TiB)
>> [ =A0 62.033898] sd 8:1:0:0: [sde] Write Protect is off
>> [ =A0 62.033902] sd 8:1:0:0: [sde] Mode Sense: 00 3a 00 00
>> [ =A0 62.033939] sd 8:1:0:0: [sde] Write cache: enabled, read cache:=
 enabled, doesn't support DPO or FUA
>> [ =A0 62.033977] sd 8:1:0:0: Attached scsi generic sg5 type 0
>> [ =A0 62.034257] scsi 8:2:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
ST31500341AS =A0 =A0 CC1H PQ: 0 ANSI: 5
>> [ =A0 62.034426] sd 8:2:0:0: [sdf] 2930277168 512-byte logical block=
s: (1.50 TB/1.36 TiB)
>> [ =A0 62.034514] sd 8:2:0:0: [sdf] Write Protect is off
>> [ =A0 62.034518] sd 8:2:0:0: [sdf] Mode Sense: 00 3a 00 00
>> [ =A0 62.034554] sd 8:2:0:0: Attached scsi generic sg6 type 0
>> [ =A0 62.034563] sd 8:2:0:0: [sdf] Write cache: enabled, read cache:=
 enabled, doesn't support DPO or FUA
>> [ =A0 62.034743] scsi 8:3:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
ST31500341AS =A0 =A0 CC1H PQ: 0 ANSI: 5
>> [ =A0 62.034910] sd 8:3:0:0: [sdg] 2930277168 512-byte logical block=
s: (1.50 TB/1.36 TiB)
>> [ =A0 62.034954] sd 8:3:0:0: Attached scsi generic sg7 type 0
>> [ =A0 62.035000] sd 8:3:0:0: [sdg] Write Protect is off
>> [ =A0 62.035011] sd 8:3:0:0: [sdg] Mode Sense: 00 3a 00 00
>> [ =A0 62.035063] sd 8:3:0:0: [sdg] Write cache: enabled, read cache:=
 enabled, doesn't support DPO or FUA
>> [ =A0 62.041037] =A0sdd: unknown partition table
>> [ =A0 62.041278] sd 8:0:0:0: [sdd] Attached SCSI disk
>> [ =A0 62.055364] =A0sde: unknown partition table
>> [ =A0 62.055517] sd 8:1:0:0: [sde] Attached SCSI disk
>> [ =A0 62.059238] =A0sdf: unknown partition table
>> [ =A0 62.059395] sd 8:2:0:0: [sdf] Attached SCSI disk
>> [ =A0 62.060249] =A0sdg: unknown partition table
>> [ =A0 62.060399] sd 8:3:0:0: [sdg] Attached SCSI disk
>> [ =A0 64.167041] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl =
0)
>> [ =A0 64.167363] ata10.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6=
 ports, feat 0x1/0x9
>> [ =A0 64.169254] ata10.00: hard resetting link
>> [ =A0 64.573260] ata10.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 320)
>> [ =A0 64.573299] ata10.01: hard resetting link
>> [ =A0 64.999017] ata10.01: softreset failed (SRST command error)
>> [ =A0 64.999034] ata10.01: failed to read SCR 0 (Emask=3D0x40)
>> [ =A0 64.999038] ata10.01: reset failed (errno=3D-85), retrying in 1=
0 secs
>> [ =A0 74.573049] ata10.01: reset failed, giving up
>> [ =A0 74.573058] ata10.15: hard resetting link
>> [ =A0 74.573061] ata10: controller in dubious state, performing PORT=
_RST
>> [ =A0 76.727039] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
>> [ =A0 76.727371] ata10.00: hard resetting link
>> [ =A0 77.131252] ata10.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 320)
>> [ =A0 77.131287] ata10.01: hard resetting link
>> [ =A0 77.535261] ata10.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
>> [ =A0 77.535297] ata10.02: hard resetting link
>> [ =A0 77.851041] ata10.02: softreset failed (SRST command error)
>> [ =A0 77.961014] ata10.02: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0 77.961018] ata10.02: reset failed (errno=3D-85), retrying in 1=
0 secs
>> [ =A0 87.535028] ata10.02: reset failed, giving up
>> [ =A0 87.535033] ata10.15: hard resetting link
>> [ =A0 87.535035] ata10: controller in dubious state, performing PORT=
_RST
>> [ =A0 89.689041] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
>> [ =A0 89.689414] ata10.00: hard resetting link
>> [ =A0 90.093265] ata10.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 320)
>> [ =A0 90.093303] ata10.01: hard resetting link
>> [ =A0 90.497259] ata10.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
>> [ =A0 90.497296] ata10.02: hard resetting link
>> [ =A0 90.901259] ata10.02: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
>> [ =A0 90.901296] ata10.03: hard resetting link
>> [ =A0 91.327009] ata10.03: softreset failed (SRST command error)
>> [ =A0 91.327024] ata10.03: failed to read SCR 0 (Emask=3D0x40)
>> [ =A0 91.327026] ata10.03: reset failed (errno=3D-85), retrying in 1=
0 secs
>> [ =A0100.901043] ata10.03: reset failed, giving up
>> [ =A0100.901048] ata10.15: hard resetting link
>> [ =A0100.901051] ata10: controller in dubious state, performing PORT=
_RST
>> [ =A0103.055046] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
>> [ =A0103.055433] ata10.00: hard resetting link
>> [ =A0103.459260] ata10.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 320)
>> [ =A0103.459296] ata10.01: hard resetting link
>> [ =A0103.863260] ata10.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
>> [ =A0103.863296] ata10.02: hard resetting link
>> [ =A0104.267287] ata10.02: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
>> [ =A0104.267332] ata10.03: hard resetting link
>> [ =A0104.671261] ata10.03: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
>> [ =A0104.671297] ata10.04: hard resetting link
>> [ =A0104.976391] ata10.04: SATA link down (SStatus 0 SControl 320)
>> [ =A0104.976458] ata10.05: hard resetting link
>> [ =A0105.281363] ata10.05: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 320)
>> [ =A0105.282235] ata10.00: ATA-8: Hitachi HDP725050GLA360, GM4OA50E,=
 max UDMA/133
>> [ =A0105.282240] ata10.00: 976773168 sectors, multi 16: LBA48 NCQ (d=
epth 31/32)
>> [ =A0105.283269] ata10.00: configured for UDMA/100
>> [ =A0105.303836] ata10.01: ATA-8: Hitachi HDP725050GLA360, GM4OA50E,=
 max UDMA/133
>> [ =A0105.303840] ata10.01: 976773168 sectors, multi 0: LBA48 NCQ (de=
pth 31/32)
>> [ =A0105.304715] ata10.01: configured for UDMA/100
>> [ =A0105.319063] ata10.02: ATA-8: Hitachi HDP725050GLA360, GM4OA50E,=
 max UDMA/133
>> [ =A0105.319067] ata10.02: 976773168 sectors, multi 0: LBA48 NCQ (de=
pth 31/32)
>> [ =A0105.319948] ata10.02: configured for UDMA/100
>> [ =A0105.333306] ata10.03: ATA-8: Hitachi HDP725050GLA360, GM4OA50E,=
 max UDMA/133
>> [ =A0105.333310] ata10.03: 976773168 sectors, multi 0: LBA48 NCQ (de=
pth 31/32)
>> [ =A0105.334189] ata10.03: configured for UDMA/100
>> [ =A0105.334259] ata10: EH complete
>> [ =A0105.334390] scsi 9:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
Hitachi HDP72505 GM4O PQ: 0 ANSI: 5
>> [ =A0105.334575] sd 9:0:0:0: [sdh] 976773168 512-byte logical blocks=
: (500 GB/465 GiB)
>> [ =A0105.334617] sd 9:0:0:0: Attached scsi generic sg8 type 0
>> [ =A0105.334672] sd 9:0:0:0: [sdh] Write Protect is off
>> [ =A0105.334676] sd 9:0:0:0: [sdh] Mode Sense: 00 3a 00 00
>> [ =A0105.334717] sd 9:0:0:0: [sdh] Write cache: enabled, read cache:=
 enabled, doesn't support DPO or FUA
>> [ =A0105.334785] scsi 9:1:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
Hitachi HDP72505 GM4O PQ: 0 ANSI: 5
>> [ =A0105.334954] sd 9:1:0:0: [sdi] 976773168 512-byte logical blocks=
: (500 GB/465 GiB)
>> [ =A0105.335040] sd 9:1:0:0: [sdi] Write Protect is off
>> [ =A0105.335044] sd 9:1:0:0: [sdi] Mode Sense: 00 3a 00 00
>> [ =A0105.335076] sd 9:1:0:0: [sdi] Write cache: enabled, read cache:=
 enabled, doesn't support DPO or FUA
>> [ =A0105.335274] sd 9:1:0:0: Attached scsi generic sg9 type 0
>> [ =A0105.335459] scsi 9:2:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
Hitachi HDP72505 GM4O PQ: 0 ANSI: 5
>> [ =A0105.335626] sd 9:2:0:0: [sdj] 976773168 512-byte logical blocks=
: (500 GB/465 GiB)
>> [ =A0105.335714] sd 9:2:0:0: [sdj] Write Protect is off
>> [ =A0105.335718] sd 9:2:0:0: [sdj] Mode Sense: 00 3a 00 00
>> [ =A0105.335757] sd 9:2:0:0: [sdj] Write cache: enabled, read cache:=
 enabled, doesn't support DPO or FUA
>> [ =A0105.335766] sd 9:2:0:0: Attached scsi generic sg10 type 0
>> [ =A0105.335938] scsi 9:3:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
Hitachi HDP72505 GM4O PQ: 0 ANSI: 5
>> [ =A0105.336111] sd 9:3:0:0: [sdk] 976773168 512-byte logical blocks=
: (500 GB/465 GiB)
>> [ =A0105.336161] sd 9:3:0:0: Attached scsi generic sg11 type 0
>> [ =A0105.336202] sd 9:3:0:0: [sdk] Write Protect is off
>> [ =A0105.336206] sd 9:3:0:0: [sdk] Mode Sense: 00 3a 00 00
>> [ =A0105.336260] sd 9:3:0:0: [sdk] Write cache: enabled, read cache:=
 enabled, doesn't support DPO or FUA
>> [ =A0105.346322] =A0sdh: unknown partition table
>> [ =A0105.346554] sd 9:0:0:0: [sdh] Attached SCSI disk
>> [ =A0105.360434] =A0sdj: unknown partition table
>> [ =A0105.360598] sd 9:2:0:0: [sdj] Attached SCSI disk
>> [ =A0105.361877] =A0sdi: unknown partition table
>> [ =A0105.362042] sd 9:1:0:0: [sdi] Attached SCSI disk
>> [ =A0105.366343] =A0sdk: unknown partition table
>> [ =A0105.366502] sd 9:3:0:0: [sdk] Attached SCSI disk
>> [ =A0105.366688] bio: create slab <bio-1> at 1
>> [ =A0105.366782] md/raid1:md0: active with 2 out of 2 mirrors
>> [ =A0105.366819] md0: detected capacity change from 0 to 314507264
>> [ =A0105.385841] =A0md0:
>> [ =A0105.387349] scsi_verify_blk_ioctl: 122 callbacks suppressed
>> [ =A0105.387352] mdadm: sending ioctl 1261 to a partition!
>> [ =A0105.387355] mdadm: sending ioctl 1261 to a partition!
>> [ =A0105.445648] mdadm: sending ioctl 1261 to a partition!
>> [ =A0105.445651] mdadm: sending ioctl 1261 to a partition!
>> [ =A0105.475825] mdadm: sending ioctl 1261 to a partition!
>> [ =A0105.475828] mdadm: sending ioctl 1261 to a partition!
>> [ =A0105.482162] md: bind<sdg>
>> [ =A0105.485146] md: bind<sdf>
>> [ =A0105.488262] md: bind<sde>
>> [ =A0105.491687] md: bind<sdd>
>> [ =A0105.494574] async_tx: api initialized (async)
>> [ =A0105.494927] xor: automatically using best checksumming function=
: pIII_sse
>> [ =A0105.499004] =A0 =A0pIII_sse =A0: =A08432.000 MB/sec
>> [ =A0105.499006] xor: using function: pIII_sse (8432.000 MB/sec)
>> [ =A0105.508257] mdadm: sending ioctl 1261 to a partition!
>> [ =A0105.508260] mdadm: sending ioctl 1261 to a partition!
>> [ =A0105.516064] raid6: int32x1 =A0 =A0902 MB/s
>> [ =A0105.533042] raid6: int32x2 =A0 =A0773 MB/s
>> [ =A0105.550091] raid6: int32x4 =A0 =A0714 MB/s
>> [ =A0105.567020] raid6: int32x8 =A0 =A0796 MB/s
>> [ =A0105.584015] raid6: mmxx1 =A0 =A0 3160 MB/s
>> [ =A0105.601018] raid6: mmxx2 =A0 =A0 3523 MB/s
>> [ =A0105.618010] raid6: sse1x1 =A0 =A02062 MB/s
>> [ =A0105.635022] raid6: sse1x2 =A0 =A02734 MB/s
>> [ =A0105.652017] raid6: sse2x1 =A0 =A03707 MB/s
>> [ =A0105.669017] raid6: sse2x2 =A0 =A04906 MB/s
>> [ =A0105.669018] raid6: using algorithm sse2x2 (4906 MB/s)
>> [ =A0105.669800] md: raid6 personality registered for level 6
>> [ =A0105.669802] md: raid5 personality registered for level 5
>> [ =A0105.669804] md: raid4 personality registered for level 4
>> [ =A0105.669950] md/raid:md6: device sdd operational as raid disk 0
>> [ =A0105.669952] md/raid:md6: device sde operational as raid disk 1
>> [ =A0105.669954] md/raid:md6: device sdf operational as raid disk 2
>> [ =A0105.669956] md/raid:md6: device sdg operational as raid disk 3
>> [ =A0105.670311] md/raid:md6: allocated 4216kB
>> [ =A0105.670342] md/raid:md6: raid level 5 active with 4 out of 4 de=
vices, algorithm 2
>> [ =A0105.670344] RAID conf printout:
>> [ =A0105.670345] =A0--- level:5 rd:4 wd:4
>> [ =A0105.670347] =A0disk 0, o:1, dev:sdd
>> [ =A0105.670349] =A0disk 1, o:1, dev:sde
>> [ =A0105.670350] =A0disk 2, o:1, dev:sdf
>> [ =A0105.670352] =A0disk 3, o:1, dev:sdg
>> [ =A0105.670377] md6: detected capacity change from 0 to 45008975953=
92
>> [ =A0105.672274] md: bind<sdk>
>> [ =A0105.673419] =A0md6: unknown partition table
>> [ =A0105.675966] md: bind<sdj>
>> [ =A0105.679622] md: bind<sdi>
>> [ =A0105.683718] md: bind<sdh>
>> [ =A0105.687032] md/raid:md7: device sdh operational as raid disk 1
>> [ =A0105.687035] md/raid:md7: device sdi operational as raid disk 0
>> [ =A0105.687037] md/raid:md7: device sdj operational as raid disk 2
>> [ =A0105.687038] md/raid:md7: device sdk operational as raid disk 3
>> [ =A0105.687363] md/raid:md7: allocated 4216kB
>> [ =A0105.687395] md/raid:md7: raid level 5 active with 4 out of 4 de=
vices, algorithm 2
>> [ =A0105.687397] RAID conf printout:
>> [ =A0105.687398] =A0--- level:5 rd:4 wd:4
>> [ =A0105.687400] =A0disk 0, o:1, dev:sdi
>> [ =A0105.687401] =A0disk 1, o:1, dev:sdh
>> [ =A0105.687403] =A0disk 2, o:1, dev:sdj
>> [ =A0105.687404] =A0disk 3, o:1, dev:sdk
>> [ =A0105.687428] md7: detected capacity change from 0 to 15003154513=
92
>> [ =A0105.689250] =A0md7: unknown partition table
>> [ =A0140.072536] dracut Warning: No root device "block:/dev/disk/by-=
uuid/773cb4b3-4bb0-4705-b494-08cb9c2b5d73" found
> ------
