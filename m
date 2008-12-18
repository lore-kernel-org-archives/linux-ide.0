From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 5/8] ide-cd: remove handler wrappers
Date: Thu, 18 Dec 2008 08:40:49 +0100
Message-ID: <1229586052-3542-6-git-send-email-petkovbb@gmail.com>
References: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:57692 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbYLRHlE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 02:41:04 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so1054029bwz.13
        for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 23:41:02 -0800 (PST)
In-Reply-To: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Remove cdrom_do_newpc_cont and cdrom_start_rw_cont wrappers and pass
cdrom_transfer_packet_command to ide_execute_command directly.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |  121 ++++++++++++++++++++------------------------------
 1 files changed, 48 insertions(+), 73 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 34981f5..f3c7cc3 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -511,48 +511,7 @@ end_request:
 	return 1;
 }
 
-/*
- * Set up the device registers for transferring a packet command on DEV,
- * expecting to later transfer XFERLEN bytes.  HANDLER is the routine
- * which actually transfers the command to the drive.  If this is a
- * drq_interrupt device, this routine will arrange for HANDLER to be
- * called when the interrupt from the drive arrives.  Otherwise, HANDLER
- * will be called immediately after the drive is prepared for the transfer.
- */
-static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive,
-						  ide_handler_t *handler)
-{
-	ide_hwif_t *hwif = drive->hwif;
-	struct request *rq = hwif->hwgroup->rq;
-	int xferlen;
-
-	xferlen = ide_cd_get_xferlen(rq);
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
-				    ATAPI_WAIT_PC, ide_cd_expiry);
-		return ide_started;
-	} else {
-		ide_execute_pkt_cmd(drive);
-
-		return (*handler) (drive);
-	}
-}
+static ide_startstop_t cdrom_newpc_intr(ide_drive_t *);
 
 /*
  * Send a packet command to DRIVE described by CMD_BUF and CMD_LEN. The device
@@ -561,11 +520,10 @@ static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive,
  * there's data ready.
  */
 #define ATAPI_MIN_CDB_BYTES 12
-static ide_startstop_t cdrom_transfer_packet_command(ide_drive_t *drive,
-					  struct request *rq,
-					  ide_handler_t *handler)
+static ide_startstop_t cdrom_transfer_packet_command(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
+	struct request *rq = hwif->hwgroup->rq;
 	int cmd_len;
 	ide_startstop_t startstop;
 
@@ -592,7 +550,7 @@ static ide_startstop_t cdrom_transfer_packet_command(ide_drive_t *drive,
 	}
 
 	/* arm the interrupt handler */
-	ide_set_handler(drive, handler, rq->timeout, ide_cd_expiry);
+	ide_set_handler(drive, cdrom_newpc_intr, rq->timeout, ide_cd_expiry);
 
 	/* ATAPI commands get padded out to 12 bytes minimum */
 	cmd_len = COMMAND_SIZE(rq->cmd[0]);
@@ -610,6 +568,49 @@ static ide_startstop_t cdrom_transfer_packet_command(ide_drive_t *drive,
 }
 
 /*
+ * Set up the device registers for transferring a packet command on DEV,
+ * expecting to later transfer XFERLEN bytes.  HANDLER is the routine
+ * which actually transfers the command to the drive.  If this is a
+ * drq_interrupt device, this routine will arrange for HANDLER to be
+ * called when the interrupt from the drive arrives.  Otherwise, HANDLER
+ * will be called immediately after the drive is prepared for the transfer.
+ */
+static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct request *rq = hwif->hwgroup->rq;
+	int xferlen;
+
+	xferlen = ide_cd_get_xferlen(rq);
+
+	ide_debug_log(IDE_DBG_PC, "Call %s, xferlen: %d\n", __func__, xferlen);
+
+	/* FIXME: for Virtual DMA we must check harder */
+	if (drive->dma)
+		drive->dma = !hwif->dma_ops->dma_setup(drive);
+
+	/* set up the controller registers */
+	ide_pktcmd_tf_load(drive, IDE_TFLAG_OUT_NSECT | IDE_TFLAG_OUT_LBAL,
+			   xferlen, drive->dma);
+
+	if (drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT) {
+		/* waiting for CDB interrupt, not DMA yet. */
+		if (drive->dma)
+			drive->waiting_for_dma = 0;
+
+		/* packet command */
+		ide_execute_command(drive, ATA_CMD_PACKET,
+				    cdrom_transfer_packet_command,
+				    ATAPI_WAIT_PC, ide_cd_expiry);
+		return ide_started;
+	} else {
+		ide_execute_pkt_cmd(drive);
+
+		return cdrom_transfer_packet_command(drive);
+	}
+}
+
+/*
  * Check the contents of the interrupt reason register from the cdrom
  * and attempt to recover if there are problems.  Returns  0 if everything's
  * ok; nonzero if the request has been terminated.
@@ -680,8 +681,6 @@ static int ide_cd_check_transfer_size(ide_drive_t *drive, int len)
 	return 1;
 }
 
-static ide_startstop_t cdrom_newpc_intr(ide_drive_t *);
-
 static ide_startstop_t ide_cd_prepare_rw_request(ide_drive_t *drive,
 						 struct request *rq)
 {
@@ -724,20 +723,6 @@ static ide_startstop_t ide_cd_prepare_rw_request(ide_drive_t *drive,
 }
 
 /*
- * Routine to send a read/write packet command to the drive. This is usually
- * called directly from cdrom_start_{read,write}(). However, for drq_interrupt
- * devices, it is called from an interrupt when the drive is ready to accept
- * the command.
- */
-static ide_startstop_t cdrom_start_rw_cont(ide_drive_t *drive)
-{
-	struct request *rq = drive->hwif->hwgroup->rq;
-
-	/* send the command to the drive and return */
-	return cdrom_transfer_packet_command(drive, rq, cdrom_newpc_intr);
-}
-
-/*
  * Fix up a possibly partially-processed request so that we can start it over
  * entirely, or even put it back on the request queue.
  */
@@ -1126,13 +1111,6 @@ static ide_startstop_t cdrom_start_rw(ide_drive_t *drive, struct request *rq)
 	return ide_started;
 }
 
-static ide_startstop_t cdrom_do_newpc_cont(ide_drive_t *drive)
-{
-	struct request *rq = HWGROUP(drive)->rq;
-
-	return cdrom_transfer_packet_command(drive, rq, cdrom_newpc_intr);
-}
-
 static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 {
 
@@ -1177,7 +1155,6 @@ static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 					sector_t block)
 {
-	ide_handler_t *fn;
 
 	ide_debug_log(IDE_DBG_RQ, "Call %s, rq->cmd[0]: 0x%x, "
 		      "rq->cmd_type: 0x%x, block: %llu\n",
@@ -1185,7 +1162,6 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 		      (unsigned long long)block);
 
 	if (blk_fs_request(rq)) {
-		fn = cdrom_start_rw_cont;
 
 		if (cdrom_start_rw(drive, rq) == ide_stopped)
 			return ide_stopped;
@@ -1194,7 +1170,6 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 			return ide_stopped;
 	} else if (blk_sense_request(rq) || blk_pc_request(rq) ||
 		   rq->cmd_type == REQ_TYPE_ATA_PC) {
-		fn = cdrom_do_newpc_cont;
 
 		if (!rq->timeout)
 			rq->timeout = ATAPI_WAIT_PC;
@@ -1210,7 +1185,7 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 		return ide_stopped;
 	}
 
-	return cdrom_start_packet_command(drive, fn);
+	return cdrom_start_packet_command(drive);
 }
 
 /*
-- 
1.6.0.4

