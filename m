From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10723] linux 2.6.24 fails to mount ext3 rootfs on FUJITSU MHK2060AT
Date: Sat, 17 May 2008 06:23:31 -0700 (PDT)
Message-ID: <20080517132331.D2AA110805F@picon.linux-foundation.org>
References: <bug-10723-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58148 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753510AbYEQNXe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 09:23:34 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4HDNWXT002055
	for <linux-ide@vger.kernel.org>; Sat, 17 May 2008 06:23:33 -0700
In-Reply-To: <bug-10723-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10723





------- Comment #2 from juergen.kosel@gmx.de  2008-05-17 06:23 -------
ide=nodma doesn't change much. It even still complains about the dma timeouts.

Except that it still fails to mount the rootfs it looks similar to this output
from 2.6.22.3:

Linux version 2.6.22-3-486 (Debian 2.6.22-6) (maks@debian.org) (gcc version
4.1.3 20071019 (prerelease) (Debian 4.1.2-17)) #1 Mon Nov 12 07:53:08 UTC 2007
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000003000000 (usable)
48MB LOWMEM available.
Entering add_active_range(0, 0, 12288) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->    12288
early_node_map[1] active PFN ranges
    0:        0 ->    12288
On node 0 totalpages: 12288
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 64 pages used for memmap
  Normal zone: 8128 pages, LIFO batch:0
DMI not present or invalid.
Allocating PCI resources starting at 10000000 (gap: 03000000:fd000000)
Built 1 zonelists.  Total pages: 12192
Kernel command line: root=/dev/hda1 ro ide=nodma
No local APIC present or hardware disabled
mapped APIC to ffffd000 (01061000)
Initializing CPU#0
PID hash table entries: 256 (order: 8, 1024 bytes)
Detected 120.691 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 39276k/49152k available (1656k kernel code, 9488k reserved, 650k data,
316k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb5000 - 0xfffff000   ( 296 kB)
    vmalloc : 0xc3800000 - 0xfffb3000   ( 967 MB)
    lowmem  : 0xc0000000 - 0xc3000000   (  48 MB)
      .init : 0xc0344000 - 0xc0393000   ( 316 kB)
      .data : 0xc029e27b - 0xc0340cc4   ( 650 kB)
      .text : 0xc0100000 - 0xc029e27b   (1656 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 242.28 BogoMIPS (lpj=484574)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 000001bf 00000000 00000000 00000000 00000000
00000000 00000000
Intel Pentium with F0 0F bug - workaround enabled.

CPU: After all inits, caps: 000001bf 00000000 00000000 00000000 00000000
00000000 00000000
Compat vDSO mapped to ffffe000.
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
ACPI: Core revision 20070126
ACPI Exception (tbxface-0618): AE_NO_ACPI_TABLES, While loading namespace from
ACPI tables [20070126]
ACPI: Unable to load the System Description Tables
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf73d9, last bus=0
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5010
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x1a65, dseg 0xf0000
PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI Error (evxfevnt-0186): Could not enable RealTimeClock event [20070126]
ACPI Warning (evxface-0145): Could not enable fixed event 4 [20070126]
pnp: 00:08: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:08: iomem range 0xf0000-0xfffff could not be reserved
pnp: 00:08: iomem range 0x100000-0x2ffffff could not be reserved
Time: tsc clocksource has been installed.
pnp: 00:13: ioport range 0x100-0x107 has been reserved
pnp: 00:13: ioport range 0x2a0-0x2a0 has been reserved
pnp: 00:13: ioport range 0x370-0x371 has been reserved
pnp: 00:13: iomem range 0xfffc0000-0xffffffff has been reserved
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 6144k freed
audit: initializing netlink socket (disabled)
audit(1211029346.240:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:00:02.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:03: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303,PNP0f0e] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
EISA: Probing bus 0 at eisa.0
Cannot allocate resource for EISA slot 1
EISA: Detected 0 cards.
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Freeing unused kernel memory: 316k freed
input: AT Translated Set 2 keyboard as /class/input/input0
thermal: Unknown symbol acpi_processor_set_thermal_limit
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI subsystem initialized
OPTI621: IDE controller at PCI slot 0000:00:14.0
OPTI621: chipset revision 18
OPTI621: not 100% native mode: will probe irqs later
PCI: Setting latency timer of device 0000:00:14.0 to 64
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
Probing IDE interface ide0...
hda: FUJITSU MHK2060AT, ATA DISK drive
libata version 2.21 loaded.
Floppy drive(s): fd0 is 1.44M
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
FDC 0 is a post-1991 82077
hda: max request size: 128KiB
hda: 11733120 sectors (6007 MB) w/512KiB Cache, CHS=12416/15/63, (U)DMA
hda: cache flushes not supported
 hda:<4>hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
 hda1 hda2 <<4>hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
 hda5<4>hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
 hda6 >
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
Attempting manual resume
swsusp: Basic memory bitmaps created
swsusp: Basic memory bitmaps freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
input: PC Speaker as /class/input/input1
parport_pc 00:01: reported by Plug and Play BIOS
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
parport1: PC-style at 0x3bc [PCSPP,TRISTATE]
Real Time Clock Driver v1.12ac
input: ImPS/2 Generic Wheel Mouse as /class/input/input2
Adding 75560k swap on /dev/hda5.  Priority:-1 extents:1 across:75560k
EXT3 FS on hda1, internal journal
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised:
dm-devel@redhat.com


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
