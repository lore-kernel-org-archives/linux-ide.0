From: Yuri Kirsanov <flash@rccb.ru>
Subject: TX4000 RAID and sata_promise
Date: Thu, 23 Jun 2005 21:05:33 +0400
Message-ID: <653445328.20050623210533@rccb.ru>
Reply-To: Yuri Kirsanov <flash@rccb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.85.106.102] ([213.85.106.102]:40361 "EHLO rccb.ru")
	by vger.kernel.org with ESMTP id S932313AbVHRREz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Aug 2005 13:04:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Erik Slagter <erik@slagter.name>

Here's my dmesg with sata_promise compiled-in kernel:

Linux version 2.6.12.4-10flh (root@mandr) (gcc version 3.4.3 (Mandrakelinux 10.2 3.4.3-7mdk)) #3 SMP Tue Aug 16 21:34:11 MSD 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000beeb000 (usable)
 BIOS-e820: 000000000beeb000 - 000000000beef000 (ACPI data)
 BIOS-e820: 000000000beef000 - 000000000beff000 (reserved)
 BIOS-e820: 000000000beff000 - 000000000bf00000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
190MB LOWMEM available.
On node 0 totalpages: 48875
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 44779 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f70e0
ACPI: RSDT (v001 ASUS   CUSL2-M  0x30303031 MSFT 0x31313031) @ 0x0beeb000
ACPI: FADT (v001 ASUS   CUSL2-M  0x30303031 MSFT 0x31313031) @ 0x0beeb080
ACPI: BOOT (v001 ASUS   CUSL2-M  0x30303031 MSFT 0x31313031) @ 0x0beeb040
ACPI: DSDT (v001   ASUS CUSL2-M  0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Allocating PCI resources starting at 0bf00000 (gap: 0bf00000:f40f0000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 acpi=ht resume=/dev/hda5 ide2=0xd400,0xd002
ide_setup: ide2=0xd400,0xd002
 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (011bf000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 804.257 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 189304k/195500k available (1999k kernel code, 5640k reserved, 813k data, 248k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1593.34 BogoMIPS (lpj=796672)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 01
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span 01
  groups: 01
  domain 1: span 01
   groups: 01
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 189k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0d90, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd70
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbda0, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus fe [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:01:02.0 doesn't match PIRQ mask - try pci=usepirqmask
pnp: 00:12: ioport range 0x290-0x297 has been reserved
pnp: 00:12: ioport range 0x3f0-0x3f1 has been reserved
pnp: 00:12: ioport range 0xe400-0xe47f has been reserved
pnp: 00:12: ioport range 0xec00-0xec3f has been reserved
Simple Boot Flag at 0x3a set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
audit: initializing netlink socket (disabled)
audit(1124384084.409:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
PNP: PS/2 controller doesn't have AUX irq; using default 0xc
PNP: PS/2 Controller [PNP0303] at 0x60,0x64 irq 112
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: FUJITSU MPC3043AT, ATA DISK drive
hdb: ST320011A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 8448300 sectors (4325 MB), CHS=8940/15/63, UDMA(33)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 >
hdb: max request size: 128KiB
hdb: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
hdb: cache flushes not supported
 /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 >
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
swsusp: Suspend partition has wrong signature?
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
devfs_mk_dev: could not append to parent for md/0
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
input: AT Translated Set 2 keyboard on isa0060/serio0
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
Freeing unused kernel memory: 248k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 5 for device 0000:00:1f.2
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: Intel Corporation 82801BA/BAM USB (Hub #1)
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: irq 5, io base 0x0000a400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 9 for device 0000:00:1f.4
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: Intel Corporation 82801BA/BAM USB (Hub #2)
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1f.4: irq 9, io base 0x0000a000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Adding 1140572k swap on /dev/hda5.  Priority:-1 extents:1
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
loop: loaded (max 8 devices)
PCI: Enabling device 0000:01:02.0 (0014 -> 0017)
PCI: IRQ 0 for device 0000:01:02.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: setting IRQ 11 as level-triggered
PCI: Assigned IRQ 11 for device 0000:01:02.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:01:02.0: 3Com PCI 3c905C Tornado at 0xd800. Vers LK1.1.19
ip_conntrack version 2.1 (1527 buckets, 12216 max) - 252 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET: Registered protocol family 17
PCI: Found IRQ 11 for device 0000:01:02.0
PCI: Found IRQ 10 for device 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49516 usecs
intel8x0: clocking to 48000
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0387d80(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device caef1c00(sit0)
eth0: no IPv6 routers present



Modprobe says no such module, of course...
FATAL: Module sata_promise not found.

