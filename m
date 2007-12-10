From: For Junk Mail <junk_mail@irishbroadband.net>
Subject: Re: Recent kernel hosing partition
Date: Mon, 10 Dec 2007 17:49:36 +0000
Message-ID: <1197308981.1873.75.camel@genius.chateau.dec>
References: <14119388.post@talk.nabble.com> <475CEFF8.5050707@gmail.com>
	 <f68177890712100208o27d71584l685520d2e9ecf5bd@mail.gmail.com>
	 <475D11A1.1070700@gmail.com>
	 <f68177890712100347i3a03df38n36cffd00c8603ae1@mail.gmail.com>
	 <475D41AA.2060205@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-I0tlIkfMOvmjSYV8bn72"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4.irishbroadband.ie ([62.231.32.17]:58376 "EHLO
	smtp4.irishbroadband.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbXLJSRM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 13:17:12 -0500
In-Reply-To: <475D41AA.2060205@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--=-I0tlIkfMOvmjSYV8bn72
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Business.kid using this address because gmail keeps bouncing linux-ide
for silly reasons.

On Mon, 2007-12-10 at 22:39 +0900, Tejun Heo wrote:

> 
> >     The drive is triggering all sorts of errors.  Can you post the
> >     result of 'smartctl -a /dev/sdX' where sdX is the offending drive.  Also
> >     please restore cc to linux-ide@vger.kernel.org
> >     <mailto:linux-ide@vger.kernel.org>.
> > 
> > 
> > Attached smartctl -a /dev/sda > smartctl.out
> > 
> > I see where you're going, and I think you're wrong. The drive is only 2
> > months old. I had heavy toolchain compiles and massive copies/ deletions
> > pass of without incident on sda8 while F7's root partition (sda3) was
> > lightly loaded by comparison. sda3 picked up _all_ the errors.  I never
> > hit an error on the hard work - no dodgy exits. The console stuff on
> > sda3 was all fine. It only screwed every application I was running under
> > X - Firefox particularly. I could still compile with the tools & libs on
> > sda3 when X was screwed. Badblocks never found a thing (e2fsck -cf).
> > Lost+found is empty on every other partition.
> 
> Right, it doesn't look like your harddrive is bad.
> 
> > Sadly, "errors all over the place" is common enough with Via chipsets
> > and Seagate disks.  I've seen it before. I'm stuck with Via in this box.
> > I would not have bought Seagate, but when someone gives it to you and
> > you're unemployed...
> 
> I'm not aware of any specific issues with via + Segate drives.  Have
> pointers?

Remember the infamous via 'hardware error' which via insist is a
configuration error from the MPV3 chipset? This 8235 southbridge is the
same southbridge basically, shrunk down and sped up. They never liked
Seagate drives, which seem to use non standard dma - fine with a windows
driver, but dodgy in linux. I did some crashtesting for mandrake on disk
optimizing scripts in times (far) past. They built a database of drives
and how fast they could set safely them, and Seagate never got past PIO
4. So I never bought Seagate.
> 
> > Another issue here is that the old ide driver could get through the
> > mess, whereas the newer one cannot. I get "Drive reset: success" and the
> > old ide driver recovers, whereas the new one goes out to lunch. The log
> > snippets show a 60 seconds gap between errors. That's a 60 second freeze.
> 
> Hmmm...
> 
> 1. So, the IDE driver suffers from error conditions too?  Do you have
> logs around?
> 
There is only IDE. No SATA. 80 ribbon cable. But Fedora only uses ATA
driver so it's sda, and not hda as per normal. Sorry for the confusion.
This is not a new box (2004/2005)

> 2. Do you have logs of libata driver goes out to lunch?
> 
Catch 22. Did you see the film? I've only one hard disk. Reset to get
out of trouble, so how does it log the disk going out to lunch?. Where
would I log it to?
https://bugzilla.redhat.com/attachment.cgi?id=281341 is the output of 
grep -C10 frozen /var/log/messages > errors.out which gives context. I
have the whole /var/log/messages. The recorded errors are mainly in the
bootup phase, as sda3 was unmountable every time there after an
'out-to-lunch' episode.

Typically, in an 'out to lunch' period, the line beginning 'exception
Emask' down as far as 'DPO or FUA' would repeat on stdout. Some disk
error would precede it, e.g. '/usr/lib/something.so: no such file or
directory'. That file would probably migrate to lost+found on the next
e2fsck pass and when I went to check it 2 reboots later it was indeed
missing. Then we got to the stage where the
entire /usr/lib/firefox<version>/  directory migrated and we departed
from reality at that point.

Somewhere, I actually have the datasheet for the actual chip, the Via
vt8235 southbridge. I acquired it around kernel 2.6.19 and did the test
work here on one of the dodgiest boxes in the universe to rid the
usb-2.0 driver of syslog spam about overcurrent change.

What was done then worked quite well. A patch was written to log the
values of certain registers to syslog. Then what was going wrong could
be seen, and it became evident the via hardware broke standards on 2 usb
ports. Via's solution was to disable those 2 ports :-/, but I had the
early rev of the chipset where they were in.


> 3. Can you post boot log from you current setup?
I presume you want the dmesg output - boot.log is dhcp stuff here. This
is the last dmesg from that kernel, which is clean. Just checking inside
the initrd, these are preloaded
/tmp/temp/lib/ata_generic.ko  /tmp/temp/lib/libata.ko    /tmp/temp/lib/scsi_mod.ko
/tmp/temp/lib/ehci-hcd.ko     /tmp/temp/lib/mbcache.ko   /tmp/temp/lib/scsi_wait_scan.ko
/tmp/temp/lib/ext3.ko         /tmp/temp/lib/ohci-hcd.ko  /tmp/temp/lib/sd_mod.ko
/tmp/temp/lib/jbd.ko          /tmp/temp/lib/pata_via.ko  /tmp/temp/lib/uhci-hcd.ko


If we can provoke the error, I feel the way to trap it is
1. make intelligent recoverable changes to ide partition /dev/sda3 on
firefox files.
2. Directly or indirectly, Mount my 1 gig usb disk on /var/log :-D.
Would that get around the Catch-22? I can stick in another (old) disk if
needed, but I only have ide, and we freeze, so that will hardly be much
good.
  
3. Go browsing and hope that trouble starts. 

Looking at the lost+found files in detail, I was struck by the #numbers.
There are a number of strings there: At least 3 from Firefox; at least
one each from openoffice, /etc/rc.d, and one I think from Evolution. 
-- 
For Junk Mail <junk_mail@irishbroadband.net>

--=-I0tlIkfMOvmjSYV8bn72
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=UTF-8
Content-Transfer-Encoding: 7bit

Linux version 2.6.23.1-21.fc7 (kojibuilder@xenbuilder4.fedora.phx.redhat.com) (gcc version 4.1.2 20070925 (Red Hat 4.1.2-27)) #1 SMP Thu Nov 1 21:09:24 EDT 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
Using x86 segment limits to approximate NX protection
Entering add_active_range(0, 0, 262128) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262128
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   262128
On node 0 totalpages: 262128
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 255 pages used for memmap
  HighMem zone: 32497 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
DMI 2.2 present.
Using APIC driver default
ACPI: RSDP 000F71F0, 0014 (r0 VIA694)
ACPI: RSDT 3FFF3000, 0028 (r1 VIA694 AWRDACPI 42302E31 AWRD        0)
ACPI: FACP 3FFF3040, 0074 (r1 VIA694 AWRDACPI 42302E31 AWRD        0)
ACPI: DSDT 3FFF30C0, 3ED7 (r1 VIA694 AWRDACPI     1000 MSFT  100000D)
ACPI: FACS 3FFF0000, 0040
ACPI: PM-Timer IO Port: 0x4008
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000f0000
swsusp: Registered nosave memory region: 00000000000f0000 - 0000000000100000
Built 1 zonelists in Zone order.  Total pages: 260081
Kernel command line: ro root=/dev/sda3 rhgb  noapic  
Found and enabled local APIC!
mapped APIC to ffffb000 (fee00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c07a5000 soft=c0785000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2075.150 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1031448k/1048512k available (2175k kernel code, 16264k reserved, 1114k data, 280k init, 131008k highmem)
virtual kernel memory layout:
    fixmap  : 0xffc53000 - 0xfffff000   (3760 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc073c000 - 0xc0782000   ( 280 kB)
      .data : 0xc061fcc5 - 0xc0736544   (1114 kB)
      .text : 0xc0400000 - 0xc061fcc5   (2175 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
SLUB: Genslabs=22, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 4152.30 BogoMIPS (lpj=2076153)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383f3ff c1c3fbff 00000000 00000420 00000000 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 14k freed
ACPI: Core revision 20070126
ACPI: setting ELCR to 0200 (from 1e20)
CPU0: AMD Athlon(tm) XP 2600+ stepping 01
SMP motherboard not detected.
Brought up 1 CPUs
sizeof(vma)=84 bytes
sizeof(page)=32 bytes
sizeof(inode)=336 bytes
sizeof(dentry)=132 bytes
sizeof(ext3inode)=488 bytes
sizeof(buffer_head)=56 bytes
sizeof(skbuff)=180 bytes
sizeof(task_struct)=1552 bytes
Booting paravirtualized kernel on bare hardware
Time: 11:09:11  Date: 12/10/07
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 4000-407f claimed by vt8235 PM
PCI quirk: region 5000-500f claimed by vt8235 SMB
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0
ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0
ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
Time: tsc clocksource has been installed.
pnp: 00:00: iomem range 0xcf800-0xcffff has been reserved
pnp: 00:00: iomem range 0xf0000-0xf7fff could not be reserved
pnp: 00:00: iomem range 0xf8000-0xfbfff could not be reserved
pnp: 00:00: iomem range 0xfc000-0xfffff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e4000000-e5ffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 2802k freed
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1197284951.414:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
- Added public key F78B1579A6D2C17
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: VIA PCI bridge detected. Disabling DAC.
Boot video device is 0000:01:00.0
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: Thermal Zone [THRM] (45 C)
isapnp: Scanning for PnP cards...
Switched to high resolution mode on CPU 0
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.102
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Marking TSC unstable due to: possible TSC halt in C2.
Time: acpi_pm clocksource has been installed.
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /class/input/input0
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input1
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Processor cpuid 681 not supported
Using IPI No-Shortcut mode
  Magic number: 3:569:175
  hash matches device device:0b
Freeing unused kernel memory: 280k freed
Write protecting the kernel read-only data: 844k
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 11, io base 0x0000d000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 5, io base 0x0000d400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 12, io base 0x0000d800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 2
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: irq 10, io mem 0xe6000000
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004, overcurrent ignored
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
SCSI subsystem initialized
libata version 2.21 loaded.
pata_via 0000:00:11.1: version 0.3.2
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: VIA VLink IRQ fixup for 0000:00:11.1, from 255 to 11
scsi0 : pata_via
scsi1 : pata_via
ata1: PATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001dc00 irq 14
ata2: PATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001dc08 irq 15
ata1.00: ATA-7: ST380215A, 3.AAC, max UDMA/100
ata1.00: 156301488 sectors, multi 16: LBA48 
ata1.00: configured for UDMA/100
ata2.00: ATAPI: TOSHIBA CD/DVDW SDR5372V, TU11, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      ST380215A        3.AA PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: CD-ROM            TOSHIBA  CD/DVDW SDR5372V TU11 PQ: 0 ANSI: 5
usb 1-1: new low speed USB device using uhci_hcd and address 3
usb 1-1: configuration #1 chosen from 1 choice
input: HID 1241:1166 as /class/input/input2
input: USB HID v1.10 Mouse [HID 1241:1166] on usb-0000:00:10.0-1
usb 1-2: new full speed USB device using uhci_hcd and address 4
usb 1-2: device descriptor read/64, error -71
usb 1-2: device descriptor read/64, error -71
usb 1-2: new full speed USB device using uhci_hcd and address 5
usb 1-2: device descriptor read/64, error -71
usb 1-2: device descriptor read/64, error -71
usb 1-2: new full speed USB device using uhci_hcd and address 6
usb 1-2: device not accepting address 6, error -71
usb 1-2: new full speed USB device using uhci_hcd and address 7
usb 1-2: device not accepting address 7, error -71
usb 2-2: new full speed USB device using uhci_hcd and address 2
usb 2-2: configuration #1 chosen from 1 choice
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1197284957.405:2): selinux=0 auid=4294967295
spurious 8259A interrupt: IRQ7.
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Attached scsi generic sg1 type 5
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
via-rhine: Broken BIOS detected, avoid_D3 enabled.
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
eth0: VIA Rhine II at 0xe6001000, 00:50:70:22:c5:73, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input5
ACPI: Sleep Button (CM) [SLPB]
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
parport_pc 00:0a: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
NET: Registered protocol family 23
ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1959920k swap on /dev/sda2.  Priority:-1 extents:1 across:1959920k

--=-I0tlIkfMOvmjSYV8bn72--

