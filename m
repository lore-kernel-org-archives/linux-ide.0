From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: always clear all bits in irq_stat
Date: Sat, 28 Jun 2008 01:49:02 +0900
Message-ID: <486519FE.4070106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41121 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017AbYF0QtW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jun 2008 12:49:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, pth@novell.com

Some AHCI controllers (ICH7 was reported) set pending bit in
HOST_IRQ_STAT for non-existent ports and when it's not cleared falls
into IRQ storm.  Always clear full irq_stat instead of only the bits
that are handled.  As nothing changes for recognized ports, the risk
of breaking things is pretty low.

Reported and verified by Philipp Thomas in the following suse
bugzilla.

https://bugzilla.novell.com/attachment.cgi?id=215692

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Philipp Thomas <pth@novell.com>
---
This should fix some of ahci IRQ storms we have.  I'm not sure it
fixes the JMB probing one tho.  I think this one is worth committing
to #upstream-fixes and should be safe.

Thanks.

 drivers/ata/ahci.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 966ab40..8378334 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1760,7 +1760,7 @@ static irqreturn_t ahci_interrupt(int irq, void *dev_instance)
 	struct ahci_host_priv *hpriv;
 	unsigned int i, handled = 0;
 	void __iomem *mmio;
-	u32 irq_stat, irq_ack = 0;
+	u32 irq_stat;
 
 	VPRINTK("ENTER\n");
 
@@ -1792,14 +1792,11 @@ static irqreturn_t ahci_interrupt(int irq, void *dev_instance)
 					"interrupt on disabled port %u\n", i);
 		}
 
-		irq_ack |= (1 << i);
-	}
-
-	if (irq_ack) {
-		writel(irq_ack, mmio + HOST_IRQ_STAT);
 		handled = 1;
 	}
 
+	writel(irq_stat, mmio + HOST_IRQ_STAT);
+
 	spin_unlock(&host->lock);
 
 	VPRINTK("EXIT\n");

-- 
tejun
