From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12217] reading a cdrom hangs the system
Date: Wed, 17 Dec 2008 02:23:12 -0800 (PST)
Message-ID: <20081217102312.689AE11D109@picon.linux-foundation.org>
References: <bug-12217-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39605 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751401AbYLQKXQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Dec 2008 05:23:16 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHANCfp006100
	for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 02:23:13 -0800
In-Reply-To: <bug-12217-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=3D12217





------- Comment #2 from michel.schmid-ms@orange.fr  2008-12-17 02:23 --=
-----
Hi,
Please find attached the two outputs you asked for.
Both commands were ran after the reboot, because rebooting is the only=20
thing I can do afer the hang (or crash?): keyboard and mouse are dead.
thanks and regards,
Michel.

"Le dire c'est bien, le fer c'est mieux"

Michel Schmid
Chemin de Chamarge=20
=46-04300 Mane
T=E9l. : +33 4 92 75 42 09
www.michel-schmid.com



bugme-daemon@bugzilla.kernel.org a =E9crit :
> http://bugzilla.kernel.org/show_bug.cgi?id=3D12217
>
>
> bbpetkov@yahoo.de changed:
>
>            What    |Removed                     |Added
> ---------------------------------------------------------------------=
-------
>                  CC|                            |bbpetkov@yahoo.de
>
>
>
>
> ------- Comment #1 from bbpetkov@yahoo.de  2008-12-14 01:56 -------
> Hi,
>
> please send the output of 'dmesg' and 'lspci -vv', the last one run a=
s root.
>
> Thanks.
>
>
>  =20
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.27-10-generic (buildd@vernadsky) (gcc =
version
4.3.2 (Ubuntu 4.3.2-1ubuntu11) ) #1 SMP Fri Nov 21 12:00:22 UTC 2008 (U=
buntu
2.6.27-10.20-generic)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserve=
d)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001dff0000 (usable)
[    0.000000]  BIOS-e820: 000000001dff0000 - 000000001dffffc0 (ACPI da=
ta)
[    0.000000]  BIOS-e820: 000000001dffffc0 - 000000001e000000 (ACPI NV=
S)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserve=
d)
[    0.000000] DMI 2.3 present.
[    0.000000] last_pfn =3D 0x1dff0 max_arch_pfn =3D 0x100000
[    0.000000] kernel direct mapping tables up to 1dff0000 @ 7000-d000
[    0.000000] RAMDISK: 1d81e000 - 1dfdfef1
[    0.000000] ACPI: RSDP 000E5010, 0014 (r0 OID_00)
[    0.000000] ACPI: RSDT 1DFFFBC0, 0030 (r1 INSYDE RSDT_000        1 _=
CSI  =20
10101)
[    0.000000] ACPI: FACP 1DFFFAC0, 0074 (r1 INSYDE FACP_000      100 _=
CSI  =20
10101)
[    0.000000] ACPI: DSDT 1DFFC6E0, 33DA (r1 INSYDE    KN266     1000 M=
SFT=20
100000E)
[    0.000000] ACPI: FACS 1DFFFFC0, 0040
[    0.000000] ACPI: BOOT 1DFFFB50, 0028 (r1 INSYDE SYS_BOOT      100 _=
CSI  =20
10101)
[    0.000000] ACPI: DBGP 1DFFFB80, 0034 (r1 INSYDE DBGP_000      100 _=
CSI  =20
10101)
[    0.000000] ACPI: DMI detected: Acer
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 479MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 1dff0000
[    0.000000]   low ram: 00000000 - 1dff0000
[    0.000000]   bootmap 00002000 - 00005c00
[    0.000000] (9 early reservations) =3D=3D> bootmem [0000000000 - 001=
dff0000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> =
[0000000000
- 0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE =3D=3D> =
[0000001000
- 0000002000]
[    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE =3D=3D> =
[0000006000
- 0000007000]
[    0.000000]   #3 [0000100000 - 00005c09e0]    TEXT DATA BSS =3D=3D> =
[0000100000
- 00005c09e0]
[    0.000000]   #4 [001d81e000 - 001dfdfef1]          RAMDISK =3D=3D> =
[001d81e000
- 001dfdfef1]
[    0.000000]   #5 [00005c1000 - 00005c4000]    INIT_PG_TABLE =3D=3D> =
[00005c1000
- 00005c4000]
[    0.000000]   #6 [000009fc00 - 0000100000]    BIOS reserved =3D=3D> =
[000009fc00
- 0000100000]
[    0.000000]   #7 [0000007000 - 0000009000]          PGTABLE =3D=3D> =
[0000007000
- 0000009000]
[    0.000000]   #8 [0000002000 - 0000006000]          BOOTMAP =3D=3D> =
[0000002000
- 0000006000]
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x0001dff0
[    0.000000]   HighMem  0x0001dff0 -> 0x0001dff0
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0001dff0
[    0.000000] On node 0 totalpages: 122767
[    0.000000] free_area_init_node: node 0, pgdat c048a580, node_mem_ma=
p
c1000000
[    0.000000]   DMA zone: 3963 pages, LIFO batch:0
[    0.000000]   Normal zone: 117724 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] SMP: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] Local APIC disabled by BIOS -- you can enable it with "l=
apic"
[    0.000000] mapped APIC to ffffb000 (0143a000)
[    0.000000] PM: Registered nosave memory: 000000000009f000 -
00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 -
00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 -
0000000000100000
[    0.000000] Allocating PCI resources starting at 20000000 (gap:
1e000000:e1f80000)
[    0.000000] PERCPU: Allocating 41628 bytes of per cpu data
[    0.000000] NR_CPUS: 64, nr_cpu_ids: 1, nr_node_ids 1
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total
pages: 121687
[    0.000000] Kernel command line:
root=3DUUID=3De77b4529-960b-43f1-a9a2-226eefbe5090 ro quiet splash loca=
le=3Dfr_FR=20
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[    0.000000] TSC: PIT calibration confirmed by PMTIMER.
[    0.000000] TSC: using PIT calibration value
[    0.000000] Detected 1658.503 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.004000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.004000] Memory: 473156k/491456k available (2574k kernel code, 17=
636k
reserved, 1159k data, 424k init, 0k highmem)
[    0.004000] virtual kernel memory layout:
[    0.004000]     fixmap  : 0xffc77000 - 0xfffff000   (3616 kB)
[    0.004000]     pkmap   : 0xff400000 - 0xff800000   (4096 kB)
[    0.004000]     vmalloc : 0xde800000 - 0xff3fe000   ( 523 MB)
[    0.004000]     lowmem  : 0xc0000000 - 0xddff0000   ( 479 MB)
[    0.004000]       .init : 0xc04ab000 - 0xc0515000   ( 424 kB)
[    0.004000]       .data : 0xc038389a - 0xc04a5680   (1159 kB)
[    0.004000]       .text : 0xc0100000 - 0xc038389a   (2574 kB)
[    0.004000] Checking if this processor honours the WP bit even in su=
pervisor
mode...Ok.
[    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
[    0.004000] SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjec=
ts=3D0, CPUs=3D1,
Nodes=3D1
[    0.004022] Calibrating delay loop (skipped), value calculated using=
 timer
frequency.. 3317.00 BogoMIPS (lpj=3D6634012)
[    0.004061] Security Framework initialized
[    0.004075] SELinux:  Disabled at boot.
[    0.004125] AppArmor: AppArmor initialized
[    0.004139] Mount-cache hash table entries: 512
[    0.004439] Initializing cgroup subsys ns
[    0.004446] Initializing cgroup subsys cpuacct
[    0.004450] Initializing cgroup subsys memory
[    0.004474] Enabling disabled K7/SSE Support.
[    0.004479] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64
bytes/line)
[    0.004483] CPU: L2 Cache: 256K (64 bytes/line)
[    0.004508] Checking 'hlt' instruction... OK.
[    0.020512] SMP alternatives: switching to UP code
[    0.027209] Freeing SMP alternatives: 11k freed
[    0.027220] ACPI: Core revision 20080609
[    0.029799] ACPI: Checking initramfs for custom DSDT
[    0.427369] ACPI: setting ELCR to 0200 (from 0e20)
[    0.428143] weird, boot CPU (#0) not listedby the BIOS.
[    0.428148] SMP motherboard not detected.
[    0.428153] Local APIC not detected. Using dummy APIC emulation.
[    0.428156] SMP disabled
[    0.428281] Brought up 1 CPUs
[    0.428286] Total of 1 processors activated (3317.00 BogoMIPS).
[    0.428311] CPU0 attaching sched-domain:
[    0.428316]  domain 0: span 0 level CPU
[    0.428320]   groups: 0
[    0.428747] net_namespace: 840 bytes
[    0.428760] Booting paravirtualized kernel on bare hardware
[    0.429034] Time: 11:12:22  Date: 12/17/08
[    0.429095] NET: Registered protocol family 16
[    0.429641] EISA bus registered
[    0.429675] ACPI: bus type pci registered
[    0.429925] PCI: PCI BIOS revision 2.10 entry at 0xe8a04, last bus=3D=
1
[    0.429930] PCI: Using configuration type 1 for base access
[    0.434251] ACPI: EC: Look up EC in DSDT
[    0.442191] ACPI: Interpreter enabled
[    0.442198] ACPI: (supports S0 S3 S4 S5)
[    0.442222] ACPI: Using PIC for interrupt routing
[    0.447940] ACPI: EC: non-query interrupt received, switching to int=
errupt
mode
[    0.452756] ACPI: EC: GPE =3D 0x1, I/O: command/status =3D 0x66, dat=
a =3D 0x62
[    0.452761] ACPI: EC: driver started in interrupt mode
[    0.452837] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.452970] PCI: 0000:00:00.0 reg 10 32bit mmio: [b0000000, b7ffffff=
]
[    0.453049] pci 0000:00:01.0: supports D1
[    0.453087] PCI: 0000:00:0a.0 reg 10 32bit mmio: [c000000, c000fff]
[    0.453102] pci 0000:00:0a.0: supports D1
[    0.453105] pci 0000:00:0a.0: supports D2
[    0.453108] pci 0000:00:0a.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.453114] pci 0000:00:0a.0: PME# disabled
[    0.453146] PCI: 0000:00:0c.0 reg 10 32bit mmio: [f0000000, f00007ff=
]
[    0.453153] PCI: 0000:00:0c.0 reg 14 32bit mmio: [f0004000, f0007fff=
]
[    0.453190] pci 0000:00:0c.0: supports D1
[    0.453192] pci 0000:00:0c.0: supports D2
[    0.453195] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot
[    0.453200] pci 0000:00:0c.0: PME# disabled
[    0.453250] PCI: 0000:00:10.0 reg 20 io port: [1200, 121f]
[    0.453272] pci 0000:00:10.0: supports D1
[    0.453274] pci 0000:00:10.0: supports D2
[    0.453277] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.453282] pci 0000:00:10.0: PME# disabled
[    0.453326] PCI: 0000:00:10.1 reg 20 io port: [1300, 131f]
[    0.453348] pci 0000:00:10.1: supports D1
[    0.453350] pci 0000:00:10.1: supports D2
[    0.453353] pci 0000:00:10.1: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.453358] pci 0000:00:10.1: PME# disabled
[    0.453386] PCI: 0000:00:10.3 reg 10 32bit mmio: [f4000000, f40000ff=
]
[    0.453424] pci 0000:00:10.3: supports D1
[    0.453426] pci 0000:00:10.3: supports D2
[    0.453429] pci 0000:00:10.3: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.453434] pci 0000:00:10.3: PME# disabled
[    0.453498] HPET not enabled in BIOS. You might try hpet=3Dforce boo=
t option
[    0.453509] pci 0000:00:11.0: quirk: region 1000-107f claimed by vt8=
235 PM
[    0.453514] pci 0000:00:11.0: quirk: region 1400-140f claimed by vt8=
235 SMB
[    0.453564] PCI: 0000:00:11.1 reg 20 io port: [1100, 110f]
[    0.453617] PCI: 0000:00:11.5 reg 10 io port: [e000, e0ff]
[    0.453658] pci 0000:00:11.5: supports D1
[    0.453660] pci 0000:00:11.5: supports D2
[    0.453688] PCI: 0000:00:11.6 reg 10 io port: [e100, e1ff]
[    0.453728] pci 0000:00:11.6: supports D1
[    0.453730] pci 0000:00:11.6: supports D2
[    0.453759] PCI: 0000:00:12.0 reg 10 io port: [e200, e2ff]
[    0.453766] PCI: 0000:00:12.0 reg 14 32bit mmio: [f0008000, f00080ff=
]
[    0.453801] pci 0000:00:12.0: supports D1
[    0.453804] pci 0000:00:12.0: supports D2
[    0.453806] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.453811] pci 0000:00:12.0: PME# disabled
[    0.453864] PCI: 0000:01:00.0 reg 10 32bit mmio: [e0080000, e00fffff=
]
[    0.453872] PCI: 0000:01:00.0 reg 14 32bit mmio: [a8000000, afffffff=
]
[    0.453892] PCI: 0000:01:00.0 reg 30 32bit mmio: [c0000, cffff]
[    0.453906] pci 0000:01:00.0: supports D1
[    0.453908] pci 0000:01:00.0: supports D2
[    0.453940] PCI: bridge 0000:00:01.0 io port: [c000, dfff]
[    0.453945] PCI: bridge 0000:00:01.0 32bit mmio: [e0000000, efffffff=
]
[    0.453951] PCI: bridge 0000:00:01.0 32bit mmio pref: [a0000000, aff=
fffff]
[    0.453975] bus 00 -> node 0
[    0.453987] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.454085] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
[    0.463672] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 =
15)
[    0.463851] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 =
15)
[    0.464048] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 =
15)
[    0.464207] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 1=
5) *0,
disabled.
[    0.464505] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.464579] pnp: PnP ACPI init
[    0.464597] ACPI: bus type pnp registered
[    0.468367] pnp: PnP ACPI: found 11 devices
[    0.468367] ACPI: ACPI bus type pnp unregistered
[    0.468367] PnPBIOS: Disabled by ACPI PNP
[    0.469066] PCI: Using ACPI for IRQ routing
[    0.469098] pci 0000:00:0a.0: BAR 0: can't allocate resource
[    0.469264] NET: Registered protocol family 8
[    0.469264] NET: Registered protocol family 20
[    0.469264] NetLabel: Initializing
[    0.469264] NetLabel:  domain hash size =3D 128
[    0.469264] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.469264] NetLabel:  unlabeled traffic allowed by default
[    0.472058] tracer: 772 pages allocated for 65536 entries of 48 byte=
s
[    0.472062]    actual entries 65620
[    0.472484] AppArmor: AppArmor Filesystem Enabled
[    0.472509] ACPI: RTC can wake from S4
[    0.472615] system 00:03: iomem range 0xfffc0000-0xffffffff could no=
t be
reserved
[    0.472631] system 00:05: ioport range 0x1000-0x107f has been reserv=
ed
[    0.472636] system 00:05: ioport range 0x1400-0x140f has been reserv=
ed
[    0.472640] system 00:05: ioport range 0x1600-0x167f has been reserv=
ed
[    0.472644] system 00:05: ioport range 0x2c8-0x2cf has been reserved
[    0.472648] system 00:05: ioport range 0x4d0-0x4d1 has been reserved
[    0.472652] system 00:05: ioport range 0x600-0x60f has been reserved
[    0.472656] system 00:05: ioport range 0x3e0-0x3e3 has been reserved
[    0.472661] system 00:05: iomem range 0xd4000-0xd7fff has been reser=
ved
[    0.508237] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.508243] pci 0000:00:01.0:   IO window: 0xc000-0xdfff
[    0.508249] pci 0000:00:01.0:   MEM window: 0xe0000000-0xefffffff
[    0.508254] pci 0000:00:01.0:   PREFETCH window:
0x000000a0000000-0x000000afffffff
[    0.508263] pci 0000:00:0a.0: CardBus bridge, secondary bus 0000:02
[    0.508266] pci 0000:00:0a.0:   IO window: 0x001800-0x0018ff
[    0.508271] pci 0000:00:0a.0:   IO window: 0x001c00-0x001cff
[    0.508277] pci 0000:00:0a.0:   PREFETCH window: 0x20000000-0x23ffff=
ff
[    0.508282] pci 0000:00:0a.0:   MEM window: 0x24000000-0x27ffffff
[    0.508305] pci 0000:00:01.0: setting latency timer to 64
[    0.508705] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.508711] PCI: setting IRQ 11 as level-triggered
[    0.508719] pci 0000:00:0a.0: PCI INT A -> Link[LNKD] -> GSI 11 (lev=
el, low)
-> IRQ 11
[    0.508727] bus: 00 index 0 io port: [0, ffff]
[    0.508730] bus: 00 index 1 mmio: [0, ffffffff]
[    0.508733] bus: 01 index 0 io port: [c000, dfff]
[    0.508736] bus: 01 index 1 mmio: [e0000000, efffffff]
[    0.508739] bus: 01 index 2 mmio: [a0000000, afffffff]
[    0.508741] bus: 01 index 3 mmio: [0, 0]
[    0.508744] bus: 02 index 0 io port: [1800, 18ff]
[    0.508747] bus: 02 index 1 io port: [1c00, 1cff]
[    0.508749] bus: 02 index 2 mmio: [20000000, 23ffffff]
[    0.508752] bus: 02 index 3 mmio: [24000000, 27ffffff]
[    0.508777] NET: Registered protocol family 2
[    0.508999] IP route cache hash table entries: 4096 (order: 2, 16384=
 bytes)
[    0.509365] TCP established hash table entries: 16384 (order: 5, 131=
072
bytes)
[    0.509640] TCP bind hash table entries: 16384 (order: 5, 131072 byt=
es)
[    0.509928] TCP: Hash tables configured (established 16384 bind 1638=
4)
[    0.509934] TCP reno registered
[    0.510168] NET: Registered protocol family 1
[    0.510446] checking if image is initramfs... it is
[    1.012148] Switched to high resolution mode on CPU 0
[    1.429205] Freeing initrd memory: 7943k freed
[    1.429637] Simple Boot Flag at 0x37 set to 0x1
[    1.430713] audit: initializing netlink socket (disabled)
[    1.430752] type=3D2000 audit(1229512342.428:1): initialized
[    1.438036] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    1.442232] VFS: Disk quotas dquot_6.5.1
[    1.442398] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    1.442600] msgmni has been set to 940
[    1.442843] io scheduler noop registered
[    1.442846] io scheduler anticipatory registered
[    1.442850] io scheduler deadline registered
[    1.442867] io scheduler cfq registered (default)
[    1.442891] PCI: VIA PCI bridge detected.Disabling DAC.
[    1.442968] pci 0000:01:00.0: Boot video device
[    1.443528] isapnp: Scanning for PnP cards...
[    1.797081] isapnp: No Plug & Play device found
[    1.872442] Serial: 8250/16550 driver4 ports, IRQ sharing enabled
[    1.876407] brd: module loaded
[    1.876547] input: Macintosh mouse button emulation as
/devices/virtual/input/input0
[    1.876770] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60=
,0x64
irq 1,12
[    1.892465] i8042.c: Detected active multiplexing controller, rev 1.=
1.
[    1.903616] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.903627] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    1.903631] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    1.903635] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    1.903638] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    1.904727] mice: PS/2 mouse device common for all mice
[    1.904986] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    1.905026] rtc0: alarms up to one year, y3k
[    1.905246] EISA: Probing bus 0 at eisa.0
[    1.905260] Cannot allocate resource for EISA slot 1
[    1.905291] EISA: Detected 0 cards.
[    1.905298] cpuidle: using governor ladder
[    1.905302] cpuidle: using governor menu
[    1.906140] TCP cubic registered
[    1.906195] Using IPI No-Shortcut mode
[    1.906706] registered taskstats version 1
[    1.906881]   Magic number: 4:647:226
[    1.906995] tty ttyrd: hash matches
[    1.907241] rtc_cmos 00:01: setting system clock to 2008-12-17 11:12=
:23 UTC
(1229512343)
[    1.907247] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.907250] EDD information not available.
[    1.908186] Freeing unused kernel memory: 424k freed
[    1.908267] Write protecting the kernel text: 2576k
[    1.908316] Write protecting the kernel read-only data: 936k
[    1.934380] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input1
[    2.276096] fuse init (API version 7.9)
[    2.490304] ACPI: CPU0 (power states: C1[C1] C2[C2])
[    2.490409] processor ACPI0007:00: registered as cooling_device0
[    2.494802] Marking TSC unstable due to TSC halts in idle
[    2.496578] thermal LNXTHERM:01: registered as thermal_zone0
[    2.500708] ACPI: Thermal Zone [THRM] (73 C)
[    3.585741] usbcore: registered new interface driver usbfs
[    3.585795] usbcore: registered new interface driver hub
[    3.596774] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
[    3.596783] PCI: setting IRQ 5 as level-triggered
[    3.596792] ohci1394 0000:00:0c.0: PCI INT A -> Link[LNKC] -> GSI 5 =
(level,
low) -> IRQ 5
[    3.646725] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[5]=20
MMIO=3D[f0000000-f00007ff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/8]
[    3.661653] usbcore: registered new device driver usb
[    3.680449] No dock devices found.
[    3.752861] SCSI subsystem initialized
[    3.756996] USB Universal Host Controller Interface driver v3.0
[    3.763528] via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald B=
ecker
[    3.847214] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[    3.847227] uhci_hcd 0000:00:10.0: PCI INT A -> Link[LNKA] -> GSI 11=
 (level,
low) -> IRQ 11
[    3.847246] uhci_hcd 0000:00:10.0: UHCI Host Controller
[    3.847382] uhci_hcd 0000:00:10.0: new USB bus registered, assigned =
bus
number 1
[    3.847424] uhci_hcd 0000:00:10.0: irq 11, io base 0x00001200
[    3.847787] usb usb1: configuration #1 chosen from 1 choice
[    3.847831] hub 1-0:1.0: USB hub found
[    3.847852] hub 1-0:1.0: 2 ports detected
[    3.849421] libata version 3.00 loaded.
[    4.053035] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[    4.053044] PCI: setting IRQ 10 as level-triggered
[    4.053054] uhci_hcd 0000:00:10.1: PCI INT B -> Link[LNKB] -> GSI 10=
 (level,
low) -> IRQ 10
[    4.053062] uhci_hcd 0000:00:10.1: VIA VLink IRQ fixup, from 255 to =
10
[    4.053092] uhci_hcd 0000:00:10.1: UHCI Host Controller
[    4.053139] uhci_hcd 0000:00:10.1: new USB bus registered, assigned =
bus
number 2
[    4.053179] uhci_hcd 0000:00:10.1: irq 10, io base 0x00001300
[    4.053405] usb usb2: configuration #1 chosen from 1 choice
[    4.053448] hub 2-0:1.0: USB hub found
[    4.053467] hub 2-0:1.0: 2 ports detected
[    4.164173] usb 1-2: new low speed USB device using uhci_hcd and add=
ress 2
[    4.261607] ehci_hcd 0000:00:10.3: PCI INT D -> Link[LNKD] -> GSI 11=
 (level,
low) -> IRQ 11
[    4.261619] ehci_hcd 0000:00:10.3: VIA VLink IRQ fixup, from 0 to 11
[    4.261665] ehci_hcd 0000:00:10.3: EHCI Host Controller
[    4.261715] ehci_hcd 0000:00:10.3: new USB bus registered, assigned =
bus
number 3
[    4.261803] ehci_hcd 0000:00:10.3: irq 11, io mem 0xf4000000
[    4.300158] ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, drive=
r 10 Dec
2004
[    4.300527] usb usb3: configuration #1 chosen from 1 choice
[    4.300584] hub 3-0:1.0: USB hub found
[    4.300606] hub 3-0:1.0: 4 ports detected
[    4.510060] via-rhine 0000:00:12.0: PCI INT A -> Link[LNKA] -> GSI 1=
1
(level, low) -> IRQ 11
[    4.514555] eth0: VIA Rhine II at 0xf0008000, 00:c0:9f:24:63:42, IRQ=
 11.
[    4.515270] eth0: MII PHY found at address 1, status 0x7809 advertis=
ing 01e1
Link 0000.
[    4.515339] pata_acpi 0000:00:11.1: can't derive routing for PCI INT=
 A
[    4.515442] pata_acpi 0000:00:11.1: can't derive routing for PCI INT=
 A
[    4.522979] pata_via 0000:00:11.1: version 0.3.3
[    4.523009] pata_via 0000:00:11.1: can't derive routing for PCI INT =
A
[    4.524199] scsi0 : pata_via
[    4.524526] scsi1 : pata_via
[    4.526654] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x1100=
 irq 14
[    4.526660] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1108=
 irq 15
[    4.688827] ata1.00: ATA-5: IC25N030ATCS04-0, CA3OA71A, max UDMA/100
[    4.688835] ata1.00: 58605120 sectors, multi 16: LBA=20
[    4.696343] usb 1-2: device not accepting address 2, error -71
[    4.704676] ata1.00: configured for UDMA/100
[    4.752185] hub 1-0:1.0: unable to enumerate USB device on port 2
[    4.860310] ata2.01: NODEV after polling detection
[    4.868896] ata2.00: ATAPI: UJDA740 DVD/CDRW, 1.00, max UDMA/33
[    4.884757] ata2.00: configured for UDMA/33
[    4.885023] scsi 0:0:0:0: Direct-Access     ATA      IC25N030ATCS04-=
0 CA3O
PQ: 0 ANSI: 5
[    4.888440] scsi 1:0:0:0: CD-ROM            MATSHITA UJDA740 DVD/CDR=
W 1.00
PQ: 0 ANSI: 5
[    5.104151] usb 1-2: new low speed USB device using uhci_hcd and add=
ress 4
[    5.116317] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f0000=
0a2bdc]
[    5.146946] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[    5.147025] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    5.183255] Driver 'sd' needs updating - please use bus_type methods
[    5.186656] sd 0:0:0:0: [sda] 58605120 512-byte hardware sectors (30=
006 MB)
[    5.186693] sd 0:0:0:0: [sda] Write Protect is off
[    5.186697] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.186737] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enab=
led,
doesn't support DPO or FUA
[    5.186925] sd 0:0:0:0: [sda] 58605120 512-byte hardware sectors (30=
006 MB)
[    5.186947] sd 0:0:0:0: [sda] Write Protect is off
[    5.186951] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.186987] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enab=
led,
doesn't support DPO or FUA
[    5.186995]  sda:<4>Driver 'sr' needs updating - please use bus_type=
 methods
[    5.207834]  sda1 sda2 sda3 sda4
[    5.238457] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.250313] sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda=
 tray
[    5.250323] Uniform CD-ROM driver Revision: 3.20
[    5.250539] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    5.303617] usb 1-2: configuration #1 chosen from 1 choice
[    5.359832] usbcore: registered new interface driver hiddev
[    5.398891] input: HID 1241:1177 as
/devices/pci0000:00/0000:00:10.0/usb1/1-2/1-2:1.0/input/input2
[    5.399847] input,hidraw0: USB HID v1.10 Mouse [HID 1241:1177] on
usb-0000:00:10.0-2
[    5.399902] usbcore: registered new interface driver usbhid
[    5.399909] usbhid: v2.6:USB HID core driver
[    5.761519] PM: Starting manual resume from disk
[    5.761528] PM: Resume from partition 8:2
[    5.761531] PM: Checking hibernation image.
[    5.761896] PM: Resume from disk failed.
[    5.818660] EXT3-fs: INFO: recovery required on readonly filesystem.
[    5.818669] EXT3-fs: write access will be enabled during recovery.
[    7.842405] kjournald starting.  Commit interval 5 seconds
[    7.842450] EXT3-fs: sda3: orphan cleanup on readonly fs
[    7.842462] ext3_orphan_cleanup: deleting unreferenced inode 147335
[    7.842579] ext3_orphan_cleanup: deleting unreferenced inode 325795
[    7.842592] ext3_orphan_cleanup: deleting unreferenced inode 325776
[    7.842603] ext3_orphan_cleanup: deleting unreferenced inode 325775
[    7.842612] ext3_orphan_cleanup: deleting unreferenced inode 325774
[    7.842620] ext3_orphan_cleanup: deleting unreferenced inode 325773
[    7.842629] ext3_orphan_cleanup: deleting unreferenced inode 325772
[    7.842637] EXT3-fs: sda3: 7 orphan inodes deleted
[    7.842641] EXT3-fs: recovery complete.
[    7.924532] EXT3-fs: mounted filesystem with ordered data mode.
[   19.394275] udevd version 124 started
[   20.580672] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   20.681989] shpchp: Standard Hot Plug PCI Controller Driver version:=
 0.4
[   21.106567] Yenta: CardBus bridge found at 0000:00:0a.0 [10cf:10e7]
[   21.106595] Yenta O2: res at 0x94/0xD4: 00/ea
[   21.106598] Yenta O2: enabling read prefetch/write burst
[   21.195292] irda_init()
[   21.195325] NET: Registered protocol family 23
[   21.232766] Yenta: ISA IRQ mask 0x0098, PCI irq 11
[   21.232774] Socket status: 30000821
[   21.316954] Linux agpgart interface v0.103
[   21.385067] input: Power Button (FF) as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   21.396102] ACPI: Power Button (FF) [PWRF]
[   21.396280] input: Lid Switch as
/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input4
[   21.396419] ACPI: Lid Switch [LID]
[   21.396495] input: Power Button (CM) as
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input5
[   21.408177] ACPI: Power Button (CM) [PBTN]
[   21.448524] input: PC Speaker as /devices/platform/pcspkr/input/inpu=
t6
[   21.621059] agpgart: Detected VIA Apollo Pro266 chipset
[   21.646082] agpgart-via 0000:00:00.0: AGP aperture is 128M @ 0xb0000=
000
[   21.888071] pccard: CardBus card inserted into slot 0
[   21.888134] PCI: 0000:02:00.0 reg 10 32bit mmio: [d0000000, d000ffff=
]
[   21.888144] PCI: 0000:02:00.0 reg 14 32bit mmio: [c0000000, c000ffff=
]
[   21.936424] ACPI: I/O resource vt596_smbus [0x1400-0x1407] conflicts=
 with
ACPI region SMB_ [0x1400-0x1407]
[   21.936431] ACPI: Device needs an ACPI driver
[   22.721604] input: PS/2 Mouse as /devices/platform/i8042/serio4/inpu=
t/input7
[   22.759726] input: AlpsPS/2 ALPS GlidePoint as
/devices/platform/i8042/serio4/input/input8
[   22.836249] ACPI: AC Adapter [ADP0] (on-line)
[   22.905068] input: Video Bus as
/devices/LNXSYSTM:00/device:00/PNP0A03:00/device:01/device:02/input/inp=
ut9
[   22.916132] ACPI: Video Device [VGA0] (multi-head: yes  rom: no  pos=
t: no)
[   23.337032] ACPI: Battery Slot [BAT0] (battery present)
[   23.987948] parport_pc 00:0a: reported by Plug and Play ACPI
[   23.988074] parport0: PC-style at 0x378, irq 7 [PCSPP]
[   24.030619] VIA 82xx Modem 0000:00:11.6: PCI INT C -> Link[LNKC] -> =
GSI 5
(level, low) -> IRQ 5
[   24.612446] ACPI: WMI: Mapper loaded
[   24.715144] acer-wmi: Acer Laptop ACPI-WMI Extras
[   24.715166] acer-wmi: No or unsupported WMI interface, unable to loa=
d
[   24.780126] VIA 82xx Modem 0000:00:11.6: setting latency timer to 64
[   25.388208] MC'97 0 converters and GPIO not ready (0x1)
[   25.389814] VIA 82xx Audio 0000:00:11.5: PCI INT C -> Link[LNKC] -> =
GSI 5
(level, low) -> IRQ 5
[   25.389973] VIA 82xx Audio 0000:00:11.5: setting latency timer to 64
[   27.661012] ndiswrapper version 1.53 loaded (smp=3Dyes, preempt=3Dno=
)
[   27.665618] cs: IO port probe 0x100-0x3af: clean.
[   27.667323] cs: IO port probe 0x3e0-0x4ff: clean.
[   27.668086] cs: IO port probe 0x820-0x8ff: clean.
[   27.668707] cs: IO port probe 0xc00-0xcf7: clean.
[   27.669531] cs: IO port probe 0xa00-0xaff: clean.
[   27.821691] ndiswrapper: driver wg511v2 (NETGEAR,09/17/2004,3.1.0.19=
) loaded
[   27.822181] ndiswrapper 0000:02:00.0: enabling device (0000 -> 0002)
[   27.822203] ndiswrapper 0000:02:00.0: PCI INT A -> Link[LNKD] -> GSI=
 11
(level, low) -> IRQ 11
[   27.822229] ndiswrapper 0000:02:00.0: setting latency timer to 64
[   27.825015] ndiswrapper: using IRQ 11
[   28.092744] wlan0: ethernet device 00:0f:b5:4c:1f:62 using NDIS driv=
er:
wg511v2, version: 0x3000027, NDIS version: 0x501, vendor: 'NDIS Network
Adapter', 11AB:1FAA.5.conf
[   28.092771] ndiswrapper (set_iw_encr_mode:708): setting encryption m=
ode to 6
failed (C00000BB)
[   28.092782] wlan0: encryption modes supported: WEP; TKIP with WPA
[   28.092918] usbcore: registered new interface driver ndiswrapper
[   29.256931] lp0: using parport0 (interrupt-driven).
[   29.545417] Adding 289160k swap on /dev/sda2.  Priority:-1 extents:1
across:289160k
[   30.132896] EXT3 FS on sda3, internal journal
[   48.458207] kjournald starting.  Commit interval 5 seconds
[   48.458839] EXT3 FS on sda4, internal journal
[   48.458849] EXT3-fs: mounted filesystem with ordered data mode.
[   48.901704] type=3D1505 audit(1229508790.814:2): operation=3D"profil=
e_load"
name=3D"/usr/share/gdm/guest-session/Xsession" name2=3D"default" pid=3D=
4280
[   49.253073] type=3D1505 audit(1229508791.166:3): operation=3D"profil=
e_load"
name=3D"/usr/lib/cups/backend/cups-pdf" name2=3D"default" pid=3D4285
[   49.253829] type=3D1505 audit(1229508791.166:4): operation=3D"profil=
e_load"
name=3D"/usr/sbin/cupsd" name2=3D"default" pid=3D4285
[   49.386698] type=3D1505 audit(1229508791.298:5): operation=3D"profil=
e_load"
name=3D"/usr/sbin/mysqld" name2=3D"default" pid=3D4289
[   49.539635] ip_tables: (C) 2000-2006 Netfilter Core Team
[   52.924075] NET: Registered protocol family 17
[   55.220830] powernow: PowerNOW! Technology present. Can scale: frequ=
ency and
voltage.
[   55.226873] powernow: SGTC: 13333
[   55.226877] powernow: Minimum speed 663 MHz. Maximum speed 1658 MHz.
[   56.336965] warning: `avahi-daemon' uses 32-bit capabilities (legacy=
 support
in use)
[   60.691280] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[   60.691294] apm: overridden by ACPI.
[   60.911163] ppdev: user-space parallel port driver
[   62.656728] NET: Registered protocol family 10
[   62.660409] lo: Disabled Privacy Extensions
[   63.508114] Clocksource tsc unstable (delta =3D -94595805 ns)
[   64.754946] Bluetooth: Core ver 2.13
[   64.756106] NET: Registered protocol family 31
[   64.756112] Bluetooth: HCI device and connection manager initialized
[   64.756121] Bluetooth: HCI socket layer initialized
[   64.783223] Bluetooth: L2CAP ver 2.11
[   64.783235] Bluetooth: L2CAP socket layer initialized
[   64.802362] Bluetooth: SCO (Voice Link) ver 0.6
[   64.802375] Bluetooth: SCO socket layer initialized
[   64.821996] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   64.822011] Bluetooth: BNEP filters: protocol multicast
[   64.868494] Bridge firewalling registered
[   64.870235] pan0: Dropping NETIF_F_UFO since no NETIF_F_HW_CSUM feat=
ure.
[   64.890919] Bluetooth: RFCOMM socket layer initialized
[   64.893107] Bluetooth: RFCOMM TTY layer initialized
[   64.893123] Bluetooth: RFCOMM ver 1.10
[   66.741395] mtrr: base(0xaa000000) is not aligned on a size(0x500000=
0)
boundary
[   68.403895] [drm] Initialized drm 1.1.0 20060810
[   68.445442] pci 0000:01:00.0: PCI INT A -> Link[LNKA] -> GSI 11 (lev=
el, low)
-> IRQ 11
[   68.447260] [drm] Initialized savage 2.4.1 20050313 on minor 0
[   68.449084] mtrr: base(0xaa000000) is not aligned on a size(0x500000=
0)
boundary
[   68.449789] agpgart-via 0000:00:00.0: AGP 2.0 bridge
[   68.449816] agpgart-via 0000:00:00.0: putting AGP V2 device into 0x =
mode
[   68.449880] pci 0000:01:00.0: putting AGP V2 device into 0x mode
[   69.109687] eth0: link down
[   69.111754] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   73.252058] wlan0: no IPv6 routers present
[  194.466688] ppdev0: registered pardevice
[  194.516120] ppdev0: unregistered pardevice
00:00.0 Host bridge: VIA Technologies, Inc. P/KN266 Host Bridge
        Subsystem: VIA Technologies, Inc. P/KN266 Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort+ >SERR- <PERR+ INTx-
        Latency: 8
        Region 0: Memory at b0000000 (32-bit, prefetchable) [size=3D128=
M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GAR=
T64- HTrans-
64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64b=
it- FW-
Rate=3D<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Kernel driver in use: agpgart-via
        Kernel modules: via-agp

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort+ >SERR- <PERR+ INTx-
        Latency: 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latenc=
y=3D0
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: e0000000-efffffff
        Prefetchable memory behind bridge: a0000000-afffffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort+ <SERR- <PERR+
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Kernel modules: shpchp

00:0a.0 CardBus bridge: O2 Micro, Inc. OZ601/6912/711E0 CardBus/SmartCa=
rdBus
Controller
        Subsystem: Fujitsu Limited. Device 10e7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping+ SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort=
- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 168
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 28000000 (32-bit, non-prefetchable) [size=3D=
4K]
        Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latenc=
y=3D176
        Memory window 0: 20000000-23fff000 (prefetchable)
        Memory window 1: 24000000-27fff000
        I/O window 0: 00001800-000018ff
        I/O window 1: 00001c00-00001cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- Post=
Write+
        16-bit legacy interface ports at 0001
        Kernel driver in use: yenta_cardbus
        Kernel modules: yenta_socket

00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-20=
00
Controller (PHY/Link) (prog-if 10)
        Subsystem: Fujitsu Limited. Device 1162
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 128 (500ns min, 1000ns max), Cache Line Size: 16 bytes
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=3D=
2K]
        Region 1: Memory at f0004000 (32-bit, non-prefetchable) [size=3D=
16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME+
        Kernel driver in use: ohci1394
        Kernel modules: ohci1394

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contro=
ller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 22
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at 1200 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contro=
ller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 22
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1300 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-i=
f 20)
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=3D=
256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Kernel driver in use: ehci_hcd
        Kernel modules: ehci-hcd

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- Par=
Err-
Stepping+ SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Kernel modules: i2c-viapro, via-ircc

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-=
if 8a
[Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT82=
3x/A/C
PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Interrupt: pin A routed to IRQ 0
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchabl=
e)
[size=3D8]
        Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchabl=
e)
[size=3D1]
        Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchabl=
e)
[size=3D8]
        Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchabl=
e)
[size=3D1]
        Region 4: I/O ports at 1100 [size=3D16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Kernel driver in use: pata_via
        Kernel modules: pata_via

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/82=
35/8237
AC97 Audio Controller (rev 50)
        Subsystem: Acer Incorporated [ALI] Device 0030
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at e000 [size=3D256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Kernel driver in use: VIA 82xx Audio
        Kernel modules: snd-via82xx

00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Co=
ntroller
(rev 80)
        Subsystem: Acer Incorporated [ALI] Device 0030
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at e100 [size=3D256]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Kernel driver in use: VIA 82xx Modem
        Kernel modules: snd-via82xx-modem

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (=
rev 74)
        Subsystem: Acer Incorporated [ALI] Device 0030
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping+ SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 128 (750ns min, 2000ns max), Cache Line Size: 16 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e200 [size=3D256]
        Region 1: Memory at f0008000 (32-bit, non-prefetchable) [size=3D=
256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Kernel driver in use: via-rhine
        Kernel modules: via-rhine

01:00.0 VGA compatible controller: S3 Inc. VT8375 [ProSavage8 KM266/KL2=
66]
        Subsystem: Acer Incorporated [ALI] Device 0030
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 128 (1000ns min, 63750ns max), Cache Line Size: 16 byt=
es
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0080000 (32-bit, non-prefetchable) [size=3D=
512K]
        Region 1: Memory at a8000000 (32-bit, prefetchable) [size=3D128=
M]
        Expansion ROM at a0000000 [disabled] [size=3D64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [80] AGP version 2.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA- ITACoh- GAR=
T64- HTrans-
64bit- FW- AGP3- Rate=3Dx4
                Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64=
bit- FW-
Rate=3Dx4
        Kernel modules: savagefb

02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88w8335 [Lib=
ertas]
802.11b/g Wireless (rev 03)
        Subsystem: Netgear Device 4e00
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 24000000 (32-bit, non-prefetchable) [size=3D=
64K]
        Region 1: Memory at 24010000 (32-bit, non-prefetchable) [size=3D=
64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Kernel driver in use: ndiswrapper


--=20
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
