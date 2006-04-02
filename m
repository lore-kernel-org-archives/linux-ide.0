From: Jeff Garzik <jeff@garzik.org>
Subject: New probe code causes boot delay on empty ports
Date: Sun, 02 Apr 2006 12:16:02 -0400
Message-ID: <442FF8C2.40201@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020908060709020601000703"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:3460 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932378AbWDBQQK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 12:16:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------020908060709020601000703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


A previously fast-booting EM64T ICH6 AHCI box now pauses for 5 seconds, 
when probing hits an empty port.

Additionally, the probe code should IMO take into account the fact that 
AHCI reset includes a COMRESET.

Anyway, see attached dmesg.

	Jeff




--------------020908060709020601000703
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Bootdata ok (command line is ro root=LABEL=root nogui)
Linux version 2.6.16-libata1-g6d5f9732 (jgarzik@ich.yyz.us) (gcc version 4.1.0 20060304 (Red Hat 4.1.0-3)) #1 SMP Sun Apr 2 11:51:46 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f630000 (usable)
 BIOS-e820: 000000003f630000 - 000000003f640000 (ACPI data)
 BIOS-e820: 000000003f640000 - 000000003f700000 (ACPI NVS)
 BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000f7e90
ACPI: XSDT (v001 A M I  OEMXSDT  0x12000416 MSFT 0x00000097) @ 0x000000003f630100
ACPI: FADT (v003 A M I  OEMFACP  0x12000416 MSFT 0x00000097) @ 0x000000003f630200
ACPI: HPET (v001 A M I  XXXXXXXX 0x12000416 LTNI 0x00000097) @ 0x000000003f630500
ACPI: MADT (v001 A M I  OEMAPIC  0x12000416 MSFT 0x00000097) @ 0x000000003f630300
ACPI: MCFG (v001 A M I  OEMMCFG  0x12000416 MSFT 0x00000097) @ 0x000000003f630400
ACPI: OEMB (v001 A M I  OEMBIOS  0x12000416 MSFT 0x00000097) @ 0x000000003f640040
ACPI: DSDT (v001 VVPLI7 VVPLI721 0x00000021 INTL 0x02002026) @ 0x0000000000000000
On node 0 totalpages: 254802
  DMA zone: 2759 pages, LIFO batch:0
  DMA32 zone: 252043 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Checking aperture...
Built 1 zonelists
Kernel command line: ro root=LABEL=root nogui
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 2794.813 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 1016068k/1038528k available (1887k kernel code, 21656k reserved, 1143k data, 176k init)
Calibrating delay using timer specific routine.. 5595.34 BogoMIPS (lpj=11190683)
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
Using local APIC timer interrupts.
result 12476780
Detected 12.476 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5589.85 BogoMIPS (lpj=11179718)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU1: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.40GHz stepping 04
APIC error on CPU1: 00(40)
Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=22
checking if image is initramfs... it is
Freeing initrd memory: 1054k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfed00000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
PCI-DMA: Disabling IOMMU.
initcall at 0xffffffff80574c00: pci_iommu_init+0x0/0x580(): returned with error code -1
pnp: 00:0a: ioport range 0x400-0x47f could not be reserved
pnp: 00:0a: ioport range 0x680-0x6ff has been reserved
pnp: 00:0a: ioport range 0x500-0x53f has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: c000-cfff
  MEM window: fe500000-fe7fffff
  PREFETCH window: bfd00000-bfdfffff
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: fe400000-fe4fffff
  PREFETCH window: bfc00000-bfcfffff
PCI: Bridge: 0000:00:1c.2
  IO window: disabled.
  MEM window: fe300000-fe3fffff
  PREFETCH window: bfb00000-bfbfffff
PCI: Bridge: 0000:00:1c.3
  IO window: disabled.
  MEM window: fe200000-fe2fffff
  PREFETCH window: bfa00000-bfafffff
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: fe100000-fe1fffff
  PREFETCH window: bf900000-bf9fffff
PCI: Bridge: 0000:00:1c.5
  IO window: disabled.
  MEM window: fe000000-fe0fffff
  PREFETCH window: bf800000-bf8fffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fe800000-fe8fffff
  PREFETCH window: bfe00000-bfefffff
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1c.3 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.4 to 64
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1143993629.520:1): initialized
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
Allocate Port Service[0000:00:1c.3:pcie03]
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
Allocate Port Service[0000:00:1c.4:pcie03]
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
Allocate Port Service[0000:00:1c.5:pcie02]
Allocate Port Service[0000:00:1c.5:pcie03]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945G Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
pnp: Device 00:03 does not supported disabling.
pnp: Device 00:04 does not supported disabling.
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
isa bounce pool size: 16 pages
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
ICH7: chipset revision 0
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: TEAC DW-552G, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 176k freed
Write protecting the kernel read-only data: 703k
SCSI subsystem initialized
libata version 1.20 loaded.
ahci 0000:00:1f.2: version 1.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
input: ImPS/2 Generic Wheel Mouse as /class/input/input2
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0001 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq ilck stag led clo pio slum part 
ata1: SATA max UDMA/133 cmd 0xFFFFC20000016D00 ctl 0x0 bmdma 0x0 irq 66
ata2: SATA max UDMA/133 cmd 0xFFFFC20000016D80 ctl 0x0 bmdma 0x0 irq 66
ata3: SATA max UDMA/133 cmd 0xFFFFC20000016E00 ctl 0x0 bmdma 0x0 irq 66
ata4: SATA max UDMA/133 cmd 0xFFFFC20000016E80 ctl 0x0 bmdma 0x0 irq 66
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata1: dev 0 ATA-6, max UDMA/133, 234441648 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0007
ata2: dev 0 ATAPI, max UDMA/33
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/33
scsi1 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata3: dev 0 ATA-6, max UDMA/133, 234441648 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : ahci
ata4: softreset failed, will try hardreset in 5 secs
ata4: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
  Vendor: ATA       Model: ST3120026AS       Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
  Vendor: PLEXTOR   Model: DVDR   PX-712A    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3120026AS       Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 2:0:0:0: Attached scsi disk sdb
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
8139too Fast Ethernet driver 0.9.27
GSI 20 sharing vector 0x4A and IRQ 20
ACPI: PCI Interrupt 0000:07:01.0[A] -> GSI 22 (level, low) -> IRQ 74
eth0: RealTek RTL8139 at 0xffffc20000018c00, 00:48:54:80:c9:91, IRQ 74
eth0:  Identified 8139 chip type 'RTL-8139B'
Intel(R) PRO/1000 Network Driver - version 7.0.33-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:06:00.0 to 64
e1000: 0000:06:00.0: e1000_probe: The EEPROM Checksum Is Not Valid
e1000: probe of 0000:06:00.0 failed with error -5
sd 0:0:0:0: Attached scsi generic sg0 type 0
 1:0:0:0: Attached scsi generic sg1 type 5
sd 2:0:0:0: Attached scsi generic sg2 type 0
USB Universal Host Controller Interface driver v3.0
GSI 21 sharing vector 0x52 and IRQ 21
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 82
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 82, io base 0x0000ee00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr 1:0:0:0: Attached scsi CD-ROM sr0
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 193, io base 0x0000ee80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 185, io base 0x0000ef00
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 177, io base 0x0000e000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 82
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 82, io mem 0xfeb3f800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
usb 5-7: new high speed USB device using ehci_hcd and address 2
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SPBT]
Using specific hotkey driver
usb 5-7: configuration #1 chosen from 1 choice
Initializing USB Mass Storage driver...
scsi4 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
  Vendor: IN-WIN    Model: iAPP  HS-CF       Rev: 1.95
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 4:0:0:0: Attached scsi removable disk sdc
sd 4:0:0:0: Attached scsi generic sg3 type 0
usb-storage: device scan complete
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 4096532k swap on /dev/sda5.  Priority:-1 extents:1 across:4096532k
eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver

--------------020908060709020601000703--
