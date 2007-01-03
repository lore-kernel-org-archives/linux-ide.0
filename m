From: "Art Haas" <ahaas@airmail.net>
Subject: Re: CDROM drive not found when booting using new libata code
Date: Wed, 3 Jan 2007 12:08:40 -0600
Message-ID: <20070103180840.GC2268@artsapartment.org>
References: <4562C65C.2010802@gmail.com> <20061206181652.GA3107@artsapartment.org> <45779852.1030909@gmail.com> <20061207105525.4ebb4547@localhost.localdomain> <45780AF5.2020605@gmail.com> <20061208010626.GA1856@artsapartment.org> <45927532.3060404@gmail.com> <45933F2A.5070304@gmail.com> <20070102210708.GI24909@artsapartment.org> <459B239B.90204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:37700 "EHLO
	ms-smtp-01.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbXACSIr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jan 2007 13:08:47 -0500
Received: from pcdebian (cpe-68-201-223-150.houston.res.rr.com [68.201.223.150])
	by ms-smtp-01.texas.rr.com (8.13.6/8.13.6) with ESMTP id l03I8iH3028309
	for <linux-ide@vger.kernel.org>; Wed, 3 Jan 2007 12:08:45 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <459B239B.90204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, Jan 03, 2007 at 12:31:39PM +0900, Tejun Heo wrote:
> Art Haas wrote:
> > Hi.
> > 
> > I wanted to try the two patches you've sent against the current
> > 2.6.20-rc3, but there have been numerous changes to the files
> > so neither patch can apply cleanly. I'm not familiar enough
> > with the libata to try and make similar changes to the current
> > files to match your patch. :-(
> > 
> > Any possiblity of generating patches against the 2.6.20-rc3 tree?
> 
> Yeap, please try the attached patch.  Thanks.
> [ ... snip patch ... ]

Sorry to report the patch did not work. Here's the dmesg output
from booting the test kernel - this morning's Linus tree with
your patch applied:

$ dmesg
Linux version 2.6.20-rc3-ajh (arth@pcdebian) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 Wed Jan 3 04:20:15 CST 2007
BIOS-provided physical RAM map:
[ ... snip ... ]
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
libata version 2.00 loaded.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: match found with the PnP device '00:02' and the driver 'system'
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:08' and the driver 'serial'
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:09' and the driver 'serial'
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ata_piix 0000:00:07.1: version 2.00ac7
ata1: PATA max UDMA/33:PIO4 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/33:PIO4 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi0 : ata_piix
ata1.00: ATA-2, max UDMA/33:PIO4, 6303024 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATA-4, max UDMA/66:PIO4, 16514064 sectors: LBA 
ata1.01: ata1: dev 1 multi count 16
ata1.00: configured for UDMA/33:PIO0
ata1.01: configured for UDMA/33:PIO0
scsi1 : ata_piix
ata2.00: ATAPI, max MWDMA1:PIO4
ata2.00: revalidation failed (errno=-2)
ata2.00: limiting speed to PIO4
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: revalidation failed (errno=-2)
ata2.00: limiting speed to PIO0
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: revalidation failed (errno=-2)
ata2.00: disabled
scsi 0:0:0:0: Direct-Access     ATA      ST33232A         3.02 PQ: 0 ANSI: 5
SCSI device sda: 6303024 512-byte hdwr sectors (3227 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 6303024 512-byte hdwr sectors (3227 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
scsi 0:0:1:0: Direct-Access     ATA      FUJITSU MPD3084A DD-0 PQ: 0 ANSI: 5
SCSI device sdb: 16514064 512-byte hdwr sectors (8455 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 16514064 512-byte hdwr sectors (8455 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 < sdb5 sdb6 > sdb3
sd 0:0:1:0: Attached scsi disk sdb
[ ... snip ... ]

A week or two ago I built a 2.6.20-rc kernel configured to use the
drivers/ide code and it (still) found the CDROM drive. Here's a trimmed
dmesg output of that kernel included with the hopes that it can be
useful ...

Linux version 2.6.20-rc1-ide (arth@pcdebian) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 Sun Dec 17 12:40:37 CST 2006
[ ... snip ... ]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: ST33232A, ATA DISK drive
hdb: FUJITSU MPD3084AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 6303024 sectors (3227 MB) w/128KiB Cache, CHS=6253/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdb: max request size: 128KiB
hdb: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63, UDMA(33)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 < hdb5 hdb6 > hdb3
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
TCP cubic registered
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 152k freed
NET: Registered protocol family 1
hdc: ATAPI 24X CD-ROM drive, 120kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
Real Time Clock Driver v1.12ac
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
[ ... snip ... ]


-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
