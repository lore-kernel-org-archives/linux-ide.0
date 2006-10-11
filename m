From: "Kevin Radloff" <radsaq@gmail.com>
Subject: [BUG] 2.6.19-rc1: ata_piix takes excessively long to probe a nonexistent device
Date: Wed, 11 Oct 2006 01:10:59 -0400
Message-ID: <3b0ffc1f0610102210o15d52d95n28d2963164c4dd23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030797AbWJKFLE@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

Using ata_piix on a Fujitsu laptop with an ICH4-M and a HD on the
first channel and a DVD/CDRW drive on the second channel, I see this:

ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
scsi0 : ata_piix
ata1.00: ATA-6, max UDMA/100, 156301488 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ata_piix
ata2.00: ATAPI, max UDMA/33
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHT2080A 0022 PQ: 0 ANSI: 5
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 > sda3
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: CD-ROM            MATSHITA UJDA755 DVD/CDRW 1.00 PQ: 0 ANSI: 5

The timeout/retry periods add an extra minute or two to kernel boot
process. This did not occur with 2.6.17 + Alan's PATA patches
(although I did see a single message about dev 1 failing to IDENTIFY
with that).

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
