From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/40] ide-tape: idetape_pc_intr() should use local_irq_enable_in_hardirq()
Date: Sun, 18 May 2008 20:55:40 +0200
Message-ID: <20080518185540.5636.32322.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:25716 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbYERSiP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:38:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1425260fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:38:14 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -794,7 +794,7 @@ static ide_startstop_t idetape_pc_intr(i
 				" transferred\n", pc->xferred);
 
 		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
-		local_irq_enable();
+		local_irq_enable_in_hardirq();
 
 #if SIMULATE_ERRORS
 		if ((pc->c[0] == WRITE_6 || pc->c[0] == READ_6) &&
