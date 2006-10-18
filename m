From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Problems writing with Samsung SH-W163A SATA CD/DVDRW
Date: Wed, 18 Oct 2006 10:19:49 +0100
Message-ID: <f4527be0610180219q6e5d316fif4c0b8c8a4d389c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:24461 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932155AbWJRJTv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Oct 2006 05:19:51 -0400
Received: by nf-out-0910.google.com with SMTP id c2so605169nfe
        for <linux-ide@vger.kernel.org>; Wed, 18 Oct 2006 02:19:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have a Samsung SH-W163A SATA CD/DVDRW connected to jmicron
20360/20363 onboard sata controller on Gigabyte GA-965P-DS3, running
kernel 2.6.18 with sr_mod loaded I can mount recorded/original disks
and read them, but if I try to burn a cd or dvd using cdrecord, and
somtimes when mounting media I get loads of errors in dmesg and the
burn fails.

Info from cdrecord dev=3DATAPI:0,0,0 -checkdrive:

Cdrecord-ProDVD-Clone 2.01.01a10 (i686-pc-linux-gnu) Copyright (C)
1995-2006 J=C3=B6rg Schilling
scsidev: 'ATAPI:0,0,0'
devname: 'ATAPI'
scsibus: 0 target: 0 lun: 0
Warning: Using ATA Packet interface.
Warning: The related Linux kernel interface code seems to be unmaintained.
Warning: There is absolutely NO DMA, operations thus are slow.
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 5
Response Format: 2
Capabilities   :
Vendor_info    : 'TSSTcorp'
Identifikation : 'CD/DVDW SH-W163A'
Revision       : 'TS01'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
Driver flags   : DVD MMC-3 SWABAUDIO BURNFREE
Supported modes: PACKET SAO

Here is full dmesg before trying to record a disk:

Linux version 2.6.18badb0y1 (root@beast) (gcc version 4.1.1 (Gentoo
4.1.1)) #14 SMP Sat Sep 30 14:40:34 BST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5340
On node 0 totalpages: 524272
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294896 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f6c80
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x7fff3040
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x7fff30c0
ACPI: MCFG (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x7fff7b80
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x7fff7a80
ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20040311) @ 0x7fff7c00
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20040311) @ 0x7fff8090
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)
Detected 2400.077 MHz processor.
Built 1 zonelists.  Total pages: 524272
Kernel command line:
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2074476k/2097088k available (2417k kernel code, 21384k
reserved, 914k data, 204k init, 1179584k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok=
.
Calibrating delay using timer specific routine.. 4802.67 BogoMIPS (lpj=3D24=
013353)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000
0000e3bd 00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000
0000e3bd 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000940
0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 16k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4800.12 BogoMIPS (lpj=3D24=
000631)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000
0000e3bd 00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000
0000e3bd 00000000 00000001
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000940
0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
Total of 2 processors activated (9602.79 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=3D16
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 *14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI: Bridge: 0000:00:01.0
  IO window: 6000-6fff
  MEM window: f4000000-f6ffffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 5000-5fff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
  IO window: 7000-8fff
  MEM window: f9000000-f90fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: 9000-9fff
  MEM window: f7000000-f8ffffff
  PREFETCH window: 88000000-880fffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: f9100000-f91fffff
  PREFETCH window: disabled.
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
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
JFS: nTxBlock =3D 8192, nTxLock =3D 65536
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
Allocate Port Service[0000:00:1c.3:pcie03]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
Allocate Port Service[0000:00:1c.4:pcie03]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [
Cpu1Ist] [20060707]
ACPI: Processor [CPU1] (supports 2 throttling states)
ACPI: Getting cpuindex for acpiid 0x2
ACPI: Getting cpuindex for acpiid 0x3
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
libata version 2.00 loaded.
ahci 0000:03:00.0: version 2.0
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:03:00.0 to 64
ahci 0000:03:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mod=
e
ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part
ata1: SATA max UDMA/133 cmd 0xF8CD4100 ctl 0x0 bmdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xF8CD4180 ctl 0x0 bmdma 0x0 irq 17
scsi0 : ahci
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 145223999 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI, max UDMA/33
ata2.00: applying bridge limits
ata2.00: configured for UDMA/33
  Vendor: ATA       Model: WDC WD740ADFD-00  Rev: 20.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: TSSTcorp  Model: CD/DVDW SH-W163A  Rev: TS01
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0xB400 ctl 0xB802 bmdma 0xC400 irq 17
ata4: SATA max UDMA/133 cmd 0xBC00 ctl 0xC002 bmdma 0xC408 irq 17
scsi2 : ata_piix
ata3.00: ATA-7, max UDMA7, 781420655 sectors: LBA48 NCQ (depth 0/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : ata_piix
ata4.00: ATA-7, max UDMA7, 781422768 sectors: LBA48 NCQ (depth 0/32)
ata4.00: ata4: dev 0 multi count 16
ata4.00: configured for UDMA/133
  Vendor: ATA       Model: SAMSUNG HD400LJ   Rev: ZZ10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG HD400LJ   Rev: ZZ10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ata5: SATA max UDMA/133 cmd 0xD000 ctl 0xD402 bmdma 0xE000 irq 17
ata6: SATA max UDMA/133 cmd 0xD800 ctl 0xDC02 bmdma 0xE008 irq 17
scsi4 : ata_piix
ata5.00: ATA-7, max UDMA7, 781422768 sectors: LBA48 NCQ (depth 0/32)
ata5.00: ata5: dev 0 multi count 16
ata5.00: configured for UDMA/133
scsi5 : ata_piix
ata6.00: ATA-7, max UDMA7, 781422768 sectors: LBA48 NCQ (depth 0/32)
ata6.00: ata6: dev 0 multi count 16
ata6.00: configured for UDMA/133
  Vendor: ATA       Model: SAMSUNG HD400LJ   Rev: ZZ10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG HD400LJ   Rev: ZZ10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 145223999 512-byte hdwr sectors (74355 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 145223999 512-byte hdwr sectors (74355 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 781420655 512-byte hdwr sectors (400087 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 781420655 512-byte hdwr sectors (400087 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 2:0:0:0: Attached scsi disk sdb
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: unknown partition table
sd 3:0:0:0: Attached scsi disk sdc
SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: unknown partition table
sd 4:0:0:0: Attached scsi disk sdd
SCSI device sde: 781422768 512-byte hdwr sectors (400088 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
SCSI device sde: 781422768 512-byte hdwr sectors (400088 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
 sde: unknown partition table
sd 5:0:0:0: Attached scsi disk sde
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf9205000
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 19, io mem 0xf9204000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000a000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 20, io base 0x0000a400
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.0: irq 19, io base 0x0000a800
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000ac00
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000b000
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usb 3-2: new full speed USB device using uhci_hcd and address 3
usb 3-2: configuration #1 chosen from 1 choice
usb 5-1: new low speed USB device using uhci_hcd and address 2
usb 5-1: configuration #1 chosen from 1 choice
usb 7-2: new low speed USB device using uhci_hcd and address 2
usb 7-2: configuration #1 chosen from 1 choice
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
raid6: int32x1    948 MB/s
raid6: int32x2    896 MB/s
raid6: int32x4    739 MB/s
raid6: int32x8    591 MB/s
raid6: mmxx1     3026 MB/s
raid6: mmxx2     3526 MB/s
raid6: sse1x1    2108 MB/s
raid6: sse1x2    2728 MB/s
raid6: sse2x1    3971 MB/s
raid6: sse2x2    4389 MB/s
raid6: using algorithm sse2x2 (4389 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  8780.400 MB/sec
raid5: using function: pIII_sse (8780.400 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: bitmap version 4.39
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 172 bytes per conntrac=
k
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: Unknown p4-clockmod-capable CPU. Please send an e-mail to
<linux@brodo.de>
p4-clockmod: Unknown p4-clockmod-capable CPU. Please send an e-mail to
<linux@brodo.de>
Starting balanced_irq
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Time: tsc clocksource has been installed.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda2: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 94469
ext3_orphan_cleanup: deleting unreferenced inode 94421
ext3_orphan_cleanup: deleting unreferenced inode 93720
ext3_orphan_cleanup: deleting unreferenced inode 93621
EXT3-fs: sda2: 4 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 204k freed
EXT3 FS on sda2, internal journal
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:04:00.0 to 64
sky2 v1.5 addr 0xf8000000 irq 16 Yukon-EC (0xb6) rev 2
sky2 eth0: addr 00:16:e6:59:d8:7b
Linux video capture interface: v2.00
saa7130/34: v4l2 driver version 0.2.14 loaded
ACPI: PCI Interrupt 0000:05:02.0[A] -> GSI 18 (level, low) -> IRQ 18
saa7134[0]: found at 0000:05:02.0, rev: 1, irq: 18, latency: 32, mmio:
0xf9101000
saa7134[0]: subsystem: 1461:2c05, board: AverTV DVB-T 777 [card=3D85,autode=
tected]
saa7134[0]: board init: gpio is 2f800
saa7134[0]: i2c eeprom 00: 61 14 05 2c 00 00 00 00 00 00 00 00 00 00 00 00
saa7134[0]: i2c eeprom 10: 00 ff 82 0e ff 20 ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 20: 01 40 01 02 02 03 03 01 08 ff 00 a8 ff ff ff ff
saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 40: ff 32 00 c0 86 1e ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: registered device video0 [v4l2]
saa7134[0]: registered device vbi0
saa7134[0]: avertv 777 dvb setup
DVB: registering new adapter (saa7134[0]).
DVB: registering frontend 0 (Zarlink MT352 DVB-T)...
saa7146: register extension 'budget_ci dvb'.
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 20 (level, low) -> IRQ 21
saa7146: found saa7146 @ mem f8e9a000 (revision 1, irq 21) (0x13c2,0x1017).
saa7146 (0): dma buffer size 192512
DVB: registering new adapter (TT-Budget/S-1500 PCI).
adapter has MAC addr =3D 00:d0:5c:07:97:6e
input: Budget-CI dvb ir receiver saa7146 (0) as /class/input/input0
budget_ci: CI interface initialised
dvb_ca adapter 1: DVB CAM detected and initialised successfully
DVB: registering frontend 1 (ST STV0299 DVB-S)...
input: eGalax Inc. USB TouchController as /class/input/input1
usbcore: registered new driver usbtouchscreen
input: Logitech USB Receiver as /class/input/input2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1a.0-1
input:    Wireless Keyboard/Mouse(2.4G) as /class/input/input3
input: USB HID v1.10 Keyboard [   Wireless Keyboard/Mouse(2.4G)] on
usb-0000:00:1d.2-2
input:    Wireless Keyboard/Mouse(2.4G) as /class/input/input4
input: USB HID v1.10 Mouse [   Wireless Keyboard/Mouse(2.4G)] on
usb-0000:00:1d.2-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
sr0: scsi3-mmc drive: 125x/125x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for
FTDI USB Serial Device
ftdi_sio 3-2:1.0: FTDI USB Serial Device converter detected
drivers/usb/serial/ftdi_sio.c: Detected FT232BM
usb 3-2: FTDI USB Serial Device converter now attached to ttyUSB0
usbcore: registered new driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver
md: raidstart(pid 3198) used deprecated START_ARRAY ioctl. This will
not be supported beyond July 2006
md: autorun ...
md: considering sde ...
md:  adding sde ...
md:  adding sdd ...
md:  adding sdc ...
md:  adding sdb ...
md: created md0
md: bind<sdb>
md: bind<sdc>
md: bind<sdd>
md: bind<sde>
md: running: <sde><sdd><sdc><sdb>
raid5: device sde operational as raid disk 3
raid5: device sdd operational as raid disk 2
raid5: device sdc operational as raid disk 1
raid5: device sdb operational as raid disk 0
raid5: allocated 4204kB for md0
raid5: raid level 5 set md0 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, o:1, dev:sdb
 disk 1, o:1, dev:sdc
 disk 2, o:1, dev:sdd
 disk 3, o:1, dev:sde
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 4000176k swap on /dev/sda3.  Priority:-1 extents:1 across:4000176k

If I try to record a dvd using cdrecord or any other app it will start
the process and then fail saying that the drive is not ready, and
there are loads of errors in dmesg:


ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x54 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x54 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: limiting speed to UDMA/25
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/25
ata2: EH complete
ata2.00: limiting speed to UDMA/16
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/16
ata2: EH complete
ata2.00: limiting speed to PIO4
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO4
ata2: EH complete
ata2.00: limiting speed to PIO3
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO3
ata2: EH complete
ata2.00: limiting speed to PIO2
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO2
ata2: EH complete
ata2.00: limiting speed to PIO1
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO1
ata2: EH complete
ata2.00: limiting speed to PIO0
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x68 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x54 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x54 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x20 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x68 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x54 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete


I have tested the drive in windows in the same machine and it records
cd and dvd's perfectly.

Is there any other info that would be helpful in diagnosing what is
going wrong here?

Andy
