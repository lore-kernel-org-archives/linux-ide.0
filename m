From: Andi Kleen <ak@suse.de>
Subject: More information on ATI IXP failure in git9
Date: Sun, 25 Jun 2006 23:59:27 +0200
Message-ID: <200606252359.27671.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:44209 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932368AbWFYV7e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jun 2006 17:59:34 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com


The system uses sata_sil with

00:11.0 IDE interface: ATI Technologies Inc ATI 437A Serial ATA Controller
00:12.0 IDE interface: ATI Technologies Inc ATI 4379 Serial ATA Controller

I added some printks and it fails here:


static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
{
        struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
        u8 status;

        if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
                u32 serror;


                 ...
          
                <------ hits two times, 
               goto freeze;


Appended a successfull boot from 2.6.16.


libata version 1.20 loaded.
sata_sil 0000:00:11.0: version 0.9
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 23 (level, low) -> IRQ 201
ata1: SATA max UDMA/100 cmd 0xFFFFC20000012080 ctl 0xFFFFC2000001208A bmdma 0xFFFFC20000012000 irq 201
ata2: SATA max UDMA/100 cmd 0xFFFFC200000120C0 ctl 0xFFFFC200000120CA bmdma 0xFFFFC20000012008 irq 201
ata1: SATA link down (SStatus 0)
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 00:0040 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:40ff 93:0000
ata2: dev 0 ATA-7, max UDMA7, 488397168 sectors: LBA48
sata_get_dev_handle: SATA dev addr=0x110000, handle=0x0000000000000000
ata2: dev 0 configured for UDMA/100
sata_get_dev_handle: SATA dev addr=0x110000, handle=0x0000000000000000
scsi1 : sata_sil
  Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 177
ata3: SATA max UDMA/100 cmd 0xFFFFC20000014080 ctl 0xFFFFC2000001408A bmdma 0xFFFFC20000014000 irq 177
ata4: SATA max UDMA/100 cmd 0xFFFFC200000140C0 ctl 0xFFFFC200000140CA bmdma 0xFFFFC20000014008 irq 177
ata3: SATA link down (SStatus 0)
scsi2 : sata_sil
ata4: SATA link down (SStatus 0)
scsi3 : sata_sil
Driver 'sd' needs updating - please use bus_type methods
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 1:0:0:0: Attached scsi disk sda


-Andi
