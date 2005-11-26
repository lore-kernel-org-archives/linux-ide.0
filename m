From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: cpu consumption
Date: Sat, 26 Nov 2005 05:45:24 -0800
Message-ID: <5d96567b0511260545j61970a01j3b5c435766a51a6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:16174 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964769AbVKZNpZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Nov 2005 08:45:25 -0500
Received: by wproxy.gmail.com with SMTP id 70so1422235wra
        for <linux-ide@vger.kernel.org>; Sat, 26 Nov 2005 05:45:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello Jeff.
Here is my problem.

When I issue a READ operation over a SATA disk in linux i have
huge cpu consumption , about 90% cpu usage.

I am using MAXTOR disks in a supermicro machine.
the cpu test was made when i "raw read" from the DISK using DIRECT_IO.

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

this is my dmesg.
ata1: SATA max UDMA/133 cmd 0xE900 ctl 0xEA02 bmdma 0xED00 irq 10
ata2: SATA max UDMA/133 cmd 0xEB00 ctl 0xEC02 bmdma 0xED08 irq 10
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:207f
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:207f
ata2: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 7L250S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7L250S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host1/bus0/target0/lun0:
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


Thank you.
--
Raz
