From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/40] ide-tape: remove superfluous warning message from idetape_issue_pc()
Date: Sun, 18 May 2008 20:55:58 +0200
Message-ID: <20080518185558.5636.56122.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:17236 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbYERSid (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:38:33 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1473278fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:38:32 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

ide_dma_off() prints info about DMA being disabled.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1038,8 +1038,6 @@ static ide_startstop_t idetape_issue_pc(
 
 	if (pc->flags & PC_FLAG_DMA_ERROR) {
 		pc->flags &= ~PC_FLAG_DMA_ERROR;
-		printk(KERN_WARNING "ide-tape: DMA disabled, "
-				"reverting to PIO\n");
 		ide_dma_off(drive);
 	}
 	if ((pc->flags & PC_FLAG_DMA_RECOMMENDED) && drive->using_dma)
