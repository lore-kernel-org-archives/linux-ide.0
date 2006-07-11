From: "Christian Pernegger" <pernegger@gmail.com>
Subject: "Many lost ticks" while writing DVD-RAM
Date: Tue, 11 Jul 2006 19:46:37 +0200
Message-ID: <bb145bd20607111046g2514265hd28049c533185bc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:12234 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751150AbWGKRqk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jul 2006 13:46:40 -0400
Received: by ug-out-1314.google.com with SMTP id a2so4437573ugf
        for <linux-ide@vger.kernel.org>; Tue, 11 Jul 2006 10:46:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I got

Losing some ticks... checking if CPU frequency changed.
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip __do_softirq+0x48/0xd3

today while writing a large batch of data to an ext2 formatted
DVD-RAM. A bit of googling says this might be the IDE controller.

(Now the write hangs, at first I thought it was just slow, but 2 hours? Nah)

The board is an Intel SE7230NH1-E (ICH7R southbridge) I thought the
controller was supported but then, maybe not.

System info follows, just shout if you need anything more.

Thank you,

Christian


Kernel is vanilla 2.6.17.4+20060710 (x86_64)

lspci -vv

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corporation Unknown device 346a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 50
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 30b0 [size=16]


lsmod

Module                  Size  Used by
ext2                   74640  1
ipv6                  298016  20
thermal                20876  0
fan                     9736  0
button                 12448  0
processor              36616  1 thermal
ac                     10120  0
battery                15496  0
dm_mod                 67272  0
generic                 9860  0 [permanent]
i2c_i801               14100  0
psmouse                47628  0
serio_raw              12292  0
i2c_core               29184  1 i2c_i801
aic7xxx               174420  0
ehci_hcd               38024  0
piix                   15876  0 [permanent]
scsi_transport_spi     33664  1 aic7xxx
uhci_hcd               29336  0
3w_xxxx                32288  0
e1000                 121912  0
pcspkr                  7936  0
ide_cd                 47008  1
cdrom                  41784  1 ide_cd
ide_generic             5632  0 [permanent]
ide_core              157940  4 generic,piix,ide_cd,ide_generic
ext3                  145680  1
jbd                    67368  1 ext3
mbcache                14600  2 ext2,ext3
raid1                  27776  1
md_mod                 87448  4 raid1
sd_mod                 25984  2
ahci                   24196  2
libata                138272  1 ahci
scsi_mod              162584  6
aic7xxx,scsi_transport_spi,3w_xxxx,sd_mod,ahci,libata
evdev                  15872  0

dmesg:
Bootdata ok (command line is root=/dev/md_d0p1 ro elevator=deadline )
Linux version 2.6.17.4-99-em64t-p4-smp (chris@jesus) (gcc version
4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #1 SMP Tue Jul 11
15:21:44 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fe71000 (usable)
 BIOS-e820: 000000007fe71000 - 000000007fee9000 (ACPI NVS)
 BIOS-e820: 000000007fee9000 - 000000007feed000 (usable)
 BIOS-e820: 000000007feed000 - 000000007feff000 (ACPI data)
 BIOS-e820: 000000007feff000 - 000000007ff00000 (usable)
DMI 2.3 present.
ACPI: RSDP (v000 INTEL                                 ) @ 0x00000000000fe020
ACPI: RSDT (v001 INTEL  04DT044  0x000002a2 MSFT 0x01000013) @
0x000000007fefde48
ACPI: FADT (v001 INTEL  04DT044  0x000002a2 MSFT 0x01000013) @
0x000000007fefcf10
ACPI: MADT (v001 INTEL  04DT044  0x000002a2 MSFT 0x01000013) @
0x000000007fefce10
ACPI: WDDT (v001 INTEL  04DT044  0x000002a2 MSFT 0x01000013) @
0x000000007fef7f90
ACPI: MCFG (v001 INTEL  04DT044  0x000002a2 MSFT 0x01000013) @
0x000000007fef7f10
ACPI: ASF! (v032 INTEL  04DT044  0x000002a2 MSFT 0x01000013) @
0x000000007fefcd10
ACPI: DSDT (v001 INTEL  04DT044  0x000002a2 MSFT 0x01000013) @
0x0000000000000000
On node 0 totalpages: 515545
  DMA zone: 2855 pages, LIFO batch:0
  DMA32 zone: 512690 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:6 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:6 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x05] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 5, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7ff00000:80100000)
Checking aperture...
SMP: Allowing 4 CPUs, 2 hotplug CPUs
Built 1 zonelists
Kernel command line: root=/dev/md_d0p1 ro elevator=deadline
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 2992.575 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2057088k/2096128k available (1838k kernel code, 37768k
reserved, 847k data, 148k init)
Calibrating delay using timer specific routine.. 5990.53 BogoMIPS (lpj=11981060)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
Using local APIC timer interrupts.
result 12468993
Detected 12.468 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5985.53 BogoMIPS (lpj=11971078)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) D CPU 3.00GHz stepping 02
APIC error on CPU1: 00(40)
Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=1039
checking if image is initramfs... it is
Freeing initrd memory: 1446k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:04.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: ACPI device : hid PNP0A03
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0800
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0303
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0003
pnp: PnP ACPI: found 10 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI-DMA: Disabling IOMMU.
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: match found with the PnP device '00:06' and the driver 'system'
pnp: 00:06: ioport range 0x500-0x53f has been reserved
pnp: 00:06: ioport range 0x400-0x47f could not be reserved
pnp: 00:06: ioport range 0x680-0x6ff has been reserved
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
  IO window: 2000-2fff
  MEM window: 88900000-889fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: 88000000-888fffff
  PREFETCH window: 80000000-87ffffff
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.4 to 64
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1152635185.852:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
Allocate Port Service[0000:00:1c.5:pcie02]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:08' and the driver 'serial'
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
isa bounce pool size: 16 pages
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
usbmon: debugfs is not available
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:07' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices:
SLPB  P32 UAR1 PEX0 PEX1 PEX2 PEX3 PEX4 PEX5 UHC1 UHC2 UHC3 UHC4 EHCI AC9M AZAL
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 148k freed
SCSI subsystem initialized
libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
GSI 18 sharing vector 0xD9 and IRQ 18
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 217
input: AT Translated Set 2 keyboard as /class/input/input0
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part
ata1: SATA max UDMA/133 cmd 0xFFFFC20000002100 ctl 0x0 bmdma 0x0 irq 225
ata2: SATA max UDMA/133 cmd 0xFFFFC20000002180 ctl 0x0 bmdma 0x0 irq 225
ata3: SATA max UDMA/133 cmd 0xFFFFC20000002200 ctl 0x0 bmdma 0x0 irq 225
ata4: SATA max UDMA/133 cmd 0xFFFFC20000002280 ctl 0x0 bmdma 0x0 irq 225
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi2 : ahci
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : ahci
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
ata4.00: ata4: dev 0 multi count 16
ata4.00: configured for UDMA/133
  Vendor: ATA       Model: WDC WD5000YS-01M  Rev: 07.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD5000YS-01M  Rev: 07.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD5000YS-01M  Rev: 07.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD5000YS-01M  Rev: 07.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda:
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb:
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 sdd3
sd 3:0:0:0: Attached scsi disk sdd
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
md: raid1 personality registered for level 1
md: md_d0 stopped.
md: bind<sdd>
md: bind<sdc>
raid1: raid set md_d0 active with 2 out of 2 mirrors
md_d0: bitmap initialized from disk: read 15/15 pages, set 24 bits, status: 0
created bitmap (233 pages) for device md_d0
 md_d0: p1 p2 p3
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
pnp: the driver 'ide' has been registered
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-4570A, ATAPI CD/DVD-ROM drive
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
Intel(R) PRO/1000 Network Driver - version 7.0.33-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:03:00.0 to 64
3ware Storage Controller device driver for Linux v1.26.02.001.
USB Universal Host Controller Interface driver v3.0
e1000: 0000:03:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:16:76:73:c4:27
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 17 (level, low) -> IRQ 169
e1000: 0000:04:05.0: e1000_probe: (PCI:33MHz:32-bit) 00:16:76:73:c4:28
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
GSI 19 sharing vector 0xE9 and IRQ 19
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 22 (level, low) -> IRQ 233
scsi4 : 3ware Storage Controller
3w-xxxx: scsi4: Found a 3ware Storage Controller at 0x1240, IRQ: 233.
ICH7: IDE controller at PCI slot 0000:00:1f.1
GSI 20 sharing vector 0x32 and IRQ 20
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 50
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
ICH7: port 0x01f0 already claimed by ide0
ICH7: neither IDE port enabled (BIOS)
GSI 21 sharing vector 0x3A and IRQ 21
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 58, io base 0x00003080
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 217, io base 0x00003060
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 50, io base 0x00003040
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 177, io base 0x00003020
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
GSI 22 sharing vector 0x42 and IRQ 22
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 21 (level, low) -> IRQ 66
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 58, io mem 0x88a00400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
scsi5 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

hw_random: RNG not detected
Adding 3999996k swap on /dev/md_d0p2.  Priority:-1 extents:1 across:3999996k
EXT3 FS on md_d0p1, internal journal
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
Losing some ticks... checking if CPU frequency changed.
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip __do_softirq+0x48/0xd3
