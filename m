From: "Christopher R. Thompson" <Christoffur050@Verizon.Net>
Subject: Re: ide-core.o & libata.o ICH5
Date: Thu, 23 Dec 2004 01:53:53 -0800
Message-ID: <41CA95B1.9000509@Verizon.Net>
References: <41C341A4.9010401@Verizon.Net> <41C9D5AA.70804@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000705080801020006060707"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out002pub.verizon.net ([206.46.170.141]:6350 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261196AbULWJx4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Dec 2004 04:53:56 -0500
Received: from Verizon.Net ([4.27.2.67]) by out002.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20041223095353.PAYH12052.out002.verizon.net@Verizon.Net>
          for <linux-ide@vger.kernel.org>; Thu, 23 Dec 2004 03:53:53 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000705080801020006060707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I think I finally got it up by bypassing the disk probe on hdc and 
removing the ide-scsi install in the initrd script.

The system still hangs on the parallel ide ports when accessing the 
devices using ide-scsi. Which is weird because ide-scsi.o wasn't 
insmod'ed during the bootup (as far as I know).

I'll be out of town 'till Monday, but will try to check messages via dialup.

-- 

Christopher R. Thompson
Student of Mechanical Engineering
California State Polytechnic University, Pomona
home: http://www.csupomona.edu/~cthompson1/


--------------000705080801020006060707
Content-Type: text/plain;
 name="004-native-no-ide-scsi.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="004-native-no-ide-scsi.log"


*
*** Bios in Native mode
*
*** No ide-scsi installed in initrd
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
Detected 3198.620 MHz processor.
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
..... CPU clock speed is 3198.4925 MHz.
..... host bus clock speed is 199.9057 MHz.
cpu: 0, clocks: 1999057, slice: 999528
CPU0<T0:1999056,T1:999520,D:8,S:999528,C:1999057>
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
Loading ide-disk module
hdc: attached ide-disk driver.
hdc: host protected area => 1

*
*** Whoops.... System Hang @ hdc ***
*

*
*** Reboot with hdc=noprobe
*
*** Boots ok, System up and running until I execute modprobe ide-scsi after logging in. ***
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
Kernel command line: mem=1024mb root=/dev/sda3 rw console=tty0 console=ttyS0,115200n8 idebus=66 hdc=noprobe hdd=ide-scsi BOOT_IMAGE=bzi2429.2
ide_setup: idebus=66
ide_setup: hdc=noprobe
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
..... CPU clock speed is 3198.4944 MHz.
..... host bus clock speed is 199.9057 MHz.
cpu: 0, clocks: 1999057, slice: 999528
CPU0<T0:1999056,T1:999520,D:8,S:999528,C:1999057>
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
hdd: GENERIC DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
ide1 at 0xefa8-0xefaf,0xefe2 on irq 11
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
Partition check:
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
Loading ide-disk module
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
Setting clock  (localtime): Thu Dec 23 00:52:10 PST 2004 [  OK  ]
Setting hostname Sharlie.TfJC:  [  OK  ]
Mounting USB filesystem:  [  OK  ]
Initializing USB HID interface:  modprobe: Can't locate module hid
[FAILED]
Initializing USB keyboard:  modprobe: Can't locate module keybdev
[FAILED]
Initializing USB mouse:  modprobe: Can't locate module mousedev
[FAILED]
Checking root filesystem
/: clean, 474991/9945088 files, 11176912/19884453 blocks
[/sbin/fsck.ext2 (1) -- /] fsck.ext2 -a /dev/sda3 
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Activating swap partitions:  swapon: /dev/hdb2: No such device or address
swapon: /dev/hda2: No such device or address
[FAILED]
Finding module dependencies:  [  OK  ]
Checking filesystems
fsck.ext2/dev/sdb2: 
The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>

: fsck.ext3: Bad magic number in super-block while trying to open /dev/sdb2
Possibly non-existent or swap device?
No such device or address while trying to open /dev/hdb1
/dev/sda3 is mounted.  Checking all file systems.
[/sbin/fsck.ext2 (1) -- /linux2] fsck.ext2 -a /dev/hdb1 
[/sbin/fsck.ext2 (2) -- /] fsck.ext2 -a /dev/sda3 
[/sbin/fsck.ext3 (3) -- /oldusr] fsck.ext3 -a /dev/sdb2 
e2fsck: Cannot continue, aborting.


[FAILED]

*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.
Give root password for maintenance
(or type Control-D for normal startup): 

rm: remove regular file `mtab'? y

-rw-r--r--    1 root     root         1881 Dec 22 22:38 fstab
-rw-r--r--    1 root     root           36 Dec 22 22:38 fstab.REVOKE
-rw-r--r--    1 root     root         1879 Dec 22 21:55 fstab.sda3.sav
-rw-r--r--    1 root     root           35 Sep  3  2002 updfstab.conf
-rw-r--r--    1 root     root          852 Oct 30 23:09 updfstab.conf.default

mount: /dev/sda3 already mounted or / busy
mount: according to mtab, /dev/sda3 is already mounted on /

11 # df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda3             78289508  43459344  30853276  59% /
12 # mount -a
13 # df -a
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda3             78289508  43459344  30853276  59% /
none                         0         0         0   -  /dev/pts
none                    516716         0    516716   0% /dev/shm
/dev/sdb1            152847236 119321784  25761240  83% /linux2
/dev/sda1             79510304  70249056   9261248  89% /cdrive
/dev/sdc1              2208740   1312308    896432  60% /edrive
/dev/sdd1              2080220    319512   1760708  16% /fdrive
/dev/sdc3              1683992   1528036     70412  96% /oldlinux
/dev/sdd2              2071416   1814608    151584  93% /oldusr
/NOAA/NOAA_OE.iso       678770    678770         0 100% /NOAA/ExplorerCD
14 # init 5
INIT: Switching to runlevel: 5
(Repair filesystem) 15 # (Repair filesystem) Applying Intel IA32 Microcode update: [  OK  ]
Updating /etc/fstab cannot stat /dev/cdrom: No such file or directory
[FAILED]
Checking for new hardware [  OK  ]
Starting ip6tables:  [  OK  ]
Starting iptables:  [  OK  ]
Setting network parameters:  [  OK  ]
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth0:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: Dec 23 00:56:38 Sharlie kernel: klogd 1.4.1, log source = /proc/kmsg started.
Dec 23 00:56:38 Sharlie kernel: Linux version 2.4.29-pre2-Sharlie-two (root@Sharlie.TfJC) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #11 Wed Dec 22 19:28:50 PST 2004
Dec 23 00:56:38 Sharlie kernel: BIOS-provided physical RAM map:
Dec 23 00:56:38 Sharlie kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Dec 23 00:56:38 Sharlie kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Dec 23 00:56:38 Sharlie kernel:  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
Dec 23 00:56:38 Sharlie kernel:  BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
Dec 23 00:56:38 Sharlie kernel:  BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
Dec 23 00:56:38 Sharlie kernel:  BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
Dec 23 00:56:38 Sharlie kernel:  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
Dec 23 00:56:38 Sharlie kernel:  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
Dec 23 00:56:38 Sharlie kernel: user-defined physical RAM map:
Dec 23 00:56:38 Sharlie kernel:  user: 0000000000000000 - 000000000009fc00 (usable)
Dec 23 00:56:38 Sharlie kernel:  user: 000000000009fc00 - 00000000000a0000 (reserved)
Dec 23 00:56:38 Sharlie kernel:  user: 00000000000e8000 - 0000000000100000 (reserved)
Dec 23 00:56:38 Sharlie kernel:  user: 0000000000100000 - 000000003ffb0000 (usable)
Dec 23 00:56:38 Sharlie kernel:  user: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
Dec 23 00:56:38 Sharlie kernel:  user: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
Dec 23 00:56:38 Sharlie kernel:  user: 000000003fff0000 - 0000000040000000 (reserved)
Dec 23 00:56:38 Sharlie kernel:  user: 00000000ffb80000 - 0000000100000000 (reserved)
Dec 23 00:56:38 Sharlie kernel: 127MB HIGHMEM available.
Dec 23 00:56:38 Sharlie kernel: 896MB LOWMEM available.
Dec 23 00:56:38 Sharlie kernel: found SMP MP-table at 000ff780
Dec 23 00:56:38 Sharlie kernel: hm, page 000ff000 reserved twice.
Dec 23 00:56:38 Sharlie kernel: hm, page 00100000 reserved twice.
Dec 23 00:56:38 Sharlie kernel: hm, page 000f1000 reserved twice.
Dec 23 00:56:38 Sharlie kernel: hm, page 000f2000 reserved twice.
Dec 23 00:56:38 Sharlie kernel: On node 0 totalpages: 262064
Dec 23 00:56:38 Sharlie kernel: zone(0): 4096 pages.
Dec 23 00:56:38 Sharlie kernel: zone(1): 225280 pages.
Dec 23 00:56:38 Sharlie kernel: zone(2): 32688 pages.
Dec 23 00:56:38 Sharlie kernel: Intel MultiProcessor Specification v1.1
Dec 23 00:56:38 Sharlie kernel:     Virtual Wire compatibility mode.
Dec 23 00:56:38 Sharlie kernel: OEM ID: ASUSTeK  Product ID: P4P800SE     APIC at: 0xFEE00000
Dec 23 00:56:38 Sharlie kernel: I/O APIC #13 Version 32 at 0xFEC00000.
Dec 23 00:56:38 Sharlie kernel: Enabling APIC mode: Flat.^IUsing 1 I/O APICs
Dec 23 00:56:38 Sharlie kernel: SMP mptable: no processors registered!
Dec 23 00:56:38 Sharlie kernel: BIOS bug, MP table errors detected!...
Dec 23 00:56:38 Sharlie kernel: ... disabling SMP support. (tell your hw vendor)
Dec 23 00:56:38 Sharlie kernel: Kernel command line: mem=1024mb root=/dev/sda3 rw console=tty0 console=ttyS0,115200n8 idebus=66 hdc=noprobe hdd=ide-scsi BOOT_IMAGE=bzi2429.2
Dec 23 00:56:38 Sharlie kernel: ide_setup: idebus=66
Dec 23 00:56:38 Sharlie kernel: ide_setup: hdc=noprobe
Dec 23 00:56:38 Sharlie kernel: ide_setup: hdd=ide-scsi
Dec 23 00:56:38 Sharlie kernel: Found and enabled local APIC!
Dec 23 00:56:38 Sharlie kernel: Initializing CPU#0
Dec 23 00:56:38 Sharlie kernel: Detected 3198.573 MHz processor.
Dec 23 00:56:38 Sharlie kernel: Console: colour VGA+ 80x25
Dec 23 00:56:38 Sharlie kernel: Calibrating delay loop... 6383.20 BogoMIPS
Dec 23 00:56:38 Sharlie kernel: Memory: 1032824k/1048256k available (1261k kernel code, 15044k reserved, 497k data, 116k init, 130752k highmem)
Dec 23 00:56:38 Sharlie kernel: Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Dec 23 00:56:38 Sharlie kernel: Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Dec 23 00:56:38 Sharlie kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Dec 23 00:56:38 Sharlie kernel: Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
[  OK  ]
Dec 23 00:56:38 Sharlie kernel: Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Dec 23 00:56:38 Sharlie kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Dec 23 00:56:38 Sharlie kernel: CPU: L2 cache: 1024K
Dec 23 00:56:38 Sharlie kernel: Intel machine check architecture supported.
Dec 23 00:56:38 Sharlie kernel: Intel machine check reporting enabled on CPU#0.
Dec 23 00:56:38 Sharlie kernel: CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Dec 23 00:56:38 Sharlie kernel: CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Dec 23 00:56:38 Sharlie kernel: CPU: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Dec 23 00:56:38 Sharlie kernel: Enabling fast FPU save and restore... done.
Dec 23 00:56:38 Sharlie kernel: Enabling unmasked SIMD FPU exception support... done.
Dec 23 00:56:38 Sharlie kernel: Checking 'hlt' instruction... OK.
Dec 23 00:56:38 Sharlie kernel: POSIX conformance testing by UNIFIX
Dec 23 00:56:38 Sharlie kernel: enabled ExtINT on CPU#0
Dec 23 00:56:38 Sharlie kernel: ESR value before enabling vector: 00000000
Dec 23 00:56:38 Sharlie kernel: ESR value after enabling vector: 00000000
Dec 23 00:56:38 Sharlie kernel: Using local APIC timer interrupts.
Dec 23 00:56:38 Sharlie kernel: calibrating APIC timer ...
Dec 23 00:56:38 Sharlie kernel: ..... CPU clock speed is 3198.4944 MHz.
Dec 23 00:56:38 Sharlie kernel: ..... host bus clock speed is 199.9057 MHz.
Dec 23 00:56:38 Sharlie kernel: cpu: 0, clocks: 1999057, slice: 999528
Dec 23 00:56:38 Sharlie kernel: CPU0<T0:1999056,T1:999520,D:8,S:999528,C:1999057>
Dec 23 00:56:38 Sharlie kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Dec 23 00:56:38 Sharlie kernel: mtrr: detected mtrr type: Intel
Dec 23 00:56:38 Sharlie kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
Dec 23 00:56:38 Sharlie kernel: PCI: Using configuration type 1
Dec 23 00:56:38 Sharlie kernel: PCI: Probing PCI hardware
Dec 23 00:56:38 Sharlie kernel: PCI: Probing PCI hardware (bus 00)
Dec 23 00:56:38 Sharlie kernel: Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
Dec 23 00:56:38 Sharlie kernel: PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
Dec 23 00:56:38 Sharlie kernel: Linux NET4.0 for Linux 2.4
Dec 23 00:56:38 Sharlie kernel: Based upon Swansea University Computer Society NET3.039
Dec 23 00:56:38 Sharlie kernel: Initializing RT netlink socket
Dec 23 00:56:38 Sharlie kernel: Starting kswapd
Dec 23 00:56:38 Sharlie kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
Dec 23 00:56:38 Sharlie kernel: VFS: Disk quotas vdquot_6.5.1
Dec 23 00:56:38 Sharlie kernel: rivafb: RIVA MTRR set to ON
Dec 23 00:56:38 Sharlie kernel: Console: switching to colour frame buffer device 80x30
Dec 23 00:56:38 Sharlie kernel: rivafb: PCI nVidia NV10 framebuffer ver 0.9.4 (GeForce2-MX, 64MB @ 0xE8000000)
Dec 23 00:56:38 Sharlie kernel: pty: 2048 Unix98 ptys configured
Dec 23 00:56:38 Sharlie kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Dec 23 00:56:38 Sharlie kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Dec 23 00:56:38 Sharlie kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Dec 23 00:56:38 Sharlie kernel: Real Time Clock Driver v1.10f
Dec 23 00:56:38 Sharlie kernel: Floppy drive(s): fd0 is 1.44M
Dec 23 00:56:38 Sharlie kernel: FDC 0 is a post-1991 82077
Dec 23 00:56:38 Sharlie kernel: RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
Dec 23 00:56:38 Sharlie kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
Dec 23 00:56:38 Sharlie kernel: ide: Assuming 66MHz system bus speed for PIO modes
Dec 23 00:56:38 Sharlie kernel: ICH5: IDE controller at PCI slot 00:1f.1
ntpd: Opening firewall for port 123Dec 23 00:56:38 Sharlie kernel: PCI: Enabling device 00:1f.1 (0005 -> 0007)
[  OK  ]
Dec 23 00:56:38 Sharlie kernel: ICH5: chipset revision 2
Dec 23 00:56:38 Sharlie kernel: ICH5: 100%% native mode on irq 11
Dec 23 00:56:38 Sharlie kernel:     ide0: BM-DMA at 0xef90-0xef97, BIOS settings: hda:pio, hdb:pio
Dec 23 00:56:38 Sharlie kernel:     ide1: BM-DMA at 0xef98-0xef9f, BIOS settings: hdc:pio, hdd:DMA
Dec 23 00:56:38 Sharlie kernel: hdd: GENERIC DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
Dec 23 00:56:38 Sharlie kernel: ide1 at 0xefa8-0xefaf,0xefe2 on irq 11
Dec 23 00:56:38 Sharlie kernel: SCSI subsystem driver Revision: 1.00
Dec 23 00:56:38 Sharlie kernel: libata version 1.10 loaded.
Dec 23 00:56:38 Sharlie kernel: ata_piix version 1.03
Dec 23 00:56:38 Sharlie kernel: PCI: Setting latency timer of device 00:1f.2 to 64
Dec 23 00:56:38 Sharlie kernel: ata1: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEF8E bmdma 0xEF60 irq 11
Dec 23 00:56:39 Sharlie kernel: ata2: SATA max UDMA/133 cmd 0xEF80 ctl 0xEF8A bmdma 0xEF68 irq 11
Dec 23 00:56:39 Sharlie kernel: ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
Dec 23 00:56:39 Sharlie kernel: ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
Dec 23 00:56:39 Sharlie kernel: ata1: dev 0 configured for UDMA/133
Dec 23 00:56:39 Sharlie kernel: ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
Dec 23 00:56:39 Sharlie kernel: ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
Dec 23 00:56:39 Sharlie kernel: ata2: dev 0 configured for UDMA/133
Dec 23 00:56:39 Sharlie kernel: scsi0 : ata_piix
Dec 23 00:56:39 Sharlie kernel: scsi1 : ata_piix
Dec 23 00:56:39 Sharlie kernel:   Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
Dec 23 00:56:39 Sharlie kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Dec 23 00:56:39 Sharlie kernel:   Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
Dec 23 00:56:39 Sharlie kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Dec 23 00:56:39 Sharlie kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Dec 23 00:56:39 Sharlie kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Dec 23 00:56:39 Sharlie kernel: SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
Dec 23 00:56:39 Sharlie kernel: Partition check:
Dec 23 00:56:39 Sharlie kernel:  sda: sda1 sda2 sda3
Dec 23 00:56:39 Sharlie kernel: SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
Dec 23 00:56:39 Sharlie kernel:  sdb: sdb1 sdb2
Dec 23 00:56:39 Sharlie kernel: Linux video capture interface: v1.00
Dec 23 00:56:39 Sharlie kernel: Initializing Cryptographic API
Dec 23 00:56:39 Sharlie kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec 23 00:56:39 Sharlie kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Dec 23 00:56:39 Sharlie kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Dec 23 00:56:39 Sharlie kernel: TCP: Hash tables configured (established 262144 bind 65536)
Dec 23 00:56:39 Sharlie kernel: Linux IP multicast router 0.06 plus PIM-SM
Dec 23 00:56:39 Sharlie kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Dec 23 00:56:39 Sharlie kernel: RAMDISK: Compressed image found at block 0
Dec 23 00:56:39 Sharlie kernel: Freeing initrd memory: 491k freed
Dec 23 00:56:39 Sharlie kernel: VFS: Mounted root (ext2 filesystem).
Dec 23 00:56:39 Sharlie kernel: scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Dec 23 00:56:39 Sharlie kernel:         <Adaptec 2940A Ultra SCSI adapter>
Dec 23 00:56:39 Sharlie kernel:         aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs
Dec 23 00:56:39 Sharlie kernel: 
Dec 23 00:56:39 Sharlie kernel: blk: queue f7ec8994, I/O limit 4095Mb (mask 0xffffffff)
ntpd: Synchronizing with time server: Dec 23 00:56:39 Sharlie kernel: (scsi2:A:0): 10.000MB/s transfers (10.000MHz, offset 15)
Dec 23 00:56:39 Sharlie kernel:   Vendor: SEAGATE   Model: ST15230W          Rev: 0298
Dec 23 00:56:39 Sharlie kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Dec 23 00:56:39 Sharlie kernel: blk: queue f7ec8a94, I/O limit 4095Mb (mask 0xffffffff)
Dec 23 00:56:39 Sharlie kernel: (scsi2:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
Dec 23 00:56:39 Sharlie kernel:   Vendor: SEAGATE   Model: ST15230W          Rev: 0298
Dec 23 00:56:39 Sharlie kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Dec 23 00:56:39 Sharlie kernel: blk: queue f7ec8b94, I/O limit 4095Mb (mask 0xffffffff)
Dec 23 00:56:39 Sharlie kernel: scsi2:A:0:0: Tagged Queuing enabled.  Depth 32
Dec 23 00:56:39 Sharlie kernel: scsi2:A:1:0: Tagged Queuing enabled.  Depth 32
Dec 23 00:56:39 Sharlie kernel: Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Dec 23 00:56:39 Sharlie kernel: Attached scsi disk sdd at scsi2, channel 0, id 1, lun 0
Dec 23 00:56:39 Sharlie kernel: SCSI device sdc: 8386733 512-byte hdwr sectors (4294 MB)
Dec 23 00:56:39 Sharlie kernel:  sdc: sdc1 sdc2 sdc3
Dec 23 00:56:39 Sharlie kernel: SCSI device sdd: 8386733 512-byte hdwr sectors (4294 MB)
Dec 23 00:56:39 Sharlie kernel:  sdd: sdd1 sdd2
Dec 23 00:56:39 Sharlie kernel: usb.c: registered new driver usbdevfs
Dec 23 00:56:39 Sharlie kernel: usb.c: registered new driver hub
Dec 23 00:56:39 Sharlie kernel: Freeing unused kernel memory: 116k freed
Dec 23 00:56:39 Sharlie kernel: Adding Swap: 1012084k swap-space (priority -1)
Dec 23 00:56:39 Sharlie kernel: Journalled Block Device driver loaded
Dec 23 00:56:39 Sharlie kernel: kjournald starting.  Commit interval 5 seconds
Dec 23 00:56:39 Sharlie kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,35), internal journal
Dec 23 00:56:39 Sharlie kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 23 00:56:39 Sharlie kernel: kjournald starting.  Commit interval 5 seconds
Dec 23 00:56:39 Sharlie kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,50), internal journal
Dec 23 00:56:39 Sharlie kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 23 00:56:39 Sharlie kernel: loop: loaded (max 8 devices)
Dec 23 00:56:39 Sharlie kernel: ISO 9660 Extensions: Microsoft Joliet Level 1
Dec 23 00:56:39 Sharlie kernel: ISO 9660 Extensions: IEEE_P1282
Dec 23 00:56:39 Sharlie kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Dec 23 00:56:39 Sharlie kernel: microcode: CPU0 already at revision 0x13 (current=0x13)
Dec 23 00:56:39 Sharlie kernel: microcode: No suitable data for cpu 0
Dec 23 00:56:39 Sharlie kernel: PCI: Setting latency timer of device 00:1d.7 to 64
Dec 23 00:56:39 Sharlie kernel: ehci_hcd 00:1d.7: Intel Corp. 82801EB USB2
Dec 23 00:56:39 Sharlie kernel: ehci_hcd 00:1d.7: irq 5, pci mem fd916800
Dec 23 00:56:39 Sharlie kernel: usb.c: new USB bus registered, assigned bus number 1
Dec 23 00:56:39 Sharlie kernel: ehci_hcd 00:1d.7: enabled 64bit PCI DMA
Dec 23 00:56:39 Sharlie kernel: PCI: cache line size of 128 is not supported by device 00:1d.7
Dec 23 00:56:39 Sharlie kernel: ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
Dec 23 00:56:39 Sharlie kernel: hub.c: USB hub found
Dec 23 00:56:39 Sharlie kernel: hub.c: 8 ports detected
Dec 23 00:56:39 Sharlie kernel: ehci_hcd 00:1d.7: remove state 3
Dec 23 00:56:39 Sharlie kernel: usb.c: USB disconnect on device 00:1d.7-0 address 1
Dec 23 00:56:39 Sharlie kernel: usb.c: USB bus 1 deregistered
Dec 23 00:56:39 Sharlie kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Dec 23 00:56:39 Sharlie kernel: parport0: irq 7 detected
Dec 23 00:56:39 Sharlie kernel: parport0: Printer, EPSON Stylus C62
Dec 23 00:56:39 Sharlie kernel: ip_tables: (C) 2000-2002 Netfilter core team
Dec 23 00:56:39 Sharlie kernel: sk98lin: Network Device Driver v6.22
Dec 23 00:56:39 Sharlie kernel: (C)Copyright 1999-2004 Marvell(R).
Dec 23 00:56:39 Sharlie kernel: eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
Dec 23 00:56:39 Sharlie kernel:       PrefPort:A  RlmtMode:Check Link State
Dec 23 00:56:39 Sharlie kernel: eth0: network connection up using port A
Dec 23 00:56:39 Sharlie kernel:     speed:           100
Dec 23 00:56:39 Sharlie kernel:     autonegotiation: yes
Dec 23 00:56:39 Sharlie kernel:     duplex mode:     full
Dec 23 00:56:39 Sharlie kernel:     flowctrl:        symmetric
Dec 23 00:56:39 Sharlie kernel:     irq moderation:  disabled
Dec 23 00:56:39 Sharlie kernel:     scatter-gather:  enabled
[  OK  ]
Starting ntpd: [  OK  ]
Starting portmapper: [  OK  ]
Starting NFS statd: [  OK  ]
Starting keytable:  [  OK  ]
Initializing random number generator:  [  OK  ]
Starting pcmcia:  [  OK  ]
Mounting other filesystems:  [FAILED]
Starting automount: No Mountpoints Defined[  OK  ]
Starting sshd:  [  OK  ]
Starting xinetd: [  OK  ]
Starting lpd: Dec 23 00:56:53 Sharlie kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Dec 23 00:56:53 Sharlie kernel: parport0: irq 7 detected
Dec 23 00:56:53 Sharlie kernel: parport0: Printer, EPSON Stylus C62
Dec 23 00:56:53 Sharlie kernel: lp0: using parport0 (polling).
Dec 23 00:56:53 Sharlie kernel: lp0: console ready
[  OK  ]
Starting NFS services:  Dec 23 00:56:53 Sharlie kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
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
Red Hat Linux release 8.0 (Psyche)
Kernel 2.4.29-pre2-Sharlie-two on an i686

Sharlie.TfJC login: 
Red Hat Linux release 8.0 (Psyche)
Kernel 2.4.29-pre2-Sharlie-two on an i686

Sharlie.TfJC login: hdd: attached ide-scsi driver.
Dec 23 01:00:47 Sharlie kernel: hdd: attached ide-scsi driver.
Dec 23 01:00:47 Sharlie kernel: scsi3 : SCSI host adapter emulation for IDE ATAPI devices

*
*** Whoops... system hang @ modprobe ide-scsi
*
*** Guess I'll use compatibility mode when I need to write to the dvd.
*

--------------000705080801020006060707--

