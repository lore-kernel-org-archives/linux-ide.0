From: Ondrej Zary <linux@rainbow-software.org>
Subject: pata_it821x completely broken
Date: Fri, 4 Jul 2008 21:53:54 +0200
Message-ID: <200807042153.56644.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.atlantis.sk ([80.94.52.35]:59461 "EHLO mail.atlantis.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbYGDTyF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Jul 2008 15:54:05 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@redhat.com
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hello,
after a total hard disk failure, I decided to build RAID1 using a cheap card 
with it8212 chip and two Samsung HD400LD drives. I thought that the 
pata_it821x driver is mature and should work fine (it does not depend on 
EXPERIMENTAL). However, it seems to be broken in several ways (in 2.6.25.3).

When I don't have any RAID array created, both drives are detected but it 
appears to work only in MWDMA2 mode:

pata_it821x: controller in smart mode.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Setting latency timer of device 0000:00:12.0 to 64
scsi2 : pata_it821x
scsi3 : pata_it821x
ata3: PATA max MWDMA2 cmd 0x6800 ctl 0x6c00 bmdma 0x7800 irq 11
ata4: PATA max MWDMA2 cmd 0x7000 ctl 0x7400 bmdma 0x7808 irq 11
ata3.00: ATA-7: SAMSUNG HD400LD, WQ100-15, max UDMA/100
ata3.00: 781422768 sectors, multi 0: LBA48
ata3.00: configured for DMA
ata4.00: ATA-7: SAMSUNG HD400LD, WQ100-15, max UDMA/100
ata4.00: 781422768 sectors, multi 0: LBA48
ata4.00: configured for DMA

But in fact, it's running faster:
hdparm --direct -t /dev/sdc

/dev/sdc:
 Timing O_DIRECT disk reads:  188 MB in  3.01 seconds =  62.48 MB/sec


Also I get some errors about HPA when rebooting but haven't captured them yet. 


But the more interesting thing is that once I create a RAID1 array (and run 
background rebuild), the driver does not work anymore:

ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
scsi2 : pata_it821x
scsi3 : pata_it821x
ata3: PATA max MWDMA2 cmd 0x6800 ctl 0x6c00 bmdma 0x7800 irq 11
ata4: PATA max MWDMA2 cmd 0x7000 ctl 0x7400 bmdma 0x7808 irq 11
ata3.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_masl=0x80)
ata3: failed to recover some devices, retrying in 5 secs
ata3.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_masl=0x80)
ata3: failed to recover some devices, retrying in 5 secs
ata3.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_masl=0x80)
ata3: failed to recover some devices, retrying in 5 secs


I'm going to start debugging, suggestions are welcome.

-- 
Ondrej Zary
