From: Brad Campbell <brad@wasp.net.au>
Subject: libata 2.6.9-rc1 further info
Date: Thu, 26 Aug 2004 15:36:36 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <412DCB44.2010805@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:41603 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268767AbUHZLf5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Aug 2004 07:35:57 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Why do I get all the pathalogical cases?

This is 2.6.9-rc1. Two genuine Maxtor Maxline-II SATA drives on the last 2 ports. If the first cards 
are unpopulated this is what happens at boot time.

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: Host Protected Area detected.
         current capacity is 78159151 sectors (40017 MB)
         native  capacity is 78165360 sectors (40020 MB)
hda: 78159151 sectors (40017 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
ata1: SATA max UDMA/133 cmd 0xE080B200 ctl 0xE080B238 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xE080B280 ctl 0xE080B2B8 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xE080B300 ctl 0xE080B338 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xE080B380 ctl 0xE080B3B8 bmdma 0x0 irq 19
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
ata5: SATA max UDMA/133 cmd 0xE080D200 ctl 0xE080D238 bmdma 0x0 irq 17
ata6: SATA max UDMA/133 cmd 0xE080D280 ctl 0xE080D2B8 bmdma 0x0 irq 17
ata7: SATA max UDMA/133 cmd 0xE080D300 ctl 0xE080D338 bmdma 0x0 irq 17
ata8: SATA max UDMA/133 cmd 0xE080D380 ctl 0xE080D3B8 bmdma 0x0 irq 17
ata5: no device found (phy stat 00000000)
scsi4 : sata_promise
ata6: no device found (phy stat 00000000)
scsi5 : sata_promise
ata7: no device found (phy stat 00000000)
scsi6 : sata_promise
ata8: no device found (phy stat 00000000)
scsi7 : sata_promise
ata9: SATA max UDMA/133 cmd 0xE080F200 ctl 0xE080F238 bmdma 0x0 irq 18
ata10: SATA max UDMA/133 cmd 0xE080F280 ctl 0xE080F2B8 bmdma 0x0 irq 18
ata11: SATA max UDMA/133 cmd 0xE080F300 ctl 0xE080F338 bmdma 0x0 irq 18
ata12: SATA max UDMA/133 cmd 0xE080F380 ctl 0xE080F3B8 bmdma 0x0 irq 18
ata9: no device found (phy stat 00000000)
scsi8 : sata_promise
ata10: no device found (phy stat 00000000)
scsi9 : sata_promise
ata11: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata11: dev 0 configured for UDMA/133
scsi10 : sata_promise
ata12: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata12: dev 0 configured for UDMA/133
scsi11 : sata_promise
   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
sata_via(0000:00:0f.0): routed to hard irq line 6
ata13: SATA max UDMA/133 cmd 0x8800 ctl 0x8402 bmdma 0x7400 irq 20
ata14: SATA max UDMA/133 cmd 0x8000 ctl 0x7802 bmdma 0x7408 irq 20
ata13: no device found (phy stat 00000000)
scsi12 : sata_via
ata14: no device found (phy stat 00000000)
scsi13 : sata_via
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
  /dev/scsi/host10/bus0/target0/lun0:<3>ata11: DMA timeout

Now I note when booting up, none of the Promise card bioses detect these drives either, so I can 
only speculate that the cards are not being set up correctly before Linux takes possession of them.

On another note, the genuine Maxtor drives do not exhibit the problems on the VIA controller (They 
are slow though at less than 20MB/s transfer rate).

So something after 2.6.6 broke ATA drives using a SIL3611CT80 interface board to a SATA controller.

Where to now batman?

Regards,
Brad
