From: Tejun Heo <htejun@gmail.com>
Subject: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Mon, 12 Mar 2007 21:23:59 +0900
Message-ID: <45F5465F.6050709@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010408070903020107090908"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:6221 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965774AbXCLMYD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 08:24:03 -0400
Received: by ug-out-1314.google.com with SMTP id 44so2210714uga
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 05:24:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, paul@paulbristow.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Stanislav Brabec <sbrabec@novell.com>, Jeff Garzik <jeff@garzik.org>

This is a multi-part message in MIME format.
--------------010408070903020107090908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello, all.

Stanislav Brabec reported that IOMEGA IDE ZIP drive doesn't work with
recent kernels.  Low level driver is via82cxxx.  Relevant part of
2.6.20.1 boot message follows.

 VP_IDE: IDE controller at PCI slot 0000:00:11.1
 VP_IDE: chipset revision 6
 VP_IDE: not 100% native mode: will probe irqs later
 VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
 Probing IDE interface ide0...
 hda: ST3160812A, ATA DISK drive
 hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 ...
 hdb: lost interrupt
 hdb: status error: status=0x00 { }
 ide: failed opcode was: unknown
 ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
 ...
 hdb: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
 hdb: No disk in drive
 hdb: lost interrupt
 hdb: status error: status=0x00 { }
 ide: failed opcode was: unknown
 ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
 [above repeats several times]
 ...
 hdb: lost interrupt
 hdb: status error: status=0x00 { }
 ide: failed opcode was: unknown
 ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
 hdb: 98304kB, 196608 blocks, 512 sector size
  hdb: unknown partition table
  hdb: unknown partition table
  hdb: unknown partition table
  hdb: unknown partition table

And the device is inaccessible after boot completed.  On suse 10.1
kernel (2.6.16 based), it works better.

 VP_IDE: IDE controller at PCI slot 0000:00:11.1
 PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 0
 VP_IDE: chipset revision 6
 VP_IDE: not 100% native mode: will probe irqs later
 VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
 Probing IDE interface ide0...
 hda: ST3160812A, ATA DISK drive
 hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 ...
 hdb: No disk in drive
 hdb: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
 ...
 hdb: lost interrupt
 hdb: status error: status=0x00 { }
 ide: failed opcode was: unknown
 ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
 hdb: 98304kB, 196608 blocks, 512 sector size
  hdb: unknown partition table

There is one lost interrupt message but the drive reportedly works
fine after that.  Stanislav also seems to recall that ide-floppy
worked without any error message with older kernel.

I'm attaching full boot log messages for 2.6.20.1 and suse 10.1.

Any ideas?

[libata]
And, as the device requires custom high level driver, libata fails
miserably.  Would it be worth to try support these devices?  Or are
they just too outdated to put the effort in?

Thanks.

-- 
tejun

--------------010408070903020107090908
Content-Type: text/plain;
 name="zip-failure-2.6.16-based-suse10.1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zip-failure-2.6.16-based-suse10.1.txt"

Linux version 2.6.16.27-0.6-default (geeko@buildhost) (gcc version 4.1.0 (SUSE Linux)) #1 Wed Dec 13 09:34:50 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff8000 (ACPI data)
 BIOS-e820: 000000002fff8000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
767MB LOWMEM available.
No mptable found.
On node 0 totalpages: 196592
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 192496 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
IO/L-APIC allowed because system is MP or new enough
ACPI: RSDP (v000 AMI                                   ) @ 0x000fc3c0
ACPI: RSDT (v001 AMIINT          0x00000011 MSFT 0x00000097) @ 0x2fff0000
ACPI: FADT (v001 AMIINT          0x00000011 MSFT 0x00000097) @ 0x2fff0030
ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Allocating PCI resources starting at 40000000 (gap: 30000000:cff80000)
Built 1 zonelists
Kernel command line: root=/dev/hda2 vga=0x31a resume=/dev/hda5 splash=silent elevator=
bootsplash: silent mode.
Local APIC disabled by BIOS -- you can enable it with "lapic"
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1338.227 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 773800k/786368k available (1490k kernel code, 12016k reserved, 608k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2681.18 BogoMIPS (lpj=5362373)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 04
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
Freeing initrd memory: 2365k freed
 not found!
ACPI: setting ELCR to 0200 (from 1c20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdb21, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 *12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
Setting up standard PCI resources
PCI: Bridge: 0000:00:01.0
  IO window: 8000-9fff
  MEM window: dfe00000-dfefffff
  PREFETCH window: d7c00000-dfcfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1172471433.628:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xd8000000, mapped to 0xf0880000, using 10240k, total 32768k
vesafb: mode is 1280x1024x16, linelength=2560, pages=11
vesafb: protected mode interface info at c000:4d22
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size 76045 bytes,<6>...found (1280x1024, 33692 bytes, v3).
Console: switching to colour frame buffer device 156x60
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0 UAR1  USB USB1 USB2  AC9  MC9 ILAN SLPB 
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 156k freed
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI subsystem initialized
dc395x: Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
dc395x: Used settings: AdapterID=07, Speed=0(20.0MHz), dev_mode=0x57
dc395x:                AdaptMode=0x0f, Tags=4(16), DelayReset=1s
dc395x: Connectors:  Termination: Auto Low High 
dc395x: Performing initial SCSI bus reset
scsi0 : Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
VP_IDE: IDE controller at PCI slot 0000:00:11.1
PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST3160812A, ATA DISK drive
hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 512KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Probing IDE interface ide1...
hdc: HL-DT-ST DVDRAM GSA-4160B, ATAPI CD/DVD-ROM drive
hdd: CD-W540E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ACPI: Processor [CPU1] (supports 16 throttling states)
Attempting manual resume
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
reiserfs: using flush barriers
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
Adding 2104472k swap on /dev/hda5.  Priority:-1 extents:1 across:2104472k
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
ppdev: user-space parallel port driver
lp0: using parport0 (interrupt-driven).
usbcore: registered new driver usbfs
usbcore: registered new driver hub
hdc: ATAPI 63X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:11.2: irq 12, io base 0x0000c800
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.16.27-0.6-default uhci_hcd
usb usb1: SerialNumber: 0000:00:11.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ieee80211_crypt: module not supported by Novell, setting U taint flag.
ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:11.3: irq 12, io base 0x0000cc00
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.16.27-0.6-default uhci_hcd
usb usb2: SerialNumber: 0000:00:11.3
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ieee80211_crypt: registered algorithm 'NULL'
ide-floppy driver 0.99.newide
hostap: module not supported by Novell, setting U taint flag.
NET: Registered protocol family 23
hostap_pci: module not supported by Novell, setting U taint flag.
hostap_pci: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
hostap_pci: Registered netdevice wifi0
wifi0: Original COR value: 0x0
hdb: No disk in drive
hdb: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
usb 2-2: new full speed USB device using uhci_hcd and address 2
prism2_hw_init: initialized in 288 ms
wifi0: NIC: id=0x8013 v1.0.0
wifi0: PRI: id=0x15 v1.0.7
wifi0: STA: id=0x1f v1.3.6
gameport: NS558 PnP Gameport is pnp00:0a/gameport0, io 0x200, speed 864kHz
via_ircc: module not supported by Novell, setting U taint flag.
usb 2-2: new device found, idVendor=05e3, idProduct=0502
usb 2-2: new device strings: Mfr=0, Product=1, SerialNumber=0
usb 2-2: Product: USB Host To Host Bridge
usb 2-2: configuration #1 chosen from 1 choice
8139too Fast Ethernet driver 0.9.27
Linux agpgart interface v0.101 (c) Dave Jones
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
wifi0: defaulting to host-based encryption as a workaround for firmware bug in Host AP mode WEP
wifi0: defaulting to bogus WDS frame as a workaround for firmware bug in Host AP mode WDS
wifi0: Intersil Prism2.5 PCI: mem=0xdfdff000, irq=12
wifi0: registered netdevice wlan0
ACPI: PCI Interrupt 0000:00:07.2[C] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:07.2: EHCI Host Controller
ehci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:07.2: irq 10, io mem 0xdfffee00
ehci_hcd 0000:00:07.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: EHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.16.27-0.6-default ehci_hcd
usb usb3: SerialNumber: 0000:00:07.2
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 5 ports detected
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
es1968: not attempting power management.
prism2_download: dl_cmd=6 start_addr=0x003f0000 num_areas=3
wifi0: test Genesis mode with HCR 0x1f
wifi0: Original COR value: 0x0
Readback test failed, HCR 0x1f write 00 e1 a1 ff read 00 c1 a1 c1
wifi0: test Genesis mode with HCR 0x0f
wifi0: Original COR value: 0xa1
Readback test succeeded, HCR 0x0f
prism2_hw_init: initialized in 0 ms
wifi0: NIC: id=0x8013 v1.0.0
wifi0: PRI: id=0x15 v1.1.4
Could not get RID for component STA
wifi0: Failed to read STA f/w version - only Primary f/w present
usb0: register 'gl620a' at usb-0000:00:11.3-2, Genesys GeneLink, ca:43:3b:7e:19:3a
usbcore: registered new driver gl620a
es1968: clocking to 48000
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xf1578f00, 00:50:fc:33:ce:ba, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:07.0: OHCI Host Controller
ohci_hcd 0000:00:07.0: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:07.0: irq 5, io mem 0xdfffc000
prism2_download: dl_cmd=5 start_addr=0x003f0c01 num_areas=3
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: OHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.16.27-0.6-default ohci_hcd
usb usb4: SerialNumber: 0000:00:07.0
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
prism2_hw_init: initialized in 300 ms
wifi0: NIC: id=0x8013 v1.0.0
wifi0: PRI: id=0x15 v1.1.4
wifi0: STA: id=0x1f v1.8.4
ACPI: PCI Interrupt 0000:00:07.1[B] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
ohci_hcd 0000:00:07.1: OHCI Host Controller
ohci_hcd 0000:00:07.1: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:07.1: irq 12, io mem 0xdfffd000
usb usb5: new device found, idVendor=0000, idProduct=0000
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: OHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.16.27-0.6-default ohci_hcd
usb usb5: SerialNumber: 0000:00:07.1
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
usb 4-2: new low speed USB device using ohci_hcd and address 2
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
usb 4-2: new device found, idVendor=051d, idProduct=0002
usb 4-2: new device strings: Mfr=3, Product=1, SerialNumber=2
usb 4-2: Product: Back-UPS RS 500 FW:30.j4.I USB FW:j4
usb 4-2: Manufacturer: American Power Conversion
usb 4-2: SerialNumber: BB0328000279  
usb 4-2: configuration #1 chosen from 1 choice
usb 4-3: new full speed USB device using ohci_hcd and address 3
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
dm-netlink version 0.0.2 loaded
usb 4-3: new device found, idVendor=0a12, idProduct=0001
usb 4-3: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-3: configuration #1 chosen from 1 choice
usb 5-1: new low speed USB device using ohci_hcd and address 2
usb 5-1: string descriptor 0 read error: -22
usb 5-1: string descriptor 0 read error: -22
usb 5-1: new device found, idVendor=0bc7, idProduct=0004
usb 5-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-1: configuration #1 chosen from 1 choice
input: ATI/X10 RF USB Remote Control(0bc7,0004) as /class/input/input2
usbcore: registered new driver ati_remote
drivers/usb/input/ati_remote.c: Weird data, len=1 ff 00 00 00 00 00 ...
drivers/usb/input/ati_remote.c: Registered USB driver ATI/X10 RF USB Remote Control v. 2.2.1
loop: loaded (max 8 devices)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
reiserfs: using flush barriers
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
AppArmor: AppArmor (version 2.0-19.43r6320) initialized
audit(1172471464.465:2): AppArmor (version 2.0-19.43r6320) initialized

ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NET: Registered protocol family 17
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
hwmon: module not supported by Novell, setting U taint flag.
hwmon_vid: module not supported by Novell, setting U taint flag.
w83627hf: module not supported by Novell, setting U taint flag.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
powernow-k8: Processor cpuid 644 not supported
powernow: No powernow capabilities detected
u32 classifier
    Perfomance counters on
    Actions configured 
act_police: module not supported by Novell, setting U taint flag.
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xf17dcf00, 00:50:fc:33:ce:ba, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
bootsplash: status on console 0 changed to on
eth0: no IPv6 routers present
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
hdb: lost interrupt
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
hdb: 98304kB, 196608 blocks, 512 sector size
 hdb: unknown partition table

--------------010408070903020107090908
Content-Type: text/plain;
 name="zip-failure-2.6.20.1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zip-failure-2.6.20.1.txt"

Linux version 2.6.20.1-default (root@utx) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #1 SMP Thu Feb 22 21:41:49 CET 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000002fef0000 end: 000000002fff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000002fff0000 size: 0000000000008000 end: 000000002fff8000 type: 3
copy_e820_map() start: 000000002fff8000 size: 0000000000008000 end: 0000000030000000 type: 4
copy_e820_map() start: 00000000fff80000 size: 0000000000080000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff8000 (ACPI data)
 BIOS-e820: 000000002fff8000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
767MB LOWMEM available.
Entering add_active_range(0, 0, 196592) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   196592
  HighMem    196592 ->   196592
early_node_map[1] active PFN ranges
    0:        0 ->   196592
On node 0 totalpages: 196592
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1503 pages used for memmap
  Normal zone: 190993 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP (v000 AMI                                   ) @ 0x000fc3c0
ACPI: RSDT (v001 AMIINT          0x00000011 MSFT 0x00000097) @ 0x2fff0000
ACPI: FADT (v001 AMIINT          0x00000011 MSFT 0x00000097) @ 0x2fff0030
ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Allocating PCI resources starting at 40000000 (gap: 30000000:cff80000)
Detected 1338.228 MHz processor.
Built 1 zonelists.  Total pages: 195057
Kernel command line: root=/dev/hda1 vga=0x31a resume=/dev/hda5 splash=silent
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (0160c000)
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 772536k/786368k available (1708k kernel code, 13196k reserved, 719k data, 192k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffe15000 - 0xfffff000   (1960 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf0800000 - 0xff7fe000   ( 239 MB)
    lowmem  : 0xc0000000 - 0xefff0000   ( 767 MB)
      .init : 0xc0366000 - 0xc0396000   ( 192 kB)
      .data : 0xc02ab3af - 0xc035f354   ( 719 kB)
      .text : 0xc0100000 - 0xc02ab3af   (1708 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2678.89 BogoMIPS (lpj=5357799)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 1c20)
CPU0: AMD Athlon(tm) Processor stepping 04
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdb21, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 *12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 8000-9fff
  MEM window: dfe00000-dfefffff
  PREFETCH window: d7c00000-dfcfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3190k freed
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1172249290.788:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xd8000000, mapped to 0xf0880000, using 5120k, total 32768k
vesafb: mode is 1280x1024x16, linelength=2560, pages=11
vesafb: protected mode interface info at c000:4d22
vesafb: pmi: set display start = c00c4d90, set palette = c00c4dca
vesafb: pmi: ports = 9810 9816 9854 9838 983c 985c 9800 9804 98b0 98b2 98b4 
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
NET: Registered protocol family 1
Using IPI No-Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 192k freed
Time: tsc clocksource has been installed.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI subsystem initialized
ACPI: Processor [CPU1] (supports 16 throttling states)
dc395x: Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
dc395x: Used settings: AdapterID=07, Speed=0(20.0MHz), dev_mode=0x57
dc395x:                AdaptMode=0x0f, Tags=4(16), DelayReset=1s
dc395x: Connectors:  Termination: Auto Low High 
dc395x: Performing initial SCSI bus reset
scsi0 : Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST3160812A, ATA DISK drive
hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 512KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Probing IDE interface ide1...
hdc: HL-DT-ST DVDRAM GSA-4160B, ATAPI CD/DVD-ROM drive
hdd: CD-W540E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
lp0: using parport0 (interrupt-driven).
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ACPI: PCI Interrupt 0000:00:07.2[C] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:07.2: EHCI Host Controller
ehci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
USB Universal Host Controller Interface driver v3.0
ehci_hcd 0000:00:07.2: irq 10, io mem 0xdfffee00
ehci_hcd 0000:00:07.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
8139too Fast Ethernet driver 0.9.28
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:11.2: irq 12, io base 0x0000c800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
NET: Registered protocol family 23
ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:11.3: irq 12, io base 0x0000cc00
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ieee80211_crypt: registered algorithm 'NULL'
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xf0e90f00, 00:50:fc:33:ce:ba, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:07.0: OHCI Host Controller
ohci_hcd 0000:00:07.0: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:07.0: irq 5, io mem 0xdfffc000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
ACPI: PCI Interrupt 0000:00:07.1[B] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
ohci_hcd 0000:00:07.1: OHCI Host Controller
ohci_hcd 0000:00:07.1: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:07.1: irq 12, io mem 0xdfffd000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
es1968: not attempting power management.
hostap_pci: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
es1968: clocking to 48000
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
hostap_pci: Registered netdevice wifi0
wifi0: Original COR value: 0x0
gameport: NS558 PnP Gameport is pnp00:0a/gameport0, io 0x200, speed 864kHz
usb 3-2: new full speed USB device using uhci_hcd and address 2
hdc: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
usb 3-2: configuration #1 chosen from 1 choice
ide-floppy driver 0.99.newide
usb 4-2: new low speed USB device using ohci_hcd and address 2
prism2_hw_init: initialized in 816 ms
wifi0: NIC: id=0x8013 v1.0.0
wifi0: PRI: id=0x15 v1.0.7
wifi0: STA: id=0x1f v1.3.6
usb 4-2: configuration #1 chosen from 1 choice
usb 4-3: new full speed USB device using ohci_hcd and address 3
wifi0: defaulting to host-based encryption as a workaround for firmware bug in Host AP mode WEP
wifi0: defaulting to bogus WDS frame as a workaround for firmware bug in Host AP mode WDS
wifi0: Intersil Prism2.5 PCI: mem=0xdfdff000, irq=12
wifi0: registered netdevice wlan0
usb 4-3: configuration #1 chosen from 1 choice
usb 5-1: new low speed USB device using ohci_hcd and address 2
usb 5-1: string descriptor 0 read error: -22
usb 5-1: string descriptor 0 read error: -22
usb 5-1: configuration #1 chosen from 1 choice
hdb: lost interrupt
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
input: ATI/X10 RF USB Remote Control(0bc7,0004) as /class/input/input2
usbcore: registered new interface driver ati_remote
drivers/usb/input/ati_remote.c: Weird data, len=1 ff 00 00 00 00 00 ...
drivers/usb/input/ati_remote.c: Registered USB driver ATI/X10 RF USB Remote Control v. 2.2.1
usb0: register 'gl620a' at usb-0000:00:11.3-2, Genesys GeneLink, 8e:63:75:81:10:77
usbcore: registered new interface driver gl620a
hdb: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
hdb: No disk in drive
hdb: lost interrupt
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
Adding 2104472k swap on /dev/hda5.  Priority:-1 extents:1 across:2104472k
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
hdb: lost interrupt
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
hdb: No disk in drive
hdb: lost interrupt
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
loop: loaded (max 8 devices)
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input5
ACPI: Sleep Button (CM) [SLPB]
powernow-k8: Processor cpuid 644 not supported
powernow: No powernow capabilities detected
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NET: Registered protocol family 17
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
audit(1172249534.514:2): audit_pid=3590 old=0 by auid=4294967295
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
hdb: No disk in drive
eth0: no IPv6 routers present
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
[drm] Initialized r128 2.5.0 20030725 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ACPI: PCI interrupt for device 0000:00:06.0 disabled
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xf1328f00, 00:50:fc:33:ce:ba, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: no IPv6 routers present
st: Version 20061107, fixed bufsize 32768, s/g segs 256
hdb: lost interrupt
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
hdb: No disk in drive
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
hdb: lost interrupt
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
hdb: 98304kB, 196608 blocks, 512 sector size
 hdb: unknown partition table
 hdb: unknown partition table
 hdb: unknown partition table
 hdb: unknown partition table
ip_tables: (C) 2000-2006 Netfilter Core Team

--------------010408070903020107090908--
