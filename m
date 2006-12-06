From: "Art Haas" <ahaas@airmail.net>
Subject: Re: CDROM drive not found when booting using new libata code
Date: Wed, 6 Dec 2006 12:16:52 -0600
Message-ID: <20061206181652.GA3107@artsapartment.org>
References: <20060924221020.GB2080@artsapartment.org> <4562C65C.2010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wmail-1.airmail.net ([209.196.70.86]:64367 "EHLO
	wmail-1.airmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936981AbWLFSSF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2006 13:18:05 -0500
Received: from cpe-68-201-223-150.houston.res.rr.com ([68.201.223.150] helo=pcdebian)
	by wmail-1.airmail.net with esmtp (Exim 4.60)
	(envelope-from <ahaas@airmail.net>)
	id 1Gs1LH-000Bq3-Qu
	for linux-ide@vger.kernel.org; Wed, 06 Dec 2006 12:18:04 -0600
Content-Disposition: inline
In-Reply-To: <4562C65C.2010802@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Tue, Nov 21, 2006 at 06:26:52PM +0900, Tejun Heo wrote:
> Art Haas wrote:
> >Hi.
> >
> >As Linus has just pulled in the large libata changes into his tree, I
> >wanted to try out the new code. I'm running Debian on a PIIX
> >motherboard, and I've enclosed the 'dmesg' output for the machine
> >when booting 2.6.18 which uses the piix.c code in drivers/ide and
> >the new 2.6.18+ code which uses ata_piix.c in drivers/ata.
> 
> Can you please test 2.6.19-rc5-mm2?

Hello.

I didn't get a chance to try that release, but since then many of the
libata patches have been merged into Linus's post-2.6.19 tree, which
I'm now running. The CD-ROM drive is still not being found,
unfortunately. Trimmed 'dmesg' output below:

Linux version 2.6.19-ajh (arth@pcdebian) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-20)) #6 Wed Dec 6 08:38:32 CST 2006
[ ... snip ... ]
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
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi0 : ata_piix
ata1.00: ATA-2, max UDMA/33, 6303024 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATA-4, max UDMA/66, 16514064 sectors: LBA 
ata1.01: ata1: dev 1 multi count 16
ata1.00: configured for UDMA/33
ata1.01: configured for UDMA/33
scsi1 : ata_piix
ata2.00: ATAPI, max MWDMA1
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

Although the CD-ROM wasn't found, the bootup was speedier than it had
been with the libata code from the 2.6.19-pre releases. I notice that
the 'revalidation failed' value is different that what I had been
seeing, also. Here is trimmed 'dmesg' output from when I first tried out
the new libata code:

Linux version 2.6.18-pata (arth@pcdebian) (gcc version 4.1.2 20060928 (prerelease) (Debian 4.1.1-15)) #25 Wed Oct 4 16:12:47 CDT 2006
[ ... snip ... ]
libata version 2.00 loaded.
ata_piix 0000:00:07.1: version 2.00ac6
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi0 : ata_piix
ata1.00: ATA-2, max UDMA/33, 6303024 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATA-4, max UDMA/66, 16514064 sectors: LBA 
ata1.01: ata1: dev 1 multi count 16
ata1.00: configured for UDMA/33
ata1.01: configured for UDMA/33
scsi1 : ata_piix
ATA: abnormal status 0xFF on port 0x177
ATA: abnormal status 0xFF on port 0x177
ata2.00: ATAPI, max MWDMA1
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: limiting speed to PIO4
ata2: failed to recover some devices, retrying in 5 secs
ATA: abnormal status 0xFF on port 0x177
ATA: abnormal status 0xFF on port 0x177
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: limiting speed to PIO0
ata2: failed to recover some devices, retrying in 5 secs
ATA: abnormal status 0xFF on port 0x177
ATA: abnormal status 0xFF on port 0x177
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled
scsi 0:0:0:0: Direct-Access     ATA      ST33232A         3.02 PQ: 0 ANSI: 5
SCSI device sda: 6303024 512-byte hdwr sectors (3227 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write through
SCSI device sda: 6303024 512-byte hdwr sectors (3227 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write through
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
scsi 0:0:1:0: Direct-Access     ATA      FUJITSU MPD3084A DD-0 PQ: 0 ANSI: 5
SCSI device sdb: 16514064 512-byte hdwr sectors (8455 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 16514064 512-byte hdwr sectors (8455 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 sdb6 > sdb3
sd 0:0:1:0: Attached scsi disk sdb
[ ... snip ... ]

For comparison here is trimmed 'dmesg' output from a 2.6.18 kernel using
the drivers/ide code:

Linux version 2.6.18 (arth@pcdebian) (gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #1 Wed Sep 20 06:56:45 CDT 2006
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
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 132k freed
input: AT Translated Set 2 keyboard as /class/input/input0
NET: Registered protocol family 1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
hdc: ATAPI 24X CD-ROM drive, 120kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
[ ... snip ... ]

In better news, I'm running Linus' current tree on a SMP PIII machine
which also uses the piix motherboard. This machine previous would
also not find the CD-ROM and had long delays probing the disks during
bootup. I'm pleased to report both problems are solved!

Please let me know what other info I can pass along to help identify
the problem, and I'll be glad to test patches.

My thanks to everyone working on Linux and the new libata code.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
