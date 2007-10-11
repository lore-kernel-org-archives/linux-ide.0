From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Sil4723 boot delay on ASUS P5W-DH Delux
Date: Thu, 11 Oct 2007 15:31:32 +0200
Message-ID: <5501535d0710110631g432cf52dpbc707dc912aa3d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:7045 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759312AbXJKNbd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Oct 2007 09:31:33 -0400
Received: by wa-out-1112.google.com with SMTP id v27so609423wah
        for <linux-ide@vger.kernel.org>; Thu, 11 Oct 2007 06:31:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hello Tejun,

I found your patchset (20071011: libata-tj-2.6.23-20071011) and applied it
against latest kernel 2.6.23

But unfortunately I have to revise your statement on your wiki:

* The long boot delay on ASUS boards with on-board PMP chips should be
  fixed by this patchset but I don't have such a board or Sil4723
  which is used on those boards, so I'm not sure. Anyone up for
  testing?

It's not fixed... sry to tell you.

ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient (Status 0x80)
ata2: COMRESET failed (errno=-16)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

http://bugzilla.kernel.org/show_bug.cgi?id=8923

Thanks and regards
Bjoern Olausson


Heres the complete dmsg:

Linux version 2.6.23 (root@freax) (gcc version 4.1.2 (Gentoo 4.1.2)) #1 SMP
PREEMPT Thu Oct 11 15:01:09 CEST 2007
Command line: root=/dev/sda3 video=nvidiafb:1280x1024-32@85,mtrr,ywrap
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff80000 (usable)
 BIOS-e820: 000000007ff80000 - 000000007ff8e000 (ACPI data)
 BIOS-e820: 000000007ff8e000 - 000000007ffe0000 (ACPI NVS)
 BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 524160) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.4 present.
ACPI: RSDP 000FAF20, 0024 (r2 ACPIAM)
ACPI: XSDT 7FF80100, 004C (r1 A_M_I_ OEMXSDT 8000715 MSFT 97)
ACPI: FACP 7FF80290, 00F4 (r3 A_M_I_ OEMFACP 8000715 MSFT 97)
ACPI: DSDT 7FF80590, 9560 (r1 A0543 A0543000 0 INTL 20060113)
ACPI: FACS 7FF8E000, 0040
ACPI: APIC 7FF80390, 0080 (r1 A_M_I_ OEMAPIC 8000715 MSFT 97)
ACPI: OEMB 7FF8E040, 0066 (r1 A_M_I_ AMI_OEM 8000715 MSFT 97)
ACPI: HPET 7FF89AF0, 0038 (r1 A_M_I_ OEMHPET 8000715 MSFT 97)
ACPI: MCFG 7FF89B30, 003C (r1 A_M_I_ OEMMCFG 8000715 MSFT 97)
No NUMA configuration found
Faking a node at 0000000000000000-000000007ff80000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 524160) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000007ff80000
Zone PFN ranges:
  DMA 0 -> 4096
  DMA32 4096 -> 1048576
  Normal 1048576 -> 1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
  0: 0 -> 159
  0: 256 -> 524160
On node 0 totalpages: 524063
  DMA zone: 88 pages used for memmap
  DMA zone: 2813 pages reserved
  DMA zone: 1098 pages, LIFO batch:0
  DMA32 zone: 11173 pages used for memmap
  DMA32 zone: 508891 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7fb00000)
SMP: Allowing 4 CPUs, 2 hotplug CPUs
PERCPU: Allocating 35032 bytes of per cpu data
Built 1 zonelists in Node order. Total pages: 509989
Policy zone: DMA32
Kernel command line: root=/dev/sda3 video=nvidiafb:1280x1024-32@85
,mtrr,ywrap
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Detected 2404.115 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES: 8
... MAX_LOCK_DEPTH: 30
... MAX_LOCKDEP_KEYS: 2048
... CLASSHASH_SIZE: 1024
... MAX_LOCKDEP_ENTRIES: 8192
... MAX_LOCKDEP_CHAINS: 16384
... CHAINHASH_SIZE: 8192
 memory used by lock dependency info: 1648 kB
 per task-struct memory footprint: 1680 bytes
Checking aperture...
Memory: 2039616k/2096640k available (3927k kernel code, 56636k reserved,
2263k data, 348k init)
SLUB: Genslabs=23, HWalign=64, Order=0-1, MinObjects=4, CPUs=4, Nodes=1
Calibrating delay using timer specific routine.. 4811.55 BogoMIPS
(lpj=2405779)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
lockdep: not fixing up alternatives.
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 16695247
Detected 16.695 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4808.09 BogoMIPS
(lpj=2404048)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
Intel(R) Core(TM)2 CPU 6600 @ 2.40GHz stepping 06
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10 11 12 14 15)
ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] - CC, should
be CB [20070126]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq". If it helps, post a
report
NET: Registered protocol family 23
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PCI-GART: No AMD northbridge found.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Time: tsc clocksource has been installed.
pnp: 00:01: iomem range 0xfed13000-0xfed19fff has been reserved
pnp: 00:06: ioport range 0x290-0x297 has been reserved
pnp: 00:07: iomem range 0xfed1c000-0xfed1ffff has been reserved
pnp: 00:07: iomem range 0xfed20000-0xfed3ffff has been reserved
pnp: 00:07: iomem range 0xfed50000-0xfed8ffff has been reserved
pnp: 00:07: iomem range 0xffb00000-0xffbfffff could not be reserved
pnp: 00:09: iomem range 0xfec00000-0xfec00fff has been reserved
pnp: 00:09: iomem range 0xfee00000-0xfee00fff could not be reserved
pnp: 00:0b: iomem range 0xf0000000-0xf3ffffff has been reserved
pnp: 00:0c: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:0c: iomem range 0xc0000-0xdffff has been reserved
pnp: 00:0c: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:0c: iomem range 0x100000-0x7fffffff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: ebe00000-efefffff
  PREFETCH window: c3500000-e34fffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: c3400000-c34fffff
PCI: Bridge: 0000:00:1c.3
  IO window: b000-bfff
  MEM window: ebd00000-ebdfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: a000-afff
  MEM window: ebc00000-ebcfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
  IO window: 9000-9fff
  MEM window: ebb00000-ebbfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 8000-8fff
  MEM window: e3600000-ebafffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.4 to 64
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 12, 16777216 bytes)
TCP bind hash table entries: 65536 (order: 9, 3670016 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.28 [Flags: R/W].
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:06:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
ACPI Exception (processor_core-0818): AE_NOT_FOUND, Processor Device is not
present [20070126]
ACPI Exception (processor_core-0818): AE_NOT_FOUND, Processor Device is not
present [20070126]
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
intel_rng: FWH not detected
Linux agpgart interface v0.102
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: module loaded
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
usbcore: registered new interface driver irda-usb
USB IrDA support registered
usbcore: registered new interface driver stir4200
usbcore: registered new interface driver mcs7780
ahci 0000:00:1f.2: version 3.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xefffb800 port 0xefffb900 irq 1274
ata2: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq
1274
ata3: SATA max UDMA/133 abar m1024@0xefffb800 port 0xefffba00 irq 1274
ata4: SATA max UDMA/133 abar m1024@0xefffb800 port 0xefffba80 irq 1274
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: WDC WD740ADFD-00NLR1, 20.07P20, max UDMA/133
ata1.00: 145226112 sectors, multi 16: LBA48 NCQ (not used)
ata1.00: configured for UDMA/133
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient (Status 0x80)
ata2: COMRESET failed (errno=-16)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-6: Config Disk, RGL10364, max UDMA/133
ata2.00: 640 sectors, multi 1: LBA
ata2.00: device is on DMA blacklist, disabling DMA
ata2.00: configured for PIO4
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7: WDC WD740ADFD-00NLR1, 20.07P20, max UDMA/133
ata3.00: 145226112 sectors, multi 16: LBA48 NCQ (not used)
ata3.00: configured for UDMA/133
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7: WDC WD1600BEVS-00RST0, 04.01G04, max UDMA/133
ata4.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata4.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access ATA WDC WD740ADFD-00 20.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 145226112 512-byte hardware sectors (74356 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
sd 0:0:0:0: [sda] 145226112 512-byte hardware sectors (74356 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access ATA Config Disk RGL1 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 640 512-byte hardware sectors (0 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:0:0: [sdb] 640 512-byte hardware sectors (0 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: unknown partition table
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:0:0: Direct-Access ATA WDC WD740ADFD-00 20.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 145226112 512-byte hardware sectors (74356 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
sd 2:0:0:0: [sdc] 145226112 512-byte hardware sectors (74356 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sdc: sdc1
sd 2:0:0:0: [sdc] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: Direct-Access ATA WDC WD1600BEVS-0 04.0 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] 312581808 512-byte hardware sectors (160042 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
sd 3:0:0:0: [sdd] 312581808 512-byte hardware sectors (160042 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sdd: sdd1
sd 3:0:0:0: [sdd] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg3 type 0
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part
PCI: Setting latency timer of device 0000:02:00.0 to 64
scsi4 : ahci
scsi5 : ahci
ata5: SATA max UDMA/133 abar m8192@0xebbfe000 port 0xebbfe100 irq 17
ata6: SATA max UDMA/133 abar m8192@0xebbfe000 port 0xebbfe180 irq 17
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
ata_piix 0000:00:1f.1: version 2.12
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi6 : ata_piix
scsi7 : ata_piix
ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
PCI: Enabling device 0000:02:00.1 (0000 -> 0001)
ACPI: PCI Interrupt 0000:02:00.1[B] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:02:00.1 to 64
scsi8 : pata_jmicron
scsi9 : pata_jmicron
ata9: PATA max UDMA/100 cmd 0x9c00 ctl 0x9880 bmdma 0x9400 irq 18
ata10: PATA max UDMA/100 cmd 0x9800 ctl 0x9480 bmdma 0x9408 irq 18
ata9.00: ATAPI: PLEXTOR DVDR PX-760A, 1.07, max UDMA/66
ata9.01: ATAPI: PLEXTOR DVD-ROM PX-130A, 1.03, max UDMA/100
ata9.00: configured for UDMA/66
ata9.01: configured for UDMA/100
scsi 8:0:0:0: CD-ROM PLEXTOR DVDR PX-760A 1.07 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 8:0:0:0: Attached scsi CD-ROM sr0
sr 8:0:0:0: Attached scsi generic sg4 type 5
scsi 8:0:1:0: CD-ROM PLEXTOR DVD-ROM PX-130A 1.03 PQ: 0 ANSI: 5
sr1: scsi3-mmc drive: 0x/50x cd/rw xa/form2 cdda tray
sr 8:0:1:0: Attached scsi CD-ROM sr1
sr 8:0:1:0: Attached scsi generic sg5 type 5
I2O subsystem v1.325
i2o: max drivers = 8
Fusion MPT base driver 3.04.05
Copyright (c) 1999-2007 LSI Logic Corporation
Fusion MPT SPI Host driver 3.04.05
Fusion MPT SAS Host driver 3.04.05
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 21
firewire_ohci: Added fw-ohci device 0000:01:03.0, OHCI version 1.10
ieee1394: raw1394: /dev/raw1394 device initialized
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xefffbc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e480
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000e800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new high speed USB device using ehci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ec00
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
firewire_core: created new fw device fw0 (0 config rom retries, S400)
usb 1-7: new high speed USB device using ehci_hcd and address 7
usb 1-7: configuration #1 chosen from 1 choice
hub 1-7:1.0: USB hub found
hub 1-7:1.0: 4 ports detected
usb 2-2: new low speed USB device using uhci_hcd and address 2
usb 2-2: configuration #1 chosen from 1 choice
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usb 3-2: new full speed USB device using uhci_hcd and address 3
usb 3-2: configuration #1 chosen from 1 choice
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 3 ports detected
usb 4-2: new full speed USB device using uhci_hcd and address 2
usb 4-2: device descriptor read/64, error -71
usb 4-2: device descriptor read/64, error -71
usb 4-2: new full speed USB device using uhci_hcd and address 3
usb 4-2: device descriptor read/64, error -71
usb 4-2: device descriptor read/64, error -71
usb 4-2: new full speed USB device using uhci_hcd and address 4
usb 4-2: device not accepting address 4, error -71
usb 4-2: new full speed USB device using uhci_hcd and address 5
usb 4-2: device not accepting address 5, error -71
usb 1-1.1: new full speed USB device using ehci_hcd and address 8
usb 1-1.1: configuration #1 chosen from 1 choice
usb 1-1.2: new high speed USB device using ehci_hcd and address 9
usb 1-1.2: configuration #1 chosen from 1 choice
usb 1-7.1: new high speed USB device using ehci_hcd and address 10
usb 1-7.1: configuration #1 chosen from 1 choice
hub 1-7.1:1.0: USB hub found
hub 1-7.1:1.0: 4 ports detected
usb 1-7.2: new high speed USB device using ehci_hcd and address 11
usb 1-7.2: configuration #1 chosen from 1 choice
usb 1-7.3: new high speed USB device using ehci_hcd and address 12
usb 1-7.3: configuration #1 chosen from 1 choice
usb 3-2.2: new full speed USB device using uhci_hcd and address 4
usb 3-2.2: configuration #1 chosen from 1 choice
usb 3-2.3: new full speed USB device using uhci_hcd and address 5
usb 3-2.3: configuration #1 chosen from 1 choice
usblp0: USB Bidirectional printer dev 9 if 0 alt 0 proto 2 vid 0x04A9 pid
0x10A5
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
scsi10 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 11
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie
3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie
5.0
usbcore: registered new interface driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 23
coretemp coretemp.0: Using undocumented features, absolute temperature might
be wrong!
coretemp coretemp.1: Using undocumented features, absolute temperature might
be wrong!
w83627ehf: Found W83627DHG chip at 0x290
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised:
dm-devel@redhat.com
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
Bluetooth: Virtual HCI driver ver 1.2
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: Broadcom Blutonium firmware driver ver 1.1
usbcore: registered new interface driver bcm203x
Bluetooth: Digianswer Bluetooth USB driver ver 0.8
usbcore: registered new interface driver bpa10x
Bluetooth: BlueFRITZ! USB driver ver 1.1
usbcore: registered new interface driver bfusb
usbcore: registered new interface driver hiddev
input: Logitech USB RECEIVER as /class/input/input2
input: USB HID v1.11 Mouse [Logitech USB RECEIVER] on usb-0000:00:1d.0-2
hiddev96: USB HID v1.10 Device [T-wins ASUS DH Remote] on usb-0000:00:1d.1-1
input: Logitech USB Receiver as /class/input/input3
input: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:1d.7-1.1
input: Logitech USB Receiver as /class/input/input4
input,hiddev97: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:
1d.7-1.1
input: Logitech Logitech BT Mini-Receiver as /class/input/input5
input: USB HID v1.11 Keyboard [Logitech Logitech BT Mini-Receiver] on
usb-0000:00:1d.1-2.2
input: Logitech Logitech BT Mini-Receiver as /class/input/input6
input,hiddev98: USB HID v1.11 Mouse [Logitech Logitech BT Mini-Receiver] on
usb-0000:00:1d.1-2.3
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
oprofile: using NMI interrupt.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
IrCOMM protocol (Dag Brattli)
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.5
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
NET: Registered protocol family 33
RxRPC: Registered security type 2 'rxkad'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <
jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
kjournald starting. Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 348k freed
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:04:00.0 to 64
sky2 0000:04:00.0: v1.18 addr 0xebdfc000 irq 19 Yukon-EC (0xb6) rev 2
sky2 eth0: addr 00:18:f3:84:4f:8a
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:03:00.0 to 64
sky2 0000:03:00.0: v1.18 addr 0xebcfc000 irq 16 Yukon-EC (0xb6) rev 2
sky2 eth1: addr 00:18:f3:84:43:74
wmaster0: Selected rate control algorithm 'simple'
phy0: hwaddr 00:15:af:09:e6:34, rtl8187 V1 + rtl8225z2
usbcore: registered new interface driver rtl8187
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1b.0 to 64
nvidia: module license 'NVIDIA' taints kernel.
ath_hal: 0.9.30.13 (AR5210, AR5211, AR5212, AR5416, RF5111, RF5112, RF2413,
RF5413, RF2133)
wlan: 0.8.4.2 (0.9.4)
ath_pci: no version for "ieee80211_encap" found: kernel tainted.
ath_pci: 0.9.4.5 (0.9.4)
ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 23 (level, low) -> IRQ 23
ath_pci: switching rfkill capability off
ath_rate_sample: 1.2 (0.9.4)
ath_pci: switching per-packet transmit power control off
wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps
24Mbps 36Mbps 48Mbps 54Mbps
wifi0: turboG rates: 6Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
wifi0: H/W encryption support: WEP AES AES_CCM TKIP
wifi0: mac 7.9 phy 4.5 radio 5.6
wifi0: Use hw queue 1 for WME_AC_BE traffic
wifi0: Use hw queue 0 for WME_AC_BK traffic
wifi0: Use hw queue 2 for WME_AC_VI traffic
wifi0: Use hw queue 3 for WME_AC_VO traffic
wifi0: Use hw queue 8 for CAB traffic
wifi0: Use hw queue 9 for beacons
wifi0: Atheros 5212: mem=0xebaf0000, irq=23
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:06:00.0 to 64
NVRM: loading NVIDIA UNIX x86_64 Kernel Module 100.14.19 Wed Sep 12 14:08:38
PDT 2007
EXT3 FS on sda3, internal journal
scsi 10:0:0:0: Direct-Access Generic STORAGE DEVICE 9602 PQ: 0 ANSI: 0
sd 10:0:0:0: [sde] Attached SCSI removable disk
sd 10:0:0:0: Attached scsi generic sg6 type 0
scsi 10:0:0:1: Direct-Access Generic STORAGE DEVICE 9602 PQ: 0 ANSI: 0
sd 10:0:0:1: [sdf] Attached SCSI removable disk
sd 10:0:0:1: Attached scsi generic sg7 type 0
scsi 10:0:0:2: Direct-Access Generic STORAGE DEVICE 9602 PQ: 0 ANSI: 0
sd 10:0:0:2: [sdg] Attached SCSI removable disk
sd 10:0:0:2: Attached scsi generic sg8 type 0
scsi 10:0:0:3: Direct-Access Generic STORAGE DEVICE 9602 PQ: 0 ANSI: 0
sd 10:0:0:3: [sdh] Attached SCSI removable disk
sd 10:0:0:3: Attached scsi generic sg9 type 0
usb-storage: device scan complete
ath_rate_amrr: 0.1 (0.9.4)
ath_rate_onoe: 1.0 (0.9.4)
wlan: mac acl policy registered
Linux video capture interface: v2.00
bttv: driver version 0.9.17 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
vboxdrv: Trying to deactivate the NMI watchdog permanently...
vboxdrv: Successfully done.
Adding 979956k swap on /dev/sda2. Priority:-1 extents:1 across:979956k
sky2 eth0: enabling interface
ADDRCONF(NETDEV_UP): eth0: link is not ready
sky2 eth0: Link is up at 1000 Mbps, full duplex, flow control both
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
ath0: no IPv6 routers present
eth0: no IPv6 routers present
