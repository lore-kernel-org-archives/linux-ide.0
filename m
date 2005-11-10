From: Andrew Joyce <joyce@webcreations.ca>
Subject: AHCI and VT8251
Date: Wed, 09 Nov 2005 22:14:18 -0500
Message-ID: <1131592459.30236.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from physics.QueensU.CA ([130.15.24.20]:62617 "EHLO
	physics.queensu.ca") by vger.kernel.org with ESMTP id S1751726AbVKJDPI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Nov 2005 22:15:08 -0500
Received: from joyce.webcreations.ca (dhcp_24_145 [130.15.24.145])
	by physics.queensu.ca (8.12.8/8.12.8) with ESMTP id jAA325qv007597
	for <linux-ide@vger.kernel.org>; Wed, 9 Nov 2005 22:02:05 -0500
Received: from d226-53-149.home.cgocable.net ([24.226.53.149] helo=[192.168.1.90])
	(user=joycea) by joyce.webcreations.ca with esmtpsa (Exim 4.54 #1 (Debian))
	id 1Ea2tn-000463-1S
	for <linux-ide@vger.kernel.org>; Wed, 09 Nov 2005 22:14:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am trying to get a system using a VIA VT8251 chipset up and running.
The chip claims to comply to the AHCI standard so, much like a previous
poster, I added the PCI ID of the controller into the AHCI driver,
compiled the 2.6.14 kernel and crossed my fingers.  I met with the same
problems as were found earlier.  I am fairly certain this is an issue
with the kernel driver and the new VT8251 chipset.  As far as I can tell
this is the first board the chip is shipping in and the board has only
been on the market for about a month at this stage.

I am presently unsure how to proceed in order to diagnose or address
this problem.  My experience with kernel hacking is pretty limited but I
would be willing to help out by testing whatever I can and I am happy to
do some legwork and research to get this going.  Would anyone be
interested in helping me address this problem?

I have attached the relevant portions of kernel messages below.

Thanks,
Andrew

=========================================================================
SCSI subsystem initialized
libata version 1.12 loaded.
ahci version 1.01
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 3
ahci(0000:00:0f.0) AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA
mode
ahci(0000:00:0f.0) flags: 64bit ncq pm led clo pmp pio slum part
ata1: SATA max UDMA/133 cmd 0xFFFFC20000006D00 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xFFFFC20000006D80 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xFFFFC20000006E00 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xFFFFC20000006E80 ctl 0x0 bmdma 0x0 irq 19
ata1 is slow to respond, please be patient
ata1 failed to respond (30 secs)
scsi0 : ahci
ata2: no device found (phy stat 00000000)
scsi1 : ahci
ata3: no device found (phy stat 00000000)
scsi2 : ahci
ata4: no device found (phy stat 00000000)
scsi3 : ahci


