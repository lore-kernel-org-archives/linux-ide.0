From: "Art Haas" <ahaas@airmail.net>
Subject: Queued patches for PIIX hardware
Date: Tue, 10 Oct 2006 10:25:03 -0500
Message-ID: <20061010152503.GA29794@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wmail-2.airmail.net ([209.196.70.85]:18885 "EHLO
	wmail-2.airmail.net") by vger.kernel.org with ESMTP id S932126AbWJJPZW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Oct 2006 11:25:22 -0400
Received: from cpe-24-28-121-3.houston.res.rr.com ([24.28.121.3] helo=pcdebian)
	by wmail-2.airmail.net with esmtp (Exim 4.60)
	(envelope-from <ahaas@airmail.net>)
	id 1GXJTt-000LXm-Ic
	for linux-ide@vger.kernel.org; Tue, 10 Oct 2006 10:25:21 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi.

I've been using kernels with the new libata code since Linus merged the
files into his tree, and on my machines with PIIX hardware things have
not worked as smoothly as they did when using the drivers/ide code.
That's to be expected as the code is now getting much wider testing, so
a problem or two will be discovered. I've checked on this list for
various patches dealing with PIIX machines and other libata issues, and
it looks like there are several potential patches and patch sets that
may solve some of the problems I've seen. A quick peek at the libata git
repo this morning, however, and I saw that these patches do not appear
to be queued up to go into -rc2 just yet. Are the patches still to
"fluid" to be sent upstream?

On one machine I use, the system doesn't recognize the CD-ROM drive and
prints out numerous 'abnormal status 0xFF' warnings:

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

The 'sdc' device should be the CD-ROM. There is a patch by Tejun Heo
dealing with the 0xff status that may fix this problem.

Another machine has problems when looking at the CD-ROM, but instead of
the 0xff message the system does several retries and long waits to
identify the device, and ultimately bails on it. I think there was a
series of five or six patches that dealt with problems like this -
something about ghost or phantom device handling.

Thanks in advance for any info about various libata patches that you
could send my way.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
