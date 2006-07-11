From: Ellis <linux@paranor.org.uk>
Subject: Problem with SiI 3112 SATA Controller/Driver ?
Date: Tue, 11 Jul 2006 22:46:13 +0100
Message-ID: <44B41C25.6030209@paranor.org.uk>
Reply-To: linux@paranor.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hermes.hosts.co.uk ([212.84.175.24]:19100 "EHLO
	hermes.hosts.co.uk") by vger.kernel.org with ESMTP id S1751331AbWGKVmc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jul 2006 17:42:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff

I'm afraid that I'm going to bother you with my woes ...

I have a SATA controller that is giving me problems and I'm looking for 
some advice. I am including quite a bit of information in the hope that 
it will help.

Here goes (linux data in lower part of message):

Linux System:	Slackware 10.2
Motherboard:	ABIT ST6-RAID (P3 class) with newest BIOS available
SATA Card:	EIO DM-8301H (non-raid) SiI 3112 chipset
   - info @ http://www.ivmm.com/eio/products/sata_pci_host.htm
     - Note line 2 of description - "Works with 'various' brands of large
       capacity ... "
   - Win drvrs @ http://www.ivmm.com/eio/support/download.htm#DM8301H
   - BIOS Rev. is 4.1.34 on the card dated 2002?
HDD:		Seagate ST3120827AS - 120 GB


While booting the machine, the BIOS on the card reports finding the HDD 
with a capacity of 114473 MB.


The HDD is visible in Linux as /dev/sda, and has one partition only.

Output from lspci ...

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and 
Memory Controller Hub (rev 04)
00:01.0 PCI bridge: Intel Corporation 82815 815 Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 11)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (LPC) (rev 11)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 11)
00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #1) (rev 11)
00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 11)
00:1f.4 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #2) (rev 11)
00:1f.5 Multimedia audio controller: Intel Corporation 82801BA/BAM AC'97 
Audio (rev 11)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD 
[Radeon 7200]
02:01.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
02:03.0 Mass storage controller: Silicon Image, Inc. SiI 3112 
[SATALink/SATARaid] Serial ATA Controller (rev 02)
02:06.0 Mass storage controller: Triones Technologies, Inc. 
HPT366/368/370/370A/372/372N (rev 04)


Attempting to format the HDD results in the tty being locked-up in linux

Screen capture ...

root@slaktux:/# mkfs.ext3 -v /dev/sda1
mke2fs 1.38 (30-Jun-2005)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
14663680 inodes, 29304560 blocks
1465228 blocks (5.00%) reserved for the super user
First data block=0
895 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group
Superblock backups stored on blocks:
         32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 
2654208,
         4096000, 7962624, 11239424, 20480000, 23887872

Writing inode tables: 104/895


****	No progress beyond this point ... terminal frozen.


Processes running ...

   PID TTY      STAT   TIME COMMAND
     1 ?        S      0:01 init [3]
     2 ?        SN     0:00 [ksoftirqd/0]
     3 ?        S<     0:00 [events/0]
     4 ?        S<     0:00 [khelper]
     5 ?        S<     0:00 [kthread]
     7 ?        S<     0:00 [kblockd/0]
    10 ?        S<     0:00 [khubd]
    41 ?        S      0:00 [kapmd]
    89 ?        D      0:00 [pdflush]
    90 ?        D      0:00 [pdflush]
    92 ?        S<     0:00 [aio/0]
    91 ?        S      0:01 [kswapd0]
   683 ?        S<     0:00 [kseriod]
   736 ?        S<     0:00 [ata/0]
   738 ?        S      0:00 [scsi_eh_0]
   739 ?        S      0:00 [scsi_eh_1]
   783 ?        S      0:00 [md0_raid1]
   784 ?        S      0:00 [kjournald]
   835 ?        S<s    0:00 udevd
  1018 ?        S      0:00 [kjournald]
  1019 ?        S      0:00 [kjournald]
  1209 ?        Ds     0:00 /usr/sbin/syslogd
  1212 ?        Ss     0:00 /usr/sbin/klogd -c 3 -x
  1236 ?        Ss     0:00 /sbin/dhcpcd -d -t 60 eth0
  1727 ?        Ss     0:00 /sbin/rpc.portmap
  1733 ?        Ss     0:00 /usr/sbin/inetd
  1738 ?        Ss     0:00 /usr/sbin/sshd
  1754 ?        Ss     0:00 /usr/sbin/cupsd
  1879 ?        S      0:00 /usr/sbin/crond -l10
  1881 ?        Ss     0:00 /usr/sbin/atd -b 15 -l 1
  1884 ?        Ss     0:00 sendmail: accepting connections
  1887 ?        Ss     0:00 sendmail: Queue runner@00:25:00 for 
/var/spool/clientmqueue
  1890 ?        Ss     0:00 /usr/sbin/apmd
  1900 ?        Ss     0:00 /usr/sbin/smbd -D
  1902 ?        Ss     0:00 /usr/sbin/nmbd -D
  1904 ?        S      0:00 /usr/sbin/smbd -D
  1905 ?        Ss     0:00 /usr/sbin/gpm -m /dev/mouse -t ps2
  1908 ?        Ss     0:00 /opt/kde/bin/lisa
  1909 tty1     Ss     0:00 -bash
  1910 tty2     Ss     0:00 -bash
  1911 tty3     Ss+    0:00 /sbin/agetty 38400 tty3 linux
  1912 tty4     Ss+    0:00 /sbin/agetty 38400 tty4 linux
  1913 tty5     Ss+    0:00 /sbin/agetty 38400 tty5 linux
  1914 tty6     Ss+    0:00 /sbin/agetty 38400 tty6 linux
  2090 tty1     D+     0:01 mkfs.ext3 /dev/sda1
  2108 tty2     R+     0:00 ps ax

I am unable to 'kill' 2090, and attempting a reboot causes all other 
ttys' to hang as well as the machine, so the only action left is the 
reset button.


Output from DMESG ...

Linux version 2.6.17.4 (root@slaktux) (gcc version 3.3.6) #1 Tue Jul 11 
20:23:11 BST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
   DMA zone: 4096 pages, LIFO batch:0
   Normal zone: 126960 pages, LIFO batch:31
DMI 2.2 present.
Allocating PCI resources starting at 30000000 (gap: 20000000:dfb00000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=linux-2.6.17.4 ro root=302
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01402000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 1209.548 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 514608k/524224k available (3044k kernel code, 9068k reserved, 
1071k data, 208k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2421.83 BogoMIPS 
(lpj=4843671)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III CPU             1200MHz stepping 01
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=2
Setting up standard PCI resources
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 4000-407f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 4080-40bf claimed by ICH4 GPIO
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
PCI: Found IRQ 9 for device 0000:00:1f.3
PCI: Sharing IRQ 9 with 0000:00:1f.5
PCI: Sharing IRQ 9 with 0000:02:01.0
PCI: Bridge: 0000:00:01.0
   IO window: c000-cfff
   MEM window: dc000000-ddffffff
   PREFETCH window: d0000000-d7ffffff
PCI: Bridge: 0000:00:1e.0
   IO window: 9000-bfff
   MEM window: de000000-dfffffff
   PREFETCH window: 30000000-300fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/O].
Initializing Cryptographic API
io scheduler noop registered
io scheduler deadline registered (default)
vesafb: framebuffer at 0xd0000000, mapped to 0xe0800000, using 3072k, 
total 32768k
vesafb: mode is 1024x768x16, linelength=2048, pages=20
vesafb: protected mode interface info at c000:4606
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
hw_random: RNG not detected
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: AGP aperture is 64M @ 0xd8000000
[drm] Initialized drm 1.0.1 20051102
[drm] Initialized radeon 1.24.0 20060225 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: Printer, Hewlett-Packard HP LaserJet 1100
lp0: using parport0 (polling).
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PCI: Found IRQ 9 for device 0000:02:01.0
PCI: Sharing IRQ 9 with 0000:00:1f.3
PCI: Sharing IRQ 9 with 0000:00:1f.5
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:01.0: 3Com PCI 3c905B Cyclone 100baseTx at e0b06000.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 17
ICH2: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC35L040AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
HPT370A: IDE controller at PCI slot 0000:02:06.0
PCI: Found IRQ 11 for device 0000:02:06.0
PCI: Sharing IRQ 11 with 0000:00:1f.4
HPT370A: chipset revision 4
HPT370A: 100% native mode on irq 11
HPT37X: using 33MHz PCI clock
     ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:DMA, hdf:pio
HPT37X: using 33MHz PCI clock
     ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:DMA, hdh:pio
Probing IDE interface ide2...
hde: ST3120026A, ATA DISK drive
ide2 at 0xa800-0xa807,0xac02 on irq 11
Probing IDE interface ide3...
hdg: IC35L120AVV207-0, ATA DISK drive
ide3 at 0xb000-0xb007,0xb402 on irq 11
hda: max request size: 128KiB
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
  hda: hda1 hda2 hda3
hde: max request size: 512KiB
hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, 
UDMA(100)
hde: cache flushes supported
  hde: hde1
hdg: max request size: 512KiB
hdg: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=16383/255/63, 
UDMA(100)
hdg: cache flushes supported
  hdg: hdg1
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
sata_sil 0000:02:03.0: version 0.9
PCI: Found IRQ 10 for device 0000:02:03.0
PCI: Sharing IRQ 10 with 0000:00:1f.2
ata1: SATA max UDMA/100 cmd 0xE0B08080 ctl 0xE0B0808A bmdma 0xE0B08000 
irq 10
ata2: SATA max UDMA/100 cmd 0xE0B080C0 ctl 0xE0B080CA bmdma 0xE0B08008 
irq 10
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
88:207f
ata1: dev 0 ATA-6, max UDMA/133, 234441648 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link down (SStatus 0)
scsi1 : sata_sil
   Vendor: ATA       Model: ST3120827AS       Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v3.0
PCI: Found IRQ 10 for device 0000:00:1f.2
PCI: Sharing IRQ 10 with 0000:02:03.0
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: irq 10, io base 0x0000d000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1f.4
PCI: Sharing IRQ 11 with 0000:02:06.0
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: UHCI Host Controller
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1f.4: irq 11, io base 0x0000d400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
    pIII_sse  :  2822.000 MB/sec
raid5: using function: pIII_sse (2822.000 MB/sec)
raid6: int32x1    386 MB/s
raid6: int32x2    484 MB/s
raid6: int32x4    338 MB/s
raid6: int32x8    319 MB/s
raid6: mmxx1     1181 MB/s
raid6: mmxx2     1405 MB/s
raid6: sse1x1    1160 MB/s
raid6: sse1x2    1426 MB/s
raid6: using algorithm sse1x2 (1426 MB/s)
md: raid6 personality registered for level 6
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 
10:27:24 2006 UTC).
PCI: Found IRQ 9 for device 0000:00:1f.5
PCI: Sharing IRQ 9 with 0000:00:1f.3
PCI: Sharing IRQ 9 with 0000:02:01.0
PCI: Setting latency timer of device 0000:00:1f.5 to 64
input: AT Translated Set 2 keyboard as /class/input/input0
intel8x0_measure_ac97_clock: measured 55292 usecs
intel8x0: clocking to 48000
ALSA device list:
   #0: Intel 82801BA-ICH2 with ALC200,200P at 0xd800, irq 9
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1>
md: bind<hdg1>
md: running: <hdg1><hde1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
Adding 514040k swap on /dev/hda1.  Priority:-1 extents:1 across:514040k
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PCI: Found IRQ 9 for device 0000:02:01.0
PCI: Sharing IRQ 9 with 0000:00:1f.3
PCI: Sharing IRQ 9 with 0000:00:1f.5
eth0:  setting full-duplex.


I have had a look at the code for the driver (sata_sil.c) and I have not 
attempted to 'blacklist' the HDD or 'sledgehammer' the DM-8301H to try 
to obtain a solution, although I would like to really sledgehammer the 
DM-8301H <grin> ... but at least it was a cheap card.


Is there anything else I can try to get the HDD/Card working? Utilities 
that I can run for more information? Anything that I can do to help in 
general?

Any advice would be much appreciated.


Thanks and regards
Ellis

Ellis Skinazi
mailto: linux@paranor.org.uk

- Real Windows users type a user name and password and then reach for 
the mouse to click LOGIN ... they haven't found the Enter key yet :^)


