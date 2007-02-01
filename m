From: juergen.metzdorf@telelev-dsl.de
Subject: Problem: 2.6.20-rc7 sata_via: SATA-DVD-Writer doesn't work
	properly
Date: Thu, 01 Feb 2007 19:22:31 +0100
Message-ID: <20070201192231.xhwd8k5t4wg8w4sk@webmail.citykom.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_2anq9yw0qc5c"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from muemailf.citykom.de ([195.202.32.14]:62759 "EHLO
	muemailf.citykom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422924AbXBAS3Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 13:29:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

This message is in MIME format.

--=_2anq9yw0qc5c
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hello,

I'm experiencing problems with an SATA-DVD-Writer (Samsung SH-S183a) connected
to a VIA8237 motherboard chipset. As you can see in the attached boot.log, the
system is reducing the DMA-Mode from DMA33 to DMA25 then to DMA16 to end up as
PIO4. As a result the dvds that are written are corrupt. During the writing
process the messages log shows repeating entries like this:

ata2.00: 2 bytes trailing data

Tried kernel: 2.6.18.2 (suse 10.2 default), 2.6.19.2 and 2.6.20-rc6.

The dvd writer is checked ok by using it on the same machine with an different
OS (WinXP).

Thanx in advance for any help!

Juergen Metzdorf
--=_2anq9yw0qc5c
Content-Type: text/plain;
	charset=iso-8859-1;
	name="boot.msg"
Content-Disposition: attachment;
	filename="boot.msg"
Content-Transfer-Encoding: 7bit

Cannot find map file.

No module symbols loaded - kernel modules not enabled.



Cannot build symbol table - disabling symbol lookups

klogd 1.4.1, log source = ksyslog started.

<5>Linux version 2.6.20-rc7-default (juergen@linux) (gcc version 4.0.2 20050901 (prerelease) (SUSE Linux)) #1 SMP Wed Jan 31 20:38:23 CET 2007

<6>BIOS-provided physical RAM map:

<4>sanitize start

<4>sanitize end

<4>copy_e820_map() start: 0000000000000000 size: 000000000009d800 end: 000000000009d800 type: 1

<4>copy_e820_map() type is E820_RAM

<4>copy_e820_map() start: 000000000009d800 size: 0000000000002800 end: 00000000000a0000 type: 2

<4>copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2

<4>copy_e820_map() start: 0000000000100000 size: 000000001fefb000 end: 000000001fffb000 type: 1

<4>copy_e820_map() type is E820_RAM

<4>copy_e820_map() start: 000000001fffb000 size: 0000000000004000 end: 000000001ffff000 type: 3

<4>copy_e820_map() start: 000000001ffff000 size: 0000000000001000 end: 0000000020000000 type: 4

<4>copy_e820_map() start: 00000000fec00000 size: 0000000000001000 end: 00000000fec01000 type: 2

<4>copy_e820_map() start: 00000000fee00000 size: 0000000000001000 end: 00000000fee01000 type: 2

<4>copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end: 0000000100000000 type: 2

<4> BIOS-e820: 0000000000000000 - 000000000009d800 (usable)

<4> BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)

<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)

<4> BIOS-e820: 0000000000100000 - 000000001fffb000 (usable)

<4> BIOS-e820: 000000001fffb000 - 000000001ffff000 (ACPI data)

<4> BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)

<4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)

<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)

<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)

<5>0MB HIGHMEM available.

<5>511MB LOWMEM available.

<7>Entering add_active_range(0, 0, 131067) 0 entries of 256 used

<4>Zone PFN ranges:

<4>  DMA             0 ->     4096

<4>  Normal       4096 ->   131067

<4>  HighMem    131067 ->   131067

<4>early_node_map[1] active PFN ranges

<4>    0:        0 ->   131067

<7>On node 0 totalpages: 131067

<7>  DMA zone: 32 pages used for memmap

<7>  DMA zone: 0 pages reserved

<7>  DMA zone: 4064 pages, LIFO batch:0

<7>  Normal zone: 991 pages used for memmap

<7>  Normal zone: 125980 pages, LIFO batch:31

<7>  HighMem zone: 0 pages used for memmap

<6>DMI 2.3 present.

<6>Using APIC driver default

<7>ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5e30

<7>ACPI: RSDT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffb000

<7>ACPI: FADT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffb0b2

<7>ACPI: BOOT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffb030

<7>ACPI: MADT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffb058

<7>ACPI: DSDT (v001   ASUS A7V600   0x00001000 MSFT 0x0100000b) @ 0x00000000

<6>ACPI: PM-Timer IO Port: 0xe408

<7>ACPI: Local APIC address 0xfee00000

<6>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)

<4>Processor #0 6:10 APIC version 16

<6>ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])

<6>ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])

<4>IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23

<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)

<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)

<7>ACPI: IRQ0 used by override.

<7>ACPI: IRQ2 used by override.

<7>ACPI: IRQ9 used by override.

<4>Enabling APIC mode:  Flat.  Using 1 I/O APICs

<6>Using ACPI (MADT) for SMP configuration information

<4>Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)

<4>Detected 1822.656 MHz processor.

<4>Built 1 zonelists.  Total pages: 130044

<5>Kernel command line: root=/dev/sdb3 vga=0x31a resume=/dev/sdb2 splash=silent

<7>mapped APIC to ffffd000 (fee00000)

<7>mapped IOAPIC to ffffc000 (fec00000)

<6>Enabling fast FPU save and restore... done.

<6>Enabling unmasked SIMD FPU exception support... done.

<6>Initializing CPU#0

<4>PID hash table entries: 2048 (order: 11, 8192 bytes)

<4>Console: colour dummy device 80x25

<4>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)

<4>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)

<6>Memory: 512936k/524268k available (1718k kernel code, 10788k reserved, 718k data, 192k init, 0k highmem)

<4>virtual kernel memory layout:

<4>    fixmap  : 0xffe16000 - 0xfffff000   (1956 kB)

<4>    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)

<4>    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)

<4>    lowmem  : 0xc0000000 - 0xdfffb000   ( 511 MB)

<4>      .init : 0xc0368000 - 0xc0398000   ( 192 kB)

<4>      .data : 0xc02ada6f - 0xc0361330   ( 718 kB)

<4>      .text : 0xc0100000 - 0xc02ada6f   (1718 kB)

<4>Checking if this processor honours the WP bit even in supervisor mode... Ok.

<4>Calibrating delay using timer specific routine.. 3648.37 BogoMIPS (lpj=7296746)

<6>Security Framework v1.0.0 initialized

<4>Mount-cache hash table entries: 512

<7>CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000

<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)

<6>CPU: L2 Cache: 512K (64 bytes/line)

<7>CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000

<6>Intel machine check architecture supported.

<6>Intel machine check reporting enabled on CPU#0.

<4>Compat vDSO mapped to ffffe000.

<6>Checking 'hlt' instruction... OK.

<6>SMP alternatives: switching to UP code

<6>Freeing SMP alternatives: 12k freed

<6>ACPI: Core revision 20060707

<4>CPU0: AMD Athlon(TM) XP 2500+ stepping 00

<6>Total of 1 processors activated (3648.37 BogoMIPS).

<4>ENABLING IO-APIC IRQs

<6>..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1

<6>Brought up 1 CPUs

<6>NET: Registered protocol family 16

<6>ACPI: bus type pci registered

<6>PCI: PCI BIOS revision 2.10 entry at 0xf1970, last bus=1

<6>PCI: Using configuration type 1

<4>Setting up standard PCI resources

<6>ACPI: Interpreter enabled

<6>ACPI: Using IOAPIC for interrupt routing

<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)

<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.

<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.

<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.

<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 *7 9 10 11 12)

<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *7 9 10 11 12)

<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12)

<4>ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12) *15, disabled.

<6>ACPI: PCI Root Bridge [PCI0] (0000:00)

<7>PCI: Probing PCI hardware (bus 00)

<6>ACPI: Assume root bridge [\_SB_.PCI0] bus is 0

<6>PCI: enabled onboard AC97/MC97 devices

<7>Boot video device is 0000:01:00.0

<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]

<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]

<6>Linux Plug and Play Support v0.97 (c) Adam Belay

<6>pnp: PnP ACPI init

<6>pnp: PnP ACPI: found 12 devices

<6>PnPBIOS: Disabled by ACPI PNP

<6>PCI: Using ACPI for IRQ routing

<6>PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report

<6>pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved

<6>pnp: 00:02: ioport range 0xe800-0xe81f has been reserved

<6>pnp: 00:0b: ioport range 0x290-0x297 has been reserved

<6>pnp: 00:0b: ioport range 0x370-0x375 has been reserved

<6>PCI: Bridge: 0000:00:01.0

<6>  IO window: d000-dfff

<6>  MEM window: bf000000-bfffffff

<6>  PREFETCH window: c0000000-efffffff

<7>PCI: Setting latency timer of device 0000:00:01.0 to 64

<6>NET: Registered protocol family 2

<4>IP route cache hash table entries: 4096 (order: 2, 16384 bytes)

<4>TCP established hash table entries: 16384 (order: 5, 131072 bytes)

<4>TCP bind hash table entries: 8192 (order: 4, 65536 bytes)

<6>TCP: Hash tables configured (established 16384 bind 8192)

<6>TCP reno registered

<6>checking if image is initramfs... it is

<6>Freeing initrd memory: 3224k freed

<6>Simple Boot Flag at 0x3a set to 0x1

<6>Machine check exception polling timer started.

<6>apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)

<5>apm: overridden by ACPI.

<6>audit: initializing netlink socket (disabled)

<5>audit(1170277571.716:1): initialized

<4>Total HugeTLB memory allocated, 0

<5>VFS: Disk quotas dquot_6.5.1

<4>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)

<6>io scheduler noop registered

<6>io scheduler anticipatory registered

<6>io scheduler deadline registered

<6>io scheduler cfq registered (default)

<6>PCI: Bypassing VIA 8237 APIC De-Assert Message

<6>vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 5120k, total 262144k

<6>vesafb: mode is 1280x1024x16, linelength=2560, pages=101

<6>vesafb: protected mode interface info at c000:57cf

<6>vesafb: pmi: set display start = c00c5863, set palette = c00c58af

<6>vesafb: pmi: ports = d810 d816 d854 d838 d83c d85c d800 d804 d8b0 d8b2 d8b4 

<6>vesafb: scrolling: redraw

<6>vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0

<4>Console: switching to colour frame buffer device 160x64

<6>fb0: VESA VGA frame buffer device

<6>isapnp: Scanning for PnP cards...

<6>isapnp: No Plug & Play device found

<6>Real Time Clock Driver v1.12ac

<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled

<6>serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

<6>serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

<6>00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

<6>00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

<4>floppy0: no floppy controllers found

<4>RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize

<6>PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1

<4>PNP: PS/2 controller doesn't have AUX irq; using default 12

<6>serio: i8042 KBD port at 0x60,0x64 irq 1

<6>serio: i8042 AUX port at 0x60,0x64 irq 12

<6>mice: PS/2 mouse device common for all mice

<6>input: AT Translated Set 2 keyboard as /class/input/input0

<6>input: PC Speaker as /class/input/input1

<6>NET: Registered protocol family 1

<4>Using IPI No-Shortcut mode

<6>ACPI: (supports S0 S1 S4 S5)

<6>Freeing unused kernel memory: 192k freed

<6>Time: tsc clocksource has been installed.

<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

<5>SCSI subsystem initialized

<7>libata version 2.00 loaded.

<7>sata_via 0000:00:0f.0: version 2.0

<6>ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 16

<6>sata_via 0000:00:0f.0: routed to hard irq line 0

<6>ata1: SATA max UDMA/133 cmd 0xB800 ctl 0xB402 bmdma 0xA400 irq 16

<6>ata2: SATA max UDMA/133 cmd 0xB000 ctl 0xA802 bmdma 0xA408 irq 16

<6>scsi0 : sata_via

<6>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

<4>ATA: abnormal status 0x7F on port 0xB807

<4>ATA: abnormal status 0x7F on port 0xB807

<6>ata1.00: ATA-7, max UDMA7, 312581808 sectors: LBA48 

<6>ata1.00: ata1: dev 0 multi count 16

<6>ata1.00: configured for UDMA/133

<6>scsi1 : sata_via

<6>ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

<4>ATA: abnormal status 0x7F on port 0xB007

<4>ATA: abnormal status 0x7F on port 0xB007

<6>ata2.00: ATAPI, max UDMA/33

<6>ata2.00: configured for UDMA/33

<5>scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SP1614C  SW10 PQ: 0 ANSI: 5

<5>SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)

<5>sda: Write Protect is off

<7>sda: Mode Sense: 00 3a 00 00

<5>SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

<5>SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)

<5>sda: Write Protect is off

<7>sda: Mode Sense: 00 3a 00 00

<5>SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

<6> sda: sda1 sda2

<5>sd 0:0:0:0: Attached scsi disk sda

<5>scsi 1:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183A SB02 PQ: 0 ANSI: 5

<7>pata_via 0000:00:0f.1: version 0.2.0

<6>ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 16

<6>ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x9800 irq 14

<5>sd 0:0:0:0: Attached scsi generic sg0 type 0

<5>sr 1:0:0:0: Attached scsi generic sg1 type 5

<4>sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray

<6>Uniform CD-ROM driver Revision: 3.20

<7>sr 1:0:0:0: Attached scsi CD-ROM sr0

<6>ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x9808 irq 15

<6>scsi2 : pata_via

<6>ata3.00: ATA-5, max UDMA/100, 90069840 sectors: LBA 

<6>ata3.00: ata3: dev 0 multi count 16

<6>ata3.00: configured for UDMA/100

<6>scsi3 : pata_via

<4>ATA: abnormal status 0x7F on port 0x177

<4>ATA: abnormal status 0x7F on port 0x177

<6>ata4.01: ATAPI, max UDMA/33

<6>ata4.01: configured for UDMA/33

<5>scsi 2:0:0:0: Direct-Access     ATA      IBM-DTLA-307045  TX6O PQ: 0 ANSI: 5

<5>SCSI device sdb: 90069840 512-byte hdwr sectors (46116 MB)

<5>sdb: Write Protect is off

<7>sdb: Mode Sense: 00 3a 00 00

<5>SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

<5>SCSI device sdb: 90069840 512-byte hdwr sectors (46116 MB)

<5>sdb: Write Protect is off

<7>sdb: Mode Sense: 00 3a 00 00

<5>SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

<6> sdb: sdb1 sdb2 sdb3

<5>sd 2:0:0:0: Attached scsi disk sdb

<5>sd 2:0:0:0: Attached scsi generic sg2 type 0

<5>scsi 3:0:1:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1502 1012 PQ: 0 ANSI: 5

<4>sr1: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray

<7>sr 3:0:1:0: Attached scsi CD-ROM sr1

<5>sr 3:0:1:0: Attached scsi generic sg3 type 5

<6>BIOS EDD facility v0.16 2004-Jun-25, 2 devices found

<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen

<3>ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in

<4>         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)

<6>ata2: soft resetting port

<4>ATA: abnormal status 0x7F on port 0xB007

<4>ATA: abnormal status 0x7F on port 0xB007

<6>ata2.00: configured for UDMA/33

<6>ata2: EH complete

<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen

<3>ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in

<4>         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)

<6>ata2: soft resetting port

<4>ATA: abnormal status 0x7F on port 0xB007

<4>ATA: abnormal status 0x7F on port 0xB007

<6>ata2.00: configured for UDMA/33

<6>ata2: EH complete

<4>Attempting manual resume

<6>kjournald starting.  Commit interval 5 seconds

<6>EXT3 FS on sdb3, internal journal

<6>EXT3-fs: mounted filesystem with ordered data mode.

<6>usbcore: registered new interface driver usbfs

<6>usbcore: registered new interface driver hub

<6>usbcore: registered new device driver usb

<6>Linux agpgart interface v0.101 (c) Dave Jones

<6>ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 17

<6>ehci_hcd 0000:00:10.4: EHCI Host Controller

<6>ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1

<6>ehci_hcd 0000:00:10.4: irq 17, io mem 0xbe000000

<6>ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004

<6>usb usb1: configuration #1 chosen from 1 choice

<6>hub 1-0:1.0: USB hub found

<6>hub 1-0:1.0: 8 ports detected

<6>pci_hotplug: PCI Hot Plug PCI Core version: 0.5

<6>agpgart: Detected VIA KT400/KT400A/KT600 chipset

<6>agpgart: AGP aperture is 128M @ 0xf0000000

<6>USB Universal Host Controller Interface driver v3.0

<6>ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 17

<6>uhci_hcd 0000:00:10.0: UHCI Host Controller

<6>uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2

<6>uhci_hcd 0000:00:10.0: irq 17, io base 0x00009400

<6>usb usb2: configuration #1 chosen from 1 choice

<6>hub 2-0:1.0: USB hub found

<6>hub 2-0:1.0: 2 ports detected

<6>ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 17

<6>uhci_hcd 0000:00:10.1: UHCI Host Controller

<6>uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3

<6>uhci_hcd 0000:00:10.1: irq 17, io base 0x00009000

<6>usb usb3: configuration #1 chosen from 1 choice

<6>hub 3-0:1.0: USB hub found

<6>hub 3-0:1.0: 2 ports detected

<6>ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 17

<6>uhci_hcd 0000:00:10.2: UHCI Host Controller

<6>uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4

<6>uhci_hcd 0000:00:10.2: irq 17, io base 0x00008800

<6>usb usb4: configuration #1 chosen from 1 choice

<6>hub 4-0:1.0: USB hub found

<6>hub 4-0:1.0: 2 ports detected

<6>ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 17

<6>uhci_hcd 0000:00:10.3: UHCI Host Controller

<6>uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5

<6>uhci_hcd 0000:00:10.3: irq 17, io base 0x00008400

<6>usb usb5: configuration #1 chosen from 1 choice

<6>hub 5-0:1.0: USB hub found

<6>hub 5-0:1.0: 2 ports detected

<6>usb 2-2: new low speed USB device using uhci_hcd and address 2

<6>shpchp: Standard Hot Plug PCI Controller Driver version: 0.4

<6>ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 18

<7>PCI: Setting latency timer of device 0000:00:11.5 to 64

<6>usb 2-2: configuration #1 chosen from 1 choice

<3>ALSA sound/pci/via82xx.c:581: codec_read: codec 0 is not valid [0xfe0000]

<3>ALSA sound/pci/via82xx.c:581: codec_read: codec 0 is not valid [0xfe0000]

<3>ALSA sound/pci/via82xx.c:581: codec_read: codec 0 is not valid [0xfe0000]

<3>ALSA sound/pci/via82xx.c:581: codec_read: codec 0 is not valid [0xfe0000]

<6>usbcore: registered new interface driver hiddev

<6>input: PS/2+USB Mouse as /class/input/input2

<6>input: USB HID v1.11 Mouse [PS/2+USB Mouse] on usb-0000:00:10.0-2

<6>usbcore: registered new interface driver usbhid

<6>drivers/usb/input/hid-core.c: v2.6:USB HID core driver

<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen

<3>ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in

<4>         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)

<6>ata2: soft resetting port

<4>ATA: abnormal status 0x7F on port 0xB007

<4>ATA: abnormal status 0x7F on port 0xB007

<6>ata2.00: configured for UDMA/33

<6>ata2: EH complete

<4>ata2.00: limiting speed to UDMA/25

<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen

<3>ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in

<4>         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)

<6>ata2: soft resetting port

<4>ATA: abnormal status 0x7F on port 0xB007

<4>ATA: abnormal status 0x7F on port 0xB007

<6>ata2.00: configured for UDMA/25

<6>ata2: EH complete

<3>sr0: CDROM (ioctl) error, command: <6>Read TOC/PMA/ATIP 43 00 00 00 00 00 00 00 0c 40

<6>sr: Current [descriptor]: sense key: Aborted Command

<6>    Additional sense: No additional sense information

<4>ata2.00: limiting speed to UDMA/16

<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen

<3>ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in

<4>         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)

<6>ata2: soft resetting port

<4>ATA: abnormal status 0x7F on port 0xB007

<4>ATA: abnormal status 0x7F on port 0xB007

<6>ata2.00: configured for UDMA/16

<6>ata2: EH complete

<4>ata2.00: limiting speed to PIO4

<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen

<3>ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in

<4>         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)

<6>ata2: soft resetting port

<4>ATA: abnormal status 0x7F on port 0xB007

<4>ATA: abnormal status 0x7F on port 0xB007

<6>ata2.00: configured for PIO4

<6>ata2: EH complete

<6>device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com

<6>loop: loaded (max 8 devices)

<6>NTFS driver 2.1.28 [Flags: R/W MODULE].

Kernel logging (ksyslog) stopped.

Kernel log daemon terminating.



Boot logging started on /dev/tty1(/dev/console) at Wed Jan 31 21:06:15 2007



Trying manual resume from /dev/sdb2

Creating device nodes with udev

Loading ide-core

Loading ide-disk

Loading scsi_mod

Loading sd_mod

Loading processor

Loading thermal

Loading libata

Loading sata_via

Loading pata_via

Loading via82cxxx

Loading fan

Loading edd

Loading jbd

Loading mbcache

Loading ext3

Invoking userspace resume from /dev/sdb2

resume: Could not stat configuration file

resume: libgcrypt version: 1.2.3

resume: Could not read the image

Invoking in-kernel resume from /dev/sdb2

Waiting for device /dev/sdb3 to appear:  ok

showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel

fsck 1.39 (29-May-2006)

[/bin/fsck.ext3 (1) -- /] fsck.ext3 -a -C0 /dev/sdb3 

/dev/sdb3: clean, 321475/2801664 files, 1696640/5592620 blocks

fsck succeeded. Mounting root device read-write.

Mounting root /dev/sdb3



Boot logging started on /dev/tty1(/dev/console) at Wed Jan 31 21:09:34 2007



Master Resource Control: previous runlevel: N, switching to runlevel: 5

FATAL: Module apparmor not found.

Loading AppArmor module failed

- could not start AppArmorfailed

<notice>startproc: execve (/sbin/acpid) [ /sbin/acpid ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/sbin/acpid ]

[acpid]: starting up





[acpid]: 0 rules loaded





done

acpid: loading ACPI modules ( ac battery button ) done

acpid: will not skip unsupported modules

acpid: loading ACPI laptop modules ( ) done

Starting acpid done

<notice>startproc: execve (/sbin/syslog-ng) [ /sbin/syslog-ng ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 TERM=linux SHELL=/bin/sh ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 SPLASHCFG= PWD=/ PREVLEVEL=N LINES=64 SHLVL=2 HOME=/ SPLASH=no splash=silent ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/sbin/syslog-ng ]

<notice>startproc: execve (/usr/bin/dbus-daemon) [ /usr/bin/dbus-daemon --system ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/usr/bin/dbus-daemon ]

<notice>startproc: execve (/sbin/klogd) [ /sbin/klogd -c 1 -x -x ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 TERM=linux SHELL=/bin/sh ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 SPLASHCFG= PWD=/ PREVLEVEL=N LINES=64 SHLVL=2 HOME=/ SPLASH=no splash=silent ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/sbin/klogd ]

Starting syslog servicesdone

Starting D-Bus daemondone

<notice>startproc: execve (/sbin/resmgrd) [ /sbin/resmgrd ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/sbin/resmgrd ]

Initializing random number generatordone

Starting resource managerdone

Starting irqbalance unused

<notice>startproc: execve (/usr/sbin/polkitd) [ /usr/sbin/polkitd ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/usr/sbin/polkitd ]

Starting PolicyKit daemondone

<notice>startproc: execve (/usr/sbin/hald) [ /usr/sbin/hald --daemon=yes ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/usr/sbin/hald ]

Starting HAL daemondone

Loading CPUFreq modules (CPUFreq not supported)

Loading keymap i386/qwertz/de-latin1-nodeadkeys.map.gz

doneLoading compose table latin1.adddone

Start Unicode mode

doneLoading console font lat9w-16.psfu  -m trivial G0:loadable

done<notice>startproc: execve (/usr/sbin/dhcdbd) [ /usr/sbin/dhcdbd --system ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 OLDPWD=/etc/sysconfig/network LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/sbin:/usr/sbin:/bin:/usr/bin:/etc/sysconfig/network/scripts vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/usr/sbin/dhcdbd ]

<notice>startproc: execve (/usr/sbin/NetworkManagerDispatcher) [ /usr/sbin/NetworkManagerDispatcher ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 OLDPWD=/etc/sysconfig/network LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/sbin:/usr/sbin:/bin:/usr/bin:/etc/sysconfig/network/scripts vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/usr/sbin/NetworkManagerDispatcher ]

<notice>startproc: execve (/usr/sbin/NetworkManager) [ /usr/sbin/NetworkManager ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 OLDPWD=/etc/sysconfig/network LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/sbin:/usr/sbin:/bin:/usr/bin:/etc/sysconfig/network/scripts vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/usr/sbin/NetworkManager ]

Starting the DHCP DBUS Daemondone

Starting the NetworkManagerDispatcherdone

Starting the NetworkManagerdone

<notice>startproc: execve (/sbin/portmap) [ /sbin/portmap ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/sbin/portmap ]

Starting RPC portmap daemondone

Importing Net File System (NFS)unused

<notice>startproc: execve (/sbin/auditd) [ /sbin/auditd -n ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/sbin/auditd ]

Checking/updating CPU microcode unused

Starting auditd done

Starting nfsboot (sm-notify) done

<notice>startproc: execve (/usr/sbin/nscd) [ /usr/sbin/nscd ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/usr/sbin/nscd ]

Starting Name Service Cache Daemondone

Starting ZENworks Management Daemondone

<notice>startproc: execve (/usr/sbin/sshd) [ /usr/sbin/sshd -o PidFile=/var/run/sshd.init.pid ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/usr/sbin/sshd ]

Starting SSH daemondone

<notice>startproc: execve (/usr/sbin/powersaved) [ /usr/sbin/powersaved -d -f /var/run/acpid.socket -v 3 ], [ HOME=/ PATH=/bin:/sbin:/usr/bin:/usr/sbin SHELL=/bin/sh RUNLEVEL=5 PREVLEVEL=N DAEMON=/usr/sbin/powersaved ]

Starting powersaved: done

Starting mail service (Postfix)done

<notice>startproc: execve (/usr/sbin/cron) [ /usr/sbin/cron ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/usr/sbin/cron ]

Starting CRON daemondone

Starting service kdm<notice>startproc: execve (/opt/kde3/bin/kdm) [ /opt/kde3/bin/kdm ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 TERM=linux SHELL=/bin/sh ROOTFS_FSCK=0 INIT_VERSION=sysvinit-2.86 KDEROOTHOME=/root/.kdm REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 SPLASHCFG= PWD=/ LANG=de_DE.UTF-8 PREVLEVEL=N LINES=64 QT_SYSTEM_DIR=/usr/share/desktop-data SHLVL=2 HOME=/ XCURSOR_THEME=crystalwhite WINDOWMANAGER=/usr/bin/kde SPLASH=no splash=silent ROOTFS_BLKDEV=/dev/sdb3 _=/sbin/startproc DAEMON=/opt/kde3/bin/kdm ]

done

<notice>startproc: execve (/usr/sbin/cupsd) [ /usr/sbin/cupsd ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=ext3 SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x31a RUNLEVEL=5 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sdb3 _=/usr/bin/ionice DAEMON=/usr/sbin/cupsd ]

Starting service kdmdone

Starting cupsddone

Master Resource Control: runlevel 5 has been reached

Skipped services in runlevel 5: irq_balancer nfs microcode splash

<notice>killproc: kill(2271,3)



Boot logging started on /dev/tty1(/dev/console) at Wed Jan 31 21:40:29 2007



Master Resource Control: previous runlevel: 5, switching to runlevel: 6

<notice>killproc: kill(2827,15)

<notice>killproc: kill(3057,15)

Shutting down auditd done

Shutting down CRON daemondone

Unloading AppArmor profiles - failed, is securityfs loaded?failed

<notice>killproc: kill(3140,15)

Shutting down irqbalance done

<notice>killproc: kill(2915,15)

Shutting down Name Service Cache Daemondone

<notice>killproc: kill(3040,15)

Shutting down mail service (Postfix)done

<notice>killproc: kill(2978,15)

Saving random seeddone

Shutting down cupsddone

<notice>killproc: kill(3013,15)

Shutting down powersaved done

<notice>killproc: kill(3105,15)

Shutting down SSH daemondone

Shutting down service kdmdone

Shutting down service kdmdone

/etc/init.d/kbd stopdone

Shutting down ZENworks Management Daemondone

Remove Net File System (NFS)unused

Shutting down RPC portmap daemon<notice>killproc: kill(2791,15)

done

Shutting down syslog services<notice>killproc: kill(2375,15)

<notice>killproc: kill(2371,15)

done

<notice>checkproc: /usr/sbin/NetworkManager 2728

Shutting down the NetworkManager<notice>killproc: kill(2728,15)

NetworkManager: <WARN>  nm_signal_handler(): Caught signal 15, shutting down normally.





NetworkManager: <info>  Caught terminiation signal





NetworkManager: <debug> [1170276034.512728] nm_print_open_socks(): Open Sockets List:





NetworkManager: <debug> [1170276034.512838] nm_print_open_socks(): Open Sockets List Done.





done

<notice>checkproc: /usr/sbin/dhcdbd 2714

Shutting down the DHCP DBUS Daemon<notice>killproc: kill(2714,15)

dhcdbd: Shut down.



done

<notice>checkproc: /usr/sbin/NetworkManagerDispatcher 2723

Shutting down the NetworkManagerDispatcher<notice>killproc: kill(2723,15)

done

Shutting down HAL daemon<notice>killproc: kill(2460,15)

done

Shutting down PolicyKit<notice>killproc: kill(2451,15)

done

<notice>killproc: kill(2346,15)

[acpid]: exiting





<notice>killproc: kill(2430,15)

<notice>killproc: kill(2436,15)

Shutting down acpid done

Shutting down resource managerdone

Shutting down D-Bus daemondone

Running /etc/init.d/halt.local

done<notice>killproc: kill(4351,3)

Sending all processes the TERM signal...

done


--=_2anq9yw0qc5c--
