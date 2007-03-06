From: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH, RFT, v2] sata_mv: convert to new EH
Date: Tue, 06 Mar 2007 00:16:41 -0500
Message-ID: <1173158201.3416.8.camel@obelisk.thedillows.org>
References: <20070225233454.GA31282@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.knology.net ([24.214.63.101]:41605 "EHLO smtp.knology.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbXCFFX1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 00:23:27 -0500
In-Reply-To: <20070225233454.GA31282@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Sun, 2007-02-25 at 18:34 -0500, Jeff Garzik wrote:
> Just got sata_mv working under the new EH, on my 6041.
> 
> It probes and talks to disks just fine (chip doesn't support ATAPI),
> and hotplug actually has a chance of working.
> 
> The 'mv-eh' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git mv-eh

Testing on my Adaptec 1420SA (604x, not sure which) gave several BUG()s,
and seemed to mount the drive. I immediately unmounted it, as I got
spooked by the bug reports in dmesg, and I fat fingered ro as rw :(

sata_mv, and libata built as modules, full .config available on request 

I'd love to get this controller running, as I could use the space. I'll
test just about anything you want, but my turnaround is likely to be on
the order of 24 hours or so...

lspci:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02)
00:0a.0 RAID bus controller: Adaptec Serial ATA II RAID 1420SA (rev 01)
00:0b.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet Controller
00:0c.0 Ethernet controller: 3Com Corporation 3cSOHO100-TX Hurricane (rev 30)
00:0d.0 Ethernet controller: 3Com Corporation 3C990B-TX-M/3C990BSVR [Typhoon2] (rev 03)
01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 GTS/Pro] (rev a3)

lspci -s a -xxx
00:0a.0 RAID bus controller: Adaptec Serial ATA II RAID 1420SA (rev 01)
00: 05 90 41 02 17 00 b0 02 01 00 04 01 08 20 00 00
10: 04 00 00 ed 00 00 00 00 01 a0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 05 90 41 02
30: 00 00 00 00 40 00 00 00 00 00 00 00 0c 01 00 00

dmesg, including BUG output:
Linux version 2.6.21-rc2 (il1@shed.thedillows.org) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 SMP Mon Mar 5 22:41:32 EST 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009a400 end: 000000000009a400 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009a400 size: 0000000000005c00 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001fefc000 end: 000000001fffc000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001fffc000 size: 0000000000003000 end: 000000001ffff000 type: 3
copy_e820_map() start: 000000001ffff000 size: 0000000000001000 end: 0000000020000000 type: 4
copy_e820_map() start: 00000000fec00000 size: 0000000000001000 end: 00000000fec01000 type: 2
copy_e820_map() start: 00000000fee00000 size: 0000000000001000 end: 00000000fee01000 type: 2
copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009a400 (usable)
 BIOS-e820: 000000000009a400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f54d0
Entering add_active_range(0, 0, 131068) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131068
early_node_map[1] active PFN ranges
    0:        0 ->   131068
On node 0 totalpages: 131068
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 991 pages used for memmap
  Normal zone: 125981 pages, LIFO batch:31
DMI 2.3 present.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #3 6:8 APIC version 17
Processor #0 6:8 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 1004.573 MHz processor.
Built 1 zonelists.  Total pages: 130045
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515252k/524272k available (1244k kernel code, 8480k reserved, 485k data, 188k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffbc000 - 0xfffff000   ( 268 kB)
    vmalloc : 0xe0800000 - 0xfffba000   ( 503 MB)
    lowmem  : 0xc0000000 - 0xdfffc000   ( 511 MB)
      .init : 0xc02b7000 - 0xc02e6000   ( 188 kB)
      .data : 0xc023736f - 0xc02b0910   ( 485 kB)
      .text : 0xc0100000 - 0xc023736f   (1244 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2011.03 BogoMIPS (lpj=4022062)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 11k freed
CPU0: Intel Pentium III (Coppermine) stepping 0a
Booting processor 1/0 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 2009.18 BogoMIPS (lpj=4018373)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (4020.21 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
migration_cost=752
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0d20, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd20
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbd50, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region e800-e80f claimed by vt82c686 SMB
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:04.0
pnp: 00:06: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:06: iomem range 0x100000-0x1fffffff could not be reserved
pnp: 00:06: iomem range 0xe8000-0xeffff has been reserved
pnp: 00:06: iomem range 0xf0000-0xf3fff could not be reserved
pnp: 00:0f: ioport range 0xe400-0xe47f has been reserved
pnp: 00:0f: ioport range 0xe800-0xe83f could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ee000000-efcfffff
  PREFETCH window: eff00000-fbffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 196608 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1807k freed
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Enabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:03: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20269: IDE controller at PCI slot 0000:00:09.0
PDC20269: chipset revision 2
PDC20269: ROM enabled at 0x30040000
PDC20269: PLL input clock is 16640 kHz
PDC20269: 100% native mode on irq 5
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Maxtor 6Y120L0, ATA DISK drive
ide2 at 0xb800-0xb807,0xb402 on irq 5
Probing IDE interface ide3...
hdg: ST380013A, ATA DISK drive
ide3 at 0xb000-0xb007,0xa802 on irq 5
Probing IDE interface ide0...
hda: Maxtor 4D040H2, ATA DISK drive
Probing IDE interface ide1...
hdc: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hde: max request size: 128KiB
hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
hde: cache flushes supported
 hde: hde1 hde2
hdg: max request size: 512KiB
hdg: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hdg: cache flushes supported
 hdg: hdg1 hdg2 hdg3
hda: max request size: 128KiB
hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63
hda: cache flushes not supported
 hda: hda1 hda2
PNP: PS/2 Controller [PNP0303] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 188k freed
Time: tsc clocksource has been installed.
SCSI subsystem initialized
libata version 2.20 loaded.
sata_mv 0000:00:0a.0: version 0.8
sata_mv 0000:00:0a.0: Applying B2 workarounds to unknown rev
sata_mv 0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x00000000 ctl 0xe08a2120 bmdma 0x00000000 irq 12
ata2: SATA max UDMA/133 cmd 0x00000000 ctl 0xe08a4120 bmdma 0x00000000 irq 12
ata3: SATA max UDMA/133 cmd 0x00000000 ctl 0xe08a6120 bmdma 0x00000000 irq 12
ata4: SATA max UDMA/133 cmd 0x00000000 ctl 0xe08a8120 bmdma 0x00000000 irq 12
scsi0 : sata_mv
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: Maxtor 6L200S0, BACE1G10, max UDMA/133
ata1.00: 398297088 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
scsi1 : sata_mv
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: Maxtor 6L200S0, BACE1G10, max UDMA/133
ata2.00: 398297088 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/133
scsi2 : sata_mv
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : sata_mv
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6L200S0   BACE PQ: 0 ANSI: 5
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6L200S0   BACE PQ: 0 ANSI: 5
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
md: raid1 personality registered for level 1
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: hdg1 has different UUID to sdb1
md: created md1
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
md: personality for level 0 is not loaded!
md: do_md_run() returned -22
md: md1 stopped.
md: unbind<sdb1>
md: export_rdev(sdb1)
md: unbind<sda1>
md: export_rdev(sda1)
md: considering hdg1 ...
md:  adding hdg1 ...
md: created md0
md: bind<hdg1>
md: running: <hdg1>
raid1: raid set md0 active with 1 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0c.0: 3Com PCI 3cSOHO100-TX Hurricane at e0854000.
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
e1000: 0000:00:0b.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:6c:66:b3
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
typhoon.c: version 1.5.8 (06/11/09)
eth2: 3Com Typhoon2 (3C990B-FX-97) at MMIO 0xea800000, 00:0a:5e:1b:95:7b
eth2: Typhoon 1.1+ Sleep Image version 03.001.007 03:11:11 07/23/01 0000156
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport_pc: VIA parallel port: io=0x378, irq=7
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sda1 ...
md:  adding sda1 ...
md:  adding sdb1 ...
md: created md1
md: bind<sdb1>
md: bind<sda1>
md: running: <sda1><sdb1>
md: raid0 personality registered for level 0
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sda1
raid0:   comparing sda1(199141632) with sda1(199141632)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdb1
raid0:   comparing sdb1(199141632) with sda1(199141632)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 398283264 blocks.
raid0 : conf->hash_spacing is 398283264 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdg3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1048568k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:1048568k
eth0:  setting full-duplex.
e1000: eth1: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
PM: Writing back config space on device 0000:00:0d.0 at offset f (was 50a0100, writing 50a0105)
PM: Writing back config space on device 0000:00:0d.0 at offset 5 (was 0, writing ea800000)
PM: Writing back config space on device 0000:00:0d.0 at offset 4 (was 1, writing 9001)
PM: Writing back config space on device 0000:00:0d.0 at offset 3 (was 0, writing 2008)
PM: Writing back config space on device 0000:00:0d.0 at offset 1 (was 2100000, writing 2100017)
lp0: using parport0 (interrupt-driven).
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
 [<e0847501>] mv_qc_issue+0x96/0x108 [sata_mv]
 [<e080ef8b>] ata_qc_issue+0x445/0x489 [libata]
 [<e0813107>] ata_scsi_rw_xlat+0x12c/0x178 [libata]
 [<e082747b>] scsi_done+0x0/0x16 [scsi_mod]
 [<e08149cd>] ata_scsi_translate+0xed/0x147 [libata]
 [<e082747b>] scsi_done+0x0/0x16 [scsi_mod]
 [<e08152f1>] ata_scsi_queuecmd+0xf8/0x134 [libata]
 [<e0812fdb>] ata_scsi_rw_xlat+0x0/0x178 [libata]
 [<e0827608>] scsi_dispatch_cmd+0x177/0x1ba [scsi_mod]
 [<e082b9dd>] scsi_request_fn+0x20a/0x2b0 [scsi_mod]
 [<c017fce0>] blk_remove_plug+0x4f/0x5b
 [<c017fd23>] blk_run_queue+0x37/0x63
 [<e082b118>] scsi_next_command+0x25/0x2f [scsi_mod]
 [<e082b1ba>] scsi_end_request+0x98/0xa2 [scsi_mod]
 [<e082b2b9>] scsi_io_completion+0xf5/0x2c7 [scsi_mod]
 [<e080746f>] sd_rw_intr+0x1ae/0x1b6 [sd_mod]
 [<e082bd9c>] scsi_softirq_done+0x22/0xc6 [scsi_mod]
 [<e082707d>] scsi_finish_command+0x3f/0x43 [scsi_mod]
 [<c018024f>] blk_done_softirq+0x48/0x53
 [<c0119980>] __do_softirq+0x5d/0xb8
 [<c0119a0d>] do_softirq+0x32/0x36
 [<c0104976>] do_IRQ+0x5a/0x70
 [<c0102dc3>] common_interrupt+0x23/0x28
 [<e09e528e>] raid0_make_request+0x1ad/0x1b1 [raid0]
 [<c017fa0f>] generic_make_request+0x11a/0x12a
 [<c016485c>] __find_get_block_slow+0xea/0xf4
 [<e09b551b>] ext3_get_block+0x0/0xbf [ext3]
 [<c0180d4b>] submit_bio+0xc0/0xc7
 [<c0134dcf>] mempool_alloc+0x1c/0xbb
 [<c0166cb3>] bio_alloc_bioset+0x9a/0xf2
 [<c0164555>] submit_bh+0xbc/0xd7
 [<c0164d65>] ll_rw_block+0x79/0x91
 [<e0984027>] jread+0x11d/0x1ba [jbd]
 [<c016485c>] __find_get_block_slow+0xea/0xf4
 [<c018a93e>] radix_tree_node_alloc+0x16/0x55
 [<e0984126>] do_one_pass+0x62/0x3f8 [jbd]
 [<c02358e9>] out_of_line_wait_on_bit+0x63/0x6b
 [<e0984551>] journal_recover+0x37/0x8e [jbd]
 [<e09866cb>] journal_load+0xa9/0xdd [jbd]
 [<e09ba302>] ext3_get_journal+0xb8/0xcc [ext3]
 [<e09bb4eb>] ext3_fill_super+0xddb/0x1398 [ext3]
 [<c018c2c7>] snprintf+0x1f/0x23
 [<c017663e>] disk_name+0x30/0x88
 [<c014c7e5>] get_sb_bdev+0xcd/0x11c
 [<e09b9589>] ext3_get_sb+0x20/0x25 [ext3]
 [<e09ba710>] ext3_fill_super+0x0/0x1398 [ext3]
 [<c014bfe1>] vfs_kern_mount+0x40/0x6f
 [<c014c04e>] do_kern_mount+0x2b/0x3c
 [<c015c7d2>] do_mount+0x55c/0x5a8
 [<c013d449>] __handle_mm_fault+0x440/0x754
 [<c01597af>] iput+0x39/0x62
 [<c023675c>] error_code+0x7c/0x84
 [<c01368e0>] __get_free_pages+0x1a/0x33
 [<c015b503>] copy_mount_options+0x25/0x10b
 [<c015c895>] sys_mount+0x77/0xb3
 [<c01023b4>] sysenter_past_esp+0x5d/0x81
 [<c0230000>] unix_seq_show+0x11b/0x11d
 =======================
BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
[snip identical backtrace]
 =======================
BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
[snip identical backtrace]
 =======================
BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
[snip identical backtrace]
 =======================
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
BUG: at drivers/ata/sata_mv.c:1291 mv_get_crpb_status()
 [<e0846b08>] mv_interrupt+0x292/0x6c9 [sata_mv]
 [<c01c1ee6>] ide_intr+0x1ac/0x1b9
 [<c0130599>] handle_IRQ_event+0x1a/0x3f
 [<c013197d>] handle_fasteoi_irq+0x7c/0xaf
 [<c0104971>] do_IRQ+0x55/0x70
 [<c0102dc3>] common_interrupt+0x23/0x28
 [<c0136218>] get_page_from_freelist+0x1a5/0x2a9
 [<c013636a>] __alloc_pages+0x4e/0x290
 [<c013c74c>] do_wp_page+0x1b1/0x371
 [<c013d70d>] __handle_mm_fault+0x704/0x754
 [<c010f0d6>] do_page_fault+0x223/0x521
 [<c010eeb3>] do_page_fault+0x0/0x521
 [<c023675c>] error_code+0x7c/0x84
 [<c012007b>] sys_reboot+0xe3/0x145
 [<c0230000>] unix_seq_show+0x11b/0x11d
 =======================

