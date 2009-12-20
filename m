From: Mario Bachmann <grafgrimm77@gmx.de>
Subject: Re: old Plextor CD Writer PX-W1210A is not recognized
Date: Sun, 20 Dec 2009 21:21:26 +0100
Message-ID: <20091220212126.199c541e@x2.grafnetz>
References: <20091220123215.2ae100e7@x2.grafnetz>
	<4B2E7A61.7080000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:53844 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754686AbZLTUVu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Dec 2009 15:21:50 -0500
In-Reply-To: <4B2E7A61.7080000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Am Sun, 20 Dec 2009 13:26:25 -0600
schrieb Robert Hancock <hancockrwd@gmail.com>:

> On 12/20/2009 05:32 AM, Mario Bachmann wrote:
> > Hello,
> >
> > my old PLEXTOR CD-R PX-W1210A, FwRev=1.09 is not recognized any more in Linux 2.6.31.4.
> >
> > In my old Rescue-Linux on the same machine with Linux 2.6.25.14 the CD-Writer is recognized and it works.
> >
> > To give you some Information about the Plextor-CD-Burner, I booted my old 2.6.25.14-Linux:
> >
> > # uname -a
> > Linux amd2000 2.6.25.14 #1 Fri Aug 1 23:55:59 CEST 2008 i686 AMD Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux
> >
> > # hdparm -Ii /dev/hdc
> > /dev/hdc:
> >
> >   Model=PLEXTOR CD-R PX-W1210A, FwRev=1.09, SerialNo=
> >   Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
> >   RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
> >   BuffType=unknown, BuffSize=0kB, MaxMultSect=0
> >   (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
> >   IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
> >   PIO modes:  pio0 pio1 pio2 pio3 pio4
> >   DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
> >   AdvancedPM=no
> >
> >   * signifies the current active mode
> >
> > # ls /dev/hd*
> > /dev/hda
> > /dev/hda1
> > /dev/hda10
> > /dev/hda11
> > /dev/hda2
> > /dev/hda3
> > /dev/hda4
> > /dev/hda5
> > /dev/hda6
> > /dev/hda7
> > /dev/hda8
> > /dev/hda9
> > /dev/hdb
> > /dev/hdb1
> > /dev/hdc
> >
> > # dmesg|grep -e hda -e hdb -e hdc -e hdd
> >      ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
> >      ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
> > hda: SAMSUNG SP1614N, ATA DISK drive
> > hdb: SAMSUNG SP1614N, ATA DISK drive
> > hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> > hda: UDMA/100 mode selected
> > hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> > hdb: UDMA/100 mode selected
> > hdc: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
> > hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> > hdc: MWDMA2 mode selected
> > hda: max request size: 512KiB
> > hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
> > hda: cache flushes supported
> >   hda: hda1 hda2 hda3 hda4<  hda5 hda6 hda7 hda8 hda9 hda10 hda11>
> > hdb: max request size: 512KiB
> > hdb: Host Protected Area detected.
> > hdb: Host Protected Area disabled.
> > hdb: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
> > hdb: cache flushes supported
> >   hdb: hdb1
> > hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache
> > XFS mounting filesystem hda9
> > Ending clean XFS mount for filesystem: hda9
> > XFS mounting filesystem hda6
> > Ending clean XFS mount for filesystem: hda6
> > XFS mounting filesystem hda8
> > Ending clean XFS mount for filesystem: hda8
> > Adding 1199992k swap on /dev/hda10.  Priority:1 extents:1 across:1199992k
> >
> > # dmesg |grep ide
> > BIOS-provided physical RAM map:
> > ACPI: IRQ0 used by override.
> > ACPI: IRQ2 used by override.
> > ACPI: IRQ9 used by override.
> > Kernel command line: BOOT_IMAGE=Rescue ro root=309 video=vesafb:ywrap,mtrr agp=off max_loop=16
> > pci 0000:01:00.0: Boot video device
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> >      ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
> >      ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
> > Probing IDE interface ide0...
> > Probing IDE interface ide1...
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> >
> > The difference between my old 2.6.25.14-Linux and the newer 2.6.31.4-Linux is mainly the actuality of the updates (and the kernel).
> > I configured the kernel by my own and the changes were made with "make oldconfig" and answer the questions.
> >
> > Can You please tell me if/why the Plextor do not work any more. Or better: Give me instructions to get it working again in newer versions of Linux Kernel.
> 
> It's difficult to say without seeing the dmesg output from the newer 
> kernel. However, from the output you posted above it seems that you may 
> not have any hardware-specific IDE driver enabled in your kernel 
> configuration and it's using a generic driver. I believe this mode isn't 
> supported anymore, at least not by default.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

No problem, here comes the dmesg-output from the newer kernel:
Greetings Mario

Linux version 2.6.31.4 (root@amd2000) (gcc version 4.4.2 (Gentoo 4.4.2 p1.0) ) #5 Fri Dec 11 23:51:26 CET 2009
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  NSC Geode by NSC
  Cyrix CyrixInstead
  Centaur CentaurHauls
  Transmeta GenuineTMx86
  Transmeta TransmetaCPU
  UMC UMC UMC UMC
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
DMI 2.3 present.
AMI BIOS detected: BIOS may corrupt low RAM, working around it.
e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
last_pfn = 0x3fff0 max_arch_pfn = 0x100000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-DFFFF write-protect
  E0000-EFFFF uncachable
  F0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000 mask FC0000000 write-back
  1 disabled
  2 disabled
  3 disabled
  4 disabled
  5 disabled
  6 disabled
  7 base 0D0000000 mask FF8000000 write-combining
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
initial memory mapped : 0 - 01800000
init_memory_mapping: 0000000000000000-00000000377fe000
 0000000000 - 0000400000 page 4k
 0000400000 - 0037400000 page 2M
 0037400000 - 00377fe000 page 4k
kernel direct mapping tables up to 377fe000 @ 10000-15000
ACPI: RSDP 000fa340 00014 (v00 AMI   )
ACPI: RSDT 3fff0000 0002C (v01 AMIINT SiS735XX 00001000 MSFT 0100000B)
ACPI: FACP 3fff0030 00074 (v01 AMIINT SiS735XX 00001000 MSFT 0100000B)
ACPI: DSDT 3fff0100 03332 (v01    SiS      735 00000100 MSFT 0100000D)
ACPI: FACS 3fff8000 00040
ACPI: APIC 3fff00b0 00050 (v01 AMIINT SiS735XX 00001000 MSFT 0100000B)
ACPI: Local APIC address 0xfee00000
135MB HIGHMEM available.
887MB LOWMEM available.
  mapped low ram: 0 - 377fe000
  low ram: 0 - 377fe000
  node 0 low ram: 00000000 - 377fe000
  node 0 bootmap 00011000 - 00017f00
(6 early reservations) ==> bootmem [0000000000 - 00377fe000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0001000000 - 00014f3130]    TEXT DATA BSS ==> [0001000000 - 00014f3130]
  #2 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
  #3 [00014f4000 - 00014fa294]              BRK ==> [00014f4000 - 00014fa294]
  #4 [0000010000 - 0000011000]          PGTABLE ==> [0000010000 - 0000011000]
  #5 [0000011000 - 0000018000]          BOOTMAP ==> [0000011000 - 0000018000]
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  Normal   0x00001000 -> 0x000377fe
  HighMem  0x000377fe -> 0x0003fff0
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000010 -> 0x0000009f
    0: 0x00000100 -> 0x0003fff0
On node 0 totalpages: 262015
free_area_init_node: node 0, pgdat c146dac0, node_mem_map c14fb200
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 3951 pages, LIFO batch:0
  Normal zone: 1744 pages used for memmap
  Normal zone: 221486 pages, LIFO batch:31
  HighMem zone: 272 pages used for memmap
  HighMem zone: 34530 pages, LIFO batch:7
Using APIC driver default
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
nr_irqs_gsi: 24
Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259967
Kernel command line: auto BOOT_IMAGE=Linux-26314 ro root=305 video=vesafb:ywrap,mtrr:3 agp=off loop.max_loop=32
PID hash table entries: 4096 (order: 12, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Initializing HighMem for node 0 (000377fe:0003fff0)
Memory: 1033548k/1048512k available (3313k kernel code, 14112k reserved, 1232k data, 280k init, 139208k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffa4000 - 0xfffff000   ( 364 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
    lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
      .init : 0xc1471000 - 0xc14b7000   ( 280 kB)
      .data : 0xc133c7d5 - 0xc1470b84   (1232 kB)
      .text : 0xc1000000 - 0xc133c7d5   (3313 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:288
Fast TSC calibration using PIT
Detected 1673.886 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Calibrating delay loop (skipped), value calculated using timer frequency.. 3347.77 BogoMIPS (lpj=6695544)
Mount-cache hash table entries: 512
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
mce: CPU supports 4 MCE banks
CPU: AMD Athlon(tm) XP 2000+ stepping 02
Checking 'hlt' instruction... OK.
ACPI: Core revision 20090521
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:00.0: reg 10 32bit mmio: [0xd0000000-0xd7ffffff]
pci 0000:00:02.0: Enabling SiS 96x SMBus
pci 0000:00:02.1: reg 20 io port: [0xc00-0xc1f]
pci 0000:00:02.2: reg 10 32bit mmio: [0xcfffe000-0xcfffefff]
pci 0000:00:02.3: reg 10 32bit mmio: [0xcffff000-0xcfffffff]
pci 0000:00:02.5: reg 20 io port: [0xff00-0xff0f]
pci 0000:00:02.7: reg 10 io port: [0xdc00-0xdcff]
pci 0000:00:02.7: reg 14 io port: [0xd800-0xd83f]
pci 0000:00:02.7: PME# supported from D3hot D3cold
pci 0000:00:02.7: PME# disabled
pci 0000:00:03.0: reg 10 io port: [0xd400-0xd4ff]
pci 0000:00:03.0: reg 14 32bit mmio: [0xcfff9000-0xcfff9fff]
pci 0000:00:03.0: reg 30 32bit mmio: [0xcffc0000-0xcffdffff]
pci 0000:00:03.0: supports D1 D2
pci 0000:00:03.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:03.0: PME# disabled
pci 0000:00:0d.0: reg 10 io port: [0xd000-0xd0ff]
pci 0000:00:0d.0: reg 14 32bit mmio: [0xcfffdf00-0xcfffdfff]
pci 0000:00:0d.0: reg 30 32bit mmio: [0xcffa0000-0xcffbffff]
pci 0000:00:0d.0: supports D1 D2
pci 0000:00:0d.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:00:0d.0: PME# disabled
pci 0000:00:0f.0: reg 10 32bit mmio: [0xcfffb000-0xcfffbfff]
pci 0000:00:0f.0: supports D1 D2
pci 0000:00:0f.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:0f.0: PME# disabled
pci 0000:00:0f.1: reg 10 32bit mmio: [0xcfffc000-0xcfffcfff]
pci 0000:00:0f.1: supports D1 D2
pci 0000:00:0f.1: PME# supported from D0 D1 D2 D3hot
pci 0000:00:0f.1: PME# disabled
pci 0000:00:0f.2: reg 10 32bit mmio: [0xcfffde00-0xcfffdeff]
pci 0000:00:0f.2: supports D1 D2
pci 0000:00:0f.2: PME# supported from D0 D1 D2 D3hot
pci 0000:00:0f.2: PME# disabled
pci 0000:00:11.0: reg 10 io port: [0xcc00-0xcc3f]
pci 0000:00:11.0: supports D2
pci 0000:01:00.0: reg 10 32bit mmio: [0xce000000-0xceffffff]
pci 0000:01:00.0: reg 14 32bit mmio: [0xb0000000-0xbfffffff]
pci 0000:01:00.0: reg 18 32bit mmio: [0xcd000000-0xcdffffff]
pci 0000:01:00.0: reg 30 32bit mmio: [0xcfee0000-0xcfefffff]
pci 0000:00:01.0: bridge 32bit mmio: [0xcbe00000-0xcfefffff]
pci 0000:00:01.0: bridge 32bit mmio pref: [0xabc00000-0xcbcfffff]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 *11 12 14 15)
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: disabled
pci 0000:00:01.0:   MEM window: 0xcbe00000-0xcfefffff
pci 0000:00:01.0:   PREFETCH window: 0xabc00000-0xcbcfffff
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
pci_bus 0000:01: resource 1 mem: [0xcbe00000-0xcfefffff]
pci_bus 0000:01: resource 2 pref mem [0xabc00000-0xcbcfffff]
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
audit: initializing netlink socket (disabled)
type=2000 audit(1261343899.127:1): initialized
highmem bounce pool size: 64 pages
SGI XFS with ACLs, security attributes, no debug enabled
msgmni has been set to 1747
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
vesafb: framebuffer at 0xb0000000, mapped to 0xf8080000, using 2560k, total 131072k
vesafb: mode is 1280x1024x8, linelength=1280, pages=1
vesafb: protected mode interface info at c000:d5a0
vesafb: pmi: set display start = c00cd5d6, set palette = c00cd640
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=2048
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input1
ACPI: Sleep Button [SLPB]
processor LNXCPU:00: registered as cooling_device0
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 2.88M AMI BIOS
FDC 0 is a post-1991 82077
loop: module loaded
Uniform Multi-Platform E-IDE driver
sis5513 0000:00:02.5: SiS735 ATA 100 (2nd gen) controller
sis5513 0000:00:02.5: IDE controller (0x1039:0x5513 rev 0xd0)
sis5513 0000:00:02.5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07
    ide1: BM-DMA at 0xff08-0xff0f
Probing IDE interface ide0...
hda: SAMSUNG SP1614N, ATA DISK drive
Switched to high resolution mode on CPU 0
hdb: SAMSUNG SP1614N, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdb: UDMA/100 mode selected
Probing IDE interface ide1...
ide1: no devices on the port
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
ide-gd driver 1.18
hda: max request size: 512KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdb: max request size: 512KiB
hdb: Host Protected Area detected.
	current capacity is 66055248 sectors (33820 MB)
	native  capacity is 312581808 sectors (160041 MB)
hdb: 66055248 sectors (33820 MB) w/8192KiB Cache, CHS=16383/255/63
hdb: cache flushes supported
 hdb: hdb1
hdb: p1 size 312581745 exceeds device capacity, enabling native capacity
hdb: detected capacity change from 33820286976 to 160041885696
ide-cd driver 5.00
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:00:0d.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
r8169 0000:00:0d.0: no PCI Express capability
eth0: RTL8169sb/8110sb at 0xf8040f00, 00:e0:51:20:00:9d, XID 10000000 IRQ 18
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:0f.2: PCI INT C -> GSI 17 (level, low) -> IRQ 17
ehci_hcd 0000:00:0f.2: EHCI Host Controller
ehci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0f.2: irq 17, io mem 0xcfffde00
ehci_hcd 0000:00:0f.2: USB 2.0 started, EHCI 1.00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd 0000:00:02.2: PCI INT D -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:00:02.2: OHCI Host Controller
ohci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.2: irq 19, io mem 0xcfffe000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.3: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ohci_hcd 0000:00:02.3: OHCI Host Controller
ohci_hcd 0000:00:02.3: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.3: irq 23, io mem 0xcffff000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ohci_hcd 0000:00:0f.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:00:0f.0: OHCI Host Controller
ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:0f.0: irq 19, io mem 0xcfffb000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
ohci_hcd 0000:00:0f.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:0f.1: OHCI Host Controller
ohci_hcd 0000:00:0f.1: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:0f.1: irq 16, io mem 0xcfffc000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, 114 bytes nvram
i2c /dev entries driver
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x0c00
ACPI: I/O resource 0000:00:02.1 [0xc00-0xc1f] conflicts with ACPI region SMRG [0xc00-0xc1f]
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
sis96x_smbus: probe of 0000:00:02.1 failed with error -16
it87: Found IT8705F chip at 0x290, revision 2
cpuidle: using governor ladder
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Using IPI Shortcut mode
rtc_cmos 00:02: setting system clock to 2009-12-20 21:18:22 UTC (1261343902)
input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input3
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
UDF-fs: No partition found (1)
XFS mounting filesystem hda5
Ending clean XFS mount for filesystem: hda5
VFS: Mounted root (xfs filesystem) readonly on device 3:5.
Freeing unused kernel memory: 280k freed
udev: starting version 146
parport_pc 00:0a: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
ppdev: user-space parallel port driver
nvidia: module license 'NVIDIA' taints kernel.
Disabling lock debugging due to kernel taint
nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
NVRM: loading NVIDIA UNIX x86 Kernel Module  190.42  Tue Oct 20 20:18:32 PDT 2009
Intel ICH 0000:00:02.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
intel8x0_measure_ac97_clock: measured 55772 usecs (2682 samples)
intel8x0: clocking to 48000
ENS1371 0000:00:11.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
XFS mounting filesystem hda6
Ending clean XFS mount for filesystem: hda6
XFS mounting filesystem hda8
Ending clean XFS mount for filesystem: hda8
XFS mounting filesystem hdb1
Ending clean XFS mount for filesystem: hdb1
Adding 1199992k swap on /dev/hda10.  Priority:1 extents:1 across:1199992k 
ip_tables: (C) 2000-2006 Netfilter Core Team
nf_conntrack version 0.5.0 (16383 buckets, 65532 max)
CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
nf_conntrack.acct=1 kernel parameter, acct=1 nf_conntrack module option or
sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
r8169: eth0: link up
NET: Registered protocol family 10
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
XFS mounting filesystem loop0
Ending clean XFS mount for filesystem: loop0
XFS mounting filesystem loop1
Ending clean XFS mount for filesystem: loop1
eth0: no IPv6 routers present
