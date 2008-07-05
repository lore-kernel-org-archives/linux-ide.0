From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: give another shot at clearing all bits
 in irq_stat
Date: Sat, 05 Jul 2008 13:10:50 +0900
Message-ID: <486EF44A.20400@kernel.org>
References: <20080704131005.GA30768@havoc.gtf.org> <alpine.LFD.1.10.0807040955100.2815@woody.linux-foundation.org> <486EE6CA.2040908@kernel.org> <486EE804.6020202@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35089 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbYGEELU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Jul 2008 00:11:20 -0400
In-Reply-To: <486EE804.6020202@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Commit ea0c62f7cf70f13a67830471b613337bd0c9a62e tried to clear all
bits in irq_stat but it didn't actually achieve that as irq_stat was
anded with port_map right after read.  This patch makes ahci driver
always use the unmasked value to clear irq_status.

While at it, add explanation on the peculiarities of ahci IRQ
clearing.

This was spotted by Linus Torvalds.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
The original report requires further investigation regarding why the
bogus change fixed the problem but this change is the correct thing to
do regardless.

Thanks.

 drivers/ata/ahci.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 061817a..5e6468a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1777,7 +1777,7 @@ static irqreturn_t ahci_interrupt(int irq, void *dev_instance)
 	struct ahci_host_priv *hpriv;
 	unsigned int i, handled = 0;
 	void __iomem *mmio;
-	u32 irq_stat;
+	u32 irq_stat, irq_masked;
 
 	VPRINTK("ENTER\n");
 
@@ -1786,16 +1786,17 @@ static irqreturn_t ahci_interrupt(int irq, void *dev_instance)
 
 	/* sigh.  0xffffffff is a valid return from h/w */
 	irq_stat = readl(mmio + HOST_IRQ_STAT);
-	irq_stat &= hpriv->port_map;
 	if (!irq_stat)
 		return IRQ_NONE;
 
+	irq_masked = irq_stat & hpriv->port_map;
+
 	spin_lock(&host->lock);
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap;
 
-		if (!(irq_stat & (1 << i)))
+		if (!(irq_masked & (1 << i)))
 			continue;
 
 		ap = host->ports[i];
@@ -1812,6 +1813,15 @@ static irqreturn_t ahci_interrupt(int irq, void *dev_instance)
 		handled = 1;
 	}
 
+	/* HOST_IRQ_STAT behaves as level triggered latch meaning that
+	 * it should be cleared after all the port events are cleared;
+	 * otherwise, it will raise a spurious interrupt after each
+	 * valid one.  Please read section 10.6.2 of ahci 1.1 for more
+	 * information.
+	 *
+	 * Also, use the unmasked value to clear interrupt as spurious
+	 * pending event on a dummy port might cause screaming IRQ.
+	 */
 	writel(irq_stat, mmio + HOST_IRQ_STAT);
 
 	spin_unlock(&host->lock);
