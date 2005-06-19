From: Yuri Kirsanov <flash@rccb.ru>
Subject: TX4000 RAID and sata_promise
Date: Sun, 19 Jun 2005 16:20:36 +0400
Message-ID: <16214721156.20050619162036@rccb.ru>
Reply-To: Yuri Kirsanov <flash@rccb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.85.106.100] ([213.85.106.100]:56252 "EHLO rccb.ru")
	by vger.kernel.org with ESMTP id S932505AbVHNMUD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Aug 2005 08:20:03 -0400
Received: from 80.249.155.6 (account flash [80.249.155.6] verified)
  by rccb.ru (CommuniGate Pro SMTP 4.2.8)
  with ESMTP id 941283 for linux-ide@vger.kernel.org; Sun, 14 Aug 2005 12:20:35 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

TX4000 RAID and sata_promise.

Good day. I have Mandrake Linux LE2005 with custom kernel
2.6.12.2+Reiser4 patch+TX4000 patch
(First part of this patch http://www.mail-archive.com/linux-ide@vger.kernel.org/msg00150.html
second part failed and I can't figure out how to apply it). When i do
'modprobe sata_promise' it only says:

Aug 14 19:24:21 mandr kernel: libata version 1.11 loaded.
Aug 14 19:24:21 mandr kernel: sata_promise version 1.01
Aug 14 19:24:21 mandr kernel: PCI: Found IRQ 9 for device 0000:01:09.0
Aug 14 19:24:21 mandr kernel: ata1: PATA max UDMA/133 cmd 0xC89FE200 ctl 0xC89FE238 bmdma 0x0 irq 9
Aug 14 19:24:21 mandr kernel: ata2: PATA max UDMA/133 cmd 0xC89FE280 ctl 0xC89FE2B8 bmdma 0x0 irq 9
Aug 14 19:24:21 mandr kernel: ata3: PATA max UDMA/133 cmd 0xC89FE300 ctl 0xC89FE338 bmdma 0x0 irq 9
Aug 14 19:24:21 mandr kernel: ata4: PATA max UDMA/133 cmd 0xC89FE380 ctl 0xC89FE3B8 bmdma 0x0 irq 9
Aug 14 19:24:21 mandr kernel: ata1: no device found (phy stat 00000000)
Aug 14 19:24:21 mandr kernel: scsi0 : sata_promise
Aug 14 19:24:21 mandr kernel: ata2: no device found (phy stat 00000000)
Aug 14 19:24:21 mandr kernel: scsi1 : sata_promise
Aug 14 19:24:21 mandr kernel: ata3: no device found (phy stat 00000000)
Aug 14 19:24:21 mandr kernel: scsi2 : sata_promise
Aug 14 19:24:22 mandr kernel: ata4: no device found (phy stat 00000000)
Aug 14 19:24:22 mandr kernel: scsi3 : sata_promise

I have 2 hard drives connected to TX4000 on IDE1 channel, in stripe
mode. I've set up raid in TX4000 BIOS, but in Linux it can't see my
hard disks, and so I have no /dev/sd* and can't mount this hard
disks...Could you please help me, what am I doing wrong?
I've already tried to install sata_promise both as a module and as a
built-in...I've tried to do 'modprobe sd_mod' first, it only says
'SCSI system initialized'. I'm completely stuck with it :(

PS. I have ASUS i815 CUSL2-M motherboard.

