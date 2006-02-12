From: Johny <kernel@agotnes.com>
Subject: Promise SX4 - strange test results
Date: Sun, 12 Feb 2006 15:29:02 +1000
Message-ID: <43EEC79E.1000604@agotnes.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040101030800090806040807"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from munin.agotnes.com ([202.173.149.60]:21479 "EHLO
	mail.agotnes.com") by vger.kernel.org with ESMTP id S932253AbWBLFa0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Feb 2006 00:30:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.agotnes.com (Postfix) with ESMTP id E986460057
	for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 15:30:23 +1000 (EST)
Received: from mail.agotnes.com ([127.0.0.1])
 by localhost (munin.agotnes.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22570-17 for <linux-ide@vger.kernel.org>;
 Sun, 12 Feb 2006 15:30:20 +1000 (EST)
Received: from [172.31.254.148] (unknown [172.31.254.148])
	by mail.agotnes.com (Postfix) with ESMTP id E14FB60039
	for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 15:30:20 +1000 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernel list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040101030800090806040807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I've been trying to get my Promise SX4 card setup and functional under 
load with the latest kernels (2.6.16-rc2-mm1), and have had a couple of 
weird results.

I have attached my dmesg for the hardware details, the setup is real simple;

Promise SX4 (not an M, with non-ECC memory - tested with 4 different 
chips of different brands - same symptom)

2 Seagate 80GB drives,

md set to use them as RAID 1 (mirrored), with ext3 as the fs.

Problem 1;
------------
With drives hooked up I only get the following transfer speeds out of 
hdparm -tT;

/dev/sda:
  Timing cached reads:   1028 MB in  2.01 seconds = 512.18 MB/sec
  Timing buffered disk reads:   40 MB in  3.10 seconds =  12.90 MB/sec

On my PATA drive in the same system I get the following speeds;

/dev/hdc:
  Timing cached reads:   1020 MB in  2.01 seconds = 508.45 MB/sec
  Timing buffered disk reads:  172 MB in  3.03 seconds =  56.83 MB/sec

Anyone else get better performance out of the SX4? If so, how? Is there 
anything I can tune here, as hdparm hasn't got any options I can execute 
against the SATA drive...

Problem 2;
--------------
With drives hooked up to ports 1 & 2 on the controller.

I mount md0 under /mnt, cp a bunch of files (/var, in fact) onto the 
raid array and simultaneously run 'du -sk /mnt/raidFiles'). The copy 
fails immediately with the following errors;

Feb 11 08:36:01 localhost kernel: EXT3-fs error (device md0): 
ext3_readdir: bad entry in directory #9109506: rec_len %% 4 != 0 - 
offset=0, inode=1164442529, rec_len=17046, name_len=248
Feb 11 08:36:01 localhost kernel: Aborting journal on device md0.
Feb 11 08:36:54 localhost kernel: ext3_abort called.
Feb 11 08:36:54 localhost kernel: EXT3-fs error (device md0): 
ext3_journal_start_sb: Detected aborted journal
Feb 11 08:36:54 localhost kernel: Remounting filesystem read-only

This obviously concerns me, I've tried to have 1 drive on port 1 and one 
on port 4, which seems to work, however, it hardly fills me with 
confidence to move them and suddenly have it work ;)

Anything I can do to provide further debug? I've seen rather a lot of EH 
code getting committed lately, has that made it into the -mm series yet? 
If not, should I get a snapshot of the latest kernel to test with and 
get some EH diagnostics? If so - which kernel? :)

Let me know,

Cheers,

:)Johny

--------------040101030800090806040807
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

4ce000 soft=c04cd000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 904996k/917504k available (2760k kernel code, 12076k reserved, 935k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3323.46 BogoMIPS (lpj=6646939)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Sempron(tm)   2400+ stepping 01
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0e20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb9f0, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 0400-047f claimed by vt8235 PM
PCI quirk: region 5000-500f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 11 12) *5
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs *20), disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs *21)
ACPI: PCI Interrupt Link [ALKC] (IRQs *22)
ACPI: PCI Interrupt Link [ALKD] (IRQs *23)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:02: ioport range 0x400-0x47f could not be reserved
pnp: 00:02: ioport range 0x5000-0x500f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e8000000-e9ffffff
  PREFETCH window: e4000000-e7ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1139753963.192:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (59 C)
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 10
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: PIONEER DVD-RW DVR-109, ATAPI CD/DVD-ROM drive
hdb: HL-DT-ST GCE-8525B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HDS722580VLAT20, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 512KiB
hdc: 160836480 sectors (82348 MB) w/1794KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
hdb: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
libata version 1.20 loaded.
sata_sx4 0000:00:0a.0: version 0.8
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ata1: SATA max UDMA/133 cmd 0xF8940200 ctl 0xF8940238 bmdma 0x0 irq 11
ata2: SATA max UDMA/133 cmd 0xF8940280 ctl 0xF89402B8 bmdma 0x0 irq 11
ata3: SATA max UDMA/133 cmd 0xF8940300 ctl 0xF8940338 bmdma 0x0 irq 11
ata4: SATA max UDMA/133 cmd 0xF8940380 ctl 0xF89403B8 bmdma 0x0 irq 11
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_sx4
scsi1 : sata_sx4
scsi2 : sata_sx4
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata4: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_sx4
  Vendor: ATA       Model: ST380817AS        Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST380817AS        Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 3:0:0:0: Attached scsi disk sdb
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 3:0:0:0: Attached scsi generic sg1 type 0
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugfs is not available
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Via IRQ fixup for 0000:00:10.3, from 5 to 11
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: irq 11, io mem 0xeb12a000
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.16-rc2-mm1 ehci_hcd
usb usb1: SerialNumber: 0000:00:10.3
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 10, io base 0x0000cc00
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.16-rc2-mm1 uhci_hcd
usb usb2: SerialNumber: 0000:00:10.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 11, io base 0x0000d000
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.16-rc2-mm1 uhci_hcd
usb usb3: SerialNumber: 0000:00:10.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 11, io base 0x0000d400
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.16-rc2-mm1 uhci_hcd
usb usb4: SerialNumber: 0000:00:10.2
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-4: new high speed USB device using ehci_hcd and address 3
usb 1-4: new device found, idVendor=050d, idProduct=0249
usb 1-4: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-4: Product: USB 2 Flash Media Device
usb 1-4: Manufacturer: BELKIN
usb 1-4: SerialNumber: 249010002583
usb 1-4: configuration #1 chosen from 1 choice
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: new device found, idVendor=0731, idProduct=0528
usb 3-1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 3-1: configuration #1 chosen from 1 choice
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
scsi4 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.11rc3 (Thu Feb 02 07:50:46 2006 UTC).
ALSA device list:
  No soundcards found.
oprofile: using timer interrupt.
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
ip_conntrack version 2.4 (7168 buckets, 57344 max) - 172 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed
Time: acpi_pm clocksource has been installed.
input: PS2++ Logitech Wheel Mouse as /class/input/input1
Adding 498004k swap on /dev/hdc2.  Priority:-1 extents:1 across:498004k
EXT3 FS on hdc4, internal journal
  Vendor: BELKIN    Model: USB 2 HS-CF       Rev: 3.23
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 4:0:0:0: Attached scsi removable disk sdc
sd 4:0:0:0: Attached scsi generic sg2 type 0
  Vendor: BELKIN    Model: USB 2 HS-MS       Rev: 3.23
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 4:0:0:1: Attached scsi removable disk sdd
sd 4:0:0:1: Attached scsi generic sg3 type 0
  Vendor: BELKIN    Model: USB 2 HS-SM/XD    Rev: 3.23
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 4:0:0:2: Attached scsi removable disk sde
sd 4:0:0:2: Attached scsi generic sg4 type 0
  Vendor: BELKIN    Model: USB 2 HS-SD/MMC   Rev: 3.23
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 4:0:0:3: Attached scsi removable disk sdf
sd 4:0:0:3: Attached scsi generic sg5 type 0
usb-storage: device scan complete
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
md: raidstart(pid 5390) used deprecated START_ARRAY ioctl. This will not be supported beyond July 2006
md: autorun ...
md: considering sdb ...
md:  adding sdb ...
md:  adding sda ...
md: created md0
md: bind<sda>
md: bind<sdb>
md: running: <sdb><sda>
md: raid1 personality registered for level 1
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
acx: this driver is still EXPERIMENTAL
acx: reading README file and/or Craig's HOWTO is recommended, visit http://acx100.sf.net in case of further questions/discussion
acx: compiled to use 32bit I/O access. I/O timing issues might occur, such as non-working firmware upload. Report them
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
acx: found ACX111-based wireless network card at 0000:00:08.0, irq:10, phymem1:0xEB128000, phymem2:0xEB100000, mem1:0xf8858000, mem1_size:8192, mem2:0xf8a00000, mem2_size:131072
NVS_vendor_offs:01CD probe_delay:200 eof_memory:1114112
CCAModes:04 Diversity:01 ShortPreOpt:01 PBCC:01 ChanAgil:00 PHY:05 Temp:01
AntennaID:00 Len:02 Data:01 02 
PowerLevelID:01 Len:02 Data:001E 000A 
DataRatesID:02 Len:05 Data:02 04 11 22 44 
DomainID:03 Len:06 Data:41 20 30 31 32 40 
ProductID:04 Len:09 Data:TI ACX100
ManufacturerID:05 Len:07 Data:TI Test
acx: form factor 0x01 ((mini-)PCI / CardBus), radio type 0x16 (Radia), EEPROM version 0x05, uploaded firmware 'Rev 1.2.1.34' (0x03010101)
acx v0.3.31: net device wlan0, driver compiled against wireless extensions 19 and Linux 2.6.16-rc2-mm1
process `named' is using obsolete setsockopt SO_BSDCOMPAT
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

--------------040101030800090806040807--
