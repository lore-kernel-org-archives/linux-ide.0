From: =?ISO-8859-1?Q?Daniel_Schr=F6der?= <mail@dschroeder.info>
Subject: [PMP] libata-tj-2.6.18.1-20061020 sil3132 success
Date: Sat, 21 Oct 2006 17:44:02 +0200
Message-ID: <453A4042.9070801@dschroeder.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:18892 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S2993108AbWJUPoL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Oct 2006 11:44:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hello *,

first of all: thanks for the work you are doing!
second: today, i have bought a PMP Device Raidsonic Stardom ST6600
(http://www.raidsonic.de/de/pages/products/external_cases.php?we_objectID=4239)

patched the vanilla 2.6.18.1 Kernel with the libata-tj patch from
20061020 and everything seems to run smoothly. The
controller is a sil3132 onboard on an Asus m2n32-wifi deluxe.

Beneath is a dmesg output (turn on, mount, umount, turn off) and a lspci
output

cheers,
daniel

<dmesg>
Linux version 2.6.18.1 (root@isla-magica) (gcc version 4.1.1 (Gentoo
4.1.1)) #1 SMP PREEMPT Sat Oct 21 12:44:00 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003fef3000 (ACPI NVS)
 BIOS-e820: 000000003fef3000 - 000000003ff00000 (ACPI data)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f60b0
On node 0 totalpages: 261872
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32496 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x000f7d30
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fef3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fef30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x3fefc5c0
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fefc740
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fefc500
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: Skipping IOAPIC probe due to 'noapic' option.
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 40000000 (gap: 3ff00000:b0100000)
Detected 2210.174 MHz processor.
Built 1 zonelists.  Total pages: 261872
Kernel command line: root=/dev/sda3 noapic
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
spurious 8259A interrupt: IRQ7.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032384k/1047488k available (3475k kernel code, 14456k reserved,
1316k data, 248k init, 129984k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4423.85 BogoMIPS
(lpj=8847706)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff ebd3fbff 00000000 00000000
00002001 00000000 0000001d
CPU: After vendor identify, caps: 078bfbff ebd3fbff 00000000 00000000
00002001 00000000 0000001d
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 078bfbff ebd3fbff 00000000 00000410 00002001
00000000 0000001d
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 16k freed
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0ca0)
CPU0: AMD Athlon(tm) 64 Processor 3500+ stepping 02
Total of 1 processors activated (4423.85 BogoMIPS).
Brought up 1 CPUs
migration_cost=0
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
PCI: No mmconfig possible on 0:18
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:0e.0
Boot video device is 0000:07:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LMC1] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LSA2] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AMC1] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [ASA2] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
pnp: 00:01: ioport range 0x1000-0x107f could not be reserved
pnp: 00:01: ioport range 0x1080-0x10ff has been reserved
pnp: 00:01: ioport range 0x1400-0x147f has been reserved
pnp: 00:01: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:01: ioport range 0x1800-0x187f has been reserved
pnp: 00:01: ioport range 0x1880-0x18ff has been reserved
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: fdf00000-fdffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:12.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:14.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:16.0
  IO window: 9000-9fff
  MEM window: fde00000-fdefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:17.0
  IO window: 8000-8fff
  MEM window: fa000000-fcffffff
  PREFETCH window: e0000000-efffffff
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI: Setting latency timer of device 0000:00:12.0 to 64
PCI: Setting latency timer of device 0000:00:14.0 to 64
PCI: Setting latency timer of device 0000:00:16.0 to 64
PCI: Setting latency timer of device 0000:00:17.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
highmem bounce pool size: 64 pages
NTFS driver 2.1.27 [Flags: R/O].
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:03.0 to 64
pcie_portdrv_probe->Dev[02fd:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie03]
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[02fb:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie03]
PCI: Setting latency timer of device 0000:00:12.0 to 64
pcie_portdrv_probe->Dev[0376:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:12.0:pcie00]
Allocate Port Service[0000:00:12.0:pcie03]
PCI: Setting latency timer of device 0000:00:14.0 to 64
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:14.0:pcie00]
Allocate Port Service[0000:00:14.0:pcie03]
PCI: Setting latency timer of device 0000:00:16.0 to 64
pcie_portdrv_probe->Dev[0375:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:16.0:pcie00]
Allocate Port Service[0000:00:16.0:pcie03]
PCI: Setting latency timer of device 0000:00:17.0 to 64
pcie_portdrv_probe->Dev[0377:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:17.0:pcie00]
Allocate Port Service[0000:00:17.0:pcie03]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: Getting cpuindex for acpiid 0x1
ACPI: Thermal Zone [THRM] (40 C)
loop: loaded (max 8 devices)
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.56.
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LMAC] -> GSI 7 (level, low)
-> IRQ 7
PCI: Setting latency timer of device 0000:00:10.0 to 64
forcedeth: using HIGHDMA
eth0: forcedeth.c: subsystem: 010de:cb84 bound to 0000:00:10.0
ACPI: PCI Interrupt Link [LMC1] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LMC1] -> GSI 5 (level, low)
-> IRQ 5
PCI: Setting latency timer of device 0000:00:11.0 to 64
forcedeth: using HIGHDMA
eth1: forcedeth.c: subsystem: 010de:cb84 bound to 0000:00:11.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-MCP55: IDE controller at PCI slot 0000:00:0c.0
NFORCE-MCP55: chipset revision 161
NFORCE-MCP55: not 100% native mode: will probe irqs later
NFORCE-MCP55: 0000:00:0c.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-740A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 2.00 loaded.
sata_sil24 0000:06:00.0: version 0.4
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 7
ACPI: PCI Interrupt 0000:06:00.0[A] -> Link [LNK7] -> GSI 7 (level, low)
-> IRQ 7
PCI: Setting latency timer of device 0000:06:00.0 to 64
ata1: SATA max UDMA/100 cmd 0xF8820000 ctl 0x0 bmdma 0x0 irq 7
ata2: SATA max UDMA/100 cmd 0xF8822000 ctl 0x0 bmdma 0x0 irq 7
scsi0 : sata_sil24
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : sata_sil24
ata2: SATA link down (SStatus 0 SControl 300)
sata_nv 0000:00:0d.0: version 2.0
ACPI: PCI Interrupt Link [LSID] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LSID] -> GSI 5 (level, low)
-> IRQ 5
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ata3: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xDC00 irq 5
ata4: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xDC08 irq 5
scsi2 : sata_nv
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
ata3.00: ata3: dev 0 multi count 1
ata3.00: configured for UDMA/133
scsi3 : sata_nv
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata4.00: ata4: dev 0 multi count 1
ata4.00: configured for UDMA/133
  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 2:0:0:0: Attached scsi disk sda
sd 2:0:0:0: Attached scsi generic sg0 type 0
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 3:0:0:0: Attached scsi disk sdb
sd 3:0:0:0: Attached scsi generic sg1 type 0
ACPI: PCI Interrupt Link [LFID] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:0d.1[B] -> Link [LFID] -> GSI 5 (level, low)
-> IRQ 5
PCI: Setting latency timer of device 0000:00:0d.1 to 64
ata5: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC800 irq 5
ata6: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC808 irq 5
scsi4 : sata_nv
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata5.00: ata5: dev 0 multi count 1
ata5.00: configured for UDMA/133
scsi5 : sata_nv
ata6: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x967
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2
sd 4:0:0:0: Attached scsi disk sdc
sd 4:0:0:0: Attached scsi generic sg2 type 0
ACPI: PCI Interrupt Link [LSA2] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:0d.2[C] -> Link [LSA2] -> GSI 5 (level, low)
-> IRQ 5
PCI: Setting latency timer of device 0000:00:0d.2 to 64
ata7: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB400 irq 5
ata8: SATA max UDMA/133 cmd 0xBC00 ctl 0xB802 bmdma 0xB408 irq 5
scsi6 : sata_nv
ata7: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xC407
scsi7 : sata_nv
ata8: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xBC07
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:03:0b.0[A] -> Link [LNK1] -> GSI 11 (level,
low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]
MMIO=[fdfff000-fdfff7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LUB2] -> GSI 10 (level,
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:0a.1 to 64
ehci_hcd 0000:00:0a.1: EHCI Host Controller
ehci_hcd 0000:00:0a.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0a.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:0a.1
ehci_hcd 0000:00:0a.1: irq 10, io mem 0xfe02e000
ehci_hcd 0000:00:0a.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
USB Universal Host Controller Interface driver v3.0
Initializing USB Mass Storage driver...
usb 1-2: new high speed USB device using ehci_hcd and address 2
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 7 ports detected
usb 1-9: new high speed USB device using ehci_hcd and address 3
usb 1-9: configuration #1 chosen from 1 choice
usb 1-2.2: new low speed USB device using ehci_hcd and address 4
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d80000b09010]
usb 1-2.2: configuration #1 chosen from 1 choice
usb 1-2.5: new high speed USB device using ehci_hcd and address 5
usb 1-2.5: configuration #1 chosen from 1 choice
hub 1-2.5:1.0: USB hub found
hub 1-2.5:1.0: 3 ports detected
usb 1-2.5.3: new full speed USB device using ehci_hcd and address 6
usb 1-2.5.3: configuration #1 chosen from 1 choice
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
input: HID 0c12:0005 as /class/input/input0
input: USB HID v1.00 Joystick [HID 0c12:0005] on usb-0000:00:0a.1-2.2
drivers/usb/input/hid-core.c: ctrl urb status -75 received
hiddev96: USB HID v1.10 Device [EIZO EIZO USB HID Monitor] on
usb-0000:00:0a.1-2.5.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: raid1 personality registered for level 1
raid6: int32x1    791 MB/s
raid6: int32x2   1055 MB/s
raid6: int32x4    830 MB/s
raid6: int32x8    611 MB/s
raid6: mmxx1     1772 MB/s
raid6: mmxx2     3306 MB/s
input: AT Translated Set 2 keyboard as /class/input/input1
raid6: sse1x1    1749 MB/s
raid6: sse1x2    2900 MB/s
raid6: sse2x1    3051 MB/s
raid6: sse2x2    4120 MB/s
raid6: using algorithm sse2x2 (4120 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  6641.000 MB/sec
raid5: using function: pIII_sse (6641.000 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
dm-devel@redhat.com
sdhci: Secure Digital Host Controller Interface driver, 0.12
sdhci: Copyright(c) Pierre Ossman
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
13:55:50 2006 UTC).
ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:0e.1[B] -> Link [LAZA] -> GSI 10 (level,
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:0e.1 to 64
logips2pp: Detected unknown logitech mouse model 62
hda_codec: Unknown model for AD1988, trying auto-probe from BIOS...
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input2
ALSA device list:
  #0: HDA NVidia at 0xfe020000 irq 10
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8183 buckets, 65464 max) - 204 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation
<jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
Time: tsc clocksource has been installed.
md: autorun ...
md: considering sdc1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md: created md1
md: bind<sdb1>
md: bind<sdc1>
md: running: <sdc1><sdb1>
raid1: raid set md1 active with 2 out of 2 mirrors
md: ... autorun DONE.
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 248k freed
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-2: found reiserfs format "3.6" with standard journal
ReiserFS: dm-2: using ordered data mode
ReiserFS: dm-2: journal params: device dm-2, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: dm-2: checking transaction log (dm-2)
ReiserFS: dm-2: Using r5 hash to sort names
NTFS volume version 3.1.
Adding 2097144k swap on /dev/storage/swap.  Priority:-1 extents:1
across:2097144k
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 11
ACPI: PCI Interrupt 0000:07:00.0[A] -> Link [LNK6] -> GSI 11 (level,
low) -> IRQ 11
PCI: Setting latency timer of device 0000:07:00.0 to 64
NVRM: loading NVIDIA Linux x86 Kernel Module  1.0-8776  Mon Oct 16
21:56:04 PDT 2006
eth1: Promiscuous mode enabled.
device eth1 entered promiscuous mode
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x42 frozen
ata1: (irq_stat 0x00b00090, PHY RDY changed)
ata1: waiting for device to spin up (8 secs)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
ata1.00: hard resetting port
ata1.00: SATA link down (SStatus 0 SControl 310)
ata1.01: hard resetting port
ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.02: hard resetting port
ata1.02: SATA link down (SStatus 0 SControl 300)
ata1.03: hard resetting port
ata1.03: SATA link down (SStatus 0 SControl 300)
ata1.04: hard resetting port
ata1.04: SATA link down (SStatus 0 SControl 300)
ata1.01: ATA-7, max UDMA7, 781422768 sectors: LBA48 NCQ (depth 31/32)
ata1.01: configured for UDMA/100
ata1: EH complete
  Vendor: ATA       Model: SAMSUNG HD401LJ   Rev: ZZ10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 0:0:1:0: Attached scsi disk sdd
sd 0:0:1:0: Attached scsi generic sg3 type 0
ReiserFS: sdd1: found reiserfs format "3.6" with standard journal
ReiserFS: sdd1: using ordered data mode
ReiserFS: sdd1: journal params: device sdd1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sdd1: checking transaction log (sdd1)
ReiserFS: sdd1: Using r5 hash to sort names
ata1.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x1 frozen
ata1.15: (irq_stat 0x08000800, SDB notify)
ata1.15: failed to read PMP GSCR[0] (errno=-16)
ata1.15: PMP revalidation failed (errno=-16)
ata1.15: retrying hardreset
ata1.15: hard resetting port
ata1.15: SATA link down (SStatus 1 SControl 300)
ata1.15: failed to read PMP GSCR[0] (errno=-16)
ata1.15: PMP revalidation failed (errno=-16)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting port
ata1.15: SATA link down (SStatus 1 SControl 300)
ata1.15: failed to read PMP GSCR[0] (errno=-16)
ata1.15: PMP revalidation failed (errno=-16)
ata1.15: failed to recover PMP after 3 resets, giving up
ata1.15: Port Multiplier detaching
ata1.01: disabled
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=4)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x41
ata1: (irq_stat 0x00a40080, device exchanged)
ata1: soft resetting port
ata1: SATA link down (SStatus 1 SControl 300)
ata1: EH complete
ata1.01: detaching (SCSI 0:0:1:0)
</dmesg>


<lspci>
00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
00:04.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
00:08.0 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a1)
00:09.0 ISA bridge: nVidia Corporation MCP55 LPC Bridge (rev a2)
00:09.1 SMBus: nVidia Corporation MCP55 SMBus (rev a2)
00:09.2 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a2)
00:0a.0 USB Controller: nVidia Corporation MCP55 USB Controller (rev a1)
00:0a.1 USB Controller: nVidia Corporation MCP55 USB Controller (rev a2)
00:0c.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1)
00:0d.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
00:0d.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
00:0d.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
00:0e.0 PCI bridge: nVidia Corporation Unknown device 0370 (rev a2)
00:0e.1 Audio device: nVidia Corporation MCP55 High Definition Audio
(rev a2)
00:10.0 Bridge: nVidia Corporation MCP55 Ethernet (rev a2)
00:11.0 Bridge: nVidia Corporation MCP55 Ethernet (rev a2)
00:12.0 PCI bridge: nVidia Corporation Unknown device 0376 (rev a2)
00:14.0 PCI bridge: nVidia Corporation Unknown device 0374 (rev a2)
00:16.0 PCI bridge: nVidia Corporation Unknown device 0375 (rev a2)
00:17.0 PCI bridge: nVidia Corporation Unknown device 0377 (rev a2)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
03:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link)
06:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA
Raid II Controller (rev 01)
07:00.0 VGA compatible controller: nVidia Corporation G70 [GeForce 7600
GT] (rev a1)
</lspci>

