From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 04/16] ide-cris: use ide_execute_command()
Date: Tue, 22 Jan 2008 00:31:03 +0100
Message-ID: <20080121233103.30311.22721.sendpatchset@localhost.localdomain>
References: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:43432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760408AbYAUXR6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 18:17:58 -0500
Received: by ug-out-1314.google.com with SMTP id z38so975307ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 15:17:57 -0800 (PST)
In-Reply-To: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cris/ide-cris.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -1034,11 +1034,7 @@ static int cris_dma_setup(ide_drive_t *d
 
 static void cris_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
-	/* set the irq handler which will finish the request when DMA is done */
-	ide_set_handler(drive, &cris_dma_intr, WAIT_CMD, NULL);
-
-	/* issue cmd to drive */
-	cris_ide_outb(command, IDE_COMMAND_REG);
+	ide_execute_command(drive, command, &cris_dma_intr, WAIT_CMD, NULL);
 }
 
 static void cris_dma_start(ide_drive_t *drive)
