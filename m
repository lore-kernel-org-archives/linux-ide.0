From: David Richards <david@industrialstrengthsolutions.com>
Subject: sata_sil + seagate issues
Date: Wed, 09 Mar 2005 17:41:51 -0500
Message-ID: <422F7BAF.5070201@industrialstrengthsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from lakermmtao07.cox.net ([68.230.240.32]:9092 "EHLO
	lakermmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262293AbVCIWbM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Mar 2005 17:31:12 -0500
Received: from [192.168.1.103] (really [68.10.24.17])
          by lakermmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050309223107.VWUY19214.lakermmtao07.cox.net@[192.168.1.103]>
          for <linux-ide@vger.kernel.org>; Wed, 9 Mar 2005 17:31:07 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Im using vanilla kernel.org 2.6.11, Ive got a Silicon Image 3112 on my 
abit mobo, im using it with two seagate sata 160gig drives.

However im getting this "applying seagate errata" in my dmesg and the 
performance is terrible.

I want to know what I need to do to solve this problem now, is this a 
bug in the drives or the controller card? Can anyone reccomend me a 
proper 2-4 port sata card that is well supported?

Im definatly willing to help in whatever tangental way I can to help fix 
the software problem, however I do need this to work properly, currently 
Bit torrent will drop out every once in a while with "data corrupted on 
disk"


Thanks SO MUCH!

David




bash-3.00# hdparm -Tt /dev/sda1

/dev/sda1:
Timing cached reads: 1188 MB in 2.00 seconds = 592.61 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate 
ioctl for device
Timing buffered disk reads: 38 MB in 3.07 seconds = 12.37 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate 
ioctl for device


bash-3.00# hdparm -Tt /dev/sda2

/dev/sda2:
Timing cached reads: 1196 MB in 2.00 seconds = 597.79 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate 
ioctl for device
Timing buffered disk reads: 44 MB in 3.08 seconds = 14.27 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate 
ioctl for device
bash-3.00#

01:0b.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 
SATARaid Controller (rev 02)
        Subsystem: CMD Technology Inc: Unknown device 6112
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
        I/O ports at c800 [size=8]
        I/O ports at cc00 [size=4]
        I/O ports at d000 [size=8]
        I/O ports at d400 [size=4]
        I/O ports at d800 [size=16]
        Memory at e3000000 (32-bit, non-prefetchable) [size=512]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

libata version 1.10 loaded.
sata_sil version 0.8
ata1: SATA max UDMA/100 cmd 0xE0826080 ctl 0xE082608A bmdma 0xE0826000 
irq 11
ata2: SATA max UDMA/100 cmd 0xE08260C0 ctl 0xE08260CA bmdma 0xE0826008 
irq 11
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata1(0): applying Seagate errata fix
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
88:207f
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
Vendor: ATA Model: ST3160023AS Rev: 3.18
Type: Direct-Access ANSI SCSI revision: 05
Vendor: ATA Model: ST3160827AS Rev: 3.00
Type: Direct-Access ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0, type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0, type 0


