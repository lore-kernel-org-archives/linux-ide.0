From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/12] ns87415: use pci_get_legacy_ide_irq()
Date: Mon, 19 Jan 2009 15:13:43 +0100
Message-ID: <20090119141343.27613.99813.sendpatchset@localhost.localdomain>
References: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:36546 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbZASONU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:13:20 -0500
In-Reply-To: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ns87415: use pci_get_legacy_ide_irq()

Fix ->init_hwif to use pci_get_legacy_ide_irq() instead of
__ide_default_irq().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ns87415.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ns87415.c
===================================================================
--- a/drivers/ide/ns87415.c
+++ b/drivers/ide/ns87415.c
@@ -286,7 +286,7 @@ static void __devinit init_hwif_ns87415 
 	}
 
 	if (!using_inta)
-		hwif->irq = __ide_default_irq(hwif->io_ports.data_addr);
+		hwif->irq = pci_get_legacy_ide_irq(dev, hwif->channel);
 	else if (!hwif->irq && hwif->mate && hwif->mate->irq)
 		hwif->irq = hwif->mate->irq;	/* share IRQ with mate */
 
