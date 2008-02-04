From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 02/22] ide-tape: remove struct idetape_read_position_result_t
Date: Mon,  4 Feb 2008 14:40:20 +0100
Message-ID: <1202132440-26648-3-git-send-email-petkovbb@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:38290 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbYBDNmF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:42:05 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2554585wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:42:04 -0800 (PST)
In-Reply-To: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functional changes resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   49 +++++++++++++++++------------------------------
 1 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 442d71c..c8c57ab 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -571,24 +571,6 @@ struct idetape_id_gcw {
 	unsigned protocol		:2;	/* Protocol type */
 };
 
-/*
- *	READ POSITION packet command - Data Format (From Table 6-57)
- */
-typedef struct {
-	unsigned	reserved0_10	:2;	/* Reserved */
-	unsigned	bpu		:1;	/* Block Position Unknown */	
-	unsigned	reserved0_543	:3;	/* Reserved */
-	unsigned	eop		:1;	/* End Of Partition */
-	unsigned	bop		:1;	/* Beginning Of Partition */
-	u8		partition;		/* Partition Number */
-	u8		reserved2, reserved3;	/* Reserved */
-	u32		first_block;		/* First Block Location */
-	u32		last_block;		/* Last Block Location (Optional) */
-	u8		reserved12;		/* Reserved */
-	u8		blocks_in_buffer[3];	/* Blocks In Buffer - (Optional) */
-	u32		bytes_in_buffer;	/* Bytes In Buffer (Optional) */
-} idetape_read_position_result_t;
-
 /* Structures related to the SELECT SENSE / MODE SENSE packet commands. */
 #define IDETAPE_BLOCK_DESCRIPTOR	0
 #define	IDETAPE_CAPABILITIES_PAGE	0x2a
@@ -1999,30 +1981,35 @@ static void idetape_wait_for_request (ide_drive_t *drive, struct request *rq)
 	spin_lock_irq(&tape->spinlock);
 }
 
-static ide_startstop_t idetape_read_position_callback (ide_drive_t *drive)
+static ide_startstop_t idetape_read_position_callback(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	idetape_read_position_result_t *result;
+	u8 *readpos = tape->pc->buffer;
 
 	debug_log(DBG_PROCS, "Enter %s\n", __func__);
 
 	if (!tape->pc->error) {
-		result = (idetape_read_position_result_t *) tape->pc->buffer;
-		debug_log(DBG_SENSE, "BOP - %s\n", result->bop ? "Yes" : "No");
-		debug_log(DBG_SENSE, "EOP - %s\n", result->eop ? "Yes" : "No");
+		debug_log(DBG_SENSE, "BOP - %s\n",
+				!!(readpos[0] & 0x80) ? "Yes" : "No");
+		debug_log(DBG_SENSE, "EOP - %s\n",
+				!!(readpos[0] & 0x40) ? "Yes" : "No");
+
+		if (!!(readpos[0] & 0x4)) {
+			printk(KERN_INFO "ide-tape: Block location is unknown"
+					"to the tape\n");
 
-		if (result->bpu) {
-			printk(KERN_INFO "ide-tape: Block location is unknown to the tape\n");
 			clear_bit(IDETAPE_ADDRESS_VALID, &tape->flags);
 			idetape_end_request(drive, 0, 0);
 		} else {
 			debug_log(DBG_SENSE, "Block Location - %u\n",
-					ntohl(result->first_block));
-
-			tape->partition = result->partition;
-			tape->first_frame_position = ntohl(result->first_block);
-			tape->last_frame_position = ntohl(result->last_block);
-			tape->blocks_in_buffer = result->blocks_in_buffer[2];
+					be32_to_cpu(*(u32 *)&readpos[4]));
+
+			tape->partition = readpos[1];
+			tape->first_frame_position =
+				be32_to_cpu(*(u32 *)&readpos[4]);
+			tape->last_frame_position =
+				be32_to_cpu(*(u32 *)&readpos[8]);
+			tape->blocks_in_buffer = readpos[15];
 			set_bit(IDETAPE_ADDRESS_VALID, &tape->flags);
 			idetape_end_request(drive, 1, 0);
 		}
-- 
1.5.3.7

