From: "Ruben Moretti" <moretti@labor-enders.de>
Subject: Promise SX4 controllers strange Port1 Issue
Date: Fri, 2 Sep 2005 12:35:04 +0200
Message-ID: <005401c5afa9$fb5bd300$1e0a1eac@mmoretti>
Reply-To: "Ruben Moretti" <moretti@labor-enders.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ad96e11b2.dsl.de.colt.net ([217.110.17.178]:12177 "EHLO
	linus.labor-enders.de") by vger.kernel.org with ESMTP
	id S1030240AbVIBKfP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Sep 2005 06:35:15 -0400
Received: from localhost (unknown [127.0.0.1])
	by linus.labor-enders.de (Postfix) with ESMTP id CB84F97D5A
	for <linux-ide@vger.kernel.org>; Fri,  2 Sep 2005 10:35:04 +0000 (UTC)
Received: from linus.labor-enders.de ([127.0.0.1])
 by localhost (linus.labor-enders.de [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 20092-11-2 for <linux-ide@vger.kernel.org>;
 Fri,  2 Sep 2005 12:35:04 +0200 (CEST)
Received: from mmoretti (pc-moretti.enders.de [172.30.10.30])
	by linus.labor-enders.de (Postfix) with SMTP id 2C86B97D52
	for <linux-ide@vger.kernel.org>; Fri,  2 Sep 2005 12:35:04 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello List Co ;)

 I'm running 2.6.12 /2.6.13 kernel on a single CPU (P4-Celeron)/Fedora.
Board  ASROCK 775V88 with 2 Sata ports onboard. (sata_via)
With two promise SX4 cards serving seven SATA HDs on their seven channe=
ls
(RAID). [Card1 Port 2,3,4  - Card2 Port 2,3,4]
Now  I added  HDDs to the controller 1 or 2. All HDs are connected as
master; one HD per channel.
Now wenn i add the HDDs on  Ports 1, I get errors for the  added HD,  a=
nd
for the previously installed ones.
There's no irq problem and no HD or controller problem (checked this by
cross-changing).
Tested with kernels 2.6.12 /2.6.13
Log File, one with and one without HDD on Port 1 [Both Cards with HDDs =
on
Port 2,3,4]

Any more ideas or hint?

Thanks in advance

Ruben Moretti



--- Snip with HDD on Port 1 Card 1
Linux version 2.6.12-1.1447_FC4 (bhcompile@decompose.build.redhat.com) =
(gcc
version 4.0.1 20050727 (Red Hat 4.0.1-5)) #1 Fri Aug 26 20:29:51 EDT 20=
05
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
Using x86 segment limits to approximate NX protection
DMI 2.3 present.
Allocating PCI resources starting at 40000000 (gap: 40000000:bffc0000)
Built 1 zonelists
Kernel command line: ro root=3D/dev/md3 acpi=3Doff pci=3Dnoacpi ide=3Dn=
odma
console=3DttyS0 console=3Dtty0
ide_setup: ide=3Dnodma : Prevented DMA
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc0458000 soft=3Dc0457000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2684.955 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033384k/1048256k available (2518k kernel code, 14048k reserved=
,
690k data, 184k init, 130752k highmem)
Checking if this processor honours the WP bit even in supervisor mode..=
=2E Ok.
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU: Intel(R) Celeron(R) CPU 2.80GHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
=46reeing initrd memory: 1199k freed
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050729
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3227] at 0000:00:11.0
PCI: IRQ 0 for device 0000:00:0f.1 doesn't match PIRQ mask - try
pci=3Dusepirqmask
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1125392498.474:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 1C1942C715575330
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA PT880 chipset
agpgart: AGP aperture is 64M @ 0xf8000000
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabl=
ed
=FFttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebu=
s=3Dxx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
PCI: IRQ 0 for device 0000:00:0f.1 doesn't match PIRQ mask - try
pci=3Dusepirqmask
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD400BB-23DEA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD400BB-23DEA0, ATA DISK drive
hdd: GCR-8523B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
        current capacity is 78156288 sectors (40016 MB)
        native  capacity is 78165360 sectors (40020 MB)
hda: Host Protected Area disabled.
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=3D65535/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: max request size: 128KiB
hdc: Host Protected Area detected.
        current capacity is 78156288 sectors (40016 MB)
        native  capacity is 78165360 sectors (40020 MB)
hdc: Host Protected Area disabled.
hdc: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=3D65535/16/63
hdc: cache flushes not supported
 hdc: hdc1 hdc2 hdc3
hdd: ATAPI 52X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
=46reeing unused kernel memory: 184k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
SCSI subsystem initialized
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 10
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 10
logips2pp: Detected unknown logitech mouse model 1
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
  Vendor: ATA       Model: Maxtor 6L200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: ATA       Model: Maxtor 6L200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Local DIMM ECC Enabled
ata3: SATA max UDMA/133 cmd 0xF89C0200 ctl 0xF89C0238 bmdma 0x0 irq 5
ata4: SATA max UDMA/133 cmd 0xF89C0280 ctl 0xF89C02B8 bmdma 0x0 irq 5
ata5: SATA max UDMA/133 cmd 0xF89C0300 ctl 0xF89C0338 bmdma 0x0 irq 5
ata6: SATA max UDMA/133 cmd 0xF89C0380 ctl 0xF89C03B8 bmdma 0x0 irq 5
ata3: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_sx4
ata4: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_sx4
ata5: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata5: dev 0 configured for UDMA/133
scsi4 : sata_sx4
ata6: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata6: dev 0 configured for UDMA/133
scsi5 : sata_sx4
  Vendor: ATA       Model: Maxtor 6L200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdc: drive cache: write back
 sdc:<3>ata3: command timeout
ata3: status=3D0x51 { DriveReady SeekComplete Error }
ata3: called with no error (51)!
SCSI error : <2 0 0 0> return code =3D 0x8000002
sdc: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdc, sector 8
Buffer I/O error on device sdc, logical block 1
ata3: command timeout
ata3: status=3D0x51 { DriveReady SeekComplete Error }
ata3: called with no error (51)!
SCSI error : <2 0 0 0> return code =3D 0x8000002
sdc: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdc, sector 8
Buffer I/O error on device sdc, logical block 1
Dev sdc: unable to read RDB block 8
 unknown partition table
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
  Vendor: ATA       Model: Maxtor 6L200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdd: drive cache: write back
 sdd:<3>ata4: command timeout
ata4: status=3D0x51 { DriveReady SeekComplete Error }
ata4: called with no error (51)!
SCSI error : <3 0 0 0> return code =3D 0x8000002
sdd: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdd, sector 0
Buffer I/O error on device sdd, logical block 0
ata4: command timeout
ata4: status=3D0x51 { DriveReady SeekComplete Error }
ata4: called with no error (51)!
SCSI error : <3 0 0 0> return code =3D 0x8000002
sdd: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdd, sector 0
Buffer I/O error on device sdd, logical block 0
ata4: command timeout
ata4: status=3D0x51 { DriveReady SeekComplete Error }
ata4: called with no error (51)!
SCSI error : <3 0 0 0> return code =3D 0x8000002
sdd: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdd, sector 0
Buffer I/O error on device sdd, logical block 0
 unable to read partition table
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
  Vendor: ATA       Model: Maxtor 6L200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sde: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sde: drive cache: write back
SCSI device sde: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sde: drive cache: write back
 sde:<3>ata5: command timeout
ata5: status=3D0x51 { DriveReady SeekComplete Error }
ata5: called with no error (51)!
SCSI error : <4 0 0 0> return code =3D 0x8000002
sde: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sde, sector 0
Buffer I/O error on device sde, logical block 0
ata5: command timeout
ata5: status=3D0x51 { DriveReady SeekComplete Error }
ata5: called with no error (51)!
SCSI error : <4 0 0 0> return code =3D 0x8000002
sde: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sde, sector 0
Buffer I/O error on device sde, logical block 0
ata5: command timeout
ata5: status=3D0x51 { DriveReady SeekComplete Error }
ata5: called with no error (51)!
SCSI error : <4 0 0 0> return code =3D 0x8000002
sde: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sde, sector 0
Buffer I/O error on device sde, logical block 0
 unable to read partition table
Attached scsi disk sde at scsi4, channel 0, id 0, lun 0
  Vendor: ATA       Model: Maxtor 6L200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdf: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdf: drive cache: write back
SCSI device sdf: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdf: drive cache: write back
 sdf:<3>ata6: command timeout
ata6: status=3D0x51 { DriveReady SeekComplete Error }
ata6: called with no error (51)!
SCSI error : <5 0 0 0> return code =3D 0x8000002
sdf: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdf, sector 0
Buffer I/O error on device sdf, logical block 0
ata6: command timeout
ata6: status=3D0x51 { DriveReady SeekComplete Error }
ata6: called with no error (51)!
SCSI error : <5 0 0 0> return code =3D 0x8000002
sdf: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdf, sector 0
Buffer I/O error on device sdf, logical block 0
ata6: command timeout
ata6: status=3D0x51 { DriveReady SeekComplete Error }
ata6: called with no error (51)!
SCSI error : <5 0 0 0> return code =3D 0x8000002
sdf: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdf, sector 0
Buffer I/O error on device sdf, logical block 0
 unable to read partition table
Attached scsi disk sdf at scsi5, channel 0, id 0, lun 0
Local DIMM ECC Enabled
ata7: SATA max UDMA/133 cmd 0xF8B40200 ctl 0xF8B40238 bmdma 0x0 irq 10
ata8: SATA max UDMA/133 cmd 0xF8B40280 ctl 0xF8B402B8 bmdma 0x0 irq 10
ata9: SATA max UDMA/133 cmd 0xF8B40300 ctl 0xF8B40338 bmdma 0x0 irq 10
ata10: SATA max UDMA/133 cmd 0xF8B40380 ctl 0xF8B403B8 bmdma 0x0 irq 10
ATA: abnormal status 0x7F on port 0xF8B4021C
scsi6 : sata_sx4
ata8: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata8: dev 0 configured for UDMA/133
scsi7 : sata_sx4
ata9: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata9: dev 0 configured for UDMA/133
scsi8 : sata_sx4
ata10: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata10: dev 0 configured for UDMA/133
scsi9 : sata_sx4
  Vendor: ATA       Model: Maxtor 6L200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdg: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdg: drive cache: write back
SCSI device sdg: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdg: drive cache: write back
 sdg: unknown partition table
Attached scsi disk sdg at scsi7, channel 0, id 0, lun 0
  Vendor: ATA       Model: Maxtor 6L200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdh: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdh: drive cache: write back
SCSI device sdh: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdh: drive cache: write back
 sdh: sdh1
Attached scsi disk sdh at scsi8, channel 0, id 0, lun 0
  Vendor: ATA       Model: Maxtor 6L200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdi: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdi: drive cache: write back
SCSI device sdi: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdi: drive cache: write back
 sdi: sdi1
Attached scsi disk sdi at scsi9, channel 0, id 0, lun 0
md: raid1 personality registered as nr 3
md: Autodetecting RAID arrays.
md: autorun ...
------

lspci -v
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0258
        Subsystem: ASRock Incorporation: Unknown device 0258
        Flags: bus master, 66Mhz, medium devsel, latency 8
        Memory at f8000000 (32-bit, prefetchable) [size=3D64M]
        Capabilities: [80] AGP version 3.5
        Capabilities: [50] Power Management version 2

00:00.1 Host bridge: VIA Technologies, Inc. PT880 Host Bridge
        Subsystem: ASRock Incorporation: Unknown device 1258
        Flags: bus master, medium devsel, latency 0

00:00.2 Host bridge: VIA Technologies, Inc. PT880 Host Bridge
        Subsystem: ASRock Incorporation: Unknown device 2258
        Flags: bus master, medium devsel, latency 0

00:00.3 Host bridge: VIA Technologies, Inc. PT880 Host Bridge
        Subsystem: ASRock Incorporation: Unknown device 3258
        Flags: bus master, medium devsel, latency 0

00:00.4 Host bridge: VIA Technologies, Inc. PT880 Host Bridge
        Subsystem: ASRock Incorporation: Unknown device 4258
        Flags: bus master, medium devsel, latency 0

00:00.7 Host bridge: VIA Technologies, Inc. PT880 Host Bridge
        Subsystem: ASRock Incorporation: Unknown device 7258
        Flags: bus master, medium devsel, latency 0

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 0=
0
[Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latenc=
y=3D0
        Memory behind bridge: fc600000-fe6fffff
        Prefetchable memory behind bridge: f3f00000-f7efffff
        Capabilities: [70] Power Management version 2

00:0b.0 RAID bus controller: Promise Technology, Inc. PDC20621 [SATA150=
 SX4]
4 Channel IDE RAID Controller (rev 01)
        Subsystem: Promise Technology, Inc. PDC20621 [SATA150 SX4] 4 Ch=
annel
IDE RAID Controller
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 5
        I/O ports at b000 [size=3D256]
        I/O ports at a800 [size=3D256]
        I/O ports at a400 [size=3D256]
        Memory at fe900000 (32-bit, non-prefetchable) [size=3D1M]
        Memory at febd8000 (32-bit, non-prefetchable) [size=3D32K]
        Expansion ROM at febc0000 [disabled] [size=3D64K]
        Capabilities: [60] Power Management version 1

00:0d.0 RAID bus controller: Promise Technology, Inc. PDC20621 [SATA150=
 SX4]
4 Channel IDE RAID Controller (rev 01)
        Subsystem: Promise Technology, Inc. PDC20621 [SATA150 SX4] 4 Ch=
annel
IDE RAID Controller
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 10
        I/O ports at c000 [size=3D256]
        I/O ports at b800 [size=3D256]
        I/O ports at b400 [size=3D256]
        Memory at fea00000 (32-bit, non-prefetchable) [size=3D1M]
        Memory at febf0000 (32-bit, non-prefetchable) [size=3D32K]
        Expansion ROM at febe0000 [disabled] [size=3D64K]
        Capabilities: [60] Power Management version 1

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAI=
D
Controller (rev 80)
        Subsystem: ASRock Incorporation: Unknown device 3149
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at ec00 [size=3D8]
        I/O ports at e800 [size=3D4]
        I/O ports at e400 [size=3D8]
        I/O ports at e000 [size=3D4]
        I/O ports at dc00 [size=3D16]
        I/O ports at d800 [size=3D256]
        Capabilities: [c0] Power Management version 2

00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-=
if 8a
[Master SecP PriP])
        Subsystem: ASRock Incorporation K7VT2 motherboard
        Flags: bus master, medium devsel, latency 32
        I/O ports at fc00 [size=3D16]
        Capabilities: [c0] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
        Subsystem: ASRock Incorporation: Unknown device 3227
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (=
rev
78)
        Subsystem: ASRock Incorporation: Unknown device 3065
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d400 [size=3D256]
        Memory at febffc00 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [40] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2
Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
        Subsystem: PROLINK Microsystems Corp Pixelview RIVA TNT2 M64
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
        Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M]
        Memory at f4000000 (32-bit, prefetchable) [size=3D32M]
        Expansion ROM at fe6f0000 [disabled] [size=3D64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0






cat /proc/interrupts
           CPU0
  0:     217348          XT-PIC  timer
  1:         44          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:         12          XT-PIC  serial
  5:        135          XT-PIC  libata
  8:          1          XT-PIC  rtc
 10:        158          XT-PIC  libata, libata
 11:        513          XT-PIC  eth0
 12:        101          XT-PIC  i8042
 14:       4612          XT-PIC  ide0
 15:       5431          XT-PIC  ide1
NMI:          0
ERR:          0=20

