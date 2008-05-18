From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 09/40] ide-tape: remove superfluous error message from idetape_pc_intr()
Date: Sun, 18 May 2008 20:55:49 +0200
Message-ID: <20080518185549.5636.40698.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:24872 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974AbYERSiY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:38:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1425123fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:38:23 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

ide_dma_off() prints info about DMA being disabled.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |    1 -
 1 file changed, 1 deletion(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -842,7 +842,6 @@ static ide_startstop_t idetape_pc_intr(i
 		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
 		printk(KERN_ERR "ide-tape: The tape wants to issue more "
 				"interrupts in DMA mode\n");
-		printk(KERN_ERR "ide-tape: DMA disabled, reverting to PIO\n");
 		ide_dma_off(drive);
 		return ide_do_reset(drive);
 	}
