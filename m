From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: 2.6.30-rc4 kernel
Date: Tue, 19 May 2009 07:57:06 +0200
Message-ID: <20090519055706.GA23611@liondog.tnic>
References: <20090518200558.D61FB567E@p4.dav.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:33355 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbZESF5M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 01:57:12 -0400
Received: by bwz22 with SMTP id 22so3605685bwz.37
        for <linux-ide@vger.kernel.org>; Mon, 18 May 2009 22:57:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090518200558.D61FB567E@p4.dav.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rob@housetosell.net
Cc: linux-ide@vger.kernel.org

(adding linux-ide to CC)

On Mon, May 18, 2009 at 09:05:58PM +0100, rob@housetosell.net wrote:
> On Wed, May 13, 2009 at 07:17:17PM +0100, rob1@housetosell.net wrote:
> 
> Hi
> 
> I am not sure how much use this will be however if a break point is set to cdrom_newpc_intr and go is continuosly pressed then the kernel will actually boot (it will also boot if there is no media in the cdrom's) however the cdrom cannot be mounted. The dmesg output and the syslog may provide some useful information:-
> 
> from dmesg
> 
> ide-cd: hdc: ide_cd_check_ireason: bad interrupt reason 0x03
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> 
> and from the syslog
> 
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: attempt to access beyond end of device
> May 18 19:30:37 jewel kernel: hdc: rw=0, want=68, limit=4
> May 18 19:30:37 jewel kernel: isofs_fill_super: bread failed, dev=hdc, iso_blknum=16, block=16
> 
> Full versions of dmesg and the syslog are below.
> 
> Hope this may be of some use.
> 
> Regards
> 
> Rob
> 
> linux@housetosell.net
> 
> 
> $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
> 
> ME# disabled
> pci 0000:01:00.0: reg 10 32bit mmio: [0xdf680000-0xdf6fffff]
> pci 0000:01:00.0: reg 14 32bit mmio: [0xd0000000-0xd7ffffff]
> pci 0000:01:00.0: reg 30 32bit mmio: [0xdf670000-0xdf67ffff]
> pci 0000:01:00.0: supports D1 D2
> pci 0000:00:01.0: bridge 32bit mmio: [0xdf500000-0xdf6fffff]
> pci 0000:00:01.0: bridge 32bit mmio pref: [0xcf300000-0xdf3fffff]
> pci 0000:00:11.0: VIA IRQ router [1106:3177]
> pci 0000:00:11.1: hardcoded PCI INT A -> IRQ 14
> NET: Registered protocol family 8
> NET: Registered protocol family 20
> pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
> pci 0000:00:01.0:   IO window: disabled
> pci 0000:00:01.0:   MEM window: 0xdf500000-0xdf6fffff
> pci 0000:00:01.0:   PREFETCH window: 0x000000cf300000-0x000000df3fffff
> pci 0000:00:01.0: setting latency timer to 64
> pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
> pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
> pci_bus 0000:01: resource 1 mem: [0xdf500000-0xdf6fffff]
> pci_bus 0000:01: resource 2 pref mem [0xcf300000-0xdf3fffff]
> NET: Registered protocol family 2
> IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
> TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> TCP reno registered
> NET: Registered protocol family 1
> platform rtc_cmos: registered platform RTC device (no PNP device found)
> audit: initializing netlink socket (disabled)
> type=2000 audit(1242673909.079:1): initialized
> VFS: Disk quotas dquot_6.5.2
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> squashfs: version 4.0 (2009/01/31) Phillip Lougher
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> NTFS driver 2.1.29 [Flags: R/W].
> msgmni has been set to 941
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> pci 0000:00:01.0: disabling DAC on VIA PCI bridge
> pci 0000:01:00.0: Boot video device
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> lp: driver loaded but no devices found
> Real Time Clock Driver v1.12b
> Linux agpgart interface v0.103
> agpgart: Detected VIA P4M266x/P4N266 chipset
> agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
> [drm] Initialized drm 1.1.0 20060810
> [drm] Initialized savage 2.4.1 20050313 for 0000:01:00.0 on minor 0
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> parport0: PC-style at 0x378 [PCSPP(,...)]
> lp0: using parport0 (polling).
> lp0: console ready
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> brd: module loaded
> loop: module loaded
> Uniform Multi-Platform E-IDE driver
> via82cxxx 0000:00:11.1: VIA vt8235 (rev 00) IDE UDMA133
> via82cxxx 0000:00:11.1: IDE controller (0x1106:0x0571 rev 0x06)
> VIA_IDE 0000:00:11.1: hardcoded PCI INT A -> IRQ 14
> VIA_IDE 0000:00:11.1: VIA VLink IRQ fixup, from 255 to 14
> via82cxxx 0000:00:11.1: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xfc00-0xfc07
>     ide1: BM-DMA at 0xfc08-0xfc0f
> Probing IDE interface ide0...
> hda: Maxtor 2F040L0, ATA DISK drive
> hdb: Maxtor 4D040H2, ATA DISK drive
> hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> hda: host side 80-wire cable detection failed, limiting max speed to UDMA33
> hda: UDMA/33 mode selected
> hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> hdb: host side 80-wire cable detection failed, limiting max speed to UDMA33
> hdb: UDMA/33 mode selected
> Probing IDE interface ide1...
> hdc: ATAPI DVD-ROM 16XMax, ATAPI CD/DVD-ROM drive
> hdd: SONY DVD RW AW-G170A, ATAPI CD/DVD-ROM drive
> hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> hdc: UDMA/33 mode selected
> hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> hdd: UDMA/66 mode selected
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide-gd driver 1.18
> hda: max request size: 128KiB
> hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63
> hda: cache flushes supported
>  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
> hdb: max request size: 128KiB
> hdb: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63
> hdb: cache flushes not supported
>  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
>  hdb2: <openbsd:bad subpartition - ignored
> bad subpartition - ignored
> bad subpartition - ignored
> bad subpartition - ignored
>  >
>  hdb3: <bsd: >
> ide-cd driver 5.00
> ide-cd: hdc: ide_cd_check_ireason: bad interrupt reason 0x03
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> ide-cd: hdc: ATAPI CD-ROM drive, 0kB Cache
> Uniform CD-ROM driver Revision: 3.20
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> ide-cd: hdc: weird block size 3749653184
> ide-cd: hdc: default to 2kb block size
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> ide-cd: hdd: ATAPI 48X DVD-ROM DVD-R/RAM CD-R/RW drive, 2048kB Cache
> Driver 'sd' needs updating - please use bus_type methods
> Driver 'sr' needs updating - please use bus_type methods
> ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
> PCI: setting IRQ 5 as level-triggered
> ne2k-pci 0000:00:0b.0: found PCI INT A -> IRQ 5
> ne2k-pci 0000:00:0b.0: sharing IRQ 5 with 0000:00:10.3
> eth0: RealTek RTL-8029 found at 0xec00, IRQ 5, 00:00:21:68:51:fa.
> via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
> PCI: setting IRQ 11 as level-triggered
> via-rhine 0000:00:12.0: found PCI INT A -> IRQ 11
> via-rhine 0000:00:12.0: sharing IRQ 11 with 0000:00:10.0
> eth1: VIA Rhine II at 0x1d800, 00:0a:e6:8d:60:20, IRQ 11.
> eth1: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci_hcd 0000:00:10.3: found PCI INT D -> IRQ 5
> ehci_hcd 0000:00:10.3: sharing IRQ 5 with 0000:00:0b.0
> ehci_hcd 0000:00:10.3: EHCI Host Controller
> ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:10.3: Enabling legacy PCI PM
> ehci_hcd 0000:00:10.3: irq 5, io mem 0xdfbfff00
> ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 6 ports detected
> uhci_hcd: USB Universal Host Controller Interface driver
> uhci_hcd 0000:00:10.0: found PCI INT A -> IRQ 11
> uhci_hcd 0000:00:10.0: sharing IRQ 11 with 0000:00:12.0
> uhci_hcd 0000:00:10.0: UHCI Host Controller
> uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:10.0: irq 11, io base 0x0000e000
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> PCI: setting IRQ 10 as level-triggered
> uhci_hcd 0000:00:10.1: found PCI INT B -> IRQ 10
> uhci_hcd 0000:00:10.1: sharing IRQ 10 with 0000:00:09.0
> uhci_hcd 0000:00:10.1: UHCI Host Controller
> uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:10.1: irq 10, io base 0x0000e400
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> uhci_hcd 0000:00:10.2: found PCI INT C -> IRQ 11
> uhci_hcd 0000:00:10.2: sharing IRQ 11 with 0000:00:11.5
> uhci_hcd 0000:00:10.2: UHCI Host Controller
> uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
> uhci_hcd 0000:00:10.2: irq 11, io base 0x0000e800
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new interface driver usbserial
> USB Serial support registered for generic
> usbcore: registered new interface driver usbserial_generic
> usbserial: USB Serial Driver core
> PNP: No PS/2 controller found. Probing ports directly.
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> mice: PS/2 mouse device common for all mice
> input: PC Speaker as /devices/platform/pcspkr/input/input0
> EISA: Probing bus 0 at eisa.0
> EISA: Detected 0 cards.
> No iBFT detected.
> Advanced Linux Sound Architecture Driver Version 1.0.19.
> VIA 82xx Audio 0000:00:11.5: found PCI INT C -> IRQ 11
> VIA 82xx Audio 0000:00:11.5: sharing IRQ 11 with 0000:00:10.2
> VIA 82xx Audio 0000:00:11.5: setting latency timer to 64
> input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
> Clocksource tsc unstable (delta = 523603809330 ns)
> ALSA device list:
>   #0: VIA 8235 with ALC101 at 0xdc00, irq 11
> Netfilter messages via NETLINK v0.30.
> nf_conntrack version 0.5.0 (7679 buckets, 30716 max)
> ip_tables: (C) 2000-2006 Netfilter Core Team
> arp_tables: (C) 2002 David S. Miller
> TCP bic registered
> NET: Registered protocol family 17
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> Using IPI Shortcut mode
> input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input2
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with writeback data mode.
> VFS: Mounted root (ext3 filesystem) readonly on device 3:7.
> Freeing unused kernel memory: 328k freed
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> EXT3 FS on hda7, internal journal
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda1, internal journal
> EXT3-fs: mounted filesystem with writeback data mode.
> eth1: link down
> svc: 127.0.0.1, port=41730: unknown version (3 for prog 100003, nfsd)
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda8, internal journal
> EXT3-fs: mounted filesystem with writeback data mode.
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hda: UDMA/33 mode selected
> hdb: UDMA/33 mode selected
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hdb5, internal journal
> EXT3-fs: mounted filesystem with writeback data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda6, internal journal
> EXT3-fs: mounted filesystem with writeback data mode.
> IN=eth0 OUT= MAC=01:00:5e:00:00:01:00:1b:2f:22:df:9a:08:00 SRC=192.168.0.1 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=263 DF PROTO=2 
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> ide-cd: hdc: weird block size 1413276124
> ide-cd: hdc: default to 2kb block size
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> IN=eth0 OUT= MAC=01:00:5e:00:00:01:00:1b:2f:22:df:9a:08:00 SRC=192.168.0.1 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=264 DF PROTO=2 
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> attempt to access beyond end of device
> hdc: rw=0, want=68, limit=4
> isofs_fill_super: bread failed, dev=hdc, iso_blknum=16, block=16
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> IN=eth0 OUT= MAC=01:00:5e:00:00:01:00:1b:2f:22:df:9a:08:00 SRC=192.168.0.1 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=265 DF PROTO=2 
> agpgart-via 0000:00:00.0: AGP 2.0 bridge
> agpgart-via 0000:00:00.0: putting AGP V2 device into 0x mode
> pci 0000:01:00.0: putting AGP V2 device into 0x mode
> 
> 
> $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
> syslog
> $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:37 jewel kernel: attempt to access beyond end of device
> May 18 19:30:37 jewel kernel: hdc: rw=0, want=68, limit=4
> May 18 19:30:37 jewel kernel: isofs_fill_super: bread failed, dev=hdc, iso_blknum=16, block=16
> May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> May 18 19:30:44 jewel kernel: IN=eth0 OUT= MAC=01:00:5e:00:00:01:00:1b:2f:22:df:9a:08:00 SRC=192.168.0.1 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=265 DF PROTO=2 
> May 18 19:31:05 jewel kernel: agpgart-via 0000:00:00.0: AGP 2.0 bridge
> May 18 19:31:05 jewel kernel: agpgart-via 0000:00:00.0: putting AGP V2 device into 0x mode
> May 18 19:31:05 jewel kernel: pci 0000:01:00.0: putting AGP V2 device into 0x mode
> May 18 19:32:49 jewel kernel: IN=eth0 OUT= MAC=01:00:5e:00:00:01:00:1b:2f:22:df:9a:08:00 SRC=192.168.0.1 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=266 DF PROTO=2 
> $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

-- 
Regards/Gruss,
    Boris.
