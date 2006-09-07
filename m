From: Andres Salomon <dilinger@debian.org>
Subject: weird port status w/ sata_mv
Date: Thu, 07 Sep 2006 02:59:49 -0400
Message-ID: <1157612390.32204.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mouth.voxel.net ([69.9.180.118]:43990 "EHLO mail.squishy.cc")
	by vger.kernel.org with ESMTP id S1750896AbWIGG7q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Sep 2006 02:59:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org

Hi,

I have 4 separate machines that have the following card in each of them:
0000:03:03.0 0104: 11ab:6041 (rev 09)
(that is, "RAID bus controller: Marvell Technology Group Ltd. MV88SX6041
4-port SATA II PCI-X Controller")

Most of the time when I boot the machine using an sata drive plugged
into the controller (as JBOD), it boots just fine.  However, every once
in a while, the sata_mv driver will fail to detect the drive that's
plugged in.  When that happens, no matter how many times I reboot, I
cannot get it to find the drive.  If I leave the machine turned off for
a while, and then turn it back on, sata_mv will typically then find the
drive.

Using 2.6.18-rc5 (it happens w/ old kernels as well), a successful
bootup will typically show the following:



sata_mv 0000:03:03.0: version 0.7
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 42 (level, low) -> IRQ 169
sata_mv 0000:03:03.0: 32 slots 4 ports unknown mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF88A2120 bmdma 0x0 irq 169
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xF88A4120 bmdma 0x0 irq 169
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF88A6120 bmdma 0x0 irq 169
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF88A8120 bmdma 0x0 irq 169
scsi0 : sata_mv
ata1: no device found (phy stat 00000000)
scsi1 : sata_mv
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/133
scsi2 : sata_mv
ata3: no device found (phy stat 00000000)
scsi3 : sata_mv
ata4: no device found (phy stat 00000000)
  Vendor: ATA       Model: WDC WD2500JS-22M  Rev: 02.0
  Type:   Direct-Access                      ANSI SCSI revision: 05


As you can see, the drive is attached to ata2.  When the driver fails to
detect the drive, what happens is the driver spits out:

ata2: no device found (phy stat 00000224)

Looking through the driver, ata_port_online() is failing because it
expects the SCR_STATUS to be 0x3 instead of 0x4.  Unfortunately, I don't
see it documented anywhere what 0x3 actually means (nor what 0x4 means).
I've tried having the driver ignore 0x4, but it gets angry when
attempting to probe the drive.

What does 0x4 in the SCR_STATUS register actually mean?  Is there
something that can be initialized or reset to coax the port to a normal
status/state?



