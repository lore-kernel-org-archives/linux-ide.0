From: Bob Ham <rah@bash.sh>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Wed, 01 Aug 2007 16:52:16 +0100
Message-ID: <1185983536.16340.3.camel@orchid.arb.net>
References: <1185880124.3483.25.camel@localhost>
	 <46AF76D7.8050800@ru.mvista.com> <1185916925.8484.23.camel@orchid.arb.net>
	 <200707312332.10820.bzolnier@gmail.com>  <46B08D63.4040205@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sLhxrAY2UxQBMQZvcHRa"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waffl.ing.me.uk ([217.147.94.6]:38908 "EHLO waffl.ing.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763079AbXHAPwU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Aug 2007 11:52:20 -0400
In-Reply-To: <46B08D63.4040205@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org


--=-sLhxrAY2UxQBMQZvcHRa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-08-01 at 17:40 +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> Bartlomiej Zolnierkiewicz wrote:
>=20
> >>>>>I've had a Highpoint Rocket 1540 (not "RocketRAID") SATA controller =
for
> >>>>>a while now, using a proprietary binary driver from Highpoint in a l=
inux
> >>>>>2.4 kernel.  The chipset is an hpt374.  The hpt366 driver freezes on
> >>>>>boot, as reported by others.
>=20
> >>>>   Can we see a bootlog please?
>=20
> >>>    ... and the output of 'lspci -v' too.
>=20
>     If possible, turn off that driver,=20
> then post that output...

This is the output of the boot using the pata_hpt37x driver:


Linux version 2.6.22.1 (rah@teasel) (gcc version 4.1.2 20061115
(prerelease) (Debian 4.1.1-21)) #6 Tue Jul 31 20:23:11 BST 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
 BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
 BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000ff780
Entering add_active_range(0, 0, 130880) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   130880
early_node_map[1] active PFN ranges
    0:        0 ->   130880
On node 0 totalpages: 130880
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 990 pages used for memmap
  Normal zone: 125794 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP 000F91A0, 0014 (r0 ACPIAM)
ACPI: RSDT 1FF40000, 0030 (r1 A M I  OEMRSDT   9000424 MSFT       97)
ACPI: FACP 1FF40200, 0081 (r2 A M I  OEMFACP   9000424 MSFT       97)
ACPI: DSDT 1FF40350, 373D (r1  A0008 A0008705      705 INTL  2002026)
ACPI: FACS 1FF50000, 0040
ACPI: APIC 1FF40300, 004A (r1 A M I  OEMAPIC   9000424 MSFT       97)
ACPI: OEMB 1FF50040, 003F (r1 A M I  OEMBIOS   9000424 MSFT       97)
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:df7c0000)
Built 1 zonelists.  Total pages: 129858
Kernel command line: root=3D/dev/sda1 ro devfs=3Dmount vga=3D0x313=20
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 1666.560 MHz processor.
Console: colour VGA+ 132x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 511900k/523520k available (2566k kernel code, 11044k reserved,
1040k data, 188k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xe0800000 - 0xfffb5000   ( 503 MB)
    lowmem  : 0xc0000000 - 0xdff40000   ( 511 MB)
      .init : 0xc0488000 - 0xc04b7000   ( 188 kB)
      .data : 0xc0381845 - 0xc0485c04   (1040 kB)
      .text : 0xc0100000 - 0xc0381845   (2566 kB)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 3336.73 BogoMIPS
(lpj=3D6673476)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000420 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Sempron(tm)  2400+ stepping 01
Checking 'hlt' instruction... OK.
ACPI: Core revision 20070126
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3D1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: enabled onboard AC97/MC97 devices
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
libata version 2.21 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a
report
ACPI: RTC can wake from S4
pnp: 00:08: iomem range 0xfec80000-0xfec800ff has been reserved
pnp: 00:08: iomem range 0xfec00000-0xfec00fff has been reserved
pnp: 00:08: iomem range 0xfee00000-0xfee00fff has been reserved
pnp: 00:08: iomem range 0xfff80000-0xffffffff could not be reserved
pnp: 00:09: ioport range 0x480-0x487 has been reserved
pnp: 00:09: ioport range 0xc00-0xc7f has been reserved
pnp: 00:0b: iomem range 0x0-0x9ffff could not be reserved
Time: tsc clocksource has been installed.
pnp: 00:0b: iomem range 0xc0000-0xdffff could not be reserved
pnp: 00:0b: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:0b: iomem range 0x100000-0x1fffffff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
Unpacking initramfs... done
Freeing initrd memory: 2474k freed
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: VIA PCI bridge detected. Disabling DAC.
PCI: Bypassing VIA 8237 APIC De-Assert Message
Boot video device is 0000:00:13.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin
is 60 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
00:0a: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
loop: module loaded
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
sata_via 0000:00:0f.0: version 2.2
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 16
sata_via 0000:00:0f.0: routed to hard irq line 11
scsi0 : sata_via
scsi1 : sata_via
ata1: SATA max UDMA/133 cmd 0x0001ef88 ctl 0x0001ef86 bmdma 0x0001eeb0
irq 16
ata2: SATA max UDMA/133 cmd 0x0001ef68 ctl 0x0001ef82 bmdma 0x0001eeb8
irq 16
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: WDC WD400JD-22MSA1, 10.01E01, max UDMA/133
ata1.00: 78165360 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-6: WDC WD2000JD-00HBB0, 08.02D08, max UDMA/133
ata2.00: 390721968 sectors, multi 16: LBA48=20
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD400JD-22MS 10.0 PQ: 0
ANSI: 5
sd 0:0:0:0: [sda] 78165360 512-byte hardware sectors (40021 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 78165360 512-byte hardware sectors (40021 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      WDC WD2000JD-00H 08.0 PQ: 0
ANSI: 5
sd 1:0:0:0: [sdb] 390721968 512-byte hardware sectors (200050 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:0:0: [sdb] 390721968 512-byte hardware sectors (200050 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 17
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 17, io mem 0xfea00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 17
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 17, io base 0x0000eec0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 17
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 17, io base 0x0000ef00
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 17
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 17, io base 0x0000ef20
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 17
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 17, io base 0x0000ef40
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one year, y3k
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int32x1    601 MB/s
raid6: int32x2    802 MB/s
raid6: int32x4    623 MB/s
raid6: int32x8    421 MB/s
raid6: mmxx1     1391 MB/s
raid6: mmxx2     2161 MB/s
raid6: sse1x1    1277 MB/s
raid6: sse1x2    2021 MB/s
raid6: using algorithm sse1x2 (2021 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  3847.000 MB/sec
raid5: using function: pIII_sse (3847.000 MB/sec)
md: multipath personality registered for level -4
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised:
dm-devel@redhat.com
TCP cubic registered
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
sit0: Disabled Privacy Extensions
NET: Registered protocol family 17
CCID: Registered CCID 3 (ccid3)
CCID: Registered CCID 2 (ccid2)
SCTP: Hash tables configured (established 16384 bind 32768)
Using IPI Shortcut mode
rtc_cmos 00:02: setting the system clock to 2007-07-31 19:57:54
(1185911874)
Freeing unused kernel memory: 188k freed
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 18 (level, low) -> IRQ 18
skge 1.11 addr 0xfe500000 irq 18 chip Yukon-Lite rev 9
skge eth0: addr 00:11:d8:5f:fe:30
via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 19
eth1: VIA Rhine II at 0xfe900000, 00:05:5d:01:96:2b, IRQ 19.
eth1: MII PHY found at address 8, status 0x782d advertising 01e1 Link
45e1.
NET: Registered protocol family 1
hpt37x: DPLL did not stabilize.
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: DPLL did not stabilize.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
parport_pc 00:06: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Adding 1959920k swap on /dev/scsi/host0/bus0/target0/lun0/part2.
Priority:-1 extents:1 across:1959920k
EXT3 FS on sda1, internal journal
md: md0 stopped.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
skge eth1: enabling interface
ADDRCONF(NETDEV_UP): eth1: link is not ready
ip_tables: (C) 2000-2006 Netfilter Core Team
nf_conntrack version 0.5.0 (4090 buckets, 32720 max)
ip6_tables: (C) 2000-2006 Netfilter Core Team
skge eth1: Link is up at 100 Mbps, full duplex, flow control both
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
eth0: no IPv6 routers present
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery
directory
NFSD: starting 90-second grace period




--=20
Bob Ham <rah@bash.sh>

--=-sLhxrAY2UxQBMQZvcHRa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGsKwt7whsMRnFexQRApGxAJ4uKWTaTBQ5uiL5gkrKlAIliqKOCACeLW9q
exMh1+mlWBsBIEqsZ3IpxC4=
=hv+V
-----END PGP SIGNATURE-----

--=-sLhxrAY2UxQBMQZvcHRa--

