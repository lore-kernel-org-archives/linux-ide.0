From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Wed, 14 Mar 2007 16:03:10 +0800
Message-ID: <45F7AC3E.20700@tw.ibm.com>
References: <45F5465F.6050709@gmail.com> <45F55E21.4030208@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030500020701000902090909"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:37275 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933884AbXCNIDd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 04:03:33 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2E83WTb003516
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 04:03:32 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2E83W8h058586
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 02:03:32 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2E83VRl001864
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 02:03:32 -0600
In-Reply-To: <45F55E21.4030208@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, paul@paulbristow.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Stanislav Brabec <sbrabec@novell.com>

This is a multi-part message in MIME format.
--------------030500020701000902090909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> [libata]
>> And, as the device requires custom high level driver, libata fails
>> miserably.  Would it be worth to try support these devices?  Or are
>> they just too outdated to put the effort in?
> 
> 
> What SCSI peripheral device type does it report, when booted under libata?
> 
>     Jeff
> 
> 
> P.S.  As an aside, this reminds to unpack the SATA tape drive I was
> handed many moons ago, and test it with libata.
> 

Libata works well with my zip 100 drive since 2.6.18 or even earlier.
I just test it again with 2.6.20.3, it looks good on detection (except
the "abnormal status 0x7F on port 0xE08895DF" warning):

ata3.00: ATAPI, max UDMA/33
ata3.01: ATAPI, max UDMA/33
ata3.00: configured for UDMA/33
ata3.01: configured for UDMA/33
scsi3 : pata_pdc2027x
ATA: abnormal status 0x7F on port 0xE08895DF
ATA: abnormal status 0x7F on port 0xE08895DF
ata4.00: ATAPI, max PIO2, CDB intr
ata4.00: configured for PIO2
scsi 2:0:0:0: CD-ROM            LITE-ON  CD-RW SOHR-5238S 4S07 PQ: 0 ANSI: 5
scsi 2:0:1:0: CD-ROM            HL-DT-ST DVDRAM GSA-4163B A105 PQ: 0 ANSI: 5
scsi 3:0:0:0: Direct-Access     IOMEGA   ZIP 100          14.A PQ: 0 ANSI: 5

Read/write/eject also works without error.
Full dmesg attached for your reference.
--
albert

--------------030500020701000902090909
Content-Type: text/plain;
 name="dmesg_2.6.20.3_zip100.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_2.6.20.3_zip100.txt"

Linux version 2.6.20.3 (albertcc@p4ht-s.tw.ibm.com) (gcc version 4.0.0 20050519 (Red Hat 4.0.0-8)) #1 PREEMPT Wed Mar 14 15:03:36 CST 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001fef0000 end: 000000001fff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001fff0000 size: 0000000000003000 end: 000000001fff3000 type: 4
copy_e820_map() start: 000000001fff3000 size: 000000000000d000 end: 0000000020000000 type: 3
copy_e820_map() start: 00000000fec00000 size: 0000000001400000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Entering add_active_range(0, 0, 131056) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131056
  HighMem    131056 ->   131056
early_node_map[1] active PFN ranges
    0:        0 ->   131056
On node 0 totalpages: 131056
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 991 pages used for memmap
  Normal zone: 125969 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI 2.2 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f6e00
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff7680
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 2424.104 MHz processor.
Built 1 zonelists.  Total pages: 130033
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c041e000 soft=c041f000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 513740k/524224k available (2180k kernel code, 9820k reserved, 786k data, 200k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffdd000 - 0xfffff000   ( 136 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc03e7000 - 0xc0419000   ( 200 kB)
      .data : 0xc0321347 - 0xc03e5c10   ( 786 kB)
      .text : 0xc0100000 - 0xc0321347   (2180 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4851.82 BogoMIPS (lpj=9703655)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00003080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 09
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0e20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfae20, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
* The chipset may have PM-Timer Bug. Due to workarounds for a bug,
* this clock source is slow. If you are sure your timer does not have
* this bug, please use "acpi_pm_good" to disable the workaround
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:02: ioport range 0x400-0x4bf could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ec000000-edffffff
  PREFETCH window: e0000000-e7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: a000-cfff
  MEM window: ee000000-ee0fffff
  PREFETCH window: 30000000-300fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1796k freed
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1173886126.644:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (25 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
intel_rng: FWH not detected
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 845G Chipset.
agpgart: AGP aperture is 64M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide-floppy driver 0.99.newide
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 200k freed
SCSI subsystem initialized
libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac7
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi0 : ata_piix
logips2pp: Detected unknown logitech mouse model 11
ata1.00: ATA-6, max UDMA/100, 390721968 sectors: LBA48 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ata_piix
scsi 0:0:0:0: Direct-Access     ATA      WDC WD2000JB-00K 08.0 PQ: 0 ANSI: 5
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
pata_pdc2027x 0000:02:05.0: version 0.74-ac5
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
pata_pdc2027x 0000:02:05.0: PLL input clock 16961 kHz
ata3: PATA max UDMA/133 cmd 0xE08897C0 ctl 0xE0889FDA bmdma 0xE0889000 irq 10
ata4: PATA max UDMA/133 cmd 0xE08895C0 ctl 0xE0889DDA bmdma 0xE0889008 irq 10
scsi2 : pata_pdc2027x
input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
ata3.00: ATAPI, max UDMA/33
ata3.01: ATAPI, max UDMA/33
ata3.00: configured for UDMA/33
ata3.01: configured for UDMA/33
scsi3 : pata_pdc2027x
ATA: abnormal status 0x7F on port 0xE08895DF
ATA: abnormal status 0x7F on port 0xE08895DF
ata4.00: ATAPI, max PIO2, CDB intr
ata4.00: configured for PIO2
scsi 2:0:0:0: CD-ROM            LITE-ON  CD-RW SOHR-5238S 4S07 PQ: 0 ANSI: 5
scsi 2:0:1:0: CD-ROM            HL-DT-ST DVDRAM GSA-4163B A105 PQ: 0 ANSI: 5
scsi 3:0:0:0: Direct-Access     IOMEGA   ZIP 100          14.A PQ: 0 ANSI: 5
sd 3:0:0:0: Attached scsi removable disk sdb
sata_sil 0000:02:04.0: version 2.0
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNK0] -> GSI 11 (level, low) -> IRQ 11
ata5: SATA max UDMA/100 cmd 0xE0832080 ctl 0xE083208A bmdma 0xE0832000 irq 11
ata6: SATA max UDMA/100 cmd 0xE08320C0 ctl 0xE08320CA bmdma 0xE0832008 irq 11
scsi4 : sata_sil
ata5: SATA link down (SStatus 0 SControl 310)
scsi5 : sata_sil
ata6: SATA link down (SStatus 0 SControl 310)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1173886130.848:2): selinux=0 auid=4294967295
sr0: scsi3-mmc drive: 95x/52x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 2:0:0:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
sr 2:0:1:0: Attached scsi CD-ROM sr1
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
eth0: RealTek RTL8139 at 0xa000, 00:d0:68:01:36:f9, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.3[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 10, io mem 0xee100000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 9, io base 0x0000d800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 5, io base 0x0000d000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 10, io base 0x0000d400
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
asus_acpi: Unknown symbol backlight_device_unregister
asus_acpi: Unknown symbol backlight_device_register
input: Power Button (FF) as /class/input/input2
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input3
ACPI: Power Button (CM) [PWRB]
ibm_acpi: Unknown symbol backlight_device_unregister
ibm_acpi: Unknown symbol backlight_device_register
toshiba_acpi: Unknown symbol backlight_device_unregister
toshiba_acpi: Unknown symbol backlight_device_register
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1048568k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:1048568k
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
audit(1173857362.508:3): audit_pid=1780 old=0 by auid=4294967295
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
eth0: no IPv6 routers present
sdb: Spinning up disk.....ready
SCSI device sdb: 196608 512-byte hdwr sectors (101 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 40 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 196608 512-byte hdwr sectors (101 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 40 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb4

--------------030500020701000902090909--

