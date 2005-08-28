From: Yuri Kirsanov <flash@rccb.ru>
Subject: TX4000 RAID and sata_promise
Date: Sun, 28 Aug 2005 17:33:10 +0400
Message-ID: <923172921.20050828173310@rccb.ru>
Reply-To: Yuri Kirsanov <flash@rccb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.85.106.102] ([213.85.106.102]:49807 "EHLO rccb.ru")
	by vger.kernel.org with ESMTP id S1750789AbVH1NdJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Aug 2005 09:33:09 -0400
Received: from 80.249.155.6 (account flash [80.249.155.6] verified)
  by rccb.ru (CommuniGate Pro SMTP 4.2.8)
  with ESMTP id 1029052 for linux-ide@vger.kernel.org; Sun, 28 Aug 2005 13:35:23 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Good day. I've tried latest kernel 2.6.13-rc7, TX4000 support seems to
be in sata_promise already. After startup I see following in dmesg:

libata version 1.12 loaded.
sata_promise version 1.02
PCI: Found IRQ 5 for device 0000:01:09.0
ata1: PATA max UDMA/133 cmd 0xCC81C200 ctl 0xCC81C238 bmdma 0x0 irq 5
ata2: PATA max UDMA/133 cmd 0xCC81C280 ctl 0xCC81C2B8 bmdma 0x0 irq 5
ata3: PATA max UDMA/133 cmd 0xCC81C300 ctl 0xCC81C338 bmdma 0x0 irq 5
ata4: PATA max UDMA/133 cmd 0xCC81C380 ctl 0xCC81C3B8 bmdma 0x0 irq 5
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise


Anybody has any ideas? As I can see, my TX4000 is found by
sata_promise, it even detects it's UDMA modes, but it still can't find
any of my hard drives, while TX4000 BIOS shows all of them ok.

Jeff, please, can you comment this situation???

