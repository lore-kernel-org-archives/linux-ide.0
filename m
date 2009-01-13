From: Jean Delvare <khali@linux-fr.org>
Subject: ata_sff_hsm_move warning
Date: Tue, 13 Jan 2009 14:27:07 +0100
Message-ID: <20090113142707.70c311ec@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:37915 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759733AbZAMN1T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jan 2009 08:27:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi Jeff, all,

FYI, I'm seeing this warning at boot time with kernel 2.6.29-rc1-git1
on x86_64:

libata version 3.00 loaded.
ata_piix 0000:00:1f.1: version 2.12
ata_piix 0000:00:1f.1: enabling device (0005 -> 0007)
ata_piix 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ata_piix 0000:00:1f.1: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
Switched to high resolution mode on CPU 0
ata1.00: ATA-6: Maxtor 5T030H3, TAH71DP0, max UDMA/100
ata1.00: 60030432 sectors, multi 16: LBA 
ata1.00: configured for UDMA/100
isa bounce pool size: 16 pages
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 5T030H3   TAH7 PQ: 0 ANSI: 5
ata2.01: ATAPI: Pioneer DVD-ROM ATAPIModel DVD-106S 0122, E1.22, max UDMA/66
ata2.01: configured for UDMA/66
------------[ cut here ]------------
WARNING: at drivers/ata/libata-sff.c:1017 ata_sff_hsm_move+0x550/0x76d [libata]()
Hardware name:         
Modules linked in: ata_piix(+) libata
Pid: 0, comm: swapper Not tainted 2.6.29-rc1-git1 #23
Call Trace:
 <IRQ>  [<ffffffff80232a02>] warn_slowpath+0xd0/0x125
 [<ffffffff8022a913>] place_entity+0x6e/0xa4
 [<ffffffff8022c58c>] try_to_wake_up+0x93/0xbb
 [<ffffffffa0011d6b>] ata_sff_interrupt+0x19/0x293 [libata]
 [<ffffffffa0012167>] ata_sff_data_xfer32+0x8f/0xbb [libata]
 [<ffffffffa00119c2>] ata_sff_hsm_move+0x550/0x76d [libata]
 [<ffffffffa0011f61>] ata_sff_interrupt+0x20f/0x293 [libata]
 [<ffffffff8026807e>] handle_IRQ_event+0x2b/0x60
 [<ffffffff802691d4>] handle_edge_irq+0xa5/0x133
 [<ffffffff8020dba6>] do_IRQ+0x49/0xb3
 [<ffffffff8020c013>] ret_from_intr+0x0/0xf
 <EOI> <4>---[ end trace ac822405c308c031 ]---
scsi 1:0:1:0: CD-ROM            PIONEER  DVD-ROM DVD-106  1.22 PQ: 0 ANSI: 5
ata_piix 0000:00:1f.2: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ata_piix 0000:00:1f.2: setting latency timer to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0xec00 ctl 0xe800 bmdma 0xdc00 irq 18
ata4: SATA max UDMA/133 cmd 0xe400 ctl 0xe000 bmdma 0xdc08 irq 18

Mainboard is an Intel D865GSA (ICH5). If you need more information,
just ask.

-- 
Jean Delvare
