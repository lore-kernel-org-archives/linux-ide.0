From: O <xsdg@mit.edu>
Subject: SATA passthrough fails to differentiate between SCSI devices
Date: Mon, 16 Jan 2006 07:19:36 +0000
Message-ID: <43CB4908.90502@mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0DC8C3BB025846ED24AA2FFC"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from XSDG.MIT.EDU ([18.241.2.180]:39633 "EHLO perl.xsdg.org")
	by vger.kernel.org with ESMTP id S932189AbWAPHTs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2006 02:19:48 -0500
Received: from localhost ([127.0.0.1])
	by perl.xsdg.org with esmtp (Exim 4.34)
	id 1EyOeZ-0002fn-MW
	for linux-ide@vger.kernel.org; Mon, 16 Jan 2006 07:19:47 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0DC8C3BB025846ED24AA2FFC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

So, if I do `for dev in /dev/sd?; do smartctl -d ata -i $dev; done`, I get identical output for all 8 SCSI disk devices available (excluding timestamps).  Additionally, if I do `for dev in /dev/sd?1; ...`, I get the identical output for all of the devices with a filesystem probed, but this set of output is for a _different drive_ than the /dev/sd? output.  Output is listed below, after some info about my drives.  lspci and dmesg excerpts follow.

All SCSI disk access (including usb-storage) seems to work properly.  Fetching smart data from my ATA drives seems to work fine as well (that is, hda works, and hdc and hdd are reported as not having any SMART data, which is correct also).  As far as I can tell, this problem only arises when the libata passthrough is used.

My disk setup is as follows:
onboard VIA VT82C[56]86 PATA controller
  hda:	WD Caviar (WD1200JB-00EVA0)
PCI Promise TX4 SATA controller
  sda:	Maxtor MaXLine Plus III (7L250S0)
  sdb:	Seagate Barracuda 7200.8 (ST3250823AS)
onboard VIA VT6420 SATA RAID controller (used in non-RAID mode)
  sdc:	Samsung SP1614C
  sdd:	Samsung SP1614C
usb-ehci
  sd[efgh]: 4-slot USB cardreader; 1GB CF card was in during bootup
unused and disabled onboard Promise SX4 SATA RAID controller


sysfs has the correct information:
05:47:45> [root{perl}@/sys/class/scsi_device]
#for drive in {2,3,4,5}\:0\:0\:0/device; do cat $drive/model; ls -l $drive/block; done
Maxtor 7L250S0  
lrwxrwxrwx  1 root root 0 2006-01-16 05:44 2:0:0:0/device/block -> ../../../../../../block/sda/
ST3250823AS     
lrwxrwxrwx  1 root root 0 2006-01-16 05:47 3:0:0:0/device/block -> ../../../../../../block/sdb/
SAMSUNG SP1614C 
lrwxrwxrwx  1 root root 0 2006-01-16 05:47 4:0:0:0/device/block -> ../../../../../../block/sdc/
SAMSUNG SP1614C 
lrwxrwxrwx  1 root root 0 2006-01-16 05:47 5:0:0:0/device/block -> ../../../../../../block/sdd/


$ls -Hl /dev/sd*
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sda
brw-rw----  1 root disk 8, 33 2006-01-16 03:20 /dev/sda1
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdb
brw-rw----  1 root disk 8, 33 2006-01-16 03:20 /dev/sdb1
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdc
brw-rw----  1 root disk 8, 33 2006-01-16 03:20 /dev/sdc1
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdd
brw-rw----  1 root disk 8, 33 2006-01-16 03:20 /dev/sdd1
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sde
brw-rw----  1 root disk 8, 33 2006-01-16 03:20 /dev/sde1
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdf
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdg
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdh


smartctl -i /dev/sd? output:
05:57:48> [root{perl}@/sys/class/scsi_device]
#for dev in /dev/sd?; do smartctl -d ata -i $dev; done
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     ST3250823AS
Serial Number:    5ND0K173
Firmware Version: 3.03
User Capacity:    250,059,350,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Mon Jan 16 05:57:55 2006 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

(output repeats identically (except for timestamp) 7 more times; see full listing at
http://web.mit.edu/~xsdg/Public/stuff/libata/SMART-info-sdX )


smartctl -i /dev/sd?1 output:
05:57:56> [root{perl}@/sys/class/scsi_device]
#for dev in /dev/sd?1; do smartctl -d ata -i $dev; done
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     SAMSUNG SP1614C
Serial Number:    S01XJ10XC95090
Firmware Version: SW100-34
User Capacity:    160,041,885,696 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Mon Jan 16 06:06:21 2006 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

(output repeats 4 more times; see full listing at
http://web.mit.edu/~xsdg/Public/stuff/libata/SMART-info-sdX1 )



(lspci -vv listing at
http://web.mit.edu/~xsdg/Public/stuff/libata/lspci )
$lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
0000:00:09.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)
0000:00:0a.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
0000:00:0c.0 ffff: D-Link System Inc RTL8139 Ethernet (rev ff)
0000:00:0d.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 3d18 (rev 02)
0000:00:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
0000:00:0e.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA TNT2/TNT2 Pro] (rev 15)



Relevant-looking kernel messages in dmesg; full listing available at 
http://web.mit.edu/~xsdg/Public/stuff/libata/dmesg :

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD1200JB-00EVA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SONY DVD RW DRU-700A, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-R/RW DRIVE SW-252F, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 > hda3 hda4
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 1X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
libata version 1.20 loaded.
sata_promise 0000:00:0d.0: version 1.03
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 18
ata1: SATA max UDMA/133 cmd 0xF8804200 ctl 0xF8804238 bmdma 0x0 irq 18
ata2: SATA max UDMA/133 cmd 0xF8804280 ctl 0xF88042B8 bmdma 0x0 irq 18
ata3: SATA max UDMA/133 cmd 0xF8804300 ctl 0xF8804338 bmdma 0x0 irq 18
ata4: SATA max UDMA/133 cmd 0xF8804380 ctl 0xF88043B8 bmdma 0x0 irq 18
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:407f
ata3: dev 0 ATA-7, max UDMA/133, 490234752 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_promise
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata4: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_promise
  Vendor: ATA       Model: Maxtor 7L250S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
sata_via 0000:00:0f.0: routed to hard irq line 1
ata5: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xD000 irq 17
ata6: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xD008 irq 17
ata5: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:80ff
ata5: dev 0 ATA-7, max UDMA7, 312581808 sectors: LBA48
ata5: dev 0 configured for UDMA/133
scsi4 : sata_via
ata6: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:80ff
ata6: dev 0 ATA-7, max UDMA7, 312581808 sectors: LBA48
ata6: dev 0 configured for UDMA/133
scsi5 : sata_via
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 sda: sda1
sd 2:0:0:0: Attached scsi disk sda
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 3:0:0:0: Attached scsi disk sdb
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 4:0:0:0: Attached scsi disk sdc
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 5:0:0:0: Attached scsi disk sdd

[firewire and USB stuff]

md: raid1 personality registered as nr 3
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39

[net, cpufreq, and some ACPI stuff]

md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md: sdb1 has different UUID to sdd1
md: sda1 has different UUID to sdd1
md: created md0
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md1
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md1 active with 2 out of 2 mirrors
md: ... autorun DONE.

[mount root fs, various things]

  Vendor: Generic   Model: USB Storage-CFC   Rev: I19A
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sde: 2001888 512-byte hdwr sectors (1025 MB)
sde: Write Protect is off
sde: Mode Sense: 03 00 00 00
sde: assuming drive cache: write through
SCSI device sde: 2001888 512-byte hdwr sectors (1025 MB)
sde: Write Protect is off
sde: Mode Sense: 03 00 00 00
sde: assuming drive cache: write through
 sde: sde1
sd 6:0:0:0: Attached scsi removable disk sde
  Vendor: Generic   Model: USB Storage-MSC   Rev: I19A
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 6:0:0:1: Attached scsi removable disk sdf
  Vendor: Generic   Model: USB Storage-SMC   Rev: I19A
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 6:0:0:2: Attached scsi removable disk sdg
  Vendor: Generic   Model: USB Storage-SDC   Rev: I19A
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 6:0:0:3: Attached scsi removable disk sdh
usb-storage: device scan complete

--xsdg

--------------enig0DC8C3BB025846ED24AA2FFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDy0kTLa8oArNOsUERAohHAJsHopeT6Fi/AK1XeYLZwMWOheHaigCeNcng
bCfSMh4WycGSA+6BGbSmBTE=
=st4p
-----END PGP SIGNATURE-----

--------------enig0DC8C3BB025846ED24AA2FFC--
