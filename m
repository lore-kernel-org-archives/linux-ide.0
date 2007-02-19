From: "Marc Marais" <marcm@liquid-nexus.net>
Subject: sata_promise: random/intermittent errors
Date: Mon, 19 Feb 2007 12:43:50 +0800
Message-ID: <20070219042905.M81047@liquid-nexus.net>
References: <20070217030514.M74974@liquid-nexus.net> <17878.49009.771973.884472@notabene.brown> <20070218091504.M97223@liquid-nexus.net> <17880.7869.963793.706096@notabene.brown> <20070218105242.M29958@liquid-nexus.net> <20070218115626.M47438@liquid-nexus.net> <Pine.LNX.4.64.0702180712340.9820@p34.internal.lan> <20070218122522.M5171@liquid-nexus.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ihug-mail.icp-qv1-irony16.iinet.net.au ([203.59.1.182]:22648
	"EHLO mail-ihug.icp-qv1-irony16.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751156AbXBSEyJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Feb 2007 23:54:09 -0500
Received: from localhost ([127.0.0.1] helo=liquid-nexus.net)
	by xerces.liquid-nexus.net with esmtp (Exim 4.50)
	id 1HJ0NS-0005t2-1N
	for linux-ide@vger.kernel.org; Mon, 19 Feb 2007 13:43:50 +0900
In-Reply-To: <20070218122522.M5171@liquid-nexus.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've decided to post this to the linux-ide list to see if I can get to the
bottom of this problem I'm experiencing with sata_promise and my PATA drives.

I've pasted a thread from the linux-raid list where I was trying to
troubleshoot/recover a destroyed raid5 array.

First a full history:

1) 2.6.17.13: 3 drive PATA raid5 array with one drive starting to give read
errors (legitimate according to SMART logs).
2) System lockups (no kernel panic seen) during load - I suspect due to the
read error on the failing drive. 
3) Decide to upgrade to 2.6.20
4) Raid5 issues occur (handling of read errors caused md device to die). 
5) Patch from Neil to fix raid-5 error handling
6) Replace failed drive and add a new drive at the same time to create a 4
drive PATA array.
7) Attempt to grow the array from 3 -> 4 devices which failed due to an error
similar to this:

ata3: command timeout
ata3: no sense translation for status: 0x40
ata3: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x40 { DriveReady }
sd 3:0:0:0: SCSI error: return code = 0x08000002
sdd: Current [descriptor]: sense key: Aborted Command
     Additional sense: No additional sense information
Descriptor sense data with sense descriptors (in hex):
         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
         00 00 00 00
end_request: I/O error, dev sdc, sector 260419647

8) Raid array is trashed, rebuild array and restore from backup.
9) From this point on the system is up and running - restored to working
state. However, I'm still getting errors similar to the above during array
accesses (read/write). Not related to load. The array (being synced) manages
to continue operation using another drive. My concern is that this may happen
on a degraded array in future.

Note that the error I'm getting (shown above) has happened on sdc and sdd and
at different sectors (i.e. not a consistent read error). Also, the SMART logs
for both drives show NO error at all, short and long SMART tests complete
successfully. I suspect this is an issue in the driver and/or my physical
TX4000 card.

If you could shed any light on this I would appreciate it.

Thanks.
Regards.

------------- BEGIN DMESG DUMP -----------------

Linux version 2.6.20 (root@xerces) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #2
SMP Mon Feb 12 09:28:29 GMT-9 2007 BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009c800 end:
000000000009c800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009c800 size: 0000000000003800 end:
00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end:
0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000007feec000 end:
000000007ffec000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000007ffec000 size: 0000000000003000 end:
000000007ffef000 type: 3
copy_e820_map() start: 000000007ffef000 size: 0000000000010000 end:
000000007ffff000 type: 2
copy_e820_map() start: 000000007ffff000 size: 0000000000001000 end:
0000000080000000 type: 4
copy_e820_map() start: 00000000fec00000 size: 0000000000001000 end:
00000000fec01000 type: 2
copy_e820_map() start: 00000000fee00000 size: 0000000000001000 end:
00000000fee01000 type: 2
copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end:
0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009c800 (usable)
 BIOS-e820: 000000000009c800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffec000 (usable)
 BIOS-e820: 000000007ffec000 - 000000007ffef000 (ACPI data)
 BIOS-e820: 000000007ffef000 - 000000007ffff000 (reserved)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved) 1151MB HIGHMEM
available.
896MB LOWMEM available.
found SMP MP-table at 000f7ea0
Entering add_active_range(0, 0, 524268) 0 entries of 256 used Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   524268
early_node_map[1] active PFN ranges
    0:        0 ->   524268
On node 0 totalpages: 524268
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2303 pages used for memmap
  HighMem zone: 292589 pages, LIFO batch:31 DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ASUS     Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:10 APIC version 16
Processor #1 6:10 APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Detected 2133.464 MHz processor.
Built 1 zonelists.  Total pages: 520173
Kernel command line: auto BOOT_IMAGE=Linux ro root=901 acpi=off pci=noacpi
elevator=as mapped APIC to ffffd000 (fee00000) mapped IOAPIC to ffffc000
(fec00000) Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes) Inode-cache
hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2072936k/2097072k available (1539k kernel code, 22916k reserved, 593k
data, 200k init, 1179568k highmem) virtual kernel memory layout:
    fixmap  : 0xfffa2000 - 0xfffff000   ( 372 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc031b000 - 0xc034d000   ( 200 kB)
      .data : 0xc0280c62 - 0xc0315230   ( 593 kB)
      .text : 0xc0100000 - 0xc0280c62   (1539 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4269.42 BogoMIPS
(lpj=2134710) Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
00000000 00000000 00000000
CPU: CLK_CTL MSR was 60031223. Reprogramming to 20031223
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000420 00000000
00000000 00000000 Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 10k freed
CPU0: AMD Athlon(TM) MP 2800+ stepping 00 Booting processor 1/1 eip 2000
Initializing CPU#1 Calibrating delay using timer specific routine.. 4266.31
BogoMIPS (lpj=2133156)
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
00000000 00000000 00000000
CPU: CLK_CTL MSR was 60031223. Reprogramming to 20031223
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000420 00000000
00000000 00000000 Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(TM) MP 2800+ stepping 00 Total of 2 processors activated
(8535.73 BogoMIPS).
ExtINT not setup in hardware but reported by MP table ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0 checking TSC
synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=1084
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1f30, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc5f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc620, dseg 0xf0000
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver SCSI subsystem
initialized libata version 2.00 loaded.
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:05.0
PCI: Using IRQ router AMD768 [1022/7443] at 0000:00:07.3
PCI->APIC IRQ transform: 0000:00:08.0[A] -> IRQ 16 APIC IRQ transform: 
PCI->0000:00:09.0[A] -> IRQ 17 APIC IRQ transform: 0000:01:05.0[A] -> 
PCI->IRQ 16 APIC IRQ transform: 0000:02:04.0[A] -> IRQ 17 APIC IRQ 
PCI->transform: 0000:02:05.0[A] -> IRQ 18 APIC IRQ transform: 
PCI->0000:02:05.1[B] -> IRQ 19 APIC IRQ transform: 0000:02:05.2[C] -> 
PCI->IRQ 16 APIC IRQ transform: 0000:02:06.0[A] -> IRQ 17 APIC IRQ 
PCI->transform: 0000:02:08.0[A] -> IRQ 19
pnp: 00:0f: ioport range 0xe400-0xe47f has been reserved
pnp: 00:0f: ioport range 0xe4e0-0xe4ff has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ee000000-efcfffff
  PREFETCH window: eff00000-fb7fffff
PCI: Bridge: 0000:00:10.0
  IO window: a000-afff
  MEM window: e8800000-ebffffff
  PREFETCH window: efd00000-efdfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes) TCP
established hash table entries: 131072 (order: 8, 1048576 bytes) TCP bind hash
table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536) TCP reno
registered checking if image is initramfs...it isn't (bad gzip magic numbers);
looks like an initrd Freeing initrd memory: 3072k freed Machine check
exception polling timer started.
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes) io scheduler noop
registered io scheduler anticipatory registered (default) io scheduler
deadline registered io scheduler cfq registered BIOS failed to enable PCI
standards compliance, fixing this error.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:03: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A RAMDISK driver initialized: 16
RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice TCP cubic registered Starting
balanced_irq Using IPI Shortcut mode
input: AT Translated Set 2 keyboard as /class/input/input0
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 3072KiB [1 disk] into ram disk... 
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 200k freed
NET: Registered protocol family 1
md: raid1 personality registered for level 1 Uniform Multi-Platform E-IDE
driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 0000:00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: 0000:00:07.1 (rev 04) UDMA100 controller
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA Probing IDE
interface ide0...
hda: WDC WD800BB-00JHC0, ATA DISK drive
hdb: WDC WD2500JB-00GVC0, ATA DISK drive ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: WDC WD800BB-23DKA0, ATA DISK drive
hdd: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hdb: max request size: 512KiB
hdb: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1
hdc: max request size: 512KiB
hdc: 156312576 sectors (80032 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 >
md: md0 stopped.
md: bind<hda1>
md: bind<hdc1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: md1 stopped.
md: bind<hda2>
md: bind<hdc2>
raid1: raid set md1 active with 2 out of 2 mirrors kjournald starting.  Commit
interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
hda: cache flushes supported
hdc: cache flushes supported
hdb: cache flushes supported
Adding 2007992k swap on /dev/md0.  Priority:-1 extents:1 across:2007992k
EXT3 FS on md1, internal journal
Real Time Clock Driver v1.12ac
hdd: ATAPI 52X DVD-ROM drive, 256kB Cache, UDMA(33) Uniform CD-ROM driver
Revision: 3.20
ieee1394: Initialized config rom entry `ip1394'
ieee1394: raw1394: /dev/raw1394 device initialized
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[e9800000-e98007ff] 
Max Packet=[2048]  IR/IT contexts=[4/8]
video1394: Installed video1394 module
AMD768 RNG detected
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:02:05.0: OHCI Host Controller ohci_hcd 0000:02:05.0: new USB bus
registered, assigned bus number 1 ohci_hcd 0000:02:05.0: irq 18, io mem
0xeb000000 usb usb1: configuration #1 chosen from 1 choice hub 1-0:1.0: USB
hub found hub 1-0:1.0: 3 ports detected ohci_hcd 0000:02:05.1: OHCI Host
Controller ohci_hcd 0000:02:05.1: new USB bus registered, assigned bus number
2 ohci_hcd 0000:02:05.1: irq 19, io mem 0xea800000
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[005042f81010a4eb] usb usb2:
configuration #1 chosen from 1 choice hub 2-0:1.0: USB hub found hub 2-0:1.0:
2 ports detected
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2 Copyright (c) 1999-2006
Intel Corporation.
e1000: 0000:00:09.0: e1000_probe: (PCI:66MHz:32-bit) 00:0e:0c:a0:04:dd
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection scsi0 : Adaptec
AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

scsi 0:0:0:0: Sequential-Access SONY     SDX-500C         0101 PQ: 0 ANSI: 2
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous
 target0:0:0: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
sata_promise 0000:00:08.0: version 1.05
ata1: PATA max UDMA/133 cmd 0xF8AA6200 ctl 0xF8AA6238 bmdma 0x0 irq 16
ata2: PATA max UDMA/133 cmd 0xF8AA6280 ctl 0xF8AA62B8 bmdma 0x0 irq 16
ata3: PATA max UDMA/133 cmd 0xF8AA6300 ctl 0xF8AA6338 bmdma 0x0 irq 16
ata4: PATA max UDMA/133 cmd 0xF8AA6380 ctl 0xF8AA63B8 bmdma 0x0 irq 16
scsi1 : sata_promise
ata1.00: ATA-7, max UDMA/100, 312581808 sectors: LBA48
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/100
scsi2 : sata_promise
ata2.00: ATA-7, max UDMA/100, 312581808 sectors: LBA48
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/100
scsi3 : sata_promise
ata3.00: ATA-7, max UDMA/100, 312581808 sectors: LBA48
ata3.00: ata3: dev 0 multi count 0
ata3.00: configured for UDMA/100
scsi4 : sata_promise
ata4.00: ATA-6, max UDMA/100, 312581808 sectors: LBA48
ata4.00: ata4: dev 0 multi count 0
ata4.00: configured for UDMA/100
scsi 1:0:0:0: Direct-Access     ATA      WDC WD1600JB-00R 20.0 PQ: 0 ANSI: 5
scsi 2:0:0:0: Direct-Access     ATA      WDC WD1600JB-00R 20.0 PQ: 0 ANSI: 5
scsi 3:0:0:0: Direct-Access     ATA      WDC WD1600JB-00R 20.0 PQ: 0 ANSI: 5
scsi 4:0:0:0: Direct-Access     ATA      WDC WD1600JB-00E 15.0 PQ: 0 ANSI: 5
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
md: md2 stopped.
md: bind<hda3>
md: bind<hdc3>
raid1: raid set md2 active with 2 out of 2 mirrors
md: md3 stopped.
md: bind<hda5>
md: bind<hdc5>
raid1: raid set md3 active with 2 out of 2 mirrors
md: md4 stopped.
md: bind<hda6>
md: bind<hdc6>
raid1: raid set md4 active with 2 out of 2 mirrors
md: md5 stopped.
md: bind<hda7>
md: bind<hdc7>
raid1: raid set md5 active with 2 out of 2 mirrors
md: md6 stopped.
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support
DPO or FUA SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sda: sda1
sd 1:0:0:0: Attached scsi disk sda
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support
DPO or FUA SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sdb: sdb1
sd 2:0:0:0: Attached scsi disk sdb
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support
DPO or FUA SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sdc: sdc1
sd 3:0:0:0: Attached scsi disk sdc
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't support
DPO or FUA SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sdd: sdd1
sd 4:0:0:0: Attached scsi disk sdd
md: bind<sdb1>
md: bind<sdc1>
md: bind<sda1>
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  4928.000 MB/sec
raid5: using function: pIII_sse (4928.000 MB/sec)
raid6: int32x1    855 MB/s
raid6: int32x2   1156 MB/s
raid6: int32x4    730 MB/s
raid6: int32x8    648 MB/s
raid6: mmxx1     1781 MB/s
raid6: mmxx2     3265 MB/s
raid6: sse1x1     464 MB/s
raid6: sse1x2     929 MB/s
raid6: using algorithm sse1x2 (929 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: device sda1 operational as raid disk 0
raid5: device sdc1 operational as raid disk 2
raid5: device sdb1 operational as raid disk 1
raid5: allocated 4204kB for md6
raid5: raid level 5 set md6 active with 3 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:3
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sdc1
md: md7 stopped.
md: bind<hdc8>
md: bind<hda8>
raid1: raid set md7 active with 2 out of 2 mirrors
st: Version 20061107, fixed bufsize 32768, s/g segs 256 st 0:0:0:0: Attached
scsi tape st0 st 0:0:0:0: st0: try direct i/o: yes (alignment 512 B)
 target0:0:0: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
st0: Block limits 2 - 16777215 bytes.
program stinit is using a deprecated SCSI ioctl, please convert it to SG_IO
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
e1000: eth0: e1000_set_tso: TSO is Disabled
e1000: eth0: e1000_set_tso: TSO is Disabled
e1000: eth0: e1000_set_tso: TSO is Disabled process `syslogd' is using
obsolete setsockopt SO_BSDCOMPAT
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata2: no sense translation for status: 0x50
ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata3: no sense translation for status: 0x50
ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
ata4: no sense translation for status: 0x50
ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x50 { DriveReady SeekComplete }
st0: MTSETDRVBUFFER only allowed for root.
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon[2331]: Module vmmon: registered with major=10 minor=165
/dev/vmmon[2331]: Module vmmon: initialized
/dev/vmnet: open called by PID 2366 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: enabling the bridge
bridge-eth0: up
bridge-eth0: already up
bridge-eth0: attached
floppy0: no floppy controllers found
floppy0: no floppy controllers found
st 0:0:0:0: Attached scsi generic sg0 type 1 sd 1:0:0:0: Attached scsi generic
sg1 type 0 sd 2:0:0:0: Attached scsi generic sg2 type 0 sd 3:0:0:0: Attached
scsi generic sg3 type 0 sd 4:0:0:0: Attached scsi generic sg4 type 0
/dev/vmnet: open called by PID 2723 (vmware-vmx) device eth0 entered
promiscuous mode
bridge-eth0: enabled promiscuous mode
/dev/vmnet: port on hub 0 successfully opened
/dev/vmmon[2744]: host clock rate change request 0 -> 1001
/dev/vmnet: open called by PID 2972 (vmware-vmx)
/dev/vmnet: port on hub 0 successfully opened
md: bind<sdd1>
RAID5 conf printout:
 --- rd:4 wd:3
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sdc1
 disk 3, o:1, dev:sdd1
md: recovery of RAID array md6
md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
md: using maximum available idle IO bandwidth (but not more than 200000
KB/sec) for recovery.
md: using 128k window, over a total of 156288256 blocks.
md: md6: recovery done.
RAID5 conf printout:
 --- rd:4 wd:4
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sdc1
 disk 3, o:1, dev:sdd1
/dev/vmnet: open called by PID 2989 (vmware-vmx)
/dev/vmnet: port on hub 0 successfully opened
/dev/vmnet: open called by PID 2989 (vmware-vmx)
/dev/vmnet: port on hub 0 successfully opened
/dev/vmmon[2744]: host clock rate change request 1001 -> 1002
/dev/vmmon[2744]: host clock rate change request 1002 -> 83
/dev/vmmon[2744]: host clock rate change request 83 -> 1001
/dev/vmmon[2744]: host clock rate change request 1001 -> 1002
/dev/vmmon[2744]: host clock rate change request 1002 -> 1001
/dev/vmnet: open called by PID 2988 (vmware-vmx)
/dev/vmnet: port on hub 0 successfully opened
/dev/vmnet: open called by PID 2989 (vmware-vmx)
/dev/vmnet: port on hub 0 successfully opened kjournald starting.  Commit
interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ata3: command timeout
ata3: no sense translation for status: 0x40
ata3: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x40 { DriveReady }
sd 3:0:0:0: SCSI error: return code = 0x08000002
sdc: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information Descriptor sense data
with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 00 00 01
end_request: I/O error, dev sdc, sector 260419647
raid5:md6: read error corrected (8 sectors at 260419584 on sdc1)
ata4: command timeout
ata4: no sense translation for status: 0x40
ata4: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x40 { DriveReady }
sd 4:0:0:0: SCSI error: return code = 0x08000002
sdd: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information Descriptor sense data
with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 00 00 00
end_request: I/O error, dev sdd, sector 277596095


------------- END DMESG DUMP -------------


---------- Forwarded Message -----------
On Sun, 18 Feb 2007 07:13:28 -0500 (EST), Justin Piszcz wrote
> On Sun, 18 Feb 2007, Marc Marais wrote:
> 
> > On Sun, 18 Feb 2007 20:39:09 +1100, Neil Brown wrote
> >> On Sunday February 18, marcm@liquid-nexus.net wrote:
> >>> Ok, I understand the risks which is why I did a full backup before 
doing
> >>> this. I have subsequently recreated the array and restored my data from
> >>> backup.
> >>
> >> Could you still please tell me exactly what kernel/mdadm version you
> >> were using?
> >>
> >> Thanks,
> >> NeilBrown
> >
> > 2.6.20 with the patch you supplied in response to the "md6_raid5 crash
> > email" I posted in linux-raid a few days ago. Just as background, I 
replaced
> > the failing drive and at the same time bought an additional drive in 
order
> > to increase the array size.
> >
> > mdadm -V = v2.6 - 21 December 2006. Compiled under Debian (stable).
> >
> > Also, I've just noticed another drive failure with the new array with a
> > similar error to what happened during the grow operation (although on a
> > different drive) - I wonder if I should post this to linux-ide?
> >
> > Feb 18 00:58:10 xerces kernel: ata4: command timeout
> > Feb 18 00:58:10 xerces kernel: ata4: no sense translation for status: 
0x40
> > Feb 18 00:58:10 xerces kernel: ata4: translated ATA stat/err 0x40/00 to 
SCSI
> > SK/ASC/ASCQ 0xb/00/00
> > Feb 18 00:58:10 xerces kernel: ata4: status=0x40 { DriveReady }
> > Feb 18 00:58:10 xerces kernel: sd 4:0:0:0: SCSI error: return code =
> > 0x08000002
> > Feb 18 00:58:10 xerces kernel: sdd: Current [descriptor]: sense key: 
Aborted
> > Command
> > Feb 18 00:58:10 xerces kernel:     Additional sense: No additional sense
> > information
> > Feb 18 00:58:10 xerces kernel: Descriptor sense data with sense 
descriptors
> > (in hex):
> > Feb 18 00:58:10 xerces kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 
00
> > 00 00 00 00
> > Feb 18 00:58:10 xerces kernel:         00 00 00 00
> > Feb 18 00:58:10 xerces kernel: end_request: I/O error, dev sdd, sector
> > 35666775
> > Feb 18 00:58:10 xerces kernel: raid5: Disk failure on sdd1, disabling
> > device. Operation continuing on 3 devices
> >
> > Regards,
> > Marc
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> Just out of curiosity:
> 
> Feb 18 00:58:10 xerces kernel: end_request: I/O error, dev sdd,
>  sector 35666775
> 
> Can you run:
> 
> smartctl -d ata -t short /dev/sdd
> wait 5 min
> smartctl -d ata -t long /dev/sdd
> wait 2-3 hr
> smartctl -d ata -a /dev/sdd
> 
> And then e-mail that output to the list?
> 
> Justin.

I have smartmontools performing regular short and long scans but I will run 
the tests immediately and send the output of smartctl -a when done.

Note I'm getting similar errors on sdc too (as in 5 minutes ago). 
Interestingly the SMART error logs for sdc and sdd show no errors at all.

ata3: command timeout
ata3: no sense translation for status: 0x40
ata3: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x40 { DriveReady }
sd 3:0:0:0: SCSI error: return code = 0x08000002
sdd: Current [descriptor]: sense key: Aborted Command
     Additional sense: No additional sense information
Descriptor sense data with sense descriptors (in hex):
         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
         00 00 00 00
end_request: I/O error, dev sdc, sector 260419647
raid5:md6: read error corrected (8 sectors at 260419584 on sdc1)

Will post logs when done...

Marc

--
------- End of Forwarded Message -------


--
