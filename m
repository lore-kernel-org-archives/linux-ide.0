From: "Jonas Jensen" <jonas.jensen@gmail.com>
Subject: pata_via "frozen" DVD drive (TSSTcorp SN-S083A on EPIA EX15000)
Date: Tue, 14 Oct 2008 11:30:12 +0200
Message-ID: <338a6b6d0810140230t16f8da53y6facbcee174cad3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:1482 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbYJNJaN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 05:30:13 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2287206rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 02:30:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello!

I'm running kernel 2.6.26.5 no patches and came across this after
installing a new DVD drive. This is a Samsung SN-S083A slimline
optical connected with SATA cable to VIA EPIA EX15000 motherboard. I
get the exception trying a blank command such as "wodim dev=0,1,0
blank=fast".

HDD and DVD are detectable only with pata_via, this seems strange as
they are SATA drives connected with SATA cable. I have tried both AHCI
and sata_via, leaving out pata_via, but that always ends up in
kernelpanic and unbootable root filesystem. I assume no drives were
found (kernel text scrolls too fast to read).

When the DVD fails it seems to drag the HDD with it. Eventually the
HDD comes back but after that the DVD is nowhere to be found. I am
unsure what I can do to fix this issue but changing kernel is
definately an option if that helps.

syslog:

Oct 13 20:51:56 silverstone kernel: ata1.01: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x6 frozen
Oct 13 20:51:56 silverstone kernel: ata1.01: cmd
a0/00:00:00:00:00/00:00:00:00:00/b0 tag 0
Oct 13 20:51:56 silverstone kernel:          cdb 54 01 00 00 00 00 00
00  00 00 00 00 00 00 00 00
Oct 13 20:51:56 silverstone kernel:          res
40/00:02:00:4c:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
Oct 13 20:51:56 silverstone kernel: ata1.01: status: { DRDY }
Oct 13 20:51:56 silverstone kernel: ata1: soft resetting link
Oct 13 20:51:56 silverstone kernel: ata1.01: qc timeout (cmd 0xa1)
Oct 13 20:51:56 silverstone kernel: ata1.01: failed to IDENTIFY (I/O
error, err_mask=0x4)
Oct 13 20:51:56 silverstone kernel: ata1.01: revalidation failed (errno=-5)
Oct 13 20:51:56 silverstone kernel: ata1: failed to recover some
devices, retrying in 5 secs
Oct 13 20:51:56 silverstone kernel: ata1: link is slow to respond,
please be patient (ready=0)
Oct 13 20:51:56 silverstone kernel: ata1: device not ready
(errno=-16), forcing hardreset
Oct 13 20:51:56 silverstone kernel: ata1: soft resetting link
Oct 13 20:51:56 silverstone kernel: ata1.01: qc timeout (cmd 0xa1)
Oct 13 20:51:56 silverstone kernel: ata1.01: failed to IDENTIFY (I/O
error, err_mask=0x4)
Oct 13 20:51:56 silverstone kernel: ata1.01: revalidation failed (errno=-5)
Oct 13 20:51:56 silverstone kernel: ata1: failed to recover some
devices, retrying in 5 secs
Oct 13 20:51:56 silverstone kernel: ata1: link is slow to respond,
please be patient (ready=0)
Oct 13 20:51:56 silverstone kernel: ata1: device not ready
(errno=-16), forcing hardreset
Oct 13 20:51:56 silverstone kernel: ata1: soft resetting link
Oct 13 20:51:56 silverstone kernel: ata1.01: qc timeout (cmd 0xa1)
Oct 13 20:51:56 silverstone kernel: ata1.01: failed to IDENTIFY (I/O
error, err_mask=0x4)
Oct 13 20:51:56 silverstone kernel: ata1.01: revalidation failed (errno=-5)
Oct 13 20:51:56 silverstone kernel: ata1.01: disabled
Oct 13 20:51:56 silverstone kernel: ata1.00: failed to IDENTIFY (I/O
error, err_mask=0x40)
Oct 13 20:51:56 silverstone kernel: ata1.00: revalidation failed (errno=-5)
Oct 13 20:51:56 silverstone kernel: ata1: failed to recover some
devices, retrying in 5 secs
Oct 13 20:51:56 silverstone kernel: ata1: link is slow to respond,
please be patient (ready=0)
Oct 13 20:51:56 silverstone kernel: ata1: device not ready
(errno=-16), forcing hardreset
Oct 13 20:51:56 silverstone kernel: ata1: soft resetting link
Oct 13 20:51:56 silverstone kernel: ata1.00: configured for UDMA/133
Oct 13 20:51:56 silverstone kernel: ata1: EH complete
Oct 13 20:51:56 silverstone kernel: sd 0:0:0:0: [sda] 976773168
512-byte hardware sectors (500108 MB)
Oct 13 20:51:56 silverstone kernel: sd 0:0:0:0: [sda] Write Protect is off
Oct 13 20:51:56 silverstone kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 13 20:51:56 silverstone kernel: sd 0:0:0:0: [sda] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA


hdparm -I /dev/sr0:

/dev/sr0:

ATAPI CD-ROM, with removable media
        Model Number:       TSSTcorp CDDVDW SN-S083A
        Serial Number:
        Firmware Revision:  SB01
Standards:
        Supported: CD-ROM ATAPI-3 -4 -5 -6 -7
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=383ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SATA-I signaling speed (1.5Gb/s)
           *    Host-initiated interface power management
           *    Phy event counters
                Device-initiated interface power management
                unknown 78[5]
           *    Software settings preservation

dmesg:

Linux version 2.6.26.5 (root@silverstone) (gcc version 4.2.3 20071014
(prerelease) (Debian 4.2.2-3)) #6 Mon Oct 13 21:39:01 CEST 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bef0000 (usable)
 BIOS-e820: 000000001bef0000 - 000000001bef3000 (ACPI NVS)
 BIOS-e820: 000000001bef3000 - 000000001bf00000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
446MB LOWMEM available.
Entering add_active_range(0, 0, 114416) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   114416
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   114416
On node 0 totalpages: 114416
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 862 pages used for memmap
  Normal zone: 109458 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
DMI 2.3 present.
ACPI: RSDP 000F92A0, 0014 (r0 CX700 )
ACPI: RSDT 1BEF3040, 0030 (r1 CX700  AWRDACPI 30302E32 AWRD        0)
ACPI: FACP 1BEF30C0, 0084 (r2 CX700  AWRDACPI 30302E32 AWRD        0)
ACPI: DSDT 1BEF31C0, 3D9A (r1 CX700  AWRDACPI     1000 MSFT  100000E)
ACPI: FACS 1BEF0000, 0040
ACPI: MCFG 1BEF7080, 003C (r1 CX700  AWRDACPI 30302E32 AWRD        0)
ACPI: APIC 1BEF6FC0, 005A (r1 CX700  AWRDACPI 30302E32 AWRD        0)
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 20000000 (gap: 1bf00000:c4100000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 113522
Kernel command line: root=/dev/sda1 ro
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 1499.975 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449420k/457664k available (2242k kernel code, 7744k reserved,
1075k data, 148k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffff6000 - 0xfffff000   (  36 kB)
    vmalloc : 0xdc800000 - 0xffff4000   ( 567 MB)
    lowmem  : 0xc0000000 - 0xdbef0000   ( 446 MB)
      .init : 0xc0440000 - 0xc0465000   ( 148 kB)
      .data : 0xc03309d3 - 0xc043d708   (1075 kB)
      .text : 0xc0100000 - 0xc03309d3   (2242 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
Calibrating delay using timer specific routine.. 3001.98 BogoMIPS (lpj=6003961)
Mount-cache hash table entries: 512
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 128K (64 bytes/line)
CPU: Centaur VIA Esther processor 1500MHz stepping 09
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 0k freed
ACPI: Core revision 20080321
ACPI: setting ELCR to 0200 (from 0e28)
net_namespace: 192 bytes
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: MCFG configuration 0: base e0000000 segment 0 buses 2 - 2
PCI: MCFG area at e0000000 reserved in E820
PCI: Using MMCONFIG for extended config space
PCI: Using configuration type 1 for base access
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI Error (dsobject-0501): Package List length (8) larger than
NumElements count (2), truncated
 [20080321]
ACPI Error (dsobject-0501): Package List length (8) larger than
NumElements count (2), truncated
 [20080321]
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S5)
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:11.7: Disabling VIA CX700 PCI parking
pci 0000:00:11.7: Disabling VIA CX700 PCI caching
PCI: Transparent bridge - 0000:00:13.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2PE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2PB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 11 12) *5
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
system 00:01: ioport range 0x400-0x47f has been reserved
system 00:01: ioport range 0x500-0x50f has been reserved
system 00:02: iomem range 0xf0000000-0xf0000fff has been reserved
system 00:03: ioport range 0x4d0-0x4d1 has been reserved
system 00:03: ioport range 0x800-0x87f has been reserved
system 00:03: ioport range 0x880-0x8ff has been reserved
system 00:08: iomem range 0xe0000000-0xefffffff could not be reserved
system 00:09: iomem range 0xd0000-0xd3fff has been reserved
system 00:09: iomem range 0xda000-0xdbfff has been reserved
system 00:09: iomem range 0xf0000-0xfbfff could not be reserved
system 00:09: iomem range 0xfc000-0xfffff could not be reserved
system 00:09: iomem range 0x1bef0000-0x1befffff could not be reserved
system 00:09: iomem range 0xffff0000-0xffffffff could not be reserved
system 00:09: iomem range 0x0-0x9ffff could not be reserved
system 00:09: iomem range 0x100000-0x1beeffff could not be reserved
system 00:09: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:09: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:09: iomem range 0xfff80000-0xfffeffff has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: 0xdd000000-0xdeffffff
  PREFETCH window: 0x00000000a0000000-0x00000000bfffffff
PCI: Bridge: 0000:00:13.0
  IO window: d000-dfff
  MEM window: 0xdfe00000-0xdfefffff
  PREFETCH window: 0x00000000dfd00000-0x00000000dfdfffff
PCI: Bridge: 0000:00:13.1
  IO window: c000-cfff
  MEM window: 0xdfc00000-0xdfcfffff
  PREFETCH window: 0x00000000dfb00000-0x00000000dfbfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:00:13.0 to 64
PCI: Setting latency timer of device 0000:00:13.1 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
NET: Registered protocol family 1
eps: Detected VIA Model A C7
eps: Current voltage = 1004mV
eps: Current multiplier = 15
eps: Highest voltage = 1004mV
eps: Highest multiplier = 15
eps: Lowest voltage = 956mV
eps: Lowest multiplier = 8
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
msgmni has been set to 877
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
io scheduler cfq registered
PCI: VIA PCI bridge detected.Disabling DAC.
pci 0000:01:00.0: Boot video device
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input2
ACPI: Sleep Button (CM) [SLPB]
ACPI: ACPI0007:00 is registered as cooling_device0
Linux agpgart interface v0.103
agpgart: Detected VIA CX700 chipset
agpgart: AGP aperture is 128M @ 0xd0000000
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 10 (level,
low) -> IRQ 10
[drm] Initialized via 2.11.1 20070202 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
loop: module loaded
via-rhine: Broken BIOS detected, avoid_D3 enabled.
via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:03:08.0[A] -> Link [LNKC] -> GSI 11 (level,
low) -> IRQ 11
eth0: VIA Rhine III at 0xdfcff000, 00:40:63:ed:a4:d9, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
pata_via 0000:00:0f.0: version 0.3.3
scsi0 : pata_via
scsi1 : pata_via
ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
ata1.00: ATA-7: ST3500630AS, 3.AAE, max UDMA/133
ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.01: ATAPI: TSSTcorp CDDVDW SN-S083A, SB01, max UDMA/100
ata1.01: applying bridge limits
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/100 (device error ignored)
scsi 0:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 0:0:1:0: CD-ROM            TSSTcorp CDDVDW SN-S083A  SB01 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
sr 0:0:1:0: Attached scsi generic sg1 type 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:10.4[D] -> Link [LNKD] -> GSI 3 (level,
low) -> IRQ 3
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: debug port 1
ehci_hcd 0000:00:10.4: irq 3, io mem 0xdffff000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 10 (level,
low) -> IRQ 10
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 10, io base 0x0000f800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 11, io base 0x0000f400
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 11 (level,
low) -> IRQ 11
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 11, io base 0x0000f000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 2-2: new full speed USB device using uhci_hcd and address 2
usb 2-2: configuration #1 chosen from 1 choice
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
usb 2-2.1: new low speed USB device using uhci_hcd and address 3
usb 2-2.1: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
cpuidle: using governor ladder
usbcore: registered new interface driver hiddev
input: NOVATEK USB Keyboard as /class/input/input3
input: USB HID v1.10 Keyboard [NOVATEK USB Keyboard] on usb-0000:00:10.0-2.1
input: NOVATEK USB Keyboard as /class/input/input4
input,hiddev96: USB HID v1.10 Device [NOVATEK USB Keyboard] on
usb-0000:00:10.0-2.1
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.16.
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
PCI: Setting latency timer of device 0000:02:01.0 to 64
PCI: Disallowing DAC for device 0000:02:01.0
ALSA device list:
  #0: HDA VIA VT82xx at 0xdfefc000 irq 11
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Using IPI Shortcut mode
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 148k freed
cdrom: module is already loaded
sr_mod: module is already loaded
Adding 524280k swap on /swapfile.  Priority:-1 extents:159 across:651028k
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
