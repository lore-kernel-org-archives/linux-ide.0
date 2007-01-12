From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/19] pdc202xx_old: remove dead code
Date: Fri, 12 Jan 2007 05:26:46 +0100
Message-ID: <20070112042646.28794.7500.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:34121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbXALEXJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 23:23:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so689929uga
        for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 20:23:09 -0800 (PST)
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

[PATCH] pdc202xx_old: remove dead code

CONFIG_PDC202XX_MASTER config option doesn't exist

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/pdc202xx_old.c |   19 -------------------
 1 file changed, 19 deletions(-)

Index: a/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a.orig/drivers/ide/pci/pdc202xx_old.c
+++ a/drivers/ide/pci/pdc202xx_old.c
@@ -557,25 +557,6 @@ static void __devinit init_dma_pdc202xx(
 			(hwif->INB(dmabase|0x1f)&1) ? "":"IN");
 	}
 #endif /* CONFIG_PDC202XX_BURST */
-#ifdef CONFIG_PDC202XX_MASTER
-	if (!(primary_mode & 1)) {
-		printk(KERN_INFO "%s: FORCING PRIMARY MODE BIT "
-			"0x%02x -> 0x%02x ", hwif->cds->name,
-			primary_mode, (primary_mode|1));
-		hwif->OUTB(primary_mode|1, (dmabase|0x1a));
-		printk("%s\n",
-			(hwif->INB((dmabase|0x1a)) & 1) ? "MASTER" : "PCI");
-	}
-
-	if (!(secondary_mode & 1)) {
-		printk(KERN_INFO "%s: FORCING SECONDARY MODE BIT "
-			"0x%02x -> 0x%02x ", hwif->cds->name,
-			secondary_mode, (secondary_mode|1));
-		hwif->OUTB(secondary_mode|1, (dmabase|0x1b));
-		printk("%s\n",
-			(hwif->INB((dmabase|0x1b)) & 1) ? "MASTER" : "PCI");
-	}
-#endif /* CONFIG_PDC202XX_MASTER */
 
 	ide_setup_dma(hwif, dmabase, 8);
 }
