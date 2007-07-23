From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [2.6.23-rc1] ata_piix: EH pending after completion, repeating EH (cnt=4)
Date: Mon, 23 Jul 2007 12:47:20 +0200 (MEST)
Message-ID: <200707231047.l6NAlKdt003284@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:35938 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724AbXGWKrY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jul 2007 06:47:24 -0400
Received: from harpo.it.uu.se (daemon@harpo.it.uu.se [130.238.12.34])
	by aun.it.uu.se (8.13.6/8.13.6) with ESMTP id l6NAlKmM003889
	for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 12:47:20 +0200 (MEST)
Received: (from mikpe@localhost)
	by harpo.it.uu.se (8.13.8+Sun/8.13.7) id l6NAlKdt003284
	for linux-ide@vger.kernel.org; Mon, 23 Jul 2007 12:47:20 +0200 (MEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This machine has a known good Samsung SATA DVD on ICH8 [8086:2820].
With kernel 2.6.23-rc1 I now get the following:

>ata_piix 0000:00:1f.2: version 2.11
>ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
>PCI: Setting latency timer of device 0000:00:1f.2 to 64
>scsi2 : ata_piix
>scsi3 : ata_piix
>ata3: SATA max UDMA/133 cmd 0x0001ec00 ctl 0x0001e882 bmdma 0x0001e400 irq 19
>ata4: SATA max UDMA/133 cmd 0x0001e800 ctl 0x0001e482 bmdma 0x0001e408 irq 19
>ata4.00: ATAPI: TSSTcorpCD/DVDW SH-S183A, SB00, max UDMA/33
>ata4.00: applying bridge limits
>ata4.00: configured for UDMA/33
>ata4: EH pending after completion, repeating EH (cnt=4)
>scsi 3:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183A SB00 PQ: 0 ANSI: 5

The "EH pending after completion" is new and did not occur with 2.6.22.
Apart from that message, things seem fine.

/Mikael
