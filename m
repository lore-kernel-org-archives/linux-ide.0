From: Daniel Brahneborg <basic@wtnord.net>
Subject: Re: siimage and two nics
Date: Fri, 26 Dec 2003 23:28:26 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031226232826.A7057@nettis.grimsta>
References: <20031226085450.A4045@nettis.grimsta> <34449.209.163.161.49.1072444479.squirrel@mail.clanhk.org> <20031226195705.B4045@nettis.grimsta> <3FEBAFA5.8020604@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 212-214-141-193.v-by.wtnord.net ([212.214.141.193]:5013 "EHLO
	ricercar.mine.nu") by vger.kernel.org with ESMTP id S264329AbTLZW2a
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Dec 2003 17:28:30 -0500
Content-Disposition: inline
In-Reply-To: <3FEBAFA5.8020604@clanhk.org>; from heretic@clanhk.org on Fri, Dec 26, 2003 at 03:48:53AM +0000
List-Id: linux-ide@vger.kernel.org
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: Daniel Brahneborg <daniel.com@wtnord.net>, linux-ide@vger.kernel.org

Thanks for your quick replies.

On Fri, Dec 26, 2003 at 03:48:53AM +0000, J. Ryan Earl wrote:
> >If I boot with the siimage module builtin, the kernel doesn't
> >find the root device (set to /dev/hda2).
> 
> You can't use the Via sata for the root device?  It's off the slow PCI 
> bus, it'll be much faster anyway.

I guess I could, I just needed something to install to.
It's a file server, so it's the SATA disks that will take
the biggest hit.

> >As a workaround, I now skip the siimage module entirely, and only
> >load the sata_via and sata_sil modules.  This makes all 4 SATA
> >drives come alive as sda, sdb etc, leaving hda untouched.  I get
> >50 MB/s with hdparm -tT, so it seems to work fine.
>
> Be careful, sata_sil is broken.  It is not stable, and has failed every 
> stress test I've tried on it.  The siimage ide driver is actually stable 
> around v1.09.

I wouldn't mind using something else, but then I must first
understand how to get it to stop messing with my PATA hda.
Would that driver make the SATA disk suddenly appear as IDE
disks instead of SCSI?

Checking... oh, it's 1.06 in Linus 2.4.23 kernel.  The diff
doesn't seem to be very much, just a check for 3114 and a fix
for Seagate drives.

> >New Problem:
> >
> >I still have a rather serious problem, also SATA related.  I want
> >to have two network cards in that machine, one of them being a
> >common 8139 card.  As the other one I want to use the via-rhine
> >card on the motherboard.  The first network card comes alive
> >without problem, but when I try to do "ifconfig eth1 up", the
> >entire machine comes to a complete stop.  Not even Caps Lock work,
> >and I have to power cycle it.  Two 8139 cards have the same effect.
> >Removing the Silicon Image card makes it work fine.  How do I do
> >to get some debug information on what happens?
> >
> >Here is the output from lspci -v.
>
>  '/proc/version'?

Linux version 2.4.23-xfs (root@fw.grimsta)
(gcc 3.2 20020903 (Red Hat Linux 8.0 3.2-7))
#8 Fri Dec 26 13:21:26 CET 2003

> newest bios?

The motherboard is just a week old, so I haven't even thought of
doing anything with the bios.

> move the sata card to a new pci slot?

Both the sata card and the network cards have switched places
a bit, with no difference in behaviour.

> dmesg?

Appended.

/Basic

Linux version 2.4.23-xfs (root@fw.grimsta) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #8 Fri Dec 26 13:21:26 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001fef3000 (ACPI NVS)
 BIOS-e820: 000000001fef3000 - 000000001ff00000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
510MB LOWMEM available.
On node 0 totalpages: 130800
zone(0): 4096 pages.
zone(1): 126704 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda3
Initializing CPU#0
Detected 819.311 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1635.12 BogoMIPS
Memory: 514816k/523200k available (1587k kernel code, 7996k reserved, 460k data, 76k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfaf40, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3227] at 00:11.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
SGI XFS snapshot-2.4.23-2003-12-01_00:33_UTC with ACLs, no debug enabled
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Real Time Clock Driver v1.10e
floppy0: no floppy controllers found
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: FUJITSU MHM2060AT, ATA DISK drive
hdd: MATSHITA CD-RW CW-7586, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 11733120 sectors (6007 MB) w/2048KiB Cache, CHS=730/255/63
hdd: attached ide-cdrom driver.
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1176.000 MB/sec
   32regs    :   909.600 MB/sec
   pII_mmx   :  1920.800 MB/sec
   p5_mmx    :  2464.400 MB/sec
raid5: using function: p5_mmx (2464.400 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 76k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
Adding Swap: 522104k swap-space (priority -1)
SCSI subsystem driver Revision: 1.00
libata version 0.81 loaded.
ata_sil version 0.51
PCI: Found IRQ 10 for device 00:0b.0
ata1: SATA max UDMA/133 cmd 0xE0870080 ctl 0xE087008A bmdma 0xE0870000 irq 10
ata2: SATA max UDMA/133 cmd 0xE08700C0 ctl 0xE08700CA bmdma 0xE0870008 irq 10
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:20ff
ata1: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
ata1: dev 0 configured for UDMA/133
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:20ff
ata2: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
ata2: dev 0 configured for UDMA/133
scsi0 : ata_sil
scsi1 : ata_sil
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_via version 0.11
ata3: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma 0xC800 irq 11
ata4: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xC808 irq 11
ata3: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:00ff
ata3: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
ata3: dev 0 configured for UDMA/133
ata4: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:00ff
ata4: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
ata4: dev 0 configured for UDMA/133
scsi2 : sata_via
scsi3 : sata_via
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
 sda: sda1 sda2
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
 sdb: sdb1 sdb2
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
 sdc: sdc1 sdc2
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
 sdd: sdd1 sdd2
 [events: 00000010]
 [events: 00000010]
 [events: 00000010]
 [events: 00000010]
md: autorun ...
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sdd2 ...
md:  adding sdc2 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2,1>
md: bind<sdc2,2>
md: bind<sdd2,3>
md: bind<sdb2,4>
md: running: <sdb2><sdd2><sdc2><sda2>
md: sdb2's event counter: 00000010
md: sdd2's event counter: 00000010
md: sdc2's event counter: 00000010
md: sda2's event counter: 00000010
md: md0: raid array is not clean -- starting background reconstruction
md0: max total readahead window set to 3072k
md0: 3 data-disks, max readahead per data-disk: 1024k
raid5: device sdb2 operational as raid disk 3
raid5: device sdd2 operational as raid disk 1
raid5: device sdc2 operational as raid disk 0
raid5: device sda2 operational as raid disk 2
raid5: allocated 4330kB for md0
raid5: raid level 5 set md0 active with 4 out of 4 devices, algorithm 0
raid5: raid set md0 not clean; reconstructing parity
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:sdc2
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdd2
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sda2
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:sdb2
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:sdc2
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdd2
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sda2
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:sdb2
md: updating md0 RAID superblock on device
md: sdb2 [events: 00000011]<6>(write) sdb2's sb offset: 152191680
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
md: using 124k window, over a total of 152191488 blocks.
md: sdd2 [events: 00000011]<6>(write) sdd2's sb offset: 152191680
md: sdc2 [events: 00000011]<6>(write) sdc2's sb offset: 152191680
md: sda2 [events: 00000011]<6>(write) sda2's sb offset: 152191680
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
XFS mounting filesystem md(9,0)
Ending clean XFS mount for filesystem: md(9,0)

