From: Damazy <damazy@gmail.com>
Subject: Re: sata_sil for 3512A chip on kernel 2.6.26.3
Date: Tue, 14 Oct 2008 12:49:08 +0200
Message-ID: <48F47924.9040504@gmail.com>
References: <48E48BF2.1010403@gmail.com> <48E71DBC.5090301@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:6750 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065AbYJNKsz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 06:48:55 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2103079fkq.5
        for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 03:48:52 -0700 (PDT)
In-Reply-To: <48E71DBC.5090301@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo wrote:

 > Please post full kernel log including the boot messages and error
 > messages.
 > Thanks.

Hello.
Thank you for your replay.
 This is dmesg:
=======================================================
p  : 0xfffa8000 - 0xfffff000   ( 348 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc03ae000 - 0xc03e5000   ( 220 kB)
      .data : 0xc02f15e2 - 0xc03ab460   ( 743 kB)
      .text : 0xc0100000 - 0xc02f15e2   (1989 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
Calibrating delay using timer specific routine.. 4849.79 BogoMIPS 
(lpj=2424897)
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 07
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 0k freed
ACPI: Core revision 20080321
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
net_namespace: 484 bytes
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf1eb0, last bus=2
PCI: Using configuration type 1 for base access
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
* The chipset may have PM-Timer Bug. Due to workarounds for a bug,
* this clock source is slow. If you are sure your timer does not have
* this bug, please use "acpi_pm_good" to disable the workaround
pci 0000:00:1f.0: Enabled i801 SMBus device
pci 0000:00:1f.0: quirk: region e400-e47f claimed by ICH4 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region ec00-ec3f claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
system 00:00: iomem range 0x0-0x9ffff could not be reserved
system 00:00: iomem range 0xf0000-0xfffff could not be reserved
system 00:00: iomem range 0x100000-0x3fffffff could not be reserved
system 00:00: iomem range 0xfec00000-0xfec000ff could not be reserved
system 00:00: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:02: ioport range 0xe400-0xe47f has been reserved
system 00:02: ioport range 0xe800-0xe81f has been reserved
system 00:02: ioport range 0xec00-0xec3f has been reserved
system 00:02: ioport range 0x4d6-0x4d6 has been reserved
system 00:02: iomem range 0xfff80000-0xffffffff could not be reserved
system 00:02: iomem range 0xffb80000-0xffbfffff has been reserved
system 00:03: ioport range 0x4d0-0x4d1 has been reserved
system 00:0c: ioport range 0x3f0-0x3f1 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: 0xf7800000-0xf87fffff
  PREFETCH window: 0x00000000f9f00000-0x00000000fbffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 9000-bfff
  MEM window: 0xf5000000-0xf6ffffff
  PREFETCH window: 0x00000000f8800000-0x00000000f9efffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Simple Boot Flag at 0x3a set to 0x1
audit: initializing netlink socket (disabled)
type=2000 audit(1223285079.155:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 1767
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
floppy0: no floppy controllers found
brd: module loaded
loop: module loaded
Uniform Multi-Platform E-IDE driver
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller (0x8086:0x24cb rev 0x01) at  PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007
    ide1: BM-DMA at 0xf008-0xf00f
Probing IDE interface ide0...
hda: WDC WD800JB-00FSA0, ATA DISK drive
hdb: SAMSUNG SV1021H, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdb: UDMA/100 mode selected
Probing IDE interface ide1...
hdc: HL-DT-STDVD-RAM GSA-H50L, ATAPI CD/DVD-ROM drive
hdd: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/66 mode selected
hdd: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdd: UDMA/33 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 > hda3
hdb: max request size: 128KiB
hdb: 19932192 sectors (10205 MB) w/426KiB Cache, CHS=19774/16/63
hdb: cache flushes not supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 >
hdc: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 256kB Cache
Driver 'sd' needs updating - please use bus_type methods
sata_sil 0000:02:0b.0: version 2.3
ACPI: PCI Interrupt 0000:02:0b.0[A] -> GSI 23 (level, low) -> IRQ 23
scsi0 : sata_sil
scsi1 : sata_sil
ata1: SATA max UDMA/100 mmio m512@0xf6000000 tf 0xf6000080 irq 23
ata2: SATA max UDMA/100 mmio m512@0xf6000000 tf 0xf60000c0 irq 23
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: HPA detected: current 976771055, native 976773168
ata1.00: ATA-7: SAMSUNG HD502IJ, 1AA01112, max UDMA7
ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-7: SAMSUNG HD502IJ, 1AA01112, max UDMA7
ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD502IJ  1AA0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976771055 512-byte hardware sectors (500107 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 976771055 512-byte hardware sectors (500107 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD502IJ  1AA0 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
usbmon: debugfs is not available
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
cpuidle: using governor ladder
TCP cubic registered
Using IPI Shortcut mode
input: AT Translated Set 2 keyboard as /class/input/input0
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
hdb: UDMA/100 mode selected
hda: UDMA/100 mode selected
Real Time Clock Driver v1.12ac
Adding 522072k swap on /dev/hda5.  Priority:-1 extents:1 across:522072k
Initializing XFRM netlink socket
NET: Registered protocol family 17
IPv4 over IPv4 tunneling driver
parport_pc 00:08: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
Linux video capture interface: v2.00
lp0: using parport0 (interrupt-driven).
nbd: registered device at major 43
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
ppdev: user-space parallel port driver
arp_tables: (C) 2002 David S. Miller
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
Linux agpgart interface v0.103
agpgart: Detected an Intel 845G Chipset.
agpgart: AGP aperture is 32M @ 0xfc000000
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized mga 3.2.1 20051102 on minor 0
bttv: driver version 0.9.17 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
bttv0: Bt878 (rev 17) at 0000:02:0c.0, irq: 20, latency: 32, mmio: 
0xf9000000
bttv0: using: Prolink PV-BT878P+4E / PixelView PlayTV PAK / Lenco 
MXTV-9578 CP [card=50,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00fbff10 [init]
bttv0: tuner type=5
bttv0: i2c: checking for Bt832 @ 0x88... not found
bttv0: i2c: checking for Bt832 @ 0x8a... found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... found
tda7432 0-0045: chip found @ 0x8a (bt878 #0 [sw])
tuner' 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
tuner-simple 0-0061: creating new instance
tuner-simple 0-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
input: bttv IR (card=50) as /class/input/input2
fuse init (API version 7.9)
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 21
eth0: RealTek RTL8139 at 0x9800, 00:05:1c:10:c8:ef, IRQ 21
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 18 (level, low) -> IRQ 18
eth1: RealTek RTL8139 at 0x9400, 00:50:ba:31:d3:36, IRQ 18
eth1:  Identified 8139 chip type 'RTL-8139B'
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@linux.intel.com>
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf7000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000d800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d400
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000d000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 3-2: new full speed USB device using uhci_hcd and address 2
usb 3-2: configuration #1 chosen from 1 choice
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
usb 3-2.1: new low speed USB device using uhci_hcd and address 3
usb 3-2.1: configuration #1 chosen from 1 choice
input: Cellink Co., LTD. Wireless RF Mouse as /class/input/input3
input: USB HID v1.10 Mouse [Cellink Co., LTD. Wireless RF Mouse] on 
usb-0000:00:1d.1-2.1
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 21 (level, low) -> IRQ 21
=======================================================

and this is kern.log with errors:
=======================================================
Oct 14 09:51:36 debian-stacja kernel: kjournald starting.  Commit 
interval 5 seconds
Oct 14 09:51:36 debian-stacja kernel: EXT3 FS on sdb1, internal journal
Oct 14 09:51:36 debian-stacja kernel: EXT3-fs: mounted filesystem with 
ordered data mode.
Oct 14 09:53:25 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:53:25 debian-stacja kernel: ata2.00: cmd 
25/00:00:67:69:9e/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:53:25 debian-stacja kernel:          res 
40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct 14 09:53:25 debian-stacja kernel: ata2.00: status: { DRDY }
Oct 14 09:53:25 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:53:26 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:53:26 debian-stacja kernel: ata2.00: configured for UDMA/100
Oct 14 09:53:26 debian-stacja kernel: ata2: EH complete
Oct 14 09:53:26 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:53:26 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:53:26 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:53:26 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:54:55 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x0
Oct 14 09:54:55 debian-stacja kernel: ata2.00: BMDMA2 stat 0x6d0009
Oct 14 09:54:55 debian-stacja kernel: ata2.00: cmd 
25/00:00:47:01:95/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:54:55 debian-stacja kernel:          res 
51/04:af:98:01:95/00:00:24:00:00/e0 Emask 0x1 (device error)
Oct 14 09:54:55 debian-stacja kernel: ata2.00: status: { DRDY ERR }
Oct 14 09:54:55 debian-stacja kernel: ata2.00: error: { ABRT }
Oct 14 09:54:55 debian-stacja kernel: ata2.00: failed to IDENTIFY (I/O 
error, err_mask=0x1)
Oct 14 09:54:55 debian-stacja kernel: ata2.00: revalidation failed 
(errno=-5)
Oct 14 09:54:55 debian-stacja kernel: ata2: failed to recover some 
devices, retrying in 5 secs
Oct 14 09:55:00 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:55:01 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:55:01 debian-stacja kernel: ata2.00: configured for UDMA/100
Oct 14 09:55:01 debian-stacja kernel: ata2: EH complete
Oct 14 09:55:01 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:55:01 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:55:01 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:55:01 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:55:02 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:55:02 debian-stacja kernel: ata2.00: cmd 
25/00:00:7f:a8:0b/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:55:02 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:55:02 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:55:02 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:55:02 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:55:02 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:55:02 debian-stacja kernel: ata2.00: configured for UDMA/100
Oct 14 09:55:02 debian-stacja kernel: ata2: EH complete
Oct 14 09:55:02 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:55:02 debian-stacja kernel: ata2.00: cmd 
25/00:00:7f:a8:0b/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:55:02 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:55:02 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:55:02 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:55:02 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:55:02 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:55:02 debian-stacja kernel: ata2.00: configured for UDMA/100
Oct 14 09:55:02 debian-stacja kernel: ata2: EH complete
Oct 14 09:55:03 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:55:03 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:55:03 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:55:03 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:55:03 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:55:03 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:55:03 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:55:03 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:55:03 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x0
Oct 14 09:55:03 debian-stacja kernel: ata2.00: BMDMA2 stat 0x6d0009
Oct 14 09:55:03 debian-stacja kernel: ata2.00: cmd 
25/00:90:7f:b7:0b/00:00:24:00:00/e0 tag 0 dma 73728 in
Oct 14 09:55:03 debian-stacja kernel:          res 
51/04:3f:d0:b7:0b/00:00:24:00:00/e0 Emask 0x1 (device error)
Oct 14 09:55:03 debian-stacja kernel: ata2.00: status: { DRDY ERR }
Oct 14 09:55:03 debian-stacja kernel: ata2.00: error: { ABRT }
Oct 14 09:55:03 debian-stacja kernel: ata2.00: failed to IDENTIFY (I/O 
error, err_mask=0x1)
Oct 14 09:55:03 debian-stacja kernel: ata2.00: revalidation failed 
(errno=-5)
Oct 14 09:55:03 debian-stacja kernel: ata2: failed to recover some 
devices, retrying in 5 secs
Oct 14 09:55:08 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:55:08 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:55:08 debian-stacja kernel: ata2.00: configured for UDMA/100
Oct 14 09:55:08 debian-stacja kernel: ata2: EH complete
Oct 14 09:55:08 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:55:08 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:55:08 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:55:08 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:55:08 debian-stacja kernel: ata2.00: limiting speed to 
UDMA/66:PIO4
Oct 14 09:55:08 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:55:08 debian-stacja kernel: ata2.00: cmd 
25/00:00:cf:4c:90/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:55:08 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:55:08 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:55:08 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:55:08 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:55:09 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:55:09 debian-stacja kernel: ata2.00: configured for UDMA/66
Oct 14 09:55:09 debian-stacja kernel: ata2: EH complete
Oct 14 09:55:09 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:55:09 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:55:09 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:55:09 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:55:09 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x0
Oct 14 09:55:09 debian-stacja kernel: ata2.00: BMDMA2 stat 0x6d0009
Oct 14 09:55:09 debian-stacja kernel: ata2.00: cmd 
25/00:00:3f:11:bd/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:55:09 debian-stacja kernel:          res 
51/04:ef:50:11:bd/00:00:24:00:00/e0 Emask 0x1 (device error)
Oct 14 09:55:09 debian-stacja kernel: ata2.00: status: { DRDY ERR }
Oct 14 09:55:09 debian-stacja kernel: ata2.00: error: { ABRT }
Oct 14 09:55:09 debian-stacja kernel: ata2.00: failed to IDENTIFY (I/O 
error, err_mask=0x1)
Oct 14 09:55:09 debian-stacja kernel: ata2.00: revalidation failed 
(errno=-5)
Oct 14 09:55:09 debian-stacja kernel: ata2: failed to recover some 
devices, retrying in 5 secs
Oct 14 09:55:14 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:55:15 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:55:15 debian-stacja kernel: ata2.00: configured for UDMA/66
Oct 14 09:55:15 debian-stacja kernel: ata2: EH complete
Oct 14 09:55:15 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:55:15 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:55:15 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:55:15 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:55:15 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x0
Oct 14 09:55:15 debian-stacja kernel: ata2.00: BMDMA2 stat 0x6d0009
Oct 14 09:55:15 debian-stacja kernel: ata2.00: cmd 
25/00:00:7f:ab:c1/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:55:15 debian-stacja kernel:          res 
51/04:cf:b0:ab:c1/00:00:24:00:00/e0 Emask 0x1 (device error)
Oct 14 09:55:15 debian-stacja kernel: ata2.00: status: { DRDY ERR }
Oct 14 09:55:15 debian-stacja kernel: ata2.00: error: { ABRT }
Oct 14 09:55:15 debian-stacja kernel: ata2.00: failed to IDENTIFY (I/O 
error, err_mask=0x1)
Oct 14 09:55:15 debian-stacja kernel: ata2.00: revalidation failed 
(errno=-5)
Oct 14 09:55:15 debian-stacja kernel: ata2: failed to recover some 
devices, retrying in 5 secs
Oct 14 09:55:20 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:55:20 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:55:20 debian-stacja kernel: ata2.00: configured for UDMA/66
Oct 14 09:55:20 debian-stacja kernel: ata2: EH complete
Oct 14 09:55:20 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:55:20 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:55:20 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:55:20 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:55:51 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:55:51 debian-stacja kernel: ata2.00: cmd 
25/00:00:4f:68:c1/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:55:51 debian-stacja kernel:          res 
40/00:cf:b0:ab:c1/00:00:24:00:00/e0 Emask 0x4 (timeout)
Oct 14 09:55:51 debian-stacja kernel: ata2.00: status: { DRDY }
Oct 14 09:55:51 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:55:51 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:55:51 debian-stacja kernel: ata2.00: configured for UDMA/66
Oct 14 09:55:51 debian-stacja kernel: ata2: EH complete
Oct 14 09:55:51 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:55:51 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:55:51 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:55:51 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:55:52 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:55:52 debian-stacja kernel: ata2.00: cmd 
25/00:00:4f:6e:c1/00:02:24:00:00/e0 tag 0 dma 262144 in
Oct 14 09:55:52 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:55:52 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:55:52 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:55:52 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:55:52 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:55:52 debian-stacja kernel: ata2.00: configured for UDMA/66
Oct 14 09:55:52 debian-stacja kernel: ata2: EH complete
Oct 14 09:55:52 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:55:52 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:55:52 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:55:52 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:56:23 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:56:23 debian-stacja kernel: ata2.00: cmd 
25/00:00:6f:e3:a3/00:02:24:00:00/e0 tag 0 dma 262144 in
Oct 14 09:56:23 debian-stacja kernel:          res 
40/00:00:01:4f:c2/ff:ff:ff:ff:ff/00 Emask 0x4 (timeout)
Oct 14 09:56:23 debian-stacja kernel: ata2.00: status: { DRDY }
Oct 14 09:56:23 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:56:23 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:56:23 debian-stacja kernel: ata2.00: configured for UDMA/66
Oct 14 09:56:23 debian-stacja kernel: ata2: EH complete
Oct 14 09:56:23 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:56:23 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:56:23 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:56:23 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:56:24 debian-stacja kernel: ata2.00: limiting speed to 
UDMA/33:PIO4
Oct 14 09:56:24 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:56:24 debian-stacja kernel: ata2.00: cmd 
25/00:00:bf:80:ae/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:56:24 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:56:24 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:56:24 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:56:24 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:56:25 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:56:25 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:56:25 debian-stacja kernel: ata2: EH complete
Oct 14 09:56:25 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:56:25 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:56:25 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:56:25 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:56:25 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:56:25 debian-stacja kernel: ata2.00: cmd 
25/00:00:bf:8d:ae/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:56:25 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:56:25 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:56:25 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:56:25 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:56:25 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:56:25 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:56:25 debian-stacja kernel: ata2: EH complete
Oct 14 09:56:25 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:56:25 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:56:25 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:56:25 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:56:25 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x0
Oct 14 09:56:25 debian-stacja kernel: ata2.00: BMDMA2 stat 0x6d0009
Oct 14 09:56:25 debian-stacja kernel: ata2.00: cmd 
25/00:90:97:65:b1/00:00:24:00:00/e0 tag 0 dma 73728 in
Oct 14 09:56:25 debian-stacja kernel:          res 
51/04:7f:a8:65:b1/00:00:24:00:00/e0 Emask 0x1 (device error)
Oct 14 09:56:25 debian-stacja kernel: ata2.00: status: { DRDY ERR }
Oct 14 09:56:25 debian-stacja kernel: ata2.00: error: { ABRT }
Oct 14 09:56:25 debian-stacja kernel: ata2.00: failed to IDENTIFY (I/O 
error, err_mask=0x1)
Oct 14 09:56:25 debian-stacja kernel: ata2.00: revalidation failed 
(errno=-5)
Oct 14 09:56:25 debian-stacja kernel: ata2: failed to recover some 
devices, retrying in 5 secs
Oct 14 09:56:30 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:56:30 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:56:31 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:56:31 debian-stacja kernel: ata2: EH complete
Oct 14 09:56:31 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:56:31 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:56:31 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:56:31 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:57:01 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:57:01 debian-stacja kernel: ata2.00: cmd 
25/00:00:27:89:07/00:01:25:00:00/e0 tag 0 dma 131072 in
Oct 14 09:57:01 debian-stacja kernel:          res 
40/00:7f:a8:65:b1/00:00:24:00:00/e0 Emask 0x4 (timeout)
Oct 14 09:57:01 debian-stacja kernel: ata2.00: status: { DRDY }
Oct 14 09:57:01 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:57:02 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:57:02 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:57:02 debian-stacja kernel: ata2: EH complete
Oct 14 09:57:02 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:57:02 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:57:02 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:57:02 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:57:05 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:57:05 debian-stacja kernel: ata2.00: cmd 
25/00:00:a7:49:c5/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:57:05 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:57:05 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:57:05 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:57:05 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:57:05 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:57:05 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:57:05 debian-stacja kernel: ata2: EH complete
Oct 14 09:57:05 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:57:05 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:57:05 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:57:05 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:57:11 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:57:11 debian-stacja kernel: ata2.00: cmd 
25/00:00:0f:2b:1e/00:01:25:00:00/e0 tag 0 dma 131072 in
Oct 14 09:57:11 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:57:11 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:57:11 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:57:11 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:57:12 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:57:12 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:57:12 debian-stacja kernel: ata2: EH complete
Oct 14 09:57:12 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:57:12 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:57:12 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:57:12 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:57:12 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x0
Oct 14 09:57:12 debian-stacja kernel: ata2.00: BMDMA2 stat 0x6c0009
Oct 14 09:57:12 debian-stacja kernel: ata2.00: cmd 
25/00:00:87:07:21/00:01:25:00:00/e0 tag 0 dma 131072 in
Oct 14 09:57:12 debian-stacja kernel:          res 
51/04:00:86:08:21/00:00:25:00:00/e0 Emask 0x1 (device error)
Oct 14 09:57:12 debian-stacja kernel: ata2.00: status: { DRDY ERR }
Oct 14 09:57:12 debian-stacja kernel: ata2.00: error: { ABRT }
Oct 14 09:57:12 debian-stacja kernel: ata2.00: failed to IDENTIFY (I/O 
error, err_mask=0x1)
Oct 14 09:57:12 debian-stacja kernel: ata2.00: revalidation failed 
(errno=-5)
Oct 14 09:57:12 debian-stacja kernel: ata2: failed to recover some 
devices, retrying in 5 secs
Oct 14 09:57:17 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:57:17 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:57:17 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:57:17 debian-stacja kernel: ata2: EH complete
Oct 14 09:57:17 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:57:17 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:57:17 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:57:17 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:57:18 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:57:18 debian-stacja kernel: ata2.00: cmd 
25/00:00:1f:8f:d6/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:57:18 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:57:18 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:57:18 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:57:18 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:57:18 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:57:18 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:57:18 debian-stacja kernel: ata2: EH complete
Oct 14 09:57:18 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:57:18 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:57:18 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:57:18 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:57:21 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x0
Oct 14 09:57:21 debian-stacja kernel: ata2.00: BMDMA2 stat 0x6d0009
Oct 14 09:57:21 debian-stacja kernel: ata2.00: cmd 
25/00:00:1f:c0:d3/00:01:23:00:00/e0 tag 0 dma 131072 in
Oct 14 09:57:21 debian-stacja kernel:          res 
51/04:ef:30:c0:d3/00:00:23:00:00/e0 Emask 0x1 (device error)
Oct 14 09:57:21 debian-stacja kernel: ata2.00: status: { DRDY ERR }
Oct 14 09:57:21 debian-stacja kernel: ata2.00: error: { ABRT }
Oct 14 09:57:21 debian-stacja kernel: ata2.00: failed to IDENTIFY (I/O 
error, err_mask=0x1)
Oct 14 09:57:21 debian-stacja kernel: ata2.00: revalidation failed 
(errno=-5)
Oct 14 09:57:21 debian-stacja kernel: ata2: failed to recover some 
devices, retrying in 5 secs
Oct 14 09:57:26 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:57:26 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:57:26 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:57:26 debian-stacja kernel: ata2: EH complete
Oct 14 09:57:26 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:57:26 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:57:26 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:57:26 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:58:00 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:58:00 debian-stacja kernel: ata2.00: cmd 
25/00:00:97:d9:d3/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:58:00 debian-stacja kernel:          res 
40/00:ef:30:c0:d3/00:00:23:00:00/e0 Emask 0x4 (timeout)
Oct 14 09:58:00 debian-stacja kernel: ata2.00: status: { DRDY }
Oct 14 09:58:00 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:58:00 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:58:00 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:58:00 debian-stacja kernel: ata2: EH complete
Oct 14 09:58:00 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:58:00 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:58:00 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:58:00 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:58:00 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x0
Oct 14 09:58:00 debian-stacja kernel: ata2.00: BMDMA2 stat 0x6d0009
Oct 14 09:58:00 debian-stacja kernel: ata2.00: cmd 
25/00:00:1f:2e:c3/00:01:23:00:00/e0 tag 0 dma 131072 in
Oct 14 09:58:00 debian-stacja kernel:          res 
51/04:bf:60:2e:c3/00:00:23:00:00/e0 Emask 0x1 (device error)
Oct 14 09:58:00 debian-stacja kernel: ata2.00: status: { DRDY ERR }
Oct 14 09:58:00 debian-stacja kernel: ata2.00: error: { ABRT }
Oct 14 09:58:00 debian-stacja kernel: ata2.00: failed to IDENTIFY (I/O 
error, err_mask=0x1)
Oct 14 09:58:00 debian-stacja kernel: ata2.00: revalidation failed 
(errno=-5)
Oct 14 09:58:00 debian-stacja kernel: ata2: failed to recover some 
devices, retrying in 5 secs
Oct 14 09:58:05 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:58:05 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:58:05 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:58:05 debian-stacja kernel: ata2: EH complete
Oct 14 09:58:05 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:58:05 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:58:05 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:58:05 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:58:07 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:58:07 debian-stacja kernel: ata2.00: cmd 
25/00:90:0f:a1:3f/00:00:24:00:00/e0 tag 0 dma 73728 in
Oct 14 09:58:07 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:58:07 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:58:07 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:58:07 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:58:07 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:58:07 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:58:07 debian-stacja kernel: ata2: EH complete
Oct 14 09:58:07 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:58:07 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:58:07 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:58:07 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:58:38 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:58:38 debian-stacja kernel: ata2.00: cmd 
25/00:00:3f:c5:a7/00:01:23:00:00/e0 tag 0 dma 131072 in
Oct 14 09:58:38 debian-stacja kernel:          res 
40/00:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x4 (timeout)
Oct 14 09:58:38 debian-stacja kernel: ata2.00: status: { DRDY }
Oct 14 09:58:38 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:58:38 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:58:38 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:58:38 debian-stacja kernel: ata2: EH complete
Oct 14 09:58:38 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:58:38 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:58:38 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:58:38 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:59:09 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:59:09 debian-stacja kernel: ata2.00: cmd 
25/00:00:a7:36:9e/00:01:23:00:00/e0 tag 0 dma 131072 in
Oct 14 09:59:09 debian-stacja kernel:          res 
40/00:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x4 (timeout)
Oct 14 09:59:09 debian-stacja kernel: ata2.00: status: { DRDY }
Oct 14 09:59:09 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:59:10 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:59:10 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:59:10 debian-stacja kernel: ata2: EH complete
Oct 14 09:59:10 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:59:10 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:59:10 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:59:10 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:59:40 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:59:40 debian-stacja kernel: ata2.00: cmd 
25/00:00:ef:1a:76/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:59:40 debian-stacja kernel:          res 
40/00:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x4 (timeout)
Oct 14 09:59:40 debian-stacja kernel: ata2.00: status: { DRDY }
Oct 14 09:59:40 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:59:40 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:59:41 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:59:41 debian-stacja kernel: ata2: EH complete
Oct 14 09:59:41 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:59:41 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:59:41 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:59:41 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:59:47 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:59:47 debian-stacja kernel: ata2.00: cmd 
25/00:90:67:7c:f3/00:01:24:00:00/e0 tag 0 dma 204800 in
Oct 14 09:59:47 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:59:47 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:59:47 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:59:47 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:59:47 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:59:47 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:59:47 debian-stacja kernel: ata2: EH complete
Oct 14 09:59:47 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:59:47 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:59:47 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:59:47 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:59:48 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:59:48 debian-stacja kernel: ata2.00: cmd 
25/00:68:0f:ce:95/00:00:24:00:00/e0 tag 0 dma 53248 in
Oct 14 09:59:48 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:59:48 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:59:48 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:59:48 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:59:48 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:59:48 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:59:48 debian-stacja kernel: ata2: EH complete
Oct 14 09:59:48 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:59:48 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:59:48 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:59:48 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:59:49 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x6 frozen
Oct 14 09:59:49 debian-stacja kernel: ata2.00: cmd 
25/00:00:1f:ab:9d/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:59:49 debian-stacja kernel:          res 
ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
Oct 14 09:59:49 debian-stacja kernel: ata2.00: status: { Busy }
Oct 14 09:59:49 debian-stacja kernel: ata2.00: error: { ICRC UNC IDNF ABRT }
Oct 14 09:59:49 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:59:49 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:59:49 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:59:49 debian-stacja kernel: ata2: EH complete
Oct 14 09:59:49 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:59:49 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:59:49 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:59:49 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:59:50 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x0
Oct 14 09:59:50 debian-stacja kernel: ata2.00: BMDMA2 stat 0x6d0009
Oct 14 09:59:50 debian-stacja kernel: ata2.00: cmd 
25/00:00:4f:0d:6f/00:01:25:00:00/e0 tag 0 dma 131072 in
Oct 14 09:59:50 debian-stacja kernel:          res 
51/04:6f:e0:0d:6f/00:00:25:00:00/e0 Emask 0x1 (device error)
Oct 14 09:59:50 debian-stacja kernel: ata2.00: status: { DRDY ERR }
Oct 14 09:59:50 debian-stacja kernel: ata2.00: error: { ABRT }
Oct 14 09:59:50 debian-stacja kernel: ata2.00: failed to IDENTIFY (I/O 
error, err_mask=0x1)
Oct 14 09:59:50 debian-stacja kernel: ata2.00: revalidation failed 
(errno=-5)
Oct 14 09:59:50 debian-stacja kernel: ata2: failed to recover some 
devices, retrying in 5 secs
Oct 14 09:59:55 debian-stacja kernel: ata2: hard resetting link
Oct 14 09:59:55 debian-stacja kernel: ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 310)
Oct 14 09:59:55 debian-stacja kernel: ata2.00: configured for UDMA/33
Oct 14 09:59:55 debian-stacja kernel: ata2: EH complete
Oct 14 09:59:55 debian-stacja kernel: sd 1:0:0:0: [sdb] 976773168 
512-byte hardware sectors (500108 MB)
Oct 14 09:59:55 debian-stacja kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 14 09:59:55 debian-stacja kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 
3a 00 00
Oct 14 09:59:55 debian-stacja kernel: sd 1:0:0:0: [sdb] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Oct 14 09:59:57 debian-stacja kernel: ata2.00: exception Emask 0x0 SAct 
0x0 SErr 0x0 action 0x0
Oct 14 09:59:57 debian-stacja kernel: ata2.00: BMDMA2 stat 0x6d0009
Oct 14 09:59:57 debian-stacja kernel: ata2.00: cmd 
25/00:00:af:cc:b5/00:01:24:00:00/e0 tag 0 dma 131072 in
Oct 14 09:59:57 debian-stacja kernel:          res 
51/04:df:d0:cc:b5/00:00:24:00:00/e0 Emask 0x1 (device error)
Oct 14 09:59:57 debian-stacja kernel: ata2.00: status: { DRDY ERR }
Oct 14 09:59:57 debian-stacja kernel: ata2.00: error: { ABRT }
Oct 14 09:59:57 debian-stacja kernel: ata2.00: failed to IDENTIFY (I/O 
error, err_mask=0x1)
Oct 14 09:59:57 debian-stacja kernel: ata2.00: revalidation failed 
(errno=-5)
Oct 14 09:59:57 debian-stacja kernel: ata2: failed to recover some 
devices, retrying in 5 secs
=======================================================

Best regards.
 Damazy
