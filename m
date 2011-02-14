From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: 2.6.35.9 bug shown in dmesg (fwd)
Date: Mon, 14 Feb 2011 18:31:29 +0100
Message-ID: <20110214173129.GA2300@localhost.localdomain>
References: <alpine.LNX.2.00.1012301233380.3394@bigred.russwhit.org>
 <20110103230028.GA1456@localhost.localdomain>
 <alpine.LNX.2.00.1101052112010.1625@bigred.russwhit.org>
 <20110106161918.GA3008@r2bh72.net.upc.cz>
 <alpine.LNX.2.00.1101061034080.1611@bigred.russwhit.org>
 <20110107203209.GA1908@r2bh72.net.upc.cz>
 <alpine.LNX.2.00.1102131828400.1632@bigred.russwhit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx4.wp.pl ([212.77.101.8]:48100 "EHLO mx4.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755846Ab1BNRi7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Feb 2011 12:38:59 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1102131828400.1632@bigred.russwhit.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell Whitaker <russ@ashlandhome.net>
Cc: linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org

On Sun, Feb 13, 2011 at 06:50:02PM -0800, Russell Whitaker wrote:
> Ok, you are right. Somewhat started over and now got a saved "dmesg"
> with the newer kernel. Copy of dmesg attached.
> 
> Background info:
>   motherboard: Tyan Tiger MPX, 2 AMD cpu's
>   software: Slackware-current 2/14/2011, "A" series
>             Selected Huge-SMP kernel
> 

There are mtd and radeon oopses in dmesg. There is no indication
that could be caused by ATA. MTD is already fixed in linux-next,
regarding radeon CCing on dri-devel mailing list.

Stanislaw

> [    0.139723] pci 0000:03:08.0: reg 30: [mem 0x00000000-0x0001ffff pref]
> [    0.139745] pci 0000:03:08.0: supports D1 D2
> [    0.139749] pci 0000:03:08.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.139755] pci 0000:03:08.0: PME# disabled
> [    0.139793] pci 0000:00:10.0: PCI bridge to [bus 03-03]
> [    0.139867] pci 0000:00:10.0:   bridge window [io  0x3000-0x3fff]
> [    0.139873] pci 0000:00:10.0:   bridge window [mem 0xe8200000-0xe82fffff]
> [    0.139879] pci 0000:00:10.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
> [    0.139892] pci_bus 0000:00: on NUMA node 0
> [    0.139899] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> [    0.140058] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
> [    0.140136] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.OP2P._PRT]
> [    0.144214] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *5 10 11)
> [    0.145407] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 10 11) *0, disabled.
> [    0.145936] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 10 *11)
> [    0.146434] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 *10 11)
> [    0.146781] HEST: Table is not found!
> [    0.147132] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
> [    0.147136] vgaarb: loaded
> [    0.147379] SCSI subsystem initialized
> [    0.148118] libata version 3.00 loaded.
> [    0.148118] usbcore: registered new interface driver usbfs
> [    0.148139] usbcore: registered new interface driver hub
> [    0.149059] usbcore: registered new device driver usb
> [    0.166966] raid6: int32x1    707 MB/s
> [    0.184004] raid6: int32x2    628 MB/s
> [    0.201050] raid6: int32x4    511 MB/s
> [    0.218015] raid6: int32x8    496 MB/s
> [    0.234951] raid6: mmxx1     1320 MB/s
> [    0.251958] raid6: mmxx2     2156 MB/s
> [    0.269013] raid6: sse1x1     460 MB/s
> [    0.285969] raid6: sse1x2     917 MB/s
> [    0.286002] raid6: using algorithm sse1x2 (917 MB/s)
> [    0.286091] PCI: Using ACPI for IRQ routing
> [    0.286168] PCI: pci_cache_line_size set to 32 bytes
> [    0.286243] reserve RAM buffer: 000000000009f800 - 000000000009ffff 
> [    0.286250] reserve RAM buffer: 000000009fef0000 - 000000009fffffff 
> [    0.286255] reserve RAM buffer: 000000009ff80000 - 000000009fffffff 
> [    0.293067] pnp: PnP ACPI init
> [    0.293192] ACPI: bus type pnp registered
> [    0.299162] pnp: PnP ACPI: found 13 devices
> [    0.299162] ACPI: ACPI bus type pnp unregistered
> [    0.299185] system 00:00: [mem 0xfffc0000-0xffffffff] has been reserved
> [    0.299261] system 00:00: [mem 0xffc00000-0xfff7ffff] has been reserved
> [    0.299336] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
> [    0.299411] system 00:00: [mem 0x00100000-0x9fffffff] could not be reserved
> [    0.299485] system 00:00: [mem 0x000e0000-0x000fffff] could not be reserved
> [    0.299568] system 00:06: [io  0x04d0-0x04d1] has been reserved
> [    0.343429] Switching to clocksource acpi_pm
> [    0.343612] pci 0000:00:10.0: BAR 9: assigned [mem 0xa0000000-0xa00fffff pref]
> [    0.343721] pci 0000:01:05.0: BAR 6: assigned [mem 0xe8040000-0xe805ffff pref]
> [    0.343828] pci 0000:01:05.1: PCI bridge to [bus 02-02]
> [    0.343900] pci 0000:01:05.1:   bridge window [io  disabled]
> [    0.343978] pci 0000:01:05.1:   bridge window [mem 0xe8100000-0xe81fffff]
> [    0.343999] pci 0000:01:05.1:   bridge window [mem pref disabled]
> [    0.343999] pci 0000:00:01.0: PCI bridge to [bus 01-02]
> [    0.343999] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
> [    0.343999] pci 0000:00:01.0:   bridge window [mem 0xe8000000-0xe81fffff]
> [    0.343999] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf7ffffff pref]
> [    0.343999] pci 0000:03:08.0: BAR 6: assigned [mem 0xa0000000-0xa001ffff pref]
> [    0.344051] pci 0000:00:10.0: PCI bridge to [bus 03-03]
> [    0.344123] pci 0000:00:10.0:   bridge window [io  0x3000-0x3fff]
> [    0.344198] pci 0000:00:10.0:   bridge window [mem 0xe8200000-0xe82fffff]
> [    0.344286] pci 0000:00:10.0:   bridge window [mem 0xa0000000-0xa00fffff pref]
> [    0.344422] pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
> [    0.344426] pci_bus 0000:00: resource 1 [mem 0x00000000-0xffffffff]
> [    0.344431] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
> [    0.344435] pci_bus 0000:01: resource 1 [mem 0xe8000000-0xe81fffff]
> [    0.344439] pci_bus 0000:01: resource 2 [mem 0xf0000000-0xf7ffffff pref]
> [    0.344444] pci_bus 0000:02: resource 1 [mem 0xe8100000-0xe81fffff]
> [    0.344448] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
> [    0.344452] pci_bus 0000:03: resource 1 [mem 0xe8200000-0xe82fffff]
> [    0.344456] pci_bus 0000:03: resource 2 [mem 0xa0000000-0xa00fffff pref]
> [    0.344538] NET: Registered protocol family 2
> [    0.344696] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.345309] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
> [    0.348005] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
> [    0.349385] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.349464] TCP reno registered
> [    0.349540] UDP hash table entries: 512 (order: 2, 16384 bytes)
> [    0.349650] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> [    0.349962] NET: Registered protocol family 1
> [    0.350235] RPC: Registered udp transport module.
> [    0.350318] RPC: Registered tcp transport module.
> [    0.350388] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.350479] pci 0000:00:00.0: BIOS failed to enable PCI standards compliance; fixing this error
> [    0.350613] pci 0000:01:05.0: Boot video device
> [    0.350671] PCI: CLS 64 bytes, default 32
> [    0.353746] audit: initializing netlink socket (disabled)
> [    0.353850] type=2000 audit(1297557217.353:1): initialized
> [    0.354320] highmem bounce pool size: 64 pages
> [    0.361087] VFS: Disk quotas dquot_6.5.2
> [    0.361328] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> [    0.362055] DLM (built Feb  7 2011 23:48:44) installed
> [    0.364709] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [    0.365518] NTFS driver 2.1.29 [Flags: R/W].
> [    0.365880] ROMFS MTD (C) 2007 Red Hat, Inc.
> [    0.366491] JFS: nTxBlock = 8192, nTxLock = 65536
> [    0.376470] SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
> [    0.378105] SGI XFS Quota Management subsystem
> [    0.378185] OCFS2 1.5.0
> [    0.378740] ocfs2: Registered cluster interface o2cb
> [    0.379021] ocfs2: Registered cluster interface user
> [    0.379094] OCFS2 DLMFS 1.5.0
> [    0.379391] OCFS2 User DLM kernel interface loaded
> [    0.379464] OCFS2 Node Manager 1.5.0
> [    0.379841] OCFS2 DLM 1.5.0
> [    0.380557] Btrfs loaded
> [    0.381869] Slow work thread pool: Starting up
> [    0.382054] Slow work thread pool: Ready
> [    0.382138] GFS2 (built Feb  7 2011 23:49:10) installed
> [    0.382233] msgmni has been set to 1679
> [    0.382724] alg: No test for cipher_null (cipher_null-generic)
> [    0.382884] alg: No test for ecb(cipher_null) (ecb-cipher_null)
> [    0.383077] alg: No test for digest_null (digest_null-generic)
> [    0.383216] alg: No test for compress_null (compress_null-generic)
> [    0.385396] alg: No test for fcrypt (fcrypt-generic)
> [    0.389574] alg: No test for stdrng (krng)
> [    0.389668] async_tx: api initialized (async)
> [    0.390025] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
> [    0.390134] io scheduler noop registered
> [    0.390203] io scheduler deadline registered
> [    0.390360] io scheduler cfq registered (default)
> [    0.390976] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    0.391787] ERST: Table is not found!
> [    0.391871] isapnp: Scanning for PnP cards...
> [    0.748787] isapnp: No Plug & Play device found
> [    0.757359] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    1.002192] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> [    1.246191] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> [    1.247234] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> [    1.247674] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> [    1.248513] Floppy drive(s): fd0 is 1.44M
> [    1.262829] FDC 0 is a post-1991 82077
> [    1.268840] brd: module loaded
> [    1.271293] loop: module loaded
> [    1.271365] Compaq SMART2 Driver (v 2.6.0)
> [    1.271671] HP CISS Driver (v 3.6.20)
> [    1.273808] Loading iSCSI transport class v2.0-870.
> [    1.275357] fnic: Cisco FCoE HBA Driver, ver 1.4.0.145
> [    1.279698] Adaptec aacraid driver 1.1-5[26400]-ms
> [    1.280141] aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 loaded
> [    1.280789] scsi: <fdomain> Detection failed (no card)
> [    1.280883] sym53c416.c: Version 1.0.0-ac
> [    1.280978] qlogicfas: no cards were found, please specify I/O address and IRQ using iobase= and irq= options
> [    1.281192] QLogic Fibre Channel HBA Driver: 8.03.02-k2
> [    1.281586] iscsi: registered transport (qla4xxx)
> [    1.281763] QLogic iSCSI HBA Driver
> [    1.281832] Emulex LightPulse Fibre Channel SCSI driver 8.3.12
> [    1.281904] Copyright(c) 2004-2009 Emulex.  All rights reserved.
> [    1.282109] Brocade BFA FC/FCOE SCSI driver - version: 2.1.2.1
> [    1.304056] Failed initialization of WD-7000 SCSI card!
> [    1.355584] DC390: clustering now enabled by default. If you get problems load
> [    1.355690]        with "disable_clustering=1" and report to maintainers
> [    1.355997] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
> [    1.356318] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
> [    1.356498] megasas: 00.00.04.17.1-rc1 Thu. Oct. 29, 11:41:51 PST 2009
> [    1.356688] mpt2sas version 05.100.00.02 loaded
> [    1.357115] GDT-HA: Storage RAID Controller Driver. Version: 3.05
> [    1.357492] 3ware Storage Controller device driver for Linux v1.26.02.003.
> [    1.357665] 3ware 9000 Storage Controller device driver for Linux v2.26.02.014.
> [    1.357884] LSI 3ware SAS/SATA-RAID Controller device driver for Linux v3.26.02.000.
> [    1.358101] ipr: IBM Power RAID SCSI Device Driver version: 2.5.0 (February 11, 2010)
> [    1.358325] RocketRAID 3xxx/4xxx Controller driver v1.6 (090910)
> [    1.358500] stex: Promise SuperTrak EX Driver version: 4.6.0000.4
> [    1.359002] st: Version 20081215, fixed bufsize 32768, s/g segs 256
> [    1.361769] pata_amd 0000:00:07.1: version 0.4.1
> [    1.361889] pata_amd 0000:00:07.1: setting latency timer to 64
> [    1.362137] scsi2 : pata_amd
> [    1.362621] scsi3 : pata_amd
> [    1.362921] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
> [    1.362998] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
> [    1.368001] I2O subsystem v1.325
> [    1.368077] i2o: max drivers = 8
> [    1.368591] I2O Configuration OSM v1.323
> [    1.368753] I2O Bus Adapter OSM v1.317
> [    1.368917] I2O Block Device OSM v1.325
> [    1.369448] I2O SCSI Peripheral OSM v1.316
> [    1.369614] I2O ProcFS OSM v1.316
> [    1.369799] Fusion MPT base driver 3.04.15
> [    1.369869] Copyright (c) 1999-2008 LSI Corporation
> [    1.369946] Fusion MPT SPI Host driver 3.04.15
> [    1.370139] Fusion MPT FC Host driver 3.04.15
> [    1.370345] Fusion MPT SAS Host driver 3.04.15
> [    1.370534] Fusion MPT misc device (ioctl) driver 3.04.15
> [    1.370828] mptctl: Registered with Fusion MPT base driver
> [    1.370902] mptctl: /dev/mptctl @ (major,minor=10,220)
> [    1.370975] Fusion MPT LAN driver 3.04.15
> [    1.371345] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.371642] 116x: driver isp116x-hcd, 03 Nov 2005
> [    1.371809] driver isp1362-hcd, 2005-04-04
> [    1.371978] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    1.372105] ohci_hcd 0000:03:00.0: PCI INT D -> GSI 19 (level, low) -> IRQ 19
> [    1.372218] ohci_hcd 0000:03:00.0: OHCI Host Controller
> [    1.372499] ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
> [    1.372663] ohci_hcd 0000:03:00.0: irq 19, io mem 0xe8200000
> [    1.425088] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
> [    1.425164] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.425279] usb usb1: Product: OHCI Host Controller
> [    1.425349] usb usb1: Manufacturer: Linux 2.6.35.11-smp ohci_hcd
> [    1.425422] usb usb1: SerialNumber: 0000:03:00.0
> [    1.425844] hub 1-0:1.0: USB hub found
> [    1.425926] hub 1-0:1.0: 4 ports detected
> [    1.427119] uhci_hcd: USB Universal Host Controller Interface driver
> [    1.427546] sl811: driver sl811-hcd, 19 May 2005
> [    1.427720] r8a66597_hcd: driver r8a66597_hcd, 2009-05-26
> [    1.428211] Initializing USB Mass Storage driver...
> [    1.428417] usbcore: registered new interface driver usb-storage
> [    1.428490] USB Mass Storage support registered.
> [    1.428658] usbcore: registered new interface driver ums-alauda
> [    1.428829] usbcore: registered new interface driver ums-cypress
> [    1.429008] usbcore: registered new interface driver ums-datafab
> [    1.429182] usbcore: registered new interface driver ums-freecom
> [    1.429367] usbcore: registered new interface driver ums-isd200
> [    1.429538] usbcore: registered new interface driver ums-jumpshot
> [    1.429708] usbcore: registered new interface driver ums-karma
> [    1.429875] usbcore: registered new interface driver ums-onetouch
> [    1.430058] usbcore: registered new interface driver ums-sddr09
> [    1.430226] usbcore: registered new interface driver ums-sddr55
> [    1.430407] usbcore: registered new interface driver ums-usbat
> [    1.430741] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> [    1.433307] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    1.433387] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    1.434022] mice: PS/2 mouse device common for all mice
> [    1.434208] md: linear personality registered for level -1
> [    1.434294] md: raid0 personality registered for level 0
> [    1.434365] md: raid1 personality registered for level 1
> [    1.434437] md: raid10 personality registered for level 10
> [    1.434508] md: raid6 personality registered for level 6
> [    1.434579] md: raid5 personality registered for level 5
> [    1.434649] md: raid4 personality registered for level 4
> [    1.434720] md: multipath personality registered for level -4
> [    1.435236] device-mapper: uevent: version 1.0.3
> [    1.435689] device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@redhat.com
> [    1.436095] cpuidle: using governor ladder
> [    1.436166] cpuidle: using governor menu
> [    1.436374] TCP cubic registered
> [    1.436443] Initializing XFRM netlink socket
> [    1.436531] NET: Registered protocol family 17
> [    1.436664] Using IPI No-Shortcut mode
> [    1.455007] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> [    1.536507] ata1.00: ATA-6: ST340810A, 3.39, max UDMA/100
> [    1.536580] ata1.00: 78165360 sectors, multi 16: LBA 
> [    1.537136] ata1.01: ATA-6: ST3160023A, 8.01, max UDMA/100
> [    1.537209] ata1.01: 312581808 sectors, multi 16: LBA48 
> [    1.559418] ata1.00: configured for UDMA/100
> [    1.565425] ata1.01: configured for UDMA/100
> [    1.565821] scsi 2:0:0:0: Direct-Access     ATA      ST340810A        3.39 PQ: 0 ANSI: 5
> [    1.566676] sd 2:0:0:0: [sda] 78165360 512-byte logical blocks: (40.0 GB/37.2 GiB)
> [    1.566875] sd 2:0:0:0: [sda] Write Protect is off
> [    1.566948] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    1.566989] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.567691] scsi 2:0:1:0: Direct-Access     ATA      ST3160023A       8.01 PQ: 0 ANSI: 5
> [    1.568192]  sda: sda1 sda2 sda3
> [    1.602752] sd 2:0:1:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
> [    1.602834] sd 2:0:1:0: [sdb] Write Protect is off
> [    1.602840] sd 2:0:1:0: [sdb] Mode Sense: 00 3a 00 00
> [    1.602874] sd 2:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.603127]  sda4
> [    1.603766]  sdb: sdb1 sdb2
> [    1.621363] sd 2:0:0:0: [sda] Attached SCSI disk
> [    1.622065] sd 2:0:1:0: [sdb] Attached SCSI disk
> [    1.757277] ata2.00: ATAPI: LITE-ON DVDRW LH-20A1H, LL0C, max UDMA/66
> [    1.757389] ata2.01: ATAPI: MATSHITA CD-RW CW-7586, 1.08, max MWDMA2
> [    1.757490] ata2.00: limited to UDMA/33 due to 40-wire cable
> [    1.779199] ata2.00: configured for UDMA/33
> [    1.801291] ata2.01: configured for MWDMA2
> [    1.803830] scsi 3:0:0:0: CD-ROM            LITE-ON  DVDRW LH-20A1H   LL0C PQ: 0 ANSI: 5
> [    1.809492] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
> [    1.809605] Uniform CD-ROM driver Revision: 3.20
> [    1.810132] sr 3:0:0:0: Attached scsi CD-ROM sr0
> [    1.812240] scsi 3:0:1:0: CD-ROM            MATSHITA CD-RW  CW-7586   1.08 PQ: 0 ANSI: 5
> [    1.815522] sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
> [    1.815999] sr 3:0:1:0: Attached scsi CD-ROM sr1
> [    1.816404] registered taskstats version 1
> [    1.816914] md: Waiting for all devices to be available before autodetect
> [    1.816988] md: If you don't use raid, use raid=noautodetect
> [    1.817565] md: Autodetecting RAID arrays.
> [    1.817636] md: Scanned 0 and added 0 devices.
> [    1.817705] md: autorun ...
> [    1.817771] md: ... autorun DONE.
> [    1.844852] REISERFS (device sda4): found reiserfs format "3.6" with standard journal
> [    1.844981] REISERFS (device sda4): using ordered data mode
> [    1.857852] REISERFS (device sda4): journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [    1.860813] REISERFS (device sda4): checking transaction log (sda4)
> [    1.882303] REISERFS (device sda4): Using r5 hash to sort names
> [    1.882441] VFS: Mounted root (reiserfs filesystem) readonly on device 8:4.
> [    1.882564] devtmpfs: mounted
> [    1.882692] Freeing unused kernel memory: 604k freed
> [    1.884105] Write protecting the kernel text: 9844k
> [    1.884264] Write protecting the kernel read-only data: 2516k
> [    3.595785] udev[1085]: starting version 165
> [    4.081211] sd 2:0:0:0: Attached scsi generic sg0 type 0
> [    4.081404] sd 2:0:1:0: Attached scsi generic sg1 type 0
> [    4.081534] sr 3:0:0:0: Attached scsi generic sg2 type 5
> [    4.081658] sr 3:0:1:0: Attached scsi generic sg3 type 5
> [    4.167844] shpchp 0000:00:01.0: HPC vendor_id 1022 device_id 700d ss_vid 0 ss_did 0
> [    4.167966] shpchp 0000:00:01.0: Cannot reserve MMIO region
> [    4.168061] shpchp 0000:00:10.0: HPC vendor_id 1022 device_id 7448 ss_vid 0 ss_did 0
> [    4.168166] shpchp 0000:00:10.0: Cannot reserve MMIO region
> [    4.168475] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    4.755831] 3c59x 0000:03:08.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
> [    4.755955] 3c59x: Donald Becker and others.
> [    4.756039] 0000:03:08.0: 3Com PCI 3c905C Tornado at f869e400.
> [    5.049204] AMD768 RNG detected
> [    5.222363] cfg80211: Calling CRDA to update world regulatory domain
> [    5.602235] Linux agpgart interface v0.103
> [    5.723667] "amd76xrom" amd76xrom_init_one(): Unable to register resource 0x00000000ffc00000-0x00000000ffffffff - kernel bug?
> [    5.747579] agpgart-amdk7 0000:00:00.0: AMD 760MP chipset
> [    5.767140] agpgart-amdk7 0000:00:00.0: AGP aperture is 64M @ 0xec000000
> [    6.015708] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
> [    6.016246] ACPI: Power Button [PWRB]
> [    6.016541] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> [    6.016781] ACPI: Power Button [PWRF]
> [    6.016985] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input3
> [    6.017184] ACPI: Sleep Button [SLPF]
> [    6.352765] ACPI: acpi_idle registered with cpuidle
> [    6.477116] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
> [    6.477249] rtc0: alarms up to one month, y3k, 242 bytes nvram
> [    6.653728] CA0106 0000:03:04.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> [    6.653882] snd-ca0106: Model 1006 Rev 00000000 Serial 10061102
> [    6.832982] [drm] Initialized drm 1.1.0 20060810
> [    7.717906] BUG: unable to handle kernel paging request at f8c8aaa0
> [    7.718009] IP: [<c14d38cf>] memcpy+0x1f/0x40
> [    7.718009] *pde = 36b3f067 *pte = 00000000 
> [    7.718009] Oops: 0002 [#1] SMP 
> [    7.718009] last sysfs file: /sys/devices/pci0000:00/0000:00:07.1/host2/target2:0:0/2:0:0:0/block/sda/removable
> [    7.718009] Modules linked in: jedec_probe parport drm snd_ca0106 mac80211 snd_rawmidi snd_seq_device rtc_cmos rtc_core eeprom_93cx6 processor cfi_probe thermal container gen_probe thermal_sys cfi_util rtc_lib button snd_ac97_codec ac97_bus snd_pcm snd_timer amd_k7_agp amd76xrom(+) hwmon agpgart mtd snd soundcore cfg80211 i2c_algo_bit i2c_amd756 amd_rng rfkill snd_page_alloc i2c_core chipreg 3c59x map_funcs mii evdev psmouse shpchp sg serio_raw
> [    7.718009] 
> [    7.718009] Pid: 1124, comm: modprobe Not tainted 2.6.35.11-smp #2 S2466 TIGER MPX/Unknown
> [    7.718009] EIP: 0060:[<c14d38cf>] EFLAGS: 00010212 CPU: 0
> [    7.718009] EIP is at memcpy+0x1f/0x40
> [    7.718009] EAX: f8c8aaa0 EBX: 00000020 ECX: 00000008 EDX: f6aaba48
> [    7.718009] ESI: f6aaba48 EDI: f8c8aaa0 EBP: f6aaba40 ESP: f6aaba34
> [    7.718009]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [    7.718009] Process modprobe (pid: 1124, ti=f6aaa000 task=f6aa0cf0 task.ti=f6aaa000)
> [    7.718009] Stack:
> [    7.718009]  000000aa 000aaaa0 f8be0000 f6aaba74 f867f0f3 000000aa 000000aa 000000aa
> [    7.718009] <0> 000000aa 000000aa 000000aa 000000aa 000000aa 00000008 f6aabb84 f6aaba9c
> [    7.718009] <0> f6aabd90 f86a2aec 000000aa 000000aa 000000aa 000000aa 000000aa 000000aa
> [    7.718009] Call Trace:
> [    7.718009]  [<f867f0f3>] ? simple_map_write+0x83/0xa0 [map_funcs]
> [    7.718009]  [<f86a2aec>] ? cfi_qry_mode_on+0xc7c/0x1130 [cfi_util]
> [    7.718009]  [<f8d67eac>] ? jedec_probe_chip+0x71c/0x13a8 [jedec_probe]
> [    7.718009]  [<f87061f6>] ? cfi_probe_chip+0x46/0x494 [cfi_probe]
> [    7.718009]  [<f86ce1b2>] ? mtd_do_chip_probe+0xb2/0x398 [gen_probe]
> [    7.718009]  [<c10254d0>] ? do_page_fault+0x0/0x370
> [    7.718009]  [<f8706012>] ? cfi_probe+0x12/0x20 [cfi_probe]
> [    7.718009]  [<f8697199>] ? do_map_probe+0x29/0x7b [chipreg]
> [    7.718009]  [<f881a261>] ? init_amd76xrom+0x261/0x419 [amd76xrom]
> [    7.718009]  [<c1001242>] ? do_one_initcall+0x32/0x190
> [    7.718009]  [<f881a000>] ? init_amd76xrom+0x0/0x419 [amd76xrom]
> [    7.718009]  [<c1074ba3>] ? sys_init_module+0x93/0x1d0
> [    7.718009]  [<c10f20c2>] ? sys_write+0x42/0x70
> [    7.718009]  [<c199ac6c>] ? syscall_call+0x7/0xb
> [    7.718009] Code: 8d 74 26 00 e8 63 fd ff ff eb e8 90 55 89 e5 83 ec 0c 89 1c 24 89 74 24 04 89 7c 24 08 0f 1f 44 00 00 89 cb 89 c7 c1 e9 02 89 d6 <f3> a5 89 d9 83 e1 03 74 02 f3 a4 8b 1c 24 8b 74 24 04 8b 7c 24 
> [    7.718009] EIP: [<c14d38cf>] memcpy+0x1f/0x40 SS:ESP 0068:f6aaba34
> [    7.718009] CR2: 00000000f8c8aaa0
> [    7.718009] ---[ end trace 7d61458dad6b2dfe ]---
> [    7.744480] parport_pc 00:0b: reported by Plug and Play ACPI
> [    7.744688] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
> [    7.816274] ppdev: user-space parallel port driver
> [    7.858206] rtl8180 0000:03:06.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [    8.033163] [drm] radeon defaulting to kernel modesetting.
> [    8.033250] [drm] radeon kernel modesetting enabled.
> [    8.033478] radeon 0000:01:05.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [    8.040981] [drm] initializing kernel modesetting (R200 0x1002:0x4242).
> [    8.041329] [drm] register mmio base: 0xE8020000
> [    8.041401] [drm] register mmio size: 131072
> [    8.041836] agpgart-amdk7 0000:00:00.0: AGP 2.0 bridge
> [    8.041928] agpgart-amdk7 0000:00:00.0: putting AGP V2 device into 4x mode
> [    8.042043] radeon 0000:01:05.0: putting AGP V2 device into 4x mode
> [    8.042150] radeon 0000:01:05.0: GTT: 64M 0xEC000000 - 0xEFFFFFFF
> [    8.042228] [drm] Generation 1 PCI interface in multifunction mode
> [    8.042301] [drm] Limiting VRAM to one aperture
> [    8.042376] radeon 0000:01:05.0: VRAM: 128M 0xF0000000 - 0xF7FFFFFF (64M used)
> [    8.042546] [drm] radeon: irq initialized.
> [    8.048780] [drm] Detected VRAM RAM=128M, BAR=128M
> [    8.048868] [drm] RAM width 128bits DDR
> [    8.049191] [TTM] Zone  kernel: Available graphics memory: 430268 kiB.
> [    8.049268] [TTM] Zone highmem: Available graphics memory: 1286048 kiB.
> [    8.049342] [TTM] Initializing pool allocator.
> [    8.049464] [drm] radeon: 64M of VRAM memory ready
> [    8.049536] [drm] radeon: 64M of GTT memory ready.
> [    8.050824] [drm] Loading R200 Microcode
> [    8.054340] phy0: Selected rate control algorithm 'minstrel'
> [    8.054727] phy0: hwaddr 08:10:74:a6:8b:ad, RTL8185vD + rtl8225z2
> [    8.092368] [TTM] AGP Bind memory failed.
> [    8.092457] [TTM] Couldn't bind backend.
> [    8.092561] radeon 0000:01:05.0: object_init failed for (1048576, 0x00000002)
> [    8.092638] radeon 0000:01:05.0: (-22) ring create failed
> [    8.092711] radeon 0000:01:05.0: failled initializing CP (-22).
> [    8.092784] radeon 0000:01:05.0: Disabling GPU acceleration
> [    8.092860] [drm] radeon: cp finalized
> [    8.092960] [drm] radeon: cp finalized
> [    8.093109] [TTM] Finalizing pool allocator.
> [    8.094065] [TTM] Zone  kernel: Used memory at exit: 0 kiB.
> [    8.094141] [TTM] Zone highmem: Used memory at exit: 0 kiB.
> [    8.094214] [drm] radeon: ttm finalized
> [    8.094290] [drm] Forcing AGP to PCI mode
> [    8.094722] [drm] Generation 1 PCI interface in multifunction mode
> [    8.094796] [drm] Limiting VRAM to one aperture
> [    8.094871] radeon 0000:01:05.0: VRAM: 128M 0xF0000000 - 0xF7FFFFFF (64M used)
> [    8.094976] radeon 0000:01:05.0: GTT: 512M 0xD0000000 - 0xEFFFFFFF
> [    8.095103] [drm] radeon: irq initialized.
> [    8.095183] [drm] Detected VRAM RAM=128M, BAR=128M
> [    8.095254] [drm] RAM width 128bits DDR
> [    8.095479] [TTM] Zone  kernel: Available graphics memory: 430268 kiB.
> [    8.095554] [TTM] Zone highmem: Available graphics memory: 1286048 kiB.
> [    8.095628] [TTM] Initializing pool allocator.
> [    8.095742] [drm] radeon: 64M of VRAM memory ready
> [    8.095814] [drm] radeon: 512M of GTT memory ready.
> [    8.095897] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [    8.104896] [drm] radeon: ring at 0x00000000D0000000
> [    8.105038] [drm] ring test succeeded in 7 usecs
> [    8.105283] [drm] radeon: ib pool ready.
> [    8.105546] [drm] ib test succeeded in 0 usecs
> [    8.105705] [drm] DFP table revision: 3
> [    8.106512] [drm] Radeon Display Connectors
> [    8.106590] [drm] Connector 0:
> [    8.106658] [drm]   DVI-I
> [    8.106725] [drm]   HPD1
> [    8.106793] [drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
> [    8.106864] [drm]   Encoders:
> [    8.106933] [drm]     CRT1: INTERNAL_DAC1
> [    8.107020] [drm]     DFP1: INTERNAL_TMDS1
> [    8.238330] [drm] fb mappable at 0xF0040000
> [    8.238402] [drm] vram apper at 0xF0000000
> [    8.238471] [drm] size 5242880
> [    8.238538] [drm] fb depth is 24
> [    8.238605] [drm]    pitch is 5120
> [    8.311302] Console: switching to colour frame buffer device 160x64
> [    8.331774] fb0: radeondrmfb frame buffer device
> [    8.331885] drm: registered panic notifier
> [    8.331998] [drm] Initialized radeon 2.5.0 20080528 for 0000:01:05.0 on minor 0
> [    8.338722] [drm] initializing kernel modesetting (R200 0x1002:0x4243).
> [    8.339111] radeon 0000:01:05.1: Fatal error during GPU init
> [    8.339251] [drm] radeon: finishing device.
> [    8.339355] [TTM] Memory type 2 has not been initialized.
> [    8.339519] BUG: unable to handle kernel NULL pointer dereference at (null)
> [    8.339701] IP: [<f905f797>] r100_cp_fini+0x57/0xb0 [radeon]
> [    8.339970] *pde = 00000000 
> [    8.340049] Oops: 0002 [#2] SMP 
> [    8.340083] last sysfs file: /sys/devices/virtual/vtconsole/vtcon1/uevent
> [    8.340083] Modules linked in: radeon(+) ttm rtl8180 ppdev drm_kms_helper parport_pc jedec_probe parport drm snd_ca0106 mac80211 snd_rawmidi snd_seq_device rtc_cmos rtc_core eeprom_93cx6 processor cfi_probe thermal container gen_probe thermal_sys cfi_util rtc_lib button snd_ac97_codec ac97_bus snd_pcm snd_timer amd_k7_agp amd76xrom(+) hwmon agpgart mtd snd soundcore cfg80211 i2c_algo_bit i2c_amd756 amd_rng rfkill snd_page_alloc i2c_core chipreg 3c59x map_funcs mii evdev psmouse shpchp sg serio_raw
> [    8.340083] 
> [    8.340083] Pid: 1187, comm: modprobe Tainted: G      D     2.6.35.11-smp #2 S2466 TIGER MPX/Unknown
> [    8.340083] EIP: 0060:[<f905f797>] EFLAGS: 00010287 CPU: 0
> [    8.340083] EIP is at r100_cp_fini+0x57/0xb0 [radeon]
> [    8.340083] EAX: 00000000 EBX: f709e000 ECX: ffff8000 EDX: f90c9120
> [    8.340083] ESI: 00000000 EDI: 00000e40 EBP: f6a0dda0 ESP: f6a0dd8c
> [    8.340083]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [    8.340083] Process modprobe (pid: 1187, ti=f6a0c000 task=f6b8ab20 task.ti=f6a0c000)
> [    8.340083] Stack:
> [    8.340083]  f8e1821c f6a0dda0 f709e000 f663f000 00800005 f6a0ddac f9065760 f709e000
> [    8.340083] <0> f6a0ddbc f902e293 f90b84bc f709e000 f6a0ddcc f902f3dc f663f000 f7125260
> [    8.340083] <0> f6a0ddfc f902f517 f90b86dc f90c0c70 f7125260 fffffff4 0000003f 00000001
> [    8.340083] Call Trace:
> [    8.340083]  [<f9065760>] ? r100_fini+0x10/0x70 [radeon]
> [    8.340083]  [<f902e293>] ? radeon_device_fini+0x33/0x80 [radeon]
> [    8.340083]  [<f902f3dc>] ? radeon_driver_unload_kms+0x2c/0x50 [radeon]
> [    8.340083]  [<f902f517>] ? radeon_driver_load_kms+0x117/0x1b0 [radeon]
> [    8.340083]  [<f8d1f82c>] ? drm_get_dev+0x2ac/0x490 [drm]
> [    8.340083]  [<f90a99f2>] ? radeon_pci_probe+0x12/0x14 [radeon]
> [    8.340083]  [<c14e974e>] ? pci_device_probe+0x5e/0x80
> [    8.340083]  [<c1561fdf>] ? driver_probe_device+0x7f/0x190
> [    8.340083]  [<c14e914b>] ? pci_match_device+0xab/0xc0
> [    8.340083]  [<c1562171>] ? __driver_attach+0x81/0x90
> [    8.340083]  [<c1561199>] ? bus_for_each_dev+0x49/0x70
> [    8.340083]  [<c1561d0e>] ? driver_attach+0x1e/0x20
> [    8.340083]  [<c15620f0>] ? __driver_attach+0x0/0x90
> [    8.340083]  [<c15618c2>] ? bus_add_driver+0xc2/0x2c0
> [    8.340083]  [<c14e9690>] ? pci_device_remove+0x0/0x40
> [    8.340083]  [<c15623a6>] ? driver_register+0x66/0x110
> [    8.340083]  [<c14e9975>] ? __pci_register_driver+0x45/0xb0
> [    8.340083]  [<f8d1a7c1>] ? drm_init+0xf1/0x100 [drm]
> [    8.340083]  [<f91a10b7>] ? radeon_init+0xb7/0xb9 [radeon]
> [    8.340083]  [<c1001242>] ? do_one_initcall+0x32/0x190
> [    8.340083]  [<f91a1000>] ? radeon_init+0x0/0xb9 [radeon]
> [    8.340083]  [<c1074ba3>] ? sys_init_module+0x93/0x1d0
> [    8.340083]  [<c10f20c2>] ? sys_write+0x42/0x70
> [    8.340083]  [<c199ac6c>] ? syscall_call+0x7/0xb
> [    8.340083] Code: a9 00 00 01 00 74 36 b8 c7 10 00 00 83 c6 01 e8 a0 37 47 c8 3b 73 6c 73 4b 81 bb 90 00 00 00 40 0e 00 00 77 cf 8b 83 94 00 00 00 <89> 38 8b 83 94 00 00 00 8b 40 04 a9 00 00 01 00 75 ca 89 d8 e8 
> [    8.340083] EIP: [<f905f797>] r100_cp_fini+0x57/0xb0 [radeon] SS:ESP 0068:f6a0dd8c
> [    8.340083] CR2: 0000000000000000
> [    8.457876] ---[ end trace 7d61458dad6b2dff ]---
> [  125.620673] lp0: using parport0 (interrupt-driven).
> [  125.628435] lp0: console ready
> [  427.840486] REISERFS (device sdb2): found reiserfs format "3.6" with standard journal
> [  427.840535] REISERFS (device sdb2): using ordered data mode
> [  427.850348] REISERFS (device sdb2): journal params: device sdb2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [  427.853365] REISERFS (device sdb2): checking transaction log (sdb2)
> [  427.902591] REISERFS (device sdb2): Using r5 hash to sort names

