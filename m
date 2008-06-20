From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/18] ide: use ->tf_load in actual_try_to_identify()
Date: Fri, 20 Jun 2008 23:34:45 +0200
Message-ID: <20080620213445.13202.61145.sendpatchset@localhost.localdomain>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:6668 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761631AbYFTVct (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 17:32:49 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1410728fkq.5
        for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 14:32:48 -0700 (PDT)
In-Reply-To: <20080620213323.13202.71450.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Convert actual_try_to_identify() to use ->tf_load instead of ->OUTB.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -290,9 +290,15 @@ static int actual_try_to_identify (ide_d
 	/* set features register for atapi
 	 * identify command to be sure of reply
 	 */
-	if ((cmd == WIN_PIDENTIFY))
-		/* disable dma & overlap */
-		hwif->OUTB(0, io_ports->feature_addr);
+	if (cmd == WIN_PIDENTIFY) {
+		ide_task_t task;
+
+		memset(&task, 0, sizeof(task));
+		/* disable DMA & overlap */
+		task.tf_flags = IDE_TFLAG_OUT_FEATURE;
+
+		drive->hwif->tf_load(drive, &task);
+	}
 
 	/* ask drive for ID */
 	hwif->exec_command(hwif, cmd);
