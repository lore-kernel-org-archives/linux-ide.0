From: David Greaves <david@dgreaves.com>
Subject: Promise Ultra100TX2 PDC20286 broken in 2.6.0-test9
Date: Sat, 08 Nov 2003 20:25:41 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FAD5145.5040603@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:5636 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S263101AbTKHUZr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Nov 2003 15:25:47 -0500
Received: from modem-431.hyena.dialup.pol.co.uk ([81.78.113.175] helo=oak.dgreaves.com)
	by mail18.svr.pol.co.uk with esmtp (Exim 4.14)
	id 1AIZdv-00033T-O3
	for linux-ide@vger.kernel.org; Sat, 08 Nov 2003 20:25:12 +0000
Received: from 80.dgreaves.com ([10.0.0.80] helo=dgreaves.com)
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1AIadm-0006vP-ES
	for linux-ide@vger.kernel.org; Sat, 08 Nov 2003 21:29:06 +0000
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Repost to linux-ide so I've quoted the entire message.
(please cc me in replies:  lkml at dgreaves.com)

Summary:
PDC20286 fails horribly with 2 UDMA drives on its primary channel
If I move one drive to the second channel it seems OK.


I have compiled with and without "DMA on by default".
I've also used the autotune options (and ata66)
I looked for the most conservative config I could find before posting 
(well, I thought I did) :)

ok...
I tried again with:
* DMA on by default (IDEDMA_PCI_AUTO) (done a partial config dump later...)
* removed noapic and used both autotune options (not tried before)
  kernel /vmlinuz-2.6.0-test9 ro root=/dev/hdc3 ide2=autotune 
ide3=autotune single
 
Result:
same problem with this dmesg (text continues after this dmesg dump)
/##########//##########//##########//##########//##########//##########
//[root@willow root]# cat dmesg_pdc20268_problem_for_bart
Linux version 2.6.0-test9 (root@willow) (gcc version 2.96 20000731 (Red 
Hat Linux 7.3 2.96-110)) #5 Sat Nov 8 19:10:59 GMT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010ff0000 (usable)
 BIOS-e820: 0000000010ff0000 - 0000000010ff3000 (ACPI NVS)
 BIOS-e820: 0000000010ff3000 - 0000000011000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
271MB LOWMEM available.
On node 0 totalpages: 69616
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 65520 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Building zonelist for node : 0
Kernel command line: ro root=/dev/hdc3 ide2=autotune ide3=autotune single
ide_setup: ide2=autotune
ide_setup: ide3=autotune
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 451.101 MHz processor.
Console: colour VGA+ 80x25
Memory: 271812k/278464k available (2116k kernel code, 5936k reserved, 
750k data, 120k init, 0k highmem)
Calibrating delay loop... 888.83 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 008021bf 808029bf 00000000 00000000
CPU:     After vendor identify, caps: 008021bf 808029bf 00000000 00000000
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU:     After all inits, caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb480, last bus=1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc0c0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc0e8, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0586] at 0000:00:07.0
Machine check exception polling timer started.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
SGI XFS for Linux with no debug enabled
Activating ISA DMA hang workarounds.
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST320420A, ATA DISK drive
hdb: YAMAHA CRW8424E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IBM-DTLA-305040, ATA DISK drive
hdd: IC35L060AVVA07-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20268: IDE controller at PCI slot 0000:00:09.0
PCI: Found IRQ 10 for device 0000:00:09.0
PDC20268: chipset revision 2
PDC20268: ROM enabled at 0xe8000000
PDC20268: 100% native mode on irq 10
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD800JB-00ETA0, ATA DISK drive
hdf: WDC WD800JB-00ETA0, ATA DISK drive
hdf: set_drive_speed_status: status=0xff { Busy }
Warning: Primary channel requires an 80-pin cable for operation.
hdf reduced to Ultra33 mode.
hdf: set_drive_speed_status: status=0xff { Busy }
ide2 at 0xd800-0xd807,0xdc02 on irq 10
hda: max request size: 128KiB
hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63, UDMA(33)
 hda: hda1 hda2
hdc: max request size: 128KiB
hdc: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=65535/16/63, UDMA(33)
 hdc: hdc1 hdc2 hdc3
hdd: max request size: 128KiB
hdd: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(33)
 hdd: hdd1
hde: max request size: 1024KiB
hde: status timeout: status=0xff { Busy }

hde: drive not ready for command
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63, 
UDMA(100)
hde: status timeout: status=0xff { Busy }

hde: drive not ready for command
 hde:hde: status timeout: status=0xff { Busy }

hde: DMA disabled
hdf: DMA disabled
PDC202XX: Primary channel reset.
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }

PDC202XX: Primary channel reset.
hde: drive not ready for command
ide2: reset timed-out, status=0xff
end_request: I/O error, dev hde, sector 0
Buffer I/O error on device hde, logical block 0
end_request: I/O error, dev hde, sector 0
Buffer I/O error on device hde, logical block 0
 unable to read partition table
hdf: max request size: 1024KiB
hdf: status timeout: status=0xff { Busy }

hdf: drive not ready for command
hdf: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63
hdf: status timeout: status=0xff { Busy }

hdf: drive not ready for command
 hdf:hdf: status timeout: status=0xff { Busy }

PDC202XX: Primary channel reset.
hdf: drive not ready for command
ide2: reset timed-out, status=0xff
hdf: status timeout: status=0xff { Busy }

PDC202XX: Primary channel reset.
hdf: drive not ready for command
ide2: reset timed-out, status=0xff
end_request: I/O error, dev hdf, sector 0
Buffer I/O error on device hdf, logical block 0
end_request: I/O error, dev hdf, sector 0
Buffer I/O error on device hdf, logical block 0
 unable to read partition table
end_request: I/O error, dev hdb, sector 0
hdb: ATAPI 24X CD-ROM CD-R/RW drive, 4096kB Cache
Uniform CD-ROM driver Revision: 3.12
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 
19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: 
CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1544:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:531:udf_vrs: Starting at sector 16 (2048 
byte sectors)
UDF-fs: No VRS found
XFS mounting filesystem hdc3
Ending clean XFS mount for filesystem: hdc3
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 120k freed
Adding 512056k swap on /dev/hdc2.  Priority:-1 extents:1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
XFS mounting filesystem hdd1
Ending clean XFS mount for filesystem: hdd1
XFS mounting filesystem hdc1
Ending clean XFS mount for filesystem: hdc1
XFS mounting filesystem hda2
Ending clean XFS mount for filesystem: hda2
hdb: DMA disabled
//##########//##########//##########//##########//##########//##########
/
You asked why are both drives on one channel - I only had one 80-strand 
cable to hand!
Also one drive is mounted rw and used - the other is ro and contains 
rsync snapshots so is only used in the wee small hours.
...but I dug another cable from another machine and tried that.
The disks were jumpered "master w/ slave" and "slave"
I moved them both to "master w/ slave"  and the BIOS didn't recognise them
I jumpered them both as "single master" and the BIOS saw them.

***I rebooted the same kernel/params and it worked.***

/##########//##########//##########//##########//##########//##########
/[root@willow root]# cat dmesg_pdc20268_problem_for_bart_2channel
Linux version 2.6.0-test9 (root@willow) (gcc version 2.96 20000731 (Red 
Hat Linux 7.3 2.96-110)) #5 Sat Nov 8 19:10:59 GMT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010ff0000 (usable)
 BIOS-e820: 0000000010ff0000 - 0000000010ff3000 (ACPI NVS)
 BIOS-e820: 0000000010ff3000 - 0000000011000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
271MB LOWMEM available.
On node 0 totalpages: 69616
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 65520 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Building zonelist for node : 0
Kernel command line: ro root=/dev/hdc3 ide2=autotune ide3=autotune single
ide_setup: ide2=autotune
ide_setup: ide3=autotune
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 451.085 MHz processor.
Console: colour VGA+ 80x25
Memory: 271812k/278464k available (2116k kernel code, 5936k reserved, 
750k data, 120k init, 0k highmem)
Calibrating delay loop... 888.83 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 008021bf 808029bf 00000000 00000000
CPU:     After vendor identify, caps: 008021bf 808029bf 00000000 00000000
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU:     After all inits, caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb480, last bus=1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc0c0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc0e8, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0586] at 0000:00:07.0
Machine check exception polling timer started.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
SGI XFS for Linux with no debug enabled
Activating ISA DMA hang workarounds.
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST320420A, ATA DISK drive
hdb: YAMAHA CRW8424E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IBM-DTLA-305040, ATA DISK drive
hdd: IC35L060AVVA07-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20268: IDE controller at PCI slot 0000:00:09.0
PCI: Found IRQ 10 for device 0000:00:09.0
PDC20268: chipset revision 2
PDC20268: ROM enabled at 0xe8000000
PDC20268: 100% native mode on irq 10
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD800JB-00ETA0, ATA DISK drive
ide2 at 0xd800-0xd807,0xdc02 on irq 10
hdg: WDC WD800JB-00ETA0, ATA DISK drive
ide3 at 0xe000-0xe007,0xe402 on irq 10
hda: max request size: 128KiB
hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63, UDMA(33)
 hda: hda1 hda2
hdc: max request size: 128KiB
hdc: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=65535/16/63, UDMA(33)
 hdc: hdc1 hdc2 hdc3
hdd: max request size: 128KiB
hdd: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(33)
 hdd: hdd1
hde: max request size: 1024KiB
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63, 
UDMA(100)
 hde: hde1
hdg: max request size: 1024KiB
hdg: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63, 
UDMA(100)
 hdg: hdg1
end_request: I/O error, dev hdb, sector 0
hdb: ATAPI 24X CD-ROM CD-R/RW drive, 4096kB Cache
Uniform CD-ROM driver Revision: 3.12
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 
19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: 
CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1544:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:531:udf_vrs: Starting at sector 16 (2048 
byte sectors)
UDF-fs: No VRS found
XFS mounting filesystem hdc3
Ending clean XFS mount for filesystem: hdc3
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 120k freed
Adding 512056k swap on /dev/hdc2.  Priority:-1 extents:1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
XFS mounting filesystem hdd1
Ending clean XFS mount for filesystem: hdd1
XFS mounting filesystem hdc1
Ending clean XFS mount for filesystem: hdc1
XFS mounting filesystem hda2
Ending clean XFS mount for filesystem: hda2
XFS mounting filesystem hde1
Ending clean XFS mount for filesystem: hde1
/##########//##########//##########//##########//##########//##########///

For the hell of it I tried it without the autotune parameters and it was 
still fine...
It looks like something doesn't work with 2 drives on 1 channel.

Also does this help?
[root@willow linux-2.6.0-test9]# grep -E "BLK_DEV|IDE" .config
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
# Please see Documentation/ide.txt for help/info on IDE drives
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set
# IDE chipset support/bugfixes
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_ONLYDISK=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_IVB=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_SD is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_BLK_DEV_MD=m
CONFIG_BLK_DEV_DM=m
# CONFIG_VIDEO_DEV is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_TRIDENT is not set
# CONFIG_SND_TRIDENT is not set



David


> Hi,
>
> Can you try "ide2=autotune ide3=autotune" boot parameters?
>
> Promise driver is not autotuning PIO modes by default (will be fixed soon,
> needs some more testing). You are hitting it only in 2.6.0-t9 because 
> you've
> compiled kernel without "DMA on by default" (guess based on your dmesg),
> plus in 2.4.18 you are passing "ide2=autotune" parameter.
>
> Off-topic: you have two drives on the first channel, second channel is 
> free.
> Why not move one of drives to the second channel?
>
> Please post ide bugreports on linux-ide@xxxxxxxxxxxxxxx next time.
>
> thanks,
> --bartlomiej
>
> On Saturday 08 of November 2003 17:51, David Greaves wrote:
> >/ Summary: The Promise Ultra100TX2 doesn't work for me in 2.6.0-test9 -/
> >/ but it is fine with 2.4.18xfs/
> >
> >/ (First posting to lkml - hopefully got enough info and this will be/
> >/ helpful - let me know if you need more.)/
> >/ I've been googling, recompiling and trying for 12 hours now so I've 
> seen/
> >/ a lot of stuff about the promise drivers :)/
> >
> >/ My basic system is RedHat 7.3 with XFS. The kernel is non std (has 
> XFS +/
> >/ misc ACL patch) 2.4.18/
> >
> >/ I am using the 80pin cable supplied with the Promise./
> >/ I've tried the 'noapic' option (and config'ed without any power/
> >/ management) as Alan Cox suggested/
> >
> >/ Below is trimmed dmesg from 2.4.18 and complete dmesg from 2.6.0-test9/
> >
> >/ Please cc lkml at dgreaves.com in replies./
> >
> >/ grub for 2.4.18: kernel /vmlinuz-2.4.18-4SGI_XFS_1.1customIDE ro/
> >/ root=/dev/hdc3 ide2=ata66 ide2=autotune/
> >/ (Relevant bit from 2.4.18 dmesg:/
> >/ #########################/
> >/ Uniform Multi-Platform E-IDE driver Revision: 6.31/
> >/ ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx/
> >/ VP_IDE: IDE controller on PCI bus 00 dev 39/
> >/ VP_IDE: chipset revision 6/
> >/ VP_IDE: not 100% native mode: will probe irqs later/
> >/ VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1/
> >/ ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA/
> >/ ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA/
> >/ PDC20268: IDE controller on PCI bus 00 dev 48/
> >/ PCI: Found IRQ 10 for device 00:09.0/
> >/ PDC20268: chipset revision 2/
> >/ PDC20268: not 100% native mode: will probe irqs later/
> >/ PDC20268: ROM enabled at 0xe8000000/
> >/ PDC20268: ATA-66/100 forced bit set (WARNING)!!/
> >/ ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio/
> >/ ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio/
> >/ hda: ST320420A, ATA DISK drive/
> >/ hdb: YAMAHA CRW8424E, ATAPI CD/DVD-ROM drive/
> >/ hdc: IBM-DTLA-305040, ATA DISK drive/
> >/ hdd: IC35L060AVVA07-0, ATA DISK drive/
> >/ hde: WDC WD800JB-00ETA0, ATA DISK drive/
> >/ hdf: WDC WD800JB-00ETA0, ATA DISK drive/
> >/ ide0 at 0x1f0-0x1f7,0x3f6 on irq 14/
> >/ ide1 at 0x170-0x177,0x376 on irq 15/
> >/ ide2 at 0xd800-0xd807,0xdc02 on irq 10/
> >/ hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=2480/255/63, 
> UDMA(33)/
> >/ hdc: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=79780/16/63, 
> UDMA(33)/
> >/ hdd: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63,/
> >/ UDMA(33)/
> >/ blk: queue c02ebdec, I/O limit 4095Mb (mask 0xffffffff)/
> >/ hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/255/63,/
> >/ UDMA(100)/
> >/ blk: queue c02ebf38, I/O limit 4095Mb (mask 0xffffffff)/
> >/ hdf: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/255/63,/
> >/ UDMA(100)/
> >/ Partition check:/
> >/ hda: hda1 hda2/
> >/ hdc: hdc1 hdc2 hdc3/
> >/ hdd: hdd1/
> >/ hde: hde1/
> >/ hdf: hdf1/
> >/ [snip]/
> >/ md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27/
> >/ XFS mounting filesystem ide0(3,1)/
> >/ XFS mounting filesystem ide1(22,65)/
> >/ XFS mounting filesystem ide1(22,1)/
> >/ XFS mounting filesystem ide0(3,2)/
> >/ XFS mounting filesystem ide2(33,1)/
> >/ XFS mounting filesystem ide2(33,65)/
> >/ hdb: ATAPI 24X CD-ROM CD-R/RW drive, 4096kB Cache, DMA/
> >/ Uniform CD-ROM driver Revision: 3.12/
> >/ hdb: packet command error: status=0x51 { DriveReady SeekComplete 
> Error }/
> >/ hdb: packet command error: error=0x00/
> >/ hdb: DMA disabled/
> >/ ide0: Speed warnings UDMA 3/4/5 is not functional./
> >/ ide1: Speed warnings UDMA 3/4/5 is not functional./
> >/ ide1: Speed warnings UDMA 3/4/5 is not functional./
> >/ blk: queue c02ebdec, I/O limit 4095Mb (mask 0xffffffff)/
> >/ blk: queue c02ebf38, I/O limit 4095Mb (mask 0xffffffff)/
> >/ #########################/
> >
> >/ and from 2.6.0-test9/
> >/ #########################/
> >/ Linux version 2.6.0-test9 (root@willow) (gcc version 2.96 20000731 
> (Red/
> >/ Hat Linux 7.3 2.96-110)) #2 Sat Nov 8 15:56:56 GMT 2003/
> >/ BIOS-provided physical RAM map:/
> >/ BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)/
> >/ BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)/
> >/ BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)/
> >/ BIOS-e820: 0000000000100000 - 0000000010ff0000 (usable)/
> >/ BIOS-e820: 0000000010ff0000 - 0000000010ff3000 (ACPI NVS)/
> >/ BIOS-e820: 0000000010ff3000 - 0000000011000000 (ACPI data)/
> >/ BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)/
> >/ 271MB LOWMEM available./
> >/ On node 0 totalpages: 69616/
> >/ DMA zone: 4096 pages, LIFO batch:1/
> >/ Normal zone: 65520 pages, LIFO batch:15/
> >/ HighMem zone: 0 pages, LIFO batch:1/
> >/ DMI 2.2 present./
> >/ Building zonelist for node : 0/
> >/ Kernel command line: ro root=/dev/hdc3 noapic single/
> >/ Initializing CPU#0/
> >/ PID hash table entries: 2048 (order 11: 16384 bytes)/
> >/ Detected 451.117 MHz processor./
> >/ Console: colour VGA+ 80x25/
> >/ Memory: 271812k/278464k available (2117k kernel code, 5936k reserved,/
> >/ 753k data, 120k init, 0k highmem)/
> >/ Calibrating delay loop... 888.83 BogoMIPS/
> >/ Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)/
> >/ Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)/
> >/ Mount-cache hash table entries: 512 (order: 0, 4096 bytes)/
> >/ CPU: After generic identify, caps: 008021bf 808029bf 00000000 00000000/
> >/ CPU: After vendor identify, caps: 008021bf 808029bf 00000000 00000000/
> >/ CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)/
> >/ CPU: L2 Cache: 256K (32 bytes/line)/
> >/ CPU: After all inits, caps: 008021bf 808029bf 00000000 00000002/
> >/ CPU: AMD-K6(tm) 3D+ Processor stepping 01/
> >/ Checking 'hlt' instruction... OK./
> >/ POSIX conformance testing by UNIFIX/
> >/ NET: Registered protocol family 16/
> >/ PCI: PCI BIOS revision 2.10 entry at 0xfb480, last bus=1/
> >/ PCI: Using configuration type 1/
> >/ mtrr: v2.0 (20020519)/
> >/ Linux Plug and Play Support v0.97 (c) Adam Belay/
> >/ PnPBIOS: Scanning system for PnP BIOS support.../
> >/ PnPBIOS: Found PnP BIOS installation structure at 0xc00fc0c0/
> >/ PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc0e8, dseg 0xf0000/
> >/ PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver/
> >/ SCSI subsystem initialized/
> >/ drivers/usb/core/usb.c: registered new driver usbfs/
> >/ drivers/usb/core/usb.c: registered new driver hub/
> >/ PCI: Probing PCI hardware/
> >/ PCI: Probing PCI hardware (bus 00)/
> >/ PCI: Using IRQ router VIA [1106/0586] at 0000:00:07.0/
> >/ Machine check exception polling timer started./
> >/ Installing knfsd (copyright (C) 1996 okir@xxxxxxxxxxxx)./
> >/ udf: registering filesystem/
> >/ SGI XFS for Linux with no debug enabled/
> >/ Activating ISA DMA hang workarounds./
> >/ pty: 256 Unix98 ptys configured/
> >/ Linux agpgart interface v0.100 (c) Dave Jones/
> >/ Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing 
> disabled/
> >/ ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A/
> >/ ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A/
> >/ Using anticipatory io scheduler/
> >/ Floppy drive(s): fd0 is 1.44M/
> >/ FDC 0 is a post-1991 82077/
> >/ Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2/
> >/ ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx/
> >/ VP_IDE: IDE controller at PCI slot 0000:00:07.1/
> >/ VP_IDE: chipset revision 6/
> >/ VP_IDE: not 100% native mode: will probe irqs later/
> >/ ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx/
> >/ VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on 
> pci0000:00:07.1/
> >/ ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA/
> >/ ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA/
> >/ hda: ST320420A, ATA DISK drive/
> >/ hdb: YAMAHA CRW8424E, ATAPI CD/DVD-ROM drive/
> >/ ide0 at 0x1f0-0x1f7,0x3f6 on irq 14/
> >/ hdc: IBM-DTLA-305040, ATA DISK drive/
> >/ hdd: IC35L060AVVA07-0, ATA DISK drive/
> >/ ide1 at 0x170-0x177,0x376 on irq 15/
> >/ PDC20268: IDE controller at PCI slot 0000:00:09.0/
> >/ PCI: Found IRQ 10 for device 0000:00:09.0/
> >/ PDC20268: chipset revision 2/
> >/ PDC20268: ROM enabled at 0xe8000000/
> >/ PDC20268: 100% native mode on irq 10/
> >/ ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio/
> >/ ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio/
> >/ hde: WDC WD800JB-00ETA0, ATA DISK drive/
> >/ hdf: WDC WD800JB-00ETA0, ATA DISK drive/
> >/ hdf: set_drive_speed_status: status=0xff { Busy }/
> >/ ide2 at 0xd800-0xd807,0xdc02 on irq 10/
> >/ hda: max request size: 128KiB/
> >/ hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63/
> >/ hda: hda1 hda2/
> >/ hdc: max request size: 128KiB/
> >/ hdc: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=65535/16/63/
> >/ hdc: hdc1 hdc2 hdc3/
> >/ hdd: max request size: 128KiB/
> >/ hdd: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63/
> >/ hdd: hdd1/
> >/ hde: max request size: 1024KiB/
> >/ hde: status timeout: status=0xff { Busy }/
> >
> >/ hde: drive not ready for command/
> >/ hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63/
> >/ hde: status timeout: status=0xff { Busy }/
> >
> >/ hde: drive not ready for command/
> >/ hde:hde: status timeout: status=0xff { Busy }/
> >
> >/ PDC202XX: Primary channel reset./
> >/ hde: drive not ready for command/
> >/ ide2: reset timed-out, status=0xff/
> >/ hde: status timeout: status=0xff { Busy }/
> >
> >/ PDC202XX: Primary channel reset./
> >/ hde: drive not ready for command/
> >/ ide2: reset timed-out, status=0xff/
> >/ end_request: I/O error, dev hde, sector 0/
> >/ Buffer I/O error on device hde, logical block 0/
> >/ end_request: I/O error, dev hde, sector 0/
> >/ Buffer I/O error on device hde, logical block 0/
> >/ unable to read partition table/
> >/ hdf: max request size: 1024KiB/
> >/ hdf: status timeout: status=0xff { Busy }/
> >
> >/ hdf: drive not ready for command/
> >/ hdf: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63/
> >/ hdf: status timeout: status=0xff { Busy }/
> >
> >/ hdf: drive not ready for command/
> >/ hdf:hdf: status timeout: status=0xff { Busy }/
> >
> >/ PDC202XX: Primary channel reset./
> >/ hdf: drive not ready for command/
> >/ ide2: reset timed-out, status=0xff/
> >/ hdf: status timeout: status=0xff { Busy }/
> >
> >/ PDC202XX: Primary channel reset./
> >/ hdf: drive not ready for command/
> >/ ide2: reset timed-out, status=0xff/
> >/ end_request: I/O error, dev hdf, sector 0/
> >/ Buffer I/O error on device hdf, logical block 0/
> >/ end_request: I/O error, dev hdf, sector 0/
> >/ Buffer I/O error on device hdf, logical block 0/
> >/ unable to read partition table/
> >/ end_request: I/O error, dev hdb, sector 0/
> >/ hdb: ATAPI 24X CD-ROM CD-R/RW drive, 4096kB Cache/
> >/ Uniform CD-ROM driver Revision: 3.12/
> >/ drivers/usb/core/usb.c: registered new driver usblp/
> >/ drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver/
> >/ drivers/usb/core/usb.c: registered new driver hid/
> >/ drivers/usb/input/hid-core.c: v2.0:USB HID core driver/
> >/ mice: PS/2 mouse device common for all mice/
> >/ input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1/
> >/ serio: i8042 AUX port at 0x60,0x64 irq 12/
> >/ input: AT Translated Set 2 keyboard on isa0060/serio0/
> >/ serio: i8042 KBD port at 0x60,0x64 irq 1/
> >/ Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25/
> >/ 19:16:36 2003 UTC)./
> >/ request_module: failed /sbin/modprobe -- snd-card-0. error = -16/
> >/ ALSA device list:/
> >/ No soundcards found./
> >/ NET: Registered protocol family 2/
> >/ IP: routing cache hash table of 2048 buckets, 16Kbytes/
> >/ TCP: Hash tables configured (established 32768 bind 32768)/
> >/ NET: Registered protocol family 1/
> >/ UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session:/
> >/ CDROMMULTISESSION not supported: rc=-22/
> >/ UDF-fs DEBUG fs/udf/super.c:1544:udf_fill_super: Multi-session=0/
> >/ UDF-fs DEBUG fs/udf/super.c:531:udf_vrs: Starting at sector 16 (2048/
> >/ byte sectors)/
> >/ UDF-fs: No VRS found/
> >/ XFS mounting filesystem hdc3/
> >/ Ending clean XFS mount for filesystem: hdc3/
> >/ VFS: Mounted root (xfs filesystem) readonly./
> >/ Freeing unused kernel memory: 120k freed/
> >/ Adding 512056k swap on /dev/hdc2. Priority:-1 extents:1/
> >/ md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27/
> >/ XFS mounting filesystem hda1/
> >/ Ending clean XFS mount for filesystem: hda1/
> >/ XFS mounting filesystem hdd1/
> >/ Ending clean XFS mount for filesystem: hdd1/
> >/ XFS mounting filesystem hdc1/
> >/ Ending clean XFS mount for filesystem: hdc1/
> >/ XFS mounting filesystem hda2/
> >/ Ending clean XFS mount for filesystem: hda2/
> >/ hdb: DMA disabled/
> >/ hda: Speed warnings UDMA 3/4/5 is not functional./
> >/ ide1: Speed warnings UDMA 3/4/5 is not functional./
> >/ ide1: Speed warnings UDMA 3/4/5 is not functional./
> >/ end_request: I/O error, dev hde, sector 0/
> >/ hde: set_drive_speed_status: status=0xff { Busy }/
> >/ end_request: I/O error, dev hde, sector 0/
> >/ hde: set_drive_speed_status: status=0xff { Busy }/
> >/ end_request: I/O error, dev hde, sector 0/
> >/ end_request: I/O error, dev hdf, sector 0/
> >/ hdf: set_drive_speed_status: status=0xff { Busy }/
> >/ end_request: I/O error, dev hdf, sector 0/
> >/ hdf: set_drive_speed_status: status=0xff { Busy }/
> >/ end_request: I/O error, dev hdf, sector 0/
>


