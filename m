From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: seagate disks on sil3114 - slow?
Date: Thu, 18 Oct 2007 08:52:26 +0000
Message-ID: <1192697546.5720.51.camel@localhost>
References: <1192683290.5720.38.camel@localhost>
	 <4716EA25.7060205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nn7.de ([85.214.94.156]:39201 "EHLO nn7.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932814AbXJRJB4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 05:01:56 -0400
In-Reply-To: <4716EA25.7060205@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Thu, 2007-10-18 at 01:07 -0400, Jeff Garzik wrote:
> Soeren Sonnenburg wrote:
> > Dear all,
> > 
> > I just now realize that all disk i.o. on my machine is quite slow
> > compared with the pata disks I had before. Furthermore I recognized that
> > I only have seagates (ST3400832AS,ST3400620AS,ST3750640AS,ST3750640AS)
> > connected to a sil3114 controller.
> > 
> > Being on kernel 2.6.23.1 and stumbling across
> > http://home-tj.org/wiki/index.php/Sil_m15w I am now wondering if this
> > patch made it already in kernel (or when it will make it if it is not
> > yet in/why never).
> 
> Are you sure you have a 3114?  the mod15write isn't applied to that chip.
> Does your dmesg say "applying Seagate errata fix (mod15write workaround)" ?

At least lspci / dmesg indicates I have a 3114 ... but maybe the problem
is something else. Is there a raw device speed, readonly benchmark to
check whether things are as expected?

Soeren

- lspci

00:0e.0 RAID bus controller: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller (rev 02)

00:0e.0 0104: 1095:3114 (rev 02)

- dmesg
sata_sil 0000:00:0e.0: version 2.3
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 17
sata_sil 0000:00:0e.0: Applying R_ERR on DMA activate FIS errata fix
scsi3 : sata_sil
scsi4 : sata_sil
scsi5 : sata_sil
scsi6 : sata_sil
ata4: SATA max UDMA/100 cmd 0xf882e080 ctl 0xf882e08a bmdma 0xf882e000 irq 17
ata5: SATA max UDMA/100 cmd 0xf882e0c0 ctl 0xf882e0ca bmdma 0xf882e008 irq 17
ata6: SATA max UDMA/100 cmd 0xf882e280 ctl 0xf882e28a bmdma 0xf882e200 irq 17
ata7: SATA max UDMA/100 cmd 0xf882e2c0 ctl 0xf882e2ca bmdma 0xf882e208 irq 17
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata4.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata4.00: 781422768 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/100
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata5.00: ATA-7: ST3400620AS, 3.AAE, max UDMA/133
ata5.00: 781422768 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata5.00: configured for UDMA/100
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
ata6.00: 1465149168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata6.00: configured for UDMA/100
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata7.00: ATA-7: ST3750640AS, 3.AAC, max UDMA/133
ata7.00: 1465149168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata7.00: configured for UDMA/100
scsi 3:0:0:0: Direct-Access     ATA      ST3400832AS      3.01 PQ: 0 ANSI: 5
sd 3:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
sd 3:0:0:0: [sda] Write Protect is off
sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
sd 3:0:0:0: [sda] Write Protect is off
sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: unknown partition table
sd 3:0:0:0: [sda] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg0 type 0
scsi 4:0:0:0: Direct-Access     ATA      ST3400620AS      3.AA PQ: 0 ANSI: 5
sd 4:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 4:0:0:0: [sdb] Write Protect is off
sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 4:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 4:0:0:0: [sdb] Write Protect is off
sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: unknown partition table
sd 4:0:0:0: [sdb] Attached SCSI disk
sd 4:0:0:0: Attached scsi generic sg1 type 0
scsi 5:0:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 5:0:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
sd 5:0:0:0: [sdc] Write Protect is off
sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:0:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
sd 5:0:0:0: [sdc] Write Protect is off
sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: unknown partition table
sd 5:0:0:0: [sdc] Attached SCSI disk
sd 5:0:0:0: Attached scsi generic sg2 type 0
scsi 6:0:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 6:0:0:0: [sdd] 1465149168 512-byte hardware sectors (750156 MB)
sd 6:0:0:0: [sdd] Write Protect is off
sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 6:0:0:0: [sdd] 1465149168 512-byte hardware sectors (750156 MB)
sd 6:0:0:0: [sdd] Write Protect is off
sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: unknown partition table
sd 6:0:0:0: [sdd] Attached SCSI disk
sd 6:0:0:0: Attached scsi generic sg3 type 0
