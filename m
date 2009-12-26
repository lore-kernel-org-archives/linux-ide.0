From: Mikael Pettersson <mikpe@it.uu.se>
Subject: 2.6.33-rc2 pata_macio fails to detect PMac G3 CD-drive
Date: Sat, 26 Dec 2009 18:18:30 +0100
Message-ID: <19254.17766.674348.933702@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:56160 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbZLZRSk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Dec 2009 12:18:40 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: benh@kernel.crashing.org

I decided to give the new pata_macio a try on my old PMac G3 (Beige).
None of the disks are connected to the PMAC IDE controller, but the
CD-drive is.

2.6.32 with legacy IDE detects things nicely:

ide-pmac: Found Apple Heathrow ATA controller (macio), bus ID 0, irq 30
Probing IDE interface ide0...
hda: MATSHITA CR-585, ATAPI CD/DVD-ROM drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO3
hda: MWDMA1 mode selected
ide0 at 0xf1018000-0xf1018070,0xf1018160 on irq 30
ide-pmac: Found Apple Heathrow ATA controller (macio), bus ID 1, irq 34
Probing IDE interface ide1...
ide1 at 0xf1020000-0xf1020070,0xf1020160 on irq 34
ide-gd driver 1.18
...
ide-cd driver 5.00
ide-cd: hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20

but 2.6.33-rc2 with pata_macio does not:

pata-macio 0.00020000:ide: Activating pata-macio chipset Heathrow ATA, Apple bus ID 0
scsi1 : pata_macio
ata1: PATA max MWDMA2 irq 30
irq 30: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[ef87bc40] [c00094a0] show_stack+0x74/0x1a8 (unreliable)
[ef87bc70] [c006049c] __report_bad_irq+0x40/0xd4
[ef87bc90] [c0060728] note_interrupt+0x1f8/0x254
[ef87bcc0] [c0061144] handle_edge_irq+0xe4/0x1ac
[ef87bce0] [c0007004] do_IRQ+0xa8/0xcc
[ef87bd00] [c00142cc] ret_from_except+0x0/0x14
--- Exception: 501 at ata_eh_freeze_port+0x34/0x48
    LR = ata_eh_freeze_port+0x30/0x48
[ef87bdd0] [c01a8f34] ata_eh_reset+0x370/0xd90
[ef87be50] [c01aabfc] ata_eh_recover+0x300/0x115c
[ef87bee0] [c01abc60] ata_do_eh+0x54/0xc8
[ef87bf10] [c01adcb0] ata_sff_error_handler+0x144/0x228
[ef87bf30] [c01ac5ec] ata_scsi_error+0x320/0x548
[ef87bf60] [c017e4b4] scsi_error_handler+0x174/0x444
[ef87bfc0] [c0046b88] kthread+0x80/0x84
[ef87bff0] [c0013a44] kernel_thread+0x4c/0x68
handlers:
[<c01afc68>] (ata_sff_interrupt+0x0/0x12c)
Disabling IRQ #30
ata1.00: ATAPI: MATSHITA CR-585, ZS20, max MWDMA1
ata1.00: configured for MWDMA1
pata-macio 0.00021000:ide: Activating pata-macio chipset Heathrow ATA, Apple bus ID 1
scsi2 : pata_macio
ata2: PATA max MWDMA2 irq 34
...
ata1.00: qc timeout (cmd 0xa0)
ata1.00: TEST_UNIT_READY failed (err_mask=0x5)
ata1.00: configured for MWDMA1
ata1.00: qc timeout (cmd 0xa0)
ata1.00: TEST_UNIT_READY failed (err_mask=0x5)
ata1.00: limiting speed to MWDMA1:PIO2
ata1.00: configured for MWDMA1
ata1.00: qc timeout (cmd 0xa0)
ata1.00: TEST_UNIT_READY failed (err_mask=0x5)
ata1.00: disabled
ata1: soft resetting link
ata1: EH complete

/Mikael
