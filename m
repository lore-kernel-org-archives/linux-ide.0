From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: RE: IDE Timeout problem on Intel PIIX3 (Triton 2) chipset
Date: Mon, 28 Jun 2004 21:27:59 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040628202759.6202.qmail@web52909.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52909.mail.yahoo.com ([206.190.39.186]:36780 "HELO
	web52909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265212AbUF2BIL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jun 2004 21:08:11 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: meelis.roos@cyber.ee, patrick@dreker.de

> Any kernel above and including 2.4.21 (including
> 2.6.5 and 2.6.7, others not tested) produces the
> following errors quite often (once or twice per
> minute, with the corresponding delay) and the
> harddisk drops out of DMA.

Linux 2.4.26-UP is fine for me here, for both hda and
hdb. This box has 64 MB RAM, amd the kernel is
compiled with gcc-3.2.3.

# lspci
00:00.0 Host bridge: Intel Corp. 430VX - 82437VX TVX
[Triton VX] (rev 02)
00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA
[Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE
[Natoma/Triton II]
00:07.2 USB Controller: Intel Corp. 82371SB PIIX3 USB
[Natoma/Triton II] (rev 01)
00:08.0 VGA compatible controller: ATI Technologies
Inc 3D Rage I/II 215GT [Mach64 GT] (rev 41)
00:0d.0 VGA compatible controller: Matrox Graphics,
Inc. MGA 2164W [Millennium II]
00:0e.0 PCI bridge: Digital Equipment Corporation
DECchip 21152 (rev 03)
00:0f.0 Ethernet controller: Intel Corp. 82557/8/9
[Ethernet Pro 100] (rev 08)
01:04.0 Ethernet controller: Intel Corp. 82557/8/9
[Ethernet Pro 100] (rev 05)
01:05.0 Ethernet controller: Intel Corp. 82557/8/9
[Ethernet Pro 100] (rev 05)

# cat /proc/ide/hda/settings
name                    value           min           
 max             mode
----                    -----           ---           
 ---             ----
acoustic                0               0             
 254             rw
address                 0               0             
 2               rw
bios_cyl                787             0             
 65535           rw
bios_head               128             0             
 255             rw
bios_sect               63              0             
 63              rw
breada_readahead        8               0             
 255             rw
bswap                   0               0             
 1               r
current_speed           34              0             
 70              rw
failures                0               0             
 65535           rw
file_readahead          124             0             
 16384           rw
init_speed              34              0             
 70              rw
io_32bit                3               0             
 3               rw
keepsettings            0               0             
 1               rw
lun                     0               0             
 7               rw
max_failures            1               0             
 65535           rw
max_kb_per_request      128             1             
 255             rw
multcount               16              0             
 16              rw
nice1                   1               0             
 1               rw
nowerr                  0               0             
 1               rw
number                  0               0             
 3               rw
pio_mode                write-only      0             
 255             w
slow                    0               0             
 1               rw
unmaskirq               1               0             
 1               rw
using_dma               1               0             
 1               rw
wcache                  0               0             
 1               rw

# cat /proc/ide/hdb/settings
name                    value           min           
 max             mode
----                    -----           ---           
 ---             ----
acoustic                0               0             
 254             rw
address                 0               0             
 2               rw
bios_cyl                667             0             
 65535           rw
bios_head               240             0             
 255             rw
bios_sect               63              0             
 63              rw
breada_readahead        8               0             
 255             rw
bswap                   0               0             
 1               r
current_speed           0               0             
 70              rw
failures                0               0             
 65535           rw
file_readahead          124             0             
 16384           rw
init_speed              0               0             
 70              rw
io_32bit                3               0             
 3               rw
keepsettings            0               0             
 1               rw
lun                     0               0             
 7               rw
max_failures            1               0             
 65535           rw
max_kb_per_request      128             1             
 255             rw
multcount               16              0             
 16              rw
nice1                   1               0             
 1               rw
nowerr                  0               0             
 1               rw
number                  1               0             
 3               rw
pio_mode                write-only      0             
 255             w
slow                    0               0             
 1               rw
unmaskirq               1               0             
 1               rw
using_dma               1               0             
 1               rw
wcache                  0               0             
 1               rw

# uptime
 21:21:38 up 75 days, 1 min,  5 users,  load average:
0.00, 0.00, 0.00

Uniform Multi-Platform E-IDE driver Revision:
7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
PIIX3: IDE controller at PCI slot 00:07.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xefa0-0xefa7, BIOS settings:
hda:pio, hdb:pio
    ide1: BM-DMA at 0xefa8-0xefaf, BIOS settings:
hdc:pio, hdd:pio
hda: WDC AC33200L, ATA DISK drive
hdb: WDC AC35100L, ATA DISK drive
blk: queue c02b5080, I/O limit 4095Mb (mask
0xffffffff)
blk: queue c02b51bc, I/O limit 4095Mb (mask
0xffffffff)
hdc: TOSHIBA CD-ROM XM-6002B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: task_no_data_intr: status=0x51 { DriveReady
SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError
}
hda: 6346368 sectors (3249 MB) w/256KiB Cache,
CHS=787/128/63, DMA
hdb: attached ide-disk driver.
hdb: task_no_data_intr: status=0x51 { DriveReady
SeekComplete Error }
hdb: task_no_data_intr: error=0x04 { DriveStatusError
}
hdb: host protected area => 1
hdb: 10085040 sectors (5164 MB) w/256KiB Cache,
CHS=667/240/63, (U)DMA
Partition check:
 hda: hda1 hda2 hda3
 hdb: hdb1 hdb2 hdb3 hdb4

# cat /proc/interrupts
           CPU0
  0:  648044291          XT-PIC  timer
  1:       6916          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:      27998          XT-PIC  serial
  9:        385          XT-PIC  usb-uhci
 10:   13465208          XT-PIC  eth2, eth0
 11:     604729          XT-PIC  eth1
 14:    4091193          XT-PIC  ide0
 15:         36          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0

Cheers,
Chris



	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - sooooo many all-new ways to express yourself http://uk.messenger.yahoo.com
