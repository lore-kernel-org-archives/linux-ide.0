From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/15] ide: no need to read Status and Error registers for "empty" taskfile requests
Date: Sun, 01 Feb 2009 18:50:40 +0100
Message-ID: <20090201175040.19144.95929.sendpatchset@localhost.localdomain>
References: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:43113 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbZBARtr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 12:49:47 -0500
In-Reply-To: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: no need to read Status and Error registers for "empty" taskfile requests

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -333,9 +333,7 @@ static ide_startstop_t execute_drive_cmd
 #ifdef DEBUG
  	printk("%s: DRIVE_CMD (null)\n", drive->name);
 #endif
-	(void)hwif->tp_ops->read_status(hwif);
-
-	ide_complete_rq(drive, ide_read_error(drive));
+	ide_complete_rq(drive, 0);
 
  	return ide_stopped;
 }
