From: "Christopher R. Thompson" <Christoffur050@Verizon.Net>
Subject: Re: ICH5 in 2.4.29-pre2
Date: Thu, 23 Dec 2004 00:07:01 -0800
Message-ID: <41CA7CA5.5070009@Verizon.Net>
References: <41C341A4.9010401@Verizon.Net> <41C9D5AA.70804@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030002030700050408000802"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out007pub.verizon.net ([206.46.170.107]:40897 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261175AbULWIHH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Dec 2004 03:07:07 -0500
Received: from Verizon.Net ([4.27.2.67]) by out007.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20041223080701.HCDY27681.out007.verizon.net@Verizon.Net>
          for <linux-ide@vger.kernel.org>; Thu, 23 Dec 2004 02:07:01 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030002030700050408000802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok. It looks like 2.4.29-pre2 is basically working for me. I got 
/dev/sda3 to mount and was able to do stuff to the disk. I have some 
problems with the RedHat Junk screwing with my fstab (I think) 'cause it 
still thinks that /dev/sda3 is /dev/hda3.
Probably 'cause I forgot to delete /etc/mtab or something.

The weird thing is when booting with loadlin. When I boot from the 
autoexec.bat file under win98 the initrd file extends beyond the end of 
memory, and the scsi card fails to initialize..

When I drop to dos and boot from a regular batch file using the same 
loadlin instructions... initrd loads just fine.

The only problem is when we load the ide-scsi driver module for the 
dvd-writer. Then the system hangs.

I've attached several syslogs together if anyone is interested.

I'll try not-loading the ide-scsi driver at boot-time to get around the 
dvd-writer, and see if I can load it after the system is up and running.

-- 
Regards from,
Christopher R. Thompson
Student of Mechanical Engineering
California State Polytechnic University, Pomona
home: http://www.csupomona.edu/~cthompson1/



--------------030002030700050408000802
Content-Type: text/plain;
 name="2-4-29-compiled-in.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2-4-29-compiled-in.log"


*
*** Booted "Linux8" from win98se autoexec.bat ie: "loadlin @C:\linux8" ***
*
*** Note that aic7xxx is mia??? ****
*
*** Native Mode Bios Config
*
*** initrd extends beyond end of memory
*

Linux version 2.4.29-pre2-Sharlie-two (root@Sharlie.TfJC) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #11 Wed Dec 22 19:28:50 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e8000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000003ffb0000 (usable)
 user: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 user: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 user: 000000003fff0000 - 0000000040000000 (reserved)
 user: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
initrd extends beyond end of memory (0x3ffffc93 > 0x38000000)
disabling initrd
On node 0 totalpages: 262064
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32688 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  Product ID: P4P800SE     APIC at: 0xFEE00000
I/O APIC #13 Version 32 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
SMP mptable: no processors registered!
BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Kernel command line: mem=1024mb root=/dev/sda3 rw console=tty0 console=ttyS0,115200n8 idebus=66 hdd=ide-scsi BOOT_IMAGE=bzi2429.2
ide_setup: idebus=66
ide_setup: hdd=ide-scsi
Found and enabled local APIC!
Initializing CPU#0
Detected 3198.575 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 6383.20 BogoMIPS
Memory: 1033316k/1048256k available (1261k kernel code, 14552k reserved, 497k data, 116k init, 130752k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3198.4973 MHz.
..... host bus clock speed is 199.9060 MHz.
cpu: 0, clocks: 1999060, slice: 999530
CPU0<T0:1999056,T1:999520,D:6,S:999530,C:1999060>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV10 framebuffer ver 0.9.4 (GeForce2-MX, 64MB @ 0xE8000000)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 66MHz system bus speed for PIO modes
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: 100% native mode on irq 11
    ide0: BM-DMA at 0xef90-0xef97, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xef98-0xef9f, BIOS settings: hdc:pio, hdd:DMA
hdc: Maxtor 4R120L4, ATA DISK drive
hdd: GENERIC DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
blk: queue c0317bb4, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0xefa8-0xefaf,0xefe2 on irq 11
Partition check:
 hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
 unable to read partition table
SCSI subsystem driver Revision: 1.00
ata1: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEF8E bmdma 0xEF60 irq 11
ata2: SATA max UDMA/133 cmd 0xEF80 ctl 0xEF8A bmdma 0xEF68 irq 11
ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi0 : ata_piix
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
 sda: sda1 sda2 sda3
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
 sdb: sdb1 sdb2
Linux video capture interface: v1.00
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 116k freed
INIT: version 2.84 booting
		Welcome to Red Hat Linux
		Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Setting clock  (localtime): Wed Dec 22 21:53:18 PST 2004 [  OK  ]
Setting hostname Sharlie.TfJC:  [  OK  ]
Initializing USB controller (ehci-hcd):  [  OK  ]
Initializing USB controller (usb-uhci):  [  OK  ]
Mounting USB filesystem:  [  OK  ]
Initializing USB HID interface:  modprobe: Can't locate module hid
[FAILED]
Initializing USB keyboard:  modprobe: Can't locate module keybdev
[FAILED]
Initializing USB mouse:  modprobe: Can't locate module mousedev
[FAILED]
Checking root filesystem
/dev/sda3 is mounted.  [/sbin/fsck.ext2 (1) -- /] fsck.ext2 -a /dev/sda3 
e2fsck: Cannot continue, aborting.


[FAILED]

*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.
Give root password for maintenance
(or type Control-D for normal startup): 

*** Looks good here except for old fstab entries *** modified and rebooted ***

Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda3             78289508  43456020  30856600  59% /
none                         0         0         0   -  /proc
usbdevfs                     0         0         0   -  /proc/bus/usb
none                  78289508  43456020  30856600  59% /dev/pts
none                  78289508  43456020  30856600  59% /dev/shm
/dev/sdb1             78289508  43456020  30856600  59% /linux2
/dev/sda1             78289508  43456020  30856600  59% /cdrive
/NOAA/NOAA_OE.iso     78289508  43456020  30856600  59% /NOAA/ExplorerCD
usbdevfs                     0         0         0   -  /proc/bus/usb
Sending all processes the TERM signal... 
Sending all processes the KILL signal... 
Syncing hardware clock to system time 
Turning off quotas:  
umount2: Invalid argument
umount: /NOAA/NOAA_OE.iso: not mounted
umount: /NOAA/ExplorerCD: Illegal seek
umount2: Invalid argument
umount: /dev/sda1: not mounted
umount2: Invalid argument
umount: /dev/sdb1: not mounted
umount2: Invalid argument
umount: none: not found
umount: /dev/shm: not mounted
umount2: Invalid argument
umount: none: not found
umount: /dev/pts: not mounted
umount2: Invalid argument
umount: usbdevfs: not found
umount: /proc/bus/usb: not mounted
Please stand by while rebooting the system...
Restarting system.

*
*** Booted from dos linux8.bat ie: "loadlin @c:\linux8" ***
*
*** Note that aic7xxx is loaded here but not above ***
*
*** Same initrd file is used for both boots!!!! ***
*

Linux version 2.4.29-pre2-Sharlie-two (root@Sharlie.TfJC) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #11 Wed Dec 22 19:28:50 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e8000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000003ffb0000 (usable)
 user: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 user: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 user: 000000003fff0000 - 0000000040000000 (reserved)
 user: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262064
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32688 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  Product ID: P4P800SE     APIC at: 0xFEE00000
I/O APIC #13 Version 32 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
SMP mptable: no processors registered!
BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Kernel command line: mem=1024mb root=/dev/sda3 rw console=tty0 console=ttyS0,115200n8 idebus=66 hdd=ide-scsi BOOT_IMAGE=bzi2429.2
ide_setup: idebus=66
ide_setup: hdd=ide-scsi
Found and enabled local APIC!
Initializing CPU#0
Detected 3198.573 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 6383.20 BogoMIPS
Memory: 1032824k/1048256k available (1261k kernel code, 15044k reserved, 497k data, 116k init, 130752k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3198.4974 MHz.
..... host bus clock speed is 199.9059 MHz.
cpu: 0, clocks: 1999059, slice: 999529
CPU0<T0:1999056,T1:999520,D:7,S:999529,C:1999059>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV10 framebuffer ver 0.9.4 (GeForce2-MX, 64MB @ 0xE8000000)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 66MHz system bus speed for PIO modes
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: 100% native mode on irq 11
    ide0: BM-DMA at 0xef90-0xef97, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xef98-0xef9f, BIOS settings: hdc:pio, hdd:DMA
hdc: Maxtor 4R120L4, ATA DISK drive
hdd: GENERIC DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
blk: queue c0317bb4, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0xefa8-0xefaf,0xefe2 on irq 11
Partition check:
 hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
 unable to read partition table
SCSI subsystem driver Revision: 1.00
ata1: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEF8E bmdma 0xEF60 irq 11
ata2: SATA max UDMA/133 cmd 0xEF80 ctl 0xEF8A bmdma 0xEF68 irq 11
ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi0 : ata_piix
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
 sda: sda1 sda2 sda3
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
 sdb: sdb1 sdb2
Linux video capture interface: v1.00
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 491k freed
VFS: Mounted root (ext2 filesystem).
Red Hat nash version 3.4.28 starting
Loading aic7xxx module
scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940A Ultra SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

blk: queue f7ec8994, I/O limit 4095Mb (mask 0xffffffff)
(scsi2:A:0): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: SEAGATE   Model: ST15230W          Rev: 0298
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7ec8a94, I/O limit 4095Mb (mask 0xffffffff)
(scsi2:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: SEAGATE   Model: ST15230W          Rev: 0298
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7ec8b94, I/O limit 4095Mb (mask 0xffffffff)
scsi2:A:0:0: Tagged Queuing enabled.  Depth 32
scsi2:A:1:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Attached scsi disk sdd at scsi2, channel 0, id 1, lun 0
SCSI device sdc: 8386733 512-byte hdwr sectors (4294 MB)
 sdc: sdc1 sdc2 sdc3
SCSI device sdd: 8386733 512-byte hdwr sectors (4294 MB)
 sdd: sdd1 sdd2
Loading ide-scsi module
hdd: attached ide-scsi driver.
scsi3 : SCSI host adapter emulation for IDE ATAPI devices

*
*** System Hang *** <ctl-alt-delete> unresponsive *** <pg-up><pg-down> unresponsive *** <sys-req> unresponsive ***
*


*
*** Booted from dos linux8.bat ie: "Loadlin @c:\linux8"
*
*** Same as before except delete bootparam hdd=ide-scsi
*

Linux version 2.4.29-pre2-Sharlie-two (root@Sharlie.TfJC) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #11 Wed Dec 22 19:28:50 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e8000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000003ffb0000 (usable)
 user: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 user: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 user: 000000003fff0000 - 0000000040000000 (reserved)
 user: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262064
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32688 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  Product ID: P4P800SE     APIC at: 0xFEE00000
I/O APIC #13 Version 32 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
SMP mptable: no processors registered!
BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Kernel command line: mem=1024mb root=/dev/sda3 rw console=tty0 console=ttyS0,115200n8 idebus=66 BOOT_IMAGE=bzi2429.2
ide_setup: idebus=66
Found and enabled local APIC!
Initializing CPU#0
Detected 3198.573 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 6383.20 BogoMIPS
Memory: 1032824k/1048256k available (1261k kernel code, 15044k reserved, 497k data, 116k init, 130752k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3198.4965 MHz.
..... host bus clock speed is 199.9059 MHz.
cpu: 0, clocks: 1999059, slice: 999529
CPU0<T0:1999056,T1:999520,D:7,S:999529,C:1999059>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV10 framebuffer ver 0.9.4 (GeForce2-MX, 64MB @ 0xE8000000)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 66MHz system bus speed for PIO modes
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: 100% native mode on irq 11
    ide0: BM-DMA at 0xef90-0xef97, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xef98-0xef9f, BIOS settings: hdc:pio, hdd:DMA
hdc: Maxtor 4R120L4, ATA DISK drive
hdd: GENERIC DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
blk: queue c0317bb4, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0xefa8-0xefaf,0xefe2 on irq 11
Partition check:
 hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
 unable to read partition table
SCSI subsystem driver Revision: 1.00
ata1: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEF8E bmdma 0xEF60 irq 11
ata2: SATA max UDMA/133 cmd 0xEF80 ctl 0xEF8A bmdma 0xEF68 irq 11
ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi0 : ata_piix
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
 sda: sda1 sda2 sda3
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
 sdb: sdb1 sdb2
Linux video capture interface: v1.00
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 491k freed
VFS: Mounted root (ext2 filesystem).
Red Hat nash version 3.4.28 starting
Loading aic7xxx module
scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940A Ultra SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

blk: queue f7ec8994, I/O limit 4095Mb (mask 0xffffffff)
(scsi2:A:0): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: SEAGATE   Model: ST15230W          Rev: 0298
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7ec8a94, I/O limit 4095Mb (mask 0xffffffff)
(scsi2:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: SEAGATE   Model: ST15230W          Rev: 0298
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7ec8b94, I/O limit 4095Mb (mask 0xffffffff)
scsi2:A:0:0: Tagged Queuing enabled.  Depth 32
scsi2:A:1:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Attached scsi disk sdd at scsi2, channel 0, id 1, lun 0
SCSI device sdc: 8386733 512-byte hdwr sectors (4294 MB)
 sdc: sdc1 sdc2 sdc3
SCSI device sdd: 8386733 512-byte hdwr sectors (4294 MB)
 sdd: sdd1 sdd2
Loading ide-scsi module
hdd: attached ide-scsi driver.
scsi3 : SCSI host adapter emulation for IDE ATAPI devices

*
*** System hang *** Same as before ***
*

*
*** Booted from win98se autoexec.bat ie: "loadlin @c:\linux8"
*
*** Same as first time... no aic7xxx initialization
*
*** Why is "initrd extends beyond end of memory"?
*

Linux version 2.4.29-pre2-Sharlie-two (root@Sharlie.TfJC) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #11 Wed Dec 22 19:28:50 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e8000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000003ffb0000 (usable)
 user: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 user: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 user: 000000003fff0000 - 0000000040000000 (reserved)
 user: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
initrd extends beyond end of memory (0x3ffffc93 > 0x38000000)
disabling initrd
On node 0 totalpages: 262064
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32688 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  Product ID: P4P800SE     APIC at: 0xFEE00000
I/O APIC #13 Version 32 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
SMP mptable: no processors registered!
BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Kernel command line: mem=1024mb root=/dev/sda3 rw console=tty0 console=ttyS0,115200n8 idebus=66 BOOT_IMAGE=bzi2429.2
ide_setup: idebus=66
Found and enabled local APIC!
Initializing CPU#0
Detected 3198.620 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 6383.20 BogoMIPS
Memory: 1033316k/1048256k available (1261k kernel code, 14552k reserved, 497k data, 116k init, 130752k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3198.4973 MHz.
..... host bus clock speed is 199.9059 MHz.
cpu: 0, clocks: 1999059, slice: 999529
CPU0<T0:1999056,T1:999520,D:7,S:999529,C:1999059>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV10 framebuffer ver 0.9.4 (GeForce2-MX, 64MB @ 0xE8000000)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 66MHz system bus speed for PIO modes
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: 100% native mode on irq 11
    ide0: BM-DMA at 0xef90-0xef97, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xef98-0xef9f, BIOS settings: hdc:pio, hdd:DMA
hdc: Maxtor 4R120L4, ATA DISK drive
hdd: GENERIC DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
blk: queue c0317bb4, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0xefa8-0xefaf,0xefe2 on irq 11
Partition check:
 hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
 unable to read partition table
SCSI subsystem driver Revision: 1.00
ata1: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEF8E bmdma 0xEF60 irq 11
ata2: SATA max UDMA/133 cmd 0xEF80 ctl 0xEF8A bmdma 0xEF68 irq 11
ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi0 : ata_piix
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
 sda: sda1 sda2 sda3
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
 sdb: sdb1 sdb2
Linux video capture interface: v1.00
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 116k freed
INIT: version 2.84 booting
		Welcome to Red Hat Linux
		Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Setting clock  (localtime): Wed Dec 22 22:00:41 PST 2004 [  OK  ]
Setting hostname Sharlie.TfJC:  [  OK  ]
Initializing USB controller (ehci-hcd):  [  OK  ]
Initializing USB controller (usb-uhci):  [  OK  ]
Mounting USB filesystem:  [  OK  ]
Initializing USB HID interface:  modprobe: Can't locate module hid
[FAILED]
Initializing USB keyboard:  modprobe: Can't locate module keybdev
[FAILED]
Initializing USB mouse:  modprobe: Can't locate module mousedev
[FAILED]
Checking root filesystem
/dev/sda3 is mounted.  [/sbin/fsck.ext2 (1) -- /] fsck.ext2 -a /dev/sda3 
e2fsck: Cannot continue, aborting.


[FAILED]

*
*** I don't get it *** fstab should be ok
*** but system still thinks that root dev is /dev/hda3 ?
*** I think that I thought that this problem was caused
*** by the scsi card not being initialized
*

*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.
Give root password for maintenance
(or type Control-D for normal startup): 
-rw-r--r--    1 root     root         1879 Dec 22 21:55 fstab
-rw-r--r--    1 root     root         1963 Dec 22 10:26 fstab.hda3.sav
-rw-r--r--    1 root     root            0 Dec 22 10:26 fstab.REVOKE
-rw-r--r--    1 root     root           35 Sep  3  2002 updfstab.conf
-rw-r--r--    1 root     root          852 Oct 30 23:09 updfstab.conf.default

*
*** Put old fstab back and reboot ***
*

INIT: (Repair filesystem) 6 # (Repair filesystem) 6 # Starting killall:  [  OK  ]
Sending all processes the TERM signal... 
Sending all processes the KILL signal... 
Syncing hardware clock to system time 
Turning off quotas:  
umount2: Invalid argument
umount: /NOAA/NOAA_OE.iso: not mounted
umount: /NOAA/ExplorerCD: Illegal seek
Please stand by while rebooting the system...
Restarting system.

*
*** Back to compatibility mode
*
*** Whoops... forgot to change back bootparam to root=/dev/hda3
*

Linux version 2.4.29-pre2-Sharlie-two (root@Sharlie.TfJC) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #11 Wed Dec 22 19:28:50 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e8000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000003ffb0000 (usable)
 user: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 user: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 user: 000000003fff0000 - 0000000040000000 (reserved)
 user: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
initrd extends beyond end of memory (0x3ffffc93 > 0x38000000)
disabling initrd
On node 0 totalpages: 262064
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32688 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  Product ID: P4P800SE     APIC at: 0xFEE00000
I/O APIC #13 Version 32 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
SMP mptable: no processors registered!
BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Kernel command line: mem=1024mb root=/dev/sda3 rw console=tty0 console=ttyS0,115200n8 idebus=66 BOOT_IMAGE=bzi2429.2
ide_setup: idebus=66
Found and enabled local APIC!
Initializing CPU#0
Detected 3198.573 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 6383.20 BogoMIPS
Memory: 1033316k/1048256k available (1261k kernel code, 14552k reserved, 497k data, 116k init, 130752k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3198.4954 MHz.
..... host bus clock speed is 199.9059 MHz.
cpu: 0, clocks: 1999059, slice: 999529
CPU0<T0:1999056,T1:999520,D:7,S:999529,C:1999059>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.2
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV10 framebuffer ver 0.9.4 (GeForce2-MX, 64MB @ 0xE8000000)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 66MHz system bus speed for PIO modes
hda: Maxtor 6Y160M0, ATA DISK drive
hdb: Maxtor 6Y160M0, ATA DISK drive
hdc: Maxtor 4R120L4, ATA DISK drive
hdd: GENERIC DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
Partition check:
 hda:end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
 unable to read partition table
 hdb:end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
 unable to read partition table
 hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
 unable to read partition table
SCSI subsystem driver Revision: 1.00
ata_piix: combined mode not supported
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Linux video capture interface: v1.00
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kmod: failed to exec /sbin/modprobe -s -k block-major-8, errno = 2
VFS: Cannot open root device "sda3" or 08:03
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:03

*
*** bios back in compatibility mode *** root=/dev/hda3
*

 Linux version 2.4.29-pre2-Sharlie-two (root@Sharlie.TfJC) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #11 Wed Dec 22 19:28:50 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e8000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000003ffb0000 (usable)
 user: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 user: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 user: 000000003fff0000 - 0000000040000000 (reserved)
 user: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262064
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32688 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  Product ID: P4P800SE     APIC at: 0xFEE00000
I/O APIC #13 Version 32 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
SMP mptable: no processors registered!
BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Kernel command line: mem=1024mb root=/dev/hda3 rw console=tty0 console=ttyS0,115200n8 idebus=66 hdd=ide-scsi BOOT_IMAGE=bzi2429.2
ide_setup: idebus=66
ide_setup: hdd=ide-scsi
Found and enabled local APIC!
Initializing CPU#0
Detected 3198.573 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 6383.20 BogoMIPS
Memory: 1032824k/1048256k available (1261k kernel code, 15044k reserved, 497k data, 116k init, 130752k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3198.4954 MHz.
..... host bus clock speed is 199.9057 MHz.
cpu: 0, clocks: 1999057, slice: 999528
CPU0<T0:1999056,T1:999520,D:8,S:999528,C:1999057>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.2
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV10 framebuffer ver 0.9.4 (GeForce2-MX, 64MB @ 0xE8000000)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 66MHz system bus speed for PIO modes
hda: Maxtor 6Y160M0, ATA DISK drive
hdb: Maxtor 6Y160M0, ATA DISK drive
hdc: Maxtor 4R120L4, ATA DISK drive
hdd: GENERIC DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
Partition check:
 hda:end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
 unable to read partition table
 hdb:end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
 unable to read partition table
 hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
 unable to read partition table
SCSI subsystem driver Revision: 1.00
ata_piix: combined mode not supported
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Linux video capture interface: v1.00
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 491k freed
VFS: Mounted root (ext2 filesystem).
Red Hat nash version 3.4.28 starting
Loading aic7xxx module
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940A Ultra SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

blk: queue f7ec9794, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: SEAGATE   Model: ST15230W          Rev: 0298
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7ec9894, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: SEAGATE   Model: ST15230W          Rev: 0298
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7ec9994, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sda: 8386733 512-byte hdwr sectors (4294 MB)
 sda: sda1 sda2 sda3
SCSI device sdb: 8386733 512-byte hdwr sectors (4294 MB)
 sdb: sdb1 sdb2
Loading ide-scsi module
hdd: attached ide-scsi driver.
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: GENERIC   Model: DVD DUAL 4XMax    Rev: 2.17
  Type:   CD-ROM                             ANSI SCSI revision: 02
Loading ide-disk module
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 312581808 sectors (160042 MB) w/7936KiB Cache, CHS=19457/255/63
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63
 hda: hda1 hda2 hda3
 hdb: hdb1 hdb2
 hdc: hdc1 hdc2 hdc3 hdc4
Loading usbcore module
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Loading ehci-hcd module
insmod: ehci-hcd.o: 
ERROR: /bin/insmod exited abnormally!
Loading usb-uhci module
insmod: usb-uhci.o: 
ERROR: /bin/insmod exited abnormally!
Loading usb-storage module
insmod: usb-storage.o: 
ERROR: /bin/insmod exited abnormally!
Mounting /proc filesystem
Creating block devices
Creating root device
Mounting root filesystem
Freeing unused kernel memory: 116k freed
INIT: version 2.84 booting
		Welcome to Red Hat Linux
		Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Unmounting initrd:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Setting clock  (localtime): Wed Dec 22 22:04:38 PST 2004 [  OK  ]
Setting hostname Sharlie.TfJC:  [  OK  ]
Mounting USB filesystem:  [  OK  ]
Initializing USB HID interface:  modprobe: Can't locate module hid
[FAILED]
Initializing USB keyboard:  modprobe: Can't locate module keybdev
[FAILED]
Initializing USB mouse:  modprobe: Can't locate module mousedev
[FAILED]
Checking root filesystem
/ was not cleanly unmounted, check forced.
/: 474982/9945088 files (2.3% non-contiguous), 11176082/19884453 blocks
[/sbin/fsck.ext2 (1) -- /] fsck.ext2 -a /dev/hda3 
[PASSED]
Remounting root filesystem in read-write mode:  [  OK  ]
Activating swap partitions:  [  OK  ]
Finding module dependencies:  [  OK  ]
Checking filesystems
/dev/hdb1 was not cleanly unmounted, check forced.
/usr123456: clean, 98695/263296 files, 461926/526128 blocks
/123456: clean, 25708/214144 files, 388741/427730 blocks
/dev/hdb1: 130/19415040 files (1.5% non-contiguous), 30439701/38821064 blocks
Checking all file systems.
[/sbin/fsck.ext2 (1) -- /linux2] fsck.ext2 -a /dev/hdb1 
[/sbin/fsck.ext3 (2) -- /oldlinux] fsck.ext3 -a /dev/sda3 
[/sbin/fsck.ext3 (3) -- /oldusr] fsck.ext3 -a /dev/sdb2 
[PASSED]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 5
Entering non-interactive startup
Applying Intel IA32 Microcode update: [  OK  ]
Updating /etc/fstab [  OK  ]
Checking for new hardware [  OK  ]
Starting ip6tables:  [  OK  ]
Starting iptables:  [  OK  ]
Setting network parameters:  [  OK  ]
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth0:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: Dec 22 22:38:36 Sharlie kernel: klogd 1.4.1, log source = /proc/kmsg started.
[  OK  ]
Dec 22 22:38:36 Sharlie kernel: Linux version 2.4.29-pre2-Sharlie-two (root@Sharlie.TfJC) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #11 Wed Dec 22 19:28:50 PST 2004
Dec 22 22:38:36 Sharlie kernel: BIOS-provided physical RAM map:
Dec 22 22:38:36 Sharlie kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Dec 22 22:38:36 Sharlie kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Dec 22 22:38:36 Sharlie kernel:  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
Dec 22 22:38:36 Sharlie kernel:  BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
Dec 22 22:38:36 Sharlie kernel:  BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
Dec 22 22:38:36 Sharlie kernel:  BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
Dec 22 22:38:36 Sharlie kernel:  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
Dec 22 22:38:36 Sharlie kernel:  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
Dec 22 22:38:36 Sharlie kernel: user-defined physical RAM map:
Dec 22 22:38:36 Sharlie kernel:  user: 0000000000000000 - 000000000009fc00 (usable)
Dec 22 22:38:36 Sharlie kernel:  user: 000000000009fc00 - 00000000000a0000 (reserved)
Dec 22 22:38:36 Sharlie kernel:  user: 00000000000e8000 - 0000000000100000 (reserved)
Dec 22 22:38:36 Sharlie kernel:  user: 0000000000100000 - 000000003ffb0000 (usable)
Dec 22 22:38:36 Sharlie kernel:  user: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
Dec 22 22:38:36 Sharlie kernel:  user: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
Dec 22 22:38:36 Sharlie kernel:  user: 000000003fff0000 - 0000000040000000 (reserved)
Dec 22 22:38:36 Sharlie kernel:  user: 00000000ffb80000 - 0000000100000000 (reserved)
Dec 22 22:38:36 Sharlie kernel: 127MB HIGHMEM available.
Dec 22 22:38:36 Sharlie kernel: 896MB LOWMEM available.
Dec 22 22:38:36 Sharlie kernel: found SMP MP-table at 000ff780
Dec 22 22:38:36 Sharlie kernel: hm, page 000ff000 reserved twice.
Dec 22 22:38:36 Sharlie kernel: hm, page 00100000 reserved twice.
Dec 22 22:38:36 Sharlie kernel: hm, page 000f1000 reserved twice.
Dec 22 22:38:36 Sharlie kernel: hm, page 000f2000 reserved twice.
Dec 22 22:38:36 Sharlie kernel: On node 0 totalpages: 262064
Dec 22 22:38:36 Sharlie kernel: zone(0): 4096 pages.
Dec 22 22:38:36 Sharlie kernel: zone(1): 225280 pages.
Dec 22 22:38:36 Sharlie kernel: zone(2): 32688 pages.
Dec 22 22:38:36 Sharlie kernel: Intel MultiProcessor Specification v1.1
Dec 22 22:38:36 Sharlie kernel:     Virtual Wire compatibility mode.
Dec 22 22:38:36 Sharlie kernel: OEM ID: ASUSTeK  Product ID: P4P800SE     APIC at: 0xFEE00000
Dec 22 22:38:36 Sharlie kernel: I/O APIC #13 Version 32 at 0xFEC00000.
Dec 22 22:38:36 Sharlie kernel: Enabling APIC mode: Flat.^IUsing 1 I/O APICs
Dec 22 22:38:36 Sharlie kernel: SMP mptable: no processors registered!
Dec 22 22:38:36 Sharlie kernel: BIOS bug, MP table errors detected!...
Dec 22 22:38:36 Sharlie kernel: ... disabling SMP support. (tell your hw vendor)
Dec 22 22:38:36 Sharlie kernel: Kernel command line: mem=1024mb root=/dev/hda3 rw console=tty0 console=ttyS0,115200n8 idebus=66 hdd=ide-scsi BOOT_IMAGE=bzi2429.2
Dec 22 22:38:36 Sharlie kernel: ide_setup: idebus=66
Dec 22 22:38:36 Sharlie kernel: ide_setup: hdd=ide-scsi
Dec 22 22:38:36 Sharlie kernel: Found and enabled local APIC!
Dec 22 22:38:36 Sharlie kernel: Initializing CPU#0
Dec 22 22:38:36 Sharlie kernel: Detected 3198.573 MHz processor.
Dec 22 22:38:36 Sharlie kernel: Console: colour VGA+ 80x25
Dec 22 22:38:36 Sharlie kernel: Calibrating delay loop... 6383.20 BogoMIPS
Dec 22 22:38:36 Sharlie kernel: Memory: 1032824k/1048256k available (1261k kernel code, 15044k reserved, 497k data, 116k init, 130752k highmem)
Dec 22 22:38:36 Sharlie kernel: Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Dec 22 22:38:36 Sharlie kernel: Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Dec 22 22:38:36 Sharlie kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ntpd: Opening firewall for port 123Dec 22 22:38:36 Sharlie kernel: Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 22 22:38:36 Sharlie kernel: Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Dec 22 22:38:36 Sharlie kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Dec 22 22:38:36 Sharlie kernel: CPU: L2 cache: 1024K
Dec 22 22:38:36 Sharlie kernel: Intel machine check architecture supported.
Dec 22 22:38:36 Sharlie kernel: Intel machine check reporting enabled on CPU#0.
Dec 22 22:38:36 Sharlie kernel: CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Dec 22 22:38:36 Sharlie kernel: CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Dec 22 22:38:36 Sharlie kernel: CPU: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Dec 22 22:38:36 Sharlie kernel: Enabling fast FPU save and restore... done.
Dec 22 22:38:36 Sharlie kernel: Enabling unmasked SIMD FPU exception support... done.
[  OK  ]
Dec 22 22:38:36 Sharlie kernel: Checking 'hlt' instruction... OK.
Dec 22 22:38:37 Sharlie kernel: POSIX conformance testing by UNIFIX
Dec 22 22:38:37 Sharlie kernel: enabled ExtINT on CPU#0
Dec 22 22:38:37 Sharlie kernel: ESR value before enabling vector: 00000000
Dec 22 22:38:37 Sharlie kernel: ESR value after enabling vector: 00000000
Dec 22 22:38:37 Sharlie kernel: Using local APIC timer interrupts.
Dec 22 22:38:37 Sharlie kernel: calibrating APIC timer ...
Dec 22 22:38:37 Sharlie kernel: ..... CPU clock speed is 3198.4954 MHz.
Dec 22 22:38:37 Sharlie kernel: ..... host bus clock speed is 199.9057 MHz.
Dec 22 22:38:37 Sharlie kernel: cpu: 0, clocks: 1999057, slice: 999528
Dec 22 22:38:37 Sharlie kernel: CPU0<T0:1999056,T1:999520,D:8,S:999528,C:1999057>
Dec 22 22:38:37 Sharlie kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Dec 22 22:38:37 Sharlie kernel: mtrr: detected mtrr type: Intel
Dec 22 22:38:37 Sharlie kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
Dec 22 22:38:37 Sharlie kernel: PCI: Using configuration type 1
Dec 22 22:38:37 Sharlie kernel: PCI: Probing PCI hardware
Dec 22 22:38:37 Sharlie kernel: PCI: Probing PCI hardware (bus 00)
Dec 22 22:38:37 Sharlie kernel: PCI: Ignoring BAR0-3 of IDE controller 00:1f.2
Dec 22 22:38:37 Sharlie kernel: Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
Dec 22 22:38:37 Sharlie kernel: PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
Dec 22 22:38:37 Sharlie kernel: Linux NET4.0 for Linux 2.4
Dec 22 22:38:37 Sharlie kernel: Based upon Swansea University Computer Society NET3.039
Dec 22 22:38:37 Sharlie kernel: Initializing RT netlink socket
Dec 22 22:38:37 Sharlie kernel: Starting kswapd
Dec 22 22:38:37 Sharlie kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
Dec 22 22:38:37 Sharlie kernel: VFS: Disk quotas vdquot_6.5.1
Dec 22 22:38:37 Sharlie kernel: rivafb: RIVA MTRR set to ON
Dec 22 22:38:37 Sharlie kernel: Console: switching to colour frame buffer device 80x30
Dec 22 22:38:37 Sharlie kernel: rivafb: PCI nVidia NV10 framebuffer ver 0.9.4 (GeForce2-MX, 64MB @ 0xE8000000)
Dec 22 22:38:37 Sharlie kernel: pty: 2048 Unix98 ptys configured
Dec 22 22:38:37 Sharlie kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Dec 22 22:38:37 Sharlie kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Dec 22 22:38:37 Sharlie kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Dec 22 22:38:37 Sharlie kernel: Real Time Clock Driver v1.10f
Dec 22 22:38:37 Sharlie kernel: Floppy drive(s): fd0 is 1.44M
Dec 22 22:38:37 Sharlie kernel: FDC 0 is a post-1991 82077
Dec 22 22:38:37 Sharlie kernel: RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
Dec 22 22:38:37 Sharlie kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ntpd: Synchronizing with time server: Dec 22 22:38:37 Sharlie kernel: ide: Assuming 66MHz system bus speed for PIO modes
Dec 22 22:38:37 Sharlie kernel: hda: Maxtor 6Y160M0, ATA DISK drive
Dec 22 22:38:37 Sharlie kernel: hdb: Maxtor 6Y160M0, ATA DISK drive
Dec 22 22:38:37 Sharlie kernel: hdc: Maxtor 4R120L4, ATA DISK drive
Dec 22 22:38:37 Sharlie kernel: hdd: GENERIC DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
Dec 22 22:38:37 Sharlie kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 22 22:38:37 Sharlie kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 22 22:38:37 Sharlie kernel: Partition check:
Dec 22 22:38:37 Sharlie kernel:  hda:end_request: I/O error, dev 03:00 (hda), sector 0
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:00 (hda), sector 2
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:00 (hda), sector 4
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:00 (hda), sector 6
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:00 (hda), sector 0
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:00 (hda), sector 2
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:00 (hda), sector 4
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:00 (hda), sector 6
Dec 22 22:38:37 Sharlie kernel:  unable to read partition table
Dec 22 22:38:37 Sharlie kernel:  hdb:end_request: I/O error, dev 03:40 (hdb), sector 0
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:40 (hdb), sector 2
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:40 (hdb), sector 4
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:40 (hdb), sector 6
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:40 (hdb), sector 0
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:40 (hdb), sector 2
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:40 (hdb), sector 4
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 03:40 (hdb), sector 6
Dec 22 22:38:37 Sharlie kernel:  unable to read partition table
Dec 22 22:38:37 Sharlie kernel:  hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 16:00 (hdc), sector 2
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 16:00 (hdc), sector 4
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 16:00 (hdc), sector 6
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 16:00 (hdc), sector 0
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 16:00 (hdc), sector 2
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 16:00 (hdc), sector 4
Dec 22 22:38:37 Sharlie kernel: end_request: I/O error, dev 16:00 (hdc), sector 6
Dec 22 22:38:37 Sharlie kernel:  unable to read partition table
Dec 22 22:38:37 Sharlie kernel: SCSI subsystem driver Revision: 1.00
Dec 22 22:38:37 Sharlie kernel: libata version 1.10 loaded.
Dec 22 22:38:37 Sharlie kernel: ata_piix version 1.03
Dec 22 22:38:37 Sharlie kernel: ata_piix: combined mode not supported
Dec 22 22:38:37 Sharlie kernel: kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Dec 22 22:38:37 Sharlie kernel: Linux video capture interface: v1.00
Dec 22 22:38:37 Sharlie kernel: Initializing Cryptographic API
Dec 22 22:38:37 Sharlie kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec 22 22:38:37 Sharlie kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Dec 22 22:38:37 Sharlie kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Dec 22 22:38:37 Sharlie kernel: TCP: Hash tables configured (established 262144 bind 65536)
Dec 22 22:38:37 Sharlie kernel: Linux IP multicast router 0.06 plus PIM-SM
Dec 22 22:38:37 Sharlie kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Dec 22 22:38:37 Sharlie kernel: RAMDISK: Compressed image found at block 0
Dec 22 22:38:37 Sharlie kernel: Freeing initrd memory: 491k freed
Dec 22 22:38:37 Sharlie kernel: VFS: Mounted root (ext2 filesystem).
Dec 22 22:38:37 Sharlie kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Dec 22 22:38:37 Sharlie kernel:         <Adaptec 2940A Ultra SCSI adapter>
Dec 22 22:38:37 Sharlie kernel:         aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs
Dec 22 22:38:37 Sharlie kernel: 
Dec 22 22:38:37 Sharlie kernel: blk: queue f7ec9794, I/O limit 4095Mb (mask 0xffffffff)
Dec 22 22:38:37 Sharlie kernel: (scsi0:A:0): 10.000MB/s transfers (10.000MHz, offset 15)
Dec 22 22:38:37 Sharlie kernel:   Vendor: SEAGATE   Model: ST15230W          Rev: 0298
Dec 22 22:38:37 Sharlie kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Dec 22 22:38:37 Sharlie kernel: blk: queue f7ec9894, I/O limit 4095Mb (mask 0xffffffff)
Dec 22 22:38:37 Sharlie kernel: (scsi0:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
Dec 22 22:38:37 Sharlie kernel:   Vendor: SEAGATE   Model: ST15230W          Rev: 0298
Dec 22 22:38:37 Sharlie kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Dec 22 22:38:37 Sharlie kernel: blk: queue f7ec9994, I/O limit 4095Mb (mask 0xffffffff)
Dec 22 22:38:37 Sharlie kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Dec 22 22:38:37 Sharlie kernel: scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
Dec 22 22:38:37 Sharlie kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Dec 22 22:38:37 Sharlie kernel: Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Dec 22 22:38:37 Sharlie kernel: SCSI device sda: 8386733 512-byte hdwr sectors (4294 MB)
Dec 22 22:38:37 Sharlie kernel:  sda: sda1 sda2 sda3
Dec 22 22:38:37 Sharlie kernel: SCSI device sdb: 8386733 512-byte hdwr sectors (4294 MB)
Dec 22 22:38:37 Sharlie kernel:  sdb: sdb1 sdb2
Dec 22 22:38:37 Sharlie kernel: hdd: attached ide-scsi driver.
Dec 22 22:38:37 Sharlie kernel: scsi1 : SCSI host adapter emulation for IDE ATAPI devices
Dec 22 22:38:37 Sharlie kernel:   Vendor: GENERIC   Model: DVD DUAL 4XMax    Rev: 2.17
Dec 22 22:38:37 Sharlie kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Dec 22 22:38:37 Sharlie kernel: hda: attached ide-disk driver.
Dec 22 22:38:37 Sharlie kernel: hda: host protected area => 1
Dec 22 22:38:37 Sharlie kernel: hda: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63
Dec 22 22:38:37 Sharlie kernel: hdb: attached ide-disk driver.
Dec 22 22:38:37 Sharlie kernel: hdb: host protected area => 1
Dec 22 22:38:37 Sharlie kernel: hdb: 312581808 sectors (160042 MB) w/7936KiB Cache, CHS=19457/255/63
Dec 22 22:38:37 Sharlie kernel: hdc: attached ide-disk driver.
Dec 22 22:38:37 Sharlie kernel: hdc: host protected area => 1
Dec 22 22:38:37 Sharlie kernel: hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63
Dec 22 22:38:37 Sharlie kernel:  hda: hda1 hda2 hda3
Dec 22 22:38:37 Sharlie kernel:  hdb: hdb1 hdb2
Dec 22 22:38:37 Sharlie kernel:  hdc: hdc1 hdc2 hdc3 hdc4
Dec 22 22:38:37 Sharlie kernel: usb.c: registered new driver usbdevfs
Dec 22 22:38:37 Sharlie kernel: usb.c: registered new driver hub
Dec 22 22:38:37 Sharlie kernel: Freeing unused kernel memory: 116k freed
Dec 22 22:38:37 Sharlie kernel: Adding Swap: 1004052k swap-space (priority -1)
Dec 22 22:38:37 Sharlie kernel: Adding Swap: 1012084k swap-space (priority -2)
Dec 22 22:38:37 Sharlie kernel: Adding Swap: 265064k swap-space (priority -3)
Dec 22 22:38:37 Sharlie kernel: Journalled Block Device driver loaded
Dec 22 22:38:37 Sharlie kernel: kjournald starting.  Commit interval 5 seconds
Dec 22 22:38:37 Sharlie kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
Dec 22 22:38:37 Sharlie kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 22 22:38:37 Sharlie kernel: kjournald starting.  Commit interval 5 seconds
Dec 22 22:38:37 Sharlie kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,18), internal journal
Dec 22 22:38:37 Sharlie kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 22 22:38:37 Sharlie kernel: loop: loaded (max 8 devices)
Dec 22 22:38:37 Sharlie kernel: ISO 9660 Extensions: Microsoft Joliet Level 1
Dec 22 22:38:37 Sharlie kernel: ISO 9660 Extensions: IEEE_P1282
Dec 22 22:38:37 Sharlie kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Dec 22 22:38:37 Sharlie kernel: microcode: CPU0 already at revision 0x13 (current=0x13)
Dec 22 22:38:37 Sharlie kernel: microcode: No suitable data for cpu 0
Dec 22 22:38:37 Sharlie kernel: PCI: Setting latency timer of device 00:1d.7 to 64
Dec 22 22:38:37 Sharlie kernel: ehci_hcd 00:1d.7: Intel Corp. 82801EB USB2
Dec 22 22:38:38 Sharlie kernel: ehci_hcd 00:1d.7: irq 5, pci mem fd9cc800
Dec 22 22:38:38 Sharlie kernel: usb.c: new USB bus registered, assigned bus number 1
Dec 22 22:38:38 Sharlie kernel: ehci_hcd 00:1d.7: enabled 64bit PCI DMA
Dec 22 22:38:38 Sharlie kernel: PCI: cache line size of 128 is not supported by device 00:1d.7
Dec 22 22:38:38 Sharlie kernel: ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
Dec 22 22:38:38 Sharlie kernel: hub.c: USB hub found
Dec 22 22:38:38 Sharlie kernel: hub.c: 8 ports detected
Dec 22 22:38:38 Sharlie kernel: ehci_hcd 00:1d.7: remove state 3
Dec 22 22:38:38 Sharlie kernel: usb.c: USB disconnect on device 00:1d.7-0 address 1
Dec 22 22:38:38 Sharlie kernel: usb.c: USB bus 1 deregistered
Dec 22 22:38:38 Sharlie kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Dec 22 22:38:38 Sharlie kernel: parport0: irq 7 detected
Dec 22 22:38:38 Sharlie kernel: parport0: Printer, EPSON Stylus C62
Dec 22 22:38:38 Sharlie kernel: ip_tables: (C) 2000-2002 Netfilter core team
Dec 22 22:38:38 Sharlie kernel: sk98lin: Network Device Driver v6.22
Dec 22 22:38:38 Sharlie kernel: (C)Copyright 1999-2004 Marvell(R).
Dec 22 22:38:38 Sharlie kernel: eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
Dec 22 22:38:38 Sharlie kernel:       PrefPort:A  RlmtMode:Check Link State
Dec 22 22:38:38 Sharlie kernel: eth0: network connection up using port A
Dec 22 22:38:38 Sharlie kernel:     speed:           100
Dec 22 22:38:38 Sharlie kernel:     autonegotiation: yes
Dec 22 22:38:38 Sharlie kernel:     duplex mode:     full
Dec 22 22:38:38 Sharlie kernel:     flowctrl:        symmetric
Dec 22 22:38:38 Sharlie kernel:     irq moderation:  disabled
Dec 22 22:38:38 Sharlie kernel:     scatter-gather:  enabled
[  OK  ]
Starting ntpd: [  OK  ]
Starting portmapper: [  OK  ]
Starting NFS statd: [  OK  ]
Starting keytable:  [  OK  ]
Initializing random number generator:  [  OK  ]
Starting pcmcia:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting automount: No Mountpoints Defined[  OK  ]
Starting sshd:  [  OK  ]
Starting xinetd: [  OK  ]
Starting lpd: Dec 22 22:38:52 Sharlie kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Dec 22 22:38:52 Sharlie kernel: parport0: irq 7 detected
Dec 22 22:38:52 Sharlie kernel: parport0: Printer, EPSON Stylus C62
Dec 22 22:38:52 Sharlie kernel: lp0: using parport0 (polling).
Dec 22 22:38:52 Sharlie kernel: lp0: console ready
[  OK  ]
Starting NFS services:  Dec 22 22:38:52 Sharlie kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  OK  ]
Starting NFS quotas: [  OK  ]
Starting NFS daemon: [  OK  ]
Starting NFS mountd: [  OK  ]
Starting sendmail: [  OK  ]
Starting sm-client: [  OK  ]
Starting privoxy: [  OK  ]
Starting console mouse services: [  OK  ]
Starting postgresql service: [  OK  ]
Starting cannaserver: [  OK  ]
Starting crond: [  OK  ]
Starting xfs: [  OK  ]
Starting SMB services: [  OK  ]
Starting NMB services: [  OK  ]
Starting anacron: [  OK  ]
Starting atd: [  OK  ]
Starting wine:  [  OK  ]
Starting mdmonitor:  [  OK  ]

Red Hat Linux release 8.0 (Psyche)
Kernel 2.4.29-pre2-Sharlie-two on an i686

Sharlie.TfJC login: 

Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Dec 22 22:39:35 Sharlie kernel: Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Dec 22 22:39:35 Sharlie kernel: sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Dec 22 22:39:35 Sharlie kernel: Uniform CD-ROM driver Revision: 3.12

--------------030002030700050408000802--

