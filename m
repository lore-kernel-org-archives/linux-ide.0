From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/9] ide: call clear_irq() method in ide_timer_expiry()
Date: Wed, 10 Jun 2009 22:47:52 +0400
Message-ID: <200906102247.53077.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37387 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752451AbZFJSqT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jun 2009 14:46:19 -0400
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Now the clear_irq() method is called only from ide_intr() but ide_timer_expiry()
also should call this method in case when drive_is_ready() succeeds...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git 'for-next' branch.

 drivers/ide/ide-io.c |    3 +++
 1 files changed, 3 insertions(+)

Index: ide-2.6/drivers/ide/ide-io.c
===================================================================
--- ide-2.6.orig/drivers/ide/ide-io.c
+++ ide-2.6/drivers/ide/ide-io.c
@@ -669,6 +669,9 @@ void ide_timer_expiry (unsigned long dat
 				hwif->dma_ops->dma_lost_irq(drive);
 			if (hwif->ack_intr)
 				hwif->ack_intr(hwif);
+			if (hwif->port_ops && hwif->port_ops->clear_irq)
+				hwif->port_ops->clear_irq(drive);
+
 			printk(KERN_WARNING "%s: lost interrupt\n",
 				drive->name);
 			startstop = handler(drive);

