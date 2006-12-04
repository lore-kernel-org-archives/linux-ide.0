From: Jan Gutter <jang@lucidview.net>
Subject: ICH7m problem using libata
Date: Mon, 04 Dec 2006 19:36:39 +0200
Message-ID: <1165253799.16504.37.camel@laundromat.jangutter.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.developerscorner.co.za ([64.151.72.215]:2603 "EHLO
	us.developerscorner.co.za" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758963AbWLDRic (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Dec 2006 12:38:32 -0500
Received: from [192.168.2.150] (wbs-196-2-116-197.wbs.co.za [196.2.116.197])
	(authenticated bits=0)
	by us.developerscorner.co.za (8.12.8/8.12.8) with ESMTP id kB4HhKbm021835
	for <linux-ide@vger.kernel.org>; Mon, 4 Dec 2006 09:44:51 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Our company has recently purchased two Acer 5632WSMi laptops and we're
running Gentoo x86 unstable on them. The most hindering problem that's
currently plaguing us is the IDE chipset. 

Without the combined_mode=libata on the command line, DMA is disabled
and the hard drive just uses PIO. With libata, it hangs up randomly,
causing the driver to eventually clock down to PIO mode too.

I'd be willing to test patches (like really INSANE ones), because the
laptop's not too critical currently. I can post the full dmesg and lspci
-vvnn if it might be of use. I have no idea whether this problem has
been solved or reported before.

Excerpt from lspci:

00:1f.2 0101: 8086:27c4 (rev 02)

00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) \
Serial ATA Storage Controller IDE (rev 02)

Excerpt from dmesg:

Linux version 2.6.19-gentoo-r1 (root@wookie) (gcc version 4.1.1 \
(Gentoo 4.1.1-r3)) #2 SMP PREEMPT Mon Dec 4 18:33:02 SAST 2006
...cut...
Kernel command line: root=/dev/ram0 init=/linuxrc ramdisk=8192 \
real_root=/dev/sda7 udev video=vesafb:ywrap,1440x900-24@65 \
combined_mode=libata
...cut...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
input: AT Translated Set 2 keyboard as /class/input/input0
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe
ata_piix 0000:00:1f.2: version 2.00ac6
ata_piix 0000:00:1f.2: MAP [ IDE IDE P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
scsi0 : ata_piix
ata1.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATAPI, max UDMA/33
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/33
scsi1 : ata_piix
ATA: abnormal status 0x7F on port 0x177
scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK1234GA AC00 PQ: 0
ANSI: 5
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
scsi 0:0:1:0: CD-ROM            TSSTcorp CD/DVDW TS-L632D ac00 PQ: 0
ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
...cut...
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01: (BMDMA stat 0x64)
ata1.01: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/33
ata1: EH complete
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01: (BMDMA stat 0x64)
ata1.01: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/33
ata1: EH complete
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01: (BMDMA stat 0x64)
ata1.01: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/33
ata1: EH complete
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back

Thanks in advance for any help!

Jan Gutter

