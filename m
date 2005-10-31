From: Jeff Garzik <jgarzik@pobox.com>
Subject: sata_mv output
Date: Mon, 31 Oct 2005 09:49:02 -0500
Message-ID: <43662EDE.3020704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:27535 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750751AbVJaOtG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2005 09:49:06 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EWay8-0006Ct-SC
	for linux-ide@vger.kernel.org; Mon, 31 Oct 2005 14:49:06 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


Here's what the latest sata_mv does on my machine, with a 6041 chip on 
the motherboard and a single drive attached to the second port:

sata_mv 0000:02:0d.0: version 0.25
ACPI: PCI Interrupt 0000:02:0d.0[A] -> GSI 17 (level, low) -> IRQ 185
sata_mv 0000:02:0d.0: 32 slots 4 ports SCSI mode IRQ via MSI
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20010122120 bmdma 0x0 irq 185
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20010124120 bmdma 0x0 irq 185
ata5: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20010126120 bmdma 0x0 irq 185
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20010128120 bmdma 0x0 irq 185
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
ata4: PIO error
ata4: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0000
ata4: no dma
ata4: dev 0 not supported, ignoring
scsi3 : sata_mv
ata5: no device found (phy stat 00000000)
scsi4 : sata_mv
ata6: no device found (phy stat 00000000)
scsi5 : sata_mv
