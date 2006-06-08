From: Aalderd Bouwman <aalderd.boac@wanadoo.nl>
Subject: Seagate SATA 3GB/s drive connected to via vt8251 using ahci module
Date: Thu, 08 Jun 2006 19:30:27 +0200
Message-ID: <1149787827.4180.8.camel@anja>
Reply-To: aalderd.boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp04.wanadoo.nl ([194.134.35.144]:13107 "EHLO
	smtp04.wanadoo.nl") by vger.kernel.org with ESMTP id S964877AbWFHR2f
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jun 2006 13:28:35 -0400
Received: from anja (s5593cc1b.adsl.wanadoo.nl [85.147.204.27])
	by smtp4.wanadoo.nl (Postfix) with ESMTP id 36A12407B0
	for <linux-ide@vger.kernel.org>; Thu,  8 Jun 2006 19:28:32 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I am running Gentoo Linux on a Asus A8V-MX mainboard with the Via VT8251
southbridge chipset. The sata-controller is configured as AHCI.
Bios version is 0210.

The drive is working properly with the drivers of VIA.

A Maxtor drive works correct on this controller but this seagate drive
(ST3808110AS) fails on both modes (1.5Gb/s or 3.0Gb/s).

Here you can find the log-results after doing some actions on this
drive. After the sector errors the drive could not be accessed by fdisk.

# uname -a
Linux server 2.6.17-rc5-mm2 #2 Wed Jun 7 22:18:57 CEST 2006 i686 AMD
Opteron(tm) Processor 144 AuthenticAMD GNU/Linux

Kernel log:

Jun  8 18:38:54 server 800000 type: 2
Jun  8 18:38:54 server add_memory_region(000000001f7e0000, 0000000000020000, 2)
Jun  8 18:38:54 server copy_e820_map() start: 00000000e0000000 size: 0000000010000000 end: 00000000f0000000 type: 2
Jun  8 18:38:54 server add_memory_region(00000000e0000000, 0000000010000000, 2)
Jun  8 18:38:54 server copy_e820_map() start: 00000000fec00000 size: 0000000000001000 end: 00000000fec01000 type: 2
Jun  8 18:38:54 server add_memory_region(00000000fec00000, 0000000000001000, 2)
Jun  8 18:38:54 server copy_e820_map() start: 00000000ff7c0000 size: 0000000000840000 end: 0000000100000000 type: 2
Jun  8 18:38:54 server add_memory_region(00000000ff7c0000, 0000000000840000, 2)
Jun  8 18:38:54 server BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jun  8 18:38:54 server BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jun  8 18:38:54 server BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Jun  8 18:38:54 server BIOS-e820: 0000000000100000 - 000000001f7b0000 (usable)
Jun  8 18:38:54 server BIOS-e820: 000000001f7b0000 - 000000001f7be000 (ACPI data)
Jun  8 18:38:54 server BIOS-e820: 000000001f7be000 - 000000001f7e0000 (ACPI NVS)
Jun  8 18:38:54 server BIOS-e820: 000000001f7e0000 - 000000001f800000 (reserved)
Jun  8 18:38:54 server BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jun  8 18:38:54 server BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jun  8 18:38:54 server BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Jun  8 18:38:54 server 503MB LOWMEM available.
Jun  8 18:38:54 server On node 0 totalpages: 128944
Jun  8 18:38:54 server DMA zone: 4096 pages, LIFO batch:0
Jun  8 18:38:54 server Normal zone: 124848 pages, LIFO batch:31
Jun  8 18:38:54 server DMI 2.3 present.
Jun  8 18:38:54 server ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fac60
Jun  8 18:38:54 server ACPI: XSDT (v001 A M I  OEMXSDT  0x09000505 MSFT 0x00000097) @ 0x1f7b0100
Jun  8 18:38:54 server ACPI: FADT (v003 A M I  OEMFACP  0x09000505 MSFT 0x00000097) @ 0x1f7b0290
Jun  8 18:38:54 server ACPI: MADT (v001 A M I  OEMAPIC  0x09000505 MSFT 0x00000097) @ 0x1f7b0390
Jun  8 18:38:54 server ACPI: OEMB (v001 A M I  AMI_OEM  0x09000505 MSFT 0x00000097) @ 0x1f7be040
Jun  8 18:38:54 server ACPI: DSDT (v001  A0347 A0347001 0x00000001 INTL 0x02002026) @ 0x00000000
Jun  8 18:38:54 server ACPI: PM-Timer IO Port: 0x808
Jun  8 18:38:54 server Allocating PCI resources starting at 20000000 (gap: 1f800000:c0800000)
Jun  8 18:38:54 server Detected 1800.296 MHz processor.
Jun  8 18:38:54 server Built 1 zonelists
Jun  8 18:38:54 server Kernel command line: root=/dev/hda3
Jun  8 18:38:54 server Enabling fast FPU save and restore... done.
Jun  8 18:38:54 server Enabling unmasked SIMD FPU exception support... done.
Jun  8 18:38:54 server Initializing CPU#0
Jun  8 18:38:54 server CPU 0 irqstacks, hard=c03d9000 soft=c03d8000
Jun  8 18:38:54 server PID hash table entries: 2048 (order: 11, 8192 bytes)
Jun  8 18:38:54 server Console: colour VGA+ 80x25
Jun  8 18:38:54 server Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Jun  8 18:38:54 server Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Jun  8 18:38:54 server Memory: 507748k/515776k available (1920k kernel code, 7540k reserved, 800k data, 164k init, 0k highmem)
Jun  8 18:38:54 server Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jun  8 18:38:54 server Calibrating delay using timer specific routine.. 3602.51 BogoMIPS (lpj=7205030)
Jun  8 18:38:54 server Mount-cache hash table entries: 512
Jun  8 18:38:54 server CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
Jun  8 18:38:54 server CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
Jun  8 18:38:54 server CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jun  8 18:38:54 server CPU: L2 Cache: 1024K (64 bytes/line)
Jun  8 18:38:54 server CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000410 00000001 00000000 00000001
Jun  8 18:38:54 server Intel machine check architecture supported.
Jun  8 18:38:54 server Intel machine check reporting enabled on CPU#0.
Jun  8 18:38:54 server Compat vDSO mapped to ffffe000.
Jun  8 18:38:54 server CPU: AMD Opteron(tm) Processor 144 stepping 01
Jun  8 18:38:54 server Checking 'hlt' instruction... OK.
Jun  8 18:38:54 server SMP alternatives: switching to UP code
Jun  8 18:38:54 server Freeing SMP alternatives: 0k freed
Jun  8 18:38:54 server ACPI: setting ELCR to 0200 (from 0c28)
Jun  8 18:38:54 server NET: Registered protocol family 16
Jun  8 18:38:54 server ACPI: bus type pci registered
Jun  8 18:38:54 server PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=4
Jun  8 18:38:54 server Setting up standard PCI resources
Jun  8 18:38:54 server ACPI: Subsystem revision 20060310
Jun  8 18:38:54 server ACPI: Interpreter enabled
Jun  8 18:38:54 server ACPI: Using PIC for interrupt routing
Jun  8 18:38:54 server ACPI: PCI Root Bridge [PCI0] (0000:00)
Jun  8 18:38:54 server PCI: Probing PCI hardware (bus 00)
Jun  8 18:38:54 server Boot video device is 0000:01:00.0
Jun  8 18:38:54 server ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jun  8 18:38:54 server ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
Jun  8 18:38:54 server ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
Jun  8 18:38:54 server ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7.P7P9._PRT]
Jun  8 18:38:54 server ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7.P7P8._PRT]
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jun  8 18:38:54 server Linux Plug and Play Support v0.97 (c) Adam Belay
Jun  8 18:38:54 server pnp: PnP ACPI init
Jun  8 18:38:54 server pnp: PnP ACPI: found 15 devices
Jun  8 18:38:54 server SCSI subsystem initialized
Jun  8 18:38:54 server usbcore: registered new driver usbfs
Jun  8 18:38:54 server usbcore: registered new driver hub
Jun  8 18:38:54 server PCI: Using ACPI for IRQ routing
Jun  8 18:38:54 server PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jun  8 18:38:54 server TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
Jun  8 18:38:54 server pnp: 00:07: ioport range 0x290-0x297 has been reserved
Jun  8 18:38:54 server PCI: Bridge: 0000:00:01.0
Jun  8 18:38:54 server IO window: disabled.
Jun  8 18:38:54 server MEM window: fca00000-feafffff
Jun  8 18:38:54 server PREFETCH window: cff00000-d7efffff
Jun  8 18:38:54 server PCI: Bridge: 0000:02:00.0
Jun  8 18:38:54 server IO window: disabled.
Jun  8 18:38:54 server MEM window: disabled.
Jun  8 18:38:54 server PREFETCH window: disabled.
Jun  8 18:38:54 server PCI: Bridge: 0000:02:00.1
Jun  8 18:38:54 server IO window: disabled.
Jun  8 18:38:54 server MEM window: disabled.
Jun  8 18:38:54 server PREFETCH window: disabled.
Jun  8 18:38:54 server PCI: Bridge: 0000:00:13.0
Jun  8 18:38:54 server IO window: disabled.
Jun  8 18:38:54 server MEM window: disabled.
Jun  8 18:38:54 server PREFETCH window: disabled.
Jun  8 18:38:54 server ACPI (acpi_bus-0192): Device `P0P1]is not power manageable [20060310]
Jun  8 18:38:54 server PCI: Setting latency timer of device 0000:00:01.0 to 64
Jun  8 18:38:54 server PCI: Setting latency timer of device 0000:00:13.0 to 64
Jun  8 18:38:54 server ACPI (acpi_bus-0192): Device `P7P8]is not power manageable [20060310]
Jun  8 18:38:54 server PCI: Setting latency timer of device 0000:02:00.0 to 64
Jun  8 18:38:54 server ACPI (acpi_bus-0192): Device `P7P9]is not power manageable [20060310]
Jun  8 18:38:54 server PCI: Setting latency timer of device 0000:02:00.1 to 64
Jun  8 18:38:54 server NET: Registered protocol family 2
Jun  8 18:38:54 server IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
Jun  8 18:38:54 server TCP established hash table entries: 16384 (order: 4, 65536 bytes)
Jun  8 18:38:54 server TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
Jun  8 18:38:54 server TCP: Hash tables configured (established 16384 bind 8192)
Jun  8 18:38:54 server TCP reno registered
Jun  8 18:38:54 server Machine check exception polling timer started.
Jun  8 18:38:54 server audit: initializing netlink socket (disabled)
Jun  8 18:38:54 server audit(1149791899.396:1): initialized
Jun  8 18:38:54 server Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Jun  8 18:38:54 server io scheduler noop registered
Jun  8 18:38:54 server io scheduler anticipatory registered (default)
Jun  8 18:38:54 server io scheduler deadline registered
Jun  8 18:38:54 server io scheduler cfq registered
Jun  8 18:38:54 server ACPI: Power Button (FF) [PWRF]
Jun  8 18:38:54 server ACPI: Sleep Button (CM) [SLPB]
Jun  8 18:38:54 server ACPI: Power Button (CM) [PWRB]
Jun  8 18:38:54 server ACPI: Processor [CPU1] (supports 16 throttling states)
Jun  8 18:38:54 server ACPI Error (acpi_processor-0474): Getting cpuindex for acpiid 0x2 [20060310]
Jun  8 18:38:54 server Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Jun  8 18:38:54 server serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun  8 18:38:54 server 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun  8 18:38:54 server Floppy drive(s): fd0 is 1.44M
Jun  8 18:38:54 server FDC 0 is a post-1991 82077
Jun  8 18:38:54 server via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
Jun  8 18:38:54 server ACPI (acpi_bus-0192): Device `ILAN]is not power manageable [20060310]
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Jun  8 18:38:54 server PCI: setting IRQ 11 as level-triggered
Jun  8 18:38:54 server ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jun  8 18:38:54 server eth0: VIA Rhine II at 0xfebff000, 00:13:d4:a7:82:e5, IRQ 11.
Jun  8 18:38:54 server eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link 45e1.
Jun  8 18:38:54 server Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jun  8 18:38:54 server ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun  8 18:38:54 server VP_IDE: IDE controller at PCI slot 0000:00:0f.1
Jun  8 18:38:54 server ACPI (acpi_bus-0192): Device `IDEC]is not power manageable [20060310]
Jun  8 18:38:54 server PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 0
Jun  8 18:38:54 server VP_IDE: chipset revision 7
Jun  8 18:38:54 server VP_IDE: not 100% native mode: will probe irqs later
Jun  8 18:38:54 server VP_IDE: VIA vt8251 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
Jun  8 18:38:54 server ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
Jun  8 18:38:54 server ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Jun  8 18:38:54 server Probing IDE interface ide0...
Jun  8 18:38:54 server hda: QUANTUM BIGFOOT TS6.4A, ATA DISK drive
Jun  8 18:38:54 server hdb: Pioneer DVD-ROM ATAPIModel DVD-104S 012, ATAPI CD/DVD-ROM drive
Jun  8 18:38:54 server ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun  8 18:38:54 server Probing IDE interface ide1...
Jun  8 18:38:54 server hdc: ST3160021A, ATA DISK drive
Jun  8 18:38:54 server ide1 at 0x170-0x177,0x376 on irq 15
Jun  8 18:38:54 server hda: max request size: 128KiB
Jun  8 18:38:54 server hda: 12536370 sectors (6418 MB) w/418KiB Cache, CHS=13266/15/63, UDMA(33)
Jun  8 18:38:54 server hda: cache flushes not supported
Jun  8 18:38:54 server hda: hda1 hda2 hda3 hda4 < hda5 >
Jun  8 18:38:54 server hdc: max request size: 512KiB
Jun  8 18:38:54 server hdc: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(100)
Jun  8 18:38:54 server hdc: cache flushes supported
Jun  8 18:38:54 server hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 hdc9 >
Jun  8 18:38:54 server hdb: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Jun  8 18:38:54 server Uniform CD-ROM driver Revision: 3.20
Jun  8 18:38:54 server ACPI (acpi_bus-0192): Device `EHCI]is not power manageable [20060310]
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Jun  8 18:38:54 server PCI: setting IRQ 5 as level-triggered
Jun  8 18:38:54 server ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Jun  8 18:38:54 server ehci_hcd 0000:00:10.4: EHCI Host Controller
Jun  8 18:38:54 server ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
Jun  8 18:38:54 server ehci_hcd 0000:00:10.4: debug port 1
Jun  8 18:38:54 server ehci_hcd 0000:00:10.4: irq 5, io mem 0xfebff400
Jun  8 18:38:54 server ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Jun  8 18:38:54 server usb usb1: new device found, idVendor=0000, idProduct=0000
Jun  8 18:38:54 server usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
Jun  8 18:38:54 server usb usb1: Product: EHCI Host Controller
Jun  8 18:38:54 server usb usb1: Manufacturer: Linux 2.6.17-rc5-mm2 ehci_hcd
Jun  8 18:38:54 server usb usb1: SerialNumber: 0000:00:10.4
Jun  8 18:38:54 server usb usb1: configuration #1 chosen from 1 choice
Jun  8 18:38:54 server hub 1-0:1.0: USB hub found
Jun  8 18:38:54 server hub 1-0:1.0: 8 ports detected
Jun  8 18:38:54 server USB Universal Host Controller Interface driver v3.0
Jun  8 18:38:54 server ACPI (acpi_bus-0192): Device `USB1]is not power manageable [20060310]
Jun  8 18:38:54 server ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jun  8 18:38:54 server uhci_hcd 0000:00:10.0: UHCI Host Controller
Jun  8 18:38:54 server uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
Jun  8 18:38:54 server uhci_hcd 0000:00:10.0: irq 11, io base 0x0000e000
Jun  8 18:38:54 server usb usb2: new device found, idVendor=0000, idProduct=0000
Jun  8 18:38:54 server usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
Jun  8 18:38:54 server usb usb2: Product: UHCI Host Controller
Jun  8 18:38:54 server usb usb2: Manufacturer: Linux 2.6.17-rc5-mm2 uhci_hcd
Jun  8 18:38:54 server usb usb2: SerialNumber: 0000:00:10.0
Jun  8 18:38:54 server usb usb2: configuration #1 chosen from 1 choice
Jun  8 18:38:54 server hub 2-0:1.0: USB hub found
Jun  8 18:38:54 server hub 2-0:1.0: 2 ports detected
Jun  8 18:38:54 server ACPI (acpi_bus-0192): Device `USB2]is not power manageable [20060310]
Jun  8 18:38:54 server ACPI: PCI Interrupt 0000:00:10.1[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Jun  8 18:38:54 server uhci_hcd 0000:00:10.1: UHCI Host Controller
Jun  8 18:38:54 server uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
Jun  8 18:38:54 server uhci_hcd 0000:00:10.1: irq 5, io base 0x0000dc00
Jun  8 18:38:54 server usb usb3: new device found, idVendor=0000, idProduct=0000
Jun  8 18:38:54 server usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
Jun  8 18:38:54 server usb usb3: Product: UHCI Host Controller
Jun  8 18:38:54 server usb usb3: Manufacturer: Linux 2.6.17-rc5-mm2 uhci_hcd
Jun  8 18:38:54 server usb usb3: SerialNumber: 0000:00:10.1
Jun  8 18:38:54 server usb usb3: configuration #1 chosen from 1 choice
Jun  8 18:38:54 server hub 3-0:1.0: USB hub found
Jun  8 18:38:54 server hub 3-0:1.0: 2 ports detected
Jun  8 18:38:54 server ACPI (acpi_bus-0192): Device `USB3]is not power manageable [20060310]
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Jun  8 18:38:54 server PCI: setting IRQ 10 as level-triggered
Jun  8 18:38:54 server ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Jun  8 18:38:54 server uhci_hcd 0000:00:10.2: UHCI Host Controller
Jun  8 18:38:54 server uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
Jun  8 18:38:54 server uhci_hcd 0000:00:10.2: irq 10, io base 0x0000d880
Jun  8 18:38:54 server usb usb4: new device found, idVendor=0000, idProduct=0000
Jun  8 18:38:54 server usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
Jun  8 18:38:54 server usb usb4: Product: UHCI Host Controller
Jun  8 18:38:54 server usb usb4: Manufacturer: Linux 2.6.17-rc5-mm2 uhci_hcd
Jun  8 18:38:54 server usb usb4: SerialNumber: 0000:00:10.2
Jun  8 18:38:54 server usb usb4: configuration #1 chosen from 1 choice
Jun  8 18:38:54 server hub 4-0:1.0: USB hub found
Jun  8 18:38:54 server hub 4-0:1.0: 2 ports detected
Jun  8 18:38:54 server ACPI (acpi_bus-0192): Device `USB4]is not power manageable [20060310]
Jun  8 18:38:54 server ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
Jun  8 18:38:54 server PCI: setting IRQ 3 as level-triggered
Jun  8 18:38:54 server ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
Jun  8 18:38:54 server uhci_hcd 0000:00:10.3: UHCI Host Controller
Jun  8 18:38:54 server uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
Jun  8 18:38:54 server uhci_hcd 0000:00:10.3: irq 3, io base 0x0000d800
Jun  8 18:38:54 server usb usb5: new device found, idVendor=0000, idProduct=0000
Jun  8 18:38:54 server usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
Jun  8 18:38:54 server usb usb5: Product: UHCI Host Controller
Jun  8 18:38:54 server usb usb5: Manufacturer: Linux 2.6.17-rc5-mm2 uhci_hcd
Jun  8 18:38:54 server usb usb5: SerialNumber: 0000:00:10.3
Jun  8 18:38:54 server usb usb5: configuration #1 chosen from 1 choice
Jun  8 18:38:54 server hub 5-0:1.0: USB hub found
Jun  8 18:38:54 server hub 5-0:1.0: 2 ports detected
Jun  8 18:38:54 server Initializing USB Mass Storage driver...
Jun  8 18:38:54 server usbcore: registered new driver usb-storage
Jun  8 18:38:54 server USB Mass Storage support registered.
Jun  8 18:38:54 server PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Jun  8 18:38:54 server serio: i8042 AUX port at 0x60,0x64 irq 12
Jun  8 18:38:54 server serio: i8042 KBD port at 0x60,0x64 irq 1
Jun  8 18:38:54 server mice: PS/2 mouse device common for all mice
Jun  8 18:38:54 server input: PC Speaker as /class/input/input0
Jun  8 18:38:54 server ip_conntrack version 2.4 (4029 buckets, 32232 max) - 208 bytes per conntrack
Jun  8 18:38:54 server input: AT Translated Set 2 keyboard as /class/input/input1
Jun  8 18:38:54 server TCP bic registered
Jun  8 18:38:54 server NET: Registered protocol family 1
Jun  8 18:38:54 server NET: Registered protocol family 17
Jun  8 18:38:54 server Using IPI Shortcut mode
Jun  8 18:38:54 server ACPI: (supports S0 S1 S3 S4 S5)
Jun  8 18:38:54 server Freeing unused kernel memory: 164k freed
Jun  8 18:38:54 server Time: tsc clocksource has been installed.
Jun  8 18:38:54 server ReiserFS: hda3: found reiserfs format "3.6" with standard journal
Jun  8 18:38:54 server ReiserFS: hda3: using ordered data mode
Jun  8 18:38:54 server ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jun  8 18:38:54 server ReiserFS: hda3: checking transaction log (hda3)
Jun  8 18:38:54 server ReiserFS: hda3: Using r5 hash to sort names
Jun  8 18:38:54 server Adding 192772k swap on /dev/hda2.  Priority:-1 extents:1 across:192772k
Jun  8 18:38:54 server ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Jun  8 18:38:54 server 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Jun  8 18:38:54 server 0000:00:0c.0: 3Com PCI 3c905B Cyclone 100baseTx at e00d6800.
Jun  8 18:38:54 server ReiserFS: hdc5: found reiserfs format "3.6" with standard journal
Jun  8 18:38:54 server ReiserFS: hdc5: using ordered data mode
Jun  8 18:38:54 server ReiserFS: hdc5: journal params: device hdc5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jun  8 18:38:54 server ReiserFS: hdc5: checking transaction log (hdc5)
Jun  8 18:38:54 server ReiserFS: hdc5: Using r5 hash to sort names
Jun  8 18:38:54 server ReiserFS: hdc6: found reiserfs format "3.6" with standard journal
Jun  8 18:38:54 server ReiserFS: hdc6: using ordered data mode
Jun  8 18:38:54 server ReiserFS: hdc6: journal params: device hdc6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jun  8 18:38:54 server ReiserFS: hdc6: checking transaction log (hdc6)
Jun  8 18:38:54 server ReiserFS: hdc6: Using r5 hash to sort names
Jun  8 18:38:54 server ReiserFS: hdc7: found reiserfs format "3.6" with standard journal
Jun  8 18:38:54 server ReiserFS: hdc7: using ordered data mode
Jun  8 18:38:54 server ReiserFS: hdc7: journal params: device hdc7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jun  8 18:38:54 server ReiserFS: hdc7: checking transaction log (hdc7)
Jun  8 18:38:54 server ReiserFS: hdc7: Using r5 hash to sort names
Jun  8 18:38:54 server ReiserFS: hdc8: found reiserfs format "3.6" with standard journal
Jun  8 18:38:54 server ReiserFS: hdc8: using ordered data mode
Jun  8 18:38:54 server ReiserFS: hdc8: journal params: device hdc8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jun  8 18:38:54 server ReiserFS: hdc8: checking transaction log (hdc8)
Jun  8 18:38:54 server ReiserFS: hdc8: Using r5 hash to sort names
Jun  8 18:38:54 server ReiserFS: hdc9: found reiserfs format "3.6" with standard journal
Jun  8 18:38:54 server ReiserFS: hdc9: using ordered data mode
Jun  8 18:38:54 server ReiserFS: hdc9: journal params: device hdc9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jun  8 18:38:54 server ReiserFS: hdc9: checking transaction log (hdc9)
Jun  8 18:38:54 server ReiserFS: hdc9: Using r5 hash to sort names
Jun  8 18:38:55 server eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Jun  8 18:38:55 server ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Jun  8 18:38:55 server eth1:  setting full-duplex.

After inserting ahci module:
Kernel log:
Jun  8 18:52:12 server libata version 1.30 loaded.
Jun  8 18:52:12 server ahci 0000:00:0f.0: version 1.3
Jun  8 18:52:12 server ACPI (acpi_bus-0192): Device `SATA]is not power manageable [20060310]
Jun  8 18:52:12 server ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Jun  8 18:52:18 server ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
Jun  8 18:52:18 server ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jun  8 18:52:18 server ata1: SATA max UDMA/133 cmd 0xE0488D00 ctl 0x0 bmdma 0x0 irq 10
Jun  8 18:52:18 server ata2: SATA max UDMA/133 cmd 0xE0488D80 ctl 0x0 bmdma 0x0 irq 10
Jun  8 18:52:18 server ata3: SATA max UDMA/133 cmd 0xE0488E00 ctl 0x0 bmdma 0x0 irq 10
Jun  8 18:52:18 server ata4: SATA max UDMA/133 cmd 0xE0488E80 ctl 0x0 bmdma 0x0 irq 10
Jun  8 18:52:18 server ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun  8 18:52:18 server ata1.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
Jun  8 18:52:18 server ata1.00: ATA-7, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 31/32)
Jun  8 18:52:18 server ata1.00: configured for UDMA/133
Jun  8 18:52:18 server scsi0 : ahci
Jun  8 18:52:18 server ata2: SATA link down (SStatus 0 SControl 300)
Jun  8 18:52:18 server scsi1 : ahci
Jun  8 18:52:19 server ata3: SATA link down (SStatus 0 SControl 300)
Jun  8 18:52:19 server scsi2 : ahci
Jun  8 18:52:19 server ata4: SATA link down (SStatus 0 SControl 300)
Jun  8 18:52:19 server scsi3 : ahci
Jun  8 18:52:19 server Vendor: ATA       Model: ST3808110AS       Rev: 3.AA
Jun  8 18:52:19 server Type:   Direct-Access                      ANSI SCSI revision: 05
Jun  8 18:52:19 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Jun  8 18:52:19 server sda: Write Protect is off
Jun  8 18:52:19 server sda: Mode Sense: 00 3a 00 00
Jun  8 18:52:19 server SCSI device sda: drive cache: write back
Jun  8 18:52:19 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Jun  8 18:52:19 server sda: Write Protect is off
Jun  8 18:52:19 server sda: Mode Sense: 00 3a 00 00
Jun  8 18:52:19 server SCSI device sda: drive cache: write back
Jun  8 18:52:19 server sda: sda1 sda2 sda3 sda4 < sda5 >
Jun  8 18:52:19 server sd 0:0:0:0: Attached scsi disk sda
Jun  8 18:52:19 server sd 0:0:0:0: Attached scsi generic sg0 type 0

Now doing fdisk /dev/sda or mke2fs /dev/sda1:
Kernel log:
Jun  8 18:52:19 server ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x2)
Jun  8 18:53:09 server ata1.00: qc timeout (cmd 0x2f)
Jun  8 18:53:09 server ata1: failed to read log page 10h (errno=-5)
Jun  8 18:53:09 server ata1.00: exception Emask 0x1 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
Jun  8 18:53:09 server ata1.00: (irq_stat 0x40000000)
Jun  8 18:53:09 server ata1.00: tag 0 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 1 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 2 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 3 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 4 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 5 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 6 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 7 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 8 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 9 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 10 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 11 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 12 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 13 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 14 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 15 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 16 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 17 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 18 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 19 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 20 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 21 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 22 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 23 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 24 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 25 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 26 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 27 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 28 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 29 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1.00: tag 30 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun  8 18:53:09 server ata1: soft resetting port
Jun  8 18:53:09 server ata1: softreset failed (1st FIS failed)
Jun  8 18:53:09 server ata1: softreset failed, retrying in 5 secs

Jun  8 18:53:14 server ata1: hard resetting port
Jun  8 18:53:22 server ata1: port is slow to respond, please be patient
Jun  8 18:53:45 server ata1: port failed to respond (30 secs)
Jun  8 18:53:45 server ata1: COMRESET failed (device not ready)
Jun  8 18:53:45 server ata1: hardreset failed, retrying in 5 secs
Jun  8 18:53:50 server ata1: hard resetting port
Jun  8 18:53:57 server ata1: port is slow to respond, please be patient

Jun  8 18:54:20 server ata1: port failed to respond (30 secs)
Jun  8 18:54:20 server ata1: COMRESET failed (device not ready)
Jun  8 18:54:20 server ata1: reset failed, giving up
Jun  8 18:54:20 server ata1.00: disabled
Jun  8 18:54:20 server ata1: EH complete
Jun  8 18:54:20 server CSI error: return code = 0x40000

Very much scsi errors for different sectors: 
(I use syslog-ng, maybe the corruptoins are generated by suppressing messages)

Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 98375
Jun  8 18:54:20 server sd 0:0:0:0: SCSI error: return code = 0x40000
..
Jun  8 18:54:20 server sd 0:0:0:0: SCSI errCSI error: return code = 0x40000
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 98395
Jun  8 18:54:20 server sd 0:0:0:0: SCSI error: return code = 0x40000
..
Jun  8 18:54:20 server end_request: I/CSI error: return code = 0x40000
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 98415
Jun  8 18:54:20 server sd 0:0:0:0: SCSI error: return code = 0x40000
..
Jun  8 18:54:20 server sd 0:0:0:0: SCSI errSCSI error: return code = 0x40000
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 98691
Jun  8 18:54:20 server sd 0:0:0:0: SCSI error: return code = 0x40000
..
Jun  8 18:54:20 server unparseable log message: "<ror: return code = 0x40000"
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 196759
..
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 273051
Jun  8 18:54:20 server sd 0:0:0:0: SCSI error: return code = 0x40000
Jun  8 18:54:20 server end_request: I/O errror: return code = 0x40000
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 196779
Jun  8 18:54:20 server sd 0:0:0:0: SCSI error: return code = 0x40000
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 180653
Jun  8 18:54:20 server sd 0:0:0:0: SCSI error: return code = 0x40000
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 273063
..
Jun  8 18:54:20 server end_request: I/O e: return code = 0x40000
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 131559
Jun  8 18:54:20 server sd 0:0:0:0: SCSI error: return code = 0x40000
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 131301
Jun  8 18:54:20 server sd 0:0:0:0: SCSI error: return code = 0x40000
..
Jun  8 18:54:20 server sd 0:0:0:0: SCSI e return code = 0x40000
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 180473
Jun  8 18:54:20 server sd 0:0:0:0: SCSI error: return code = 0x40000
..
Jun  8 18:54:20 server sd 0:0:0:0: SCSI error: return code = 0x40000
Jun  8 18:54:20 server end_request: I/O error, dev sda, sector 65
Jun  8 18:54:41 server sd 0:0:0:0: SCSI error: return code = 0x40000
Jun  8 18:54:41 server end_request: I/O error, dev sda, sector 0
Jun  8 18:54:41 server printk: 3105 messages suppressed.
Jun  8 18:54:41 server Buffer I/O error on device sda, logical block 0
Jun  8 18:54:41 server sd 0:0:0:0: SCSI error: return code = 0x40000
Jun  8 18:54:41 server end_request: I/O error, dev sda, sector 8
Jun  8 18:54:41 server Buffer I/O error on device sda, logical block 1
Jun  8 18:54:41 server sd 0:0:0:0: SCSI error: return code = 0x40000
Jun  8 18:54:41 server end_request: I/O error, dev sda, sector 16
Jun  8 18:54:41 server Buffer I/O error on device sda, logical block 2
Jun  8 18:54:41 server sd 0:0:0:0: SCSI error: return code = 0x40000
Jun  8 18:54:41 server end_request: I/O error, dev sda, sector 24
Jun  8 18:54:41 server Buffer I/O error on device sda, logical block 3
Jun  8 18:54:41 server sd 0:0:0:0: SCSI error: return code = 0x40000
Jun  8 18:54:41 server end_request: I/O error, dev sda, sector 0

unloading ahci:
Jun  8 18:54:47 server ACPI: PCI interrupt for device 0000:00:0f.0 disabled

Thanks Tejun for finding this list ;-)

Aalderd.

