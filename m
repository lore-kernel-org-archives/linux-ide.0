From: Pedro R <eusou15@yahoo.com>
Subject: Re: PROBLEM: When hibernating or resuming, ide driver locks the computer with 100% cpu utilization (2.6.28.7)
Date: Fri, 27 Mar 2009 09:59:22 -0700 (PDT)
Message-ID: <901185.63858.qm@web32106.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web32106.mail.mud.yahoo.com ([68.142.207.120]:46511 "HELO
	web32106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753213AbZC0Q7Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Mar 2009 12:59:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org


Sorry for not being more specific, this is quite a hard bug to catch. I=
've been chasing it for a few months now,=20
I first thought it was a TuxOnIce bug, then a framebuffer bug, but now =
i'm pretty sure it's the ide driver.

Anyway, here is how to reproduce it:

0 - Boot the computer (i.e. without any resume)
1 - inside GNOME, insert a CD / DVD in the drive. Wait for it to be aut=
o mounted.
2 - Hibernate the computer. Hibernation performs sucessfully.
3 - Turn on the computer, and resume. Resume performs sucessfully.
4 - Once back in GNOME, remove the CD / DVD. It umounts, but then GNOME=
 displays an error of the like
"Cannot unmount the CD", however it is already umounted!
5 - Start the hibernation process. CPU jumps immediately to 100%, displ=
aying infinetely the message:

 ide: status error =3D 0x04 {DriveReady SeekComplete DataRequest Error}
 hdc: failed opcode =3D 0x059

=20
=20
 Here is the dmesg output of the process indicated above - BUT the 2 li=
nes above don't appear on it!
 After this, the computer must be shut down by holding the power button=
 3 seconds.
=20
Mar 27 16:35:23 portatel kernel: klogd 1.5.0#5, log source =3D /proc/km=
sg started.
Mar 27 16:35:23 portatel kernel: [    0.000000] BIOS EBDA/lowmem at: 00=
09fc00/0009fc00
Mar 27 16:35:23 portatel kernel: [    0.000000] Initializing cgroup sub=
sys cpu
Mar 27 16:35:23 portatel kernel: [    0.000000] Linux version 2.6.28.7 =
(root@portatel) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #1 PREEMPT Fri =
Mar 20 13:53:19 WET 2009
Mar 27 16:35:23 portatel kernel: [    0.000000] KERNEL supported cpus:
Mar 27 16:35:23 portatel kernel: [    0.000000]   Intel GenuineIntel
Mar 27 16:35:23 portatel kernel: [    0.000000]   AMD AuthenticAMD
Mar 27 16:35:23 portatel kernel: [    0.000000]   NSC Geode by NSC
Mar 27 16:35:23 portatel kernel: [    0.000000]   Cyrix CyrixInstead
Mar 27 16:35:23 portatel kernel: [    0.000000]   Centaur CentaurHauls
Mar 27 16:35:23 portatel kernel: [    0.000000]   Transmeta GenuineTMx8=
6
Mar 27 16:35:23 portatel kernel: [    0.000000]   Transmeta TransmetaCP=
U
Mar 27 16:35:23 portatel kernel: [    0.000000]   UMC UMC UMC UMC
Mar 27 16:35:23 portatel kernel: [    0.000000] BIOS-provided physical =
RAM map:
Mar 27 16:35:23 portatel kernel: [    0.000000]  BIOS-e820: 00000000000=
00000 - 000000000009fc00 (usable)
Mar 27 16:35:23 portatel kernel: [    0.000000]  BIOS-e820: 00000000000=
9fc00 - 00000000000a0000 (reserved)
Mar 27 16:35:23 portatel kernel: [    0.000000]  BIOS-e820: 00000000000=
e0000 - 0000000000100000 (reserved)
Mar 27 16:35:23 portatel kernel: [    0.000000]  BIOS-e820: 00000000001=
00000 - 000000007fff0000 (usable)
Mar 27 16:35:23 portatel kernel: [    0.000000]  BIOS-e820: 000000007ff=
f0000 - 000000007fffffc0 (ACPI data)
Mar 27 16:35:23 portatel kernel: [    0.000000]  BIOS-e820: 000000007ff=
fffc0 - 0000000080000000 (ACPI NVS)
Mar 27 16:35:23 portatel kernel: [    0.000000]  BIOS-e820: 00000000ffb=
80000 - 00000000ffc00000 (reserved)
Mar 27 16:35:23 portatel kernel: [    0.000000]  BIOS-e820: 00000000fff=
80000 - 0000000100000000 (reserved)
Mar 27 16:35:23 portatel kernel: [    0.000000] DMI 2.3 present.
Mar 27 16:35:23 portatel kernel: [    0.000000] last_pfn =3D 0x7fff0 ma=
x_arch_pfn =3D 0x100000
Mar 27 16:35:23 portatel kernel: [    0.000000] kernel direct mapping t=
ables up to 377fe000 @ 7000-d000
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: RSDP 000E6010, 00=
14 (r0 OID_00)
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: RSDT 7FFFACE0, 00=
38 (r1 INSYDE RSDT_000        1 _CSI    10101)
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: FACP 7FFFFAA0, 00=
74 (r1 ACER   DFL322        100 _CSI    10101)
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: DSDT 7FFFB160, 49=
3D (r1 ACER   TM290           6 MSFT  100000E)
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: FACS 7FFFFFC0, 00=
40
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: BOOT 7FFFFB90, 00=
28 (r1 INSYDE BOOT_000        1 _CSI    10101)
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: DBGP 7FFFFBC0, 00=
34 (r1 INSYDE DBGP_000        1 _CSI    10101)
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: APIC 7FFFFB30, 00=
5A (r1 INSYDE APIC_000 30303030 0000 30303030)
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: SSDT 7FFFAD20, 01=
92 (r1 INSYDE   GV3Ref     2000 INTL 20021002)
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: Local APIC addres=
s 0xfee00000
Mar 27 16:35:23 portatel kernel: [    0.000000] 1159MB HIGHMEM availabl=
e.
Mar 27 16:35:23 portatel kernel: [    0.000000] 887MB LOWMEM available.
Mar 27 16:35:23 portatel kernel: [    0.000000]   mapped low ram: 0 - 3=
77fe000
Mar 27 16:35:23 portatel kernel: [    0.000000]   low ram: 00000000 - 3=
77fe000
Mar 27 16:35:23 portatel kernel: [    0.000000]   bootmap 00009000 - 00=
00ff00
Mar 27 16:35:23 portatel kernel: [    0.000000] (6 early reservations) =
=3D=3D> bootmem [0000000000 - 00377fe000]
Mar 27 16:35:23 portatel kernel: [    0.000000]   #0 [0000000000 - 0000=
001000]   BIOS data page =3D=3D> [0000000000 - 0000001000]
Mar 27 16:35:23 portatel kernel: [    0.000000]   #1 [0000100000 - 0000=
69cc14]    TEXT DATA BSS =3D=3D> [0000100000 - 000069cc14]
Mar 27 16:35:23 portatel kernel: [    0.000000]   #2 [000069d000 - 0000=
6a0000]    INIT_PG_TABLE =3D=3D> [000069d000 - 00006a0000]
Mar 27 16:35:23 portatel kernel: [    0.000000]   #3 [000009fc00 - 0000=
100000]    BIOS reserved =3D=3D> [000009fc00 - 0000100000]
Mar 27 16:35:23 portatel kernel: [    0.000000]   #4 [0000007000 - 0000=
009000]          PGTABLE =3D=3D> [0000007000 - 0000009000]
Mar 27 16:35:23 portatel kernel: [    0.000000]   #5 [0000009000 - 0000=
010000]          BOOTMAP =3D=3D> [0000009000 - 0000010000]
Mar 27 16:35:23 portatel kernel: [    0.000000] Zone PFN ranges:
Mar 27 16:35:23 portatel kernel: [    0.000000]   DMA      0x00000000 -=
> 0x00001000
Mar 27 16:35:23 portatel kernel: [    0.000000]   Normal   0x00001000 -=
> 0x000377fe
Mar 27 16:35:23 portatel kernel: [    0.000000]   HighMem  0x000377fe -=
> 0x0007fff0
Mar 27 16:35:23 portatel kernel: [    0.000000] Movable zone start PFN =
for each node
Mar 27 16:35:23 portatel kernel: [    0.000000] early_node_map[2] activ=
e PFN ranges
Mar 27 16:35:23 portatel kernel: [    0.000000]     0: 0x00000000 -> 0x=
0000009f
Mar 27 16:35:23 portatel kernel: [    0.000000]     0: 0x00000100 -> 0x=
0007fff0
Mar 27 16:35:23 portatel kernel: [    0.000000] On node 0 totalpages: 5=
24175
Mar 27 16:35:23 portatel kernel: [    0.000000] free_area_init_node: no=
de 0, pgdat c05bd2b8, node_mem_map c1000000
Mar 27 16:35:23 portatel kernel: [    0.000000]   DMA zone: 32 pages us=
ed for memmap
Mar 27 16:35:23 portatel kernel: [    0.000000]   DMA zone: 0 pages res=
erved
Mar 27 16:35:23 portatel kernel: [    0.000000]   DMA zone: 3967 pages,=
 LIFO batch:0
Mar 27 16:35:23 portatel kernel: [    0.000000]   Normal zone: 1744 pag=
es used for memmap
Mar 27 16:35:23 portatel kernel: [    0.000000]   Normal zone: 221486 p=
ages, LIFO batch:31
Mar 27 16:35:23 portatel kernel: [    0.000000]   HighMem zone: 2320 pa=
ges used for memmap
Mar 27 16:35:23 portatel kernel: [    0.000000]   HighMem zone: 294626 =
pages, LIFO batch:31
Mar 27 16:35:23 portatel kernel: [    0.000000]   Movable zone: 0 pages=
 used for memmap
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: PM-Timer IO Port:=
 0x1008
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: Local APIC addres=
s 0xfee00000
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x=
00] lapic_id[0x00] enabled)
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_i=
d[0x00] high edge lint[0x1])
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: IOAPIC (id[0x01] =
address[0xfec00000] gsi_base[0])
Mar 27 16:35:23 portatel kernel: [    0.000000] IOAPIC[0]: apic_id 1, v=
ersion 32, address 0xfec00000, GSI 0-23
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: INT_SRC_OVR (bus =
0 bus_irq 0 global_irq 2 dfl dfl)
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: INT_SRC_OVR (bus =
0 bus_irq 9 global_irq 9 high level)
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: IRQ0 used by over=
ride.
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: IRQ2 used by over=
ride.
Mar 27 16:35:23 portatel kernel: [    0.000000] ACPI: IRQ9 used by over=
ride.
Mar 27 16:35:23 portatel kernel: [    0.000000] Enabling APIC mode:  Fl=
at.  Using 1 I/O APICs
Mar 27 16:35:23 portatel kernel: [    0.000000] Using ACPI (MADT) for S=
MP configuration information
Mar 27 16:35:23 portatel kernel: [    0.000000] PM: Registered nosave m=
emory: 000000000009f000 - 00000000000a0000
Mar 27 16:35:23 portatel kernel: [    0.000000] PM: Registered nosave m=
emory: 00000000000a0000 - 00000000000e0000
Mar 27 16:35:23 portatel kernel: [    0.000000] PM: Registered nosave m=
emory: 00000000000e0000 - 0000000000100000
Mar 27 16:35:23 portatel kernel: [    0.000000] Allocating PCI resource=
s starting at 88000000 (gap: 80000000:7fb80000)
Mar 27 16:35:23 portatel kernel: [    0.000000] Built 1 zonelists in Zo=
ne order, mobility grouping on.  Total pages: 520079
Mar 27 16:35:23 portatel kernel: [    0.000000] Kernel command line: ro=
ot=3D/dev/hda6 ro no_console_suspend=20
Mar 27 16:35:23 portatel kernel: [    0.000000] Enabling fast FPU save =
and restore... done.
Mar 27 16:35:23 portatel kernel: [    0.000000] Enabling unmasked SIMD =
=46PU exception support... done.
Mar 27 16:35:23 portatel kernel: [    0.000000] Initializing CPU#0
Mar 27 16:35:23 portatel kernel: [    0.000000] PID hash table entries:=
 4096 (order: 12, 16384 bytes)
Mar 27 16:35:23 portatel kernel: [    0.000000] TSC: PIT calibration ma=
tches PMTIMER. 1 loops
Mar 27 16:35:23 portatel kernel: [    0.000000] Detected 1598.657 MHz p=
rocessor.
Mar 27 16:35:23 portatel kernel: [    0.000999] Console: colour VGA+ 80=
x25
Mar 27 16:35:23 portatel kernel: [    0.000999] console [tty0] enabled
Mar 27 16:35:23 portatel kernel: [    0.000999] Dentry cache hash table=
 entries: 131072 (order: 7, 524288 bytes)
Mar 27 16:35:23 portatel kernel: [    0.000999] Inode-cache hash table =
entries: 65536 (order: 6, 262144 bytes)
Mar 27 16:35:23 portatel kernel: [    0.000999] Memory: 2072776k/209708=
8k available (3527k kernel code, 22988k reserved, 1369k data, 416k init=
, 1187784k highmem)
Mar 27 16:35:23 portatel kernel: [    0.000999] virtual kernel memory l=
ayout:
Mar 27 16:35:23 portatel kernel: [    0.000999]     fixmap  : 0xfffab00=
0 - 0xfffff000   ( 336 kB)
Mar 27 16:35:23 portatel kernel: [    0.000999]     pkmap   : 0xff80000=
0 - 0xffc00000   (4096 kB)
Mar 27 16:35:23 portatel kernel: [    0.000999]     vmalloc : 0xf7ffe00=
0 - 0xff7fe000   ( 120 MB)
Mar 27 16:35:23 portatel kernel: [    0.000999]     lowmem  : 0xc000000=
0 - 0xf77fe000   ( 887 MB)
Mar 27 16:35:23 portatel kernel: [    0.000999]       .init : 0xc05cc00=
0 - 0xc0634000   ( 416 kB)
Mar 27 16:35:23 portatel kernel: [    0.000999]       .data : 0xc0471e1=
5 - 0xc05c8558   (1369 kB)
Mar 27 16:35:23 portatel kernel: [    0.000999]       .text : 0xc010000=
0 - 0xc0471e15   (3527 kB)
Mar 27 16:35:23 portatel kernel: [    0.000999] Checking if this proces=
sor honours the WP bit even in supervisor mode...Ok.
Mar 27 16:35:23 portatel kernel: [    0.001017] Calibrating delay loop =
(skipped), value calculated using timer frequency.. 3197.31 BogoMIPS (l=
pj=3D1598657)
Mar 27 16:35:23 portatel kernel: [    0.001154] Security Framework init=
ialized
Mar 27 16:35:23 portatel kernel: [    0.001206] SELinux:  Disabled at b=
oot.
Mar 27 16:35:23 portatel kernel: [    0.001265] Mount-cache hash table =
entries: 512
Mar 27 16:35:23 portatel kernel: [    0.001476] Initializing cgroup sub=
sys ns
Mar 27 16:35:23 portatel kernel: [    0.001525] Initializing cgroup sub=
sys cpuacct
Mar 27 16:35:23 portatel kernel: [    0.001571] Initializing cgroup sub=
sys devices
Mar 27 16:35:23 portatel kernel: [    0.001637] CPU: L1 I cache: 32K, L=
1 D cache: 32K
Mar 27 16:35:23 portatel kernel: [    0.001715] CPU: L2 cache: 2048K
Mar 27 16:35:23 portatel kernel: [    0.001759] Intel machine check arc=
hitecture supported.
Mar 27 16:35:23 portatel kernel: [    0.001808] Intel machine check rep=
orting enabled on CPU#0.
Mar 27 16:35:23 portatel kernel: [    0.001862] CPU: Intel(R) Pentium(R=
) M processor 1.60GHz stepping 06
Mar 27 16:35:23 portatel kernel: [    0.002007] Checking 'hlt' instruct=
ion... OK.
Mar 27 16:35:23 portatel kernel: [    0.008872] Freeing SMP alternative=
s: 0k freed
Mar 27 16:35:23 portatel kernel: [    0.008919] ACPI: Core revision 200=
80926
Mar 27 16:35:23 portatel kernel: [    0.017390] ..TIMER: vector=3D0x30 =
apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
Mar 27 16:35:23 portatel kernel: [    0.028995] net_namespace: 760 byte=
s
Mar 27 16:35:23 portatel kernel: [    0.028995] Booting paravirtualized=
 kernel on bare hardware
Mar 27 16:35:23 portatel kernel: [    0.028995] NET: Registered protoco=
l family 16
Mar 27 16:35:23 portatel kernel: [    0.028995] EISA bus registered
Mar 27 16:35:23 portatel kernel: [    0.029005] ACPI: bus type pci regi=
stered
Mar 27 16:35:23 portatel kernel: [    0.029207] PCI: PCI BIOS revision =
2.10 entry at 0xe97e4, last bus=3D2
Mar 27 16:35:23 portatel kernel: [    0.029256] PCI: Using configuratio=
n type 1 for base access
Mar 27 16:35:23 portatel kernel: [    0.033986] ACPI: EC: Look up EC in=
 DSDT
Mar 27 16:35:23 portatel kernel: [    0.038030] ACPI: Interpreter enabl=
ed
Mar 27 16:35:23 portatel kernel: [    0.038077] ACPI: (supports S0 S4 S=
5)
Mar 27 16:35:23 portatel kernel: [    0.038221] ACPI: Using IOAPIC for =
interrupt routing
Mar 27 16:35:23 portatel kernel: [    0.083096] ACPI: EC: GPE =3D 0x1c,=
 I/O: command/status =3D 0x66, data =3D 0x62
Mar 27 16:35:23 portatel kernel: [    0.083146] ACPI: EC: driver starte=
d in poll mode
Mar 27 16:35:23 portatel kernel: [    0.083553] ACPI: ACPI Dock Station=
 Driver: 1 docks/bays found
Mar 27 16:35:23 portatel kernel: [    0.083609] ACPI: PCI Root Bridge [=
PCI0] (0000:00)
Mar 27 16:35:23 portatel kernel: [    0.083715] pci 0000:00:00.0: reg 1=
0 32bit mmio: [0xb0000000-0xbfffffff]
Mar 27 16:35:23 portatel kernel: [    0.083856] pci 0000:00:1d.0: reg 2=
0 io port: [0x1200-0x121f]
Mar 27 16:35:23 portatel kernel: [    0.083901] pci 0000:00:1d.1: reg 2=
0 io port: [0x1600-0x161f]
Mar 27 16:35:23 portatel kernel: [    0.083944] pci 0000:00:1d.2: reg 2=
0 io port: [0x1700-0x171f]
Mar 27 16:35:23 portatel kernel: [    0.083998] pci 0000:00:1d.7: reg 1=
0 32bit mmio: [0xf0000000-0xf00003ff]
Mar 27 16:35:23 portatel kernel: [    0.084036] pci 0000:00:1d.7: PME# =
supported from D0 D3hot D3cold
Mar 27 16:35:23 portatel kernel: [    0.084087] pci 0000:00:1d.7: PME# =
disabled
Mar 27 16:35:23 portatel kernel: [    0.084199] HPET not enabled in BIO=
S. You might try hpet=3Dforce boot option
Mar 27 16:35:23 portatel kernel: [    0.084252] pci 0000:00:1f.0: quirk=
: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
Mar 27 16:35:23 portatel kernel: [    0.084310] pci 0000:00:1f.0: quirk=
: region 1300-133f claimed by ICH4 GPIO
Mar 27 16:35:23 portatel kernel: [    0.084374] pci 0000:00:1f.1: reg 1=
0 io port: [0x00-0x07]
Mar 27 16:35:23 portatel kernel: [    0.084381] pci 0000:00:1f.1: reg 1=
4 io port: [0x00-0x03]
Mar 27 16:35:23 portatel kernel: [    0.084387] pci 0000:00:1f.1: reg 1=
8 io port: [0x00-0x07]
Mar 27 16:35:23 portatel kernel: [    0.084393] pci 0000:00:1f.1: reg 1=
c io port: [0x00-0x03]
Mar 27 16:35:23 portatel kernel: [    0.084400] pci 0000:00:1f.1: reg 2=
0 io port: [0x1100-0x110f]
Mar 27 16:35:23 portatel kernel: [    0.084406] pci 0000:00:1f.1: reg 2=
4 32bit mmio: [0x000000-0x0003ff]
Mar 27 16:35:23 portatel kernel: [    0.084448] pci 0000:00:1f.3: reg 2=
0 io port: [0x1400-0x141f]
Mar 27 16:35:23 portatel kernel: [    0.084483] pci 0000:00:1f.5: reg 1=
0 io port: [0xe000-0xe0ff]
Mar 27 16:35:23 portatel kernel: [    0.084489] pci 0000:00:1f.5: reg 1=
4 io port: [0xe100-0xe13f]
Mar 27 16:35:23 portatel kernel: [    0.084495] pci 0000:00:1f.5: reg 1=
8 32bit mmio: [0xf0000400-0xf00005ff]
Mar 27 16:35:23 portatel kernel: [    0.084501] pci 0000:00:1f.5: reg 1=
c 32bit mmio: [0xf0000600-0xf00006ff]
Mar 27 16:35:23 portatel kernel: [    0.084520] pci 0000:00:1f.5: PME# =
supported from D0 D3hot D3cold
Mar 27 16:35:23 portatel kernel: [    0.084569] pci 0000:00:1f.5: PME# =
disabled
Mar 27 16:35:23 portatel kernel: [    0.084637] pci 0000:00:1f.6: reg 1=
0 io port: [0xe200-0xe2ff]
Mar 27 16:35:23 portatel kernel: [    0.084643] pci 0000:00:1f.6: reg 1=
4 io port: [0xe300-0xe37f]
Mar 27 16:35:23 portatel kernel: [    0.084669] pci 0000:00:1f.6: PME# =
supported from D0 D3hot D3cold
Mar 27 16:35:23 portatel kernel: [    0.084718] pci 0000:00:1f.6: PME# =
disabled
Mar 27 16:35:23 portatel kernel: [    0.084791] pci 0000:01:00.0: reg 1=
0 32bit mmio: [0xa8000000-0xafffffff]
Mar 27 16:35:23 portatel kernel: [    0.084797] pci 0000:01:00.0: reg 1=
4 io port: [0xc100-0xc1ff]
Mar 27 16:35:23 portatel kernel: [    0.084802] pci 0000:01:00.0: reg 1=
8 32bit mmio: [0xe0010000-0xe001ffff]
Mar 27 16:35:23 portatel kernel: [    0.084816] pci 0000:01:00.0: reg 3=
0 32bit mmio: [0x000000-0x01ffff]
Mar 27 16:35:23 portatel kernel: [    0.084824] pci 0000:01:00.0: suppo=
rts D1 D2
Mar 27 16:35:23 portatel kernel: [    0.084854] pci 0000:00:01.0: bridg=
e io port: [0xc000-0xdfff]
Mar 27 16:35:23 portatel kernel: [    0.084857] pci 0000:00:01.0: bridg=
e 32bit mmio: [0xe0000000-0xefffffff]
Mar 27 16:35:23 portatel kernel: [    0.084861] pci 0000:00:01.0: bridg=
e 32bit mmio pref: [0xa0000000-0xafffffff]
Mar 27 16:35:23 portatel kernel: [    0.084890] pci 0000:02:00.0: reg 1=
0 32bit mmio: [0xd0020000-0xd00207ff]
Mar 27 16:35:23 portatel kernel: [    0.084896] pci 0000:02:00.0: reg 1=
4 32bit mmio: [0xd0024000-0xd0027fff]
Mar 27 16:35:23 portatel kernel: [    0.084924] pci 0000:02:00.0: suppo=
rts D1 D2
Mar 27 16:35:23 portatel kernel: [    0.084926] pci 0000:02:00.0: PME# =
supported from D0 D1 D2 D3hot
Mar 27 16:35:23 portatel kernel: [    0.084975] pci 0000:02:00.0: PME# =
disabled
Mar 27 16:35:23 portatel kernel: [    0.085030] pci 0000:02:01.0: reg 1=
0 32bit mmio: [0xd0010000-0xd001ffff]
Mar 27 16:35:23 portatel kernel: [    0.085064] pci 0000:02:01.0: PME# =
supported from D3hot D3cold
Mar 27 16:35:23 portatel kernel: [    0.085113] pci 0000:02:01.0: PME# =
disabled
Mar 27 16:35:23 portatel kernel: [    0.085185] pci 0000:02:02.0: reg 1=
0 32bit mmio: [0xd0000000-0xd0000fff]
Mar 27 16:35:23 portatel kernel: [    0.085217] pci 0000:02:02.0: PME# =
supported from D0 D3hot D3cold
Mar 27 16:35:23 portatel kernel: [    0.085266] pci 0000:02:02.0: PME# =
disabled
Mar 27 16:35:23 portatel kernel: [    0.085336] pci 0000:02:04.0: reg 1=
0 32bit mmio: [0x000000-0x000fff]
Mar 27 16:35:23 portatel kernel: [    0.085345] pci 0000:02:04.0: suppo=
rts D1 D2
Mar 27 16:35:23 portatel kernel: [    0.085347] pci 0000:02:04.0: PME# =
supported from D0 D1 D2 D3hot D3cold
Mar 27 16:35:23 portatel kernel: [    0.085397] pci 0000:02:04.0: PME# =
disabled
Mar 27 16:35:23 portatel kernel: [    0.085469] pci 0000:00:1e.0: trans=
parent bridge
Mar 27 16:35:23 portatel kernel: [    0.085517] pci 0000:00:1e.0: bridg=
e io port: [0xa000-0xbfff]
Mar 27 16:35:23 portatel kernel: [    0.085521] pci 0000:00:1e.0: bridg=
e 32bit mmio: [0xd0000000-0xdfffffff]
Mar 27 16:35:23 portatel kernel: [    0.085526] pci 0000:00:1e.0: bridg=
e 32bit mmio pref: [0x90000000-0x9fffffff]
Mar 27 16:35:23 portatel kernel: [    0.085549] bus 00 -> node 0
Mar 27 16:35:23 portatel kernel: [    0.085555] ACPI: PCI Interrupt Rou=
ting Table [\_SB_.PCI0._PRT]
Mar 27 16:35:23 portatel kernel: [    0.085760] ACPI: PCI Interrupt Rou=
ting Table [\_SB_.PCI0.AGPB._PRT]
Mar 27 16:35:23 portatel kernel: [    0.085867] ACPI: PCI Interrupt Rou=
ting Table [\_SB_.PCI0.HUB_._PRT]
Mar 27 16:35:23 portatel kernel: [    0.091947] ACPI: PCI Interrupt Lin=
k [LNKA] (IRQs 10) *11
Mar 27 16:35:23 portatel kernel: [    0.092229] ACPI: PCI Interrupt Lin=
k [LNKB] (IRQs 10) *5
Mar 27 16:35:23 portatel kernel: [    0.092499] ACPI: PCI Interrupt Lin=
k [LNKC] (IRQs 10) *0, disabled.
Mar 27 16:35:23 portatel kernel: [    0.092802] ACPI: PCI Interrupt Lin=
k [LNKD] (IRQs 10) *0, disabled.
Mar 27 16:35:23 portatel kernel: [    0.093096] ACPI: PCI Interrupt Lin=
k [LNKE] (IRQs 10) *11
Mar 27 16:35:23 portatel kernel: [    0.093372] ACPI: PCI Interrupt Lin=
k [LNKF] (IRQs 10) *11
Mar 27 16:35:23 portatel kernel: [    0.093649] ACPI: PCI Interrupt Lin=
k [LNKG] (IRQs 10) *11
Mar 27 16:35:23 portatel kernel: [    0.093924] ACPI: PCI Interrupt Lin=
k [LNKH] (IRQs *10)
Mar 27 16:35:23 portatel kernel: [    0.094558] SCSI subsystem initiali=
zed
Mar 27 16:35:23 portatel kernel: [    0.094627] libata version 3.00 loa=
ded.
Mar 27 16:35:23 portatel kernel: [    0.094753] usbcore: registered new=
 interface driver usbfs
Mar 27 16:35:23 portatel kernel: [    0.094858] usbcore: registered new=
 interface driver hub
Mar 27 16:35:23 portatel kernel: [    0.094945] usbcore: registered new=
 device driver usb
Mar 27 16:35:23 portatel kernel: [    0.095152] PCI: Using ACPI for IRQ=
 routing
Mar 27 16:35:23 portatel kernel: [    0.095302] Bluetooth: Core ver 2.1=
3
Mar 27 16:35:23 portatel kernel: [    0.095302] NET: Registered protoco=
l family 31
Mar 27 16:35:23 portatel kernel: [    0.095302] Bluetooth: HCI device a=
nd connection manager initialized
Mar 27 16:35:23 portatel kernel: [    0.095302] Bluetooth: HCI socket l=
ayer initialized
Mar 27 16:35:23 portatel kernel: [    0.095302] pnp: PnP ACPI init
Mar 27 16:35:23 portatel kernel: [    0.095302] ACPI: bus type pnp regi=
stered
Mar 27 16:35:23 portatel kernel: [    0.119074] pnp: PnP ACPI: found 9 =
devices
Mar 27 16:35:23 portatel kernel: [    0.119119] ACPI: ACPI bus type pnp=
 unregistered
Mar 27 16:35:23 portatel kernel: [    0.119165] PnPBIOS: Disabled by AC=
PI PNP
Mar 27 16:35:23 portatel kernel: [    0.119219] system 00:01: ioport ra=
nge 0x1000-0x107f has been reserved
Mar 27 16:35:23 portatel kernel: [    0.119268] system 00:01: ioport ra=
nge 0x1300-0x133f has been reserved
Mar 27 16:35:23 portatel kernel: [    0.119317] system 00:01: ioport ra=
nge 0x200-0x20f has been reserved
Mar 27 16:35:23 portatel kernel: [    0.119366] system 00:01: ioport ra=
nge 0x4d0-0x4d1 has been reserved
Mar 27 16:35:23 portatel kernel: [    0.119414] system 00:01: ioport ra=
nge 0xfe00-0xfe00 has been reserved
Mar 27 16:35:23 portatel kernel: [    0.119463] system 00:01: ioport ra=
nge 0xff2c-0xff2f has been reserved
Mar 27 16:35:23 portatel kernel: [    0.154511] pci 0000:00:01.0: PCI b=
ridge, secondary bus 0000:01
Mar 27 16:35:23 portatel kernel: [    0.154560] pci 0000:00:01.0:   IO =
window: 0xc000-0xdfff
Mar 27 16:35:23 portatel kernel: [    0.154609] pci 0000:00:01.0:   MEM=
 window: 0xe0000000-0xefffffff
Mar 27 16:35:23 portatel kernel: [    0.154659] pci 0000:00:01.0:   PRE=
=46ETCH window: 0x000000a0000000-0x000000afffffff
Mar 27 16:35:23 portatel kernel: [    0.154724] pci 0000:02:04.0: CardB=
us bridge, secondary bus 0000:03
Mar 27 16:35:23 portatel kernel: [    0.154772] pci 0000:02:04.0:   IO =
window: 0x00a000-0x00a0ff
Mar 27 16:35:23 portatel kernel: [    0.154822] pci 0000:02:04.0:   IO =
window: 0x00a400-0x00a4ff
Mar 27 16:35:23 portatel kernel: [    0.154871] pci 0000:02:04.0:   PRE=
=46ETCH window: 0x90000000-0x93ffffff
Mar 27 16:35:23 portatel kernel: [    0.154922] pci 0000:02:04.0:   MEM=
 window: 0xd4000000-0xd7ffffff
Mar 27 16:35:23 portatel kernel: [    0.155575] pci 0000:00:1e.0: PCI b=
ridge, secondary bus 0000:02
Mar 27 16:35:23 portatel kernel: [    0.155624] pci 0000:00:1e.0:   IO =
window: 0xa000-0xbfff
Mar 27 16:35:23 portatel kernel: [    0.155674] pci 0000:00:1e.0:   MEM=
 window: 0xd0000000-0xdfffffff
Mar 27 16:35:23 portatel kernel: [    0.155725] pci 0000:00:1e.0:   PRE=
=46ETCH window: 0x00000090000000-0x0000009fffffff
Mar 27 16:35:23 portatel kernel: [    0.155795] pci 0000:00:1e.0: setti=
ng latency timer to 64
Mar 27 16:35:23 portatel kernel: [    0.155806] pci 0000:02:04.0: PCI I=
NT A -> GSI 16 (level, low) -> IRQ 16
Mar 27 16:35:23 portatel kernel: [    0.155858] bus: 00 index 0 io port=
: [0x00-0xffff]
Mar 27 16:35:23 portatel kernel: [    0.155904] bus: 00 index 1 mmio: [=
0x000000-0xffffffff]
Mar 27 16:35:23 portatel kernel: [    0.155951] bus: 01 index 0 io port=
: [0xc000-0xdfff]
Mar 27 16:35:23 portatel kernel: [    0.156000] bus: 01 index 1 mmio: [=
0xe0000000-0xefffffff]
Mar 27 16:35:23 portatel kernel: [    0.156047] bus: 01 index 2 mmio: [=
0xa0000000-0xafffffff]
Mar 27 16:35:23 portatel kernel: [    0.156095] bus: 01 index 3 mmio: [=
0x0-0x0]
Mar 27 16:35:23 portatel kernel: [    0.156140] bus: 02 index 0 io port=
: [0xa000-0xbfff]
Mar 27 16:35:23 portatel kernel: [    0.156186] bus: 02 index 1 mmio: [=
0xd0000000-0xdfffffff]
Mar 27 16:35:23 portatel kernel: [    0.156234] bus: 02 index 2 mmio: [=
0x90000000-0x9fffffff]
Mar 27 16:35:23 portatel kernel: [    0.156281] bus: 02 index 3 io port=
: [0x00-0xffff]
Mar 27 16:35:23 portatel kernel: [    0.156327] bus: 02 index 4 mmio: [=
0x000000-0xffffffff]
Mar 27 16:35:23 portatel kernel: [    0.156374] bus: 03 index 0 io port=
: [0xa000-0xa0ff]
Mar 27 16:35:23 portatel kernel: [    0.156421] bus: 03 index 1 io port=
: [0xa400-0xa4ff]
Mar 27 16:35:23 portatel kernel: [    0.156467] bus: 03 index 2 mmio: [=
0x90000000-0x93ffffff]
Mar 27 16:35:23 portatel kernel: [    0.156514] bus: 03 index 3 mmio: [=
0xd4000000-0xd7ffffff]
Mar 27 16:35:23 portatel kernel: [    0.156583] NET: Registered protoco=
l family 2
Mar 27 16:35:23 portatel kernel: [    0.156746] IP route cache hash tab=
le entries: 32768 (order: 5, 131072 bytes)
Mar 27 16:35:23 portatel kernel: [    0.157084] TCP established hash ta=
ble entries: 131072 (order: 8, 1048576 bytes)
Mar 27 16:35:23 portatel kernel: [    0.158296] TCP bind hash table ent=
ries: 65536 (order: 6, 262144 bytes)
Mar 27 16:35:23 portatel kernel: [    0.158694] TCP: Hash tables config=
ured (established 131072 bind 65536)
Mar 27 16:35:23 portatel kernel: [    0.158744] TCP reno registered
Mar 27 16:35:23 portatel kernel: [    0.158936] NET: Registered protoco=
l family 1
Mar 27 16:35:23 portatel kernel: [    0.159151] Simple Boot Flag at 0x3=
7 set to 0x80
Mar 27 16:35:23 portatel kernel: [    0.159455] Microcode Update Driver=
: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
Mar 27 16:35:23 portatel kernel: [    0.159715] audit: initializing net=
link socket (disabled)
Mar 27 16:35:23 portatel kernel: [    0.159772] type=3D2000 audit(12381=
71704.158:1): initialized
Mar 27 16:35:23 portatel kernel: [    0.160019] highmem bounce pool siz=
e: 64 pages
Mar 27 16:35:23 portatel kernel: [    0.160069] HugeTLB registered 4 MB=
 page size, pre-allocated 0 pages
Mar 27 16:35:23 portatel kernel: [    0.160208] VFS: Disk quotas dquot_=
6.5.1
Mar 27 16:35:23 portatel kernel: [    0.160288] Dquot-cache hash table =
entries: 1024 (order 0, 4096 bytes)
Mar 27 16:35:23 portatel kernel: [    0.160428] fuse init (API version =
7.10)
Mar 27 16:35:23 portatel kernel: [    0.160539] SGI XFS with ACLs, secu=
rity attributes, realtime, large block numbers, no debug enabled
Mar 27 16:35:23 portatel kernel: [    0.160773] SGI XFS Quota Managemen=
t subsystem
Mar 27 16:35:23 portatel kernel: [    0.160827] msgmni has been set to =
1730
Mar 27 16:35:23 portatel kernel: [    0.161010] alg: No test for stdrng=
 (krng)
Mar 27 16:35:23 portatel kernel: [    0.161115] Block layer SCSI generi=
c (bsg) driver version 0.4 loaded (major 252)
Mar 27 16:35:23 portatel kernel: [    0.161173] io scheduler noop regis=
tered
Mar 27 16:35:23 portatel kernel: [    0.161217] io scheduler anticipato=
ry registered
Mar 27 16:35:23 portatel kernel: [    0.161263] io scheduler deadline r=
egistered
Mar 27 16:35:23 portatel kernel: [    0.161321] io scheduler cfq regist=
ered (default)
Mar 27 16:35:23 portatel kernel: [    0.161554] pci 0000:01:00.0: Boot =
video device
Mar 27 16:35:23 portatel kernel: [    0.205094] pci_hotplug: PCI Hot Pl=
ug PCI Core version: 0.5
Mar 27 16:35:23 portatel kernel: [    0.205206] shpchp: Standard Hot Pl=
ug PCI Controller Driver version: 0.4
Mar 27 16:35:23 portatel kernel: [    0.205312] radeonfb 0000:01:00.0: =
PCI INT A -> GSI 16 (level, low) -> IRQ 16
Mar 27 16:35:23 portatel kernel: [    0.205907] radeonfb: Retrieved PLL=
 infos from BIOS
Mar 27 16:35:23 portatel kernel: [    0.205958] radeonfb: Reference=3D2=
7.00 MHz (RefDiv=3D6) Memory=3D390.00 Mhz, System=3D200.00 MHz
Mar 27 16:35:23 portatel kernel: [    0.206016] radeonfb: PLL min 20000=
 max 35000
Mar 27 16:35:23 portatel kernel: [    0.206064] Non-DDC laptop panel de=
tected
Mar 27 16:35:23 portatel kernel: [    0.207114] radeonfb: Monitor 1 typ=
e LCD found
Mar 27 16:35:23 portatel kernel: [    0.207159] radeonfb: Monitor 2 typ=
e no found
Mar 27 16:35:23 portatel kernel: [    0.207204] radeonfb: panel ID stri=
ng: SEC                    =20
Mar 27 16:35:23 portatel kernel: [    0.207252] radeonfb: detected LVDS=
 panel size from BIOS: 1280x800
Mar 27 16:35:23 portatel kernel: [    0.207299] radeondb: BIOS provided=
 dividers will be used
Mar 27 16:35:23 portatel kernel: [    0.207373] radeonfb: Dynamic Clock=
 Power Management enabled
Mar 27 16:35:23 portatel kernel: [    0.207420] radeonfb: Acer Aspire 2=
010 detected, enabling workaround
Mar 27 16:35:23 portatel kernel: [    0.228118] Console: switching to c=
olour frame buffer device 160x50
Mar 27 16:35:23 portatel kernel: [    0.249627] radeonfb (0000:01:00.0)=
: ATI Radeon 4e50 "NP"
Mar 27 16:35:23 portatel kernel: [    0.249969] ACPI: AC Adapter [ACAD]=
 (off-line)
Mar 27 16:35:23 portatel kernel: [    0.270241] ACPI: Battery Slot [BAT=
1] (battery present)
Mar 27 16:35:23 portatel kernel: [    0.270452] input: Power Button (FF=
) as /class/input/input0
Mar 27 16:35:23 portatel kernel: [    0.270517] ACPI: Power Button (FF)=
 [PWRF]
Mar 27 16:35:23 portatel kernel: [    0.270638] input: Lid Switch as /c=
lass/input/input1
Mar 27 16:35:23 portatel kernel: [    0.270743] ACPI: Lid Switch [LID]
Mar 27 16:35:23 portatel kernel: [    0.270861] input: Power Button (CM=
) as /class/input/input2
Mar 27 16:35:23 portatel kernel: [    0.270926] ACPI: Power Button (CM)=
 [PWRB]
Mar 27 16:35:23 portatel kernel: [    0.271052] input: Sleep Button (CM=
) as /class/input/input3
Mar 27 16:35:23 portatel kernel: [    0.271117] ACPI: Sleep Button (CM)=
 [SLPB]
Mar 27 16:35:23 portatel kernel: [    0.271451] ACPI: CPU0 (power state=
s: C1[C1] C2[C2] C3[C3] C4[C3])
Mar 27 16:35:23 portatel kernel: [    0.271663] processor ACPI_CPU:00: =
registered as cooling_device0
Mar 27 16:35:23 portatel kernel: [    0.271730] ACPI: Processor [CPU0] =
(supports 8 throttling states)
Mar 27 16:35:23 portatel kernel: [    0.274319] lp: driver loaded but n=
o devices found
Mar 27 16:35:23 portatel kernel: [    0.274500] ppdev: user-space paral=
lel port driver
Mar 27 16:35:23 portatel kernel: [    0.274558] Linux agpgart interface=
 v0.103
Mar 27 16:35:23 portatel kernel: [    0.274624] agpgart-intel 0000:00:0=
0.0: Intel 855GM Chipset
Mar 27 16:35:23 portatel kernel: [    0.295196] agpgart-intel 0000:00:0=
0.0: AGP aperture is 256M @ 0xb0000000
Mar 27 16:35:23 portatel kernel: [    0.295362] [drm] Initialized drm 1=
=2E1.0 20060810
Mar 27 16:35:23 portatel kernel: [    0.295906] [drm] Initialized radeo=
n 1.29.0 20080528 on minor 0
Mar 27 16:35:23 portatel kernel: [    0.296207] Serial: 8250/16550 driv=
er4 ports, IRQ sharing enabled
Mar 27 16:35:23 portatel kernel: [    0.296757] serial 0000:00:1f.6: PC=
I INT B -> GSI 17 (level, low) -> IRQ 17
Mar 27 16:35:23 portatel kernel: [    0.296837] serial 0000:00:1f.6: PC=
I INT B disabled
Mar 27 16:35:23 portatel kernel: [    0.297214] parport_pc 00:08: repor=
ted by Plug and Play ACPI
Mar 27 16:35:23 portatel kernel: [    0.299223] parport0: PC-style at 0=
x378, irq 7 [PCSPP,EPP]
Mar 27 16:35:23 portatel kernel: [    0.383534] lp0: using parport0 (in=
terrupt-driven).
Mar 27 16:35:23 portatel kernel: [    0.387116] brd: module loaded
Mar 27 16:35:23 portatel kernel: [    0.389818] loop: module loaded
Mar 27 16:35:23 portatel kernel: [    0.392010] tg3.c:v3.94 (August 14,=
 2008)
Mar 27 16:35:23 portatel kernel: [    0.394241] tg3 0000:02:01.0: PCI I=
NT A -> GSI 21 (level, low) -> IRQ 21
Mar 27 16:35:23 portatel kernel: [    0.432774] eth0: Tigon3 [partno(BC=
M95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000Base-T Eth=
ernet 00:02:3f:1b:4c:3c
Mar 27 16:35:23 portatel kernel: [    0.435306] eth0: RXcsums[1] LinkCh=
gREG[0] MIirq[0] ASF[0] WireSpeed[0] TSOcap[1]
Mar 27 16:35:23 portatel kernel: [    0.437941] eth0: dma_rwctrl[763f00=
00] dma_mask[32-bit]
Mar 27 16:35:23 portatel kernel: [    0.440668] Uniform Multi-Platform =
E-IDE driver
Mar 27 16:35:23 portatel kernel: [    0.443486] piix 0000:00:1f.1: IDE =
controller (0x8086:0x24ca rev 0x03)
Mar 27 16:35:23 portatel kernel: [    0.446331] PIIX_IDE 0000:00:1f.1: =
enabling device (0005 -> 0007)
Mar 27 16:35:23 portatel kernel: [    0.449257] PIIX_IDE 0000:00:1f.1: =
PCI INT A -> GSI 18 (level, low) -> IRQ 18
Mar 27 16:35:23 portatel kernel: [    0.452262] piix 0000:00:1f.1: not =
100% native mode: will probe irqs later
Mar 27 16:35:23 portatel kernel: [    0.455354]     ide0: BM-DMA at 0x1=
100-0x1107
Mar 27 16:35:23 portatel kernel: [    0.458545]     ide1: BM-DMA at 0x1=
108-0x110f
Mar 27 16:35:23 portatel kernel: [    0.461755] Probing IDE interface i=
de0...
Mar 27 16:35:23 portatel kernel: [    0.682363] Switched to high resolu=
tion mode on CPU 0
Mar 27 16:35:23 portatel kernel: [    0.698129] hda: HTS721010G9AT00, A=
TA DISK drive
Mar 27 16:35:23 portatel kernel: [    1.313051] hda: host max PIO4 want=
ed PIO255(auto-tune) selected PIO4
Mar 27 16:35:23 portatel kernel: [    1.313280] hda: UDMA/100 mode sele=
cted
Mar 27 16:35:23 portatel kernel: [    1.316824] Probing IDE interface i=
de1...
Mar 27 16:35:23 portatel kernel: [    1.988130] hdc: Optiarc DVD RW AD-=
7630A, ATAPI CD/DVD-ROM drive
Mar 27 16:35:23 portatel kernel: [    2.603048] hdc: host max PIO4 want=
ed PIO255(auto-tune) selected PIO4
Mar 27 16:35:23 portatel kernel: [    2.606065] hdc: UDMA/33 mode selec=
ted
Mar 27 16:35:23 portatel kernel: [    2.612591] ide0 at 0x1f0-0x1f7,0x3=
f6 on irq 14
Mar 27 16:35:23 portatel kernel: [    2.632370] ide1 at 0x170-0x177,0x3=
76 on irq 15
Mar 27 16:35:23 portatel kernel: [    2.639305] ide-gd driver 1.18
Mar 27 16:35:23 portatel kernel: [    2.642994] hda: max request size: =
512KiB
Mar 27 16:35:23 portatel kernel: [    2.646892] hda: 195371568 sectors =
(100030 MB) w/7539KiB Cache, CHS=3D16383/255/63
Mar 27 16:35:23 portatel kernel: [    2.650948] hda: cache flushes supp=
orted
Mar 27 16:35:23 portatel kernel: [    2.654652]  hda: hda1 hda2 hda3 < =
hda5 hda6 hda7 >
Mar 27 16:35:23 portatel kernel: [    2.703252] ide-cd driver 5.00
Mar 27 16:35:23 portatel kernel: [    2.716065] ide-cd: hdc: ATAPI 24X =
DVD-ROM DVD-R/RAM CD-R/RW drive, 2048kB Cache
Mar 27 16:35:23 portatel kernel: [    2.719993] Uniform CD-ROM driver R=
evision: 3.20
Mar 27 16:35:23 portatel kernel: [    2.744981] Driver 'sd' needs updat=
ing - please use bus_type methods
Mar 27 16:35:23 portatel kernel: [    2.749174] ohci1394 0000:02:00.0: =
PCI INT A -> GSI 20 (level, low) -> IRQ 20
Mar 27 16:35:23 portatel kernel: [    2.803277] ohci1394: fw-host0: OHC=
I-1394 1.1 (PCI): IRQ=3D[20]  MMIO=3D[d0020000-d00207ff]  Max Packet=3D=
[2048]  IR/IT contexts=3D[4/8]
Mar 27 16:35:23 portatel kernel: [    2.807432] yenta_cardbus 0000:02:0=
4.0: CardBus bridge found [1025:0061]
Mar 27 16:35:23 portatel kernel: [    2.811542] yenta_cardbus 0000:02:0=
4.0: Using CSCINT to route CSC interrupts to PCI
Mar 27 16:35:23 portatel kernel: [    2.815655] yenta_cardbus 0000:02:0=
4.0: Routing CardBus interrupts to PCI
Mar 27 16:35:23 portatel kernel: [    2.819758] yenta_cardbus 0000:02:0=
4.0: TI: mfunc 0x00111c12, devctl 0x46
Mar 27 16:35:23 portatel kernel: [    3.046667] yenta_cardbus 0000:02:0=
4.0: ISA IRQ mask 0x0c28, PCI irq 16
Mar 27 16:35:23 portatel kernel: [    3.050757] yenta_cardbus 0000:02:0=
4.0: Socket status: 30000006
Mar 27 16:35:23 portatel kernel: [    3.054839] pci_bus 0000:02: Raisin=
g subordinate bus# of parent bus (#02) from #02 to #06
Mar 27 16:35:23 portatel kernel: [    3.058983] yenta_cardbus 0000:02:0=
4.0: pcmcia: parent PCI bridge I/O window: 0xa000 - 0xbfff
Mar 27 16:35:23 portatel kernel: [    3.063153] pcmcia_socket pcmcia_so=
cket0: cs: IO port probe 0xa000-0xbfff: clean.
Mar 27 16:35:23 portatel kernel: [    3.067833] yenta_cardbus 0000:02:0=
4.0: pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xdfffffff
Mar 27 16:35:23 portatel kernel: [    3.072070] yenta_cardbus 0000:02:0=
4.0: pcmcia: parent PCI bridge Memory window: 0x90000000 - 0x9fffffff
Mar 27 16:35:23 portatel kernel: [    3.327117] ehci_hcd: USB 2.0 'Enha=
nced' Host Controller (EHCI) Driver
Mar 27 16:35:23 portatel kernel: [    3.331329] ehci_hcd 0000:00:1d.7: =
PCI INT D -> GSI 23 (level, low) -> IRQ 23
Mar 27 16:35:23 portatel kernel: [    3.335537] ehci_hcd 0000:00:1d.7: =
setting latency timer to 64
Mar 27 16:35:23 portatel kernel: [    3.335540] ehci_hcd 0000:00:1d.7: =
EHCI Host Controller
Mar 27 16:35:23 portatel kernel: [    3.339807] ehci_hcd 0000:00:1d.7: =
new USB bus registered, assigned bus number 1
Mar 27 16:35:23 portatel kernel: [    3.347913] ehci_hcd 0000:00:1d.7: =
debug port 1
Mar 27 16:35:23 portatel kernel: [    3.352098] ehci_hcd 0000:00:1d.7: =
cache line size of 32 is not supported
Mar 27 16:35:23 portatel kernel: [    3.352108] ehci_hcd 0000:00:1d.7: =
irq 23, io mem 0xf0000000
Mar 27 16:35:23 portatel kernel: [    3.366006] ehci_hcd 0000:00:1d.7: =
USB 2.0 started, EHCI 1.00
Mar 27 16:35:23 portatel kernel: [    3.370277] usb usb1: configuration=
 #1 chosen from 1 choice
Mar 27 16:35:23 portatel kernel: [    3.374510] hub 1-0:1.0: USB hub fo=
und
Mar 27 16:35:23 portatel kernel: [    3.378730] hub 1-0:1.0: 6 ports de=
tected
Mar 27 16:35:23 portatel kernel: [    3.383121] usb usb1: New USB devic=
e found, idVendor=3D1d6b, idProduct=3D0002
Mar 27 16:35:23 portatel kernel: [    3.387335] usb usb1: New USB devic=
e strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Mar 27 16:35:23 portatel kernel: [    3.391446] usb usb1: Product: EHCI=
 Host Controller
Mar 27 16:35:23 portatel kernel: [    3.395484] usb usb1: Manufacturer:=
 Linux 2.6.28.7 ehci_hcd
Mar 27 16:35:23 portatel kernel: [    3.399507] usb usb1: SerialNumber:=
 0000:00:1d.7
Mar 27 16:35:23 portatel kernel: [    3.403568] uhci_hcd: USB Universal=
 Host Controller Interface driver
Mar 27 16:35:23 portatel kernel: [    3.407647] uhci_hcd 0000:00:1d.0: =
PCI INT A -> GSI 16 (level, low) -> IRQ 16
Mar 27 16:35:23 portatel kernel: [    3.411698] uhci_hcd 0000:00:1d.0: =
setting latency timer to 64
Mar 27 16:35:23 portatel kernel: [    3.411702] uhci_hcd 0000:00:1d.0: =
UHCI Host Controller
Mar 27 16:35:23 portatel kernel: [    3.415838] uhci_hcd 0000:00:1d.0: =
new USB bus registered, assigned bus number 2
Mar 27 16:35:23 portatel kernel: [    3.419903] uhci_hcd 0000:00:1d.0: =
irq 16, io base 0x00001200
Mar 27 16:35:23 portatel kernel: [    3.423994] usb usb2: configuration=
 #1 chosen from 1 choice
Mar 27 16:35:23 portatel kernel: [    3.428082] hub 2-0:1.0: USB hub fo=
und
Mar 27 16:35:23 portatel kernel: [    3.432152] hub 2-0:1.0: 2 ports de=
tected
Mar 27 16:35:23 portatel kernel: [    3.436333] usb usb2: New USB devic=
e found, idVendor=3D1d6b, idProduct=3D0001
Mar 27 16:35:23 portatel kernel: [    3.440398] usb usb2: New USB devic=
e strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Mar 27 16:35:23 portatel kernel: [    3.444406] usb usb2: Product: UHCI=
 Host Controller
Mar 27 16:35:23 portatel kernel: [    3.448410] usb usb2: Manufacturer:=
 Linux 2.6.28.7 uhci_hcd
Mar 27 16:35:23 portatel kernel: [    3.452436] usb usb2: SerialNumber:=
 0000:00:1d.0
Mar 27 16:35:23 portatel kernel: [    3.456468] uhci_hcd 0000:00:1d.1: =
PCI INT B -> GSI 19 (level, low) -> IRQ 19
Mar 27 16:35:23 portatel kernel: [    3.460546] uhci_hcd 0000:00:1d.1: =
setting latency timer to 64
Mar 27 16:35:23 portatel kernel: [    3.460550] uhci_hcd 0000:00:1d.1: =
UHCI Host Controller
Mar 27 16:35:23 portatel kernel: [    3.464656] uhci_hcd 0000:00:1d.1: =
new USB bus registered, assigned bus number 3
Mar 27 16:35:23 portatel kernel: [    3.468691] uhci_hcd 0000:00:1d.1: =
irq 19, io base 0x00001600
Mar 27 16:35:23 portatel kernel: [    3.472809] usb usb3: configuration=
 #1 chosen from 1 choice
Mar 27 16:35:23 portatel kernel: [    3.476861] hub 3-0:1.0: USB hub fo=
und
Mar 27 16:35:23 portatel kernel: [    3.480822] hub 3-0:1.0: 2 ports de=
tected
Mar 27 16:35:23 portatel kernel: [    3.484877] usb usb3: New USB devic=
e found, idVendor=3D1d6b, idProduct=3D0001
Mar 27 16:35:23 portatel kernel: [    3.488778] usb usb3: New USB devic=
e strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Mar 27 16:35:23 portatel kernel: [    3.492626] usb usb3: Product: UHCI=
 Host Controller
Mar 27 16:35:23 portatel kernel: [    3.496388] usb usb3: Manufacturer:=
 Linux 2.6.28.7 uhci_hcd
Mar 27 16:35:23 portatel kernel: [    3.500090] usb usb3: SerialNumber:=
 0000:00:1d.1
Mar 27 16:35:23 portatel kernel: [    3.503791] uhci_hcd 0000:00:1d.2: =
PCI INT C -> GSI 18 (level, low) -> IRQ 18
Mar 27 16:35:23 portatel kernel: [    3.507522] uhci_hcd 0000:00:1d.2: =
setting latency timer to 64
Mar 27 16:35:23 portatel kernel: [    3.507526] uhci_hcd 0000:00:1d.2: =
UHCI Host Controller
Mar 27 16:35:23 portatel kernel: [    3.511354] uhci_hcd 0000:00:1d.2: =
new USB bus registered, assigned bus number 4
Mar 27 16:35:23 portatel kernel: [    3.515146] uhci_hcd 0000:00:1d.2: =
irq 18, io base 0x00001700
Mar 27 16:35:23 portatel kernel: [    3.519021] usb usb4: configuration=
 #1 chosen from 1 choice
Mar 27 16:35:23 portatel kernel: [    3.522810] hub 4-0:1.0: USB hub fo=
und
Mar 27 16:35:23 portatel kernel: [    3.526540] hub 4-0:1.0: 2 ports de=
tected
Mar 27 16:35:23 portatel kernel: [    3.530359] usb usb4: New USB devic=
e found, idVendor=3D1d6b, idProduct=3D0001
Mar 27 16:35:23 portatel kernel: [    3.534044] usb usb4: New USB devic=
e strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Mar 27 16:35:23 portatel kernel: [    3.537746] usb usb4: Product: UHCI=
 Host Controller
Mar 27 16:35:23 portatel kernel: [    3.541361] usb usb4: Manufacturer:=
 Linux 2.6.28.7 uhci_hcd
Mar 27 16:35:23 portatel kernel: [    3.544974] usb usb4: SerialNumber:=
 0000:00:1d.2
Mar 27 16:35:23 portatel kernel: [    3.548690] PNP: PS/2 Controller [P=
NP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
Mar 27 16:35:23 portatel kernel: [    3.552604] i8042.c: Detected activ=
e multiplexing controller, rev 1.1.
Mar 27 16:35:23 portatel kernel: [    3.556280] serio: i8042 KBD port a=
t 0x60,0x64 irq 1
Mar 27 16:35:23 portatel kernel: [    3.559941] serio: i8042 AUX0 port =
at 0x60,0x64 irq 12
Mar 27 16:35:23 portatel kernel: [    3.563570] serio: i8042 AUX1 port =
at 0x60,0x64 irq 12
Mar 27 16:35:23 portatel kernel: [    3.567160] serio: i8042 AUX2 port =
at 0x60,0x64 irq 12
Mar 27 16:35:23 portatel kernel: [    3.570682] serio: i8042 AUX3 port =
at 0x60,0x64 irq 12
Mar 27 16:35:23 portatel kernel: [    3.574382] mice: PS/2 mouse device=
 common for all mice
Mar 27 16:35:23 portatel kernel: [    3.578271] rtc_cmos 00:04: RTC can=
 wake from S4
Mar 27 16:35:23 portatel kernel: [    3.581825] rtc_cmos 00:04: rtc cor=
e: registered rtc_cmos as rtc0
Mar 27 16:35:23 portatel kernel: [    3.585354] rtc0: alarms up to one =
month, y3k, 114 bytes nvram
Mar 27 16:35:23 portatel kernel: [    3.588915] i801_smbus 0000:00:1f.3=
: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Mar 27 16:35:23 portatel kernel: [    3.592557] iTCO_wdt: Intel TCO Wat=
chDog Timer Driver v1.05
Mar 27 16:35:23 portatel kernel: [    3.596211] iTCO_wdt: Found a ICH4-=
M TCO device (Version=3D1, TCOBASE=3D0x1060)
Mar 27 16:35:23 portatel kernel: [    3.599856] iTCO_wdt: initialized. =
heartbeat=3D30 sec (nowayout=3D0)
Mar 27 16:35:23 portatel kernel: [    3.603458] device-mapper: uevent: =
version 1.0.3
Mar 27 16:35:23 portatel kernel: [    3.607119] input: AT Translated Se=
t 2 keyboard as /class/input/input4
Mar 27 16:35:23 portatel kernel: [    3.610739] device-mapper: ioctl: 4=
=2E14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
Mar 27 16:35:23 portatel kernel: [    3.614465] EISA: Probing bus 0 at =
eisa.0
Mar 27 16:35:23 portatel kernel: [    3.618220] cpuidle: using governor=
 ladder
Mar 27 16:35:23 portatel kernel: [    3.622054] cpuidle: using governor=
 menu
Mar 27 16:35:23 portatel kernel: [    3.626200] usbcore: registered new=
 interface driver hiddev
Mar 27 16:35:23 portatel kernel: [    3.629818] usbcore: registered new=
 interface driver usbhid
Mar 27 16:35:23 portatel kernel: [    3.633340] usbhid: v2.6:USB HID co=
re driver
Mar 27 16:35:23 portatel kernel: [    3.636948] Advanced Linux Sound Ar=
chitecture Driver Version 1.0.18rc3.
Mar 27 16:35:23 portatel kernel: [    3.640877] Intel ICH 0000:00:1f.5:=
 PCI INT B -> GSI 17 (level, low) -> IRQ 17
Mar 27 16:35:23 portatel kernel: [    3.644461] Intel ICH 0000:00:1f.5:=
 setting latency timer to 64
Mar 27 16:35:23 portatel kernel: [    3.646733] Marking TSC unstable du=
e to TSC halts in idle
Mar 27 16:35:23 portatel kernel: [    4.063325] ieee1394: Host added: I=
D:BUS[0-00:1023]  GUID[00023f4853000249]
Mar 27 16:35:23 portatel kernel: [    4.237017] Synaptics Touchpad, mod=
el: 1, fw: 5.9, id: 0x126eb1, caps: 0xa04713/0x4000
Mar 27 16:35:23 portatel kernel: [    4.271267] input: SynPS/2 Synaptic=
s TouchPad as /class/input/input5
Mar 27 16:35:23 portatel kernel: [    4.457023] intel8x0_measure_ac97_c=
lock: measured 50416 usecs
Mar 27 16:35:23 portatel kernel: [    4.460633] intel8x0: clocking to 4=
8000
Mar 27 16:35:23 portatel kernel: [    4.465039] Intel ICH Modem 0000:00=
:1f.6: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Mar 27 16:35:23 portatel kernel: [    4.468765] Intel ICH Modem 0000:00=
:1f.6: setting latency timer to 64
Mar 27 16:35:23 portatel kernel: [    4.471703] ALSA device list:
Mar 27 16:35:23 portatel kernel: [    4.475426]   #0: Intel 82801DB-ICH=
4 with ALC250 at irq 17
Mar 27 16:35:23 portatel kernel: [    4.479226]   #1: Intel 82801DB-ICH=
4 Modem at irq 17
Mar 27 16:35:23 portatel kernel: [    4.483404] TCP cubic registered
Mar 27 16:35:23 portatel kernel: [    4.487157] NET: Registered protoco=
l family 17
Mar 27 16:35:23 portatel kernel: [    4.490934] Bluetooth: L2CAP ver 2.=
11
Mar 27 16:35:23 portatel kernel: [    4.494636] Bluetooth: L2CAP socket=
 layer initialized
Mar 27 16:35:23 portatel kernel: [    4.498328] Bluetooth: RFCOMM socke=
t layer initialized
Mar 27 16:35:23 portatel kernel: [    4.501973] Bluetooth: RFCOMM TTY l=
ayer initialized
Mar 27 16:35:23 portatel kernel: [    4.505591] Bluetooth: RFCOMM ver 1=
=2E10
Mar 27 16:35:23 portatel kernel: [    4.509174] ieee80211: 802.11 data/=
management/control stack, git-1.1.13
Mar 27 16:35:23 portatel kernel: [    4.512790] ieee80211: Copyright (C=
) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
Mar 27 16:35:23 portatel kernel: [    4.516458] ieee80211_crypt: regist=
ered algorithm 'NULL'
Mar 27 16:35:23 portatel kernel: [    4.516689] Using IPI Shortcut mode
Mar 27 16:35:23 portatel kernel: [    4.537516] registered taskstats ve=
rsion 1
Mar 27 16:35:23 portatel kernel: [    4.542177] rtc_cmos 00:04: setting=
 system clock to 2009-03-27 16:35:09 UTC (1238171709)
Mar 27 16:35:23 portatel kernel: [    4.581060] XFS mounting filesystem=
 hda6
Mar 27 16:35:23 portatel kernel: [    4.654033] Clocksource tsc unstabl=
e (delta =3D -77507373 ns)
Mar 27 16:35:23 portatel kernel: [    4.658667] Starting XFS recovery o=
n filesystem: hda6 (logdev: internal)
Mar 27 16:35:23 portatel kernel: [    6.299604] Ending XFS recovery on =
filesystem: hda6 (logdev: internal)
Mar 27 16:35:23 portatel kernel: [    6.304120] VFS: Mounted root (xfs =
filesystem) readonly.
Mar 27 16:35:23 portatel kernel: [    6.309041] Freeing unused kernel m=
emory: 416k freed
Mar 27 16:35:23 portatel kernel: [    9.481392] pcmcia_socket pcmcia_so=
cket0: cs: IO port probe 0x100-0x3af: clean.
Mar 27 16:35:23 portatel kernel: [    9.487108] pcmcia_socket pcmcia_so=
cket0: cs: IO port probe 0x3e0-0x4ff: clean.
Mar 27 16:35:23 portatel kernel: [    9.491991] pcmcia_socket pcmcia_so=
cket0: cs: IO port probe 0x820-0x8ff: clean.
Mar 27 16:35:23 portatel kernel: [    9.496697] pcmcia_socket pcmcia_so=
cket0: cs: IO port probe 0xc00-0xcf7: clean.
Mar 27 16:35:23 portatel kernel: [    9.501585] pcmcia_socket pcmcia_so=
cket0: cs: IO port probe 0xa00-0xaff: clean.
Mar 27 16:35:23 portatel kernel: [    9.900519] Intel 82802 RNG detecte=
d
Mar 27 16:35:23 portatel kernel: [    9.927367] ipw2200: Intel(R) PRO/W=
ireless 2200/2915 Network Driver, 1.2.2kmprq
Mar 27 16:35:23 portatel kernel: [    9.931401] ipw2200: Copyright(c) 2=
003-2006 Intel Corporation
Mar 27 16:35:23 portatel kernel: [    9.935454] ipw2200 0000:02:02.0: P=
CI INT A -> GSI 22 (level, low) -> IRQ 22
Mar 27 16:35:23 portatel kernel: [    9.957034] ipw2200: Detected Intel=
 PRO/Wireless 2200BG Network Connection
Mar 27 16:35:23 portatel kernel: [    9.961120] ipw2200 0000:02:02.0: f=
irmware: requesting ipw2200-bss.fw
Mar 27 16:35:23 portatel kernel: [   10.313341] ipw2200: Detected geogr=
aphy ZZM (11 802.11bg channels, 0 802.11a channels)
Mar 27 16:35:23 portatel kernel: [   11.590374] Adding 2249060k swap on=
 /dev/hda5.  Priority:-1 extents:1 across:2249060k
Mar 27 16:35:23 portatel kernel: [   13.012757] XFS mounting filesystem=
 hda7
Mar 27 16:35:23 portatel kernel: [   13.673479] Starting XFS recovery o=
n filesystem: hda7 (logdev: internal)
Mar 27 16:35:23 portatel kernel: [   13.852352] Ending XFS recovery on =
filesystem: hda7 (logdev: internal)
Mar 27 16:35:23 portatel kernel: [   18.097094] microcode: CPU0 updated=
 from revision 0x17 to 0x18, date =3D 2004-10-17=20
Mar 27 16:35:24 portatel kernel: [   20.288935] NET: Registered protoco=
l family 10
Mar 27 16:35:24 portatel kernel: [   20.290566] lo: Disabled Privacy Ex=
tensions
Mar 27 16:35:29 portatel kernel: [   24.940862] vboxdrv: Trying to deac=
tivate the NMI watchdog permanently...
Mar 27 16:35:29 portatel kernel: [   24.940866] vboxdrv: Successfully d=
one.
Mar 27 16:35:29 portatel kernel: [   24.940868] vboxdrv: Found 1 proces=
sor cores.
Mar 27 16:35:29 portatel kernel: [   24.940972] vboxdrv: TSC mode is 's=
ynchronous', kernel timer mode is 'normal'.
Mar 27 16:35:29 portatel kernel: [   24.942046] vboxdrv: Successfully l=
oaded version 2.1.4 (interface 0x000a0009).
Mar 27 16:35:31 portatel kernel: [   26.847826] ACPI: EC: non-query int=
errupt received, switching to interrupt mode
Mar 27 16:35:31 portatel kernel: [   26.849776] ACPI: EC: GPE storm det=
ected, transactions will use polling mode
Mar 27 16:35:32 portatel kernel: [   28.487144] ADDRCONF(NETDEV_UP): et=
h0: link is not ready
Mar 27 16:35:36 portatel kernel: [   32.067409] agpgart-intel 0000:00:0=
0.0: AGP 2.0 bridge
Mar 27 16:35:36 portatel kernel: [   32.067427] agpgart-intel 0000:00:0=
0.0: putting AGP V2 device into 1x mode
Mar 27 16:35:36 portatel kernel: [   32.067460] radeonfb 0000:01:00.0: =
putting AGP V2 device into 1x mode
Mar 27 16:35:37 portatel kernel: [   33.297180] [drm] Setting GART loca=
tion based on new memory map
Mar 27 16:35:37 portatel kernel: [   33.297194] [drm] Loading R300 Micr=
ocode
Mar 27 16:35:37 portatel kernel: [   33.297246] [drm] Num pipes: 1
Mar 27 16:35:37 portatel kernel: [   33.297256] [drm] writeback test su=
cceeded in 1 usecs
Mar 27 16:35:42 portatel kernel: [   38.281585] [drm] Num pipes: 1
Mar 27 16:40:10 portatel kernel: [  305.834089] agpgart-intel 0000:00:0=
0.0: AGP 2.0 bridge
Mar 27 16:40:10 portatel kernel: [  305.834120] agpgart-intel 0000:00:0=
0.0: putting AGP V2 device into 1x mode
Mar 27 16:40:10 portatel kernel: [  305.834178] radeonfb 0000:01:00.0: =
putting AGP V2 device into 1x mode
Mar 27 16:40:10 portatel kernel: [  305.834224] [drm] Loading R300 Micr=
ocode
Mar 27 16:40:10 portatel kernel: [  305.834276] [drm] Num pipes: 1
Mar 27 16:40:17 portatel kernel: [  312.822613] warning: `pulseaudio' u=
ses 32-bit capabilities (legacy support in use)
Mar 27 16:40:32 portatel kernel: [  327.791156] ADDRCONF(NETDEV_CHANGE)=
: eth1: link becomes ready
Mar 27 16:40:32 portatel kernel: [  328.312051] ieee80211_crypt: regist=
ered algorithm 'TKIP'
Mar 27 16:40:43 portatel kernel: [  338.590026] eth1: no IPv6 routers p=
resent
Mar 27 16:40:50 portatel kernel: [  345.534056] ADDRCONF(NETDEV_UP): et=
h1: link is not ready
Mar 27 16:40:51 portatel kernel: [  346.739671] ADDRCONF(NETDEV_CHANGE)=
: eth1: link becomes ready
Mar 27 16:41:02 portatel kernel: [  357.831596] ADDRCONF(NETDEV_UP): et=
h1: link is not ready
Mar 27 16:41:03 portatel kernel: [  358.957695] ADDRCONF(NETDEV_CHANGE)=
: eth1: link becomes ready
Mar 27 16:42:56 portatel kernel: [  472.336282] UDF-fs: No VRS found
Mar 27 16:42:56 portatel kernel: [  472.437336] ISO 9660 Extensions: Mi=
crosoft Joliet Level 3
Mar 27 16:42:56 portatel kernel: [  472.466037] ISOFS: changing to seco=
ndary root
Mar 27 16:43:08 portatel kernel: [  483.989195] [drm] Num pipes: 1
Mar 27 16:43:09 portatel kernel: [  484.828375] ADDRCONF(NETDEV_UP): et=
h1: link is not ready
Mar 27 16:44:17 portatel kernel: [  487.441113] PM: Syncing filesystems=
 ... done.
Mar 27 16:44:17 portatel kernel: [  487.447643] Freezing user space pro=
cesses ... (elapsed 0.00 seconds) done.
Mar 27 16:44:17 portatel kernel: [  487.448436] Freezing remaining free=
zable tasks ... (elapsed 0.00 seconds) done.
Mar 27 16:44:17 portatel kernel: [  487.448671] PM: Shrinking memory...=
  ^H-^Hdone (0 pages freed)
Mar 27 16:44:17 portatel kernel: [  487.515880] PM: Freed 0 kbytes in 0=
=2E06 seconds (0.00 MB/s)
Mar 27 16:44:17 portatel kernel: [  487.600056] parport_pc 00:08: disab=
led
Mar 27 16:44:17 portatel kernel: [  487.600482] eth1: Going into suspen=
d...
Mar 27 16:44:17 portatel kernel: [  487.602342] ipw2200 0000:02:02.0: P=
CI INT A disabled
Mar 27 16:44:17 portatel kernel: [  487.602406] ACPI handle has no cont=
ext!
Mar 27 16:44:17 portatel kernel: [  487.613095] ACPI handle has no cont=
ext!
Mar 27 16:44:17 portatel kernel: [  487.624023] radeonfb (0000:01:00.0)=
: suspending for event: 1...
Mar 27 16:44:17 portatel kernel: [  487.624175] Intel ICH Modem 0000:00=
:1f.6: PCI INT B disabled
Mar 27 16:44:17 portatel kernel: [  487.635216] Intel ICH 0000:00:1f.5:=
 PCI INT B disabled
Mar 27 16:44:17 portatel kernel: [  487.635333] PIIX_IDE 0000:00:1f.1: =
PCI INT A disabled
Mar 27 16:44:17 portatel kernel: [  487.635464] ehci_hcd 0000:00:1d.7: =
PCI INT D disabled
Mar 27 16:44:17 portatel kernel: [  487.635540] uhci_hcd 0000:00:1d.2: =
PCI INT C disabled
Mar 27 16:44:17 portatel kernel: [  487.635616] uhci_hcd 0000:00:1d.1: =
PCI INT B disabled
Mar 27 16:44:17 portatel kernel: [  487.635691] uhci_hcd 0000:00:1d.0: =
PCI INT A disabled
Mar 27 16:44:17 portatel kernel: [  487.635983] ACPI: Preparing to ente=
r system sleep state S4
Mar 27 16:44:17 portatel kernel: [  487.642003] PM: Creating hibernatio=
n image:=20
Mar 27 16:44:17 portatel kernel: [  487.642003] PM: Need to copy 114962=
 pages
Mar 27 16:44:17 portatel kernel: [  487.642003] Intel machine check arc=
hitecture supported.
Mar 27 16:44:17 portatel kernel: [  487.642003] Intel machine check rep=
orting enabled on CPU#0.
Mar 27 16:44:17 portatel kernel: [  487.642003] microcode: CPU0 updated=
 from revision 0x18 to 0x18, date =3D 2004-10-17=20
Mar 27 16:44:17 portatel kernel: [  487.642151] ACPI: Waking up from sy=
stem sleep state S4
Mar 27 16:44:17 portatel kernel: [  487.907415] pm_op(): pci_pm_restore=
+0x0/0x42 returns -16
Mar 27 16:44:17 portatel kernel: [  487.907476] PM: Device 0000:00:00.0=
 failed to restore: error -16
Mar 27 16:44:17 portatel kernel: [  487.907579] uhci_hcd 0000:00:1d.0: =
PCI INT A -> GSI 16 (level, low) -> IRQ 16
Mar 27 16:44:17 portatel kernel: [  487.907653] uhci_hcd 0000:00:1d.0: =
setting latency timer to 64
Mar 27 16:44:17 portatel kernel: [  487.907683] uhci_hcd 0000:00:1d.1: =
PCI INT B -> GSI 19 (level, low) -> IRQ 19
Mar 27 16:44:17 portatel kernel: [  487.907758] uhci_hcd 0000:00:1d.1: =
setting latency timer to 64
Mar 27 16:44:17 portatel kernel: [  487.907786] uhci_hcd 0000:00:1d.2: =
PCI INT C -> GSI 18 (level, low) -> IRQ 18
Mar 27 16:44:17 portatel kernel: [  487.907860] uhci_hcd 0000:00:1d.2: =
setting latency timer to 64
Mar 27 16:44:17 portatel kernel: [  487.907888] ehci_hcd 0000:00:1d.7: =
PCI INT D -> GSI 23 (level, low) -> IRQ 23
Mar 27 16:44:17 portatel kernel: [  487.907962] ehci_hcd 0000:00:1d.7: =
setting latency timer to 64
Mar 27 16:44:17 portatel kernel: [  487.908030] pci 0000:00:1e.0: setti=
ng latency timer to 64
Mar 27 16:44:17 portatel kernel: [  487.908054] PIIX_IDE 0000:00:1f.1: =
PCI INT A -> GSI 18 (level, low) -> IRQ 18
Mar 27 16:44:17 portatel kernel: [  487.908141] PIIX_IDE 0000:00:1f.1: =
restoring config space at offset 0x1 (was 0x2800003, writing 0x2800007)
Mar 27 16:44:17 portatel kernel: [  487.908149] PIIX_IDE 0000:00:1f.1: =
setting latency timer to 64
Mar 27 16:44:17 portatel kernel: [  487.908197] Intel ICH 0000:00:1f.5:=
 PCI INT B -> GSI 17 (level, low) -> IRQ 17
Mar 27 16:44:17 portatel kernel: [  487.908272] Intel ICH 0000:00:1f.5:=
 setting latency timer to 64
Mar 27 16:44:17 portatel kernel: [  488.923250] Intel ICH Modem 0000:00=
:1f.6: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Mar 27 16:44:17 portatel kernel: [  488.923335] Intel ICH Modem 0000:00=
:1f.6: setting latency timer to 64
Mar 27 16:44:17 portatel kernel: [  489.924794] radeonfb (0000:01:00.0)=
: resuming from state: 1...
Mar 27 16:44:17 portatel kernel: [  489.940028] ohci1394 0000:02:00.0: =
restoring config space at offset 0xf (was 0x4020100, writing 0x402010b)
Mar 27 16:44:17 portatel kernel: [  489.940042] ohci1394 0000:02:00.0: =
restoring config space at offset 0x5 (was 0x0, writing 0xd0024000)
Mar 27 16:44:17 portatel kernel: [  489.940047] ohci1394 0000:02:00.0: =
restoring config space at offset 0x4 (was 0x0, writing 0xd0020000)
Mar 27 16:44:17 portatel kernel: [  489.940052] ohci1394 0000:02:00.0: =
restoring config space at offset 0x3 (was 0x0, writing 0x8004)
Mar 27 16:44:17 portatel kernel: [  489.940059] ohci1394 0000:02:00.0: =
restoring config space at offset 0x1 (was 0x2100000, writing 0x2100006)
Mar 27 16:44:17 portatel kernel: [  489.990091] ohci1394: fw-host0: OHC=
I-1394 1.1 (PCI): IRQ=3D[20]  MMIO=3D[d0020000-d00207ff]  Max Packet=3D=
[2048]  IR/IT contexts=3D[4/8]
Mar 27 16:44:17 portatel kernel: [  489.990374] tg3 0000:02:01.0: resto=
ring config space at offset 0xc (was 0x0, writing 0xfaf20000)
Mar 27 16:44:17 portatel kernel: [  489.990399] eth1: Coming out of sus=
pend...
Mar 27 16:44:17 portatel kernel: [  490.001224] ipw2200 0000:02:02.0: P=
CI INT A -> GSI 22 (level, low) -> IRQ 22
Mar 27 16:44:17 portatel kernel: [  490.167445] parport_pc 00:08: activ=
ated
Mar 27 16:44:17 portatel kernel: [  490.169887] hda: host max PIO4 want=
ed PIO255(auto-tune) selected PIO4
Mar 27 16:44:17 portatel kernel: [  490.171703] hda: UDMA/100 mode sele=
cted
Mar 27 16:44:17 portatel kernel: [  490.174743] hdc: host max PIO4 want=
ed PIO255(auto-tune) selected PIO4
Mar 27 16:44:17 portatel kernel: [  490.175103] hdc: UDMA/33 mode selec=
ted
Mar 27 16:44:17 portatel kernel: [  490.262608] Restarting tasks ... do=
ne.
Mar 27 16:44:18 portatel kernel: [  490.944983] ADDRCONF(NETDEV_UP): et=
h1: link is not ready
Mar 27 16:44:18 portatel kernel: [  491.282464] ADDRCONF(NETDEV_UP): et=
h0: link is not ready
Mar 27 16:44:19 portatel kernel: [  492.343960] agpgart-intel 0000:00:0=
0.0: AGP 2.0 bridge
Mar 27 16:44:19 portatel kernel: [  492.343993] agpgart-intel 0000:00:0=
0.0: putting AGP V2 device into 1x mode
Mar 27 16:44:19 portatel kernel: [  492.344071] radeonfb 0000:01:00.0: =
putting AGP V2 device into 1x mode
Mar 27 16:44:19 portatel kernel: [  492.344118] [drm] Loading R300 Micr=
ocode
Mar 27 16:44:19 portatel kernel: [  492.344170] [drm] Num pipes: 1
Mar 27 16:44:26 portatel kernel: [  498.894848] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:26 portatel kernel: [  498.905272] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:26 portatel kernel: [  498.946167] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:26 portatel kernel: [  498.956461] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:26 portatel kernel: [  498.973087] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:26 portatel kernel: [  498.983441] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:28 portatel kernel: [  500.898214] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:28 portatel kernel: [  500.908232] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:29 portatel kernel: [  502.850042] ADDRCONF(NETDEV_CHANGE)=
: eth1: link becomes ready
Mar 27 16:44:30 portatel kernel: [  502.903020] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:30 portatel kernel: [  502.932559] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:32 portatel kernel: [  504.901634] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:32 portatel kernel: [  504.931435] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:32 portatel kernel: [  505.258695] [drm] Num pipes: 1
Mar 27 16:44:33 portatel kernel: [  505.986885] ADDRCONF(NETDEV_UP): et=
h1: link is not ready
Mar 27 16:44:34 portatel kernel: [  506.899923] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:34 portatel kernel: [  506.928380] VFS: busy inodes on cha=
nged media or resized disk hdc
Mar 27 16:44:34 portatel kernel: [  507.436197] VFS: busy inodes on cha=
nged media or resized disk hdc




*** END OF LOG ****




--- On Fri, 27/3/09, Borislav Petkov <petkovbb@googlemail.com> wrote:

> From: Borislav Petkov <petkovbb@googlemail.com>
> Subject: Re: PROBLEM: When hibernating or resuming, ide driver locks =
the computer with 100% cpu utilization (2.6.28.7)
> To: "Pedro R" <eusou15@yahoo.com>
> Cc: linux-ide@vger.kernel.org
> Date: Friday, 27 March, 2009, 12:59 PM
>=20
> -----Inline Attachment Follows-----
>=20
> Hi,
>=20
> On Thu, Mar 26, 2009 at 08:00:45PM -0700, Pedro R wrote:
> >=20
> > The following is a description of a bug in the linux
> kernel, according to the REPORTING-BUGS file.
> >=20
> >=20
> > [1.] One line description: When hibernating or
> resuming, ide driver locks the computer with 100% cpu
> utilization (2.6.28.7)
> >=20
> >=20
> >=20
> > [2.] Full description: Bug is 100% reproducible on
> suspend, appears to be quite random when resuming.=20
> >=20
> > After removing a previously inserted CD / DVD from the
> drive, any attempt to hibernate locks up the computer.=20
> > After the line "suspending console: use
> no_console_suspend ..." the following 2 lines loop
> infinitely:
> >=20
> > ide: status error =3D 0x04 {DriveReady SeekComplete
> DataRequest Error}
> > hdc: failed opcode =3D 0x059
>=20
> can you please clafify the exact order of how things
> happen: do you
> remove the CD after having hibernated the machine or
> during? What
> are the exact steps/their order, you do to trigger the bug?
> Can you
> also send me the whole dmesg output of a suspend/resume
> cycle? In case
> you can't catch the whole output due to the logs being
> swamped with the
> messages above, try setting log_buf_len kernel cmdline
> parameter to a
> higher value like 10M, for example.
>=20
> Thanks.
>=20
> --=20
> Regards/Gruss,
> =A0 =A0 Boris.
>=20


     =20
