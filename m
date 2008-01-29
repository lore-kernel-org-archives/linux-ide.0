From: rgheck <rgheck@bobjweil.com>
Subject: ATA Problems: Back in the Land of the Unhappy Camper
Date: Tue, 29 Jan 2008 16:14:48 -0500
Message-ID: <479F9748.5010301@bobjweil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:57618
	"EHLO QMTA09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751865AbYA2VOu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 16:14:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>


Well, it looks as if my problems weren't solved after all. I took out a 
Plextor PX-W4012TA and re-installed me cherished Plextor PX-W1610A---the 
latter burns at 1X, which produces glorious sounding CDs. Anyway, with 
this change, my problems have re-appeared. See the dmesg excerpt below. 
The short version is:
    ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Now, at the end, I get:
    scsi scan: 96 byte inquiry failed.  Consider BLIST_INQUIRY_36 for 
this device
Is this worth trying? If so, how do I try it?

It's possible, I suppose, that there's something wrong with this old 
drive. I have another one, I believe, at work, so I'll bring it home and 
see if it does better. But I wasn't having these sorts of problems 
before upgrading to Fedora 8 and so libata, so I'm doubtful that's it.

Anyway, thanks to everyone here for their patience and willingness to help.

Richard

=====

pata_amd 0000:00:0d.0: version 0.3.10
PCI: Setting latency timer of device 0000:00:0d.0 to 64
scsi6 : pata_amd
scsi7 : pata_amd
ata7: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
ata8: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
ata7.00: ATAPI: PLEXTOR CD-R   PX-W1610A, 1.05, max MWDMA2
ata7.00: configured for MWDMA2
ata8: port disabled. ignoring.
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: cmd a0/01:00:00:60:00/00:00:00:00:00/a0 tag 0 dma 96 in
         cdb 12 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
         res 40/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata7.00: status: { DRDY }
ata7: soft resetting link
ata7.00: configured for MWDMA2
ata7: EH complete
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: cmd a0/01:00:00:60:00/00:00:00:00:00/a0 tag 0 dma 96 in
         cdb 12 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
         res 40/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata7.00: status: { DRDY }
ata7: soft resetting link
ata7.00: configured for MWDMA2
ata7: EH complete
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: cmd a0/01:00:00:60:00/00:00:00:00:00/a0 tag 0 dma 96 in
         cdb 12 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
         res 40/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata7.00: status: { DRDY }
ata7: soft resetting link
ata7.00: configured for MWDMA2
ata7: EH complete
ata7.00: limiting speed to MWDMA1:PIO4
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: cmd a0/01:00:00:60:00/00:00:00:00:00/a0 tag 0 dma 96 in
         cdb 12 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
         res 40/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata7.00: status: { DRDY }
ata7: soft resetting link
ata7.00: configured for MWDMA1
ata7: EH complete
scsi scan: 96 byte inquiry failed.  Consider BLIST_INQUIRY_36 for this 
device
scsi 6:0:0:0: CD-ROM            PLEXTOR  CD-R   PX-W1610A 1.05 PQ: 0 ANSI: 5

etc
etc

and then it just plain won't work, at least to write....

