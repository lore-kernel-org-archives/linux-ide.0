From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/16] trm290: use ide_execute_command()
Date: Tue, 22 Jan 2008 00:30:56 +0100
Message-ID: <20080121233056.30311.5861.sendpatchset@localhost.localdomain>
References: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:43432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759946AbYAUXRv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 18:17:51 -0500
Received: by ug-out-1314.google.com with SMTP id z38so975307ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 15:17:50 -0800 (PST)
In-Reply-To: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/trm290.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: b/drivers/ide/pci/trm290.c
===================================================================
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -177,10 +177,7 @@ static void trm290_selectproc (ide_drive
 
 static void trm290_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
-	BUG_ON(HWGROUP(drive)->handler != NULL);	/* paranoia check */
-	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
-	/* issue cmd to drive */
-	outb(command, IDE_COMMAND_REG);
+	ide_execute_command(drive, command, &ide_dma_intr, WAIT_CMD, NULL);
 }
 
 static int trm290_dma_setup(ide_drive_t *drive)
