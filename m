From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 2/4] ide-atapi: remove ide-scsi remnants from ide_transfer_pc()
Date: Sun,  7 Dec 2008 18:21:09 +0100
Message-ID: <1228670471-3435-3-git-send-email-petkovbb@gmail.com>
References: <1228670471-3435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:23401 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbYLGRVS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2008 12:21:18 -0500
Received: by fk-out-0910.google.com with SMTP id 18so868085fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 07 Dec 2008 09:21:16 -0800 (PST)
In-Reply-To: <1228670471-3435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index ff6b567..f5bf405 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -550,8 +550,7 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 	}
 
 	ireason = ide_read_ireason(drive);
-	if (drive->media == ide_tape &&
-	    (drive->dev_flags & IDE_DFLAG_SCSI) == 0)
+	if (drive->media == ide_tape)
 		ireason = ide_wait_ireason(drive, ireason);
 
 	if ((ireason & ATAPI_COD) == 0 || (ireason & ATAPI_IO)) {
@@ -569,14 +568,9 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 		timeout = drive->pc_delay;
 		expiry = &ide_delayed_transfer_pc;
 	} else {
-		if (drive->dev_flags & IDE_DFLAG_SCSI) {
-			timeout = ide_scsi_get_timeout(pc);
-			expiry = ide_scsi_expiry;
-		} else {
-			timeout = (drive->media == ide_floppy) ? WAIT_FLOPPY_CMD
-							       : WAIT_TAPE_CMD;
-			expiry = NULL;
-		}
+		timeout = (drive->media == ide_floppy) ? WAIT_FLOPPY_CMD
+						       : WAIT_TAPE_CMD;
+		expiry = NULL;
 	}
 
 	/* Set the interrupt routine */
-- 
1.6.0.4

