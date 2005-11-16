From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: ata_piix PATA cdrom fails.
Date: Wed, 16 Nov 2005 22:02:11 +0000
Message-ID: <437BAC63.6010403@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:16647 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1030562AbVKPXB6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Nov 2005 18:01:58 -0500
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.42)
	id 1EcWBZ-000ID2-JF
	for linux-ide@vger.kernel.org; Wed, 16 Nov 2005 22:55:26 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Can anybody help me get my DVD-ROM recognized?
dmesg output below.
kernel 2.6.15-rc1
It seems to correctly recognize the PATA interface (ata1), but then 
fails to detect any devices there.


[    0.539597] libata version 1.12 loaded.
[    0.539641] ata_piix 0000:00:1f.2: version 1.04
[    0.539647] ata_piix 0000:00:1f.2: combined mode detected (p=0, s=1)
[    0.539708] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, 
low) -> IRQ 169
[    0.539810] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    0.539859] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 
irq 14
[    0.862097] ata1: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 
86:0000 87:0000 88:0407
[    0.862101] ata1: dev 0 ATAPI, max UDMA/33
[    1.033679] ata1: dev 1 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 
86:0000 87:0000 88:0407
[    1.033683] ata1: dev 1 ATAPI, max UDMA/33
[    1.033990] ata1: dev 0 configured for UDMA/33
[    1.034169] ata1: dev 1 configured for UDMA/33
[    1.034218] scsi0 : ata_piix
[    1.034458] ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 
irq 15
[    1.324988] ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 
86:3c01 87:4023 88:207f
[    1.324992] ata2: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
[    1.336960] ata2: dev 1 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 
86:3c01 87:4003 88:207f
[    1.336964] ata2: dev 1 ATA-6, max UDMA/133, 312581808 sectors: LBA48
[    1.337118] ata2: dev 0 configured for UDMA/133
[    1.337459] ata2: dev 1 configured for UDMA/133
[    1.337509] scsi1 : ata_piix
[    1.337672]   Vendor: ATA       Model: ST3300831AS       Rev: 3.01
[    1.338772]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[    1.339054]   Vendor: ATA       Model: ST3160023AS       Rev: 3.18
[    1.340153]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[    1.340417] sata_sil 0000:03:03.0: version 0.9
[    1.340433] ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 19 (level, 
low) -> IRQ 177
[    1.340578] ata3: SATA max UDMA/100 cmd 0xF880E080 ctl 0xF880E08A 
bmdma 0xF880E000 irq 177
[    1.340674] ata4: SATA max UDMA/100 cmd 0xF880E0C0 ctl 0xF880E0CA 
bmdma 0xF880E008 irq 177
[    1.544273] ata3: no device found (phy stat 00000000)
[    1.544331] scsi2 : sata_sil
[    1.751778] ata4: no device found (phy stat 00000000)
[    1.751836] scsi3 : sata_sil
[    1.752047] SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
[    1.752127] SCSI device sda: drive cache: write back
[    1.752257] SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
[    1.752335] SCSI device sda: drive cache: write back
[    1.752387]  sda: sda1 sda2 < sda5 sda6 sda7 >
[    1.805821] sd 1:0:0:0: Attached scsi disk sda
[    1.805914] SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
[    1.805992] SCSI device sdb: drive cache: write back
[    1.806118] SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
[    1.806197] SCSI device sdb: drive cache: write back
[    1.806247]  sdb: sdb1 sdb2 < sdb5 sdb6 >
[    1.834900] sd 1:0:1:0: Attached scsi disk sdb
[    1.835033] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    1.835826] sd 1:0:1:0: Attached scsi generic sg1 type 0
[    1.835954] ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
