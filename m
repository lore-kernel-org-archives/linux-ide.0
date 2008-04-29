From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10574] Hard disk makes bad noise at poweroff when shutting down.
Date: Tue, 29 Apr 2008 07:09:20 -0700 (PDT)
Message-ID: <20080429140920.ED954108061@picon.linux-foundation.org>
References: <bug-10574-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53634 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751764AbYD2OJ4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 10:09:56 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3TE9LkM008716
	for <linux-ide@vger.kernel.org>; Tue, 29 Apr 2008 07:09:22 -0700
In-Reply-To: <bug-10574-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10574





------- Comment #2 from ron.w@web.de  2008-04-29 07:09 -------
First of all I have to correct my original statement: Suspend-to-Disk makes
same noise in Linux. Only Suspend-to-RAM does not. In order to screen out
possible hardware failure I performed complete SeaTools testing procedures, the
hardware is 100% OK. I checked also with the Accoustic testing feature.
Moreover I installed for testing purposes Windows XP, which was delivered with
this notebook. So I can say now, this noise is defintively *not* normal on
poweroff. Parking the heads and shutdown correctly makes a completely different
sound (silent klick), mostly inaudible.

Here is the requested dmesg-output:

Initializing cgroup subsys cpuset
Linux version 2.6.24-2.6.24.4.slh.5-sidux-686 (Debian 2.6.24-27) (s.l-h@gmx.de)
(gcc version 4.2.3 (Debian 4.2.3-3)) #1 SMP PREEMPT Fri Apr 11 22:17:21 UTC
2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e4000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fe80000 (usable)
 BIOS-e820: 000000001fe80000 - 000000001fe91000 (ACPI data)
 BIOS-e820: 000000001fe91000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
510MB LOWMEM available.
Entering add_active_range(0, 0, 130688) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   130688
  HighMem    130688 ->   130688
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   130688
On node 0 totalpages: 130688
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 989 pages used for memmap
  Normal zone: 125603 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
DMI present.
ACPI: RSDP 000F6E50, 0014 (r0 PTLTD )
ACPI: RSDT 1FE8AE02, 0048 (r1 PTLTD  Ohlone00  6040000  LTP        0)
ACPI: FACP 1FE90E88, 0074 (r1 INTEL  ALVISO    6040000 LOHR       5F)
ACPI: DSDT 1FE8C36B, 4B1D (r1 INTEL  ALVISO    6040000 INTL 20030224)
ACPI: FACS 1FEA1FC0, 0040
ACPI: APIC 1FE90EFC, 0068 (r1 INTEL  ALVISO    6040000 LOHR       5F)
ACPI: BOOT 1FE90FD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: MCFG 1FE90F9C, 003C (r1 INTEL  ALVISO    6040000 LOHR       5F)
ACPI: SSDT 1FE8BD18, 064F (r1 SataRe  SataPri     1000 INTL 20030224)
ACPI: SSDT 1FE8B686, 0692 (r1 SataRe  SataSec     1000 INTL 20030224)
ACPI: SSDT 1FE8B241, 0235 (r1  PmRef  Cpu0Ist     3000 INTL 20030224)
ACPI: SSDT 1FE8B063, 01DE (r1  PmRef  Cpu0Cst     3001 INTL 20030224)
ACPI: SSDT 1FE8AE4A, 0219 (r1  PmRef    CpuPm     3000 INTL 20030224)
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
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
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000dc000
swsusp: Registered nosave memory region: 00000000000dc000 - 00000000000e4000
swsusp: Registered nosave memory region: 00000000000e4000 - 00000000000e8000
swsusp: Registered nosave memory region: 00000000000e8000 - 0000000000100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129667
Kernel command line: root=UUID=7f579515-fb23-4ef2-a877-4e6865748cd7 ro quiet
vga=791 resume=/dev/sda9
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 1729.081 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 507196k/522752k available (2270k kernel code, 15044k reserved, 827k
data, 344k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4d000 - 0xfffff000   ( 712 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xdfe80000   ( 510 MB)
      .init : 0xc040d000 - 0xc0463000   ( 344 kB)
      .data : 0xc0337802 - 0xc04064c4   ( 827 kB)
      .text : 0xc0100000 - 0xc0337802   (2270 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
SLUB: Genslabs=11, HWalign=64, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 3459.56 BogoMIPS (lpj=1729783)
Security Framework initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180
00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00002040 00000180
00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 11k freed
Early unpacking initramfs... done
ACPI: Core revision 20070126
ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
CPU0: Intel(R) Pentium(R) M processor 1.73GHz stepping 08
Total of 1 processors activated (3459.56 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
net_namespace: 64 bytes
NET: Registered protocol family 16
EISA bus registered
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in interrupt mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
Force enabled HPET at base address 0xfed00000
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 6 7 10) *4
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 *7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 8
NET: Registered protocol family 20
hpet clockevent registered
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
ACPI: RTC can wake from S4
Time: tsc clocksource has been installed.
system 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
system 00:01: iomem range 0xf0000000-0xf0003fff could not be reserved
system 00:01: iomem range 0xf0004000-0xf0004fff could not be reserved
system 00:01: iomem range 0xf0005000-0xf0005fff could not be reserved
system 00:01: iomem range 0xf0008000-0xf000bfff could not be reserved
system 00:01: iomem range 0xfed20000-0xfed8ffff could not be reserved
system 00:05: ioport range 0x800-0x80f has been reserved
system 00:05: ioport range 0x1000-0x107f has been reserved
system 00:05: ioport range 0x1180-0x11bf has been reserved
system 00:05: ioport range 0x1640-0x164f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: 90000000-afffffff
  PREFETCH window: c0000000-cfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 2000-2fff
  MEM window: b0000000-b3ffffff
  PREFETCH window: d0000000-d3ffffff
PCI: Bus 7, cardbus bridge: 0000:06:02.0
  IO window: 00001400-000014ff
  IO window: 00001c00-00001cff
  PREFETCH window: 30000000-33ffffff
  MEM window: 34000000-37ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: b4000000-b40fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:06:02.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:06:02.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 5, 196608 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
Unpacking initramfs... done
Freeing initrd memory: 6719k freed
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1209442122.781:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:01:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
vesafb: framebuffer at 0xc0000000, mapped to 0xe0880000, using 3072k, total
131072k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:d5b0
vesafb: pmi: set display start = c00cd5e6, set palette = c00cd650
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf
3d0 3d1 3d2 3d3 3d4 3d5 3da 
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
Switched to high resolution mode on CPU 0
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
EISA: Probing bus 0 at eisa.0
Cannot allocate resource for EISA slot 1
Cannot allocate resource for EISA slot 2
EISA: Detected 0 cards.
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
NET: Registered protocol family 1
Using IPI No-Shortcut mode
Freeing unused kernel memory: 344k freed
input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not
present [20070126]
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
sky2 0000:02:00.0: v1.20 addr 0xb0000000 irq 16 Yukon-FE (0xb7) rev 1
sky2 eth0: addr 00:03:25:16:6f:2a
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 18, io base 0x00001800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
libata version 3.00 loaded.
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 20, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 18, io mem 0x80004000
usb 2-1: new low speed USB device using uhci_hcd and address 2
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
Marking TSC unstable due to: TSC halts in idle.
Time: hpet clocksource has been installed.
ACPI: PCI Interrupt 0000:06:02.2[A] -> GSI 16 (level, low) -> IRQ 16
firewire_ohci: Added fw-ohci device 0000:06:02.2, OHCI version 1.10
ahci 0000:00:1f.2: version 3.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ahci: probe of 0000:00:1f.2 failed with error -22
ata_piix 0000:00:1f.2: version 2.12
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x1870 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1878 irq 15
ata1.00: ATA-6: ST9100823A, 3.02, max UDMA/100
ata1.00: 195371568 sectors, multi 16: LBA48 
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
usb 2-1: new low speed USB device using uhci_hcd and address 3
ata2.00: ATAPI: MATSHITADVD-RAM UJ-840S, 1.00, max UDMA/33
firewire_core: created new fw device fw0 (0 config rom retries, S400)
usb 2-1: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
input: Darfon USB Optical Mouse as
/devices/pci0000:00/0000:00:1d.1/usb2/2-1/2-1:1.0/input/input1
input,hidraw0: USB HID v1.10 Mouse [Darfon USB Optical Mouse] on
usb-0000:00:1d.1-1
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      ST9100823A       3.02 PQ: 0 ANSI: 5
scsi 1:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-840S  1.00 PQ: 0 ANSI: 5
Driver 'sd' needs updating - please use bus_type methods
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sda:<4>Driver 'sr' needs updating - please use bus_type methods
 sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: [sda] Attached SCSI disk
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised:
dm-devel@redhat.com
Attempting manual resume
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
input: Power Button (FF) as /devices/virtual/input/input2
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /devices/virtual/input/input3
ACPI: Lid Switch [LID0]
input: Power Button (CM) as /devices/virtual/input/input4
ACPI: Power Button (CM) [PWRB]
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1b.0 to 64
iTCO_vendor_support: vendor-support=0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
iTCO_wdt: Found a ICH6-M TCO device (Version=2, TCOBASE=0x1060)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
intel_rng: FWH not detected
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
Yenta: CardBus bridge found at 0000:06:02.0 [161f:203d]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:06:02.0, mfunc 0x00a01002, devctl 0x64
Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#06) from #06 to #0a
pcmcia: parent PCI bridge Memory window: 0xb4000000 - 0xb40fffff
Linux video capture interface: v2.00
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
input: PC Speaker as /devices/platform/pcspkr/input/input5
ACPI: PCI Interrupt 0000:06:02.3[A] -> GSI 16 (level, low) -> IRQ 16
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.2kmprq
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:06:08.0[A] -> GSI 21 (level, low) -> IRQ 21
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
NET: Registered protocol family 23
saa7130/34: v4l2 driver version 0.2.14 loaded
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x6eb1, caps: 0xa04711/0x40a
input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input6
parport_pc 00:08: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 5 [PCSPP,TRISTATE,EPP]
found SMC SuperIO Chip (devid=0x7a rev=00 base=0x002e): LPC47N227
smsc_superio_flat(): fir: 0x6f8, sir: 0x2f8, dma: 01, irq: 3, mode: 0x0a
smsc_ircc_present: can't get sir_base of 0x2f8
ipw2200: Radio Frequency Kill Switch is On:
Kill switch must be turned off for wireless networking to work.
ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
sdhci: SDHCI controller found at 0000:06:02.4 [104c:8034] (rev 0)
ACPI: PCI Interrupt 0000:06:02.4[A] -> GSI 16 (level, low) -> IRQ 16
sdhci:slot0: Will use DMA mode even though HW doesn't fully claim to support
it.
mmc0: SDHCI at 0xb4007000 irq 16 DMA
sdhci:slot1: Will use DMA mode even though HW doesn't fully claim to support
it.
mmc1: SDHCI at 0xb4006c00 irq 16 DMA
sdhci:slot2: Will use DMA mode even though HW doesn't fully claim to support
it.
mmc2: SDHCI at 0xb4006800 irq 16 DMA
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 19 (level, low) -> IRQ 19
saa7133[0]: found at 0000:06:03.0, rev: 208, irq: 19, latency: 181, mmio:
0xb4007800
saa7133[0]: subsystem: 5168:0307, board: UNKNOWN/GENERIC [card=0,autodetected]
saa7133[0]: board init: gpio is 10000
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
saa7133[0]: i2c eeprom 00: 68 51 07 03 54 20 1c 00 43 43 a9 1c 55 d2 b2 92
saa7133[0]: i2c eeprom 10: 00 00 62 08 ff 20 ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 20: 01 40 01 03 03 01 01 03 08 ff 01 e7 ff ff ff ff
saa7133[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 40: ff 24 00 c2 96 10 ff ff 01 16 32 15 ff ff ff ff
saa7133[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: registered device video0 [v4l2]
saa7133[0]: registered device vbi0
Adding 2265124k swap on /dev/sda9.  Priority:-1 extents:1 across:2265124k
EXT3 FS on sda1, internal journal
fuse init (API version 7.9)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 17
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth1: link is not ready
lp0: using parport0 (interrupt-driven).
lp0: console ready
ppdev: user-space parallel port driver
Clocksource tsc unstable (delta = -176332630 ns)
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA UNIX x86 Kernel Module  169.12  Thu Feb 14 17:53:07 PST
2008
sky2 eth0: enabling interface
ADDRCONF(NETDEV_UP): eth0: link is not ready
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control rx
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present
swsusp: Marking nosave pages: 000000000009f000 - 0000000000100000
swsusp: Basic memory bitmaps created
Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Shrinking memory...  -\|/done (32605 pages freed)
Freed 130420 kbytes in 0.30 seconds (434.73 MB/s)
Suspending console(s)
sd 0:0:0:0: [sda] Synchronizing SCSI cache
parport_pc 00:08: disabled
eth1: Going into suspend...
ACPI: PCI interrupt for device 0000:06:08.0 disabled
ACPI handle has no context!
ACPI: PCI interrupt for device 0000:06:02.4 disabled
ACPI handle has no context!
ACPI handle has no context!
ACPI: PCI interrupt for device 0000:06:02.3 disabled
ACPI handle has no context!
ACPI handle has no context!
sky2 eth0: disabling interface
NVRM: RmPowerManagement: 3
ipw2200: Unable to load ucode: -22
ipw2200: Unable to load firmware: -22
ipw2200: Failed to up device
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ACPI: PCI interrupt for device 0000:00:1d.7 disabled
ACPI: PCI interrupt for device 0000:00:1d.2 disabled
ACPI: PCI interrupt for device 0000:00:1d.1 disabled
ACPI: PCI interrupt for device 0000:00:1d.0 disabled
ACPI: PCI interrupt for device 0000:00:1b.0 disabled
Disabling non-boot CPUs ...
swsusp: critical section: 
swsusp: Need to copy 58899 pages
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Force enabled HPET at resume
PCI: Setting latency timer of device 0000:00:01.0 to 64
PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100006,
writing 100002)
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1b.0 to 64
PM: Writing back config space on device 0000:00:1c.0 at offset 7 (was 2020,
writing 20002020)
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.0 to 64
usb usb1: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
usb usb2: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.2 to 64
usb usb3: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.7 to 64
usb usb4: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
PM: Writing back config space on device 0000:00:1e.0 at offset 6 (was d8060600,
writing d80a0600)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PM: Writing back config space on device 0000:00:1f.2 at offset 1 (was 2b80001,
writing 2b80005)
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
NVRM: RmPowerManagement: 5
ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
ata1.00: ACPI cmd ef/03:45:00:00:00:a0 filtered out
ata1.00: configured for UDMA/100
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
ata2.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
ata2.00: ACPI cmd ef/03:42:00:00:00:a0 filtered out
ata2.00: configured for UDMA/33
PM: Writing back config space on device 0000:02:00.0 at offset f (was 100,
writing 104)
PM: Writing back config space on device 0000:02:00.0 at offset 6 (was 1,
writing 2001)
PM: Writing back config space on device 0000:02:00.0 at offset 4 (was 4,
writing b0000004)
PM: Writing back config space on device 0000:02:00.0 at offset 3 (was 0,
writing 8)
PM: Writing back config space on device 0000:02:00.0 at offset 1 (was 100000,
writing 100407)
sky2 eth0: enabling interface
PM: Writing back config space on device 0000:06:02.0 at offset f (was 34001ff,
writing 5c001ff)
PM: Writing back config space on device 0000:06:02.0 at offset 3 (was 824000,
writing 82a820)
PM: Writing back config space on device 0000:06:02.2 at offset f (was 4030100,
writing 4030104)
PM: Writing back config space on device 0000:06:02.2 at offset 5 (was 0,
writing b4000000)
PM: Writing back config space on device 0000:06:02.2 at offset 4 (was 0,
writing b4006000)
PM: Writing back config space on device 0000:06:02.2 at offset 3 (was 800000,
writing 802008)
PM: Writing back config space on device 0000:06:02.2 at offset 1 (was 2100000,
writing 2100016)
ACPI: PCI Interrupt 0000:06:02.3[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:06:02.4[A] -> GSI 16 (level, low) -> IRQ 16
PM: Writing back config space on device 0000:06:03.0 at offset 1 (was 2900002,
writing 2900006)
saa7133[0]: board init: gpio is 10000
eth1: Coming out of suspend...
ACPI: PCI Interrupt 0000:06:08.0[A] -> GSI 21 (level, low) -> IRQ 21
parport_pc 00:08: activated
i8042 aux 00:0a: activation failed
sd 0:0:0:0: [sda] Starting disk
Restarting tasks ... <6>usb 2-1: USB disconnect, address 3
done.
swsusp: Basic memory bitmaps freed
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control rx
usb 2-1: new low speed USB device using uhci_hcd and address 4
usb 2-1: configuration #1 chosen from 1 choice
input: Darfon USB Optical Mouse as
/devices/pci0000:00/0000:00:1d.1/usb2/2-1/2-1:1.0/input/input7
input,hidraw0: USB HID v1.10 Mouse [Darfon USB Optical Mouse] on
usb-0000:00:1d.1-1
ipw2200: Radio Frequency Kill Switch is On:
Kill switch must be turned off for wireless networking to work.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
