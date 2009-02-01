From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/8] ide: remove no longer needed PC_FLAG_TIMEDOUT packet command flag
Date: Sun, 01 Feb 2009 20:27:38 +0100
Message-ID: <20090201192738.1592.37936.sendpatchset@localhost.localdomain>
References: <20090201192732.1592.76435.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:64635 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbZBAT0r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 14:26:47 -0500
In-Reply-To: <20090201192732.1592.76435.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove no longer needed PC_FLAG_TIMEDOUT packet command flag

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-atapi.c |    5 -----
 include/linux/ide.h     |    2 --
 2 files changed, 7 deletions(-)

Index: b/drivers/ide/ide-atapi.c
===================================================================
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -324,11 +324,6 @@ static ide_startstop_t ide_pc_intr(ide_d
 	timeout = (drive->media == ide_floppy) ? WAIT_FLOPPY_CMD
 					       : WAIT_TAPE_CMD;
 
-	if (pc->flags & PC_FLAG_TIMEDOUT) {
-		drive->pc_callback(drive, 0);
-		return ide_stopped;
-	}
-
 	/* Clear the interrupt */
 	stat = tp_ops->read_status(hwif);
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -350,8 +350,6 @@ enum {
 	PC_FLAG_DMA_IN_PROGRESS		= (1 << 4),
 	PC_FLAG_DMA_ERROR		= (1 << 5),
 	PC_FLAG_WRITING			= (1 << 6),
-	/* command timed out */
-	PC_FLAG_TIMEDOUT		= (1 << 7),
 };
 
 /*
