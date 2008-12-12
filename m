From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Help interpreting AHCI failure messages
Date: Fri, 12 Dec 2008 13:23:29 -0800
Message-ID: <4942D651.1050306@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:34266 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbYLLVXb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Dec 2008 16:23:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,

I'm trying to bring up the AHCI driver on a Xen dom0 kernel.  There's 
almost certainly some problem with my DMA handling somewhere - or 
perhaps interrupt routing - which is causing the AHCI driver to fail thus:

xen_set_ioapic_routing: irq 31 gsi 18 vector 184 ioapic 0 pin 18
triggering 0 polarity 1ahci 0000:00:1f.2: PCI INT C -> GSI 18 (level, low) -> IRQ 31
xen: PCI device 0000:00:1f.2 pin 3 -> irq 31
ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x27 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pmp pio slum part ems
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xff970000 port 0xff970100 irq 31
ata2: SATA max UDMA/133 abar m2048@0xff970000 port 0xff970180 irq 31
ata3: SATA max UDMA/133 abar m2048@0xff970000 port 0xff970200 irq 31
ata4: DUMMY
ata5: DUMMY
ata6: SATA max UDMA/133 abar m2048@0xff970000 port 0xff970380 irq 31
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI: HL-DT-ST DVD+/-RW GSA-H73N, B103, max UDMA/100
ata2.00: configured for UDMA/100
ata3: SATA link down (SStatus 4 SControl 300)
ata6: SATA link down (SStatus 4 SControl 300)
scsi 1:0:0:0: CD-ROM            HL-DT-ST DVD+-RW GSA-H73N B103 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi generic sg0 type 5


I'm wondering if you can give me a clue as to what might be failing on 
the AHCI side to give these symptoms, so I have some idea where I need 
to fix things in my code?

Thanks,
    J
