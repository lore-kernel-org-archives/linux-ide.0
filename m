From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/50] cmd64x: cleanup ->init_chipset method
Date: Sun, 06 Jul 2008 19:20:26 +0200
Message-ID: <48710240.1ade660a.3458.628d@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:6801 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758099AbYGFRe6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:34:58 -0400
Received: by mu-out-0910.google.com with SMTP id w8so554720mue.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:34:57 -0700 (PDT)
Content-Disposition: inline; filename=cmd64x-cleanup-init_chipset-method.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Remove verbose reporting for CMD646 (PCI device revision is always
logged by IDE PCI layer).

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cmd64x.c |   18 ------------------
 1 file changed, 18 deletions(-)

Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -334,24 +334,6 @@ static unsigned int __devinit init_chips
 {
 	u8 mrdmode = 0;
 
-	if (dev->device == PCI_DEVICE_ID_CMD_646) {
-
-		switch (dev->revision) {
-		case 0x07:
-		case 0x05:
-			printk("%s: UltraDMA capable\n", name);
-			break;
-		case 0x03:
-		default:
-			printk("%s: MultiWord DMA force limited\n", name);
-			break;
-		case 0x01:
-			printk("%s: MultiWord DMA limited, "
-			       "IRQ workaround enabled\n", name);
-			break;
-		}
-	}
-
 	/* Set a good latency timer and cache line size value. */
 	(void) pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
 	/* FIXME: pci_set_master() to ensure a good latency timer value */

-- 

