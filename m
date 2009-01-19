From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/12] ns87415: small ->init_hwif cleanup
Date: Mon, 19 Jan 2009 15:13:50 +0100
Message-ID: <20090119141350.27613.31866.sendpatchset@localhost.localdomain>
References: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:36546 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbZASON0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:13:26 -0500
In-Reply-To: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ns87415: small ->init_hwif cleanup

Core IDE PCI code takes care of assigning hwif->irq for both ports.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ns87415.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ns87415.c
===================================================================
--- a/drivers/ide/ns87415.c
+++ b/drivers/ide/ns87415.c
@@ -287,8 +287,6 @@ static void __devinit init_hwif_ns87415 
 
 	if (!using_inta)
 		hwif->irq = pci_get_legacy_ide_irq(dev, hwif->channel);
-	else if (!hwif->irq && hwif->mate && hwif->mate->irq)
-		hwif->irq = hwif->mate->irq;	/* share IRQ with mate */
 
 	if (!hwif->dma_base)
 		return;
