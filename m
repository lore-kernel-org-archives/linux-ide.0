From: "Christopher R. Thompson" <Christoffur050@Verizon.Net>
Subject: Re: ICH5 libata and bios in Native mode Kernel BUG
Date: Wed, 22 Dec 2004 12:06:00 -0800
Message-ID: <41C9D3A8.40009@Verizon.Net>
References: <41C341A4.9010401@Verizon.Net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090109060202070308050605"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out011pub.verizon.net ([206.46.170.135]:20388 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262031AbULVUGF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Dec 2004 15:06:05 -0500
Received: from Verizon.Net ([4.27.2.67]) by out011.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20041222200600.DEKN4717.out011.verizon.net@Verizon.Net>
          for <linux-ide@vger.kernel.org>; Wed, 22 Dec 2004 14:06:00 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090109060202070308050605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Loading the modules exactly the same as before.. but with the bios 
configured in Native mode with "P-ATA+SATA"

echo Installing ide modules
echo Installing scsi modules
insmod /lib/scsi_mod.o
insmod /lib/sd_mod.o
insmod /lib/aic7xxx.o
echo Installing libata
insmod /lib/libata.o
insmod /lib/ata_piix.o
insmod /lib/ide-scsi.o
echo Installing usb modules
insmod /lib/usbcore.o
insmod /lib/ehci-hcd.o
insmod /lib/usb-uhci.o
insmod /lib/usb-storage.o

Yields the following syslog w oops

--------------090109060202070308050605
Content-Type: text/plain;
 name="Kernel-003.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Kernel-003.log"

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
Kernel command line: mem=1024mb root=/dev/ram1 rw console=tty0 console=ttyS0,115200n8 idebus=66 hdd=ide-scsi BOOT_IMAGE=bzi2427
Found and enabled local APIC!
Initializing CPU#0
Detected 3198.573 MHz processor.
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
Red Hat nash version 3.4.28 starting
Mounting /SCSI subsystem driver Revision: 1.00
proc filesystem
Installing ide modules
Installing scsi modules
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
Installing libata
ata1: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEF8E bmdma 0xEF60 irq 11
ata2: SATA max UDMA/133 cmd 0xEF80 ctl 0xEF8A bmdma 0xEF68 irq 11
kernel BUG at highmem.c:166!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0139aa8>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: f71b1078   ecx: 00000000   edx: f71b1570
esi: 00000000   edi: 00000000   ebp: c1c34000   esp: c1c35f68
ds: 0018   es: 0018   ss: 0018
Process keventd (pid: 2, stackpage=c1c35000)
Stack: f71b1078 fd85f9bb f71b1078 c1c35f84 c1c35f84 c011f04a f71b1078 f71b15c4 
       f71b15c4 c1c34560 c1c34570 c0127b53 c023a090 c1c35fb0 00000000 c1c34560 
       c1c34570 c1c34000 00000001 00000000 0000001b 00010000 00000000 00000700 
Call Trace:    [<fd85f9bb>] [<c011f04a>] [<c0127b53>] [<c0127a20>] [<c0105000>]
  [<c010733e>] [<c0127a20>]

Code: 0f 0b a6 00 b3 e8 21 c0 05 00 00 80 00 ba a0 ab 2a c0 c1 e8 
 

--------------090109060202070308050605--

