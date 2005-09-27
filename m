From: Giulio Orsero <giulioo@gmail.com>
Subject: ata_piix: "abnormal status 0xD0", but disks are OK
Date: Tue, 27 Sep 2005 16:46:30 +0200
Message-ID: <20050927144631.1FCDE1295C@mail.golden.dom>
Reply-To: giulioo@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wnx-5a.seeweb.it ([212.25.170.113]:35819 "EHLO wnx-5a.seeweb.it")
	by vger.kernel.org with ESMTP id S964929AbVI0Oql (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Sep 2005 10:46:41 -0400
Received: from mail.golden.dom (xs-213-255-43-90.to1.albacom.net [213.255.43.90] (may be forged))
	(authenticated bits=0)
	by wnx-5a.seeweb.it (8.12.3/8.12.3/Debian-7.1) with ESMTP id j8REkav5012784
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 16:46:39 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

=== Summary: 
sata ata_piix drivers claims hard disk is broken while there's high
probability it's not.

=== hardware:
kernel: stock 2.4.32-rc1 (on a RHEL3 system)
Motherboard: Supermicro P8SC8 BIOS v1.1 
BIOS: SATA=enhanced mode  SATA_MODE=IDE 
Intel(R) Pentium(R) 4 CPU 3.00GHz, 512MB RAM
hda=dvd (ide-scsi)
2 Seagate 120GB sata: sda sdb (using ata_piix)
md mirror raid1 on 8 partitions on the 2 disks:
        md1 md2 md5 md6 md7 md8 md9 md10
libata dmesg at the end of email
 
=== errors:
When resyncing the last md10 (40GB) partition I always get:
-----------
ata1: command 0x35 timeout, stat 0xd0 host_stat 0x21
ata1: status=0xd0 { Busy }
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
Current sd08:0a: sense key Aborted Command
Additional sense indicates Scsi parity error
 I/O error: dev 08:0a, sector 47993480    <----- This number always
different
ATA: abnormal status 0xD0 on port 0xE907
ATA: abnormal status 0xD0 on port 0xE907
ATA: abnormal status 0xD0 on port 0xE907
------------
md driver then kicks out sda10 partition.

=== Problems:
1) I checked both the hard disks with Seagate and IBM disk diagnostic
utilities
and they both say that both disks are fine (I always used advanced/complete
tests). Why does libata think othwewise?
2) memtest86 runs with no errors.
3) When the above problem occcurs the system is hosed. I would expect that
md
would kick out the sda10 partition and go on. (md driver of the very same
kernel
handles this condition ok with IDE disks, but has problems with SATA, so
I think the problem is in SATA and not md)

 
=== Notes:
- We intentionally stay with 2.4 because we value stability above
all, we understand you, as developers, would probably just say "upgrade to
latest 2.6.x", but this is not an option, really. We monitor various lists
and it's not that 2.6.x is the nirvana...
- We'd like to test new SATA code (to be copied over into the 2.4 tree) if
this would be useful in solving this problem.

Thanks

libata version 1.10 loaded.
ata_piix version 1.03
PCI: Setting latency timer of device 00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xE900 ctl 0xEA02 bmdma 0xED00 irq 19
ata2: SATA max UDMA/133 cmd 0xEB00 ctl 0xEC02 bmdma 0xED08 irq 19
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata2: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi0 : ata_piix
scsi1 : ata_piix
  Vendor: ATA       Model: ST3120827AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3120827AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 >
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
 sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 >
-- 
giulioo@pobox.com
