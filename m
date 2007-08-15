From: Ethan Sommer <sommere@gac.edu>
Subject: booting from MD raid using libata
Date: Wed, 15 Aug 2007 08:06:47 -0500
Message-ID: <46C2FA67.5060005@gac.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060308050507030202090008"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wraith.gac.edu ([138.236.128.65]:48185 "EHLO wraith.gac.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755830AbXHONgq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 09:36:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: htejun@gmail.com

This is a multi-part message in MIME format.
--------------060308050507030202090008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've been trying to diagnose a problem we've been having for a few days 
and I think I've found the problem. (I'm hoping you might have the 
solution.)

I have a system which has a intel 965 MB and a couple SIL based SATA 
cards one of which is hooked up to a few PMPs.

If I try to boot the system normally after installing the libata-tj 
patch, it can't find the root partition because MD can't find any raid 
devices because the kernel hasn't detected the SATA partitions yet.

If I turn the system drive to "legacy" mode in the kernel, then it 
detects the partitions on hda and hdc but not on sda-sdX, then it 
detects raid devices, then it detects the partitions on sda-sdX. So, I 
think the ordering of these steps is the problem.

The system is unusably slow if I have the system disks in legacy mode. 
I've attached /var/log/dmesg.

Ethan

-- 
Ethan Sommer
Systems Administrator
Gustavus Adolphus College
507-933-7042
sommere@gustavus.edu


--------------060308050507030202090008
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.22.1-GAC2 (root@supertanker.gac.edu) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-52)) #5 SMP Tue Aug 14 18:34:12 CDT 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000008f000 (usable)
 BIOS-e820: 000000000008f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cf599000 (usable)
 BIOS-e820: 00000000cf599000 - 00000000cf5a6000 (reserved)
 BIOS-e820: 00000000cf5a6000 - 00000000cf64e000 (usable)
 BIOS-e820: 00000000cf64e000 - 00000000cf6a6000 (ACPI NVS)
 BIOS-e820: 00000000cf6a6000 - 00000000cf6ab000 (ACPI data)
 BIOS-e820: 00000000cf6ab000 - 00000000cf6f2000 (ACPI NVS)
 BIOS-e820: 00000000cf6f2000 - 00000000cf6f3000 (usable)
 BIOS-e820: 00000000cf6f3000 - 00000000cf6ff000 (ACPI data)
 BIOS-e820: 00000000cf6ff000 - 00000000cf700000 (usable)
 BIOS-e820: 00000000cf700000 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 000000012c000000 (usable)
3904MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe200
NX (Execute Disable) protection: active
Entering add_active_range(0, 0, 1228800) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->  1228800
early_node_map[1] active PFN ranges
    0:        0 ->  1228800
On node 0 totalpages: 1228800
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 7808 pages used for memmap
  HighMem zone: 991616 pages, LIFO batch:31
DMI 2.4 present.
Using APIC driver default
ACPI: RSDP 000FE020, 0014 (r0 INTEL )
ACPI: RSDT CF6FD038, 004C (r1 INTEL  DG965SS       697       1000013)
ACPI: FACP CF6FC000, 0074 (r1 INTEL  DG965SS       697 MSFT  1000013)
ACPI: DSDT CF6F7000, 40ED (r1 INTEL  DG965SS       697 MSFT  1000013)
ACPI: FACS CF6AB000, 0040
ACPI: APIC CF6F6000, 0078 (r1 INTEL  DG965SS       697 MSFT  1000013)
ACPI: WDDT CF6F5000, 0040 (r1 INTEL  DG965SS       697 MSFT  1000013)
ACPI: MCFG CF6F4000, 003C (r1 INTEL  DG965SS       697 MSFT  1000013)
ACPI: ASF! CF6F3000, 00A6 (r32 INTEL  DG965SS       697 MSFT  1000013)
ACPI: SSDT CF6AA000, 01BC (r1 INTEL     CpuPm      697 MSFT  1000013)
ACPI: SSDT CF6A9000, 0175 (r1 INTEL   Cpu0Ist      697 MSFT  1000013)
ACPI: SSDT CF6A8000, 0175 (r1 INTEL   Cpu1Ist      697 MSFT  1000013)
ACPI: SSDT CF6A7000, 0175 (r1 INTEL   Cpu2Ist      697 MSFT  1000013)
ACPI: SSDT CF6A6000, 0175 (r1 INTEL   Cpu3Ist      697 MSFT  1000013)
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at d4000000 (gap: d0000000:2ff00000)
Built 1 zonelists.  Total pages: 1219200
Kernel command line: ro root=/dev/md1
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c07bf000 soft=c079f000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1864.908 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 4072372k/4915200k available (2379k kernel code, 45104k reserved, 1025k data, 260k init, 3201292k highmem)
virtual kernel memory layout:
    fixmap  : 0xffc56000 - 0xfffff000   (3748 kB)
    pkmap   : 0xffa00000 - 0xffc00000   (2048 kB)
    vmalloc : 0xf8800000 - 0xff9fe000   ( 113 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0759000 - 0xc079a000   ( 260 kB)
      .data : 0xc0652e29 - 0xc0753384   (1025 kB)
      .text : 0xc0400000 - 0xc0652e29   (2379 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3731.20 BogoMIPS (lpj=1865601)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940 0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
CPU0: Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz stepping 06
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c07c0000 soft=c07a0000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3729.09 BogoMIPS (lpj=1864546)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940 0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz stepping 06
Total of 2 processors activated (7460.29 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
migration_cost=54
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:01: iomem range 0xf0000000-0xf7ffffff has been reserved
pnp: 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
pnp: 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
pnp: 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
Time: tsc clocksource has been installed.
pnp: 00:06: ioport range 0x500-0x53f has been reserved
pnp: 00:06: ioport range 0x400-0x47f has been reserved
pnp: 00:06: ioport range 0x680-0x6ff has been reserved
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: 3000-3fff
  MEM window: e0200000-e02fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
  IO window: 2000-2fff
  MEM window: e0100000-e01fffff
  PREFETCH window: e0500000-e05fffff
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: e0000000-e00fffff
  PREFETCH window: e0600000-e06fffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.4 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1291k freed
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
audit: initializing netlink socket (disabled)
audit(1187178454.720:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:00:02.0
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
agpgart: Detected an Intel 965G Chipset.
agpgart: Detected 7676K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: WDC WD4000YR-01PLB0, ATA DISK drive
Probing IDE interface ide1...
hdc: WDC WD4000YR-01PLB0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 781422768 sectors (400088 MB) w/16384KiB Cache, CHS=48641/255/63
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdc: max request size: 512KiB
hdc: 781422768 sectors (400088 MB) w/16384KiB Cache, CHS=48641/255/63
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 >
ide-floppy driver 0.99.newide
ata_piix 0000:00:1f.2: version 2.11
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
ata_piix 0000:00:1f.2: failed to request/iomap BARs for port 0 (errno=-16)
PCI: Unable to reserve I/O region #3:8@170 for device 0000:00:1f.2
ata_piix 0000:00:1f.2: failed to request/iomap BARs for port 1 (errno=-16)
ata_piix 0000:00:1f.2: no available native port
ata_piix 0000:00:1f.5: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.5[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.5 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x00014428 ctl 0x0001444e bmdma 0x000140f0 irq 19
ata2: SATA max UDMA/133 cmd 0x00014420 ctl 0x0001444a bmdma 0x000140f8 irq 19
ata1.00: ATA-7: HDS724040KLSA80, KFAOA46A, max UDMA/133
ata1.00: 781422768 sectors, multi 16: LBA48 
ata1.00: configured for UDMA/133
ata2.00: ATA-7: HDS724040KLSA80, KFAOA46A, max UDMA/133
ata2.00: 781422768 sectors, multi 16: LBA48 
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 1:0:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
sata_promise 0000:06:00.0: version 2.09
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 21 (level, low) -> IRQ 20
scsi2 : sata_promise
scsi3 : sata_promise
scsi4 : sata_promise
ata3: SATA max UDMA/133 cmd 0xf882a200 ctl 0xf882a238 bmdma 0x00000000 irq 20
ata4: SATA max UDMA/133 cmd 0xf882a280 ctl 0xf882a2b8 bmdma 0x00000000 irq 20
ata5: PATA max UDMA/133 cmd 0xf882a300 ctl 0xf882a338 bmdma 0x00000000 irq 20
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7: HDS724040KLSA80, KFAOA32A, max UDMA/133
ata3.00: 781422768 sectors, multi 0: LBA48 
ata3.00: configured for UDMA/133
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7: HDS724040KLSA80, KFAOA32A, max UDMA/133
ata4.00: 781422768 sectors, multi 0: LBA48 
ata4.00: configured for UDMA/133
ata5.00: ATAPI: PIONEER DVD-RW  DVR-112D, 1.15, max UDMA/66
ata5.00: configured for UDMA/66
scsi 2:0:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 3:0:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 4:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-112D 1.15 PQ: 0 ANSI: 5
sata_sil24 0000:04:00.0: version 1.0
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:04:00.0 to 64
scsi5 : sata_sil24
scsi6 : sata_sil24
ata6: SATA max UDMA/100 cmd 0xf8830000 ctl 0x00000000 bmdma 0x00000000 irq 19
ata7: SATA max UDMA/100 cmd 0xf8832000 ctl 0x00000000 bmdma 0x00000000 irq 19
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata6.00: ATA-7: HDS724040KLSA80, KFAOA46A, max UDMA/133
ata6.00: 781422768 sectors, multi 16: LBA48 
ata6.00: configured for UDMA/100
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata7.00: hard resetting link
ata7.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata7.01: hard resetting link
ata7.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata7.02: hard resetting link
ata7.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata7.03: hard resetting link
ata7.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata7.04: hard resetting link
ata7.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata7.05: hard resetting link
ata7.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata7.00: ATA-7: HDS724040KLSA80, KFAOA46A, max UDMA/133
ata7.00: 781422768 sectors, multi 16: LBA48 
ata7.00: configured for UDMA/100
ata7.01: ATA-7: HDS724040KLSA80, KFAOA46A, max UDMA/133
ata7.01: 781422768 sectors, multi 0: LBA48 
ata7.01: configured for UDMA/100
ata7.02: ATA-7: WDC WD4000YR-01PLB0, 01.06A01, max UDMA/133
ata7.02: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata7.02: configured for UDMA/100
ata7.03: ATA-7: HDS724040KLSA80, KFAOA46A, max UDMA/133
ata7.03: 781422768 sectors, multi 0: LBA48 
ata7.03: configured for UDMA/100
ata7.04: ATA-7: HDS724040KLSA80, KFAOA46A, max UDMA/133
ata7.04: 781422768 sectors, multi 0: LBA48 
ata7.04: configured for UDMA/100
ata7: EH complete
scsi 5:0:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 6:0:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 6:1:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 6:2:0:0: Direct-Access     ATA      WDC WD4000YR-01P 01.0 PQ: 0 ANSI: 5
scsi 6:3:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 6:4:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
ACPI: PCI Interrupt 0000:06:01.0[A] -> GSI 22 (level, low) -> IRQ 21
scsi7 : sata_sil24
scsi8 : sata_sil24
scsi9 : sata_sil24
scsi10 : sata_sil24
ata8: SATA max UDMA/100 cmd 0xf8840000 ctl 0x00000000 bmdma 0x00000000 irq 21
ata9: SATA max UDMA/100 cmd 0xf8842000 ctl 0x00000000 bmdma 0x00000000 irq 21
ata10: SATA max UDMA/100 cmd 0xf8844000 ctl 0x00000000 bmdma 0x00000000 irq 21
ata11: SATA max UDMA/100 cmd 0xf8846000 ctl 0x00000000 bmdma 0x00000000 irq 21
ata8: SATA link down (SStatus 0 SControl 0)
ata9: SATA link down (SStatus 0 SControl 0)
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata10.00: hard resetting link
ata10.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.01: hard resetting link
ata10.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.02: hard resetting link
ata10.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.03: hard resetting link
ata10.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.04: hard resetting link
ata10.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.05: hard resetting link
ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.00: ATA-7: HDS724040KLSA80, KFAOA32A, max UDMA/133
ata10.00: 781422768 sectors, multi 16: LBA48 
ata10.00: configured for UDMA/100
ata10.01: ATA-7: HDS724040KLSA80, KFAOA32A, max UDMA/133
ata10.01: 781422768 sectors, multi 0: LBA48 
ata10.01: configured for UDMA/100
ata10.02: ATA-7: HDS724040KLSA80, KFAOA46A, max UDMA/133
ata10.02: 781422768 sectors, multi 0: LBA48 
ata10.02: configured for UDMA/100
ata10.03: ATA-7: HDS724040KLSA80, KFAOA46A, max UDMA/133
ata10.03: 781422768 sectors, multi 0: LBA48 
ata10.03: configured for UDMA/100
ata10.04: ATA-7: HDS724040KLSA80, KFAOA32A, max UDMA/133
ata10.04: 781422768 sectors, multi 0: LBA48 
ata10.04: configured for UDMA/100
ata10: EH complete
ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata11.00: ATA-7: HDS724040KLSA80, KFAOA46A, max UDMA/133
ata11.00: 781422768 sectors, multi 16: LBA48 
ata11.00: configured for UDMA/100
scsi 9:0:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 9:1:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 9:2:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 9:3:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 9:4:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
scsi 10:0:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
speedstep-centrino with X86_SPEEDSTEP_CENTRINO_ACPI config is deprecated.
 Use X86_ACPI_CPUFREQ (acpi-cpufreq) instead.
speedstep-centrino with X86_SPEEDSTEP_CENTRINO_ACPI config is deprecated.
 Use X86_ACPI_CPUFREQ (acpi-cpufreq) instead.
Using IPI No-Shortcut mode
Freeing unused kernel memory: 260k freed
Write protecting the kernel read-only data: 756k
input: AT Translated Set 2 keyboard as /class/input/input0
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1a.0: irq 17, io base 0x000040a0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1a.1: irq 20, io base 0x00004080
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.0: irq 22, io base 0x00004060
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00004040
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00004020
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 6
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xe0425400
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 22, io mem 0xe0425000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 6 ports detected
md: raid1 personality registered for level 1
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdc7 ...
md:  adding hdc7 ...
md: hdc6 has different UUID to hdc7
md: hdc5 has different UUID to hdc7
md: hdc3 has different UUID to hdc7
md: hdc2 has different UUID to hdc7
md: hdc1 has different UUID to hdc7
md:  adding hda7 ...
md: hda6 has different UUID to hdc7
md: hda5 has different UUID to hdc7
md: hda3 has different UUID to hdc7
md: hda2 has different UUID to hdc7
md: hda1 has different UUID to hdc7
md: created md5
md: bind<hda7>
md: bind<hdc7>
md: running: <hdc7><hda7>
raid1: raid set md5 active with 2 out of 2 mirrors
md: considering hdc6 ...
md:  adding hdc6 ...
md: hdc5 has different UUID to hdc6
md: hdc3 has different UUID to hdc6
md: hdc2 has different UUID to hdc6
md: hdc1 has different UUID to hdc6
md:  adding hda6 ...
md: hda5 has different UUID to hdc6
md: hda3 has different UUID to hdc6
md: hda2 has different UUID to hdc6
md: hda1 has different UUID to hdc6
md: created md4
md: bind<hda6>
md: bind<hdc6>
md: running: <hdc6><hda6>
raid1: raid set md4 active with 2 out of 2 mirrors
md: considering hdc5 ...
md:  adding hdc5 ...
md: hdc3 has different UUID to hdc5
md: hdc2 has different UUID to hdc5
md: hdc1 has different UUID to hdc5
md:  adding hda5 ...
md: hda3 has different UUID to hdc5
md: hda2 has different UUID to hdc5
md: hda1 has different UUID to hdc5
md: created md3
md: bind<hda5>
md: bind<hdc5>
md: running: <hdc5><hda5>
raid1: raid set md3 active with 2 out of 2 mirrors
md: considering hdc3 ...
md:  adding hdc3 ...
md: hdc2 has different UUID to hdc3
md: hdc1 has different UUID to hdc3
md:  adding hda3 ...
md: hda2 has different UUID to hdc3
md: hda1 has different UUID to hdc3
md: created md2
md: bind<hda3>
md: bind<hdc3>
md: running: <hdc3><hda3>
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering hdc2 ...
md:  adding hdc2 ...
md: hdc1 has different UUID to hdc2
md:  adding hda2 ...
md: hda1 has different UUID to hdc2
md: created md1
md: bind<hda2>
md: bind<hdc2>
md: running: <hdc2><hda2>
raid1: raid set md1 active with 2 out of 2 mirrors
md: considering hdc1 ...
md:  adding hdc1 ...
md:  adding hda1 ...
md: created md0
md: bind<hda1>
md: bind<hdc1>
md: running: <hdc1><hda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1187178483.650:2): selinux=0 auid=4294967295
sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
sd 1:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 2:0:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 2:0:0:0: [sdc] Attached SCSI disk
sd 3:0:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 3:0:0:0: [sdd] Attached SCSI disk
sd 5:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
sd 5:0:0:0: [sde] Write Protect is off
sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
sd 5:0:0:0: [sde] Write Protect is off
sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1
sd 5:0:0:0: [sde] Attached SCSI disk
sd 6:0:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
sd 6:0:0:0: [sdf] Write Protect is off
sd 6:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 6:0:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
sd 6:0:0:0: [sdf] Write Protect is off
sd 6:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1
sd 6:0:0:0: [sdf] Attached SCSI disk
sd 6:1:0:0: [sdg] 781422768 512-byte hardware sectors (400088 MB)
sd 6:1:0:0: [sdg] Write Protect is off
sd 6:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 6:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 6:1:0:0: [sdg] 781422768 512-byte hardware sectors (400088 MB)
sd 6:1:0:0: [sdg] Write Protect is off
sd 6:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 6:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdg: sdg1
sd 6:1:0:0: [sdg] Attached SCSI disk
sd 6:2:0:0: [sdh] 781422768 512-byte hardware sectors (400088 MB)
sd 6:2:0:0: [sdh] Write Protect is off
sd 6:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 6:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 6:2:0:0: [sdh] 781422768 512-byte hardware sectors (400088 MB)
sd 6:2:0:0: [sdh] Write Protect is off
sd 6:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 6:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdh: sdh1
sd 6:2:0:0: [sdh] Attached SCSI disk
sd 6:3:0:0: [sdi] 781422768 512-byte hardware sectors (400088 MB)
sd 6:3:0:0: [sdi] Write Protect is off
sd 6:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 6:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 6:3:0:0: [sdi] 781422768 512-byte hardware sectors (400088 MB)
sd 6:3:0:0: [sdi] Write Protect is off
sd 6:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 6:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdi: sdi1
sd 6:3:0:0: [sdi] Attached SCSI disk
sd 6:4:0:0: [sdj] 781422768 512-byte hardware sectors (400088 MB)
sd 6:4:0:0: [sdj] Write Protect is off
sd 6:4:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 6:4:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 6:4:0:0: [sdj] 781422768 512-byte hardware sectors (400088 MB)
sd 6:4:0:0: [sdj] Write Protect is off
sd 6:4:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 6:4:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdj: sdj1
sd 6:4:0:0: [sdj] Attached SCSI disk
sd 9:0:0:0: [sdk] 781422768 512-byte hardware sectors (400088 MB)
sd 9:0:0:0: [sdk] Write Protect is off
sd 9:0:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:0:0:0: [sdk] 781422768 512-byte hardware sectors (400088 MB)
sd 9:0:0:0: [sdk] Write Protect is off
sd 9:0:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdk: sdk1
sd 9:0:0:0: [sdk] Attached SCSI disk
sd 9:1:0:0: [sdl] 781422768 512-byte hardware sectors (400088 MB)
sd 9:1:0:0: [sdl] Write Protect is off
sd 9:1:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 9:1:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:1:0:0: [sdl] 781422768 512-byte hardware sectors (400088 MB)
sd 9:1:0:0: [sdl] Write Protect is off
sd 9:1:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 9:1:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdl: sdl1
sd 9:1:0:0: [sdl] Attached SCSI disk
sd 9:2:0:0: [sdm] 781422768 512-byte hardware sectors (400088 MB)
sd 9:2:0:0: [sdm] Write Protect is off
sd 9:2:0:0: [sdm] Mode Sense: 00 3a 00 00
sd 9:2:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:2:0:0: [sdm] 781422768 512-byte hardware sectors (400088 MB)
sd 9:2:0:0: [sdm] Write Protect is off
sd 9:2:0:0: [sdm] Mode Sense: 00 3a 00 00
sd 9:2:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdm: sdm1
sd 9:2:0:0: [sdm] Attached SCSI disk
sd 9:3:0:0: [sdn] 781422768 512-byte hardware sectors (400088 MB)
sd 9:3:0:0: [sdn] Write Protect is off
sd 9:3:0:0: [sdn] Mode Sense: 00 3a 00 00
sd 9:3:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:3:0:0: [sdn] 781422768 512-byte hardware sectors (400088 MB)
sd 9:3:0:0: [sdn] Write Protect is off
sd 9:3:0:0: [sdn] Mode Sense: 00 3a 00 00
sd 9:3:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdn: sdn1
sd 9:3:0:0: [sdn] Attached SCSI disk
sd 9:4:0:0: [sdo] 781422768 512-byte hardware sectors (400088 MB)
sd 9:4:0:0: [sdo] Write Protect is off
sd 9:4:0:0: [sdo] Mode Sense: 00 3a 00 00
sd 9:4:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:4:0:0: [sdo] 781422768 512-byte hardware sectors (400088 MB)
sd 9:4:0:0: [sdo] Write Protect is off
sd 9:4:0:0: [sdo] Mode Sense: 00 3a 00 00
sd 9:4:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdo: sdo1
sd 9:4:0:0: [sdo] Attached SCSI disk
sd 10:0:0:0: [sdp] 781422768 512-byte hardware sectors (400088 MB)
sd 10:0:0:0: [sdp] Write Protect is off
sd 10:0:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 10:0:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 10:0:0:0: [sdp] 781422768 512-byte hardware sectors (400088 MB)
sd 10:0:0:0: [sdp] Write Protect is off
sd 10:0:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 10:0:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdp: sdp1
sd 10:0:0:0: [sdp] Attached SCSI disk
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 4:0:0:0: Attached scsi CD-ROM sr0
parport_pc 00:08: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
scsi11 : pata_marvell
scsi12 : pata_marvell
ata12: PATA max UDMA/100 cmd 0x00013018 ctl 0x00013026 bmdma 0x00013000 irq 16
ata13: DUMMY
BAR5:00:00 01:7F 02:22 03:CA 04:00 05:00 06:00 07:00 08:00 09:00 0A:00 0B:00 0C:01 0D:00 0E:00 0F:00 
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 21 (level, low) -> IRQ 20
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:00:19.0[A] -> GSI 20 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:19.0 to 64
e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:16:76:be:b9:65
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: Attached scsi generic sg3 type 0
sr 4:0:0:0: Attached scsi generic sg4 type 5
sd 5:0:0:0: Attached scsi generic sg5 type 0
sd 6:0:0:0: Attached scsi generic sg6 type 0
sd 6:1:0:0: Attached scsi generic sg7 type 0
sd 6:2:0:0: Attached scsi generic sg8 type 0
sd 6:3:0:0: Attached scsi generic sg9 type 0
sd 6:4:0:0: Attached scsi generic sg10 type 0
sd 9:0:0:0: Attached scsi generic sg11 type 0
sd 9:1:0:0: Attached scsi generic sg12 type 0
sd 9:2:0:0: Attached scsi generic sg13 type 0
sd 9:3:0:0: Attached scsi generic sg14 type 0
sd 9:4:0:0: Attached scsi generic sg15 type 0
sd 10:0:0:0: Attached scsi generic sg16 type 0
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1b.0 to 64
lp0: using parport0 (interrupt-driven).
lp0: console ready
input: Power Button (FF) as /class/input/input1
ACPI: Power Button (FF) [PWRF]
input: Sleep Button (CM) as /class/input/input2
ACPI: Sleep Button (CM) [SLPB]
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdp1 ...
md:  adding sdp1 ...
md:  adding sdo1 ...
md:  adding sdn1 ...
md:  adding sdm1 ...
md:  adding sdl1 ...
md:  adding sdk1 ...
md:  adding sdj1 ...
md:  adding sdi1 ...
md:  adding sdh1 ...
md:  adding sdg1 ...
md:  adding sdf1 ...
md:  adding sde1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md10
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
md: bind<sdf1>
md: bind<sdg1>
md: bind<sdh1>
md: bind<sdi1>
md: bind<sdj1>
md: bind<sdk1>
md: bind<sdl1>
md: bind<sdm1>
md: bind<sdn1>
md: bind<sdo1>
md: bind<sdp1>
md: running: <sdp1><sdo1><sdn1><sdm1><sdl1><sdk1><sdj1><sdi1><sdh1><sdg1><sdf1><sde1><sdd1><sdc1><sdb1><sda1>
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :    28.000 MB/sec
raid5: using function: pIII_sse (28.000 MB/sec)
raid6: int32x1      3 MB/s
raid6: int32x2      3 MB/s
raid6: int32x4      3 MB/s
raid6: int32x8      3 MB/s
raid6: mmxx1        7 MB/s
raid6: mmxx2        7 MB/s
raid6: sse1x1       7 MB/s
raid6: sse1x2       7 MB/s
raid6: sse2x1      11 MB/s
raid6: sse2x2      11 MB/s
raid6: using algorithm sse2x1 (11 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: device sdp1 operational as raid disk 9
raid5: device sdo1 operational as raid disk 8
raid5: device sdn1 operational as raid disk 7
raid5: device sdm1 operational as raid disk 6
raid5: device sdl1 operational as raid disk 5
raid5: device sdk1 operational as raid disk 4
raid5: device sdj1 operational as raid disk 13
raid5: device sdi1 operational as raid disk 12
raid5: device sdh1 operational as raid disk 11
raid5: device sdg1 operational as raid disk 10
raid5: device sdf1 operational as raid disk 15
raid5: device sde1 operational as raid disk 14
raid5: device sdd1 operational as raid disk 2
raid5: device sdc1 operational as raid disk 3
raid5: device sdb1 operational as raid disk 1
raid5: device sda1 operational as raid disk 0
raid5: allocated 16696kB for md10
raid5: raid level 6 set md10 active with 16 out of 16 devices, algorithm 2
RAID5 conf printout:
 --- rd:16 wd:16
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sdd1
 disk 3, o:1, dev:sdc1
 disk 4, o:1, dev:sdk1
 disk 5, o:1, dev:sdl1
 disk 6, o:1, dev:sdm1
 disk 7, o:1, dev:sdn1
 disk 8, o:1, dev:sdo1
 disk 9, o:1, dev:sdp1
 disk 10, o:1, dev:sdg1
 disk 11, o:1, dev:sdh1
 disk 12, o:1, dev:sdi1
 disk 13, o:1, dev:sdj1
 disk 14, o:1, dev:sde1
 disk 15, o:1, dev:sdf1
md: ... autorun DONE.
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
EXT3 FS on md1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1052152k swap on /dev/md4.  Priority:-1 extents:1 across:1052152k

--------------060308050507030202090008--
