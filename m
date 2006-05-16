From: "Raphael Bossek" <raphael.bossek@gmx.de>
Subject: How to debug CompactFlash card fails on PATA port of an SATA
 controller ?
Date: Tue, 16 May 2006 10:11:21 +0200
Message-ID: <20060516081121.78840@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:22760 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751671AbWEPILX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 04:11:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I get the PATA interface of my Promise PDC40775 (SATA 300 TX2plus) working.
But now I run into trouble while connecting a SimpleTech CompactFlash card
SLCF512J2U-F (512MB). This are are the messages from log:

sata_promise 0000:00:0a.0: version 1.04
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 217       
sata_promise PATA port found
ata9: SATA max UDMA/133 cmd 0xBE9D0200 ctl 0xBE9D0238 bmdma 0x0 irq 217
ata10: SATA max UDMA/133 cmd 0xBE9D0280 ctl 0xBE9D02B8 bmdma 0x0 irq 217
sata_promiseDisabling SATA for third port
ata11: PATA max UDMA/133 cmd 0xBE9D0300 ctl 0xBE9D0338 bmdma 0x0 irq 217
ata9: SATA link down (SStatus 0)
scsi8 : sata_promise
ata10: SATA link down (SStatus 0)
scsi9 : sata_promise
ata11: dev 0 cfg 49:0300 82:7068 83:4004 84:4000 85:7068 86:0004 87:4000 88:0000
ata11: dev 0 ATA-0, max MWDMA2, 1000944 sectors: LBA
ata11: dev 0 configured for MWDMA2
scsi10 : sata_promise
  Vendor: ATA       Model: STI Flash 7.3.0   Rev: 06/1
  Type:   Direct-Access                      ANSI SCSI revision: 05 
SCSI device sdb: 1000944 512-byte hdwr sectors (512 MB) 
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 1000944 512-byte hdwr sectors (512 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb:<3>ata11: command timeout
ata11: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata11: status=0xff { Busy }
sd 10:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0xfffffff
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
ata11: command timeout
ata11: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata11: status=0xff { Busy }
sd 10:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0xfffffff
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
 unable to read partition table
sd 10:0:0:0: Attached scsi disk sdb

How can I identify the real problem for this device ?

--
Raphael Bossek
-- 


Bis zu 70% Ihrer Onlinekosten sparen: GMX SmartSurfer!
      Kostenlos downloaden: http://www.gmx.net/de/go/smartsurfer
    
