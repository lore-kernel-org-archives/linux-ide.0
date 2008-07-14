From: "Igor Podlesny" <for.poige+linux@gmail.com>
Subject: 2.6.26, sata_nv.c, NCQ's support disappeared (broken?)
Date: Tue, 15 Jul 2008 01:31:12 +0800
Message-ID: <43d009740807141031g612c56b7h52f6c3c6cbfab6b9@mail.gmail.com>
Reply-To: for.poige+linux@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:23516 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYGNRbO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jul 2008 13:31:14 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2402273wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 14 Jul 2008 10:31:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

	Hi! Here goes the dmesg output:

---X8------X8------X8------X8------X8------X8------X8------X8------X8------X8------X8------X8------X8---
[    0.658727] scsi0 : sata_nv
[    0.658727] scsi1 : sata_nv
[    0.658727] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd400 irq 23
[    0.658727] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd408 irq 23
[    0.973823] ata1: SATA link down (SStatus 0 SControl 300)
[    1.293342] ata2: SATA link down (SStatus 0 SControl 300)
[    1.294547] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
[    1.294547] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] ->
GSI 22 (level, low) -> IRQ 22
[    1.294547] PCI: Setting latency timer of device 0000:00:08.0 to 64
[    1.294547] scsi2 : sata_nv
[    1.294547] scsi3 : sata_nv
[    1.294547] ata3: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc000 irq 22
[    1.294547] ata4: SATA max UDMA/133 cmd 0x960 ctl 0xb60 bmdma 0xc008 irq 22
[    1.768314] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.816280] ata3.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
[    1.816280] ata3.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    1.882549] ata3.00: configured for UDMA/133
[    2.367912] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.374813] ata4.00: ATA-8: Hitachi HDP725050GLA360, GM4OA50E, max UDMA/133
[    2.374855] ata4.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    2.388144] ata4.00: configured for UDMA/133
---X8------X8------X8------X8------X8------X8------X8------X8------X8------X8------X8------X8------X8-----

-- 
End of message. Next message?
