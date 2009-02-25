From: Andrew Schepler <aschepler@gmail.com>
Subject: 2.6.28.7 boot problems
Date: Wed, 25 Feb 2009 16:46:21 -0500
Message-ID: <40f01080902251346v5f73ed43nacc07bf65c98a727@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:27650 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbZBYVqY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 16:46:24 -0500
Received: by yx-out-2324.google.com with SMTP id 8so173023yxm.1
        for <linux-ide@vger.kernel.org>; Wed, 25 Feb 2009 13:46:22 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, and apologies if this list is an impolite place to ask for help.
(If not, where is better?)

I tried building myself a 2.6.28.7 Linux kernel, but the IDE drivers
seem not to be working.  My hard drive is IDE ATA.  CONFIG_IDE is
built into the kernel.  I've tried both with and without
CONFIG_IDE_GENERIC, but there's not much difference.  The root
partition is ext2 and ext2 is built into the kernel (but it looks like
the kernel's not even seeing any drives or partitions.)

On failed 2.6.28.7 boot, I see the following relevant-looking lines.
I copied these by hand, so there might be a minor typo.  Yes, the
kernel lists no partitions after "available partitions:".
ide-gd driver 1.18
ide-cd driver 5.00
ide_generic: please use "probe_mask=0x3f" module parameter
...
VFS: Cannot open root device "hda3" or unknown-block(0,0)
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

Below is a grep excerpt from my .config, and then a successful dmesg
from kernel 2.6.17.  Can anyone guess what's going wrong?

Many thanks,
-- Andrew

$ grep -Ei 'ide|ata' /usr/src/linux-2.6.28.7/.config
# CONFIG_ATALK is not set
# CONFIG_PARIDE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y
# Please see Documentation/ide/ide.txt for help/info on IDE drives
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
CONFIG_IDE_GD_ATAPI=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y
# IDE chipset support/bugfixes
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_SFF=y
# PCI IDE chipsets support
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_SATA_PMP=y
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y
...
(the rest of the matching lines are not set)

Linux version 2.6.17 (root@schep) (gcc version 4.1.2 20060729
(prerelease) (Debian 4.1.1-10)) #2 Tue Sep 12 20:44:46 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f53f0
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2010.211 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1036424k/1048512k available (1611k kernel code, 11448k
reserved, 499k data, 132k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4023.17 BogoMIPS (lpj=8046357)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000
00000001 00000000 00000001
CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000
00000001 00000000 00000001
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000410
00000001 00000000 00000001
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 02
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb650, last bus=2
Setting up standard PCI resources
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-103f claimed by ali7101 ACPI
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:02.0
PCI: Using IRQ router default [10b9/1689] at 0000:00:00.0
PCI->APIC IRQ transform: 0000:00:04.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:0e.0[A] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:0e.1[A] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:0f.0[A] -> IRQ 20
PCI->APIC IRQ transform: 0000:00:0f.1[B] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:0f.2[C] -> IRQ 22
PCI->APIC IRQ transform: 0000:00:0f.3[D] -> IRQ 24
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:02:07.0[A] -> IRQ 19
PCI->APIC IRQ transform: 0000:02:0a.0[A] -> IRQ 18
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f8000000-faffffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:02.0
  IO window: c000-cfff
  MEM window: fb000000-fcffffff
  PREFETCH window: 50000000-500fffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:00:02.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Real Time Clock Driver v1.12ac
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: Printer, Canon BJC-4300
Floppy drive(s): fd0 is 1.44M, fd1 is 360K PC
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: Maxtor 32049H2, ATA DISK drive
Probing IDE interface ide1...
hdc: ASUS CRW-5232AS, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
        current capacity is 40019519 sectors (20489 MB)
        native  capacity is 40021632 sectors (20491 MB)
hda: Host Protected Area disabled.
hda: 40021632 sectors (20491 MB) w/2048KiB Cache, CHS=39704/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 132k freed
input: AT Translated Set 2 keyboard as /class/input/input0
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
Adding 56216k swap on /dev/hda2.  Priority:-1 extents:1 across:56216k
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 33 at 0001c000, 00:A0:CC:3A:DB:A1, IRQ 19.
SCSI subsystem initialized
loop: loaded (max 8 devices)
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
lp0: using parport0 (polling).
eth0: no IPv6 routers present
...
