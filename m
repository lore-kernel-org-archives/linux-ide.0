From: "Christopher R. Thompson" <Christoffur050@Verizon.Net>
Subject: Re: ICH5 compiled in IDE, no libata, bios in Native Mode - Kernel
 Hung
Date: Wed, 22 Dec 2004 12:13:58 -0800
Message-ID: <41C9D586.2040602@Verizon.Net>
References: <41C341A4.9010401@Verizon.Net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030103070404040109070400"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out004pub.verizon.net ([206.46.170.142]:7646 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262032AbULVUOA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Dec 2004 15:14:00 -0500
Received: from Verizon.Net ([4.27.2.67]) by out004.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20041222201359.DHQS8290.out004.verizon.net@Verizon.Net>
          for <linux-ide@vger.kernel.org>; Wed, 22 Dec 2004 14:13:59 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030103070404040109070400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Compiled in IDE modules no libata. Bios in Native Mode: "P-ATA+SATA"

echo "Loading aic7xxx module"
insmod /lib/aic7xxx.o
echo "Loading ide-scsi module"
insmod /lib/ide-scsi.o
echo "Loading usb-storage module"
insmod /lib/usbcore.o
insmod /lib/ehci-hcd.o
insmod /lib/usb-uhci.o
insmod /lib/usb-storage.o

Yields syslog (attached as file Kernel-004.log)


--------------030103070404040109070400
Content-Type: text/plain;
 name="Kernel-004.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Kernel-004.log"

Linux version 2.4.27-Sharlie-two (root@Sharlie.TfJC) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #19 Mon Nov 15 06:34:48 PST 2004
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
On node 0 totalpages: 262064
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32688 pages.
Kernel command line: mem=1024mb idebus=66 root=/dev/hda3 hdd=ide-scsi console=tty0 console=ttyS0,115200n8 BOOT_IMAGE=bzi2427.2
ide_setup: idebus=66
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 3198.580 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 6383.20 BogoMIPS
Memory: 1032948k/1048256k available (1365k kernel code, 14920k reserved, 531k data, 128k init, 130752k highmem)
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
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 66MHz system bus speed for PIO modes
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
PCI: Sharing IRQ 11 with 00:1f.2
ICH5: chipset revision 2
ICH5: 100% native mode on irq 11
    ide0: BM-DMA at 0xef90-0xef97, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xef98-0xef9f, BIOS settings: hdc:pio, hdd:DMA
ICH5-SATA: IDE controller at PCI slot 00:1f.2
PCI: Found IRQ 11 for device 00:1f.2
PCI: Sharing IRQ 11 with 00:1d.2
PCI: Sharing IRQ 11 with 00:1f.1
ICH5-SATA: chipset revision 2
ICH5-SATA: 100% native mode on irq 11
    ide2: BM-DMA at 0xef60-0xef67, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xef68-0xef6f, BIOS settings: hdg:DMA, hdh:pio
hdc: Maxtor 4R120L4, ATA DISK drive
hdd: GENERIC DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
blk: queue c0335554, I/O limit 4095Mb (mask 0xffffffff)
hde: Maxtor 6Y160M0, ATA DISK drive
blk: queue c03359a8, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 6Y160M0, ATA DISK drive
hdh: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
hdh: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
blk: queue c0335dfc, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0xefa8-0xefaf,0xefe2 on irq 11
ide2 at 0xefa0-0xefa7,0xef8e on irq 11
ide3 at 0xef80-0xef87,0xef8a on irq 11
hdc: attached ide-disk driver.
hdc: host protected area => 1


--------------030103070404040109070400--

