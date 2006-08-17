From: Vlad Codrea <VladCodrea@mail.utexas.edu>
Subject: Libata in 2.6.18-rc4-mm1 doesn't recognize DVD-ROM drive
Date: Wed, 16 Aug 2006 23:11:29 -0500
Message-ID: <44E3EC71.1080200@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironman.mail.utexas.edu ([128.83.32.51]:48187 "EHLO
	ironman.mail.utexas.edu") by vger.kernel.org with ESMTP
	id S932393AbWHQDCm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Aug 2006 23:02:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,
 
Libata in 2.6.18-rc4-mm1 doesn't recognize my DVD-ROM drive, which is an 
ATAPI TORiSAN DVD-ROM DRD-N216. It's interesting that dmesg initially 
says "ata2: PATA max UDMA/33ata2: PATA max UDMA/33" even though the 
drive is only capable of Multiword DMA Mode 2 and PIO Mode 4 according 
to its specs ( 
http://support.dell.com/support/edocs/storage/tormargi/Specs.htm ).
 
Nevertheless, libata seems to find the correct mode later on: "ata2.00: 
ATAPI, max MWDMA2, CDB intr".
 
I've included the libata-related dmesg lines below. The full dmesg can 
be found at
 
http://bugzilla.kernel.org/attachment.cgi?id=8806
 
I'd be happy to provide any other information that may be helpful in 
debugging the problem.
 
Thank you,
-Vlad  


SCSI subsystem initialized
libata version 2.00 loaded.
ata_piix 0000:00:07.1: version 2.00ac6
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFCF0 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFCF8 irq 15
scsi0 : ata_piix
ata1.00: ATA-4, max UDMA/33, 12685680 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/33
scsi1 : ata_piix
ata2.00: ATAPI, max MWDMA2, CDB intr
ata2.00: configured for MWDMA2
scsi 0:0:0:0: Direct access     ATA      IBM-DADA-26480   AD6O PQ: 0 ANSI: 5
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x4)
ata2.00: tag 0 cmd 0xa0 Emask 0x2 stat 0x58 err 0x0 (HSM violation)
ata2: soft resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: soft resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
SCSI device sda: 12685680 512-byte hdwr sectors (6495 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 12685680 512-byte hdwr sectors (6495 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: soft resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled
ata2: EH complete
