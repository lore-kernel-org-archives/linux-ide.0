From: Andres Meyer <andres.meyer@computer.org>
Subject: Marvell SATA 5081 success
Date: Sun, 20 Nov 2005 14:18:14 +0100
Message-ID: <43807796.4090002@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout.hispeed.ch ([62.2.95.247]:51586 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1751204AbVKTOPL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Nov 2005 09:15:11 -0500
Received: from mail.cputoasters.com (84-73-58-247.dclient.hispeed.ch [84.73.58.247])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.6/8.12.6/taifun-1.0) with ESMTP id jAKEF9jr030872
	for <linux-ide@vger.kernel.org>; Sun, 20 Nov 2005 15:15:10 +0100
Received: from [IPv6:2001:960:75e:0:80d5:70aa:5ecf:bc68] (unknown [IPv6:2001:960:75e:0:80d5:70aa:5ecf:bc68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.cputoasters.com (Postfix) with ESMTP id 94B565CD264
	for <linux-ide@vger.kernel.org>; Sun, 20 Nov 2005 14:17:20 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Just wanted to confirm that my Highpoint 1820 (PCI-X)  works fine with 
2x300GB disks on  a dual Opteron, 2.6.15-rc2 x86_64 with 4GB RAM. I have 
been constantly compiling kernels and transferring files for 12h now 
without a problem.

Thx a lot,
Andres

lspci:
0000:02:04.0 SCSI storage controller: Marvell Technology Group Ltd. 
MV88SX5081 8-port SATA I PCI-X Controller

dmesg:
libata version 1.20 loaded.
sata_mv 0000:02:04.0: version 0.5
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 25 (level, low) -> IRQ 21
sata_mv 0000:02:04.0: 32 slots 8 ports SCSI mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003A2120 bmdma 0x0 irq 21
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003A4120 bmdma 0x0 irq 21
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003A6120 bmdma 0x0 irq 21
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003A8120 bmdma 0x0 irq 21
ata5: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003B2120 bmdma 0x0 irq 21
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003B4120 bmdma 0x0 irq 21
ata7: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003B6120 bmdma 0x0 irq 21
ata8: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003B8120 bmdma 0x0 irq 21
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 
88:207f
ata1: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_mv
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 
88:007f
ata2: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_mv
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
ata5: no device found (phy stat 00000000)
scsi4 : sata_mv
ata6: no device found (phy stat 00000000)
scsi5 : sata_mv
ata7: no device found (phy stat 00000000)
scsi6 : sata_mv
ata8: no device found (phy stat 00000000)
scsi7 : sata_mv
  Vendor: ATA       Model: ST3300831AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
  Vendor: ATA       Model: Maxtor 6L300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 < sdb5 >
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sda: drive cache: write back
 sda:
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sda: drive cache: write back
 sda:
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sda: drive cache: write back
 sda: sda1 < sda5 >
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sda: drive cache: write back
 sda: sda1 < sda5 >

