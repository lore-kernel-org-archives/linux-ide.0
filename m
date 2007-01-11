From: Kovid Goyal <kovid@theory.caltech.edu>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Thu, 11 Jan 2007 15:32:03 -0800
Message-ID: <200701111532.03235.kovid@theory.caltech.edu>
References: <200612111003.39928.kovid@theory.caltech.edu> <200612191800.18624.kovid@theory.caltech.edu> <45889C67.900@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zjspFTGNOPi8vI0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from theory.caltech.edu ([131.215.116.2]:35386 "EHLO
	theory.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154AbXAKXcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 18:32:05 -0500
In-Reply-To: <45889C67.900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

--Boundary-00=_zjspFTGNOPi8vI0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I was finally able to get the netconsole logs for a failing boot. Attached as 
log-panic. Sorry for the delay.

Thanks,

Kovid.

On Tuesday 19 December 2006 18:13, you wrote:
> Kovid Goyal wrote:
> > Yes going back to 2.6.17 does fix it. Also windows and various LiveCDs
> > boot without problems.
> >
> > Here is the output
> > smartctl -d ata -a /dev/sda
> > smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce
> > Allen Home page is http://smartmontools.sourceforge.net/
>
> Thanks, I couldn't find anything indicating hardware problem from the
> smartctl output.  Ergh... The 0xff timing out is fixed in the devel
> tree.  The problem is why sda sometimes doesn't get detected.  Can you
> post the result of failing dmesg?  If you've got a second computer,
> doing netconsole (Documentation/networking/netconsole.txt) is the best
> way.  If not, just take a picture of the screen while ata1 detection is
> in progress.

-- 
_____________________________________

Kovid Goyal  MC 452-48
California Institute of Technology
1200 E California Blvd
Pasadena, CA 91125

home  : +01 626 390 8699
office: +01 626 395 6595 (449 Lauritsen)
email : kovid@theory.caltech.edu
web   : http://www.kovidgoyal.net
_____________________________________

--Boundary-00=_zjspFTGNOPi8vI0
Content-Type: text/plain;
  charset="iso-8859-1";
  name="log-panic"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="log-panic"

Linux version 2.6.19-gentoo-r3 (root@giskard) (gcc version 4.1.1 (Gentoo 4.=
1.1-r3)) #1 SMP Sat Jan 6 09:35:46 PST 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fe88c00 (usable)
 BIOS-e820: 000000003fe88c00 - 000000003fe8ac00 (ACPI NVS)
 BIOS-e820: 000000003fe8ac00 - 000000003fe8cc00 (ACPI data)
 BIOS-e820: 000000003fe8cc00 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   261768
early_node_map[1] active PFN ranges
    0:        0 ->   261768
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x07] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x05] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Detected 3192.174 MHz processor.
Built 1 zonelists.  Total pages: 259723
Kernel command line: root=3D/dev/sda5 console=3Dtty1 netconsole=3D4444@192.=
168.1.100/eth0,6666@192.168.1.103/00:09:5B:0E:58:EE
netconsole: local port 4444
netconsole: local IP 192.168.1.100
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 192.168.1.103
netconsole: remote ethernet address 00:09:5b:0e:58:ee
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033260k/1047072k available (2672k kernel code, 13256k reserved, 87=
2k data, 228k init, 129568k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc047f000 - 0xc04b8000   ( 228 kB)
      .data : 0xc039c162 - 0xc047618c   ( 872 kB)
      .text : 0xc0100000 - 0xc039c162   (2672 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Using HPET for base-timer
Calibrating delay using timer specific routine.. 6388.08 BogoMIPS (lpj=3D31=
94042)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
=46reeing SMP alternatives: 20k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6383.99 BogoMIPS (lpj=3D31=
91999)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Total of 2 processors activated (12772.08 BogoMIPS).
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=3D296
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Firmware left 0000:03:08.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
pnp: 00:01: ioport range 0x800-0x85f could not be reserved
pnp: 00:01: ioport range 0xc00-0xc7f has been reserved
pnp: 00:01: ioport range 0x860-0x8ff could not be reserved
pnp: 00:0b: ioport range 0x100-0x1fe has been reserved
pnp: 00:0b: ioport range 0x200-0x277 has been reserved
pnp: 00:0b: ioport range 0x280-0x2e7 has been reserved
pnp: 00:0b: ioport range 0x2e8-0x2ef has been reserved
pnp: 00:0b: ioport range 0x2f0-0x2f7 has been reserved
pnp: 00:0b: ioport range 0x2f8-0x2ff has been reserved
pnp: 00:0b: ioport range 0x300-0x377 has been reserved
pnp: 00:0b: ioport range 0x380-0x3bb has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: dfe00000-dfffffff
  PREFETCH window: c0000000-cfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: dfd00000-dfdfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: c000-cfff
  MEM window: dfc00000-dfcfffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
hda: PHILIPS DVD+/-RW DVD8631, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
ata: 0x1F0 IDE port busy
ata: conflict with ide0
ata1: DUMMY
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
scsi0 : ata_piix
scsi1 : ata_piix
ata2: port disabled. ignoring.
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 17
ata3: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 17
ata4: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 17
scsi2 : ata_piix
scsi3 : ata_piix
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 18
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: irq 18, io mem 0xffa80800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 18, io base 0x0000ff80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ff60
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 20
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 20, io base 0x0000ff40
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 21
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 21, io base 0x0000ff20
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usb 2-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usb 3-2: new low speed USB device using uhci_hcd and address 3
usb 3-2: configuration #1 chosen from 1 choice
usb 4-1: new low speed USB device using uhci_hcd and address 2
usb 4-1: configuration #1 chosen from 1 choice
usb 4-2: new full speed USB device using uhci_hcd and address 3
usb 4-2: configuration #1 chosen from 1 choice
usb 5-1: new full speed USB device using uhci_hcd and address 2
usb 5-1: configuration #1 chosen from 2 choices
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 1 alt=
 0 proto 2 vid 0x03F0 pid 0x3A11
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
input: Microsoft Natural=AE Ergonomic Keyboard 4000 as /class/input/input0
input: USB HID v1.11 Keyboard [Microsoft Natural=AE Ergonomic Keyboard 4000=
] on usb-0000:00:1d.2-1
input: Microsoft Natural=AE Ergonomic Keyboard 4000 as /class/input/input1
input: USB HID v1.11 Device [Microsoft Natural=AE Ergonomic Keyboard 4000] =
on usb-0000:00:1d.2-1
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
input: Microsoft Natural=AE Ergonomic Keyboard 4000 as /class/input/input2
The simple driver 'usbnek4k' attach to the device 'Microsoft Natural=AE Erg=
onomic Keyboard 4000'
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input3
input: AT Translated Set 2 keyboard as /class/input/input4
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
input: ImExPS/2 Logitech MX Mouse as /class/input/input5
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "sda5" or unknown-block(2,0)
Please append a correct "root=3D" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2=
,0)
=20
--Boundary-00=_zjspFTGNOPi8vI0--
