From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/19] hpt366: remove redundant check from init_dma_hpt366()
Date: Fri, 12 Jan 2007 05:27:29 +0100
Message-ID: <20070112042729.28794.88151.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:34121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030496AbXALEXx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 23:23:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so689929uga
        for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 20:23:52 -0800 (PST)
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

[PATCH] hpt366: remove redundant check from init_dma_hpt366()

->init_dma() cannot be called with dmabase == 0
(see drivers/ide/setup-pci.c)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/hpt366.c |    3 ---
 1 file changed, 3 deletions(-)

Index: a/drivers/ide/pci/hpt366.c
===================================================================
--- a.orig/drivers/ide/pci/hpt366.c
+++ a/drivers/ide/pci/hpt366.c
@@ -1391,9 +1391,6 @@ static void __devinit init_dma_hpt366(id
 	u8 dma_new	= 0, dma_old	= 0;
 	unsigned long flags;
 
-	if (!dmabase)
-		return;
-		
 	dma_old = hwif->INB(dmabase + 2);
 
 	local_irq_save(flags);
