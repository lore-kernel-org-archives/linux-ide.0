From: Yuri Kirsanov <flash@rccb.ru>
Subject: TX4000 RAID and sata_promise
Date: Sun, 28 Aug 2005 18:46:30 +0400
Message-ID: <19927573359.20050828184630@rccb.ru>
Reply-To: Yuri Kirsanov <flash@rccb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.85.106.102] ([213.85.106.102]:4745 "EHLO rccb.ru")
	by vger.kernel.org with ESMTP id S1751178AbVH1OqX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Aug 2005 10:46:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Look's like I've found solution. I've checked libata_core.c and found
following strings in it (line 1427):

      if (sata_dev_present(ap))
        ata_port_probe(ap);
      else {
                sstatus = scr_read(ap, SCR_STATUS);
                printk(KERN_INFO "ata%u: no device found (phy stat %08x)\n",
                       ap->id, sstatus);
                ata_port_disable(ap);
        }

For experiment, I made following changes:

//      if (sata_dev_present(ap))
        ata_port_probe(ap);
/*      else {
                sstatus = scr_read(ap, SCR_STATUS);
                printk(KERN_INFO "ata%u: no device found (phy stat %08x)\n",
                       ap->id, sstatus);
                ata_port_disable(ap);
        }
*/

So, now it's always do port-probe, and here is the result:

libata version 1.12 loaded.
sata_promise version 1.02
PCI: Found IRQ 9 for device 0000:01:0a.0
ata1: PATA max UDMA/133 cmd 0xCC81C200 ctl 0xCC81C238 bmdma 0x0 irq 9
ata2: PATA max UDMA/133 cmd 0xCC81C280 ctl 0xCC81C2B8 bmdma 0x0 irq 9
ata3: PATA max UDMA/133 cmd 0xCC81C300 ctl 0xCC81C338 bmdma 0x0 irq 9
ata4: PATA max UDMA/133 cmd 0xCC81C380 ctl 0xCC81C3B8 bmdma 0x0 irq 9
ATA: abnormal status 0x8 on port 0xCC81C21C
ata1: disabling port
scsi0 : sata_promise
ata2: dev 0 cfg 49:0b00 82:346b 83:4208 84:4000 85:3461 86:0000 87:4000 88:101f
ata2: dev 0 ATA, max UDMA/66, 17840592 sectors:
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/66
scsi1 : sata_promise
ATA: abnormal status 0x8 on port 0xCC81C31C
ata3: disabling port
scsi2 : sata_promise
ATA: abnormal status 0x8 on port 0xCC81C39C
ata4: disabling port
scsi3 : sata_promise
  Vendor: ATA       Model: FUJITSU MPF3102A  Rev: 5C18
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 17840592 512-byte hdwr sectors (9134 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 17840592 512-byte hdwr sectors (9134 MB)
SCSI device sda: drive cache: write back
 sda:<4>ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x84 { DriveStatusError BadCRC }
 sda1
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0

As you can see, my device is found ok, I was able to format it and
mount it. Seek errors may be because of bad disk state, I'm trying to
make some checks on it. I understand, that I made really incorrect
commenting out, but maybe now somebody will be able to make this
driver work correctly with an PATA devices?

