From: Vegard Lima <vegard.lima@uia.no>
Subject: 2.6.23-rc6: pata_ali cdrom doesn't work
Date: Thu, 13 Sep 2007 17:03:58 +0200
Message-ID: <46E9515E.2060808@hia.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pat.hia.no ([158.36.80.149]:57465 "EHLO pat.hia.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755473AbXIMPgn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Sep 2007 11:36:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org

Hi,

same laptop that had trouble with the Fedroa 7 test kernels:
   https://bugzilla.redhat.com/show_bug.cgi?id=227207

Timeout messages below appear during boot and mounting
a cd times out and fails. Full dmesg output at:
   http://www.math.missouri.edu/~lima/2.6.23-rc6-dmesg.txt

Is this a known bug?

scsi0 : pata_ali
scsi1 : pata_ali
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x00012480 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x00012488 irq 15
ata1.00: ATA-5: IC25N030ATCS04-0, CA3OA71A, max UDMA/100
ata1.00: 58605120 sectors, multi 16: LBA
ata1.00: limited to UDMA/33 due to 40-wire cable
ata1.00: configured for UDMA/33
ata2.00: ATAPI: SONY    CD-RW  CRX800E, 1.1d, max MWDMA2
ata2.00: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      IC25N030ATCS04-0 CA3O PQ: 0 ANSI: 5
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 96 in
          res 40/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata2: soft resetting port
ata2.00: configured for MWDMA2
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 96 in
          res 40/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata2: soft resetting port
ata2.00: configured for MWDMA2
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 96 in
          res 40/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata2: soft resetting port
ata2.00: configured for MWDMA2
ata2: EH complete
ata2.00: limiting speed to MWDMA1:PIO4
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 96 in
          res 40/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata2: soft resetting port
ata2.00: configured for MWDMA1
ata2: EH complete
scsi scan: 96 byte inquiry failed.  Consider BLIST_INQUIRY_36 for this device
scsi 1:0:0:0: CD-ROM            SONY     CD-RW  CRX800E   1.1d PQ: 0 ANSI: 5


Thanks,
-- 
Vegard Lima
