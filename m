From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10911] New: A long boot caused due to ata soft resets and drive recognition problems
Date: Sat, 14 Jun 2008 05:46:30 -0700 (PDT)
Message-ID: <bug-10911-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40317 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755942AbYFNMqe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jun 2008 08:46:34 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5ECkUjq012735
	for <linux-ide@vger.kernel.org>; Sat, 14 Jun 2008 05:46:31 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10911

           Summary: A long boot caused due to ata soft resets and drive
                    recognition problems
           Product: IO/Storage
           Version: 2.5
     KernelVersion: output of uname -a: Linux desktop 2.6.25-ARCH #1 SMP
                    PREEMPT Sun
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: gajo01@gmail.com


Latest working kernel version: 2.4.x was far less problematic

Earliest failing kernel version: i didn't try the versions inbetween, the first
update was already at 2.6.24

Distribution: Archlinux

Hardware Environment: relevant parts: motherboard - MSI P965 Neo, hard disk -
200GB ata disk , cdrw/dvdrw LG

Software Environment: not an userspace software problem

Problem Description: I'm getting long boots due to ata recognition problems as
shown below, in the 2.4.x versions it was unnoticable, it only did one soft
reset which prolonged boot time by 5 seconds which was managable. 

Important thing to note is that once it finally boots it works just as well as
it did in 2.4.x, showing no signs of failirue, but boot time is just huge.

Additional information and similar problems can be found here if interested:
http://bbs.archlinux.org/viewtopic.php?pid=379139#p379139

The link above just shows problems other people have that weren't connected to
my distribution which might give some insight to the issue.

Issue represented itself on multiple distributions using newest (2.6.x) kernel,
some to name: Archlinux, Fedora 8.

important dmesg output part:

scsi0 : pata_jmicron
scsi1 : pata_jmicron
ata1: PATA max UDMA/100 cmd 0xbf00 ctl 0xbe00 bmdma 0xbb00 irq 17
ata2: PATA max UDMA/100 cmd 0xbd00 ctl 0xbc00 bmdma 0xbb08 irq 17
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
ata1.00: ATA-7: ST3200826A, 3.06, max UDMA/100
ata1.00: 390721968 sectors, multi 0: LBA48 
ata1.01: ATAPI: HL-DT-ST DVDRAM GSA-4120B, A101, max UDMA/33
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      ST3200826A       3.06 PQ: 0 ANSI: 5
scsi 0:0:1:0: CD-ROM            HL-DT-ST DVDRAM GSA-4120B A101 PQ: 0 ANSI: 5
ahci 0000:02:00.0: version 3.0
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
PCI: Setting latency timer of device 0000:02:00.0 to 64
scsi2 : ahci
scsi3 : ahci
ata3: SATA max UDMA/133 abar m8192@0xfdbfe000 port 0xfdbfe100 irq 16
ata4: SATA max UDMA/133 abar m8192@0xfdbfe000 port 0xfdbfe180 irq 16
ata3: SATA link down (SStatus 0 SControl 300)
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 8 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 35 secs
ata4: limiting SATA link speed to 1.5 Gbps
ata4: classfication failed, assuming ATA
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4: failed to recover some devices, retrying in 5 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 35 secs
ata4: classfication failed, assuming ATA
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4: failed to recover some devices, retrying in 5 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 35 secs
ata4: classfication failed, assuming ATA
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4: failed to recover some devices, retrying in 5 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 35 secs
ata4: classfication failed, assuming ATA
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
ata_piix 0000:00:1f.2: version 2.12
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi4 : ata_piix
scsi5 : ata_piix
ata5: SATA max UDMA/133 cmd 0xfa00 ctl 0xf900 bmdma 0xf600 irq 19
ata6: SATA max UDMA/133 cmd 0xf800 ctl 0xf700 bmdma 0xf608 irq 19
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
PCI: Setting latency timer of device 0000:00:1f.5 to 64
scsi6 : ata_piix
scsi7 : ata_piix
ata7: SATA max UDMA/133 cmd 0xf300 ctl 0xf200 bmdma 0xef00 irq 19
ata8: SATA max UDMA/133 cmd 0xf100 ctl 0xf000 bmdma 0xef08 irq 19
ata7: SATA link down (SStatus 0 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)
usbcore: registered new interface driver usbfs

entire dmesg output:
Linux version 2.6.25-ARCH (root@desktop) (gcc version 4.3.0 (GCC) ) #1 SMP
PREEMPT Sun Jun 1 15:04:51 CEST 2008
Command line: root=/dev/sda1 ro vga=791
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fee0000 (usable)
 BIOS-e820: 000000007fee0000 - 000000007fee3000 (ACPI NVS)
 BIOS-e820: 000000007fee3000 - 000000007fef0000 (ACPI data)
 BIOS-e820: 000000007fef0000 - 000000007ff00000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524000) 1 entries of 256 used
end_pfn_map = 1048576
DMI 2.4 present.
ACPI: RSDP 000F9210, 0014 (r0 IntelR)
ACPI: RSDT 7FEE3040, 003C (r1 IntelR AWRDACPI 42302E31 AWRD        0)
ACPI: FACP 7FEE30C0, 0074 (r1 IntelR AWRDACPI 42302E31 AWRD        0)
ACPI: DSDT 7FEE3180, 4BB6 (r1 INTELR AWRDACPI     1000 MSFT  100000E)
ACPI: FACS 7FEE0000, 0040
ACPI: HPET 7FEE7E80, 0038 (r1 IntelR AWRDACPI 42302E31 AWRD       98)
ACPI: MCFG 7FEE7F00, 003C (r1 IntelR AWRDACPI 42302E31 AWRD        0)
ACPI: APIC 7FEE7D80, 0084 (r1 IntelR AWRDACPI 42302E31 AWRD        0)
ACPI: SSDT 7FEE7F80, 015C (r1  PmRef  Cpu0Ist     3000 INTL 20060912)
ACPI: SSDT 7FEE8410, 02F1 (r1  PmRef    CpuPm     3000 INTL 20040311)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524000) 1 entries of 256 used
early res: 0 [0-fff] BIOS data page
early res: 1 [6000-7fff] SMP_TRAMPOLINE
early res: 2 [200000-68ac4b] TEXT DATA BSS
early res: 3 [37f33000-37fef583] RAMDISK
early res: 4 [9f000-9ffff] EBDA
early res: 5 [8000-bfff] PGTABLE
 [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001200000 on node 0
 [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001600000 on node 0
 [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001a00000 on node 0
 [ffffe20000600000-ffffe200007fffff] PMD ->ffff810001e00000 on node 0
 [ffffe20000800000-ffffe200009fffff] PMD ->ffff810002200000 on node 0
 [ffffe20000a00000-ffffe20000bfffff] PMD ->ffff810002600000 on node 0
 [ffffe20000c00000-ffffe20000dfffff] PMD ->ffff810002a00000 on node 0
 [ffffe20000e00000-ffffe20000ffffff] PMD ->ffff810002e00000 on node 0
 [ffffe20001000000-ffffe200011fffff] PMD ->ffff810003200000 on node 0
 [ffffe20001200000-ffffe200013fffff] PMD ->ffff810003600000 on node 0
 [ffffe20001400000-ffffe200015fffff] PMD ->ffff810003a00000 on node 0
 [ffffe20001600000-ffffe200017fffff] PMD ->ffff810003e00000 on node 0
 [ffffe20001800000-ffffe200019fffff] PMD ->ffff810004200000 on node 0
 [ffffe20001a00000-ffffe20001bfffff] PMD ->ffff810004600000 on node 0
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524000
On node 0 totalpages: 523903
  DMA zone: 56 pages used for memmap
  DMA zone: 1172 pages reserved
  DMA zone: 2771 pages, LIFO batch:0
  DMA32 zone: 7108 pages used for memmap
  DMA32 zone: 512796 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x10b9a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 80000000 (gap: 7ff00000:60100000)
SMP: Allowing 4 CPUs, 2 hotplug CPUs
PERCPU: Allocating 34152 bytes of per cpu data
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 515567
Kernel command line: root=/dev/sda1 ro vga=791
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
TSC calibrated against PM_TIMER
time.c: Detected 2395.895 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Memory: 2057408k/2096000k available (2456k kernel code, 37500k reserved, 926k
data, 276k init)
CPA: page pool initialized 1 of 1 pages preallocated
SLUB: Genslabs=12, HWalign=64, Order=0-1, MinObjects=4, CPUs=4, Nodes=1
hpet clockevent registered
Calibrating delay using timer specific routine.. 4796.44 BogoMIPS (lpj=7991106)
Security Framework initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
using mwait in idle threads.
ACPI: Core revision 20070126
ACPI: Checking initramfs for custom DSDT
Using local APIC timer interrupts.
APIC timer calibration result 16638146
Detected 16.638 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4793.45 BogoMIPS (lpj=7986326)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
net_namespace: 1016 bytes
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: Using configuration type 1
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 *9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 11 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 15 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI-GART: No AMD northbridge found.
ACPI: RTC can wake from S4
system 00:01: ioport range 0x4d0-0x4d1 has been reserved
system 00:01: ioport range 0xa00-0xa7f has been reserved
system 00:01: ioport range 0x880-0x88f has been reserved
system 00:0b: ioport range 0x400-0x4bf could not be reserved
system 00:0d: iomem range 0xe0000000-0xefffffff could not be reserved
system 00:0e: iomem range 0xf0000-0xfffff could not be reserved
system 00:0e: iomem range 0xfed00000-0xfed000ff has been reserved
system 00:0e: iomem range 0x7fee0000-0x7fefffff could not be reserved
system 00:0e: iomem range 0x0-0x9ffff could not be reserved
system 00:0e: iomem range 0x100000-0x7fedffff could not be reserved
system 00:0e: iomem range 0xfec00000-0xfec00fff has been reserved
system 00:0e: iomem range 0xfed14000-0xfed1dfff has been reserved
system 00:0e: iomem range 0xfed20000-0xfed9ffff has been reserved
system 00:0e: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:0e: iomem range 0xffb00000-0xffb7ffff has been reserved
system 00:0e: iomem range 0xfff00000-0xffffffff has been reserved
system 00:0e: iomem range 0xe0000-0xeffff has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: 0xfa000000-0xfcffffff
  PREFETCH window: 0x00000000d0000000-0x00000000dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: b000-bfff
  MEM window: 0xfdb00000-0xfdbfffff
  PREFETCH window: 0x00000000fdc00000-0x00000000fdcfffff
PCI: Bridge: 0000:00:1e.0
  IO window: c000-cfff
  MEM window: 0xfde00000-0xfdefffff
  PREFETCH window: 0x00000000fdd00000-0x00000000fddfffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Unpacking initramfs... done
Freeing initrd memory: 753k freed
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
vesafb: framebuffer at 0xd0000000, mapped to 0xffffc20010100000, using 3072k,
total 262144k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Linux agpgart interface v0.103
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
input: Macintosh mouse button emulation as /class/input/input0
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
registered taskstats version 1
Freeing unused kernel memory: 276k freed
No dock devices found.
SCSI subsystem initialized
libata version 3.00 loaded.
PCI: Enabling device 0000:02:00.1 (0000 -> 0001)
ACPI: PCI Interrupt 0000:02:00.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:02:00.1 to 64
scsi0 : pata_jmicron
scsi1 : pata_jmicron
ata1: PATA max UDMA/100 cmd 0xbf00 ctl 0xbe00 bmdma 0xbb00 irq 17
ata2: PATA max UDMA/100 cmd 0xbd00 ctl 0xbc00 bmdma 0xbb08 irq 17
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
ata1.00: ATA-7: ST3200826A, 3.06, max UDMA/100
ata1.00: 390721968 sectors, multi 0: LBA48 
ata1.01: ATAPI: HL-DT-ST DVDRAM GSA-4120B, A101, max UDMA/33
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      ST3200826A       3.06 PQ: 0 ANSI: 5
scsi 0:0:1:0: CD-ROM            HL-DT-ST DVDRAM GSA-4120B A101 PQ: 0 ANSI: 5
ahci 0000:02:00.0: version 3.0
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
PCI: Setting latency timer of device 0000:02:00.0 to 64
scsi2 : ahci
scsi3 : ahci
ata3: SATA max UDMA/133 abar m8192@0xfdbfe000 port 0xfdbfe100 irq 16
ata4: SATA max UDMA/133 abar m8192@0xfdbfe000 port 0xfdbfe180 irq 16
ata3: SATA link down (SStatus 0 SControl 300)
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 8 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 35 secs
ata4: limiting SATA link speed to 1.5 Gbps
ata4: classfication failed, assuming ATA
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4: failed to recover some devices, retrying in 5 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 35 secs
ata4: classfication failed, assuming ATA
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4: failed to recover some devices, retrying in 5 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 35 secs
ata4: classfication failed, assuming ATA
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4: failed to recover some devices, retrying in 5 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 10 secs
ata4: classification failed
ata4: reset failed (errno=-22), retrying in 35 secs
ata4: classfication failed, assuming ATA
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
ata_piix 0000:00:1f.2: version 2.12
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi4 : ata_piix
scsi5 : ata_piix
ata5: SATA max UDMA/133 cmd 0xfa00 ctl 0xf900 bmdma 0xf600 irq 19
ata6: SATA max UDMA/133 cmd 0xf800 ctl 0xf700 bmdma 0xf608 irq 19
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
PCI: Setting latency timer of device 0000:00:1f.5 to 64
scsi6 : ata_piix
scsi7 : ata_piix
ata7: SATA max UDMA/133 cmd 0xf300 ctl 0xf200 bmdma 0xef00 irq 19
ata8: SATA max UDMA/133 cmd 0xf100 ctl 0xf000 bmdma 0xef08 irq 19
ata7: SATA link down (SStatus 0 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 2
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfdfff000
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000fe00
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfdffe000
Driver 'sd' needs updating - please use bus_type methods
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sda: sda1 sda2 sda3
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
Driver 'sr' needs updating - please use bus_type methods
sd 0:0:0:0: [sda] Attached SCSI disk
sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000fd00
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000fc00
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
hub 4-0:1.0: unable to enumerate USB device on port 2
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000fb00
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
hub 4-0:1.0: unable to enumerate USB device on port 3
usb 5-2: new low speed USB device using uhci_hcd and address 2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usb 5-2: configuration #1 chosen from 1 choice
usb 6-1: new low speed USB device using uhci_hcd and address 2
usb 6-1: configuration #1 chosen from 1 choice
rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 21 (level, low) -> IRQ 21
eth0: RTL8169sc/8110sc at 0xffffc20000024000, 00:16:17:b2:2b:11, XID 18000000
IRQ 21
ACPI: ACPI0007:00 is registered as cooling_device0
ACPI: SSDT 7FEE8380, 0087 (r1  PmRef  Cpu1Ist     3000 INTL 20060912)
ACPI: ACPI0007:01 is registered as cooling_device1
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA UNIX x86_64 Kernel Module  173.14.05  Mon May 19 00:03:22
PDT 2008
input: Power Button (FF) as /class/input/input1
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input2
ACPI: Power Button (CM) [PWRB]
ACPI: PNP0C0B:00 is registered as cooling_device2
ACPI: Fan [FAN] (on)
ACPI: LNXTHERM:01 is registered as thermal_zone0
ACPI: Thermal Zone [THRM] (41 C)
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 0:0:1:0: Attached scsi generic sg1 type 5
usbcore: registered new interface driver hiddev
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
mm/memory.c:127: bad pmd ffff810000207228(9090909090909090).
input: Logitech HID compliant keyboard as /class/input/input3
input,hidraw0: USB HID v1.10 Keyboard [Logitech HID compliant keyboard] on
usb-0000:00:1d.0-2
PPP generic driver version 2.4.2
input: Logitech HID compliant keyboard as /class/input/input4
lp: driver loaded but no devices found
input,hidraw1: USB HID v1.10 Device [Logitech HID compliant keyboard] on
usb-0000:00:1d.0-2
ppdev: user-space parallel port driver
input: Logitech USB-PS/2 Optical Mouse as /class/input/input5
parport_pc 00:0a: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
input,hidraw2: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on
usb-0000:00:1d.1-1
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
lp0: using parport0 (interrupt-driven).
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 29294516k swap on /dev/sda3.  Priority:-1 extents:1 across:29294516k
r8169: eth0: link up
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
eth0: no IPv6 routers present

Steps to reproduce:
Simply booting the newest kernel versions


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
