From: "Christopher R. Thompson" <Christoffur050@Verizon.Net>
Subject: Re: ICH5 ide modules in BOIS Compatibilty mode
Date: Wed, 22 Dec 2004 11:51:04 -0800
Message-ID: <41C9D028.9070506@Verizon.Net>
References: <41C341A4.9010401@Verizon.Net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090904090401010109050803"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out004pub.verizon.net ([206.46.170.142]:37792 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262028AbULVTvF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Dec 2004 14:51:05 -0500
Received: from Verizon.Net ([4.27.2.67]) by out004.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20041222195104.CZMK8290.out004.verizon.net@Verizon.Net>
          for <linux-ide@vger.kernel.org>; Wed, 22 Dec 2004 13:51:04 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090904090401010109050803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The responses to my questions have been overwhelming... So I guess I'll 
debug it myself.

Here is the syslog (attached file Kernel-001.log) when loading just the 
ide modules thusly:

echo Installing ide modules
insmod /lib/ide-core.o
insmod /lib/ide-disk.o
insmod /lib/piix.o
insmod /lib/ide-detect.o
echo Installing scsi modules
insmod /lib/scsi_mod.o
insmod /lib/sd_mod.o
insmod /lib/aic7xxx.o
insmod /lib/ide-scsi.o
echo Installing usb modules
insmod /lib/usbcore.o
insmod /lib/ehci-hcd.o
insmod /lib/usb-uhci.o
insmod /lib/usb-storage.o

Note that kernel parameters idebus=66 and hdd=ide-scsi are not applied 
and that "ide0: ports already in use".

Cannot probe hda or hdb

...
Christopher R. Thompson wrote:

Forget it.

-- 

Christopher R. Thompson
Student of Mechanical Engineering
California State Polytechnic University, Pomona
home: http://www.csupomona.edu/~cthompson1/

Email: mailto:Christoffur050@Verizon.SPAM
Note the Anti-SSSpppaaammm Mailing address...
"Net" will work better than "SPAM" if
you really want to send a message to me.



--------------090904090401010109050803
Content-Type: text/plain;
 name="Kernel-001.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Kernel-001.log"

Linux version 2.4.27 (root@Sharlie.TfJC) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #33-Christopher R. Thompson Wednesday December 15, 2004
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
Kernel command line: mem=1024mb root=/dev/hda3 rw console=ttyS0,115200n8 console=tty0 idebus=66 hdd=ide-scsi BOOT_IMAGE=bzi2427
Found and enabled local APIC!
Initializing CPU#0
Detected 3198.620 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 6383.20 BogoMIPS
Memory: 1029488k/1048256k available (1099k kernel code, 18380k reserved, 405k data, 108k init, 130752k highmem)
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
..... CPU clock speed is 3198.4964 MHz.
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
Linux video capture interface: v1.00
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4089k freed
VFS: Mounted root (ext2 filesystem).
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: ports already in use, skipping probe
hdc: Maxtor 4R120L4, ATA DISK drive
hdd: GENERIC DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940A Ultra SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

blk: queue f7eca594, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: SEAGATE   Model: ST15230W          Rev: 0298
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7eca694, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: SEAGATE   Model: ST15230W          Rev: 0298
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7eca794, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sda: 8386733 512-byte hdwr sectors (4294 MB)
Partition check:
 sda: sda1 sda2 sda3
SCSI device sdb: 8386733 512-byte hdwr sectors (4294 MB)
 sdb: sdb1 sdb2
hdd: attached ide-scsi driver.
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: GENERIC   Model: DVD DUAL 4XMax    Rev: 2.17
  Type:   CD-ROM                             ANSI SCSI revision: 02
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
ehci_hcd 00:1d.7: Intel Corp. 82801EB USB2
ehci_hcd 00:1d.7: irq 5, pci mem fd8a5800
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
hub.c: USB hub found
hub.c: 8 ports detected
usb-uhci.c: $Revision: 1.275 $ time 10:01:42 Dec 21 2004
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xeec0, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xef00, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xef20, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xef40, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 5
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Freeing unused kernel memory: 108k freed
Kernel panic: No init found.  Try passing init= option to kernel.

--------------090904090401010109050803--

