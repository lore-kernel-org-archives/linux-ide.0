From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9994] New: atiixp ide timeouts
Date: Thu, 14 Feb 2008 16:17:16 -0800 (PST)
Message-ID: <bug-9994-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45978 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757130AbYBOARU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 19:17:20 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1F0HGYm032478
	for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 16:17:17 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9994

           Summary: atiixp ide timeouts
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.24
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: jan.fikar@psi.ch


Latest working kernel version:2.6.23
Earliest failing kernel version:2.6.24
Distribution:gentoo
Hardware Environment:Acer Aspire 5021
Software Environment:
Problem Description:
After some hours of uptime I can find this in dmesg and dma of my harddrive is
switched off:
...
hda: irq timeout: status=0xd0 { Busy }
hda: irq timeout: status=0xd0 { Busy }
hda: status timeout: status=0xd0 { Busy }
hda: DMA disabled
...

I can switch it back with hdparm -d1 /dev/hda, but after some hours the same
thing happens.

Steps to reproduce: just wait, the attached dmesg contains 26 ide0 resets
during 17 hours uptime

lspci -v:
00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 01)
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMMi
        Flags: bus master, 66MHz, medium devsel, latency 64

00:02.0 PCI bridge: ATI Technologies Inc RS480 PCI-X Root Port (prog-if 00
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: c0100000-c01fffff
        Prefetchable memory behind bridge: c8000000-cfffffff
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot-), MSI 00
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0
Enable-
        Capabilities: [b0] Subsystem: ATI Technologies Inc Unknown device 5950
        Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+

00:06.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge (prog-if 00 [Normal
decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot-), MSI 00
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0
Enable-
        Capabilities: [b0] Subsystem: ATI Technologies Inc Unknown device 5950
        Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+

00:07.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge (prog-if 00 [Normal
decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot-), MSI 00
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0
Enable-
        Capabilities: [b0] Subsystem: ATI Technologies Inc Unknown device 5950
        Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+

00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
(prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at c0000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit- Queue=0/0
Enable-

00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
(prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMMi
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at c0001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit- Queue=0/0
Enable-

00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller
(prog-if 20 [EHCI])
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMMi
        Flags: 66MHz, medium devsel, IRQ 11
        Memory at c0002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit- Queue=0/0
Enable-

00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 11)
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMMi
        Flags: 66MHz, medium devsel
        I/O ports at 8400 [size=16]
        Memory at c0003000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [b0] HyperTransport: MSI Mapping Enable- Fixed+

00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE
Controller (prog-if 8a [Master SecP PriP])
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMMi
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 16
        I/O ports at 01f0 [size=8]
        I/O ports at 03f4 [size=1]
        I/O ports at 0170 [size=8]
        I/O ports at 0374 [size=1]
        I/O ports at 8410 [size=16]
        Capabilities: [70] Message Signalled Interrupts: Mask- 64bit- Queue=0/0
Enable-

00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMi
        Flags: bus master, 66MHz, medium devsel, latency 0

00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge (prog-if 01
[Subtractive decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=00, secondary=06, subordinate=06, sec-latency=64
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: c0200000-c02fffff

00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio
Controller (rev 02)
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMMi
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 17
        Memory at c0003400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Message Signalled Interrupts: Mask- 64bit- Queue=0/0
Enable-

00:14.6 Modem: ATI Technologies Inc SB400 AC'97 Modem Controller (rev 02)
(prog-if 00 [Generic])
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMMi
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 11
        Memory at c0003800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Message Signalled Interrupts: Mask- 64bit- Queue=0/0
Enable-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address
Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
        Flags: fast devsel

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility X700
(PCIE) (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMi
        Flags: bus master, fast devsel, latency 0, IRQ 18
        Memory at c8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 9000 [size=256]
        Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at c0120000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Express Endpoint, MSI 00
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0
Enable-

06:05.0 Network controller: Broadcom Corporation BCM4318 [AirForce One 54g]
802.11g Wireless LAN Controller (rev 02)
        Subsystem: AMBIT Microsystem Corp. Aspire 3022WLMi, 5024WLMi, 5020
        Flags: bus master, fast devsel, latency 64, IRQ 21
        Memory at c0204000 (32-bit, non-prefetchable) [size=8K]

06:06.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMi
        Flags: bus master, medium devsel, latency 64, IRQ 20
        Memory at c020a000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=06, secondary=07, subordinate=08, sec-latency=176
        Memory window 0: 60000000-63fff000 (prefetchable)
        Memory window 1: 64000000-67fff000 (prefetchable)
        I/O window 0: 0000a400-0000a4ff
        I/O window 1: 0000a800-0000a8ff
        16-bit legacy interface ports at 0001

06:06.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394 Host
Controller (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMi
        Flags: bus master, medium devsel, latency 64, IRQ 22
        Memory at c0208000 (32-bit, non-prefetchable) [size=2K]
        Memory at c0200000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

06:06.3 Mass storage controller: Texas Instruments PCIxx21 Integrated
FlashMedia Controller
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMi
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at c0206000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [44] Power Management version 2

06:06.4 Generic system peripheral [0805]: Texas Instruments
PCI6411/6421/6611/6621/7411/7421/7611/7621 Secure Digital Controller
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMi
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at c0209000 (32-bit, non-prefetchable) [size=256]
        Memory at c0208c00 (32-bit, non-prefetchable) [size=256]
        Memory at c0208800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

06:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit
Ethernet (rev 10)
        Subsystem: Acer Incorporated [ALI] Aspire 5024WLMi
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        I/O ports at a000 [size=256]
        Memory at c0209400 (32-bit, non-prefetchable) [size=256]
        [virtual] Expansion ROM at c0220000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

dmesg:
Linux version 2.6.24-gentoo-r2 (root@fuf) (gcc version 4.2.2 (Gentoo 4.2.2
p1.0)) #2 PREEMPT Mon Feb 11 18:58:21 CET 2008
Command line: root=/dev/hda5 udev powernow-k8.vcore_list=1125,925 
usbcore.autosuspend=1 hpet=force
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000004fea0000 (usable)
 BIOS-e820: 000000004fea0000 - 000000004feae000 (ACPI data)
 BIOS-e820: 000000004feae000 - 000000004ff00000 (ACPI NVS)
 BIOS-e820: 000000004ff00000 - 0000000050000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 155) 0 entries of 256 used
Entering add_active_range(0, 256, 327328) 1 entries of 256 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP 000F6DA0, 0014 (r0 PTLTD )
ACPI: RSDT 4FEA81E3, 0034 (r1 PTLTD    RSDT    6040000  LTP        0)
ACPI: FACP 4FEADE41, 0074 (r1 ATI    Piranha   6040000 ATI     F4240)
ACPI: DSDT 4FEA8217, 5C2A (r1    ATI    SB400  6040000 MSFT  100000E)
ACPI: FACS 4FEAEFC0, 0040
ACPI: SSDT 4FEADEB5, 00B5 (r1 PTLTD  POWERNOW  6040000  LTP        1)
ACPI: APIC 4FEADF6A, 005A (r1 PTLTD      APIC    6040000  LTP        0)
ACPI: MCFG 4FEADFC4, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
ACPI: DMI detected: Acer
Entering add_active_range(0, 0, 155) 0 entries of 256 used
Entering add_active_range(0, 256, 327328) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      155
    0:      256 ->   327328
On node 0 totalpages: 327227
  DMA zone: 56 pages used for memmap
  DMA zone: 1371 pages reserved
  DMA zone: 2568 pages, LIFO batch:0
  DMA32 zone: 4419 pages used for memmap
  DMA32 zone: 318813 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
ATI board detected. Disabling timer routing over 8254.
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 60000000 (gap: 50000000:aec00000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 321381
Kernel command line: root=/dev/hda5 udev powernow-k8.vcore_list=1125,925 
usbcore.autosuspend=1 hpet=force
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
TSC calibrated against PM_TIMER
time.c: Detected 1599.999 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ 180000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 1282044k/1309312k available (3486k kernel code, 26556k reserved, 1281k
data, 216k init)
Calibrating delay using timer specific routine.. 3202.05 BogoMIPS (lpj=1601028)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Turion(tm) 64 Mobile Technology ML-28 stepping 02
ACPI: Core revision 20070126
ACPI: Table DSDT replaced by host OS
ACPI: DSDT 00000000, 5624 (r1    ATI    SB400  6040000 INTL 20061109)
ACPI: DSDT override uses original SSDTs unless "acpi_no_auto_ssdt"<3>..MP-BIOS
bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
APIC timer calibration result 12499988
Detected 12.499 MHz APIC timer.
net_namespace: 120 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: EC: GPE = 0x3, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in interrupt mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB6_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB7_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:06.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:06.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:07.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:07.0
ACPI: RTC can wake from S4
Time: tsc clocksource has been installed.
system 00:01: iomem range 0xe0000000-0xefffffff has been reserved
system 00:01: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:01: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:08: ioport range 0x1080-0x1080 has been reserved
system 00:08: ioport range 0x1200-0x120f has been reserved
system 00:08: ioport range 0x500-0x51f has been reserved
system 00:08: ioport range 0x40b-0x40b has been reserved
system 00:08: ioport range 0x4d0-0x4d1 has been reserved
system 00:08: ioport range 0x4d6-0x4d6 has been reserved
system 00:08: ioport range 0xc00-0xc01 has been reserved
system 00:08: ioport range 0xc14-0xc14 has been reserved
system 00:08: ioport range 0xc50-0xc52 has been reserved
system 00:08: ioport range 0xc6c-0xc6c has been reserved
system 00:08: ioport range 0xc6f-0xc6f has been reserved
system 00:08: ioport range 0xcd4-0xcd5 has been reserved
system 00:08: ioport range 0xcd6-0xcd7 has been reserved
system 00:08: ioport range 0xcd8-0xcdf has been reserved
system 00:08: ioport range 0x8000-0x805f has been reserved
system 00:08: ioport range 0xf40-0xf47 has been reserved
system 00:08: ioport range 0x87f-0x87f has been reserved
system 00:09: iomem range 0xe0000-0xfffff could not be reserved
system 00:09: iomem range 0xfff80000-0xffffffff could not be reserved
system 00:09: iomem range 0x0-0xfff could not be reserved
PCI: Bridge: 0000:00:02.0
  IO window: 9000-9fff
  MEM window: c0100000-c01fffff
  PREFETCH window: c8000000-cfffffff
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 7, cardbus bridge: 0000:06:06.0
  IO window: 0000a400-0000a4ff
  IO window: 0000a800-0000a8ff
  PREFETCH window: 60000000-63ffffff
  MEM window: 64000000-67ffffff
PCI: Bridge: 0000:00:14.4
  IO window: a000-afff
  MEM window: c0200000-c02fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:07.0 to 64
ACPI: PCI Interrupt 0000:06:06.0[A] -> GSI 20 (level, low) -> IRQ 20
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
SGI XFS with large block/inode numbers, no debug enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: MSI quirk detected. MSI deactivated.
Boot video device is 0000:01:00.0
PCI: Setting latency timer of device 0000:00:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
PCI: Setting latency timer of device 0000:00:06.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
PCI: Setting latency timer of device 0000:00:07.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
Generic RTC Driver v1.07
Linux agpgart interface v0.102
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
input: Power Button (FF) as /devices/virtual/input/input0
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /devices/virtual/input/input1
ACPI: Lid Switch [LID0]
input: Sleep Button (CM) as /devices/virtual/input/input2
ACPI: Sleep Button (CM) [SLPB]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [TZS0] (57 C)
ACPI: Thermal Zone [TZS1] (53 C)
ACPI: Thermal Zone [TZSV] (65 C)
loop: module loaded
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller (0x1002:0x4376 rev 0x00) at  PCI slot 0000:00:14.1
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8410-0x8417, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8418-0x841f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
Switched to high resolution mode on CPU 0
hda: ST9160821A, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITAUJ-845D, ATAPI CD/DVD-ROM drive
hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/33 mode selected
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
Driver 'sd' needs updating - please use bus_type methods
ACPI: PCI Interrupt 0000:06:06.2[C] -> GSI 22 (level, low) -> IRQ 22
firewire_ohci: Added fw-ohci device 0000:06:06.2, OHCI version 1.10
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input3
rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month
i2c /dev entries driver
device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised:
dm-devel@redhat.com
cpuidle: using governor ladder
firewire_core: created new fw device fw0 (0 config rom retries, S400)
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x12a0b1, caps: 0xa04713/0x204000
input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio4/input/input4
cpuidle: using governor menu
Advanced Linux Sound Architecture Driver Version 1.0.15 (Tue Nov 20 19:16:42
2007 UTC).
ALSA device list:
  No soundcards found.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
powernow-k8: Found 1 AMD Turion(tm) 64 Mobile Technology ML-28 processors (1
cpu cores) (version 2.20.00)
powernow-k8: Requested Voltage for id0 is 1125 mV default voltage is 1450
powernow-k8: Performing required adjustment of 325 mV  or 13 25mV steps
powernow-k8: Requested Voltage for id1 is 925 mV default voltage is 1000
powernow-k8: Performing required adjustment of 75 mV  or 3 25mV steps
powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x11
powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x19
rtc_cmos 00:04: setting system clock to 2008-02-14 08:47:44 UTC (1202978864)
Marking TSC unstable due to TSC halts in idle
Time: acpi_pm clocksource has been installed.
XFS mounting filesystem hda5
Starting XFS recovery on filesystem: hda5 (logdev: internal)
Ending XFS recovery on filesystem: hda5 (logdev: internal)
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 216k freed
Clocksource tsc unstable (delta = -91005859 ns)
ACPI: WMI-Acer: Mapper loaded
acer_acpi: Acer Laptop ACPI Extras version 0.10.0
acer_acpi: Detected Acer AMW0 interface
Registered led device: acer_acpi:mail
fuse init (API version 7.9)
ndiswrapper version 1.52 loaded (smp=no, preempt=yes)
ndiswrapper (link_pe_images:576): fixing KI_USER_SHARED_DATA address in the
driver
ndiswrapper: driver bcmwl5 (Broadcom,02/11/2005, 3.100.64.0) loaded
ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 21 (level, low) -> IRQ 21
ndiswrapper: using IRQ 21
wlan0: ethernet device 00:0e:9b:bf:b0:b8 using NDIS driver: bcmwl5, version:
0x364400a, NDIS version: 0x501, vendor: 'NDIS Network Adapter',
14E4:4318.5.conf
wlan0: encryption modes supported: WEP; TKIP with WPA, WPA2, WPA2PSK; AES/CCMP
with WPA, WPA2, WPA2PSK
usbcore: registered new interface driver ndiswrapper
Adding 2449872k swap on /dev/mapper/crypt-swap.  Priority:-1 extents:1
across:2449872k
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 17
ndiswrapper: device wlan0 removed
ACPI: PCI interrupt for device 0000:06:05.0 disabled
usbcore: deregistering interface driver ndiswrapper
ndiswrapper version 1.52 loaded (smp=no, preempt=yes)
ndiswrapper (link_pe_images:576): fixing KI_USER_SHARED_DATA address in the
driver
ndiswrapper: driver bcmwl5 (Broadcom,02/11/2005, 3.100.64.0) loaded
ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 21 (level, low) -> IRQ 21
ndiswrapper: using IRQ 21
wlan0: ethernet device 00:0e:9b:bf:b0:b8 using NDIS driver: bcmwl5, version:
0x364400a, NDIS version: 0x501, vendor: 'NDIS Network Adapter',
14E4:4318.5.conf
wlan0: encryption modes supported: WEP; TKIP with WPA, WPA2, WPA2PSK; AES/CCMP
with WPA, WPA2, WPA2PSK
usbcore: registered new interface driver ndiswrapper
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:01:00.0 to 64
[drm] Initialized radeon 1.28.0 20060524 on minor 0
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs
XFS mounting filesystem hda6
Starting XFS recovery on filesystem: hda6 (logdev: internal)
Ending XFS recovery on filesystem: hda6 (logdev: internal)
APIC error on CPU0: 00(40)
hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: 0xea
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: DMA disabled
hda: drive not ready for command
ide0: reset: master: error (0x00?)
hda: status error: status=0x00 { }
ide: failed opcode was: unknown
hda: drive not ready for command
hda: status error: status=0x00 { }
ide: failed opcode was: unknown
hda: drive not ready for command
hda: status error: status=0x10 { SeekComplete }
ide: failed opcode was: unknown
hda: drive not ready for command
hda: status error: status=0x10 { SeekComplete }
ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: 0xea
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset: success
APIC error on CPU0: 40(40)
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
ide0: reset timed-out, status=0x80
hda: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset: success
hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: 0xea
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset timed-out, status=0x80
hda: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset: success
hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: 0xea
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset timed-out, status=0x80
hda: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset: success
hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: 0xea
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
psmouse.c: TouchPad at isa0060/serio4/input0 lost synchronization, throwing 2
bytes away.
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
