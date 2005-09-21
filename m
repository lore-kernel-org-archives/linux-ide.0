From: Reuben Farrelly <reuben-lkml@reub.net>
Subject: Problems with SATA/AHCI with 'nosmp'  boot option
Date: Wed, 21 Sep 2005 21:10:47 +1200
Message-ID: <43312397.9080501@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tornado.reub.net ([202.89.145.182]:45792 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750784AbVIUJKr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2005 05:10:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

Hi,

While trying to gather more info about a problem with the latest sky2.c Gig 
ethernet driver hanging, I thought I'd boot my SMP built kernel (on an SMP/HT 
machine) with the 'nosmp' boot option.

However when I did this, I could no longer boot the machine, because the ahci
driver reported timeouts when probing the drives attached to the SATA ports, 
like this:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 73
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 81
ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci(0000:00:1f.2) flags: 64bit ncq led slum part
ata1: SATA max UDMA/133 cmd 0xF8806D00 ctl 0x0 bmdma 0x0 irq 81
ata2: SATA max UDMA/133 cmd 0xF8806D80 ctl 0x0 bmdma 0x0 irq 81
ata3: SATA max UDMA/133 cmd 0xF8806E00 ctl 0x0 bmdma 0x0 irq 81
ata4: SATA max UDMA/133 cmd 0xF8806E80 ctl 0x0 bmdma 0x0 irq 81
ata1 is slow to respond, please be patient
ata1 failed to respond (30 secs)
scsi0 : ahci
ata2 is slow to respond, please be patient
ata2 failed to respond (30 secs)

etc, all ata ports fail to respond (at all).

Then of course the machine panics later on because it can't find a root to
mount other critical things like /dev on since the physically attached drives 
aren't seen.

The problem seemed was very reproduceable, I attempted this a couple of times
to make sure that it was consistent - and yes it was.  However, if I build a 
kernel without SMP, it runs fine, so it appears to be just a problem with the 
boot option rather than non-SMP as such.

Normally the boot would look like this:

ata1: SATA max UDMA/133 cmd 0xF8806D00 ctl 0x0 bmdma 0x0 irq 193
ata2: SATA max UDMA/133 cmd 0xF8806D80 ctl 0x0 bmdma 0x0 irq 193
ata3: SATA max UDMA/133 cmd 0xF8806E00 ctl 0x0 bmdma 0x0 irq 193
ata4: SATA max UDMA/133 cmd 0xF8806E80 ctl 0x0 bmdma 0x0 irq 193
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata1: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata2: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ahci
ata3: no device found (phy stat 00000000)
scsi2 : ahci
ata4: no device found (phy stat 00000000)
scsi3 : ahci
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0


Has anyone else seen this (probably somewhat obscure) problem?  It's hardly a 
showstopper but still, would have saved me a bunch of messing around 
rebuilding if it worked :)  Looking back in time looks like the 'nosmp' has 
caused problems before, so seems possible that this is not an IDE specific 
problem, although the rest of the boot up looked OK.

The machine has an Intel 925XCV board ( 
http://support.intel.com/support/motherboards/desktop/d925xcv/index.htm ), and 
this was with 2.6.14-rc1-mm1.

Kernel config is at http://www.reub.net/kernel/


reuben

