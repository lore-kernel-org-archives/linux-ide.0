From: Benjamin LaHaise <bcrl@kvack.org>
Subject: 2.6.21-rc1: irq 11: nobody cared with PCMCIA CF adapter
Date: Sat, 24 Feb 2007 11:06:05 -0500
Message-ID: <20070224160605.GG26583@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kanga.kvack.org ([66.96.29.28]:48072 "EHLO kanga.kvack.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933513AbXBXQGT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Feb 2007 11:06:19 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi folks,

Trying out 2.6.21-rc1 on a Compaq Presario 2100 with a PCMCIA to Compact 
Flash adapter is showing a new problem in reporting an irq 11: nobody 
cared followed by a subsequent ide timeout.  The traceback is below.  A 
bcm43xx wireless PCMCIA doesn't have the same problem, so it seems like 
a libata issue.  Cheers,

		-ben

Linux version 2.6.21-rc1 (bcrl@stealth.home.kvack.org) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-51)) #1 Thu Feb 22 19:29:40 EST 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009f800 end: 000000000009f800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009f800 size: 0000000000000800 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000d0000 size: 0000000000030000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000002edf0000 end: 000000002eef0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000002eef0000 size: 000000000000f000 end: 000000002eeff000 type: 3
copy_e820_map() start: 000000002eeff000 size: 0000000000001000 end: 000000002ef00000 type: 4
copy_e820_map() start: 000000002ef00000 size: 0000000000100000 end: 000000002f000000 type: 2
copy_e820_map() start: 00000000fffc0000 size: 0000000000040000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002eef0000 (usable)
 BIOS-e820: 000000002eef0000 - 000000002eeff000 (ACPI data)
 BIOS-e820: 000000002eeff000 - 000000002ef00000 (ACPI NVS)
 BIOS-e820: 000000002ef00000 - 000000002f000000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
750MB LOWMEM available.
Entering add_active_range(0, 0, 192240) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   192240
early_node_map[1] active PFN ranges
    0:        0 ->   192240
On node 0 totalpages: 192240
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1469 pages used for memmap
  Normal zone: 186675 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP 000F7470, 0014 (r0 PTLTD )
ACPI: RSDT 2EEF8C72, 0030 (r1 PTLTD    RSDT    6040000  LTP        0)
ACPI: FACP 2EEFEE4C, 0074 (r1 ATI    Raptor    6040000 ATI     F4240)
ACPI: DSDT 2EEF8CA2, 61AA (r1    ATI U1_M1535  6040000 MSFT  100000D)
ACPI: FACS 2EEFFFC0, 0040
ACPI: BOOT 2EEFEEC0, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: SSDT 2EEFEEE8, 0118 (r1 PTLTD  POWERNOW  6040000  LTP        1)
ATI board detected. Disabling timer routing over 8254.
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 30000000 (gap: 2f000000:d0fc0000)
Detected 1788.984 MHz processor.
Built 1 zonelists.  Total pages: 190739
Kernel command line: ro root=LABEL=/
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (015e3000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 755276k/768960k available (2982k kernel code, 13200k reserved, 1327k data, 228k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xef800000 - 0xfffb5000   ( 263 MB)
    lowmem  : 0xc0000000 - 0xeeef0000   ( 750 MB)
      .init : 0xc0538000 - 0xc0571000   ( 228 kB)
      .data : 0xc03e9a9b - 0xc0535a40   (1327 kB)
      .text : 0xc0100000 - 0xc03e9a9b   (2982 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3579.14 BogoMIPS (lpj=17895706)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD mobile AMD Athlon(tm) XP 2200+ stepping 01
Checking 'hlt' instruction... OK.
ACPI: Core revision 20070126
ACPI: setting ELCR to 0200 (from 0e28)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd87b, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using PIC for interrupt routing
ACPI: Device [FIR] status [0000000c]: functional but not present; setting present
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 8000-803f claimed by ali7101 ACPI
PCI quirk: region 8040-805f claimed by ali7101 SMB
Boot video device is 0000:01:05.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 6 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 6 10) *9
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:07: ioport range 0x40b-0x40b has been reserved
pnp: 00:07: ioport range 0x480-0x48f has been reserved
pnp: 00:07: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:07: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:07: ioport range 0x8000-0x807f could not be reserved
pnp: 00:07: iomem range 0xe0500000-0xe0500fff has been reserved
pnp: 00:07: iomem range 0xd0500000-0xd0500fff has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: e4100000-e41fffff
  PREFETCH window: ec000000-efffffff
PCI: Bus 2, cardbus bridge: 0000:00:0a.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 30000000-33ffffff
  MEM window: 34000000-37ffffff
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1267k freed
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
microcode: CPU0 not a capable Intel processor
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
audit: initializing netlink socket (disabled)
audit(1172191978.470:1): initialized
Total HugeTLB memory allocated, 0
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
Activating ISA DMA hang workarounds.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
input: Lid Switch as /class/input/input2
ACPI: Lid Switch [LID]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (67 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
ppdev: user-space parallel port driver
Linux agpgart interface v0.102 (c) Dave Jones
agpgart: Detected Ati IGP320/M chipset
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
[drm] Initialized radeon 1.25.0 20060524 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKG] -> GSI 3 (level, low) -> IRQ 3
0000:00:08.0: ttyS1 at I/O 0x8828 (irq = 3) is a 8250
0000:00:08.0: ttyS2 at I/O 0x8840 (irq = 3) is a 8250
0000:00:08.0: ttyS3 at I/O 0x8850 (irq = 3) is a 8250
Couldn't register serial port 0000:00:08.0: -28
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 0 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).
lp0: console ready
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
natsemi dp8381x driver, version 2.1, Sept 11, 2006
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
natsemi eth0: Aculab E1/T1 PMXc cPCI carrier card at 0xe4003000 (0000:00:12.0), 00:0b:cd:a5:aa:73, IRQ 11, port MII, ignoring PHY
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP MPPE Compression module registered
NET: Registered protocol family 24
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
alim15x3: ATI Radeon IGP Northbridge is not yet fully tested.
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: Unable to derive IRQ for device 0000:00:10.0
ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG MP0402H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78242976 sectors (40060 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0024]
Yenta O2: res at 0x94/0xD4: 00/ea
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0438, PCI irq 11
Socket status: 30000007
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input3
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
oprofile: using timer interrupt.
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: SGTC: 13333
powernow: Minimum speed 1060 MHz. Maximum speed 1788 MHz.
powernow-k8: Processor cpuid 681 not supported
Using IPI Shortcut mode
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Freeing unused kernel memory: 228k freed
Time: acpi_pm clocksource has been installed.
USB Universal Host Controller Interface driver v3.0
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKU] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 10, io mem 0xe4000000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
end_request: I/O error, dev fd0, sector 0
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
Synaptics Touchpad, model: 1, fw: 5.8, id: 0x2348b3, caps: 0x904713/0x10008
input: SynPS/2 Synaptics TouchPad as /class/input/input4
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 1595 types, 173 bools, 1 sens, 1024 cats
security:  59 classes, 50086 rules
security:  class dccp_socket not defined in policy
security:  permission dccp_recv in class node not defined in policy
security:  permission dccp_send in class node not defined in policy
security:  permission dccp_recv in class netif not defined in policy
security:  permission dccp_send in class netif not defined in policy
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda1, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1172191985.030:2): policy loaded auid=4294967295
rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
pnp: Device 00:02 does not support disabling.
rtc_cmos: probe of 00:02 failed with error -16
input: PC Speaker as /class/input/input5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKH] -> GSI 5 (level, low) -> IRQ 5
AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
ali mixer 1 creating error.
No dock devices found.
ibm_acpi: IBM ThinkPad ACPI Extras v0.13
ibm_acpi: http://ibm-acpi.sf.net/
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
EXT3 FS on hda1, internal journal
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
Clocksource tsc unstable (delta = -149864604 ns)
eth0: remaining active for wake-on-lan
pccard: CardBus card inserted into slot 0
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
bcm43xx driver
PCI: Enabling device 0000:02:00.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:02:00.0 to 64
bcm43xx: Chip ID 0x4318, rev 0x2
bcm43xx: Number of cores: 4
bcm43xx: Core 0: ID 0x800, rev 0xd, vendor 0x4243
bcm43xx: Core 1: ID 0x812, rev 0x9, vendor 0x4243
bcm43xx: Core 2: ID 0x804, rev 0xc, vendor 0x4243
bcm43xx: Core 3: ID 0x80d, rev 0x7, vendor 0x4243
bcm43xx: PHY connected
bcm43xx: Detected PHY: Analog: 3, Type 2, Revision 7
bcm43xx: Detected Radio: ID: 8205017f (Manuf: 17f Ver: 2050 Rev: 8)
bcm43xx: Radio turned off
bcm43xx: Radio turned off
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
SoftMAC: Associate: Scanning for networks first.
SoftMAC: Associate: failed to initiate scan. Is device up?
bcm43xx: PHY connected
bcm43xx: Microcode rev 0x122, pl 0x99 (2005-01-22  22:40:08)
bcm43xx: Radio turned on
bcm43xx: Radio enabled by hardware
bcm43xx: ASSERTION FAILED (radio_attenuation < 10) at: drivers/net/wireless/bcm43xx/bcm43xx_phy.c:1471:bcm43xx_find_lopair()
bcm43xx: ASSERTION FAILED (radio_attenuation < 10) at: drivers/net/wireless/bcm43xx/bcm43xx_phy.c:1471:bcm43xx_find_lopair()
bcm43xx: ASSERTION FAILED (radio_attenuation < 10) at: drivers/net/wireless/bcm43xx/bcm43xx_phy.c:1471:bcm43xx_find_lopair()
bcm43xx: Chip initialized
bcm43xx: 32-bit DMA initialized
bcm43xx: Keys cleared
bcm43xx: Selected 802.11 core (phytype 2)
bcm43xx: ASSERTION FAILED (radio_attenuation < 10) at: drivers/net/wireless/bcm43xx/bcm43xx_phy.c:1471:bcm43xx_find_lopair()
SoftMAC: Associate: Scanning for networks first.
SoftMAC: Scanning finished: scanned 14 channels starting with channel 1
SoftMAC: Queueing Authentication Request to 00:0c:e5:50:73:82
SoftMAC: Cannot associate without being authenticated, requested authentication
SoftMAC: Already requested authentication, waiting...
SoftMAC: Sent Authentication Request to 00:0c:e5:50:73:82.
SoftMAC: Open Authentication completed with 00:0c:e5:50:73:82
SoftMAC: sent association request!
SoftMAC: associated!
pccard: card ejected from slot 0
bcm43xx: Radio turned off
bcm43xx: Failed to switch to core 0
bcm43xx: Failed to switch to core 2
bcm43xx: gpio error: Neither ChipCommon nor PCI core available!
bcm43xx: DMA-32 0x0200 (RX) max used slots: 1/64
bcm43xx: Error: Wait on DMA RX status timed out.
bcm43xx: DMA-32 0x02A0 (TX) max used slots: 0/512
bcm43xx: Error: Wait on DMA TX status timed out.
bcm43xx: DMA-32 0x0280 (TX) max used slots: 0/512
bcm43xx: Error: Wait on DMA TX status timed out.
bcm43xx: DMA-32 0x0260 (TX) max used slots: 0/512
bcm43xx: Error: Wait on DMA TX status timed out.
bcm43xx: DMA-32 0x0240 (TX) max used slots: 0/512
bcm43xx: Error: Wait on DMA TX status timed out.
bcm43xx: DMA-32 0x0220 (TX) max used slots: 6/512
bcm43xx: Error: Wait on DMA TX status timed out.
bcm43xx: DMA-32 0x0200 (TX) max used slots: 0/512
bcm43xx: Error: Wait on DMA TX status timed out.
bcm43xx: Failed to switch to core 0
bcm43xx: Failed to switch to core 0
bcm43xx: Failed to switch to core 0
ACPI: PCI interrupt for device 0000:02:00.0 disabled
pccard: PCMCIA card inserted into slot 0
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
irq 11: nobody cared (try booting with the "irqpoll" option)
 [<c0147b94>] __report_bad_irq+0x24/0x80
 [<c0147dbb>] note_interrupt+0x1cb/0x200
 [<c0147275>] handle_IRQ_event+0x25/0x50
 [<c0148680>] handle_level_irq+0x80/0xb0
 [<c010658e>] do_IRQ+0x4e/0xa0
 [<c01048d7>] common_interrupt+0x23/0x28
 [<c0121fc0>] __do_softirq+0x30/0x90
 [<c0122047>] do_softirq+0x27/0x30
 [<c0106593>] do_IRQ+0x53/0xa0
 [<c01048d7>] common_interrupt+0x23/0x28
 [<c0233f9b>] delay_tsc+0xb/0x20
 [<c0233fe6>] __delay+0x6/0x10
 [<c031746b>] pcmcia_request_configuration+0x12b/0x3e0
 [<c03172a4>] pcmcia_request_io+0x74/0x110
 [<c02f9c71>] ide_probe+0x351/0x4c0
 [<c0313321>] pccard_get_tuple_data+0x81/0x90
 [<c03138ef>] pccard_read_tuple+0x5f/0xb0
 [<c01a0806>] __sysfs_make_dirent+0x86/0x90
 [<c0315883>] pcmcia_device_probe+0x83/0x110
 [<c02bc495>] really_probe+0x65/0x180
 [<c02bc5f9>] driver_probe_device+0x49/0xc0
 [<c03e706e>] klist_next+0x4e/0x90
 [<c02bb8a4>] bus_for_each_drv+0x44/0x70
 [<c02bc72a>] device_attach+0x7a/0x80
 [<c02bc670>] __device_attach+0x0/0x10
 [<c02bb70b>] bus_rescan_devices_helper+0x4b/0x90
 [<c02bb99a>] bus_for_each_dev+0x3a/0x60
 [<c02bb9d3>] bus_rescan_devices+0x13/0x20
 [<c02bb6c0>] bus_rescan_devices_helper+0x0/0x90
 [<c0314de4>] pcmcia_store_allow_func_id_match+0x64/0x90
 [<c0314d80>] pcmcia_store_allow_func_id_match+0x0/0x90
 [<c02b984d>] dev_attr_store+0x2d/0x40
 [<c019fbe2>] sysfs_write_file+0xb2/0x100
 [<c016885e>] vfs_write+0xbe/0x160
 [<c019fb30>] sysfs_write_file+0x0/0x100
 [<c0168e51>] sys_write+0x41/0x70
 [<c0103ec8>] sysenter_past_esp+0x5d/0x81
 =======================
handlers:
[<c031b540>] (yenta_interrupt+0x0/0xe0)
Disabling IRQ #11
Probing IDE interface ide2...
hde: CF Card, CFA DISK drive
ide2 at 0x100-0x107,0x10e on irq 11
hde: max request size: 128KiB
hde: 4030464 sectors (2063 MB) w/1KiB Cache, CHS=7872/16/32
 hde:<4>hde: lost interrupt

-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <zyntrop@kvack.org>.
