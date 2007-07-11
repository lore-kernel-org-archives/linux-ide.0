From: Peter Favrholdt <linux-ide@how.dk>
Subject: sata_promise TX4 "intermittent problems" still in 2.6.22
Date: Wed, 11 Jul 2007 18:30:57 +0200
Message-ID: <469505C1.5000504@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:57847 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbXGKQbD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 12:31:03 -0400
Received: from how3.how.dk (0x50a32a37.unknown.tele.dk [80.163.42.55])
	by pfepb.post.tele.dk (Postfix) with ESMTP id 3CF2DA50004
	for <linux-ide@vger.kernel.org>; Wed, 11 Jul 2007 18:30:58 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by how3.how.dk with esmtp (Exim 4.50)
	id 1I8f5f-0005HI-SN
	for linux-ide@vger.kernel.org; Wed, 11 Jul 2007 18:30:59 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Just testet 2.6.22 on my setup. Unfortunately the problem is still there.

Interesting part of dmesg:

[   33.036786] sata_promise 0000:01:08.0: applying SATAII TX4 port 
numbering workaround
[   33.036926] scsi0 : sata_promise
[   33.037032] scsi1 : sata_promise
[   33.037125] scsi2 : sata_promise
[   33.037221] scsi3 : sata_promise
[   33.037303] ata1: SATA max UDMA/133 cmd 0xe0814380 ctl 0xe08143b8 
bmdma 0x00000000 irq 11
[   33.037363] ata2: SATA max UDMA/133 cmd 0xe0814280 ctl 0xe08142b8 
bmdma 0x00000000 irq 11
[   33.037422] ata3: SATA max UDMA/133 cmd 0xe0814200 ctl 0xe0814238 
bmdma 0x00000000 irq 11
[   33.037481] ata4: SATA max UDMA/133 cmd 0xe0814300 ctl 0xe0814338 
bmdma 0x00000000 irq 11
[   33.504834] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   33.561725] ata1.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   33.561774] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   33.653311] ata1.00: configured for UDMA/133
[   34.120556] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   34.176731] ata2.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   34.176779] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   34.268312] ata2.00: configured for UDMA/133
[   34.732282] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   34.787158] ata3.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   34.787206] ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   34.870410] ata3.00: configured for UDMA/133
[   35.336011] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   35.389438] ata4.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   35.389486] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   35.472698] ata4.00: configured for UDMA/133
[   35.472822] scsi 0:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[   35.472966] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[   35.473028] sd 0:0:0:0: [sda] Write Protect is off
[   35.473089] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   35.473192] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[   35.473248] sd 0:0:0:0: [sda] Write Protect is off
[   35.473308] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   35.473368]  sda: unknown partition table
[   35.491503] sd 0:0:0:0: [sda] Attached SCSI disk
[   35.491604] sd 0:0:0:0: Attached scsi generic sg0 type 0

[ 3993.963562] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x2 frozen
[ 3993.963576] ata1.00: cmd c8/00:00:00:15:4c/00:00:00:00:00/ec tag 0 
cdb 0x0 data 131072 in
[ 3993.963579]          res 40/00:01:09:4f:c2/00:00:00:00:00/00 Emask 
0x4 (timeout)
[ 3999.312950] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 4004.014836] ata1: device not ready (errno=-16), forcing hardreset
[ 4004.014845] ata1: hard resetting port
[ 4009.528375] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 4014.062329] ata1: COMRESET failed (errno=-16)
[ 4014.062338] ata1: hard resetting port
[ 4019.575900] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 4024.109824] ata1: COMRESET failed (errno=-16)
[ 4024.109833] ata1: hard resetting port
[ 4029.623411] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 4059.122095] ata1: COMRESET failed (errno=-16)
[ 4059.122108] ata1: limiting SATA link speed to 1.5 Gbps
[ 4059.122111] ata1: hard resetting port
[ 4064.131863] ata1: COMRESET failed (errno=-16)
[ 4064.131872] ata1: reset failed, giving up
[ 4064.131875] ata1.00: disabled
[ 4064.131891] ata1: EH complete
[ 4064.132621] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 4064.132628] end_request: I/O error, dev sda, sector 206312704
[ 4064.132632] Buffer I/O error on device sda, logical block 25789088
