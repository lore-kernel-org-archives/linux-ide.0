From: Sven Lemke <catnip@web.de>
Subject: sata_promise - another sata dvd writer problem
Date: Sun, 06 May 2007 16:35:11 +0200
Message-ID: <463DE79F.4070808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:53451 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbXEFOft (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 May 2007 10:35:49 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8F2B179809D7
	for <linux-ide@vger.kernel.org>; Sun,  6 May 2007 16:35:47 +0200 (CEST)
Received: from [88.76.53.185] (helo=[192.168.178.22])
	by smtp05.web.de with asmtp (WEB.DE 4.108 #197)
	id 1Hkhpy-0000io-00
	for linux-ide@vger.kernel.org; Sun, 06 May 2007 16:35:46 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi folks,

I'm using kernel 2.6.21-mm1 and get strange problems when connecting
my new SATA DVD writer to the TX2Plus Promise controller. It works
with an slightly older kernel version though. And since I couldn't figure
out who is responsible for the driver I decided to post my problem here.


dmesg reads:

sata_promise 0000:00:0b.0: version 2.05
...
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI, max UDMA/33
ata2.00: applying bridge limits
ata2.00: configured for UDMA/33
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM TSSTcorp CD/DVDW SH-S183L SB01 PQ: 0 ANSI: 5
...
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (port_status 0x20200000)
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
         res 40/00:02:00:60:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (port_status 0x20200000)
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
         res 40/00:02:00:60:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (port_status 0x20200000)
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
         res 40/00:02:00:60:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: limiting speed to UDMA/25:PIO4
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (port_status 0x20200000)
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
         res 40/00:02:00:60:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/25
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (port_status 0x20200000)
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
         res 40/00:02:00:60:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/25
ata2: EH complete
...
~

Then I have to disconnect the drive to continue booting.
I hope this can be fixed soon.

Thanks,
Sven
