From: Kuckuck Kuckuck <gentoopower@yahoo.de>
Subject: [SOLVED - Could be a bug though] AW: Raid autodetect problem, boot fails if root=/dev/md1 DG965RY
Date: Wed, 24 Oct 2007 21:13:31 +0000 (GMT)
Message-ID: <728724.77244.qm@web26001.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web26001.mail.ukl.yahoo.com ([217.12.10.212]:26608 "HELO
	web26001.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754126AbXJXVNd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Oct 2007 17:13:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuckuck Kuckuck <gentoopower@yahoo.de>, Linuxlist <linux-ide@vger.kernel.org>

Hi List,

I'm now able to use /dev/md1 as root device (kernel
 /boot/vmlinuz-2.6.23.1 ro root=3D/dev/md1),
I had to compile libata,ahci,scsi stuff into the kernel, not as
 modules.
Now  initializing and creation of /dev/sdx happends before raid autodet=
ect.

I tried adding a delay to the initrd.img and I made sure that all modul=
es
 necessary to init the sata drives were in initrd,
but whatever I did , the devices were not there before raidautodetec st=
arted. THe drives were seen before autodetect but there were no devices=
 /dev/sdx created
The scsi subsystem was never loaded before raid autodetect ran.

I'm not sure if this is a bug, a hardware problem or a bug with the old=
er mkinitrd that ships with my target OS CentOS 4.5.

Unfortunately I cannot do more testing/debugging as I have to ship this=
 server to some other business unit.
So If you come across a Intel DG965RY or a board with the same Chipset =
you can try for yourself.

Cheers

----- Urspr=FCngliche Mail ----
Von: Kuckuck Kuckuck <gentoopower@yahoo.de>
An: Linuxlist <linux-ide@vger.kernel.org>
Gesendet: Dienstag, den 23. Oktober 2007, 12:13:54 Uhr
Betreff: Raid autodetect problem, boot fails if root=3D/dev/md1 DG965RY




Hi List,

I'm currently trying to setup a new server. I'm having trouble using an
 md1 device as root device.

On SERVER1 with DG945NT  Board Raid autodetect finds the md raid
 successfully, here dmesg output
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md1
=2E..
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.


ON SERVER2 with DG965RY Board I use the same drive/partition scheme,
 there I get:



md: Autodetecting RAID arrays

md: autorun ...

md: ... autorun DONE.

Creating root device

Mounting root filesystem

EXT3-fs: unable to read superblock

Of course it cannot read the superblock, since md1 is not available at
 that time

The boot entry I used on SERVER2:

title CentOS RAID(2.6.23.1)
        root (hd0,0)
        kernel /boot/vmlinuz-2.6.23.1 ro root=3D/dev/md1 rhgb
 all-generic-ide vga=3D794
        initrd /boot/initrd-2.6.23.1.img

*Note: I use a removable IDE drive (hda) on both machines to boot from
*sda1 etc is set to partition type fd raid autodetect

I'm attaching dmesg output from SERVER2, created when booting with
 option root=3D/dev/hda1

I'm out of ideas right now:-)

Thanks=20








       __________________________________  Ihre erste Baustelle?
 Wissenswertes f=FCr Bastler und Hobby Handwerker. www.yahoo.de/clever

-----Integrierter Anhang folgt-----

Linux version 2.6.23.1 (root@efbs3sql) (gcc version 3.4.6 20060404 (Red
 Hat 3.4.6-8)) #1 SMP Mon Oct 22 17:34:27 CEST 2007
Command line: ro root=3D/dev/hda1 rhgb all-generic-ide vga=3D794
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000008f000 (usable)
 BIOS-e820: 000000000008f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007e561000 (usable)
 BIOS-e820: 000000007e561000 - 000000007e56e000 (reserved)
 BIOS-e820: 000000007e56e000 - 000000007e60b000 (usable)
 BIOS-e820: 000000007e60b000 - 000000007e6e9000 (ACPI NVS)
 BIOS-e820: 000000007e6e9000 - 000000007e6ed000 (usable)
 BIOS-e820: 000000007e6ed000 - 000000007e6f2000 (ACPI data)
 BIOS-e820: 000000007e6f2000 - 000000007e6f3000 (usable)
 BIOS-e820: 000000007e6f3000 - 000000007e6ff000 (ACPI data)
 BIOS-e820: 000000007e6ff000 - 000000007e700000 (usable)
 BIOS-e820: 000000007e700000 - 000000007f000000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 143) 0 entries of 3200 used
Entering add_active_range(0, 256, 517473) 1 entries of 3200 used
Entering add_active_range(0, 517486, 517643) 2 entries of 3200 used
Entering add_active_range(0, 517865, 517869) 3 entries of 3200 used
Entering add_active_range(0, 517874, 517875) 4 entries of 3200 used
Entering add_active_range(0, 517887, 517888) 5 entries of 3200 used
end_pfn_map =3D 1048576
DMI 2.4 present.
ACPI: RSDP 000FE020, 0014 (r0 INTEL )
ACPI: RSDT 7E6FD038, 004C (r1 INTEL  DG965RY       6AD       1000013)
ACPI: FACP 7E6FC000, 0074 (r1 INTEL  DG965RY       6AD MSFT  1000013)
ACPI: DSDT 7E6F7000, 41AA (r1 INTEL  DG965RY       6AD MSFT  1000013)
ACPI: FACS 7E691000, 0040
ACPI: APIC 7E6F6000, 0078 (r1 INTEL  DG965RY       6AD MSFT  1000013)
ACPI: WDDT 7E6F5000, 0040 (r1 INTEL  DG965RY       6AD MSFT  1000013)
ACPI: MCFG 7E6F4000, 003C (r1 INTEL  DG965RY       6AD MSFT  1000013)
ACPI: ASF! 7E6F3000, 00A6 (r32 INTEL  DG965RY       6AD MSFT  1000013)
ACPI: SSDT 7E6F1000, 020C (r1 INTEL     CpuPm      6AD MSFT  1000013)
ACPI: SSDT 7E6F0000, 01B7 (r1 INTEL   Cpu0Ist      6AD MSFT  1000013)
ACPI: SSDT 7E6EF000, 01B7 (r1 INTEL   Cpu1Ist      6AD MSFT  1000013)
ACPI: SSDT 7E6EE000, 01B7 (r1 INTEL   Cpu2Ist      6AD MSFT  1000013)
ACPI: SSDT 7E6ED000, 01B7 (r1 INTEL   Cpu3Ist      6AD MSFT  1000013)
No NUMA configuration found
=46aking a node at 0000000000000000-000000007e700000
Entering add_active_range(0, 0, 143) 0 entries of 3200 used
Entering add_active_range(0, 256, 517473) 1 entries of 3200 used
Entering add_active_range(0, 517486, 517643) 2 entries of 3200 used
Entering add_active_range(0, 517865, 517869) 3 entries of 3200 used
Entering add_active_range(0, 517874, 517875) 4 entries of 3200 used
Entering add_active_range(0, 517887, 517888) 5 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000007e700000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[6] active PFN ranges
    0:        0 ->      143
    0:      256 ->   517473
    0:   517486 ->   517643
    0:   517865 ->   517869
    0:   517874 ->   517875
    0:   517887 ->   517888
On node 0 totalpages: 517523
  DMA zone: 64 pages used for memmap
  DMA zone: 1254 pages reserved
  DMA zone: 2665 pages, LIFO batch:0
  DMA32 zone: 8028 pages used for memmap
  DMA32 zone: 505512 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7f000000:80f00000)
PERCPU: Allocating 31608 bytes of per cpu data
Built 1 zonelists in Node order.  Total pages: 508177
Policy zone: DMA32
Kernel command line: ro root=3D/dev/hda1 rhgb all-generic-ide vga=3D794
IDE generic will claim all unknown PCI IDE storage controllers.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Detected 1998.060 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Checking aperture...
Memory: 2031668k/2071552k available (2587k kernel code, 38424k
 reserved, 1308k data, 324k init)
SLUB: Genslabs=3D23, HWalign=3D64, Order=3D0-1, MinObjects=3D4, CPUs=3D=
2, Nodes=3D1
Calibrating delay using timer specific routine.. 3999.29 BogoMIPS
 (lpj=3D7998583)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
=46reeing SMP alternatives: 26k freed
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12487873
Detected 12.487 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3996.31 BogoMIPS
 (lpj=3D7992623)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
Intel(R) Core(TM)2 CPU          4400  @ 2.00GHz stepping 02
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
xor: automatically using best checksumming function: generic_sse
   generic_sse:  7343.000 MB/sec
xor: using function: generic_sse (7343.000 MB/sec)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 2.21 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post=
 a
 report
PCI-GART: No AMD northbridge found.
ACPI: RTC can wake from S4
Time: tsc clocksource has been installed.
pnp: 00:01: iomem range 0xf0000000-0xf7ffffff has been reserved
pnp: 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
pnp: 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
pnp: 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
pnp: 00:06: ioport range 0x500-0x53f has been reserved
pnp: 00:06: ioport range 0x400-0x47f has been reserved
pnp: 00:06: ioport range 0x680-0x6ff has been reserved
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: 2000-2fff
  MEM window: 90100000-901fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: 90000000-900fffff
  PREFETCH window: 90400000-904fffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.4 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 11, 10485760 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Unpacking initramfs... done
=46reeing initrd memory: 841k freed
audit: initializing netlink socket (disabled)
audit(1193141893.428:1): initialized
audit: cannot initialize inotify handle
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
async_tx: api initialized (async)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:00:02.0
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0x80000000, mapped to 0xffffc20001000000, using
 5120k, total 7616k
vesafb: mode is 1280x1024x16, linelength=3D2560, pages=3D1
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.102
agpgart: Detected an Intel 965G Chipset.
agpgart: Detected 7676K stolen memory.
agpgart: AGP aperture is 256M @ 0x80000000
[drm] Initialized drm 1.1.0 20060810
intelfb: Framebuffer driver for Intel(R)
 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
intelfb: Version 0.9.4
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
 enabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
 idebus=3Dxx
Unknown: IDE controller at PCI slot 0000:02:00.0
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
Unknown: chipset revision 177
Unknown: 100% native mode on irq 17
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD3200SB-01KMA0, ATA DISK drive
hdb: TSSTcorpCD/DVDW SH-S182M, ATAPI CD/DVD-ROM drive
ide0 at 0x2018-0x201f,0x2026 on irq 17
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 512KiB
hda: 625142448 sectors (320072 MB) w/8192KiB Cache,
 CHS=3D38913/255/63<4>hda: host side 80-wire cable detection failed, li=
miting max speed to
 UDMA33

hda: cache flushes supported
 hda: hda1 hda2
hdb: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
ahci 0000:00:1f.2: version 2.3
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x33 impl
 SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part=20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc20000fbe100 ctl 0x0000000000000000
 bmdma 0x0000000000000000 irq 506
ata2: SATA max UDMA/133 cmd 0xffffc20000fbe180 ctl 0x0000000000000000
 bmdma 0x0000000000000000 irq 506
ata3: DUMMY
ata4: DUMMY
ata5: SATA max UDMA/133 cmd 0xffffc20000fbe300 ctl 0x0000000000000000
 bmdma 0x0000000000000000 irq 506
ata6: SATA max UDMA/133 cmd 0xffffc20000fbe380 ctl 0x0000000000000000
 bmdma 0x0000000000000000 irq 506
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: ST3500630NS, 3.AEK, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: ST3500630NS, 3.AEK, max UDMA/133
ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/133
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: ATA-7: ST3500630NS, 3.AEK, max UDMA/133
ata5.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata5.00: configured for UDMA/133
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATA-7: ST3500630NS, 3.AEK, max UDMA/133
ata6.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3500630NS      3.AE PQ: 0
 ANSI: 5
scsi 1:0:0:0: Direct-Access     ATA      ST3500630NS      3.AE PQ: 0
 ANSI: 5
scsi 4:0:0:0: Direct-Access     ATA      ST3500630NS      3.AE PQ: 0
 ANSI: 5
scsi 5:0:0:0: Direct-Access     ATA      ST3500630NS      3.AE PQ: 0
 ANSI: 5
PNP: PS/2 Controller [PNP0f03:PS2M] at 0x60,0x64 irq 12
PNP: PS/2 controller doesn't have KBD irq; using default 1
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
raid6: int64x1   1838 MB/s
raid6: int64x2   2382 MB/s
raid6: int64x4   2482 MB/s
raid6: int64x8   1467 MB/s
raid6: sse2x1    3224 MB/s
raid6: sse2x2    3507 MB/s
raid6: sse2x4    6232 MB/s
raid6: using algorithm sse2x4 (6232 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
=46reeing unused kernel memory: 324k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
input: ImPS/2 Logitech Wheel Mouse as /class/input/input0
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1193141903.288:2): selinux=3D0 auid=3D4294967295
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
 support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
 support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
 support DPO or FUA
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
 support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 4:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
 support DPO or FUA
sd 4:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
 support DPO or FUA
 sdc: sdc1
sd 4:0:0:0: [sdc] Attached SCSI disk
sd 5:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 5:0:0:0: [sdd] Write Protect is off
sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
 support DPO or FUA
sd 5:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 5:0:0:0: [sdd] Write Protect is off
sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
 support DPO or FUA
 sdd: sdd1
sd 5:0:0:0: [sdd] Attached SCSI disk
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:00:19.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:19.0 to 64
e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
 00:19:d1:a3:18:0d
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 21 (level, low) -> IRQ 21
e1000: 0000:06:00.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:6c:64:d4
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
usbcore: registered new interface driver snd-usb-audio
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 21 (level, low) -> IRQ 21
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
iTCO_wdt: Found a ICH8 or ICH8R TCO device (Version=3D2, TCOBASE=3D0x04=
60)
iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0x90325c00
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0x90325800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x000030c0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x000030a0
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-1: new high speed USB device using ehci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00003080
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003060
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
usb 2-1: configuration #1 chosen from 1 choice
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[19]
  MMIO=3D[90044000-900447ff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/=
8]
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md1
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1><sdb1><sda1>
raid5: device sdd1 operational as raid disk 3
raid5: device sdc1 operational as raid disk 2
raid5: device sdb1 operational as raid disk 1
raid5: device sda1 operational as raid disk 0
raid5: allocated 4280kB for md1
raid5: raid level 5 set md1 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sdc1
 disk 3, o:1, dev:sdd1
md: ... autorun DONE.
usb 5-2: new low speed USB device using uhci_hcd and address 2
usb 5-2: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input1
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:1d.0-2
input: HID 046a:0023 as /class/input/input2
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:1d.0-2
usb 2-1.2: new high speed USB device using ehci_hcd and address 4
usb 2-1.2: configuration #1 chosen from 1 choice
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0090270001e7aea6]
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
mtrr: no more MTRRs available
mtrr: no more MTRRs available
usb 2-1.1: new high speed USB device using ehci_hcd and address 5
usb 2-1.1: configuration #1 chosen from 1 choice
Initializing USB Mass Storage driver...
scsi6 : SCSI emulation for USB Mass Storage devices
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
asus_acpi: Unknown symbol backlight_device_unregister
asus_acpi: Unknown symbol backlight_device_register
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Sleep Button (CM) as /class/input/input4
ACPI: Sleep Button (CM) [SLPB]
toshiba_acpi: Unknown symbol backlight_device_unregister
toshiba_acpi: Unknown symbol backlight_device_register
EXT3 FS on hda1, internal journal
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised:
 dm-devel@redhat.com
Adding 4112600k swap on /dev/hda2.  Priority:-1 extents:1
 across:4112600k
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
scsi 6:0:0:0: CD-ROM            HL-DT-ST DVDRRW GSA-5169D 1.00 PQ: 0
 ANSI: 0
usb-storage: device scan complete
sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
sr 6:0:0:0: Attached scsi CD-ROM sr0
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
pnp: Device 00:07 disabled.
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow
 Control: RX/TX
ip_tables: (C) 2000-2006 Netfilter Core Team
pnp: Device 00:07 activated.
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
eth0: no IPv6 routers present
mtrr: no more MTRRs available
mtrr: no more MTRRs available
usb 1-1: new high speed USB device using ehci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
scsi7 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
scsi 7:0:0:0: Direct-Access              USB DISK 2.0     PMAP PQ: 0
 ANSI: 0 CCS
sd 7:0:0:0: [sde] 16121856 512-byte hardware sectors (8254 MB)
sd 7:0:0:0: [sde] Write Protect is off
sd 7:0:0:0: [sde] Mode Sense: 23 00 00 00
sd 7:0:0:0: [sde] Assuming drive cache: write through
sd 7:0:0:0: [sde] 16121856 512-byte hardware sectors (8254 MB)
sd 7:0:0:0: [sde] Write Protect is off
sd 7:0:0:0: [sde] Mode Sense: 23 00 00 00
sd 7:0:0:0: [sde] Assuming drive cache: write through
 sde: sde1
sd 7:0:0:0: [sde] Attached SCSI removable disk
usb-storage: device scan complete






       __________________________________  Ihre erste Baustelle? Wissen=
swertes f=FCr Bastler und Hobby Handwerker. www.yahoo.de/clever
