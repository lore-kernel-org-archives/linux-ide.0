From: Aalderd Bouwman <aalderd.boac@wanadoo.nl>
Subject: Re: [PATCHSET] ahci updates regarding vt8251 support, take #2
Date: Wed, 18 Oct 2006 19:02:34 +0200
Message-ID: <1161190955.2924.10.camel@anja>
References: <11609522031228-git-send-email-htejun@gmail.com>
	 <1161146723.3008.2.camel@anja>  <45361509.2050000@gmail.com>
Reply-To: aalderd.boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-1.orange.nl ([193.252.22.241]:23347 "EHLO smtp-1.orange.nl")
	by vger.kernel.org with ESMTP id S1422692AbWJRRAy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Oct 2006 13:00:54 -0400
In-Reply-To: <45361509.2050000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Oct 14 08:48:18 server 0: 0000000000100000 - 000000001f7b0000 (usable)
Oct 14 08:48:18 server BIOS-e820: 000000001f7b0000 - 000000001f7be000
(ACPI data)
Oct 14 08:48:18 server BIOS-e820: 000000001f7be000 - 000000001f7e0000
(ACPI NVS)
Oct 14 08:48:18 server BIOS-e820: 000000001f7e0000 - 000000001f800000
(reserved)
Oct 14 08:48:18 server BIOS-e820: 00000000e0000000 - 00000000f0000000
(reserved)
Oct 14 08:48:18 server BIOS-e820: 00000000fec00000 - 00000000fec01000
(reserved)
Oct 14 08:48:18 server BIOS-e820: 00000000ff7c0000 - 0000000100000000
(reserved)
Oct 14 08:48:18 server 503MB LOWMEM available.
Oct 14 08:48:18 server Entering add_active_range(0, 0, 128944) 0 entries
of 256 used
Oct 14 08:48:18 server Zone PFN ranges:
Oct 14 08:48:18 server DMA             0 ->     4096
Oct 14 08:48:18 server Normal       4096 ->   128944
Oct 14 08:48:18 server early_node_map[1] active PFN ranges
Oct 14 08:48:18 server 0:        0 ->   128944
Oct 14 08:48:18 server On node 0 totalpages: 128944
Oct 14 08:48:18 server DMA zone: 32 pages used for memmap
Oct 14 08:48:18 server DMA zone: 0 pages reserved
Oct 14 08:48:18 server DMA zone: 4064 pages, LIFO batch:0
Oct 14 08:48:18 server Normal zone: 975 pages used for memmap
Oct 14 08:48:18 server Normal zone: 123873 pages, LIFO batch:31
Oct 14 08:48:18 server DMI 2.3 present.
Oct 14 08:48:18 server ACPI: RSDP (v002
ACPIAM                                ) @ 0x000fac60
Oct 14 08:48:18 server ACPI: XSDT (v001 A M I  OEMXSDT  0x09000505 MSFT
0x00000097) @ 0x1f7b0100
Oct 14 08:48:18 server ACPI: FADT (v003 A M I  OEMFACP  0x09000505 MSFT
0x00000097) @ 0x1f7b0290
Oct 14 08:48:18 server ACPI: MADT (v001 A M I  OEMAPIC  0x09000505 MSFT
0x00000097) @ 0x1f7b0390
Oct 14 08:48:18 server ACPI: OEMB (v001 A M I  AMI_OEM  0x09000505 MSFT
0x00000097) @ 0x1f7be040
Oct 14 08:48:18 server ACPI: DSDT (v001  A0347 A0347001 0x00000001 INTL
0x02002026) @ 0x00000000
Oct 14 08:48:18 server ACPI: PM-Timer IO Port: 0x808
Oct 14 08:48:18 server Allocating PCI resources starting at 20000000
(gap: 1f800000:c0800000)
Oct 14 08:48:18 server Detected 1800.130 MHz processor.
Oct 14 08:48:18 server Built 1 zonelists.  Total pages: 127937
Oct 14 08:48:18 server Kernel command line: root=/dev/sda3
Oct 14 08:48:18 server Enabling fast FPU save and restore... done.
Oct 14 08:48:18 server Enabling unmasked SIMD FPU exception support...
done.
Oct 14 08:48:18 server Initializing CPU#0
Oct 14 08:48:18 server PID hash table entries: 2048 (order: 11, 8192
bytes)
Oct 14 08:48:18 server Console: colour VGA+ 80x25
Oct 14 08:48:18 server Dentry cache hash table entries: 65536 (order: 6,
262144 bytes)
Oct 14 08:48:18 server Inode-cache hash table entries: 32768 (order: 5,
131072 bytes)
Oct 14 08:48:18 server Memory: 507932k/515776k available (1895k kernel
code, 7356k reserved, 712k data, 136k init,
0k highmem)
Oct 14 08:48:18 server virtual kernel memory layout:
Oct 14 08:48:18 server fixmap  : 0xffff8000 - 0xfffff000   (  28 kB)
Oct 14 08:48:18 server vmalloc : 0xe0000000 - 0xffff6000   ( 511 MB)
Oct 14 08:48:18 server lowmem  : 0xc0000000 - 0xdf7b0000   ( 503 MB)
Oct 14 08:48:18 server .init : 0xc038e000 - 0xc03b0000   ( 136 kB)
Oct 14 08:48:18 server .data : 0xc02d9d36 - 0xc038beec   ( 712 kB)
Oct 14 08:48:18 server .text : 0xc0100000 - 0xc02d9d36   (1895 kB)
Oct 14 08:48:18 server Checking if this processor honours the WP bit
even in supervisor mode... Ok.
Oct 14 08:48:18 server Calibrating delay using timer specific routine..
3602.34 BogoMIPS (lpj=7204688)
Oct 14 08:48:18 server Mount-cache hash table entries: 512
Oct 14 08:48:18 server CPU: After generic identify, caps: 078bfbff
e3d3fbff 00000000 00000000 00000001 00000000 00000001
Oct 14 08:48:18 server CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K
(64 bytes/line)
Oct 14 08:48:18 server CPU: L2 Cache: 1024K (64 bytes/line)
Oct 14 08:48:18 server CPU: After all inits, caps: 078bfbff e3d3fbff
00000000 00000410 00000001 00000000 00000001
Oct 14 08:48:18 server Intel machine check architecture supported.
Oct 14 08:48:18 server Intel machine check reporting enabled on CPU#0.
Oct 14 08:48:18 server Compat vDSO mapped to ffffe000.
Oct 14 08:48:18 server CPU: AMD Opteron(tm) Processor 144 stepping 01
Oct 14 08:48:18 server Checking 'hlt' instruction... OK.
Oct 14 08:48:18 server ACPI: Core revision 20060707
Oct 14 08:48:18 server ACPI: setting ELCR to 0200 (from 0c28)
Oct 14 08:48:18 server NET: Registered protocol family 16
Oct 14 08:48:18 server ACPI: bus type pci registered
Oct 14 08:48:18 server PCI: PCI BIOS revision 3.00 entry at 0xf0031,
last bus=4
Oct 14 08:48:18 server PCI: Using configuration type 1
Oct 14 08:48:18 server Setting up standard PCI resources
Oct 14 08:48:18 server ACPI: Interpreter enabled
Oct 14 08:48:18 server ACPI: Using PIC for interrupt routing
Oct 14 08:48:18 server ACPI: PCI Root Bridge [PCI0] (0000:00)
Oct 14 08:48:18 server PCI: Probing PCI hardware (bus 00)
Oct 14 08:48:18 server Boot video device is 0000:01:00.0
Oct 14 08:48:18 server ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Oct 14 08:48:18 server ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
Oct 14 08:48:18 server ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P7._PRT]
Oct 14 08:48:18 server ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P7.P7P9._PRT]
Oct 14 08:48:18 server ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P7.P7P8._PRT]
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7
10 *11 12 14 15)
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7
*10 11 12 14 15)
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7
10 11 12 14 15)
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7
10 11 12 14 15)
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7
10 11 12 14 15) *0, disabled.
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7
10 11 12 14 15) *0, disabled.
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7
10 11 12 14 15) *0, disabled.
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7
10 11 12 14 15) *0, disabled.
Oct 14 08:48:18 server Linux Plug and Play Support v0.97 (c) Adam Belay
Oct 14 08:48:18 server pnp: PnP ACPI init
Oct 14 08:48:18 server pnp: PnP ACPI: found 13 devices
Oct 14 08:48:18 server SCSI subsystem initialized
Oct 14 08:48:18 server usbcore: registered new interface driver usbfs
Oct 14 08:48:18 server usbcore: registered new interface driver hub
Oct 14 08:48:18 server usbcore: registered new device driver usb
Oct 14 08:48:18 server PCI: Using ACPI for IRQ routing
Oct 14 08:48:18 server PCI: If a device doesn't work, try
"pci=routeirq".  If it helps, post a report
Oct 14 08:48:18 server pnp: 00:07: ioport range 0x290-0x297 has been
reserved
Oct 14 08:48:18 server PCI: Bridge: 0000:00:01.0
Oct 14 08:48:18 server IO window: disabled.
Oct 14 08:48:18 server MEM window: fca00000-feafffff
Oct 14 08:48:18 server PREFETCH window: cff00000-d7efffff
Oct 14 08:48:18 server PCI: Bridge: 0000:02:00.0
Oct 14 08:48:18 server IO window: disabled.
Oct 14 08:48:18 server MEM window: disabled.
Oct 14 08:48:18 server PREFETCH window: disabled.
Oct 14 08:48:18 server PCI: Bridge: 0000:02:00.1
Oct 14 08:48:18 server IO window: disabled.
Oct 14 08:48:18 server MEM window: disabled.
Oct 14 08:48:18 server PREFETCH window: disabled.
Oct 14 08:48:18 server PCI: Bridge: 0000:00:13.0
Oct 14 08:48:18 server IO window: disabled.
Oct 14 08:48:18 server MEM window: disabled.
Oct 14 08:48:18 server PREFETCH window: disabled.
Oct 14 08:48:18 server PCI: Setting latency timer of device 0000:00:01.0
to 64
Oct 14 08:48:18 server PCI: Setting latency timer of device 0000:00:13.0
to 64
Oct 14 08:48:18 server PCI: Setting latency timer of device 0000:02:00.0
to 64
Oct 14 08:48:18 server PCI: Setting latency timer of device 0000:02:00.1
to 64
Oct 14 08:48:18 server NET: Registered protocol family 2
Oct 14 08:48:18 server IP route cache hash table entries: 4096 (order:
2, 16384 bytes)
Oct 14 08:48:18 server TCP established hash table entries: 16384 (order:
4, 65536 bytes)
Oct 14 08:48:18 server TCP bind hash table entries: 8192 (order: 3,
32768 bytes)
Oct 14 08:48:18 server TCP: Hash tables configured (established 16384
bind 8192)
Oct 14 08:48:18 server TCP reno registered
Oct 14 08:48:18 server Machine check exception polling timer started.
Oct 14 08:48:18 server audit: initializing netlink socket (disabled)
Oct 14 08:48:18 server audit(1160815666.396:1): initialized
Oct 14 08:48:18 server Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Oct 14 08:48:18 server io scheduler noop registered
Oct 14 08:48:18 server io scheduler anticipatory registered (default)
Oct 14 08:48:18 server io scheduler deadline registered
Oct 14 08:48:18 server io scheduler cfq registered
Oct 14 08:48:18 server ACPI: Power Button (FF) [PWRF]
Oct 14 08:48:18 server ACPI: Sleep Button (CM) [SLPB]
Oct 14 08:48:18 server ACPI: Power Button (CM) [PWRB]
Oct 14 08:48:18 server ACPI: Processor [CPU1] (supports 16 throttling
states)
Oct 14 08:48:18 server ACPI: Getting cpuindex for acpiid 0x2
Oct 14 08:48:18 server Serial: 8250/16550 driver $Revision: 1.90 $ 4
ports, IRQ sharing disabled
Oct 14 08:48:18 server serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a
16550A
Oct 14 08:48:18 server 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Oct 14 08:48:18 server Floppy drive(s): fd0 is 1.44M
Oct 14 08:48:18 server FDC 0 is a post-1991 82077
Oct 14 08:48:18 server via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by
Donald Becker
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Oct 14 08:48:18 server PCI: setting IRQ 11 as level-triggered
Oct 14 08:48:18 server ACPI: PCI Interrupt 0000:00:12.0[A] -> Link
[LNKA] -> GSI 11 (level, low) -> IRQ 11
Oct 14 08:48:18 server eth0: VIA Rhine II at 0xfebff000,
00:13:d4:a7:82:e5, IRQ 11.
Oct 14 08:48:18 server eth0: MII PHY found at address 1, status 0x786d
advertising 01e1 Link 41e1.
Oct 14 08:48:18 server Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
Oct 14 08:48:18 server ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Oct 14 08:48:18 server VP_IDE: IDE controller at PCI slot 0000:00:0f.1
Oct 14 08:48:18 server PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to
0
Oct 14 08:48:18 server VP_IDE: chipset revision 7
Oct 14 08:48:18 server VP_IDE: not 100% native mode: will probe irqs
later
Oct 14 08:48:18 server VP_IDE: VIA vt8251 (rev 00) IDE UDMA133
controller on pci0000:00:0f.1
Oct 14 08:48:18 server ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings:
hda:pio, hdb:DMA
Oct 14 08:48:18 server ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings:
hdc:DMA, hdd:pio
Oct 14 08:48:18 server Probing IDE interface ide0...
Oct 14 08:48:18 server hdb: Pioneer DVD-ROM ATAPIModel DVD-104S 012,
ATAPI CD/DVD-ROM drive
Oct 14 08:48:18 server ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 14 08:48:18 server Probing IDE interface ide1...
Oct 14 08:48:18 server hdc: ST3160021A, ATA DISK drive
Oct 14 08:48:18 server ide1 at 0x170-0x177,0x376 on irq 15
Oct 14 08:48:18 server hdc: max request size: 512KiB
Oct 14 08:48:18 server hdc: 312581808 sectors (160041 MB) w/2048KiB
Cache, CHS=19457/255/63, UDMA(100)
Oct 14 08:48:18 server hdc: cache flushes supported
Oct 14 08:48:18 server hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 hdc9 >
Oct 14 08:48:18 server hdb: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Oct 14 08:48:18 server Uniform CD-ROM driver Revision: 3.20
Oct 14 08:48:18 server libata version 2.00 loaded.
Oct 14 08:48:18 server ahci 0000:00:0f.0: version 2.0
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Oct 14 08:48:18 server PCI: setting IRQ 10 as level-triggered
Oct 14 08:48:18 server ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Oct 14 08:48:18 server ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4
ports 3 Gbps 0xf impl SATA mode
Oct 14 08:48:18 server ahci 0000:00:0f.0: flags: 64bit ncq pm led clo
pmp pio slum part
Oct 14 08:48:18 server ata1: SATA max UDMA/133 cmd 0xE0006D00 ctl 0x0
bmdma 0x0 irq 10
Oct 14 08:48:18 server ata2: SATA max UDMA/133 cmd 0xE0006D80 ctl 0x0
bmdma 0x0 irq 10
Oct 14 08:48:18 server ata3: SATA max UDMA/133 cmd 0xE0006E00 ctl 0x0
bmdma 0x0 irq 10
Oct 14 08:48:18 server ata4: SATA max UDMA/133 cmd 0xE0006E80 ctl 0x0
bmdma 0x0 irq 10
Oct 14 08:48:18 server scsi0 : ahci
Oct 14 08:48:18 server ata1: SATA link up 3.0 Gbps (SStatus 123 SControl
300)
Oct 14 08:48:18 server ata1.00: ATA-7, max UDMA/133, 156301488 sectors:
LBA48 NCQ (depth 0/32)
Oct 14 08:48:18 server ata1.00: ata1: dev 0 multi count 16
Oct 14 08:48:18 server ata1.00: configured for UDMA/133
Oct 14 08:48:18 server scsi1 : ahci
Oct 14 08:48:18 server ata2: SATA link down (SStatus 0 SControl 300)
Oct 14 08:48:18 server scsi2 : ahci
Oct 14 08:48:18 server ata3: SATA link down (SStatus 0 SControl 300)
Oct 14 08:48:18 server scsi3 : ahci
Oct 14 08:48:18 server ata4: SATA link down (SStatus 0 SControl 300)
Oct 14 08:48:18 server scsi 0:0:0:0: Direct-Access     ATA
ST3808110AS      3.AA PQ: 0 ANSI: 5
Oct 14 08:48:18 server SCSI device sda: 156301488 512-byte hdwr sectors
(80026 MB)
Oct 14 08:48:18 server sda: Write Protect is off
Oct 14 08:48:18 server sda: Mode Sense: 00 3a 00 00
Oct 14 08:48:18 server SCSI device sda: drive cache: write back
Oct 14 08:48:18 server SCSI device sda: 156301488 512-byte hdwr sectors
(80026 MB)
Oct 14 08:48:18 server sda: Write Protect is off
Oct 14 08:48:18 server sda: Mode Sense: 00 3a 00 00
Oct 14 08:48:18 server SCSI device sda: drive cache: write back
Oct 14 08:48:18 server sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Oct 14 08:48:18 server sd 0:0:0:0: Attached scsi disk sda
Oct 14 08:48:18 server sd 0:0:0:0: Attached scsi generic sg0 type 0
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Oct 14 08:48:18 server PCI: setting IRQ 5 as level-triggered
Oct 14 08:48:18 server ACPI: PCI Interrupt 0000:00:10.4[C] -> Link
[LNKC] -> GSI 5 (level, low) -> IRQ 5
Oct 14 08:48:18 server ehci_hcd 0000:00:10.4: EHCI Host Controller
Oct 14 08:48:18 server ehci_hcd 0000:00:10.4: new USB bus registered,
assigned bus number 1
Oct 14 08:48:18 server ehci_hcd 0000:00:10.4: debug port 1
Oct 14 08:48:18 server ehci_hcd 0000:00:10.4: irq 5, io mem 0xfebff400
Oct 14 08:48:18 server ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI
1.00, driver 10 Dec 2004
Oct 14 08:48:18 server usb usb1: configuration #1 chosen from 1 choice
Oct 14 08:48:18 server hub 1-0:1.0: USB hub found
Oct 14 08:48:18 server hub 1-0:1.0: 8 ports detected
Oct 14 08:48:18 server USB Universal Host Controller Interface driver
v3.0
Oct 14 08:48:18 server ACPI: PCI Interrupt 0000:00:10.0[A] -> Link
[LNKA] -> GSI 11 (level, low) -> IRQ 11
Oct 14 08:48:18 server uhci_hcd 0000:00:10.0: UHCI Host Controller
Oct 14 08:48:18 server uhci_hcd 0000:00:10.0: new USB bus registered,
assigned bus number 2
Oct 14 08:48:18 server uhci_hcd 0000:00:10.0: irq 11, io base 0x0000e000
Oct 14 08:48:18 server usb usb2: configuration #1 chosen from 1 choice
Oct 14 08:48:18 server hub 2-0:1.0: USB hub found
Oct 14 08:48:18 server hub 2-0:1.0: 2 ports detected
Oct 14 08:48:18 server ACPI: PCI Interrupt 0000:00:10.1[C] -> Link
[LNKC] -> GSI 5 (level, low) -> IRQ 5
Oct 14 08:48:18 server uhci_hcd 0000:00:10.1: UHCI Host Controller
Oct 14 08:48:18 server uhci_hcd 0000:00:10.1: new USB bus registered,
assigned bus number 3
Oct 14 08:48:18 server uhci_hcd 0000:00:10.1: irq 5, io base 0x0000dc00
Oct 14 08:48:18 server usb usb3: configuration #1 chosen from 1 choice
Oct 14 08:48:18 server hub 3-0:1.0: USB hub found
Oct 14 08:48:18 server hub 3-0:1.0: 2 ports detected
Oct 14 08:48:18 server ACPI: PCI Interrupt 0000:00:10.2[B] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Oct 14 08:48:18 server uhci_hcd 0000:00:10.2: UHCI Host Controller
Oct 14 08:48:18 server uhci_hcd 0000:00:10.2: new USB bus registered,
assigned bus number 4
Oct 14 08:48:18 server uhci_hcd 0000:00:10.2: irq 10, io base 0x0000d880
Oct 14 08:48:18 server usb usb4: configuration #1 chosen from 1 choice
Oct 14 08:48:18 server hub 4-0:1.0: USB hub found
Oct 14 08:48:18 server hub 4-0:1.0: 2 ports detected
Oct 14 08:48:18 server ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
Oct 14 08:48:18 server PCI: setting IRQ 3 as level-triggered
Oct 14 08:48:18 server ACPI: PCI Interrupt 0000:00:10.3[D] -> Link
[LNKD] -> GSI 3 (level, low) -> IRQ 3
Oct 14 08:48:18 server uhci_hcd 0000:00:10.3: UHCI Host Controller
Oct 14 08:48:18 server uhci_hcd 0000:00:10.3: new USB bus registered,
assigned bus number 5
Oct 14 08:48:18 server uhci_hcd 0000:00:10.3: irq 3, io base 0x0000d800
Oct 14 08:48:18 server usb usb5: configuration #1 chosen from 1 choice
Oct 14 08:48:18 server hub 5-0:1.0: USB hub found
Oct 14 08:48:18 server hub 5-0:1.0: 2 ports detected
Oct 14 08:48:18 server Initializing USB Mass Storage driver...
Oct 14 08:48:18 server usbcore: registered new interface driver
usb-storage
Oct 14 08:48:18 server USB Mass Storage support registered.
Oct 14 08:48:18 server PNP: No PS/2 controller found. Probing ports
directly.
Oct 14 08:48:18 server serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 14 08:48:18 server serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 14 08:48:18 server mice: PS/2 mouse device common for all mice
Oct 14 08:48:18 server input: PC Speaker as /class/input/input0
Oct 14 08:48:18 server ip_conntrack version 2.4 (4029 buckets, 32232
max) - 212 bytes per conntrack
Oct 14 08:48:18 server TCP cubic registered
Oct 14 08:48:18 server NET: Registered protocol family 1
Oct 14 08:48:18 server NET: Registered protocol family 17
Oct 14 08:48:18 server Using IPI Shortcut mode
Oct 14 08:48:18 server ACPI: (supports S0 S1 S3 S4 S5)
Oct 14 08:48:18 server Time: tsc clocksource has been installed.
<snip> FS mount - dmesg </snip>
Oct 14 08:48:18 server ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Oct 14 08:48:18 server 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html
Oct 14 08:48:18 server 0000:00:0c.0: 3Com PCI 3c905B Cyclone 100baseTx
at e00c0800.
<snip> FS mount - dmesg </snip>

The dmesg when turning the drive on/of is already posted

Spurious part:

Oct 18 06:34:34 server xinetd[5919]: START: vmware-authd pid=19719
from=xx.xx.xx.xx
Oct 18 06:34:34 server vmware-authd[19719]: login from xx.xx.xx.xx as
aalderd
Oct 18 06:34:35 server spurious 8259A interrupt: IRQ7.
Oct 18 06:34:36 server xinetd[5919]: EXIT: vmware-authd status=0
pid=19719 duration=2(sec)
Oct 18 06:34:52 server vmware-authd[19752]: The
"/opt/vmware/server/lib/bin/vmware-vmx" process did not start properly.
Exit 0x100
Oct 18 06:35:05 server vmware-authd[19766]: The
"/opt/vmware/server/lib/bin/vmware-vmx" process did not start properly.
Exit 0x100
Oct 18 06:36:23 server vmware-authd[19770]: The
"/opt/vmware/server/lib/bin/vmware-vmx" process did not start properly.
Exit 0x100

As you see it happened when I start a vmware-server-session.
The vmware-server-session failed due the missed vmware-modules by the
way.

Aalderd
On Wed, 2006-10-18 at 20:50 +0900, Tejun Heo wrote:
> Aalderd Bouwman wrote:
> > Hello Tejun,
> > 
> > I now have received the message in dmesg:
> > spurious 8259A interrupt: IRQ7.
> > 
> > What does it mean? And is it a problem for the properly working of the
> > system?
> 
> Can you post full dmesg?
> 

