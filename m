From: Jarno Paananen <jpaana@s2.org>
Subject: Re: Promise 579 with current(?) libata in libata-dev-2.6 queue
Date: Mon, 25 Oct 2004 20:56:00 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <m3d5z6iswf.fsf@kalahari.s2.org>
References: <m3sm8ljkco.fsf@kalahari.s2.org> <417023B6.9070900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.org ([195.197.64.39]:919 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id S261239AbUJYR4E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Oct 2004 13:56:04 -0400
In-Reply-To: <417023B6.9070900@pobox.com> (Jeff Garzik's message of "Fri, 15
 Oct 2004 15:23:34 -0400")
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi again,

also the PATA port seems to work fine:

libata version 1.02 loaded.
sata_promise version 1.00
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 169
sata_promise PATA port found
ata1: SATA max UDMA/133 cmd 0xF8812200 ctl 0xF8812238 bmdma 0x0 irq 169
ata2: SATA max UDMA/133 cmd 0xF8812280 ctl 0xF88122B8 bmdma 0x0 irq 169
ata3: PATA max UDMA/133 cmd 0xF8812300 ctl 0xF8812338 bmdma 0x0 irq 169
ata1: dev 0 cfg 49:2f00 82:7c69 83:4f09 84:4003 85:7c69 86:0e01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors: lba48
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi1 : sata_promise
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:203f
ata2: dev 0 ATA, max UDMA/100, 312581808 sectors: lba48
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/100
scsi2 : sata_promise
ata3: dev 0 cfg 49:2f00 82:7c69 83:4309 84:4000 85:7c69 86:0201 87:4000 88:203f
ata3: dev 0 ATA, max UDMA/100, 160086528 sectors:
ata3: dev 0 configured for UDMA/100
scsi3 : sata_promise
  Vendor: ATA       Model: Maxtor 4G120J6    Rev: GAK8
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SV1604N   Rev: TR10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 98196H8    Rev: ZAH8
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 71833096 512-byte hdwr sectors (36779 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 < sdb5 sdb6 sdb7 >
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 < sdc5 >
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
SCSI device sdd: 160086528 512-byte hdwr sectors (81964 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 < sdd5 sdd6 sdd7 >
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0


// Jarno
