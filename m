From: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Mon, 12 Jul 2004 11:15:01 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40F2AAF5.79BEC86B@verizon.net>
References: <40E99531.BDB8D339@verizon.net> <200407072143.07618.bzolnier@elka.pw.edu.pl> <40F04291.434D8AF9@verizon.net> <200407102207.19713.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out005pub.verizon.net ([206.46.170.143]:13498 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S266864AbUGLPPG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jul 2004 11:15:06 -0400
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

Here's the dmesg output:

Linux version 2.4.22-1.2115.nptlBOOT (bhcompile@bugs.devel.redhat.com) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-6)) #1 Wed Oct 29 15:19:13 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000005000000 (usable)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
80MB LOWMEM available.
On node 0 totalpages: 20480
zone(0): 4096 pages.
zone(1): 16384 pages.
zone(2): 0 pages.
DMI not present.
Kernel command line: initrd=initrd.img ramdisk_size=8192 BOOT_IMAGE=vmlinuz rescue
Initializing CPU#0
Detected 132.634 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 264.60 BogoMIPS
Memory: 77860k/81920k available (1264k kernel code, 3672k reserved, 362k data, 108k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfd930, last bus=6
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BIOS EDD facility v0.09 2003-Jan-22, 0 devices found
EDD information not available.
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIXa: IDE controller at PCI slot 00:01.0
PIIXa: chipset revision 2
PIIXa: not 100% native mode: will probe irqs later
PIIXa: neither IDE port enabled (BIOS)
hda: IBM-DARA-209000, ATA DISK drive
hdb: HITACHI CDR-S100, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 12594960 sectors (6449 MB) w/418KiB Cache, CHS=833/240/63
hdb: attached ide-cdrom driver.
hdb: ATAPI 20X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 15:20:47 Oct 29 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 533k freed
VFS: Mounted root (ext2 filesystem).
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
SCSI subsystem driver Revision: 1.00
ISO 9660 Extensions: RRIP_1991A
Unable to identify CD-ROM format.
VFS: Can't find ext2 filesystem on dev loop(7,0).
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
raid5: measuring checksumming speed
   8regs     :   106.400 MB/sec
   32regs    :    97.600 MB/sec
raid5: using function: 8regs (106.400 MB/sec)
md: raid5 personality registered as nr 4
Journalled Block Device driver loaded
LVM version 1.0.5+(22/07/2002) module loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding Swap: 514072k swap-space (priority -1)
