From: Reinhard =?utf-8?q?Brandst=C3=A4dter?= <r.brandstaedter@gmx.at>
Subject: sata_via and SATA DVD drive (PX-712SA)
Date: Thu, 20 Apr 2006 20:20:17 +0200
Message-ID: <200604202020.22010.r.brandstaedter@gmx.at>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1286455.8AEoyWTq6p";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.noc.eunet-ag.at ([193.154.160.116]:23211 "EHLO
	smtp2.noc.eunet-ag.at") by vger.kernel.org with ESMTP
	id S1750762AbWDTSUg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Apr 2006 14:20:36 -0400
Received: from melchior.redchili.dyndns.org (redchili.dyndns.org [193.154.186.156])
	by smtp2.noc.eunet-ag.at (Postfix) with ESMTP id A69A33AE8E
	for <linux-ide@vger.kernel.org>; Thu, 20 Apr 2006 20:20:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by melchior.redchili.dyndns.org (Postfix) with ESMTP id C642A3E15
	for <linux-ide@vger.kernel.org>; Thu, 20 Apr 2006 20:22:48 +0200 (CEST)
Received: from melchior.redchili.dyndns.org ([127.0.0.1])
 by localhost (melchior.redchili.dyndns.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 19960-03 for <linux-ide@vger.kernel.org>;
 Thu, 20 Apr 2006 20:22:39 +0200 (CEST)
Received: from [192.168.1.89] (unknown [192.168.1.89])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by melchior.redchili.dyndns.org (Postfix) with ESMTP id 709C23DD3
	for <linux-ide@vger.kernel.org>; Thu, 20 Apr 2006 20:22:39 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--nextPart1286455.8AEoyWTq6p
Content-Type: multipart/mixed;
  boundary="Boundary-01=_hD9RE+oAC1qETwW"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_hD9RE+oAC1qETwW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

since 2.6.12 I try to get a Plextor PX-712SA (SATA DVD-RW) drive to work on=
 a=20
VIA SATA controller. Without success.

When I load the sata_via module the controller is initialized and two sata=
=20
interfaces are found (ata4 and ata5).
Scanning the attached drive fails, and i think the returned code indicates =
the=20
drive is busy:

=2E..
ata4: command 0xa0 timeout, stat 0xd0 host_stat 0x61
ata4: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
=2E..

The controller seems to lock up (IDE LED is on) after that.
I can unload the module and load it again, resulting in a timeout:

=2E..
ata6 is slow to respond, please be patient
ata6 failed to respond (30 secs)
=2E..

Attached my dmesg output with the messages of loading the module, unloading=
 it=20
and loading it again. (ata4 & ata5 found, then ata6 & ata7)

I also tried with SCSI debugging but this gives no additional info.

I hope I'm not completely wrong with posting to this list, but it's my last=
=20
resort.

Thanks,
Reinhard

--Boundary-01=_hD9RE+oAC1qETwW
Content-Type: text/plain;
  charset="utf-8";
  name="plextor-dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="plextor-dmesg.txt"

@cyberus.ca)
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 128M @ 0xc0000000
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: d0000000-d7ffffff
  PREFETCH window: c8000000-cfffffff
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.1
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.3
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:01.0 to 64
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 27 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:02.0, from 11 to 0
PCI: Setting latency timer of device 0000:00:02.0 to 64
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 31 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:03.0, from 11 to 1
PCI: Setting latency timer of device 0000:00:03.0 to 64
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 35 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:03.1, from 0 to 2
PCI: Setting latency timer of device 0000:00:03.1 to 64
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:03.2[C] -> GSI 39 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:03.2, from 11 to 3
PCI: Setting latency timer of device 0000:00:03.2 to 64
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:03.3[D] -> GSI 43 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:03.3, from 11 to 4
PCI: Setting latency timer of device 0000:00:03.3 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
squashfs: version 3.0 (2006/03/15) Phillip Lougher
JFS: nTxBlock =3D 8017, nTxLock =3D 64139
SGI XFS with ACLs, large block/inode numbers, no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
vesafb: framebuffer at 0xc8000000, mapped to 0xffffc20010700000, using 3072=
k, total 131072k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D1
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (37 C)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
mice: PS/2 mouse device common for all mice
isa bounce pool size: 16 pages
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input0
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
hda: IC35L060AVV207-0, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
Probing IDE interface ide1...
hdd: Pioneer DVD-ROM ATAPIModel DVD-115 0127, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 80418240 sectors (41174 MB) w/1821KiB Cache, CHS=3D16383/255/63
hda: cache flushes supported
 hda: hda1
hdb: max request size: 128KiB
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=3D65535/16/63
hdb: cache flushes supported
 hdb: hdb1
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
sata_promise 0000:00:0b.0: version 1.03
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 21
sata_promise PATA port found
ata1: SATA max UDMA/133 cmd 0xFFFFC2000000C200 ctl 0xFFFFC2000000C238 bmdma=
 0x0 irq 21
ata2: SATA max UDMA/133 cmd 0xFFFFC2000000C280 ctl 0xFFFFC2000000C2B8 bmdma=
 0x0 irq 21
ata3: PATA max UDMA/133 cmd 0xFFFFC2000000C300 ctl 0xFFFFC2000000C338 bmdma=
 0x0 irq 21
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:=
20ff
ata1: dev 0 ATA-7, max UDMA7, 312581808 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:=
20ff
ata2: dev 0 ATA-7, max UDMA7, 312581808 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_promise
ATA: abnormal status 0x8 on port 0xFFFFC2000000C31C
ata3: disabling port
scsi2 : sata_promise
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda2 sda3 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 >
sd 1:0:0:0: Attached scsi disk sdb
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
usbmon: debugfs is not available
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  6133.000 MB/sec
raid5: using function: generic_sse (6133.000 MB/sec)
raid6: int64x1   1901 MB/s
raid6: int64x2   2480 MB/s
raid6: int64x4   2467 MB/s
raid6: int64x8   1842 MB/s
raid6: sse2x1    2311 MB/s
raid6: sse2x2    3053 MB/s
raid6: sse2x4    3615 MB/s
raid6: using algorithm sse2x4 (3615 MB/s)
md: raid6 personality registered for level 6
md: multipath personality registered for level -4
md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: bitmap version 4.39
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:5=
7:20 2006 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.0)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x6 (1400 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x8 (1350 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xc, vid 0x6
ACPI wakeup devices:=20
PCI0 USB0 USB1 USB2 USB3 USB4 USB5 USB6 AC97 PEXG PEX0 PEX1 PEX2 PEX3=20
ACPI: (supports S0 S1 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 4 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: sdb3: found reiserfs format "3.6" with standard journal
ReiserFS: sdb3: using ordered data mode
ReiserFS: sdb3: journal params: device sdb3, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb3: checking transaction log (sdb3)
ReiserFS: sdb3: replayed 14 transactions in 0 seconds
ReiserFS: sdb3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
=46reeing unused kernel memory: 200k freed
Adding 498004k swap on /dev/sdb2.  Priority:-1 extents:1 across:498004k
ndiswrapper version 1.13 loaded (preempt=3Dno,smp=3Dno)
ndiswrapper (load_pe_images:573): fixing KI_USER_SHARED_DATA address in the=
 driver
ndiswrapper: driver mrv8knt (Marvell,11/16/2004,2.7.1.2) loaded
GSI 22 sharing vector 0xD9 and IRQ 22
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 17 (level, low) -> IRQ 22
ndiswrapper: using irq 22
wlan0: vendor: 'Marvell 802.11 Driver'
wlan0: ndiswrapper ethernet device 00:11:d8:98:d0:f1 using driver mrv8knt, =
11AB:1FA7.5.conf
wlan0: encryption modes supported: WEP; TKIP with WPA, WPA2, WPA2PSK; AES/C=
CMP with WPA, WPA2, WPA2PSK
md: raidstart(pid 1423) used deprecated START_ARRAY ioctl. This will not be=
 supported beyond July 2006
md: autorun ...
md: considering sdb8 ...
md:  adding sdb8 ...
md:  adding sda5 ...
md: created md0
md: bind<sda5>
md: bind<sdb8>
md: running: <sdb8><sda5>
md0: setting max_sectors to 16, segment boundary to 4095
raid0: looking at sdb8
raid0:   comparing sdb8(111739968) with sdb8(111739968)
raid0:   END
raid0:   =3D=3D> UNIQUE
raid0: 1 zones
raid0: looking at sda5
raid0:   comparing sda5(111739968) with sdb8(111739968)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 223479936 blocks.
raid0 : conf->hash_spacing is 223479936 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
ReiserFS: sdb5: found reiserfs format "3.6" with standard journal
ReiserFS: sdb5: using ordered data mode
ReiserFS: sdb5: journal params: device sdb5, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb5: checking transaction log (sdb5)
ReiserFS: sdb5: replayed 3 transactions in 0 seconds
ReiserFS: sdb5: Using r5 hash to sort names
ReiserFS: sdb6: found reiserfs format "3.6" with standard journal
ReiserFS: sdb6: using ordered data mode
ReiserFS: sdb6: journal params: device sdb6, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb6: checking transaction log (sdb6)
ReiserFS: sdb6: replayed 56 transactions in 0 seconds
ReiserFS: sdb6: Using r5 hash to sort names
ReiserFS: sdb7: found reiserfs format "3.6" with standard journal
ReiserFS: sdb7: using ordered data mode
ReiserFS: sdb7: journal params: device sdb7, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb7: checking transaction log (sdb7)
ReiserFS: sdb7: replayed 3 transactions in 0 seconds
ReiserFS: sdb7: Using r5 hash to sort names
ReiserFS: md0: found reiserfs format "3.6" with standard journal
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ReiserFS: md0: using ordered data mode
ReiserFS: md0: journal params: device md0, size 8192, journal first block 1=
8, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md0: checking transaction log (md0)
ReiserFS: md0: replayed 3 transactions in 0 seconds
ReiserFS: md0: Using r5 hash to sort names
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
GSI 23 sharing vector 0xE1 and IRQ 23
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI 22 (level, low) -=
> IRQ 23
PCI: Via IRQ fixup for 0000:00:11.5, from 11 to 7
PCI: Setting latency timer of device 0000:00:11.5 to 64
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (iw_set_tx_power:459): setting tx_power failed (C00000BB)
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
wlan0: no IPv6 routers present
GSI 24 sharing vector 0xE9 and IRQ 24
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 24 (level, low) -> IRQ 24
PCI: Setting latency timer of device 0000:02:00.0 to 64
NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-8756  Wed Mar 29 15:12=
:41 PST 2006
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
GSI 25 sharing vector 0x32 and IRQ 25
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 (level, low) -=
> IRQ 25
PCI: Via IRQ fixup for 0000:00:0f.0, from 11 to 9
sata_via 0000:00:0f.0: routed to hard irq line 9
ata4: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 25
ata5: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 25
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:=
0407
ata4: dev 0 ATAPI, max UDMA/33
ata4(0): applying bridge limits
ata4: dev 0 configured for UDMA/33
scsi3 : sata_via
ata5: SATA link down (SStatus 0)
scsi4 : sata_via
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ata4: command 0xa0 timeout, stat 0xd0 host_stat 0x61
ata4: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ACPI: PCI interrupt for device 0000:00:0f.0 disabled
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 (level, low) -=
> IRQ 25
sata_via 0000:00:0f.0: routed to hard irq line 9
ata6: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 25
ata7: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 25
ata6: SATA link up 1.5 Gbps (SStatus 113)
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ata6 is slow to respond, please be patient
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ata6 failed to respond (30 secs)
scsi5 : sata_via
ata7: SATA link down (SStatus 0)
scsi6 : sata_via
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset
ndiswrapper (wrap_ndis_worker_proc:1001): wlan0 is being reset

--Boundary-01=_hD9RE+oAC1qETwW--

--nextPart1286455.8AEoyWTq6p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBER9DlkeAWQwM7gdsRAnjkAJ90ZBUwxxlyqLjXwY6Csf99oIxonACeKCmo
TKx+koUzo0D+zGFOvRVlZb0=
=1YLl
-----END PGP SIGNATURE-----

--nextPart1286455.8AEoyWTq6p--
