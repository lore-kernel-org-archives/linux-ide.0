From: Bernardo Innocenti <bernie@develer.com>
Subject: SATA150 TX4 very slow writing
Date: Fri, 23 Jun 2006 05:37:08 +0200
Message-ID: <449B61E4.9060908@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 81-174-32-62.f5.ngi.it ([81.174.32.62]:5271 "EHLO develer.com")
	by vger.kernel.org with ESMTP id S933002AbWFWKar (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jun 2006 06:30:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

we're suffering very slow writing to disks attached to this PCI
controller:

 02:01.0 Mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)

The average speed is 4MB/s, with the system becoming unresponsive
on large copy operations.  Reading is normal (65-68MB/s) on all 4
SATA drives.

The motherboard also has an AHCI controller that works fine
both reading and writing.  The system is SMP (Pentium D), but
still running a 32bit kernel.  This card was used for over
one year on a different server, without any performance
problem.

Smells like some weird IRQ handling bug to me...  dmesg output
follows.  Please let me know if you need any additional
information.


Linux version 2.6.16-1.2133_FC5 (brewbuilder@hs20-bc2-2.build.redhat.com) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 Tue Jun 6 00:52:14 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009cc00 (usable)
 BIOS-e820: 000000000009cc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fee0000 (usable)
 BIOS-e820: 000000007fee0000 - 000000007fee9000 (ACPI data)
 BIOS-e820: 000000007fee9000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff00000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
1150MB HIGHMEM available.
895MB LOWMEM available.
found SMP MP-table at 000f6060
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 524000
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225279 pages, LIFO batch:31
  HighMem zone: 294625 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6030
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x7fee4008
ACPI: FADT (v001 INTEL           0x06040000 PTL  0x00000003) @ 0x7fee8eb4
ACPI: MCFG (v001 PTLTD    MCFG   0x06040000  LTP 0x00000000) @ 0x7fee8f28
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x7fee8f64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x7fee8fd8
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @ 0x7fee4040
ACPI: DSDT (v001  INTEL GLENWOOD 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:6 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:6 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec80000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Built 1 zonelists
Kernel command line: root=/dev/md0 video=vga vga=0x0F01 selinux=0 netconsole=6665@10.3.3.1/eth0,514@10.3.3.2/
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec80000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c03db000 soft=c03da000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2993.119 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2073096k/2096000k available (1943k kernel code, 21688k reserved, 773k data, 176k init, 1178500k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5997.63 BogoMIPS (lpj=11995268)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e43d 00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000e43d 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: After all inits, caps: bfebf3ff 20100000 00000000 00000180 0000e43d 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring handled by SMI
CPU: Intel(R) Pentium(R) D CPU 3.00GHz stepping 02
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking if image is initramfs... it is
Freeing initrd memory: 1062k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd897, last bus=10
PCI: Using MMCONFIG
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:0a:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.DEV1.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 10 11 14 15) *5
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:01:00.0
  IO window: 4000-4fff
  MEM window: ed200000-ed2fffff
  PREFETCH window: 88000000-880fffff
PCI: Bridge: 0000:00:01.0
  IO window: 4000-4fff
  MEM window: ed100000-ed2fffff
  PREFETCH window: 88000000-880fffff
PCI: Bridge: 0000:00:1c.0
  IO window: 5000-5fff
  MEM window: ed300000-ed3fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: 6000-6fff
  MEM window: ed400000-ed4fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: 7000-7fff
  MEM window: ed500000-ed5fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
  IO window: 8000-8fff
  MEM window: ed600000-ed6fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 9000-9fff
  MEM window: ed700000-eeffffff
  PREFETCH window: 88100000-881fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Simple Boot Flag at 0x37 set to 0x1
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1151031410.828:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key B90BB6BF503FCE2A
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
Allocate Port Service[0000:00:1c.3:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x30a0-0x30a7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-4571A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
PXHA EXP1 EXP2 EXP3 EXP4 PCIB KBC0 MSE0 USB1 USB2 USB3 USB4 EUSB 
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 176k freed
Write protecting the kernel read-only data: 359k
input: AT Translated Set 2 keyboard as /class/input/input0
SCSI subsystem initialized
libata version 1.20 loaded.
ahci 0000:00:1f.2: version 1.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
ata1: SATA max UDMA/133 cmd 0xF881C500 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xF881C580 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xF881C600 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF881C680 ctl 0x0 bmdma 0x0 irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023 88:003f
ata1: dev 0 ATA-6, max UDMA/100, 488397168 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023 88:003f
ata2: dev 0 ATA-6, max UDMA/100, 488397168 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023 88:003f
ata3: dev 0 ATA-6, max UDMA/100, 488397168 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : ahci
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata4: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : ahci
  Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 >
sd 1:0:0:0: Attached scsi disk sdb
  Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 < sdc5 >
sd 2:0:0:0: Attached scsi disk sdc
  Vendor: ATA       Model: ST3250624AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 < sdd5 >
sd 3:0:0:0: Attached scsi disk sdd
sata_promise 0000:02:01.0: version 1.03
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 20
ata5: SATA max UDMA/133 cmd 0xF882E200 ctl 0xF882E238 bmdma 0x0 irq 20
ata6: SATA max UDMA/133 cmd 0xF882E280 ctl 0xF882E2B8 bmdma 0x0 irq 20
ata7: SATA max UDMA/133 cmd 0xF882E300 ctl 0xF882E338 bmdma 0x0 irq 20
ata8: SATA max UDMA/133 cmd 0xF882E380 ctl 0xF882E3B8 bmdma 0x0 irq 20
ata5: SATA link up 1.5 Gbps (SStatus 113)
ata5: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata5: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata5: dev 0 configured for UDMA/133
scsi4 : sata_promise
ata6: SATA link up 1.5 Gbps (SStatus 113)
ata6: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata6: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata6: dev 0 configured for UDMA/133
scsi5 : sata_promise
ata7: SATA link up 1.5 Gbps (SStatus 113)
ata7: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata7: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata7: dev 0 configured for UDMA/133
scsi6 : sata_promise
ata8: SATA link up 1.5 Gbps (SStatus 113)
ata8: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata8: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata8: dev 0 configured for UDMA/133
scsi7 : sata_promise
  Vendor: ATA       Model: ST3250624AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
 sde: sde1 sde2 < sde5 >
sd 4:0:0:0: Attached scsi disk sde
  Vendor: ATA       Model: ST3250624AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
 sdf: sdf1 sdf2 < sdf5 >
sd 5:0:0:0: Attached scsi disk sdf
  Vendor: ATA       Model: ST3250624AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdg: 488397168 512-byte hdwr sectors (250059 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
SCSI device sdg: 488397168 512-byte hdwr sectors (250059 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
 sdg: sdg1 sdg2 < sdg5 >
sd 6:0:0:0: Attached scsi disk sdg
  Vendor: ATA       Model: ST3250624AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
 sdh: sdh1 sdh2 < sdh5 >
sd 7:0:0:0: Attached scsi disk sdh
md: raid1 personality registered for level 1
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
md: Autodetecting RAID arrays.
md: invalid raid superblock magic on sde1
md: sde1 has invalid sb, not importing!
md: invalid raid superblock magic on sdf1
md: sdf1 has invalid sb, not importing!
md: autorun ...
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with writeback data mode.
hw_random: RNG not detected
Intel(R) PRO/1000 Network Driver - version 6.3.9-k4-NAPI
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:03:00.0 to 64
e1000: 0000:03:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:57:27:68
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:04:00.0 to 64
e1000: 0000:04:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:57:27:69
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:06:00.0 to 64
e1000: 0000:06:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:57:27:6a
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:08:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:08:00.0 to 64
e1000: 0000:08:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:57:27:6b
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: Attached scsi generic sg3 type 0
sd 4:0:0:0: Attached scsi generic sg4 type 0
sd 5:0:0:0: Attached scsi generic sg5 type 0
sd 6:0:0:0: Attached scsi generic sg6 type 0
sd 7:0:0:0: Attached scsi generic sg7 type 0
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 21, io base 0x00003000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003020
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003060
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xed000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
Non-volatile memory driver v1.2
FDC 0 is a post-1991 82077
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
usb 1-1: device not accepting address 2, error -71
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: md1 stopped.
md: bind<sdb5>
md: bind<sdc5>
md: bind<sdd5>
md: bind<sda5>
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  4740.000 MB/sec
raid5: using function: pIII_sse (4740.000 MB/sec)
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: device sda5 operational as raid disk 0
raid5: device sdd5 operational as raid disk 3
raid5: device sdc5 operational as raid disk 2
raid5: device sdb5 operational as raid disk 1
raid5: allocated 4206kB for md1
raid5: raid level 5 set md1 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, o:1, dev:sda5
 disk 1, o:1, dev:sdb5
 disk 2, o:1, dev:sdc5
 disk 3, o:1, dev:sdd5
md: md2 stopped.
md: bind<sdf1>
md: bind<sde1>
raid1: raid set md2 active with 2 out of 2 mirrors
md: md3 stopped.
md: bind<sdf5>
md: bind<sdg5>
md: bind<sdh5>
md: bind<sde5>
md: md3: raid array is not clean -- starting background reconstruction
raid5: device sde5 operational as raid disk 0
raid5: device sdh5 operational as raid disk 3
raid5: device sdg5 operational as raid disk 2
raid5: device sdf5 operational as raid disk 1
raid5: allocated 4206kB for md3
raid5: raid level 5 set md3 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, o:1, dev:sde5
 disk 1, o:1, dev:sdf5
 disk 2, o:1, dev:sdg5
 disk 3, o:1, dev:sdh5
md: syncing RAID array md3
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for reconstruction.
md: using 128k window, over a total of 236372160 blocks.
md: resuming recovery of md3 from checkpoint.
md: md3: sync done.
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, o:1, dev:sde5
 disk 1, o:1, dev:sdf5
 disk 2, o:1, dev:sdg5
 disk 3, o:1, dev:sdh5
usb 1-1: new full speed USB device using uhci_hcd and address 4
usb 1-1: configuration #1 chosen from 1 choice
usb 3-2: new full speed USB device using uhci_hcd and address 2
usb 3-2: configuration #1 chosen from 1 choice
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0317
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
pl2303 3-2:1.0: pl2303 converter detected
usb 3-2: pl2303 converter now attached to ttyUSB0
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
Adding 7823612k swap on /dev/sdc1.  Priority:1 extents:1 across:7823612k
Adding 7823612k swap on /dev/sdd1.  Priority:1 extents:1 across:7823612k
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 232 bytes per conntrack
Ethernet Channel Bonding Driver: v3.0.1 (January 9, 2006)
bonding: MII link monitoring set to 100 ms
e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
bonding: bond0: enslaving eth0 as an active interface with an up link.
e1000: eth1: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
bonding: bond0: enslaving eth1 as an active interface with an up link.
e1000: eth2: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
bonding: bond0: enslaving eth2 as an active interface with an up link.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
bonding: bond0: link status definitely up for interface eth0.
bonding: bond0: link status definitely up for interface eth1.
bonding: bond0: link status definitely up for interface eth2.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
ADDRCONF(NETDEV_UP): eth3: link is not ready
e1000: eth3: e1000_watchdog_task: NIC Link is Up 10 Mbps Half Duplex
ADDRCONF(NETDEV_CHANGE): eth3: link becomes ready
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
bond0: no IPv6 routers present
eth0: no IPv6 routers present
eth2: no IPv6 routers present
eth1: no IPv6 routers present
eth3: no IPv6 routers present
netconsole: local port 6665
netconsole: local IP 10.3.3.1
netconsole: interface eth0
netconsole: remote port 514
netconsole: remote IP 10.3.3.2
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
netconsole: network logging started

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

