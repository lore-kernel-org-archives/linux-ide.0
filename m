From: John Goerzen <jgoerzen@complete.org>
Subject: Re: Promise IDE controller crashes 2.4.22
Date: Fri, 28 Nov 2003 19:12:55 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031129011255.GB2069@complete.org>
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org> <200311280016.48828.bzolnier@elka.pw.edu.pl> <20031128021253.GA6539@complete.org> <200311281401.32549.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from glockenspiel.complete.org ([69.10.152.57]:40139 "EHLO
	glockenspiel.complete.org") by vger.kernel.org with ESMTP
	id S263584AbTK2BND (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Nov 2003 20:13:03 -0500
Content-Disposition: inline
In-Reply-To: <200311281401.32549.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Fri, Nov 28, 2003 at 02:01:32PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Sorry, it should have been "ide2=dma"...

That doesn't seem to have made much of a difference.  hdparm /dev/hde
still reports DMA being off by default.  Here's the complete dmesg
again:


Linux version 2.4.22 (jgoerzen@heinrich) (gcc version 3.3.2 (Debian)) #3 Sat Oct 25 15:45:50 CDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000018000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
384MB LOWMEM available.
On node 0 totalpages: 98304
zone(0): 4096 pages.
zone(1): 94208 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hdc1 ro rootfstype=ext3 ide2=dma
ide_setup: ide2=dma
Initializing CPU#0
Detected 400.919 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 386700k/393216k available (1137k kernel code, 6132k reserved, 465k data, 76k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0596] at 00:07.0
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c596b (rev 12) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20269: IDE controller at PCI slot 00:08.0
PCI: Found IRQ 11 for device 00:08.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
PDC20269: ROM enabled at 0xe4000000
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
hda: FUJITSU MPE3084AE, ATA DISK drive
hdc: IBM-DTLA-305040, ATA DISK drive
hde: Maxtor 6Y160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xdc02 on irq 11
hda: attached ide-disk driver.
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=1027/255/63
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=79780/16/63
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
 hdc: [PTBL] [5005/255/63] hdc1
 hde: hde1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 76k freed
Adding Swap: 248968k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,1), internal journal
PCI: Found IRQ 12 for device 00:0a.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xec00. Vers LK1.1.18-ac
 00:01:02:43:b1:69, IRQ 12
  product code 4347 rev 00.12 date 03-28-00
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
00:0a.0: scatter/gather enabled. h/w checksums enabled
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
