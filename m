From: sampei02@tiscali.it
Subject: Re: UDMA modes
Date: Thu, 18 Aug 2005 08:19:20 +0200
Message-ID: <42D7AA4700049B26@mail-5.mail.tiscali.sys>
References: <42D7AAD50004A80D@mail-6.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mrqout1.tiscali.it ([195.130.225.11]:26344 "EHLO
	mrqout1.tiscali.it") by vger.kernel.org with ESMTP id S1750805AbVHRGTp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 02:19:45 -0400
In-Reply-To: <42D7AAD50004A80D@mail-6.mail.tiscali.sys>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

I attached all boot information (dmesg):

Linux version 2.6.12-1.1372_FC3 (bhcompile@tweety.build.redhat.com) (gc=
c
version 3.4.3 20050227 (Red Hat 3.4.3-22)) #1 Fri Jul 15 00:59:10 EDT 2=
005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fc570
ACPI: RSDT (v001 AMIINT VIA_P6   0x00000010 MSFT 0x00000097) @ 0x1fff00=
00
ACPI: FADT (v001 AMIINT VIA_P6   0x00000011 MSFT 0x00000097) @ 0x1fff00=
30
ACPI: DSDT (v001    VIA APOLLO-P 0x00001000 MSFT 0x0100000b) @ 0x000000=
00
ACPI: BIOS age (2000) fails cutoff (2001), acpi=3Dforce is required to =
enable
ACPI
ACPI: Disabling ACPI support
Allocating PCI resources starting at 20000000 (gap: 20000000:dfff0000)
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc0443000 soft=3Dc0442000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 798.102 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514556k/524224k available (2441k kernel code, 9012k reserved, 6=
87k
data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode..=
=2E
Ok.
Calibrating delay loop... 1568.76 BogoMIPS (lpj=3D784384)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 =
00000000
00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 0=
0000000
00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f1ff 00000000 00000000 00000040 0000000=
0
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
=46reeing initrd memory: 399k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
audit: initializing netlink socket (disabled)
audit(1124352260.309:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key D06D4AA4577B751B
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabl=
ed
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebu=
s=3Dxx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.=
1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6Y080L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdd: LG CD-ROM CRD-8521B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=3D65535/16/63, U=
DMA(33)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdd: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 7, 917504 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
=46reeing unused kernel memory: 180k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
logips2pp: Detected unknown logitech mouse model 0
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda5: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 211893
ext3_orphan_cleanup: deleting unreferenced inode 211933
ext3_orphan_cleanup: deleting unreferenced inode 394243
ext3_orphan_cleanup: deleting unreferenced inode 97736
ext3_orphan_cleanup: deleting unreferenced inode 394206
ext3_orphan_cleanup: deleting unreferenced inode 97759
ext3_orphan_cleanup: deleting unreferenced inode 394261
ext3_orphan_cleanup: deleting unreferenced inode 394220
ext3_orphan_cleanup: deleting unreferenced inode 394239
ext3_orphan_cleanup: deleting unreferenced inode 394260
ext3_orphan_cleanup: deleting unreferenced inode 390987
ext3_orphan_cleanup: deleting unreferenced inode 390979
ext3_orphan_cleanup: deleting unreferenced inode 390939
ext3_orphan_cleanup: deleting unreferenced inode 390945
ext3_orphan_cleanup: deleting unreferenced inode 390927
ext3_orphan_cleanup: deleting unreferenced inode 394259
ext3_orphan_cleanup: deleting unreferenced inode 390983
ext3_orphan_cleanup: deleting unreferenced inode 390995
ext3_orphan_cleanup: deleting unreferenced inode 394258
ext3_orphan_cleanup: deleting unreferenced inode 390941
ext3_orphan_cleanup: deleting unreferenced inode 391000
ext3_orphan_cleanup: deleting unreferenced inode 390973
ext3_orphan_cleanup: deleting unreferenced inode 390985
ext3_orphan_cleanup: deleting unreferenced inode 390981
ext3_orphan_cleanup: deleting unreferenced inode 390926
EXT3-fs: hda5: 25 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.27
PCI: Found IRQ 5 for device 0000:00:0a.0
eth0: RealTek RTL8139 at 0xd800, 00:50:bf:5a:8d:bf, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:07.2
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x0000dc00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on hda5, internal journal
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.co=
m
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1052216k swap on /dev/hda7.  Priority:-1 extents:1
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport_pc: VIA parallel port: io=3D0x378, irq=3D7
ieee1394: Initialized config rom entry `ip1394'
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
i2c /dev entries driver
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport_pc: VIA parallel port: io=3D0x378, irq=3D7
lp0: using parport0 (interrupt-driven).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03d2f00(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present




>-- Messaggio Originale --
>Date: Wed, 17 Aug 2005 10:17:07 +0200
>From: sampei02@tiscali.it
>Subject: Re: UDMA modes
>To: "Eric D. Mudama" <edmudama@gmail.com>
>Cc: "Erik Slagter" <erik@slagter.name>,
> linux-ide@vger.kernel.org
>
>
>I updated Kernel at 2.6.12-1.1372_FC3 by rpm package.
>
>Kernel reconized Controller IDE, infact dmesg command gets:
>
>Uniform Multi-PLatform E-IDE driver revision: 7.00alpha2
>VP_IDE: IDE controller at PCI slot 0000:00:07.1
>VP_IDE: chipset revision 6
>VP_IDE: not 100% native mode: will probe irqs later
>VP_IDE: VIA vt82c686b (rev.40) IDE UDMA100 controller on pci0000:00:07=
=2E1
>probing IDE interface ide0
>....
>
>What do you think ?
>
>
>>-- Messaggio Originale --
>>Date:	Tue, 16 Aug 2005 09:13:25 -0600
>>From:	"Eric D. Mudama" <edmudama@gmail.com>
>>To:	"sampei02@tiscali.it" <sampei02@tiscali.it>
>>Subject: Re: UDMA modes
>>Cc:	Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org
>>
>>
>>we'd need to see the dmesg output I am sure
>>
>>On 8/16/05, sampei02@tiscali.it <sampei02@tiscali.it> wrote:
>>> My Maxtor Hard Disk supports UDMA <=3D 6 (133)
>>> How can I control BITS options in controller ? What's line command =
?
>>> How can I verify controller is properly configured in my kernel ?
>>>
>>>
>>> >-- Messaggio Originale --
>>> >Subject: Re: UDMA modes
>>> >From: Erik Slagter <erik@slagter.name>
>>> >To: sampei02@tiscali.it
>>> >Cc: linux-ide@vger.kernel.org
>>> >Date: Tue, 16 Aug 2005 11:05:17 +0200
>>> >
>>> >
>>> >On Tue, 2005-08-16 at 09:02 +0200, sampei02@tiscali.it wrote:
>>> >> I have motherboard which supports DMA ATA 66/100/133 and I conne=
ct
>HD
>>> with
>>> >> new 80-wire cable.
>>> >> I have FC3 with Kernel 2.6.9
>>> >> With hdparm -i /dev/hda I get:
>>> >>
>>> >> DMA modes: udma0 udma1 udma2
>>> >> UDMA modes: udma0 udma1 *udma2
>>> >>
>>> >> Why udma is 2 and not udma 5 ?
>>> >
>>> >Controller not explicitly supported by linux or not configured in =
the
>>> >kernel? Controller needs BITS option? (see IDE config). Harddisk d=
oesn't
>>> >support > udma2?
>>> >
>>> >Allegato: signature.asc
>>> >
>>>
>>>
>>> __________________________________________________________________
>>> TISCALI ADSL 1.25 MEGA
>>> Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone =
Telecom
>>> a partire da 19,95 Euro/mese.
>>> Attivala entro il 31 agosto, il primo MESE =E8 GRATIS! CLICCA QUI.
>>> http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/
>>>
>>>
>>>
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe linux-ide=
"
in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>__________________________________________________________________
>TISCALI ADSL 1.25 MEGA
>Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Tel=
ecom
>a partire da 19,95 Euro/mese.
>Attivala entro il 31 agosto, il primo MESE =E8 GRATIS! CLICCA QUI.
>http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/
>
>
>


__________________________________________________________________
TISCALI ADSL 1.25 MEGA
Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Tele=
com
a partire da 19,95 Euro/mese.
Attivala entro il 31 agosto, il primo MESE =E8 GRATIS! CLICCA QUI.
http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/



