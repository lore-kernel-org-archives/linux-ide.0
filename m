From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/40] ide-scsi: fix DRQ checking for DMA transfers in idescsi_pc_intr()
Date: Sun, 18 May 2008 20:54:45 +0200
Message-ID: <20080518185445.5636.51099.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:17236 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbYERShW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:37:22 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1473278fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:37:20 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

If DRQ bit of Status Register is not cleared it is an error condition
and should be handled accordingly (disable DMA + reset the device).

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/scsi/ide-scsi.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -388,7 +388,6 @@ static ide_startstop_t idescsi_pc_intr (
 		return ide_stopped;
 	}
 	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
-		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
 #if IDESCSI_DEBUG_LOG
 		printk ("ide-scsi: %s: DMA complete\n", drive->name);
 #endif /* IDESCSI_DEBUG_LOG */
@@ -404,12 +403,20 @@ static ide_startstop_t idescsi_pc_intr (
 		if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
 			printk(KERN_INFO "Packet command completed, %d bytes"
 					" transferred\n", pc->xferred);
+		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
 		local_irq_enable_in_hardirq();
 		if (stat & ERR_STAT)
 			rq->errors++;
 		idescsi_end_request (drive, 1, 0);
 		return ide_stopped;
 	}
+	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
+		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
+		printk(KERN_ERR "%s: The device wants to issue more interrupts "
+				"in DMA mode\n", drive->name);
+		ide_dma_off(drive);
+		return ide_do_reset(drive);
+	}
 	bcount = (hwif->INB(hwif->io_ports.lbah_addr) << 8) |
 		  hwif->INB(hwif->io_ports.lbam_addr);
 	ireason = hwif->INB(hwif->io_ports.nsect_addr);
