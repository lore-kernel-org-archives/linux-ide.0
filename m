From: Larry Battraw <lbattraw@insightbb.com>
Subject: Problems with SiL3114 and WDC WD2500SD-01K
Date: Sat, 20 Aug 2005 18:36:47 -0500
Message-ID: <1124581007.5764.10.camel@rambo.fortresscode.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 12-208-38-136.client.insightBB.com ([12.208.38.136]:27114 "EHLO
	12-203-209-98.client.insightBB.com") by vger.kernel.org with ESMTP
	id S1750720AbVHTXg5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Aug 2005 19:36:57 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by 12-203-209-98.client.insightBB.com (Postfix) with ESMTP id 70C7A5F6824
	for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2005 18:36:49 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

  I installed a SiL3114-based PCI card (Syba) and Western Digital
WD2500SD in my system recently and haven't been able to get the system
to write/read any data from the drive beyond the initial drive probe.  I
get a lot of messages about "ATA: abnormal status 0xD8 on port
0xF081C0C7" and SCSI parity errors.  This seems to be a problem that
affected people quite a while ago, and I'm not sure why it's appearing
with a recent kernel (2.6.12.5).  I've attached the output from dmesg.
Any ideas on what's happening?

Larry

Linux version 2.6.12.5 (root@rambo.fortresscode.com) (gcc version 4.0.1
20050710 (Red Hat 4.0.1-2)) #1 Thu Aug 18 21:23:12 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
 BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ffec000 (usable)
 BIOS-e820: 000000002ffec000 - 000000002ffef000 (ACPI data)
 BIOS-e820: 000000002ffef000 - 000000002ffff000 (reserved)
 BIOS-e820: 000000002ffff000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
767MB LOWMEM available.
On node 0 totalpages: 196588
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192492 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a10
ACPI: RSDT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @
0x2ffec000
ACPI: FADT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @
0x2ffec080
ACPI: BOOT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @
0x2ffec040
ACPI: DSDT (v001   ASUS A7V-133  0x00001000 MSFT 0x0100000b) @
0x00000000
ACPI: PM-Timer IO Port: 0xe408
Allocating PCI resources starting at 30000000 (gap: 30000000:cfff0000)
Built 1 zonelists
Kernel command line: ro root=/dev/sda2
Initializing CPU#0
CPU 0 irqstacks, hard=c047d000 soft=c047c000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1209.141 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 774164k/786352k available (2666k kernel code, 11672k reserved,
682k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 2392.06 BogoMIPS (lpj=1196032)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 4c20)
checking if image is initramfs... it is
Freeing initrd memory: 733k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 *14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f ->
09
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:02: ioport range 0xe800-0xe80f has been reserved
Simple Boot Flag at 0x3a set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1124556250.152:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
Applying VIA southbridge workaround.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 16 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 256M @ 0xd0000000
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing
enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide1...
hdc: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKB] -> GSI 10 (level,
low) -> IRQ 10
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x5800-0x5807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x5808-0x580f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Maxtor 6Y160P0, ATA DISK drive
ide2 at 0x7000-0x7007,0x6802 on irq 10
Probing IDE interface ide3...
Probing IDE interface ide0...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hde: max request size: 128KiB
hde: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63,
UDMA(100)
hde: cache flushes supported
 hde: hde1 hde2 hde3 hde4
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
PWRB PCI0 UAR1 UAR2 USB0 USB1 
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 192k freed
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 14
PCI: setting IRQ 14 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 14 (level,
low) -> IRQ 14
aic7xxx: PCI Device 0:10:0 failed memory mapped test.  Using PIO.
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
  Vendor: SEAGATE   Model: SX150176LC        Rev: BA11
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:1:0: Tagged Queuing enabled.  Depth 4
 target0:0:1: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:1): 6.600MB/s transfers (16bit)
 target0:0:1: Domain Validation skipping write tests
(scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
 target0:0:1: Ending Domain Validation
SCSI device sda: 97693755 512-byte hdwr sectors (50019 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 97693755 512-byte hdwr sectors (50019 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
libata version 1.11 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level,
low) -> IRQ 10
ata1: SATA max UDMA/100 cmd 0xF081C080 ctl 0xF081C08A bmdma 0xF081C000
irq 10
ata2: SATA max UDMA/100 cmd 0xF081C0C0 ctl 0xF081C0CA bmdma 0xF081C008
irq 10
ata3: SATA max UDMA/100 cmd 0xF081C280 ctl 0xF081C28A bmdma 0xF081C200
irq 10
ata4: SATA max UDMA/100 cmd 0xF081C2C0 ctl 0xF081C2CA bmdma 0xF081C208
irq 10
ata1: no device found (phy stat 00000000)
scsi1 : sata_sil
ata2: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003
88:207f
ata2: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata3: no device found (phy stat 00000000)
scsi3 : sata_sil
ata4: no device found (phy stat 00000000)
scsi4 : sata_sil
  Vendor: ATA       Model: WDC WD2500SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
md: raid1 personality registered as nr 3
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sda3 ...
md:  adding sda3 ...
md:  adding hde4 ...
md: created md0
md: bind<hde4>
md: bind<sda3>
md: running: <sda3><hde4>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.27
PCI: Enabling device 0000:00:0d.0 (0004 -> 0007)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 5 (level, low)
-> IRQ 5
eth0: RealTek RTL8139 at 0x7400, 00:48:54:6b:86:15, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139B'
PCI: Enabling device 0000:00:0c.0 (0004 -> 0005)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKA] -> GSI 11 (level,
low) -> IRQ 11
usbcore: registered new driver snd-usb-audio
PCI: Enabling device 0000:00:0c.1 (0004 -> 0005)
gameport: EMU10K1 is pci0000:00:0c.1/gameport0, io 0x7800, speed 1242kHz
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
parport_pc: VIA parallel port: io=0x378, irq=7
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 5 (level, low)
-> IRQ 5
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:04.2: irq 5, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:04.3[D] -> Link [LNKD] -> GSI 5 (level, low)
-> IRQ 5
uhci_hcd 0000:00:04.3: UHCI Host Controller
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:04.3: irq 5, io base 0x0000d000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using uhci_hcd and address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:00:09.0 (0094 -> 0097)
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 5 (level, low)
-> IRQ 5
PCI: Via IRQ fixup for 0000:00:09.0, from 255 to 5
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[5]
MMIO=[c5800000-c58007ff]  Max Packet=[2]
ohci1394: fw-host0: Serial EEPROM has suspicious values, attempting to
setting max_packet_size to 512 bytes
usb 2-2: new full speed USB device using uhci_hcd and address 2
usb 1-1.1: new full speed USB device using uhci_hcd and address 3
usb 1-1.3: new full speed USB device using uhci_hcd and address 4
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011060000006c17]
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0
alt 0 proto 2 vid 0x03F0 pid 0x3404
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
Initializing USB Mass Storage driver...
scsi5 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9144
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdc at scsi5, channel 0, id 0, lun 0
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9144
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdd at scsi5, channel 0, id 0, lun 1
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9144
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sde at scsi5, channel 0, id 0, lun 2
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9144
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdf at scsi5, channel 0, id 0, lun 3
usb-storage: device scan complete
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x60
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 8
Buffer I/O error on device sdb, logical block 1
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 16
Buffer I/O error on device sdb, logical block 2
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 24
Buffer I/O error on device sdb, logical block 3
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 32
Buffer I/O error on device sdb, logical block 4
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 40
Buffer I/O error on device sdb, logical block 5
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 48
Buffer I/O error on device sdb, logical block 6
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 56
Buffer I/O error on device sdb, logical block 7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 488396928
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 0
cdrom: open failed.
cdrom: open failed.
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 8
Buffer I/O error on device sdb, logical block 1
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 16
Buffer I/O error on device sdb, logical block 2
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 24
Buffer I/O error on device sdb, logical block 3
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 32
Buffer I/O error on device sdb, logical block 4
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 40
Buffer I/O error on device sdb, logical block 5
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 48
Buffer I/O error on device sdb, logical block 6
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 56
Buffer I/O error on device sdb, logical block 7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 488396928
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 0
cdrom: open failed.
Slab corruption: start=ef42b498, len=364
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<f084c715>](scsi_put_command+0x195/0x2e0 [scsi_mod])
010: 6b 6b 6b 6b 6b 6b 6b 6b 90 ba 42 ef 6b 6b 6b 6b
Prev obj: start=ef42b320, len=364
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<f084c921>](scsi_setup_command_freelist+0xc1/0x120
[scsi_mod])
000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
010: 2c 80 86 ef 2c 80 86 ef 5a 5a 5a 5a 5a 5a 5a 5a
Next obj: start=ef42b610, len=364
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<f084c240>](__scsi_get_command+0x20/0x170 [scsi_mod])
000: 00 00 00 00 48 36 4d ef 03 10 02 01 00 00 00 00
010: 7c 36 4d ef 7c 36 4d ef 00 00 00 00 00 00 00 00
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hde2: found reiserfs format "3.6" with standard journal
ReiserFS: hde2: using ordered data mode
ReiserFS: hde2: journal params: device hde2, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hde2: checking transaction log (hde2)
ReiserFS: hde2: Using r5 hash to sort names
Adding 755044k swap on /dev/hde3.  Priority:-1 extents:1
Adding 786424k swap on /SWAP.  Priority:-2 extents:455
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (6143 buckets, 49144 max) - 272 bytes per
conntrack
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
Device not ready. Make sure there is a disc in the drive.
lp0: using parport0 (interrupt-driven).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device c040a6c0(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
Slab corruption: start=ef42ba78, len=364
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<f084c715>](scsi_put_command+0x195/0x2e0 [scsi_mod])
010: 6b 6b 6b 6b 6b 6b 6b 6b 28 b6 42 ef 6b 6b 6b 6b
Prev obj: start=ef42b900, len=364
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](stext+0x3feffdd8/0x8)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=ef42bbf0, len=364
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<f084c921>](scsi_setup_command_freelist+0xc1/0x120
[scsi_mod])
000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
010: 2c 10 8c ef 2c 10 8c ef 5a 5a 5a 5a 5a 5a 5a 5a
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 8
Buffer I/O error on device sdb, logical block 1
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 16
Buffer I/O error on device sdb, logical block 2
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 24
Buffer I/O error on device sdb, logical block 3
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 32
Buffer I/O error on device sdb, logical block 4
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 40
Buffer I/O error on device sdb, logical block 5
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 48
Buffer I/O error on device sdb, logical block 6
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 56
Buffer I/O error on device sdb, logical block 7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ATA: abnormal status 0xD8 on port 0xF081C0C7
ata2: command 0x25 timeout, stat 0xd8 host_stat 0x61
ata2: status=0xd8 { Busy }
SCSI error : <2 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
Slab corruption: start=ef42b900, len=364
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<f084c715>](scsi_put_command+0x195/0x2e0 [scsi_mod])
010: 6b 6b 6b 6b 6b 6b 6b 6b 90 ba 42 ef 6b 6b 6b 6b
Prev obj: start=ef42b788, len=364
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<f084c921>](scsi_setup_command_freelist+0xc1/0x120
[scsi_mod])
000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
010: 08 13 19 ef 08 13 19 ef 5a 5a 5a 5a 5a 5a 5a 5a
Next obj: start=ef42ba78, len=364
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<f084c240>](__scsi_get_command+0x20/0x170 [scsi_mod])
000: 00 00 00 00 30 8f b0 ed 03 10 02 01 44 04 60 ea
010: 64 8f b0 ed 64 8f b0 ed 00 00 00 00 00 00 00 00


