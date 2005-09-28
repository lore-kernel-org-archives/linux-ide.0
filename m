From: Giulio Orsero <giulioo@gmail.com>
Subject: ata1: BUG: timeout without command
Date: Wed, 28 Sep 2005 11:39:03 +0200
Message-ID: <20050928093906.4D35612CBF@mail.golden.dom>
Reply-To: giulioo@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wnx-5a.seeweb.it ([212.25.170.113]:51402 "EHLO wnx-5a.seeweb.it")
	by vger.kernel.org with ESMTP id S1030236AbVI1Jjx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Sep 2005 05:39:53 -0400
Received: from mail.golden.dom (xs-213-255-43-90.to1.albacom.net [213.255.43.90] (may be forged))
	(authenticated bits=0)
	by wnx-5a.seeweb.it (8.12.3/8.12.3/Debian-7.1) with ESMTP id j8S9dlv5026752
	for <linux-ide@vger.kernel.org>; Wed, 28 Sep 2005 11:39:48 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

=== Summary: 
Errors
ata1: error occurred, port reset 
ata1: BUG: timeout without command
appeas on idle system.
Yesterday I had other problems detailed here:
http://marc.theaimsgroup.com/?l=linux-ide&m=112783255913496&w=2
then I switched the system to AHCI both in BIOS and using ahci instead of
ata_piix. The problems detailed in the yesterday's email all still there
with ahci (crash during rabuilding of md10); this morning I had the above
errors while the system was idle (no rebuilding of the md10 array).

=== software/hardware:
kernel: stock 2.4.32-rc1 (on a RHEL3 system)
Motherboard: Supermicro P8SC8 BIOS v1.1 
BIOS: SATA=enhanced mode  SATA_MODE=AHCI 
Intel(R) Pentium(R) 4 CPU 3.00GHz, 512MB RAM
hda=dvd (ide-scsi)
2 Seagate 120GB sata: sda sdb (using ata_piix)
md mirror raid1 on 8 partitions on the 2 disks:
        md1 md2 md5 md6 md7 md8 md9 md10
libata dmesg at the end of email
 
=== Notes:
- We intentionally stay with 2.4 because we value stability above
all, we understand you, as developers, would probably just say "upgrade to
latest 2.6.x", but this is not an option, really. We monitor various lists
and it's not that 2.6.x is the nirvana...
- We'd like to test new SATA code (to be copied over into the 2.4 tree) if
this would be useful in solving this problem.

Thanks

libata version 1.11 loaded.
ahci version 1.01
PCI: Setting latency timer of device 00:1f.2 to 64
ahci(00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci(00:1f.2) flags: 64bit ncq pm led slum part 
ata1: SATA max UDMA/133 cmd 0xE0031100 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xE0031180 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xE0031200 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xE0031280 ctl 0x0 bmdma 0x0 irq 19
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata2: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata2: dev 0 configured for UDMA/133
ata3: no device found (phy stat 00000000)
ata4: no device found (phy stat 00000000)
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
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
