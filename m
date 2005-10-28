From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: sil3112 problems
Date: Fri, 28 Oct 2005 10:14:51 +1000
Message-ID: <43616D7B.30100@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ihug-mail.icp-qv1-irony1.iinet.net.au ([203.59.1.195]:36751
	"EHLO mail-ihug.icp-qv1-irony1.iinet.net.au") by vger.kernel.org
	with ESMTP id S965020AbVJ1APQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2005 20:15:16 -0400
Received: from [192.168.3.7] (e7.eyal.emu.id.au [192.168.3.7])
	by e4.eyal.emu.id.au (8.11.6/8.11.6) with ESMTP id j9S0Epo11769
	for <linux-ide@vger.kernel.org>; Fri, 28 Oct 2005 10:14:51 +1000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: list linux-ide <linux-ide@vger.kernel.org>

After putting aside the Promise TX4 and replacing it with a SIL3112 based
card, I now see the errors that others have reported:

	ata4: status=0x51 { DriveReady SeekComplete Error }
	ata4: error=0x04 { DriveStatusError }

I have two SATA disk on the mobo (never seen an error there) and two on
the SIL. Both ata3 and ata4 show these errors. I can provoke this by
simply running concurrent dd reads from the two disks. I get anything from
a few error in a second to no error for 10-15 seconds (rare). I get about
66MB/s read rate on each mobo disk, a bit less on the SIL card.

Once in a while it will log a CRCerror too. I tried a more powerful
power supply and replaced the cables with no improvement.

This is on 2.6.13.4. I had the same with 2.6.14-rc5 but went off it
because my i2c sensors failed to come up here (separate issue).

Reading the list I see no resolution, just conflicting comments (the
"works for me" or "not" kind).

Is there a clear answer? If this card is again useless then what is
a card that DOES work reliably. I just need dual SATA. I might as well
bought a new mobo by now...

All four disks are identical

ata3: SATA max UDMA/100 cmd 0xF8A94080 ctl 0xF8A9408A bmdma 0xF8A94000 irq 21
ata4: SATA max UDMA/100 cmd 0xF8A940C0 ctl 0xF8A940CA bmdma 0xF8A94008 irq 21
ata3: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata4: dev 0 configured for UDMA/100
scsi3 : sata_sil
  Vendor: ATA       Model: WDC WD3200JD-00K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
  Vendor: ATA       Model: WDC WD3200JD-00K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
