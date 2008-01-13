From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: SATA timeouts on two disks
Date: Sun, 13 Jan 2008 13:07:35 +0100
Message-ID: <18313.65287.290482.369023@harpo.it.uu.se>
References: <3afbacad0801121656u7318de7l57ba5064da259f3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:61259 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbYAMMHl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Jan 2008 07:07:41 -0500
In-Reply-To: <3afbacad0801121656u7318de7l57ba5064da259f3f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim MacBaine <jmacbaine@gmail.com>
Cc: linux-ide@vger.kernel.org

Jim MacBaine writes:
 > Hi,
 > 
 > Recently I'm experiencing strange sata errors on my desktop system.
 > The system was recently equipped with three 250 GB SATA drives from

Clue #1: added drives

 > three different manufacturers and I'm having an identical problem on
 > two of them.  The drives are connected to two on-board controllers on
 > an Asus A8V board, which were both running with Linux for more than
 > two years with older SATA disks without problems. A hardware failure
 > seems unlikely to me as the same error occurrs on two brand new disks
 > from two different manufacturers.  I'm running a vanilla 2.6.23.12
 > kernel.
 > 
 > Errror on sdc happened about 10 times tonight, each time I could hear
 > the disk spin down and up again, while the system was frozen for
 > several seconds:
 > 
 > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x180000 action 0x2 frozen
 > ata2.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
 >          res 40/00:00:00:00:40/00:00:00:00:00/00 Emask 0x4 (timeout)
 > ata2: soft resetting port
 > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > ata2.00: configured for UDMA/133
 > ata2: EH complete
 > sd 1:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
 > sd 1:0:0:0: [sdb] Write Protect is off
 > sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
 > sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
 > support DPO or FUA
 > 
 > In the log I also found several identical errors on one other drive:
 > 
 > ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
 > ata5.00: cmd 25/00:08:b7:f2:11/00:00:13:00:00/e0 tag 0 cdb 0x0 data 4096 in
 >          res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
 > ata5: soft resetting port
 > ata5.00: configured for UDMA/33
 > ata5: EH complete
 > sd 4:0:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
 > sd 4:0:0:0: [sdc] Write Protect is off
 > sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
 > sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
 > support DPO or FUA

Clue #2: both ata2 and ata5 are having problems

 > 
 > Can this be the result of a hardware failure?  I've seen several
 > drives being added to an NCQ blacklist during the last weeks.  Is it
 > possible that my drives need to be added here, too?  Or have I just
 > two failing drives?
 > 
 > Thanks a lot for any clues,
 > Jim
 > 
 > 
 > System boot log extract:
 > 
 > sata_promise 0000:00:08.0: version 2.10
 > ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 18
 > scsi0 : sata_promise
 > scsi1 : sata_promise
 > scsi2 : sata_promise
 > ata1: SATA max UDMA/133 cmd 0xf882e200 ctl 0xf882e238 bmdma 0x00000000 irq 18
 > ata2: SATA max UDMA/133 cmd 0xf882e280 ctl 0xf882e2b8 bmdma 0x00000000 irq 18
 > ata3: PATA max UDMA/133 cmd 0xf882e300 ctl 0xf882e338 bmdma 0x00000000 irq 18
 > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > ata1.00: ATA-8: SAMSUNG HD252KJ, CM100-12, max UDMA7
 > ata1.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
 > ata1.00: configured for UDMA/133
 > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > ata2.00: ATA-7: WDC WD2500JS-55NCB1, 10.02E01, max UDMA/133
 > ata2.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
 > ata2.00: configured for UDMA/133

Clue #3: ata2 is driven by sata_promise (lspci says it's a 20378, they're good)

 > scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD252KJ  CM10 PQ: 0 ANSI: 5
 > sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
 > sd 0:0:0:0: [sda] Write Protect is off
 > sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
 > sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
 > support DPO or FUA
 > sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
 > sd 0:0:0:0: [sda] Write Protect is off
 > sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
 > sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
 > support DPO or FUA
 >  sda: sda2 sda3
 > sd 0:0:0:0: [sda] Attached SCSI disk
 > scsi 1:0:0:0: Direct-Access     ATA      WDC WD2500JS-55N 10.0 PQ: 0 ANSI: 5
 > sd 1:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
 > sd 1:0:0:0: [sdb] Write Protect is off
 > sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
 > sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
 > support DPO or FUA
 > sd 1:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
 > sd 1:0:0:0: [sdb] Write Protect is off
 > sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
 > sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
 > support DPO or FUA
 >  sdb: sdb2 sdb3
 > sd 1:0:0:0: [sdb] Attached SCSI disk
 > sata_via 0000:00:0f.0: version 2.3
 > ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
 > sata_via 0000:00:0f.0: routed to hard irq line 10
 > scsi3 : sata_via
 > scsi4 : sata_via
 > ata4: SATA max UDMA/133 cmd 0x0001d000 ctl 0x0001c802 bmdma 0x0001b800 irq 17
 > ata5: SATA max UDMA/133 cmd 0x0001c400 ctl 0x0001c002 bmdma 0x0001b808 irq 17
 > ata4: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
 > ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > ata5.00: ATA-7: MAXTOR STM3250820AS, 3.AAE, max UDMA/133
 > ata5.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 0/32)
 > ata5.00: configured for UDMA/133

Clue #4: ata5 is driven by sata_via

The fact that the problems occur on different disks on
different controllers driven by different drivers indicates
that it's not a disk, controller, or driver problem.

I strongly suspect an underdimensioned or failing PSU.
