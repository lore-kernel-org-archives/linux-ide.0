From: Bernd Schmidt <bernds_cb1@t-online.de>
Subject: Kernel slow to boot in 2.6.18
Date: Wed, 22 Nov 2006 21:40:10 +0100
Message-ID: <4564B5AA.60202@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020607020704020000040707"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout01.sul.t-online.com ([194.25.134.80]:27779 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1757019AbWKVUk0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Nov 2006 15:40:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020607020704020000040707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I just upgraded to 2.6.18.3 from 2.6.16.23, and the new kernel hangs for
a longish period during bootup.  I'm attaching a complete dmesg; here
are the relevant lines during which it becomes very slow:

ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA
ata2.00: ata2: dev 0 multi count 1
ata2.00: configured for UDMA/133
scsi2 : ahci

Googling showed that someone else had run into this before, but there
didn't seem to be a conclusion:
  http://uwsg.iu.edu/hypermail/linux/kernel/0611.1/2455.html

This is on an ASUS P5W-DH Deluxe mainboard, two SATA drives attached.
Not sure where /dev/sdb, the "Config Disk" is coming from; fdisk has the
following to say about it:
  Disk /dev/sdb: 0 MB, 327680 bytes
  255 heads, 63 sectors/track, 0 cylinders
  Units = cylinders of 16065 * 512 = 8225280 bytes

  Disk /dev/sdb doesn't contain a valid partition table

This was there in 2.6.16 already but never caused any problems.


Bernd

--------------020607020704020000040707
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.18-gentoo-r3 (root@beaker) (gcc version 4.1.1 (Gentoo 4.1.1-r1)) #1 SMP Wed Nov 22 16:08:34 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff80000 (usable)
 BIOS-e820: 000000007ff80000 - 000000007ff8e000 (ACPI data)
 BIOS-e820: 000000007ff8e000 - 000000007ffe0000 (ACPI NVS)
 BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 524160
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294784 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000faf40
ACPI: RSDT (v001 A M I  OEMRSDT  0x08000608 MSFT 0x00000097) @ 0x7ff80000
ACPI: FADT (v001 A M I  OEMFACP  0x08000608 MSFT 0x00000097) @ 0x7ff80200
ACPI: MADT (v001 A M I  OEMAPIC  0x08000608 MSFT 0x00000097) @ 0x7ff80390
ACPI: OEMB (v001 A M I  AMI_OEM  0x08000608 MSFT 0x00000097) @ 0x7ff8e040
ACPI: MCFG (v001 A M I  OEMMCFG  0x08000608 MSFT 0x00000097) @ 0x7ff893f0
ACPI: DSDT (v001  A0543 A0543000 0x00000000 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7fb00000)
Detected 2404.220 MHz processor.
Built 1 zonelists.  Total pages: 524160
Kernel command line: root=/dev/sda6
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2074188k/2096640k available (2498k kernel code, 21300k reserved, 1018k data, 192k init, 1179136k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4811.81 BogoMIPS (lpj=9623638)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000940 0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 16k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6861.69 BogoMIPS (lpj=13723397)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000940 0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
Total of 2 processors activated (11673.51 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=50
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=5
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:05:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:07: ioport range 0x290-0x297 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: faa00000-feafffff
  PREFETCH window: cff00000-efefffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: cfe00000-cfefffff
PCI: Bridge: 0000:00:1c.3
  IO window: b000-bfff
  MEM window: fa900000-fa9fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: a000-afff
  MEM window: fa800000-fa8fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 9000-9fff
  MEM window: fa700000-fa7fffff
  PREFETCH window: c7e00000-cfdfffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.3 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.4 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/O].
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
vesafb: NVIDIA Corporation, G73 Board - p345h0  , Chip Rev    (OEM: NVIDIA)
vesafb: VBE version: 3.0
vesafb: protected mode interface info at c000:d230
vesafb: pmi: set display start = c00cd266, set palette = c00cd2d0
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
vesafb: VBIOS/hardware supports DDC2 transfers
vesafb: monitor limits: vf = 63 Hz, hf = 65 kHz, clk = 110 MHz
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 160x64
vesafb: framebuffer at 0xd0000000, mapped to 0xf8880000, using 10240k, total 262144k
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU1PM] [20060707]
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU2PM] [20060707]
ACPI: Processor [CPU2] (supports 8 throttling states)
ACPI: Getting cpuindex for acpiid 0x3
ACPI: Getting cpuindex for acpiid 0x4
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
Linux video capture interface: v2.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 18
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input0
hda: _NEC DVD_RW ND-4571A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
ata1: SATA max UDMA/133 cmd 0xF880C900 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xF880C980 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xF880CA00 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF880CA80 ctl 0x0 bmdma 0x0 irq 19
scsi0 : ahci
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA 
ata2.00: ata2: dev 0 multi count 1
ata2.00: configured for UDMA/133
scsi2 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48 NCQ (depth 31/32)
ata3.00: ata3: dev 0 multi count 0
ata3.00: configured for UDMA/133
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: ST3400620AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Config  Disk      Rev: RGL1
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7L250S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 640 512-byte hdwr sectors (0 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write through
SCSI device sdb: 640 512-byte hdwr sectors (0 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write through
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 490234752 512-byte hdwr sectors (251000 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 490234752 512-byte hdwr sectors (251000 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 < sdc5 sdc6 sdc7 >
sd 2:0:0:0: Attached scsi disk sdc
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xfebfbc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e480
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000e800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 22, io base 0x0000e880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 17, io base 0x0000ec00
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 1-7: new high speed USB device using ehci_hcd and address 4
usb 1-7: configuration #1 chosen from 1 choice
hub 1-7:1.0: USB hub found
hub 1-7:1.0: 4 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usb 1-7.1: new low speed USB device using ehci_hcd and address 5
usb 1-7.1: configuration #1 chosen from 1 choice
usb 1-7.3: new high speed USB device using ehci_hcd and address 6
usb 1-7.3: configuration #1 chosen from 1 choice
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x04A9 pid 0x1091
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: Logitech USB-PS/2 Optical Mouse as /class/input/input1
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
input: MOSIC      USB 2A4K  GamePad           as /class/input/input2
input: USB HID v1.00 Gamepad [MOSIC      USB 2A4K  GamePad          ] on usb-0000:00:1d.7-7.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 13:55:50 2006 UTC).
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
ALSA device list:
  #0: HDA Intel at 0xfebfc000 irq 17
oprofile: using NMI interrupt.
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 204 bytes per conntrack
ctnetlink v0.90: registering with nfnetlink.
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Time: tsc clocksource has been installed.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 192k freed
ivtv:  ==================== START INIT IVTV ====================
ivtv:  version 0.8.1 (tagged release) loading
ivtv:  Linux version: 2.6.18-gentoo-r3 SMP mod_unload PENTIUMM REGPARM gcc-4.1
ivtv:  In case of problems please include the debug info between
ivtv:  the START INIT IVTV and END INIT IVTV lines, along with
ivtv:  any module options, when mailing the ivtv-users mailinglist.
ivtv0: Autodetected Hauppauge card (cx23416 based)
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 22 (level, low) -> IRQ 18
ivtv0: loaded v4l-cx2341x-enc.fw firmware (262144 bytes)
tveeprom 0-0050: Hauppauge model 32054, rev B148, serial# 2766660
tveeprom 0-0050: tuner model is LG TP18PSB11D (idx 48, type 29)
tveeprom 0-0050: TV standards PAL(B/G) (eeprom 0x04)
tveeprom 0-0050: audio processor is MSP4418 (idx 25)
tveeprom 0-0050: decoder processor is SAA7115 (idx 19)
tveeprom 0-0050: has no radio, has IR remote
ivtv0: Autodetected Hauppauge WinTV PVR-250
tuner 0-0061: chip found @ 0xc2 (ivtv i2c driver #0)
saa7115 0-0021: saa7115 found @ 0x42 (ivtv i2c driver #0)
msp3400 0-0040: MSP4418G-A2 found @ 0x80 (ivtv i2c driver #0)
msp3400 0-0040: MSP4418G-A2 supports nicam and radio, mode is autodetect and autoselect
ivtv0: Encoder revision: 0x02050032
ivtv0: Registered device video0 for encoder MPEG
ivtv0: Registered device video32 for encoder YUV
ivtv0: Registered device vbi0 for encoder VBI
ivtv0: Registered device video24 for encoder PCM audio
tuner 0-0061: type set to 29 (LG PAL_BG (TPI8PSB11D))
ivtv0: Initialized Hauppauge WinTV PVR-250, card #0
ivtv:  ====================  END INIT IVTV  ====================
loop: loaded (max 8 devices)
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:03:00.0 to 64
sky2 v1.5 addr 0xfa9fc000 irq 17 Yukon-EC (0xb6) rev 2
sky2 eth0: addr 00:17:31:ee:e4:c1
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
sky2 v1.5 addr 0xfa8fc000 irq 16 Yukon-EC (0xb6) rev 2
sky2 eth1: addr 00:17:31:e8:ec:2c
NTFS volume version 3.1.
Adding 3911788k swap on /dev/sda7.  Priority:-1 extents:1 across:3911788k
sky2 eth0: enabling interface
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control none
sky2 eth1: enabling interface
sky2 eth1: Link is up at 100 Mbps, full duplex, flow control both

--------------020607020704020000040707--
