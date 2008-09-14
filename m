From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 10/10] ide-cd: use generic ide_issue_pc
Date: Sun, 14 Sep 2008 13:35:58 +0200
Message-ID: <1221392158-3848-11-git-send-email-petkovbb@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:4760 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbYINLgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Sep 2008 07:36:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1047388fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 14 Sep 2008 04:36:06 -0700 (PDT)
In-Reply-To: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

... and remove cdrom_start_packet_command.

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |   48 ++++--------------------------------------------
 1 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 29bd205..495e5bb 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -513,50 +513,9 @@ end_request:
 }
 
 /*
- * Set up the device registers for transferring a packet command on DEV,
- * expecting to later transfer XFERLEN bytes.  HANDLER is the routine
- * which actually transfers the command to the drive.  If this is a
- * drq_interrupt device, this routine will arrange for HANDLER to be
- * called when the interrupt from the drive arrives.  Otherwise, HANDLER
- * will be called immediately after the drive is prepared for the transfer.
- */
-static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive,
-						  int xferlen,
-						  ide_handler_t *handler)
-{
-	ide_hwif_t *hwif = drive->hwif;
-
-	ide_debug_log(IDE_DBG_PC, "Call %s, xferlen: %d\n", __func__, xferlen);
-
-	/* FIXME: for Virtual DMA we must check harder */
-	if (drive->dma)
-		drive->dma = !hwif->dma_ops->dma_setup(drive);
-
-	/* set up the controller registers */
-	ide_pktcmd_tf_load(drive, IDE_TFLAG_OUT_NSECT | IDE_TFLAG_OUT_LBAL,
-			   xferlen, drive->dma);
-
-	if (drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT) {
-		/* waiting for CDB interrupt, not DMA yet. */
-		if (drive->dma)
-			drive->waiting_for_dma = 0;
-
-		/* packet command */
-		ide_execute_command(drive, ATA_CMD_PACKET, handler,
-				    ATAPI_WAIT_PC, cdrom_timer_expiry);
-		return ide_started;
-	} else {
-		ide_execute_pkt_cmd(drive);
-
-		return (*handler) (drive);
-	}
-}
-
-/*
  * Send a packet command to DRIVE described by CMD_BUF and CMD_LEN. The device
- * registers must have already been prepared by cdrom_start_packet_command.
- * HANDLER is the interrupt handler to call when the command completes or
- * there's data ready.
+ * registers must have already been prepared by ide_issue_pc. HANDLER is the
+ * interrupt handler to call when the command completes or there's data ready.
  */
 #define ATAPI_MIN_CDB_BYTES 12
 static ide_startstop_t cdrom_transfer_packet_command(ide_drive_t *drive,
@@ -1290,7 +1249,8 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 		return ide_stopped;
 	}
 
-	return cdrom_start_packet_command(drive, xferlen, fn);
+	return ide_issue_pc(drive, ATAPI_WAIT_PC, cdrom_timer_expiry,
+			    xferlen, fn);
 }
 
 /*
-- 
1.5.5.1

