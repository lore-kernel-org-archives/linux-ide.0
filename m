From: Russell King <rmk@arm.linux.org.uk>
Subject: PATA timeouts on old thinkpad
Date: Fri, 21 Nov 2008 00:25:21 +0000
Message-ID: <20081121002521.GA12626@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42006 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbYKUAZc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Nov 2008 19:25:32 -0500
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1L3Jpu-0006sa-R0
	for linux-ide@vger.kernel.org; Fri, 21 Nov 2008 00:25:27 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1L3Jpr-0003yh-DQ
	for linux-ide@vger.kernel.org; Fri, 21 Nov 2008 00:25:23 +0000
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Last weekend I upgraded my old Thinkpad from Fedora Core 2 to F9
(a 2.6.9 kernel to a 2.6.25 kernel).  The old 2.6.9 kernel was
using the IDE drivers, and there have been no issues with IDE on
this hardware until this upgrade.

With 2.6.25, I'm randomly seeing:

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ca/00:02:ba:75:05/00:00:00:00:00/e0 tag 0 dma 1024 out
         res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for UDMA/33
ata1.01: configured for MWDMA1
ata1.00: configured for UDMA/33
ata1.01: configured for MWDMA1
ata1: EH complete
sd 0:0:0:0: [sda] 8007552 512-byte hardware sectors (4100 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 8007552 512-byte hardware sectors (4100 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA

I've killed off the hald thread responsible for polling the CD drive on
ata1.01 just in case it's somehow provoking this, but the timeout
continues to happen.

There doesn't seem to be any way of predicting these timeouts - it may
be as little as half an hour, or as long as a couple of days.

boot messages follow:

Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.25-14.fc9.i586 (mockbuild@) (gcc version 4.3.0 20080428 (Red Hat 4.3.0-8) (GCC) ) #1 SMP Thu May 1 05:49:25 EDT 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003fd0000 (usable)
 BIOS-e820: 0000000003fd0000 - 0000000003fdf000 (ACPI data)
 BIOS-e820: 0000000003fdf000 - 0000000003fe0000 (ACPI NVS)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
63MB LOWMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Using x86 segment limits to approximate NX protection
Entering add_active_range(0, 0, 16336) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->    16336
  HighMem     16336 ->    16336
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    16336
On node 0 totalpages: 16336
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 95 pages used for memmap
  Normal zone: 12145 pages, LIFO batch:1
  HighMem zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
DMI 2.0 present.
Using APIC driver default
ACPI Error (tbxfroot-0218): A valid RSDP was not found [20070126]
Allocating PCI resources starting at 10000000 (gap: 03fe0000:fc000000)
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16209
Kernel command line: ro root=/dev/sda2
No local APIC present or hardware disabled
mapped APIC to ffffb000 (0108b000)
Initializing CPU#0
CPU 0 irqstacks, hard=c07ba000 soft=c079a000
PID hash table entries: 256 (order: 8, 1024 bytes)
Detected 232.102 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 57200k/65344k available (2240k kernel code, 7732k reserved, 1121k data,
284k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffc52000 - 0xfffff000   (3764 kB)
    pkmap   : 0xff400000 - 0xff800000   (4096 kB)
    vmalloc : 0xc4800000 - 0xff3fe000   ( 939 MB)
    lowmem  : 0xc0000000 - 0xc3fd0000   (  63 MB)
      .init : 0xc0750000 - 0xc0797000   ( 284 kB)
      .data : 0xc0630178 - 0xc0748800   (1121 kB)
      .text : 0xc0400000 - 0xc0630178   (2240 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
SLUB: Genslabs=12, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 465.42 BogoMIPS (lpj=232713)
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Intel Pentium with F0 0F bug - workaround enabled.

Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 20k freed
ACPI: Core revision 20070126
ACPI Exception (tbxface-0629): AE_NO_ACPI_TABLES, While loading namespace from ACPI tables [20070126]
ACPI: Unable to load the System Description Tables
CPU0: Intel Mobile Pentium MMX stepping 01
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
sizeof(vma)=84 bytes
sizeof(page)=32 bytes
sizeof(inode)=340 bytes
sizeof(dentry)=132 bytes
sizeof(ext3inode)=492 bytes
sizeof(buffer_head)=56 bytes
sizeof(skbuff)=176 bytes
sizeof(task_struct)=3712 bytes
CPU0 attaching sched-domain:
 domain 0: span 00000001
  groups: 00000001
net_namespace: 548 bytes
Booting paravirtualized kernel on bare hardware
Time: 20:26:17  Date: 11/16/08
NET: Registered protocol family 16
No dock devices found.
PCI: PCI BIOS revision 2.10 entry at 0xfd880, last bus=0
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
pci 0000:00:06.3: quirk: region ef00-ef3f claimed by PIIX4 ACPI
pci 0000:00:06.3: quirk: region efa0-efaf claimed by PIIX4 SMB
pci 0000:00:06.3: PIIX4 devres C PIO at 15e8-15ef
pci 0000:00:06.3: PIIX4 devres E PIO at 0538-053f
pci 0000:00:06.3: PIIX4 devres I PIO at 002e-002f
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:06.0
PCI: setting IRQ 11 as level-triggered
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:03.0
PCI: Found IRQ 11 for device 0000:00:02.1
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI: Bus 1, cardbus bridge: 0000:00:02.0
  IO window: 0x00001000-0x000010ff
  IO window: 0x00001400-0x000014ff
  PREFETCH window: 0x10000000-0x13ffffff
  MEM window: 0x14000000-0x17ffffff
PCI: Bus 5, cardbus bridge: 0000:00:02.1
  IO window: 0x00001800-0x000018ff
  IO window: 0x00001c00-0x00001cff
  PREFETCH window: 0x18000000-0x1bffffff
  MEM window: 0x1c000000-0x1fffffff
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:03.0
PCI: Found IRQ 11 for device 0000:00:02.1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 2581k freed
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
audit: initializing netlink socket (disabled)
type=2000 audit(1226867180.298:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
pci 0000:00:03.0: Boot video device
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Non-volatile memory driver v1.2
Linux agpgart interface v0.103
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
brd: module loaded
input: Macintosh mouse button emulation as /devices/virtual/input/input0
Yenta: CardBus bridge found at 0000:00:02.0 [1014:0092]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:02.0, mfunc 0xfba97543, devctl 0x62
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:02.1 [1014:0092]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:02.1, mfunc 0xfba97543, devctl 0x62
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000020
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
registered taskstats version 1
  Magic number: 0:729:447
  hash matches drivers/base/power/main.c:222
Freeing unused kernel memory: 284k freed
Write protecting the kernel read-only data: 908k
pccard: CardBus card inserted into slot 1
SCSI subsystem initialized
Driver 'sd' needs updating - please use bus_type methods
libata version 3.00 loaded.
ata_piix 0000:00:06.1: version 2.12
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xfcf0 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xfcf8 irq 15
ata1.00: ATA-3: IBM-DTCA-24090, TC6IAB4A, max UDMA/33
ata1.00: 8007552 sectors, multi 16: LBA
ata1.01: ATAPI: SANYO CRD-S372B, 1.24I, max MWDMA1
ata1.00: configured for UDMA/33
ata1.01: configured for MWDMA1
ata1.00: configured for UDMA/33
ata1.01: configured for MWDMA1
ata1: EH complete
ata2: port disabled. ignoring.
scsi 0:0:0:0: Direct-Access     ATA      IBM-DTCA-24090   TC6I PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 8007552 512-byte hardware sectors (4100 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 8007552 512-byte hardware sectors (4100 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda4 < sda5 sda6 sda7 sda8 >
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 0:0:1:0: CD-ROM            SANYO    CRD-S372B        1.24 PQ: 0 ANSI: 5
IBM TrackPoint firmware: 0x06, buttons: 2/3
input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/input/input2
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
PCI: Found IRQ 11 for device 0000:00:06.2
uhci_hcd 0000:00:06.2: UHCI Host Controller
uhci_hcd 0000:00:06.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:06.2: irq 11, io base 0x00009000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.25-14.fc9.i586 uhci_hcd
usb usb1: SerialNumber: 0000:00:06.2
Driver 'sr' needs updating - please use bus_type methods
sr0: scsi3-mmc drive: 8x/24x xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 0:0:1:0: Attached scsi generic sg1 type 5
cs: IO port probe 0x210-0x21f: clean.
cs: IO port probe 0x170-0x177: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x300-0x4ff: excluding 0x330-0x337 0x388-0x38f 0x4d0-0x4d7
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x210-0x21f: clean.
cs: IO port probe 0x170-0x177: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x300-0x4ff: excluding 0x330-0x337 0x388-0x38f 0x4d0-0x4d7
cs: IO port probe 0xa00-0xaff: clean.
PCI: Enabling device 0000:05:00.0 (0000 -> 0003)
3c59x: Donald Becker and others.
0000:05:00.0: 3Com PCI 3CCFE575BT Cyclone CardBus at c4836000.
PCI: Setting latency timer of device 0000:05:00.0 to 64
input: PC Speaker as /devices/platform/pcspkr/input/input3
piix4_smbus 0000:00:06.3: Found 0000:00:06.3 device
piix4_smbus 0000:00:06.3: IBM system detected; this module may corrupt your serial eeprom! Refusing to load module!
piix4_smbus: probe of 0000:00:06.3 failed with error -1
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
