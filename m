From: Haroldo Gamal <haroldo.gamal@infolink.com.br>
Subject: sata_sil problems
Date: Tue, 31 Aug 2004 11:04:45 -0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4134857D.3090805@infolink.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.infolink.com.br ([200.187.64.6]:13842 "EHLO
	smtp.infolink.com.br") by vger.kernel.org with ESMTP
	id S268591AbUHaOEp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Aug 2004 10:04:45 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Marcelo Ramos <mramos@infolink.com.br>

Hi Jeff,

I am using a IC7-MAX3 with SIL-3114 and I am having problems like this:

Aug 30 03:42:45 backup01 kernel: ata6: command 0x35 timeout, stat 0xd8 
host_stat 0x1
Aug 30 03:42:45 backup01 kernel: scsi7: ERROR on channel 0, id 0, lun 0, 
CDB: Write (10) 00 04 41 11 57 00 04 00 00
Aug 30 03:42:45 backup01 kernel: Current sde: sense key Medium Error
Aug 30 03:42:45 backup01 kernel: Additional sense: Write error - auto 
reallocation failed
Aug 30 03:42:45 backup01 kernel: end_request: I/O error, dev sde, sector 
71373143
Aug 30 03:42:45 backup01 kernel: ATA: abnormal status 0xD8 on port 
0x4283B2C7
Aug 30 03:42:45 backup01 last message repeated 2 times

Almost time, the error hangs the machine. I've searched for an answer 
with no luck, including to compile the sata_sil as non module too.

Do you known any procedure or workaround to fix the problem?

More information comes at the end of this e-mail.

I thank you in advance,

Haroldo Gamal
haroldo.gamal@infolink.com.br <mailto:haroldo.gamal@infolink.com.br>

Aug 27 17:24:30 backup01 kernel: sata_sil version 0.54
Aug 27 17:24:30 backup01 kernel: ACPI: PCI interrupt 0000:03:03.0[A] -> 
GSI 10 (level, low) -> IRQ 10
Aug 27 17:24:30 backup01 kernel: ata3: SATA max UDMA/100 cmd 0x4283B080 
ctl 0x4283B08A bmdma 0x4283B000 irq 10
Aug 27 17:24:30 backup01 kernel: ata4: SATA max UDMA/100 cmd 0x4283B0C0 
ctl 0x4283B0CA bmdma 0x4283B008 irq 10
Aug 27 17:24:30 backup01 kernel: ata5: SATA max UDMA/100 cmd 0x4283B280 
ctl 0x4283B28A bmdma 0x4283B200 irq 10
Aug 27 17:24:30 backup01 kernel: ata6: SATA max UDMA/100 cmd 0x4283B2C0 
ctl 0x4283B2CA bmdma 0x4283B208 irq 10
Aug 27 17:24:30 backup01 kernel: ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 
84:4003 85:3469 86:3c01 87:4003 88:207f
Aug 27 17:24:30 backup01 kernel: ata3: dev 0 ATA, max UDMA/133, 
390721968 sectors: lba48
Aug 27 17:24:30 backup01 kernel: ata3: dev 0 configured for UDMA/100
Aug 27 17:24:30 backup01 kernel: scsi4 : sata_sil
Aug 27 17:24:30 backup01 kernel: ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 
84:4003 85:3469 86:3c01 87:4003 88:207f
Aug 27 17:24:30 backup01 kernel: ata4: dev 0 ATA, max UDMA/133, 
390721968 sectors: lba48
Aug 27 17:24:30 backup01 kernel: ata4: dev 0 configured for UDMA/100
Aug 27 17:24:30 backup01 kernel: scsi5 : sata_sil
Aug 27 17:24:30 backup01 kernel: ata5: dev 0 cfg 49:2f00 82:346b 83:7d01 
84:4003 85:3469 86:3c01 87:4003 88:207f
Aug 27 17:24:30 backup01 kernel: ata5: dev 0 ATA, max UDMA/133, 
390721968 sectors: lba48
Aug 27 17:24:30 backup01 kernel: ata5: dev 0 configured for UDMA/100
Aug 27 17:24:30 backup01 kernel: scsi6 : sata_sil
Aug 27 17:24:30 backup01 kernel: ata6: dev 0 cfg 49:2f00 82:346b 83:7d01 
84:4003 85:3469 86:3c01 87:4003 88:207f
Aug 27 17:24:30 backup01 kernel: ata6: dev 0 ATA, max UDMA/133, 
390721968 sectors: lba48
Aug 27 17:24:30 backup01 kernel: ata6: dev 0 configured for UDMA/100
Aug 27 17:24:30 backup01 kernel: scsi7 : sata_sil
Aug 27 17:24:30 backup01 kernel: Vendor: ATA Model: ST3200822AS Rev: 3.01
Aug 27 17:24:30 backup01 kernel: Type: Direct-Access ANSI SCSI revision: 05
Aug 27 17:24:30 backup01 kernel: Vendor: ATA Model: ST3200822AS Rev: 3.01
Aug 27 17:24:30 backup01 kernel: Type: Direct-Access ANSI SCSI revision: 05
Aug 27 17:24:30 backup01 kernel: Vendor: ATA Model: ST3200822AS Rev: 3.01
Aug 27 17:24:30 backup01 kernel: Type: Direct-Access ANSI SCSI revision: 05
Aug 27 17:24:30 backup01 kernel: Vendor: ATA Model: ST3200822AS Rev: 3.01
Aug 27 17:24:30 backup01 kernel: Type: Direct-Access ANSI SCSI revision: 05
Aug 27 17:24:30 backup01 kernel: SCSI device sda: 390721968 512-byte 
hdwr sectors (200050 MB)
Aug 27 17:24:30 backup01 kernel: SCSI device sda: drive cache: write back
Aug 27 17:24:30 backup01 kernel: sda: sda1
Aug 27 17:24:30 backup01 kernel: Attached scsi disk sda at scsi2, 
channel 0, id 0, lun 0
Aug 27 17:24:30 backup01 kernel: SCSI device sdb: 390721968 512-byte 
hdwr sectors (200050 MB)
Aug 27 17:24:30 backup01 kernel: SCSI device sdb: drive cache: write back
Aug 27 17:24:30 backup01 kernel: sdb: sdb1
Aug 27 17:24:30 backup01 kernel: Attached scsi disk sdb at scsi4, 
channel 0, id 0, lun 0
Aug 27 17:24:30 backup01 kernel: SCSI device sdc: 390721968 512-byte 
hdwr sectors (200050 MB)
Aug 27 17:24:30 backup01 kernel: SCSI device sdc: drive cache: write back
Aug 27 17:24:30 backup01 kernel: sdc: sdc1
Aug 27 17:24:30 backup01 kernel: Attached scsi disk sdc at scsi5, 
channel 0, id 0, lun 0
Aug 27 17:24:30 backup01 kernel: SCSI device sdd: 390721968 512-byte 
hdwr sectors (200050 MB)
Aug 27 17:24:30 backup01 kernel: SCSI device sdd: drive cache: write back
Aug 27 17:24:30 backup01 kernel: sdd: sdd1
Aug 27 17:24:30 backup01 kernel: Attached scsi disk sdd at scsi6, 
channel 0, id 0, lun 0
