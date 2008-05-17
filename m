From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10723] linux 2.6.24 fails to mount ext3 rootfs on FUJITSU MHK2060AT
Date: Sat, 17 May 2008 07:57:26 -0700 (PDT)
Message-ID: <20080517145726.A501B10805E@picon.linux-foundation.org>
References: <bug-10723-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51307 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752965AbYEQO55 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 10:57:57 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4HEvQ7g007227
	for <linux-ide@vger.kernel.org>; Sat, 17 May 2008 07:57:28 -0700
In-Reply-To: <bug-10723-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10723





------- Comment #4 from juergen.kosel@gmx.de  2008-05-17 07:57 -------
Hello,

also hda=nodma makes no difference.
But this time I found out that it is possible to mount the rootfs from the
initramfs busybox comandline as ext2:

Initializing CPU#0
PID hash table entries: 256 (order: 8, 1024 bytes)
Detected 120.687 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 38896k/49152k available (1747k kernel code, 9868k reserved, 711k data,
324k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb3000 - 0xfffff000   ( 304 kB)
    vmalloc : 0xc3800000 - 0xfffb1000   ( 967 MB)
    lowmem  : 0xc0000000 - 0xc3000000   (  48 MB)
      .init : 0xc036a000 - 0xc03bb000   ( 324 kB)
      .data : 0xc02b4d71 - 0xc0366bec   ( 711 kB)
      .text : 0xc0100000 - 0xc02b4d71   (1747 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 242.55 BogoMIPS (lpj=485115)
Security Framework initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
CPU: After generic identify, caps: 000001bf 00000000 00000000 00000000 00000000
00000000 00000000 00000000
Intel Pentium with F0 0F bug - workaround enabled.

CPU: After all inits, caps: 000001bf 00000000 00000000 00000000 00000000
00000000 00000000 00000000
Compat vDSO mapped to ffffe000.
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 0k freed
ACPI: Core revision 20070126
ACPI Exception (tbxface-0629): AE_NO_ACPI_TABLES, While loading namespace from
ACPI tables [20070126]
ACPI: Unable to load the System Description Tables
net_namespace: 64 bytes
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
Time: tsc clocksource has been installed.
system 00:08: iomem range 0x0-0x9ffff could not be reserved
system 00:08: iomem range 0xf0000-0xfffff could not be reserved
system 00:08: iomem range 0x100000-0x2ffffff could not be reserved
system 00:13: ioport range 0x100-0x107 has been reserved
system 00:13: ioport range 0x2a0-0x2a0 has been reserved
system 00:13: ioport range 0x370-0x371 has been reserved
system 00:13: ioport range 0x374-0x374 has been reserved
system 00:13: ioport range 0x400-0x47f has been reserved
system 00:13: ioport range 0x480-0x4ff has been reserved
system 00:13: ioport range 0xcf7-0xcf7 has been reserved
system 00:13: iomem range 0xfffc0000-0xffffffff has been reserved
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 6372k freed
audit: initializing netlink socket (disabled)
audit(1211033382.013:1): initialized
Total HugeTLB memory allocated, 0
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
cpuidle: using governor ladder
cpuidle: using governor menu
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
registered taskstats version 1
Freeing unused kernel memory: 324k freed
input: AT Translated Set 2 keyboard as /class/input/input0
thermal: Unknown symbol acpi_processor_set_thermal_limit
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
OPTI621: IDE controller (0x1045:0xc621 rev 0x12) at  PCI slot 0000:00:14.0
OPTI621: not 100% native mode: will probe irqs later
PCI: Setting latency timer of device 0000:00:14.0 to 64
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
OPTI621: IDE port disabled
Probing IDE interface ide0...
SCSI subsystem initialized
hdb: IRQ probe failed (0xffffefb8)
hdb: IRQ probe failed (0xffffefb8)
libata version 3.00 loaded.
hda: FUJITSU MHK2060AT, ATA DISK drive
hda: host max PIO3 wanted PIO255(auto-tune) selected PIO3
hda: Selected PIO mode 3
ide0: master: address: 1, data: 3, recovery: 3, drdy: 2 [clk]
ide0: slave:  address: 1, data: 1, recovery: 2, drdy: 2 [clk]
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 11733120 sectors (6007 MB) w/512KiB Cache, CHS=12416/15/63
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
swsusp: Marking nosave pages: 000000000009f000 - 0000000000100000
swsusp: Basic memory bitmaps created
swsusp: Basic memory bitmaps freed
JBD: no valid journal superblock found
EXT3-fs: error loading journal.
EXT2-fs warning (device hda1): ext2_fill_super: mounting ext3 filesystem as
ext2
init_special_inode: bogus i_mode (54130)
init_special_inode: bogus i_mode (54130)
init_special_inode: bogus i_mode (54130)
init_special_inode: bogus i_mode (54130)
init_special_inode: bogus i_mode (54130)
init_special_inode: bogus i_mode (54130)
init_special_inode: bogus i_mode (54130)
JBD: no valid journal superblock found
EXT3-fs: error loading journal.
EXT2-fs warning (device hda1): ext2_fill_super: mounting ext3 filesystem as
ext2


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
