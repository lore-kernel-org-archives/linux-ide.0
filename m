From: Marc Zuckman <marc@fallon.classyad.com>
Subject: it821x problems continue with 2.6.25
Date: Fri, 25 Apr 2008 08:20:42 -0400
Message-ID: <200804250820.42606.marc@fallon.classyad.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:43954
	"EHLO QMTA07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753770AbYDYM0R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Apr 2008 08:26:17 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org

A few months ago, I reported problems using the it821x driver in 2.6.23.
A discussion of the issues ensued and is archived in the linux-ide with the 
last communication located here:
http://marc.info/?l=linux-ide&m=120023746217790&w=2

My difficulties remained unresolved as of 2.6.24.4  and now also as of 2.6.25

DMA on the drive cannot be set with hdparm -d1 /dev/hde

The Raid 1 array simply does not work properly in this configuration.

The last working version of the kernel that  I have used is 2.6.20-gentoo-r7.

Boot excerpts:

Linux version 2.6.25-gentoo-r1mz (root@...) (gcc version 4.1.1 (Gentoo 
4.1.1-r3)) #2 SMP Sun Apr 20 10:46:44 EDT 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005fff0000 (usable)
 BIOS-e820: 000000005fff0000 - 000000005fff3000 (ACPI NVS)
 BIOS-e820: 000000005fff3000 - 0000000060000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
896MB LOWMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at [c00f5320] 000f5320
Entering add_active_range(0, 0, 393200) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   393200
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   393200
On node 0 totalpages: 393200
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 1279 pages used for memmap
  HighMem zone: 162545 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
...

CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11258.87 BogoMIPS).


PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet clockevent registered
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz

Real Time Clock Driver v1.12ac
Linux agpgart interface v0.103

Uniform Multi-Platform E-IDE driver
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller (0x8086:0x24db rev 0x02) at  PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:PIO, hdb:PIO
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:PIO, hdd:PIO
Probing IDE interface ide0...
hda: WDC WD1000BB-00CAA1, ATA DISK drive
hdb: QUANTUM FIREBALL EX6.4A, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdb: UDMA/33 mode selected
Probing IDE interface ide1...
hdc: TOSHIBA CD/DVDW SDR5372V, ATAPI CD/DVD-ROM drive
hdd: TDK CDRW321040B, ATAPI CD/DVD-ROM drive
hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/33 mode selected
hdd: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdd: UDMA/33 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
IT8212: IDE controller (0x1283:0x8212 rev 0x11) at  PCI slot 0000:03:0c.0
ACPI: PCI Interrupt 0000:03:0c.0[A] -> GSI 21 (level, low) -> IRQ 21
it821x: controller in smart mode.
IT8212: 100% native mode on irq 21
    ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:DMA, hdf:PIO
    ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:PIO, hdh:PIO
Probing IDE interface ide2...
hde: Integrated Technology Express Inc, ATA DISK drive
hde: IT8212 RAID 1 volume.
hde: no DMA mode selected
Probing IDE interface ide3...
ide2 at 0xa810-0xa817,0xac02 on irq 21
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 195369455 sectors (100029 MB)
	native  capacity is 195371568 sectors (100030 MB)
hda: Host Protected Area disabled.
hda: 195371568 sectors (100030 MB) w/2048KiB Cache, CHS=65535/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
hdb: max request size: 128KiB
hdb: 12594960 sectors (6448 MB) w/418KiB Cache, CHS=13328/15/63
hdb: cache flushes not supported
 hdb: hdb1 hdb2
hde: max request size: 128KiB
hde: 312581806 sectors (160041 MB), CHS=19457/255/63
hde: cache flushes not supported
 hde: hde1
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache

EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 280k freed
intel_rng: FWH not detected
EXT3 FS on hda7, internal journal
hde: no DMA mode selected
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1177468k swap on /dev/hdb2.  Priority:-1 extents:1 across:1177468k
hda: UDMA/100 mode selected
hda: UDMA/100 mode selected
hdb: UDMA/33 mode selected
hdb: UDMA/33 mode selected
hde: no DMA mode selected



hdparm --Istdout /dev/hde

/dev/hde:
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 2008 2004 1801 3552 0101 0005
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 496e 7465 6772 6174 6564
2054 6563 686e 6f6c 6f67 7920 4578 7072
6573 7320 496e 6320 2020 2020 2020 0000
0000 0000 0000 0000 0000 0000 0000 000f
0000 0000 0000 0000 ffff 0fff 0000 0007
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
003f 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 9eae 12a1 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0001 0003 3133 2121 9111 0091 3266
0021 0021 0001 0505 0005 0500 0000 0005
0005 0005 0040 0000 0000 0000 0000 0000
0000 0000 0001 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
