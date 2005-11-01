From: Don Carroll <ibedonc@star-c.com>
Subject: Asus A8V , via vt8251 AHCI
Date: Tue, 1 Nov 2005 00:40:58 -0600
Message-ID: <20051101064058.GA4902@vcr.star-c.com>
Reply-To: ibedonc@star-c.com, ibedonc@star-c.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dpc6935171158.direcpc.com ([69.35.171.158]:50881 "EHLO
	vcr.star-c.com") by vger.kernel.org with ESMTP id S932400AbVKAGlu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Nov 2005 01:41:50 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: garzik@pobox.com, linux-ide@vger.kernel.org

Hi , I added pci id 3349 to achi.c and I get it to load now
ahci version 1.00
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 21 (level, low) -> IRQ 217
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 9
ahci(0000:00:0f.0) AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci(0000:00:0f.0) flags: 64bit ncq pm led clo pmp pio slum part
ata3: SATA max UDMA/133 cmd 0xFFFFC20000038900 ctl 0x0 bmdma 0x0 irq 217
ata4: SATA max UDMA/133 cmd 0xFFFFC20000038980 ctl 0x0 bmdma 0x0 irq 217
ata5: SATA max UDMA/133 cmd 0xFFFFC20000038A00 ctl 0x0 bmdma 0x0 irq 217
ata6: SATA max UDMA/133 cmd 0xFFFFC20000038A80 ctl 0x0 bmdma 0x0 irq 217
ata3: no device found (phy stat 00000000)
scsi2 : ahci
ata4: no device found (phy stat 00000000)
scsi3 : ahci
ata5: no device found (phy stat 00000000)
scsi4 : ahci
ata6 is slow to respond, please be patient
ata6 failed to respond (30 secs)
scsi5 : ahci

I have a drive on ata6 , but it does not respond , timesout

this is Mandriva 2006 x86_64 and it has 2.6.12 I have not been able to get .14
to compile yet , does this look like something that ahci 1.01 would help , any
ideas ?


