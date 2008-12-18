From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 7/8] ide-atapi: put the rest of non-ide-cd code into the else-clause of ide_transfer_pc
Date: Thu, 18 Dec 2008 08:40:51 +0100
Message-ID: <1229586052-3542-8-git-send-email-petkovbb@gmail.com>
References: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:38264 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbYLRHlE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 02:41:04 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so1054023bwz.13
        for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 23:41:03 -0800 (PST)
In-Reply-To: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index dbed09c..f3dea66 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -534,17 +534,17 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 							       : WAIT_TAPE_CMD;
 			expiry = NULL;
 		}
-	}
 
-	ireason = ide_read_ireason(drive);
-	if (drive->media == ide_tape)
-		ireason = ide_wait_ireason(drive, ireason);
+		ireason = ide_read_ireason(drive);
+		if (drive->media == ide_tape)
+			ireason = ide_wait_ireason(drive, ireason);
 
-	if ((ireason & ATAPI_COD) == 0 || (ireason & ATAPI_IO)) {
-		printk(KERN_ERR "%s: (IO,CoD) != (0,1) while issuing "
-				"a packet command\n", drive->name);
+		if ((ireason & ATAPI_COD) == 0 || (ireason & ATAPI_IO)) {
+			printk(KERN_ERR "%s: (IO,CoD) != (0,1) while issuing "
+					"a packet command\n", drive->name);
 
-		return ide_do_reset(drive);
+			return ide_do_reset(drive);
+		}
 	}
 
 	/* Set the interrupt routine */
-- 
1.6.0.4

