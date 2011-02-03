From: Alejandro Riveira =?UTF-8?B?RmVybsOhbmRleg==?=
	<ariveira@gmail.com>
Subject: Re: PATA_ARTOP doesn't detect connected disk on Landisk
Date: Thu, 3 Feb 2011 12:58:04 +0100
Message-ID: <20110203125804.463de1b2@varda>
References: <4D49FA15.40600@0x0f.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65414 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274Ab1BCL6K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2011 06:58:10 -0500
In-Reply-To: <4D49FA15.40600@0x0f.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Palmer <me@0x0f.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

El Thu, 03 Feb 2011 00:43:01 +0000
Daniel Palmer <me@0x0f.com> escribi=C3=B3:

> Hi,

 Hi CCing linux-ide

>=20
> Please CC me as I only subscribe to the digest.. LKML-proper would ki=
ll=20
> my mail server.
>=20
> I'm running 2.6.35 on an I-O Data Landisk machine. So far I can't get=
 a=20
> newer kernel to output anything to the serial console, the artop driv=
er=20
> hasn't changed from what I can tell . The model is a HDL-???U so it h=
as=20
> an PATA interface on the board for it's internal drive.  You can see=20
> photos of the same board here:=20
> http://su-u.jp/juju/%CA%AC%B2%F2%A4%B7%A4%C6%A4%DF%A4%E8%A4%A6/LANDIS=
K.html
>=20
> The original drive has died so I've replaced it with a CF adapter and=
=20
> 4GB card.
> Unfortunately the original drive was dead when I got the machine, so =
I=20
> haven't tested it with a standard drive.
>=20
> I'm not sure if this problem is Landisk-specific or even specific to =
my=20
> Landisk.
>=20
> When the machine boots SH IPL+g loads, detects the ARTOP (Its called=20
> A-Card here, they seem to be the same thing) controller and probes th=
e=20
> disk and sh-lilo loads:
>=20
> A-Card ATP865 ATA controller found.
> PCIC initialization done.
> MASTER:48bit LBA mode non support
> Disk drive detected: SanDisk SDCFH-004G HDX 5.04      ALZ012210190202
> LBA: 00778E30
> DiskSize: 4011614208Byte
> PIO MODE1
> Set Transfer Mode result: 50
> A-Card ATP865 ATA controller found.
>  > b
> Set Transfer Mode result: 50
> Initialize Device Parameters result: 50
> IDLE result: 50
> LILO boot:
>=20
>    1 : CF
>    2 : USB
>=20
>=20
> So I hit 1, which is my config for kernel from the CF and root is a=20
> partition on the CF card, the kernel loads and starts booting. I don'=
t=20
> think there's any initramfs support in sh-lilo so everything that is=20
> needed to get root mounted is compiled into the kernel. And this happ=
ens..
>=20
> push-switch: version 0.1.1 loaded
> TCP cubic registered
> NET: Registered protocol family 17
> rs5c313 rs5c313: setting system clock to 2011-02-03 02:58:27 UTC=20
> (1296701907)
> Waiting 20sec before mounting root device...
> ata1: link is slow to respond, please be patient (ready=3D0)
> ata1: SRST failed (errno=3D-16)
> ata1: link is slow to respond, please be patient (ready=3D0)
> ata1: SRST failed (errno=3D-16)
> ata1: link is slow to respond, please be patient (ready=3D0)
> ata1: SRST failed (errno=3D-16)
> ata1: SRST failed (errno=3D-16)
> ata1: reset failed, giving up
> VFS: Cannot open root device "sda3" or unknown-block(0,0)
> Please append a correct "root=3D" boot option; here are the available=
=20
> partitions:
> Kernel panic - not syncing: VFS: Unable to mount root fs on=20
> unknown-block(0,0)
> Stack: (0x8fc1df10 to 0x8fc1e000)
> df00:                                     8c26eaaa 8c26eb40 8c130fc0=20
> 8fc1df30
> df20: 8c31bd28 00008001 8c26eb40 8c33628c 8fc1df3c 00000000 8c30d814=20
> 6e6b6e75
>=20
> Something is happening that is stopping the CF card from getting prob=
ed.
> I've discovered though if I compile the Artop driver as a module, boo=
t=20
> with root on a USB drive, unload the module, pull the card out, push =
it=20
> back in and reload the driver the CF card is detected any the partiti=
ons=20
> are probed and I can mount the fs just fine.
>=20
> I've also discovered that if I pull the card just as the kernel start=
s=20
> booting and ram it back in really quickly the kernel will load up,=20
> detect the CF card and mount root. Timing has to be perfect though. I=
f I=20
> do it too late the kernel panics straight away.
>=20
> I'm guessing it's some sort of reset problem? I haven't ruled out tha=
t=20
> it could be some weirdness with my CF adapter. I don't have another t=
o=20
> test at the moment. I have tried OpenBSD/Landisk on the same machine=20
> with the same CF card and it boots no problems. Shame it's unusably s=
low.
>=20
> I'm going to mess around with the driver when I get some free time.=20
> Hopefully I can work out what is happening.
> I have appended my serial output from when the machine boots correctl=
y.
>=20
>=20
> Cheers,
>=20
> Daniel
>=20
>=20
>=20
>=20
>=20
> SH IPL+g version 0.9, Copyright (C) 2000 Free Software Foundation, In=
c.
>=20
> This software comes with ABSOLUTELY NO WARRANTY; for details type `w'=
=2E
> This is free software, and you are welcome to redistribute it under
> certain conditions; type `l' for details.
>=20
> 2002/09/09 Making.  2003/10/16 I-O DATA NSD NWG Update.
> 266:133:33 on base clock 22.22MHz and SDRAM 4 burst. ATA boot.
>=20
> A-Card ATP865 ATA controller found.
> PCIC initialization done.
> MASTER:48bit LBA mode non support
> Disk drive detected: SanDisk SDCFH-004G HDX 5.04      ALZ012210190202
> LBA: 00778E30
> DiskSize: 4011614208Byte
> PIO MODE1
> Set Transfer Mode result: 50
> A-Card ATP865 ATA controller found.
>  > b
> Set Transfer Mode result: 50
> Initialize Device Parameters result: 50
> IDLE result: 50
> LILO boot:
>=20
>    1 : CF
>    2 : USB
>=20
> Select boot image -> 1
> Loading CF...................................done.
> Setting GDB trap vector to 80000100
> Linux version 2.6.35.10 (daniel@kyoro) (gcc version 4.4.5 (Debian=20
> 4.4.5-10) ) #19 Tue Feb 1 10:49:40 GMT 2011
> Boot params:
> ... MOUNT_ROOT_RDONLY - 00000001
> ... RAMDISK_FLAGS     - 00000000
> ... ORIG_ROOT_DEV     - 00000301
> ... LOADER_TYPE       - 00000001
> ... INITRD_START      - 00000000
> ... INITRD_SIZE       - 00000000
> Memory limited to 64MB
> Booting machvec: LANDISK
> Node 0: start_pfn =3D 0xc000, low =3D 0x10000
> Zone PFN ranges:
>    Normal   0x0000c000 -> 0x00010000
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>      0: 0x0000c000 -> 0x00010000
> I-O DATA DEVICE, INC. "LANDISK Series" support.
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
16256
> Kernel command line: ro BOOT_FILE=3D/boot/zImage mem=3D64M=20
> console=3DttySC1,9600 root=3D/dev/sda3 rootdelay=3D20
> PID hash table entries: 256 (order: -2, 1024 bytes)
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> PVR=3D04050005 CVR=3D20480000 PRR=3D00000113
> I-cache : n_ways=3D2 n_sets=3D256 way_incr=3D8192
> I-cache : entry_mask=3D0x00001fe0 alias_mask=3D0x00001000 n_aliases=3D=
2
> D-cache : n_ways=3D2 n_sets=3D512 way_incr=3D16384
> D-cache : entry_mask=3D0x00003fe0 alias_mask=3D0x00003000 n_aliases=3D=
4
> Memory: 61596k/65536k available (2503k kernel code, 669k data, 108k i=
nit)
> virtual kernel memory layout:
>      fixmap  : 0xdfff7000 - 0xdffff000   (  32 kB)
>      vmalloc : 0xc0000000 - 0xdfff5000   ( 511 MB)
>      lowmem  : 0x8c000000 - 0x90000000   (  64 MB) (cached)
>              : 0xa0000000 - 0xc0000000   ( 512 MB) (uncached)
>        .init : 0x8c31b000 - 0x8c336000   ( 108 kB)
>        .data : 0x8c272db0 - 0x8c31a5a0   ( 669 kB)
>        .text : 0x8c001000 - 0x8c272db0   (2503 kB)
> Hierarchical RCU implementation.
>          RCU-based detection of stalled CPUs is disabled.
>          Verbose stalled-CPUs detection is disabled.
> NR_IRQS:256 nr_irqs:256
> intc: Registered controller 'sh7750' with 20 IRQs
> intc: Registered controller 'sh7750_dma8' with 9 IRQs
> intc: Registered controller 'sh7750_tmu34' with 2 IRQs
> intc: Registered controller 'sh7750_pci' with 8 IRQs
> intc: Registered controller 'landisk' with 8 IRQs
> Console: colour dummy device 80x25
>   sh_tmu.0: used for clock events
>   sh_tmu.0: used for periodic clock events
>   sh_tmu.1: used as clock source
> Calibrating delay loop (skipped)... 266.66 BogoMIPS PRESET (lpj=3D533=
333)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> CPU: SH7751R
> devtmpfs: initialized
> NET: Registered protocol family 16
> PCI: Starting intialization.
> bio: create slab <bio-0> at 0
> vgaarb: loaded
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> DMA: Registering sh_dmac handler (8 channels).
> DMA: Registering DMA API.
> pci 0000:00:01.0: BAR 6: assigned [mem 0xfd000000-0xfd00ffff pref]
> pci 0000:00:02.0: BAR 0: assigned [mem 0xfd010000-0xfd010fff]
> pci 0000:00:02.0: BAR 0: set to [mem 0xfd010000-0xfd010fff] (PCI addr=
ess=20
> [0xfd010000-0xfd010fff]
> pci 0000:00:02.1: BAR 0: assigned [mem 0xfd011000-0xfd011fff]
> pci 0000:00:02.1: BAR 0: set to [mem 0xfd011000-0xfd011fff] (PCI addr=
ess=20
> [0xfd011000-0xfd011fff]
> pci 0000:00:00.0: BAR 0: assigned [io  0x1000-0x10ff]
> pci 0000:00:00.0: BAR 0: set to [io  0x1000-0x10ff] (PCI address=20
> [0x1000-0x10ff]
> pci 0000:00:00.0: BAR 1: assigned [mem 0xfd012000-0xfd0120ff]
> pci 0000:00:00.0: BAR 1: set to [mem 0xfd012000-0xfd0120ff] (PCI addr=
ess=20
> [0xfd012000-0xfd0120ff]
> pci 0000:00:02.2: BAR 0: assigned [mem 0xfd012100-0xfd0121ff]
> pci 0000:00:02.2: BAR 0: set to [mem 0xfd012100-0xfd0121ff] (PCI addr=
ess=20
> [0xfd012100-0xfd0121ff]
> pci 0000:00:01.0: BAR 4: assigned [io  0x1400-0x140f]
> pci 0000:00:01.0: BAR 4: set to [io  0x1400-0x140f] (PCI address=20
> [0x1400-0x140f]
> pci 0000:00:01.0: BAR 0: assigned [io  0x1410-0x1417]
> pci 0000:00:01.0: BAR 0: set to [io  0x1410-0x1417] (PCI address=20
> [0x1410-0x1417]
> pci 0000:00:01.0: BAR 2: assigned [io  0x1418-0x141f]
> pci 0000:00:01.0: BAR 2: set to [io  0x1418-0x141f] (PCI address=20
> [0x1418-0x141f]
> pci 0000:00:01.0: BAR 1: assigned [io  0x1420-0x1423]
> pci 0000:00:01.0: BAR 1: set to [io  0x1420-0x1423] (PCI address=20
> [0x1420-0x1423]
> pci 0000:00:01.0: BAR 3: assigned [io  0x1424-0x1427]
> pci 0000:00:01.0: BAR 3: set to [io  0x1424-0x1427] (PCI address=20
> [0x1424-0x1427]
> Switching to clocksource sh_tmu.1
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 2048 (order: 2, 16384 bytes)
> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> TCP reno registered
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> gio: driver initialized
> msgmni has been set to 120
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> SuperH SCI(F) driver initialized
> sh-sci.0: ttySC0 at MMIO 0xffe00000 (irq =3D 23) is a sci
> sh-sci.1: ttySC1 at MMIO 0xffe80000 (irq =3D 40) is a scif
> console [ttySC1] enabled
> loop: module loaded
> scsi0 : pata_artop
> scsi1 : pata_artop
> ata1: PATA max UDMA/133 cmd 0x1410 ctl 0x1420 bmdma 0x1400 irq 6
> ata2: PATA max UDMA/133 cmd 0x1418 ctl 0x1424 bmdma 0x1408 irq 6
> scsi2 : pata_platform
> ata3: PATA max PIO0 ioport cmd 0xc0000040 ctl 0xc000002c irq 10
> 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
> PCI: Enabling device 0000:00:00.0 (0000 -> 0003)
> 8139cp 0000:00:00.0: eth0: RTL-8139C+ at 0xfd012000, 00:a0:b0:4c:cf:c=
6,=20
> IRQ 5
> PCI: Setting latency timer of device 0000:00:00.0 to 64
> usbmon: debugfs is not available
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> PCI: Enabling device 0000:00:02.2 (0000 -> 0002)
> ehci_hcd 0000:00:02.2: EHCI Host Controller
> ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:02.2: Enabling legacy PCI PM
> ehci_hcd 0000:00:02.2: irq 5, io mem 0xfd012100
> ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 5 ports detected
> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> PCI: Enabling device 0000:00:02.0 (0000 -> 0002)
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> ohci_hcd 0000:00:02.0: OHCI Host Controller
> ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
> ohci_hcd 0000:00:02.0: irq 7, io mem 0xfd010000
> ata1.00: CFA: SanDisk SDCFH-004G, HDX 5.04, max UDMA/66
> ata1.00: 7835184 sectors, multi 0: LBA
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> ata1.00: configured for UDMA/66
> scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDCFH-00 HDX  PQ: 0=20
> ANSI: 5
> sd 0:0:0:0: [sda] 7835184 512-byte logical blocks: (4.01 GB/3.73 GiB)
> PCI: Enabling device 0000:00:02.1 (0000 -> 0002)
> PCI: Setting latency timer of device 0000:00:02.1 to 64
> ohci_hcd 0000:00:02.1: OHCI Host Controller
> ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
> ohci_hcd 0000:00:02.1: irq 8, io mem 0xfd011000
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't=
=20
> support DPO or FUA
>   sda: sda1 sda2 sda3
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> mice: PS/2 mouse device common for all mice
> rs5c313 rs5c313: rtc core: registered rs5c313 as rtc0
> sh_tmu sh_tmu.0: kept as earlytimer
> sh_tmu sh_tmu.1: kept as earlytimer
> push-switch: version 0.1.1 loaded
> TCP cubic registered
> NET: Registered protocol family 17
> rs5c313 rs5c313: setting system clock to 2011-02-03 03:02:37 UTC=20
> (1296702157)
> Waiting 20sec before mounting root device...
> EXT3-fs: barriers not enabled
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs (sda3): mounted filesystem with writeback data mode
> VFS: Mounted root (ext3 filesystem) readonly on device 8:3.
> devtmpfs: mounted
> Freeing unused kernel memory: 108k freed
> INIT: version 2.88 booting
> Using makefile-style concurrent boot in runlevel S.
> Starting the hotplug events dispatcher: udevdudev[851]: starting vers=
ion=20
> 164
> .
> Synthesizing the initial hotplug events...done.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
