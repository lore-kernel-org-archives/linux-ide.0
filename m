From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 2/8] ide-atapi: assign expiry and timeout based on device type
Date: Thu, 18 Dec 2008 08:40:46 +0100
Message-ID: <1229586052-3542-3-git-send-email-petkovbb@gmail.com>
References: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:59794 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbYLRHlC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 02:41:02 -0500
Received: by bwz14 with SMTP id 14so1054040bwz.13
        for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 23:41:00 -0800 (PST)
In-Reply-To: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 5c143b4..5295b26 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -514,9 +514,28 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 		cmd_len = COMMAND_SIZE(rq->cmd[0]);
 		if (cmd_len < ATAPI_MIN_CDB_BYTES)
 			cmd_len = ATAPI_MIN_CDB_BYTES;
-	} else
+
+		timeout = rq->timeout;
+		expiry  = ide_cd_expiry;
+
+	} else {
 		cmd_len = ATAPI_MIN_CDB_BYTES;
 
+		/*
+		 * If necessary schedule the packet transfer to occur 'timeout'
+		 * miliseconds later in ide_delayed_transfer_pc() after the
+		 * device says it's ready for a packet.
+		 */
+		if (drive->atapi_flags & IDE_AFLAG_ZIP_DRIVE) {
+			timeout = drive->pc_delay;
+			expiry = &ide_delayed_transfer_pc;
+		} else {
+			timeout = (drive->media == ide_floppy) ? WAIT_FLOPPY_CMD
+							       : WAIT_TAPE_CMD;
+			expiry = NULL;
+		}
+	}
+
 	ireason = ide_read_ireason(drive);
 	if (drive->media == ide_tape)
 		ireason = ide_wait_ireason(drive, ireason);
@@ -528,20 +547,6 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 		return ide_do_reset(drive);
 	}
 
-	/*
-	 * If necessary schedule the packet transfer to occur 'timeout'
-	 * miliseconds later in ide_delayed_transfer_pc() after the device
-	 * says it's ready for a packet.
-	 */
-	if (drive->atapi_flags & IDE_AFLAG_ZIP_DRIVE) {
-		timeout = drive->pc_delay;
-		expiry = &ide_delayed_transfer_pc;
-	} else {
-		timeout = (drive->media == ide_floppy) ? WAIT_FLOPPY_CMD
-						       : WAIT_TAPE_CMD;
-		expiry = NULL;
-	}
-
 	/* Set the interrupt routine */
 	ide_set_handler(drive, ide_pc_intr, timeout, expiry);
 
-- 
1.6.0.4

