From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] cmd64x: don't clear the other channels interrupt
Date: Fri, 9 Nov 2007 15:07:01 +0400
Message-ID: <200711091407.01369.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:55736 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752291AbXKILGt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 06:06:49 -0500
In-Reply-To: <200702162321.40813.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, marogge@onlinehome.de, milon@wq.cz

Make sure to not clear the other IDE channel's interrupt when clearing an IDE
interrupt via the MRDMODE register.

Thanks to Bart for finding a coding mistake.

---
The patch is against the Linus tree.

 drivers/ide/pci/cmd64x.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cmd64x.c		Version 1.50	May 10, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.51	Nov 8, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Due to massive hardware bugs, UltraDMA is only supported
@@ -339,7 +339,8 @@ static int cmd648_ide_dma_end (ide_drive
 	u8  mrdmode		= inb(hwif->dma_master + 0x01);
 
 	/* clear the interrupt bit */
-	outb(mrdmode | irq_mask, hwif->dma_master + 0x01);
+	outb((mrdmode & ~(MRDMODE_INTR_CH0 | MRDMODE_INTR_CH1)) | irq_mask,
+	     hwif->dma_master + 0x01);
 
 	return err;
 }

