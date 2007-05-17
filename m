From: Theo Baumgartner <tbaumgartner@swissonline.ch>
Subject: sata_promise driver failed with Promise SATA300 TX4
Date: Thu, 17 May 2007 21:37:19 +0200
Message-ID: <200705172137.20013.tbaumgartner@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viefep13-int.chello.at ([213.46.255.15]:44925 "EHLO
	viefep24-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752040AbXEQThY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 15:37:24 -0400
Received: from 84-74-134-243.dclient.hispeed.ch ([84.74.134.243])
          by viefep24-int.chello.at
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20070517193721.LSRY1882.viefep24-int.chello.at@84-74-134-243.dclient.hispeed.ch>
          for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 21:37:21 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

Hello again

I've got again into trouble with my Promise Card using kernel 2.6.17.

Since about 2 weeks i have a trashed raid5  (and unfortunately no backup) to an unknown reason (i think 
sata powercables or sata_promise problems). As i was trying to figure out how i could rebuild my raid 
array issuing "mdadm --examine /dev/sd[abcd]1" i've got this:

irq 18: nobody cared (try booting with the "irqpoll" option)
 <c01269db> __report_bad_irq+0x2b/0x69  <c0126b96> note_interrupt+0x17d/0x1ab
 <c01265ba> handle_IRQ_event+0x23/0x4c  <c012664b> __do_IRQ+0x68/0x91
 <c0104571> do_IRQ+0x19/0x24  <c0102e12> common_interrupt+0x1a/0x20
 <c0101781> default_idle+0x2b/0x53  <c01017e4> cpu_idle+0x3b/0x50
 <c02fc5e7> start_kernel+0x267/0x269
handlers:
[<e08310ee>] (pdc_interrupt+0x0/0x19c [sata_promise])
Disabling IRQ #18
ata1: command timeout
ata1: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xff { Busy }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sda, sector 488391871
Buffer I/O error on device sda1, logical block 244195904
ata1: command timeout
ata1: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xff { Busy }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sda, sector 488391873
Buffer I/O error on device sda1, logical block 244195905
ata1: command timeout
ata1: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xff { Busy }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sda, sector 488391875
Buffer I/O error on device sda1, logical block 244195906

After that mdadm was hanging and no access to disks was possible.

Hope this helps someone trace the problem.

Best regards
Theo Baumgartner
