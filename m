From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/9] ide: fix ide_intr() for non-PCI devices and CONFIG_BLK_DEV_IDEPCI=y
Date: Thu, 27 Dec 2007 20:12:07 +0100
Message-ID: <20071227191207.1357.24118.sendpatchset@localhost.localdomain>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:6105 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbXL0TBP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Dec 2007 14:01:15 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1692943ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 27 Dec 2007 11:01:14 -0800 (PST)
In-Reply-To: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

'hwif->pci_dev && !hwif->pci_dev->vendor' condition is never true,
check for 'hwif->chipset != ide_pci' instead.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1487,7 +1487,7 @@ irqreturn_t ide_intr (int irq, void *dev
 		 * remove all the ifdef PCI crap
 		 */
 #ifdef CONFIG_BLK_DEV_IDEPCI
-		if (hwif->pci_dev && !hwif->pci_dev->vendor)
+		if (hwif->chipset != ide_pci)
 #endif	/* CONFIG_BLK_DEV_IDEPCI */
 		{
 			/*
