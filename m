From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: Re: Freeze after disabling write cache with hdparm -W0 /dev/sda
Date: Wed, 11 Jul 2007 13:25:38 +0100
Message-ID: <4694CC42.3060808@onelan.co.uk>
References: <46935C4D.40003@onelan.co.uk> <4694669E.7060600@gmail.com> <46949555.9060208@onelan.co.uk> <469496A4.7070902@gmail.com> <46949AB1.80705@onelan.co.uk> <46949B97.8090703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.mail.uk.clara.net ([80.168.70.181]:54605 "EHLO
	relay1.mail.uk.clara.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759415AbXGKMZs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 08:25:48 -0400
In-Reply-To: <46949B97.8090703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Simon Farnsworth wrote:
>> Tejun Heo wrote:
>>> Simon Farnsworth wrote:
>>>> Just a thought; is it possible to trigger libata EH from userspace? If
>>>> so, we could write a small utility to disable write cache, then force EH
>>>> to detect the change.
>>> That's automatically done.  libata snoops cache on/off and triggers
>>> revalidation but you can request manual rescan by echoing "- - -" to
>>> /sys/class/scsi_host/hostX/scan.
>>>
>> Would it be worth changing our code to do "hdparm -W1 /dev/sda && hdparm
>> -W0 /dev/sda", or would this not show anything. The lack of revalidation
>> on some drives is what's worrying me a little here.
> 
> Revalidation happens after cache property is changed successfully.  What
> happens if you request manual rescan while the drive is not repsponding?
> 
The 30 second freeze happens when we request manual rescan. We do
revalidate once the freeze is over, though; dmesg follows:

Linux version 2.6.21-1.3189.ONELAN2
(sfarnsworth@fc4simon.office.onelan.co.uk) (gcc version 4.0.1 20050727
(Red Hat 4.0.1-5)) #1 SMP Wed Jun 27 10:39:33 BST 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 00000000000a0000 end:
00000000000a0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end:
0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000000def0000 end:
000000000dff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000dff0000 size: 0000000000003000 end:
000000000dff3000 type: 4
copy_e820_map() start: 000000000dff3000 size: 000000000000d000 end:
000000000e000000 type: 3
copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end:
0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dff0000 (usable)
 BIOS-e820: 000000000dff0000 - 000000000dff3000 (ACPI NVS)
 BIOS-e820: 000000000dff3000 - 000000000e000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
223MB LOWMEM available.
Using x86 segment limits to approximate NX protection
Entering add_active_range(0, 0, 57328) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->    57328
  HighMem     57328 ->    57328
early_node_map[1] active PFN ranges
    0:        0 ->    57328
On node 0 totalpages: 57328
  DMA zone: 40 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4056 pages, LIFO batch:0
  Normal zone: 519 pages used for memmap
  Normal zone: 52713 pages, LIFO batch:15
  HighMem zone: 0 pages used for memmap
DMI 2.2 present.
Using APIC driver default
ACPI: RSDP 000F6620, 0014 (r0 VT9174)
ACPI: RSDT 0DFF3000, 0028 (r1 VT9174 AWRDACPI 42302E31 AWRD        0)
ACPI: FACP 0DFF3040, 0074 (r1 VT9174 AWRDACPI 42302E31 AWRD        0)
ACPI: DSDT 0DFF30C0, 2FDD (r1 VT9174 AWRDACPI     1000 MSFT  100000C)
ACPI: FACS 0DFF0000, 0040
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 10000000 (gap: 0e000000:f1ff0000)
Built 1 zonelists.  Total pages: 56769
Kernel command line: ro root=/dev/VolGroup00/LogVol00 quiet
No local APIC present or hardware disabled
mapped APIC to ffffd000 (0123a000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0764000 soft=c0784000
PID hash table entries: 1024 (order: 10, 4096 bytes)
Detected 999.856 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 220272k/229312k available (2080k kernel code, 8588k reserved,
1110k data, 240k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffc56000 - 0xfffff000   (3748 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xce800000 - 0xff7fe000   ( 783 MB)
    lowmem  : 0xc0000000 - 0xcdff0000   ( 223 MB)
      .init : 0xc0723000 - 0xc075f000   ( 240 kB)
      .data : 0xc060835e - 0xc071dcb0   (1110 kB)
      .text : 0xc0400000 - 0xc060835e   (2080 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2000.91 BogoMIPS
(lpj=1000459)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0381b83f 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 64K (32 bytes/line)
CPU: After all inits, caps: 0381b13f 00000000 00000000 00000000 00000000
000000dd 00000000
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20070126
ACPI: setting ELCR to 0200 (from 1e20)
CPU0: Centaur VIA Nehemiah stepping 08
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
sizeof(vma)=84 bytes
sizeof(page)=40 bytes
sizeof(inode)=420 bytes
sizeof(dentry)=144 bytes
sizeof(ext3inode)=596 bytes
sizeof(buffer_head)=56 bytes
sizeof(skbuff)=176 bytes
sizeof(task_struct)=1408 bytes
Time: 12:17:05  Date: 06/11/107
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb260, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by vt8235 PM
PCI quirk: region 0500-050f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:00: iomem range 0xd0000-0xd3fff has been reserved
pnp: 00:00: iomem range 0xe2000-0xe3fff has been reserved
pnp: 00:00: iomem range 0xf0000-0xfbfff could not be reserved
pnp: 00:00: iomem range 0xfc000-0xfffff could not be reserved
pnp: 00:02: ioport range 0x400-0x47f has been reserved
pnp: 00:02: ioport range 0x500-0x50f has been reserved
Time: tsc clocksource has been installed.
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: dc000000-ddffffff
  PREFETCH window: d8000000-dbffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 5, 196608 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
checking if image is initramfs... it is
Switched to high resolution mode on CPU 0
Freeing initrd memory: 1790k freed
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1184156225.683:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 2 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
agpgart: Detected VIA CLE266 chipset
agpgart: AGP aperture is 128M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Time: acpi_pm clocksource has been installed.
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /class/input/input0
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input1
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
  Magic number: 15:821:278
  hash matches device tty15
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 240k freed
Write protecting the kernel read-only data: 818k
SCSI subsystem initialized
libata version 2.20 loaded.
pata_via 0000:00:11.1: version 0.2.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level,
low) -> IRQ 11
PCI: VIA VLink IRQ fixup for 0000:00:11.1, from 255 to 11
ata1: PATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001e000
irq 14
ata2: PATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001e008
irq 15
scsi0 : pata_via
ata1.00: ata_hpa_resize 1: sectors = 156301488, hpa_sectors = 156301488
ata1.00: ATA-7: MAXTOR STM380215A, 3.AAC, max UDMA/100
ata1.00: 156301488 sectors, multi 16: LBA48
ata1.00: ata_hpa_resize 1: sectors = 156301488, hpa_sectors = 156301488
ata1.00: configured for UDMA/100
scsi1 : pata_via
ATA: abnormal status 0x8 on port 0x00010177
scsi 0:0:0:0: Direct-Access     ATA      MAXTOR STM380215 3.AA PQ: 0 ANSI: 5
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised:
dm-devel@redhat.com
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1184156228.728:2): selinux=0 auid=4294967295
FDC 0 is a post-1991 82077
via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
via-rhine: Broken BIOS detected, avoid_D3 enabled.
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level,
low) -> IRQ 11
eth0: VIA Rhine II at 0xde002000, 00:40:63:ed:8b:32, IRQ 11.
eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 10 (level,
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:11.5 to 64
NET: Registered protocol family 23
Linux video capture interface: v2.00
saa7130/34: v4l2 driver version 0.2.14 loaded
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LNKB] -> GSI 12 (level,
low) -> IRQ 12
saa7133[0]: found at 0000:00:14.0, rev: 209, irq: 12, latency: 32, mmio:
0xde003000
saa7133[0]: subsystem: 17de:7250, board: KWorld DVB-T 210
[card=114,autodetected]
saa7133[0]: board init: gpio is 100
saa7133[0]: i2c eeprom 00: de 17 50 72 ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
tuner 0-004b: chip found @ 0x96 (saa7133[0])
tuner 0-004b: setting tuner address to 61
tuner 0-004b: type set to tda8290+75a
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
tuner 0-004b: setting tuner address to 61
tuner 0-004b: type set to tda8290+75a
saa7133[0]: registered device video0 [v4l2]
saa7133[0]: registered device vbi0
saa7133[0]: registered device radio0
DVB: registering new adapter (saa7133[0]).
DVB: registering frontend 0 (Philips TDA10046H DVB-T)...
tda1004x: setting up plls for 48MHz sampling clock
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 5 (level, low)
-> IRQ 5
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: irq 5, io mem 0xde001000
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
hub 1-0:1.0: over-current change on port 5
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level,
low) -> IRQ 11
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 11, io base 0x0000d400
hub 1-0:1.0: over-current change on port 6
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 12 (level,
low) -> IRQ 12
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 12, io base 0x0000d800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 10 (level,
low) -> IRQ 10
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 10, io base 0x0000dc00
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
tda1004x: timeout waiting for DSP ready
tda1004x: found firmware revision 0 -- invalid
tda1004x: trying to boot from eeprom
ata1.00: ata_hpa_resize 1: sectors = 156301488, hpa_sectors = 156301488
ata1.00: ata_hpa_resize 1: sectors = 156301488, hpa_sectors = 156301488
ata1.00: configured for UDMA/100
ata1: EH pending after completion, repeating EH (cnt=4)
ata1: soft resetting port
tda1004x: timeout waiting for DSP ready
tda1004x: found firmware revision 0 -- invalid
tda1004x: waiting for firmware upload...
tda1004x: no firmware upload (timeout or file not found?)
tda1004x: firmware upload failed
ata1.00: ata_hpa_resize 1: sectors = 156301488, hpa_sectors = 156301488
ata1.00: ata_hpa_resize 1: sectors = 156301488, hpa_sectors = 156301488
ata1.00: configured for UDMA/100
ata1: EH complete
ata2: soft resetting port
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
ATA: abnormal status 0x8 on port 0x00010177
ata2: EH complete
usbcore: registered new interface driver usbvision
USBVision USB Video Device Driver for Linux : 0.9.9
bay: Unknown symbol is_dock_device
bay: Unknown symbol register_hotplug_dock_device
bay: Unknown symbol unregister_hotplug_dock_device
input: Power Button (FF) as /class/input/input2
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input3
ACPI: Power Button (CM) [PWRB]
No dock devices found.
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2097144k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1
across:2097144k
vt1211: Found VT1211 chip at 0x6000, revision 2
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
eth0: no IPv6 routers present
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level,
low) -> IRQ 11
[drm] Initialized via 2.11.0 20061227 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
BUG: warning at kernel/softirq.c:138/local_bh_enable() (Not tainted)
 [<c042afff>] local_bh_enable+0x45/0x96
 [<c0603cde>] cond_resched_softirq+0x2d/0x43
 [<c05d55bf>] established_get_first+0x17/0xac
 [<c05d8f93>] tcp_seq_next+0x71/0x86
 [<c048c004>] seq_read+0x181/0x268
 [<c048be83>] seq_read+0x0/0x268
 [<c0476651>] vfs_read+0xab/0x15a
 [<c0476fb7>] sys_read+0x41/0x67
 [<c0404ecc>] syscall_call+0x7/0xb
 =======================

-- 
Simon Farnsworth

