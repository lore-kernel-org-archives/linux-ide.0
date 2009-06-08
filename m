From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] sl82c105: add printk() logging facility
Date: Mon, 8 Jun 2009 21:46:19 +0400
Message-ID: <200906082146.19522.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:41691 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750853AbZFHRot (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Jun 2009 13:44:49 -0400
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Add missing printk() logging facility in sl82c105_dma_lost_irq().

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of the ide-2.6.git 'for-next' branch...

 drivers/ide/sl82c105.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

Index: ide-2.6/drivers/ide/sl82c105.c
===================================================================
--- ide-2.6.orig/drivers/ide/sl82c105.c
+++ ide-2.6/drivers/ide/sl82c105.c
@@ -10,7 +10,7 @@
  * with the timing registers setup.
  *  -- Benjamin Herrenschmidt (01/11/03) benh@kernel.crashing.org
  *
- * Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
+ * Copyright (C) 2006-2007,2009 MontaVista Software, Inc. <source@mvista.com>
  * Copyright (C)      2007 Bartlomiej Zolnierkiewicz
  */
 
@@ -146,14 +146,15 @@ static void sl82c105_dma_lost_irq(ide_dr
 	u32 val, mask		= hwif->channel ? CTRL_IDE_IRQB : CTRL_IDE_IRQA;
 	u8 dma_cmd;
 
-	printk("sl82c105: lost IRQ, resetting host\n");
+	printk(KERN_WARNING "sl82c105: lost IRQ, resetting host\n");
 
 	/*
 	 * Check the raw interrupt from the drive.
 	 */
 	pci_read_config_dword(dev, 0x40, &val);
 	if (val & mask)
-		printk("sl82c105: drive was requesting IRQ, but host lost it\n");
+		printk(KERN_INFO "sl82c105: drive was requesting IRQ, "
+		       "but host lost it\n");
 
 	/*
 	 * Was DMA enabled?  If so, disable it - we're resetting the
@@ -162,7 +163,7 @@ static void sl82c105_dma_lost_irq(ide_dr
 	dma_cmd = inb(hwif->dma_base + ATA_DMA_CMD);
 	if (dma_cmd & 1) {
 		outb(dma_cmd & ~1, hwif->dma_base + ATA_DMA_CMD);
-		printk("sl82c105: DMA was enabled\n");
+		printk(KERN_INFO "sl82c105: DMA was enabled\n");
 	}
 
 	sl82c105_reset_host(dev);

