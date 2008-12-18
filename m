From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/8] ide-atapi: compute cmd_len based on device type in ide_transfer_pc
Date: Thu, 18 Dec 2008 08:40:45 +0100
Message-ID: <1229586052-3542-2-git-send-email-petkovbb@gmail.com>
References: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:8062 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYLRHlB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 02:41:01 -0500
Received: by fk-out-0910.google.com with SMTP id 18so155335fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 23:40:59 -0800 (PST)
In-Reply-To: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index d412bd2..5c143b4 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -15,6 +15,8 @@
 #define debug_log(fmt, args...) do {} while (0)
 #endif
 
+#define ATAPI_MIN_CDB_BYTES	12
+
 static inline int dev_is_idecd(ide_drive_t *drive)
 {
 	return drive->media == ide_cdrom || drive->media == ide_optical;
@@ -492,6 +494,7 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 	struct request *rq = hwif->hwgroup->rq;
 	ide_expiry_t *expiry;
 	unsigned int timeout;
+	int cmd_len;
 	ide_startstop_t startstop;
 	u8 ireason;
 
@@ -506,6 +509,14 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 			drive->waiting_for_dma = 1;
 	}
 
+	if (dev_is_idecd(drive)) {
+		/* ATAPI commands get padded out to 12 bytes minimum */
+		cmd_len = COMMAND_SIZE(rq->cmd[0]);
+		if (cmd_len < ATAPI_MIN_CDB_BYTES)
+			cmd_len = ATAPI_MIN_CDB_BYTES;
+	} else
+		cmd_len = ATAPI_MIN_CDB_BYTES;
+
 	ireason = ide_read_ireason(drive);
 	if (drive->media == ide_tape)
 		ireason = ide_wait_ireason(drive, ireason);
@@ -513,6 +524,7 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 	if ((ireason & ATAPI_COD) == 0 || (ireason & ATAPI_IO)) {
 		printk(KERN_ERR "%s: (IO,CoD) != (0,1) while issuing "
 				"a packet command\n", drive->name);
+
 		return ide_do_reset(drive);
 	}
 
@@ -541,7 +553,7 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 
 	/* Send the actual packet */
 	if ((drive->atapi_flags & IDE_AFLAG_ZIP_DRIVE) == 0)
-		hwif->tp_ops->output_data(drive, NULL, rq->cmd, 12);
+		hwif->tp_ops->output_data(drive, NULL, rq->cmd, cmd_len);
 
 	return ide_started;
 }
-- 
1.6.0.4

