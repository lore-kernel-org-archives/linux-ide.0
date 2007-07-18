From: Pavel Mateja <pavel@netsafe.cz>
Subject: ALi SATA problem
Date: Wed, 18 Jul 2007 11:17:40 +0200
Message-ID: <200707181117.41129.pavel@netsafe.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.netsafe.cz ([213.29.17.218]:34656 "HELO netsafe.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1762965AbXGRJYY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jul 2007 05:24:24 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,
I got some strange problem with my ULi M5288 SATA. I have one disk connected 
to 1st port. Dmesg says:

ahci 0000:00:16.1: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl IDE mode
ahci 0000:00:16.1: flags: ncq ilck pm led clopmp pio slum part
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc20000028500 ctl 0x0000000000000000 bmdma 
0x0000000000000000 irq 21
ata2: SATA max UDMA/133 cmd 0xffffc20000028580 ctl 0x0000000000000000 bmdma 
0x0000000000000000 irq 21
ata3: SATA max UDMA/133 cmd 0xffffc20000028600 ctl 0x0000000000000000 bmdma 
0x0000000000000000 irq 21
ata4: SATA max UDMA/133 cmd 0xffffc20000028680 ctl 0x0000000000000000 bmdma 
0x0000000000000000 irq 21
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6: WDC WD360GD-00FLC0, 33.08F33,max UDMA/133
ata1.00: 72303840 sectors, multi 16: LBA48
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)

This is true, but shortly after boot my dmesg log gets flooded by

ata4: soft resetting port
ata4: SATA link down (SStatus 1 SControl 300)
ata4: EH complete
ata2: soft resetting port
ata2: SATA link down (SStatus 1 SControl 300)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
ata2: (irq_stat 0x00000040, connection status changed)
ata4: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
ata4: (irq_stat 0x00000040, connection status changed)
ata2: soft resetting port
ata2: SATA link down (SStatus 1 SControl 300)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
ata2: (irq_stat 0x00000040, connection status changed)

and scsi_eh_1 and/or scsi_eh_3 processes came to D state for a while.

I can provide any additional info upon request. Kernel is 2.6.22.1 with 
suspend2 patch but vanilla is doing same thing.
Had anybody seen such thing?
-- 
Pavel Mateja
