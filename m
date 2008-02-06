From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9904] New: ASUS DVD-E616A - drive side 80-wire cable detection failed
Date: Wed,  6 Feb 2008 12:40:10 -0800 (PST)
Message-ID: <bug-9904-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46851 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756575AbYBFUkO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 15:40:14 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m16KeArv013871
	for <linux-ide@vger.kernel.org>; Wed, 6 Feb 2008 12:40:12 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9904

           Summary: ASUS DVD-E616A - drive side 80-wire cable detection
                    failed
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
        ReportedBy: jtsn@gmx.de
                CC: jtsn@gmx.de


Latest working kernel version: none
Earliest failing kernel version: 2.6.21
Distribution: Gentoo (with vanilla kernel on x86_64) or Slackware (on i386).

Hardware Environment:

Mainboard: 939Dual-VSTA, BIOS P1.30
DVD-ROM drive: ASUS DVD-E616A (UDMA100 capable).

# dmesg

Linux version 2.6.24 (root@plex) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0.2)) #5
SMP Tue Jan 29 19:07:57 CET 2008
Command line: root=/dev/hda5 ro notsc
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
 BIOS-e820: 000000007ffb0000 - 000000007ffc0000 (ACPI data)
 BIOS-e820: 000000007ffc0000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ff380000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524208) 1 entries of 256 used
end_pfn_map = 1048576
DMI present.
ACPI: RSDP 000FA900, 0014 (r0 ACPIAM)
ACPI: RSDT 7FFB0000, 0038 (r1 A M I  OEMRSDT   9000625 MSFT       97)
ACPI: FACP 7FFB0200, 0084 (r2 A M I  OEMFACP   9000625 MSFT       97)
ACPI: DSDT 7FFB0440, 496C (r1  939DV 939DV122      122 INTL 20051117)
ACPI: FACS 7FFC0000, 0040
ACPI: APIC 7FFB0390, 0068 (r1 A M I  OEMAPIC   9000625 MSFT       97)
ACPI: MCFG 7FFB0400, 003C (r1 A M I  OEMMCFG   9000625 MSFT       97)
ACPI: OEMB 7FFC0040, 005C (r1 A M I  AMI_OEM   9000625 MSFT       97)
ACPI: HPET 7FFB4DB0, 0038 (r1 A M I  OEMHPET   9000625 MSFT       97)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524208) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524208
On node 0 totalpages: 524111
  DMA zone: 56 pages used for memmap
  DMA zone: 1761 pages reserved
  DMA zone: 2182 pages, LIFO batch:0
  DMA32 zone: 7110 pages used for memmap
  DMA32 zone: 513002 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, address 0xfec10000, GSI 24-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x10b9a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000e8000
swsusp: Registered nosave memory region: 00000000000e8000 - 0000000000100000
Allocating PCI resources starting at 88000000 (gap: 80000000:7f380000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 29664 bytes of per cpu data
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 515184
Kernel command line: root=/dev/hda5 ro notsc
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
hpet clockevent registered
TSC calibrated against HPET
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 2200.078 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ c0000000 size 256 MB
Memory: 2056944k/2096832k available (4067k kernel code, 39208k reserved, 1888k
data, 268k init)
Calibrating delay using timer specific routine.. 4402.66 BogoMIPS (lpj=8805336)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
APIC timer calibration result 12500443
Detected 12.500 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4400.15 BogoMIPS (lpj=8800304)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 02
Brought up 2 CPUs
net_namespace: 120 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0800-083f claimed by ali7101 ACPI
PCI: Transparent bridge - 0000:00:06.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HTT_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] -  67, should
be 5A [20070126]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 16 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 0 of device 0000:00:04.0
agpgart: Detected AGP bridge 20
Setting up ULi AGP.
agpgart: AGP aperture is 256M @ 0xc0000000
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
ACPI: RTC can wake from S4
Time: hpet clocksource has been installed.
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 1
system 00:07: ioport range 0x480-0x48f has been reserved
system 00:07: ioport range 0x4d0-0x4d1 has been reserved
system 00:07: ioport range 0x800-0x87f could not be reserved
system 00:07: ioport range 0x400-0x40f has been reserved
system 00:09: iomem range 0xfec00000-0xfec00fff has been reserved
system 00:09: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:09: iomem range 0xfec10000-0xfec10fff has been reserved
system 00:09: iomem range 0xff380000-0xffffffff could not be reserved
system 00:0d: ioport range 0x290-0x29f has been reserved
system 00:0e: iomem range 0xe0000000-0xefffffff has been reserved
system 00:0f: iomem range 0x0-0x9ffff could not be reserved
system 00:0f: iomem range 0xc0000-0xcffff has been reserved
system 00:0f: iomem range 0xe0000-0xfffff could not be reserved
system 00:0f: iomem range 0x100000-0x7fffffff could not be reserved
system 00:0f: iomem range 0x0-0x0 could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: d7e00000-d7efffff
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: d7f00000-d7ffffff
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: f5000000-f7efffff
  PREFETCH window: d8000000-dfffffff
PCI: Bridge: 0000:00:06.0
  IO window: e000-efff
  MEM window: f7f00000-f7ffffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 29
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 34
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.29 [Flags: R/O].
fuse init (API version 7.9)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:03:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PCI: Setting latency timer of device 0000:00:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
lp: driver loaded but no devices found
hpet_resources: 0xfed00000 is busy
Generic RTC Driver v1.07
Non-volatile memory driver v1.2
ppdev: user-space parallel port driver
Linux agpgart interface v0.102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport_pc 00:06: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: module loaded
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 21 (level, low) -> IRQ 21
eth0: RTL8110s at 0xffffc2000001ec00, 00:08:54:50:83:ee, XID 04000000 IRQ 21
uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005-7-29)
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 17 (level, low) -> IRQ 17
eth1: ULi M5263 at pci0000:00:11.0, 00:13:8f:c5:2b:56, irq 17.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller (0x10b9:0x5229 rev 0xc7) at  PCI slot 0000:00:12.0
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 19 (level, low) -> IRQ 19
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hdb: ST340016A, ATA DISK drive
hda: HDT722525DLAT80, ATA DISK drive
hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/133 mode selected
hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdb: UDMA/100 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdd: ASUS DVD-E616A, ATAPI CD/DVD-ROM drive
hdc: MATSHITADVD-RAM SW-9576S, ATAPI CD/DVD-ROM drive
hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/66 mode selected
hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdd: drive side 80-wire cable detection failed, limiting max speed to UDMA33
hdd: UDMA/33 mode selected
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 488397168 sectors (250059 MB) w/7674KiB Cache, CHS=30401/255/63
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 >
 hda1: <bsd: hda7 hda8 hda9 hda10 hda11 hda12 >
hdb: max request size: 128KiB
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63
hdb: cache flushes not supported
 hdb: hdb1
hdc: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 2048kB Cache
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ACPI: PCI Interrupt 0000:00:13.3[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:13.3: EHCI Host Controller
ehci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.3: debug port 1
ehci_hcd 0000:00:13.3: irq 23, io mem 0xf4fff800
ehci_hcd 0000:00:13.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 20, io mem 0xf4ffe000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 21 (level, low) -> IRQ 21
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 21, io mem 0xf4ffd000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 22 (level, low) -> IRQ 22
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.2: irq 22, io mem 0xf4ffc000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
usb 1-6: new high speed USB device using ehci_hcd and address 3
usb 1-6: configuration #1 chosen from 1 choice
usb 3-1: new full speed USB device using ohci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 4 ports detected
usb 4-2: new full speed USB device using ohci_hcd and address 2
usb 4-2: configuration #1 chosen from 1 choice
usb 3-1.1: new low speed USB device using ohci_hcd and address 3
usb 3-1.1: configuration #1 chosen from 1 choice
usb 3-1.2: new low speed USB device using ohci_hcd and address 4
usb 3-1.2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input2
input: PC Speaker as /class/input/input3
input: ImPS/2 Logitech Wheel Mouse as /class/input/input4
rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month
i2c /dev entries driver
ali1563_smbus 0000:00:07.0: Found ALi1563 SMBus at 0x0400
w83627ehf: Found W83627EHG chip at 0x290
device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised:
dm-devel@redhat.com
cpuidle: using governor ladder
cpuidle: using governor menu
input: Logitech  Logitech MOMO Racing  as /class/input/input5
Force feedback for Logitech force feedback devices by Johann Deneux
<johann.deneux@it.uu.se>
input: USB HID v1.00 Joystick [Logitech  Logitech MOMO Racing ] on
usb-0000:00:13.1-1.1
input: Logitech Logitech Force 3D Pro as /class/input/input6
Force feedback for Logitech force feedback devices by Johann Deneux
<johann.deneux@it.uu.se>
input: USB HID v1.10 Joystick [Logitech Logitech Force 3D Pro] on
usb-0000:00:13.1-1.2
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.15 (Tue Nov 20 19:16:42
2007 UTC).
usbcore: registered new interface driver snd-usb-audio
ALSA device list:
  #0: PnP Audio Device         at usb-0000:00:13.2-2, full speed
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ processors
(2 cpu cores) (version 2.20.00)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
rtc_cmos 00:02: setting system clock to 2008-02-06 18:43:02 UTC (1202323382)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 268k freed
udev: renamed network interface eth1 to eth0
udev: renamed network interface eth0_rename to eth1
EXT3 FS on hda5, internal journal
scsi 0:0:0:0: Direct-Access     Generic  USB CF Reader    0.00 PQ: 0 ANSI: 2
sd 0:0:0:0: [sda] Attached SCSI removable disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 0:0:0:1: Direct-Access     Generic  USB SD Reader    0.00 PQ: 0 ANSI: 2
sd 0:0:0:1: [sdb] Attached SCSI removable disk
sd 0:0:0:1: Attached scsi generic sg1 type 0
scsi 0:0:0:2: Direct-Access     Generic  USB MS Reader    0.00 PQ: 0 ANSI: 2
sd 0:0:0:2: [sdc] Attached SCSI removable disk
sd 0:0:0:2: Attached scsi generic sg2 type 0
scsi 0:0:0:3: Direct-Access     Generic  USB SM Reader    0.00 PQ: 0 ANSI: 2
sd 0:0:0:3: [sdd] Attached SCSI removable disk
sd 0:0:0:3: Attached scsi generic sg3 type 0
usb-storage: device scan complete

# lspci

00:00.0 Host bridge: ALi Corporation M1695 K8 Northbridge [PCI Express and
HyperTransport]
00:01.0 PCI bridge: ALi Corporation PCI Express Root Port
00:02.0 PCI bridge: ALi Corporation PCI Express Root Port
00:04.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8 Single
Chip]
00:05.0 PCI bridge: ALi Corporation AGP8X Controller
00:06.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge
00:07.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev 70)
00:07.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:11.0 Ethernet controller: ALi Corporation ULi 1689,1573 integrated ethernet.
(rev 40)
00:12.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address
Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
03:00.0 VGA compatible controller: nVidia Corporation NV40 [GeForce 6800] (rev
a1)
04:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit
Ethernet (rev 10)

Software Environment:

Vanilla kernel 2.6.24

Problem Description:

The ASUS DVD-E616A DVD-ROM drive is capable of doing UDMA100. In the
configuration above it is configured for cable-select and connected to the
mainboard PATA controller via an 80-wire cable together with a Panasonic
SW-9576. This configuration works fine on other operating systems, e. g. BSD.

The 80-wire detection for this drive fails on Linux with this message:

hdd: ASUS DVD-E616A, ATAPI CD/DVD-ROM drive
hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdd: drive side 80-wire cable detection failed, limiting max speed to UDMA33
hdd: UDMA/33 mode selected

This happens regardless wether it is connected at the end of the cable, in the
middle, configured as master/slave etc., while the 80-wire detection for the
other DVD drive (Panasonic SW-9576) on the same cable succeeds. Even if the
DVD-E616A is connected alone as single drive, the detection fails.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
