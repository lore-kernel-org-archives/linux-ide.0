From: Milosz Tanski <mtanski@wideopenwest.com>
Subject: ICH7 fails to wakeup drive sata drive on ACPI resume
Date: Mon, 19 Jun 2006 03:02:26 -0400
Message-ID: <1150700546.6346.16.camel@mlap>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop-7.dnv.wideopenwest.com ([64.233.207.25]:15530 "EHLO
	pop-7.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id S932217AbWFSHC2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jun 2006 03:02:28 -0400
Received: from [10.0.0.102] (d192-24-139-155.try.wideopenwest.com [24.192.155.139])
	by pop-7.dnv.wideopenwest.com (8.12.8/8.12.8) with ESMTP id k5J76oRF017430
	for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2006 02:06:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I was experiencing some difficulties with waking up from sleep on laptop
with a ICH7 sata controller (Thinkpad z61t). After a long investigation
I figured out that on resume it fails to resume the drive(s).

The situation is like this if the controller is in AHCI mode in the bios
it will fail to resume the sata hard drive on resume, but if it's set
for compatibility mode it resumes just fine.

When it resumes in AHCI mode this are the errors that scroll down ~
every 30 seconds (copied down by hand):

ata1: handing error 1 timeout
ata1: port reset, p_is 4000 is 0 pis 40000 and 8007 tf 80 ss 113 se
4050000
ata1: satus=0x50 {Drive Ready Seek Complete}
Infofld = 0x3d7a31

That's what lead me to believe that drive doesn't resume, now I know
there is a recent patch added 6/3 to wait till drive spins up
(http://www.kernel.org/git/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commit;h=d9ec5ad24ce80b7ef69a0717363db661d13aada5) I am wondering if this has anything to with this line, and just waiting for ever for the drive to resume.

This is on a 2.6.17 kernel, can some one point me in the right direction
where to look for the bug.
Also I'm not on the list so please reply to me as well.

Here's some info that will hopefully be usefully:
dmesg in AHCI mode:
Linux version 2.6.17-2-be9bb5-686 (root@mlap) (gcc version 4.0.3 (Ubuntu
4.0.3-1ubuntu5)) #1 SMP Sat Jun 17 12:06:54 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007f6e0000 (usable)
 BIOS-e820: 000000007f6e0000 - 000000007f6f0000 (ACPI data)
 BIOS-e820: 000000007f6f0000 - 000000007f700000 (ACPI NVS)
 BIOS-e820: 000000007f700000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
1142MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f68a0
On node 0 totalpages: 521952
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 292576 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v002 LENOVO                                ) @ 0x000f6860
ACPI: XSDT (v001 LENOVO TP-7F    0x00001060  LTP 0x00000000) @
0x7f6e32d1
ACPI: FADT (v003 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6e3400
ACPI: SSDT (v001 LENOVO TP-7F    0x00001060 MSFT 0x0100000e) @
0x7f6e35b4
ACPI: ECDT (v001 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6efd9a
ACPI: TCPA (v002 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6efdec
ACPI: MADT (v001 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6efe1e
ACPI: MCFG (v001 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6efe86
ACPI: HPET (v001 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6efec4
ACPI: BOOT (v001 LENOVO TP-7F    0x00001060  LTP 0x00000001) @
0x7f6effd8
ACPI: SSDT (v001 LENOVO TP-7F    0x00001060 INTL 0x20050513) @
0x7f6f2939
ACPI: SSDT (v001 LENOVO TP-7F    0x00001060 INTL 0x20050513) @
0x7f6f2e40
ACPI: DSDT (v001 LENOVO TP-7F    0x00001060 MSFT 0x0100000e) @
0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:14 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)
Built 1 zonelists
Kernel command line: root=/dev/sda3 ro quiet splash
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2059368k/2087808k available (1912k kernel code, 27156k reserved,
858k data, 312k init, 1170304k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Detected 1829.186 MHz processor.
Using pmtmr for high-res timesource
Calibrating delay using timer specific routine.. 3663.73 BogoMIPS
(lpj=7327479)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000
0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000
0000c1a9 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9
00000000 00000000
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
checking if image is initramfs... it is
Freeing initrd memory: 6425k freed
ACPI: Looking for DSDT ... not found!
CPU0: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3657.64 BogoMIPS
(lpj=7315286)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000
0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000
0000c1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9
00000000 00000000
CPU1: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
Total of 2 processors activated (7321.38 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: 
Brought up 2 CPUs
migration_cost=8000
NET: Registered protocol family 16
EISA bus registered
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 2.10 entry at 0xfd84b, last bus=24
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: ee000000-ee0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: 2000-3fff
  MEM window: ec000000-edffffff
  PREFETCH window: e4000000-e40fffff
PCI: Bridge: 0000:00:1c.2
  IO window: 4000-5fff
  MEM window: e8000000-e9ffffff
  PREFETCH window: e4100000-e41fffff
PCI: Bridge: 0000:00:1c.3
  IO window: 6000-7fff
  MEM window: ea000000-ebffffff
  PREFETCH window: e4200000-e42fffff
PCI: Bus 22, cardbus bridge: 0000:15:00.0
  IO window: 00008000-000080ff
  IO window: 00008400-000084ff
  PREFETCH window: e0000000-e1ffffff
  MEM window: e6000000-e7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 8000-bfff
  MEM window: e4300000-e7ffffff
  PREFETCH window: e0000000-e3ffffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Enabling device 0000:00:1e.0 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 201
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Simple Boot Flag at 0x35 set to 0x1
audit: initializing netlink socket (disabled)
audit(1150694728.896:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
hpet_acpi_add: no address or irqs in _CRS
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
EISA: Probing bus 0 at eisa.0
Cannot allocate resource for EISA slot 1
Cannot allocate resource for EISA slot 2
Cannot allocate resource for EISA slot 3
Cannot allocate resource for EISA slot 4
Cannot allocate resource for EISA slot 5
Cannot allocate resource for EISA slot 6
Cannot allocate resource for EISA slot 7
Cannot allocate resource for EISA slot 8
EISA: Detected 0 cards.
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 8
NET: Registered protocol family 20
Starting balanced_irq
Using IPI No-Shortcut mode
ACPI wakeup devices: 
 LID SLPB EXP0 EXP1 EXP2 EXP3 PCI1 USB0 USB1 USB3 USB7 HDEF 
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 312k freed
input: AT Translated Set 2 keyboard as /class/input/input0
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x25
fb0: VGA16 VGA frame buffer device
Capability LSM initialized
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (56 C)
ACPI: Thermal Zone [THM1] (56 C)
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[C] -> GSI 16 (level, low) -> IRQ 201
ICH7: chipset revision 2
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: UJDA765 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
SCSI subsystem initialized
libata version 1.20 loaded.
ahci 0000:00:1f.2: version 1.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl
SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
ata1: SATA max UDMA/133 cmd 0xF8896500 ctl 0x0 bmdma 0x0 irq 58
ata2: SATA max UDMA/133 cmd 0xF8896580 ctl 0x0 bmdma 0x0 irq 58
ata3: SATA max UDMA/133 cmd 0xF8896600 ctl 0x0 bmdma 0x0 irq 58
ata4: SATA max UDMA/133 cmd 0xF8896680 ctl 0x0 bmdma 0x0 irq 58
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:0f00 82:746b 83:7f69 84:6063 85:f469 86:3c49 87:6063
88:043f
ata1: dev 0 ATA-7, max UDMA/100, 117210240 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ahci
ata2: SATA link down (SStatus 0)
scsi1 : ahci
ata3: SATA link down (SStatus 0)
scsi2 : ahci
ata4: SATA link down (SStatus 0)
scsi3 : ahci
  Vendor: ATA       Model: HTS541060G9SA00   Rev: MB3I
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 201, io base 0x00001820
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 66, io base 0x00001840
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 74
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 74, io base 0x00001860
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 82
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 82, io base 0x00001880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Enabling device 0000:15:00.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:15:00.1[B] -> GSI 17 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:15:00.1 to 64
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 82
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 82, io mem 0xee444000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[66]
MMIO=[e4302000-e43027ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Probing IDE interface ide1...
usb 5-3: new high speed USB device using ehci_hcd and address 2
Attempting manual resume
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
usb 5-3: configuration #1 chosen from 1 choice
hub 5-3:1.0: USB hub found
hub 5-3:1.0: 7 ports detected
usb 5-7: new high speed USB device using ehci_hcd and address 4
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00061b002022a173]
usb 5-7: configuration #1 chosen from 1 choice
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
usb 5-3.2: new high speed USB device using ehci_hcd and address 5
usb 5-3.2: configuration #1 chosen from 1 choice
usb 5-3.6: new low speed USB device using ehci_hcd and address 6
usb 5-3.6: configuration #1 chosen from 1 choice
usb 3-2: new full speed USB device using uhci_hcd and address 2
usb 3-2: configuration #1 chosen from 1 choice
sd 0:0:0:0: Attached scsi generic sg0 type 0
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
hw_random hardware driver 1.0.0 loaded
input: PC Speaker as /class/input/input1
sdhci: Secure Digital Host Controller Interface driver, 0.11
sdhci: Copyright(c) Pierre Ossman
ACPI: PCI Interrupt 0000:15:00.3[A] -> GSI 16 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:15:00.3 to 64
mmc0: SDHCI at 0xe4302800 irq 201 DMA
ACPI: PCI Interrupt 0000:15:00.2[A] -> GSI 16 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:15:00.2 to 64
usbcore: registered new driver hiddev
input: Kensington USB Input Device as /class/input/input2
input: USB HID v1.00 Mouse [Kensington USB Input Device] on
usb-0000:00:1d.7-3.6
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ieee80211_crypt: registered algorithm 'NULL'
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x81a0b1, caps:
0xa04793/0x300000
serio: Synaptics pass-through port at isa0060/serio1/input0
tg3.c:v3.59 (June 8, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95752m) rev 6002 PHY(5752)] (PCI Express)
10/100/1000BaseT Ethernet 00:16:36:4b:7e:b0
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]
TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
usbcore: registered new driver libusual
input: SynPS/2 Synaptics TouchPad as /class/input/input3
ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 201
Yenta: CardBus bridge found at 0000:15:00.0 [17aa:2028]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to ISA
Yenta TI: socket 0000:15:00.0, mfunc 0x01db1b22, devctl 0x64
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation
<jketreno@linux.intel.com>
Yenta: ISA IRQ mask 0x0cf8, PCI irq 201
Socket status: 30000086
pcmcia: parent PCI bridge I/O window: 0x8000 - 0xbfff
cs: IO port probe 0x8000-0xbfff: clean.
pcmcia: parent PCI bridge Memory window: 0xe4300000 - 0xe7ffffff
pcmcia: parent PCI bridge Memory window: 0xe0000000 - 0xe3ffffff
Initializing USB Mass Storage driver...
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux,
1.0.3m
ipw3945: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:03:00.0 to 64
ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
ts: Compaq touchscreen protocol output
ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1b.0 to 64
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
hda_intel: azx_get_response timeout, switching to single_cmd mode...
ipw3945: Detected geography ABG (11 802.11bg channels, 13 802.11a
channels)
lp: driver loaded but no devices found
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
Adding 2048248k swap on /dev/sda1.  Priority:-1 extents:1
across:2048248k
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
  Vendor: FUJITSU   Model: MHT2080AH         Rev: 006C
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 03 00 00 00
sdb: assuming drive cache: write through
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 03 00 00 00
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2 sdb3
sd 4:0:0:0: Attached scsi disk sdb
sd 4:0:0:0: Attached scsi generic sg1 type 0
usb-storage: device scan complete
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
IBM TrackPoint firmware: 0x0e, buttons: 3/3
input: TPPS/2 IBM TrackPoint as /class/input/input4
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: AC Adapter [AC] (on-line)
pcc_acpi: loading...
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
ibm_acpi: http://ibm-acpi.sf.net/
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ppdev: user-space parallel port driver
apm: BIOS not found.
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 201
[drm] Initialized i915 1.4.0 20060119 on minor 0
PM: Writing back config space on device 0000:02:00.0 at offset 1 (was
100506, writing 100106)
Non-volatile memory driver v1.2
input: /usr/sbin/thinkpad-keys as /class/input/input5
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
ReiserFS: sdb2: found reiserfs format "3.6" with standard journal
ReiserFS: sdb2: using ordered data mode
ReiserFS: sdb2: journal params: device sdb2, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sdb2: checking transaction log (sdb2)
ReiserFS: sdb2: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

dmesg in compat mode:
Linux version 2.6.17-2-be9bb5-686 (root@mlap) (gcc version 4.0.3 (Ubuntu
4.0.3-1ubuntu5)) #1 SMP Sat Jun 17 12:06:54 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007f6e0000 (usable)
 BIOS-e820: 000000007f6e0000 - 000000007f6f0000 (ACPI data)
 BIOS-e820: 000000007f6f0000 - 000000007f700000 (ACPI NVS)
 BIOS-e820: 000000007f700000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
1142MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f68a0
On node 0 totalpages: 521952
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 292576 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v002 LENOVO                                ) @ 0x000f6860
ACPI: XSDT (v001 LENOVO TP-7F    0x00001060  LTP 0x00000000) @
0x7f6e32d1
ACPI: FADT (v003 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6e3400
ACPI: SSDT (v001 LENOVO TP-7F    0x00001060 MSFT 0x0100000e) @
0x7f6e35b4
ACPI: ECDT (v001 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6efd9a
ACPI: TCPA (v002 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6efdec
ACPI: MADT (v001 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6efe1e
ACPI: MCFG (v001 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6efe86
ACPI: HPET (v001 LENOVO TP-7F    0x00001060 LNVO 0x00000001) @
0x7f6efec4
ACPI: BOOT (v001 LENOVO TP-7F    0x00001060  LTP 0x00000001) @
0x7f6effd8
ACPI: SSDT (v001 LENOVO TP-7F    0x00001060 INTL 0x20050513) @
0x7f6f2939
ACPI: SSDT (v001 LENOVO TP-7F    0x00001060 INTL 0x20050513) @
0x7f6f2e40
ACPI: SSDT (v001 LENOVO TP-7F    0x00001060 INTL 0x20050513) @
0x7f6f36fd
ACPI: DSDT (v001 LENOVO TP-7F    0x00001060 MSFT 0x0100000e) @
0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:14 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)
Built 1 zonelists
Kernel command line: root=/dev/sda3 ro quiet splash
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2059368k/2087808k available (1912k kernel code, 27156k reserved,
858k data, 312k init, 1170304k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Detected 1829.218 MHz processor.
Using pmtmr for high-res timesource
Calibrating delay using timer specific routine.. 3663.70 BogoMIPS
(lpj=7327411)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000
0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000
0000c1a9 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9
00000000 00000000
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
checking if image is initramfs... it is
Freeing initrd memory: 6425k freed
ACPI: Looking for DSDT ... not found!
CPU0: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3657.88 BogoMIPS
(lpj=7315761)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000
0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000
0000c1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9
00000000 00000000
CPU1: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
Total of 2 processors activated (7321.58 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: 
Brought up 2 CPUs
migration_cost=8000
NET: Registered protocol family 16
EISA bus registered
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 2.10 entry at 0xfd84b, last bus=24
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: ee000000-ee0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: 2000-3fff
  MEM window: ec000000-edffffff
  PREFETCH window: e4000000-e40fffff
PCI: Bridge: 0000:00:1c.2
  IO window: 4000-5fff
  MEM window: e8000000-e9ffffff
  PREFETCH window: e4100000-e41fffff
PCI: Bridge: 0000:00:1c.3
  IO window: 6000-7fff
  MEM window: ea000000-ebffffff
  PREFETCH window: e4200000-e42fffff
PCI: Bus 22, cardbus bridge: 0000:15:00.0
  IO window: 00008000-000080ff
  IO window: 00008400-000084ff
  PREFETCH window: e0000000-e1ffffff
  MEM window: e6000000-e7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 8000-bfff
  MEM window: e4300000-e7ffffff
  PREFETCH window: e0000000-e3ffffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Enabling device 0000:00:1e.0 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 201
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Simple Boot Flag at 0x35 set to 0x1
audit: initializing netlink socket (disabled)
audit(1150694136.548:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
hpet_acpi_add: no address or irqs in _CRS
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
EISA: Probing bus 0 at eisa.0
Cannot allocate resource for EISA slot 1
Cannot allocate resource for EISA slot 2
Cannot allocate resource for EISA slot 3
Cannot allocate resource for EISA slot 4
Cannot allocate resource for EISA slot 5
Cannot allocate resource for EISA slot 6
Cannot allocate resource for EISA slot 7
Cannot allocate resource for EISA slot 8
EISA: Detected 0 cards.
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 8
NET: Registered protocol family 20
Starting balanced_irq
Using IPI No-Shortcut mode
ACPI wakeup devices: 
 LID SLPB EXP0 EXP1 EXP2 EXP3 PCI1 USB0 USB1 USB3 USB7 HDEF 
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 312k freed
input: AT Translated Set 2 keyboard as /class/input/input0
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x25
fb0: VGA16 VGA frame buffer device
Capability LSM initialized
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (55 C)
ACPI: Thermal Zone [THM1] (55 C)
SCSI subsystem initialized
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
ata1: dev 0 cfg 49:0f00 82:746b 83:7f69 84:6063 85:f469 86:3c49 87:6063
88:203f
ata1: dev 0 ATA-7, max UDMA/100, 117210240 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: HTS541060G9SA00   Rev: MB3I
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
ata2: dev 0 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
  Vendor: MATSHITA  Model: UJDA765 DVD/CDRW  Rev: 1.70
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 201, io base 0x00001820
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 58, io base 0x00001840
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 66, io base 0x00001860
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 74
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 74, io base 0x00001880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 74
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 74, io mem 0xee444000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
PCI: Enabling device 0000:15:00.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:15:00.1[B] -> GSI 17 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:15:00.1 to 64
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[58]
MMIO=[e4302000-e43027ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe
Attempting manual resume
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
usb 5-7: new high speed USB device using ehci_hcd and address 3
usb 5-7: configuration #1 chosen from 1 choice
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
usb 3-2: new full speed USB device using uhci_hcd and address 2
usb 3-2: configuration #1 chosen from 1 choice
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00061b002022a173]
sd 0:0:0:0: Attached scsi generic sg0 type 0
 1:0:0:0: Attached scsi generic sg1 type 5
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
input: PC Speaker as /class/input/input1
hw_random hardware driver 1.0.0 loaded
tg3.c:v3.59 (June 8, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95752m) rev 6002 PHY(5752)] (PCI Express)
10/100/1000BaseT Ethernet 00:16:36:4b:7e:b0
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]
TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation
<jketreno@linux.intel.com>
ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 201
Yenta: CardBus bridge found at 0000:15:00.0 [17aa:2028]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to ISA
Yenta TI: socket 0000:15:00.0, mfunc 0x01db1b22, devctl 0x64
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x81a0b1, caps:
0xa04793/0x300000
serio: Synaptics pass-through port at isa0060/serio1/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
Yenta: ISA IRQ mask 0x0cf8, PCI irq 201
Socket status: 30000086
pcmcia: parent PCI bridge I/O window: 0x8000 - 0xbfff
cs: IO port probe 0x8000-0xbfff: clean.
pcmcia: parent PCI bridge Memory window: 0xe4300000 - 0xe7ffffff
pcmcia: parent PCI bridge Memory window: 0xe0000000 - 0xe3ffffff
ACPI: PCI Interrupt 0000:15:00.2[A] -> GSI 16 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:15:00.2 to 64
sdhci: Secure Digital Host Controller Interface driver, 0.11
sdhci: Copyright(c) Pierre Ossman
ACPI: PCI Interrupt 0000:15:00.3[A] -> GSI 16 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:15:00.3 to 64
mmc0: SDHCI at 0xe4302800 irq 201 DMA
ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux,
1.0.3m
ipw3945: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:03:00.0 to 64
ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
ts: Compaq touchscreen protocol output
ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1b.0 to 64
cs: IO port probe 0x100-0x3af: excluding 0x370-0x377
cs: IO port probe 0x3e0-0x4ff: excluding 0x3f0-0x3f7 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
ipw3945: Detected geography ABG (11 802.11bg channels, 13 802.11a
channels)
lp: driver loaded but no devices found
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
Adding 2048248k swap on /dev/sda1.  Priority:-1 extents:1
across:2048248k
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
IBM TrackPoint firmware: 0x0e, buttons: 3/3
input: TPPS/2 IBM TrackPoint as /class/input/input3
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: AC Adapter [AC] (on-line)
pcc_acpi: loading...
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
ibm_acpi: http://ibm-acpi.sf.net/
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ppdev: user-space parallel port driver
apm: BIOS not found.
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 201
[drm] Initialized i915 1.4.0 20060119 on minor 0
PM: Writing back config space on device 0000:02:00.0 at offset 1 (was
100506, writing 100106)
Non-volatile memory driver v1.2
input: /usr/sbin/thinkpad-keys as /class/input/input4
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
usb 5-3: new high speed USB device using ehci_hcd and address 4
usb 5-3: configuration #1 chosen from 1 choice
hub 5-3:1.0: USB hub found
hub 5-3:1.0: 7 ports detected
usb 5-3.2: new high speed USB device using ehci_hcd and address 5
usb 5-3.2: configuration #1 chosen from 1 choice
usb 5-3.6: new low speed USB device using ehci_hcd and address 6
usb 5-3.6: configuration #1 chosen from 1 choice
usbcore: registered new driver libusual
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
input: Kensington USB Input Device as /class/input/input5
input: USB HID v1.00 Mouse [Kensington USB Input Device] on
usb-0000:00:1d.7-3.6
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
  Vendor: FUJITSU   Model: MHT2080AH         Rev: 006C
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 03 00 00 00
sdb: assuming drive cache: write through
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 03 00 00 00
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2 sdb3
sd 2:0:0:0: Attached scsi disk sdb
sd 2:0:0:0: Attached scsi generic sg2 type 0
usb-storage: device scan complete
ReiserFS: sdb2: found reiserfs format "3.6" with standard journal
ReiserFS: sdb2: using ordered data mode
ReiserFS: sdb2: journal params: device sdb2, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sdb2: checking transaction log (sdb2)
ReiserFS: sdb2: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 17
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'

LSPCI output:
 0000:00:00.0 Host bridge: Intel Corporation Mobile Memory Controller
Hub (rev 03)
	Subsystem: Lenovo: Unknown device 2017
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [5109]

0000:00:02.0 VGA compatible controller: Intel Corporation Mobile
Integrated Graphics Controller (rev 03) (prog-if 00 [VGA])
	Subsystem: Lenovo: Unknown device 201a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at ee100000 (32-bit, non-prefetchable) [size=512K]
	Region 1: I/O ports at 1800 [size=8]
	Region 2: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Region 3: Memory at ee200000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 Display controller: Intel Corporation Mobile Integrated
Graphics Controller (rev 03)
	Subsystem: Lenovo: Unknown device 201a
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Region 0: Memory at ee180000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
	Subsystem: Lenovo: Unknown device 2010
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin B routed to IRQ 58
	Region 0: Memory at ee240000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 1 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: ee000000-ee0fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
		Address: fee00000  Data: 40d9
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 2 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00002000-00003fff
	Memory behind bridge: ec000000-edffffff
	Prefetchable memory behind bridge: 00000000e4000000-00000000e4000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
		Address: fee00000  Data: 40e1
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 3 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=04, subordinate=0b, sec-latency=0
	I/O behind bridge: 00004000-00005fff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: 00000000e4100000-00000000e4100000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
		Address: fee00000  Data: 40e9
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 4 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=0c, subordinate=13, sec-latency=0
	I/O behind bridge: 00006000-00007fff
	Memory behind bridge: ea000000-ebffffff
	Prefetchable memory behind bridge: 00000000e4200000-00000000e4200000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
		Address: fee00000  Data: 4032
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Lenovo: Unknown device 200a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 201
	Region 4: I/O ports at 1820 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Lenovo: Unknown device 200a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 58
	Region 4: I/O ports at 1840 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Lenovo: Unknown device 200a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 66
	Region 4: I/O ports at 1860 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Lenovo: Unknown device 200a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 74
	Region 4: I/O ports at 1880 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Lenovo: Unknown device 200b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 74
	Region 0: Memory at ee444000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev
e2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=15, subordinate=18, sec-latency=32
	I/O behind bridge: 00008000-0000bfff
	Memory behind bridge: e4300000-e7ffffff
	Prefetchable memory behind bridge: 00000000e0000000-00000000e3f00000
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC
Interface Bridge (rev 02)
	Subsystem: Lenovo: Unknown device 2009
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [100c]

0000:00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family)
Serial ATA Storage Controllers cc=IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Lenovo: Unknown device 200e
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 201
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 18b0 [size=16]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus
Controller (rev 02)
	Subsystem: Lenovo: Unknown device 200f
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 18e0 [size=32]

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme
BCM5752M Gigabit Ethernet PCI Express (rev 02)
	Subsystem: Lenovo: Unknown device 2020
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 82
	Region 0: Memory at ee000000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
Enable+
		Address: 00000000fee00000  Data: 4052
	Capabilities: [d0] #10 [0001]

0000:03:00.0 Network controller: Intel Corporation: Unknown device 4227
(rev 02)
	Subsystem: Intel Corporation: Unknown device 1010
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 58
	Region 0: Memory at edf00000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] #10 [0011]

0000:15:00.0 CardBus bridge: Texas Instruments: Unknown device 8039
	Subsystem: Lenovo: Unknown device 2028
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at e4300000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=15, secondary=16, subordinate=17, sec-latency=176
	Memory window 0: e0000000-e1fff000 (prefetchable)
	Memory window 1: e6000000-e7fff000
	I/O window 0: 00008000-000080ff
	I/O window 1: 00008400-000084ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:15:00.1 FireWire (IEEE 1394): Texas Instruments: Unknown device
803a (prog-if 10 [OHCI])
	Subsystem: Lenovo: Unknown device 207f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin B routed to IRQ 58
	Region 0: Memory at e4302000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at e4304000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot
+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:15:00.2 Mass storage controller: Texas Instruments: Unknown device
803b
	Subsystem: Lenovo: Unknown device 207c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1750ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at e4301000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot
+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:15:00.3 0805: Texas Instruments: Unknown device 803c (prog-if 01)
	Subsystem: Lenovo: Unknown device 207d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1750ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at e4302800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot
+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

