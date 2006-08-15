From: derrywang <derrywang@linpus.com>
Subject: help
Date: Tue, 15 Aug 2006 10:35:43 +0800
Message-ID: <44E132FF.9060302@linpus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010000010805020500070606"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl-220-228-241-233.NH.sparqnet.net ([220.228.241.233]:4742
	"EHLO mail.linpus.com.tw") by vger.kernel.org with ESMTP
	id S1751534AbWHOCg0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Aug 2006 22:36:26 -0400
Received: from localhost ([127.0.0.1])
	by mail.linpus.com.tw
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits))
	for linux-ide@vger.kernel.org;
	Tue, 15 Aug 2006 10:40:58 +0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010000010805020500070606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear Uwe Koziolek,

Hi, Can you help me?
I am a engineer of a linux company. I want to install a linux 
distribution on one notebook.
But I failed because of SATA HDD driver problem.
The hardware of this notebook is : SISM662MXZ+966LZ. I download the new 
driver source from SIS website.
Unfortunnly I failed again.
The detail dmesg and lspci information are touched by attachment. please 
check it.
The main problem is ( I guess)
driver can not get the correct SCR_STATUS register value. So Sata link down.

In the last, please forgive me for the poor english. :-)
Thank you!

Best Regards,
Derry


--------------010000010805020500070606
Content-Type: text/x-log;
 name="dmesg.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="dmesg.log"

Linux version 2.6.16 (root@localhost.localdomain) (gcc 版本 3.4.6) #1 Mon Aug 14 14:34:39 CST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dd90000 (usable)
 BIOS-e820: 000000000dd90000 - 000000000dd9f000 (ACPI data)
 BIOS-e820: 000000000dd9f000 - 000000000de00000 (ACPI NVS)
 BIOS-e820: 000000000de00000 - 000000000e000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
221MB LOWMEM available.
On node 0 totalpages: 56720
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 52624 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:0
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f93b0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0dd9a278
ACPI: FADT (v001 SiS    662MX    0x06040000 PTL  0x000f4240) @ 0x0dd9eef2
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x0dd9ef66
ACPI: MCFG (v001 PTLTD    MCFG   0x06040000  LTP 0x00000000) @ 0x0dd9efc4
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050228) @ 0x0dd9a2ac
ACPI: DSDT (v001 PTLTD       662 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 10000000 (gap: 0e000000:f0c00000)
Built 1 zonelists
Kernel command line: vga=769 max_loop=255 initrd=boot/initrd.gz init=linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=4444 root=/dev/ram0 rw BOOT_IMAGE=boot/vmlinuz 
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1600.284 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 216716k/226880k available (4164k kernel code, 9568k reserved, 1284k data, 496k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3207.47 BogoMIPS (lpj=6414944)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c189 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Genuine Intel(R) CPU            1050  @ 1.60GHz stepping 08
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0800 (from 0eb8)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1320k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS BUG #81[000fdda0] found
PCI: Using MMCONFIG
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.5
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *4 5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *7 9 10 11)
ACPI: Embedded Controller [EC0] (gpe 31) interrupt mode.
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: d4000000-d40fffff
  PREFETCH window: c8000000-cfffffff
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: d4100000-d41fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: dc000000-dfffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1f.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:07.0 to 64
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.0 to 64
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NTFS driver 2.1.26 [Flags: R/O].
JFS: nTxBlock = 1705, nTxLock = 13640
SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:06.0 to 64
pcie_portdrv_probe->Dev[000a:1039] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
Allocate Port Service[0000:00:06.0:pcie01]
Allocate Port Service[0000:00:06.0:pcie02]
Allocate Port Service[0000:00:06.0:pcie03]
PCI: Setting latency timer of device 0000:00:07.0 to 64
pcie_portdrv_probe->Dev[000a:1039] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
Allocate Port Service[0000:00:07.0:pcie01]
Allocate Port Service[0000:00:07.0:pcie02]
Allocate Port Service[0000:00:07.0:pcie03]
ACPI: PCI Interrupt 0000:00:1f.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1f.0:pcie00]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xc8000000, mapped to 0xce980000, using 600k, total 32768k
vesafb: mode is 640x480x8, linelength=640, pages=24
vesafb: protected mode interface info at cc82:0004
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=6:6:6:6, shift=0:0:0:0
Console: switching to colour frame buffer device 80x30
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Video Device [VGA0] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [TZ00] (33 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4444K size 1024 blocksize
loop: loaded (max 255 devices)
Compaq SMART2 Driver (v 2.6.0)
HP CISS Driver (v 2.6.10)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
ACPI: PCI Interrupt 0000:00:02.5[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
SIS5513: chipset revision 1
SIS5513: not 100% native mode: will probe irqs later
SIS5513: IDE controller at PCI slot 0000:00:02.5
ACPI: PCI Interrupt 0000:00:02.5[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
SIS5513: chipset revision 1
SIS5513: not 100% native mode: will probe irqs later
SIS_IDE: probe of 0000:00:02.5 failed with error -1
Probing IDE interface ide0...
hda: PHILIPS CD-RW/DVD-ROM SCB5265, ATAPI CD/DVD-ROM drive
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
Loading Adaptec I2O RAID: Version 2.4 Build 5go
Detecting Adaptec I2O RAID controllers...
Adaptec aacraid driver (1.1-4 Aug 14 2006 14:29:02)
scsi: <fdomain> Detection failed (no card)
sym53c416.c: Version 1.0.0-ac
qlogicfas: no cards were found, please specify I/O address and IRQ using iobase= and irq= optionsEmulex LightPulse Fibre Channel SCSI driver 8.1.1
Copyright(c) 2004-2005 Emulex.  All rights reserved.
Failed initialization of WD-7000 SCSI card!
megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
megaraid: 2.20.4.7 (Release Date: Mon Nov 14 12:27:22 EST 2005)
megasas: 00.00.02.04 Fri Feb 03 14:31:44 PST 2006
GDT-HA: Storage RAID Controller Driver. Version: 3.04 
GDT-HA: Found 0 PCI Storage RAID Controllers
3ware Storage Controller device driver for Linux v1.26.02.001.
3ware 9000 Storage Controller device driver for Linux v2.26.02.007.
nsp32: loading...
ipr: IBM Power RAID SCSI Device Driver version: 2.1.2 (February 8, 2006)
libata version 1.20 loaded.
I2O subsystem v1.325
i2o: max drivers = 8
I2O Configuration OSM v1.323
I2O Bus Adapter OSM v1.317
I2O Block Device OSM v1.325
I2O SCSI Peripheral OSM v1.316
I2O ProcFS OSM v1.316
Fusion MPT base driver 3.03.07
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.07
Fusion MPT FC Host driver 3.03.07
Fusion MPT SAS Host driver 3.03.07
usbmon: debugfs is not available
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0  KBC USB0 USB1 USB2  LAN HDEF CBUS 
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 496k freed
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
sata_sis 0000:00:05.0: Detected SiS 182/1182/1183 SATA controller
ata1: SATA max UDMA/133 cmd 0x1448 ctl 0x143E bmdma 0x1410 irq 5
ata2: SATA max UDMA/133 cmd 0x1440 ctl 0x143A bmdma 0x1418 irq 5
ata1: SATA link down (SStatus 117)
scsi2 : sata_sis
ata2: SATA link down (SStatus 5)
scsi3 : sata_sis
squashfs: version 3.0 (2006/03/15) Phillip Lougher
Registering unionfs 20060423-1600
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
Linux agpgart interface v0.101 (c) Dave Jones
fuse init (API version 7.6)
input: ImPS/2 Synaptics TouchPad as /class/input/input1
Intel ISA PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.16.16 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413, RF5413)
wlan: 0.8.4.2 (svn 1531)
ath_rate_sample: 1.2 (svn 1531)
ath_pci: 0.9.4.5 (svn 1531)
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:02:00.0 to 64
wifi%d: unable to attach hardware: 'Hardware revision not supported' (HAL status 13)
ACPI: PCI interrupt for device 0000:02:00.0 disabled
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKC] -> GSI 4 (level, low) -> IRQ 4
PCI: Setting latency timer of device 0000:00:0f.0 to 64
hda_codec: Unknown model for ALC262, trying auto-probe from BIOS...
sis190 Gigabit Ethernet driver 1.2 loaded.
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
PCI: Setting latency timer of device 0000:00:04.0 to 64
0000:00:04.0: Read MAC address from EEPROM
0000:00:04.0: Realtek PHY RTL8201 transceiver at address 31.
0000:00:04.0: Using transceiver at address 31 as default.
0000:00:04.0: SiS 190 PCI Fast Ethernet adapter at cea34000 (IRQ: 3), 00:17:00:00:00:00
eth0: GMII mode.
eth0: Enabling Auto-negotiation.
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:00:03.3[D] -> Link [LNKH] -> GSI 7 (level, low) -> IRQ 7
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:03.3: irq 7, io mem 0xd4206000
ehci_hcd 0000:00:03.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKE] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.0: irq 11, io mem 0xd4204000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:03.1[B] -> Link [LNKF] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:03.1: irq 10, io mem 0xd4205000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
agpgart: Unsupported SiS chipset (device id: 0662)
USB Universal Host Controller Interface driver v2.3

--------------010000010805020500070606
Content-Type: text/x-log;
 name="lspci.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.log"

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0662 (rev 01)
	Flags: bus master, medium devsel, latency 32
	Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 3.5

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS AGP Port (virtual PCI-to-PCI bridge) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d4000000-d40fffff
	Prefetchable memory behind bridge: c8000000-cfffffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 0966 (rev 59)
	Flags: bus master, medium devsel, latency 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
	Flags: bus master, medium devsel, latency 128, IRQ 9
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at 1400 [size=16]
	Capabilities: [58] Power Management version 2

00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: QUANTA Computer Inc: Unknown device 0759
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at d4204000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: QUANTA Computer Inc: Unknown device 0759
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at d4205000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
	Subsystem: Silicon Integrated Systems [SiS] USB 2.0 Controller
	Flags: bus master, medium devsel, latency 32, IRQ 7
	Memory at d4206000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 2

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS]: Unknown device 0190 (rev 01)
	Subsystem: QUANTA Computer Inc: Unknown device 0759
	Flags: bus master, medium devsel, latency 0, IRQ 3
	Memory at d4407000 (32-bit, non-prefetchable) [size=128]
	I/O ports at 1000 [size=128]
	Capabilities: [40] Power Management version 2

00:05.0 IDE interface: Silicon Integrated Systems [SiS]: Unknown device 1183 (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 1183
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at 1448 [size=8]
	I/O ports at 143c [size=4]
	I/O ports at 1440 [size=8]
	I/O ports at 1438 [size=4]
	I/O ports at 1410 [size=16]
	I/O ports at 1080 [size=128]
	Capabilities: [58] Power Management version 2

00:06.0 PCI bridge: Silicon Integrated Systems [SiS] PCI-to-PCI bridge (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: d4100000-d41fffff
	Capabilities: [b0] #0d [0000]
	Capabilities: [c0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [d0] #10 [0141]
	Capabilities: [f4] Power Management version 2

00:07.0 PCI bridge: Silicon Integrated Systems [SiS] PCI-to-PCI bridge (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Memory behind bridge: dc000000-dfffffff
	Capabilities: [b0] #0d [0000]
	Capabilities: [c0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [d0] #10 [0141]
	Capabilities: [f4] Power Management version 2

00:0f.0 Class 0403: Silicon Integrated Systems [SiS]: Unknown device 7502
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 1234
	Flags: bus master, medium devsel, latency 0, IRQ 4
	Memory at d4200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2

00:1f.0 PCI bridge: Silicon Integrated Systems [SiS] PCI-to-PCI bridge (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	Capabilities: [d0] #10 [0141]
	Capabilities: [a0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [f4] Power Management version 2

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 661/741/760/761 PCI/AGP VGA Display Adapter (rev 04) (prog-if 00 [VGA])
	Flags: 66Mhz, medium devsel, IRQ 9
	BIST result: 00
	Memory at c8000000 (32-bit, prefetchable) [size=128M]
	Memory at d4000000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at 9000 [size=128]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [40] Power Management version 2
	Capabilities: [50] AGP version 3.0

02:00.0 Ethernet controller: Atheros Communications, Inc.: Unknown device 001c (rev 01)
	Subsystem: Unknown device 1a32:0100
	Flags: fast devsel, IRQ 9
	Memory at d4100000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [60] #10 [0011]
	Capabilities: [90] #11 [0000]


--------------010000010805020500070606--

